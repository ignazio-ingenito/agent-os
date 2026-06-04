# COS Unresolved Architectural Decisions

## Purpose

This document identifies unresolved architectural decisions in the current COS design.

Source documents:

* `../specs/COS_ARCHITECTURE.md`
* `../specs/COS_GOVERNANCE_SPEC.md`
* `../specs/COS_IMPLEMENTATION_ARCHITECTURE.md`

This document does not implement COS and does not modify the source specifications.

## Decision Status Key

| Status | Meaning |
| --- | --- |
| Open | decision has not been accepted |
| Recommended | this document recommends an option |
| Requires ADR | decision should become an ADR once accepted |
| Requires Spec Update | accepted decision should update one or more COS specs |

## Summary

The current COS design is coherent enough to continue, but several architectural decisions remain open before implementation should begin.

Highest-priority unresolved decisions:

* how to model `Diagnose`
* whether to keep or replace `Maintenance Overlay`
* where Knowledge Management stops and implementation begins
* what adoption level should be the first implementation target
* how repository bootstrap should happen without prematurely introducing wrappers, scripts, or templates

## Decision 1: How Should `Diagnose` Be Modeled?

Status: Recommended, Requires ADR, Requires Spec Update

### Issue

`../specs/COS_ARCHITECTURE.md` uses `Diagnose` in the debugging route:

```text
Intake -> Understand -> Diagnose -> Plan -> Build -> Verify -> Handoff
```

But `Diagnose` is not defined as a lifecycle stage, review lens, overlay, or artifact source. This violates the lifecycle model because route strings otherwise use lifecycle stages or explicit overlay application.

The architecture already decided that Research is not a core lifecycle stage and is instead applied through the Research Overlay. `Diagnose` needs the same kind of explicit treatment.

### Options

#### Option A: Make Diagnose a Core Lifecycle Stage

Route:

```text
Intake -> Understand -> Diagnose -> Challenge -> Decide -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Pros:

* makes debugging highly visible
* gives root-cause work first-class entry and exit criteria
* useful for complex production and reliability work

Cons:

* bloats the core lifecycle
* most non-debugging work does not need it
* weakens the lifecycle's general-purpose shape
* invites other specialized activities to become stages

#### Option B: Make Diagnose a Review Lens

Use:

```text
Stages: Intake -> Understand -> Plan -> Build -> Verify -> Handoff
Lens: Diagnosis
```

Pros:

* keeps lifecycle small
* makes diagnosis a method of evaluation
* works for code, operations, tests, and incidents

Cons:

* diagnosis usually produces findings and evidence, not just evaluation
* may understate the need to stop before fixing unexplained failures
* less clear where diagnosis artifacts live

#### Option C: Make Diagnose a Specialized Overlay

Use:

```text
Stages: Intake -> Understand -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Handoff
Overlay: Diagnosis
Rule: root cause must be established before Build for unexplained failures.
```

Pros:

* matches the Research Overlay precedent
* keeps core lifecycle small
* gives debugging explicit trigger rules and artifacts
* works for bug fixes, failing tests, incidents, and operational failures
* allows diagnosis-specific artifacts without turning diagnosis into a universal stage

Cons:

* introduces another specialized route operation
* requires route syntax rules for applying overlays
* still needs careful boundary with Incident and Operations overlays

### Recommendation

Choose Option C: make `Diagnose` a specialized overlay.

Recommended route:

```text
Intake -> Understand -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Handoff
```

For incidents:

```text
Intake -> Understand -> Apply Incident Overlay -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Recommended required artifacts:

* Diagnosis Note when an unexplained failure is investigated
* Reproduction Notes when behavior can be reproduced
* Hypothesis Log for complex investigations
* Root Cause Summary before Build for non-trivial fixes

### Trade-Offs

This keeps the core lifecycle stable while making root-cause investigation explicit. The cost is that COS must support overlay application in routes beyond Research. That is acceptable if the architecture clearly distinguishes lifecycle stages from overlay operations.

## Decision 2: Should `Maintenance Overlay` Remain?

Status: Recommended, Requires ADR, Requires Spec Update

### Issue

COS currently has both:

* `Maintain` as a lifecycle stage
* `Maintenance Overlay` as an overlay

