<?php

namespace App\Http\Controllers;

use App\Models\SallaConnection;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class SallaStoreController extends Controller
{
    /**
     * Display user's Salla connections
     */
    public function index()
    {
        $user = Auth::user();

        $connections = SallaConnection::query()
            ->where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();

        return view('default.panel.user.salla.index', [
            'connections' => $connections,
        ]);
    }

    /**
     * Disconnect a Salla store
     */
    public function disconnect($id)
    {
        $user = Auth::user();

        $connection = SallaConnection::query()
            ->where('user_id', $user->id)
            ->findOrFail($id);

        // Mark connection as disconnected
        $connection->update([
            'connection_status' => 'disconnected',
            'webhook_status' => 'inactive',
            'access_token' => null,
            'refresh_token' => null,
            'webhook_secret' => null,
        ]);

        Log::info('Salla connection disconnected', [
            'user_id' => $user->id,
            'connection_id' => $connection->id,
            'salla_store_id' => $connection->salla_store_id,
        ]);

        return back()->with([
            'type' => 'success',
            'message' => trans('Salla store disconnected successfully.'),
        ]);
    }

    /**
     * Test Salla connection
     */
    public function test($id)
    {
        $user = Auth::user();

        $connection = SallaConnection::query()
            ->where('user_id', $user->id)
            ->findOrFail($id);

        try {
            // Use lightweight store info endpoint to test connection
            $apiClient = new SallaApiClient($connection, app(SallaOAuthService::class));
            $response = $apiClient->get('store/info');

            // Update connection status if successful
            $connection->update([
                'connection_status' => 'connected',
                'last_synced_at' => now(),
            ]);

            Log::info('Salla connection test successful', [
                'user_id' => $user->id,
                'connection_id' => $connection->id,
                'salla_store_id' => $connection->salla_store_id,
            ]);

            return back()->with([
                'type' => 'success',
                'message' => trans('Salla connection test successful.'),
            ]);

        } catch (\Exception $e) {
            // Update connection status to indicate issue
            $connection->update([
                'connection_status' => 'error',
            ]);

            Log::error('Salla connection test failed', [
                'user_id' => $user->id,
                'connection_id' => $connection->id,
                'salla_store_id' => $connection->salla_store_id,
                'error' => $e->getMessage(),
            ]);

            return back()->with([
                'type' => 'error',
                'message' => trans('Salla connection test failed:').' '.$e->getMessage(),
            ]);
        }
    }
}
