# System Design

> **Languages**: [中文](../../architecture/system-design.md) | English (this page)  
> **Policy**: [Documentation policy](../../DOCUMENTATION-POLICY.md)

| Field | Content |
|-------|---------|
| Version | 0.1.3 (skeleton) |
| Related | [Project charter](../project-charter.md) |

---

## 1. System context (C4 Context)

> **TBD**: Context diagram for **end users, tenant admins, external partners, IdP, observability**.

---

## 2. Logical view

### 2.1 Major components

> **TBD**: BFF/API, domain services, batch jobs, message consumers, reporting, and tenant boundaries.

### 2.2 Tenant context propagation

> **TBD**: Source of `tenant_id` (JWT claim / session), propagation in async and batch (`TaskDecorator`, job parameters, etc.).

### 2.3 Front/back separation (direction set)

- **Browser SPA**: **TypeScript + React** (MUI, Redux Toolkit) talks to the backend only over **HTTPS REST APIs**; no direct DB or Kafka access from the browser.
- **First phase**: **Web** (desktop browser); mobile / mini-programs later.

### 2.4 Messaging and inter-service communication (aligned with charter)

| Concern | Direction | Notes |
|---------|-----------|-------|
| **Bulk jobs, async pipelines, progress/state events, domain events** | **Apache Kafka** | Aligns with “upload → MQ” style flows; topics, partition keys (recommend including `tenant_id`), consumer groups, retries/DLQ — **ADR TBD** |
| **Synchronous service-to-service calls** | **Decided: RESTful HTTP + JSON** | Matches **Project charter**; **Kafka is not an RPC bus**. **gRPC** is **not** a v1 default; introduce only via ADR if needed |

### 2.5 Relational DB portability

- **PostgreSQL** locally and in dev; **Amazon Aurora PostgreSQL** on AWS; switch via **Spring profiles / env vars** and the **same Flyway migrations** (**decided**: no Liquibase unless an ADR replaces Flyway).

---

## 3. Physical view and AWS mapping (draft)

### 3.1 Processes, dependencies, and containerization (draft)

- **Local-first**: “clone and run” on a laptop. **PostgreSQL** and **Kafka** are **recommended** to run via **Docker / Docker Compose** for reproducibility and CI parity; the JVM app may stay on the host in early iterations (app containerization is not mandatory on day one).
- **AWS migration path (required)**: the same codebase must move to **Amazon Aurora PostgreSQL** and **Amazon MSK** (or an approved equivalent Kafka topology on AWS) using **configuration and secret injection**—**no** hard-coded “localhost-only” assumptions in business code paths.
- **Cloud packaging for the app**: **Elastic Beanstalk JAR** vs **container image** (Docker → ECS/EKS, etc.) remains **ADR TBD** (observability, cadence, team skills).
- **Compose in repo**: whether to ship a standard `docker-compose.yml` (Postgres + Kafka + optional Redis) is finalized alongside **`docs/engineering/release-and-cicd.md`**.

> **TBD**: Table mapping VPC, load balancers, Elastic Beanstalk (or containers), Aurora PostgreSQL, ElastiCache, S3, KMS, Secrets Manager, Cognito, CloudFront, CloudWatch, CodePipeline, etc.

---

## 4. Security design

> **TBD**: Authentication and authorization, tenant isolation, key rotation, audit logs, rate limits, WAF (if used).

---

## 5. Non-functional requirements (executive summary)

> **TBD**: Target RPS, batch latency, retention, backups — reference `engineering` or a dedicated NFR doc.

---

## 6. Approvals and go-live (domain placeholder)

> **TBD**: State machines aligned with charter **templates A/B**, draft vs. live storage, sync API vs. async pipeline boundary.

---

## Revision history

| Version | Date | Description |
|---------|------|-------------|
| 0.1.0 | 2026-05-12 | Skeleton |
| 0.1.1 | 2026-05-12 | Bilingual links and documentation policy reference |
| 0.1.2 | 2026-05-12 | Front/back split, Kafka for bulk, PostgreSQL/Aurora portability, containerization discussion |
| 0.1.3 | 2026-05-12 | Aligned with charter: REST sync, Flyway only; local Postgres/Kafka via Compose; AWS Aurora/MSK path reserved |