# COS Diagnosis Overlay Specification

## Purpose

The Diagnosis Overlay defines how COS handles unexplained failures, bugs, failing tests, and production symptoms before remediation.

Diagnosis is a specialized overlay. It is not a lifecycle stage and not a review lens.

Its purpose is to establish enough causal understanding to plan and verify the smallest responsible fix. It prevents agents from treating symptoms, guessing at fixes, or moving into `Build` before the failure is understood.

## When To Apply It

Apply the Diagnosis Overlay when work includes:

* unexplained failures
* failing tests with unknown cause
* runtime errors, crashes, hangs, or regressions
* production symptoms that need technical investigation
* behavior that contradicts expected product, contract, or operational behavior
* build, deploy, or CI failures that are not already understood
* user reports where the observed symptom and actual cause may differ

Diagnosis is required for non-trivial unexplained failures before `Build`.

## When Not To Apply It

Do not apply Diagnosis when:

* the cause is already known and the task is only implementation
* the work is a planned feature, refactor, migration, or documentation change
* the request is a normal review, critique, or architecture challenge
* the issue is only a question that can be answered from existing documentation
* the failure is trivial, local, and already explained by the user or repository evidence
* the task is incident coordination without technical root-cause investigation

If new unexplained failures appear during `Build` or `Verify`, route back through Diagnosis.

## Route Shape

Default debugging route:

```text
Intake -> Understand -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Handoff
```

Incident route when production or operational response is involved:

```text
Intake -> Understand -> Apply Incident Overlay -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Diagnosis does not replace `Understand`, `Plan`, `Build`, or `Verify`. It adds specialized checks and artifacts between understanding the problem and planning a fix.

## Relationship With Incident Overlay

Incident Overlay handles operational response: severity, user impact, containment, rollback, timeline, communication, release concerns, and post-incident follow-up.

Diagnosis Overlay handles causal investigation: what failed, why it failed, how the failure can be reproduced or observed, and what evidence supports the root cause.

Use both when an incident has an unexplained technical cause. In that route:

* Incident establishes impact, urgency, containment needs, and operational guardrails.
* Diagnosis establishes root cause before remediation.
* Release handles rollout, rollback, monitoring, and production validation.
* Maintain captures follow-up work and durable knowledge updates.

Incident response may require containment before full diagnosis when user, data, security, or production risk is high. Containment must be recorded as containment, not treated as root-cause resolution.

## Relationship With Build And Verify

`Build` may implement local code, prepare operational change, or execute an approved operational action. Diagnosis does not grant permission to execute risky work.

Before `Build`, Diagnosis should identify:

* observed symptom
* expected behavior
* suspected root cause
* evidence supporting the cause
* impacted area
* proposed remediation path
* verification plan

For non-trivial unexplained failures, `Build` must not start until root cause is established or the remaining uncertainty is explicitly documented and accepted.

`Verify` must prove both:

* the original symptom no longer occurs
* the diagnosed cause is addressed, not merely hidden

If verification produces a new unexplained failure, return to Diagnosis instead of continuing to patch.

## Entry Criteria

Diagnosis may start when:

* a concrete symptom, failure, or unexpected behavior is known
* the expected behavior is stated or discoverable
* enough context exists to inspect likely causes
* relevant repository instructions, docs, code, logs, tests, or runtime evidence can be examined

If the symptom is too vague to investigate, return to `Understand` and clarify:

* what happened
* where it happened
* when it started
* expected behavior
* observed behavior
* available evidence

## Exit Criteria

Diagnosis is complete when:

* the symptom is described precisely
* expected behavior is known
* the root cause is identified or the limit of available evidence is explicit
* supporting evidence is recorded
* affected contracts, data, permissions, workflows, or operational systems are identified
* a remediation plan can be written
* verification expectations are defined

For high-risk work, unresolved uncertainty must be carried into `Plan` as a risk and may require user confirmation before `Build`.

## Required Artifacts

Required artifacts scale with blast radius and complexity. For non-trivial diagnosis, preserve:

* Problem Brief
* Diagnosis Notes
* Root-Cause Evidence
* Remediation Plan
* Verification Evidence
* Handoff

For small local failures, the artifacts may be concise and embedded in the working response or handoff. For durable project knowledge, promote findings into `docs/` according to governance rules.

## Optional Artifacts

Use these only when they clarify the work:

* reproduction steps
* failure timeline
* hypothesis log
* affected-surface map
* test plan
* rollback notes
* incident notes
* post-incident follow-up
* ADR, contract update, or architecture note when diagnosis changes durable understanding

Do not create templates for these artifacts as part of this overlay.

## Diagnosis Workflow

1. Define the symptom.
2. Define expected behavior.
3. Gather evidence from the smallest relevant source set.
4. Identify affected area and blast radius.
5. Form one or more testable hypotheses.
6. Test hypotheses against code, tests, configuration, logs, runtime evidence, or user-reported facts.
7. Narrow to the most supported root cause.
8. Record evidence and rejected alternatives when relevant.
9. Plan the smallest responsible remediation.
10. Define verification that proves the original symptom and root cause are addressed.

For low-risk obvious failures, this workflow can be compressed. It must not be skipped for unexplained or high-risk failures.

## Root-Cause Rules

Root cause must be evidence-based.

Rules:

* A symptom is not a root cause.
* A guess is not a root cause.
* A plausible fix is not root-cause evidence.
* "Works after change" is not enough unless the change directly addresses the diagnosed cause.
* Correlation in logs or timing is supporting evidence, not proof by itself.
* Missing observability must be documented as a diagnostic limitation.
* Multiple causes must be separated when a failure has more than one contributing factor.
* If the true root cause cannot be established, state the best-supported cause and remaining uncertainty.

For non-trivial unexplained failures, root cause must be established before `Build` unless the user explicitly approves a constrained experimental remediation.

## Verification Expectations

Verification must be fresh and tied to the diagnosis.

Expected verification includes:

* reproduction fails before the fix when practical
* targeted test, check, log, or manual validation proves the symptom is gone
* evidence shows the diagnosed cause is addressed
* regression risk is considered for affected contracts, workflows, data, or operations
* residual uncertainty is stated

For production or operational diagnosis, verification should also include release, monitoring, rollback, or containment evidence as required by the Incident and Release routes.

## Examples

### Failing Test

Symptom:

```text
The audit log pagination test fails after a query change.
```

Route:

```text
Intake -> Understand -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Handoff
```

Diagnosis output:

* expected ordering rule
* failing assertion
* query behavior causing skipped records
* targeted test plan

### Production Error

Symptom:

```text
Users intermittently receive 500 responses when exporting reports.
```

Route:

```text
Intake -> Understand -> Apply Incident Overlay -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Release -> Handoff -> Maintain
```

Diagnosis output:

* impact and containment from Incident
* failing dependency or data condition
* root-cause evidence from logs or runtime behavior
* remediation and production verification plan

### Build Failure

Symptom:

```text
CI fails after dependency updates, but local tests pass.
```

Route:

```text
Intake -> Understand -> Apply Diagnosis Overlay -> Plan -> Build -> Verify -> Handoff
```

Diagnosis output:

* environment difference
* failing command and error
* dependency or configuration cause
* verification command for CI-equivalent behavior

## Common Mistakes

* Treating Diagnosis as a lifecycle stage named `Diagnose`.
* Treating Diagnosis as a review lens.
* Starting `Build` before root cause is established.
* Fixing the first visible symptom without testing alternatives.
* Using broad rewrites as diagnosis.
* Treating containment as final remediation.
* Treating a passing test as proof without tying it to the diagnosed cause.
* Ignoring incident severity, rollback, or communication needs during production symptoms.
* Leaving root-cause evidence only in chat when it changes durable project knowledge.
* Creating scripts, wrappers, or templates instead of documenting the overlay behavior.
