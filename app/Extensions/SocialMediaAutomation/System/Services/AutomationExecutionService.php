<?php

declare(strict_types=1);

namespace App\Extensions\SocialMediaAutomation\System\Services;

use App\Extensions\SocialMedia\System\Models\SocialMediaPlatform;
use App\Extensions\SocialMediaAutomation\System\Models\Automation;
use App\Extensions\SocialMediaAutomation\System\Models\AutomationLog;
use App\Extensions\SocialMediaAutomation\System\Models\PendingAutomation;
use App\Models\ConnectedAccount;
use Illuminate\Http\Client\Response;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use RuntimeException;
use Throwable;

class AutomationExecutionService
{
    /**
     * Process an incoming comment event from a platform webhook.
     *
     * Checks BOTH legacy (SocialMediaPlatform) and new (ConnectedAccount) automations.
     *
     * @param  array<string, mixed>  $payload
     */
    public function processCommentEvent(string $platform, array $payload): void
    {
        $accountId = $payload['account_id'] ?? null;

        Log::info('[FB AUTOMATION] processCommentEvent', [
            'platform'   => $platform,
            'account_id' => $accountId,
            'post_id'    => $payload['post_id'] ?? null,
            'comment_id' => $payload['comment_id'] ?? null,
            'text'       => $payload['text'] ?? '',
        ]);

        $automations = $this->resolveAutomations($platform, $accountId);

        Log::info('[FB AUTOMATION] Automations resolved', [
            'platform'   => $platform,
            'account_id' => $accountId,
            'count'      => $automations->count(),
            'ids'        => $automations->pluck('id')->toArray(),
        ]);

        if ($automations->isEmpty()) {
            Log::warning('[FB AUTOMATION] No live automations found for account', [
                'platform'   => $platform,
                'account_id' => $accountId,
            ]);
        }

        foreach ($automations as $automation) {
            Log::info('[FB AUTOMATION] Evaluating automation', [
                'automation_id'            => $automation->id,
                'name'                     => $automation->name,
                'uses_connected_account'   => !is_null($automation->connected_account_id),
                'social_media_platform_id' => $automation->social_media_platform_id,
                'connected_account_id'     => $automation->connected_account_id,
                'trigger_target'           => $automation->trigger_target,
                'keyword_mode'             => $automation->keyword_mode,
                'include_keywords'         => $automation->include_keywords ?? [],
            ]);

            $matched = $this->matchesTrigger($automation, $payload);

            Log::info('[FB AUTOMATION] Trigger result', [
                'automation_id' => $automation->id,
                'comment_text'  => $payload['text'] ?? '',
                'matched'       => $matched,
            ]);

            if ($matched) {
                $delay = max(0, $automation->delay_seconds);

                PendingAutomation::query()->create([
                    'automation_id' => $automation->id,
                    'comment_data'  => $payload,
                    'execute_at'    => now()->addSeconds($delay),
                    'status'        => 'pending',
                ]);

                Log::info('[FB AUTOMATION] Pending automation created', [
                    'automation_id' => $automation->id,
                    'execute_at'    => now()->addSeconds($delay)->toDateTimeString(),
                    'delay_seconds' => $delay,
                ]);
            }
        }
    }

