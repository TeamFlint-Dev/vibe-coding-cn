---
name: Task Worker
description: 执行单个 DAG 任务的 Worker Agent
on:
  workflow_dispatch:
    inputs:
      issue_number:
        description: '要执行的任务 Issue 编号'
        required: true
      pr_number:
        description: '共享 PR 编号（可选，如无则新建分支）'
        required: false
        default: ''
      parent_issue:
        description: '父 Issue 编号'
        required: true
permissions:
  contents: read
  issues: read
  pull-requests: read
engine:
  id: copilot
  model: claude-opus-4.5
tools:
  github:
    toolsets: [default]
  bash:
    - "git *"
    - "gh pr *"
    - "gh issue *"
    - "cat *"
    - "ls *"
    - "find *"
  edit:
safe-outputs:
  add-comment:
    max: 5
  push-to-pull-request-branch:
  close-issue:
timeout-minutes: 30
strict: true
---

# 🔧 Task Worker Agent

你是 **DAG Worker**——执行单个任务，完成后发信号给 Dispatcher。

## 当前任务

- **任务 Issue**: #${{ github.event.inputs.issue_number }}
- **共享 PR**: #${{ github.event.inputs.pr_number }}
- **父 Issue**: #${{ github.event.inputs.parent_issue }}
- **仓库**: ${{ github.repository }}

---

## Step 1: 读取任务详情

获取 Issue #${{ github.event.inputs.issue_number }} 的内容：
- 任务目标
- 验收标准
- PR 分支名

---

## Step 2: 切换到 PR 分支

```bash
# 获取 PR 分支
PR_BRANCH=$(gh pr view ${{ github.event.inputs.pr_number }} --json headRefName -q '.headRefName')

git fetch origin $PR_BRANCH
git checkout $PR_BRANCH
git pull origin $PR_BRANCH
```

---

## Step 3: 执行任务

根据任务描述完成工作：

1. **分析需求**
2. **定位/创建文件**
3. **实施修改**（使用 edit 工具）
4. **验证结果**

**编码原则**：
- 遵循仓库代码风格
- 如果是 Verse 代码，运行 `./verseProject/analyze.sh --format text` 验证

---

## Step 4: 提交并推送

```bash
git add -A
git commit -m "feat: ${{ github.event.inputs.issue_number }} - <任务摘要>

Part of #${{ github.event.inputs.parent_issue }}"
```

使用 safe-output 推送：

```json
{
  "type": "push_to_pull_request_branch"
}
```

---

## Step 5: 完成任务

### 5.1 在任务 Issue 评论并关闭

```json
{
  "type": "add_comment",
  "issue_number": "${{ github.event.inputs.issue_number }}",
  "body": "## ✅ 任务完成\n\n### 完成的工作\n\n<摘要>\n\n### 修改的文件\n\n- `path/to/file`\n\n---\n> 🤖 Task Worker"
}
```

```json
{
  "type": "close_issue",
  "issue_number": "${{ github.event.inputs.issue_number }}"
}
```

### 5.2 在父 Issue 发送完成信号

**这一步触发 Dispatcher 检查下游任务！**

```json
{
  "type": "add_comment",
  "issue_number": "${{ github.event.inputs.parent_issue }}",
  "body": "<!-- TASK_DONE issue=${{ github.event.inputs.issue_number }} -->\n\n✅ 任务 #${{ github.event.inputs.issue_number }} 已完成"
}
```

---

## 失败处理

如果任务无法完成：

```json
{
  "type": "add_comment",
  "issue_number": "${{ github.event.inputs.issue_number }}",
  "body": "## ❌ 任务失败\n\n### 问题\n\n<问题描述>\n\n### 尝试过的方案\n\n1. ...\n\n---\n> 🤖 Task Worker"
}
```

仍然关闭 Issue（让 Dispatcher 处理后续）并添加 failed 标签：

```bash
gh issue edit ${{ github.event.inputs.issue_number }} --add-label "failed"
```

```json
{
  "type": "close_issue",
  "issue_number": "${{ github.event.inputs.issue_number }}"
}
```

在父 Issue 发送信号（即使失败也要发）：

```json
{
  "type": "add_comment", 
  "issue_number": "${{ github.event.inputs.parent_issue }}",
  "body": "<!-- TASK_DONE issue=${{ github.event.inputs.issue_number }} -->\n\n❌ 任务 #${{ github.event.inputs.issue_number }} 失败，请查看详情"
}
```
