# End-to-End Integration Playbook

This playbook is for production client teams onboarding a new site and first devices.

## System Endpoints

- UI: `https://portal.central-ems.com`
- API: `https://api.central-ems.com`
- Cloud Bridge: `https://cloud-bridge.central-ems.com`

## Phase 1: Provision Inventory

1. Create site in portal `/sites` or via `POST /sites`.
2. Create device in portal `/devices` or via `POST /devices`.
3. Record serial numbers exactly as installed in field hardware.

## Phase 2: Validate Device Registration for Ingestion

```bash
curl -X GET "https://cloud-bridge.central-ems.com/device/SN-UK-0001/info"
```

Success confirms Cloud Bridge can resolve serial to device/site/org.

## Phase 3: Send Initial Telemetry

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

## Phase 4: Verify Telemetry

API verification:

```bash
curl -X GET "https://api.central-ems.com/readings?device_id=<device_id>&limit=20" \
  -H "Authorization: Bearer <clerk_jwt>"
```

UI verification:

1. open `/readings`
2. filter to the target device
3. inspect payload and timestamps

## Phase 5: Configure Signal Mapping (if needed)

1. discover template/blocks/signals via API.
2. create device-signal mappings.
3. create device-block-template-site mapping with explicit slot where possible.

## Phase 6: Scale via CSV Import

1. download import template
2. prepare CSV rows for create/update/reference
3. validate to get `session_id`
4. fix row errors
5. apply session

## Phase 7: Operating Model

- human operations: UI + Clerk JWT
- automation and recurring jobs: API key integrations
- telemetry ingest clients: Cloud Bridge bulk endpoint

## Go-Live Checklist

- site and device inventory complete
- serial numbers validated against physical asset list
- first telemetry path verified end-to-end
- duplicate policy validated (`allow_reading_overwrite`)
- mapping and signal visibility verified
- CSV import/export dry run completed