    /**
     * Resolve live automations for a platform + account ID, checking BOTH:
     *   1. Legacy SocialMediaPlatform (credentials->platform_id)
     *   2. New ConnectedAccount (account_identifier)
     *
     * @return \Illuminate\Database\Eloquent\Collection<int, Automation>
     */
    private function resolveAutomations(string $platform, ?string $accountId): \Illuminate\Database\Eloquent\Collection
    {
        // ── Path 1: legacy SocialMediaPlatform ──────────────────────────────
        $legacyQuery = Automation::query()
            ->where('status', 'live')
            ->whereNotNull('social_media_platform_id')
            ->whereNull('connected_account_id')
            ->whereHas('platform', function ($q) use ($platform, $accountId) {
                $q->where('platform', $platform);
                if ($accountId) {
                    // Facebook/Instagram store the page/account ID under credentials->platform_id
                    $q->where('credentials->platform_id', $accountId);
                }
            })
            ->with(['actions', 'replies', 'platform']);

        // ── Path 2: ConnectedAccount ─────────────────────────────────────────
        $connectedQuery = Automation::query()
            ->where('status', 'live')
            ->whereNotNull('connected_account_id')
            ->whereHas('connectedAccount', function ($q) use ($platform, $accountId) {
                $q->where('platform', $platform)
                  ->where('connection_status', 'connected');
                if ($accountId) {
                    $q->where('account_identifier', $accountId);
                }
            })
            ->with(['actions', 'replies', 'connectedAccount']);

        // Merge both result sets; use a Collection union to avoid duplicates
        $legacyResults    = $legacyQuery->get();
        $connectedResults = $connectedQuery->get();

        Log::info('[FB AUTOMATION] resolveAutomations breakdown', [
            'platform'         => $platform,
            'account_id'       => $accountId,
            'legacy_count'     => $legacyResults->count(),
            'connected_count'  => $connectedResults->count(),
            'legacy_ids'       => $legacyResults->pluck('id')->toArray(),
            'connected_ids'    => $connectedResults->pluck('id')->toArray(),
        ]);

        return $legacyResults->merge($connectedResults);
    }

    /**
     * Check if a comment matches the automation's trigger rules.
     *
     * @param  array<string, mixed>  $commentData
     */
    public function matchesTrigger(Automation $automation, array $commentData): bool
    {
        Log::info('[FB AUTOMATION DEBUG] Trigger matching check', [
            'automation_id' => $automation->id,
            'trigger_target' => $automation->trigger_target,
            'trigger_post_id' => $automation->trigger_post_id,
            'received_post_id' => $commentData['post_id'] ?? null,
        ]);

        // Check post targeting
        if ($automation->trigger_target === 'specific_post') {
            $postId = $commentData['post_id'] ?? null;

            if ($postId !== $automation->trigger_post_id) {
                Log::debug('[FB AUTOMATION DEBUG] Trigger mismatch: post_id does not match', [
                    'automation_id'   => $automation->id,
                    'expected_post'   => $automation->trigger_post_id,
                    'received_post'   => $postId,
                ]);

                return false;
            }
        }

        // Check keyword matching
        if ($automation->keyword_mode === 'specific') {
            $commentText = strtolower($commentData['text'] ?? '');

            // Check include keywords
            $includeKeywords = $automation->include_keywords ?? [];
            if (! empty($includeKeywords)) {
                $found = false;
                foreach ($includeKeywords as $keyword) {
                    if (str_contains($commentText, strtolower($keyword))) {
                        $found = true;
                        Log::info('[FB AUTOMATION DEBUG] Include keyword matched', [
                            'automation_id' => $automation->id,
                            'keyword' => $keyword,
                        ]);

                        break;
                    }
                }
                if (! $found) {
                    Log::debug('[FB AUTOMATION DEBUG] Trigger mismatch: no include keyword found in comment', [
                        'automation_id'    => $automation->id,
                        'comment_text'     => $commentText,
                        'include_keywords' => $includeKeywords,
                    ]);

                    return false;
                }
            }

            // Check exclude keywords
            $excludeKeywords = $automation->exclude_keywords ?? [];
            foreach ($excludeKeywords as $keyword) {
                if (str_contains($commentText, strtolower($keyword))) {
                    Log::debug('[FB AUTOMATION DEBUG] Trigger mismatch: exclude keyword found in comment', [
                        'automation_id'   => $automation->id,
                        'comment_text'    => $commentText,
                        'matched_keyword' => $keyword,
                    ]);

                    return false;
                }
            }
        }

        Log::info('[FB AUTOMATION DEBUG] Trigger matched successfully', [
            'automation_id' => $automation->id,
        ]);

        return true;
    }

