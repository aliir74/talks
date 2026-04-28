# Fix 404 on direct access to deck slide routes

**Goal:** Direct hits to `/second-brain/1`, `/second-brain/2`, etc. should serve the Slidev SPA instead of returning Vercel's 404.
**Status:** in_progress
**Created:** 2026-04-28
**Execution:** Use `/execute-plan <path-to-this-file>` to run this plan task-by-task.

---

## Architecture

Slidev builds a Vite SPA per deck (`decks/<slug>/dist/`) using Vue Router in HTML5 history mode. Each deck is copied into `dist/<slug>/` by `build.sh` with `--base /<slug>/`, so the only real file under `/second-brain/` is `index.html` plus `assets/*`. Routes like `/1`, `/2` are virtual — they only exist client-side.

When you navigate from `/second-brain/` to `/second-brain/1` in-browser, Vue Router handles it client-side and works. When you hit `/second-brain/1` cold, Vercel looks for a matching file, doesn't find one, and returns its built-in 404 page.

The fix is to add a per-deck SPA fallback rewrite to `vercel.json`: anything under `/<slug>/*` that doesn't resolve to a real static file should rewrite to `/<slug>/index.html`. Vercel evaluates rewrites only after the static-file lookup fails, so real assets (`/second-brain/assets/foo.js`) keep working.

To stay generic across `decks/*`, generate the rewrite list at build time from the discovered slugs and emit a final `dist/vercel.json` (Vercel reads the project-root `vercel.json`; we only need the build-time generation if we want it scoped to discovered decks). Simpler alternative: keep a single static rewrite in the root `vercel.json` using `:slug` pattern. Decide in Phase 1.

---

## Phase 1 — Pick rewrite strategy and update `vercel.json`

- [x] Decide: generic `/(?<slug>[^/]+)/:path*` → `/$slug/index.html` rewrite vs. one explicit rewrite per known deck slug. Generic is preferred — scales as new decks are added under `decks/*` without touching `vercel.json`.
  - Constraint: the landing page `dist/index.html` must keep working at `/`. Rewrites only fire when no static file matches, so `/` and `/index.html` are unaffected. Confirm by re-reading Vercel's rewrite docs.
  - Constraint: Slidev emits `assets/`, fonts, images, etc. under `/<slug>/assets/...` — those are real files, so rewrites won't intercept them.
  - Constraint: `cleanUrls: true` and `trailingSlash: true` must continue to behave. Cleanup checked against `/<slug>` vs `/<slug>/` — both should hit `index.html` directly (real file), so no interaction with the rewrite.
- [x] Edit `vercel.json` to add:
  ```json
  "rewrites": [
    { "source": "/:slug/:path*", "destination": "/:slug/index.html" }
  ]
  ```
  Place after `cleanUrls`. Do NOT add a global `/(.*)` fallback — that would break the landing page.
- [x] Verify the JSON parses (`python3 -c 'import json; json.load(open("vercel.json"))'`).

## Phase 2 — Verify locally and on a preview deploy

- [ ] Build locally: `bash build.sh`. Confirm `dist/second-brain/index.html` exists and `dist/index.html` (landing) exists.
- [ ] Serve `dist/` with a tool that respects `vercel.json` rewrites (`vercel dev` from the project root, or `npx serve dist` won't apply rewrites — use `vercel dev`).
- [ ] Hit each route in a fresh tab (no client-side navigation):
  - `/` → landing page renders
  - `/second-brain/` → deck loads at slide 1
  - `/second-brain/1` and `/second-brain/1/` → deck loads at slide 1 (no 404)
  - `/second-brain/5` → deck loads at slide 5
  - `/second-brain/assets/<some-real-file>` → 200, real asset (NOT html)
- [ ] Push the branch and let Vercel build a preview. Repeat the same 5 checks against the preview URL.
- [ ] If anything breaks (especially asset 200s turning into html), revert and reconsider — likely the rewrite pattern is too greedy and needs an asset exclusion or per-slug allowlist.

## Phase 3 — Ship

- [ ] Commit with a single concise message (lowercase title, body explaining the SPA-fallback rationale).
- [ ] Open PR to `main`. PR description should include: the symptom (404 on direct `/second-brain/1`), the root cause (no SPA fallback), and the manual verification checklist results.
- [ ] After merge, verify against production (`https://talks.aliirani.com/second-brain/1`) loads fine cold.

---

## Decisions Made

| Decision | Rationale |
|---|---|
| _(add as you go)_ | |

---

## Errors Encountered

| Error | Attempt | Resolution |
|---|---|---|
| _(none yet)_ | | |
