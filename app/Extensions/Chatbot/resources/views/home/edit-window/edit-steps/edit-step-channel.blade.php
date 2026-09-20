{{-- Connected Accounts Multi-Selector --}}
<div
    class="col-start-1 col-end-1 row-start-1 row-end-1 transition-all"
    x-data="$store.connectedAccountSelector"
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
                x-model="searchQuery"
                placeholder="Search connected accounts..."
                class="lqd-input w-full"
            >
        </div>

        <!-- Account List -->
        <div class="border border-gray-200 dark:border-gray-700 rounded-lg overflow-hidden">
            <template x-if="loadingAccounts">
                <div class="p-4 text-center text-sm text-gray-500">
                    Loading...
                </div>
            </template>

            <template x-if="!loadingAccounts && filteredAccounts.length === 0">
                <div class="p-4 text-center text-sm text-gray-500">
                    @lang('No connected accounts yet.')
                    <a href="{{ route('dashboard.user.integrations.index') }}" class="text-primary underline">
                        @lang('Connect an account')
                    </a>
                </div>
            </template>

            <template x-if="!loadingAccounts && filteredAccounts.length > 0">
                <div class="max-h-64 overflow-y-auto">
                    <template x-for="account in filteredAccounts" :key="account.id">
                        <div
                            class="flex items-center gap-3 p-3 border-b border-gray-100 dark:border-gray-700 last:border-b-0 hover:bg-gray-50 dark:hover:bg-gray-800/50 cursor-pointer"
                            @click="toggleAccount(account.id)"
                        >
                            <input
                                type="checkbox"
                                :checked="selectedAccountIds.includes(account.id)"
                                @click.stop
                                class="w-4 h-4 rounded border-gray-300 text-primary focus:ring-primary"
                            >
                            <div class="flex-1 flex items-center gap-3">
                                <template x-if="account.account_avatar">
                                    <img :src="account.account_avatar" class="w-8 h-8 rounded-full object-cover">
                                </template>
                                <template x-if="!account.account_avatar">
                                    <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary font-semibold text-sm">
                                        <span x-text="account.account_name ? account.account_name.charAt(0).toUpperCase() : account.platform.charAt(0).toUpperCase()"></span>
                                    </div>
                                </template>
                                <div class="flex-1">
                                    <div class="font-medium text-sm" x-text="account.account_name"></div>
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
                <span x-text="selectedAccountIds.length"></span> accounts selected
            </span>
            <button
                @click="saveAccountSelection()"
                :disabled="savingAccount"
                class="px-4 py-2 bg-primary text-white rounded hover:bg-primary/90 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
                <template x-if="savingAccount">
                    Saving...
                </template>
                <template x-if="!savingAccount">
                    Save Connected Accounts
                </template>
            </button>
        </div>
    </div>
</div>

@push('script')
<script>
(() => {
    document.addEventListener('alpine:init', () => {
        // Register component globally as a store for better accessibility
        Alpine.store('connectedAccountSelector', () => ({
            accounts: [],
            loadingAccounts: false,
            selectedAccountIds: [],
            searchQuery: '',
            savingAccount: false,

            get filteredAccounts() {
                if (!this.searchQuery) return this.accounts;
                const query = this.searchQuery.toLowerCase();
                return this.accounts.filter(account => 
                    account.account_name?.toLowerCase().includes(query) ||
                    account.account_username?.toLowerCase().includes(query) ||
                    account.platform_label?.toLowerCase().includes(query)
                );
            },

            init() {
                this.$watch('editingStep', step => {
                    if (step === 5) this.fetchAccounts();
                });
                this.$watch('activeChatbot', chatbot => {
                    if (chatbot?.id) {
                        // Initialize from chatbot's connected_account_ids if available
                        if (chatbot.connected_account_ids && Array.isArray(chatbot.connected_account_ids)) {
                            this.selectedAccountIds = chatbot.connected_account_ids;
                        } else {
                            this.selectedAccountIds = [];
                        }
                    }
                });
            },

            async fetchAccounts() {
                this.loadingAccounts = true;
                try {
                    const res = await fetch('{{ route('dashboard.user.integrations.api.accounts') }}', {
                        headers: { 'Accept': 'application/json' }
                    });
                    const data = await res.json();
                    const platformLabels = {
                        salla: 'Salla',
                        instagram: 'Instagram',
                        messenger: 'Messenger',
                        whatsapp: 'WhatsApp',
                        telegram: 'Telegram',
                    };
                    this.accounts = (data.data || []).map(a => ({
                        ...a,
                        platform_label: platformLabels[a.platform] || a.platform,
                    }));
                } catch (e) {
                    console.error(e);
                } finally {
                    this.loadingAccounts = false;
                }
            },

            toggleAccount(accountId) {
                const index = this.selectedAccountIds.indexOf(accountId);
                if (index > -1) {
                    this.selectedAccountIds.splice(index, 1);
                } else {
                    this.selectedAccountIds.push(accountId);
                }
            },

            async saveAccountSelection() {
                if (!this.activeChatbot?.id) return;
                this.savingAccount = true;

                try {
                    const formData = new FormData();
                    this.selectedAccountIds.forEach(id => {
                        formData.append('connected_account_ids[]', id);
                    });
                    formData.append('_token', document.querySelector('meta[name="csrf-token"]').content);

                    const res = await fetch(`{{ route('api.v2.chatbot.ext.connected-account.update', ['chatbotId' => 'PLACEHOLDER']) }}`.replace('PLACEHOLDER', this.activeChatbot.id), {
                        method: 'PUT',
                        headers: { 
                            'Accept': 'application/json',
                            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content,
                        },
                        body: formData,
                    });
                    const data = await res.json();
                    if (data.status === 'success') {
                        this.activeChatbot.connected_account_ids = data.data.connected_account_ids;
                        toastr.success(data.message || '{{ __('Account selection saved.') }}');
                    } else {
                        toastr.error(data.message || '{{ __('Failed to save account selection.') }}');
                    }
                } catch (e) {
                    console.error(e);
                    toastr.error('{{ __('An error occurred.') }}');
                } finally {
                    this.savingAccount = false;
                }
            }
        }));
    });
})();
</script>
@endpush