The overlay duplicates the stage. It lists checks such as drift, stale docs, flaky tests, dependency risk, and hidden coupling. Those are real concerns, but they are categories of maintenance work rather than a distinct domain overlay.

### Options

#### Option A: Keep Maintenance Overlay as Written

Pros:

* simple
* already present in the architecture
* easy for agents to invoke during repository cleanup

Cons:

* duplicates the Maintain stage
* creates circular language: maintenance work uses the Maintenance Overlay
* does not distinguish dependency, docs, architecture, CI, or test health work

#### Option B: Remove Maintenance Overlay Entirely

Pros:

* eliminates duplication
* keeps overlays domain-specific
* makes Maintain the single maintenance concept

Cons:

* loses a convenient checklist for maintenance work
* may make maintenance routes underspecified
* forces all maintenance concerns into the stage definition

#### Option C: Replace Maintenance Overlay With Specific Maintenance Sub-Overlays

Examples:

* Documentation Health Overlay
* Dependency Health Overlay
* Architecture Health Overlay
* CI/Test Health Overlay
* Repository Hygiene Overlay

Pros:

* keeps Maintain as the lifecycle stage
* makes overlays specific and actionable
* supports different maintenance routes without one catch-all overlay
* aligns with governance freshness and update obligations

Cons:

* adds more named concepts
* requires clear trigger rules for each sub-overlay
* may be too detailed for early COS adoption

### Recommendation

Choose Option C, but implement it in phases.

Near-term recommendation:

* keep `Maintain` as the lifecycle stage
* deprecate generic `Maintenance Overlay`
* introduce specific maintenance overlays only when their trigger rules are clear

Minimum first set:

* Documentation Health Overlay
* Dependency Health Overlay
* Architecture Health Overlay
* CI/Test Health Overlay

### Trade-Offs

This removes conceptual duplication while preserving maintenance rigor. The trade-off is more taxonomy. COS should avoid introducing every possible maintenance overlay at once; start with the four that map to recurring repository degradation.

## Decision 3: Where Are Knowledge Management Implementation Boundaries?

Status: Recommended, Requires ADR, Requires Spec Update

### Issue

`../specs/COS_GOVERNANCE_SPEC.md` defines a Knowledge Management Layer with authority, lifecycle, freshness, retrieval, conflicts, update obligations, retention, archival, and versioning.

`../specs/COS_IMPLEMENTATION_ARCHITECTURE.md` maps knowledge into `.codex/`, `docs/`, and `.codex-work/`.

The unresolved decision is what must be implemented as repository structure versus what remains manual governance. Without this boundary, COS may drift into premature tooling, indexing, scripts, or generated templates.

### Options

#### Option A: Documentation-Only Knowledge Management

Knowledge management is implemented entirely through markdown files and manual agent behavior.

Pros:

* simplest
* no tooling dependency
* easy to adopt
* aligns with current "do not implement scripts" constraint

Cons:

* retrieval can be inconsistent
* stale artifact detection is manual
* conflict resolution depends on agent discipline
* does not scale well across many repositories

#### Option B: Repository Structure Plus Required Governance Files

Knowledge management is implemented through:

* `.codex/adoption.md`
* `.codex/governance.md`
* `.codex/authority.md`
* `.codex/knowledge-map.md`
* durable `docs/` artifact locations
* `.codex-work/` continuity and evidence locations

No wrappers, scripts, or generated templates are required.

Pros:

* gives agents predictable discovery paths
* preserves manual adoption
* avoids premature automation
* supports authority and freshness without tooling
* can later be automated safely

Cons:

* requires more files than documentation-only adoption
* still depends on agents reading and updating files correctly
* freshness checks remain manual

#### Option C: Tooling-Backed Knowledge Management

Knowledge management includes indexes, generated maps, stale-artifact scanners, schema validators, or command wrappers.

Pros:

* stronger consistency
* easier stale detection
* better scale across repositories
* easier enforcement

Cons:

* premature at current design maturity
* violates current non-implementation boundary
* creates maintenance burden
* scripts may encode unstable semantics

### Recommendation

Choose Option B.

COS should implement Knowledge Management first as repository structure plus required governance files. Tooling should be deferred until adoption patterns stabilize.

Recommended boundary:

