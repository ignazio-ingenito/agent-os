# COS Architecture Review V2

## Review Scope

This review evaluates `../specs/COS_ARCHITECTURE.md` using the Architecture Lens.

Focus areas:

* overlaps
* unnecessary complexity
* lifecycle violations
* missing concepts
* missing governance
* Research
* Release vs Handoff
* Knowledge Management

This document is a review artifact only. It does not implement COS or revise the architecture spec.

## Executive Summary

`../specs/COS_ARCHITECTURE.md` is a strong improvement over the original pipeline list. It establishes a lifecycle-first architecture, introduces routing, defines blast radius, separates review lenses from overlays, and gives artifacts clearer purpose.

The main architectural weakness is taxonomy drift. The Research decision now resolves one part of that drift: Research is not a core lifecycle stage and is implemented through the Research Overlay. Remaining drift still exists where route syntax introduces non-lifecycle nodes such as `Diagnose` and `Critique`, and where overlays or lenses can look like stages.

The largest missing concept is Knowledge Management. COS currently references documentation, artifacts, handoffs, ADRs, source notes, and maintenance reports, but it does not define how knowledge is captured, normalized, indexed, invalidated, updated, or retired. Without a knowledge layer, COS will produce many artifacts but lack a governance model for keeping them coherent over time.

The highest-priority architecture corrections are:

* Keep Research out of the core lifecycle and implement research requests through the Research Overlay.
* Split Release and Handoff into separate lifecycle outcomes.
* Add a Knowledge Management layer that governs artifact authority, freshness, retention, indexing, and synchronization.
* Normalize route syntax so lifecycle stages, lenses, overlays, and specialized route operations remain clearly typed.
* Add governance for versioning, overrides, artifact ownership, change control, and deprecation.

## Findings

### Critical: Route Syntax Violates the Lifecycle Model

`../specs/COS_ARCHITECTURE.md` defines the core lifecycle as:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

But later routes include:

```text
Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff
Intake -> Understand -> Diagnose -> Plan -> Build -> Verify -> Handoff
Intake -> Understand -> Challenge -> Critique -> Handoff
```

`Apply Research Overlay`, `Diagnose`, and `Critique` are not core lifecycle stages. The Research route is now intentionally specialized and overlay-backed, which is acceptable if the architecture clearly treats it as an overlay application rather than a lifecycle stage. `Critique` is explicitly defined as a review lens. `Diagnose` is mentioned as a route node but has no lifecycle stage, lens, overlay, or artifact section.

This creates a structural contradiction: the architecture claims lifecycle stages are the routing spine, but the routing table mixes stages, lenses, overlays, and implied skills.

Recommendation:

Use only lifecycle stages in ordinary route strings. For specialized routes such as research, allow explicit overlay application only if the route syntax names it as an overlay operation.

Example:

```text
Route: Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff
Overlay: Research
Lenses: Challenge, Critique
Artifacts: Research Brief, Options Matrix when multiple viable options exist, Recommendation Memo when a decision is expected, Source Notes when external sources are used
```

Do not promote Research to a core lifecycle stage. The explicit decision is that Research remains a specialized route implemented through the Research Overlay.

### Critical: Release and Handoff Are Correctly Split but Need Governance

The prior combined release/handoff stage merged two different responsibilities:

* Release prepares or executes deployment, rollout, rollback, monitoring, and production readiness.
* Handoff preserves context for a user, reviewer, future agent, or downstream process.

These are not the same lifecycle outcome. Handoff is always useful when work is paused, blocked, delegated, reviewed, or completed. Release is only relevant when operational deployment or rollout is involved. The architecture decision now correctly separates them:

```text
Verify -> Release -> Handoff
```

For work without operational rollout, the path remains:

```text
Verify -> Handoff
```

Remaining governance risks:

* low-risk work appears to have a release phase when it only needs a summary
* production work can be reduced to a handoff note without release gates
* release artifacts and handoff artifacts blur together
* verification state, next actor, rollout readiness, and rollback readiness are mixed

Recommendation:

Keep `Release` and `Handoff` split. Define release authority, release blockers, rollback ownership, and post-release verification so the split has operational force.

### Critical: Knowledge Management Is Missing as a First-Class Architecture Layer

COS produces many durable artifacts:

* Problem Brief
* Research Brief
* Options Matrix
* Decision Note
* PRD
* ADR
* RFC
* Test Plan
* Interface Contract
* Security Review
* Migration Plan
* Release Checklist
* Handoff Note
* Maintenance Report
* Incident Report

