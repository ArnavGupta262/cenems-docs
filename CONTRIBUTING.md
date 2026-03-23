# Contributing Guide (Client + Internal Teams)

## Editing Rules

1. Keep pages concise and task-oriented.
2. Always include request/response examples for API changes.
3. For behavior changes, include:
   1. what changed
   2. who is impacted
   3. rollout or migration note
4. Do not remove existing examples unless replacing with a better tested one.

## Required Updates per Change Type

## Cloud Bridge ingest change

Update:

1. `cloud-bridge/api-reference.md`
2. `cloud-bridge/quickstart.md` (if request shape changed)
3. `cloud-bridge/troubleshooting.md` (new failure mode)

## Device API change

Update:

1. `api/endpoint-reference.md`
2. `devices/device-model.md` or `devices/device-types-and-configuration.md`

## Mapping behavior change

Update:

1. `devices/signal-mapping.md`
2. `devices/workflows.md`

## OpenAPI Snapshot Update

Update generated specs when API surfaces change:

1. `api/generated/api-router-openapi.json`
2. `api/generated/cloud-bridge-openapi.json`

## Pull Request Checklist

1. Links are valid.
2. Examples are runnable.
3. Status codes and fields match current implementation.
4. `SUMMARY.md` includes any new pages.

