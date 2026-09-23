<?php

declare(strict_types=1);

namespace App\Extensions\SocialMediaAutomation\System\Models;

use App\Extensions\SocialMedia\System\Models\SocialMediaPlatform;
use App\Models\ConnectedAccount;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Automation extends Model
{
    protected $table = 'ext_sm_automations';

    protected $fillable = [
        'user_id',
        'social_media_platform_id',
        'connected_account_id',
        'name',
        'status',
        'trigger_target',
        'trigger_post_id',
        'trigger_post_data',
        'keyword_mode',
        'include_keywords',
        'exclude_keywords',
        'enable_public_replies',
        'delay_seconds',
        'workflow_graph',
    ];

    protected $casts = [
        'trigger_post_data'     => 'array',
        'include_keywords'      => 'array',
        'exclude_keywords'      => 'array',
        'enable_public_replies' => 'boolean',
        'delay_seconds'         => 'integer',
        'workflow_graph'        => 'array',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Legacy relationship — SocialMediaPlatform (ext_social_media_platforms).
     */
    public function platform(): BelongsTo
    {
        return $this->belongsTo(SocialMediaPlatform::class, 'social_media_platform_id');
    }

    /**
     * New relationship — ConnectedAccount.
     */
    public function connectedAccount(): BelongsTo
    {
        return $this->belongsTo(ConnectedAccount::class, 'connected_account_id');
    }

    /**
     * Platform string regardless of account system.
     */
    public function getPlatformNameAttribute(): ?string
    {
        if ($this->connected_account_id && $this->relationLoaded('connectedAccount')) {
            return $this->connectedAccount?->platform;
        }

        if ($this->social_media_platform_id && $this->relationLoaded('platform')) {
            return $this->platform?->platform;
        }

        return null;
    }

    /**
     * Platform account identifier (Page ID, IG user ID, etc.).
     */
    public function getPlatformAccountIdAttribute(): ?string
    {
        if ($this->connected_account_id && $this->relationLoaded('connectedAccount')) {
            return $this->connectedAccount?->account_identifier;
        }

        if ($this->social_media_platform_id && $this->relationLoaded('platform')) {
            return $this->platform?->credentials['platform_id'] ?? null;
        }

        return null;
    }

    /**
     * Decrypted access token regardless of account system.
     */
    public function getAccessTokenAttribute(): ?string
    {
        if ($this->connected_account_id && $this->relationLoaded('connectedAccount')) {
            return $this->connectedAccount?->access_token;
        }

        if ($this->social_media_platform_id && $this->relationLoaded('platform')) {
            return $this->platform?->credentials['access_token'] ?? null;
        }

        return null;
    }

    public function actions(): HasMany
    {
        return $this->hasMany(AutomationAction::class, 'automation_id')->orderBy('order');
    }

    public function replies(): HasMany
    {
        return $this->hasMany(AutomationReply::class, 'automation_id');
    }

    public function logs(): HasMany
    {
        return $this->hasMany(AutomationLog::class, 'automation_id');
    }

    public function isLive(): bool
    {
        return $this->status === 'live';
    }

    public function isDraft(): bool
    {
        return $this->status === 'draft';
    }
}