The architecture does not define how these artifacts relate to each other, which ones are authoritative, how stale artifacts are detected, or how knowledge is carried across sessions and repositories.

This is a major gap because COS is meant to be reusable across many repositories. Without knowledge governance, COS will accumulate documents that conflict, drift, and confuse future agents.

Recommendation:

Add a `Knowledge Management` architecture layer with:

* artifact authority hierarchy
* artifact lifecycle states
* freshness rules
* invalidation triggers
* indexing/discovery rules
* cross-reference rules
* retention and archival rules
* update obligations
* repository override rules

Suggested artifact lifecycle:

```text
Draft -> Proposed -> Accepted -> Active -> Superseded -> Archived
```

Suggested authority order:

```text
User instruction for current task
-> repository AGENTS/project instructions
-> accepted ADRs/policies
-> active architecture/spec docs
-> PRDs/RFCs/plans
-> handoff notes
-> examples and generated docs
```

Handoff notes should not become authoritative by default. They should be continuity artifacts, not policy.

### Important: Research Decision Is Clear, but Governance Still Needs Tightening

Research is now defined as a specialized route implemented through the Research Overlay, not as a core lifecycle stage.

Decision:

```text
Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff
```

Trigger scope:

* technologies
* frameworks
* vendors
* AI models
* architectures
* external services
* libraries
* standards

Required artifacts:

* Research Brief
* Options Matrix when multiple viable options exist
* Recommendation Memo when a decision is expected
* Source Notes when external sources are used

Research overlay responsibilities:

* gather current or authoritative sources
* compare alternatives
* assess maturity and operational fit
* produce the required research artifacts based on the request

Remaining concern: the architecture should define source authority, freshness rules, citation requirements, and revalidation triggers for research outputs.

### Important: Diagnose Is Used but Not Architected

The debugging route uses:

```text
Intake -> Understand -> Diagnose -> Plan -> Build -> Verify -> Handoff
```

But `Diagnose` is not defined as a lifecycle stage, lens, overlay, or artifact source. This leaves root-cause work underspecified.

Recommendation:

Make Diagnose an overlay or review lens, not a lifecycle stage.

Suggested route:

```text
Route: Intake -> Understand -> Plan -> Build -> Verify -> Handoff
Overlay: Diagnosis
Special rule: root-cause diagnosis must complete before Build for unexplained failures.
```

Required diagnosis artifacts should be lightweight:

* observed symptom
* reproduction path
* hypotheses tested
* confirmed root cause
* rejected causes
* fix target

### Important: Critique Appears as a Route Node Despite Being a Lens

The review route uses:

```text
Intake -> Understand -> Challenge -> Critique -> Handoff
```

This violates the architecture statement that review lenses are not standalone lifecycle stages unless explicitly requested.

Recommendation:

Represent review requests as:

```text
Route: Intake -> Understand -> Handoff
Lenses: Challenge, Critique, Architecture
Artifacts: Review Report
```

For reviews that produce decisions:

```text
Route: Intake -> Understand -> Decide -> Handoff
Lenses: Challenge, Critique
```

### Important: Maintain Is Both a Lifecycle Stage and an Overlay

`Maintain` is a lifecycle stage and `Maintenance` is also an overlay. This is not inherently wrong, but the boundary is unclear.

Current ambiguity:

* Maintain stage reduces long-term repository degradation.
* Maintenance overlay adds checks for drift, stale docs, dependency risk, and hidden coupling.

The overlay appears to duplicate the stage instead of adding domain-specific behavior.

Recommendation:

Keep `Maintain` as a lifecycle stage. Replace `Maintenance Overlay` with specific overlays:

* Dependency overlay
* Documentation overlay
* Architecture health overlay
* CI/test health overlay

This makes maintenance composable instead of circular.

### Important: Artifact Governance Is Underspecified

The artifact list is useful but lacks governance fields.

Missing governance:

* owner
* status
* source of truth
* supersedes/superseded-by
* last reviewed date
* review cadence
* invalidation triggers
* related artifacts
* repository scope
* authority level

Without these fields, COS cannot reliably determine whether an artifact should be trusted, updated, ignored, or archived.

Recommendation:

Every durable artifact should include a governance header.

Suggested minimum:

```text
Status:
Owner:
Scope:
Created:
Last Reviewed:
Supersedes:
Superseded By:
Source of Truth:
Related Artifacts:
Invalidation Triggers:
```

