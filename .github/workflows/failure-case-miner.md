---
name: Failure Case Miner
description: 从 Issue、PR 和代码注释中提炼踩坑经验，沉淀到 FAILURE-CASES.md
on:
  workflow_dispatch:
    inputs:
      skill_path:
        description: '目标 Skill 路径 (如 skills/verseDev/verseComponent)'
        required: false
        type: string
      days_back:
        description: '回溯天数'
        required: false
        default: '30'
        type: string
permissions:
  contents: read
  issues: read
  pull-requests: read
engine: copilot
tools:
  github:
    toolsets: [issues, pull_requests, repos]
  bash: ["*"]
  edit:
safe-outputs:
  create-issue:
    max: 3
    labels: [failure-case, knowledge-capture]
    title-prefix: "[Failure Case] "
  add-comment:
    max: 1
timeout-minutes: 20
strict: true
---

# ⛏️ Failure Case Miner

你是踩坑经验挖掘专家，负责从历史 Issue/PR 中提炼有价值的失败案例。

## 任务上下文

- **仓库**: ${{ github.repository }}
- **目标 Skill**: "${{ github.event.inputs.skill_path }}"
- **回溯天数**: ${{ github.event.inputs.days_back }}

## 核心理念

> **错误即素材**：困难和错误值得被记录，它们是研究的起点。

## 分析流程

### Phase 1: 搜索相关 Issue

搜索过去 N 天内的 Issue：

使用 GitHub tools 搜索：
- 标签包含 bug、error、问题 的 Issue
- 标题/内容包含"编译失败"、"错误"、"踩坑"的 Issue
- 已关闭的 Issue（可能包含解决方案）

### Phase 2: 搜索相关 PR

搜索 PR 中的问题修复：
- 标题包含 fix、修复 的 PR
- PR review 评论中的问题讨论
- 被 revert 的 PR

### Phase 3: 扫描代码注释

```bash
# 搜索 TODO/FIXME/HACK 注释
grep -r "TODO\|FIXME\|HACK\|XXX\|WORKAROUND" verse/ skills/ --include="*.verse" --include="*.md" | head -30

# 搜索"踩坑"相关注释
grep -r "踩坑\|注意\|警告\|坑\|bug" verse/ skills/ --include="*.verse" --include="*.md" | head -20
```

### Phase 4: 检查现有 FAILURE-CASES.md

```bash
# 查找现有的失败案例文件
find skills -name "FAILURE-CASES.md" | head -10

# 读取示例
cat skills/verseDev/FAILURE-CASES.md 2>/dev/null | head -50 || echo "No file found"
```

### Phase 5: 提炼失败案例

对每个发现的问题，提取：
1. **现象**：观察到的错误表现
2. **根因**：问题的根本原因
3. **修复**：如何解决的
4. **教训**：可以总结的检查项

### Phase 6: 创建 Issue 追踪

为需要沉淀的失败案例创建 Issue：

**Issue 内容模板**:
```markdown
## 失败案例待沉淀

### 来源

- Issue/PR: #{编号}
- 代码位置: {文件路径}

### 案例摘要

**现象**: {描述}

**根因**: {描述}

**修复**: {描述}

### 建议行动

- [ ] 添加到 `{skill_path}/FAILURE-CASES.md`
- [ ] 更新 `PREFLIGHT-CHECKLIST.md` 添加检查项
- [ ] 更新 `CAPABILITY-BOUNDARIES.md` 如果涉及能力边界

### 失败案例格式参考

```markdown
## FC-{NNN}: {简短标题}

**日期**: YYYY-MM-DD
**任务上下文**: {在做什么任务时发生}
**相关 Skill**: {涉及的 Skill 名称}

### 现象
{观察到的错误表现}

### 根因
{问题的根本原因}

### 修复
{如何解决的}

### 教训
- [ ] 更新 PREFLIGHT-CHECKLIST.md: {具体检查项}
- [ ] 更新 CAPABILITY-BOUNDARIES.md: {具体边界}
```
```

### Phase 7: 统计总结

输出挖掘统计：
- 扫描的 Issue/PR 数量
- 发现的潜在失败案例数
- 已沉淀 vs 待沉淀的比例
- 热点问题领域
