# COS Architecture Specification

## Purpose

The Codex Operating System (COS) is a reusable workflow architecture for agent-assisted engineering, architecture, infrastructure, AI projects, application development, UX design, repository maintenance, and technical decision making.

This document defines the architecture of COS. It does not define implementation files, scripts, wrappers, generated folders, or templates.

COS is intended to make agent behavior predictable across repositories by defining:

* lifecycle stages
* routing rules
* blast radius levels
* review lenses
* domain overlays
* expected artifacts
* entry criteria
* exit criteria

## Architectural Principles

### Lifecycle First

COS is organized around a core lifecycle rather than isolated skill lists. Skills are tools used inside lifecycle stages; they are not the architecture itself.

### Minimum Necessary Process

The routing model must choose the smallest workflow that can responsibly handle the request. COS should not force heavy process onto small, low-risk tasks.

### Challenge Before Critique

Viability must be questioned before quality is polished.

* Challenge asks whether the idea, plan, or decision should proceed.
* Critique improves an accepted idea, plan, decision, or artifact.

### Risk-Based Rigor

The required process increases with uncertainty, blast radius, security exposure, data impact, production impact, and public contract impact.

### Artifacts Over Ceremony

A stage is useful only if it produces clarity, a decision, evidence, or a reusable artifact. COS should avoid process steps that do not improve outcomes.

### Repository Awareness

In existing repositories, COS must inspect project instructions, existing documentation, code patterns, public contracts, and local conventions before recommending implementation work.

## Core Lifecycle

The COS lifecycle is:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Not every request uses every stage. Routing determines which stages are required, optional, or skipped.
`Release` is used only when deployment, rollout, rollback, migration, runtime monitoring, or production operation is involved.

## Lifecycle Stages

### 1. Intake

Purpose: classify the request and determine the minimum responsible workflow.

Primary questions:

* What is the user asking for?
* Is this a question, review, design task, implementation task, debugging task, maintenance task, or operational task?
* Is the request clear enough to proceed?
* What is the likely blast radius?
* Which overlays are required?
* Does the agent need user confirmation before proceeding?

Common inputs:

* user request
* repository instructions
* existing active plan, if any
* current repository state, if relevant

Expected outputs:

* request classification
* assumed goal
* selected lifecycle path
* selected overlays
* process level
* confirmation requirement, if any

Entry criteria:

* a user request exists

Exit criteria:

* request type is classified
* uncertainty level is estimated
* blast radius level is estimated
* next stage is selected
* required user questions are identified, if any

### 2. Understand

Purpose: clarify the problem, context, constraints, users, and success criteria before designing or implementing.

Primary questions:

* What problem is being solved?
* Who is affected?
* What does success look like?
* What constraints already exist?
* What documentation, code, or domain language governs the work?
* What assumptions remain unresolved?

Common inputs:

* user request
* existing documentation
* source code, if relevant
* previous decisions or ADRs
* domain glossary, if available

Expected outputs:

* problem brief
* clarified goal
* constraints
* success criteria
* open questions

Entry criteria:

* Intake selected a workflow requiring clarification or contextual understanding

Exit criteria:

* goal is clear enough to evaluate or act on
* relevant existing context has been inspected
* unresolved questions are either answered, explicitly deferred, or identified as blocking

### 3. Challenge

Purpose: test viability before further investment.

Primary questions:

* Should this be done?
* Is the problem real and specific enough?
* Are the assumptions defensible?
* What could make this fail?
* Is there a simpler or safer alternative?
* Is the proposed scope too broad?

Common inputs:

* problem brief
* research findings
* proposed decision
* proposed plan
* existing constraints

Expected outputs:

* viability assessment
* challenged assumptions
* failure modes
* scope concerns
* recommended proceed/change/stop decision

Entry criteria:

* a proposal, problem statement, plan, or decision candidate exists

Exit criteria:

* major assumptions have been surfaced
* proceed/change/stop recommendation is explicit
* blocking questions are identified, if any

### 4. Decide

Purpose: convert understanding and challenge results into an explicit direction.

Primary questions:

* What decision is being made?
* What alternatives were considered?
* Why is this option preferred?
* What consequences follow?
* What artifact should record the decision?

