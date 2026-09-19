<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SallaWebhookEvent extends Model
{
    use HasFactory;

    protected $fillable = [
        'salla_connection_id',
        'event_type',
        'merchant_id',
        'payload_hash',
        'payload',
        'signature_verification_status',
        'processing_status',
        'received_at',
        'processed_at',
    ];

    protected $casts = [
        'received_at' => 'datetime',
        'processed_at' => 'datetime',
    ];

    /**
     * Relationship to Salla connection
     */
    public function connection()
    {
        return $this->belongsTo(SallaConnection::class, 'salla_connection_id');
    }
}
