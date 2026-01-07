# Verse Remote Compile - Agent 调用脚本
# 用法: .\compile.ps1 [-Wait] [-Timeout 300]
#
# 自动检测当前分支，发送编译请求到云端服务器

param(
    [switch]$Wait,           # 是否等待编译完成
    [int]$Timeout = 300,     # 等待超时（秒）
    [string]$Server = "http://193.112.183.143:19527"
)

$ErrorActionPreference = "Stop"

# 获取脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 获取仓库根目录（向上查找 .git）
function Get-RepoRoot {
    $current = Get-Location
    while ($current -and !(Test-Path (Join-Path $current ".git"))) {
        $current = Split-Path $current -Parent
    }
    return $current
}

# 获取当前分支
function Get-CurrentBranch {
    $branch = git rev-parse --abbrev-ref HEAD 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "错误: 无法获取当前分支，请确保在 Git 仓库中" -ForegroundColor Red
        exit 1
    }
    return $branch
}

# 获取当前 commit
function Get-CurrentCommit {
    $commit = git rev-parse HEAD 2>$null
    if ($LASTEXITCODE -ne 0) {
        return "unknown"
    }
    return $commit
}

# 发送编译请求
function Send-CompileRequest {
    param(
        [string]$Branch,
        [string]$Commit
    )
    
    $body = @{
        branch = $Branch
        commit = $Commit
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri "$Server/verse/compile" `
            -Method Post `
            -ContentType "application/json" `
            -Body $body
        return $response
    } catch {
        Write-Host "错误: 无法发送编译请求 - $_" -ForegroundColor Red
        exit 1
    }
}

# 查询编译状态
function Get-CompileStatus {
    param([string]$RequestId)
    
    try {
        $response = Invoke-RestMethod -Uri "$Server/verse/status/$RequestId" -Method Get
        return $response
    } catch {
        return $null
    }
}

# ==================== 主逻辑 ====================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Verse Remote Compile" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. 检测当前分支
$branch = Get-CurrentBranch
$commit = Get-CurrentCommit
$shortCommit = $commit.Substring(0, 7)

Write-Host "分支: " -NoNewline
Write-Host $branch -ForegroundColor Yellow
Write-Host "Commit: " -NoNewline
Write-Host $shortCommit -ForegroundColor Yellow
Write-Host "服务器: " -NoNewline
Write-Host $Server -ForegroundColor Gray
Write-Host ""

# 2. 发送编译请求
Write-Host "正在发送编译请求..." -ForegroundColor Gray
$response = Send-CompileRequest -Branch $branch -Commit $commit

$requestId = $response.request_id
Write-Host "请求已提交: " -NoNewline
Write-Host $requestId -ForegroundColor Green
Write-Host ""

# 3. 如果需要等待结果
if ($Wait) {
    Write-Host "等待编译完成 (超时: ${Timeout}s)..." -ForegroundColor Gray
    
    $startTime = Get-Date
    $lastStatus = ""
    
    while ($true) {
        $elapsed = ((Get-Date) - $startTime).TotalSeconds
        if ($elapsed -gt $Timeout) {
            Write-Host "超时: 编译未在 ${Timeout}s 内完成" -ForegroundColor Red
            exit 1
        }
        
        $status = Get-CompileStatus -RequestId $requestId
        if ($status) {
            if ($status.status -ne $lastStatus) {
                Write-Host "  状态: $($status.status)" -ForegroundColor Gray
                $lastStatus = $status.status
            }
            
            if ($status.status -eq "completed") {
                Write-Host ""
                # 根据 success 字段判断编译是否成功
                $isSuccess = $status.success -eq $true
                $errorCount = if ($null -ne $status.error_count) { $status.error_count } else { 0 }
                $warningCount = if ($null -ne $status.warning_count) { $status.warning_count } else { 0 }
                
                if ($isSuccess -and $errorCount -eq 0) {
                    Write-Host "========================================" -ForegroundColor Green
                    Write-Host "  ✓ 编译成功!" -ForegroundColor Green
                    Write-Host "========================================" -ForegroundColor Green
                } else {
                    Write-Host "========================================" -ForegroundColor Red
                    Write-Host "  ✗ 编译失败!" -ForegroundColor Red
                    Write-Host "========================================" -ForegroundColor Red
                }
                
                Write-Host "  错误数: $errorCount" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
                Write-Host "  警告数: $warningCount" -ForegroundColor $(if ($warningCount -gt 0) { "Yellow" } else { "Green" })
                
                if ($status.duration) {
                    Write-Host "  耗时: $($status.duration)" -ForegroundColor Gray
                }
                
                # 显示错误列表
                if ($status.errors -and $status.errors.Count -gt 0) {
                    Write-Host ""
                    Write-Host "错误列表:" -ForegroundColor Red
                    foreach ($err in $status.errors) {
                        Write-Host "  - $err" -ForegroundColor Red
                    }
                }
                
                # 显示警告列表
                if ($status.warnings -and $status.warnings.Count -gt 0) {
                    Write-Host ""
                    Write-Host "警告列表:" -ForegroundColor Yellow
                    foreach ($warn in $status.warnings) {
                        Write-Host "  - $warn" -ForegroundColor Yellow
                    }
                }
                
                if ($errorCount -gt 0 -or -not $isSuccess) {
                    exit 1
                } else {
                    exit 0
                }
            }
            elseif ($status.status -eq "failed") {
                Write-Host ""
                Write-Host "========================================" -ForegroundColor Red
                Write-Host "  ✗ 编译失败!" -ForegroundColor Red
                Write-Host "========================================" -ForegroundColor Red
                
                $errorCount = if ($null -ne $status.error_count) { $status.error_count } else { 0 }
                $warningCount = if ($null -ne $status.warning_count) { $status.warning_count } else { 0 }
                
                Write-Host "  错误数: $errorCount" -ForegroundColor Red
                Write-Host "  警告数: $warningCount" -ForegroundColor Yellow
                
                if ($status.duration) {
                    Write-Host "  耗时: $($status.duration)" -ForegroundColor Gray
                }
                Write-Host ""
                
                # 显示错误列表
                if ($status.errors -and $status.errors.Count -gt 0) {
                    Write-Host "错误列表:" -ForegroundColor Red
                    foreach ($err in $status.errors) {
                        Write-Host "  - $err" -ForegroundColor Red
                    }
                    Write-Host ""
                }
                
                # 显示警告列表
                if ($status.warnings -and $status.warnings.Count -gt 0) {
                    Write-Host "警告列表:" -ForegroundColor Yellow
                    foreach ($warn in $status.warnings) {
                        Write-Host "  - $warn" -ForegroundColor Yellow
                    }
                    Write-Host ""
                }
                
                # 显示原始编译输出（如果有）
                if ($status.raw_output) {
                    Write-Host "--- 编译日志 ---" -ForegroundColor Cyan
                    Write-Host $status.raw_output
                    Write-Host "--- 日志结束 ---" -ForegroundColor Cyan
                }
                
                exit 1
            }
        }
        
        Start-Sleep -Seconds 2
    }
} else {
    # 不等待，输出查询命令
    Write-Host "编译任务已提交，使用以下命令查询当前状态(一次):" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  curl $Server/verse/status/$requestId" -ForegroundColor White
    Write-Host ""
    Write-Host "或重新运行并添加 -Wait 参数等待结果" -ForegroundColor Gray
}
