# Template and Mapping APIs

Base URL: `https://api.central-ems.com`

Use these APIs when you need deterministic signal extraction and block mapping.

## Discover Template Structure

Endpoints:

- `GET /templates`
- `GET /templates/{template_id}`
- `GET /blocks?template_id=...`
- `GET /blocks/{block_id}`
- `GET /signals?block_id=...`
- `GET /signals/{signal_id}`

## Device-Signal Mapping (`/device-signals`)

Create mapping:

```json
{
  "device_id": "d7fcf8d4-e7bc-4ee2-8ebd-a8b7f892ca09",
  "signal_id": "5b3af909-0267-43f0-9bd8-c8ec030e4f6b",
  "block_id": "33333333-3333-3333-3333-333333333333",
  "template_id": "11111111-1111-1111-1111-111111111111",
  "path": "$.metrics.power_kw"
}
```

Update mapping supports:

- `path`
- `block_id`
- `template_id`

## Device-Block-Template-Site Mapping (`/device-block-template-site`)

Create mapping:

```json
{
  "device_id": "d7fcf8d4-e7bc-4ee2-8ebd-a8b7f892ca09",
  "site_id": "8f28f66b-9d41-4470-bfcb-9d6880d94231",
  "template_id": "11111111-1111-1111-1111-111111111111",
  "block_id": "33333333-3333-3333-3333-333333333333",
  "mapping_slot": "default"
}
```

If `mapping_slot` is omitted, backend tries to infer one.

Potential outcomes:

- single candidate found: slot auto-selected.
- multiple candidates: `409` ambiguity error returned.
- no valid candidates left: conflict/validation error.

### Ambiguity Response Pattern

When ambiguous, service returns conflict details with candidate choices (slot, signal matches, source tags, profile IDs).

## Practical Recommendation

For deterministic production setups:

1. Discover IDs from `/templates` `/blocks` `/signals` first.
2. Prefer explicit `mapping_slot` in automated workflows.
3. Validate mappings in portal signal views before cutover.
