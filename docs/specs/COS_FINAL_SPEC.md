# COS Final Specification

## Purpose

COS is a repository operating model for agent-assisted engineering work. It defines how agents understand requests, choose workflows, produce artifacts, respect authority, preserve knowledge, and avoid unsafe execution.

This document is the concise implementation-oriented reference for repository owners.

It does not implement folders, wrappers, scripts, templates, or automation.

## Core Lifecycle

The COS lifecycle is:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Not every request uses every stage.

Stage summary:

| Stage | Purpose |
| --- | --- |
| Intake | classify the request, risk, blast radius, route, overlays, and confirmation needs |
| Understand | inspect context, docs, code, constraints, users, and success criteria |
| Challenge | test viability before investing further |
| Decide | record the selected direction and rationale |
| Plan | sequence work, acceptance criteria, impacted areas, and verification |
| Build | perform local implementation or approved action |
| Verify | produce fresh evidence before completion claims |
| Release | handle rollout, rollback, migration, monitoring, or production operation when relevant |
| Handoff | preserve state, risks, evidence, open questions, and next action |
| Maintain | reduce drift, stale knowledge, dependency risk, and architecture degradation |

`Release` is skipped when no deployment, rollout, migration, runtime monitoring, or production operation is involved.

## Routing

Routing chooses the smallest responsible path through the lifecycle.

Default routes:

| Request | Route |
| --- | --- |
| Direct answer | `Intake -> Understand -> Handoff` |
| Review | `Intake -> Understand -> Challenge -> Handoff` with relevant review lenses |
| Research | `Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff` |
| Design | `Intake -> Understand -> Challenge -> Decide -> Plan -> Handoff` |
| Implementation | `Intake -> Understand -> Plan -> Build -> Verify -> Handoff` |
| Debugging | `Intake -> Understand -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Handoff` |
| Maintenance | `Intake -> Understand -> Maintain -> Plan -> Build -> Verify -> Handoff` |
| Release | `Intake -> Understand -> Plan -> Verify -> Release -> Handoff` |
| Incident | `Intake -> Understand -> Apply Incident Overlay -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain` |

Routing intrusiveness:

| Level | Use |
| --- | --- |
| Silent | obvious, low-risk work |
| Lightweight | moderate work where route context helps |
| Confirming | ambiguous, costly, or durable decisions |
| Mandatory | security, data, production, irreversible, or public-contract risk |

## Blast Radius

Blast radius determines process rigor.

| Level | Meaning | Minimum Rigor |
| --- | --- | --- |
| 0 Informational | no file or operational change | source-based accuracy check |
| 1 Local reversible | isolated, easy to revert | targeted content or local check |
| 2 Module-level | one feature/module/workflow | plan, targeted tests, relevant manual check |
| 3 Cross-module/public contract | APIs, schemas, permissions, shared behavior | challenge, decision, broader verification, docs |
| 4 Production/security/data-critical | production, secrets, destructive data, irreversible operations | explicit confirmation, rollback plan, release verification |

## Review Lenses

Review lenses evaluate work inside stages. They are not lifecycle stages.

| Lens | Use |
| --- | --- |
| Challenge | viability, assumptions, scope, failure modes |
| Critique | improve accepted artifacts |
| Code Review | correctness, maintainability, security, performance, tests |
| QA | user-visible behavior against acceptance criteria |
| Security | auth, permissions, secrets, user input, sensitive data |
| Architecture | boundaries, coupling, ownership, abstractions |
| Operations | deployability, rollback, observability, supportability |

Challenge comes before Critique when both apply.

## Overlays

Overlays add specialized requirements to lifecycle stages. They do not replace the lifecycle.

Active overlays:

| Overlay | Trigger |
| --- | --- |
| UX/Application | user workflows, UI, interaction, product behavior |
| API/Interface | endpoints, DTOs, contracts, module boundaries |
| Security/Privacy | auth, permissions, sensitive data, secrets, unsafe inputs |
| Data/Migration | schema, persistence, retention, data movement |
| Infrastructure/Kubernetes | infra, CI/CD, runtime config, Kubernetes |
| AI Application | prompts, models, retrieval, tool use, agent behavior |
| Research | technologies, frameworks, vendors, AI models, architectures, services, libraries, standards |
| Diagnosis | unexplained failures, bugs, failing tests, production symptoms |
| Incident | outage, degraded production behavior, security/data compromise |

Deprecated:

* Generic `Maintenance Overlay`

Maintenance uses the `Maintain` lifecycle stage. Specific overlays may be added later for Documentation Health, Dependency Health, Architecture Health, and CI/Test Health.

Research required artifacts:

* Research Brief
* Options Matrix when multiple viable options exist
* Recommendation Memo when a decision is expected
* Source Notes when external sources are used

Diagnosis required artifacts should include root-cause evidence for non-trivial unexplained failures.

## Governance

COS governance controls knowledge, authority, freshness, conflicts, execution, versioning, and adoption.

Governance is implemented first through repository structure and governance files, not tooling.

Core governance files:

```text
.codex/adoption.md
.codex/governance.md
.codex/routing.md
.codex/authority.md
.codex/execution.md
.codex/knowledge-map.md
```

Do not create `.codex/knowledge/` for now.

Knowledge Management responsibilities:

* identify authoritative sources
* classify artifacts by authority and freshness
* track artifact lifecycle state
* resolve artifact conflicts
* define update obligations
* preserve handoffs without turning them into policy

## Authority Model

Authority order:

