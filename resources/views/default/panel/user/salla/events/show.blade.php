@extends('panel.layout.app', ['disable_tblr' => true])
@section('title', __('Webhook Event').' #'.$event->id)
@section('titlebar_actions', '')
@section('titlebar_subtitle', __('Event details from:').' '.$connection->store_name ?? 'Unknown Store')

@section('content')
    <div class="py-10">
        <div class="mb-6">
            <x-button
                href="{{ route('dashboard.user.salla.events.index', $connection->id) }}"
                size="lg"
            >
                @lang('Back to Events')
            </x-button>
        </div>

        <x-card>
            <div class="space-y-6">
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Event Type')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $event->event_type }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Merchant ID')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $event->merchant_id ?? 'N/A' }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Signature Verified')
                        </p>
                        <p class="font-medium text-lg">
                            @if($event->signature_verified)
                                <span class="text-green-600 dark:text-green-400">Yes</span>
                            @else
                                <span class="text-red-600 dark:text-red-400">No</span>
                            @endif
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Processing Status')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $event->processing_status }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Received At')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $event->created_at ? $event->created_at->format('Y-m-d H:i:s') : 'N/A' }}
                        </p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600 dark:text-gray-400">
                            @lang('Processed At')
                        </p>
                        <p class="font-medium text-lg">
                            {{ $event->processed_at ? $event->processed_at->format('Y-m-d H:i:s') : 'N/A' }}
                        </p>
                    </div>
                </div>

                <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700">
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-2">
                        @lang('Payload Hash')
                    </p>
                    <p class="font-mono text-sm break-all">
                        {{ $event->payload_hash }}
                    </p>
                </div>

                <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700">
                    <p class="text-sm text-gray-600 dark:text-gray-400">
                        @lang('Note: Raw payload is not displayed for security reasons')
                    </p>
                </div>
            </div>
        </x-card>
    </div>
@endsection
