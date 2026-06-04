# Agent OS Launch Plan

## Purpose

This document defines the public launch plan for Agent OS.

It is intended to guide Codex and the repository maintainer through:

* final repository checks
* Medium publication
* LinkedIn launch posts
* Italian and English content coordination
* cross-posting strategy
* feedback collection
* follow-up tasks

The goal is not just to publish an article.

The goal is to drive qualified attention to the Agent OS repository and collect real feedback from people using AI agents on real engineering work.

---

# Launch Thesis

Main positioning:

> AI agents are getting better at execution. What is missing is a shared operating model for judgment.

Agent OS should be presented as:

* model-agnostic
* lifecycle-first
* documentation-first
* governance-aware
* currently in active validation
* open to critique and real-world experiments

Agent OS should not be presented as:

* a finished product
* a runtime
* a wrapper
* an automation framework
* a prompt trick collection
* a silver bullet

---

# Core Links

Repository:

```text
https://github.com/ignazio-ingenito/agent-os
```

English article source:

```text
docs/articles/medium-agent-os.md
```

Italian article source:

```text
docs/articles/medium-agent-os.it.md
```

Article assets:

```text
docs/articles/assets/
```

---

# Phase 1 — Repository Readiness

## Goal

Make sure the GitHub repository is ready before sending traffic to it.

## Instructions for Codex

Check the repository state and report whether it is ready for public promotion.

Do not modify files unless explicitly asked.

## Checklist

### Git state

Run:

```bash
git status
git log --oneline --decorate -5
```

Expected:

* working tree clean
* latest commits include article preparation
* no untracked article assets
* no local-only draft files accidentally left untracked

### GitHub metadata

Check:

```bash
gh repo view ignazio-ingenito/agent-os
```

Expected:

* repository is public
* description is present
* topics are present
* README renders correctly

Recommended description:

```text
A lifecycle-first operating system for AI-assisted engineering, architecture, research, UX, infrastructure, and decision-making.
```

Recommended topics:

```text
ai-agents
agentic-ai
software-engineering
developer-tools
codex
claude-code
ai-engineering
architecture
devops
knowledge-management
```

### License

Check:

```bash
ls -la LICENSE
```

Expected:

* `LICENSE` exists
* license is suitable for open source publication

Recommended license:

```text
MIT
```

### README

Check:

* English README exists
* Italian README exists
* language links work
* hero positioning is clear
* repository description is understandable in the first screen
* images render correctly
* no broken relative links

---

# Phase 2 — Article Readiness

## Goal

Make sure both Medium articles are clean and ready to publish.

## Instructions for Codex

Review both article files.

Do not rewrite the article.

Only report blocking issues, obvious publication problems, or broken links.

## English article checklist

File:

```text
docs/articles/medium-agent-os.md
```

Run:

```bash
grep -n "Suggested image\|Image prompt\|/IMAGE\|IMAGE:" docs/articles/medium-agent-os.md
grep -n "Italian version" docs/articles/medium-agent-os.md
grep -n "A star is welcome" docs/articles/medium-agent-os.md
```

Expected:

* no internal image metadata remains
* Italian version link exists
* final call to action exists
* all image paths point to `assets/`
* all captions are italic markdown captions
* title is final

Final English title:

```text
The Missing Layer in AI Coding Agents Is Judgment
```

Final English subtitle:

```text
A practical operating model for using AI agents in real repositories without losing context, decisions, or engineering discipline.
```

## Italian article checklist

File:

```text
docs/articles/medium-agent-os.it.md
```

Run:

```bash
grep -n "English version" docs/articles/medium-agent-os.it.md
grep -n "Una star è benvenuta" docs/articles/medium-agent-os.it.md
grep -n "knowledge management\|maintenance pass\|Una fix\|artifact" docs/articles/medium-agent-os.it.md
```

Expected:

* English version link exists
* final call to action exists
* no awkward hybrid translation remains
* technical English terms are intentional
* images use the same asset paths
* title is final

Final Italian title:

```text
Gli agenti AI sanno eseguire. Il problema è farli giudicare meglio.
```

Final Italian subtitle:

```text
Un modello operativo pratico per usare agenti AI su repository reali senza perdere contesto, decisioni e disciplina tecnica.
```

---

# Phase 3 — Medium Publication

## Goal

Publish the English and Italian Medium articles, then cross-link them.

Medium is the long-form article home. LinkedIn is the immediate distribution channel.

