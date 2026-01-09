---
name: Issue Assigner
description: 自动为新创建的 [Plan] Issue 分配 Copilot 和 Maybank01
runs-on: [self-hosted, linux, x64, tencent-cloud]
on:
  issues:
    types: [opened]
permissions:
  contents: read
  issues: read

# 只处理 [Plan] 前缀的 Issue
if: startsWith(github.event.issue.title, '[Plan]')

safe-outputs:
  assign-to-agent:
    name: copilot
    max: 1
  assign-to-user:
    allowed:
      - Maybank01
    max: 1

timeout-minutes: 2
---

# 🔧 Issue Assigner

你是一个自动分配器。当检测到新的 `[Plan]` Issue 时，自动分配给 Copilot 和 Maybank01。

## 触发条件

- Issue 标题: `${{ github.event.issue.title }}`
- Issue 编号: `${{ github.event.issue.number }}`

## 执行步骤

### 步骤 1: 验证 Issue

确认 Issue 标题以 `[Plan]` 开头。

### 步骤 2: 分配 Copilot

使用 `assign-to-agent` safe-output，将 Issue #${{ github.event.issue.number }} 分配给 Copilot。

### 步骤 3: 分配人类监督者

使用 `assign-to-user` safe-output，将 Issue #${{ github.event.issue.number }} 分配给 Maybank01。

### 步骤 4: 确认

输出确认信息：Issue 已分配给 Copilot 和 Maybank01。
