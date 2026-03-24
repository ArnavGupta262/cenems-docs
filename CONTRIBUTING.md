# Contributing Guide (Client + Internal Teams)

## Documentation Principles

1. Write for production client execution, not internal code familiarity.
2. Keep examples copy-paste runnable.
3. Prefer task-based guidance over endpoint-only narration.
4. Keep auth guidance explicit (JWT lane and API-key lane).

## Canonical Entry Points

- `README.md`
- `start-here.md`
- `integration-playbook.md`
- `ui/*`
- `api/*`
- `cloud-bridge/*`

## Required Updates by Change Type

### Cloud Bridge ingest behavior changes

Update:

1. `cloud-bridge/quickstart.md`
2. `cloud-bridge/api-reference.md`
3. `cloud-bridge/payload-contract.md`
4. `cloud-bridge/troubleshooting.md`

### Site/Device API schema changes

Update:

1. `api/sites-and-devices.md`
2. `ui/sites-and-devices.md`
3. `integration-playbook.md`

### CSV import contract changes

Update:

1. `api/csv-import-sites-devices.md`
2. `integration-playbook.md`

### Template/mapping behavior changes

Update:

1. `api/mapping-and-templates.md`
2. `ui/readings-and-operations.md`

### Report export changes

Update:

1. `api/reports-and-csv-export.md`

## Pull Request Checklist

1. All production URLs are correct.
2. JSON/CSV examples match source implementation.
3. Auth/header requirements are explicit where needed.
4. `SUMMARY.md` navigation is updated.
5. New pages are `.md` unless there is a strong reason not to.
