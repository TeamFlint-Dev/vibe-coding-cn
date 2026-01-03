<#
.SYNOPSIS
    从 githubnext/gh-aw 官方仓库同步原始文件

.DESCRIPTION
    按文件夹层级同步以下目录：
    - .github/skills/    → Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/skills/
    - .github/workflows/ → Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/workflows/ (仅 .md)
    - .github/agents/    → .github/agents/gh-aw-official/
    - .github/aw/        → Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/aw/

    同步完成后更新 README.md 中的版本日期。

.PARAMETER SourceRepo
    源仓库，默认 githubnext/gh-aw

.PARAMETER Branch
    源分支，默认 main

.PARAMETER DryRun
    仅显示将要执行的操作，不实际同步

.EXAMPLE
    .\sync-gh-aw.ps1

.EXAMPLE
    .\sync-gh-aw.ps1 -DryRun

.NOTES
    需要 Git 命令行工具
#>

param(
    [string]$SourceRepo = "githubnext/gh-aw",
    [string]$Branch = "main",
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# 获取仓库根目录
$RepoRoot = Split-Path -Parent $PSScriptRoot

# 目录映射配置（不包括 agents，agents 需要特殊处理）
$SyncMappings = @{
    ".github/skills"    = "Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/skills"
    ".github/workflows" = "Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/workflows"
    ".github/aw"        = "Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/aw"
}

# Agents 目录需要扁平化同步（VS Code 不支持子目录识别）
$AgentsSource = ".github/agents"
$AgentsTarget = ".github/agents"

# 官方 Agent 文件列表（用于区分官方和定制 Agent）
$OfficialAgentFiles = @()

# 需要过滤的文件模式（仅同步 .md 文件）
$WorkflowsOnlyMd = ".github/workflows"

# README 文件路径（用于更新版本日期）
$ReadmePath = Join-Path $RepoRoot "Core/skills/programming/ghAgenticWorkflows/shared/gh-aw-raw/README.md"

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

# 创建临时目录
$TempDir = Join-Path $env:TEMP "gh-aw-sync-$(Get-Date -Format 'yyyyMMdd-HHmmss')"

try {
    Write-Step "克隆 $SourceRepo (sparse checkout)..."
    
    if ($DryRun) {
        Write-Info "[DryRun] 将克隆到 $TempDir"
    } else {
        # 使用 sparse checkout 只拉取需要的目录
        git clone --depth 1 --filter=blob:none --sparse "https://github.com/$SourceRepo.git" $TempDir 2>&1 | Out-Null
        
        Push-Location $TempDir
        git sparse-checkout set .github/skills .github/agents .github/aw .github/workflows 2>&1 | Out-Null
        Pop-Location
        
        Write-Success "克隆完成"
    }

    # 同步每个目录
    foreach ($src in $SyncMappings.Keys) {
        $dst = Join-Path $RepoRoot $SyncMappings[$src]
        $srcPath = Join-Path $TempDir $src
        
        Write-Step "同步 $src → $($SyncMappings[$src])"
        
        if ($DryRun) {
            Write-Info "[DryRun] 源: $srcPath"
            Write-Info "[DryRun] 目标: $dst"
            continue
        }
        
        if (-not (Test-Path $srcPath)) {
            Write-Warning "源目录不存在: $srcPath"
            continue
        }
        
        # 确保目标目录存在
        if (-not (Test-Path $dst)) {
            New-Item -ItemType Directory -Path $dst -Force | Out-Null
            Write-Info "创建目录: $dst"
        }
        
        # 清理目标目录（保留 README.md）
        Get-ChildItem $dst -Exclude "README.md" -ErrorAction SilentlyContinue | ForEach-Object {
            Remove-Item $_.FullName -Recurse -Force
        }
        
        # 根据目录类型选择同步方式
        if ($src -eq $WorkflowsOnlyMd) {
            # workflows 目录：只同步 .md 文件，排除 .lock.yml
            $mdFiles = Get-ChildItem $srcPath -Filter "*.md" -Recurse -File
            $count = 0
            
            foreach ($file in $mdFiles) {
                $relativePath = $file.FullName.Substring($srcPath.Length + 1)
                $destPath = Join-Path $dst $relativePath
                $destDir = Split-Path $destPath -Parent
                
                if (-not (Test-Path $destDir)) {
                    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
                }
                
                Copy-Item $file.FullName $destPath -Force
                $count++
            }
            
            Write-Success "同步 $count 个 .md 文件"
        } else {
            # 其他目录：完整复制
            Copy-Item "$srcPath\*" $dst -Recurse -Force
            $count = (Get-ChildItem $dst -Recurse -File | Measure-Object).Count
            Write-Success "同步 $count 个文件"
        }
    }

    # 同步 Agents（扁平化到根目录，不删除定制 Agent）
    Write-Step "同步 Agents (扁平化)..."
    
    $agentsSrcPath = Join-Path $TempDir $AgentsSource
    $agentsDstPath = Join-Path $RepoRoot $AgentsTarget
    
    if ($DryRun) {
        Write-Info "[DryRun] 源: $agentsSrcPath"
        Write-Info "[DryRun] 目标: $agentsDstPath (扁平化)"
    } elseif (Test-Path $agentsSrcPath) {
        # 确保目标目录存在
        if (-not (Test-Path $agentsDstPath)) {
            New-Item -ItemType Directory -Path $agentsDstPath -Force | Out-Null
        }
        
        # 获取官方 Agent 文件列表
        $officialAgents = Get-ChildItem $agentsSrcPath -Filter "*.agent.md" -File
        $count = 0
        
        foreach ($agent in $officialAgents) {
            $destPath = Join-Path $agentsDstPath $agent.Name
            Copy-Item $agent.FullName $destPath -Force
            $script:OfficialAgentFiles += $agent.Name
            $count++
        }
        
        Write-Success "同步 $count 个官方 Agent"
        Write-Info "官方 Agent 列表: $($officialAgents.Name -join ', ')"
    } else {
        Write-Warning "Agents 源目录不存在: $agentsSrcPath"
    }

    # 更新 README.md 的版本日期
    Write-Step "更新版本日期..."
    
    if ($DryRun) {
        Write-Info "[DryRun] 将更新 $ReadmePath"
    } else {
        $today = Get-Date -Format "yyyy-MM-dd"
        
        if (Test-Path $ReadmePath) {
            $content = Get-Content $ReadmePath -Raw -Encoding UTF8
            
            # 更新版本日期（支持多种格式）
            $patterns = @(
                @{ Pattern = '版本[：:]\s*\d{4}-\d{2}-\d{2}'; Replace = "版本: $today" }
                @{ Pattern = '最后更新[：:]\s*\d{4}-\d{2}-\d{2}'; Replace = "最后更新: $today" }
                @{ Pattern = 'Last Updated[：:]\s*\d{4}-\d{2}-\d{2}'; Replace = "Last Updated: $today" }
            )
            
            $updated = $false
            foreach ($p in $patterns) {
                if ($content -match $p.Pattern) {
                    $content = $content -replace $p.Pattern, $p.Replace
                    $updated = $true
                }
            }
            
            if ($updated) {
                Set-Content $ReadmePath $content -Encoding UTF8 -NoNewline
                Write-Success "版本日期已更新为 $today"
            } else {
                Write-Warning "未找到版本日期字段，跳过更新"
            }
        } else {
            Write-Warning "README.md 不存在: $ReadmePath"
        }
    }

    Write-Host ""
    Write-Host "============================================" -ForegroundColor Green
    Write-Host "  ✓ 同步完成！" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Green
    Write-Host ""
    
    # 显示同步摘要
    Write-Host "同步摘要:" -ForegroundColor Cyan
    foreach ($src in $SyncMappings.Keys) {
        $dst = Join-Path $RepoRoot $SyncMappings[$src]
        if (Test-Path $dst) {
            $count = (Get-ChildItem $dst -Recurse -File -ErrorAction SilentlyContinue | Measure-Object).Count
            Write-Host "  $($SyncMappings[$src]): $count 文件" -ForegroundColor Gray
        }
    }

} catch {
    Write-Host ""
    Write-Host "✗ 同步失败: $_" -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    exit 1
} finally {
    # 清理临时目录
    if ((Test-Path $TempDir) -and -not $DryRun) {
        Write-Step "清理临时文件..."
        Remove-Item $TempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Success "清理完成"
    }
}
