# COS Bootstrap Guide

## Audience

Repository owners adopting COS in a real repository.

## Purpose

This guide explains how to adopt COS manually, from no adoption to the A3 Workflow-Aware reference level.

It is a guide only. It does not create folders, wrappers, scripts, templates, or automation.

## Adoption Path

COS adoption progresses through:

```text
A0 Unadopted -> A1 Documented -> A2 Artifact-aware -> A3 Workflow-aware
```

A1 is the minimum useful adoption level.

A3 is the reference implementation target.

## First Day Setup

Use the first day to make the repository readable to agents without creating unnecessary process.

Recommended first-day outcome:

```text
/
├── AGENTS.md
├── docs/
│   └── specs/
│       └── COS_FINAL_SPEC.md
└── .codex/
    └── adoption.md
```

If the repository already has `AGENTS.md`, update it instead of replacing it.

First-day decisions:

* Who owns COS adoption in this repository?
* Is this repository targeting A1, A2, or A3 first?
* Which work is high-risk and requires confirmation?
* Where will durable decisions live?
* Should `.codex-work/` be local-only, selectively committed, or decided later?

Common first-day mistake:

* trying to create the full A3 layout before the repository has any actual COS artifacts

Better approach:

* create only the files needed for the target adoption level
* add folders when real artifacts need them

## A0 -> A1 Adoption

A0 means the repository has no local COS adoption rules. Agents may still use COS concepts ad hoc, but the repository does not guide them.

A1 means the repository declares COS usage and gives agents an entry point.

### Prerequisites

Before moving to A1:

* repository owner agrees to use COS
* repository has, or will create, `AGENTS.md`
* repository owner chooses an initial adoption owner
* repository owner accepts that high-risk actions require confirmation

### Files to Create

Required:

```text
AGENTS.md
.codex/adoption.md
```

Recommended reference files:

```text
docs/specs/COS_FINAL_SPEC.md
```

If this repository tracks the full COS source specs, also include:

```text
docs/specs/COS_ARCHITECTURE.md
docs/specs/COS_GOVERNANCE_SPEC.md
docs/specs/COS_IMPLEMENTATION_ARCHITECTURE.md
docs/decisions/COS_ACCEPTED_DECISIONS.md
```

Do not create templates. Write only the repository-specific content needed.

### Folders to Create

Required:

```text
.codex/
```

No `docs/` or `.codex-work/` folders are required for A1 unless the repository already needs them.

### Required Decisions

Record these in `.codex/adoption.md`:

* COS adoption level: `A1 Documented`
* adoption owner
* repository owner
* location of `AGENTS.md`
* location of COS reference docs
* confirmation rule for high-risk work
* whether the repository intends to progress to A2 or A3

Realistic example:

```text
Adoption Level: A1 Documented
Repository Owner: Platform Team
Governance Owner: Lead Maintainer
COS Reference: docs/specs/COS_FINAL_SPEC.md
High-Risk Rule: production, secrets, destructive data, and public API changes require explicit confirmation
Next Target: A3 after two real workflows have used A1 successfully
```

### Validation Checklist

A1 is valid when:

* `AGENTS.md` says the repository uses COS
* `AGENTS.md` points to `.codex/adoption.md`
* `.codex/adoption.md` declares the adoption level
* high-risk confirmation is explicit
* agents can find the COS reference document
* no scripts, wrappers, templates, or automation were added

### Common Mistakes

* copying a huge COS policy into `AGENTS.md`
* treating handoff notes as policy
* skipping the adoption owner
* saying "uses COS" without pointing to the actual COS files
* creating A3 folders without a reason

## A1 -> A2 Adoption

A2 means the repository defines where durable artifacts live and how authority works.

Move to A2 when the repository starts producing decisions, research, contracts, product specs, or architecture notes that agents must find later.

### Prerequisites

Before moving to A2:

* A1 is valid
* repository has at least one durable artifact type to manage
* repository owner agrees on artifact locations
* repository owner agrees that handoffs are not policy

### Files to Create

Required:

```text
.codex/governance.md
.codex/authority.md
.codex/knowledge-map.md
```

Create durable docs files only when needed. Common first files:

```text
docs/adr/README.md
docs/architecture/overview.md
docs/research/README.md
docs/glossary.md
```

### Folders to Create

Create only folders that correspond to artifacts the repository expects to use.

Recommended A2 folders:

```text
docs/
docs/adr/
docs/architecture/
docs/product/
docs/contracts/
docs/research/
docs/research/active/
docs/research/accepted/
docs/research/archived/
```

If the repository has no product specs or interface contracts yet, `docs/product/` and `docs/contracts/` may wait.

### Required Decisions

Record in `.codex/governance.md`:

* artifact lifecycle states used by the repository
* governance header expectations
* review cadence for durable docs
* promotion rule from `.codex-work/` into durable docs

Record in `.codex/authority.md`:

* which documents are authoritative
* where ADRs live
* where active contracts live
* where product specs live
* what is low authority

Record in `.codex/knowledge-map.md`:

* where agents look for architecture decisions
* where agents look for research
* where agents look for contracts
* where agents look for product behavior

Realistic example:

```text
ADRs: docs/adr/
Research: docs/research/
Contracts: docs/contracts/
Low Authority: .codex-work/, old handoffs, archived research
Stale Research Rule: revalidate before vendor, framework, library, AI model, or external service decisions
```

### Validation Checklist

A2 is valid when:

* A1 remains valid
* `.codex/governance.md` exists
* `.codex/authority.md` exists
* `.codex/knowledge-map.md` exists
* ADR location is defined
* research location is defined
* low-authority continuity artifacts are distinguished from durable knowledge
* agents can find active decisions without guessing
* no templates or automation were introduced

### Common Mistakes

* creating folders for every possible artifact before any artifact exists
* forgetting to define authority
* treating `.codex-work/` as durable docs
* not separating active research from archived research
* creating `.codex/knowledge/` even though COS keeps knowledge files at top-level `.codex` for now

## A2 -> A3 Adoption

A3 means the repository defines workflow behavior: routing, execution authority, handoffs, verification, operations, and maintenance.

Move to A3 when agents will perform implementation, debugging, release, incident, research, or maintenance workflows in the repository.

### Prerequisites

Before moving to A3:

* A2 is valid
* repository has recurring agent-assisted work
* repository owner can define execution boundaries
* repository owner can define verification expectations
* repository owner can identify high-risk work

### Files to Create

Required:

```text
.codex/routing.md
.codex/execution.md
```

Recommended as workflows appear:

```text
docs/operations/releases/README.md
docs/operations/incidents/README.md
docs/operations/runbooks/README.md
docs/maintenance/README.md
```

### Folders to Create

Required for A3:

```text
.codex-work/
.codex-work/handoffs/
.codex-work/investigations/
.codex-work/verification/
docs/operations/
docs/operations/releases/
docs/operations/incidents/
docs/operations/runbooks/
docs/maintenance/
```

Optional subfolders may be added later if the repository needs active/archived separation for handoffs.

### Required Decisions

Record in `.codex/routing.md`:

* default route for implementation
* default route for debugging
* default route for research
* default route for design
* default route for release
* overlays required by repository domain
* review lenses required by blast radius

Record in `.codex/execution.md`:

* actions agents may do without confirmation
* actions requiring confirmation
* forbidden actions
* production execution rules
* destructive operation rules
* external cost-incurring operation rules

Realistic example:

```text
Implementation Route: Intake -> Understand -> Plan -> Build -> Verify -> Handoff
Debugging Route: Intake -> Understand -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Handoff
Research Route: Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff
Release Route: Intake -> Understand -> Plan -> Verify -> Release -> Handoff

Confirmation Required:
- production deploys
- database migrations
- secret handling
- public API contract breaks
- external paid service changes
```

### Validation Checklist

A3 is valid when:

* A2 remains valid
* `.codex/routing.md` exists
* `.codex/execution.md` exists
* implementation route is defined
* debugging route uses Diagnosis Overlay, not Diagnose as a lifecycle stage
* research route uses Research Overlay, not Research as a lifecycle stage
* execution confirmation rules are explicit
* handoff location is defined
* verification location is defined
* release and incident locations are defined if the repository has operational work
* `.codex-work/` is documented as ephemeral by default
* no scripts, wrappers, templates, or automation were introduced

### Common Mistakes

* allowing agents to infer permission from the Build stage
* skipping verification because a change seems simple
* putting handoffs in `docs/` as if they were durable policy
* using `Diagnose` as a lifecycle stage
* using generic Maintenance Overlay instead of the Maintain stage
* adding automation before A3 is proven manually

## First ADR

Use an ADR when a decision is hard to reverse, surprising without context, and the result of a real trade-off.

Realistic first ADR:

