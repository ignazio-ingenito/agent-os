# COS Implementation Architecture

## Purpose

This document defines the repository structure required to support the Codex Operating System (COS).

It maps `COS_ARCHITECTURE.md` and `COS_GOVERNANCE_SPEC.md` into a repository layout and artifact placement model.

This document does not implement COS. It does not generate wrappers, scripts, templates, executable pipeline runners, or automation hooks.

## Design Goals

The repository structure must support:

* lifecycle-driven work
* governed artifacts
* repository-specific COS adoption
* ADRs and durable decisions
* handoffs and continuation context
* research outputs and source notes
* clear AGENTS integration
* artifact authority and freshness rules
* future automation without requiring it now

## Repository Layout

Recommended structure:

```text
/
├── AGENTS.md
├── .codex/
│   ├── adoption.md
│   ├── governance.md
│   ├── routing.md
│   ├── authority.md
│   ├── execution.md
│   └── knowledge-map.md
├── docs/
│   ├── specs/
│   │   ├── COS_ARCHITECTURE.md
│   │   ├── COS_GOVERNANCE_SPEC.md
│   │   └── COS_IMPLEMENTATION_ARCHITECTURE.md
│   ├── architecture/
│   │   ├── overview.md
│   │   └── decisions-map.md
│   ├── adr/
│   │   └── README.md
│   ├── product/
│   │   └── README.md
│   ├── contracts/
│   │   └── README.md
│   ├── operations/
│   │   ├── releases/
│   │   ├── incidents/
│   │   └── runbooks/
│   ├── research/
│   │   ├── README.md
│   │   ├── active/
│   │   ├── accepted/
│   │   └── archived/
│   ├── maintenance/
│   │   └── README.md
│   └── glossary.md
└── .codex-work/
    ├── handoffs/
    │   ├── active/
    │   └── archived/
    ├── investigations/
    └── verification/
```

This is a target layout. The structure should be created only when implementation or adoption work is explicitly requested.

## Layout Principles

### Root Files Are Stable Control Documents

Root-level COS files define the base architecture and governance:

* `docs/specs/COS_ARCHITECTURE.md`
* `docs/specs/COS_GOVERNANCE_SPEC.md`
* `docs/specs/COS_IMPLEMENTATION_ARCHITECTURE.md`

These files are repository-readable reference documents. They should not contain transient work state.

### `.codex/` Is the Repository COS Control Plane

`.codex/` contains repository-specific COS adoption and governance configuration expressed as documentation.

It does not contain scripts, wrappers, or executable automation in this architecture.

### `docs/` Contains Durable Project Knowledge

`docs/` stores accepted, active, and historical project knowledge:

* architecture
* ADRs
* PRDs
* contracts
* release records
* incident records
* research records
* maintenance reports
* glossary

### `.codex-work/` Contains Continuity and Evidence

`.codex-work/` stores lower-authority continuity and evidence artifacts:

* handoff notes
* investigation notes
* verification notes

These artifacts are useful context, but they do not become authoritative policy by default.

## Artifact Locations

| Artifact | Location | Authority Class | Retention |
| --- | --- | --- | --- |
| Adoption profile | `.codex/adoption.md` | Repository Policy | durable |
| Repository COS governance | `.codex/governance.md` | Repository Policy | durable |
| Routing defaults | `.codex/routing.md` | Repository Policy | durable |
| Authority map | `.codex/authority.md` | Repository Policy | durable |
| Execution authority rules | `.codex/execution.md` | Repository Policy | durable |
| Knowledge map | `.codex/knowledge-map.md` | Repository Policy | durable |
| Architecture overview | `docs/architecture/overview.md` | Active Architecture Reference | durable |
| Decisions map | `docs/architecture/decisions-map.md` | Active Architecture Reference | durable |
| ADR | `docs/adr/YYYY-NNN-title.md` | Accepted Decision | durable |
| PRD | `docs/product/YYYY-NNN-title.md` | Active Product Spec | durable while active |
| Interface contract | `docs/contracts/YYYY-NNN-title.md` | Active Contract | durable while active |
| Research Brief | `docs/research/active/YYYY-NNN-topic.md` | Evidence or Decision support | until accepted or archived |
| Accepted research | `docs/research/accepted/YYYY-NNN-topic.md` | Decision support | durable until superseded |
| Archived research | `docs/research/archived/YYYY-NNN-topic.md` | Historical evidence | archive |
| Source Notes | colocated with research brief or `docs/research/active/YYYY-NNN-topic-sources.md` | Evidence | through decision lifecycle |
| Recommendation Memo | colocated with research brief or `docs/research/active/YYYY-NNN-topic-recommendation.md` | Decision support | until decision accepted |
| Options Matrix | colocated with research brief or `docs/research/active/YYYY-NNN-topic-options.md` | Decision support | through decision lifecycle |
| Release Checklist | `docs/operations/releases/YYYY-NNN-title.md` | Operational | release lifecycle |
| Incident Report | `docs/operations/incidents/YYYY-NNN-title.md` | Operational | durable |
| Runbook | `docs/operations/runbooks/title.md` | Operational Runbook | durable while active |
| Maintenance Report | `docs/maintenance/YYYY-NNN-title.md` | Operational or Reference | until superseded |
| Handoff Note | `.codex-work/handoffs/active/YYYY-MM-DD-topic.md` | Continuity Artifact | ephemeral |
| Archived Handoff | `.codex-work/handoffs/archived/YYYY-MM-DD-topic.md` | Continuity Artifact | archive |
| Investigation Note | `.codex-work/investigations/YYYY-MM-DD-topic.md` | Evidence | through related work |
| Verification Note | `.codex-work/verification/YYYY-MM-DD-topic.md` | Evidence | through related work |

