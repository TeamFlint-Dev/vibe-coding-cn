---
# 具有完整 Bash 权限的工作流模板
# 用途：需要安装工具或执行复杂脚本的任务

on:
  workflow_dispatch:
    inputs:
      task:
        description: '任务描述'
        required: true
        type: string

permissions:
  contents: read
  issues: read
  pull-requests: read

tools:
  # 完整 bash 权限 - 允许所有命令
  bash: [":*"]
  edit:
  github:
    toolsets: [repos, issues, pull_requests]
    mode: remote

# 允许访问的外部 URL
network:
  allowed:
    - "raw.githubusercontent.com"
    - "pypi.org"
    - "files.pythonhosted.org"
    - "registry.npmjs.org"

safe-outputs:
  add-comment:
    max: 5
  create-pull-request:
  create-issue:
    max: 2

---

# Full Access Task Executor

具有完整系统访问权限的任务执行器。

## ⚠️ 安全提示

此工作流具有完整 bash 权限，请确保：

1. 只在可信仓库中使用
2. 仔细审查触发的 prompt
3. 监控执行日志

## 任务

{{ inputs.task }}

## 可用能力

- ✅ 安装 Python 包：`pip install <package>`
- ✅ 安装 Node 包：`npm install <package>`
- ✅ 下载脚本：`curl -sSL <url> | bash`
- ✅ 执行任意 shell 命令
- ✅ 编辑文件
- ✅ 创建 PR 和 Issue

## 执行步骤

1. 解析任务需求
2. 安装必要工具（如需）
3. 执行任务
4. 清理临时文件
5. 通过 safe-outputs 报告结果
