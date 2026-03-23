# Cloud Bridge Quickstart

## Prerequisites

1. A device exists in DB with a known `serialNumber`.
2. Cloud Bridge is running (`http://localhost:8015` in the local stack scripts).
3. API Router is running (`http://localhost:8000`) for verification.

## 1) Upload a Single Reading

```bash
curl -X POST "http://localhost:8015/upload/reading" \
  -H "Content-Type: application/json" \
  -d '{
    "timestamp": "2026-03-23T10:30:00Z",
    "source_tag": "default",
    "data": {
      "serialNumber": "SN_ABC_1001",
      "deviceType": "pv_inverter",
      "power_kw": 25.5,
      "voltage_v": 405.2
    }
  }'
```

Expected response shape:

```json
{
  "success": true,
  "message": "Reading uploaded successfully",
  "reading_id": "uuid",
  "device_id": "uuid",
  "site_id": "uuid",
  "org_id": "uuid"
}
```

## 2) Upload Readings in Bulk

```bash
curl -X POST "http://localhost:8015/upload/readings/bulk" \
  -H "Content-Type: application/json" \
  -d '{
    "readings": [
      {
        "timestamp": "2026-03-23T10:30:00Z",
        "data": {
          "serialNumber": "SN_ABC_1001",
          "power_kw": 25.5
        }
      },
      {
        "timestamp": "2026-03-23T10:31:00Z",
        "data": {
          "serialNumber": "SN_ABC_1001",
          "power_kw": 26.1
        }
      }
    ]
  }'
```

Bulk uploads return partial success details per row with:

1. `summary.total`
2. `summary.successful`
3. `summary.failed`
4. `results[]` with `reading_index`, `message`, and optional IDs.

## 3) Verify Device Metadata by Serial Number

```bash
curl "http://localhost:8015/device/SN_ABC_1001/info"
```

Use this to validate that serial -> device/site/org mapping exists before ingesting high-volume telemetry.

## 4) Verify Persisted Readings via API Router

```bash
curl "http://localhost:8000/readings?limit=10" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>"
```

## 5) Common First Errors

1. `422` with `serialNumber is required`:
   1. `data` object is missing `serialNumber`.
2. `404 Device with serialNumber ... not found`:
   1. Device has not been created in API Router/DB.
3. `409 Duplicate reading already exists ... overwrite is disabled`:
   1. Device has `allow_reading_overwrite=false`.

