# 仓库维护 Agent Workflows 索引

> **创建日期**: 2026-01-07
> **用途**: 手动触发的 Agent Workflows，用于发掘需求、生成 Issue、辅助决策

---

## 概览

这 10 个 Agent Workflows 专注于**仓库维护**和**需求发掘**，帮助你：

- 发现仓库中的改进机会
- 通过 Issue 追踪待办事项
- 沉淀知识和经验
- 生成报告和路线图

所有 workflow 都是 **手动触发 (workflow_dispatch)**，无需定时自动运行。

---

## Workflow 分类

### 🔍 发现类 (Discovery)

发现仓库中的问题和改进机会。

| Workflow | 文件 | 核心功能 | 输出 |
|----------|------|---------|------|
| **Skill Gap Finder** | [skill-gap-finder.md](.github/workflows/skill-gap-finder.md) | 分析 Skill 缺失，发现需要新建的技能 | Issue (标签: skill-gap) |
| **Code Library Discoverer** | [code-library-discoverer.md](.github/workflows/code-library-discoverer.md) | 发现可复用代码，建议抽取到 library | Issue (标签: code-reuse) |
| **Failure Case Miner** | [failure-case-miner.md](.github/workflows/failure-case-miner.md) | 从 Issue/PR 提炼踩坑经验 | Issue (标签: failure-case) |

### 📋 审计类 (Audit)

检查文档和代码的质量。

| Workflow | 文件 | 核心功能 | 输出 |
|----------|------|---------|------|
| **Skill Quality Auditor** | [skill-quality-auditor.md](.github/workflows/skill-quality-auditor.md) | 审计 Skill 质量，评分并建议改进 | Issue (标签: skill-quality) |
| **Design Doc Reviewer** | [design-doc-reviewer.md](.github/workflows/design-doc-reviewer.md) | 检查设计文档完整性和一致性 | Issue (标签: design-review) |
| **API Digest Updater** | [api-digest-updater.md](.github/workflows/api-digest-updater.md) | 检查 API Digest 是否过时 | Issue (标签: api-digest) |

### 🚀 规划类 (Planning)

帮助规划下一步工作。

| Workflow | 文件 | 核心功能 | 输出 |
|----------|------|---------|------|
| **Project Next Step** | [project-next-step.md](.github/workflows/project-next-step.md) | 根据项目状态建议下一步任务 | Issue (标签: next-step) |
| **Roadmap Generator** | [roadmap-generator.md](.github/workflows/roadmap-generator.md) | 生成优先级排序的待办清单 | Issue (标签: roadmap) |

### 🔬 研究类 (Research)

调研新知识和最佳实践。

| Workflow | 文件 | 核心功能 | 输出 |
|----------|------|---------|------|
| **Verse Code Scout** | [verse-code-scout.md](.github/workflows/verse-code-scout.md) | 研究 Verse 新特性/最佳实践 | Issue (标签: research, verse) |

### 📊 报告类 (Reporting)

生成进度报告和总结。

| Workflow | 文件 | 核心功能 | 输出 |
|----------|------|---------|------|
| **Weekly Progress Reporter** | [weekly-progress-reporter.md](.github/workflows/weekly-progress-reporter.md) | 生成周进展报告 | Issue (标签: weekly-report) |

---

## 使用方法

### 方式 1: GitHub Actions UI

1. 打开 GitHub 仓库 → Actions 标签页
2. 左侧选择要运行的 Workflow
3. 点击 "Run workflow"
4. 填写输入参数
5. 点击 "Run workflow" 按钮

### 方式 2: GitHub CLI

```bash
# 运行 Skill Gap Finder
gh aw run skill-gap-finder -f focus_area=verseDev

# 运行 Project Next Step
gh aw run project-next-step -f project_name=fishing

# 运行 Roadmap Generator
gh aw run roadmap-generator -f focus_area=all -f time_horizon=month

# 运行 Verse Code Scout
gh aw run verse-code-scout -f topic="SceneGraph最佳实践"

# 运行 Skill Quality Auditor
gh aw run skill-quality-auditor -f skill_path=skills/verseDev/verseComponent
```

---

## 各 Workflow 详细参数

