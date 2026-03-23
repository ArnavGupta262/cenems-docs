# Device Types and Configuration

## Device Types

Device types are canonical templates shared across organizations.

Key fields:

1. `id`
2. `slug`
3. `name`
4. `description`
5. `model`
6. `photo_url`
7. `attributes`
8. `protocol_definitions`
9. `configuration_schema`

API:

1. `GET /device-types`
2. `GET /device-types/{device_type_id}`
3. `GET /device-types/{device_type_id}/configuration-schema`

## Configuration Schema Validation

Device configuration is stored on `device.configuration` (JSON).

When patching `PATCH /devices/{device_id}/configuration`:

1. API performs a shallow merge of current config + patch.
2. If `device_type.configuration_schema` exists, merged config is validated with JSON Schema.
3. Invalid payload returns `422`.

## Example: Fetch Schema and Update Configuration

1. Fetch schema:

```bash
curl "http://localhost:8000/device-types/<type_id>/configuration-schema" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>"
```

2. Patch configuration:

```bash
curl -X PATCH "http://localhost:8000/devices/<device_id>/configuration" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>" \
  -d '{
    "sampling_interval_seconds": 30,
    "publish_enabled": true
  }'
```

## Best Practices

1. Version configuration schema changes per device type.
2. Keep required keys small and explicit to reduce rollout breakage.
3. Validate changes in non-production org before broad rollout.