## Publication order

Recommended order:

```text
1. Publish English Medium article
2. Immediately publish English LinkedIn post
3. Publish Italian Medium article
4. Immediately publish Italian LinkedIn post
5. Update cross-language Medium links
```

## Task 3.1 — Publish English Medium article

### Instructions

1. Open Medium.
2. Create a new story.
3. Copy content from:

```text
docs/articles/medium-agent-os.md
```

4. Upload images manually from:

```text
docs/articles/assets/
```

5. Use Medium native captions.
6. Check desktop preview.
7. Check mobile preview.
8. Publish.

### Tags

Use up to the available Medium tag limit.

Suggested tags:

```text
AI
Software Engineering
AI Agents
DevOps
Architecture
```

### Checklist

* title correct
* subtitle correct
* images uploaded manually
* captions present
* GitHub repo link works
* no relative GitHub language link left as final Medium link, unless temporarily intentional
* mobile preview readable
* final CTA intact

---

## Task 3.2 — Publish Italian Medium article

### Instructions

1. Create a second Medium story.
2. Copy content from:

```text
docs/articles/medium-agent-os.it.md
```

3. Upload the same images manually.
4. Use Italian captions.
5. Check desktop preview.
6. Check mobile preview.
7. Publish.

### Tags

Suggested tags:

```text
AI
Software Engineering
Agenti AI
Architettura
DevOps
```

### Checklist

* title correct
* subtitle correct
* images uploaded manually
* captions translated
* GitHub repo link works
* no awkward technical translation
* mobile preview readable
* final CTA intact

---

## Task 3.3 — Update cross-language Medium links

After both Medium articles are live:

### English article

Replace the relative Italian link with the real Medium Italian URL.

### Italian article

Replace the relative English link with the real Medium English URL.

### Checklist

* English article links to Italian Medium article
* Italian article links to English Medium article
* GitHub article files can remain with relative links unless a decision is made to store published URLs too

---

# Phase 4 — LinkedIn Launch

## Goal

Publish LinkedIn immediately after each Medium article, because LinkedIn is the primary distribution channel for the Italian network and an important professional channel in general.

## Task 4.1 — LinkedIn English post

Publish immediately after the English Medium article.

### Suggested post

```text
Most AI agent frameworks optimize execution.

I think the missing layer is judgment.

Over the last few weeks I worked on Agent OS: a lifecycle-first operating model for using AI agents in real repositories.

The idea is simple:

AI agents are getting better at writing code, running tools, and changing files.

But real engineering work also needs:

- routing
- challenge
- decision capture
- authority
- verification evidence
- handoff
- knowledge management

Agent OS is not a runtime or a wrapper.

It is a documented operating model for agent-assisted engineering.

The project is still in active validation, and that is the point: I am looking for critique from people using agents on real codebases.

Article:
<MEDIUM_EN_URL>

Repository:
https://github.com/ignazio-ingenito/agent-os

A star is welcome.
Real validation matters more.
```

### Checklist

* Medium English URL inserted
* GitHub URL inserted
* no broken preview
* tone is technical, not promotional
* CTA asks for critique and validation
* post is published right after Medium English article

---

## Task 4.2 — LinkedIn Italian post

Publish immediately after the Italian Medium article.

This post can be more complete than the English one because Medium is less central for the Italian audience.

### Suggested post

```text
Negli ultimi mesi ho usato sempre di più agenti AI su repository reali.

La parte difficile non è farli scrivere codice.

La parte difficile è farli ragionare con abbastanza disciplina.

Quando il lavoro diventa serio, iniziano i problemi:

- decisioni perse nella chat
- richieste vaghe trasformate troppo presto in codice
- ricerche senza fonti o raccomandazioni chiare
- handoff trattati come policy
- verifiche saltate
- automazione introdotta prima di sapere cosa automatizzare

Da questa frustrazione è nato Agent OS.

Non è un framework software.
Non è un runtime.
Non è un wrapper.

È un modello operativo per agent-assisted engineering: lifecycle, governance, review lens, overlay, blast radius e knowledge management.

L’obiettivo non è far produrre più codice agli agenti.

È aiutarli a lavorare con più giudizio.

Articolo:
<MEDIUM_IT_URL>

Repository:
https://github.com/ignazio-ingenito/agent-os

Se lavori con Codex, Claude Code, Cursor, Gemini CLI o altri agenti su repository reali, mi interessa soprattutto capire dove questo modello ti sembra utile e dove invece rischia di diventare troppo pesante.

Una star aiuta.
Feedback e critiche aiutano di più.
```

