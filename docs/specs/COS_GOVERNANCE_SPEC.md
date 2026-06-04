# COS Governance Specification

## Purpose

This document defines governance for the Codex Operating System (COS).

Governance defines how COS knowledge, artifacts, authority, execution, versioning, overrides, conflicts, freshness, and repository adoption are managed across projects.

This specification does not implement COS. It does not create wrappers, templates, scripts, generated folders, or runtime tooling.

## Scope

This specification covers:

* Knowledge Management Layer
* Artifact Authority Model
* Artifact Lifecycle Model
* Repository Override Precedence
* Execution Authority Model
* COS Versioning Strategy
* Knowledge Freshness Rules
* Artifact Conflict Resolution
* Knowledge Update Obligations
* Repository Adoption Model

## Governance Principles

### Authority Must Be Explicit

Every durable COS artifact must make its authority clear. Agents should not treat handoff notes, draft plans, examples, or stale research as policy.

### Freshness Must Be Managed

Knowledge decays at different rates. COS must distinguish stable architectural decisions from time-sensitive vendor, model, library, and operational facts.

### Overrides Must Be Ordered

Repository-specific instructions may customize COS, but override precedence must be explicit so agents can resolve conflicts consistently.

### Execution Must Be Permissioned

COS must distinguish between actions an agent may take autonomously, actions requiring confirmation, and actions forbidden without explicit approval.

### Knowledge Must Be Updated After Evidence

Verification, release, incidents, maintenance, and research can all invalidate prior knowledge. COS must define when artifacts are updated, superseded, or archived.

## 1. Knowledge Management Layer

The Knowledge Management Layer governs how COS captures, retrieves, validates, updates, and retires knowledge.

It sits above the lifecycle and applies to every route, overlay, lens, and artifact.

```text
Knowledge Management
├── Authority Model
├── Artifact Lifecycle
├── Freshness Model
├── Retrieval Rules
├── Conflict Resolution
├── Update Obligations
├── Retention and Archival
└── Versioning
```

### Responsibilities

The Knowledge Management Layer is responsible for:

* identifying authoritative sources
* classifying artifacts by authority and freshness
* defining artifact lifecycle states
* resolving conflicts between artifacts
* deciding when repository knowledge must be updated
* deciding when external facts must be revalidated
* preserving handoff context without turning it into policy
* keeping COS adoption consistent across repositories

### Knowledge Types

COS recognizes these knowledge types:

| Type | Description | Examples |
| --- | --- | --- |
| Policy | Rules that govern agent behavior | AGENTS, COS governance, security rules |
| Decision | Accepted choices and rationale | ADR, decision note, accepted RFC |
| Contract | Public or internal interface commitments | API contract, data schema, permission model |
| Product | User-facing behavior and acceptance criteria | PRD, workflow spec, UX state inventory |
| Operational | Runtime, deployment, and support knowledge | runbook, release checklist, incident report |
| Continuity | Temporary context for resuming work | handoff note, investigation note |
| Evidence | Proof, observations, or source material | verification output, source notes, test results |
| Reference | Stable explanatory material | architecture spec, glossary, guide |

### Retrieval Tiers

When repository context is needed, agents should inspect knowledge in this order:

| Tier | Sources | Use |
| --- | --- | --- |
| 1 | current user instruction and task-specific files | determine immediate goal and constraints |
| 2 | repository instructions and local COS adoption docs | determine local rules and overrides |
| 3 | accepted policies, ADRs, active architecture docs, active contracts | determine durable project truth |
| 4 | PRDs, RFCs, implementation plans, test plans | determine intended work and acceptance |
| 5 | source code, tests, configs, runtime evidence | verify actual behavior |
| 6 | handoffs, incident reports, maintenance reports | recover context and historical rationale |
| 7 | external sources | validate time-sensitive or missing facts |

Source code and runtime evidence may override stale documentation as evidence of current behavior, but they do not automatically define intended policy.

### Knowledge States

Knowledge can be:

* current: aligned with active decisions and observed behavior
* stale: likely outdated but not yet superseded
* conflicting: contradicted by another artifact or observed behavior
* superseded: replaced by newer authoritative knowledge
* archived: retained for history but not active guidance

Agents must not rely on stale, conflicting, superseded, or archived knowledge without noting the limitation.

## 2. Artifact Authority Model

The Artifact Authority Model defines which artifacts can govern decisions and how conflicts are resolved.

### Authority Classes

