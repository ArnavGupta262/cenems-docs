# UI Guide

The production portal is available at `https://portal.central-ems.com`.

The portal is Clerk-authenticated and designed for day-to-day operations teams.

## Main Navigation

These are the most relevant pages for onboarding and telemetry operations:

- `/sites`: primary operational hub for site setup, template assignment, and device management.
- `/devices`: device-focused operational view and recent reading checks.
- `/readings`: reading-level inspection by site/device filters.
- `/signal-readings`: normalized signal-level inspection.
- `/templates`: template/block/signal structure management.
- `/reports/devices` and `/reports/signals`: CSV export workflows.

## Organization Context

The header includes an organization switcher. All site/device/readings activity is scoped to the active organization context.

## Operational Recommendation

For users provisioning infrastructure manually:

1. Start in `/sites` to create site records.
2. Add devices from the site view or the devices view.
3. Confirm device serial numbers carefully before ingestion starts.
4. Verify telemetry in `/readings` and `/signal-readings`.

## Related Pages

- [Sites and Devices](./sites-and-devices.md)
- [Readings and Operations](./readings-and-operations.md)
- [Cloud Bridge Quickstart](../cloud-bridge/quickstart.md)
