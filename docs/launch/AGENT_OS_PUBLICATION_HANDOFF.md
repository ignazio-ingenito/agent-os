# Agent OS Publication Handoff

## Purpose

This document hands off the Agent OS public launch workflow to Codex.

The goal is to manage the publication and promotion process after the English Medium article and English LinkedIn post have been published.

Codex must help with:

* tracking launch status
* publishing and cross-linking the Italian version
* preparing LinkedIn posts
* collecting feedback
* updating GitHub issues
* maintaining a clean launch log
* preventing accidental publication of draft/internal content

---

## Repository

Repository:

```text
https://github.com/ignazio-ingenito/agent-os
```

Main branch:

```text
main
```

Project status:

```text
public
open source
MIT licensed
active validation
```

Core positioning:

```text
Most AI agent frameworks optimize execution.
Agent OS optimizes judgment.
```

Agent OS is a lifecycle-first operating model for AI-assisted engineering. It is not a runtime, wrapper, scaffolder, prompt trick collection, or automation framework.

---

## Current launch status

Completed:

* GitHub repository is public.
* Repository description is configured.
* Topics are configured.
* LICENSE is present.
* README is available in English and Italian.
* Medium English article is published.
* LinkedIn English post is published.
* Launch feedback issue has been created.

Medium English URL:

```text
https://medium.com/@ignazio.ingenito/the-missing-layer-in-ai-coding-agents-is-judgment-e38f99170b7f
```

LinkedIn English post URL:

```text
https://www.linkedin.com/posts/ignazio-ingenito_ai-softwareengineering-aiagents-share-7468311316038877184-9nCs/
```

Remaining:

* Publish Italian Medium article.
* Publish Italian LinkedIn post immediately after Italian Medium publication.
* Update Medium cross-language links.
* Track launch feedback in GitHub issue.
* Decide whether to cross-post later to DEV.to, Reddit, Hacker News, or other channels.

---

## Relevant local files

English Medium article:

```text
docs/articles/medium-agent-os.md
```

Italian Medium article:

```text
docs/articles/medium-agent-os.it.md
```

Article images:

```text
docs/articles/assets/agent-os-execution-vs-judgment.png
docs/articles/assets/agent-os-lifecycle.png
docs/articles/assets/agent-os-lenses-overlays.png
docs/articles/assets/agent-os-blast-radius.png
```

Launch plan:

```text
docs/launch/AGENT_OS_LAUNCH_PLAN.md
```

Expected additional handoff file:

```text
docs/launch/AGENT_OS_PUBLICATION_HANDOFF.md
```

---

## Publication process still to execute

### 1. Publish Italian Medium article

Source file:

```text
docs/articles/medium-agent-os.it.md
```

Title:

```text
Gli agenti AI sanno eseguire. Il problema è farli giudicare meglio.
```

Subtitle:

```text
Un modello operativo pratico per usare agenti AI su repository reali senza perdere contesto, decisioni e disciplina tecnica.
```

Suggested Medium topics:

```text
AI
Software Engineering
Agenti AI
Architettura
DevOps
```

If Medium topic volume is poor for Italian tags, prefer more widely used English tags:

```text
AI
Artificial Intelligence
Software Engineering
Programming
AI Agent
```

Manual publication instructions:

1. Open Medium.
2. Create a new story.
3. Convert Markdown to HTML if Medium does not recognize Markdown formatting.
4. Copy content from browser-rendered HTML into Medium.
5. Upload images manually.
6. Use Medium native captions.
7. Check desktop preview.
8. Check mobile preview.
9. Publish.
10. Save the Italian Medium URL.

Important:

* Do not leave Markdown image paths like `assets/...` in Medium.
* Do not leave placeholders like `[IMAGE: ...]`.
* Do not leave internal text like `Image prompt`, `Suggested image`, or `Caption:`.
* Do not publish raw Markdown syntax.
* Remove or replace relative GitHub links with Medium URLs where needed.

---

## Image mapping for Medium

Use these images in this order.

### Hero image

File:

```text
docs/articles/assets/agent-os-execution-vs-judgment.png
```

Caption EN:

```text
Agent OS is not about making agents faster. It is about making their work more accountable.
```

Caption IT:

```text
Agent OS non serve a rendere gli agenti più veloci. Serve a rendere il loro lavoro più responsabile.
```

---

### Lifecycle image

File:

```text
docs/articles/assets/agent-os-lifecycle.png
```

Caption EN:

```text
The lifecycle is not a checklist. It is a routing model.
```

Caption IT:

```text
Il lifecycle non è una checklist. È un modello di routing.
```

---

### Lenses and overlays image

File:

```text
docs/articles/assets/agent-os-lenses-overlays.png
```

Caption EN:

```text
Lenses evaluate the work. Overlays add domain-specific requirements.
```

Caption IT:

```text
Le lens valutano il lavoro. Gli overlay aggiungono requisiti specifici del dominio.
```

---

### Blast radius image

File:

```text
docs/articles/assets/agent-os-blast-radius.png
```

Caption EN:

```text
The amount of process should match the risk.
```

Caption IT:

```text
La quantità di processo dovrebbe seguire il rischio.
```

---

## Markdown to HTML helper

If Medium does not recognize Markdown correctly, use this approach.

From repository root:

```bash
cp docs/articles/medium-agent-os.it.md /tmp/medium-agent-os-it-medium.md

# Optional: remove language switch if it should be replaced later with real Medium URLs.
sed -i '/English version/d' /tmp/medium-agent-os-it-medium.md

pandoc /tmp/medium-agent-os-it-medium.md \
  -f markdown \
  -t html \
  -o /tmp/medium-agent-os-it.html

explorer.exe "$(wslpath -w /tmp/medium-agent-os-it.html)"
```

Then:

1. Open the generated HTML in browser.
2. Select all.
3. Copy.
4. Paste into Medium.
5. Replace image placeholders or broken images manually.
6. Add captions natively in Medium.

If `pandoc` is missing:

```bash
sudo apt update
sudo apt install pandoc
```

---

## 2. Publish Italian LinkedIn post

Publish immediately after the Italian Medium article is live.

Use this post as the starting point.

Replace:

```text
<MEDIUM_IT_URL>
```

with the final Italian Medium URL.

Post:

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

Suggested hashtags:

```text
#AI
#SoftwareEngineering
#AIAgents
#DevOps
#OpenSource
```

Do not overdo hashtags.

---

## 3. Update cross-language links on Medium

After both Medium articles are live:

### English Medium article

Add or update:

```text
Italian version: <MEDIUM_IT_URL>
```

### Italian Medium article

Add or update:

```text
English version: https://medium.com/@ignazio.ingenito/the-missing-layer-in-ai-coding-agents-is-judgment-e38f99170b7f
```

Important:

* GitHub relative links are acceptable in repository Markdown.
* Medium articles must use real Medium URLs.
* Do not leave links like `medium-agent-os.it.md` in Medium.

---

## 4. Update repository articles if desired

Optional.

If the maintainer wants repository article files to contain published Medium URLs, update:

```text
docs/articles/medium-agent-os.md
docs/articles/medium-agent-os.it.md
```

with a small “Published on Medium” section.

Recommended format:

```markdown
Published on Medium:

- English: <MEDIUM_EN_URL>
- Italian: <MEDIUM_IT_URL>
```

Do not do this unless explicitly asked.

---

## 5. Track launch feedback

A GitHub issue has been created to collect launch feedback.

Codex should use it as a launch journal and feedback inbox.

The issue should collect:

* Medium comments
* LinkedIn comments
* GitHub issues
* Reddit or DEV.to comments, if posted later
* direct feedback
* repeated objections
* confusing concepts
* validation candidates
* possible follow-up issues

When feedback arrives, summarize it in the issue using this format:

```markdown
### YYYY-MM-DD

- Source:
- Feedback:
- Action:
- Status:
```

Example:

```markdown
### 2026-06-04

- Source: LinkedIn IT
- Feedback: Concern that Agent OS may be too heavy for small teams.
- Action: Consider adding a clearer lightweight usage example for Level 0/1 work.
- Status: Open
```

If repeated feedback appears, create a dedicated GitHub issue.

Do not solve everything inside the launch feedback issue. Use it as an inbox and triage log.

---

## 6. Optional later channels

Do not post everywhere immediately.

Recommended later sequence:

1. DEV.to after Medium and LinkedIn are stable.
2. Reddit only if the post asks for critique, not stars.
3. Hacker News only after at least one real validation or meaningful feedback exists.

### DEV.to

Use English article.

Set canonical URL to the Medium English article if DEV.to supports it.

### Reddit

Use only one or two subreddits at first.

Possible subreddits:

```text
r/programming
r/devops
r/OpenAI
r/ClaudeAI
r/LocalLLaMA
```

Tone:

* ask for critique
* do not ask for stars
* be transparent that Agent OS is documentation-first and in active validation

### Hacker News

Do not post immediately unless explicitly instructed.

Possible title:

```text
Agent OS: A lifecycle-first operating model for AI-assisted engineering
```

or:

```text
The missing layer in AI coding agents is judgment
```

---

## Current open work

Main validation issue remains open:

```text
Validate Agent OS on a real repository
```

Launch feedback issue is newly created.

After publication, the next real work is:

```text
Validate Agent OS on itself or on another real repository.
```

Recommended first validation target:

```text
agent-os itself
```

Reason:

If Agent OS cannot manage its own adoption and validation flow, it is not ready to guide other repositories.

---

## Pre-publication checklist for Italian article

Before publishing Medium IT:

* [ ] title is correct
* [ ] subtitle is correct
* [ ] article is formatted correctly
* [ ] no raw Markdown remains
* [ ] no `[IMAGE: ...]` placeholders remain
* [ ] no `assets/...` paths remain visible
* [ ] all images uploaded manually
* [ ] captions added natively in Medium
* [ ] GitHub link works
* [ ] English Medium link is correct
* [ ] mobile preview is readable
* [ ] tags are selected
* [ ] final CTA is intact

---

## Final launch checklist

* [ ] Medium EN live
* [ ] LinkedIn EN live
* [ ] Medium IT live
* [ ] LinkedIn IT live
* [ ] Medium EN links to Medium IT
* [ ] Medium IT links to Medium EN
* [ ] GitHub repo links are correct
* [ ] feedback issue exists
* [ ] launch feedback issue has initial launch log entry
* [ ] no urgent formatting issues remain

