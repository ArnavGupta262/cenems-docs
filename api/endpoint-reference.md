# API Endpoint Reference (Device and Telemetry Focus)

Base URL: `http://localhost:8000`

## Devices

## `GET /devices`

Query params:

1. `skip` (default `0`)
2. `limit` (default `100`, max `1000`)
3. `site_id`
4. `device_type_slug` (or deprecated alias `device_type`)

Permission: `devices:read`

## `GET /devices/{device_id}`

Returns one `DeviceResponse`.

Permission: `devices:read`

## `POST /devices`

Creates a device.

Required body fields:

1. `serialNumber`
2. `manufacturer`
3. `model`
4. `firmwareVersion`
5. `installationDate`
6. `name`
7. `siteId`
8. `device_type_id`
9. `allow_reading_overwrite` (optional, defaults `true`)

Permission: `devices:write`

## `PATCH /devices/{device_id}`

Partial updates.  
Important: `serialNumber` is immutable.

Permission: `devices:write`

## `DELETE /devices/{device_id}`

Deletes device record.  
Readings are preserved (device references in readings may become orphaned).

Permission: `devices:write`

## `POST /devices/bulk-create`

Bulk create endpoint, returns HTTP `207 Multi-Status`.

Response shape:

1. `created[]` with inserted rows.
2. `failed[]` with index + error.

Headers required:

1. `X-Org-Id`
2. `X-User-Id`

## `POST /devices/{device_id}/clone`

Deep-copies a device into same site/org with generated serial and `" (copy)"` suffix.

Headers required:

1. `X-Org-Id`
2. `X-User-Id`
3. `X-Org-Role`

Permission guard: admin/owner role.

## `GET /devices/{device_id}/configuration`

Returns configuration JSON object for the device.

Header required: `X-Org-Id`

## `PATCH /devices/{device_id}/configuration`

Shallow merge patch into `device.configuration`.

Behavior:

1. Merges current config + patch payload.
2. Validates merged config against `device_type.configuration_schema` if present.
3. Returns updated configuration.

Header required: `X-Org-Id`

## Device Types

## `GET /device-types`

List canonical device types (global/shared, not org-scoped).

## `GET /device-types/{device_type_id}`

Get one device type.

## `GET /device-types/{device_type_id}/configuration-schema`

Returns JSON schema used to validate device configuration patches.

## Readings

## `GET /readings`

Query params:

1. `skip`
2. `limit`
3. `device_id`
4. `site_id`

Permission: `readings:read`

## `GET /readings/{reading_id}`

Get one reading.

Permission: `readings:read`

## Device Signal Mapping

## `GET /device-signals`

Paginated list with filters:

1. `device_id`
2. `site_id`
3. `template_id`
4. `block_id`
5. `signal_id`
6. `skip`
7. `limit`

## `POST /device-signals`

Create manual signal extraction mapping:

1. `device_id`
2. `signal_id`
3. `path` (JSON path)
4. optional `block_id`
5. optional `template_id`

## `GET /device-signals/{mapping_id}`

Get mapping details.

## `PUT /device-signals/{mapping_id}`

Update mapping path/template/block.

## `DELETE /device-signals/{mapping_id}`

Delete mapping.

## Device-Block-Template-Site Assignment

## `GET /device-block-template-site`

List tuple mappings with filters and pagination.

## `POST /device-block-template-site`

Create mapping tuple:

1. `device_id`
2. `site_id`
3. `template_id`
4. `block_id`
5. optional `mapping_slot`

If `mapping_slot` omitted:

1. Service may auto-resolve slot.
2. If multiple valid slots exist, request fails with ambiguity details.

## `PUT /device-block-template-site/{mapping_id}`

Update `mapping_slot`.

## `DELETE /device-block-template-site/{mapping_id}`

Delete tuple mapping.

## API Keys

## `GET /api-keys`

List org API keys (without raw key value).

## `POST /api-keys`

Create key (admin/owner).  
Returns `rawApiKey` once.

## `PATCH /api-keys/{api_key_id}`

Update key metadata.

## `DELETE /api-keys/{api_key_id}`

Soft-revoke key (`revoked_at`, `revoked_by`).

## Example Device Creation Request

```bash
curl -X POST "http://localhost:8000/devices" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>" \
  -d '{
    "serialNumber": "SN_ABC_1001",
    "manufacturer": "Example Manufacturer",
    "model": "Model-X",
    "firmwareVersion": "1.0.0",
    "installationDate": "2026-03-23T10:00:00Z",
    "name": "Site A Inverter 1",
    "attributes": {"timezone": "Europe/London"},
    "siteId": "<site_id>",
    "device_type_id": "<device_type_uuid>",
    "allow_reading_overwrite": true
  }'
```

