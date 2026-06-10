# PerkPilot Documentation (English)

> **Languages**: [中文](../README.md) | English (this page)  
> **Policy**: Keep Chinese and English in sync — [Documentation policy](../DOCUMENTATION-POLICY.md)

This directory mirrors formal product and engineering docs under `docs/` in **English**. Paths match the Chinese tree (e.g. `../project-charter.md` ↔ `./project-charter.md`).

---

## 1. Reading order

| # | Document | Description |
|---|----------|-------------|
| 0 | [DOCUMENTATION-POLICY.md](../DOCUMENTATION-POLICY.md) | **Documentation policy**: same-change-set ZH/EN, path mirror, `docs/en/` |
| 1 | [project-charter.md](./project-charter.md) | **Project charter**: background, tenants/roles, scope, goals, NFR summary |
| 2 | [architecture/system-design.md](./architecture/system-design.md) | **System design**: context, logical/physical views, security, AWS mapping (in progress) |
| 3 | [data/database-design.md](./data/database-design.md) | **Data design**: naming, logical/physical model, migrations (in progress) |
| 4 | [api/conventions.md](./api/conventions.md) | **API conventions**: URLs/versions, errors, auth; OpenAPI location (in progress) |
| 5 | [engineering/release-and-cicd.md](./engineering/release-and-cicd.md) | **Release & CI/CD**: branches, environments, pipelines, versioning |
| — | [adr/README.md](./adr/README.md) | **ADRs**: architecture decision index and template |

---

## 2. Other common engineering artifacts (enable as needed)

See the Chinese [README.md](../README.md) §2 for the full table (PRD, threat modeling, test strategy, OpenAPI, etc.).

---

## 3. Repository layout (suggested)

| Topic | Location |
|-------|----------|
| IaC | `infra/` (cross-link from architecture) |
| Executable tests | `backend/`, `frontend/` + CI config |
| Pipelines | `.github/workflows/` and/or `infra` (CodePipeline) |

---

## 4. Next decisions

- [ ] Tenant onboarding (signup, first admin, trial/billing) in v0 or not  
- [ ] Auth choice (Cognito vs. others) and **`tenant_id` in JWT**  
- [ ] Approval state machine and draft/live strategy (templates A/B in charter)  
- [ ] OpenAPI source of truth and codegen  
- [ ] Environment matrix (dev / staging / prod) and AWS accounts / regions  

---

## Revision history

| Date | Description |
|------|-------------|
| 2026-05-12 | Initial English documentation hub |
| 2026-05-12 | Bilingual parity policy and cross-links |