## Governance Locations

Repository-level COS governance lives in `.codex/`.

### `.codex/adoption.md`

Defines the repository adoption profile.

Required content:

* COS Architecture Version
* COS Governance Version
* Adoption Level
* Repository Owner
* Governance Owner
* Artifact Locations
* Default Routes
* Required Overlays
* Verification Requirements
* Release Authority
* Execution Authority Limits
* Override Rules
* Review Cadence
* Migration Notes

### `.codex/governance.md`

Defines local governance rules that specialize `COS_GOVERNANCE_SPEC.md`.

Required content:

* local artifact lifecycle rules
* local artifact review cadence
* local artifact ownership
* local conflict resolution additions
* local knowledge update obligations
* local archival policy

### `.codex/routing.md`

Defines repository-specific route defaults.

Required content:

* default route for implementation requests
* default route for research requests
* default route for release requests
* required overlays by domain
* required review lenses by blast radius
* confirmation thresholds

### `.codex/authority.md`

Defines local authority mappings.

Required content:

* authoritative project docs
* active ADR index reference
* active contract index reference
* active product spec index reference
* known low-authority or historical locations
* source-of-truth precedence exceptions

### `.codex/execution.md`

Defines local execution authority.

Required content:

* autonomous local actions
* actions requiring confirmation
* forbidden actions
* production execution rules
* destructive action rules
* external service and cost-incurring action rules
* release approval rules

### `.codex/knowledge-map.md`

Defines how agents discover repository knowledge.

Required content:

* authoritative docs map
* ADR map
* contract map
* product spec map
* research map
* operations map
* handoff and evidence map
* stale or archived knowledge locations

## ADR Locations

ADRs live in:

```text
docs/adr/
```

Recommended naming:

```text
docs/adr/YYYY-NNN-short-title.md
```

Examples:

```text
docs/adr/2026-001-use-research-overlay-for-research-requests.md
docs/adr/2026-002-split-release-and-handoff.md
```

ADR index:

```text
docs/adr/README.md
```

The ADR index should list:

* active ADRs
* superseded ADRs
* archived ADRs
* related architecture docs
* affected contracts or workflows

ADRs are durable decision artifacts and should use the governance header from `COS_GOVERNANCE_SPEC.md`.

## Handoff Locations

Handoffs live in:

```text
.codex-work/handoffs/
```

Active handoffs:

```text
.codex-work/handoffs/active/
```

Archived handoffs:

```text
.codex-work/handoffs/archived/
```

Recommended naming:

```text
.codex-work/handoffs/active/YYYY-MM-DD-topic.md
```

Handoff notes are continuity artifacts. They preserve context for a user, reviewer, future agent, or downstream process.

Handoff notes must not become authoritative policy unless their content is promoted into a higher-authority artifact such as:

* ADR
* decision note
* PRD
* contract
* runbook
* repository governance file

Minimum handoff fields:

* current goal
* current state
* decisions made
* relevant files
* verification state
* risks
* unresolved questions
* next actor
* next action

## Research Locations

Research lives in:

```text
docs/research/
```

Research states:

```text
docs/research/active/
docs/research/accepted/
docs/research/archived/
```

Research requests use the specialized route:

```text
Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff
```

Research is not a core lifecycle stage.

### Research Trigger Scope

The Research Overlay is triggered when evaluating:

* technologies
* frameworks
* vendors
* AI models
* architectures
* external services
* libraries
* standards

### Required Research Artifacts

Required:

* Research Brief

Conditionally required:

* Options Matrix when multiple viable options exist
* Recommendation Memo when a decision is expected
* Source Notes when external sources are used

### Research Artifact Placement

For lightweight research, one file may contain all required sections:

```text
docs/research/active/YYYY-NNN-topic.md
```

For larger research, split files by artifact:

```text
docs/research/active/YYYY-NNN-topic-brief.md
docs/research/active/YYYY-NNN-topic-options.md
docs/research/active/YYYY-NNN-topic-recommendation.md
docs/research/active/YYYY-NNN-topic-sources.md
```

