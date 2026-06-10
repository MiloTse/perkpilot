# PerkPilot 文档中心

> **Languages**: 中文（本页） | [English](./en/README.md)  
> **Policy**: 中英文须同步更新 — [文档维护策略](./DOCUMENTATION-POLICY.md)

本目录存放**正式商业项目**从立项、设计、实现到交付与迭代所需的文档。文档与代码同源，随版本演进；重大决策记入 [ADR](./adr/)。**正式 Markdown** 默认提供 **中文**（`docs/`）与 **英文**（`docs/en/`）镜像；修改须 **同提交双语对齐**（见策略文件）。

---

## 1. 文档地图（按阅读顺序）

| 顺序 | 文档 | 说明 |
|------|------|------|
| 0 | [DOCUMENTATION-POLICY.md](./DOCUMENTATION-POLICY.md) | **文档维护策略**：中英文同提交、路径镜像、`docs/en/` 约定 |
| 1 | [project-charter.md](./project-charter.md) | **项目立项书**：背景、租户/角色、范围、目标与非功能摘要 |
| 2 | [architecture/system-design.md](./architecture/system-design.md) | **系统设计**：上下文、逻辑/物理视图、安全、AWS 映射（定稿中） |
| 3 | [data/database-design.md](./data/database-design.md) | **数据设计**：命名规范、逻辑/物理模型、迁移策略（定稿中） |
| 4 | [api/conventions.md](./api/conventions.md) | **API 约定**：URL/版本、错误模型、认证；OpenAPI 契约位置（定稿中） |
| 5 | [engineering/release-and-cicd.md](./engineering/release-and-cicd.md) | **发布与 CI/CD**：分支、环境、流水线、版本号规则 |
| — | [adr/README.md](./adr/README.md) | **ADR**：架构决策记录索引与模板 |

---

## 2. 标准软件工程中还常见的文档（按需启用）

下列项在**中大型企业或强合规**交付中常见；PerkPilot 可按阶段引入，避免一开始就过重。

| 类型 | 典型文件名/位置 | 用途 |
|------|-----------------|------|
| 产品需求 / PRD | `docs/product/prd.md` 或工单系统 | 功能优先级、验收标准 |
| 用户故事 / 史诗 | 项目管理工具（Jira 等） | 迭代计划与追溯 |
| 威胁建模 | `docs/security/threat-model.md` | STRIDE、信任边界、控制措施 |
| 隐私与数据分类 | `docs/security/data-classification.md` | PII、保留期、跨境 |
| 运维与灾备 | `docs/engineering/runbook.md` | 告警响应、回滚、RTO/RPO |
| 测试策略 | `docs/quality/test-strategy.md` | 金字塔、覆盖率门禁、E2E（Cypress）与 DAST（ZAP）策略 |
| 非功能需求详单 | `docs/architecture/nfr.md` | 性能、容量、配额 |
| OpenAPI 契约 | `docs/api/openapi.yaml`（或 `backend/...` 生成物） | 前后端契约、Mock、网关 |

**当前策略**：在 `docs/` 下仅建立**立项 + 设计/数据/API/工程**主骨架；上表其余项在评审后按需新增文件。

---

## 3. 与仓库其他位置的约定（建议）

| 内容 | 建议位置 |
|------|----------|
| 基础设施即代码 | `infra/`（与 `docs/architecture` 交叉引用） |
| 可执行契约测试 | `backend` / `frontend` 内测试目录 + CI 配置 |
| 流水线定义 | `.github/workflows/` 与/或 `infra` 中 CodePipeline 描述 |

---

## 4. 下一步（需讨论后补全）

- [ ] 租户 onboarding（注册、首个管理员、试用/计费）是否纳入 v0
- [ ] 认证方案定稿（Cognito vs 其他）与 **JWT claim 中 `tenant_id`**
- [ ] 审批状态机与草稿/正式表策略（对齐立项书中的模板 A/B）
- [ ] OpenAPI 单源位置与是否由代码注解生成
- [ ] 环境矩阵（dev / staging / prod）与 AWS 账号/区域

---

## 修订记录

| 日期 | 说明 |
|------|------|
| 2026-05-12 | 增加 `docs/en/` 英文镜像、《文档维护策略》与 Cursor 双语规则 |
