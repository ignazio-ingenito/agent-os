# COS Design Specification

## Objective

Design a reusable Codex Operating System (COS).

The COS must provide a structured workflow for engineering, architecture, infrastructure, AI projects, application development, UX design, repository maintenance, and technical decision making.

The COS must be reusable across multiple repositories and projects.

The COS is intended to support:

* Complex business applications
* Web applications
* Next.js applications
* Backend services
* APIs
* Kubernetes-based systems
* DevOps and Infrastructure
* AI-enabled applications
* Data platforms
* Internal tools
* Proof of Concepts

The goal is not implementation.

The goal is validating the framework design before implementation.

---

# Existing Assumptions

The framework currently includes:

## Core Skills

* grill-me
* grill-with-docs
* challenge
* critique
* to-prd
* to-issues
* tdd
* diagnose
* review
* qa
* prototype
* zoom-out
* handoff
* improve-codebase-architecture
* docs-sync

---

## Proposed Pipelines

### Discovery

Skills:

* grill-with-docs
* grill-me
* zoom-out
* challenge

Purpose:

Understand a problem before designing solutions.

---

### Research

Skills:

* grill-with-docs
* zoom-out
* challenge
* critique
* handoff

Purpose:

Evaluate technologies, architectures, frameworks and alternatives.

---

### Decision

Skills:

* to-prd
* challenge
* critique
* handoff

Purpose:

Transform discussions into explicit decisions.

---

### Implementation

Skills:

* to-issues
* tdd
* diagnose
* review
* handoff

Purpose:

Implement work incrementally.

---

### Application Design

Skills:

* grill-with-docs
* zoom-out
* to-prd
* prototype
* challenge
* critique
* to-issues
* tdd
* qa
* review

Purpose:

Design workflows, UX, information architecture and interfaces before implementation.

---

### Maintenance

Skills:

* improve-codebase-architecture
* docs-sync
* diagnose
* handoff

Purpose:

Prevent repository degradation.

---

### Review

Skills:

* critique
* challenge
* handoff

Purpose:

Review and improve existing artifacts.

---

# Dual Review Model

Challenge:

Question viability.

Critique:

Improve quality.

Rule:

Challenge first.
Critique second.

---

# Pipeline Recommendation System

The framework should proactively suggest pipelines.

Examples:

* unclear requirements → Discovery
* technology comparison → Research
* architecture decision → Decision
* implementation request → Implementation
* UX/UI redesign → Application Design
* repository cleanup → Maintenance
* review of existing artifact → Review

The framework should recommend a pipeline when appropriate.

The recommendation must not become intrusive.

---

# Deliverables Planned

The future implementation is expected to generate:

```text
.codex/
├── AGENTS.md
├── PIPELINES.md
├── pipelines/
├── templates/
├── examples/
└── bin/
```

Including:

* wrapper scripts
* templates
* examples
* Italian user guide

---

# Requested Review

Perform:

## Critique

Identify:

* missing workflows
* missing skills
* unclear responsibilities
* weak areas
* usability concerns
* maintainability concerns

---

## Challenge

Identify:

* unnecessary complexity
* duplicated concepts
* redundant pipelines
* hidden operational costs
* long-term maintenance risks

---

## Recommendations

Produce:

* keep
* modify
* remove
* add

for every major component.

---

# Constraints

Do not implement anything.

Do not generate wrappers.

Do not generate files.

Produce only a design review.

---

# Output

Generate:

../reviews/COS_DESIGN_REVIEW.md

containing:

* executive summary
* critique findings
* challenge findings
* risks
* recommendations
* proposed revised architecture
* implementation readiness assessment

```
```
