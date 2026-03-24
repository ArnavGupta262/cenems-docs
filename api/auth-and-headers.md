# Authentication and Headers

This API supports two production integration styles.

## Style A: Clerk JWT (default for user-driven clients)

Use this when requests originate from signed-in users in the portal or trusted frontends.

Header:

```http
Authorization: Bearer <clerk_jwt>
```

Behavior:

- org role is resolved from Clerk payload
- endpoint permissions are enforced from server permission map
- user-to-org membership is validated

## Style B: API Key (recommended for automation)

Use this for non-interactive integrations and scheduled jobs.

Headers:

```http
X-API-Key: <raw_api_key>
X-Org-Id: <org_uuid>   # optional but strongly recommended
Content-Type: application/json
```

Behavior:

- key is hashed and matched in DB
- key ownership and org membership are validated
- if `X-Org-Id` is provided, it must match key org

## Endpoint-Specific Header Requirements

Most endpoints work with auth context alone.

The following endpoints require explicit org/user headers in request parameters:

- `POST /devices/bulk-create`
  - `X-Org-Id`
  - `X-User-Id`
- `POST /devices/{device_id}/clone`
  - `X-Org-Id`
  - `X-User-Id`
  - `X-Org-Role`
- `GET /devices/{device_id}/configuration`
  - `X-Org-Id`
- `PATCH /devices/{device_id}/configuration`
  - `X-Org-Id`

## Create API Key Example

```bash
curl -X POST "https://api.central-ems.com/api-keys" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <admin_or_owner_clerk_jwt>" \
  -H "X-Org-Role: admin" \
  -d '{"name":"integration-key-prod"}'
```

Response includes `rawApiKey` once. Store it securely.

## Recommended Header Baseline

For JWT clients:

- `Authorization: Bearer <jwt>`
- `Content-Type: application/json`

For API key clients:

- `X-API-Key: <key>`
- `X-Org-Id: <org_uuid>`
- `Content-Type: application/json`
