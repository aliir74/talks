---
theme: default
title: Context Engineering
info: OVOU Spotlight — Ali Irani
author: Ali Irani
transition: fade
mdc: true
fonts:
  sans: Inter
  mono: Fira Code
---

<div class="flex flex-col justify-center h-full pl-2">
  <div class="rule"></div>
  <h1 style="font-size: 3rem; margin-top: 0.75rem; margin-bottom: 0;">
    Context Engineering
  </h1>
  <p class="dim" style="margin-top: 0.5rem; font-size: 1.4rem;">Getting more out of AI</p>
  <p class="dim" style="margin-top: 1.5rem; font-size: 1.1rem;">Ali Irani · OVOU Spotlight</p>
</div>

<!--
Calm. Casual. Today: why our AI chats sometimes feel magical and sometimes useless — and what to do about it.
-->

---
layout: center
title: The problem
---

<div style="max-width: 880px; margin: 0 auto;">
  <p style="font-size: 1.9rem; font-weight: 600; line-height: 1.45; color: #111827; text-align: center;">
    Why does my AI chat get<br>
    <span class="accent">worse</span> the longer it gets?
  </p>
  <div class="rule" style="margin: 1.25rem auto;"></div>
  <div style="display: grid; grid-template-columns: 150px 460px; gap: 0; align-items: stretch; justify-content: center; margin-top: 1.5rem;">
    <img src="./meme-drake.jpg" style="height: 220px; width: 150px; object-fit: cover; object-position: 25% center; border-radius: 8px 0 0 8px;" />
    <div style="display: grid; grid-template-rows: 1fr 1fr; gap: 0;">
      <div style="display: flex; align-items: center; padding: 0.6rem 1rem; background: #fef2f2; border-left: 3px solid #ef4444; border-radius: 0 8px 0 0;">
        <span style="font-weight: 600; color: #111827;">Starting a fresh chat</span>
      </div>
      <div style="display: flex; align-items: center; padding: 0.6rem 1rem; background: #ccfbf1; border-left: 3px solid #0d9488; border-radius: 0 0 8px 0;">
        <span style="font-weight: 600; color: #111827;">Forcing a 200-message thread to behave</span>
      </div>
    </div>
  </div>
  <p style="font-size: 1.05rem; font-weight: 600; color: #0d9488; margin-top: 1.5rem; text-align: center;">
    This is happening to most of us.
  </p>
</div>

<!--
Open with the question the team has actually asked. Pause. Let it land. "Raise your hand if a long ChatGPT or Claude chat has ever gotten worse the longer you used it." Then transition: it's not the model — it's the context.
-->

---
title: Prompt → Context Engineering
---

<div class="section-header">
  <h1>Prompt &rarr; Context Engineering</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">The shift everyone in AI is talking about</p>

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 1rem;">
  <div>
    <p class="compare-label-red">Prompt engineering</p>
    <p class="compare-text">Crafting one clever instruction.</p>
    <p class="compare-text" style="margin-top: 0.5rem; color: #6b7280;">"Write me a poem about cats, in the style of Rumi."</p>
  </div>
  <div>
    <p class="compare-label-green">Context engineering</p>
    <p class="compare-text">The delicate art of filling the context window with <strong>just the right information</strong> at <strong>just the right time</strong>.</p>
  </div>
</div>

<div class="callout" style="margin-top: 2rem;">
  "Most agent failures are not model failures anymore — they are <span class="accent">context failures</span>."
  <div class="quote-attr">— Philipp Schmid, Google DeepMind</div>
</div>

<!--
Andrej Karpathy and Tobi Lütke (Shopify CEO) both started using "context engineering" instead of "prompt engineering" earlier this year. The point: the model is good. What we feed it is what's failing.
-->

---
title: Anatomy of the context window
---

<div class="section-header">
  <h1>What's actually in the context window</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.75rem;">Everything below gets sent to the model on every message — not just what you typed.</p>

<div class="context-bar">
  <div class="context-seg" style="background: #134e4a; flex: 14;">System<br>Prompt</div>
  <div class="context-seg" style="background: #0f766e; flex: 28;">Conversation History</div>
  <div class="context-seg" style="background: #0d9488; flex: 14;">Memory</div>
  <div class="context-seg" style="background: #14b8a6; flex: 14;">Retrieved<br>Docs / Files</div>
  <div class="context-seg" style="background: #2dd4bf; flex: 12; color: #134e4a;">Tools</div>
  <div class="context-seg" style="background: #5eead4; flex: 17; color: #134e4a;">Tool Results</div>
  <div class="context-seg" style="background: #ef4444; flex: 1;" title="Your prompt">You</div>
</div>

