# 系统设计（System Design）

> **Languages**: 中文（本页） | [English](../en/architecture/system-design.md)  
> **Policy**: [文档维护策略](../DOCUMENTATION-POLICY.md)

| 字段 | 内容 |
|------|------|
| 版本 | 0.1.3（骨架） |
| 关联 | [立项书](../project-charter.md) |

---

## 1. 系统上下文（C4 Context）

> **待补**：系统与 **终端用户、租户管理员、外部合作方、身份提供方、观测平台** 的上下文图（建议 Mermaid 或附图）。

---

## 2. 逻辑视图

### 2.1 主要组件

> **待补**：BFF/API、领域服务、批处理、消息消费者、报表任务等与租户的边界。

### 2.2 租户上下文传播

> **待补**：请求进入后 `tenant_id` 的来源（JWT claim / session）、在异步与批任务中的传递方式（`TaskDecorator`、Job 参数等）。

### 2.3 前后端分离（已定方向）

- **浏览器 SPA**：**TypeScript + React**（MUI、Redux Toolkit）仅通过 **HTTPS** 访问后端 **REST API**；不直连数据库或 Kafka。
- **首阶段**：**网页端**（桌面浏览器）；移动端/小程序等后续迭代。

### 2.4 消息传递与服务间通信（与立项书对齐）

| 用途 | 当前方向 | 说明 |
|------|----------|------|
| **批量处理、异步管道、进度/状态事件、领域事件** | **Apache Kafka** | 与 CLRP「表格上传 → MQ」同类能力对齐；主题、分区键（建议含 `tenant_id`）、消费者组、重试/DLQ **待 ADR 细化** |
| **服务间同步调用（即时）** | **已定：RESTful HTTP + JSON** | 与《项目立项书》一致；**Kafka 不作为 RPC 总线**。首版不默认引入 **gRPC**；若未来需要再由 ADR 论证 |

### 2.5 关系型数据库可移植性

- **PostgreSQL** 为本地与开发默认；**Amazon Aurora PostgreSQL** 为 AWS 目标；通过 **Spring profile / 环境变量** 切换 JDBC URL，**同一套 Flyway 迁移脚本** 上线（**已定稿**：不使用 Liquibase，除非 ADR 另行替换）。

---

## 3. 物理视图与 AWS 映射（草案）

### 3.1 进程、依赖中间件与容器化（讨论稿）

- **本地优先**：目标为「克隆仓库即可在本机启动框架」。**PostgreSQL** 与 **Kafka** **推荐**通过 **Docker / Docker Compose** 容器化运行，以降低环境差异、贴近 CI；应用进程首版可仍为 **本机 JVM**（不必首版即容器化应用镜像）。
- **迁至 AWS（须预留）**：同一套应用通过 **配置与密钥注入** 切换至 **Amazon Aurora PostgreSQL**、**Amazon MSK**（或经评审的等效云上 Kafka 拓扑）等；**禁止**把「只能连本机 localhost 裸端口」写死在业务代码路径中。
- **云上应用打包**：Elastic Beanstalk **可执行 JAR** vs **容器镜像**（Docker → ECS/EKS 等）仍 **待 ADR**；与观测、发布频率、团队运维习惯相关。
- **仓库内 Compose**：是否提供标准 `docker-compose.yml`（Postgres+Kafka+可选 Redis）在实现阶段与 **`docs/engineering/release-and-cicd.md`** 对齐落地。

> **待补**：VPC、负载均衡、Elastic Beanstalk（或容器）、Aurora PostgreSQL、ElastiCache、S3、KMS、Secrets Manager、Cognito、CloudFront、CloudWatch、CodePipeline 等与组件的对应表。

---

## 4. 安全设计

> **待补**：认证与授权、租户隔离、密钥轮换、审计日志、速率限制与 WAF（若采用）。

---

## 5. 非功能需求（执行摘要）

> **待补**：目标 RPS、批延迟、数据保留、备份策略引用 `engineering` 或独立 NFR 文档。

---

## 6. 审批与生效（领域设计占位）

> **待补**：与立项书中 **模板 A/B** 对齐的状态机、草稿与正式数据存储策略、同步 API 与异步管道边界。

---

## 修订记录

| 版本 | 日期 | 说明 |
|------|------|------|
| 0.1.1 | 2026-05-12 | 增加英文镜像与文档维护策略链接 |
| 0.1.2 | 2026-05-12 | 前后端分离、Kafka 批量、PostgreSQL/Aurora 可移植、容器化讨论中 |
| 0.1.3 | 2026-05-12 | 与立项书对齐：同步 REST、仅 Flyway；本地 Postgres/Kafka 推荐 Compose、预留 AWS Aurora/MSK 路径 |
