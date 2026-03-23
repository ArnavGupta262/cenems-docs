# Device Model

## Canonical Device Fields

From `db/models/devices.py` and `apps/api-router/src/schemas/devices.py`.

Identity and linkage:

1. `id`
2. `serialNumber` (unique)
3. `siteId`
4. `orgId`
5. `device_type_id`

Asset metadata:

1. `name`
2. `manufacturer`
3. `model`
4. `firmwareVersion`
5. `installationDate`
6. `attributes` (JSON)

Operational behavior:

1. `allow_reading_overwrite` (default `true`)
2. `configuration` (JSON, validated against device-type schema when patched via API)
3. `location_in_site`

Connectivity and commissioning:

1. `connectivity_status`
2. `last_seen_at`
3. `offline_since`
4. `health_score`
5. `commissioned_at`
6. `commissioning_status`

## Mutability Rules

1. `serialNumber` is immutable in update route.
2. `siteId` can be changed only to site in same organization.
3. `device_type_id` updates are allowed but must reference existing type.
4. `allow_reading_overwrite` can be toggled at any time.

## Why `allow_reading_overwrite` Matters

Cloud Bridge deduplicates readings using `dedup_hash`:

1. `device_id`
2. `serial_number`
3. normalized UTC timestamp

Behavior:

1. `allow_reading_overwrite=true`:
   1. duplicate updates existing row.
2. `allow_reading_overwrite=false`:
   1. duplicate returns `409` and existing reading is preserved.

## Device Response Shape

`DeviceResponse` includes:

1. all base device fields.
2. audit fields (`createdAt`, `updatedAt`, `createdBy`, `updatedBy`).
3. optional embedded `device_type` summary (`id`, `slug`, `name`, `photo_url`).

