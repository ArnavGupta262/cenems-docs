# Migration Checklist (Copy to Fresh Repo)

Use this checklist to move this docs package into a standalone GitBook repository.

## Recommended Copy Method

From this repo root:

```bash
mkdir -p /path/to/new-docs-repo
cp -R docs/gitbook-free-docs/. /path/to/new-docs-repo/
```

This copies:

1. `README.md`
2. `SUMMARY.md`
3. `.gitbook.yaml`
4. all section content
5. generated OpenAPI snapshots

## GitBook Setup

1. Create a new GitBook space.
2. Enable Git Sync to your fresh docs repository.
3. Ensure GitBook uses:
   1. root: `./`
   2. readme: `README.md`
   3. summary: `SUMMARY.md`
4. Publish site and set custom domain if needed.

Alternative (if you keep this folder nested in a larger repo):

1. Place a repo-root `.gitbook.yaml` with:
   1. `root: ./docs/gitbook-free-docs/`
   2. `structure.readme: README.md`
   3. `structure.summary: SUMMARY.md`

## Validation Checklist

1. Sidebar loads exactly as defined in `SUMMARY.md`.
2. Home page resolves to `README.md`.
3. All internal links render correctly.
4. Code blocks render correctly.
5. OpenAPI snapshots exist in `api/generated`.

## Optional Post-Migration Hardening

1. Add branch protection on `main`.
2. Require PR review for docs changes.
3. Add link-check CI workflow in fresh repo.
4. Decide update cadence for generated OpenAPI snapshots.