    /**
     * Execute automation actions for a matched comment.
     *
     * @param  array<string, mixed>  $commenterData
     */
    public function executeActions(Automation $automation, array $commenterData): void
    {
        $commentId = $commenterData['comment_id'] ?? null;

        // Load the correct relationship if not already loaded
        if ($automation->connected_account_id && ! $automation->relationLoaded('connectedAccount')) {
            $automation->load('connectedAccount');
        } elseif ($automation->social_media_platform_id && ! $automation->relationLoaded('platform')) {
            $automation->load('platform');
        }

        $platformName = $automation->platform_name;
        $accessToken  = $automation->access_token;

        Log::info('[FB AUTOMATION EXECUTE] Executing actions', [
            'automation_id'          => $automation->id,
            'platform'               => $platformName,
            'uses_connected_account' => !is_null($automation->connected_account_id),
            'has_token'              => !empty($accessToken),
            'comment_id'             => $commentId,
            'actions_count'          => $automation->actions->count(),
            'enable_public_replies'  => $automation->enable_public_replies,
            'replies_count'          => $automation->replies->count(),
        ]);

        if ($commentId) {
            $exists = AutomationLog::query()
                ->where('automation_id', $automation->id)
                ->where('platform_comment_id', $commentId)
                ->exists();

            if ($exists) {
                Log::info('[FB AUTOMATION] Already executed for this comment, skipping', [
                    'automation_id' => $automation->id,
                    'comment_id'    => $commentId,
                ]);

                return;
            }
        }

        $log = AutomationLog::query()->create([
            'automation_id'       => $automation->id,
            'platform_comment_id' => $commenterData['comment_id'] ?? null,
            'commenter_id'        => $commenterData['commenter_id'] ?? null,
            'commenter_username'  => $commenterData['commenter_username'] ?? null,
            'comment_text'        => $commenterData['text'] ?? null,
            'status'              => 'success',
        ]);

        try {
            $variables = $this->buildVariables($commenterData);

            // Send public reply if enabled
            if ($automation->enable_public_replies && $automation->replies->isNotEmpty()) {
                $replyText = $automation->replies->random()->content;
                $replyText = $this->substituteVariables($replyText, $variables);
                Log::info('[FB AUTOMATION EXECUTE] Sending public reply', [
                    'reply_length' => strlen($replyText),
                    'reply_text' => $replyText,
                    'comment_id' => $commenterData['comment_id'],
                ]);
                $this->sendPublicReplyForAutomation($automation, $commenterData['comment_id'] ?? '', $replyText);
                Log::info('[FB AUTOMATION EXECUTE] Public reply sent successfully');
            } else {
                Log::info('[FB AUTOMATION EXECUTE] Public reply not enabled or no replies configured', [
                    'enable_public_replies' => $automation->enable_public_replies,
                    'replies_count' => $automation->replies->count(),
                ]);
            }

            // Send DM actions
            if ($automation->actions->isNotEmpty()) {
                $processedActions = $this->processActionsWithVariables(
                    $automation->actions->toArray(),
                    $variables
                );

                $this->sendDmForAutomation($automation, $commenterData, $processedActions);
            }

            $log->update([
                'actions_executed' => $automation->actions->pluck('type')->toArray(),
            ]);

            Log::info('[FB AUTOMATION] Execution completed', ['automation_id' => $automation->id]);
        } catch (Throwable $e) {
            Log::error('[FB AUTOMATION] Execution failed', [
                'automation_id' => $automation->id,
                'error'         => $e->getMessage(),
                'file'          => $e->getFile(),
                'line'          => $e->getLine(),
            ]);

            $log->update([
                'status'        => 'failed',
                'error_message' => $e->getMessage(),
            ]);
        }
    }

    /**
     * Build the variable map from commenter data.
     *
     * @param  array<string, mixed>  $commenterData
     *
     * @return array<string, string>
     */
    private function buildVariables(array $commenterData): array
    {
        $username = $commenterData['commenter_username'] ?? '';
        $firstName = $commenterData['commenter_first_name']
            ?? explode(' ', $commenterData['commenter_name'] ?? $username)[0]
            ?? $username;

        return [
            '{first_name}'   => $firstName,
            '{username}'     => $username,
            '{comment_text}' => $commenterData['text'] ?? '',
        ];
    }

