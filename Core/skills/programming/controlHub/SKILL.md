---
name: controlHub
description: 中控服务器 - GitHub 事件中转、PR 构建调度、Copilot 自动修复、多账号轮换
version: 1.0.0
---

# Control Hub（中控服务器）

> **类型**: 基础设施（Infrastructure）  
> **职责**: GitHub 事件中转、Actions 回调处理、Copilot 修复请求、多账号管理

---

## When to Use This Skill

当你需要：
- 让 Copilot 创建的 PR 自动触发构建（绕过人工批准限制）
- 构建失败后自动请求 Copilot 修复（Bot 评论无法触发 Copilot，需用人类账号）
- 管理多个 GitHub 账号轮换以分摊 Copilot 额度
- 追踪 PR 构建状态和重试次数
- 超过重试上限后自动通知人类介入

---

## 核心架构

### 系统流程图

```
┌─────────────────────────────────────────────────────────────────────┐
│                         GitHub                                       │
│  ┌──────────┐     ┌──────────────┐     ┌──────────────────────────┐ │
│  │ PR 事件   │────→│ Webhook 发送  │     │ 评论 (Copilot 可响应)    │ │
│  └──────────┘     └──────────────┘     └──────────────────────────┘ │
└───────────────────────────│───────────────────────────▲─────────────┘
                            │                           │
                            ▼                           │
┌─────────────────────────────────────────────────────────────────────┐
│                    Webhook Hub (云服务器)                            │
│                                                                      │
│   ┌─────────────┐    ┌─────────────┐    ┌──────────────────────┐   │
│   │ /webhook    │───→│ StateStore  │    │ AccountManager       │   │
│   │ 接收 GitHub │    │ 任务状态管理 │    │ 多账号 PAT 轮换       │   │
│   └─────────────┘    └──────┬──────┘    └──────────────────────┘   │
│                             │                     ▲                 │
│   ┌─────────────┐    ┌──────▼──────┐              │                 │
│   │ /callback   │───→│ Decision    │──────────────┘                 │
│   │ 接收 Actions │    │ Engine      │                                │
│   └─────────────┘    │ 决策引擎     │                                │
│                      └──────┬──────┘                                │
│                             │                                       │
│   ┌─────────────────────────▼─────────────────────────────────────┐ │
│   │                    GitHubClient                                │ │
│   │  trigger_dispatch()  |  post_comment()  |  add_label()        │ │
│   └───────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    GitHub Actions                                    │
│                                                                      │
│   ┌────────────────────────────────────────────────────────────┐   │
│   │  repository_dispatch (build-pr)                             │   │
│   │      ↓                                                      │   │
│   │  Self-hosted Runner 构建                                    │   │
│   │      ↓                                                      │   │
│   │  POST /callback (task_id, result, build_output)            │   │
│   └────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

### 核心概念

#### Task（任务）

Task 是一次构建请求的抽象，追踪从触发到完成的整个生命周期：

```python
Task = {
    task_id: "task-1735600000-abc123",  # 唯一标识
    pr_number: 42,                       # PR 编号
    head_sha: "abc123...",               # Commit SHA
    head_ref: "feature/xxx",             # 分支名
    status: "building",                  # 状态
    retry_count: 0,                      # 重试次数
    events: [...]                        # 事件历史
}
```

**任务状态流转**：
```
pending → building → success
                  ↘ failure → awaiting_fix → building (重试)
                           ↘ escalated (超过重试上限)
```

#### 决策逻辑

```python
def process_callback(task_id, result, build_output):
    if result == "success":
        # 1. Bot 发成功评论
        # 2. 添加 ready-to-merge 标签
        # 3. @ 人类审核
        
    elif result == "failure":
        if retry_count < MAX_RETRY:
            # 1. Bot 发失败系统通知
            # 2. User 发 @copilot 修复请求
            retry_count += 1
        else:
            # 1. Bot 发失败通知
            # 2. User @ 人类介入
            # 3. 添加 needs-human-review 标签
            
    elif result == "skipped":
        # Bot 发跳过通知（无 Verse 文件变更）