Common inputs:

* problem brief
* challenge findings
* research brief
* options analysis
* user preference or approval

Expected outputs:

* decision note, PRD, ADR, RFC, policy note, or runbook decision
* rationale
* rejected alternatives
* consequences
* owner or next responsible actor, if relevant

Entry criteria:

* a decision is needed before planning or implementation
* enough information exists to choose a direction

Exit criteria:

* selected direction is explicit
* rationale is captured
* consequences and tradeoffs are documented
* downstream planning path is clear

### 5. Plan

Purpose: convert a decision or request into sequenced work with clear acceptance criteria.

Primary questions:

* What work is required?
* What order should it happen in?
* What can be done independently?
* What is the testing strategy?
* What contracts, data, permissions, or workflows are affected?
* What must be verified before completion?

Common inputs:

* decision artifact
* clarified request
* repository context
* affected modules or workflows
* selected overlays

Expected outputs:

* implementation plan
* task breakdown
* acceptance criteria
* verification plan
* risk checklist
* required docs updates

Entry criteria:

* goal is clear enough to sequence work
* implementation or operational work is expected

Exit criteria:

* tasks are ordered
* acceptance criteria are testable
* impacted contracts and workflows are identified
* verification command or method is identified
* required overlays have contributed their checks

### 6. Build

Purpose: perform the planned implementation, remediation, or operational change.

Primary questions:

* What is the smallest correct change?
* What existing patterns should be followed?
* What behavior must be preserved?
* Which tests should be written or updated?
* Are there unexplained failures that require diagnosis first?

Common inputs:

* implementation plan
* acceptance criteria
* repository context
* test strategy
* overlay requirements

Expected outputs:

* changed code or configuration
* updated tests
* updated docs where required
* implementation notes

Entry criteria:

* a plan exists, unless the task is low-risk and directly actionable
* impacted area is known
* repository instructions have been read for existing codebases

Exit criteria:

* planned change is applied
* unrelated work is not mixed in
* behavior-preserving assumptions are respected
* failures encountered during build are either resolved or escalated to diagnosis

### 7. Verify

Purpose: produce fresh evidence that the work satisfies the goal.

Primary questions:

* What proves the work is correct?
* Which tests, builds, checks, screenshots, logs, or manual validations are required?
* Did verification run after the final change?
* What residual risk remains?

Common inputs:

* implemented change
* acceptance criteria
* verification plan
* repository test/build commands
* expected behavior

Expected outputs:

* verification evidence
* passing or failing command output summary
* manual validation evidence, if applicable
* residual risk statement

Entry criteria:

* work exists that could be claimed complete

Exit criteria:

* relevant verification has been run or a reason is documented for why it could not be run
* results are read and summarized accurately
* failures are handled or reported
* residual risk is explicit

### 8. Release

Purpose: prepare verified work for deployment, rollout, rollback, migration, runtime monitoring, or production operation.

Primary questions:

* Is deployment, rollout, migration, or production operation required?
* Who owns the release?
* What blocks release?
* What rollback path exists?
* What monitoring or post-release verification is required?
* What production risks remain?

Common inputs:

* verified work
* decision artifacts
* implementation notes
* release requirements
* rollback requirements
* operational constraints

Expected outputs:

* release notes, if relevant
* rollback notes, if relevant
* release checklist, if relevant
* post-release verification requirements

Entry criteria:

* verified work exists
* deployment, rollout, migration, runtime monitoring, or production operation is required

Exit criteria:

* release readiness is explicit
* rollout or deferral decision is captured
* rollback considerations are captured
* post-release verification requirements are clear

### 9. Handoff

Purpose: preserve context for a user, reviewer, future agent, or downstream process.

Primary questions:

* Who needs to act next?
* What changed?
* What was verified?
* What risks remain?
* What context must be preserved for another agent or human?

Common inputs:

* verified work
* release state, if relevant
* decision artifacts
* implementation notes
* unresolved questions

Expected outputs:

* handoff note
* PR summary, if relevant
* open questions
* recommended next steps

Entry criteria:

* work is complete, paused, blocked, released, or ready for external review

Exit criteria:

* next actor and next action are clear
* verification state is captured
* unresolved questions are explicit
* release state is summarized when relevant

### 10. Maintain

Purpose: reduce long-term repository degradation and keep COS outputs aligned with project reality.

Primary questions:

* What is drifting?
* What is obsolete, duplicated, flaky, or hard to maintain?
* Which docs no longer match behavior?
* Which dependencies, security patches, or operational checks need attention?
* Which maintenance work should be done now versus deferred?

Common inputs:

* repository state
* documentation
* test and CI health
* dependency state
* architecture review findings
* accumulated handoff notes or deferred risks

Expected outputs:

* maintenance report
* remediation plan
* deferred debt list
* documentation updates, if required
* architecture improvement recommendations

Entry criteria:

* maintenance, cleanup, dependency, documentation, or architecture health work is requested or detected

Exit criteria:

* degradation or drift is described
* proposed remediation is scoped
* immediate versus deferred work is separated
* risky changes are routed back through Plan, Build, and Verify

## Routing Model

The routing model decides which lifecycle stages, review lenses, overlays, and artifacts apply to a request.

### Routing Inputs

COS evaluates:

* user intent
* clarity of request
* uncertainty level
* blast radius
* affected domain
* repository state
* existing documentation
* public contract impact
* data or persistence impact
* security or privacy exposure
* infrastructure or deployment impact
* user workflow impact
* production impact
* need for durable artifact

### Request Types

#### Direct Answer

Examples:

* explain a concept
* summarize a file
* answer a narrow question

Default route:

```text
Intake -> Understand -> Handoff
```

Use Challenge, Plan, Build, and Verify only if the answer changes a design, decision, or implementation.

#### Review Request

Examples:

* review a spec
* critique a plan
* challenge an architecture
* inspect a PR or diff

Default route:

```text
Intake -> Understand -> Challenge -> Critique -> Handoff
```

Use code review, security review, or architecture review lenses as needed.

#### Research Request

Examples:

* compare technologies
* evaluate frameworks
* evaluate vendors
* evaluate AI models
* choose an architecture option
* evaluate external services, libraries, or standards

Default route:

```text
Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff
```

Research is not a core lifecycle stage. Research requests use the Research Overlay to gather evidence, compare options, and prepare a recommendation inside the lifecycle. Research may require current external sources when facts are time-sensitive.

Required artifacts:

* Research Brief
* Options Matrix when multiple viable options exist
* Recommendation Memo when a decision is expected
* Source Notes when external sources are used

#### Design Request

Examples:

* design UX
* design an API
* design a workflow
* design a system boundary

Default route:

```text
Intake -> Understand -> Challenge -> Decide -> Plan -> Handoff
```

Use overlays for UX, API/interface, security, data, AI, or infrastructure as needed.

#### Implementation Request

Examples:

* build a feature
* refactor code
* fix a bug
* update configuration

Default route:

```text
Intake -> Understand -> Plan -> Build -> Verify -> Handoff
```

Add Challenge before Plan when requirements, approach, or scope are uncertain.
Add Release before Handoff when deployment, rollout, migration, runtime monitoring, or production operation is involved.

#### Debugging Request

Examples:

* investigate a failing test
* trace an error
* explain unexpected behavior

Default route:

```text
Intake -> Understand -> Diagnose -> Plan -> Build -> Verify -> Handoff
```

Diagnosis must precede fixes for unexplained failures.

#### Maintenance Request

Examples:

* clean up repository structure
* reduce tech debt
* update docs
* improve architecture
* update dependencies

Default route:

```text
Intake -> Understand -> Maintain -> Plan -> Build -> Verify -> Handoff
```

Small documentation maintenance may skip Build and use Verify as a content checklist.

#### Operational Request

Examples:

* deployment planning
* incident response
* production debugging
* observability review
* rollback planning

Default route:

```text
Intake -> Understand -> Challenge -> Plan -> Verify -> Release -> Handoff
```

Use Incident, Release, Infrastructure, Security, and Observability overlays as needed.

### Routing Intrusiveness Levels

COS recommendations must not become intrusive.

#### Silent

Use when:

* task is low-risk
* route is obvious
* no durable decision is being made

