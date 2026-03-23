# End-to-End Integration Playbook

This page is a practical sequence for clients integrating devices and telemetry.

## Phase 1: Access and Auth

1. Obtain org-scoped API key (`POST /api-keys`) from an admin user.
2. Confirm API access:

```bash
curl "http://localhost:8000/health"
```

## Phase 2: Device Foundation

1. List available device types:

```bash
curl "http://localhost:8000/device-types" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>"
```

2. Create device:

```bash
curl -X POST "http://localhost:8000/devices" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>" \
  -d '{
    "serialNumber": "SN_CLIENT_001",
    "manufacturer": "Client OEM",
    "model": "INV-1000",
    "firmwareVersion": "1.0.0",
    "installationDate": "2026-03-23T09:00:00Z",
    "name": "Main Inverter",
    "attributes": {"timezone": "Europe/London"},
    "siteId": "<site_id>",
    "device_type_id": "<device_type_uuid>",
    "allow_reading_overwrite": true
  }'
```

## Phase 3: Ingest Telemetry

1. Post reading to Cloud Bridge:

```bash
curl -X POST "http://localhost:8015/upload/reading" \
  -H "Content-Type: application/json" \
  -d '{
    "timestamp": "2026-03-23T10:30:00Z",
    "source_tag": "default",
    "data": {
      "serialNumber": "SN_CLIENT_001",
      "power_kw": 25.5,
      "voltage_v": 403.1
    }
  }'
```

2. Validate persistence:

```bash
curl "http://localhost:8000/readings?device_id=<device_id>&limit=5" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>"
```

## Phase 4: Configure Signal Mapping

1. Create manual device signal mapping:

```bash
curl -X POST "http://localhost:8000/device-signals" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>" \
  -d '{
    "device_id": "<device_id>",
    "signal_id": "<signal_uuid>",
    "path": "$.power_kw"
  }'
```

2. Create tuple mapping for auto-slot context:

```bash
curl -X POST "http://localhost:8000/device-block-template-site" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: <api_key>" \
  -H "X-Org-Id: <org_id>" \
  -d '{
    "device_id": "<device_id>",
    "site_id": "<site_id>",
    "template_id": "<template_uuid>",
    "block_id": "<block_uuid>"
  }'
```

## Phase 5: Operate and Monitor

1. Check ingestion service health:

```bash
curl "http://localhost:8015/health/nats"
```

2. Watch for:
   1. repeated `409` duplicates.
   2. rising NATS validation failures.
   3. missing readings due to serial mismatches.

3. Tune:
   1. device `allow_reading_overwrite`.
   2. device timezone/site timezone.
   3. mapping paths and slots.