* Implement as file locations, governance headers, authority maps, and knowledge maps.
* Do not implement scanners, wrappers, generators, or validators yet.
* Treat `.codex/knowledge-map.md` as the manual index.
* Treat `.codex/authority.md` as the manual authority map.
* Treat `.codex-work/` as continuity/evidence storage, not durable policy.

### Trade-Offs

This gives COS enough structure for reliable repository use without prematurely freezing the model in code. The trade-off is weaker enforcement. That is acceptable until real repositories prove which checks are worth automating.

## Decision 4: What Adoption Level Should Be the First Target?

Status: Recommended, Requires ADR

### Issue

`../specs/COS_GOVERNANCE_SPEC.md` defines adoption levels A0 through A5.

`../specs/COS_IMPLEMENTATION_ARCHITECTURE.md` maps repository structure by adoption level:

* A1: Documented
* A2: Artifact-Aware
* A3: Workflow-Aware
* A4: Governed
* A5: Automated

The unresolved decision is which adoption level should be the first implementation target. Starting too low may not prove the architecture. Starting too high may create too much structure before validation.

### Options

#### Option A: Start With A1

Pros:

* smallest adoption footprint
* easy to add to any repository
* validates AGENTS integration and adoption profile

Cons:

* too weak to validate artifact governance
* does not exercise routing, handoff, research, or execution authority
* may give false confidence

#### Option B: Start With A2

Pros:

* validates artifact locations and authority
* introduces governance and knowledge maps
* still avoids workflow-heavy structure

Cons:

* does not fully test routing or handoff behavior
* insufficient for implementation, debugging, release, or maintenance workflows

#### Option C: Start With A3

Pros:

* validates routing, execution limits, handoffs, verification, and durable artifacts
* covers real engineering workflows
* remains non-automated
* aligns with governance recommendation for serious engineering repositories

Cons:

* creates more repository structure
* requires more up-front decisions
* may feel heavy for small repos or proofs of concept

#### Option D: Start With A4

Pros:

* validates full governance
* includes version tracking and review cadence
* closest to mature COS operation

Cons:

* too much for first implementation
* risks ceremony before usage evidence
* may slow adoption

### Recommendation

Choose Option C: A3 Workflow-Aware as the first full implementation target.

Use A1 as the minimum adoption path for small repositories, but define A3 as the reference implementation target for COS.

### Trade-Offs

A3 is heavy enough to test COS as an operating system, not just a document set. It is still light enough to avoid automation. The trade-off is adoption overhead; this can be controlled by allowing A1 and A2 as valid partial adoption levels.

## Decision 5: What Is the Repository Bootstrap Strategy?

Status: Recommended, Requires ADR, Requires Spec Update

### Issue

COS needs a way to install or adopt the repository structure. Current constraints explicitly defer wrappers, scripts, templates, generated folders, and bootstrap logic.

The unresolved decision is how repositories should move from no COS adoption to A1, A2, or A3 without prematurely building automation.

### Options

#### Option A: Manual Copy Bootstrap

Users manually create files and folders from the implementation architecture.

Pros:

* no tooling
* no scripts
* no implementation burden
* easy to inspect

Cons:

* error-prone
* inconsistent across repositories
* slow for repeated adoption
* hard to keep aligned with COS versions

#### Option B: Guided Manual Bootstrap

COS provides a bootstrap specification that lists steps for A1, A2, and A3 adoption, but does not provide scripts or templates.

Pros:

* keeps non-implementation boundary
* reduces ambiguity
* supports consistent adoption
* can later become automation input

Cons:

* still manual
* requires users or agents to create files carefully
* can drift unless versioned

#### Option C: Template-Based Bootstrap

COS provides templates for adoption files and artifact headers.

Pros:

* improves consistency
* lowers adoption friction
* prepares for automation

Cons:

* violates the current "do not generate templates" constraint if done now
* template semantics may freeze too early
* creates maintenance load

#### Option D: Scripted Bootstrap

COS provides a command or wrapper that creates the structure.

Pros:

* fast
* repeatable
* easy to standardize

Cons:

* explicitly deferred
* likely premature
* requires versioning and migration support
* can encode unstable architecture decisions

### Recommendation

Choose Option B: Guided Manual Bootstrap.

Next design artifact should be a bootstrap procedure specification, not scripts or templates.

Recommended scope:

* A1 adoption checklist
* A2 adoption checklist
* A3 adoption checklist
* required decisions before each level
* files to create
* directories to create
* governance fields to fill
* validation checklist
* no generated content
* no executable automation

### Trade-Offs

Guided manual bootstrap creates enough repeatability without premature automation. The trade-off is manual effort. That is acceptable while the architecture is still being validated.

## Decision 6: Should `.codex-work/` Be Committed?

Status: Recommended, Requires Spec Update

### Issue

`../specs/COS_IMPLEMENTATION_ARCHITECTURE.md` places handoffs, investigations, and verification notes under `.codex-work/`.

The unresolved question is whether `.codex-work/` should be committed to version control. These artifacts are continuity and evidence, but may include transient information, local paths, logs, partial findings, or sensitive operational context.

### Options

#### Option A: Commit All `.codex-work/`

Pros:

* preserves agent continuity
* makes verification evidence auditable
* supports handoff across machines and agents

Cons:

* may leak sensitive or noisy information
* can clutter history
* makes ephemeral artifacts look more authoritative than intended

#### Option B: Do Not Commit `.codex-work/`

Pros:

* keeps repository clean
* reduces risk of leaking local or sensitive details
* reinforces low authority of handoff notes

Cons:

* loses continuity across agents
* verification and investigation evidence may disappear
* harder to audit agent work later

#### Option C: Commit Selected `.codex-work/` Artifacts by Promotion

Default `.codex-work/` artifacts are local or ephemeral. Important items are promoted into durable locations:

* incident evidence -> `docs/operations/incidents/`
* release evidence -> `docs/operations/releases/`
* research source notes -> `docs/research/`
* accepted diagnosis summary -> durable issue, ADR, or maintenance report

Pros:

* preserves important knowledge
* avoids clutter
* maintains authority boundaries
* reduces leakage risk

Cons:

* requires promotion discipline
* may lose some useful ephemeral context
* needs clear promotion criteria

### Recommendation

Choose Option C.

`.codex-work/` should be treated as ephemeral by default. Only promoted artifacts should become durable repository knowledge.

### Trade-Offs

This preserves the governance distinction between continuity and durable knowledge. The trade-off is that agents must explicitly promote important findings before work closes.

## Decision 7: Should Knowledge Management Have a Dedicated Directory?

Status: Recommended

### Issue

Knowledge management is currently distributed:

* `.codex/knowledge-map.md`
* `.codex/authority.md`
* `.codex/governance.md`
* `docs/`
* `.codex-work/`

The unresolved question is whether COS should introduce a dedicated `.codex/knowledge/` directory.

### Options

#### Option A: Keep Knowledge Management as Top-Level `.codex` Files

Pros:

* simple
* easy to find
* matches current implementation architecture
* avoids extra hierarchy

Cons:

* may become crowded
* less room for future subdocuments

#### Option B: Add `.codex/knowledge/`

Pros:

* clearer conceptual grouping
* scales to multiple knowledge maps
* supports future indexing or freshness reports

Cons:

* adds structure before need is proven
* complicates A1/A2 adoption
* may imply implementation tooling

#### Option C: Use `docs/knowledge/`

Pros:

* places knowledge docs in durable docs
* makes it visible to humans

Cons:

* mixes repository knowledge artifacts with COS control-plane governance
* weakens `.codex/` as adoption control plane

### Recommendation

Choose Option A for now.

Keep:

* `.codex/knowledge-map.md`
* `.codex/authority.md`
* `.codex/governance.md`

Revisit `.codex/knowledge/` only if these files become too large or need separate lifecycle management.

### Trade-Offs

This favors simplicity over future scalability. The cost is acceptable until real repositories show that knowledge management needs more structure.

## Decision 8: Should A5 Automation Be Part of COS Core?

Status: Recommended, Requires ADR

### Issue

Adoption level A5 allows automation after governance is stable. The unresolved question is whether A5 belongs to core COS or should be treated as an optional extension.

### Options

#### Option A: A5 Is Core COS

Pros:

* makes automation a planned first-class target
* encourages consistent future tooling
* gives a path to validation and enforcement

Cons:

* pulls implementation concerns into architecture
* increases maintenance burden
* can pressure premature wrapper/script generation

#### Option B: A5 Is an Optional Extension

Pros:

* keeps core COS documentation-first
* avoids premature automation
* allows different repositories to automate differently
* preserves current non-implementation boundary

Cons:

* automation may fragment later
* less standardization across repositories
* delayed enforcement

#### Option C: Remove A5 Until Needed

Pros:

* eliminates automation pressure
* keeps adoption levels focused on documentation and governance

Cons:

* loses a visible long-term path
* future automation may be bolted on awkwardly

### Recommendation

Choose Option B.

A5 should remain in the adoption model as an optional extension level, not part of core COS implementation.

### Trade-Offs

This keeps the path open without making automation a near-term commitment. The trade-off is that future automation needs its own architecture and governance review before implementation.

## Decision 9: How Should Bootstrap Validate Adoption?

Status: Recommended

### Issue

If bootstrap remains manual, COS still needs a way to determine whether a repository has successfully adopted A1, A2, or A3.

### Options

#### Option A: No Validation

Pros:

* simplest
* no extra process

Cons:

* adoption will be inconsistent
* agents may assume files exist when they do not
* hard to compare repositories

#### Option B: Manual Readiness Checklist

Pros:

* aligns with no scripts/templates constraint
* easy to include in bootstrap procedure
* supports repeatable adoption

Cons:

* manual
* can be skipped
* does not enforce correctness

#### Option C: Automated Validator

Pros:

* repeatable
* enforceable
* good for scale

Cons:

* premature
* violates current non-implementation boundary
* requires schemas and tooling

### Recommendation

Choose Option B.

Each adoption level should have a manual readiness checklist. Automated validation can be considered only after A3 is proven in real repositories.

### Trade-Offs

Manual validation is weaker than tooling but fits the current phase. It also gives COS a clear path to later automation because the checklist can become validator requirements.

## Decision 10: Should COS Define Artifact Schemas Now?

Status: Recommended

### Issue

`../specs/COS_GOVERNANCE_SPEC.md` defines required governance headers and artifact classes, but `../specs/COS_IMPLEMENTATION_ARCHITECTURE.md` explicitly avoids generating templates.

The unresolved question is whether COS should define artifact schemas now.

### Options

#### Option A: Define Full Schemas Now

Pros:

* improves consistency
* supports future validation
* reduces ambiguity

Cons:

* may become templates in practice
* could freeze artifact design too early
* increases documentation burden

#### Option B: Define Minimal Schema Requirements Only

Pros:

* preserves governance consistency
* avoids full template generation
* gives enough structure for adoption
* aligns with current non-implementation boundary

Cons:

* less consistency than full schemas
* agents may format artifacts differently

#### Option C: Defer Schemas Entirely

Pros:

* fastest
* avoids premature structure

Cons:

* weakens artifact authority and lifecycle management
* makes future validation harder

### Recommendation

Choose Option B.

Define minimal schema requirements, especially governance headers and required sections, but do not generate templates yet.

### Trade-Offs

This gives artifacts enough structure for authority and lifecycle management without turning this phase into template implementation.

## Recommended Decision Order

Decide in this order:

1. Diagnose model
2. Maintenance Overlay replacement
3. Knowledge Management implementation boundary
4. First target adoption level
5. Repository bootstrap strategy
6. `.codex-work/` commit and promotion policy
7. Knowledge Management directory structure
8. A5 automation status
9. Bootstrap validation method
10. Minimal artifact schema policy

## Implementation Readiness Impact

COS should not proceed to repository implementation until at least these decisions are accepted:

* Diagnose model
* Maintenance Overlay model
* Knowledge Management implementation boundary
* First target adoption level
* Repository bootstrap strategy

The other decisions can be resolved during bootstrap-spec design, but they should be resolved before generating repository adoption files.

## Final Recommendation

The next artifact should be a decision acceptance pass, not implementation.

Recommended accepted direction:

* Diagnosis becomes a specialized overlay.
* Generic Maintenance Overlay is deprecated and replaced by specific maintenance overlays.
* Knowledge Management is implemented first through repository structure and governance files, not tooling.
* A3 Workflow-Aware is the reference implementation target.
* Bootstrap is guided manual, with checklists but no scripts or templates.
* `.codex-work/` is ephemeral by default, with promotion into durable docs when needed.
* A5 automation remains optional and out of core COS for now.
