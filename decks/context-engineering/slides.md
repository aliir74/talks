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
---

<div style="max-width: 760px; margin: 0 auto; text-align: center;">
  <p style="font-size: 2rem; font-weight: 600; line-height: 1.45; color: #111827;">
    Why does my AI chat get<br>
    <span class="accent">worse</span> the longer it gets?
  </p>
  <div class="rule" style="margin: 1.5rem auto;"></div>
  <p class="dim" style="font-size: 1.15rem; line-height: 1.7;">
    You start strong. By message 30 it's forgetting things,<br>
    repeating itself, or just&hellip; missing the point.
  </p>
  <p style="font-size: 1.1rem; font-weight: 600; color: #5856d6; margin-top: 1.5rem;">
    This is happening to most of us.
  </p>
</div>

<!--
Open with the question the team has actually asked. Pause. Let it land. "Raise your hand if a long ChatGPT or Claude chat has ever gotten worse the longer you used it." Then transition: it's not the model — it's the context.
-->

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

<div class="section-header">
  <h1>What's actually in the context window</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.75rem;">Everything below gets sent to the model on every message — not just what you typed.</p>

<div class="context-bar">
  <div class="context-seg" style="background: #1e3a8a; flex: 14;">System<br>Prompt</div>
  <div class="context-seg" style="background: #2563eb; flex: 28;">Conversation History</div>
  <div class="context-seg" style="background: #5856d6; flex: 14;">Memory</div>
  <div class="context-seg" style="background: #7c3aed; flex: 14;">Retrieved<br>Docs / Files</div>
  <div class="context-seg" style="background: #9333ea; flex: 12;">Tools</div>
  <div class="context-seg" style="background: #c026d3; flex: 17;">Tool Results</div>
  <div class="context-seg" style="background: #db2777; flex: 1;" title="Your prompt">You</div>
</div>

<p class="dim" style="margin-top: 1rem; font-size: 0.95rem; text-align: right;">
  &larr; that thin pink sliver on the right is what you actually typed.
</p>

<div class="callout" style="margin-top: 1.5rem; font-size: 1.05rem;">
  Your message is maybe <strong>1%</strong> of what the model reads. The other 99% is&hellip; everything else.
</div>

<!--
The big realization for non-engineers: when you say "Hi" to Claude, the model doesn't see "Hi". It sees a giant document — system prompt, all your past messages, memory, attached files, tool results — and your "Hi" at the very end. That's why two identical prompts in two different chats give wildly different answers.
-->

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

<div class="section-header">
  <h1>&hellip;but too much also hurts</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">More context isn't always better. Three findings from 2024–2025 research:</p>

<div class="item-row">
  <div class="item-num">1</div>
  <div>
    <strong>Lost in the Middle</strong> <span class="dim">— Liu et al., Stanford</span><br>
    <span class="compare-text">Performance is U-shaped. Models pay attention to the start and end, and miss things buried in the middle.</span>
  </div>
</div>

<div class="item-row">
  <div class="item-num">2</div>
  <div>
    <strong>Context Rot</strong> <span class="dim">— Chroma, 18 frontier models tested</span><br>
    <span class="compare-text"><em>All</em> models degrade as input grows — even when the window isn't full.</span>
  </div>
</div>

<div class="item-row">
  <div class="item-num">3</div>
  <div>
    <strong>The 39% multi-turn drop</strong> <span class="dim">— Microsoft &times; Salesforce, May 2025</span><br>
    <span class="compare-text">"When models made wrong assumptions early, they rarely corrected themselves."</span>
  </div>
</div>

<div class="callout" style="margin-top: 1.5rem; font-size: 1.05rem;">
  Bloated history + stale memory + contradicting instructions <span style="color: #6b7280;">("follow A &rarr; ignore A, follow B")</span> = <span class="bad">recipe for hallucinations</span>.
</div>

<!--
Counter-intuitive part: if more context were always better, we'd just paste everything. Doesn't work. Long chats accumulate noise; the model latches onto an early wrong assumption and never recovers. This is why "starting a new chat" so often fixes things.
-->

---