<p class="dim" style="margin-top: 1rem; font-size: 0.95rem; text-align: right;">
  That small red sliver on the right? <strong>That's what you actually typed.</strong>
</p>

<div class="callout" style="margin-top: 1.5rem; display: flex; gap: 1.5rem; align-items: center;">
  <img src="./iceberg.jpg" style="height: 140px; border-radius: 6px; flex-shrink: 0;" />
  <div style="font-size: 1.05rem;">Your message is maybe <strong>1%</strong> of what the model reads &mdash; the tip of the iceberg. The other 99% is everything underneath.</div>
</div>

<!--
The big realization for non-engineers: when you say "Hi" to Claude, the model doesn't see "Hi". It sees a giant document — system prompt, all your past messages, memory, attached files, tool results — and your "Hi" at the very end. That's why two identical prompts in two different chats give wildly different answers.
-->

---
title: Same prompt, different result
---

<div class="section-header">
  <h1>Same prompt. Same model. Different result.</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">Both chats: I just typed <strong>"Hi"</strong>.</p>

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
  <div>
    <p class="compare-label-red">Blank chat</p>
    <div style="border: 1px solid #e5e7eb; border-radius: 8px; padding: 1rem; background: #f9fafb;">
      <p style="font-size: 0.9rem; color: #6b7280;">You: <strong style="color: #111827;">Hi</strong></p>
      <p style="font-size: 0.95rem; color: #374151; margin-top: 0.5rem; line-height: 1.5;">
        Claude: Hello! How can I help you today?
      </p>
    </div>
  </div>
  <div>
    <p class="compare-label-green">Inside a Project (memory + files loaded)</p>
    <div style="border: 1px solid #e5e7eb; border-radius: 8px; padding: 1rem; background: #f9fafb;">
      <p style="font-size: 0.9rem; color: #6b7280;">You: <strong style="color: #111827;">Hi</strong></p>
      <p style="font-size: 0.95rem; color: #374151; margin-top: 0.5rem; line-height: 1.5;">
        Claude: Hi Ali — last time we left off on the Q3 roadmap. Want to keep working on the partnerships section, or look at the budget questions you raised in your note yesterday?
      </p>
    </div>
  </div>
</div>

<p class="callout" style="margin-top: 2rem; font-size: 1.15rem;">
  Same prompt. Same model. <span class="accent">Completely different usefulness.</span>
</p>

<!--
The difference isn't the model getting smarter. It's everything else loaded into the context: memory, project files, your past chats. That's context engineering.
-->

---
title: Too little context
---

<div class="section-header">
  <h1>Too little context &rarr; the robot answer</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">"Hey, schedule a coffee with Reza Thursday."</p>

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
  <div>
    <p class="compare-label-red">No context</p>
    <p class="compare-text">"I don't have access to your calendar."</p>
    <p class="compare-text" style="margin-top: 0.5rem; color: #6b7280; font-size: 0.95rem;">Useless. You knew that.</p>
  </div>
  <div>
    <p class="compare-label-green">Calendar + emails + timezone loaded</p>
    <p class="compare-text">"Reza's free Thursday 10 AM your time. He flagged the partnerships email yesterday — I'll add that as the topic. Sending the invite."</p>
  </div>
</div>

<p class="callout" style="margin-top: 2rem;">
  The model didn't get smarter. <span class="accent">It got the right context.</span>
</p>

<!--
Schmid's example. The "AI as personal assistant" dream isn't blocked by intelligence — it's blocked by the AI not having the context a human assistant would. Connect tools, give it docs, and it stops being a robot.
-->

---
title: Too much context also hurts
---

<div class="section-header">
  <h1>&hellip;but too much also hurts</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.25rem;">More context isn't always better.</p>

<div style="display: grid; grid-template-columns: 1.4fr 1fr; gap: 1.5rem; align-items: center;">
  <div>
    <div class="item-row">
      <div class="item-num">1</div>
      <div><strong>Lost in the Middle.</strong> <span class="compare-text">Models pay attention to the start and end &mdash; and miss what's buried in between.</span></div>
    </div>
    <div class="item-row">
      <div class="item-num">2</div>
      <div><strong>Context Rot.</strong> <span class="compare-text">All 18 frontier models tested degrade as input grows.</span></div>
    </div>
    <div class="item-row">
      <div class="item-num">3</div>
      <div><strong>Wrong early &rarr; wrong forever.</strong> <span class="compare-text">39% drop on multi-turn tasks &mdash; bad early assumptions rarely get corrected.</span></div>
    </div>
    <div class="item-row">
      <div class="item-num">4</div>
      <div><strong>Bigger bills, faster limits.</strong> <span class="compare-text">Every turn re-sends the whole chat.</span></div>
    </div>
  </div>
  <div style="text-align: center;">
    <img src="./meme-spiderman.jpg" style="max-width: 100%; max-height: 200px; border-radius: 8px;" />
    <p class="dim" style="font-size: 0.8rem; margin-top: 0.4rem;">your context, contradicting itself</p>
  </div>
