# Sites and Devices API

Base URL: `https://api.central-ems.com`

This is the canonical API surface for provisioning site and device inventory.

## Sites

### Create Site

Endpoint: `POST /sites`

```json
{
  "name": "North Solar Farm",
  "latitude": 51.5074,
  "longitude": -0.1278,
  "timezone": "Europe/London",
  "attributes": {
    "region": "uk",
    "customer_ref": "CUST-1001"
  },
  "templateId": "11111111-1111-1111-1111-111111111111",
  "forecast_enabled": true
}
```

### Update Site

Endpoint: `PATCH /sites/{site_id}`

Partial updates are supported for:

- `name`
- `latitude`
- `longitude`
- `timezone`
- `attributes`
- `templateId`
- `forecast_enabled`

### Delete Site

Endpoint: `DELETE /sites/{site_id}`

Behavior:

- devices under that site are cascade-deleted
- readings are preserved

## Devices

### Create Device

Endpoint: `POST /devices`

```json
{
  "serialNumber": "SN-UK-0001",
  "manufacturer": "Acme",
  "model": "EM-200",
  "firmwareVersion": "v2.1.0",
  "installationDate": "2026-03-24T00:00:00Z",
  "name": "Main Meter",
  "attributes": {
    "timezone": "Europe/London"
  },
  "siteId": "8f28f66b-9d41-4470-bfcb-9d6880d94231",
  "device_type_id": "8fb8f73d-e593-4ef6-a09d-76c628bb8ca4",
  "allow_reading_overwrite": true
}
```

### Update Device

Endpoint: `PATCH /devices/{device_id}`

Current implementation caveat:

- patch schema currently requires `device_type_id` in payload even for partial edits.

### Bulk Create Devices

Endpoint: `POST /devices/bulk-create`

Required headers:

- `X-Org-Id`
- `X-User-Id`

Body shape:

```json
{
  "devices": [
    {
      "name": "Main Meter",
      "device_type_id": "8fb8f73d-e593-4ef6-a09d-76c628bb8ca4",
      "site_id": "8f28f66b-9d41-4470-bfcb-9d6880d94231",
      "serialNumber": "SN-UK-0001",
      "manufacturer": "Acme",
      "model": "EM-200",
      "firmwareVersion": "v2.1.0",
      "attributes": {
        "timezone": "Europe/London"
      }
    }
  ]
}
```

Response status: `207 Multi-Status`

```json
{
  "created": [
    {
      "id": "d7fcf8d4-e7bc-4ee2-8ebd-a8b7f892ca09",
      "name": "Main Meter",
      "serialNumber": "SN-UK-0001"
    }
  ],
  "failed": [
    {
      "index": 1,
      "error": "Site '...' not found for this org"
    }
  ]
}
```

### Clone Device

Endpoint: `POST /devices/{device_id}/clone`

Required headers:

- `X-Org-Id`
- `X-User-Id`
- `X-Org-Role`

Behavior:

- copies core fields into same site/org
- generates a new serial
- appends ` (copy)` to device name

### Device Configuration Endpoints

- `GET /devices/{device_id}/configuration`
- `PATCH /devices/{device_id}/configuration`

Both require:

- `X-Org-Id`

Patch is shallow merge and is validated against device-type configuration schema if defined.

## Device Types

Use these endpoints before creating devices so `device_type_id` is correct:

- `GET /device-types`
- `GET /device-types/{device_type_id}`
- `GET /device-types/{device_type_id}/configuration-schema`