<div class="section-header">
  <h1>Claude vs ChatGPT: how they remember</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">Both auto-synthesize memory now. They just show you different amounts.</p>

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
  <div>
    <p class="tag">ChatGPT memory</p>
    <ul style="margin-top: 0.75rem; line-height: 1.8; color: #374151; font-size: 1rem; padding-left: 1.2rem;">
      <li>Silent auto-injection</li>
      <li>AI-decided summaries</li>
      <li>Lower-maintenance</li>
      <li>Less auditable</li>
    </ul>
  </div>
  <div>
    <p class="tag">Claude memory</p>
    <ul style="margin-top: 0.75rem; line-height: 1.8; color: #374151; font-size: 1rem; padding-left: 1.2rem;">
      <li>Visible tool calls</li>
      <li>User-editable</li>
      <li>Transparent — you see what it remembers</li>
      <li>Auto-synthesizes <span class="dim">(since March 2026)</span></li>
    </ul>
  </div>
</div>

<div class="callout" style="margin-top: 1.5rem; font-size: 1rem;">
  <strong>Tip:</strong> Use <span class="accent">Projects</span> on either platform &mdash; instructions + files scoped to the work, not your whole life.<br>
  ChatGPT also has <span class="accent">project-only memory mode</span> to keep things contained.
</div>

<!--
The old framing "Claude is fully manual, ChatGPT is automatic" is outdated as of March 2026. Both auto-sync now. The real difference is transparency — Claude shows you the memory tool calls; ChatGPT does it silently.
-->

---

<div class="section-header">
  <h1>5 habits to take home</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">What to do differently Monday morning.</p>

<div class="item-row">
  <div class="item-num">1</div>
  <div><strong>One topic per chat.</strong> <span class="compare-text">Switching mid-chat is the #1 cause of bad output.</span></div>
</div>

<div class="item-row">
  <div class="item-num">2</div>
  <div><strong>Front-load what matters.</strong> <span class="compare-text">Most important info at the top or bottom — never buried in the middle.</span></div>
</div>

<div class="item-row">
  <div class="item-num">3</div>
  <div><strong>Prune memory monthly.</strong> <span class="compare-text">Stale or contradicting rules quietly poison every new chat.</span></div>
</div>

<div class="item-row">
  <div class="item-num">4</div>
  <div><strong>Use Projects for recurring work.</strong> <span class="compare-text">Per-project instructions + files beat re-typing context every time.</span></div>
</div>

<div class="item-row">
  <div class="item-num">5</div>
  <div><strong>Edit memory, don't trust it blindly.</strong> <span class="compare-text">Both ChatGPT and Claude let you view/edit/delete — actually do it.</span></div>
</div>

<!--
This is the take-home. If you remember nothing else from this talk, remember: one topic per chat, and prune your memory. Those two alone will make AI feel sharper for everyone.
-->

---

<div class="section-header">
  <h1>Bonus: tell it what to do</h1>
</div>

<p class="dim" style="margin-top: 0.5rem; margin-bottom: 1.5rem;">"Don't think of a white bear." &mdash; Daniel Wegner, 1987</p>

<p class="story" style="margin-bottom: 1rem;">
  Tell people <em>not</em> to think of something, and they think of it more. Ski instructors don't say "don't fall" — they say <strong>"look where you want to go"</strong>.
</p>

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 1.5rem;">
  <div>
    <p class="compare-label-red">Negative prompt</p>
    <p class="compare-text" style="font-family: 'Fira Code', monospace; font-size: 0.95rem;">"Don't use markdown.<br>Don't be too formal.<br>Don't list things."</p>
  </div>
  <div>
    <p class="compare-label-green">Positive prompt</p>
    <p class="compare-text" style="font-family: 'Fira Code', monospace; font-size: 0.95rem;">"Respond in flowing prose paragraphs, in a casual conversational tone."</p>
  </div>
</div>

<p class="callout" style="margin-top: 1.75rem; font-size: 1rem;">
  Anthropic's own guidance: <em>"Tell Claude what to do instead of what not to do."</em> Positive framing is more reliable.
</p>

<!--
Honest framing: human ironic process and LLM negative prompting work via different mechanisms. Same outcome though — describe what you want, not what you don't want. Reza asked for this one specifically.
-->

---
layout: center
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
  <p style="margin-top: 2.5rem; font-size: 1.2rem; font-weight: 600; color: #5856d6;">
    Questions?
  </p>
</div>

<!--
Land the closing. Pause. Open the floor. If someone asks "but how do I actually start a Project?" — that's the right kind of question. Walk them through it live if there's time.
-->