Accepted research should move to:

```text
docs/research/accepted/
```

Superseded or stale research should move to:

```text
docs/research/archived/
```

Research that leads to an architectural decision should link to the resulting ADR.

## Adoption Profile Location

The repository adoption profile lives at:

```text
.codex/adoption.md
```

This file is the local declaration of how the repository adopts COS.

It should define:

* COS Architecture Version
* COS Governance Version
* Adoption Level
* Repository Owner
* Governance Owner
* Artifact Locations
* Default Routes
* Required Overlays
* Verification Requirements
* Release Authority
* Execution Authority Limits
* Override Rules
* Review Cadence
* Migration Notes

Adoption profile authority:

* Authority Class: Repository Policy
* Retention Class: Reference
* Lifecycle State: Active after repository owner acceptance

## AGENTS Integration Model

`AGENTS.md` is the agent-facing entry point for repository behavior.

It should not duplicate the full COS architecture or governance specs. It should point agents to the right COS files and define repository-specific requirements.

### Root `AGENTS.md`

Root `AGENTS.md` should include:

* short statement that the repository uses COS
* pointer to `.codex/adoption.md`
* pointer to `.codex/routing.md`
* pointer to `.codex/execution.md`
* pointer to `.codex/knowledge-map.md`
* instruction to read COS architecture/governance specs for design-level work
* instruction to follow repository override precedence
* instruction that high-risk execution requires confirmation

### AGENTS Precedence

`AGENTS.md` participates in override precedence as Repository Policy.

It is below:

* system and developer instructions
* current user instruction
* safety, permission, and execution constraints

It is above:

* local COS adoption files when directly conflicting
* project ADRs and active specs for agent behavior rules
* COS base architecture and governance
* handoffs and examples

### AGENTS Scope

If nested `AGENTS.md` files exist, they may define local rules for subtrees.

Nested `AGENTS.md` files may:

* add local verification requirements
* add local overlays
* define local artifact paths for a subtree
* define local coding or documentation conventions

Nested `AGENTS.md` files may not:

* bypass repository-level execution authority
* make draft artifacts authoritative
* remove high-risk confirmation gates
* override higher-priority safety or permission rules

### AGENTS Minimal Content

Minimum useful AGENTS integration:

```text
This repository uses COS.

Before architecture, governance, implementation, release, research, or maintenance work:
- read .codex/adoption.md
- read .codex/routing.md
- read .codex/execution.md
- read .codex/knowledge-map.md

Follow docs/specs/COS_ARCHITECTURE.md and docs/specs/COS_GOVERNANCE_SPEC.md unless repository-specific instructions override them.

Do not treat handoff notes as policy.
Do not execute high-risk actions without explicit confirmation.
```

This text is an integration model, not a generated template.

## Repository Structure by Adoption Level

### A1: Documented

Minimum structure:

```text
/
├── AGENTS.md
├── docs/
│   └── specs/
│       ├── COS_ARCHITECTURE.md
│       └── COS_GOVERNANCE_SPEC.md
└── .codex/
    └── adoption.md
```

Purpose:

* declare COS usage
* define local adoption level
* point agents to base COS specs

### A2: Artifact-Aware

Adds:

```text
.codex/
├── governance.md
├── authority.md
└── knowledge-map.md
docs/
├── adr/
├── architecture/
├── product/
├── contracts/
└── research/
```

Purpose:

* define artifact authority
* define durable artifact locations
* make knowledge discoverable

### A3: Workflow-Aware

Adds:

```text
.codex/
├── routing.md
└── execution.md
.codex-work/
├── handoffs/
├── investigations/
└── verification/
docs/
├── operations/
└── maintenance/
```

Purpose:

* define route defaults
* define execution limits
* support handoff, verification, release, incident, and maintenance artifacts

### A4: Governed

Adds stronger governance expectations:

* artifact lifecycle review
* COS version tracking
* artifact schema version tracking
* adoption review cadence
* explicit release authority
* explicit conflict-resolution ownership

No additional directory is required beyond A3.

### A5: Automated

Automation may be introduced later, after governance is stable.

This document does not define automation.

## Non-Implementation Boundary

This implementation architecture does not create or require:

* wrapper scripts
* generated templates
* executable workflow runners
* automation hooks
* generated folders
* command-line tools

It only defines where COS support files and artifacts should live when repository adoption is implemented.

## Readiness Gate

Repository structure is ready to implement only when these questions can be answered:

* What COS adoption level is the repository targeting?
* Where is the adoption profile stored?
* Where are repository governance rules stored?
* Where are ADRs stored?
* Where are handoffs stored?
* Where are research artifacts stored?
* Which artifacts are durable and authoritative?
* Which artifacts are ephemeral continuity notes?
* How does `AGENTS.md` point agents to COS?
* Which local instructions override COS defaults?
* Which actions require confirmation before execution?
