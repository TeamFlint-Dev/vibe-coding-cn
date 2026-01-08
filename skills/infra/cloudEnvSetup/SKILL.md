---
name: cloudEnvSetup
description: 云端开发环境配置 - GitHub Secrets 管理、SSH 连接、服务器访问
version: 1.0.0
---

# Cloud Environment Setup（云端环境配置）

> **类型**: 基础设施（Infrastructure）  
> **职责**: 在云端开发环境（Codespaces、GitHub Actions）中配置密钥和服务器访问

---

## When to Use This Skill

当你需要：

- 在 **GitHub Codespaces** 中配置 SSH 访问服务器
- 在 **GitHub Actions** 中使用仓库 Secrets 连接服务器
- 配置 Webhook 服务相关的密钥
- 了解项目的 Secrets 架构和用途

---

## GitHub Secrets 清单

> ⚠️ 所有敏感信息已存储在 GitHub 仓库 Secrets 中，**永远不要硬编码这些值**

### 服务器连接类

| Secret 名称 | 类型 | 用途 |
|------------|------|------|
| `SSH_PRIVATE_KEY` | RSA 私钥 | 腾讯云服务器 SSH 认证 |
| `SERVER_IP` | IP 地址 | 腾讯云服务器地址 |
| `SSH_PORT` | 端口号 | SSH 端口（默认 22） |
| `SSH_USER` | 用户名 | SSH 登录用户（ubuntu） |

### Webhook 服务类

| Secret 名称 | 类型 | 用途 |
|------------|------|------|
| `WEBHOOK_PORT` | 端口号 | Webhook 服务端口 (19527) |
| `WEBHOOK_SECRET` | HMAC 密钥 | GitHub Webhook 签名验证 |
| `CALLBACK_SECRET` | HMAC 密钥 | Pipeline 回调验证 |
| `CALLBACK_URL` | URL | Pipeline 回调地址 |

### GitHub API 类

| Secret 名称 | 类型 | 用途 |
|------------|------|------|
| `GH_PAT_WEBHOOK` | PAT (Classic) | Webhook 服务的 GitHub API 调用 |
| `COPILOT_GITHUB_TOKEN` | Token | Copilot 相关操作 |
| `PIPELINE_SECRET` | 密钥 | 流水线认证 |

### 仓库信息类

| Secret 名称 | 值 | 用途 |
|------------|-----|------|
| `REPO_OWNER` | TeamFlint-Dev | 仓库 Owner |
| `REPO_NAME` | vibe-coding-cn | 仓库名称 |

---

## 使用指南

### 1. 在 GitHub Actions 中连接服务器

**标准 SSH 连接模板**:

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Setup SSH Key
        run: |
          mkdir -p ~/.ssh
          echo "${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa
          ssh-keyscan -H ${{ secrets.SERVER_IP }} >> ~/.ssh/known_hosts

      - name: Execute Remote Command
        run: |
          ssh -i ~/.ssh/id_rsa \
              -p ${{ secrets.SSH_PORT }} \
              ${{ secrets.SSH_USER }}@${{ secrets.SERVER_IP }} \
              "cd /opt/webhook && ./deploy.sh"
```

**使用 rsync 同步文件**:

```yaml
      - name: Sync Files to Server
        run: |
          rsync -avz -e "ssh -i ~/.ssh/id_rsa -p ${{ secrets.SSH_PORT }}" \
                ./dist/ \
                ${{ secrets.SSH_USER }}@${{ secrets.SERVER_IP }}:/opt/webhook/
```

### 2. 在 Codespaces 中配置 SSH

**首次进入 Codespaces 时执行**:

```bash
#!/bin/bash
# 脚本: setup-ssh.sh

# 创建 SSH 目录
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# 写入私钥（需在 Codespaces Secrets 中配置 SSH_PRIVATE_KEY）
echo "$SSH_PRIVATE_KEY" > ~/.ssh/tencent-agent.pem
chmod 600 ~/.ssh/tencent-agent.pem

# 添加主机到 known_hosts
ssh-keyscan -H "$SERVER_IP" >> ~/.ssh/known_hosts 2>/dev/null

# 创建 SSH 配置
cat > ~/.ssh/config << EOF
Host tencent
    HostName $SERVER_IP
    User $SSH_USER
    Port $SSH_PORT
    IdentityFile ~/.ssh/tencent-agent.pem
    StrictHostKeyChecking no
EOF

echo "✅ SSH configured. Connect with: ssh tencent"
```

**连接服务器**:

```bash
# 方式 1: 使用别名
ssh tencent