```

---

## 模块说明

### 1. StateStore（状态管理）

**文件**: `state_store.py`

**职责**:
- 内存存储所有任务状态
- 按 PR 追踪重试次数
- 自动清理旧任务（保留最近 200 个）

**关键接口**:
```python
store.create_task(pr_number, head_sha, head_ref, trigger_type) → task_id
store.get_task(task_id) → Task
store.update_task(task_id, status, event, event_details)
store.get_pr_retry_count(pr_number) → int
store.increment_pr_retry(pr_number) → int
```

### 2. AccountManager（账号管理）

**文件**: `account_manager.py`

**职责**:
- 管理多个 GitHub 用户账号 PAT
- 轮换账号以分摊 Copilot 额度消耗
- 检测额度错误并自动禁用问题账号
- 账号恢复（24小时后重新启用）

**配置格式**:
```bash
GITHUB_USER_PATS=user1:ghp_xxx,user2:ghp_yyy,user3:ghp_zzz
```

**关键接口**:
```python
manager.get_next_account() → GitHubAccount | None
manager.mark_account_failure(username, error_message)
manager.has_available_accounts() → bool
manager.get_stats() → dict
```

**额度错误检测**:
```python
QUOTA_ERROR_PATTERNS = [
    "rate limit exceeded",
    "secondary rate limit",
    "API rate limit",
    "quota exceeded"
]
```

### 3. GitHubClient（API 封装）

**文件**: `github_client.py`

**职责**:
- 封装所有 GitHub API 调用
- 提供统一的错误处理
- 区分 Bot PAT 和 User PAT

**关键接口**:
```python
# 使用 Bot PAT
client.trigger_dispatch(event_type, client_payload) → bool
client.post_comment_as_bot(pr_number, body) → bool
client.get_pr_info(pr_number) → dict
client.add_label(pr_number, label) → bool

# 使用 User PAT（触发 Copilot）
client.post_comment_as_user(pr_number, body, account) → bool
```

### 4. DecisionEngine（决策引擎）

**文件**: `decision_engine.py`

**职责**:
- 接收 Actions 回调，决定下一步操作
- 协调 StateStore、AccountManager、GitHubClient
- 实现重试逻辑和人类升级

**决策类型**:
```python
class ActionType(Enum):
    COMMENT_SUCCESS = "comment_success"      # 发成功评论
    COMMENT_FAILURE = "comment_failure"      # 发失败通知
    COMMENT_SKIPPED = "comment_skipped"      # 发跳过通知
    REQUEST_COPILOT_FIX = "request_copilot"  # @copilot 修复
    ESCALATE_TO_HUMAN = "escalate_human"     # @人类介入
    ADD_LABEL = "add_label"                  # 添加标签
```

---

## HTTP 端点

| 端点 | 方法 | 说明 |
|------|------|------|
| `/webhook` | POST | 接收 GitHub Webhook 事件 |
| `/callback` | POST | 接收 Actions 构建结果回调 |
| `/pipeline/ready` | POST | **Planner Agent 通知启动流水线** |
| `/pipeline/status/<id>` | GET | 查询流水线状态 |
| `/pipeline/cancel/<id>` | POST | 取消流水线 |
| `/pipeline/list` | GET | 列出所有流水线 |
| `/status/<task_id>` | GET | 查询任务状态 |
| `/accounts` | GET | 查询账号状态 |
| `/stats` | GET | 查询统计信息 |
| `/health` | GET | 健康检查 |

---

## Pipeline 通信

### pipeline-notify 工具

Agent 使用 `pipeline-notify` 命令行工具与云端服务器通信，替代不可靠的 Webhook 方式。

**工具位置**: `.github/tools/pipeline-notify.py`

**用法示例**:
```bash
# 通知调度器启动流水线（带工作分支）
python3 .github/tools/pipeline-notify.py ready \
  --pipeline-id p20260101120000 \
  --type skills-distill \
  --stages "ingest,classify,extract,assemble,validate" \
  --stage-ids "ingest:bd-abc,classify:bd-def" \
  --source-url "https://github.com/..." \
  --branch "pipeline/p20260101120000"

