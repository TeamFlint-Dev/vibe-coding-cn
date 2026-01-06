#!/usr/bin/env pwsh
<#
.SYNOPSIS
    部署 Verse Compile Server 到云服务器

.DESCRIPTION
    将 verse-compile-server 部署到云服务器，替换旧的 webhook 服务

.EXAMPLE
    ./scripts/deploy-verse-compile-server.ps1
#>

$ErrorActionPreference = "Stop"

# 配置
$ServerIP = "193.112.183.143"
$SSHUser = "ubuntu"
$SSHKey = "C:\Users\Administrator\.ssh\tencent-agent.pem"
$RemotePath = "/opt/verse-compile"
$ServiceName = "verse-compile"

$LocalServerDir = Join-Path $PSScriptRoot "verse-compile-server"

Write-Host "🚀 Deploying Verse Compile Server" -ForegroundColor Cyan
Write-Host "   Server: $ServerIP"
Write-Host "   Remote Path: $RemotePath"

# 1. 创建远程目录
Write-Host "`n📁 Creating remote directory..."
ssh -i $SSHKey "${SSHUser}@${ServerIP}" "sudo mkdir -p $RemotePath && sudo chown ${SSHUser}:${SSHUser} $RemotePath"

# 2. 复制文件
Write-Host "`n📤 Copying files..."
scp -i $SSHKey "$LocalServerDir/server.py" "${SSHUser}@${ServerIP}:${RemotePath}/"
scp -i $SSHKey "$LocalServerDir/verse-compile.service" "${SSHUser}@${ServerIP}:${RemotePath}/"
scp -i $SSHKey "$LocalServerDir/.env.example" "${SSHUser}@${ServerIP}:${RemotePath}/"

# 3. 配置 .env（如果不存在）
Write-Host "`n🔧 Configuring environment..."
$envCheck = ssh -i $SSHKey "${SSHUser}@${ServerIP}" "test -f ${RemotePath}/.env && echo 'exists' || echo 'not_exists'"

if ($envCheck -eq "not_exists") {
    Write-Host "   Creating .env from example..."
    ssh -i $SSHKey "${SSHUser}@${ServerIP}" "cp ${RemotePath}/.env.example ${RemotePath}/.env"
    Write-Host "   ⚠️  请手动编辑 ${RemotePath}/.env 填写 GITHUB_PAT" -ForegroundColor Yellow
} else {
    Write-Host "   .env already exists, skipping..."
}

# 4. 安装 systemd 服务
Write-Host "`n🔧 Installing systemd service..."
ssh -i $SSHKey "${SSHUser}@${ServerIP}" "sudo cp ${RemotePath}/verse-compile.service /etc/systemd/system/ && sudo systemctl daemon-reload && sudo systemctl enable ${ServiceName}"

# 5. 重启服务
Write-Host "`n🔄 Restarting service..."
ssh -i $SSHKey "${SSHUser}@${ServerIP}" "sudo systemctl restart ${ServiceName}"

# 6. 检查状态
Write-Host "`n📊 Checking service status..."
Start-Sleep -Seconds 2
ssh -i $SSHKey "${SSHUser}@${ServerIP}" "sudo systemctl status ${ServiceName} --no-pager"

# 7. 测试健康检查
Write-Host "`n🏥 Testing health endpoint..."
try {
    $health = Invoke-RestMethod -Uri "http://${ServerIP}:19527/health" -TimeoutSec 5
    Write-Host "   Status: $($health.status)" -ForegroundColor Green
    Write-Host "   Service: $($health.service)"
} catch {
    Write-Host "   ⚠️  Health check failed: $_" -ForegroundColor Yellow
}

Write-Host "`n✅ Deployment complete!" -ForegroundColor Green
Write-Host @"

下一步:
1. 编辑服务器上的 .env 文件，填写 GITHUB_PAT:
   ssh -i "$SSHKey" $SSHUser@$ServerIP
   sudo nano $RemotePath/.env

2. 重启服务:
   sudo systemctl restart $ServiceName

3. 查看日志:
   sudo journalctl -u $ServiceName -f
"@
