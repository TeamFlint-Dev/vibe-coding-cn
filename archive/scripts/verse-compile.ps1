<#
.SYNOPSIS
    Verse 远程编译脚本 - Agent 一键调用

.DESCRIPTION
    自动检测当前分支，推送到 Git，发送编译请求到云服务器，等待结果。

.EXAMPLE
    ./scripts/verse-compile.ps1
    
.EXAMPLE
    ./scripts/verse-compile.ps1 -NoPush  # 不自动推送，假设已经推送
#>

param(
    [switch]$NoPush,      # 跳过 git push
    [switch]$NoWait,      # 不等待结果（异步模式）
    [int]$Timeout = 300   # 超时时间（秒）
)

$ErrorActionPreference = "Stop"

# ============ 配置 ============
$CLOUD_SERVER = "http://193.112.183.143:19527"
$COMPILE_ENDPOINT = "$CLOUD_SERVER/verse/compile"
$STATUS_ENDPOINT = "$CLOUD_SERVER/verse/status"

# ============ 函数 ============

function Write-Step {
    param([string]$Message)
    Write-Host "`n📌 $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Get-CurrentBranch {
    $branch = git rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Not in a git repository"
    }
    return $branch
}

function Test-UnpushedCommits {
    param([string]$Branch)
    $unpushed = git log "origin/$Branch..$Branch" --oneline 2>$null
    return [bool]$unpushed
}

function Push-Branch {
    param([string]$Branch)
    Write-Host "   Pushing to origin/$Branch..."
    git push origin $Branch 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to push to origin/$Branch"
    }
}

function Get-CurrentCommit {
    return git rev-parse HEAD
}

function Get-RepoInfo {
    $remoteUrl = git remote get-url origin
    # 解析 owner/repo
    if ($remoteUrl -match "github\.com[:/]([^/]+)/([^/.]+)") {
        return @{
            Owner = $Matches[1]
            Repo = $Matches[2] -replace '\.git$', ''
        }
    }
    throw "Cannot parse repository info from: $remoteUrl"
}

function Send-CompileRequest {
    param(
        [string]$Branch,
        [string]$Commit,
        [string]$Owner,
        [string]$Repo
    )
    
    $body = @{
        branch = $Branch
        commit = $Commit
        repo_owner = $Owner
        repo_name = $Repo
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri $COMPILE_ENDPOINT -Method Post -Body $body -ContentType "application/json"
        return $response
    }
    catch {
        throw "Failed to send compile request: $_"
    }
}

function Get-CompileStatus {
    param([string]$RequestId)
    
    try {
        $response = Invoke-RestMethod -Uri "$STATUS_ENDPOINT/$RequestId" -Method Get
        return $response
    }
    catch {
        return $null
    }
}

function Wait-CompileResult {
    param(
        [string]$RequestId,
        [int]$Timeout
    )
    
    $startTime = Get-Date
    $spinner = @('⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏')
    $spinnerIndex = 0
    
    while ((Get-Date) - $startTime -lt [TimeSpan]::FromSeconds($Timeout)) {
        $status = Get-CompileStatus -RequestId $RequestId
        
        if ($status) {
            switch ($status.status) {
                "completed" {
                    return $status
                }
                "failed" {
                    return $status
                }
                "pending" {
                    Write-Host "`r   $($spinner[$spinnerIndex]) Waiting in queue..." -NoNewline
                }
                "running" {
                    Write-Host "`r   $($spinner[$spinnerIndex]) Compiling...       " -NoNewline
                }
            }
        }
        
        $spinnerIndex = ($spinnerIndex + 1) % $spinner.Length
        Start-Sleep -Seconds 2
    }
    
    Write-Host ""
    throw "Compile request timed out after $Timeout seconds"
}

function Format-CompileResult {
    param($Result)
    
    Write-Host ""
    Write-Host "════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host " Verse 编译结果" -ForegroundColor White
    Write-Host "════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
    
    if ($Result.success) {
        Write-Host " 状态: " -NoNewline
        Write-Host "✅ 编译成功" -ForegroundColor Green
    } else {
        Write-Host " 状态: " -NoNewline
        Write-Host "❌ 编译失败" -ForegroundColor Red
    }
    
    Write-Host " 错误数: $($Result.error_count)"
    Write-Host " 警告数: $($Result.warning_count)"
    
    if ($Result.errors -and $Result.errors.Count -gt 0) {
        Write-Host ""
        Write-Host " 错误详情:" -ForegroundColor Red
        foreach ($err in $Result.errors) {
            Write-Host "   • $err" -ForegroundColor Red
        }
    }
    
    if ($Result.warnings -and $Result.warnings.Count -gt 0) {
        Write-Host ""
        Write-Host " 警告详情:" -ForegroundColor Yellow
        foreach ($warn in $Result.warnings) {
            Write-Host "   • $warn" -ForegroundColor Yellow
        }
    }
    
    Write-Host "════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
}

# ============ 主流程 ============

try {
    Write-Host ""
    Write-Host "🔨 Verse Remote Compile" -ForegroundColor Magenta
    Write-Host ""
    
    # 1. 获取分支信息
    Write-Step "检测 Git 状态"
    $branch = Get-CurrentBranch
    Write-Host "   Branch: $branch"
    
    $repoInfo = Get-RepoInfo
    Write-Host "   Repo: $($repoInfo.Owner)/$($repoInfo.Repo)"
    
    # 2. 推送代码
    if (-not $NoPush) {
        Write-Step "同步代码到 Git"
        if (Test-UnpushedCommits -Branch $branch) {
            Push-Branch -Branch $branch
            Write-Success "代码已推送"
        } else {
            Write-Host "   Already up to date"
        }
    }
    
    $commit = Get-CurrentCommit
    Write-Host "   Commit: $($commit.Substring(0, 8))"
    
    # 3. 发送编译请求
    Write-Step "发送编译请求"
    $response = Send-CompileRequest -Branch $branch -Commit $commit -Owner $repoInfo.Owner -Repo $repoInfo.Repo
    
    if (-not $response.request_id) {
        throw "Server did not return request_id"
    }
    
    Write-Host "   Request ID: $($response.request_id)"
    Write-Success "请求已发送"
    
    # 4. 等待结果
    if ($NoWait) {
        Write-Host ""
        Write-Host "📋 异步模式：请稍后查询结果" -ForegroundColor Yellow
        Write-Host "   curl $STATUS_ENDPOINT/$($response.request_id)"
        exit 0
    }
    
    Write-Step "等待编译结果"
    $result = Wait-CompileResult -RequestId $response.request_id -Timeout $Timeout
    
    # 5. 显示结果
    Format-CompileResult -Result $result
    
    # 6. 设置退出码
    if ($result.success) {
        exit 0
    } else {
        exit 1
    }
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