| Class | Authority | Examples | Notes |
| --- | --- | --- | --- |
| System Policy | Highest | system/developer instructions | external to COS; cannot be overridden by COS |
| Task Authority | Very high | current user instruction | governs the current task unless unsafe or contradictory to higher policy |
| Repository Policy | High | AGENTS.md, project-specific COS rules | governs local behavior |
| Accepted Decision | High | accepted ADR, accepted RFC, decision note | governs architecture and durable choices |
| Active Contract | High | API contract, schema, permission model | governs observable commitments |
| Active Product Spec | Medium-high | PRD, workflow spec, acceptance criteria | governs user-facing behavior |
| Active Architecture Reference | Medium-high | COS_ARCHITECTURE, architecture spec, glossary | governs conceptual model |
| Operational Runbook | Medium | release checklist, runbook, incident procedure | governs runtime and support behavior |
| Evidence | Medium | tests, logs, source notes, verification output | proves facts but may not define intent |
| Continuity Artifact | Low | handoff note, investigation note | useful context, not authoritative policy |
| Example or Template | Low | examples, sample docs | illustrative unless explicitly adopted |
| Draft Artifact | Lowest | draft PRD, draft ADR, draft plan | not binding until accepted |

### Required Governance Header

Every durable artifact should include a governance header.

Minimum fields:

```text
Status:
Authority Class:
Owner:
Scope:
Created:
Last Reviewed:
Review Cadence:
Supersedes:
Superseded By:
Related Artifacts:
Invalidation Triggers:
```

Optional fields:

```text
COS Version:
Artifact Schema Version:
Approval:
External Sources:
Freshness Class:
Retention Class:
```

### Authority Rules

* Higher-authority artifacts override lower-authority artifacts.
* Newer artifacts do not automatically override higher-authority artifacts.
* Handoff notes preserve context but do not create policy.
* Draft artifacts do not govern implementation unless the user explicitly directs their use for the current task.
* Source code proves current behavior but may conflict with intended behavior.
* Runtime evidence proves observed behavior at a point in time, not durable policy.
* External sources must be evaluated by source authority and freshness before influencing decisions.

## 3. Artifact Lifecycle Model

Artifacts move through lifecycle states.

```text
Draft -> Proposed -> Accepted -> Active -> Superseded -> Archived
```

### States

| State | Meaning | Agent Behavior |
| --- | --- | --- |
| Draft | incomplete or exploratory | use only as context |
| Proposed | ready for review but not adopted | do not treat as policy |
| Accepted | approved as a decision or artifact | use as governing knowledge |
| Active | currently authoritative in its scope | prefer unless higher authority conflicts |
| Superseded | replaced by newer artifact | do not use except for history |
| Archived | retained for record only | do not use for active guidance |

### State Transitions

Allowed transitions:

* Draft -> Proposed
* Draft -> Archived
* Proposed -> Accepted
* Proposed -> Draft
* Proposed -> Archived
* Accepted -> Active
* Active -> Superseded
* Active -> Archived
* Superseded -> Archived

Disallowed by default:

* Archived -> Active
* Superseded -> Active
* Draft -> Active

Restoring archived or superseded knowledge requires explicit user or repository owner approval.

### Retention Classes

| Retention Class | Examples | Default Retention |
| --- | --- | --- |
| Ephemeral | handoff note, scratch investigation | until work closes or supersedes |
| Evidence | verification output, source notes | through related decision or release lifecycle |
| Operational | release checklist, incident timeline | through release or incident review cycle |
| Decision | ADR, decision note, accepted RFC | durable until superseded |
| Contract | API contract, schema, permission model | durable while contract is active |
| Reference | architecture spec, glossary, guide | durable while maintained |

## 4. Repository Override Precedence

COS must define how global COS rules interact with repository-specific instructions.

### Precedence Order

When instructions conflict, apply this order:

```text
1. System and developer instructions
2. Current user instruction
3. Safety, permission, and execution constraints
4. Repository AGENTS.md or equivalent project instructions
5. Repository-specific COS adoption rules
6. Accepted project ADRs, policies, and contracts
7. Active project architecture, PRDs, RFCs, and plans
8. COS base architecture and governance specifications
9. Handoff notes, examples, templates, and historical artifacts
```

### Override Rules

Repository rules may:

* narrow COS behavior
* add required overlays
* add verification requirements
* define local artifact paths
* define local terminology
* require additional approvals
* choose stricter process levels

Repository rules may not:

* bypass higher-priority system or developer instructions
* remove safety gates for high-risk work without explicit approval
* make stale or draft artifacts authoritative by default
* permit destructive, production, security, or data-impacting execution without required confirmation
* silently redefine core COS terms in a way that breaks cross-repository reuse

### Conflict Handling

If repository instructions conflict with COS base governance:

* prefer repository instructions for local workflow details
* prefer COS governance for cross-repository safety and artifact semantics
* ask the user only when the conflict changes policy, public behavior, security, data, or execution authority
* document the conflict in the relevant handoff or decision artifact

