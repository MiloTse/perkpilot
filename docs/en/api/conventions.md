# API Conventions

> **Languages**: [中文](../../api/conventions.md) | English (this page)  
> **Policy**: [Documentation policy](../../DOCUMENTATION-POLICY.md)

| Field | Content |
|-------|---------|
| Version | 0.1.1 (skeleton) |
| Related | [Project charter](../project-charter.md) |

---

## 1. Style and protocol

- **Protocol**: **REST + JSON** over HTTPS (unless an ADR says otherwise).
- **Base path**: `/api/v{major}` (**TBD**: flat `/v1` alternative).

---

## 2. Authentication and tenant context

> **TBD**: `Authorization: Bearer` vs. **Cognito** (or chosen IdP); forbid clients from overriding JWT tenant via arbitrary `X-Tenant-Id` (server-side validation).

---

## 3. Error model

> **TBD**: Uniform error body (`code`, `message`, `requestId`, …); HTTP status vs. business error codes.

---

## 4. Pagination and filtering

> **TBD**: `cursor` vs. `page/size`; default sort order; per-tenant resource namespaces.

---

## 5. OpenAPI contract

| Item | Plan |
|------|------|
| Contract file | `docs/api/openapi.yaml` **or** generated under `backend/build/...` (**ADR**) |
| Validation | Optional `spectral` / `openapi-diff` in CI |

---

## 6. Versioning

- **URL major version**: bump to `v2` for breaking changes.
- **Deprecation**: `Deprecation` header and release notes (**TBD** timeline).

---

## Revision history

| Version | Date | Description |
|---------|------|-------------|
| 0.1.0 | 2026-05-12 | Skeleton |
| 0.1.1 | 2026-05-12 | Bilingual links and documentation policy reference |
