# Cloud Bridge Troubleshooting

## `400` Schema Validation Failed

Cause:

- `data` payload violates JSON schema
- `data.serialNumber` missing or invalid format

Action:

1. call `GET /schema/device-data`
2. validate payload shape and serial pattern

## `404` Device with serialNumber not found

Cause:

- device serial not provisioned in API Router
- typo or casing mismatch in serial

Action:

1. verify device exists in portal `/devices` or API `/devices`
2. call `GET /device/{serial}/info` to confirm resolution

## `409` Duplicate reading blocked

Cause:

- dedupe key already exists
- `allow_reading_overwrite=false` for the target device

Action:

1. check device overwrite setting
2. resend with corrected timestamp if duplicate was accidental

## `500` Site not found for device or internal error

Cause:

- inconsistent data state
- transient backend dependency issue

Action:

1. verify site-device linkage in portal/API
2. check Cloud Bridge and DB health
3. retry and escalate with request ID and payload sample

## Readings Not Visible in UI

Cause:

- ingestion succeeded but you are in wrong org context
- dashboard/readings filters exclude device
- mapping/signal pipeline incomplete for signal-level views

Action:

1. verify org in portal switcher
2. check API `/readings` with device filter
3. inspect `/signal-readings` and mapping configuration
