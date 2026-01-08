# 云服务器环境说明

本文档描述云服务器上已部署的服务和环境配置，供 Agent 参考。

## 服务器信息

| 项目 | 值 |
|------|-----|
| IP | 193.112.183.143 |
| SSH 端口 | 22 |
| 用户 | ubuntu |
| SSH 密钥 | `~/.ssh/tencent-agent.pem` |

## 已部署服务

### 1. Webhook 服务

- **端口**: 19527
- **路径**: `/opt/webhook/`
- **服务**: `systemctl status webhook`
- **功能**: GitHub Webhook 接收、Pipeline 调度

**API 端点**:

- `POST /webhook` - GitHub 事件接收
- `POST /pipeline/ready` - Pipeline 就绪通知
- `GET /pipeline/status/<id>` - 查询 Pipeline 状态
- `GET /pipeline/list` - 列出所有 Pipeline

### 2. V2Ray 代理

- **端口**: 127.0.0.1:1080 (SOCKS5)
- **配置**: `/etc/v2ray/config.json`
- **服务**: `systemctl status v2ray`
- **管理脚本**: `/opt/v2ray/deploy-v2ray.sh`

**用途**: 解决 GitHub 等国外服务访问问题

## 网络问题排查

如果遇到 GitHub 访问慢或超时：

### 快速检查

```bash
# 1. 检查 V2Ray 状态
sudo systemctl status v2ray

# 2. 测试代理
curl -x socks5://127.0.0.1:1080 https://api.github.com

# 3. 检查 Git 代理配置
git config --global --list | grep proxy
```

### 常用修复

```bash
# 重启 V2Ray
sudo systemctl restart v2ray

# 切换节点（如果当前节点失效）
sudo /opt/v2ray/deploy-v2ray.sh switch 2

# 配置 Git 代理
git config --global http.proxy socks5://127.0.0.1:1080
git config --global https.proxy socks5://127.0.0.1:1080

# 临时使用代理
ALL_PROXY=socks5://127.0.0.1:1080 git pull
```

## Pipeline 仓库

- **路径**: `/opt/pipeline-repo`
- **用途**: 缓存仓库副本，避免频繁克隆
- **更新**: `cd /opt/pipeline-repo && git pull`

## 环境变量

服务的环境变量配置在 `/opt/webhook/.env`:

```bash
# Webhook 配置
WEBHOOK_SECRET=xxx
GH_TOKEN=xxx

# Pipeline 配置
PIPELINE_REPO_PATH=/opt/pipeline-repo
PIPELINE_SECRET=xxx
```

## SSH 连接示例

```powershell
# Windows PowerShell
ssh -i C:\Users\Administrator\.ssh\tencent-agent.pem ubuntu@193.112.183.143

# 或使用别名（如果已配置 ~/.ssh/config）
ssh tencent-agent
```
