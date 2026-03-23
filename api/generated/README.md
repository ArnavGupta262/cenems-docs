# Generated OpenAPI Snapshots

This folder contains static OpenAPI snapshots exported from current services.

## Files

1. `api-router-openapi.json`
2. `cloud-bridge-openapi.json`

## Purpose

1. Provide a frozen reference aligned with this docs bundle.
2. Allow immediate import into API documentation tooling if needed.

## Regeneration (from monorepo)

API Router:

```bash
cd apps/api-router
../../.venv/bin/python - <<'PY'
import json,sys
sys.path.insert(0,'/home/arnav/cenems/apps/api-router')
from src.main import app
with open('/home/arnav/cenems/docs/gitbook-free-docs/api/generated/api-router-openapi.json','w',encoding='utf-8') as f:
    json.dump(app.openapi(), f, indent=2)
PY
```

Cloud Bridge:

```bash
cd apps/cloud-bridge
../../.venv/bin/python - <<'PY'
import json,sys
sys.path.insert(0,'/home/arnav/cenems/apps/cloud-bridge')
from src.main import app
with open('/home/arnav/cenems/docs/gitbook-free-docs/api/generated/cloud-bridge-openapi.json','w',encoding='utf-8') as f:
    json.dump(app.openapi(), f, indent=2)
PY
```