Agent behavior:

* proceed without naming the pipeline

#### Lightweight

Use when:

* route is useful context
* task is moderate or multi-step
* user did not ask for a formal plan

Agent behavior:

* mention the assumed route in one concise sentence

#### Confirming

Use when:

* multiple viable routes exist
* user intent is ambiguous
* process cost is significant
* a durable decision or artifact will be created

Agent behavior:

* ask one focused question before proceeding

#### Mandatory

Use when:

* security, data integrity, production, irreversible, or public contract risk is high
* proceeding without confirmation would create policy or business semantics

Agent behavior:

* stop for the required decision

## Blast Radius Model

Blast radius describes how much damage an incorrect action could cause and how much verification rigor is required.

### Level 0: Informational

Definition:

* no file changes
* no operational action
* no durable decision unless explicitly requested

Examples:

* explain a file
* summarize a spec
* answer a question

Required process:

* Intake
* Understand as needed
* Handoff

Verification:

* source-based accuracy check

### Level 1: Local and Reversible

Definition:

* small change
* isolated file or local artifact
* easy to revert
* no public contract or data impact

Examples:

* edit a document
* small copy change
* local formatting fix

Required process:

* Intake
* Understand
* Build
* Verify
* Handoff

Verification:

* content review or targeted check

### Level 2: Module-Level

Definition:

* affects one module, feature, or workflow
* limited consumers
* behavior may change but is contained

Examples:

* add a focused feature
* fix a contained bug
* update a single component or service

Required process:

* Intake
* Understand
* Plan
* Build
* Verify
* Handoff

Verification:

* targeted tests plus relevant manual check

### Level 3: Cross-Module or Public Contract

Definition:

* affects multiple modules
* changes public interfaces
* changes API shape, persistence behavior, permissions, or user workflow

Examples:

* API contract change
* shared helper refactor
* database schema change
* authentication or authorization flow change

Required process:

* Intake
* Understand
* Challenge
* Decide
* Plan
* Build
* Verify
* Handoff
* Release when rollout is involved

Verification:

* broader test suite
* contract checks
* docs update
* migration or rollback review if relevant

### Level 4: Production, Security, Data, or Irreversible

Definition:

* could expose sensitive data
* could affect production availability
* could corrupt or delete data
* could create irreversible operational state
* could change security posture

Examples:

* production deploy
* destructive migration
* permissions redesign
* secret handling
* incident response
* infrastructure changes

Required process:

* Intake
* Understand
* Challenge
* Decide
* Plan
* Build
* Verify
* Release
* Handoff
* Maintain as follow-up

Verification:

* explicit approval where needed
* preflight checks
* rollback plan
* audit/security review
* post-action verification

## Review Lenses

Review lenses are reusable evaluation modes. They are not standalone lifecycle stages unless the user explicitly asks for that kind of review.

### Challenge Lens

Purpose:

* question viability
* test assumptions
* surface failure modes
* reduce scope when needed

Use when:

* idea is new or uncertain
* plan has broad impact
* irreversible decision is being considered
* requirements are weak

Outputs:

* challenged assumptions
* failure modes
* proceed/change/stop recommendation

### Critique Lens

Purpose:

* improve accepted artifacts
* strengthen clarity, structure, completeness, and usability

Use when:

* artifact is directionally accepted
* user asks for improvement
* quality matters more than viability

Outputs:

* quality findings
* improvement recommendations
* revised artifact suggestions, if requested

### Code Review Lens

Purpose:

* identify correctness, maintainability, performance, security, and test coverage issues in code

Use when:

* reviewing a diff, PR, implementation, or refactor

Outputs:

* findings ordered by severity
* file and line references where available
* open questions
* test gaps

### QA Lens

Purpose:

* verify user-visible behavior against acceptance criteria

Use when:

* workflow behavior changed
* UI changed
* a feature needs manual validation

Outputs:

* tested scenarios
* observed results
* pass/fail status
* residual risk

### Security Lens

Purpose:

* evaluate abuse cases, permissions, data exposure, secrets, trust boundaries, and unsafe inputs

Use when:

* auth, permissions, uploads, storage, external integrations, secrets, user input, or sensitive data are involved