## 5. Execution Authority Model

The Execution Authority Model defines what an agent may do autonomously.

### Authority Levels

| Level | Name | Agent May Proceed? | Examples |
| --- | --- | --- | --- |
| E0 | Read-only | Yes | inspect files, summarize docs, explain code |
| E1 | Local reversible | Yes, if task-directed | edit local docs, small local code changes |
| E2 | Local non-trivial | Usually yes with plan | feature work, refactor, tests, local build |
| E3 | External or privileged | Requires confirmation or approved permission | network calls, package installs, cloud reads, CI operations |
| E4 | Production/security/data-impacting | Requires explicit confirmation | deploy, secret handling, permission changes, migrations |
| E5 | Destructive or irreversible | Requires explicit confirmation and rollback/impact plan | data deletion, destructive migration, production rollback |
| E6 | Forbidden by policy | No | actions disallowed by system, developer, legal, or safety rules |

### Confirmation Requirements

Explicit confirmation is required for:

* production changes
* destructive operations
* irreversible data changes
* secret or credential handling
* permission or access-control changes
* public contract breaks
* external cost-incurring operations
* actions outside permitted repository or sandbox scope
* policy decisions that would govern future behavior
* security exceptions

### Execution Records

For E3 through E5 actions, the handoff or execution artifact should record:

* requested action
* approval source
* command or operation
* scope
* expected impact
* rollback or recovery plan, if relevant
* result
* verification evidence
* residual risk

### Build vs Execute

In the COS lifecycle, `Build` may mean:

* implementing local code or configuration
* preparing an operational change
* executing an approved operational action

For E4 and E5 work, `Build` must be treated as approval-gated execution. Agents must not infer permission from the lifecycle stage alone.

## 6. COS Versioning Strategy

COS requires versioning for the architecture, governance, and artifact schemas.

### Versioned Units

Version these independently:

* COS Architecture Specification
* COS Governance Specification
* artifact schemas
* route definitions
* overlay definitions
* review lens definitions
* repository adoption profile

### Version Format

Use semantic versioning:

```text
MAJOR.MINOR.PATCH
```

Meaning:

* MAJOR: breaking change to lifecycle, authority, artifact semantics, routing, or execution policy
* MINOR: additive route, overlay, artifact, or governance behavior
* PATCH: clarification, typo fix, non-semantic wording improvement

### Compatibility Rules

* A repository adoption profile should declare the COS architecture and governance versions it follows.
* Artifact schemas should declare their schema version.
* Major COS upgrades require migration notes.
* Deprecated stages, overlays, artifacts, or authority classes should remain documented for at least one major version after replacement.
* Repository-specific overrides must state which COS version they target.

### Version Change Governance

Version changes should include:

* summary of changed semantics
* affected lifecycle stages
* affected overlays or lenses
* affected artifact schemas
* migration requirements
* deprecated concepts
* compatibility notes

## 7. Knowledge Freshness Rules

Knowledge freshness defines when information must be revalidated before use.

### Freshness Classes

| Class | Examples | Revalidation Trigger |
| --- | --- | --- |
| Stable | domain glossary, accepted ADR rationale, governance definitions | conflicting evidence or major COS/repo change |
| Slow-changing | architecture docs, internal API contracts, product workflows | contract changes, release, significant refactor |
| Time-sensitive | vendor docs, library versions, AI model capabilities, cloud service behavior | before decision, implementation, purchase, or production use |
| Operational | release state, incident status, CI status, monitoring data | every use |
| Ephemeral | command output, logs, test results, handoff state | every completion or decision claim |

### Research Freshness

Research Overlay outputs must track freshness when external sources are used.

Source Notes should include:

* source title or identifier
* source URL or repository reference, when available
* source authority
* retrieval date
* relevant version, if any
* freshness class
* revalidation trigger

### Staleness Triggers

Knowledge becomes stale when:

* a newer accepted artifact supersedes it
* source code or runtime behavior contradicts it
* a dependency, vendor, model, or cloud service changes materially
* a release changes behavior or contracts
* an incident reveals false assumptions
* the artifact exceeds its review cadence
* the repository adopts a newer COS version

## 8. Artifact Conflict Resolution

Conflicts occur when two artifacts, or an artifact and observed behavior, disagree.

### Conflict Types

| Conflict Type | Example |
| --- | --- |
| Instruction conflict | current user request conflicts with AGENTS.md |
| Decision conflict | ADR conflicts with current architecture spec |
| Contract conflict | API contract conflicts with implementation |
| Evidence conflict | tests or logs contradict documentation |
| Freshness conflict | research brief conflicts with newer vendor docs |
| Continuity conflict | handoff note conflicts with accepted decision |

