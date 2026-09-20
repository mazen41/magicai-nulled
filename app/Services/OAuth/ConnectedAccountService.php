<?php

namespace App\Services\OAuth;

use App\Models\ConnectedAccount;
use App\Models\User;

class ConnectedAccountService
{
    public function createOrUpdate(
        User   $user,
        string $platform,
        string $accountIdentifier,
        string $accessToken,
        array  $accountData = [],
        ?string $refreshToken = null,
        ?\Carbon\Carbon $tokenExpiresAt = null
    ): ConnectedAccount {
        $existing = ConnectedAccount::query()
            ->where('user_id', $user->id)
            ->where('platform', $platform)
            ->where('account_identifier', $accountIdentifier)
            ->first();

        $data = [
            'access_token'       => $accessToken,
            'refresh_token'      => $refreshToken,
            'token_expires_at'   => $tokenExpiresAt,
            'account_name'       => $accountData['name'] ?? null,
            'account_username'   => $accountData['username'] ?? null,
            'account_avatar'     => $accountData['avatar'] ?? null,
            'metadata'           => $accountData['metadata'] ?? null,
            'connection_status'  => 'connected',
            'connected_at'       => now(),
            'last_synced_at'     => now(),
        ];

        if ($existing) {
            $existing->update($data);
            return $existing;
        }

        return ConnectedAccount::create(array_merge($data, [
            'user_id'            => $user->id,
            'platform'           => $platform,
            'account_identifier' => $accountIdentifier,
        ]));
    }

    public function getForUser(User $user, string $platform): \Illuminate\Database\Eloquent\Collection
    {
        return ConnectedAccount::query()
            ->where('user_id', $user->id)
            ->where('platform', $platform)
            ->where('connection_status', 'connected')
            ->orderByDesc('connected_at')
            ->get();
    }

    public function getAllForUser(User $user): array
    {
        $accounts = ConnectedAccount::query()
            ->where('user_id', $user->id)
            ->where('connection_status', 'connected')
            ->orderBy('platform')
            ->orderByDesc('connected_at')
            ->get();

        return $accounts->groupBy('platform')->toArray();
    }

    public function disconnect(ConnectedAccount $account, User $user): bool
    {
        if ($account->user_id !== $user->id) {
            return false; // ownership check
        }

        $account->update([
            'connection_status' => 'disconnected',
            'access_token'      => null,
            'refresh_token'     => null,
            'webhook_registered' => false,
        ]);

        // Nullify connected_account_id on any ext_chatbots using this account
        \App\Extensions\Chatbot\System\Models\Chatbot::query()
            ->where('connected_account_id', $account->id)
            ->update(['connected_account_id' => null]);

        return true;
    }
}
