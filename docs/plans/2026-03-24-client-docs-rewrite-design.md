# Client-Facing Docs Rewrite Design

## Goal

Rewrite this GitBook docs pack for production clients so they can reliably:

- provision sites and devices
- ingest readings through Cloud Bridge
- validate readings in API/UI
- run CSV import/export flows

## Audience

- operations users in portal UI
- integration engineers using API/Cloud Bridge
- automation owners running recurring CSV workflows

## Information Architecture

- `README.mdx` as production entrypoint with live domains
- `start-here.mdx` first-day checklist
- `ui/*` for role-based UI operations
- `cloud-bridge/*` for ingestion contract and troubleshooting
- `api/*` for auth, payloads, CSV import/export, mapping
- `integration-playbook.mdx` for end-to-end onboarding runbook

## Auth Strategy

- primary narrative: UI + Clerk JWT
- secondary lane: API keys for automation

## Data Contract Coverage

- exact device/site payload shapes from source schemas
- exact Cloud Bridge payload and dedupe/timezone behavior
- exact CSV import header contract and session workflow

## Safety and Accuracy

- all endpoint/payload content anchored to `/home/arnav/cenems` router/service implementation
- old markdown pages converted to move notices to avoid stale duplicated guidance
