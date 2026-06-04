# COS Design Review

## Executive Summary

The proposed Codex Operating System (COS) is a useful starting point for a reusable agent workflow framework. Its strongest idea is the explicit separation between problem understanding, research, decisions, implementation, application design, maintenance, and review. The dual review model of Challenge first and Critique second is also directionally strong because it prevents polishing weak ideas before their viability has been tested.

The current design is not yet implementation-ready. It is mostly a list of skills grouped into broad pipelines, but it does not yet define enough operating semantics for repeatable behavior across repositories. The framework needs clearer lifecycle stages, sharper skill responsibilities, entry and exit criteria, artifact ownership, routing rules, and blast-radius controls.

The biggest design issue is that COS currently optimizes for thoughtful conversations, but not yet for reliable engineering operations. It under-specifies triage, planning, verification, release readiness, security, migrations, incident response, dependency management, and documentation governance. These omissions matter because a reusable operating system must handle routine, risky, and production-facing work without relying on ad hoc judgment every time.

Recommended direction:

* Keep the pipeline concept, but revise it into a smaller lifecycle architecture.
* Keep Challenge and Critique, but define them as reusable review lenses rather than full pipelines.
* Add Intake, Planning, Verification, Release, Security, Migration, and Incident workflows.
* Add a routing model based on request type, uncertainty, risk, and blast radius.
* Delay implementation until the framework defines artifacts, trigger rules, success criteria, and minimum viable skill contracts.

## Critique Findings

### 1. The Pipeline Model Is Useful but Too Skill-List Driven

The current pipelines are defined primarily as ordered lists of skills. That is not enough to produce predictable behavior.

Each pipeline should define:

* when it should be used
* when it should not be used
* required inputs
* expected outputs
* mandatory artifacts
* optional artifacts
* exit criteria
* escalation points
* fast-path rules for small tasks

Without these details, two agents could follow the same pipeline names and produce very different outcomes.

Recommendation: modify each pipeline from a skill bundle into an operating procedure.

### 2. Discovery and Research Overlap

Discovery and Research both use `grill-with-docs`, `zoom-out`, and `challenge`. Their distinction is conceptually valid, but the current spec does not make the boundary operational.

Suggested distinction:

* Discovery asks: "What problem are we solving, for whom, and why?"
* Research asks: "Which known alternatives, technologies, or approaches could solve it?"

Discovery should usually produce a problem brief. Research should produce an options analysis.

Recommendation: keep both, but define separate outputs and entry criteria.

### 3. Decision Pipeline Is Misnamed or Underpowered

The Decision pipeline currently includes `to-prd`, `challenge`, `critique`, and `handoff`. That suggests decisions become product requirements, but many decisions are architectural, operational, security-related, infrastructure-related, or process-related.

The framework needs a broader decision artifact model:

* PRD for product behavior
* ADR for architecture and technical decisions
* RFC for broader proposals
* runbook decision for operations
* policy note for workflow or governance choices

Recommendation: modify Decision so it can emit PRD, ADR, RFC, or policy artifacts depending on context.

### 4. Implementation Pipeline Starts Too Late and Ends Too Early

Implementation begins with `to-issues`, then `tdd`, `diagnose`, `review`, and `handoff`. This skips several essential engineering steps:

* understanding current code and constraints
* assessing impact and blast radius
* designing interfaces
* planning tests
* validating security and data implications
* verifying completion
* updating docs
* preparing release or deployment notes

Recommendation: split implementation into Planning, Build, Verification, and Handoff/Release stages.

### 5. Application Design Is Too Broad

Application Design currently includes almost every major skill: discovery, PRD, prototype, challenge, critique, issues, TDD, QA, and review. This makes it more like a super-pipeline than a focused workflow.

Application design should be responsible for:

* user workflows
* information architecture
* interaction design
* UI states
* accessibility expectations
* data and action surfaces
* prototype validation

It should not directly own engineering implementation, issue generation, TDD, QA, or code review. Those should be downstream workflows.

Recommendation: modify Application Design into a design pipeline that hands off to Planning or Implementation.

### 6. Maintenance Is Underdefined

Maintenance is described as preventing repository degradation, using `improve-codebase-architecture`, `docs-sync`, `diagnose`, and `handoff`. This is a good direction, but incomplete.

Maintenance should cover:

* dependency upgrades
* deprecation removal
* architecture drift
* documentation drift
* flaky tests
* tech debt triage
* security patching
* CI health
* observability gaps
* dead code and unused assets

Recommendation: keep Maintenance, but divide it into scheduled maintenance, opportunistic cleanup, dependency/security maintenance, and architecture improvement.

