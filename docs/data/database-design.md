# 数据库设计（Database Design）

> **Languages**: 中文（本页） | [English](../en/data/database-design.md)  
> **Policy**: [文档维护策略](../DOCUMENTATION-POLICY.md)

| 字段 | 内容 |
|------|------|
| 版本 | 0.1.3（骨架） |
| 关联 | [立项书](../project-charter.md)、[系统设计](../architecture/system-design.md) |

---

## 1. 设计原则

- **多租户**：业务表默认包含 **`tenant_id`**（类型与索引策略 **待定**）。
- **软删除与审计**：`created_at` / `updated_at` / `deleted_at` / `created_by`（**待确认**）。
- **命名**：`snake_case`；表名前缀是否按域划分（如 `ent_`、`acct_`）**待讨论**。
- **持久层（已定稿）**：**MyBatis-Plus**；复杂 SQL、多表关联以 **Mapper XML** 为主，与 CLRP 实践一致。首版不引入 **Spring Data JPA** 持久栈，避免与 MyBatis 双栈并存。
- **Schema 迁移（已定稿）**：**Flyway** 管理全库版本化变更（业务表与 **Spring Batch** 元数据表 `BATCH_*` 等均通过迁移脚本落库）；脚本目录、命名前缀与「可重复/可校验」规范在实现阶段细化。

---

## 2. 逻辑模型（占位）

> **待补**：租户、用户、角色、权限、权益定义、白名单、卡包、审批实例、批量任务、审计日志等 ER 描述或链接到图表工具。

---

## 3. 物理模型与迁移

- **DBMS**：**PostgreSQL**（本地与开发默认；与 **Amazon Aurora PostgreSQL** 协议兼容，便于同一应用通过 **配置** 切换连接，无需改 SQL 方言）。
- **第一步目标**：在 **本机可运行** 的框架（嵌入式或 Docker PostgreSQL 均可）；云上连接串经 **Secrets Manager** 等注入（架构文档）。
- **迁移工具**：**Flyway**（与 Spring Boot 集成；与 MyBatis-Plus 无冲突）。Liquibase **不采用**（除非未来 ADR 另行取代）。
- **Spring Batch**：若启用批处理元数据表，其建表与变更 **纳入 Flyway 脚本**；与业务表的发布顺序、回滚策略在实现阶段细化。
- **环境**：dev / staging / prod 分库或分 schema 策略 **待定**。

---

## 4. 与审批/草稿相关的表（占位）

> **待补**：草稿表 vs 版本表 vs 状态字段；与 `FINAL_APPROVER` 通过后的落库策略。

---

## 5. 索引与分区（占位）

> **待补**：`(tenant_id, ...)` 复合唯一约束；大表分区策略（按租户或时间）**按需**。

---

## 修订记录

| 版本 | 日期 | 说明 |
|------|------|------|
| 0.1.1 | 2026-05-12 | 增加英文镜像与文档维护策略链接 |
| 0.1.3 | 2026-05-12 | 定稿：MyBatis-Plus（XML）+ Flyway；说明与 Spring Batch 元数据表关系 |
