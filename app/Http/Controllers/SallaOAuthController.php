<?php

namespace App\Http\Controllers;

use App\Services\Salla\SallaOAuthService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use RuntimeException;

class SallaOAuthController extends Controller
{
    public function __construct(
        private SallaOAuthService $oauthService
    ) {}

    /**
     * Redirect user to Salla authorization page
     */
    public function redirect()
    {
        $user = Auth::user();

        if (! $user) {
            return redirect()->route('login')->with([
                'type' => 'error',
                'message' => trans('You must be logged in to connect Salla.'),
            ]);
        }

        try {
            $authorizationUrl = $this->oauthService->getAuthorizationUrl($user);

            return redirect()->away($authorizationUrl);
        } catch (RuntimeException $e) {
            Log::error('Salla OAuth redirect failed', [
                'user_id' => $user->id,
                'error' => $e->getMessage(),
            ]);

            return back()->with([
                'type' => 'error',
                'message' => trans('Failed to initiate Salla connection. Please try again.'),
            ]);
        }
    }

    /**
     * Handle OAuth callback from Salla
     */
    public function callback(Request $request)
    {
        $user = Auth::user();

        if (! $user) {
            return redirect()->route('login')->with([
                'type' => 'error',
                'message' => trans('You must be logged in to complete Salla connection.'),
            ]);
        }

        // Check for OAuth error from Salla
        if ($request->has('error')) {
            $error = $request->input('error');
            $errorDescription = $request->input('error_description', trans('Unknown error'));

            Log::warning('Salla OAuth error returned', [
                'user_id' => $user->id,
                'error' => $error,
                'error_description' => $errorDescription,
            ]);

            return redirect()->route('dashboard.user.integrations.index')->with([
                'type' => 'error',
                'message' => trans('Salla authorization failed: :message', ['message' => $errorDescription]),
            ]);
        }

        // Validate required parameters
        $code = $request->input('code');
        $state = $request->input('state');

        if (! $code) {
            Log::warning('Salla OAuth callback missing authorization code', [
                'user_id' => $user->id,
            ]);

            return redirect()->route('dashboard.user.integrations.index')->with([
                'type' => 'error',
                'message' => trans('Authorization code missing. Please try connecting Salla again.'),
            ]);
        }

        if (! $state) {
            Log::warning('Salla OAuth callback missing state', [
                'user_id' => $user->id,
            ]);

            return redirect()->route('dashboard.user.integrations.index')->with([
                'type' => 'error',
                'message' => trans('OAuth state missing. Please try connecting Salla again.'),
            ]);
        }

        // Validate OAuth state
        if (! $this->oauthService->validateState($user, $state)) {
            Log::warning('Salla OAuth state validation failed', [
                'user_id' => $user->id,
            ]);

            return redirect()->route('dashboard.user.integrations.index')->with([
                'type' => 'error',
                'message' => trans('Invalid or expired OAuth state. Please try connecting Salla again.'),
            ]);
        }

        try {
            // Exchange authorization code for tokens
            $tokens = $this->oauthService->exchangeCodeForTokens($code);

            // Get user/store info from Salla
            $userInfo = $this->oauthService->getUserInfo($tokens['access_token']);

            // Wrap both writes in a transaction for consistency
            $connection = \Illuminate\Support\Facades\DB::transaction(function () use ($user, $tokens, $userInfo) {
                // Create or update connection
                $connection = $this->oauthService->createConnection($user, $tokens, $userInfo);

                // Also create ConnectedAccount record for unified integrations
                app(\App\Services\OAuth\ConnectedAccountService::class)->createOrUpdate(
                    user:              $user,
                    platform:          'salla',
                    accountIdentifier: $connection->salla_store_id,
                    accessToken:       $tokens['access_token'],
                    accountData: [
                        'name'     => $connection->store_name,
                        'username' => $connection->store_domain,
                        'avatar'   => null,
                        'metadata' => [
                            'salla_connection_id' => $connection->id,
                            'store_domain'        => $connection->store_domain,
                            'merchant_email'      => $connection->merchant_email,
                        ],
                    ],
                    refreshToken:   $tokens['refresh_token'] ?? null,
                    tokenExpiresAt: \Carbon\Carbon::createFromTimestamp($tokens['expires'] ?? now()->addDays(14)->timestamp),
                );

                return $connection;
            });

            Log::info('Salla connection created/updated successfully', [
                'user_id' => $user->id,
                'connection_id' => $connection->id,
                'salla_store_id' => $connection->salla_store_id,
            ]);

            return redirect()->route('dashboard.user.integrations.index')->with([
                'type' => 'success',
                'message' => trans('Salla store connected successfully.'),
            ]);

        } catch (RuntimeException $e) {
            Log::error('Salla OAuth callback failed', [
                'user_id' => $user->id,
                'error' => $e->getMessage(),
            ]);

            return redirect()->route('dashboard.user.integrations.index')->with([
                'type' => 'error',
                'message' => trans('Failed to connect Salla store. Please try again.'),
            ]);
        }
    }
}
