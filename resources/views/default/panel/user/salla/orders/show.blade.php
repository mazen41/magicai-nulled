@extends('panel.layout.app', ['disable_tblr' => true])
@section('title', __('Salla Order').' #'.$order->salla_order_id)
@section('titlebar_actions', '')
@section('titlebar_subtitle', __('Order details from:').' '.$connection->store_name ?? 'Unknown Store')

@section('content')
    <div class="py-10">
        <div class="mb-6">
            <x-button
                href="{{ route('dashboard.user.salla.orders.index', $connection->id) }}"
                size="lg"
            >
                @lang('Back to Orders')
            </x-button>
        </div>

        <x-card>
            <div class="space-y-6">
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Salla Order ID')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $order->salla_order_id }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Reference ID')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $order->reference_id ?? 'N/A' }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Status')
                        </p>
                        <p class="font-medium text-lg">
                            @if($order->deleted_at)
                                <span class="text-red-600 dark:text-red-400">Deleted</span>
                            @else
                                {{ $order->status_name ?? $order->status }}
                            @endif
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Currency')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $order->currency }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Total')
                        </p>
                        <p class="font-medium text-lg">
                            {{ number_format($order->total ?? 0, 2) }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Subtotal')
                        </p>
                        <p class="font-medium text-lg">
                            {{ number_format($order->sub_total ?? 0, 2) }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Shipping Cost')
                        </p>
                        <p class="font-medium text-lg">
                            {{ number_format($order->shipping_cost ?? 0, 2) }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Tax Amount')
                        </p>
                        <p class="font-medium text-lg">
                            {{ number_format($order->tax_amount ?? 0, 2) }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Payment Method')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $order->payment_method ?? 'N/A' }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Order Date')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $order->order_date ? $order->order_date->format('Y-m-d H:i:s') : 'N/A' }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Last Synced')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $order->last_synced_at ? $order->last_synced_at->format('Y-m-d H:i:s') : 'N/A' }}
                        </p>
                    </div>
                </div>

                @if($order->deleted_at)
                    <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700">
                        <p class="text-sm text-red-600 dark:text-red-400">
                            @lang('This order was deleted at:') .' '. $order->deleted_at->format('Y-m-d H:i:s')
                        </p>
                    </div>
                @endif

                <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700 flex justify-end">
                    <form action="{{ route('dashboard.user.salla.orders.refresh', [$connection->id, $order->id]) }}" method="POST">
                        @csrf
                        <x-button
                            type="submit"
                            color="blue"
                            size="lg"
                        >
                            @lang('Refresh from Salla')
                        </x-button>
                    </form>
                </div>
            </div>
        </x-card>
    </div>
@endsection
