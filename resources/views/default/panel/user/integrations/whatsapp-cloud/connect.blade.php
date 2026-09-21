@extends('panel.layout.app', ['disable_tblr' => true])
@section('title', __('Connect WhatsApp Business'))
@section('titlebar_subtitle', __('Connect via Meta Cloud API'))
@section('titlebar_back', route('dashboard.user.integrations.index'))
@section('titlebar_actions', '')

@section('content')
<div class="py-10">
    <div class="max-w-2xl mx-auto">
        <x-card class="p-6">

            {{-- Header --}}
            <div class="flex items-center gap-3 mb-6">
                <div class="size-10 rounded-lg bg-green-100 dark:bg-green-900/30 flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="size-5 text-green-600 dark:text-green-400"
                         viewBox="0 0 24 24" fill="currentColor">
                        <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15
                                 -.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463
                                 -2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606
                                 .134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371
                                 -.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51
                                 -.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016
                                 -1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487
                                 .709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719
                                 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347z"/>
                        <path d="M12 0C5.373 0 0 5.373 0 12c0 2.117.549 4.103 1.508 5.828L0 24l6.345-1.477
                                 A11.945 11.945 0 0012 24c6.627 0 12-5.373 12-12S18.627 0 12 0zm0 21.818a9.81
                                 9.81 0 01-4.994-1.368l-.358-.214-3.767.877.914-3.682-.234-.377A9.778 9.778
                                 0 012.182 12C2.182 6.575 6.575 2.182 12 2.182S21.818 6.575 21.818 12
                                 17.425 21.818 12 21.818z"/>
                    </svg>
                </div>
                <div>
                    <h2 class="text-lg font-semibold">@lang('WhatsApp Business (Cloud API)')</h2>
                    <p class="text-sm text-gray-500 dark:text-gray-400">@lang('Enter your Meta Business credentials below')</p>
                </div>
            </div>


            {{-- Session flash --}}
            @if (session('type') === 'error')
                <div class="mb-4 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
                    {{ session('message') }}
                </div>
            @endif

            {{-- Info box --}}
            <div class="mb-6 rounded-lg border border-blue-100 bg-blue-50 px-4 py-3 dark:border-blue-800 dark:bg-blue-900/20">
                <p class="text-xs text-blue-700 dark:text-blue-300 leading-relaxed">
                    @lang('You need a <strong>Meta Business Manager</strong> account with a verified WhatsApp Business account.
                    Generate a <strong>Permanent System User Token</strong> in Business Settings → System Users with
                    <code>whatsapp_business_messaging</code> and <code>whatsapp_business_management</code> permissions.')
                </p>
            </div>

            {{-- Form --}}
            <form method="POST" action="{{ route('dashboard.user.integrations.whatsapp-cloud.store') }}">
                @csrf

                {{-- Phone Number ID --}}
                <div class="mb-4">
                    <label for="phone_number_id" class="block text-sm font-medium mb-1">
                        @lang('Phone Number ID') <span class="text-red-500">*</span>
                    </label>
                    <input
                        type="text"
                        id="phone_number_id"
                        name="phone_number_id"
                        value="{{ old('phone_number_id') }}"
                        class="w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-900 dark:text-gray-100 @error('phone_number_id') border-red-400 @enderror"
                        placeholder="123456789012345"
                        required
                    />
                    @error('phone_number_id')
                        <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                    @enderror
                    <p class="mt-1 text-xs text-gray-400">@lang('Found in Meta Business Manager → WhatsApp → Phone numbers')</p>
                </div>


                {{-- WhatsApp Business Account ID --}}
                <div class="mb-4">
                    <label for="whatsapp_business_account_id" class="block text-sm font-medium mb-1">
                        @lang('WhatsApp Business Account ID') <span class="text-red-500">*</span>
                    </label>
                    <input
                        type="text"
                        id="whatsapp_business_account_id"
                        name="whatsapp_business_account_id"
                        value="{{ old('whatsapp_business_account_id') }}"
                        class="w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-900 dark:text-gray-100 @error('whatsapp_business_account_id') border-red-400 @enderror"
                        placeholder="987654321098765"
                        required
                    />
                    @error('whatsapp_business_account_id')
                        <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                    @enderror
                    <p class="mt-1 text-xs text-gray-400">@lang('Found in Meta Business Manager → WhatsApp → Settings')</p>
                </div>

                {{-- Phone Number --}}
                <div class="mb-4">
                    <label for="phone_number" class="block text-sm font-medium mb-1">
                        @lang('WhatsApp Phone Number') <span class="text-red-500">*</span>
                    </label>
                    <input
                        type="text"
                        id="phone_number"
                        name="phone_number"
                        value="{{ old('phone_number') }}"
                        class="w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-900 dark:text-gray-100 @error('phone_number') border-red-400 @enderror"
                        placeholder="+1 415 555 2671"
                        required
                    />
                    @error('phone_number')
                        <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                    @enderror
                </div>

                {{-- Display Name (optional) --}}
                <div class="mb-4">
                    <label for="display_name" class="block text-sm font-medium mb-1">
                        @lang('Display Name') <span class="text-gray-400 text-xs font-normal">(@lang('optional'))</span>
                    </label>
                    <input
                        type="text"
                        id="display_name"
                        name="display_name"
                        value="{{ old('display_name') }}"
                        class="w-full rounded-lg border border-gray-200 bg-white px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-900 dark:text-gray-100"
                        placeholder="@lang('My Store Support')"
                    />
                    <p class="mt-1 text-xs text-gray-400">@lang('Friendly label shown in Connected Accounts (auto-detected if left blank)')</p>
                </div>


                {{-- Access Token --}}
                <div class="mb-6">
                    <label for="access_token" class="block text-sm font-medium mb-1">
                        @lang('Permanent Access Token') <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                        <input
                            type="password"
                            id="access_token"
                            name="access_token"
                            class="w-full rounded-lg border border-gray-200 bg-white px-3 py-2 pr-10 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:border-gray-700 dark:bg-gray-900 dark:text-gray-100 @error('access_token') border-red-400 @enderror"
                            placeholder="EAAxxxxx..."
                            required
                            autocomplete="new-password"
                        />
                        <button
                            type="button"
                            onclick="toggleToken()"
                            class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-400 hover:text-gray-600"
                            tabindex="-1"
                        >
                            <svg id="icon-eye" xmlns="http://www.w3.org/2000/svg" class="size-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                            </svg>
                        </button>
                    </div>
                    @error('access_token')
                        <p class="mt-1 text-xs text-red-500">{{ $message }}</p>
                    @enderror
                    <p class="mt-1 text-xs text-gray-400">@lang('Create a System User token in Meta Business Settings with messaging permissions. Stored encrypted.')</p>
                </div>

                {{-- Actions --}}
                <div class="flex items-center justify-between gap-3 pt-4 border-t border-gray-100 dark:border-gray-800">
                    <a href="{{ route('dashboard.user.integrations.index') }}"
                       class="text-sm text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200">
                        ← @lang('Back to Integrations')
                    </a>
                    <x-button type="submit" variant="primary">
                        @lang('Connect WhatsApp Business')
                    </x-button>
                </div>

            </form>
        </x-card>

        {{-- Help card --}}
        <div class="mt-6 rounded-lg border border-gray-100 dark:border-gray-800 bg-gray-50 dark:bg-gray-900/50 px-5 py-4">
            <h4 class="text-sm font-medium mb-2">@lang('Where to find these credentials')</h4>
            <ol class="text-xs text-gray-500 dark:text-gray-400 space-y-1 list-decimal list-inside">
                <li>@lang('Go to <strong>business.facebook.com</strong> → your Business Manager')</li>
                <li>@lang('Navigate to <strong>Business Settings → Accounts → WhatsApp Accounts</strong>')</li>
                <li>@lang('Select your WABA — the <strong>Account ID</strong> is shown at the top')</li>
                <li>@lang('Under <strong>Phone Numbers</strong>, click a number to find its <strong>Phone Number ID</strong>')</li>
                <li>@lang('Go to <strong>Business Settings → Users → System Users</strong>')</li>
                <li>@lang('Add or select a System User → click <strong>Generate New Token</strong> with <code>whatsapp_business_messaging</code> scope')</li>
            </ol>
        </div>
    </div>
</div>

<script>
function toggleToken() {
    const field = document.getElementById('access_token');
    field.type = field.type === 'password' ? 'text' : 'password';
}
</script>
@endsection
