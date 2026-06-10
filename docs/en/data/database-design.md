# Database Design

> **Languages**: [中文](../../data/database-design.md) | English (this page)  
> **Policy**: [Documentation policy](../../DOCUMENTATION-POLICY.md)

| Field | Content |
|-------|---------|
| Version | 0.1.3 (skeleton) |
| Related | [Project charter](../project-charter.md), [System design](../architecture/system-design.md) |

---

## 1. Design principles

- **Multi-tenancy**: business tables include **`tenant_id`** (type and indexing **TBD**).
- **Soft delete & audit**: `created_at` / `updated_at` / `deleted_at` / `created_by` (**TBD**).
- **Naming**: `snake_case`; optional domain prefixes (`ent_`, `acct_`, …) **TBD**.
- **Persistence (decided)**: **MyBatis-Plus**; complex SQL and joins primarily in **Mapper XML**, aligned with CLRP. **Spring Data JPA** is **not** in the v1 persistence stack to avoid dual ORM/mapper stacks.
- **Schema migrations (decided)**: **Flyway** for all versioned DDL/DML (business tables and **Spring Batch** `BATCH_*` metadata); script layout and naming conventions to be finalized during implementation.

---

## 2. Logical model (placeholder)

> **TBD**: ER for tenants, users, roles, permissions, entitlements, allowlists, bundles, approval instances, bulk jobs, audit logs, or link to diagramming tool.

---

## 3. Physical model and migrations

- **DBMS**: **PostgreSQL** by default for local and dev (**Amazon Aurora PostgreSQL** on AWS is wire-compatible so the same app switches via **configuration**, without SQL dialect changes).
- **First milestone**: a **runnable-on-laptop** baseline (PostgreSQL via local install or Docker).
- **Migration tool**: **Flyway** (Spring Boot integration; works alongside MyBatis-Plus). **Liquibase is not used** unless an ADR replaces Flyway later.
- **Spring Batch**: if enabled, metadata tables are created/changed **via Flyway**; ordering and rollback with business migrations TBD during implementation.
- **Environments**: strategy for dev / staging / prod databases or schemas **TBD**.

---

## 4. Approval / draft tables (placeholder)

> **TBD**: Draft table vs. versioning vs. status columns; go-live after `FINAL_APPROVER`.

---

## 5. Indexing and partitioning (placeholder)

> **TBD**: Composite uniqueness `(tenant_id, …)`; partitioning strategy (by tenant or time) as needed.

---

## Revision history

| Version | Date | Description |
|---------|------|-------------|
| 0.1.0 | 2026-05-12 | Skeleton |
| 0.1.1 | 2026-05-12 | Bilingual links and documentation policy reference |
| 0.1.3 | 2026-05-12 | Decided: MyBatis-Plus (XML) + Flyway; Spring Batch metadata via Flyway |
