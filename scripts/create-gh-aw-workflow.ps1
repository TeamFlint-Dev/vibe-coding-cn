<#
.SYNOPSIS
    创建 GitHub Copilot Agent Workflow (gh-aw) 工作流模板

.DESCRIPTION
    生成符合 gh-aw 格式规范的 Markdown 工作流文件。
    gh-aw 使用 YAML frontmatter + Markdown 正文格式，frontmatter 必须用 --- 正确关闭。

.PARAMETER Name
    工作流名称（用于文件名和 name 字段）

.PARAMETER Description
    工作流描述

.PARAMETER Model
    使用的模型，默认 claude-sonnet-4

.PARAMETER Tools
    工具列表，默认 ["bash", "github", "edit"]

.EXAMPLE
    .\create-gh-aw-workflow.ps1 -Name "my-agent" -Description "我的自定义 Agent"

.NOTES
    gh-aw 格式要点：
    - frontmatter 用 --- 开头和结尾
    - instructions 作为 Markdown 正文，不是 YAML 字段
    - inputs 是数组格式
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$true)]
    [string]$Description,
    
    [string]$Model = "claude-sonnet-4",
    
    [string[]]$Tools = @("bash", "github", "edit"),
    
    [string]$OutputDir = ".github/workflows"
)

# 确保输出目录存在
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$outputFile = Join-Path $OutputDir "$Name.md"

# 构建工具列表 YAML
$toolsYaml = ($Tools | ForEach-Object { "  - $_" }) -join "`n"

# 生成工作流模板
$template = @"
---
name: $Name
description: $Description
engine: copilot
model: $Model

tools:
$toolsYaml

inputs:
  - name: input_param
    description: 输入参数描述
    required: true
---

# $Name

你是 $Description 的执行 Agent。

## 任务目标

描述这个 Agent 需要完成的任务。

## 执行步骤

### Step 1: 准备
```bash
echo "开始执行..."
```

### Step 2: 执行
在这里描述主要执行逻辑。

### Step 3: 完成
```bash
echo "执行完成"
```

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
