<?php

namespace Tests\Unit;

use App\Services\OAuth\OAuthStateService;
use Illuminate\Support\Facades\Cache;
use Tests\TestCase;

class OAuthStateServiceTest extends TestCase
{
    private OAuthStateService $service;

    protected function setUp(): void
    {
        parent::setUp();
        $this->service = new OAuthStateService();
        Cache::flush();
    }

    public function test_generate_creates_cryptographically_random_state()
    {
        $state1 = $this->service->generate('instagram', 1);
        $state2 = $this->service->generate('instagram', 1);

        $this->assertNotEquals($state1, $state2);
        $this->assertMatchesRegularExpression('/^[a-f0-9]{64}$/', $state1);
    }

    public function test_validate_with_correct_state()
    {
        $state = $this->service->generate('instagram', 1);
        $this->assertTrue($this->service->validate('instagram', 1, $state));
    }

    public function test_validate_with_incorrect_state()
    {
        $this->service->generate('instagram', 1);
        $this->assertFalse($this->service->validate('instagram', 1, 'invalid_state'));
    }

    public function test_validate_with_wrong_user()
    {
        $state = $this->service->generate('instagram', 1);
        $this->assertFalse($this->service->validate('instagram', 2, $state));
    }

    public function test_validate_with_wrong_platform()
    {
        $state = $this->service->generate('instagram', 1);
        $this->assertFalse($this->service->validate('messenger', 1, $state));
    }

    public function test_validate_is_single_use()
    {
        $state = $this->service->generate('instagram', 1);
        
        $this->assertTrue($this->service->validate('instagram', 1, $state));
        $this->assertFalse($this->service->validate('instagram', 1, $state));
    }

    public function test_simultaneous_oauth_states_do_not_collide()
    {
        $state1 = $this->service->generate('instagram', 1);
        $state2 = $this->service->generate('instagram', 1);
        $state3 = $this->service->generate('instagram', 1);

        $this->assertNotEquals($state1, $state2);
        $this->assertNotEquals($state2, $state3);
        $this->assertNotEquals($state1, $state3);

        // All should validate independently
        $this->assertTrue($this->service->validate('instagram', 1, $state1));
        $this->assertTrue($this->service->validate('instagram', 1, $state2));
        $this->assertTrue($this->service->validate('instagram', 1, $state3));
    }

    public function test_expired_state_cannot_be_validated()
    {
        $state = $this->service->generate('instagram', 1);
        
        // Manually expire the state
        Cache::forget("oauth_state_{$state}");
        
        $this->assertFalse($this->service->validate('instagram', 1, $state));
    }
}