### 7. Review Pipeline Duplicates the Dual Review Model

The Review pipeline includes `critique`, `challenge`, and `handoff`, while the Dual Review Model says Challenge should come before Critique. This creates an ordering inconsistency.

Recommendation: either change Review to `challenge -> critique -> handoff`, or remove Review as a pipeline and treat Challenge/Critique as review lenses that can be applied to any artifact.

### 8. Handoff Is Overused

`handoff` appears in Research, Decision, Implementation, Maintenance, and Review. That may be correct, but the spec does not define what handoff means.

Handoff could mean:

* handing work from one agent to another
* summarizing state for the user
* preparing an issue for later work
* preparing a PR description
* documenting open questions
* creating implementation instructions

Recommendation: define handoff as an artifact type with required fields: context, decisions, files, risks, verification state, next steps, and unresolved questions.

### 9. QA and Review Need Clear Boundaries

`qa` and `review` are both included in Application Design. `review` is also part of Implementation. Their responsibilities are unclear.

Suggested split:

* `qa`: verifies user-visible behavior against acceptance criteria.
* `review`: evaluates code, architecture, maintainability, security, and test coverage.
* `critique`: improves non-code artifacts or accepted designs.
* `challenge`: tests whether the idea, plan, or decision should proceed.

Recommendation: clarify skill boundaries before implementation.

### 10. Docs-Sync Is Too Reactive

`docs-sync` suggests documentation is updated after changes. COS needs a stronger documentation governance model.

The framework should define:

* which artifacts are authoritative
* when documentation must be updated
* when an ADR is required
* how generated docs differ from human-maintained docs
* how pipeline outputs map to docs
* how stale docs are detected

Recommendation: replace or extend `docs-sync` with `update-docs` and `docs-governance`.

## Challenge Findings

### 1. Is COS a Workflow Framework, a Skill Pack, or a Runtime?

The spec says COS is a reusable operating system, but the deliverables suggest a `.codex` folder with instructions, pipelines, templates, examples, and scripts. These are different product shapes.

Possible interpretations:

* A documentation framework for agents
* A reusable skill library
* A repository bootstrap kit
* A command-line workflow runner
* A governance model for human/agent collaboration

The current design mixes all five. That increases complexity before the core operating model has been proven.

Challenge: define the smallest viable identity of COS before implementation.

Recommendation: start with COS as a workflow and artifact specification. Add scripts only after the workflow proves useful manually.

### 2. Proactive Pipeline Recommendation Can Become Annoying or Wrong

The spec says COS should proactively suggest pipelines but not become intrusive. That is an important but unresolved tension.

Risks:

* agents may over-prescribe process for small tasks
* recommendations may interrupt user flow
* users may need to fight the framework
* vague trigger rules may cause inconsistent behavior

Challenge: can the system recommend pipelines without becoming a process tax?

Recommendation: introduce routing levels:

* Silent: proceed without mentioning a pipeline.
* Lightweight: mention the assumed pipeline in one sentence.
* Confirming: ask before using a heavy pipeline.
* Mandatory: require explicit handling for high-risk work.

### 3. Too Many Skills May Make the System Hard to Learn

The core skill list already has 15 items. Additional necessary skills could push the framework past 25. That may be too much for users and agents to reason about.

Challenge: can COS expose a small mental model while still supporting deep workflows?

Recommendation: group skills under fewer lifecycle phases and treat specialized skills as conditional overlays.

### 4. Application Design May Become a Catch-All

Application Design includes discovery, PRD, prototyping, review, QA, issue generation, and TDD. This makes it attractive as a default for many tasks, which could weaken the rest of the architecture.

Challenge: if one pipeline includes nearly everything, why should the others exist?

Recommendation: narrow Application Design to user experience and product interface design, then hand off to Planning and Implementation.

### 5. The Framework Could Encourage Ceremony Over Outcomes

The proposal is process-rich. That is valuable for complex work, but risky for small requests.

Examples where full pipeline usage would be excessive:

* typo fixes
* small copy changes
* single test updates
* one-line config changes
* quick command output requests

Challenge: COS must distinguish between high-rigor and fast-path work.

Recommendation: add a blast-radius model with low, medium, and high process requirements.

### 6. The Current Spec Does Not Prove Reusability

The objective is reuse across many repository types, including web apps, Kubernetes systems, APIs, AI applications, and data platforms. The current pipelines are generic enough to apply broadly, but not specific enough to handle domain-specific needs.

Challenge: can one workflow model fit all target project types without becoming vague?