Outputs:

* threat notes
* required safeguards
* residual risk
* approval requirement, if any

### Architecture Lens

Purpose:

* evaluate boundaries, coupling, ownership, extensibility, and long-term maintainability

Use when:

* changing module boundaries
* introducing abstractions
* modifying shared behavior
* reviewing system design

Outputs:

* boundary findings
* coupling risks
* recommended simplifications
* architectural decision needs

### Operations Lens

Purpose:

* evaluate deployment, rollback, observability, runtime failure modes, and supportability

Use when:

* production, infrastructure, CI/CD, monitoring, or incident workflows are involved

Outputs:

* rollout notes
* rollback notes
* observability requirements
* operational risks

## Overlays

Overlays add domain-specific checks and artifacts to the core lifecycle. They do not replace the lifecycle.

### UX/Application Overlay

Use when:

* designing user workflows
* changing UI
* changing interaction patterns
* defining product behavior

Additional checks:

* user goals
* states and transitions
* empty/loading/error states
* accessibility
* navigation
* responsive behavior
* content clarity

Additional artifacts:

* user workflow map
* UI state inventory
* prototype notes
* acceptance scenarios

### API/Interface Overlay

Use when:

* changing endpoints
* changing DTOs
* changing module interfaces
* changing frontend/backend contracts

Additional checks:

* request and response shape
* status codes
* error semantics
* compatibility
* versioning
* consumers

Additional artifacts:

* interface contract
* compatibility notes
* consumer impact list

### Security/Privacy Overlay

Use when:

* handling authentication
* handling authorization
* processing user input
* storing sensitive data
* handling uploads
* calling external services
* managing secrets

Additional checks:

* trust boundaries
* least privilege
* data exposure
* input validation
* auditability
* retention

Additional artifacts:

* security review
* privacy notes
* residual risk statement

### Data/Migration Overlay

Use when:

* changing schemas
* moving data
* deleting data
* changing retention
* changing persistence semantics

Additional checks:

* backwards compatibility
* migration order
* rollback feasibility
* data integrity
* audit requirements
* idempotency

Additional artifacts:

* migration plan
* rollback plan
* data integrity checklist

### Infrastructure/Kubernetes Overlay

Use when:

* changing infrastructure
* changing Kubernetes resources
* changing CI/CD
* changing network, compute, storage, or runtime configuration

Additional checks:

* rollout strategy
* blast radius
* resource limits
* secrets
* observability
* rollback

Additional artifacts:

* deployment plan
* operational risk notes
* rollback checklist

### AI Application Overlay

Use when:

* changing prompts
* changing model behavior
* changing tool use
* changing retrieval or memory
* changing agent workflows

Additional checks:

* evaluation criteria
* failure modes
* hallucination risk
* tool safety
* prompt injection
* data leakage
* model/version dependency

Additional artifacts:

* evaluation plan
* prompt or agent behavior spec
* safety notes

### Research Overlay

Use when:

* comparing technologies
* evaluating frameworks
* evaluating vendors
* evaluating AI models
* evaluating architectures
* evaluating external services
* evaluating libraries
* assessing standards

Additional checks:

* current source quality
* maturity
* maintenance status
* lock-in
* migration cost
* operational fit

Additional artifacts:

* Research Brief
* Options Matrix when multiple viable options exist
* Recommendation Memo when a decision is expected
* Source Notes when external sources are used

### Maintenance Overlay

Use when:

* reducing tech debt
* updating docs
* improving architecture
* updating dependencies
* cleaning repository structure

Additional checks:

* drift
* duplication
* stale docs
* flaky tests
* dependency risk
* hidden coupling

Additional artifacts:

* maintenance report
* remediation plan
* deferred debt list

### Incident Overlay

Use when:

* production behavior is degraded
* an outage or urgent operational failure exists
* data integrity or security may be compromised

Additional checks:

* severity
* user impact
* timeline
* containment
* rollback
* communication needs
* post-incident follow-up

Additional artifacts:

* incident notes
* timeline
* remediation checklist
* post-incident review

## Artifacts

Artifacts are durable outputs created only when useful. COS should avoid generating artifacts for small tasks that do not need them.

