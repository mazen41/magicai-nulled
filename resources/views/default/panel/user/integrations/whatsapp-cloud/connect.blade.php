@extends('panel.layout.app', ['disable_tblr' => true])
@section('title', __('Connect WhatsApp Business'))
@section('titlebar_subtitle', __('Connect via Meta Embedded Signup'))
@section('titlebar_back', route('dashboard.user.integrations.index'))
@section('titlebar_actions', '')

@section('content')
<div class="py-10">
    <div class="max-w-xl mx-auto">
        <x-card class="p-8">

            {{-- Header --}}
            <div class="flex items-center gap-3 mb-6">
                <div class="size-11 rounded-xl bg-green-100 dark:bg-green-900/30 flex items-center justify-center flex-shrink-0">
                    <svg xmlns="http://www.w3.org/2000/svg" class="size-6 text-green-600 dark:text-green-400"
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
                    <h2 class="text-lg font-semibold">@lang('WhatsApp Business')</h2>
                    <p class="text-sm text-gray-500 dark:text-gray-400">@lang('Connect your Meta Business account in one click')</p>
                </div>
            </div>

            {{-- Session flash --}}
            @if (session('type') === 'error')
                <div class="mb-5 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
                    {{ session('message') }}
                </div>
            @endif

            {{-- How it works info box --}}
            <div class="mb-7 rounded-xl border border-blue-100 bg-blue-50 px-5 py-4 dark:border-blue-800 dark:bg-blue-900/20">
                <p class="text-xs font-semibold text-blue-700 dark:text-blue-300 mb-2 uppercase tracking-wide">
                    @lang('How it works')
                </p>
                <ol class="space-y-1.5 text-xs text-blue-700 dark:text-blue-300 list-none">
                    <li class="flex items-start gap-2">
                        <span class="mt-0.5 flex-shrink-0 size-4 rounded-full bg-blue-200 dark:bg-blue-700 flex items-center justify-center text-[10px] font-bold">1</span>
                        @lang('Click <strong>Continue with Meta</strong> below')
                    </li>
                    <li class="flex items-start gap-2">
                        <span class="mt-0.5 flex-shrink-0 size-4 rounded-full bg-blue-200 dark:bg-blue-700 flex items-center justify-center text-[10px] font-bold">2</span>
                        @lang('Log in to Meta and select your <strong>Business Account</strong> and <strong>WhatsApp phone number</strong>')
                    </li>
                    <li class="flex items-start gap-2">
                        <span class="mt-0.5 flex-shrink-0 size-4 rounded-full bg-blue-200 dark:bg-blue-700 flex items-center justify-center text-[10px] font-bold">3</span>
                        @lang('You\'ll be redirected back automatically — no tokens to copy or paste')
                    </li>
                </ol>
            </div>

            {{-- CTA Button --}}
            <a href="{{ route('dashboard.user.integrations.whatsapp-cloud.connect') }}"
               class="flex items-center justify-center gap-3 w-full rounded-xl bg-[#25D366] hover:bg-[#1ebe5d] active:bg-[#17a550]
                      text-white font-semibold text-sm px-5 py-3.5 transition-colors duration-150 shadow-sm">
                {{-- WhatsApp icon --}}
                <svg xmlns="http://www.w3.org/2000/svg" class="size-5 flex-shrink-0" viewBox="0 0 24 24" fill="currentColor">
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
                @lang('Continue with Meta')
            </a>

            {{-- Security note --}}
            <p class="mt-4 text-center text-xs text-gray-400 dark:text-gray-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="inline size-3.5 mb-0.5 mr-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                </svg>
                @lang('Your credentials are encrypted and never exposed.')
            </p>

            {{-- Back link --}}
            <div class="mt-6 pt-5 border-t border-gray-100 dark:border-gray-800 text-center">
                <a href="{{ route('dashboard.user.integrations.index') }}"
                   class="text-sm text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200">
                    ← @lang('Back to Integrations')
                </a>
            </div>

        </x-card>

        {{-- Requirements card --}}
        <div class="mt-5 rounded-xl border border-gray-100 dark:border-gray-800 bg-gray-50 dark:bg-gray-900/50 px-5 py-4">
            <h4 class="text-sm font-medium mb-2">@lang('Requirements')</h4>
            <ul class="text-xs text-gray-500 dark:text-gray-400 space-y-1 list-disc list-inside">
                <li>@lang('A <strong>Meta Business Manager</strong> account')</li>
                <li>@lang('A verified <strong>WhatsApp Business</strong> phone number')</li>
                <li>@lang('<code>whatsapp_business_messaging</code> and <code>whatsapp_business_management</code> permissions on your Meta App')</li>
            </ul>
        </div>
    </div>
</div>
@endsection
