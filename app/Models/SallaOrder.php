<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SallaOrder extends Model
{
    use HasFactory;

    protected $fillable = [
        'salla_connection_id',
        'salla_order_id',
        'reference_id',
        'status',
        'status_name',
        'currency',
        'total',
        'sub_total',
        'shipping_cost',
        'tax_amount',
        'payment_method',
        'order_date',
        'deleted_at',
        'order_data',
        'last_synced_at',
    ];

    protected $casts = [
        'order_data' => 'encrypted:array',
        'total' => 'decimal:2',
        'sub_total' => 'decimal:2',
        'shipping_cost' => 'decimal:2',
        'tax_amount' => 'decimal:2',
        'order_date' => 'datetime',
        'deleted_at' => 'datetime',
        'last_synced_at' => 'datetime',
    ];

    /**
     * Relationship to Salla connection
     */
    public function connection()
    {
        return $this->belongsTo(SallaConnection::class, 'salla_connection_id');
    }
}
