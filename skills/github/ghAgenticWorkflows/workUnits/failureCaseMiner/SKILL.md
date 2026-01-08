---
name: failureCaseMiner
description: 从 Issue/PR/代码注释中提炼失败案例，并沉淀到指定 Skill 的 FAILURE-CASES.md（Work Unit）
version: 0.1.0
---

# Failure Case Miner（工作单元）

> **定位**: gh-aw Work Unit（最小工作单元）
>
> **目标**: 把“踩坑信息”从分散的 Issue/PR/注释里挖出来，并以标准格式写回 Skill 知识包（`FAILURE-CASES.md`），形成可复用的经验资产。

---

## 这个 Work Unit 负责什么

- 扫描：最近 N 天的 Issue/PR，以及仓库内的 TODO/FIXME/WORKAROUND 等注释
- 提炼：现象/根因/修复/教训（检查项）
- 沉淀：把新案例写入目标 Skill 的 `FAILURE-CASES.md`（优先），必要时创建 Issue 追踪

---

## 入口工作流

- 工作流：`.github/workflows/failure-case-miner.md`
- 编译产物：`.github/workflows/failure-case-miner.lock.yml`

---

## 输入/输出

### 输入

- `skill_path`：目标 Skill 路径（默认指向本 Work Unit 的知识包目录）
- `days_back`：回溯天数（默认 30）

### 输出

- 代码变更：更新 `${skill_path}/FAILURE-CASES.md`（包含索引与新增案例）
- 可选：创建 Issue 用于“待沉淀/待确认”的案例

---

## 运行方式（人工触发）

- 在 GitHub Actions 里手动触发 `Failure Case Miner`
- 不填 `skill_path`：沉淀到本 Work Unit 的知识包
- 传入其他 `skill_path`：沉淀到对应 Skill（例如 `skills/verseDev/verseDLSD`）

---

## 维护原则（为什么要自维护 Skills）

- 本 Work Unit 的方法论、边界、检查项、踩坑记录必须优先写回本目录下的文档
- 当涉及跨领域（如 Verse 编译器/UEFN 限制），再链接到对应领域 Skill 作为外部依赖