### Resolution Procedure

1. Identify the conflicting sources.
2. Classify each source by authority class.
3. Check artifact lifecycle state.
4. Check freshness class and review date.
5. Verify against source code, tests, runtime evidence, or primary external source when appropriate.
6. Prefer the higher-authority current artifact.
7. If authority is equal, prefer the newer accepted artifact.
8. If intent and behavior conflict, report both; do not silently treat behavior as intended policy.
9. Ask the user only when the conflict changes policy, security, data, public contracts, cost, or scope.
10. Update, supersede, or archive the stale artifact when the resolution is clear.

### Conflict Reporting

Conflict reports should include:

* conflicting artifacts or evidence
* authority class of each source
* lifecycle state of each artifact
* freshness assessment
* recommended source of truth
* required user decision, if any
* update obligation

## 9. Knowledge Update Obligations

COS must update knowledge when work changes assumptions, contracts, decisions, or observed behavior.

### Update Gates

Knowledge update obligations are checked after:

* Decide
* Plan
* Verify
* Release
* Incident handling
* Maintain
* Research Overlay

### Mandatory Updates

Update or create a durable artifact when:

* an architectural decision is accepted
* a public contract changes
* a permission, security, or data rule changes
* a product workflow changes
* a migration changes persistence semantics
* release or rollback procedure changes
* an incident reveals a new operational risk
* research leads to a recommendation or decision
* verification invalidates an assumption
* repository-specific COS behavior changes

### Optional Updates

Updates may be skipped when:

* the task is Level 0 informational
* the change is local, reversible, and not policy-relevant
* the artifact would duplicate an existing current artifact
* the user explicitly asks for review only and no decision is made

Skipped updates should be mentioned in the handoff only when the omission creates residual risk.

### Supersession Obligations

When a new artifact replaces an old one:

* mark the old artifact as superseded
* link the new artifact from the old artifact
* link the old artifact from the new artifact
* preserve rationale if it remains useful
* archive only when historical context is no longer needed for active work

## 10. Repository Adoption Model

The Repository Adoption Model defines how a repository adopts COS without requiring immediate full implementation.

### Adoption Levels

| Level | Name | Description |
| --- | --- | --- |
| A0 | Unadopted | COS may be used ad hoc by an agent, but the repository has no local adoption rules |
| A1 | Documented | repository declares COS principles and override precedence |
| A2 | Artifact-aware | repository defines artifact locations, authority, and lifecycle expectations |
| A3 | Workflow-aware | repository defines route defaults, overlays, verification rules, and handoff expectations |
| A4 | Governed | repository tracks COS version, schema versions, review cadence, and governance ownership |
| A5 | Automated | repository may add scripts or tooling after governance is stable |

This specification only defines the model. It does not implement any adoption level.

### Adoption Profile

A repository adoption profile should define:

```text
COS Architecture Version:
COS Governance Version:
Adoption Level:
Repository Owner:
Governance Owner:
Artifact Locations:
Default Routes:
Required Overlays:
Verification Requirements:
Release Authority:
Execution Authority Limits:
Override Rules:
Review Cadence:
Migration Notes:
```

### Minimum Adoption

The minimum useful adoption is A1:

* declare that COS is used
* define repository override precedence
* identify local project instructions
* state that high-risk work still requires confirmation

### Recommended Adoption

For serious engineering repositories, recommended adoption is A3:

* local route defaults
* artifact authority rules
* required overlays
* verification expectations
* handoff expectations
* release and execution limits

### Adoption Constraints

Repository adoption must not:

* bypass execution authority rules
* make draft artifacts authoritative
* remove high-risk confirmation requirements
* hide conflicts between COS and local policy
* introduce automation before governance is clear

### Adoption Review

Adoption should be reviewed when:

* COS major version changes
* repository architecture changes materially
* repository ownership changes
* production or security posture changes
* repeated conflicts occur between local instructions and COS
* agents repeatedly misroute work

## Governance Readiness Gate

COS governance is ready to support implementation only when these questions can be answered:

* Which artifact is authoritative for a given decision?
* What lifecycle state is each durable artifact in?
* Which repository instruction overrides COS behavior?
* What actions may an agent execute autonomously?
* What actions require confirmation?
* What COS version is the repository using?
* Which external facts require freshness validation?
* How are artifact conflicts resolved?
* When must knowledge be updated?
* What adoption level does the repository target?

## Non-Implementation Boundary

This governance specification does not create or require:

* wrapper scripts
* executable workflow runners
* generated templates
* generated folders
* repository bootstrap scripts
* automation hooks

Those may be considered later only after architecture and governance are validated.
