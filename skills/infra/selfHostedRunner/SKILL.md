---
name: selfHostedRunner
description: GitHub Actions Self-Hosted Runner 管理 - 安装、配置、运维
version: 1.0.0
---

# Self-Hosted Runner（自托管运行器）

> **类型**: 基础设施（Infrastructure）  
> **职责**: 在自有服务器上运行 GitHub Actions 工作流

---

## When to Use This Skill

当你需要：

- 在自有服务器上运行 GitHub Actions 工作流
- 需要比 GitHub 托管 runner 更多的资源或特殊环境
- 需要访问私有网络资源
- 长时间运行的工作流（超过 6 小时）
- 自定义硬件或软件配置

---

## 快速参考

### 在 Workflow 中使用 Self-Hosted Runner

```yaml
jobs:
  build:
    runs-on: [self-hosted, linux, x64, tencent-cloud]
    steps:
      - uses: actions/checkout@v4
      - name: Build
        run: echo "Running on self-hosted runner"
```

### 常用标签组合

| 标签组合 | 说明 |
|---------|------|
| `[self-hosted]` | 任意 self-hosted runner |
| `[self-hosted, linux]` | Linux self-hosted runner |
| `[self-hosted, linux, x64]` | x64 Linux runner |
| `[self-hosted, tencent-cloud]` | 腾讯云服务器上的 runner |

---

## 安装指南

### 方式一：使用安装脚本（推荐）

1. **SSH 到目标服务器**
   ```bash
   ssh -i ~/.ssh/tencent-agent.pem ubuntu@193.112.183.143
   ```

2. **设置环境变量**
   ```bash
   # 设置 GitHub PAT（需要 repo 权限）
   export RUNNER_CFG_PAT="ghp_xxxxxxxxxxxxxxxxxxxx"
   
   # 可选：自定义配置
   export RUNNER_NAME="my-runner"
   export RUNNER_LABELS="self-hosted,linux,x64,custom-label"
   ```

3. **下载并运行安装脚本**
   ```bash
   curl -O https://raw.githubusercontent.com/TeamFlint-Dev/vibe-coding-cn/main/tools/setup-github-runner.sh
   chmod +x setup-github-runner.sh
   ./setup-github-runner.sh
   ```

### 方式二：手动安装

1. **下载 Runner**
   ```bash
   RUNNER_VERSION="2.321.0"
   mkdir -p /opt/actions-runner && cd /opt/actions-runner
   curl -O -L "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
   tar xzf "./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
   ```

2. **获取注册 Token**
   - 访问 https://github.com/OWNER/REPO/settings/actions/runners
   - 点击 "New self-hosted runner"
   - 复制显示的 token

3. **配置 Runner**
   ```bash
   ./config.sh \
       --url https://github.com/OWNER/REPO \
       --token YOUR_TOKEN \
       --name "runner-name" \
       --labels "self-hosted,linux,x64" \
       --work "_work" \
       --unattended
   ```

4. **安装为服务**
   ```bash
   sudo ./svc.sh install
   sudo ./svc.sh start
   ```

---

## 运维手册

### 服务管理

```bash
# 服务名格式: actions.runner.{owner}-{repo}.{runner-name}.service
SERVICE_NAME="actions.runner.TeamFlint-Dev-vibe-coding-cn.tencent-cloud-runner.service"

# 查看状态
sudo systemctl status $SERVICE_NAME

# 启动/停止/重启
sudo systemctl start $SERVICE_NAME
sudo systemctl stop $SERVICE_NAME
sudo systemctl restart $SERVICE_NAME

# 使用 svc.sh（在 runner 目录下）
cd /opt/actions-runner
sudo ./svc.sh status
sudo ./svc.sh start
sudo ./svc.sh stop
```

### 日志查看

```bash
# 实时查看 systemd 日志
sudo journalctl -u $SERVICE_NAME -f

# 查看最近 100 行
sudo journalctl -u $SERVICE_NAME -n 100

# 查看 runner 诊断日志
ls /opt/actions-runner/_diag/
tail -f /opt/actions-runner/_diag/Runner_*.log
```

### 更新 Runner

```bash
cd /opt/actions-runner

# 1. 停止服务
sudo ./svc.sh stop

# 2. 下载新版本
RUNNER_VERSION="2.322.0"  # 替换为最新版本
curl -O -L "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
tar xzf "./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"

# 3. 重启服务
sudo ./svc.sh start
```

### 移除 Runner

```bash
cd /opt/actions-runner

# 1. 停止并卸载服务
sudo ./svc.sh stop
sudo ./svc.sh uninstall

# 2. 获取移除 token
export RUNNER_CFG_PAT="your-github-pat"
REMOVAL_TOKEN=$(curl -s -X POST \
    -H "Authorization: token ${RUNNER_CFG_PAT}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/OWNER/REPO/actions/runners/remove-token" \
    | jq -r '.token')

# 3. 移除注册
./config.sh remove --token "${REMOVAL_TOKEN}"
```

---

## 故障排查

### Runner 离线

1. **检查服务状态**
   ```bash
   sudo systemctl status $SERVICE_NAME
   ```

2. **检查网络连接**
   ```bash
   curl -v https://api.github.com/zen
   curl -v https://vstoken.actions.githubusercontent.com/_apis/health
   ```

3. **检查日志**
   ```bash
   sudo journalctl -u $SERVICE_NAME --since "1 hour ago"
   ```

### Job 执行失败

1. **检查工作目录权限**
   ```bash
   ls -la /opt/actions-runner/_work/
   ```

2. **检查磁盘空间**
   ```bash
   df -h
   ```

3. **清理工作目录**
   ```bash
   rm -rf /opt/actions-runner/_work/*
   ```

### 代理配置（如需要）

```bash
# 在 .env 文件中配置代理
cat > /opt/actions-runner/.env << EOF
http_proxy=http://proxy.example.com:8080
https_proxy=http://proxy.example.com:8080
no_proxy=localhost,127.0.0.1
EOF
```

---

## 安全最佳实践

### PAT 权限最小化

| 场景 | 所需权限 |
|------|----------|
| 仓库级 Runner | `repo` |
| 组织级 Runner | `admin:org`, `repo` |

### Runner 标签策略

```bash
# 使用描述性标签
--labels "self-hosted,linux,x64,tencent-cloud,production"

# 环境标签
--labels "self-hosted,staging"  # 或
--labels "self-hosted,production"
```

### 工作目录隔离

```bash
# 每个仓库使用独立工作目录
./config.sh --work "/opt/actions-runner/_work/repo-name"
```

---

## 相关链接

- [GitHub 官方文档: Self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners)
- [Runner 发布版本](https://github.com/actions/runner/releases)
- [服务器配置文件](.secrets/tencent-runner-config.md)

---

## 本仓库配置

| 配置项 | 值 |
|--------|-----|
| **服务器** | 193.112.183.143（腾讯云 Ubuntu 22.04） |
| **Runner 名称** | `tencent-cloud-runner` |
| **Runner 标签** | `self-hosted, linux, x64, tencent-cloud` |
| **安装目录** | `/opt/actions-runner/` |
| **管理页面** | [Runner 设置](https://github.com/TeamFlint-Dev/vibe-coding-cn/settings/actions/runners) |