    /**
     * Replace variable placeholders in a text string.
     *
     * @param  array<string, string>  $variables
     */
    private function substituteVariables(string $text, array $variables): string
    {
        return str_replace(
            array_keys($variables),
            array_values($variables),
            $text
        );
    }

    /**
     * Process all actions and substitute variables in text content.
     *
     * @param  array<int, mixed>  $actions
     * @param  array<string, string>  $variables
     *
     * @return array<int, mixed>
     */
    private function processActionsWithVariables(array $actions, array $variables): array
    {
        return array_map(function (array $action) use ($variables) {
            $content = $action['content'] ?? [];

            if ($action['type'] === 'text' && isset($content['text'])) {
                $content['text'] = $this->substituteVariables($content['text'], $variables);
            }

            if ($action['type'] === 'button' && isset($content['label'])) {
                $content['label'] = $this->substituteVariables($content['label'], $variables);
            }

            $action['content'] = $content;

            return $action;
        }, $actions);
    }

    /**
     * Send a DM to a user via the platform API.
     *
     * Instagram and Facebook use Private Replies (recipient.comment_id),
     * while X/Twitter uses standard DM (recipient user ID).
     *
     * @param  array<string, mixed>  $commenterData
     * @param  array<int, mixed>  $actions
     */
    /**
     * Send a DM using whichever account system the automation uses.
     * Routes to the legacy sendDm() or directly calls the platform method
     * with a ConnectedAccount's credentials.
     *
     * @param  array<string, mixed>  $commenterData
     * @param  array<int, mixed>  $actions
     */
    private function sendDmForAutomation(Automation $automation, array $commenterData, array $actions): void
    {
        // ConnectedAccount path
        if ($automation->connected_account_id && $automation->relationLoaded('connectedAccount') && $automation->connectedAccount) {
            $account      = $automation->connectedAccount;
            $platformName = $account->platform;
            $accessToken  = $account->access_token; // decrypted automatically

            // Build a lightweight credential-holder that mimics SocialMediaPlatform
            // by wrapping ConnectedAccount data into a plain object
            $pseudoPlatform = new SocialMediaPlatform([
                'platform'    => $platformName,
                'credentials' => [
                    'platform_id'  => $account->account_identifier,
                    'access_token' => $accessToken,
                ],
            ]);

            Log::info('[FB AUTOMATION] Sending DM via ConnectedAccount', [
                'automation_id'      => $automation->id,
                'platform'           => $platformName,
                'connected_account'  => $account->id,
                'has_token'          => !empty($accessToken),
                'comment_id'         => $commenterData['comment_id'] ?? null,
            ]);

            $this->sendDm($pseudoPlatform, $commenterData, $actions);

            return;
        }

        // Legacy SocialMediaPlatform path
        if ($automation->social_media_platform_id && $automation->relationLoaded('platform') && $automation->platform) {
            $this->sendDm($automation->platform, $commenterData, $actions);

            return;
        }

        Log::error('[FB AUTOMATION] sendDmForAutomation: could not resolve platform credentials', [
            'automation_id'            => $automation->id,
            'connected_account_id'     => $automation->connected_account_id,
            'social_media_platform_id' => $automation->social_media_platform_id,
        ]);
    }