</div>

<!--
Counter-intuitive part: if more context were always better, we'd just paste everything. Doesn't work. Long chats accumulate noise; the model latches onto an early wrong assumption and never recovers. This is why "starting a new chat" so often fixes things.
-->

---
title: How Claude memory works
---

<div class="section-header">
  <h1>Claude memory: visible, editable, scoped</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">Across Claude.ai chat, Cowork, and Code &mdash; same memory model.</p>

<div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.5rem;">
  <div>
    <p class="tag">Visible</p>
    <p class="compare-text" style="margin-top: 0.6rem;">Memory writes show up as tool calls in the chat &mdash; you see exactly what Claude saved, when.</p>
  </div>
  <div>
    <p class="tag">Editable</p>
    <p class="compare-text" style="margin-top: 0.6rem;">View, edit, or delete anything in your memory anytime. The AI's idea of "important" isn't always yours.</p>
  </div>
  <div>
    <p class="tag">Scoped</p>
    <p class="compare-text" style="margin-top: 0.6rem;">Per-Project in chat. Per-folder via <code>CLAUDE.md</code> in Cowork/Code. Not one giant pile.</p>
  </div>
</div>

<div class="callout" style="margin-top: 1.5rem; font-size: 1rem;">
  <strong>Audit it.</strong> Open <span class="accent">/memory</span> in Code, or the memory tab in Claude.ai. Stale rules quietly poison every new chat.
</div>

<!--
Three properties: visible (you see the tool calls), editable (you can change them), scoped (per-project / per-CLAUDE.md). Auto-synthesizes since March 2026 — Claude decides when to write, but it's transparent. Audit monthly so old rules don't fight new ones.
-->

---
title: Build context once, reuse it
---

<div class="section-header">
  <h1>Build context once. Reuse it everywhere.</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">Three patterns &mdash; pick the one that matches how you work.</p>

<div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.25rem;">
  <div>
    <p class="tag">Projects</p>
    <p class="dim" style="font-size: 0.78rem; margin-top: 0.25rem;">Claude.ai chat</p>
    <ul style="margin-top: 0.5rem; line-height: 1.6; color: #374151; font-size: 0.9rem; padding-left: 1.1rem;">
      <li>System instructions per project</li>
      <li>Files attached once, used everywhere inside</li>
      <li>Memory scoped &mdash; not your whole life</li>
    </ul>
  </div>
  <div>
    <p class="tag">CLAUDE.md</p>
    <p class="dim" style="font-size: 0.78rem; margin-top: 0.25rem;">Cowork &amp; Code</p>
    <ul style="margin-top: 0.5rem; line-height: 1.6; color: #374151; font-size: 0.9rem; padding-left: 1.1rem;">
      <li>Lives in your repo/folder &mdash; travels with the work</li>
      <li>Version-controlled, shared with teammates</li>
      <li>Loaded automatically every session</li>
    </ul>
  </div>
  <div>
    <p class="tag">Skills + Slash Commands</p>
    <p class="dim" style="font-size: 0.78rem; margin-top: 0.25rem;">Cowork &amp; Code</p>
    <ul style="margin-top: 0.5rem; line-height: 1.6; color: #374151; font-size: 0.9rem; padding-left: 1.1rem;">
      <li>Package a repeat task into one command</li>
      <li>Loads just the context it needs</li>
    </ul>
    <div style="margin-top: 0.4rem; font-family: 'Fira Code', monospace; font-size: 0.82rem; color: #0d9488;">
      /remember<br>/learn-from<br>/wrap-up
    </div>
  </div>
</div>

<div class="callout" style="margin-top: 1.5rem; font-size: 0.98rem;">
  The win: <span class="accent">write context once, Claude loads it for you.</span> No more re-typing "here's who I am, here's what we're working on" every session.
</div>

<!--
Three patterns. Projects = chat with scope. CLAUDE.md = repo-level context that travels and is shared with teammates (we have these in OVOU repos already). Skills/slash commands = packaged workflows. The /remember /learn-from /wrap-up examples are real ones I use daily.
-->

---
title: Try this week
---

<div class="section-header">
  <h1>Try this week</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">Three concrete things you can do this week. None take more than 15 minutes.</p>