### 1. Skill Gap Finder

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `focus_area` | string | 否 | `all` | 聚焦领域: verseDev/gameDev/infra/all |

**适用场景**:

- 定期检查 Skill 体系完整性
- 发现需要补充的技能文档
- 找出文档不完整的 Skill

---

### 2. Project Next Step

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `project_name` | string | ✅ 是 | - | 项目名称 (如 fishing) |

**适用场景**:

- 不知道项目下一步该做什么
- 项目阶段切换时
- 需要梳理项目进度

---

### 3. API Digest Updater

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `api_type` | string | 否 | `all` | API 类型: Verse/Fortnite/UnrealEngine/all |

**适用场景**:

- UEFN 版本更新后
- 怀疑 API 文档过时
- 定期同步检查

---

### 4. Failure Case Miner

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `skill_path` | string | 否 | - | 目标 Skill 路径 |
| `days_back` | string | 否 | `30` | 回溯天数 |

**适用场景**:

- 知识沉淀周期性任务
- 发现 Issue 中有价值的经验
- 补充 FAILURE-CASES.md

---

### 5. Verse Code Scout

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `topic` | string | ✅ 是 | - | 研究主题 |

**适用场景**:

- 学习 Verse 新特性
- 调研最佳实践
- 探索社区方案

**示例主题**:

- "SceneGraph最佳实践"
- "Verse性能优化"
- "Entity-Component架构"
- "Fortnite Creative新API"

---

### 6. Design Doc Reviewer

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `project_name` | string | ✅ 是 | - | 项目名称 |

**适用场景**:

- 设计阶段完成后的质量检查
- 准备进入开发前的验证
- 设计文档维护

---

### 7. Skill Quality Auditor

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `skill_path` | string | ✅ 是 | - | Skill 路径 |

**适用场景**:

- Skill 创建后的质量检查
- 定期质量审计
- 发现改进机会

---

### 8. Weekly Progress Reporter

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `report_scope` | string | 否 | `repo` | 范围: repo/project/skill |
| `target_path` | string | 否 | - | 目标路径 (project/skill 需要) |

**适用场景**:

- 每周例行回顾
- 项目进度汇报
- 团队同步

---

### 9. Code Library Discoverer

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `scan_path` | string | 否 | - | 扫描路径，留空扫描全部 |

**适用场景**:

- 代码重构时
- 发现重复代码
- 扩展代码库

---

### 10. Roadmap Generator

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `focus_area` | string | 否 | `all` | 领域: all/skills/projects/library/infra |
| `time_horizon` | string | 否 | `month` | 时间范围: week/month/quarter |

**适用场景**:

- 规划周期开始时
- 需要梳理优先级
- 制定阶段目标

---

## 推荐使用频率

| 频率 | Workflow |
|------|----------|
| **每周** | Weekly Progress Reporter, Failure Case Miner |
| **每两周** | Project Next Step, Roadmap Generator |
| **每月** | Skill Gap Finder, Skill Quality Auditor, API Digest Updater |
| **按需** | Verse Code Scout, Design Doc Reviewer, Code Library Discoverer |

---

## 与知识沉淀系统的关系

这些 Workflow 与仓库的 [知识沉淀系统](AGENTS.md#知识沉淀系统knowledge-capture-system) 紧密配合：

```
Workflow 发现问题
       │
       ▼
   创建 Issue
       │
       ▼
  人工/AI 处理
       │
       ▼
更新知识文档
  ├── FAILURE-CASES.md
  ├── CAPABILITY-BOUNDARIES.md
  ├── PREFLIGHT-CHECKLIST.md
  └── DECISION-LOG.md
```

---

## 扩展建议

如需添加新的 Workflow，可参考以下模板类型：

1. **发现类**: 扫描仓库 → 分析问题 → 创建 Issue
2. **审计类**: 读取内容 → 对照标准 → 评分报告
3. **规划类**: 收集现状 → 排序优先级 → 输出计划
4. **研究类**: 确定主题 → 搜索信息 → 整理知识

详见 [WORKFLOW-INDEX.md](skills/github/ghAgenticWorkflows/WORKFLOW-INDEX.md) 中的模板参考。
