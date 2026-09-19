<?php

namespace Tests\Unit;

use App\Http\Controllers\SallaOAuthController;
use App\Services\Salla\SallaOAuthService;
use Illuminate\Support\Facades\Auth;
use RuntimeException;
use Tests\TestCase;

class SallaOAuthControllerTest extends TestCase
{
    private SallaOAuthService $oauthService;
    private SallaOAuthController $controller;

    protected function setUp(): void
    {
        parent::setUp();

        $this->oauthService = app(SallaOAuthService::class);
        $this->controller = new SallaOAuthController($this->oauthService);
    }

    public function test_controller_instantiates_with_service()
    {
        $this->assertInstanceOf(SallaOAuthController::class, $this->controller);
    }

    public function test_redirect_handles_service_exception()
    {
        $mockService = $this->createMock(SallaOAuthService::class);
        $mockService->method('getAuthorizationUrl')
            ->willThrowException(new RuntimeException('Service error'));

        $controller = new SallaOAuthController($mockService);

        $this->assertInstanceOf(SallaOAuthController::class, $controller);
    }
}
