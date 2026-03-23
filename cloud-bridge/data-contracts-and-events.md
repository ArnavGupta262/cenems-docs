# Cloud Bridge Data Contracts and Events

Cloud Bridge emits `READINGS.CREATED` events after successful ingestion.

## Contract Identity

From `contracts/catalog.yaml`:

1. Contract ID: `readings.created`
2. Owner: `cloud-bridge`
3. Active version: `1.1.0`

Cloud Bridge includes:

1. `contract_name`
2. `contract_version`
3. envelope fields: `event_type`, `event_id`, `timestamp`, `data`

before publishing.

## NATS Subject

Publish subject pattern:

1. `<readings_subject_prefix>.<event_type>`
2. Default prefix is `READINGS`
3. Created event emits to `READINGS.CREATED`

## Event Payload (`readings.created@1.1.0`)

Envelope:

1. `contract_name = "readings.created"`
2. `contract_version = "1.1.0"` (resolved from catalog)
3. `event_type = "CREATED"`
4. `event_id = <reading_id>`
5. `timestamp = <publish timestamp>`
6. `data = {...}`

Event `data` includes:

1. `reading_id`
2. `device_id`
3. `site_id`
4. `org_id`
5. `serial_number`
6. `timestamp` (reading timestamp in UTC ISO-8601)
7. `source` (`cloud-bridge`)
8. `source_tag` (defaults to `default`)
9. `data` (original telemetry payload)

## Validation and Failure Handling

1. Outbound payloads are validated with `ContractValidator`.
2. On validation failure:
   1. contract log `event.validation_failure` is emitted.
   2. message can be queued in `NATSOutbox` when DB session is available.
3. On publish success/failure:
   1. contract log `event.publish_result` is emitted with `outcome`.

## Outbox and Retry

Cloud Bridge uses `NATSOutbox` as fail-safe:

1. Failed publishes are stored with status `pending`.
2. Background `OutboxProcessor` periodically retries.
3. Messages transition through `processing` -> `completed` or `failed`.

## Health Monitoring

`GET /health/nats` provides:

1. connectivity status.
2. circuit breaker state.
3. contract validation failure count.

Use this endpoint for operational dashboards and alerts.

