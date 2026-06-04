# The Missing Layer in AI Coding Agents Is Judgment

[![flag](https://api.iconify.design/twemoji/flag-for-italy.svg) Italian version](medium-agent-os.it.md)

A practical operating model for using AI agents in real repositories without losing context, decisions, or engineering discipline.

Most AI agent frameworks optimize execution.

Agent OS optimizes judgment.

![Two-column diagram comparing execution-focused AI agents with judgment-focused Agent OS workflows.](assets/agent-os-execution-vs-judgment.png)
*Agent OS is not about making agents faster. It is about making their work more accountable.*

That distinction matters more than it sounds.

The current wave of AI engineering tools is good at getting work done quickly. Codex, Claude Code, Gemini CLI, OpenHands, Cursor-like agents, and similar tools can inspect files, write code, modify tests, explain failures, and automate repetitive work. Used well, they change how software gets built.

But once you move beyond isolated snippets, execution is not the hard part.

The hard part is getting the agent to understand what kind of work it is doing.

Is this a small local edit, or a public contract change? Is this a bug fix, or is the root cause still unknown? Is this research, or a decision? Is this handoff context, or durable architecture policy? Is the agent allowed to run the command it wants to run? What evidence proves the work is finished?

Those are not implementation details. They are engineering judgment.

Agent OS is an attempt to make that judgment explicit.

It is not a runtime, wrapper, package, scaffolder, or agent vendor. It is a repository operating model for AI-assisted engineering work: a way to route requests, preserve context, record decisions, apply review lenses, manage knowledge, and require verification evidence before completion claims.

It is also still in active validation. The architecture and governance model are documented, but the next phase is real-world use and feedback.

That timing matters. Agents are moving beyond autocomplete. They now modify repositories, run tools, create plans, and carry work across sessions. The more agency we give them, the more we need an operating model for judgment, not just a faster path to execution.

## The problem that led to Agent OS

The project started from a practical frustration: agents move quickly, but real repositories need continuity.

For a small one-off task, speed is often enough. Ask an agent to rewrite a sentence, generate a utility function, or explain an error message, and the cost of being slightly wrong is usually low.

Real codebases are different.

There are existing decisions, contracts, patterns, operational constraints, data rules, security expectations, and team habits that are not always written down. A change can look local while affecting an API shape, a permission model, a deployment path, or a user workflow.

Without structure, agent sessions tend to fail in familiar ways:

* vague requests become code too early
* architectural decisions stay trapped in chat history
* research lacks source notes, freshness checks, or an actual recommendation
* review, critique, challenge, QA, and code review blur together
* handoff notes get treated as policy
* verification gets skipped or summarized without fresh evidence
* automation is introduced before anyone knows what should be automated
* maintenance becomes generic cleanup instead of governed work

Making the agent faster does not fix those problems.

The work needs a lifecycle.

## Why execution is not enough

Execution answers one question: "Can the agent do something?"

Engineering needs another question first: "What should be done, at what level of rigor, with what evidence, and under whose authority?"

A data migration should not be routed like a copy edit. A production incident should not be treated like a local unit test failure. A technology evaluation should not end with "seems good" if the decision is expensive to reverse. A handoff should not silently become architecture policy.

The issue is not that agents lack capability. The issue is that capability without routing creates noise.

Agent OS treats agent work as something that moves through stages:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Not every task uses every stage. That is the point.

A direct answer may only need intake, understanding, and handoff. A contained implementation needs planning, building, and verification. A release needs operational checks. An incident needs containment, diagnosis, verification, release handling, and follow-up.

The lifecycle exists to avoid two bad defaults: jumping into code before understanding the problem, and applying heavyweight process to work that does not need it.

## Why skills, wrappers, and prompt tricks are not enough

Early versions of Agent OS looked more like a list of skills and pipelines: discovery, research, decision, implementation, application design, maintenance, review.

That helped, but it was too flat.

The problem was not finding more skills. The problem was deciding when to use them.

Should research be a lifecycle stage, or an overlay applied when external or time-sensitive knowledge is needed? Is diagnosis a stage, or a specialized mode for unexplained failures? Is review the same thing as critique? When should challenge happen before a plan is accepted? Where should knowledge go after verification?

Wrappers do not answer those questions. Prompt tricks do not answer them reliably either. They can improve behavior inside a step, but they do not define the operating model around the step.

Agent OS moved toward a lifecycle-first architecture. The lifecycle is the spine. Review lenses evaluate work. Overlays add specialized checks. Governance decides what is authoritative. Knowledge management preserves durable context. Blast radius determines how much rigor the work needs.

Skills still matter. Tools still matter. Prompts still matter.

They are not the architecture.

## The lifecycle

The core lifecycle is:

![Agent OS lifecycle from Intake to Maintain.](assets/agent-os-lifecycle.png)
*The lifecycle is not a checklist. It is a routing model.*

The names are deliberately plain.

`Intake` classifies the request and likely risk. `Understand` forces the agent to inspect relevant context before acting. `Challenge` asks whether the plan or idea should proceed at all. `Decide` records direction and rationale when a decision is needed. `Plan` turns intent into sequenced work with acceptance criteria. `Build` performs the local implementation or approved action. `Verify` produces fresh evidence. `Release` handles rollout, rollback, migration, monitoring, or production operation when relevant. `Handoff` preserves state, risks, evidence, and open questions. `Maintain` deals with drift and stale knowledge.

That can sound like a lot, but the route is meant to shrink for small work. A direct answer does not need `Build`. A local edit may not need `Release`. A production change probably does.

The lifecycle is not a checklist to run blindly. It is a routing model.

For small work, Agent OS should almost disappear. It should become visible only when risk, uncertainty, permanence, or coordination cost makes judgment necessary.

## Review lenses

Agent OS separates review modes that often get mixed together.

Challenge is the uncomfortable one. It asks whether the idea, plan, or decision should proceed at all. Are the assumptions true? Is the scope too broad? Is there a safer path? Could this fail in a way we are ignoring?

Critique is different. Critique improves an idea that has already been accepted.

Code Review looks for correctness, maintainability, security, performance, and missing tests. QA checks user-visible behavior against acceptance criteria. Security looks at abuse paths, permissions, secrets, sensitive data, and unsafe input. Architecture looks at boundaries, coupling, ownership, and abstractions. Operations looks at deployment, rollback, observability, and supportability.

The distinction is practical. If an approach is wrong, polishing it is wasted work. Challenge comes before critique.

## Overlays

Overlays add specialized requirements without replacing the lifecycle.

The current model includes overlays for UX/Application, API/Interface, Security/Privacy, Data/Migration, Infrastructure/Kubernetes, AI Application, Research, Diagnosis, and Incident.

Research is not a lifecycle stage. It is applied when the work depends on external sources, vendors, frameworks, AI models, standards, libraries, or other time-sensitive technical facts. Research may require source notes, an options matrix, and a recommendation memo.

Diagnosis is not a lifecycle stage either. It is applied when there are unexplained failures, failing tests, bugs, production symptoms, or unexpected behavior. For non-trivial unexplained failures, root cause should be established before build. A fix without diagnosis is often just a guess with a diff.

Incidents can combine overlays:

```text
Intake -> Understand -> Apply Incident Overlay -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

The Incident Overlay handles severity, impact, containment, rollback, communication, and follow-up. The Diagnosis Overlay handles causal investigation. Release handles rollout and production validation.

Keeping those responsibilities separate makes the work easier to reason about.

![Diagram showing how a request moves through lifecycle stages with review lenses and domain overlays.](assets/agent-os-lenses-overlays.png)

*Lenses evaluate the work. Overlays add domain-specific requirements.*

## Governance

Governance is the part that decides what counts.

An accepted ADR has more authority than a handoff note. A handoff note may be useful, but it does not create policy. Source code proves current behavior, but not always intended behavior. Newer does not automatically mean more authoritative. Stale research must be revalidated before it drives a decision.

This matters because agent sessions are full of context, and not all context should govern future work.

Agent OS also treats execution as permissioned. A lifecycle stage does not grant authority. `Build` may mean local code changes, but it may also mean preparing or executing an operational action. Production changes, destructive operations, irreversible data changes, secret handling, permission changes, public contract breaks, external cost-incurring operations, and security exceptions require explicit confirmation.

That boundary is not ceremony. It is how the system keeps "the agent can do this" separate from "the agent is allowed to do this."

## Blast radius

Blast radius is the simplest way to decide how much process a task deserves.

Agent OS uses five levels:

* Level 0: informational
* Level 1: local and reversible
* Level 2: one module or workflow
* Level 3: public contract, multiple modules, permissions, or schema
* Level 4: production, security, data, or irreversible action

The higher the blast radius, the more the agent needs challenge, decision capture, verification, documentation, and human confirmation.

![Five-level blast radius scale from informational work to production, security, data, or irreversible changes.](assets/agent-os-blast-radius.png)
*The amount of process should match the risk.*

This is where Agent OS tries to stay practical. It does not say "always use the full process." It says the amount of process should match the risk.

## A small request that is not actually small

Imagine asking an agent to "clean up the authorization logic."

That sounds like a refactor. It might be one.

But it might also change who can do what.

If the authorization logic sits inside controllers, moving it into a policy layer could affect public behavior. It could change permission checks, error semantics, audit logging, API responses, or assumptions in tests. If the system has admins, owners, guests, service accounts, or tenant boundaries, a cleanup can become a security change quickly.

Agent OS would not route that as "just refactor some code" without first checking the blast radius.

The agent should understand the current permission model, inspect existing contracts and tests, identify who consumes the behavior, and challenge whether the change is behavior-preserving. If the refactor changes policy, the work may need an ADR or contract update. If it touches permissions, it likely needs Security/Privacy overlay. If it affects public API behavior, it needs API/Interface overlay. If it could expose or block user actions, it may need human confirmation before `Build`.

Verification also changes. A passing unit test is not enough if the risk is permission drift. The agent needs evidence that allowed users remain allowed, denied users remain denied, error behavior is preserved where required, and any intentional behavior change is documented.

That is the kind of judgment Agent OS is trying to make visible.

## Knowledge management

Knowledge management is one of the reasons Agent OS exists.

Agent work often produces useful knowledge: why a decision was made, which alternatives were rejected, what failed in production, how something was verified, which documents are stale, which assumptions were invalidated.

If that knowledge stays in chat, it disappears.

Agent OS starts with repository structure and governance instead of tooling. `.codex/` contains local Agent OS rules. `docs/` contains durable knowledge. `.codex-work/` contains temporary working context: handoffs, investigations, and verification notes.

The important rule is promotion.

`.codex-work/` is ephemeral by default. If something discovered there changes a decision, contract, incident, release, or long-term understanding, it should be promoted into durable docs.

That is how an agent session stops being a disposable conversation and starts contributing to the repository's memory.

## What is already in the repo

The repository is mostly documentation right now, by design. It contains the final spec, architecture and governance docs, accepted decisions, the Diagnosis Overlay spec, and a bootstrap guide for adopting Agent OS manually.

The final spec defines the lifecycle, routing, blast radius, review lenses, overlays, governance, authority model, execution authority, and repository layout. The accepted decisions explain why the model landed where it did. The Diagnosis Overlay gives unexplained failures their own operational rules without turning diagnosis into a lifecycle stage.

The bootstrap guide describes adoption levels from A0 to A3:

```text
A0 Unadopted -> A1 Documented -> A2 Artifact-aware -> A3 Workflow-aware
```

A1 is the lightweight entry point. A3 is the current reference target. A5 automation is intentionally outside the core for now.

The useful starting points are `docs/specs/COS_FINAL_SPEC.md`, `docs/decisions/COS_ACCEPTED_DECISIONS.md`, `docs/specs/COS_DIAGNOSIS_OVERLAY.md`, and `docs/guides/COS_BOOTSTRAP_GUIDE.md`.

## What is still being validated

Agent OS should not be presented as more mature than it is.

The architecture and governance model are documented. The repository is ready for review, critique, and experiments. But the project is still in active validation.

This is not a finished product pretending to be done. It is a documented operating model looking for real-world pressure.

The next questions are practical:

* Which files do agents actually read during real work?
* Which routing rules help, and which feel heavy?
* Which artifacts are worth preserving?
* Which handoffs prevent duplicated work?
* Which governance rules are clear enough for daily use?
* Where does the model need sharper language?
* What should remain manual?
* What, if anything, deserves automation later?

Agent OS is intentionally not starting with scripts, wrappers, generators, validators, or templates. Automation would be premature if the underlying workflow is not validated.

The process needs to prove itself in real repositories first.

## Why contributions matter

Agent OS is aimed at people who already feel the failure modes.

Software engineers who use agents daily. Architects who watch decisions disappear into chat. Platform and DevOps engineers who need agents to respect operational risk. Maintainers who need handoffs that do not become fake policy. AI power users who have learned that a better prompt is useful, but not enough.

The project needs practical pressure from those people.

Useful contributions are not limited to pull requests. Critiques are valuable. Failed experiments are valuable. Reports of where the model feels too heavy are valuable. Examples of where an agent skipped judgment are valuable. So are small adoption notes from real repositories.

The goal is not to build a grand framework. The goal is to make agent-assisted engineering less forgetful, less impulsive, and more accountable to evidence.

## Try it on a real workflow

The repository is here:

https://github.com/ignazio-ingenito/agent-os

A star is welcome. Real validation matters more.

Try Agent OS on a real workflow in a real repository. Use it for a debugging task, a small feature, an architecture decision, a research question, a maintenance pass, or a release plan.

Then open an issue with what happened:

* what worked
* what felt heavy
* where the model broke down
* what the agent still got wrong
* what artifact or rule you wished existed

That feedback is more useful than agreement. The architecture is written down. The next step is finding out where it survives contact with real engineering work.
