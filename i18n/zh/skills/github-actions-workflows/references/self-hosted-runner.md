# Self-Hosted Runner 配置

## 概述

Self-Hosted Runner 允许在本地机器上执行 GitHub Actions 工作流，适用于：
- 需要访问本地资源（如 UEFN、数据库）
- 需要特定硬件（GPU、大内存）
- 需要持久化环境（避免重复安装依赖）

## 安装配置

### Windows 安装

1. **下载 Runner**
   - 进入仓库 Settings → Actions → Runners → New self-hosted runner
   - 选择 Windows x64
   - 按照页面指示下载并解压

2. **配置 Runner**
```powershell
cd E:\github-actions-runner

# 配置（使用仓库提供的 token）
.\config.cmd --url https://github.com/{owner}/{repo} --token <TOKEN>

# 设置标签
.\config.cmd --labels self-hosted,windows,verse-builder
```

3. **启动 Runner**
```powershell
# 交互模式（调试用）
.\run.cmd

# 作为服务安装
.\svc.sh install
.\svc.sh start
```

### 标签配置

```yaml
# 工作流中指定 Runner
runs-on: [self-hosted, windows, verse-builder]
```

**推荐标签：**
- `self-hosted` - 必需，标识非 GitHub 托管
- `windows` / `linux` / `macos` - 操作系统
- 自定义标签：`verse-builder`, `gpu`, `high-memory` 等

## 工作流配置

### 基础模板

```yaml
name: Local Build

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: [self-hosted, windows, verse-builder]
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run Local Build
        shell: powershell
        run: |
          # 可以访问本地文件系统
          $projectPath = "E:\Game\MyProject"
          
          # 可以使用本地安装的工具
          & "E:\Tools\build.exe" --project $projectPath
```

### 环境变量

```yaml
env:
  # 定义本地路径
  LOCAL_PROJECT: "E:\\Game\\FishTycoon"
  BUILD_TOOL: "E:\\Tools\\verse-cli"

jobs:
  build:
    runs-on: [self-hosted, windows]
    steps:
      - name: Build
        run: |
          Write-Host "Project: ${{ env.LOCAL_PROJECT }}"
```

### 条件执行

```yaml
jobs:
  build:
    # 仅在特定 Runner 可用时执行
    if: github.event.inputs.use_local_runner == 'true'
    runs-on: [self-hosted, windows]
```

## 本地资源访问

### 文件系统

```powershell
# 访问本地项目
$versePath = "E:\Game\FishTycoon\Content\Verse"
Get-ChildItem $versePath -Recurse -Filter "*.verse"

# 复制文件到工作目录
Copy-Item "$versePath\*" -Destination "${{ github.workspace }}\Verse" -Recurse
```

### TCP 服务

```powershell
# 检查本地服务是否运行
$tcp = New-Object System.Net.Sockets.TcpClient
try {
    $tcp.Connect("127.0.0.1", 1962)
    Write-Host "Service is running"
    $tcp.Close()
} catch {
    Write-Host "::error::Service not available"
    exit 1
}
```

### 本地数据库

```powershell
# 连接本地 PostgreSQL
$env:PGPASSWORD = "localpassword"
psql -h localhost -U postgres -d mydb -c "SELECT version();"
```

## 安全考虑

### 工作目录隔离

```yaml
jobs:
  build:
    runs-on: [self-hosted, windows]
    defaults:
      run:
        # 使用隔离的工作目录
        working-directory: ${{ github.workspace }}
```

### 清理工作目录

```yaml
steps:
  - name: Cleanup
    if: always()
    shell: powershell
    run: |
      # 清理临时文件
      Remove-Item -Path "${{ github.workspace }}\temp\*" -Recurse -Force -ErrorAction SilentlyContinue
```

### 敏感信息处理

```yaml
steps:
  - name: Use Secret
    env:
      # 敏感信息通过 secrets 传递，不硬编码
      API_KEY: ${{ secrets.LOCAL_API_KEY }}
    run: |
      # 使用环境变量
      & myapp.exe --api-key $env:API_KEY
```

## 故障排查

### Runner 离线

```powershell
# 检查 Runner 状态
cd E:\github-actions-runner
.\run.cmd

# 查看日志
Get-Content .\_diag\Runner*.log -Tail 50
```

### 权限问题

```powershell
# 确保 Runner 用户有权限访问目标路径
icacls "E:\Game\FishTycoon" /grant "RunnerUser:(OI)(CI)F"
```

### 工作流卡住

```powershell
# 查看运行中的进程
Get-Process | Where-Object { $_.ProcessName -like "*runner*" }

# 强制终止
Stop-Process -Name "Runner.Worker" -Force
```

## 高级配置

### 多 Runner 池

```yaml
# 为不同任务配置不同 Runner
jobs:
  fast-build:
    runs-on: [self-hosted, ssd-runner]
    
  gpu-task:
    runs-on: [self-hosted, gpu-runner]
```

### 并发控制

```yaml
# 限制并发执行
concurrency:
  group: local-build-${{ github.ref }}
  cancel-in-progress: true
```

### 超时设置

```yaml
jobs:
  build:
    runs-on: [self-hosted, windows]
    timeout-minutes: 30  # 防止任务无限挂起
```

## 维护

### 更新 Runner

```powershell
# 停止 Runner
.\svc.sh stop

# 下载新版本并解压
# ...

# 重新配置（保留现有配置）
.\config.cmd --url https://github.com/{owner}/{repo} --token <NEW_TOKEN>

# 启动
.\svc.sh start
```

### 日志轮转

```powershell
# 清理旧日志
Get-ChildItem "_diag" -Filter "*.log" | 
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | 
    Remove-Item
```

### 监控

```powershell
# 简单的健康检查脚本
while ($true) {
    $process = Get-Process -Name "Runner.Listener" -ErrorAction SilentlyContinue
    if (-not $process) {
        Write-Host "Runner is down! Restarting..."
        Start-Process -FilePath ".\run.cmd" -WorkingDirectory "E:\github-actions-runner"
    }
    Start-Sleep -Seconds 60
}
```
