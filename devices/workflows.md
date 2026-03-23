# Device Operational Workflows

## Workflow 1: Onboard a New Device Type

1. Ensure device type exists in `device_types`.
2. Verify `configuration_schema` is present if device config must be constrained.
3. Verify mapping profiles in contracts registry for auto-mapping use cases.
4. Validate with:
   1. `GET /device-types`
   2. `GET /device-types/{id}/configuration-schema`

## Workflow 2: Onboard a New Device

1. Create device via `POST /devices` with:
   1. `serialNumber`
   2. `siteId`
   3. `device_type_id`
   4. optional `allow_reading_overwrite`
2. Optionally set configuration with `PATCH /devices/{id}/configuration`.
3. Verify with `GET /devices/{id}`.

## Workflow 3: Start Telemetry Ingestion

1. Send first reading to Cloud Bridge `POST /upload/reading`.
2. Confirm response includes `reading_id`, `device_id`, `site_id`, `org_id`.
3. Query API Router `GET /readings?device_id=<id>` to confirm persistence.
4. Check Cloud Bridge `GET /health/nats` to confirm publish path health.

## Workflow 4: Enable Signal Extraction

1. Create manual mapping entries in `/device-signals` for critical paths.
2. Create tuple mapping in `/device-block-template-site`.
3. Use explicit `mapping_slot` for deterministic behavior where duplicate blocks exist.
4. Run validation telemetry and verify derived signal outputs downstream.

## Workflow 5: Handle Duplicate Reading Policy

1. If upstream can replay payloads, set `allow_reading_overwrite=true`.
2. If readings are immutable records, set `allow_reading_overwrite=false`.
3. When false, monitor for `409` conflict rates and adjust upstream retry policy.

## Workflow 6: Change Device Configuration Safely

1. Pull current config with `GET /devices/{id}/configuration`.
2. Apply minimal patch via `PATCH /devices/{id}/configuration`.
3. If `422`, compare payload with device type `configuration_schema`.
4. Re-test telemetry after configuration change.

