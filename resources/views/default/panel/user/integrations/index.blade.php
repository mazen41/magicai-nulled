@extends('panel.layout.app', ['disable_tblr' => true])
@section('title', __('Integrations'))
@section('titlebar_subtitle', __('Manage your connected social accounts and platform integrations'))
@section('titlebar_actions', '')

@section('content')
<div class="py-6">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6">
        @foreach ($platforms as $platformKey => $platform)
            @if ($platform['enabled'])
            <div>
                <x-card class="h-full flex flex-col justify-between">
                    @php
                        $accounts = $connectedAccounts->get($platformKey, collect());
                    @endphp

                    <div>
                        <div class="flex items-center justify-between mb-3">
                            <div class="flex items-center gap-3">
                                <div class="size-10 rounded-lg bg-gray-100 dark:bg-gray-800 p-2 flex items-center justify-center">
                                    <span class="font-bold text-lg text-primary">{{ strtoupper(substr($platform['name'], 0, 1)) }}</span>
                                </div>
                                <div>
                                    <h3 class="text-base font-semibold">{{ $platform['name'] }}</h3>
                                    <span @class([
                                        'text-xs font-medium px-2 py-0.5 rounded-full inline-block mt-0.5',
                                        'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' => $accounts->isNotEmpty() && $accounts->first()->isConnected(),
                                        'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400' => $accounts->isEmpty() || !$accounts->first()->isConnected(),
                                    ])>
                                        {{ $accounts->isNotEmpty() && $accounts->first()->isConnected() ? __('Active') : __('Not Connected') }}
                                    </span>
                                </div>
                            </div>
                            @if ($platform['connect_url'] && $platform['connect_url'] !== '#')
                                @if ($accounts->isEmpty())
                                    <x-button
                                        href="{{ $platform['connect_url'] }}"
                                        size="sm"
                                    >
                                        @lang('Connect')
                                    </x-button>
                                @else
                                    <x-button
                                        href="{{ $platform['connect_url'] }}"
                                        size="sm"
                                        variant="outline"
                                    >
                                        @lang('Reconnect')
                                    </x-button>
                                @endif
                            @endif
                        </div>

                        <p class="text-xs text-gray-500 dark:text-gray-400 mb-4">
                            {{ $platform['description'] }}
                        </p>

                        @if ($accounts->isEmpty())
                            <div class="rounded-lg border border-dashed border-gray-200 dark:border-gray-700 p-3 text-center text-xs text-gray-500">
                                @lang('No connected account')
                            </div>
                        @else
                            <div class="space-y-2">
                                @foreach ($accounts as $account)
                                    <div class="flex items-center justify-between rounded-lg border border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/50 px-3 py-2">
                                        <div class="flex items-center gap-3">
                                            @if ($account->account_avatar)
                                                <img
                                                    src="{{ custom_theme_url($account->account_avatar) }}"
                                                    class="size-8 rounded-full object-cover"
                                                    alt="{{ $account->getDisplayName() }}"
                                                />
                                            @else
                                                <div class="size-8 rounded-full bg-primary/10 flex items-center justify-center text-primary font-semibold text-xs">
                                                    {{ strtoupper(substr($account->getDisplayName(), 0, 1)) }}
                                                </div>
                                            @endif
                                            <div>
                                                <p class="font-medium text-xs text-gray-900 dark:text-gray-100">{{ $account->getDisplayName() }}</p>
                                                @if ($account->account_username)
                                                    <p class="text-[11px] text-gray-500">@{{ ltrim($account->account_username, '@') }}</p>
                                                @endif
                                            </div>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <form method="POST" action="{{ route('dashboard.user.integrations.disconnect', $account->id) }}">
                                                @csrf
                                                @method('DELETE')
                                                <x-button
                                                    type="submit"
                                                    size="xs"
                                                    variant="outline"
                                                    class="text-red-600 border-red-200 hover:bg-red-50"
                                                    onclick="return confirm('{{ __('Disconnect this account?') }}')"
                                                >
                                                    @lang('Disconnect')
                                                </x-button>
                                            </form>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        @endif
                    </div>
                </x-card>
            </div>
            @endif
        @endforeach
    </div>
</div>
@endsection
