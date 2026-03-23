# API Authentication and Headers

API Router supports two authentication modes.

## Mode 1: API Key

Send:

1. `X-API-Key: <raw-api-key>`
2. Optional `X-Org-Id: <org-id>` (if provided, must match key org).

Behavior:

1. API key is hashed and looked up in DB.
2. User ownership and org membership are validated.
3. Request state is set with `org_id`, `user_id`, and auth method `api_key`.

## Mode 2: Clerk JWT

Send:

1. `Authorization: Bearer <jwt>`

Behavior:

1. Token is validated with Clerk secret key.
2. Org role is normalized and checked against endpoint permissions.
3. User membership in org is validated.
4. Request state is set with `clerk_org_id` and `user_id`.

## Role and Permission Model

Permissions are endpoint-driven from `apps/api-router/src/authorization/permissions.yaml`.

Device-related examples:

1. `/devices`:
   1. `GET` requires `devices:read`.
   2. `POST` requires `devices:write`.
2. `/readings`:
   1. `GET` requires `readings:read`.
3. `/device-signals`:
   1. `GET` requires `device-signals:read`.
   2. `POST/PUT/DELETE` require `device-signals:write`.

## Headers Required by Specific Endpoints

Some routes explicitly require headers in addition to auth:

1. `POST /devices/bulk-create`:
   1. `X-Org-Id`
   2. `X-User-Id`
2. `POST /devices/{device_id}/clone`:
   1. `X-Org-Id`
   2. `X-User-Id`
   3. `X-Org-Role` (role-enforced route)
3. `GET/PATCH /devices/{device_id}/configuration`:
   1. `X-Org-Id`

## Creating API Keys

Endpoint: `POST /api-keys` (admin/owner)

Example:

```bash
curl -X POST "http://localhost:8000/api-keys" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: <existing-admin-key>" \
  -H "X-Org-Id: <org-id>" \
  -H "X-Org-Role: admin" \
  -d '{"name":"client-integration-key"}'
```

Response includes `rawApiKey` one time only. Store securely.

## Recommended Client Header Set

For API key integrations:

1. `X-API-Key`
2. `X-Org-Id`
3. `Content-Type: application/json`

For Clerk integrations:

1. `Authorization: Bearer ...`
2. `Content-Type: application/json`

