# talks

Ali Irani's talks, deployed at [talks.aliirani.com](https://talks.aliirani.com).

Each deck is its own [Slidev](https://sli.dev) project under `decks/<slug>/`. A top-level `build.sh` builds every deck with `--base /<slug>/` and stitches them into a single `dist/` with a landing page at `/`.

## Layout

```
talks/
├── decks/
│   ├── second-brain/   # OVOU Spotlight talk
│   └── ...             # add more here
├── build.sh            # builds all decks → dist/
└── package.json        # root scripts
```

## Develop a deck

```bash
cd decks/<slug>
pnpm install
pnpm dev
```

## Build everything

```bash
pnpm build           # runs build.sh
open dist/index.html # landing page
```

## Add a new talk

1. Create `decks/<new-slug>/` with a slidev project (`pnpm create slidev` works)
2. Make sure `slides.md` has a `title:` in frontmatter — that's what shows on the landing page
3. Run `pnpm build` to verify
4. Commit and push — Vercel rebuilds automatically
