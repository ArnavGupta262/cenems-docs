# Cloud Bridge Troubleshooting

## Ingest Fails with `422`

Symptoms:

1. Response includes `serialNumber is required`.
2. Request body validation errors.

Checks:

1. Ensure request body has top-level `timestamp` and `data`.
2. Ensure `data.serialNumber` exists and is not empty.
3. Ensure `serialNumber` uses only letters/numbers/`_`/`-`.

## Ingest Fails with `404 Device ... not found`

Cause:

1. Device does not exist for provided `serialNumber`.

Fix:

1. Create device in API Router first.
2. Verify with Cloud Bridge helper:

```bash
curl "http://localhost:8015/device/<serialNumber>/info"
```

## Ingest Fails with `409 Duplicate reading ... overwrite is disabled`

Cause:

1. Device has `allow_reading_overwrite=false`.
2. A reading already exists with same dedupe key:
   1. device id
   2. serial number
   3. normalized UTC timestamp

Fix options:

1. Send unique timestamp for each reading.
2. Enable overwrite on device if duplicates should replace existing data.

## Timestamp Looks Shifted

Cause:

1. Naive timestamp (`YYYY-MM-DDTHH:MM:SS` without timezone) was interpreted using timezone fallback rules.

Order:

1. `device.attributes.timezone`
2. `site.timezone`
3. UTC

Fix:

1. Send timezone-aware timestamps (recommended), e.g. `2026-03-23T10:30:00Z`.

## NATS Publish Is Delayed

Symptoms:

1. Upload succeeds but downstream consumers do not receive event immediately.
2. `GET /health/nats` shows `connected=false` or circuit breaker not closed.

Behavior:

1. Reading persistence succeeds first.
2. Event may be queued in `NATSOutbox` and retried asynchronously.

Fix:

1. Check NATS availability and credentials (`NATS_URL`).
2. Monitor outbox backlog in DB.
3. Verify contract files are available (`CONTRACTS_PATH`) and valid.

## Service Starts but Protected API Calls Fail

This is usually API Router auth configuration, not Cloud Bridge.  
If `CLERK_SECRET_KEY` is unset, protected API Router routes can return `401`.

