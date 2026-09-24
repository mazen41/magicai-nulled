@php
    use Illuminate\Support\Str;
    // Build a keyed map of connected platforms for O(1) lookup
    $connectedMap = collect($userPlatforms ?? [])->keyBy('platform');
@endphp

<div class="lqd-social-media-cards-grid mt-10 grid grid-cols-1 gap-5 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5">
    @foreach ($platforms as $platform)
        @php
            $image = 'vendor/social-media/icons/' . $platform->value . '.svg';
            $image_dark_version = 'vendor/social-media/icons/' . $platform->value . '-mono-light.svg';
            $connectedAccount = $connectedMap->get($platform->value);
            $isConnected = $connectedAccount && $connectedAccount->isConnected();
            $displayName = $isConnected
                ? (data_get($connectedAccount->credentials, 'name')
                    ?? data_get($connectedAccount->credentials, 'username')
                    ?? data_get($connectedAccount->credentials, 'display_name')
                    ?? $connectedAccount->username())
                : null;
        @endphp
        <x-card
            class="lqd-social-media-card flex flex-col text-heading-foreground transition-all hover:scale-105 hover:border-heading-foreground/10 hover:shadow-lg hover:shadow-black/5"
            class:body="flex flex-col"
        >
            <figure class="mb-8 w-8 transition-all group-hover/card:scale-125">
                <img
                    class="h-auto w-full dark:hidden"
                    src="{{ asset($image) }}"
                    alt="{{ $platform->label() }}"
                />
                <img
                    class="hidden h-auto w-full dark:block"
                    src="{{ asset($image_dark_version) }}"
                    alt="{{ $platform->label() }}"
                />
            </figure>
            <h4 class="mb-2 text-lg text-inherit">
                {{ $platform->label() }}
            </h4>

            @if ($isConnected)
                <span class="mb-1 text-xs font-medium text-green-500">&#10003; @lang('Connected')</span>
                <span class="relative z-10 mb-2 text-sm opacity-80">{{ $displayName }}</span>
                <a
                    class="relative z-10 text-xs opacity-60 hover:opacity-100"
                    target="_blank"
                    href="{{ route('social-media.oauth.connect.'.$platform->value) }}?extension=agent"
                >
                    @lang('Reconnect')
                </a>
            @else
                <a
                    class="relative z-10 opacity-70"
                    target="_blank"
                    href="{{ route('social-media.oauth.connect.'.$platform->value) }}?extension=agent"
                >
                    @lang('Add New Account')
                </a>
            @endif

            <a
                class="absolute inset-0 z-2 inline-block"
                target="_blank"
                href="{{ route('social-media.oauth.connect.'.$platform->value) }}?extension=agent"
            ></a>
        </x-card>
    @endforeach
</div>
