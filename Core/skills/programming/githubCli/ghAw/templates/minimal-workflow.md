---
# 最小 gh-aw 工作流模板
# 用途：快速创建新的 Agentic Workflow

on:
  workflow_dispatch:
    inputs:
      prompt:
        description: '任务描述'
        required: true
        type: string

permissions:
  contents: read
  issues: read

tools:
  bash:
    - cat:*
    - ls:*
    - find:*
    - grep:*
  edit:
  github:
    mode: remote

safe-outputs:
  add-comment:
    max: 3

---

# Task Assistant

根据输入的 prompt 执行任务。

## 任务

{{ inputs.prompt }}

## 执行指南

1. 分析任务需求
2. 收集必要上下文（读取相关文件）
3. 执行任务
4. 通过 add-comment 报告结果
