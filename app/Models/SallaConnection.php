<?php

namespace App\Models;

use App\Models\Chatbot\Chatbot;
use App\Models\SallaWebhookSubscription;
use App\Models\SallaOrder;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class SallaConnection extends Model
{
    protected $fillable = [
        'user_id',
        'salla_store_id',
        'store_name',
        'store_domain',
        'merchant_email',
        'merchant_name',
        'access_token',
        'refresh_token',
        'token_expires_at',
        'connection_status',
        'webhook_status',
        'webhook_secret',
        'store_data',
        'last_synced_at',
        'connected_at',
    ];

    protected $casts = [
        'access_token' => 'encrypted',
        'refresh_token' => 'encrypted',
        'webhook_secret' => 'encrypted',
        'store_data' => 'array',
        'token_expires_at' => 'datetime',
        'last_synced_at' => 'datetime',
        'connected_at' => 'datetime',
    ];

    protected $hidden = [
        'access_token',
        'refresh_token',
        'webhook_secret',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function chatbots(): HasMany
    {
        return $this->hasMany(Chatbot::class, 'salla_connection_id');
    }

    public function webhookSubscriptions(): HasMany
    {
        return $this->hasMany(SallaWebhookSubscription::class, 'salla_connection_id');
    }

    public function sallaOrders(): HasMany
    {
        return $this->hasMany(SallaOrder::class, 'salla_connection_id');
    }

    public function isConnected(): bool
    {
        return $this->connection_status === 'connected';
    }

    public function scopeForUser($query, $userId)
    {
        return $query->where('user_id', $userId);
    }
}
