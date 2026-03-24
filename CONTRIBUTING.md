# Contributing Guide (Client + Internal Teams)

## Documentation Principles

1. Write for production client execution, not internal code familiarity.
2. Keep examples copy-paste runnable.
3. Prefer task-based guidance over endpoint-only narration.
4. Keep auth guidance explicit (JWT lane and API-key lane).

## Canonical Entry Points

- `README.mdx`
- `start-here.mdx`
- `integration-playbook.mdx`
- `ui/*`
- `api/*`
- `cloud-bridge/*`

Legacy `.md` files are move notices and should not hold canonical content.

## Required Updates by Change Type

### Cloud Bridge ingest behavior changes

Update:

1. `cloud-bridge/quickstart.mdx`
2. `cloud-bridge/api-reference.mdx`
3. `cloud-bridge/payload-contract.mdx`
4. `cloud-bridge/troubleshooting.mdx`

### Site/Device API schema changes

Update:

1. `api/sites-and-devices.mdx`
2. `ui/sites-and-devices.mdx`
3. `integration-playbook.mdx`

### CSV import contract changes

Update:

1. `api/csv-import-sites-devices.mdx`
2. `integration-playbook.mdx`

### Template/mapping behavior changes

Update:

1. `api/mapping-and-templates.mdx`
2. `ui/readings-and-operations.mdx`

### Report export changes

Update:

1. `api/reports-and-csv-export.mdx`

## OpenAPI Snapshot Update

Update generated specs when API surfaces change:

1. `api/generated/api-router-openapi.json`
2. `api/generated/cloud-bridge-openapi.json`
3. `api/generated/README.mdx` if file set changes

## Pull Request Checklist

1. All production URLs are correct.
2. JSON/CSV examples match source implementation.
3. Auth/header requirements are explicit where needed.
4. `SUMMARY.md` navigation is updated.
5. New pages are `.mdx` unless there is a strong reason not to.
