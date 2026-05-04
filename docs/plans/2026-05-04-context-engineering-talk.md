# Context Engineering Talk — 10-min OVOU Spotlight (Tuesday May 5)

**Goal:** Build and rehearse a 10-min Slidev deck for the Tuesday company call covering the shift from prompt → context engineering, how Claude/ChatGPT load context, why too much/too little hurts, and practical habits the team can adopt.
**Status:** in_progress
**Created:** 2026-05-04
**Execution:** From `~/Downloads/Coding/personal/talks/`, run `/execute-plan docs/plans/2026-05-04-context-engineering-talk.md` to run this plan task-by-task.

---

## Architecture

New Slidev deck added to existing repo at `~/Downloads/Coding/personal/talks/decks/context-engineering/`. The repo already has `decks/second-brain/` as a working reference — same Inter/Fira Code fonts, same `default` theme, same `build.sh` stitching pattern. Each deck is a standalone Slidev project that gets built with `--base /<slug>/` and stitched into the unified `dist/` for talks.aliirani.com.

Audience: small non-technical OVOU team (Bardia, Annelie, Yalda, Dhanishta, Reza, Kasra, Payam, etc.) who use ChatGPT/Claude daily but default to long, unfocused chats. Goal is **practical habits**, not theory — by the end they should know what to do differently Monday morning.

Source: [[Knowledge/Research/2026-05-04-context-engineering-talk|2026-05-04 research file]] and Reza's brief in Slack ([thread](https://ovouteam.slack.com/archives/D041J8RBJP3/p1777308899073329)).

---

## Phase 1 — Scaffold deck + outline