    /**
     * Send a public reply using whichever account system the automation uses.
     */
    private function sendPublicReplyForAutomation(Automation $automation, string $commentId, string $replyText): void
    {
        // ConnectedAccount path
        if ($automation->connected_account_id && $automation->relationLoaded('connectedAccount') && $automation->connectedAccount) {
            $account      = $automation->connectedAccount;
            $accessToken  = $account->access_token;

            $pseudoPlatform = new SocialMediaPlatform([
                'platform'    => $account->platform,
                'credentials' => [
                    'platform_id'  => $account->account_identifier,
                    'access_token' => $accessToken,
                ],
            ]);

            $this->sendPublicReply($pseudoPlatform, $commentId, $replyText);

            return;
        }

        // Legacy SocialMediaPlatform path
        if ($automation->social_media_platform_id && $automation->relationLoaded('platform') && $automation->platform) {
            $this->sendPublicReply($automation->platform, $commentId, $replyText);

            return;
        }

        Log::error('[FB AUTOMATION] sendPublicReplyForAutomation: could not resolve platform credentials', [
            'automation_id' => $automation->id,
        ]);
    }

    /**
     * Send a public reply to a comment on the given platform.
     *
     * @param  SocialMediaPlatform  $platform
     * @param  string  $commentId
     * @param  string  $replyText
     */
    private function sendPublicReply(SocialMediaPlatform $platform, string $commentId, string $replyText): void
    {
        $platformName = $platform->platform;

        match ($platformName) {
            'instagram' => $this->replyInstagramComment($platform, $commentId, $replyText),
            'facebook'  => $this->replyFacebookComment($platform, $commentId, $replyText),
            'tiktok'    => $this->replyTikTokComment($platform, $commentId, $replyText),
            'linkedin'  => $this->replyLinkedInComment($platform, $commentId, $replyText),
            'x', 'twitter' => $this->replyXComment($platform, $commentId, $replyText),
            default     => Log::warning("Comment reply not supported for platform: {$platformName}"),
        };
    }

    // ──────────────────────────────────────────────────────────
    //  Platform-specific DM implementations
    // ──────────────────────────────────────────────────────────

    /**
     * Dispatch a DM via the correct platform-specific method.
     *
     * Routes based on $platform->platform to the matching sendXxxDm() implementation.
     *
     * @param  array<string, mixed>  $commenterData
     * @param  array<int, mixed>  $actions
     */
    private function sendDm(SocialMediaPlatform $platform, array $commenterData, array $actions): void
    {
        $platformName = $platform->platform;
        $commentId    = $commenterData['comment_id'] ?? '';
        $senderId     = $commenterData['commenter_id'] ?? '';

        match ($platformName) {
            'instagram'        => $this->sendInstagramDm($platform, $commentId, $actions),
            'facebook', 'messenger' => $this->sendFacebookDm($platform, $commentId, $actions),
            'x', 'twitter'    => $this->sendXDm($platform, $senderId, $actions),
            default            => Log::warning("DM not supported for platform: {$platformName}"),
        };
    }

    /**
     * Send DM via Instagram Graph API Private Reply (POST /{ig-user-id}/messages).
     *
     * Uses comment_id as recipient to trigger a Private Reply to the commenter.
     *
     * @param  array<int, mixed>  $actions
     */
    private function sendInstagramDm(SocialMediaPlatform $platform, string $commentId, array $actions): void
    {
        $accessToken = $platform->credentials['access_token'] ?? null;
        $igUserId = $platform->credentials['platform_id'] ?? $platform->credentials['id'] ?? null;

        if (! $accessToken || ! $igUserId) {
            Log::warning('Instagram DM skipped: missing credentials', ['platform_id' => $platform->id]);

            return;
        }

        if (! $commentId) {
            Log::warning('Instagram DM skipped: missing comment_id', ['platform_id' => $platform->id]);

            return;
        }

        $apiVersion = config('social-media.instagram.api_version', 'v18.0');
        $baseUrl = "https://graph.facebook.com/{$apiVersion}";

        foreach ($actions as $action) {
            $message = $this->buildInstagramMessage($action);

            if (! $message) {
                continue;
            }

            if ($action['type'] === 'delay') {
                sleep(min((int) ($action['content']['seconds'] ?? 1), 60));

                continue;
            }

            $response = $this->graphApiPost("{$baseUrl}/{$igUserId}/messages", $accessToken, [
                'recipient' => ['comment_id' => $commentId],
                'message'   => $message,
            ]);

            $this->logApiResponse('Instagram DM (private reply)', $response);
        }
    }