### Problem Brief

Purpose:

* capture the problem, user, context, constraints, and success criteria

Created by:

* Understand

Required when:

* requirements are unclear
* work is broad
* product or architecture direction is being set

### Challenge Review

Purpose:

* document viability questions, assumptions, failure modes, and proceed/change/stop recommendation

Created by:

* Challenge lens

Required when:

* blast radius is Level 3 or Level 4
* user asks for a challenge review
* major investment or durable decision is being considered

### Research Brief

Purpose:

* summarize relevant sources, options, tradeoffs, and evidence

Created by:

* Research Overlay

Required when:

* the Research Overlay is applied

### Options Matrix

Purpose:

* compare alternatives against explicit criteria

Created by:

* Research Overlay
* Decision stage

Required when:

* multiple viable options exist and tradeoffs matter

### Recommendation Memo

Purpose:

* state the recommended option, rationale, tradeoffs, and decision implications from research

Created by:

* Research Overlay
* Decision stage

Required when:

* a decision is expected from a research request

### Source Notes

Purpose:

* capture external sources used, source authority, retrieval date, and freshness concerns

Created by:

* Research Overlay

Required when:

* external sources are used

### Decision Note

Purpose:

* record a decision, rationale, alternatives, consequences, and owner

Created by:

* Decide

Required when:

* a durable direction is chosen but a PRD, ADR, or RFC would be too heavy

### PRD

Purpose:

* define product behavior, user value, scope, acceptance criteria, and non-goals

Created by:

* Decide
* UX/Application overlay

Required when:

* user-facing product behavior is being defined

### ADR

Purpose:

* record hard-to-reverse architecture or technical decisions

Created by:

* Decide
* Architecture lens

Required when:

* the decision is hard to reverse
* future readers would need rationale
* real alternatives were considered

### RFC

Purpose:

* propose a significant technical or organizational direction for review

Created by:

* Decide
* Research Overlay

Required when:

* broad stakeholder review is needed before commitment

### Implementation Plan

Purpose:

* sequence work, define ownership, identify impacted areas, and list verification requirements

Created by:

* Plan

Required when:

* blast radius is Level 2 or higher
* work is multi-step
* implementation risk is non-trivial

### Test Plan

Purpose:

* define automated and manual verification required for acceptance

Created by:

* Plan
* QA lens

Required when:

* behavior changes
* production, user workflow, or public contracts are affected

### Interface Contract

Purpose:

* define API, DTO, module, or frontend/backend contract shape

Created by:

* API/Interface overlay

Required when:

* request/response shape, status codes, event names, payloads, or module boundaries change

### Security Review

Purpose:

* record threats, trust boundaries, safeguards, and residual risk

Created by:

* Security lens
* Security/Privacy overlay

Required when:

* security or privacy exposure exists

### Migration Plan

Purpose:

* define data, schema, persistence, or rollout migration steps and rollback considerations

Created by:

* Data/Migration overlay

Required when:

* data or persistence semantics change

### Release Checklist

Purpose:

* define rollout, rollback, monitoring, and post-release verification

Created by:

* Release
* Operations lens

Required when:

* deployment or production operation is involved

### Handoff Note

Purpose:

* preserve context for user, reviewer, or another agent

Created by:

* Handoff

Required when:

* work is paused
* work is ready for review
* work has unresolved questions
* another actor must continue

Minimum fields:

* goal
* decisions
* changed or relevant files
* verification state
* risks
* unresolved questions
* next steps

### Maintenance Report

Purpose:

* describe repository drift, degradation, deferred debt, and remediation options

Created by:

* Maintain
* Maintenance overlay

Required when:

* maintenance or repository health work is requested

### Incident Report

Purpose:

* capture impact, timeline, actions, root cause, remediation, and follow-up

Created by:

* Incident overlay

Required when:

* production or operational incident handling occurs

## Entry Criteria Summary

### Intake

* user request exists

### Understand

* request requires context, clarification, or repository awareness

### Challenge

* proposal, plan, decision, or high-risk action exists

### Decide

* a direction must be chosen before planning or implementation

### Plan

* work is multi-step, risky, ambiguous, or implementation-oriented