<div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.5rem;">
  <div style="border-left: 3px solid #0d9488; padding-left: 1rem;">
    <p class="tag">2 min</p>
    <p style="font-weight: 700; font-size: 1.05rem; margin-top: 0.5rem; color: #111827;">Audit your memory</p>
    <p class="compare-text" style="margin-top: 0.5rem; font-size: 0.92rem;">In Claude.ai, open the memory tab. In Claude Code, run <code style="background: #f3f4f6; padding: 0.05rem 0.3rem; border-radius: 3px; font-size: 0.85rem;">/memory</code>. Read what's there. <strong>Delete the stale stuff.</strong></p>
  </div>
  <div style="border-left: 3px solid #0d9488; padding-left: 1rem;">
    <p class="tag">10 min</p>
    <p style="font-weight: 700; font-size: 1.05rem; margin-top: 0.5rem; color: #111827;">Set up a CLAUDE.md</p>
    <p class="compare-text" style="margin-top: 0.5rem; font-size: 0.92rem;">Drop a <code style="background: #f3f4f6; padding: 0.05rem 0.3rem; border-radius: 3px; font-size: 0.85rem;">CLAUDE.md</code> in your most-active repo or folder. Two paragraphs: what the project is, your conventions. Cowork/Code loads it automatically every session.</p>
  </div>
  <div style="border-left: 3px solid #0d9488; padding-left: 1rem;">
    <p class="tag">15 min</p>
    <p style="font-weight: 700; font-size: 1.05rem; margin-top: 0.5rem; color: #111827;">Write one slash command</p>
    <p class="compare-text" style="margin-top: 0.5rem; font-size: 0.92rem;">Pick a task you do weekly &mdash; standup notes, MR review, design feedback. Package the prompt + context as a slash command. Run it next week with one keystroke.</p>
  </div>
</div>

<div class="callout" style="margin-top: 1.5rem; font-size: 0.95rem;">
  <strong>Speaker rules of thumb:</strong> one topic per chat &middot; front-load what matters &middot; prune memory monthly &middot; trust nothing the AI remembered without checking.
</div>

<!--
The take-home. Three concrete actions, not advice. If they only do one, audit memory — costs nothing, fixes the slow bleed of stale rules. The CLAUDE.md is the most leveraged: it benefits the whole team because it's version-controlled.
The five rules-of-thumb stay as the verbal closing — read them aloud as a pacing device.
-->


---
title: Bonus — tell it what to do
---

<div class="section-header">
  <h1>Bonus: tell it what to do</h1>
</div>

<div style="display: grid; grid-template-columns: 1.4fr 1fr; gap: 1.5rem; align-items: center; margin-top: 0.75rem;">
  <div>
    <p class="dim" style="margin-bottom: 0.4rem; font-size: 0.95rem;">"Don't think of a white bear." &mdash; Daniel Wegner, 1987</p>
    <p class="story" style="font-size: 1rem; line-height: 1.65;">
      Tell people <em>not</em> to think of something, and they think of it more.
    </p>
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-top: 0.75rem;">
      <div>
        <p class="compare-label-red">Negative</p>
        <p class="compare-text" style="font-family: 'Fira Code', monospace; font-size: 0.85rem;">"Don't use markdown."</p>
      </div>
      <div>
        <p class="compare-label-green">Positive</p>
        <p class="compare-text" style="font-family: 'Fira Code', monospace; font-size: 0.85rem;">"Respond in flowing prose."</p>
      </div>
    </div>
    <p class="callout" style="margin-top: 0.75rem; font-size: 0.9rem;">
      Anthropic's guidance: <em>"Tell Claude what to do instead of what not to do."</em>
    </p>
  </div>
  <div style="display: flex; flex-direction: column; align-items: center;">
    <img src="./polar-bear.jpg" style="max-height: 220px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);" />
    <p class="dim" style="font-size: 0.8rem; margin-top: 0.4rem; text-align: center; max-width: 240px;">&uarr; you're thinking about it now, aren't you?</p>
  </div>
</div>

<!--
Honest framing: human ironic process and LLM negative prompting work via different mechanisms. Same outcome though — describe what you want, not what you don't want. Reza asked for this one specifically.
-->

---
layout: center
title: Closing
---

<div style="max-width: 760px; margin: 0 auto; text-align: center;">
  <div class="rule" style="margin: 0 auto 1.5rem;"></div>
  <p style="font-size: 1.9rem; font-weight: 600; line-height: 1.5; color: #111827;">
    Your AI is only as good as<br>
    <span class="accent">the context you give it.</span>
  </p>
  <p class="dim" style="margin-top: 1.5rem; font-size: 1.15rem; line-height: 1.7;">
    Curate it like you'd brief a new hire on Day 1.
  </p>
  <p style="margin-top: 2.5rem; font-size: 1.2rem; font-weight: 600; color: #0d9488;">
    Questions?
  </p>
</div>

<!--
Land the closing. Pause. Open the floor. If someone asks "but how do I actually start a Project?" — that's the right kind of question. Walk them through it live if there's time.
-->