    /**
     * Build an Instagram-compatible message payload from an action.
     *
     * @param  array<string, mixed>  $action
     *
     * @return array<string, mixed>|null
     */
    private function buildInstagramMessage(array $action): ?array
    {
        $content = $action['content'] ?? [];

        return match ($action['type'] ?? '') {
            'text'          => ['text' => $content['text'] ?? ''],
            'image'         => ['attachment' => ['type' => 'image', 'payload' => ['url' => $content['url'] ?? '']]],
            'button'        => ['attachment' => ['type' => 'template', 'payload' => [
                'template_type' => 'button',
                'text'          => $content['label'] ?? 'Click here',
                'buttons'       => [['type' => 'web_url', 'url' => $content['url'] ?? '', 'title' => $content['label'] ?? '']],
            ]]],
            'quick_replies' => ['text' => 'Choose an option:', 'quick_replies' => collect($content['items'] ?? [])
                ->map(fn (string $item) => ['content_type' => 'text', 'title' => $item, 'payload' => $item])
                ->toArray()],
            default => null,
        };
    }

    /**
     * Send DM via Facebook Private Reply API (POST /me/messages).
     *
     * Uses comment_id as recipient to trigger a Private Reply to the commenter.
     *
     * @param  array<int, mixed>  $actions
     */
    private function sendFacebookDm(SocialMediaPlatform $platform, string $commentId, array $actions): void
    {
        $accessToken = $platform->credentials['access_token'] ?? null;

        Log::info('[FB AUTOMATION DEBUG] RECIPIENT RESOLUTION', [
            'source_commenter_id' => $commentId,
            'resolved_recipient_id' => $commentId,
            'resolution_method' => 'using comment_id as recipient (Private Reply API)',
            'success' => !empty($commentId),
        ]);

        Log::info('[FB AUTOMATION DEBUG] SEND DM START', [
            'page_id' => $platform->credentials['platform_id'] ?? null,
            'recipient_id_masked' => $commentId ? substr($commentId, 0, 8) . '...' : 'MISSING',
            'message_length' => strlen($actions[0]['content']['text'] ?? ''),
            'automation_id' => $platform->id,
        ]);

        if (! $accessToken) {
            Log::warning('[FB AUTOMATION DEBUG] Facebook DM skipped: missing access token', ['platform_id' => $platform->id]);

            return;
        }

        if (! $commentId) {
            Log::warning('[FB AUTOMATION DEBUG] Facebook DM skipped: missing comment_id', ['platform_id' => $platform->id]);

            return;
        }

        $apiVersion = config('social-media.facebook.api_version', 'v18.0');
        $baseUrl = "https://graph.facebook.com/{$apiVersion}";

        foreach ($actions as $action) {
            if ($action['type'] === 'delay') {
                $seconds = min((int) ($action['content']['seconds'] ?? 1), 60);
                Log::debug('[FB AUTOMATION DEBUG] Facebook DM delay action', ['seconds' => $seconds]);
                sleep($seconds);

                continue;
            }

            $message = $this->buildFacebookMessage($action);

            if (! $message) {
                Log::debug('[FB AUTOMATION DEBUG] Facebook DM action skipped: unsupported type', ['type' => $action['type'] ?? null]);

                continue;
            }

            Log::info('[FB AUTOMATION DEBUG] FACEBOOK GRAPH API REQUEST', [
                'endpoint' => "{$baseUrl}/me/messages",
                'method' => 'POST',
                'recipient_comment_id' => $commentId,
                'message_type' => $action['type'] ?? null,
                'api_version' => $apiVersion,
            ]);

            $response = $this->graphApiPost("{$baseUrl}/me/messages", $accessToken, [
                'recipient' => ['comment_id' => $commentId],
                'message'   => $message,
            ]);

            Log::info('[FB AUTOMATION DEBUG] FACEBOOK GRAPH API RESPONSE', [
                'http_status' => $response->status(),
                'successful' => $response->successful(),
                'body_keys' => array_keys($response->json() ?? []),
            ]);

            if (!$response->successful()) {
                Log::error('[FB AUTOMATION DEBUG] FACEBOOK GRAPH API FAILED', [
                    'http_status' => $response->status(),
                    'error' => $response->json(),
                ]);
            } else {
                Log::info('[FB AUTOMATION DEBUG] FACEBOOK DM SENT SUCCESSFULLY', [
                    'message_id' => $response->json('message_id'),
                ]);
            }

            $this->logApiResponse('Facebook DM (private reply)', $response);
        }
    }

