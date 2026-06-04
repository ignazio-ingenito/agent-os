# COS Accepted Decisions

## Purpose

This document records accepted architectural decisions for COS.

It accepts the recommended decisions from `COS_DECISIONS.md` where they do not clearly contradict the source specifications.

This document does not implement COS and does not modify existing source specifications.

## Source Documents

Accepted decisions were evaluated against:

* `../specs/COS_ARCHITECTURE.md`
* `../specs/COS_GOVERNANCE_SPEC.md`
* `../specs/COS_IMPLEMENTATION_ARCHITECTURE.md`
* `COS_DECISIONS.md`

## Accepted Decisions

### 1. Diagnosis Becomes a Specialized Overlay

Decision:

`Diagnosis` is a specialized overlay. It is not a core lifecycle stage and not a review lens.

Accepted route shape:

```text
Intake -> Understand -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Handoff
```

For incidents, Diagnosis may be combined with Incident:

```text
Intake -> Understand -> Apply Incident Overlay -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Rationale:

This follows the Research Overlay precedent. Diagnosis is specialized enough to need explicit trigger rules and artifacts, but not universal enough to belong in the core lifecycle.

Consequences:

* `Diagnose` should be removed from lifecycle-style route strings.
* Debugging routes should use `Apply Diagnosis Overlay`.
* Diagnosis needs explicit trigger rules, entry criteria, exit criteria, and artifacts.
* Root cause must be established before Build for non-trivial unexplained failures.

### 2. Generic Maintenance Overlay Is Deprecated

Decision:

The generic `Maintenance Overlay` is deprecated.

Rationale:

`Maintain` is already a lifecycle stage. A generic Maintenance Overlay duplicates that stage and creates circular architecture.

Consequences:

* Maintenance work should route through the Maintain lifecycle stage.
* Existing references to `Maintenance Overlay` should be removed or marked deprecated.
* Maintenance concerns should be represented through the Maintain stage and specific overlays when needed.

### 3. Maintenance Concerns Use Maintain and Specific Future Overlays

Decision:

Maintenance concerns are handled by:

* the `Maintain` lifecycle stage
* specific overlays later if needed

Potential future overlays:

* Documentation Health Overlay
* Dependency Health Overlay
* Architecture Health Overlay
* CI/Test Health Overlay

Rationale:

Specific overlays are more actionable than a catch-all Maintenance Overlay. They keep maintenance composable without duplicating the lifecycle stage.

Consequences:

* Do not introduce every maintenance overlay immediately.
* Add specific overlays only when trigger rules and required artifacts are clear.
* Maintenance reports remain valid artifacts under the Maintain stage.

### 4. Knowledge Management Starts as Structure and Governance, Not Tooling

Decision:

Knowledge Management is implemented first through repository structure and governance files, not tooling.

Rationale:

COS needs predictable artifact locations, authority maps, lifecycle states, and knowledge maps before it needs scanners, validators, generators, or indexes.

Consequences:

* `.codex/adoption.md`, `.codex/governance.md`, `.codex/authority.md`, and `.codex/knowledge-map.md` remain the primary control-plane files.
* `docs/` remains the durable knowledge area.
* `.codex-work/` remains continuity and evidence storage.
* No stale-artifact scanner, schema validator, generator, wrapper, or indexer is part of core implementation yet.

### 5. A3 Workflow-Aware Is the Reference Implementation Target

Decision:

A3 Workflow-Aware is the reference implementation target for COS.

Rationale:

A3 is strong enough to validate routes, overlays, execution limits, handoffs, verification, and durable artifacts without requiring automation.

Consequences:

* Reference repository structure should target A3.
* A3 should define routing, execution, handoff, investigation, verification, operations, and maintenance locations.
* A3 remains non-automated.

### 6. A1 Remains the Minimum Lightweight Adoption Level

Decision:

A1 Documented remains the minimum useful lightweight adoption level.

Rationale:

Small repositories and proofs of concept need a low-friction way to declare COS usage without adopting the full A3 structure.

Consequences:

* A1 remains valid.
* A1 should include `AGENTS.md`, base COS specs, and `.codex/adoption.md`.
* A1 does not need full workflow, research, handoff, or operations structure.

### 7. Bootstrap Strategy Is Guided Manual Bootstrap

Decision:

Repository bootstrap is guided manual bootstrap with checklists. No scripts and no templates are introduced yet.

Rationale:

Guided manual bootstrap gives repeatability without prematurely encoding unstable architecture decisions in automation.

Consequences:

* Future bootstrap documentation should define A1, A2, and A3 checklists.
* Bootstrap may list files and folders to create.
* Bootstrap must not generate files, wrappers, scripts, templates, or automation.
* Bootstrap checklists can later become automation requirements if A3 adoption is validated.

### 8. `.codex-work/` Is Ephemeral by Default

Decision:

`.codex-work/` is ephemeral by default.

Rationale:

Handoffs, investigations, and verification notes are continuity and evidence artifacts. They should not automatically become durable repository knowledge or policy.

Consequences:

* `.codex-work/` artifacts are low-authority unless promoted.
* Handoff notes must not be treated as policy.
* Repositories should decide whether `.codex-work/` is committed, ignored, or selectively promoted.

### 9. Important `.codex-work` Findings Must Be Promoted

Decision:

Important `.codex-work/` findings must be promoted into durable docs when they affect:

* decisions
* contracts
* incidents
* releases
* long-term knowledge

Rationale:

Ephemeral evidence should not be lost when it changes durable understanding.

Consequences:

* Incident findings should be promoted to `docs/operations/incidents/`.
* Release findings should be promoted to `docs/operations/releases/`.
* Research-relevant source notes should be promoted to `docs/research/`.
* Architecture or contract implications should be promoted to ADRs, contracts, or architecture docs.

### 10. Keep Knowledge Management Files as Top-Level `.codex` Files

Decision:

Knowledge Management files remain top-level `.codex` files for now.

Do not create:

```text
.codex/knowledge/
```

Rationale:

The current model is simpler and sufficient for early adoption. A dedicated knowledge directory would add hierarchy before need is proven.

Consequences:

* Keep `.codex/knowledge-map.md`.
* Keep `.codex/authority.md`.
* Keep `.codex/governance.md`.
* Revisit a dedicated knowledge directory only if these files become too large or need separate lifecycle management.

### 11. A5 Automation Is Optional and Outside Core COS

Decision:

A5 Automation remains optional and outside core COS.

Rationale:

Automation should come only after the architecture, governance, and A3 adoption model are proven manually.

Consequences:

* Core COS does not include wrappers, scripts, generators, validators, or automation hooks.
* Any future A5 automation requires its own architecture and governance review.
* A5 remains a possible extension level, not a core implementation requirement.

### 12. Bootstrap Validation Is Manual Checklist-Based

Decision:

Bootstrap validation is manual checklist-based.

Rationale:

Manual validation fits the current non-automation boundary while still giving repositories a way to check adoption completeness.

Consequences:

* A1, A2, and A3 should each have readiness checklists.
* No automated validator is introduced yet.
* Checklist items may later become validator requirements after A3 adoption is validated.

### 13. Define Minimal Artifact Schema Requirements Only

Decision:

COS defines only minimal artifact schema requirements for now, not full templates.

Rationale:

Minimal schema requirements support authority, lifecycle, freshness, and conflict resolution without prematurely generating templates.

Consequences:

* Governance headers are required for durable artifacts.
* Required sections may be specified by artifact type.
* Full templates are deferred.
* Artifact schema versions may be tracked without generating template files.

## Rationale Summary

The accepted decisions preserve the current COS direction:

* lifecycle-first
* overlay-backed specialization
* governance before tooling
* structure before automation
* A3 as the reference target
* A1 as the lightweight entry point
* clear authority boundaries between durable knowledge and continuity artifacts

No accepted decision clearly contradicts the source specifications. Some accepted decisions intentionally supersede unresolved or inconsistent portions of `../specs/COS_ARCHITECTURE.md`, especially the current `Diagnose` route and generic `Maintenance Overlay`.

## Consequences Summary

The accepted decisions create these architectural consequences:

* `Diagnosis` must be added as a specialized overlay.
* `Maintenance Overlay` must be deprecated.
* Maintenance-specific overlays must be deferred until trigger rules are clear.
* Knowledge Management remains documentation and repository-structure based.
* A3 is the reference implementation target.
* A1 remains the minimum adoption path.
* Bootstrap remains manual and checklist-based.
* `.codex-work/` remains ephemeral by default.
* Important `.codex-work/` knowledge must be promoted into durable docs.
* `.codex/knowledge/` is not introduced.
* A5 automation is outside core COS.
* Minimal schemas are defined, but full templates are deferred.

## Required Spec Updates

Once these decisions are ready to apply, update the source specifications as follows.

### `../specs/COS_ARCHITECTURE.md`

Required updates:

* Replace `Diagnose` route nodes with `Apply Diagnosis Overlay`.
* Add `Diagnosis Overlay` to the overlays section.
* Define Diagnosis Overlay triggers, checks, artifacts, entry criteria, and exit criteria.
* Deprecate or remove `Maintenance Overlay`.
* Update maintenance route language to use `Maintain` plus future specific overlays.
* Remove `Maintenance` from routing-table overlay lists where it refers to the deprecated generic overlay.
* Add references to specific future maintenance overlays only as deferred concepts.

### `../specs/COS_GOVERNANCE_SPEC.md`

Required updates:

* Clarify `.codex-work/` as ephemeral by default.
* Add promotion obligations for important `.codex-work/` findings.
* Clarify A5 automation as optional and outside core COS.
* Add manual checklist-based bootstrap validation to adoption governance.
* Clarify minimal artifact schema requirements versus full templates.

### `../specs/COS_IMPLEMENTATION_ARCHITECTURE.md`

Required updates:

* Mark `.codex-work/` as ephemeral by default.
* Add promotion paths from `.codex-work/` into durable docs.
* Clarify A3 as the reference implementation target.
* Clarify A1 as the minimum lightweight adoption level.
* Clarify that `.codex/knowledge/` should not be created yet.
* Clarify that bootstrap is guided manual checklist-based.

### `COS_DECISIONS.md`

Required updates:

* Mark accepted decisions as accepted or superseded by this document.
* Leave any unresolved decisions not covered here as open.

## Implementation Implications

These decisions imply the next design work should be:

* define the Diagnosis Overlay specification
* revise the maintenance model around Maintain and specific future overlays
* define guided manual bootstrap checklists for A1, A2, and A3
* define minimal artifact schema requirements
* define `.codex-work/` promotion rules

These decisions do not authorize:

* creating folders
* generating templates
* writing scripts
* creating wrappers
* adding automation
* modifying existing source specifications without an explicit follow-up request

## Remaining Open Questions

The following questions remain open:

* What exact trigger rules should activate Documentation Health, Dependency Health, Architecture Health, and CI/Test Health overlays?
* What minimum sections are required for each durable artifact type?
* Should `.codex-work/` be ignored by default, committed selectively, or governed per repository?
* What should the guided manual bootstrap checklist artifact be named?
* Should accepted decisions eventually be converted into ADRs under `docs/adr/` once repository structure is implemented?
* What review cadence should A3 repositories use for adoption files and knowledge maps?
* What criteria prove A3 adoption is validated enough to consider A5 automation?

## Non-Implementation Boundary

This document does not create or require:

* folders
* wrappers
* scripts
* templates
* automation
* generated adoption files
* generated artifact schemas

It records accepted decisions only.
