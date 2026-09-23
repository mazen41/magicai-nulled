<?php

namespace App\Http\Controllers\Integration;

use App\Http\Controllers\Controller;
use App\Models\ConnectedAccount;
use App\Services\OAuth\ConnectedAccountService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UnifiedIntegrationController extends Controller
{
    public function __construct(
        private ConnectedAccountService $accountService
    ) {}

    public function index()
    {
        $user = Auth::user();

        // Get all connected accounts grouped by platform
        $connectedAccounts = ConnectedAccount::query()
            ->where('user_id', $user->id)
            ->orderBy('platform')
            ->orderByDesc('connected_at')
            ->get()
            ->groupBy('platform');

        // Define supported platforms and their OAuth routes
        $platforms = $this->getSupportedPlatforms();

        return view('panel.user.integrations.index', [
            'connectedAccounts' => $connectedAccounts,
            'platforms'         => $platforms,
        ]);
    }

    public function disconnect(Request $request, ConnectedAccount $account)
    {
        $user = Auth::user();

        \Log::info('[CONNECTED ACCOUNT] Disconnect request received', [
            'account_id' => $account->id,
            'platform' => $account->platform,
            'account_identifier' => $account->account_identifier,
            'user_id' => $user->id,
            'account_user_id' => $account->user_id,
        ]);

        if ($account->user_id !== $user->id) {
            \Log::error('[CONNECTED ACCOUNT] Disconnect failed: unauthorized', [
                'account_id' => $account->id,
                'account_user_id' => $account->user_id,
                'current_user_id' => $user->id,
            ]);
            abort(403, 'Unauthorized');
        }

        $result = $this->accountService->disconnect($account, $user);

        if ($result) {
            \Log::info('[CONNECTED ACCOUNT] Disconnect successful redirect');
            return back()->with([
                'type'    => 'success',
                'message' => trans('Account disconnected successfully.'),
            ]);
        } else {
            \Log::error('[CONNECTED ACCOUNT] Disconnect failed: service returned false');
            return back()->with([
                'type'    => 'error',
                'message' => trans('Failed to disconnect account.'),
            ]);
        }
    }

    public function apiList(Request $request)
    {
        $user = Auth::user();
        $platform = $request->query('platform');

        $query = ConnectedAccount::query()
            ->where('user_id', $user->id)
            ->where('connection_status', 'connected');

        if ($platform) {
            $query->where('platform', $platform);
        }

        $platformLabels = [
            'salla'           => 'Salla',
            'instagram'       => 'Instagram',
            'messenger'       => 'Facebook Messenger',
            'telegram'        => 'Telegram',
            'whatsapp_cloud'  => 'WhatsApp Business',
        ];

        return response()->json([
            'status' => 'success',
            'data'   => $query->orderByDesc('connected_at')->get()->map(fn ($a) => [
                'id'                 => $a->id,
                'platform'           => $a->platform,
                'platform_label'     => $platformLabels[$a->platform] ?? ucfirst(str_replace('_', ' ', $a->platform)),
                'account_identifier' => $a->account_identifier,
                'account_name'       => $a->getDisplayName(),
                'account_username'   => $a->account_username,
                'account_avatar'     => $a->account_avatar,
                'connection_status'  => $a->connection_status,
                'connected_at'       => $a->connected_at?->toDateTimeString(),
            ]),
        ]);
    }

    private function getSupportedPlatforms(): array
    {
        return [
            'salla' => [
                'name'         => 'Salla',
                'icon'         => 'salla.svg',
                'connect_route' => 'dashboard.user.salla.connect',
                'connect_url'  => route('dashboard.user.salla.connect'),
                'oauth'        => true,
                'enabled'      => true,
                'description'  => 'Connect your Salla store to enable e-commerce chatbot features.',
            ],
            'instagram' => [
                'name'         => 'Instagram',
                'icon'         => 'instagram.svg',
                'connect_route' => 'dashboard.user.integrations.instagram.connect',
                'connect_url'  => route('dashboard.user.integrations.instagram.connect'),
                'oauth'        => true,
                'enabled'      => \App\Helpers\Classes\MarketplaceHelper::isRegistered('chatbot-instagram'),
                'description'  => 'Connect Instagram to receive and respond to Direct Messages.',
            ],
            'messenger' => [
                'name'         => 'Facebook Messenger',
                'icon'         => 'messenger.svg',
                'connect_route' => 'dashboard.user.integrations.messenger.connect',
                'connect_url'  => route('dashboard.user.integrations.messenger.connect'),
                'oauth'        => true,
                'enabled'      => \App\Helpers\Classes\MarketplaceHelper::isRegistered('chatbot-messenger'),
                'description'  => 'Connect Facebook Pages to handle Messenger conversations.',
            ],
            'whatsapp_cloud' => [
                'name'         => 'WhatsApp Business (Cloud API)',
                'icon'         => 'whatsapp.svg',
                'connect_route' => 'dashboard.user.integrations.whatsapp-cloud.connect',
                'connect_url'  => route('dashboard.user.integrations.whatsapp-cloud.connect'),
                'oauth'        => false,
                'enabled'      => \App\Helpers\Classes\MarketplaceHelper::isRegistered('chatbot-whatsapp'),
                'description'  => 'Connect WhatsApp Business via Meta Cloud API to receive and reply to messages.',
            ],
        ];
    }
}
