# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Ali Irani's talks site, deployed at [talks.aliirani.com](https://talks.aliirani.com) via Vercel. This is a **multi-deck Slidev workspace**, not a monorepo: each deck under `decks/<slug>/` is an independent Slidev project with its own `package.json` and `pnpm-lock.yaml`. The root only orchestrates building all decks into a single `dist/`.

## Commands

```bash
# Develop a single deck (hot reload)
cd decks/<slug>
pnpm install
pnpm dev

# Build the full site (all decks + landing page → dist/)
pnpm build           # runs build.sh
open dist/index.html
```

There are no tests or linters configured at the root. Per-deck linting depends on the deck — check the deck's own `package.json`.

## Slidev workflow — use the slidev skills

When working on any deck in this repo, **invoke the relevant `slidev:*` skills before editing slides.** They encode framework knowledge, slide-management workflows (renumbering, gap detection), and design/quality heuristics that hand-rolling reliably gets wrong.

| Task | Skill |
|---|---|
| General Slidev framework reference (layouts, frontmatter, components, themes) | `slidev:slidev-mastery` |
| Add / delete / move / renumber slides — **never edit `slides.md` slide order by hand** | `slidev:slide-management` |
| Edit a specific slide with TOC context | `slidev:edit` |
| Preview deck (start dev server) | `slidev:preview` |
| Structure content, improve flow, design slide hierarchy | `slidev:presentation-design` |
| Diagrams (mermaid / excalidraw / plantuml) | `slidev:diagram`, `slidev:excalidraw-generation`, `slidev:redraw-diagrams` |
| Visuals (images, charts, color palettes, AI image prompts) | `slidev:visual-design`, `slidev:visuals` |
| Review slide quality (12-point checklist) | `slidev:slide-quality` |
| Speaker notes | `slidev:notes` |
| Export PDF / PPTX | `slidev:export` |
| Brand-new deck (full workflow from blank) | `slidev:init` (orchestrates `slidev:brainstorm` → `slidev:frame` → `slidev:outline` → `slidev:generate`) |
| Resume work on an existing deck | `slidev:continue` |

Skipping the skill and editing markdown directly is the wrong default — it has produced bugs in this repo (per-slide `title:` missing, slide-jumper dialog leaking into prod, etc.). Reach for a skill first.

## Architecture

### Build flow (`build.sh`)

1. Iterates every directory under `decks/*/`.
2. Runs `pnpm install` (only if `node_modules` missing) then `pnpm build --base /<slug>/` inside the deck.
3. Copies the deck's `dist/` to `$ROOT/dist/<slug>/` via `cp -R` (rsync isn't on Vercel's build image — see commit `7567392`).
4. Extracts `title:` from `slides.md` frontmatter via awk for the landing page link text; falls back to slug.
5. Generates `dist/index.html` (inline HTML/CSS, no framework) listing all built decks.

If any deck fails to produce `dist/index.html`, the build aborts.

### Vercel quirks (load-bearing)

- **pnpm version is pinned via npx on Vercel only.** Vercel's bundled pnpm crashes on Node 22 with a `URLSearchParams` error. `build.sh` detects `VERCEL=1` and uses `npx --yes pnpm@10.16.0`; locally it uses the system `pnpm`. Don't replace this with a plain `pnpm` call.
- **esbuild postinstall under pnpm 10.** Each deck's `package.json` needs `pnpm.onlyBuiltDependencies: ["esbuild"]` so esbuild's native binary actually installs (commit `ad05fcd`). New decks must include this.
- **SPA routing for deck slide URLs.** Slidev decks use client-side routing for slides like `/second-brain/2/`. `vercel.json` rewrites `/:slug/:path+/` to `/:slug/` so direct deep-links to slides don't 404 (commits `811f7b4`, `7e8b7c2`). `trailingSlash: true` is required for this rewrite to match.

### Adding a new talk

1. Create `decks/<new-slug>/` (e.g. `pnpm create slidev` inside `decks/`).
2. Ensure `slides.md` frontmatter has a `title:` — that's what shows on the landing page.
3. Add `"pnpm": { "onlyBuiltDependencies": ["esbuild"] }` to the deck's `package.json`.
4. **Per-slide `title:` frontmatter** — each `---` slide separator should declare its own `title:` (e.g., `---\ntitle: The problem\n---`). Without it, Slidev's slide navigator dropdown shows "undefined" for every slide — embedded `<h1>` tags inside divs are not auto-detected.
5. **Title slide must include the presentation date** — append it to the byline, e.g., `Ali Irani · OVOU Spotlight · May 5, 2026`. Spelled-out month, no zero-padding. Update the date if the talk is re-delivered.
6. Run `pnpm build` from the root to verify the deck slots into `dist/<slug>/` and appears in `dist/index.html`.
7. Commit and push — Vercel rebuilds automatically.

## Conventions

- **No root lockfile.** Each deck owns its own `pnpm-lock.yaml`. Don't add a root one.
- **Landing page is generated, not committed.** `dist/` is built output; the landing page HTML lives inline in `build.sh`.
- Personal repo — push as `aliir74` (see `~/Downloads/Coding/personal/CLAUDE.md`).
- **This repo deploys publicly via Vercel — privacy-scan every commit.** Before staging, scan diffs for: internal Slack/ClickUp URLs, teammate names (Bardia, Annelie, Yalda, Dhanishta, Reza, Kasra, Payam, etc.), candid internal observations, vault paths (`[[Knowledge/...]]`). Working notes (plans, drafts, internal research) stay local — never commit `docs/plans/*` or similar to a public PR.
- **Crop image assets at file level — not via CSS.** PR review and the deployed build both ship the raw asset. If a meme template has empty padding (e.g., the Drake template's right yellow half), crop it with `sips`/`magick` before committing so the file matches what's displayed. CSS `object-fit`/`object-position` cropping hides the cruft from end users but leaves it in the repo.
