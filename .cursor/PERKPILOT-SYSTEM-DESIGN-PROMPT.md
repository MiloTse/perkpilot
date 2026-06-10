# PerkPilot 系统设计上下文（AI Prompt）

> **用途**：在新对话中 `@.cursor/PERKPILOT-SYSTEM-DESIGN-PROMPT.md` 或粘贴本文件，让 AI 延续本项目的业务与技术共识。  
> **与正式文档关系**：`docs/` 下为可评审的正式文档（中英同步）；本文件汇总**讨论阶段已定 + 讨论中倾向 + 待你拍板项**，更新频率高于 `docs/`。  
> **更新约定**：讨论定稿后，由你明确指令「写入 `docs/...`」再改正式文档；AI 不得擅自改 `docs/`。

---

## 1. 项目一句话

**PerkPilot**：面向多家金融机构的 **多租户 SaaS 权益与营销运营平台**；租户内保留 CLRP 式 **经办—复核—终审** 与分行链；平台侧统一身份、数据隔离与可重复交付（AWS + 本地 Compose 可切换）。

---

## 2. 业务背景（与 CLRP 对照）

| CLRP（中行内部、单法人） | PerkPilot（多租户产品） |
|--------------------------|-------------------------|
| 单一银行组织树 | **租户** = 签约金融机构（例：TD、BMO，仅作说明） |
| 总行经办 / 分行一级经办 / 复核 / **终审** | 租户内角色：`HQ_OPERATOR`、`BRANCH_OPERATOR`、`HQ_REVIEWER`、`BRANCH_REVIEWER`、`FINAL_APPROVER`、`TENANT_SYSTEM_ADMIN` |
| 审批模板 A（总行链）、B（分行+总行） | 同上，可配置流程模板 |
| 同步 API 生效 + Kafka 表格批量 + Spring Batch 报表/大批量 | **两条批量线分离**（见 §4） |
| 分库分表 + 三 app-service 按客户号路由 | **讨论中**：v1 可能单库多租户，路由抽象预留；须 **tenant_id + customer_no** |

本地 CLRP 工程回忆：**`CLRP.MD`**（仓库根目录，**git 忽略**，勿提交）。

---

## 3. 已定技术栈（实现向）

| 类别 | 选型 |
|------|------|
| JDK | **Java 21** |
| 构建 | **Maven**（多模块 Monorepo 倾向） |
| 后端框架 | **Spring Boot 3.x**、**Spring Security**、**MyBatis-Plus**（复杂 SQL 以 **Mapper XML** 为主） |
| 持久迁移 | **Flyway**（不用 Liquibase，除非 ADR 替换） |
| 不用 | **Spring Data JPA** 作为 v1 主持久栈；**Python** v1 批量 |
| 数据库 | **PostgreSQL** 本地/dev；云上 **Aurora PostgreSQL**（配置切换，无 localhost 写死） |
| 缓存/幂等辅助 | **Redis**（从首版引入：缓存、分布式锁、**幂等门闩**；与 **DB 唯一约束** 双保险） |
| 消息 | **Apache Kafka**（事件、上传后异步管道；**不作 RPC**）；云上 **MSK** 路径预留 |
| 服务间同步 | **RESTful HTTP + JSON** |
| 批量（离线） | **Spring Batch**（**独立 jar / 独立进程**） |
| 批量（上传 Excel） | **App 内 Kafka 消费者** + 业务处理（≠ Batch 服务主职责） |
| 前端 | **TypeScript + React + MUI + Redux Toolkit**；首版 **Web SPA** |
| Web ↔ App | **REST** |
| 压测 | **Apache JMeter** |
| 测试基线 | **JUnit 5**、**Testcontainers**（Postgres/Kafka 等） |
| 对象存储 | **S3**；浏览器 **预签名直传**（已定方向） |
| 身份 | **Amazon Cognito**（登录一步到位，讨论定稿中） |

---

## 4. 逻辑架构（讨论共识）

### 4.1 同仓三服务（并列、可独立部署）

