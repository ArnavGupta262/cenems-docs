# API Guide

Base URL: `https://api.central-ems.com`

This section is focused on client integration tasks required in production.

## Core Tasks

1. Authenticate correctly for your user or service context.
2. Create and maintain site/device inventory.
3. Verify ingested readings.
4. Import and export high-volume CSV datasets.
5. Configure template, block, and signal mappings.

## Integration Sequence

1. [Authentication and Headers](./auth-and-headers.md)
2. [Sites and Devices API](./sites-and-devices.md)
3. [Readings Verification API](./readings-and-verification.md)
4. [CSV Import (Sites and Devices)](./csv-import-sites-devices.md)
5. [Template and Mapping APIs](./mapping-and-templates.md)
6. [CSV Export Reports](./reports-and-csv-export.md)

## API and Cloud Bridge Division of Responsibility

- API Router (`api.central-ems.com`) is the canonical system for provisioning and querying.
- Cloud Bridge (`cloud-bridge.central-ems.com`) is optimized for telemetry ingestion by serial number.
