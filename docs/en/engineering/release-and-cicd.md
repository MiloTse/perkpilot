# Release & CI/CD

> **Languages**: [中文](../../engineering/release-and-cicd.md) | English (this page)  
> **Policy**: [Documentation policy](../../DOCUMENTATION-POLICY.md)

| Field | Content |
|-------|---------|
| Version | 0.1.2 (skeleton) |
| Related | [Project charter](../project-charter.md) |

---

## 1. Versioning (SemVer)

- **MAJOR**: incompatible API or coordinated breaking migrations.
- **MINOR**: backward-compatible features.
- **PATCH**: fixes and small compatible improvements.

Align release artifacts and images with Git tags, e.g. `v1.2.3`.

---

## 2. Branching strategy (TBD)

| Option | When it fits |
|--------|----------------|
| **Trunk-based** + short-lived feature branches | Small team, frequent integration |
| **Simplified Git Flow** (`main` + `develop`) | Fixed release windows |

> **TBD**: chosen model, merge gates, who may tag releases.

---

## 3. CI pipeline stages (recommended)

| Stage | Content |
|-------|---------|
| Lint / format | Static checks for front and back ends |
| Unit tests | JUnit / Jest, etc. |
| Build | Backend JAR / frontend bundle |
| Contract | OpenAPI checks (when enabled) |
| SAST / dependencies | Optional (Dependabot, OWASP Dependency-Check) |
| E2E | Cypress (nightly or pre-merge — **TBD**) |
| DAST | ZAP baseline on staging (**TBD** cadence) |

---

## 4. CD and environment promotion

| Environment | Purpose | AWS target |
|-------------|---------|------------|
| dev | Integration | **TBD** (local / single EB) |
| staging | Pre-prod, demos, security scans | **TBD** |
| prod | Production | **TBD** |

> **TBD**: CodePipeline vs. GitHub Actions, Elastic Beanstalk app names, DB migration ordering in CD (expand/contract, etc.).

---

## 5. Change management and rollback

> **TBD**: Blue/green vs. rolling; DB rollback; feature flags.

---

## 6. Release notes

> **TBD**: Template location (e.g. `.github/release.yml` or `CHANGELOG.md`) and owner.

---

## 7. Local development, Kafka, and containerization (draft)

- **Local-first**: target “clone and run” with backend + frontend + PostgreSQL + **Kafka**; brokers via **local install** and/or **Docker / Compose** (**ADR TBD**).
- **Kafka**: aligned with bulk/async pipelines; single broker acceptable locally; cloud may use **MSK** or self-managed (**TBD**).
- **Containerization scope**: options include (a) containerize dependencies only, apps as local processes; (b) **Compose** for full stack; (c) cloud **Elastic Beanstalk JAR** vs **container image**. **Not mandatory** to containerize everything in v1—decide via ADR with team skill and CI cost.

---

## Revision history

| Version | Date | Description |
|---------|------|-------------|
| 0.1.0 | 2026-05-12 | Skeleton |
| 0.1.1 | 2026-05-12 | Bilingual links and documentation policy reference |
| 0.1.2 | 2026-05-12 | Local dev, Kafka, containerization discussion and open items |