    /**
     * Build a Facebook-compatible message payload from an action.
     *
     * @param  array<string, mixed>  $action
     *
     * @return array<string, mixed>|null
     */
    private function buildFacebookMessage(array $action): ?array
    {
        $content = $action['content'] ?? [];

        return match ($action['type'] ?? '') {
            'text'          => ['text' => $content['text'] ?? ''],
            'image'         => ['attachment' => ['type' => 'image', 'payload' => ['url' => $content['url'] ?? '', 'is_reusable' => true]]],
            'button'        => ['attachment' => ['type' => 'template', 'payload' => [
                'template_type' => 'button',
                'text'          => $content['label'] ?? 'Click here',
                'buttons'       => [['type' => 'web_url', 'url' => $content['url'] ?? '', 'title' => $content['label'] ?? '']],
            ]]],
            'quick_replies' => ['text' => 'Choose an option:', 'quick_replies' => collect($content['items'] ?? [])
                ->map(fn (string $item) => ['content_type' => 'text', 'title' => $item, 'payload' => $item])
                ->toArray()],
            default => null,
        };
    }

    /**
     * Send DM via X API v2 (POST /2/dm_conversations/with/{participant_id}/messages).
     *
     * @param  array<int, mixed>  $actions
     */
    private function sendXDm(SocialMediaPlatform $platform, string $recipientId, array $actions): void
    {
        $accessToken = $platform->credentials['access_token'] ?? null;

        if (! $accessToken) {
            Log::warning('X DM skipped: missing access token', ['platform_id' => $platform->id]);

            return;
        }

        $baseUrl = 'https://api.x.com/2';

        foreach ($actions as $action) {
            if ($action['type'] === 'delay') {
                sleep(min((int) ($action['content']['seconds'] ?? 1), 60));

                continue;
            }

            $content = $action['content'] ?? [];
            $text = match ($action['type'] ?? '') {
                'text'          => $content['text'] ?? '',
                'button'        => ($content['label'] ?? '') . "\n" . ($content['url'] ?? ''),
                'quick_replies' => 'Options: ' . implode(', ', $content['items'] ?? []),
                default         => null,
            };

            if (! $text) {
                continue;
            }

            $response = Http::withToken($accessToken)
                ->retry(2, 1000)
                ->post("{$baseUrl}/dm_conversations/with/{$recipientId}/messages", [
                    'text' => $text,
                ]);

            $this->logApiResponse('X DM', $response);
        }
    }

    // ──────────────────────────────────────────────────────────
    //  Platform-specific comment reply implementations
    // ──────────────────────────────────────────────────────────

    /**
     * Reply to an Instagram comment via Graph API (POST /{comment-id}/replies).
     */
    private function replyInstagramComment(SocialMediaPlatform $platform, string $commentId, string $replyText): void
    {
        $accessToken = $platform->credentials['access_token'] ?? null;

        if (! $accessToken) {
            return;
        }

        $apiVersion = config('social-media.instagram.api_version', 'v18.0');

        $response = $this->graphApiPost(
            "https://graph.facebook.com/{$apiVersion}/{$commentId}/replies",
            $accessToken,
            ['message' => $replyText]
        );

        $this->logApiResponse('Instagram comment reply', $response);
    }

