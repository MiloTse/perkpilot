# Architecture Decision Records (ADR)

> **Languages**: [中文](../../adr/README.md) | English (this page)  
> **Policy**: [Documentation policy](../../DOCUMENTATION-POLICY.md)

This directory records **Architecture Decision Records**: **high-cost or hard-to-reverse** choices and boundaries, so newcomers (and future you) understand *why* the system looks the way it does.

---

## Index

| ADR | Title | Status |
|-----|-------|--------|
| — | (none yet) | — |

---

## When to write an ADR

- Choosing **Cognito vs. another IdP**, **JWT vs. session**, **OpenAPI source of truth**, **Flyway vs. Liquibase**, **multi-tenant isolation level**, etc.
- Adopting or retiring a major **AWS service path** (e.g. EB → EKS).

---

## Template (copy to `NNNN-title.md`)

```markdown
# ADR NNNN: Title

## Status

Proposed | Accepted | Superseded by ADR-XXXX

## Context

## Decision

## Consequences

## Alternatives
```

---

## Revision history

| Date | Description |
|------|-------------|
| 2026-05-12 | Initialized ADR directory and template |
| 2026-05-12 | Bilingual links and documentation policy reference |
