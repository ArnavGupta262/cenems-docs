# Cloud Bridge API Reference

Base URL: `https://cloud-bridge.central-ems.com`

## Health and Metadata

### `GET /`

Returns service metadata:

```json
{
  "message": "CENEMS Cloud Bridge",
  "version": "1.0.0",
  "status": "ready"
}
```

### `GET /health`

```json
{
  "status": "healthy",
  "service": "cloud-bridge"
}
```

### `GET /health/nats`

Returns NATS health and circuit-breaker state with `overall_status` (`healthy` or `degraded`).

## Ingestion

### `POST /upload/reading`

Request body model:

- `timestamp` (ISO datetime)
- `source_tag` (optional)
- `data` object (must include `serialNumber`)

Success: `200`

Common errors:

- `400` schema validation failed
- `404` serial number not found
- `409` duplicate blocked when overwrite is disabled
- `500` internal processing failure

### `POST /upload/readings/bulk`

Request body:

- `readings[]` where each item matches single-upload model

Constraints:

- minimum 1 reading
- maximum 1000 readings

Response includes:

- `summary.total`
- `summary.successful`
- `summary.failed`
- `results[]` with per-item status and messages

## Device/Schema Helpers

### `GET /device/{serial_number}/info`

Returns resolved device/site/org context for a serial number.

### `GET /schema/device-data`

Returns the current JSON schema for `data` payload validation.