### Build

* a plan exists, or the task is low-risk and directly actionable

### Verify

* a result exists that may be claimed as complete

### Release

* verified work requires deployment, rollout, migration, runtime monitoring, or production operation

### Handoff

* work is complete, paused, blocked, released, or ready for external review/action

### Maintain

* repository health, drift, dependency, documentation, or architecture degradation is in scope

## Exit Criteria Summary

### Intake

* route selected
* process level selected
* required overlays identified
* confirmation need determined

### Understand

* goal, context, constraints, and success criteria are clear enough for the selected route

### Challenge

* major assumptions, failure modes, and proceed/change/stop recommendation are explicit

### Decide

* decision and rationale are recorded in the appropriate artifact

### Plan

* tasks, acceptance criteria, impacted areas, and verification plan are clear

### Build

* intended change is applied without unrelated scope

### Verify

* fresh verification evidence is captured or inability to verify is explicitly reported

### Release

* release readiness, rollout or deferral decision, rollback considerations, and post-release verification requirements are clear

### Handoff

* next actor, next action, verification state, risks, and open questions are clear

### Maintain

* drift or degradation is documented, and remediation is completed, planned, or deferred

## Default Stage Selection Matrix

| Request type | Default route | Common overlays |
| --- | --- | --- |
| Direct answer | Intake -> Understand -> Handoff | None |
| Spec review | Intake -> Understand -> Challenge -> Critique -> Handoff | Architecture, Research |
| Product design | Intake -> Understand -> Challenge -> Decide -> Plan -> Handoff | UX/Application, Research |
| API design | Intake -> Understand -> Challenge -> Decide -> Plan -> Handoff | API/Interface, Security |
| Implementation | Intake -> Understand -> Plan -> Build -> Verify -> Handoff | API, Security, Data, UX as needed |
| Bug fix | Intake -> Understand -> Diagnose -> Plan -> Build -> Verify -> Handoff | Security, Data, Operations as needed |
| Maintenance | Intake -> Understand -> Maintain -> Plan -> Build -> Verify -> Handoff | Maintenance, Architecture |
| Research | Intake -> Understand -> Apply Research Overlay -> Challenge -> Decide -> Handoff | Research |
| Incident | Intake -> Understand -> Challenge -> Plan -> Verify -> Handoff -> Maintain | Incident, Operations, Security |
| Release | Intake -> Understand -> Plan -> Verify -> Release -> Handoff | Operations, Security, Data |

## Process Level Matrix

| Level | Name | Confirmation | Minimum stages | Typical artifacts |
| --- | --- | --- | --- | --- |
| 0 | Informational | Usually no | Intake, Understand, Handoff | None or short summary |
| 1 | Local reversible | Usually no | Intake, Understand, Build, Verify, Handoff | Edited artifact or verification note |
| 2 | Module-level | Sometimes | Intake, Understand, Plan, Build, Verify, Handoff | Implementation plan, test plan |
| 3 | Cross-module/public contract | Usually yes | Intake, Understand, Challenge, Decide, Plan, Build, Verify, Handoff; add Release when rollout is involved | ADR, interface contract, migration/test plan |
| 4 | Production/security/data-critical | Yes | Intake, Understand, Challenge, Decide, Plan, Build, Verify, Release, Handoff, Maintain | Security review, migration plan, release checklist, incident report |

## Non-Implementation Boundary

This architecture specification does not create or require:

* wrapper scripts
* generated folders
* executable pipeline runners
* template files
* examples
* repository bootstrap logic

Those may be designed later after the architecture is validated.

## Architecture Readiness Gate

COS should move from architecture to implementation only when these questions can be answered without improvisation:

* Which route applies to a given request?
* Which lifecycle stages are mandatory, optional, or skipped?
* What blast radius level applies?
* Which review lenses apply?
* Which overlays apply?
* When does the Research Overlay apply instead of a Research lifecycle stage?
* Which artifacts are required?
* Which research artifacts are required for the selected research route?
* What are the entry and exit criteria?
* When must the agent ask the user before continuing?
* What fresh verification evidence is required before completion claims?
* How do repository-specific instructions override COS defaults?
