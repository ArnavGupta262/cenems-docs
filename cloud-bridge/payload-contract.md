# Cloud Bridge Payload Contract

Base URL: `https://cloud-bridge.central-ems.com`

## Single Reading Payload

```json
{
  "timestamp": "2026-03-24T10:30:00Z",
  "source_tag": "default",
  "data": {
    "serialNumber": "SN-UK-0001",
    "power_kw": 25.5,
    "voltage_v": 399.4,
    "current_a": 36.2
  }
}
```

## Required Rules

- `data.serialNumber` is required.
- `serialNumber` must match pattern: `^[A-Za-z0-9_-]+$`.
- payload allows additional custom fields in `data`.

## Bulk Payload

```json
{
  "readings": [
    {
      "timestamp": "2026-03-24T10:31:00Z",
      "source_tag": "default",
      "data": {"serialNumber": "SN-UK-0001", "power_kw": 25.9}
    }
  ]
}
```

Constraints:

- max 1000 readings per request.

## Timestamp Handling

If incoming timestamp is naive (no timezone):

1. use `device.attributes.timezone` when present and valid
2. else use `site.timezone` when present and valid
3. else fallback to UTC

Stored reading timestamp is normalized to UTC.

## Deduplication and Overwrite Policy

Deduplication key is built from:

- device ID
- serial number
- normalized UTC timestamp

Behavior:

- if duplicate exists and `allow_reading_overwrite=true`: existing reading is updated
- if duplicate exists and `allow_reading_overwrite=false`: request is rejected with `409`

## Source Tag Usage

`source_tag` defaults to `default` when omitted.

Use source tags consistently if downstream mapping profiles depend on source-specific rules.
