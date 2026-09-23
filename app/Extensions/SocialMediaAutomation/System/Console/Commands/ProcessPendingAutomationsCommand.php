<?php

declare(strict_types=1);

namespace App\Extensions\SocialMediaAutomation\System\Console\Commands;

use App\Extensions\SocialMediaAutomation\System\Models\PendingAutomation;
use App\Extensions\SocialMediaAutomation\System\Services\AutomationExecutionService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Throwable;

class ProcessPendingAutomationsCommand extends Command
{
    protected $signature = 'social-media-automation:process-pending';

    protected $description = 'Process pending automation jobs from the database';

    public function handle(AutomationExecutionService $service): void
    {
        $pendings = PendingAutomation::query()
            ->where('status', 'pending')
            ->where('execute_at', '<=', now())
            ->get();

        Log::info('[FB AUTOMATION DEBUG] JOB STARTED', [
            'pending_count' => $pendings->count(),
            'ids' => $pendings->pluck('id')->toArray(),
        ]);

        foreach ($pendings as $pending) {
            $pending->update(['status' => 'processing']);

            Log::info('[FB AUTOMATION DEBUG] Processing pending automation', [
                'pending_id'    => $pending->id,
                'automation_id' => $pending->automation_id,
                'execute_at'    => $pending->execute_at,
                'comment_data'   => [
                    'comment_id' => $pending->comment_data['comment_id'] ?? null,
                    'text' => $pending->comment_data['text'] ?? '',
                ],
            ]);

            try {
                $service->executeActions(
                    $pending->automation->load(['actions', 'replies', 'platform']),
                    $pending->comment_data
                );

                $pending->update(['status' => 'completed']);

                Log::info('[FB AUTOMATION DEBUG] JOB FINISHED', ['pending_id' => $pending->id]);
            } catch (Throwable $e) {
                Log::error('[FB AUTOMATION DEBUG] Pending automation failed', [
                    'pending_id' => $pending->id,
                    'error'      => $e->getMessage(),
                    'file'       => $e->getFile(),
                    'line'       => $e->getLine(),
                ]);

                $pending->update([
                    'status'        => 'failed',
                    'error_message' => $e->getMessage(),
                ]);
            }
        }
    }
}
