<?php

namespace App\Models;

use App\Extensions\Chatbot\System\Models\Chatbot as ExtChatbot;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ConnectedAccount extends Model
{
    protected $table = 'connected_accounts';

    protected $fillable = [
        'user_id',
        'platform',
        'account_identifier',
        'account_name',
        'account_username',
        'account_avatar',
        'access_token',
        'refresh_token',
        'token_expires_at',
        'connection_status',
        'webhook_registered',
        'webhook_secret',
        'metadata',
        'connected_at',
        'last_synced_at',
    ];

    protected $casts = [
        'metadata'        => 'array',
        'token_expires_at' => 'datetime',
        'connected_at'    => 'datetime',
        'last_synced_at'  => 'datetime',
        'webhook_registered' => 'boolean',
        'access_token'     => 'encrypted',
        'refresh_token'    => 'encrypted',
        'webhook_secret'    => 'encrypted',
    ];

    protected $hidden = [
        'access_token',
        'refresh_token',
        'webhook_secret',
    ];

    // --- Relationships ---

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function chatbots(): HasMany
    {
        return $this->hasMany(\App\Extensions\Chatbot\System\Models\Chatbot::class, 'connected_account_id');
    }

    public function extChatbots(): BelongsToMany
    {
        return $this->belongsToMany(\App\Extensions\Chatbot\System\Models\Chatbot::class, 'chatbot_connected_accounts', 'connected_account_id', 'chatbot_id')
            ->withTimestamps();
    }

    // --- Helpers ---

    public function isConnected(): bool
    {
        return $this->connection_status === 'connected';
    }

    public function isTokenExpired(): bool
    {
        if (!$this->token_expires_at) return false;
        return $this->token_expires_at->isPast();
    }

    public function shouldRefreshToken(): bool
    {
        if (!$this->token_expires_at) return false;
        return $this->token_expires_at->subMinutes(5)->isPast();
    }

    public function scopeForUser($query, int $userId)
    {
        return $query->where('user_id', $userId);
    }

    public function scopePlatform($query, string $platform)
    {
        return $query->where('platform', $platform);
    }

    public function scopeConnected($query)
    {
        return $query->where('connection_status', 'connected');
    }

    public function getDisplayName(): string
    {
        return $this->account_name
            ?? $this->account_username
            ?? $this->account_identifier
            ?? ucfirst($this->platform) . ' Account';
    }
}