# 查询流水线状态
python3 .github/tools/pipeline-notify.py status --pipeline-id p001

# 取消流水线
python3 .github/tools/pipeline-notify.py cancel --pipeline-id p001
```

**环境变量**:
- `PIPELINE_SERVER_URL`: 服务器地址（默认 `http://193.112.183.143:19527`）
- `PIPELINE_SECRET`: 签名密钥（必需，与服务器配置一致）

### 分支工作流

流水线使用分支隔离工作产物，避免 Worker 直接提交到 main 分支：

```
┌─────────────────────────────────────────────────────────────┐
│  Planner Agent                                               │
│    1. 创建分支 pipeline/<pipeline_id>                        │
│    2. 创建 Beads 任务                                        │
│    3. 通知调度器（传递 --branch 参数）                        │
└───────────────────────────┬─────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  Worker Agent (每个阶段)                                     │
│    1. 接收 branch 参数                                       │
│    2. git checkout 到工作分支                                │
│    3. 执行任务、提交产物                                      │
│    4. git push 到工作分支                                    │
└───────────────────────────┬─────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│  调度器 - 流水线完成时                                       │
│    1. 检测到所有阶段完成                                     │
│    2. 自动创建 PR: pipeline/<id> → main                      │
│    3. 等待人工审查后合并                                      │
└─────────────────────────────────────────────────────────────┘
```

**优点**:
- Worker 可直接提交，无需 PR 审查
- 所有产物隔离在独立分支
- 只有最终合并需要人工审查
- 审查失败可整体回退

### /pipeline/ready 请求格式

```json
{
  "pipeline_id": "p20260101120000",
  "type": "skills-distill",
  "stages": ["ingest", "classify", "extract", "assemble", "validate"],
  "stage_ids": {
    "ingest": "bd-abc123",
    "classify": "bd-def456"
  },
  "source_url": "https://github.com/anthropics/courses",
  "branch": "pipeline/p20260101120000"
}
```

**必需字段**: `pipeline_id`, `type`, `stages`  
**可选字段**: `stage_ids`, `source_url`, `branch`

- `branch`: 工作分支名称，Worker 将提交到此分支。流水线完成时调度器会自动创建 PR。

---

## 配置说明

### 环境变量

```bash
# 必需 - Bot 操作（dispatch、系统评论）
GITHUB_PAT=ghp_bot_token

# 必需 - 用户账号（@copilot 评论）
GITHUB_USER_PATS=user1:ghp_xxx,user2:ghp_yyy

# 安全
WEBHOOK_SECRET=github_webhook_secret
CALLBACK_SECRET=actions_callback_secret
PIPELINE_SECRET=pipeline_signing_secret  # Pipeline 请求签名

# 业务配置
MAX_RETRY_COUNT=5
NOTIFY_USER=your_github_username

# 仓库
REPO_OWNER=your_org
REPO_NAME=your_repo

# 服务
PORT=8080
```

### GitHub Secrets（Actions 需要）

```yaml
CALLBACK_URL: http://your-server:port/callback
CALLBACK_SECRET: your_callback_secret
```

---

## 部署指南

### 服务器信息

> ⚠️ **重要**: 密钥和连接信息存储在 `scripts/webhook-server/.secrets`，执行服务器操作前必须先读取该文件。

**当前生产环境**:
- **服务器 IP**: `193.112.183.143`（腾讯云）
- **SSH 端口**: `22`
- **SSH 用户**: `ubuntu`（不是 root）
- **SSH 密钥**: `C:\Users\Administrator\.ssh\tencent-agent.pem`
- **Webhook 端口**: `19527`（非标准端口）
- **服务路径**: `/opt/webhook/`

### SSH 连接命令

```powershell
# Windows PowerShell 连接命令
ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143

# 执行单条命令
ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143 "命令"

# 上传文件
scp -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -P 22 本地文件 ubuntu@193.112.183.143:/opt/webhook/
```

### 防火墙配置

> ⚠️ **重要**: 服务器防火墙只允许来自 GitHub 的请求访问 Webhook 端口。

**允许的 IP 段**（GitHub Webhook 源 IP）:
- `192.30.252.0/22`
- `185.199.108.0/22`
- `140.82.112.0/20`
- `143.55.64.0/20`