```text
System/developer instructions
-> current user instruction
-> safety, permission, and execution constraints
-> repository AGENTS.md
-> repository COS adoption rules
-> accepted ADRs, policies, and contracts
-> active architecture, PRDs, RFCs, and plans
-> COS base specs
-> handoffs, examples, templates, historical artifacts
```

Rules:

* Higher authority beats lower authority.
* Newer does not automatically mean more authoritative.
* Handoff notes are context, not policy.
* Source code proves current behavior, not intended policy.
* Stale research must be revalidated before decisions.

Durable artifacts should include minimal governance fields:

```text
Status
Authority Class
Owner
Scope
Created
Last Reviewed
Review Cadence
Supersedes
Superseded By
Related Artifacts
Invalidation Triggers
```

Full templates are deferred.

## Execution Authority

Execution levels:

| Level | Meaning |
| --- | --- |
| E0 | read-only work |
| E1 | local reversible edits |
| E2 | local non-trivial implementation |
| E3 | external or privileged action |
| E4 | production/security/data-impacting action |
| E5 | destructive or irreversible action |
| E6 | forbidden action |

Explicit confirmation is required for:

* production changes
* destructive operations
* irreversible data changes
* secret or credential handling
* permission changes
* public contract breaks
* external cost-incurring operations
* actions outside permitted repository or sandbox scope
* security exceptions

Lifecycle stages do not imply permission. `Build` may require approval when it involves operational execution.

## Repository Layout

Reference A3 layout:

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
│   ├── decisions/
│   │   └── COS_ACCEPTED_DECISIONS.md
│   ├── architecture/
│   ├── adr/
│   ├── product/
│   ├── contracts/
│   ├── operations/
│   │   ├── releases/
│   │   ├── incidents/
│   │   └── runbooks/
│   ├── research/
│   │   ├── active/
│   │   ├── accepted/
│   │   └── archived/
│   ├── maintenance/
│   └── glossary.md
└── .codex-work/
    ├── handoffs/
    ├── investigations/
    └── verification/
```

Location rules:

* ADRs: `docs/adr/`
* durable research: `docs/research/`
* releases: `docs/operations/releases/`
* incidents: `docs/operations/incidents/`
* runbooks: `docs/operations/runbooks/`
* handoffs: `.codex-work/handoffs/`
* investigations: `.codex-work/investigations/`
* verification notes: `.codex-work/verification/`

`.codex-work/` is ephemeral by default. Important findings must be promoted into durable docs when they affect decisions, contracts, incidents, releases, or long-term knowledge.

## Adoption Levels

| Level | Name | Meaning |
| --- | --- | --- |
| A0 | Unadopted | COS used ad hoc only |
| A1 | Documented | minimum lightweight adoption |
| A2 | Artifact-aware | artifact locations and authority are defined |
| A3 | Workflow-aware | reference implementation target |
| A4 | Governed | versioning, review cadence, governance ownership |
| A5 | Automated | optional extension outside core COS |

A1 minimum:

```text
AGENTS.md
docs/specs/COS_ARCHITECTURE.md
docs/specs/COS_GOVERNANCE_SPEC.md
.codex/adoption.md
```

A3 reference target adds:

```text
.codex/routing.md
.codex/execution.md
.codex/authority.md
.codex/knowledge-map.md
.codex-work/
docs/operations/
docs/maintenance/
```

Bootstrap strategy:

* guided manual bootstrap
* checklist-based validation
* no scripts
* no wrappers
* no generated templates
* no automation yet

## AGENTS Integration

`AGENTS.md` is the agent-facing entry point.

It should:

* declare that the repository uses COS
* point to `.codex/adoption.md`
* point to `.codex/routing.md`
* point to `.codex/execution.md`
* point to `.codex/knowledge-map.md`
* require high-risk confirmation
* state that handoff notes are not policy
* point to base COS specs for architecture and governance work

Nested `AGENTS.md` files may add local rules but may not bypass execution authority or high-risk confirmation.

## Accepted Architectural Decisions

Accepted:

* Diagnosis is a specialized overlay.
* Generic Maintenance Overlay is deprecated.
* Maintenance uses the Maintain stage and future specific overlays only when needed.
* Knowledge Management starts as repository structure and governance files, not tooling.
* A3 Workflow-Aware is the reference implementation target.
* A1 is the minimum lightweight adoption level.
* Bootstrap is guided manual with checklists.
* `.codex-work/` is ephemeral by default.
* Important `.codex-work/` findings must be promoted into durable docs.
* Knowledge files stay as top-level `.codex` files.
* Do not create `.codex/knowledge/` yet.
* A5 automation is optional and outside core COS.
* Bootstrap validation is manual checklist-based.
* Only minimal artifact schema requirements are defined now.

## Repository Owner Checklist

To adopt COS manually:

1. Choose adoption level: A1 minimum, A3 reference.
2. Add or update `AGENTS.md` to point agents to COS files.
3. Define `.codex/adoption.md`.
4. For A3, define routing, execution, authority, governance, and knowledge-map files.
5. Create durable docs locations only when needed.
6. Treat `.codex-work/` as ephemeral unless findings are promoted.
7. Require confirmation for Level 3/4 blast radius and E3-E5 execution.
8. Use Research and Diagnosis as overlays, not lifecycle stages.
9. Do not add automation until A3 is proven.

## Non-Implementation Boundary

This final spec does not create:

* folders
* wrappers
* scripts
* templates
* automation
* bootstrap tooling

It defines the COS model a repository owner needs to understand before adoption.
