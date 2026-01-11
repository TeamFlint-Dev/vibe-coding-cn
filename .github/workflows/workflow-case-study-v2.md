---
name: Workflow Case Study v2
description: 智能分析 GitHub Agentic Workflows，持续沉淀知识到 Skills
on:
  workflow_dispatch:
  schedule: every 4h
permissions:
  contents: read
  issues: read
  pull-requests: read
concurrency:
  group: workflow-case-study-${{ github.ref }}
  cancel-in-progress: false
tracker-id: workflow-case-study-v2
engine:
  id: copilot
  model: claude-opus-4.5
env:
  WORK_UNIT_NAME: workflowCaseStudy
  GH_AW_REPO: githubnext/gh-aw
  WORK_UNIT_PATH: skills/workUnits/workflowCaseStudy
  JOURNAL_PATH: journals/workUnits/workflowCaseStudy
imports:
  - shared/workflowCaseStudy/think-model.md
  - shared/workflowCaseStudy/phase-1-prepare.md
  - shared/workflowCaseStudy/phase-2-decide.md
  - shared/workflowCaseStudy/phase-3-execute.md
  - shared/workflowCaseStudy/phase-4-deliver.md
tools:
  github:
    toolsets: [default]
  bash: ["*"]
  edit:
safe-outputs:
  create-pull-request:
    title-prefix: "[workflow-study] "
    labels: [gh-aw-research]
    draft: false
  push-to-pull-request-branch:
  create-issue:
    labels: [agent-suggested, needs-triage]
  add-comment:
    target: "*"
    max: 1
  messages:
    run-started: "🏭 工作单元启动... [{workflow_name}]({run_url})"
    run-success: "✅ 产出已交付！[{workflow_name}]({run_url})"
    run-failure: "⚠️ 遇到问题... [{workflow_name}]({run_url}) {status}"
timeout-minutes: 30
strict: true
---

# 🏭 Workflow Case Study 工作单元

**所有输出使用中文**（代码和技术术语可用英文）。

## 任务上下文

- **仓库**: ${{ github.repository }}
- **运行编号**: #${{ github.run_number }}
- **工作单元路径**: `${{ env.WORK_UNIT_PATH }}/`
- **Journal 路径**: `${{ env.JOURNAL_PATH }}/`

## ⛔ 禁止修改的目录

**绝对不要修改 `.github/` 目录下的任何文件**。

---

## 🚨 任务完成标准

| 检查项 | 必须 |
|--------|------|
| PR 创建/更新成功 | ✅ |
| 有具体的产出物 | ✅ |
| OVERVIEW.md 已更新 | ✅ |
| Journal 已记录 | ✅ |

**❌ 没有 PR = 任务失败**  
**✅ 成功标志：你能够提供一个 PR 链接**
