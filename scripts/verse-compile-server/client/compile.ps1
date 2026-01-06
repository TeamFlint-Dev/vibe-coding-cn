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
                Write-Host "========================================" -ForegroundColor Green
                Write-Host "  编译完成!" -ForegroundColor Green
                Write-Host "========================================" -ForegroundColor Green
                
                if ($status.result) {
                    $result = $status.result
                    Write-Host "  错误数: $($result.error_count)" -ForegroundColor $(if ($result.error_count -gt 0) { "Red" } else { "Green" })
                    Write-Host "  警告数: $($result.warning_count)" -ForegroundColor $(if ($result.warning_count -gt 0) { "Yellow" } else { "Green" })
                    
                    if ($result.errors -and $result.errors.Count -gt 0) {
                        Write-Host ""
                        Write-Host "错误列表:" -ForegroundColor Red
                        foreach ($err in $result.errors) {
                            Write-Host "  - $err" -ForegroundColor Red
                        }
                    }
                }
                
                if ($status.result.error_count -gt 0) {
                    exit 1
                } else {
                    exit 0
                }
            }
            elseif ($status.status -eq "failed") {
                Write-Host ""
                Write-Host "编译失败!" -ForegroundColor Red
                
                if ($status.errors -and $status.errors.Count -gt 0) {
                    Write-Host ""
                    Write-Host "错误列表:" -ForegroundColor Red
                    foreach ($err in $status.errors) {
                        Write-Host "  - $err" -ForegroundColor Red
                    }
                }
                
                Write-Host "  错误数: $($status.error_count)" -ForegroundColor Red
                Write-Host "  警告数: $($status.warning_count)" -ForegroundColor Yellow
                exit 1
            }
        }
        
        Start-Sleep -Seconds 2
    }
} else {
    # 不等待，输出查询命令
    Write-Host "编译任务已提交，使用以下命令查询状态:" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  curl $Server/verse/status/$requestId" -ForegroundColor White
    Write-Host ""
    Write-Host "或重新运行并添加 -Wait 参数等待结果" -ForegroundColor Gray
}
