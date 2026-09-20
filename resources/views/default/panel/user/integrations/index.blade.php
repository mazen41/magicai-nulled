@extends('panel.layout.app', ['disable_tblr' => true])
@section('title', __('Connected Accounts'))
@section('titlebar_subtitle', __('Manage your platform integrations'))
@section('titlebar_actions', '')

@section('content')
<div class="py-10">
    @foreach ($platforms as $platformKey => $platform)
        @if ($platform['enabled'])
        <div class="mb-8">
            <x-card>
                @php
                    $accounts = $connectedAccounts->get($platformKey, collect());
                @endphp

                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center gap-3">
                        <h3 class="text-lg font-semibold">{{ $platform['name'] }}</h3>
                    </div>
                    @if ($platform['connect_url'])
                        @if ($accounts->isEmpty())
                            <x-button
                                href="{{ $platform['connect_url'] }}"
                                size="sm"
                            >
                                @lang('+ Connect') {{ $platform['name'] }}
                            </x-button>
                        @else
                            <x-button
                                href="{{ $platform['connect_url'] }}"
                                size="sm"
                                variant="outline"
                            >
                                @lang('+ Connect Another')
                            </x-button>
                        @endif
                    @endif
                </div>

                <p class="text-sm text-gray-500 dark:text-gray-400 mb-4">
                    {{ $platform['description'] }}
                </p>

                @if ($accounts->isEmpty())
                    <div class="rounded-lg border border-dashed border-gray-200 dark:border-gray-700 p-4 text-center text-sm text-gray-500">
                        @lang('No connected accounts')
                    </div>
                @else
                    <div class="space-y-3">
                        @foreach ($accounts as $account)
                            <div class="flex items-center justify-between rounded-lg border border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/50 px-4 py-3">
                                <div class="flex items-center gap-3">
                                    @if ($account->account_avatar)
                                        <img
                                            src="{{ $account->account_avatar }}"
                                            class="size-9 rounded-full object-cover"
                                            alt="{{ $account->getDisplayName() }}"
                                        />
                                    @else
                                        <div class="size-9 rounded-full bg-primary/10 flex items-center justify-center text-primary font-semibold text-sm">
                                            {{ strtoupper(substr($account->getDisplayName(), 0, 1)) }}
                                        </div>
                                    @endif
                                    <div>
                                        <p class="font-medium text-sm">{{ $account->getDisplayName() }}</p>
                                        @if ($account->account_username)
                                            <p class="text-xs text-gray-500">@{{ $account->account_username }}</p>
                                        @endif
                                    </div>
                                </div>
                                <div class="flex items-center gap-3">
                                    <span @class([
                                        'inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium',
                                        'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400' => $account->isConnected(),
                                        'bg-gray-100 text-gray-600 dark:bg-gray-700 dark:text-gray-400' => !$account->isConnected(),
                                    ])>
                                        {{ $account->isConnected() ? __('Connected') : __('Disconnected') }}
                                    </span>
                                    <form method="POST" action="{{ route('dashboard.user.integrations.disconnect', $account->id) }}">
                                        @csrf
                                        @method('DELETE')
                                        <x-button
                                            type="submit"
                                            size="xs"
                                            variant="outline"
                                            class="text-red-600 border-red-200 hover:bg-red-50"
                                            onclick="return confirm('{{ __('Disconnect this account? Chatbots using it will stop working.') }}')"
                                        >
                                            @lang('Disconnect')
                                        </x-button>
                                    </form>
                                </div>
                            </div>
                        @endforeach
                    </div>
                @endif
            </x-card>
        </div>
        @endif
    @endforeach
</div>
@endsection
