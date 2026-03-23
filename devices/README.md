# Devices

This section documents CenEMS device concepts, API models, and operational workflows.

## Topics

1. [Device Model](./device-model.md)
2. [Device Types and Configuration](./device-types-and-configuration.md)
3. [Signal Mapping and Auto-Mapping](./signal-mapping.md)
4. [Operational Workflows](./workflows.md)

## Core Domain Relationship

1. Device belongs to one Site and one Organization.
2. Device references one canonical Device Type.
3. Readings reference device/site/org IDs.
4. Device signal mapping connects telemetry paths to logical signals.

## Design Intent

1. Keep ingestion format flexible (`data` allows arbitrary fields).
2. Keep extraction deterministic via mapping configuration (`device-signals`, `mapping_slot`).
3. Keep duplicate behavior explicit with `allow_reading_overwrite`.

