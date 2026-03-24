# Client Docs Rewrite Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace legacy docs with a production-client-focused GitBook/MDX information architecture and code-validated payload guidance.

**Architecture:** Keep GitBook navigation deterministic through `SUMMARY.md`, move canonical pages to `.mdx`, and leave old `.md` files as explicit move notices to prevent stale guidance. Source all payload examples from implementation in `/home/arnav/cenems`.

**Tech Stack:** GitBook, MDX, markdown, FastAPI source contracts

---

### Task 1: Rewire GitBook structure

**Files:**
- Modify: `.gitbook.yaml`
- Modify: `.gitbook.reporoot.example.yaml`
- Modify: `SUMMARY.md`

**Step 1:** point GitBook readme to `README.mdx`

**Step 2:** rebuild navigation for UI/API/Cloud Bridge workflows

**Step 3:** verify all summary links resolve to existing files

### Task 2: Write new canonical MDX pages

**Files:**
- Create: `README.mdx`
- Create: `start-here.mdx`
- Create: `ui/README.mdx`
- Create: `ui/sites-and-devices.mdx`
- Create: `ui/readings-and-operations.mdx`
- Create: `api/*.mdx` workflow pages
- Create: `cloud-bridge/*.mdx` workflow pages
- Create: `integration-playbook.mdx`

**Step 1:** draft production URL + auth guidance

**Step 2:** add code-aligned JSON and CSV examples

**Step 3:** add troubleshooting and verification checklists

### Task 3: De-risk legacy pages

**Files:**
- Modify: existing `.md` files replaced with move notices

**Step 1:** replace content with direct links to canonical `.mdx` pages

**Step 2:** ensure no stale payload docs remain in old pages

### Task 4: Validation

**Files:**
- Verify: entire docs tree

**Step 1:** run file inventory check

**Step 2:** grep for old localhost references and remove from canonical pages

**Step 3:** inspect git diff for coherent rewrite scope