### Checklist

* Medium Italian URL inserted
* GitHub URL inserted
* tone is personal and technical
* post gives value even if readers do not click Medium
* CTA asks for feedback
* post is published right after Medium Italian article

---

# Phase 5 — Optional Cross-Posting

## Goal

Reach technical communities without sounding spammy.

## Principle

Do not cross-post everything everywhere on the same day.

Use each platform according to its culture.

## DEV.to

Recommended timing:

```text
2-4 days after Medium publication
```

Instructions:

* publish English article
* set canonical URL to Medium if DEV.to supports it
* keep GitHub link
* keep final CTA

Checklist:

* canonical URL set
* images render correctly
* GitHub repo link works
* CTA preserved

## Reddit

Recommended timing:

```text
after Medium and LinkedIn have been published
```

Use only 1-2 subreddits at first.

Candidate subreddits:

```text
r/programming
r/devops
r/OpenAI
r/ClaudeAI
r/LocalLLaMA
```

Important:

* read subreddit rules first
* do not ask for stars
* ask for critique
* be transparent that the project is documentation-first and in validation

Suggested Reddit post:

```text
I’ve been using AI coding agents more heavily on real repositories, and I kept hitting the same problem: they execute well, but they do not reliably preserve decisions, authority, verification evidence, or handoff context.

I wrote down a lifecycle-first operating model for agent-assisted engineering.

It is called Agent OS.

It is not a runtime or wrapper. It is more of a governance/lifecycle model for working with agents in real codebases.

I’d really like critique from people using agents seriously:

- where does this feel useful?
- where does it feel too heavy?
- what failure modes am I missing?

Repo:
https://github.com/ignazio-ingenito/agent-os

Article:
<MEDIUM_EN_URL>
```

## Hacker News

Recommended timing:

```text
not immediately
```

Use after:

* the repo has feedback
* at least one validation attempt exists
* the README and article have proven understandable

Suggested HN titles:

```text
Agent OS: A lifecycle-first operating model for AI-assisted engineering
```

or:

```text
The missing layer in AI coding agents is judgment
```

---

# Phase 6 — Feedback Collection

## Goal

Capture reactions and turn them into actionable improvements.

## Task 6.1 — Create launch feedback issue

Command:

```bash
gh issue create \
  --title "Collect feedback from first public launch" \
  --body "Track feedback from Medium, LinkedIn, Reddit, DEV.to, and early GitHub users. Capture what worked, what felt heavy, missing concepts, and validation opportunities." \
  --label "type:validation,area:adoption"
```

## Checklist

Feedback issue should collect:

* Medium comments
* LinkedIn comments
* GitHub issues
* Reddit comments
* direct messages
* repeated objections
* confusing concepts
* validation candidates

---

# Phase 7 — Follow-up

## Goal

Keep the project alive after the initial post.

## Task 7.1 — One-week follow-up post

Potential title:

```text
What I learned after publishing Agent OS
```

Content:

* what resonated
* what people challenged
* what felt too heavy
* what will change
* what validation is next

## Checklist

* do not just celebrate stars
* discuss critique honestly
* link to issues or decisions
* invite more validation
* explain next step

---

# Handoff

## Current state

Agent OS has:

* public GitHub repository
* README
* English and Italian articles
* article images
* core specifications
* accepted decisions
* bootstrap guide
* open validation issue

## Next action

Before publication:

1. Commit article files and assets.
2. Verify repo readiness.
3. Publish English Medium article.
4. Publish English LinkedIn post immediately.
5. Publish Italian Medium article.
6. Publish Italian LinkedIn post immediately.
7. Update cross-language Medium links.
8. Create feedback tracking issue.

## Key risks

* publishing before `LICENSE` exists
* broken image paths
* Medium relative links left unresolved
* LinkedIn posts sounding like self-promotion
* posting to Reddit too early or too widely
* presenting Agent OS as more mature than it is

## Definition of done

Launch is complete when:

* English Medium article is live
* Italian Medium article is live
* English LinkedIn post is live
* Italian LinkedIn post is live
* GitHub repo is linked from both articles and posts
* articles cross-link each other
* launch feedback issue exists
* at least one channel is being monitored for feedback