```
┌─────────────┐     REST      ┌──────────────────────────────────────┐
│  Web 服务    │ ────────────► │  App 服务（API）                       │
│  (SPA 静态)  │               │  - 鉴权、租户上下文、领域 API            │
└─────────────┘               │  - S3 预签名、登记任务、发 Kafka         │
                              │  - Kafka 消费：Web 上传 Excel 异步批量   │
                              │  - 可选：按客户号路由 → 3× app-service   │
                              └──────────────────────────────────────┘
                                              │
                    ┌─────────────────────────┼─────────────────────────┐
                    │                         │                         │
                    ▼                         ▼                         ▼
              PostgreSQL                  Redis                     Kafka
                    ▲
                    │
┌───────────────────┴───────────────────┐
│  Batch 服务（独立 jar / 独立进程）      │
│  - Spring Batch：跨分库分表扫数、报表等  │
│  - 与「上传 Excel → Kafka」不是同功能线   │
│  - 触发：调度 / 参数化 Job（非 Kafka 主路径）│
└───────────────────────────────────────┘
```

### 4.2 App 内「三 app-service」路由（CLRP 思路）

- 单一 **App** 工程内可有 **Controller 统一入口**；**Service 层** 按 **`tenant_id` + 客户号** 路由到 **app-service-1/2/3**（对应分库分表段）。
- **v1 是否物理分库**：待定；可先逻辑抽象 + 单库 `tenant_id`。

### 4.3 两条「批量」边界（勿混）

| 线 | 触发 | 技术 | 典型场景 |
|----|------|------|----------|
| **在线异步批量** | Web 上传 Excel → S3 → 登记 → **Kafka 小消息** | App 内消费者 +（可选）写 staging 表 | 运营上传、进度查询、结果下载 |
| **离线批处理** | 调度 / Batch 参数 | **Batch 独立服务** + Spring Batch | 夜间报表、跨分片大批量变更 |

**Kafka 消息体**：仅 **指针 + 元数据**（`tenantId`, `jobId`, `s3Bucket`, `s3Key`, `checksum`, `correlationId` 等），**不放文件内容**。

**幂等**：**Redis `SET NX` + TTL** 作短期门闩；**DB 唯一键**（如 `tenant_id + upload_id`）兜底；**不默认**引入 FIFO SQS（除非 ADR 双 MQ）。

---

## 5. 身份、租户与安全（讨论倾向）

| 主题 | 倾向/已定 |
|------|-----------|
| Cognito 用户池 | **倾向双池**：租户用户池 + 平台运营池（待你拍板） |
| `tenant_id` 权威来源 | **仅信验签后的 JWT claim**（或 group→租户映射） |
| 子域名 | **可选辅助**：要求 JWT 中 `tenant_id` 与租户 slug 一致，**不能单独作为权威** |
| `X-Tenant-Id` | **不信任**浏览器随意传入 |
| 租户上下文 | Filter 设 `TenantContext`（线程级）；**Kafka/Batch/Async 须显式传递** `tenantId` 并 finally 清理 |
| 日志强制字段 | **`tenantId` + `requestId` + `userId`** |
| 日志脱敏 | **v1 不做**；后续 pipeline 改造 |

---

## 6. 部署与可移植性（Cursor 规则摘要）

- 本地：**PostgreSQL + Kafka（+ Redis）推荐 Docker Compose**；JVM 可先跑在宿主机。
- AWS：**Aurora + MSK**（或评审通过的 Kafka 拓扑）；**Secrets / profile** 切换，业务代码无 localhost-only。
- 详见：`.cursor/rules/perkpilot-deployment-portability.mdc`

---

## 7. 正式文档索引

| 文档 | 路径 |
|------|------|
| 立项书 | `docs/project-charter.md` ↔ `docs/en/project-charter.md` |
| 系统设计 | `docs/architecture/system-design.md` ↔ `docs/en/architecture/...` |
| 数据设计 | `docs/data/database-design.md` |
| 文档双语策略 | `docs/DOCUMENTATION-POLICY.md` |

---

## 8. 给 AI 的工作方式

1. **讨论阶段**：只给建议与选项，**不**自动改 `docs/`，除非用户说「写入文档/立项书/系统设计」。  
2. **写文档时**：中文 `docs/` 与英文 `docs/en/` **同一次变更同步**（`DOCUMENTATION-POLICY.md`）。  
3. **CLRP** 细节查本地 `CLRP.MD`，勿提交 git。  
4. **迭代原则**：竖切功能，先跑通再扩展；避免一次引入 Python、双 MQ、gRPC、物理分库 unless 用户明确要求。

---

## 9. 待拍板清单（供下一轮讨论）

见对话中向用户提出的问题；拍板后更新本文件 §9 或指令写入 `docs/`。

---

## 修订记录

| 日期 | 说明 |
|------|------|
| 2026-05-12 | 初版：汇总立项书 + 架构讨论（三服务、Redis 幂等、Cognito/租户、Kafka vs Batch、S3 预签名） |
