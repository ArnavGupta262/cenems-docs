# Readings Verification API

Base URL: `https://api.central-ems.com`

This section is for verifying that ingestion succeeded.

## Readings Endpoints

- `GET /readings`
- `GET /readings/{reading_id}`

Query params for list endpoint:

- `skip` (default `0`)
- `limit` (default `100`, max `1000`)
- `device_id`
- `site_id`

## Verification Flow After Cloud Bridge Ingestion

1. Identify the target device ID.
2. Query readings by `device_id`.
3. Confirm timestamp ordering and payload values.
4. Confirm `source` and `imported` fields are expected.

Example:

```bash
curl -X GET "https://api.central-ems.com/readings?device_id=<device_id>&limit=20" \
  -H "Authorization: Bearer <clerk_jwt>"
```

Typical response item shape:

```json
{
  "id": "cf7c1db7-e35f-4814-af09-f36acb41111e",
  "timestamp": "2026-03-24T10:30:00+00:00",
  "timestamp_tz": "2026-03-24T10:30:00+00:00",
  "data": {
    "serialNumber": "SN-UK-0001",
    "power_kw": 25.5
  },
  "deviceId": "d7fcf8d4-e7bc-4ee2-8ebd-a8b7f892ca09",
  "siteId": "8f28f66b-9d41-4470-bfcb-9d6880d94231",
  "orgId": "3cd6a3f8-0f71-4f84-a4a8-3b3352c16911",
  "comments": null,
  "imported": true,
  "source": "cloud-bridge",
  "createdAt": "2026-03-24T10:30:02+00:00"
}
```

## What to Check in Production

- reading appears under the correct org/site/device
- no timezone drift between expected and stored UTC
- duplicate policy behavior matches device setting
- UI `/readings` and API list are consistent
