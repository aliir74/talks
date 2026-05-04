---
title: "Context Engineering — Speaker Notes"
created: 2026-05-04
---

# Speaker Notes & Presentation Guide

## Overview
- **Duration:** 10 minutes
- **Audience:** OVOU team (mostly non-technical, daily ChatGPT/Claude users)
- **Format:** Slidev presentation, online company call
- **Core message:** The model isn't the bottleneck anymore — the context you give it is. Five small habits will make AI feel sharper for everyone.

## Slide Flow (11 slides)

| # | Slide | Time | Key Point |
|---|-------|------|-----------|
| 1 | Title | — | Settle the room. Calm. |
| 2 | "Why does my chat get worse?" | ~30s | Pause. Let it land. Look up. |
| 3 | Prompt → Context Engineering | ~1 min | The shift. Karpathy/Lütke. |
| 4 | Anatomy of context | ~1 min | The bar diagram. "Your message is 1%." |
| 5 | "Hi" — same prompt, different result | ~1 min | The turning-point slide. |
| 6 | Too little context | ~45s | Calendar example. Robot vs assistant. |
| 7 | Too much context | ~1.5 min | Three findings. Bottom line: hallucinations. |
| 8 | Claude vs ChatGPT memory | ~1 min | Both auto-sync now. Use Projects. |
| 9 | 5 habits to take home | ~1.5 min | The takeaway. Slow down here. |
| 10 | Bonus: tell it what to do | ~45s | White bear. (Q&A request from a teammate.) |
| 11 | Closing | ~30s | "Brief it like a new hire." Q&A. |

Total: ~9.5 min content + buffer for questions.

---

## Slide-by-slide notes

### 1. Title
Open simply: "Today I want to talk about something that's quietly changed how I use AI — context engineering. It's a buzzy term, but it boils down to five practical habits I think will help everyone."

### 2. The problem
Read the question out loud. Pause 2 seconds. "Show of hands — how many of you have had a long ChatGPT or Claude chat that got progressively worse the longer you used it?"

Wait for the hands. "Yeah. This is happening to most of us. And it's not because the AI got dumber halfway through — it's because the context did."

### 3. Prompt → Context Engineering
"A year ago we were all writing 'prompts' — clever instructions. Andrej Karpathy, who basically invented this field, started using a different term this year: **context engineering**."

Read the right side: "the delicate art of filling the context window with just the right information at just the right time."

Then read Schmid: "Most agent failures are not model failures anymore — they are context failures."

"That's the whole talk in one line."

### 4. Anatomy of context
Point at the bar. "When you type 'Hi' to Claude, this is what the model actually reads. System prompt at the start. All your past messages. Memory. Files you uploaded. Tool calls and their results. And that thin pink sliver on the right? That's your message."

"Your prompt is maybe 1% of what the model sees. The other 99% is everything we don't normally think about. Context engineering is just being intentional about that 99%."

### 5. The "Hi" example
"Same word, same model, two completely different answers." Read the boxes. "On the left it doesn't know me. On the right it has my project files, my memory, our last conversation — and it picks up exactly where we left off."

"This is why some people swear AI changed their life and others think it's overhyped. Same model. Different context."

### 6. Too little hurts
"If you ask plain ChatGPT to schedule a coffee, it'll say 'I can't access your calendar.' That's not stupidity — that's missing context. Connect a calendar, give it your inbox, tell it the timezone, and suddenly it's the assistant we all wanted."

### 7. Too much hurts
**Don't read the bullets word-for-word — paraphrase.**

"This is the surprising one. More context isn't always better."

1. **Lost in the middle**: "Stanford research — models pay attention to the start and end. Bury something on page 5 and they miss it."
2. **Context Rot**: "Chroma tested 18 frontier models earlier this year. *All* of them got worse as the input got longer. Not at the limit — way before."
3. **39% drop**: "Microsoft and Salesforce, May last year. When models made wrong assumptions early, they almost never corrected themselves later."

"This is why starting a new chat often fixes things. The old chat is poisoned with stale assumptions."

### 8. Claude vs ChatGPT memory
"Quick comparison. Both have memory now. Both auto-synthesize. The difference is **transparency**."

"ChatGPT silently injects what it thinks you'll need. Claude actually shows you the memory tool calls — you can see what it remembered, edit it, delete it."

"Either way: **use Projects.** Don't dump everything into one mega-chat. Per-project memory is night and day."

### 9. 5 habits to take home
**The most important slide. Don't rush.**

Walk through each one:

1. **One topic per chat.** "Switching topics mid-chat is the single biggest cause of bad output. New topic → new chat. Cheap and free."
2. **Front-load what matters.** "Lost in the middle is real. Important stuff goes first or last — never buried."
3. **Prune memory monthly.** "Open ChatGPT settings → memory. Open Claude memory. Read it. You'll be horrified at what's in there. Delete the stale stuff."
4. **Use Projects.** "Anything you do repeatedly — partnerships emails, weekly reviews, design feedback — make it a Project. Per-project instructions and files do half the work for you."
5. **Edit memory, don't trust it blindly.** "Both tools let you view and edit the saved memory. Actually do it. The AI's idea of 'what's important' is not always yours."

### 10. Bonus: tell it what to do
"Quick one a teammate asked about. Daniel Wegner, 1987 — tell people 'don't think of a white bear' and they think of one more. Ski instructors don't say 'don't fall' — they say 'look where you want to go.'"

"Same with AI. 'Don't use markdown' is worse than 'respond in flowing paragraphs.' Anthropic's own guidance: tell it what to do instead of what not to do."

"Honest caveat — humans and LLMs do this for different reasons. But the outcome is the same: positive framing wins."

### 11. Closing
"Your AI is only as good as the context you give it. Curate it like you'd brief a new hire on Day 1 — what they need, what they don't, and where to find the rest."

"Questions?"

---

## If running long

- Cut slide 6 (merge the calendar example as a one-liner into slide 5).
- Shorten slide 8 to a single sentence: "Both have memory; use Projects."

## If running short

- Expand the "Hi" example with a real screenshot from your own Claude.
- Add a live demo: open a Claude Project, show what the memory tool calls look like.

## Things to remember

- Pause after slide 2's question. The audience needs to feel the recognition.
- Don't read slide 7's bullets verbatim — paraphrase.
- Slide 9 is the one slide they should photograph. Slow down. Land each habit.
