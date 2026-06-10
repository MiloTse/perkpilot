# 架构决策记录（ADR）

> **Languages**: 中文（本页） | [English](../en/adr/README.md)  
> **Policy**: [文档维护策略](../DOCUMENTATION-POLICY.md)

本目录记录 **Architecture Decision Records**：**不可逆或高成本**的选型与边界，便于新成员与未来的自己理解「为什么这样设计」。

---

## 索引

| ADR | 标题 | 状态 |
|-----|------|------|
| — | （尚无） | — |

---

## 何时写 ADR

- 选择 **Cognito / 其他 IdP**、**JWT vs Session**、**OpenAPI 单源**、**Flyway vs Liquibase**、**多租户隔离级别** 等。
- 引入或弃用某条 **AWS 服务链路**（例如从 EB 迁到 EKS）时。

---

## 模板（复制为新文件 `NNNN-title.md`）

```markdown
# ADR NNNN: 标题

## 状态

提议 | 已接受 | 已取代 by ADR-XXXX

## 背景

## 决策

## 后果

## 备选方案
```

---

## 修订记录

| 日期 | 说明 |
|------|------|
| 2026-05-12 | 增加英文镜像与文档维护策略链接 |