```text
docs/adr/2026-001-adopt-cos-a3-workflow-aware.md
```

What it should decide:

* the repository adopts COS
* A3 is the target adoption level
* A1 is the minimum fallback for small changes
* high-risk execution requires confirmation
* `.codex-work/` is ephemeral by default

What not to put in the ADR:

* full COS documentation
* every route definition
* temporary setup notes
* handoff content

Validation:

* ADR has a status
* ADR states the decision
* ADR links to `.codex/adoption.md`
* ADR explains alternatives considered
* ADR records consequences

## First Research Artifact

Use the Research Overlay when evaluating technologies, frameworks, vendors, AI models, architectures, external services, libraries, or standards.

Realistic first research task:

```text
Evaluate whether to use NATS or Redis Streams for background event delivery.
```

Route:

```text
Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff
```

Files:

```text
docs/research/active/2026-001-nats-vs-redis-streams.md
```

Include:

* Research Brief
* Options Matrix because there are multiple viable options
* Recommendation Memo because a decision is expected
* Source Notes because external sources are used

Validation:

* sources are current enough for the decision
* official docs or primary sources are preferred
* trade-offs are explicit
* recommendation is separated from evidence
* if accepted, resulting decision is promoted to ADR or decision note

Common mistake:

* treating a research brief as an accepted decision without a Decide step

## First Handoff

Use a handoff when work is paused, delegated, blocked, ready for review, or complete with useful continuation context.

Realistic first handoff:

```text
.codex-work/handoffs/2026-06-04-auth-refactor-plan.md
```

Include:

* current goal
* current state
* decisions made
* relevant files
* verification state
* risks
* unresolved questions
* next actor
* next action

Validation:

* handoff does not define new policy
* durable decisions are promoted to ADR or decision note
* important findings are promoted out of `.codex-work/`
* risks and verification state are explicit

Common mistake:

* using a handoff note as the only record of an architectural decision

## First Implementation Workflow

Use this for a normal contained feature or bug fix.

Realistic task:

```text
Add pagination to the internal audit-log API.
```

Route:

```text
Intake -> Understand -> Plan -> Build -> Verify -> Handoff
```

Apply overlays:

* API/Interface Overlay because response shape or query parameters may change
* Security/Privacy Overlay if audit logs contain sensitive data

Required decisions:

* Is this a public contract change?
* What pagination parameters are supported?
* What behavior is preserved?
* What tests prove it works?

Validation checklist:

* repository instructions were read
* affected contract was identified
* plan lists acceptance criteria
* tests or manual verification were run after the final change
* docs or contracts were updated if behavior changed
* handoff records verification and risks

Common mistakes:

* changing API shape without an interface contract update
* treating sensitive audit data as ordinary list data
* claiming completion without fresh verification

## First UX/Design Workflow

Use this for user-facing workflows, UI behavior, or product interaction design.

Realistic task:

```text
Design the invite-user flow for an internal admin app.
```

Route:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Handoff
```

Apply overlays:

* UX/Application Overlay for workflow and UI states
* Security/Privacy Overlay for permissions and invitation abuse cases
* API/Interface Overlay if frontend/backend contracts are being shaped

Required decisions:

* Who can invite users?
* What roles can be assigned?
* What happens when an invite expires?
* What error, empty, loading, and success states exist?
* What is out of scope?

Durable artifacts:

```text
docs/product/2026-001-invite-user-flow.md
docs/contracts/2026-001-invite-user-api.md
```

Validation checklist:

* user workflow is clear
* permission rules are explicit
* UI states are listed
* API or contract implications are captured
* open questions are visible
* implementation work is not started before the design decision is clear

Common mistakes:

* jumping directly to implementation
* burying permission rules in UI notes only
* skipping error and expired-invite states

## Bootstrap Completion Checklist

Before considering bootstrap complete:

* target adoption level is declared
* `AGENTS.md` points to COS files
* `.codex/adoption.md` exists
* A2 authority and knowledge files exist if artifact-aware adoption is claimed
* A3 routing and execution files exist if workflow-aware adoption is claimed
* ADR, research, handoff, and verification locations are known
* high-risk confirmation rules are explicit
* `.codex-work/` is ephemeral by default
* no scripts, wrappers, templates, or automation were added

## Non-Implementation Boundary

This guide does not create:

* files
* folders
* scripts
* wrappers
* templates
* automation

It describes what repository owners should create manually when they choose to adopt COS.
