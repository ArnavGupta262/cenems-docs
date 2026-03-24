# CSV Import (Sites and Devices)

The API provides a review-and-apply CSV pipeline for bulk onboarding.

Base URL: `https://api.central-ems.com`

## Import Workflow

1. Download the CSV template (`.csv`).
2. Populate rows using the exact contract.
3. Validate CSV and obtain `session_id`.
4. Review row classification and errors.
5. Patch rows in session if needed.
6. Apply session.

## Endpoints

- `GET /imports/sites-devices/template.csv`
- `POST /imports/sites-devices/validate`
- `GET /imports/sites-devices/sessions/{session_id}`
- `PATCH /imports/sites-devices/sessions/{session_id}/rows/{row_index}`
- `POST /imports/sites-devices/sessions/{session_id}/apply`

CSV import in production accepts only `.csv` files.

## Required Header Contract

Header order must match exactly:

```csv
client_row_id,site_client_ref,site_id,site_name,site_latitude,site_longitude,site_timezone,site_template_id,site_forecast_enabled,site_attributes_json,device_serial_number,device_name,device_manufacturer,device_model,device_firmware_version,device_installation_date,device_type_id,device_type_slug,device_allow_reading_overwrite,device_attributes_json,block_id,mapping_slot
```

## Example CSV

```csv
client_row_id,site_client_ref,site_id,site_name,site_latitude,site_longitude,site_timezone,site_template_id,site_forecast_enabled,site_attributes_json,device_serial_number,device_name,device_manufacturer,device_model,device_firmware_version,device_installation_date,device_type_id,device_type_slug,device_allow_reading_overwrite,device_attributes_json,block_id,mapping_slot
ROW-001,SITE_REF_A,,North Solar Farm,51.5074,-0.1278,Europe/London,11111111-1111-1111-1111-111111111111,true,"{""region"":""uk""}",SN-UK-0001,Main Meter,Acme,EM-200,v2.1.0,2026-03-13T00:00:00Z,,dev-ele-meter,true,"{}",33333333-3333-3333-3333-333333333333,default
ROW-002,SITE_REF_A,,,,,,,,,SN-UK-0002,Backup Meter,Acme,EM-200,v2.1.0,2026-03-13T00:00:00Z,,dev-ele-meter,true,"{}",,
```

## Validate Example

```bash
curl -X POST "https://api.central-ems.com/imports/sites-devices/validate" \
  -H "Authorization: Bearer <clerk_jwt>" \
  -F "file=@sites_devices.csv"
```

Validation response contains:

- `session_id`
- `summary` (`total_rows`, `create_rows`, `update_rows`, `reference_rows`, `error_rows`)
- `rows[]` with classification, actions, errors, warnings, and resolved IDs

## Edit a Row in Session

```bash
curl -X PATCH "https://api.central-ems.com/imports/sites-devices/sessions/<session_id>/rows/2" \
  -H "Authorization: Bearer <clerk_jwt>" \
  -H "Content-Type: application/json" \
  -d '{
    "row_data": {
      "device_type_slug": "dev-ele-meter",
      "device_allow_reading_overwrite": "true"
    }
  }'
```

## Apply Session

```bash
curl -X POST "https://api.central-ems.com/imports/sites-devices/sessions/<session_id>/apply" \
  -H "Authorization: Bearer <clerk_jwt>"
```

Apply response contains:

- `summary` (`created`, `updated`, `unchanged`, `skipped`, `failed`)
- row-level `apply_status` (`applied`, `failed`, `skipped`)
- created/linked `site_id`, `device_id`, `mapping_id` where available

## Classification Meanings

- `create`: row will create at least one resource.
- `update`: row updates an existing resource.
- `reference existing`: row links to existing resources only.
- `error`: row is invalid and will be skipped unless corrected.

## Production Notes

- import sessions are in-memory process state, not durable long-term workflow artifacts.
- template/block validation is enforced for mapping rows.
- use `site_client_ref` to reference a site created in an earlier row.