### Important: No Distinction Between Ephemeral and Durable Knowledge

The architecture says artifacts are durable outputs created only when useful, but many listed artifacts are not equally durable.

Examples:

* ADRs and policies are durable.
* Handoff notes are ephemeral continuity aids.
* Release checklists may expire after deployment.
* Research briefs become stale as tools, vendors, models, and frameworks change.
* Incident reports are durable history but not necessarily active guidance.

Recommendation:

Classify artifacts by retention class:

* Ephemeral: handoff notes, scratch investigation notes
* Operational: release checklists, rollout notes, incident timelines
* Decision: ADRs, policy notes, decision notes
* Product: PRDs, acceptance criteria
* Reference: architecture specs, interface contracts, domain glossary
* Evidence: verification logs, test results, source notes

### Important: Release Lacks Deployment Authority and Rollback Governance

Release artifacts exist, but Release does not define:

* who can approve release
* what requires release approval
* what blocks release
* rollback authority
* deployment freeze conditions
* post-release verification ownership
* how incidents feed back into Maintain

Recommendation:

If Release becomes a separate stage, define:

Entry criteria:

* verified work exists
* deployment or operational rollout is required
* release owner is known
* rollback strategy exists for Level 3/4 work

Exit criteria:

* rollout completed or explicitly deferred
* post-release verification completed
* rollback window and owner are known
* monitoring signals are checked
* incident or follow-up tasks are created if needed

### Important: Handoff Lacks Audience-Specific Variants

The Handoff Note has a useful minimum field list, but one handoff shape will not fit all audiences.

Different handoffs:

* user summary
* implementation continuation
* code review handoff
* release handoff
* incident handoff
* research handoff
* blocked-work handoff

Recommendation:

Define Handoff as a stage with variants selected by audience and next action.

Minimum shared fields:

* current goal
* current state
* decisions made
* evidence gathered
* risks
* open questions
* next actor
* next action

Audience-specific extensions can add changed files, commands, source notes, deployment state, or incident timeline.

### Moderate: Build Is Overloaded With Operational Change

Build currently means "perform the planned implementation, remediation, or operational change." That makes Build responsible for code changes, config changes, remediation, and operational action.

This may be acceptable for a simple lifecycle, but it becomes risky for Level 4 production/security/data-critical work. Operational action often needs approval, preflight checks, execution logs, rollback, and post-action verification. That is different from implementation.

Recommendation:

Either:

* keep Build but define `Operational Execute` as an Operations overlay substep, or
* split Build into `Implement` and `Execute` for operational workflows.

Do not route production action through Build without explicit operational gates.

### Moderate: Maintain as Final Lifecycle Stage Can Blur Ongoing Governance

The lifecycle ends with Maintain, but maintenance is not just the final phase after work. It is also a continuous governance process.

Examples:

* stale docs detection
* dependency drift
* architecture drift
* artifact review cadence
* ADR supersession
* knowledge base cleanup

Recommendation:

Model Maintain as both:

* a lifecycle stage for explicit maintenance requests
* a governance loop that periodically reviews knowledge, dependencies, architecture, tests, and operations

The spec should state the difference.

### Moderate: Blast Radius Level 4 Needs Approval-Gated Build Semantics

Level 4 now includes the core lifecycle action point:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

The remaining issue is that `Build` may mean implementation, approved operational execution, or preparation for a human-operated change. Level 4 work needs explicit approval-gated semantics so the architecture does not imply autonomous production/security/data action.

Recommendation:

Use a gated action stage:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Execute -> Verify -> Release -> Handoff -> Maintain
```

If agents are not allowed to execute Level 4 changes, define:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Handoff
```

with `Execution forbidden without explicit approval`.

### Moderate: The Architecture Does Not Define Repository Override Precedence

The readiness gate asks how repository-specific instructions override COS defaults, but the architecture does not answer it.

Recommendation:

Add governance precedence:

```text
System/developer instructions
-> current user instruction
-> repository AGENTS.md
-> local COS configuration
-> accepted project ADRs/policies
-> COS base architecture
-> examples/templates
```

The exact order may need adjustment, but the architecture should define it explicitly.

### Moderate: No Versioning or Migration Model for COS Itself

COS is intended to be reusable across repositories. The architecture does not define how COS changes over time.

Missing:

* COS version
* artifact schema version
* migration rules
* deprecation policy
* compatibility guarantees
* project override compatibility

Recommendation:

Add a COS governance section:

