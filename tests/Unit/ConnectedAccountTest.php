<?php

namespace Tests\Unit;

use App\Models\ConnectedAccount;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ConnectedAccountTest extends TestCase
{
    use RefreshDatabase;

    private User $user;

    protected function setUp(): void
    {
        parent::setUp();
        $this->user = User::factory()->create();
    }

    public function test_encrypted_tokens_are_hidden_from_json()
    {
        $account = ConnectedAccount::create([
            'user_id' => $this->user->id,
            'platform' => 'instagram',
            'account_identifier' => '123456789',
            'account_name' => 'Test Account',
            'access_token' => 'test_token',
            'connection_status' => 'connected',
        ]);

        $json = $account->toJson();
        
        $this->assertStringNotContainsString('test_token', $json);
        $this->assertArrayNotHasKey('access_token', $account->toArray());
    }

    public function test_is_connected_returns_true_for_connected_status()
    {
        $account = ConnectedAccount::create([
            'user_id' => $this->user->id,
            'platform' => 'instagram',
            'account_identifier' => '123456789',
            'account_name' => 'Test Account',
            'connection_status' => 'connected',
        ]);

        $this->assertTrue($account->isConnected());
    }

    public function test_is_connected_returns_false_for_disconnected_status()
    {
        $account = ConnectedAccount::create([
            'user_id' => $this->user->id,
            'platform' => 'instagram',
            'account_identifier' => '123456789',
            'account_name' => 'Test Account',
            'connection_status' => 'disconnected',
        ]);

        $this->assertFalse($account->isConnected());
    }

    public function test_get_display_name_returns_account_name()
    {
        $account = ConnectedAccount::create([
            'user_id' => $this->user->id,
            'platform' => 'instagram',
            'account_identifier' => '123456789',
            'account_name' => 'Test Account',
            'connection_status' => 'connected',
        ]);

        $this->assertEquals('Test Account', $account->getDisplayName());
    }

    public function test_get_display_name_falls_back_to_username()
    {
        $account = ConnectedAccount::create([
            'user_id' => $this->user->id,
            'platform' => 'instagram',
            'account_identifier' => '123456789',
            'account_username' => 'testuser',
            'connection_status' => 'connected',
        ]);

        $this->assertEquals('testuser', $account->getDisplayName());
    }

    public function test_scope_for_user_filters_by_user_id()
    {
        $user2 = User::factory()->create();

        ConnectedAccount::create([
            'user_id' => $this->user->id,
            'platform' => 'instagram',
            'account_identifier' => '123456789',
            'account_name' => 'Account 1',
            'connection_status' => 'connected',
        ]);

        ConnectedAccount::create([
            'user_id' => $user2->id,
            'platform' => 'instagram',
            'account_identifier' => '987654321',
            'account_name' => 'Account 2',
            'connection_status' => 'connected',
        ]);

        $accounts = ConnectedAccount::forUser($this->user->id)->get();
        
        $this->assertCount(1, $accounts);
        $this->assertEquals('Account 1', $accounts->first()->account_name);
    }

    public function test_scope_for_platform_filters_by_platform()
    {
        ConnectedAccount::create([
            'user_id' => $this->user->id,
            'platform' => 'instagram',
            'account_identifier' => '123456789',
            'account_name' => 'Instagram Account',
            'connection_status' => 'connected',
        ]);

        ConnectedAccount::create([
            'user_id' => $this->user->id,
            'platform' => 'telegram',
            'account_identifier' => '987654321',
            'account_name' => 'Telegram Account',
            'connection_status' => 'connected',
        ]);

        $accounts = ConnectedAccount::forPlatform('instagram')->get();
        
        $this->assertCount(1, $accounts);
        $this->assertEquals('Instagram Account', $accounts->first()->account_name);
    }
}