- [x] **Scaffold the deck folder.** Copy `decks/second-brain/` structure (or `pnpm create slidev`) into `decks/context-engineering/`, set `title: "Context Engineering"`, author, info, fonts. Verify `pnpm dev` runs locally on a placeholder slide.
- [x] **Write the outline as a slides.md skeleton.** Every slide gets a title and a one-line note for what it shows; no body content yet. Target: 10 minutes ≈ 8–10 slides + title/closing. Order:
  1. Title — "Context Engineering: Getting More Out of AI"
  2. The problem (relatable opener) — "Why does my chat get worse the longer it gets?"
  3. The shift — Prompt → Context Engineering (Karpathy/Lütke quote)
  4. What "context" actually means (anatomy diagram of context window)
  5. Live demo / screenshot — what loads when you say "Hi" after a long chat
  6. Why too little hurts (no context = robot answer)
  7. Why too much hurts ("Lost in the Middle" + 39% multi-turn drop)
  8. Claude vs ChatGPT — visible vs invisible context
  9. Practical habits (5 rules to take home)
  10. Bonus: positive vs negative prompts (Wegner's white bear → "tell what to do")
  11. Closing / Q&A
- [x] **Verify:** Run `pnpm dev` and click through all empty slides — confirm transitions, fonts, no build errors. Commit: `feat(context-engineering): scaffold deck + outline`.

---

## Phase 2 — Write slide content + visuals

- [ ] **Slide 2 (the problem):** Open with a question the team has actually asked. One sentence + a screenshot of a long bloated chat. Hook: "This is happening to most of us."
- [ ] **Slide 3 (the shift):** Karpathy quote in full. Side-by-side: "Prompt engineering = clever instruction" vs "Context engineering = the delicate art of filling the context window with just the right information." Sub-line: "Most agent failures are not model failures anymore — they are context failures." (Schmid)
- [ ] **Slide 4 (anatomy of context):** Visual diagram of the context window with labeled slices — System Prompt / Conversation History / Memory / Retrieved Docs / Tools / Tool Results / User Prompt. Make the user prompt visually tiny (~1% of the bar).
- [ ] **Slide 5 (the "Hi" example):** Two screenshots side-by-side. Left: blank chat → "Hi" → AI says "Hello, how can I help?" Right: same "Hi" in a project with memory + files + tool results loaded → AI references your past work. Caption: "Same prompt. Same model. Completely different usefulness."
- [ ] **Slide 6 (too little hurts):** Schmid's calendar example. AI without calendar context → "I don't have a calendar." With calendar + emails + timezone → "Thursday 10 AM works." One slide.
- [ ] **Slide 7 (too much hurts):** Three numbered findings as bullets:
  - **Lost in the Middle** — Liu et al., performance is U-shaped (best at start/end, worst in middle).
  - **Context Rot** — Chroma tested 18 frontier models, *all* degrade as input grows, even before the window is full.
  - **39% multi-turn drop** — Microsoft + Salesforce, May 2025: "when models made wrong assumptions early, they rarely corrected themselves."
  - Bottom line: bloated history, stale memory, contradicting instructions ("follow A → ignore A, follow B") = recipe for hallucinations.
- [ ] **Slide 8 (Claude vs ChatGPT):** Comparison table:
  - **ChatGPT memory** = silent auto-injection, AI-decided summaries, lower-maintenance, less auditable.
  - **Claude memory** = visible tool calls, user-editable, transparent.
  - **Both** auto-synthesize now (since March 2 2026 for Claude). Old "Claude is fully manual" framing is outdated.
  - Tool-specific tips: Claude.ai Projects > plain chat; ChatGPT project-only memory mode (Aug 22 2025) keeps things scoped.
- [ ] **Slide 9 (practical habits — the take-home):** 5 rules, big and bold:
  1. **One topic per chat.** Switching topics mid-chat is the #1 cause of bad output.
  2. **Front-load what matters.** Put the most important info at the top OR bottom (U-curve).
  3. **Prune memory + custom instructions monthly.** Stale or contradicting rules = hallucinations.
  4. **Use Projects for recurring work.** Per-project instructions + files beat re-typing context every chat.
  5. **Edit memory, don't trust it blindly.** Both ChatGPT and Claude let you view/edit/delete — do it.
- [ ] **Slide 10 (negative prompts bonus):** Wegner's white bear (1987) — tell people "don't think of a white bear" and they think of one more. Ski instructors don't say "don't fall" — they say "look where you want to go." Same with AI: Anthropic's official guidance is *"Tell Claude what to do instead of what not to do."* Show before/after: "Don't use markdown" → "Respond in flowing prose paragraphs." Flag honestly: human ironic process and LLM negative prompting have different mechanisms but the same outcome — positive framing is more reliable.
- [ ] **Slide 11 (closing):** "Your AI is only as good as the context you give it. Curate it like you'd brief a new hire on Day 1." Optional: list of links — research file, Anthropic context engineering post, Karpathy tweet.
- [ ] **Verify:** Run `pnpm dev`, walk through end-to-end, time yourself with a phone timer — confirm under 10 min including pauses for questions. Aim for ~8 min content + 2 min Q&A buffer. Commit: `feat(context-engineering): write slide content`.

---

## Phase 3 — Polish, build, deploy

- [ ] **Visual polish.** Verify minimal design (clean lines, limited color palette — match `second-brain` deck's aesthetic). Use Apple HIG iOS system colors per vault preferences if accents needed (Indigo `#5856d6` for Dev/AI, Mint `#00c7be` for Mgmt). Avoid emoji unless adding intentionally.
- [ ] **Speaker notes.** Add `<!-- speaker note -->` blocks on every content slide with what to actually say — Ali tends to skip rehearsal, so written notes are the safety net.
- [ ] **Rehearse + time once.** Read through with a phone timer. If over 10 min, cut Slide 6 (merge into Slide 5) or trim Slide 8 to a one-liner. If under 7, expand the "Hi" example with a real screenshot from Ali's own chat.
- [ ] **Build the full repo.** `cd ~/Downloads/Coding/personal/talks && pnpm build` — verify `dist/context-engineering/` builds and lands on the landing page. Verify the second-brain deck still works (no regressions in build.sh stitching).
- [ ] **Commit + push.** Two commits ideally: `feat(context-engineering): polish + speaker notes` and `feat: deploy context-engineering deck`. Push triggers Vercel auto-rebuild → talks.aliirani.com/context-engineering/.
- [ ] **Verify deploy.** Open talks.aliirani.com/context-engineering/ in a browser, click through every slide, confirm fonts/transitions render correctly on Vercel.
- [ ] **Slack confirm with Reza.** Reply in the DM thread with the deployed URL: "Deck ready — talks.aliirani.com/context-engineering/. Will run through it on Tuesday." Use the `slack-cli` skill, do not send without showing the draft first.

---

## Decisions Made

| Decision | Rationale |
|---|---|
| Slidev deck (not Google Slides / HTML one-off) | Repo already exists at `~/Downloads/Coding/personal/talks/`, Vercel auto-deploys, `second-brain` deck works as reference. Markdown-first matches Ali's workflow. |
| 10–11 slides (not 6, not 20) | 10 min ≈ 1 min/slide for non-technical talk with pauses. Matches `second-brain` deck pacing. |
| Lead with "the problem" before the framing | Audience is non-technical and frustrated with AI — start with their pain, not Karpathy's tweet. |
| Include negative-prompt bonus slide | Reza explicitly asked about it in the DM; Wegner's white bear is vivid and honors his ski/pilot reference. |
| Cover Claude Cowork separately or merge with Claude.ai? | **Merge.** Most of the team uses claude.ai chat + Projects, not the Desktop VM product. One slide for "Claude vs ChatGPT" is cleaner than three. |
| Don't address subtask 11 (team Q&A → Dhanishta/Yalda/Kasra/Reza credit problem) in this talk | These are next-spotlight prep notes, not in-scope for the 10-min talk. Will track separately if Reza wants a follow-up session. |

---

## Errors Encountered

| Error | Attempt | Resolution |
|---|---|---|
| _(none yet)_ | | |
