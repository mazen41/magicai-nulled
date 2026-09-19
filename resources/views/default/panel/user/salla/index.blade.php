@extends('panel.layout.app', ['disable_tblr' => true])
@section('title', __('Salla Integration'))
@section('titlebar_actions', '')
@section('titlebar_subtitle', __('Manage your Salla store connections'))

@section('content')
    <div class="py-10">
        <div class="mb-6">
            <x-button
                href="{{ route('dashboard.user.salla.connect') }}"
                size="lg"
            >
                @lang('Connect Salla Store')
            </x-button>
        </div>

        @if ($connections->isEmpty())
            <x-empty-state
                title="No Salla connections"
                subtitle="Connect your Salla store to enable ecommerce features"
            />
        @else
            <div class="space-y-4">
                @foreach ($connections as $connection)
                    <x-card>
                        <div class="flex items-center justify-between">
                            <div>
                                <h3 class="text-lg font-semibold mb-1">
                                    {{ $connection->store_name ?? 'Unknown Store' }}
                                </h3>
                                @if ($connection->store_domain)
                                    <p class="text-sm text-gray-600 dark:text-gray-400">
                                        {{ $connection->store_domain }}
                                    </p>
                                @endif
                                @if ($connection->merchant_email)
                                    <p class="text-sm text-gray-600 dark:text-gray-400">
                                        {{ $connection->merchant_email }}
                                    </p>
                                @endif
                            </div>
                            <div class="text-right">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium @if($connection->connection_status === 'connected') bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400 @else bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-400 @endif">
                                    @if($connection->connection_status === 'connected')
                                        Connected
                                    @else
                                        Disconnected
                                    @endif
                                </span>
                            </div>
                        </div>

                        <div class="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700">
                            <div class="grid grid-cols-2 gap-4 text-sm">
                                <div>
                                    <p class="text-gray-600 dark:text-gray-400">
                                        @lang('Connection Status')
                                    </p>
                                    <p class="font-medium">
                                        @if($connection->connection_status === 'connected')
                                            <span class="text-green-600 dark:text-green-400">Connected</span>
                                        @elseif($connection->connection_status === 'error')
                                            <span class="text-red-600 dark:text-red-400">Error</span>
                                        @else
                                            <span class="text-gray-600 dark:text-gray-400">Disconnected</span>
                                        @endif
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-600 dark:text-gray-400">
                                        @lang('Webhook Status')
                                    </p>
                                    <p class="font-medium">
                                        @if($connection->webhook_status === 'active')
                                            <span class="text-green-600 dark:text-green-400">Active</span>
                                        @else
                                            <span class="text-gray-600 dark:text-gray-400">Inactive</span>
                                        @endif
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-600 dark:text-gray-400">
                                        @lang('Connected At')
                                    </p>
                                    <p class="font-medium">
                                        {{ $connection->connected_at ? $connection->connected_at->format('Y-m-d H:i') : 'N/A' }}
                                    </p>
                                </div>
                                <div>
                                    <p class="text-gray-600 dark:text-gray-400">
                                        @lang('Last Synced')
                                    </p>
                                    <p class="font-medium">
                                        {{ $connection->last_synced_at ? $connection->last_synced_at->format('Y-m-d H:i') : 'N/A' }}
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700 flex justify-between items-center">
                            <div class="flex gap-2">
                                <form action="{{ route('dashboard.user.salla.test', $connection->id) }}" method="POST">
                                    @csrf
                                    <x-button
                                        type="submit"
                                        color="blue"
                                        size="sm"
                                    >
                                        @lang('Test Connection')
                                    </x-button>
                                </form>
                                @if($connection->connection_status === 'connected')
                                    <x-button
                                        href="{{ route('dashboard.user.salla.orders.index', $connection->id) }}"
                                        color="gray"
                                        size="sm"
                                    >
                                        @lang('Orders')
                                    </x-button>
                                    <x-button
                                        href="{{ route('dashboard.user.salla.events.index', $connection->id) }}"
                                        color="gray"
                                        size="sm"
                                    >
                                        @lang('Webhook Events')
                                    </x-button>
                                @endif
                            </div>
                            <form action="{{ route('dashboard.user.salla.disconnect', $connection->id) }}" method="POST">
                                @csrf
                                @method('DELETE')
                                <x-button
                                    type="submit"
                                    color="red"
                                    size="sm"
                                >
                                    @lang('Disconnect')
                                </x-button>
                            </form>
                        </div>
                    </x-card>
                @endforeach
            </div>
        @endif
    </div>
@endsection