* semantic versioning for COS architecture
* schema versions for artifacts
* deprecation windows for renamed stages, overlays, and lenses
* migration notes for repository adopters
* compatibility rules for project-specific overrides

### Moderate: Knowledge Freshness Is Not Modeled

Research, dependency, infrastructure, AI model, and API recommendations decay quickly. The architecture says research may require current external sources, but it does not define freshness.

Recommendation:

Add freshness classes:

* Stable: domain glossary, core architecture, accepted ADR rationale
* Slow-changing: internal API contracts, product workflows
* Time-sensitive: vendor docs, library versions, cloud service behavior, model capabilities
* Ephemeral: logs, incidents, release state, test output

Each class should define when revalidation is required.

### Moderate: Artifact Creation Rules Are Too Broad

The architecture says artifacts are created only when useful, but many artifact sections say "Required when..." in ways that could create too many documents.

Example:

* Research Brief required when selecting a technology, vendor, framework, standard, or architecture option.
* Options Matrix required when multiple viable options exist and tradeoffs matter.
* Decision Note required when a durable direction is chosen but PRD/ADR/RFC is too heavy.

For real work, these can overlap heavily.

Recommendation:

Define artifact minimization rules:

* one artifact may satisfy multiple roles if sections are explicit
* avoid creating both Research Brief and Options Matrix for lightweight research
* use Decision Note as the default durable artifact
* promote to ADR/RFC/PRD only when criteria are met

### Moderate: Review Lens Outputs Need Severity and Actionability Rules

The review lenses list outputs, but does not define how findings should be structured.

Recommendation:

For architecture and code reviews, require:

* severity
* finding
* rationale
* affected artifact or area
* recommendation
* whether action is required before proceeding

This prevents review artifacts from becoming unprioritized advice lists.

### Moderate: No Feedback Loop From Verification to Knowledge

Verify produces evidence, but the architecture does not say when evidence updates durable knowledge.

Examples:

* failed tests may invalidate an implementation plan
* manual QA may update acceptance criteria
* production verification may update release runbooks
* recurring failure may become a maintenance item

Recommendation:

Add a Knowledge Update Gate after Verify:

```text
Verify -> Knowledge Update -> Handoff
```

This does not need to be a full lifecycle stage. It can be a rule: any verification result that changes assumptions, contracts, runbooks, or known risks must update the relevant artifact.

### Moderate: No Explicit Concept of Source Authority in Research

Research can require current sources, but there is no hierarchy of source authority.

Recommendation:

Research overlay should prefer:

* primary official docs
* standards/specifications
* source repositories and changelogs
* vendor status pages for operational claims
* reputable independent analysis for tradeoffs

It should avoid relying on stale blog posts, unverified summaries, or unsupported claims for implementation decisions.

### Moderate: Incident Route Does Not Include Diagnose

Incident route:

```text
Intake -> Understand -> Challenge -> Plan -> Verify -> Handoff -> Maintain
```

Incident overlay includes timeline and remediation, but the route omits explicit diagnosis or containment.

Recommendation:

Incident should be modeled as an overlay with phases:

```text
Triage -> Contain -> Diagnose -> Remediate -> Verify -> Communicate -> Follow up
```

Mapped onto COS:

```text
Intake/Understand -> Plan -> Execute -> Verify -> Handoff -> Maintain
```

Challenge may be useful for remediation strategy, but should not delay containment during active incidents.

### Moderate: User Confirmation Rules Need Stronger Governance

Routing intrusiveness defines Silent, Lightweight, Confirming, and Mandatory. It does not define who can override Mandatory or what actions require explicit approval.

Recommendation:

Mandatory confirmation should apply to:

* irreversible actions
* production changes
* secret or credential handling
* destructive data changes
* public contract breaks
* policy decisions
* external cost-incurring operations
* actions outside sandbox or repository boundaries

The architecture should define whether confirmation can be waived globally or only per action.

## Overlaps

### Research Request vs Research Overlay

Research is now intentionally modeled as a specialized route implemented through the Research Overlay.

Remaining requirement:

* keep `Apply Research Overlay` visibly distinct from lifecycle stages
* keep the Research Overlay trigger scope explicit
* keep required research artifacts conditional and minimal
* avoid reintroducing `Research` as a core lifecycle stage

### Release vs Handoff vs Handoff Note vs Release Checklist

The combined stage previously caused artifact overlap. After the decision to split `Release` and `Handoff`, the remaining concern is ensuring the artifacts stay owned by the correct stage.

Recommended resolution:

* Release produces Release Checklist, rollback notes, post-release verification.
* Handoff produces Handoff Note.
* Handoff can summarize release state but should not own release readiness.

### Maintain Stage vs Maintenance Overlay

The overlay duplicates the stage.

Recommended resolution:

* Keep Maintain as the lifecycle stage.
* Replace Maintenance overlay with narrower overlays.

### Challenge Stage vs Challenge Lens

Challenge is both a lifecycle stage and a lens. This can be acceptable if the architecture defines the difference.

Recommended distinction:

* Challenge stage is mandatory in high-risk routes.
* Challenge lens is the reusable evaluation method used by that stage or by review requests.

### Verify Stage vs QA Lens

Verify is the lifecycle stage. QA is one verification method.

Recommended distinction:

* Verify decides whether sufficient evidence exists.
* QA tests user-visible behavior.

### Operations Lens vs Infrastructure/Kubernetes Overlay vs Release

These concepts overlap around deployment and runtime.

Recommended distinction:

* Infrastructure overlay governs platform/configuration changes.
* Operations lens evaluates runtime supportability.
* Release stage governs rollout and post-release verification.

## Unnecessary Complexity

### Too Many Concept Types Without a Strict Type System

The architecture has stages, routes, request types, intrusiveness levels, blast radius levels, lenses, overlays, artifacts, process levels, and matrices. These are individually useful, but the relationships are not strict enough.

Recommendation:

Add a short type system:

* Stage: a lifecycle transition with entry and exit criteria.
* Lens: an evaluation method applied inside a stage.
* Overlay: domain-specific requirements added to stages.
* Artifact: durable or ephemeral output.
* Route: ordered stage sequence plus lenses, overlays, and artifacts.
* Process level: minimum rigor derived from blast radius and uncertainty.

### Artifact Catalog Is Heavy for Early COS

The artifact list is comprehensive but may be too large for initial adoption.

Recommendation:

Define a minimum artifact set:

* Decision Note
* Implementation Plan
* Verification Note
* Handoff Note
* ADR
* Release Checklist
* Incident Report

Treat others as optional expansions.

### Stage Selection Matrix Mixes Stages and Non-Stages

The Default Stage Selection Matrix repeats the route syntax issue and risks becoming the canonical source of confusion.

Recommendation:

Replace it with:

* route stages
* lenses
* overlays
* required artifacts
* confirmation level

## Lifecycle Violations

### Research Must Not Reappear as a Core Stage

This has been resolved by the decision that Research is a specialized route implemented through the Research Overlay. Future architecture revisions should preserve that boundary.

### Diagnose Used as a Stage Without Stage Definition

This creates an undefined route node.

### Critique Used as a Stage Despite Lens Definition

This contradicts the review lens section.

### Release and Handoff Must Remain Separate

This has been resolved in principle by the lifecycle decision. Future revisions should keep Release responsible for rollout readiness and Handoff responsible for continuity.

### Maintain Used as Both Stage and Overlay

This creates circular architecture.

### Level 4 Flow Omits Action Stage

The Level 4 process cannot represent authorized execution clearly.

## Missing Concepts

### Knowledge Management

Needed concepts:

* source of truth
* artifact authority
* freshness
* indexing
* discovery
* retention
* archival
* invalidation
* synchronization
* conflict resolution
* update obligations

### Governance

Needed concepts:

* COS versioning
* artifact schema versioning
* repository override precedence
* deprecation policy
* artifact ownership
* approval authority
* release authority
* security exception process
* review cadence

### Execution Authority

Needed concepts:

* what an agent may execute autonomously
* what requires approval
* what is forbidden without explicit user action
* how approval is recorded
* how escalated operations are documented

### State Model

COS needs a state model for work and artifacts.

Suggested work states:

```text
Requested -> Understood -> Proposed -> Planned -> In Progress -> Verifying -> Ready for Handoff -> Released -> Closed
```

Suggested blocked state:

```text
Blocked: Needs user decision
Blocked: Needs external system
Blocked: Needs missing access
Blocked: Unsafe to proceed
```

### Artifact Conflict Resolution

COS needs rules for contradictions.

Examples:

* current user request conflicts with an old PRD
* ADR conflicts with current implementation
* handoff note conflicts with source code
* research brief conflicts with newer vendor documentation

Recommendation:

Define conflict handling:

* identify conflict
* prefer higher-authority source
* verify against code/runtime when possible
* ask user only when conflict changes policy or scope
* update or supersede stale artifact

### Knowledge Retrieval Rules

