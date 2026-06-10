# 发布与 CI/CD（Release & CI/CD）

> **Languages**: 中文（本页） | [English](../en/engineering/release-and-cicd.md)  
> **Policy**: [文档维护策略](../DOCUMENTATION-POLICY.md)

| 字段 | 内容 |
|------|------|
| 版本 | 0.1.2（骨架） |
| 关联 | [立项书](../project-charter.md) |

---

## 1. 版本策略（SemVer）

- **MAJOR**：不兼容的 API 或数据迁移需协调的破坏性变更。
- **MINOR**：向后兼容的新功能。
- **PATCH**：缺陷修复与向后兼容的小改进。

应用镜像/构件版本建议与 Git **tag** 对齐，例如 `v1.2.3`。

---

## 2. 分支策略（待讨论定稿）

| 候选 | 适用 |
|------|------|
| **Trunk-based** + short-lived feature branches | 小团队、高频集成 |
| **Git Flow 简化版**（`main` + `develop`） | 需要固定发布窗口时 |

> **待补**：选定策略、合并门禁、谁可打 tag。

---

## 3. CI 流水线阶段（建议）

| 阶段 | 内容 |
|------|------|
| Lint / Format | 前后端静态检查 |
| Unit Test | JUnit / Jest 等 |
| Build | 后端 jar / 前端 bundle |
| Contract | OpenAPI 校验（启用后） |
| SAST / Dependency | 可选（Dependabot、OWASP Dependency-Check） |
| E2E | Cypress（夜间或合并前，**待确认**） |
| DAST | ZAP baseline on staging（**待确认** 频率） |

---

## 4. CD 与环境晋升

| 环境 | 用途 | 部署目标（AWS） |
|------|------|-----------------|
| dev | 开发联调 | **待定**（本地 / 单 EB） |
| staging | 预发、演示、安全扫描 | **待定** |
| prod | 生产 | **待定** |

> **待补**：CodePipeline 与 GitHub Actions 分工；Elastic Beanstalk 应用名；数据库迁移在 CD 中的顺序（**expand/contract** 等）。

---

## 5. 变更与回滚

> **待补**：蓝绿/滚动；数据库回滚策略；特性开关（Feature Flag）是否引入。

---

## 6. 发布说明（Release Notes）

> **待补**：模板位置（如 `.github/release.yml` 或 `CHANGELOG.md`）与责任人。

---

## 7. 本地开发、Kafka 与容器化（讨论稿）

- **本地可运行**：首阶段以「开发者本机启动后端 + 前端 + PostgreSQL + **Kafka**」为目标；中间件可 **本机安装** 或 **Docker / Docker Compose** 二选一或并存（**待 ADR**）。
- **Kafka**：与批量/异步流水线一致；本地可用 **单节点** broker；云上对接 **MSK** 或自建（**待定**）。
- **容器化范围**：选项包括（a）仅中间件容器化、应用仍本机进程；（b）**Compose 编排** 全栈；（c）云上 **EB JAR** vs **容器镜像**。**不强制**首版即全容器；与团队习惯与 CI 复杂度权衡后 ADR 定稿。

---

## 修订记录

| 版本 | 日期 | 说明 |
|------|------|------|
| 0.1.1 | 2026-05-12 | 增加英文镜像与文档维护策略链接 |
| 0.1.2 | 2026-05-12 | 增补本地开发、Kafka、容器化讨论与待定项 |