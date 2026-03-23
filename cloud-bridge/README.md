# Cloud Bridge

Cloud Bridge is the ingestion service that accepts raw device telemetry, validates it, persists readings, and publishes `READINGS.CREATED` events to NATS.

## What It Does

1. Accepts JSON telemetry with `serialNumber` in `data`.
2. Resolves the device by serial number.
3. Normalizes timestamps to UTC (device timezone -> site timezone -> UTC fallback).
4. De-duplicates readings using a deterministic hash.
5. Persists readings to Postgres.
6. Publishes contract-validated events to NATS with outbox fallback.

## Core Behaviors

1. Duplicate handling:
   1. If `allow_reading_overwrite=true` on device, duplicate hash updates existing reading.
   2. If `allow_reading_overwrite=false`, duplicate returns HTTP `409`.
2. Validation:
   1. JSON schema requires `data.serialNumber`.
   2. `serialNumber` format: `^[A-Za-z0-9_-]+$`, max length 100.
3. NATS resilience:
   1. Contract validation is required before publish.
   2. Failed publish attempts are queued in `NATSOutbox`.
   3. Background outbox processor retries pending messages.

## Endpoint Summary

1. `GET /` service info.
2. `GET /health` basic health.
3. `GET /health/nats` NATS + circuit-breaker health.
4. `POST /upload/reading` ingest one reading.
5. `POST /upload/readings/bulk` ingest many readings with partial success.
6. `GET /device/{serial_number}/info` resolve device metadata by serial number.
7. `GET /schema/device-data` return Cloud Bridge JSON validation schema.

## Related Docs

1. [Quickstart](./quickstart.md)
2. [API Reference](./api-reference.md)
3. [Data Contracts and Events](./data-contracts-and-events.md)
4. [Troubleshooting](./troubleshooting.md)