COS says to inspect docs and repository context, but not how much.

Recommendation:

Define retrieval tiers:

* Tier 1: repository instructions and task-specific files
* Tier 2: active architecture, ADRs, PRDs, interface contracts
* Tier 3: related implementation and tests
* Tier 4: historical handoffs, incident reports, maintenance reports
* Tier 5: external sources when facts are time-sensitive or not in repo

## Missing Governance

### Repository Override Governance

The architecture should define precedence and allowed overrides.

Minimum governance:

* local repository instructions can narrow COS behavior
* local instructions cannot remove safety gates for high-risk work unless explicitly allowed
* task-specific user instructions can select or skip workflows, except where safety policy requires confirmation
* project ADRs can define domain-specific routing defaults

### Artifact Governance

Each durable artifact needs:

* owner
* status
* scope
* authority level
* created date
* last reviewed date
* review cadence
* supersession links
* invalidation triggers

### Release Governance

Required:

* release owner
* approval requirements
* rollback owner
* release blockers
* post-release verification owner
* production incident escalation path

### Research Governance

Required:

* source authority hierarchy
* citation requirements when claims are external
* freshness classes
* revalidation triggers
* vendor/library/model version tracking

### Knowledge Governance

Required:

* authoritative artifact map
* stale artifact handling
* artifact retirement
* conflict resolution
* knowledge update gate after Verify, Release, Incident, and Maintain

## Recommended Revised Architecture

### Revised Core Lifecycle

Recommended lifecycle:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Notes:

* `Release` is optional and only appears when operational rollout is involved.
* `Handoff` is always available as a terminal or pause state.
* `Build` may need an operational execution substep when approved runtime action differs from implementation.
* `Research` is not a core lifecycle stage; it is applied through the Research Overlay.
* `Critique`, `Diagnosis`, `Security`, and `Architecture` should be lenses or overlays, not route nodes.

### Revised Route Shape

Instead of:

```text
Intake -> Understand -> [Research as a stage] -> Challenge -> Decide -> Handoff
```

Use:

```text
Stages: Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff
Overlay: Research
Lenses: Challenge
Artifacts: Research Brief; Options Matrix when multiple viable options exist; Recommendation Memo when a decision is expected; Source Notes when external sources are used
```

Instead of:

```text
Intake -> Understand -> Challenge -> Critique -> Handoff
```

Use:

```text
Stages: Intake -> Understand -> Handoff
Lenses: Challenge, Critique, Architecture
Artifacts: Architecture Review
```

Instead of:

```text
Intake -> Understand -> Diagnose -> Plan -> Build -> Verify -> Handoff
```

Use:

```text
Stages: Intake -> Understand -> Plan -> Build -> Verify -> Handoff
Overlay: Diagnosis
Rule: diagnosis must establish root cause before Build for unexplained failures.
Artifacts: Diagnosis Note, Verification Note
```

### Recommended Knowledge Management Layer

Add this layer:

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

### Recommended Artifact Authority Classes

```text
Policy: AGENTS, COS governance, security rules
Decision: ADR, decision note, RFC acceptance
Contract: API/interface contract, data schema, permission model
Product: PRD, acceptance criteria, workflow spec
Operational: runbook, release checklist, incident report
Continuity: handoff note, investigation note
Evidence: verification output, source notes, test results
```

### Recommended Governance Additions

Add sections for:

* COS versioning
* artifact schema versioning
* repository override precedence
* release approval
* security exception handling
* knowledge freshness and invalidation
* artifact ownership and review cadence
* conflict resolution

## Implementation Readiness Impact

`../specs/COS_ARCHITECTURE.md` is not yet ready to drive implementation.

It is ready for a revision pass.

Required before implementation:

* normalize route syntax
* preserve the decision that Research is an overlay-backed specialized route, not a core lifecycle stage
* define Diagnose or remove it from stage routes
* preserve the split between Release and Handoff
* add Knowledge Management layer
* add governance model
* define artifact authority and lifecycle
* define repository override precedence
* define versioning and deprecation rules

## Final Recommendation

Revise `../specs/COS_ARCHITECTURE.md` before creating any implementation artifacts.

The architecture should become stricter, not larger. The key change is to enforce a clean type system:

```text
Stages are the route.
Lenses evaluate.
Overlays add domain requirements.
Artifacts preserve knowledge.
Governance decides authority and freshness.
```

Once that separation is explicit, COS will be much easier to implement, teach, validate, and reuse across repositories.