Recommendation: define a core lifecycle plus domain overlays:

* Web/App overlay
* Backend/API overlay
* Infrastructure/Kubernetes overlay
* Data overlay
* AI application overlay
* Repository maintenance overlay

### 7. Wrapper Scripts May Be Premature

The deliverables include wrapper scripts and a `bin/` directory. The spec has not yet defined stable pipeline semantics, artifact schemas, or routing rules.

Challenge: scripts may encode immature assumptions and become expensive to change.

Recommendation: postpone wrapper scripts until the manual workflow has been validated in real projects.

## Duplicated Concepts

### Challenge, Critique, Review, and QA

These are related but not interchangeable. The spec currently risks using them as generic review words.

Recommended distinction:

* Challenge: viability, assumptions, demand, risk, and whether to proceed.
* Critique: quality improvement of an accepted artifact.
* Review: code/design/architecture correctness and maintainability assessment.
* QA: behavior verification against user workflows and acceptance criteria.

### Grill-Me and Grill-With-Docs

Both are interrogation/discovery tools. Their difference should be context source:

* `grill-me`: user-supplied context is primary.
* `grill-with-docs`: existing repository/domain documentation is primary.

### Diagnose, QA, and TDD

These may overlap during bug work.

Recommended distinction:

* `diagnose`: root-cause investigation.
* `tdd`: define failing behavior before changing code.
* `qa`: verify final behavior after implementation.

### To-PRD and Decision

Not every decision should become a PRD. The Decision pipeline should route to multiple artifact types.

### Docs-Sync and Handoff

Both may summarize current state. Docs-sync should update durable documentation. Handoff should prepare continuation context.

## Missing Pieces

### Missing Workflows

* Intake and triage
* Planning and task breakdown
* Security and privacy review
* API/interface design
* Data migration planning
* Release readiness
* Deployment and rollback planning
* Incident response
* Observability review
* Dependency upgrade workflow
* Test strategy workflow
* Documentation governance
* Codebase onboarding/exploration
* User acceptance validation
* Post-implementation retrospective

### Missing Skills

Recommended additions:

* `triage`
* `planning-and-task-breakdown`
* `api-and-interface-design`
* `security-and-hardening`
* `migration-planning`
* `release-readiness`
* `incident-response`
* `observability-review`
* `dependency-upgrade`
* `test-strategy`
* `verification-before-completion`
* `update-docs`
* `receiving-code-review`
* `requesting-code-review`
* `implementation-readiness-review`

### Missing Artifacts

COS should define artifact templates before scripts:

* Problem brief
* Research brief
* Options matrix
* PRD
* ADR
* RFC
* Implementation plan
* Test plan
* Migration plan
* Security review
* Release checklist
* Incident report
* Handoff note
* Maintenance report
* Design critique
* Challenge review

### Missing Routing Inputs

Pipeline recommendation should consider:

* user intent
* uncertainty level
* risk level
* blast radius
* affected domain
* whether code already exists
* whether public contracts change
* whether data or security is involved
* whether deployment is required
* whether documentation exists

### Missing Exit Criteria

Every pipeline should define what "done" means. Examples:

* Discovery is done when the problem, user, constraints, and success criteria are clear.
* Research is done when alternatives, tradeoffs, and recommendation are documented.
* Decision is done when a decision, rationale, consequences, and owner are recorded.
* Implementation is done when code, tests, verification, docs, and handoff are complete.
* Maintenance is done when drift or degradation is measured and remediated or explicitly deferred.

## Risks

### Operational Risks

* Agents may apply excessive process to small tasks.
* Agents may skip important checks because trigger rules are vague.
* Different repositories may customize COS incompatibly.
* Scripts may become brittle if pipeline semantics change.
* Handoff artifacts may become noisy unless tightly structured.

### Product Risks

* Users may perceive COS as friction rather than leverage.
* The Italian guide may become stale if authored before the framework stabilizes.
* Too many skills may make the system feel harder to use than plain Codex instructions.
* Proactive recommendations may feel intrusive unless carefully scoped.

### Engineering Risks

* Missing security, migration, and release workflows could lead to unsafe implementation habits.
* Lack of artifact schemas could produce inconsistent outputs.
* Lack of versioning could make it hard to upgrade COS across repositories.
* Lack of testing strategy for the framework itself could make wrapper behavior unreliable.

### Governance Risks

* No owner is defined for decisions, docs, templates, scripts, or skill versions.
* No compatibility model exists for project-specific overrides.
* No deprecation policy exists for renamed or removed skills.
* No standard exists for when local project instructions override COS defaults.