**这意味着**:
1. ❌ **本地测试无效** - 你无法从本地 curl 测试 Webhook 端口
2. ❌ **直接访问 /health 无效** - 防火墙会拦截非 GitHub IP
3. ✅ **只能通过 SSH 测试** - SSH 进服务器后用 localhost 测试
4. ✅ **GitHub 事件可达** - 真实 Webhook 事件可以正常接收

### 正确的测试方法

```bash
# 1. SSH 进入服务器
ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143

# 2. 在服务器内部测试
curl http://localhost:19527/health
curl http://localhost:19527/accounts
curl http://localhost:19527/stats

# 3. 查看服务状态
sudo systemctl status webhook

# 4. 查看实时日志
sudo journalctl -u webhook -f

# 5. 查看最近日志
sudo journalctl -u webhook --since "5 minutes ago" --no-pager
```

### 常用运维命令（一行式）

```powershell
# 查看服务状态
ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143 "sudo systemctl status webhook --no-pager"

# 重启服务
ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143 "sudo systemctl restart webhook"

# 查看最近日志
ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143 "sudo journalctl -u webhook --since '5 minutes ago' --no-pager"

# 测试健康端点
ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143 "curl -s http://localhost:19527/health"

# 查看账号状态
ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143 "curl -s http://localhost:19527/accounts"

# 上传代码并重启
scp -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -P 22 scripts/webhook-server/*.py ubuntu@193.112.183.143:/opt/webhook/ ; ssh -i "C:\Users\Administrator\.ssh\tencent-agent.pem" -p 22 ubuntu@193.112.183.143 "sudo systemctl restart webhook"
```

### 1. 首次部署

```bash
# 在服务器上创建目录
sudo mkdir -p /opt/webhook
sudo chown ubuntu:ubuntu /opt/webhook

# 上传文件（从本地执行）
scp -i ~/.ssh/tencent-agent.pem -P 22 scripts/webhook-server/*.py ubuntu@193.112.183.143:/opt/webhook/

# 创建 .env
nano /opt/webhook/.env  # 填写实际值
chmod 600 /opt/webhook/.env
```

### 2. Systemd 服务

```ini
# /etc/systemd/system/webhook.service
[Unit]
Description=GitHub Webhook Hub
After=network.target

[Service]
Type=simple
User=ubuntu
Group=ubuntu
WorkingDirectory=/opt/webhook
EnvironmentFile=/opt/webhook/.env
ExecStart=/usr/bin/python3 /opt/webhook/webhook_server.py
Restart=always
RestartSec=5

# 安全限制
NoNewPrivileges=true
ProtectSystem=strict
ProtectHome=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable webhook
sudo systemctl start webhook
sudo systemctl status webhook
```

### 3. GitHub Webhook 配置

1. 进入仓库 Settings → Webhooks → Add webhook
2. Payload URL: `http://193.112.183.143:19527/webhook`
3. Content type: `application/json`
4. Secret: 与 `.env` 中 `WEBHOOK_SECRET` 一致
5. Events: 选择 `Pull requests` 和 `Issue comments`

### 4. GitHub Secrets 配置

在仓库 Settings → Secrets and variables → Actions 中添加：
- `CALLBACK_URL`: `http://193.112.183.143:19527/callback`
- `CALLBACK_SECRET`: 与 `.env` 中 `CALLBACK_SECRET` 一致

### 5. 服务器防火墙配置（iptables）

服务器使用 iptables 控制 19527 端口访问，存在专用的 `GITHUB_WEBHOOK` 链：

```bash
# 查看当前规则
sudo iptables -L GITHUB_WEBHOOK -n -v

# 查看 INPUT 链如何调用 GITHUB_WEBHOOK
sudo iptables -L INPUT -n --line-numbers | grep 19527
```

**当前配置**：全放行（由腾讯云安全组控制访问）

```bash
# 设置全放行
sudo iptables -F GITHUB_WEBHOOK
sudo iptables -A GITHUB_WEBHOOK -j ACCEPT
sudo netfilter-persistent save
```

