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
| `/status/<task_id>` | GET | 查询任务状态 |
| `/accounts` | GET | 查询账号状态 |
| `/stats` | GET | 查询统计信息 |
| `/health` | GET | 健康检查 |

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

### 1. 服务器准备

```bash
# 创建目录
mkdir -p /root/webhook
cd /root/webhook

# 上传文件
scp -P 22 scripts/webhook-server/*.py user@server:/root/webhook/

# 创建 .env
cp .env.example .env
nano .env  # 填写实际值
```

### 2. Systemd 服务

```ini
# /etc/systemd/system/webhook.service
[Unit]
Description=GitHub Webhook Hub
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/webhook
EnvironmentFile=/root/webhook/.env
ExecStart=/usr/bin/python3 webhook_server.py
Restart=always
RestartSec=5

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
2. Payload URL: `http://your-server:port/webhook`
3. Content type: `application/json`
4. Secret: 与 `WEBHOOK_SECRET` 一致
5. Events: 选择 `Pull requests` 和 `Issue comments`

### 4. 验证部署

```bash
# 检查服务状态
curl http://your-server:port/health

# 查看日志
journalctl -u webhook -f
```

---

## 故障排查

### 常见问题

| 问题 | 可能原因 | 解决方案 |
|------|---------|---------|
| Copilot 不响应 | 用的是 Bot PAT | 改用 User PAT |
| 额度耗尽 | 单账号使用过多 | 配置多账号轮换 |
| 回调失败 | 签名验证失败 | 检查 CALLBACK_SECRET |
| 任务找不到 | 服务重启丢失状态 | 正常现象（内存存储） |

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
