<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SallaWebhookSubscription extends Model
{
    use HasFactory;

    protected $fillable = [
        'salla_connection_id',
        'salla_webhook_id',
        'name',
        'event',
        'url',
        'version',
        'type',
        'rule',
        'headers',
        'status',
        'synced_at',
    ];

    protected $casts = [
        'headers' => 'array',
        'version' => 'integer',
        'synced_at' => 'datetime',
    ];

    /**
     * Relationship to Salla connection
     */
    public function connection()
    {
        return $this->belongsTo(SallaConnection::class, 'salla_connection_id');
    }
}
