<#
.SYNOPSIS
    创建 GitHub Copilot Agent Workflow (gh-aw) 工作流模板

.DESCRIPTION
    生成符合 gh-aw 格式规范的 Markdown 工作流文件。
    gh-aw 使用 YAML frontmatter + Markdown 正文格式。
    
    必需字段：
    - on: 触发器（workflow_dispatch, issues, pull_request 等）
    - permissions: 权限声明
    - safe-outputs: 输出限制

.PARAMETER Name
    工作流名称（用于文件名）

.PARAMETER Description
    工作流描述

.PARAMETER Trigger
    触发器类型，默认 workflow_dispatch

.EXAMPLE
    .\create-gh-aw-workflow.ps1 -Name "my-agent" -Description "我的自定义 Agent"

.NOTES
    gh-aw 格式要点：
    - frontmatter 用 --- 开头和结尾
    - on: 触发器是必需的
    - permissions: 声明需要的权限
    - safe-outputs: 限制 AI 可以执行的操作
    - 正文是给 AI 的指令
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$true)]
    [string]$Description,
    
    [ValidateSet("workflow_dispatch", "issues", "pull_request", "schedule")]
    [string]$Trigger = "workflow_dispatch",
    
    [string]$OutputDir = ".github/workflows"
)

# 确保输出目录存在
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$outputFile = Join-Path $OutputDir "$Name.md"

# 根据触发器类型生成不同的配置
$triggerYaml = switch ($Trigger) {
    "workflow_dispatch" {
@"
on:
  workflow_dispatch:
    inputs:
      input_param:
        description: '输入参数描述'
        required: true
        type: string
"@
    }
    "issues" {
@"
on:
  issues:
    types: [opened, reopened]
"@
    }
    "pull_request" {
@"
on:
  pull_request:
    types: [opened, synchronize]
"@
    }
    "schedule" {
@"
on:
  schedule:
    - cron: "0 9 * * 1"  # Every Monday at 9 AM UTC
"@
    }
}

# 生成工作流模板
$template = @"
---
# $Name - $Description

$triggerYaml

permissions:
  contents: read
  issues: read
  pull-requests: read

# Tools - 启用 bash 执行权限（按需取消注释）
# tools:
#   bash: [":*"]
#   edit:
#   github:
#     toolsets: [repos, issues, pull_requests]
#     mode: remote

# Network - 允许访问外部域名（按需配置）
# network:
#   allowed:
#     - "api.example.com"

safe-outputs:
  create-issue:
    max: 1
  add-comment:
    max: 5
---

# $Name

$Description

## 任务目标

描述这个 Agent 需要完成的任务。

## 执行步骤

### Step 1: 准备
分析输入参数和当前环境。

### Step 2: 执行
在这里描述主要执行逻辑。

### Step 3: 完成
输出结果并清理。

## 注意事项

- 列出重要的注意事项
- 错误处理方式
- 输出格式要求
"@

# 写入文件
$template | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "✓ 工作流已创建: $outputFile" -ForegroundColor Green
Write-Host ""
Write-Host "后续步骤:" -ForegroundColor Yellow
Write-Host "  1. 编辑工作流内容: code $outputFile"
Write-Host "  2. 编译工作流: gh aw compile $Name"
Write-Host "  3. 运行工作流: gh aw run $Name --input input_param=value"
