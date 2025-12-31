# Control Hub 快速开始

> 中控服务器 - 5 分钟部署

### 1. 准备 PAT

需要两种 PAT：

| 类型 | 用途 | 权限 |
|------|------|------|
| Bot PAT | 触发 dispatch、发系统评论 | `repo` |
| User PAT | @ copilot 请求修复 | `repo` |

> ⚠️ User PAT 必须是真人账号，不能是 Bot 账号

### 2. 上传代码到服务器

```bash
# 本地执行
scp -P 22 scripts/webhook-server/*.py root@your-server:/root/webhook/
```

### 3. 配置环境变量

```bash
# 服务器上
cd /root/webhook
cat > .env << 'EOF'
GITHUB_PAT=ghp_your_bot_token
GITHUB_USER_PATS=user1:ghp_xxx,user2:ghp_yyy
WEBHOOK_SECRET=your_webhook_secret
CALLBACK_SECRET=your_callback_secret
MAX_RETRY_COUNT=5
NOTIFY_USER=your_username
REPO_OWNER=your_org
REPO_NAME=your_repo
PORT=8080
EOF
```

### 4. 启动服务

```bash
# 直接运行测试
python3 webhook_server.py

# 或使用 systemd
sudo systemctl start webhook
```

### 5. 配置 GitHub

#### Webhook 配置
- URL: `http://your-server:8080/webhook`
- Secret: 与 `.env` 中 `WEBHOOK_SECRET` 一致
- Events: `Pull requests`, `Issue comments`

#### GitHub Secrets（必须配置）

在 GitHub 仓库 → Settings → Secrets and variables → Actions 中添加：

| Secret 名称 | 值 | 说明 |
|------------|-----|------|
| `CALLBACK_URL` | `http://193.112.183.143:19527/callback` | Hub 回调地址 |
| `CALLBACK_SECRET` | `cb_secret_2026` | 回调签名密钥，与服务器 `.env` 一致 |
| `RUNNER_PROXY` | `http://127.0.0.1:10808` | Self-hosted runner 代理地址 |

> ⚠️ **RUNNER_PROXY 说明**：
> - 用于 self-hosted runner 访问 GitHub API（下载 actions 等）
> - 服务器 IP 已通过 `NO_PROXY` 排除，callback 会直连
> - 如果你的 runner 在国外或网络良好，可以不配置此项

### 6. 验证

```bash
# 健康检查
curl http://your-server:8080/health

# 查看账号状态
curl http://your-server:8080/accounts
```

---

## 工作流程验证

1. 创建一个包含 `.verse` 文件的 PR
2. 观察 Hub 日志：`journalctl -u webhook -f`
3. 预期看到：
   - `Received GitHub event: pull_request`
   - `Created task task-xxx for PR #N`
   - `Callback received: task=task-xxx, result=...`

---

## 常用命令

```bash
# 查看服务状态
sudo systemctl status webhook

# 查看实时日志
journalctl -u webhook -f

# 重启服务
sudo systemctl restart webhook

# 查看任务状态
curl http://localhost:8080/status/task-xxx

# 查看统计
curl http://localhost:8080/stats
```
