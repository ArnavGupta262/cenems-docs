# CSV Export Reports

Base URL: `https://api.central-ems.com`

This API supports two CSV export flows.

## Device Readings Report

Endpoint: `POST /reports/devices`

Request body:

```json
{
  "deviceIds": [
    "d7fcf8d4-e7bc-4ee2-8ebd-a8b7f892ca09"
  ],
  "startDate": "2026-03-20T00:00:00Z",
  "endDate": "2026-03-24T23:59:59Z",
  "unpackLists": false
}
```

Constraints:

- `startDate` must be within 30 days of current day.
- `endDate` must be after `startDate`.
- row limit is enforced (max 100,000 rows).

Response:

- `text/csv` download stream
- content-disposition filename like `readings_report_YYYYMMDD_HHMMSS.csv`

## Signal Readings Report

Endpoint: `POST /reports/signals`

Request body:

```json
{
  "deviceIds": [],
  "templateIds": ["11111111-1111-1111-1111-111111111111"],
  "blockIds": [],
  "signalIds": [],
  "startDate": "2026-03-20T00:00:00Z",
  "endDate": "2026-03-24T23:59:59Z"
}
```

Notes:

- empty arrays are treated as broad/all for that dimension.
- row limit is enforced (max 100,000 rows).

## Flattening Behavior for Device Report

Device report flattens JSON payload fields using `__` separator.

Examples:

- `{"metrics": {"power": 42}}` becomes column `metrics__power`.
- if `unpackLists=false`, lists are JSON strings.
- if `unpackLists=true`, lists are expanded with index columns like `items__0__name`.

## Client Workflow Recommendation

1. Use narrow date windows and scoped device/signal filters.
2. Validate row count expectations before large exports.
3. Store downloaded files with execution metadata (org, query, timestamp).
