<#
.SYNOPSIS
    编译 gh-aw 工作流文件

.DESCRIPTION
    将多个目录下的 .github/workflows/*.md 编译为 .lock.yml 文件。
    封装 gh aw compile 命令，支持多路径编译。

    编译路径：
    1. .github/workflows/ - 项目工作流
    2. Core/skills/.../gh-aw-raw/workflows/ - 官方工作流参考（可选）

    注意：.github/agents/ 目录下的 Agent 文件不需要编译。

.PARAMETER Paths
    要编译的目录列表，默认只编译项目工作流

.PARAMETER IncludeReference
    是否同时编译 gh-aw-raw 中的官方工作流参考

.PARAMETER Strict
    使用严格模式验证

.PARAMETER Verbose
    显示详细输出

.EXAMPLE
    .\compile-gh-aw.ps1

.EXAMPLE
    .\compile-gh-aw.ps1 -IncludeReference

.EXAMPLE
    .\compile-gh-aw.ps1 -Strict -Verbose

.NOTES
    需要安装 gh-aw 扩展: gh extension install githubnext/gh-aw
#>

param(
    [string[]]$Paths,
    [switch]$IncludeReference,
    [switch]$Strict,
    [switch]$VerboseOutput
)

$ErrorActionPreference = "Stop"

# 获取仓库根目录
$RepoRoot = Split-Path -Parent $PSScriptRoot

# 默认编译路径
$DefaultPaths = @(
    ".github/workflows"
)

# 官方工作流参考路径
$ReferencePath = "Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/workflows"

function Write-Step {
    param([string]$Message)
    Write-Host "[$([DateTime]::Now.ToString('HH:mm:ss'))] $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "  ✓ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "  ⚠ $Message" -ForegroundColor Yellow
}

function Write-Info {
    param([string]$Message)
    Write-Host "  → $Message" -ForegroundColor Gray
}

# 确定要编译的路径
if ($Paths) {
    $CompilePaths = $Paths
} else {
    $CompilePaths = $DefaultPaths
    if ($IncludeReference) {
        $CompilePaths += $ReferencePath
    }
}

# 检查 gh-aw 是否安装
Write-Step "检查 gh-aw 扩展..."

$awVersion = $null
try {
    $awVersion = & gh aw version 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "gh aw version failed"
    }
    Write-Success "gh-aw 版本: $awVersion"
} catch {
    Write-Warning "gh-aw 未安装，正在安装..."
    & gh extension install githubnext/gh-aw
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ 安装 gh-aw 失败" -ForegroundColor Red
        exit 1
    }
    $awVersion = & gh aw version 2>&1
    Write-Success "已安装 gh-aw: $awVersion"
}

# 统计结果
$totalMdFiles = 0
$totalLockFiles = 0
$compiledPaths = @()

# 编译每个路径
foreach ($path in $CompilePaths) {
    $fullPath = Join-Path $RepoRoot $path
    
    Write-Step "编译目录: $path"
    
    if (-not (Test-Path $fullPath)) {
        Write-Warning "目录不存在，跳过: $fullPath"
        continue
    }
    
    # 统计 .md 文件数量
    $mdFiles = Get-ChildItem $fullPath -Filter "*.md" -File -ErrorAction SilentlyContinue
    $mdCount = ($mdFiles | Measure-Object).Count
    
    if ($mdCount -eq 0) {
        Write-Warning "未找到 .md 工作流文件，跳过"
        continue
    }
    
    Write-Info "发现 $mdCount 个 .md 文件"
    
    # 构建编译参数
    $compileArgs = @("aw", "compile", "--dir", $fullPath)
    
    if ($Strict) {
        $compileArgs += "--strict"
    }
    
    if ($VerboseOutput) {
        $compileArgs += "--verbose"
    }
    
    # 执行编译
    Write-Info "执行: gh $($compileArgs -join ' ')"
    
    Push-Location $RepoRoot
    try {
        & gh @compileArgs
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "✗ 编译失败: $path" -ForegroundColor Red
            Pop-Location
            exit $LASTEXITCODE
        }
        
        # 统计生成的 .lock.yml 文件
        $lockFiles = Get-ChildItem $fullPath -Filter "*.lock.yml" -File -ErrorAction SilentlyContinue
        $lockCount = ($lockFiles | Measure-Object).Count
        
        Write-Success "编译完成: $mdCount .md → $lockCount .lock.yml"
        
        $totalMdFiles += $mdCount
        $totalLockFiles += $lockCount
        $compiledPaths += $path
        
    } finally {
        Pop-Location
    }
}

# 显示编译摘要
Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  ✓ 编译完成！" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

Write-Host "编译摘要:" -ForegroundColor Cyan
Write-Host "  源文件:   $totalMdFiles .md" -ForegroundColor Gray
Write-Host "  输出文件: $totalLockFiles .lock.yml" -ForegroundColor Gray
Write-Host ""

if ($VerboseOutput -and $compiledPaths.Count -gt 0) {
    Write-Host "编译的目录:" -ForegroundColor Cyan
    foreach ($p in $compiledPaths) {
        Write-Host "  - $p" -ForegroundColor Gray
    }
}
