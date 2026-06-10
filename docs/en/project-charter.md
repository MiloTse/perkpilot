# PerkPilot Project Charter

> **Languages**: [中文](../project-charter.md) | English (this page)  
> **Policy**: Chinese and English must be updated together — [Documentation policy](../DOCUMENTATION-POLICY.md)

| Field | Content |
|-------|---------|
| Document version | 0.1.3 (draft) |
| Status | Draft — moves to Approved after key business and technical review |
| Maintainers | Product and engineering leads; record material changes in [ADR](./adr/) or the revision log |

---

## 1. Background and motivation

### 1.1 Industry and experience context

- **CLRP** (internal bank rights / entitlement management; originally a **single legal entity**) provides a reusable domain model: campaign and entitlement lifecycles, **operator → reviewer → final approver**, draft vs. live data, synchronous APIs vs. asynchronous bulk processing, reporting and large-volume operations.
- **PerkPilot** productizes the same class of capabilities as a **multi-tenant SaaS entitlement cloud** for **multiple financial institutions** (or other licensed / quasi-financial customers), each with an isolated tenant space, on a unified stack and delivery pipeline.

### 1.2 Problems to solve

- Multiple legal entities manage **entitlement allowlists, card bundles, and campaign configuration** on one platform, with **CRUD, bulk import/export, reporting**, and auditable approval chains.
- Meet multi-tenant isolation and commercial delivery baselines for **data, permissions, secrets, and observability**, running on **AWS** with **CI/CD**.

---

## 2. Positioning and goals

### 2.1 One-line positioning

**PerkPilot: a multi-tenant entitlement and marketing operations platform for financial institutions; each tenant keeps HQ / branch / final-approval style workflows, while the platform provides unified identity, isolated data, and repeatable release engineering.**

### 2.2 Goals (initial scope may be trimmed)

| Dimension | Goal (initial) |
|-----------|----------------|
| Multi-tenant | Clear per-tenant data and configuration boundaries; cross-tenant access denied by default |
| Identity & RBAC | Tenant-scoped RBAC; integrate with a single IdP approach (finalized in system design) |
| Product | Allowlists, bundles, configuration CRUD; bulk jobs with status; reports / exports |
| Engineering | **CI/CD** on the main line; tiered environments (e.g. dev / staging / prod); SemVer |
| Compliance narrative | Audit fields; no secrets in repo; residency called out in architecture |

---

## 3. Terminology and tenant model

### 3.1 Tenant

- A **tenant** is one **independent financial institution or contracting party** (examples: **TD Bank** and **BMO** as two tenants — illustrative only, no affiliation).
- The tenant is the root of **billing, data isolation, and audit boundaries**.

### 3.2 Tenant account vs. signed-in users

- **Tenant space**: after onboarding, the institution receives a tenant identifier (`tenant_id` / slug — see data design).
- **Tenant root / org entry**: the institution’s administrative boundary (colloquially “TD admin account”); implementations should separate **tenant entity** from **natural-person user accounts**.
- **Signed-in users** belong to a tenant (or to platform operations) and hold roles and permissions.

### 3.3 Relationship to CLRP (conceptual)

| CLRP (single bank) | PerkPilot (multi-tenant SaaS) |
|--------------------|-------------------------------|
| Single bank org tree | Per-tenant org and workflow templates |
| Internal role names | Configurable roles per tenant; product prefers **org-meaningful** names (see below) |

> Note: engineering memories of CLRP live in local **`CLRP.MD`** (git-ignored); this charter does not restate proprietary internals.

---

## 4. Users and roles (RBAC)

### 4.1 Principles

- Do **not** use ambiguous **“level-1 review / level-2 review”** alone as primary role names; express order as **branch reviewer → HQ reviewer → final approver** or an explicit **L1/L2/L3** mapping table.
- In CLRP, **“level-1”** referred to **branch-level operators** (“branch tier-1 operator”), i.e. an **operator tier**, not “first review tier”.

### 4.2 Recommended tenant roles

| Role (Chinese) | English / code | Summary |
|----------------|----------------|---------|
| Tenant system admin | `TENANT_SYSTEM_ADMIN` | Users, roles, integration settings, workflow template binding |
| HQ operator | `HQ_OPERATOR` | Initiates entitlement/campaign changes; form or spreadsheet submit |
| HQ reviewer | `HQ_REVIEWER` | Reviews HQ operator submissions |
| Branch operator | `BRANCH_OPERATOR` | Optional; appears when the “branch chain” is enabled |
| Branch reviewer | `BRANCH_REVIEWER` | Branch-side review (**not** recommended as “level-1 review”) |
| Final approver | `FINAL_APPROVER` | After approval, changes move to live / async processing |

For international tenants, UI copy may use **Branch / HQ / Final** mapped to the Chinese role names.

### 4.3 Approval templates

**Template A — HQ only**

`HQ operator → HQ reviewer → Final approver → (go-live: synchronous API or async pipeline)`

**Template B — Branch + HQ**

`Branch operator → Branch reviewer → HQ reviewer → Final approver → (go-live)`

State machines, draft tables, and live tables are finalized in **System design**.

---

## 5. Core product flows

- **Configuration**: entitlement allowlists, card bundles, campaign CRUD.
- **Bulk**: uploads, async jobs, progress, downloadable results.
- **Reporting / exports**: scheduled or on-demand; large exports constrained in architecture / data docs.
- **Audit**: key actions include `tenant_id`, actor, object, timestamp (field-level policy TBD).

