# API Integration

The API Router is the primary client integration layer for devices, readings, configuration, and mapping resources.

## Base URL

1. Local: `http://localhost:8000`
2. Local with Traefik: `http://api.localhost`

## API Documentation Endpoints

1. OpenAPI JSON: `GET /openapi.json`
2. Swagger UI: `GET /docs`
3. ReDoc: `GET /redoc`

## Integration Topics

1. [Authentication and Headers](./auth-and-headers.md)
2. [Endpoint Reference](./endpoint-reference.md)

## Device-Centric APIs Covered

1. `/devices`
2. `/device-types`
3. `/readings`
4. `/device-signals`
5. `/device-block-template-site`
6. `/api-keys` (for API key lifecycle)

