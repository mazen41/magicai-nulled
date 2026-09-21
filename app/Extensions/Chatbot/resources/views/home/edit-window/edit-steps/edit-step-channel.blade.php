{{-- Connected Accounts Multi-Selector --}}
{{-- NOTE: No x-data here — this step inherits the parent externalChatbotEditor scope.       --}}
{{-- Channel state (channelAccounts, channelSelectedIds, etc.) is initialised in index.blade --}}
<div
    class="col-start-1 col-end-1 row-start-1 row-end-1 transition-all"
    x-show="editingStep === 5"
    x-cloak
>
    <h2 class="mb-2 text-lg font-semibold">@lang('Channel')</h2>
    <p class="mb-4 text-sm text-heading-foreground/60">
        @lang('Connect this chatbot to one or more connected accounts.')
        <a href="{{ route('dashboard.user.integrations.index') }}" class="text-primary underline">
            @lang('Manage accounts')
        </a>
    </p>

    <div class="space-y-4">
        <!-- Search -->
        <div class="relative">
            <input
                type="text"
                x-model="channelSearchQuery"
                placeholder="{{ __('Search connected accounts...') }}"
                class="lqd-input w-full"
            >
        </div>

        <!-- Account List -->
        <div class="border border-gray-200 dark:border-gray-700 rounded-lg overflow-hidden">
            <template x-if="channelLoadingAccounts">
                <div class="p-4 text-center text-sm text-gray-500">
                    @lang('Loading...')
                </div>
            </template>

            <template x-if="!channelLoadingAccounts && channelFilteredAccounts.length === 0">
                <div class="p-4 text-center text-sm text-gray-500">
                    @lang('No connected accounts yet.')
                    <a href="{{ route('dashboard.user.integrations.index') }}" class="text-primary underline">
                        @lang('Connect an account')
                    </a>
                </div>
            </template>

            <template x-if="!channelLoadingAccounts && channelFilteredAccounts.length > 0">
                <div class="max-h-64 overflow-y-auto">
                    <template x-for="account in channelFilteredAccounts" :key="account.id">
                        <div
                            class="flex items-center gap-3 p-3 border-b border-gray-100 dark:border-gray-700 last:border-b-0 hover:bg-gray-50 dark:hover:bg-gray-800/50 cursor-pointer"
                            @click="channelToggleAccount(account.id)"
                        >
                            <input
                                type="checkbox"
                                :checked="channelSelectedIds.includes(account.id)"
                                @click.stop
                                class="w-4 h-4 rounded border-gray-300 text-primary focus:ring-primary"
                            >
                            <div class="flex-1 flex items-center gap-3">
                                <template x-if="account.account_avatar">
                                    <img :src="account.account_avatar" class="w-8 h-8 rounded-full object-cover" alt="">
                                </template>
                                <template x-if="!account.account_avatar">
                                    <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary font-semibold text-sm">
                                        <span x-text="(account.account_name || account.platform || '?').charAt(0).toUpperCase()"></span>
                                    </div>
                                </template>
                                <div class="flex-1">
                                    <div class="font-medium text-sm" x-text="account.account_name || account.account_username || account.platform"></div>
                                    <div class="text-xs text-gray-500">
                                        <span x-text="account.platform_label"></span>
                                        <template x-if="account.account_username">
                                            <span x-text="' · @' + account.account_username"></span>
                                        </template>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </template>
                </div>
            </template>
        </div>

        <!-- Selection Summary & Save Button -->
        <div class="flex items-center justify-between text-sm mt-4">
            <span class="text-gray-600 dark:text-gray-400">
                <span x-text="channelSelectedIds.length"></span>&nbsp;@lang('accounts selected')
            </span>
            <button
                @click="channelSaveSelection()"
                :disabled="channelSaving"
                class="px-4 py-2 bg-primary text-white rounded hover:bg-primary/90 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                type="button"
            >
                <span x-show="channelSaving">@lang('Saving...')</span>
                <span x-show="!channelSaving">@lang('Save Connected Accounts')</span>
            </button>
        </div>
    </div>
</div>
