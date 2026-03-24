# Data Contracts and Events

Cloud Bridge emits asynchronous event publication behavior after reading persistence.

## Event Flow

1. Reading is validated and persisted.
2. `READINGS.CREATED` publish is scheduled in background.
3. If publish succeeds, flow is complete.
4. If publish is unavailable, payload can be queued into outbox for retry.

## Event Payload Core Fields

- `reading_id`
- `device_id`
- `site_id`
- `org_id`
- `serial_number`
- `timestamp`
- `data`
- `source` (`cloud-bridge`)
- `source_tag`

## Failure Handling

Contract logging tracks:

- validation failures
- publish queued outcomes
- publish failures

## Operational Guidance

- ingestion success response means DB write succeeded.
- event publish is asynchronous and can trail ingestion.
- monitor NATS health using `GET /health/nats`.