**如需限制 IP（可选）**：

```bash
# 清空后添加 GitHub IP 白名单
sudo iptables -F GITHUB_WEBHOOK
sudo iptables -A GITHUB_WEBHOOK -s 192.30.252.0/22 -j ACCEPT
sudo iptables -A GITHUB_WEBHOOK -s 185.199.108.0/22 -j ACCEPT
sudo iptables -A GITHUB_WEBHOOK -s 140.82.112.0/20 -j ACCEPT
sudo iptables -A GITHUB_WEBHOOK -s 143.55.64.0/20 -j ACCEPT
sudo iptables -A GITHUB_WEBHOOK -j DROP  # 最后丢弃其他流量
sudo netfilter-persistent save
```

> ⚠️ **注意**：如果本地 IP 不固定且需要直接测试，使用全放行模式，由腾讯云安全组控制。

---

## 故障排查

### 常见问题

| 问题 | 可能原因 | 解决方案 |
|------|---------|---------|
| Copilot 不响应 | 用的是 Bot PAT | 改用 User PAT |
| 额度耗尽 | 单账号使用过多 | 配置多账号轮换 |
| 回调失败 | 签名验证失败 | 检查 CALLBACK_SECRET |
| 任务找不到 | 服务重启丢失状态 | 正常现象（内存存储） |
| **TCP 连接失败但 Ping 正常** | **iptables 阻止端口访问** | **检查 GITHUB_WEBHOOK 链规则** |
| **unexpected EOF** | **代理转发失败或目标不可达** | **检查直连规则和 iptables** |

### 日志关键词

```bash
# 成功触发构建
[hub] Created task task-xxx for PR #42
[hub] Callback received: task=task-xxx, result=success

# 账号问题
[account] Account user1 disabled: rate limit exceeded
[account] Rotating to next account: user2

# 人类升级
[decision] PR #42 exceeded max retries, escalating to human
```

---

## 代码位置

```
scripts/webhook-server/
├── webhook_server.py     # 主服务入口
├── state_store.py        # 状态管理
├── account_manager.py    # 账号管理
├── github_client.py      # GitHub API
├── decision_engine.py    # 决策引擎
├── __init__.py           # 模块导出
├── .env.example          # 配置模板
└── webhook.service       # Systemd 配置

.github/workflows/
└── pr-builder-dispatch.yml  # Actions 工作流
```

---

## 设计决策

### 为什么用 Hub 而不是直接让 Actions 发评论？

1. **Copilot 触发限制**: GitHub Actions Bot 的评论无法触发 Copilot Agent，必须用真人账号
2. **精细控制**: Hub 可以追踪重试次数、管理多账号、决定何时升级给人类
3. **解耦**: GitHub 事件处理和业务逻辑分离，便于扩展

### 为什么用内存而不是数据库？

1. **简单**: 无需额外依赖
2. **够用**: 只需保持运行时状态，重启后任务会重新触发
3. **性能**: 内存访问快，无 I/O 延迟

### 为什么需要多账号？

1. **额度分摊**: Copilot Agent 请求消耗月度额度
2. **容错**: 单账号出问题不影响整体
3. **自动恢复**: 账号 24 小时后自动重新启用

---

## 相关技能

与中控服务器配合使用的其他技能：

| 技能 | 路径 | 说明 |
|------|------|------|
| **gh-aw** | `../ghAgenticWorkflows/SKILL.md` | GitHub Agentic Workflows |
| **copilot-cli** | `../ghAgenticWorkflows/shared/gh-aw-raw/skills/copilot-cli/SKILL.md` | Copilot CLI 集成 |
| **github-script** | `../ghAgenticWorkflows/shared/gh-aw-raw/skills/github-script/SKILL.md` | GitHub Actions 脚本最佳实践 |
| **github-mcp-server** | `../ghAgenticWorkflows/shared/gh-aw-raw/skills/github-mcp-server/SKILL.md` | GitHub MCP 服务器配置 |
| **gh-agent-task** | `../ghAgenticWorkflows/shared/gh-aw-raw/skills/gh-agent-task/SKILL.md` | 创建 Copilot 自动任务 |