## Simplification Opportunities

### 1. Collapse Pipelines Into a Core Lifecycle

Instead of many parallel top-level pipelines, define one core lifecycle:

```text
Intake -> Understand -> Decide -> Plan -> Build -> Verify -> Release/Handoff -> Maintain
```

Specialized workflows can attach to lifecycle stages as overlays.

### 2. Treat Challenge and Critique as Lenses

Challenge and Critique do not need to be standalone pipelines. They are review modes that can apply to a problem, plan, PRD, ADR, prototype, code change, or release.

### 3. Split Skills Into Core and Conditional Skills

Core skills should be few:

* triage
* grill/discovery
* challenge
* critique
* plan
* implement/test
* verify
* handoff/docs

Conditional skills can be invoked by risk or domain:

* security
* migration
* release
* observability
* API design
* prototype
* architecture improvement

### 4. Delay Scripts

Start with markdown specifications and templates. Add scripts only after several real workflows show stable repetition.

### 5. Define Process Levels

Use process levels instead of requiring full pipelines for every task:

* Level 0: direct answer or command
* Level 1: small local change
* Level 2: normal implementation
* Level 3: broad or risky change
* Level 4: production/security/data-critical work

## Recommended Revised Architecture

### Core Architecture

```text
COS
├── Operating Principles
├── Routing Model
├── Core Lifecycle
├── Review Lenses
├── Domain Overlays
├── Artifact Templates
├── Skill Contracts
└── Repository Integration Guide
```

### Routing Model

COS should first classify the request:

* Request type: question, review, bug, feature, refactor, research, design, infra, docs, maintenance.
* Context state: greenfield, existing codebase, production system, uncertain domain, documented domain.
* Risk: low, medium, high, critical.
* Blast radius: local, module, cross-module, public contract, persistence, infrastructure, user workflow.
* Required overlays: security, migration, API, UX, release, incident, data, AI.

The router then chooses a lifecycle path and optional overlays.

### Core Lifecycle

#### 1. Intake

Purpose: classify the request and decide the minimum necessary process.

Outputs:

* request type
* assumed goal
* risk level
* recommended workflow
* whether user confirmation is needed

#### 2. Understand

Purpose: clarify problem, context, constraints, users, and success criteria.

Uses:

* `grill-me`
* `grill-with-docs`
* `zoom-out`

Outputs:

* problem brief
* known constraints
* open questions

#### 3. Challenge

Purpose: test viability before investing further.

Uses:

* `challenge`

Outputs:

* invalid assumptions
* failure modes
* reasons not to proceed
* minimum evidence required

#### 4. Decide

Purpose: record the chosen direction.

Uses:

* `to-prd`
* ADR/RFC generation skill if added
* `critique`

Outputs:

* PRD, ADR, RFC, or decision note
* rationale
* consequences

#### 5. Plan

Purpose: convert decisions into sequenced work.

Uses:

* `to-issues`
* planning/task breakdown skill
* test strategy skill

Outputs:

* implementation plan
* issues/tasks
* acceptance criteria
* test plan
* risk checklist

#### 6. Build

Purpose: implement the planned change.

Uses:

* `tdd`
* `diagnose` when failures are unexplained
* domain overlays as needed

Outputs:

* code changes
* tests
* docs updates where required

#### 7. Verify

Purpose: prove the work satisfies the goal.

Uses:

* `qa`
* `review`
* `verification-before-completion`

Outputs:

* test results
* manual verification evidence
* review findings
* residual risks

#### 8. Release or Handoff

Purpose: prepare the work for deployment, continuation, or human review.

Uses:

* `handoff`
* release readiness skill
* docs update skill

Outputs:

* release notes
* rollback notes
* PR summary
* handoff note
* open questions

#### 9. Maintain

Purpose: reduce long-term degradation.

Uses:

* `improve-codebase-architecture`
* `docs-sync` or `update-docs`
* dependency/security skills

Outputs:

* maintenance report
* remediation plan
* deferred debt list

### Review Lenses

Review lenses should be reusable across lifecycle stages:

* Challenge: should this proceed?
* Critique: how can this artifact be improved?
* Code review: is this implementation correct and maintainable?
* QA: does this behavior satisfy the user workflow?
* Security review: can this be abused?
* Operations review: can this be deployed, observed, and rolled back?

### Domain Overlays

COS should support domain-specific overlays instead of one giant pipeline for every context.

Recommended overlays:

* Web application / Next.js
* Backend API
* Infrastructure / Kubernetes
* Data platform
* AI-enabled application
* Internal tools
* Proof of concept
* Repository maintenance