---

## 6. Scope

### 6.1 In scope (initial bias)

- Multi-tenant **B2B operations console** first; cardholder C-end can follow later.
- Identity, tenant context, RBAC, core APIs, persistence, baseline observability.
- **CI/CD** and at least one demo-grade environment.

### 6.2 Out of scope (unless separately chartered)

- Full **core banking ledger / clearing** integration per tenant (treat as external boundary).
- Full regulatory reporting suites (extension points may be reserved).

---

## 7. Non-functional requirements (summary)

- **Security**: least privilege; no secrets in repo; enforced tenant isolation.
- **Availability**: single-region MVP acceptable; production SLOs defined in architecture.
- **Compliance**: data minimization, log redaction, residency (especially for multi-region FIs) in architecture review.

---

## 8. Technology and deployment (summary)

### 8.1 Front/back separation and first UI

- **Separated frontend and backend**: browser **SPA** vs. backend **API** (separate repos or build artifacts); first delivery is a **web app** (desktop browser first).
- **Frontend (mainstream stack)**: **TypeScript + React**, **MUI**, **Redux Toolkit**; integrates with the backend over **HTTPS + REST (JSON)** (contracts in API docs).

### 8.2 Backend and integration

- **Language & build**: **Java 21** (LTS); **Maven**.
- **Framework**: **Spring Boot 3.x**, **Spring Security**, optional **Spring Session Redis**.
- **Persistence (decided)**: **MyBatis-Plus**; complex SQL and multi-table work primarily in **Mapper XML**, consistent with CLRP. **Spring Data JPA** (learned academically) is **not** part of the v1 persistence stack to avoid **JPA + MyBatis** dual-stack complexity—even simple CRUD stays in MyBatis-Plus.
- **Schema migrations (decided)**: **Flyway** (see **`docs/data/database-design.md`**).
- **Batch processing (direction)**: **Spring Batch** (Java) plus **Kafka**-driven async pipelines; v1 **does not introduce a Python** runtime for bulk upload/reprocessing.
- **Messaging**: **Apache Kafka** (bulk jobs, progress/state events, and domain events; recommend `tenant_id` in partition keys; topics/consumer groups in **system design**).
- **Service vs. messaging boundary (decided)**: **RESTful HTTP + JSON** between services; **Kafka** for **domain events and bulk pipelines**, not as a generic RPC bus (see **`docs/architecture/system-design.md`**).

### 8.3 Database and portability

- **RDBMS**: **PostgreSQL** for dev and local runs; cloud target **Amazon Aurora PostgreSQL** (wire-compatible). Switch via **configuration/profiles** and externalized secrets—no hard-coded hosts—so the framework runs locally first, then moves to AWS.

### 8.4 Containerization

- **Full containerization strategy** (Docker / Compose / cloud orchestration): **under discussion**; local MVP may start “runnable” then converge on Compose or cloud images (see **`docs/engineering/release-and-cicd.md`**).

### 8.5 Cloud and engineering

- **AWS**: identity, network, data, object storage, observability, pipelines (mapped in system design).
- **CI/CD**: see `docs/engineering/release-and-cicd.md`.

### 8.6 Testing and load testing

- **Load & concurrency testing (decided)**: **Apache JMeter** as the primary tool for HTTP/API scenarios (plans, scenarios, reporting—continuing CLRP-era practice).
- **Automated testing (baseline)**: start from **JUnit 5**; integration tests that need PostgreSQL / Kafka should prefer **Testcontainers** (expanded in engineering/CI docs).

---

## 9. CI/CD and versioning

- **SemVer**: `MAJOR.MINOR.PATCH`; breaking API changes bump MAJOR.
- Pipeline stages, branching, and environment promotion: **`docs/engineering/release-and-cicd.md`**.

---

## 10. Related documents and open decisions

| Document | Path | Status |
|----------|------|--------|
| Documentation policy (ZH/EN sync) | [DOCUMENTATION-POLICY.md](../DOCUMENTATION-POLICY.md) | Active |
| Chinese documentation hub | [README.md](../README.md) | Living |
| English documentation hub | [README.md](./README.md) | Living |
| System design | [architecture/system-design.md](./architecture/system-design.md) | Skeleton |
| API conventions | [api/conventions.md](./api/conventions.md) | Skeleton |
| Database design | [data/database-design.md](./data/database-design.md) | Partially decided (persistence + Flyway) |
| Release & CI/CD | [engineering/release-and-cicd.md](./engineering/release-and-cicd.md) | Skeleton |
| ADRs | [adr/README.md](./adr/README.md) | Template |

**Typical items to decide next**: tenant signup and billing, approval state fields, OpenAPI location, **table prefixes and domain packaging**, AWS account boundaries per environment, SLO / alert thresholds, **containerization scope and local orchestration**.

---

## Revision history

| Version | Date | Description |
|---------|------|-------------|
| 0.1.0 | 2026-05-12 | First charter: background, tenant/roles, templates, scope, doc map |
| 0.1.1 | 2026-05-12 | Linked bilingual documentation policy; English mirror path |
| 0.1.3 | 2026-05-12 | Decided: Java 21 + Maven; MyBatis-Plus (XML) + Flyway; Spring Batch + Kafka; REST + Kafka boundary; JMeter load testing; no Python in v1 |
