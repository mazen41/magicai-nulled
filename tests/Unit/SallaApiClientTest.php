<?php

namespace Tests\Unit;

use App\Models\SallaConnection;
use App\Services\Salla\SallaApiClient;
use App\Services\Salla\SallaOAuthService;
use Illuminate\Support\Facades\Http;
use RuntimeException;
use Tests\TestCase;

class SallaApiClientTest extends TestCase
{
    private SallaConnection $connection;
    private SallaOAuthService $oauthService;
    private SallaApiClient $client;

    protected function setUp(): void
    {
        parent::setUp();

        $this->connection = new SallaConnection([
            'id' => 1,
            'user_id' => 1,
            'salla_store_id' => 'test-store',
            'store_name' => 'Test Store',
            'connection_status' => 'connected',
        ]);

        $this->oauthService = $this->createMock(SallaOAuthService::class);
        $this->client = new SallaApiClient($this->connection, $this->oauthService);
    }

    public function test_client_instantiates_with_connection_and_service()
    {
        $this->assertInstanceOf(SallaApiClient::class, $this->client);
    }

    public function test_get_sends_bearer_authentication()
    {
        $this->oauthService->method('getValidAccessToken')
            ->willReturn('test-access-token');

        Http::fake([
            'https://api.salla.dev/admin/v2/test-endpoint' => Http::response(['data' => 'test'], 200),
        ]);

        $result = $this->client->get('test-endpoint');

        Http::assertSent(function ($request) {
            return $request->hasHeader('Authorization', 'Bearer test-access-token')
                && $request->hasHeader('Accept', 'application/json')
                && $request->hasHeader('Content-Type', 'application/json');
        });

        $this->assertEquals(['data' => 'test'], $result);
    }

    public function test_base_url_is_used_correctly()
    {
        $this->oauthService->method('getValidAccessToken')
            ->willReturn('test-access-token');

        Http::fake([
            'https://api.salla.dev/admin/v2/products' => Http::response(['data' => 'test'], 200),
        ]);

        $this->client->get('products');

        Http::assertSent(function ($request) {
            return $request->url() === 'https://api.salla.dev/admin/v2/products';
        });
    }

    public function test_query_parameters_are_passed_correctly()
    {
        $this->oauthService->method('getValidAccessToken')
            ->willReturn('test-access-token');

        Http::fake([
            'https://api.salla.dev/admin/v2/products*page=1' => Http::response(['data' => 'test'], 200),
        ]);

        $this->client->get('products', ['page' => 1]);

        Http::assertSent(function ($request) {
            return $request->url() === 'https://api.salla.dev/admin/v2/products?page=1';
        });
    }

    public function test_post_sends_json_data()
    {
        $this->oauthService->method('getValidAccessToken')
            ->willReturn('test-access-token');

        Http::fake([
            'https://api.salla.dev/admin/v2/test-endpoint' => Http::response(['data' => 'test'], 200),
        ]);

        $this->client->post('test-endpoint', ['name' => 'Test Product']);

        Http::assertSent(function ($request) {
            return $request->isJson()
                && $request->data()['name'] === 'Test Product';
        });
    }

    public function test_failed_http_response_is_handled_safely()
    {
        $this->oauthService->method('getValidAccessToken')
            ->willReturn('test-access-token');

        Http::fake([
            'https://api.salla.dev/admin/v2/test-endpoint' => Http::response(['error' => 'Not found'], 404),
        ]);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Salla API request failed: HTTP 404');

        $this->client->get('test-endpoint');
    }

    public function test_token_is_obtained_through_oauth_service()
    {
        $this->oauthService->expects($this->once())
            ->method('getValidAccessToken')
            ->with($this->connection)
            ->willReturn('test-access-token');

        Http::fake([
            'https://api.salla.dev/admin/v2/test-endpoint' => Http::response(['data' => 'test'], 200),
        ]);

        $this->client->get('test-endpoint');
    }

    public function test_credentials_do_not_appear_in_exception_messages()
    {
        $this->oauthService->method('getValidAccessToken')
            ->willReturn('secret-token-12345');

        Http::fake([
            'https://api.salla.dev/admin/v2/test-endpoint' => Http::response(['error' => 'Unauthorized'], 401),
        ]);

        try {
            $this->client->get('test-endpoint');
            $this->fail('Expected RuntimeException was not thrown');
        } catch (RuntimeException $e) {
            $message = $e->getMessage();
            $this->assertStringNotContainsString('secret-token-12345', $message);
            $this->assertStringNotContainsString('Bearer', $message);
        }
    }

    public function test_endpoint_normalization_prevents_double_slashes()
    {
        $this->oauthService->method('getValidAccessToken')
            ->willReturn('test-access-token');

        Http::fake([
            'https://api.salla.dev/admin/v2/products' => Http::response(['data' => 'test'], 200),
        ]);

        $this->client->get('/products');

        Http::assertSent(function ($request) {
            // Should be https://api.salla.dev/admin/v2/products, not .../admin/v2//products
            return ! str_contains($request->url(), '//products');
        });
    }
}
