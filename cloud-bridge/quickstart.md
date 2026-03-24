# Cloud Bridge Quickstart

Use this quickstart to post production telemetry and verify end-to-end visibility.

## Prerequisites

- device exists in API Router with a known serial number
- target site/device are in the correct organization
- Cloud Bridge endpoint is reachable

## Step 1: Verify Device by Serial

```bash
curl -X GET "https://cloud-bridge.central-ems.com/device/SN-UK-0001/info"
```

If this returns `404`, create the device first via API/UI.

## Step 2: Upload Single Reading

```bash
curl -X POST "https://cloud-bridge.central-ems.com/upload/reading" \
  -H "Content-Type: application/json" \
  -d '{
    "timestamp": "2026-03-24T10:30:00Z",
    "source_tag": "default",
    "data": {
      "serialNumber": "SN-UK-0001",
      "power_kw": 25.5,
      "voltage_v": 399.4
    }
  }'
```

Expected success response shape:

```json
{
  "success": true,
  "message": "Reading uploaded successfully",
  "reading_id": "cf7c1db7-e35f-4814-af09-f36acb41111e",
  "device_id": "d7fcf8d4-e7bc-4ee2-8ebd-a8b7f892ca09",
  "site_id": "8f28f66b-9d41-4470-bfcb-9d6880d94231",
  "org_id": "3cd6a3f8-0f71-4f84-a4a8-3b3352c16911"
}
```

## Step 3: Upload Bulk Readings

```bash
curl -X POST "https://cloud-bridge.central-ems.com/upload/readings/bulk" \
  -H "Content-Type: application/json" \
  -d '{
    "readings": [
      {
        "timestamp": "2026-03-24T10:31:00Z",
        "source_tag": "default",
        "data": {"serialNumber": "SN-UK-0001", "power_kw": 25.9}
      },
      {
        "timestamp": "2026-03-24T10:32:00Z",
        "source_tag": "default",
        "data": {"serialNumber": "SN-UK-0001", "power_kw": 26.1}
      }
    ]
  }'
```

## Step 4: Verify in API and UI

API check:

```bash
curl -X GET "https://api.central-ems.com/readings?device_id=<device_id>&limit=20" \
  -H "Authorization: Bearer <clerk_jwt>"
```

UI check:

- open `https://portal.central-ems.com/readings`
- filter for the target device
- verify latest timestamps and values

## Notes

- Naive timestamps are interpreted using device timezone, then site timezone, then UTC fallback.
- Duplicate behavior depends on `allow_reading_overwrite` on the device.
