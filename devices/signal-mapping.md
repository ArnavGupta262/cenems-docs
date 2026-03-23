# Signal Mapping and Auto-Mapping

Signal extraction in CenEMS uses two layers.

## Layer 1: Manual Mapping (`/device-signals`)

Manual mappings are authoritative.

Each mapping defines:

1. `device_id`
2. `signal_id`
3. `path` (JSON path into telemetry payload)
4. optional `block_id`
5. optional `template_id`

Endpoints:

1. `GET /device-signals`
2. `POST /device-signals`
3. `GET /device-signals/{mapping_id}`
4. `PUT /device-signals/{mapping_id}`
5. `DELETE /device-signals/{mapping_id}`

## Layer 2: Auto-Mapping (`/device-block-template-site`)

This maps device/site/template/block tuples and assigns `mapping_slot`.

Auto-slot behavior:

1. If `mapping_slot` provided explicitly, API uses it.
2. If omitted and one valid slot exists, API assigns it.
3. If omitted and multiple valid slots exist, API returns ambiguity details.

Endpoints:

1. `GET /device-block-template-site`
2. `POST /device-block-template-site`
3. `GET /device-block-template-site/{mapping_id}`
4. `PUT /device-block-template-site/{mapping_id}`
5. `DELETE /device-block-template-site/{mapping_id}`

## Precedence Rules

When both mapping methods exist:

1. Manual `device-signals` mapping is authoritative.
2. Auto-mapping profiles fill gaps not explicitly mapped manually.

## `mapping_slot` Semantics

`mapping_slot` resolves duplicate block structures (for example multiple meters with same signal layout).

Examples:

1. `default`
2. `meter_1`
3. `meter_2`
4. `block_<block-id-prefix>`

## `source_tag` and Profile Resolution

Cloud Bridge includes `source_tag` in `READINGS.CREATED` event data (default `default`).  
Auto-mapping profile specificity prefers:

1. Org scope over global scope.
2. Profile with `source_tag` over profile without `source_tag`.
3. Profile with `mapping_version` over profile without it.

## Practical Flow

1. Create or verify device type.
2. Create device.
3. Add manual `device-signals` for explicit paths where needed.
4. Add `device-block-template-site` tuples to activate auto-slot behavior.
5. Ingest sample telemetry and validate extracted signals downstream.
