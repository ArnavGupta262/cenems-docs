# CenEMS Client Documentation Pack (GitBook Free Tier)

Last updated: 2026-03-23

This folder is a standalone documentation package intended for migration into a dedicated GitBook repository.

For zero-friction migration, copy the contents of this folder into the root of your new docs repository.

## Audience

1. Client-side technical teams integrating with CenEMS ingestion and APIs.
2. Solution engineers onboarding devices and signal mappings.
3. Operations teams troubleshooting ingest and telemetry issues.

## Scope

This pack covers:

1. Cloud Bridge ingestion service (`apps/cloud-bridge`).
2. API Router integration patterns (`apps/api-router`), focused on device/reading flows.
3. Device documentation: lifecycle, types, configuration, and signal mapping.

It also includes:

1. `.gitbook.yaml` for Git Sync content configuration.
2. `SUMMARY.md` for deterministic sidebar structure.
3. generated OpenAPI snapshots in `api/generated/`.
4. docs quality workflow and markdown lint config.

## Suggested GitBook Navigation

1. [Cloud Bridge](./cloud-bridge/README.md)
2. [API Integration](./api/README.md)
3. [Devices](./devices/README.md)
4. [End-to-End Integration Playbook](./integration-playbook.md)
5. [Migration Checklist](./MIGRATION-CHECKLIST.md)
6. [Contributing Guide](./CONTRIBUTING.md)

## Service Endpoints (Typical Local Dev)

1. Cloud Bridge: `http://localhost:8015` (via `scripts/start-dev-wsl.sh`) or `http://localhost:8001` (direct default).
2. API Router: `http://localhost:8000` (also exposed as `http://api.localhost` in local dev stack).

## Quick Integration Path

1. Create device types and devices in API Router.
2. Decide whether duplicate telemetry should overwrite existing readings (`allow_reading_overwrite`).
3. Post telemetry to Cloud Bridge (`POST /upload/reading` or `POST /upload/readings/bulk`).
4. Verify normalized readings through API Router (`GET /readings`).
5. Configure device mapping (`/device-signals`, `/device-block-template-site`) for downstream signal extraction.

## Source of Truth

These docs are generated from:

1. Runtime code in `apps/cloud-bridge/src` and `apps/api-router/src`.
2. Runtime models in `db/models`.
3. Contract definitions in `contracts/`.
