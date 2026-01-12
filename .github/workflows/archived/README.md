# Archived Workflows

此目录包含已归档的工作流文件，不再活跃使用。

## 归档原因

2026-01-12：将所有基于 gh-aw (GitHub Agentic Workflows) 的实验性工作流归档。

**原因**：gh-aw 处于实验阶段，存在不稳定性和 Bug，决定改用完全自定义控制的工作流方式。

## 归档内容

### gh-aw 工作流（.md + .lock.yml 配对）

| 工作流 | 用途 |
|--------|------|
| api-digest-updater | API 摘要更新器 |
| code-library-discoverer | 代码库发现器 |
| design-doc-reviewer | 设计文档评审器 |
| dlsd-compliance-checker | DLSD 合规检查器 |
| failure-case-miner | 失败案例挖掘器 |
| goal-planner | 目标规划器 |
| issue-assigner | Issue 分配器 |
| project-next-step | 项目下一步规划 |
| research-planner | 研究规划器 |
| roadmap-generator | 路线图生成器 |
| skill-gap-finder | 技能缺口发现器 |
| skill-quality-auditor | 技能质量审计器 |
| task-planner | 任务规划器 |
| verse-code-scout | Verse 代码探索器 |
| weekly-progress-reporter | 周进度报告器 |
| workflow-case-study | 工作流案例研究 |
| workflow-case-study-v2 | 工作流案例研究 v2 |

### 传统 YAML 工作流

| 工作流 | 用途 |
|--------|------|
| sync-verse-api-digests.yml | Verse API 摘要同步 |
| verse-syntax-check.yml | Verse 语法检查 |
| verse-uefn-compile.yml | Verse UEFN 编译 |

### 其他

- `shared/` - gh-aw 共享资源目录

## 恢复使用

如需恢复某个工作流，将对应文件移回 `.github/workflows/` 目录即可。

## 当前活跃工作流

| 工作流 | 触发命令 | 用途 |
|--------|----------|------|
| `opencode.yml` | `/oc`, `/opencode` | 通用 AI Agent |
| `workflow-case-study.yml` | `/wcs`, `/workflow-case-study` | 工作流案例研究 |

## 新工作流结构

采用 OpenCode 模式，每个工作单元：

```
.github/workflows/
├── <work-unit-name>.yml           # 工作流入口
└── shared/
    └── <workUnitName>/            # Prompts 目录
        ├── entry-prompt.md        # 入口 prompt
        ├── think-model.md         # 思维模型
        ├── phase-1-*.md           # 阶段 1 prompt
        ├── phase-2-*.md           # 阶段 2 prompt
        └── ...
```
