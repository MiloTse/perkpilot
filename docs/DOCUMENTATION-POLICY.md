# 文档维护策略：中英文同步

> **Languages**: 中文（本文件含上、下两节） | English（见下方 *Documentation policy* 章节）

---

## 1. 适用范围

凡位于 `docs/` 下、用于描述 PerkPilot 产品设计、架构、数据、API、工程与发布的 **Markdown 正式文档**（不含 `docs/en/` 目录本身作为「英文镜像根」），均须同时维护 **中文** 与 **英文** 两个版本。

| 语言 | 路径约定 | 说明 |
|------|------------|------|
| 中文 | `docs/**`（不含 `docs/en/**`） | 默认阅读路径；与仓库内中文协作者对齐 |
| 英文 | `docs/en/**` | 与中文 **同相对路径** 镜像，例如 `docs/project-charter.md` ↔ `docs/en/project-charter.md` |

**例外**：本文件 `DOCUMENTATION-POLICY.md` 采用 **单文件内中英双语文**，不另建 `docs/en/` 镜像，以免重复与循环引用。

本地仅备忘、且已 `.gitignore` 的文件（如根目录 `CLRP.MD`）**不要求**英文版。

---

## 2. 强制规则（与英文页一致）

1. **同一变更内双语更新**：修改、新增或删除某一中文文档时，必须在 **同一次提交（或同一 PR）** 内完成对对应英文文档的相同意图更新；反向亦然（先改英文则同步中文）。  
2. **版本与修订记录对齐**：若文档含 `版本`、`修订记录`、`CHANGELOG` 等元数据，两种语言文件应 **同版本号、同日期、等价说明**（允许语言润色，不允许事实分歧）。  
3. **新增文档**：在 `docs/` 新增任意正式 `.md` 时，须 **同时** 在 `docs/en/` 下创建镜像文件，并在两份文件顶部互链。  
4. **删除或重命名**：须对中英文路径 **同步** 重命名/删除，并更新所有站内链接。  
5. **图表与代码**：Mermaid、表结构、路径、接口名等 **技术事实** 两种语言须一致；仅自然语言翻译可不同。

---

## 3. 审阅建议

- PR 描述中可写：`Docs: ZH+EN synced` 便于评审者检查双语 diff。  
- 若仅一方可先行撰写，须在合并前补齐另一方，**禁止**长期单侧缺省。

---

## 4. 修订记录

| 版本 | 日期 | 说明 |
|------|------|------|
| 1.0.0 | 2026-05-12 | 首版：确立中英文须同提交更新、元数据对齐等原则 |
| 1.0.1 | 2026-05-12 | 建立 `docs/en/` 英文镜像与 Cursor 规则；明确本文件为单文件双语例外 |

---

# Documentation policy: Chinese / English parity

> **Languages**: [中文版](./DOCUMENTATION-POLICY.md) | English (this page)

---

## 1. Scope

All formal **Markdown** documentation under `docs/` that describes PerkPilot product, architecture, data, API, engineering, and releases MUST be maintained in **both Chinese and English**, excluding the `docs/en/` tree as the English mirror root itself.

| Language | Path convention | Notes |
|----------|-----------------|-------|
| Chinese | `docs/**` (excluding `docs/en/**`) | Default reading path for Chinese collaborators |
| English | `docs/en/**` | **Mirrors** the Chinese relative path, e.g. `docs/project-charter.md` ↔ `docs/en/project-charter.md` |

**Exception**: `DOCUMENTATION-POLICY.md` is **bilingual in a single file** and has **no** `docs/en/` mirror.

Local-only notes ignored by git (e.g. `CLRP.MD` at repo root) are **out of scope** for bilingual parity.

---

## 2. Mandatory rules

1. **Single change-set, both languages**: Any add/edit/delete to a Chinese page MUST include the equivalent update to the English counterpart in the **same commit or PR**, and vice versa.  
2. **Aligned metadata**: Version numbers, revision tables, and dates MUST match across both files (wording may differ; facts must not).  
3. **New documents**: Creating a new formal `.md` under `docs/` requires **simultaneously** creating the mirror under `docs/en/` and adding cross-links at the top of both.  
4. **Rename/delete**: Apply to **both** trees and fix all internal links.  
5. **Diagrams & code**: Mermaid, schemas, paths, and API names MUST be identical; only prose may differ by language.

---

## 3. Review hints

- PR title/description may include `Docs: ZH+EN synced` to signal bilingual review.  
- Do not merge long-lived **single-language** drift; complete the pair before merge.

---

## 4. Revision history

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2026-05-12 | Initial rules: same-change-set updates, aligned metadata |
| 1.0.1 | 2026-05-12 | Added `docs/en/` mirror and Cursor rule; clarified single-file bilingual exception |
