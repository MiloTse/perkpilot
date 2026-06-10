# API 约定（API Conventions）

> **Languages**: 中文（本页） | [English](../en/api/conventions.md)  
> **Policy**: [文档维护策略](../DOCUMENTATION-POLICY.md)

| 字段 | 内容 |
|------|------|
| 版本 | 0.1.1（骨架） |
| 关联 | [立项书](../project-charter.md) |

---

## 1. 风格与协议

- **协议**：HTTPS 上的 **REST + JSON**（除非 ADR 另有规定）。
- **Base path**：`/api/v{major}`（**待确认** 是否采用 `/v1` 扁平路径）。

---

## 2. 认证与租户

> **待补**：`Authorization: Bearer` 与 **Cognito**（或选定 IdP）的对应关系；**禁止**客户端随意传 `X-Tenant-Id` 覆盖 JWT 中的租户（服务端校验策略）。

---

## 3. 错误模型

> **待补**：统一错误结构（如 `code`, `message`, `requestId`）；HTTP 状态码与业务错误码表。

---

## 4. 分页与筛选

> **待补**：`cursor` vs `page/size`；默认排序；租户内资源命名空间。

---

## 5. OpenAPI 契约

| 项 | 计划 |
|----|------|
| 契约文件位置 | `docs/api/openapi.yaml` **或** 由后端构建生成至 `backend/build/...`（**待 ADR**） |
| 校验 | CI 中 `spectral` / `openapi-diff`（可选） |

---

## 6. 版本策略

- **URL 主版本**：破坏性变更升 `v2`。
- **弃用**：`Deprecation` 头与文档公告（**待补** 周期）。

---

## 修订记录

| 版本 | 日期 | 说明 |
|------|------|------|
| 0.1.1 | 2026-05-12 | 增加英文镜像与文档维护策略链接 |