# 方式 2: 完整命令
ssh -i ~/.ssh/tencent-agent.pem -p $SSH_PORT $SSH_USER@$SERVER_IP
```

### 3. 配置 Codespaces Secrets 访问

GitHub Codespaces 默认**不会**自动访问 Repository Secrets，需要手动配置：

**步骤**:

1. 进入仓库 **Settings** → **Secrets and variables** → **Codespaces**
2. 点击 **New repository secret** 或 **Manage repository secrets**
3. 选择要暴露给 Codespaces 的 Secrets

**推荐暴露的 Secrets**:

- `SSH_PRIVATE_KEY` - SSH 认证
- `SERVER_IP` - 服务器地址
- `SSH_PORT` - SSH 端口
- `SSH_USER` - SSH 用户
- `WEBHOOK_PORT` - Webhook 端口（调试用）

### 4. 在 Actions 中发送 Webhook 回调

```yaml
      - name: Notify Pipeline Scheduler
        run: |
          curl -X POST "http://${{ secrets.SERVER_IP }}:${{ secrets.WEBHOOK_PORT }}/callback" \
               -H "Content-Type: application/json" \
               -H "X-Callback-Secret: ${{ secrets.CALLBACK_SECRET }}" \
               -d '{
                 "task_id": "${{ github.event.client_payload.task_id }}",
                 "status": "success",
                 "output": "Build completed"
               }'
```

---

## 服务器快速参考

### 连接信息

| 配置项 | 获取方式 |
|--------|---------|
| 服务器 IP | `${{ secrets.SERVER_IP }}` |
| SSH 端口 | `${{ secrets.SSH_PORT }}` (22) |
| SSH 用户 | `${{ secrets.SSH_USER }}` (ubuntu) |
| Webhook 端口 | `${{ secrets.WEBHOOK_PORT }}` (19527) |

### 常用服务器命令

```bash
# 查看 Webhook 服务状态
sudo systemctl status webhook

# 查看实时日志
sudo journalctl -u webhook -f

# 重启 Webhook 服务
sudo systemctl restart webhook

# 查看应用日志
tail -f /opt/webhook/webhook.log

# 测试 Webhook 健康检查
curl http://localhost:19527/health
```

### 服务器路径

| 路径 | 用途 |
|------|------|
| `/opt/webhook/` | Webhook 服务主目录 |
| `/opt/webhook/.env` | 服务环境变量配置 |
| `/opt/webhook/webhook.log` | 应用日志 |
| `/opt/pipeline-repo/` | Pipeline 工作目录 |

---

## 安全最佳实践

### ✅ 推荐做法

1. **始终使用 Secrets 引用**

   ```yaml
   # Good
   ssh ${{ secrets.SSH_USER }}@${{ secrets.SERVER_IP }}
   ```

2. **限制 Secrets 作用域**
   - 只将必要的 Secrets 暴露给 Codespaces
   - 使用 Environment Secrets 隔离生产/开发环境

3. **定期轮换密钥**
   - PAT (Personal Access Token): 每 90 天
   - SSH 密钥: 每年或安全事件后
   - Webhook Secret: 服务重部署时

4. **审计 Secrets 使用**

   ```bash
   # 查看仓库 Secrets 列表
   gh secret list
   ```

### ❌ 禁止做法

1. **硬编码敏感信息**

   ```yaml
   # Bad - 永远不要这样做
   ssh ubuntu@193.112.183.143
   ```

2. **在日志中打印 Secrets**

   ```yaml
   # Bad
   echo "Password: ${{ secrets.PASSWORD }}"
   ```

3. **提交 Secrets 到代码**
   - 确保 `.secrets/` 在 `.gitignore` 中
   - 使用 `git-secrets` 或类似工具预防

---

## 故障排查

### SSH 连接失败

```bash
# 检查密钥权限
chmod 600 ~/.ssh/id_rsa

# 测试连通性
ssh -vvv -i ~/.ssh/id_rsa $SSH_USER@$SERVER_IP

# 检查防火墙
nc -zv $SERVER_IP $SSH_PORT
```

### Webhook 回调失败

```bash
# 测试端口连通性
curl -v http://$SERVER_IP:$WEBHOOK_PORT/health

# 检查签名
echo -n "payload" | openssl dgst -sha256 -hmac "$WEBHOOK_SECRET"
```

### Codespaces 中 Secrets 不可用

1. 确认已在 Codespaces Secrets 中配置
2. 重建 Codespaces（Secrets 更新后需要重建）
3. 检查环境变量：`printenv | grep -E "SSH|SERVER"`

---

## 相关 Skills

- [controlHub](../controlHub/SKILL.md) - 中控服务器详细架构
- [beadsCLI](../beadsCLI/SKILL.md) - 任务管理 CLI
- [ghAgenticWorkflows](../ghAgenticWorkflows/SKILL.md) - GitHub Agentic Workflows

---

## 更新记录

- **2026-01-03**: 初始版本，从 `.secrets/` 配置迁移
