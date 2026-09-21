@extends('panel.layout.app', ['disable_tblr' => true])
@section('title', __('Select WhatsApp Number'))
@section('titlebar_subtitle', __('Choose the phone number to connect'))
@section('titlebar_back', route('dashboard.user.integrations.index'))
@section('titlebar_actions', '')

@section('content')
<div class="py-10">
    <div class="max-w-2xl mx-auto">
        <x-card class="p-6">

            {{-- Header --}}
            <div class="flex items-center gap-3 mb-6">
                <div class="size-11 rounded-xl bg-green-100 dark:bg-green-900/30 flex items-center justify-center flex-shrink-0">
                    <svg xmlns="http://www.w3.org/2000/svg" class="size-6 text-green-600 dark:text-green-400" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347z"/>
                        <path d="M12 0C5.373 0 0 5.373 0 12c0 2.117.549 4.103 1.508 5.828L0 24l6.345-1.477A11.945 11.945 0 0012 24c6.627 0 12-5.373 12-12S18.627 0 12 0zm0 21.818a9.81 9.81 0 01-4.994-1.368l-.358-.214-3.767.877.914-3.682-.234-.377A9.778 9.778 0 012.182 12C2.182 6.575 6.575 2.182 12 2.182S21.818 6.575 21.818 12 17.425 21.818 12 21.818z"/>
                    </svg>
                </div>
                <div>
                    <h2 class="text-lg font-semibold">@lang('Select a WhatsApp Number')</h2>
                    <p class="text-sm text-gray-500 dark:text-gray-400">
                        @lang('We found') <strong>{{ count($phones) }}</strong> @lang('phone number(s) on your Meta account. Pick one to connect.')
                    </p>
                </div>
            </div>

            {{-- Flash error --}}
            @if (session('type') === 'error')
                <div class="mb-4 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
                    {{ session('message') }}
                </div>
            @endif

            <form method="POST" action="{{ route('dashboard.user.integrations.whatsapp-cloud.store') }}">
                @csrf
                <input type="hidden" name="pick_token" value="{{ $pick_token }}">

                <div class="space-y-2 mb-6 max-h-[480px] overflow-y-auto pr-1">
                    @foreach ($phones as $index => $phone)
                        <label class="flex items-center gap-4 p-4 rounded-xl border border-gray-200 dark:border-gray-700
                                      cursor-pointer hover:border-green-400 hover:bg-green-50 dark:hover:bg-green-900/10
                                      has-[:checked]:border-green-500 has-[:checked]:bg-green-50 dark:has-[:checked]:bg-green-900/20
                                      transition-colors duration-100">

                            <input type="radio"
                                   name="phone_number_id"
                                   value="{{ $phone['phone_number_id'] }}"
                                   class="accent-green-500 size-4 flex-shrink-0"
                                   {{ $index === 0 ? 'checked' : '' }}
                                   required>

                            {{-- WhatsApp icon --}}
                            <div class="size-9 rounded-full bg-green-100 dark:bg-green-900/40 flex items-center justify-center flex-shrink-0">
                                <svg xmlns="http://www.w3.org/2000/svg" class="size-4 text-green-600 dark:text-green-400" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347z"/>
                                    <path d="M12 0C5.373 0 0 5.373 0 12c0 2.117.549 4.103 1.508 5.828L0 24l6.345-1.477A11.945 11.945 0 0012 24c6.627 0 12-5.373 12-12S18.627 0 12 0zm0 21.818a9.81 9.81 0 01-4.994-1.368l-.358-.214-3.767.877.914-3.682-.234-.377A9.778 9.778 0 012.182 12C2.182 6.575 6.575 2.182 12 2.182S21.818 6.575 21.818 12 17.425 21.818 12 21.818z"/>
                                </svg>
                            </div>

                            {{-- Details --}}
                            <div class="flex-1 min-w-0">
                                <p class="text-sm font-semibold text-gray-800 dark:text-gray-100 truncate">
                                    {{ $phone['verified_name'] ?: ($phone['waba_name'] ?: 'WhatsApp Business') }}
                                </p>
                                <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                                    {{ $phone['phone_number'] ?: __('No phone number') }}
                                </p>
                                <p class="text-[10px] text-gray-400 dark:text-gray-500 mt-0.5 font-mono">
                                    WABA: {{ $phone['waba_id'] }} &nbsp;·&nbsp; Phone ID: {{ $phone['phone_number_id'] }}
                                </p>
                            </div>

                            {{-- Check indicator --}}
                            <div class="flex-shrink-0 size-5 rounded-full border-2 border-gray-300 dark:border-gray-600
                                        flex items-center justify-center
                                        group-has-[:checked]:border-green-500 group-has-[:checked]:bg-green-500">
                            </div>
                        </label>
                    @endforeach
                </div>

                {{-- Actions --}}
                <div class="flex items-center justify-between gap-3 pt-4 border-t border-gray-100 dark:border-gray-800">
                    <a href="{{ route('dashboard.user.integrations.index') }}"
                       class="text-sm text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200">
                        ← @lang('Cancel')
                    </a>
                    <button type="submit"
                            class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl bg-green-500 hover:bg-green-600
                                   text-white text-sm font-semibold transition-colors duration-150 shadow-sm">
                        <svg xmlns="http://www.w3.org/2000/svg" class="size-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1"/>
                        </svg>
                        @lang('Connect Selected Number')
                    </button>
                </div>
            </form>

        </x-card>
    </div>
</div>
@endsection
