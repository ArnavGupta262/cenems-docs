#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
OUT_DIR="${ROOT_DIR}/docs/gitbook-free-docs/api/generated"
PY_BIN="${ROOT_DIR}/.venv/bin/python"

if [[ ! -x "${PY_BIN}" ]]; then
  echo "Missing ${PY_BIN}. Create project venv first."
  exit 1
fi

mkdir -p "${OUT_DIR}"

echo "[1/2] Exporting API Router OpenAPI..."
(
  cd "${ROOT_DIR}/apps/api-router"
  "${PY_BIN}" - <<'PY'
import json,sys
sys.path.insert(0,'/home/arnav/cenems/apps/api-router')
from src.main import app
with open('/home/arnav/cenems/docs/gitbook-free-docs/api/generated/api-router-openapi.json','w',encoding='utf-8') as f:
    json.dump(app.openapi(), f, indent=2)
print("Wrote api-router-openapi.json")
PY
)

echo "[2/2] Exporting Cloud Bridge OpenAPI..."
(
  cd "${ROOT_DIR}/apps/cloud-bridge"
  "${PY_BIN}" - <<'PY'
import json,sys
sys.path.insert(0,'/home/arnav/cenems/apps/cloud-bridge')
from src.main import app
with open('/home/arnav/cenems/docs/gitbook-free-docs/api/generated/cloud-bridge-openapi.json','w',encoding='utf-8') as f:
    json.dump(app.openapi(), f, indent=2)
print("Wrote cloud-bridge-openapi.json")
PY
)

echo "Done."

