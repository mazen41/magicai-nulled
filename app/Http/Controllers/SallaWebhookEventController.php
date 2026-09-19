<?php

namespace App\Http\Controllers;

use App\Models\SallaConnection;
use App\Models\SallaWebhookEvent;
use Illuminate\Support\Facades\Auth;

class SallaWebhookEventController extends Controller
{
    /**
     * Display webhook events for a connection
     */
    public function index($connectionId)
    {
        $user = Auth::user();

        $connection = SallaConnection::query()
            ->where('user_id', $user->id)
            ->findOrFail($connectionId);

        $events = SallaWebhookEvent::query()
            ->where('salla_connection_id', $connection->id)
            ->orderBy('created_at', 'desc')
            ->paginate(50);

        return view('default.panel.user.salla.events.index', [
            'connection' => $connection,
            'events' => $events,
        ]);
    }

    /**
     * Display webhook event details
     */
    public function show($connectionId, $eventId)
    {
        $user = Auth::user();

        $connection = SallaConnection::query()
            ->where('user_id', $user->id)
            ->findOrFail($connectionId);

        $event = SallaWebhookEvent::query()
            ->where('salla_connection_id', $connection->id)
            ->where('id', $eventId)
            ->findOrFail($eventId);

        return view('default.panel.user.salla.events.show', [
            'connection' => $connection,
            'event' => $event,
        ]);
    }
}
