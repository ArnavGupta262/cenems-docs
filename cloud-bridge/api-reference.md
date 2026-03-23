# Cloud Bridge API Reference

Base URL (local stack): `http://localhost:8015`

Security note: Cloud Bridge endpoints in this repo are currently unauthenticated at service layer. Deploy behind gateway/network controls in production.

## Health and Metadata

## `GET /`

Returns:

```json
{
  "message": "CENEMS Cloud Bridge",
  "version": "1.0.0",
  "status": "ready"
}
```

## `GET /health`

Returns:

```json
{
  "status": "healthy",
  "service": "cloud-bridge"
}
```

## `GET /health/nats`

Returns NATS and circuit-breaker status:

1. `connected`
2. `circuit_breaker_state`
3. `failure_count`
4. `last_failure_time`
5. `contract_validation_failures`
6. `overall_status` (`healthy` or `degraded`)

## Ingestion Endpoints

## `POST /upload/reading`

Request body:

```json
{
  "timestamp": "2026-03-23T10:30:00Z",
  "source_tag": "default",
  "data": {
    "serialNumber": "SN_ABC_1001",
    "power_kw": 25.5
  }
}
```

Notes:

1. `timestamp` accepts timezone-aware or naive values.
2. Naive timestamps are interpreted using:
   1. Device timezone in `device.attributes.timezone`.
   2. Site timezone.
   3. UTC fallback.
3. `data.serialNumber` is required.
4. All additional fields in `data` are accepted.

Success response (`200`): `DataUploadResponse`

1. `success`
2. `message`
3. `reading_id`
4. `device_id`
5. `site_id`
6. `org_id`

Common errors:

1. `422` schema/body validation errors.
2. `404` unknown serial number.
3. `409` duplicate blocked by `allow_reading_overwrite=false`.
4. `500` internal server error.

## `POST /upload/readings/bulk`

Request body:

```json
{
  "readings": [
    {
      "timestamp": "2026-03-23T10:30:00Z",
      "source_tag": "default",
      "data": {
        "serialNumber": "SN_ABC_1001",
        "power_kw": 25.5
      }
    }
  ]
}
```

Constraints:

1. `readings` cannot be empty.
2. Maximum 1000 readings per request.
3. Response is always summary + per-item results (partial success model).

Response (`200`):

1. `summary.total`
2. `summary.successful`
3. `summary.failed`
4. `results[]` each containing `success`, `message`, `reading_index`, and optional IDs.

## Device and Schema Helpers

## `GET /device/{serial_number}/info`

Returns:

1. `device_id`
2. `serial_number`
3. `name`
4. `manufacturer`
5. `model`
6. `site_id`
7. `site_name`
8. `org_id`

## `GET /schema/device-data`

Returns Cloud Bridge JSON schema for `data` payload validation.  
Current minimum requirement: `serialNumber` string with allowed characters `[A-Za-z0-9_-]`.

## Data Model Notes

1. Readings are stored with:
   1. `source = "cloud-bridge"`
   2. `imported = true`
   3. `dedup_hash` for uniqueness.
2. Duplicate detection key is based on:
   1. `device_id`
   2. `serial_number`
   3. normalized UTC timestamp.