Each overlay should define additional checks, artifacts, and common failure modes.

### Revised Pipeline Set

Recommended top-level workflows:

* Intake/Triage
* Discovery
* Research
* Decision
* Planning
* Implementation
* Verification
* Release/Handoff
* Maintenance
* Incident Response

Recommended cross-cutting review modes:

* Challenge
* Critique
* Security Review
* QA Review
* Code Review
* Architecture Review

## Component Recommendations

### Core Skills

* `grill-me`: keep, but define as user-context discovery.
* `grill-with-docs`: keep, but define as documented-domain discovery.
* `challenge`: keep, but make it a reusable viability lens.
* `critique`: keep, but make it a reusable quality-improvement lens.
* `to-prd`: modify, because not every decision produces a PRD.
* `to-issues`: keep, but move into Planning.
* `tdd`: keep, but define when it is mandatory versus optional.
* `diagnose`: modify, limiting it to root-cause investigation.
* `review`: modify, defining whether it means code review, artifact review, or general review.
* `qa`: keep, but define as behavior verification.
* `prototype`: keep, but place under Application Design or Research.
* `zoom-out`: keep, but define expected output.
* `handoff`: keep, but define a strict artifact schema.
* `improve-codebase-architecture`: keep, under Maintenance and Architecture Review.
* `docs-sync`: modify or rename to `update-docs` plus documentation governance.

### Proposed Pipelines

* Discovery: keep and clarify.
* Research: keep and clarify.
* Decision: modify to support ADR/RFC/PRD/policy outputs.
* Implementation: modify into Plan/Build/Verify/Release stages.
* Application Design: modify into a domain overlay or focused design workflow.
* Maintenance: keep, but expand into maintenance categories.
* Review: remove as a standalone pipeline or redefine as an artifact review workflow.

### Planned Deliverables

* `.codex/AGENTS.md`: keep, but only after core semantics are stable.
* `PIPELINES.md`: keep, should be the primary human-readable operating model.
* `pipelines/`: keep later, after pipeline contracts are defined.
* `templates/`: keep, should likely come before scripts.
* `examples/`: keep, important for adoption.
* `bin/`: defer until workflows stabilize.
* wrapper scripts: defer.
* Italian user guide: keep, but write after architecture stabilizes to avoid translation drift.

## Implementation Readiness Assessment

Current readiness: not ready for implementation.

The design is ready for another specification pass, not for file/folder/script generation.

### Ready

* Overall goal is clear.
* Initial skill inventory exists.
* Initial pipeline categories exist.
* Challenge/Critique distinction is valuable.
* Target repository types are identified.
* Planned deliverable shape is directionally reasonable.

### Not Ready

* Pipeline entry and exit criteria are missing.
* Skill contracts are missing.
* Artifact schemas are missing.
* Routing rules are underdefined.
* Intrusiveness controls are unresolved.
* Security, release, migration, and incident workflows are absent.
* Implementation deliverables are premature.
* No compatibility or versioning model exists.
* No test or validation strategy exists for COS itself.

### Minimum Work Before Implementation

Before creating `.codex/`, scripts, templates, or examples, define:

* COS identity: workflow spec, skill pack, bootstrap kit, runtime, or a staged combination.
* Core lifecycle and pipeline contracts.
* Skill responsibility matrix.
* Artifact model and templates.
* Pipeline router rules.
* Process levels based on risk and blast radius.
* Required overlays for security, API, migration, release, and incident work.
* Repository override and versioning policy.
* Validation plan using at least three representative project scenarios.

### Suggested Readiness Gate

COS should be considered implementation-ready only when the following can be answered without improvisation:

* Given a user request, which pipeline runs and why?
* What is the minimum acceptable output of that pipeline?
* Which skills are mandatory, optional, or forbidden in that context?
* What artifact is produced?
* What counts as done?
* When must the agent ask the user before proceeding?
* When can the agent proceed autonomously?
* How does COS adapt to a small task versus a high-risk production change?
* How does a repository override COS defaults?
* How are COS updates versioned and migrated across repositories?

## Final Recommendation

Do not implement the current design yet.

Revise the framework into a lifecycle-first operating model with review lenses and domain overlays. Keep the best parts of the current proposal: reusable skills, proactive pipeline suggestions, Challenge before Critique, and repository-level deliverables. Remove or postpone premature implementation mechanisms, especially wrapper scripts, until the manual workflow has been validated.

The next useful artifact is not code. It is a revised `COS_ARCHITECTURE.md` or updated spec that defines lifecycle stages, routing rules, skill contracts, and artifact schemas.
