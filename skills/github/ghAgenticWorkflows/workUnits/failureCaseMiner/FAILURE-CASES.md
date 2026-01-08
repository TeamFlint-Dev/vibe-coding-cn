# Failure Case Miner 失败案例库

> **用途**: 记录本 Work Unit（Failure Case Miner）自身的踩坑经历，避免在类似“挖掘/沉淀经验”任务中反复踩同样的坑。

---

## 案例索引

| ID | 标题 | 根因类别 | 日期 | 状态 |
|---|---|---|---|---|
| FC-001 | 默认 skill_path 未设置导致沉淀失败 | 配置错误 | 2026-01-08 | 已解决 |

---

## 案例详情

### FC-001: 默认 skill_path 未设置导致沉淀失败

**日期**: 2026-01-08
**任务上下文**: 首次将工作流重构为 Work Unit 时
**根因类别**: 配置错误

#### 现象

未提供 `skill_path` 时，工作流无法确定要沉淀到哪个 Skill 的 `FAILURE-CASES.md`，只能停留在“创建 Issue 追踪”，无法形成闭环沉淀。

#### 根因

工作流把 `skill_path` 设为可选，但没有提供默认值，也没有 fallback 目录。

#### 修复

为 `workflow_dispatch.inputs.skill_path` 增加默认值，指向本 Work Unit 自己的知识包：
`skills/github/ghAgenticWorkflows/workUnits/failureCaseMiner`

#### 教训

- [x] 默认沉淀路径必须存在且可写
- [x] Work Unit 必须拥有自维护的 `FAILURE-CASES.md`