    /**
     * Reply to a Facebook comment via Graph API (POST /{comment-id}/comments).
     */
    private function replyFacebookComment(SocialMediaPlatform $platform, string $commentId, string $replyText): void
    {
        $accessToken = $platform->credentials['access_token'] ?? null;

        if (! $accessToken) {
            Log::error('[FB AUTOMATION] No access token for Facebook comment reply', [
                'platform_id' => $platform->id,
                'comment_id' => $commentId,
            ]);
            return;
        }

        $apiVersion = config('social-media.facebook.api_version', 'v18.0');

        Log::info('[FB AUTOMATION] Attempting Facebook comment reply', [
            'comment_id' => $commentId,
            'reply_text' => $replyText,
            'api_version' => $apiVersion,
            'token_length' => strlen($accessToken),
        ]);

        $response = $this->graphApiPost(
            "https://graph.facebook.com/{$apiVersion}/{$commentId}/comments",
            $accessToken,
            ['message' => $replyText]
        );

        $this->logApiResponse('Facebook comment reply', $response);
    }

    /**
     * Reply to a TikTok comment via TikTok API (POST /v2/comment/reply/create/).
     */
    private function replyTikTokComment(SocialMediaPlatform $platform, string $commentId, string $replyText): void
    {
        $accessToken = $platform->credentials['access_token'] ?? null;

        if (! $accessToken) {
            return;
        }

        $response = Http::withToken($accessToken)
            ->retry(2, 1000)
            ->post('https://open.tiktokapis.com/v2/comment/reply/create/', [
                'comment_id' => $commentId,
                'text'       => $replyText,
            ]);

        $this->logApiResponse('TikTok comment reply', $response);
    }

    /**
     * Reply to a LinkedIn comment via REST API (POST /socialActions/{id}/comments).
     */
    private function replyLinkedInComment(SocialMediaPlatform $platform, string $commentId, string $replyText): void
    {
        $accessToken = $platform->credentials['access_token'] ?? null;

        if (! $accessToken) {
            return;
        }

        $headerVersion = config('social-media.linkedin.header_version', '202408');

        $response = Http::withToken($accessToken)
            ->withHeaders([
                'LinkedIn-Version'          => $headerVersion,
                'X-Restli-Protocol-Version' => '2.0.0',
            ])
            ->retry(2, 1000)
            ->post("https://api.linkedin.com/rest/socialActions/{$commentId}/comments", [
                'message' => ['text' => $replyText],
            ]);

        $this->logApiResponse('LinkedIn comment reply', $response);
    }

    /**
     * Reply to an X/Twitter post via API v2 (POST /2/tweets).
     */
    private function replyXComment(SocialMediaPlatform $platform, string $commentId, string $replyText): void
    {
        $accessToken = $platform->credentials['access_token'] ?? null;

        if (! $accessToken) {
            return;
        }

        $response = Http::withToken($accessToken)
            ->retry(2, 1000)
            ->post('https://api.x.com/2/tweets', [
                'text'  => $replyText,
                'reply' => ['in_reply_to_tweet_id' => $commentId],
            ]);

        $this->logApiResponse('X comment reply', $response);
    }

    // ──────────────────────────────────────────────────────────
    //  Helper methods
    // ──────────────────────────────────────────────────────────

    /**
     * Make a POST request to the Meta Graph API.
     *
     * @param  array<string, mixed>  $data
     */
    private function graphApiPost(string $url, string $accessToken, array $data): Response
    {
        return Http::withToken($accessToken)
            ->retry(2, 1000)
            ->post($url, $data);
    }

    /**
     * Log the API response for debugging.
     */
    private function logApiResponse(string $context, Response $response): void
    {
        if ($response->successful()) {
            Log::info("{$context} sent successfully", ['response' => $response->json()]);

            return;
        }

        $body = $response->body();
        Log::error("{$context} failed", [
            'status' => $response->status(),
            'body'   => $body,
            'body_preview' => substr($body, 0, 500),
        ]);

        throw new RuntimeException("{$context} failed with status {$response->status()}: {$body}");
    }
}
