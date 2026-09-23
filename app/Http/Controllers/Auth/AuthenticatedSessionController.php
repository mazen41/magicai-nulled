<?php

namespace App\Http\Controllers\Auth;

use App\Actions\EmailConfirmation;
use App\Events\UsersActivityEvent;
use App\Helpers\Classes\Helper;
use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Mail\OtpEmail;
use App\Models\Setting;
use App\Models\User;
use Exception;
use Google2FA;
use GuzzleHttp\Client;
use Igaster\LaravelTheme\Facades\Theme;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Illuminate\View\View;

class AuthenticatedSessionController extends Controller
{
    /**
     * Display the login view.
     */
    public function create(): View
    {
        if (setting('dash_theme') === 'social-media-agent-dashboard') {
            Theme::set('social-media-agent-dashboard');
        }

        return view('panel.authentication.login', [
            'plan'     => request('plan'),
            'redirect' => request('redirect'),
        ]);
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request): JsonResponse
    {
        \Log::info('[LOGIN] Login attempt started', [
            'email' => $request->email,
            'ip' => $request->ip(),
            'has_csrf' => $request->hasHeader('X-CSRF-TOKEN'),
            'csrf_token' => $request->header('X-CSRF-TOKEN'),
        ]);

        $settings = Setting::getCache();
        $email = $request->email;
        $user = User::where('email', $email)->first();

        \Log::info('[LOGIN] User lookup', [
            'user_found' => $user ? 'YES' : 'NO',
            'user_id' => $user?->id,
        ]);

        if ($settings->recaptcha_login && ($settings->recaptcha_sitekey || $settings->recaptcha_secretkey)) {
            \Log::info('[LOGIN] Recaptcha check enabled');
            $response = (new Client)->post('https://www.google.com/recaptcha/api/siteverify', [
                'form_params' => [
                    'secret'   => config('services.recaptcha.secret'),
                    'response' => $request->input('g-recaptcha-response'),
                ],
            ])->getBody()->getContents();

            if (! json_decode($response, true)['success']) {
                \Log::warning('[LOGIN] Recaptcha failed');
                return response()->json(['status' => 'error', 'message' => __('Invalid Recaptcha.')], 401);
            }
        }

        if ($settings->login_without_confirmation == 0) {
            \Log::info('[LOGIN] Email confirmation required', [
                'user_confirmed' => $user?->email_confirmed,
                'is_admin' => $user?->isAdmin(),
            ]);
            
            if (! $user) {
                \Log::warning('[LOGIN] User not found');
                return response()->json(['errors' => [trans('auth.failed')]], 401);
            }

            if (! $user->email_confirmed && ! $user->isAdmin()) {
                \Log::info('[LOGIN] Sending confirmation email');
                EmailConfirmation::forUser($user)->send();

                return response()->json([
                    'errors' => [__('We have sent you an email for account confirmation. Please confirm your account to continue. Please check spam folder. If not received, try login again after 1 hour.')],
                    'type'   => 'confirmation',
                ], 401);
            }
        }

        if ($settings->login_with_otp) {
            \Log::info('[LOGIN] OTP login enabled');
            
            if (! $user) {
                \Log::warning('[LOGIN] User not found for OTP');
                return response()->json(['errors' => [trans('auth.failed')]], 401);
            }

            $otp = random_int(1000, 9999);
            $user->update(['otp' => $otp]); // One DB write instead of save()

            try {
                Mail::to($user->email)->send(new OtpEmail($user, $settings, $otp));
                \Log::info('[LOGIN] OTP email sent');
            } catch (Exception $e) {
                \Log::error('[LOGIN] OTP email failed', ['error' => $e->getMessage()]);
                return response()->json(['errors' => [__('Email could not be sent.')], 'type' => 'error'], 401);
            }

            return response()->json(['link' => '/verify-otp']);
        }

        \Log::info('[LOGIN] Attempting authentication');
        $request->authenticate();
        $request->session()->regenerate();

        \Log::info('[LOGIN] Authentication successful', [
            'auth_check' => Auth::check(),
        ]);

        if (Auth::check()) {
            $user = Auth::user();

            \Log::info('[LOGIN] User authenticated', [
                'user_id' => $user->id,
                'email' => $user->email,
                'is_admin' => $user->isAdmin(),
            ]);

            if (Google2FA::isActivated()) {
                \Log::info('[LOGIN] 2FA enabled, redirecting to 2FA');
                session(['user_id' => $user->id]);
                Auth::logout();

                return response()->json(['link' => '2fa/login']);
            }

            event(new UsersActivityEvent($user->email, $user->type, $request->header('User-Agent')));
            \Log::info('[LOGIN] Activity event fired');
        }

        if ((setting('frontend_additional_url_type') !== 'ai-image-pro') && (setting('dash_theme') === 'social-media-agent-dashboard')) {
            \Log::info('[LOGIN] Redirecting to social media agent dashboard');
            return response()->json([
                'link' => '/dashboard/user/social-media/agent',
            ]);
        }

        $redirect = $request->get('redirect');
        $redirectUrl = $this->getRedirectUrl($redirect, $request->get('plan'));

        \Log::info('[LOGIN] Determining redirect', [
            'redirect_param' => $redirect,
            'plan_param' => $request->get('plan'),
            'redirect_url' => $redirectUrl,
        ]);

        $response = response()->json(['link' => $redirectUrl]);
        
        \Log::info('[LOGIN] Response sent', [
            'status' => $response->status(),
            'headers' => $response->headers->all(),
        ]);

        \Log::info('[LOGIN] Session data after login', [
            'session_id' => session()->getId(),
            'has_auth_user' => session()->has('_token'),
            'session_all' => session()->all(),
        ]);

        return $response;
    }

    /**
     * Get the redirect URL based on the redirect parameter
     */
    private function getRedirectUrl(?string $redirect, ?string $plan): string
    {
        // Define your redirect mappings
        $redirectMap = [
            'chatPro'      => '/chat',
            'chatProImage' => '/ai-chat-image/chat',
            'aiImagePro'   => '/dashboard/user/ai-image-pro',
            // Add more redirects as needed
        ];

        // If redirect parameter exists and is mapped
        if ($redirect && isset($redirectMap[$redirect])) {
            if ($redirect === 'aiImagePro' && ! Helper::appIsDemo()) {
                // Non-demo environments should follow the normal dashboard flow.
                $redirect = null;
            } else {
                return $redirectMap[$redirect];
            }
        }

        // Default behavior (existing logic)
        if (setting('hard_redirect_to_user_dashboard', '0') === '0' && Auth::user()?->isAdmin()) {
            return $plan ? '/dashboard/user/payment?plan=' . $plan : '/dashboard/admin';
        }

        return $plan ? '/dashboard/user/payment?plan=' . $plan : '/dashboard/user';
    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): RedirectResponse
    {
        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('/');
    }

    public function verifyOtpCode()
    {
        return view('panel.authentication.otp_verify');
    }

    public function verifyOtp(Request $request)
    {
        $request->validate([
            'otp' => 'required|array',
        ]);

        $otp = implode('', $request->get('otp'));

        $user = User::query()->where('otp', $otp)->first();

        if (! $user) {
            return response()->json([
                'errors' => [__('Invalid OTP Code')],
                'type'   => 'otp',
            ], 422);
        }

        $user->otp = null;
        $user->save();

        Auth::login($user);
        $request->session()->regenerate();

        return response()->json([
            'link' => '/dashboard',
        ]);
    }
}
