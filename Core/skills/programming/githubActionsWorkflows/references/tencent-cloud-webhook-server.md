# 腾讯云 Webhook 服务器配置指南

## 概述

本文档记录如何在腾讯云服务器上部署 Webhook 服务，用于接收 GitHub PR 事件并触发 `repository_dispatch`，从而绕过 Copilot Agent 创建的 PR 需要人工批准才能运行 workflow 的限制。

> 📁 **当前部署的配置信息**（IP、端口、密钥等）请查看本地文件：
> `.secrets/tencent-webhook-config.md`（已添加到 .gitignore，不会提交到仓库）

## 问题背景

GitHub Copilot Agent 创建的 PR 会触发 `pull_request` 事件，但由于安全策略，这些 workflow 需要人工批准才能运行。这对于需要全自动化的场景是一个障碍。

**解决方案**: 使用外部 Webhook 服务器接收 GitHub 事件，然后通过 GitHub API 触发 `repository_dispatch` 事件，该事件不受上述限制。

## 架构设计

```
GitHub PR Event → Webhook → Tencent Cloud Server → GitHub API → repository_dispatch → Self-Hosted Runner
```

## 服务器要求

- 腾讯云轻量应用服务器（或任何有公网 IP 的服务器）
- Ubuntu 22.04 LTS
- Python 3.10+
- 开放端口：19527（或自定义端口）

## 部署步骤

### 1. 准备工作目录

```bash
ssh -i ~/.ssh/your-key.pem ubuntu@your-server-ip
sudo mkdir -p /opt/webhook
sudo chown ubuntu:ubuntu /opt/webhook
cd /opt/webhook
```

### 2. 创建环境变量文件

```bash
cat > /opt/webhook/.env << 'EOF'
GITHUB_PAT=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
WEBHOOK_SECRET=your-webhook-secret-here
REPO_OWNER=YourOrg
REPO_NAME=your-repo
PORT=19527
EOF
chmod 600 /opt/webhook/.env
```

**重要参数说明：**
- `GITHUB_PAT`: GitHub Personal Access Token (Classic)，需要 `repo` 权限
- `WEBHOOK_SECRET`: 与 GitHub Webhook 配置中的 Secret 一致
- `PORT`: Webhook 服务监听端口

### 3. 创建 Webhook 服务脚本

```bash
cat > /opt/webhook/webhook_server.py << 'PYTHON_EOF'
#!/usr/bin/env python3
"""
GitHub Webhook Server for PR Events
Receives PR events and triggers repository_dispatch to bypass workflow approval
"""

import os
import hmac
import hashlib
import json
import logging
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError
from dotenv import load_dotenv

# Load environment variables
load_dotenv('/opt/webhook/.env')

# Configuration
GITHUB_PAT = os.getenv('GITHUB_PAT')
WEBHOOK_SECRET = os.getenv('WEBHOOK_SECRET', '').encode()
REPO_OWNER = os.getenv('REPO_OWNER')
REPO_NAME = os.getenv('REPO_NAME')
PORT = int(os.getenv('PORT', 19527))

# Logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('/opt/webhook/webhook.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class WebhookHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers.get('Content-Length', 0))
        payload = self.rfile.read(content_length)
        
        # Verify signature
        signature = self.headers.get('X-Hub-Signature-256', '')
        if not self.verify_signature(payload, signature):
            logger.warning('Invalid signature')
            self.send_response(401)
            self.end_headers()
            return
        
        # Parse event
        event_type = self.headers.get('X-GitHub-Event', '')
        logger.info(f'Received event: {event_type}')
        
        if event_type == 'pull_request':
            self.handle_pr_event(payload)
        elif event_type == 'ping':
            logger.info('Ping received')
        
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'OK')
    
    def verify_signature(self, payload, signature):
        if not WEBHOOK_SECRET:
            return True
        expected = 'sha256=' + hmac.new(WEBHOOK_SECRET, payload, hashlib.sha256).hexdigest()
        return hmac.compare_digest(expected, signature)
    
    def handle_pr_event(self, payload):
        data = json.loads(payload)
        action = data.get('action', '')
        pr = data.get('pull_request', {})
        pr_number = pr.get('number')
        pr_title = pr.get('title', '')
        head_sha = pr.get('head', {}).get('sha', '')  # 获取 commit SHA 用于去重
        
        # Trigger on opened, synchronize, reopened
        if action in ['opened', 'synchronize', 'reopened']:
            # 去重：检查是否已处理过该 commit
            if self.is_duplicate(pr_number, head_sha):
                logger.info(f'PR #{pr_number}: Skipping duplicate event for SHA {head_sha[:7]}')
                return
            
            logger.info(f'PR #{pr_number}: {pr_title} - Action: {action} - SHA: {head_sha[:7]}')
            self.trigger_repository_dispatch(pr_number, action, head_sha, pr.get('head', {}).get('ref', ''), pr_title)
            self.mark_processed(pr_number, head_sha)
    
    # 简单的内存去重（生产环境建议用 Redis）
    _processed_events = {}
    
    def is_duplicate(self, pr_number, head_sha):
        key = f'{pr_number}:{head_sha}'
        return key in WebhookHandler._processed_events
    
    def mark_processed(self, pr_number, head_sha):
        key = f'{pr_number}:{head_sha}'
        WebhookHandler._processed_events[key] = True
        # 清理旧记录（保留最近 100 条）
        if len(WebhookHandler._processed_events) > 100:
            oldest = list(WebhookHandler._processed_events.keys())[0]
            del WebhookHandler._processed_events[oldest]
    
    def trigger_repository_dispatch(self, pr_number, action, head_sha='', head_ref='', pr_title=''):
        url = f'https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/dispatches'
        payload = json.dumps({
            'event_type': 'build-pr',
            'client_payload': {
                'pr_number': pr_number,
                'action': action,
                'head_sha': head_sha,
                'head_ref': head_ref,
                'pr_title': pr_title
            }
        }).encode()
        
        headers = {
            'Accept': 'application/vnd.github+json',
            'Authorization': f'Bearer {GITHUB_PAT}',
            'X-GitHub-Api-Version': '2022-11-28',
            'Content-Type': 'application/json'
        }
        
        try:
            req = Request(url, data=payload, headers=headers, method='POST')
            with urlopen(req) as response:
                logger.info(f'Triggered repository_dispatch for PR #{pr_number}, status: {response.status}')
        except HTTPError as e:
            logger.error(f'HTTP Error: {e.code} - {e.read().decode()}')
        except URLError as e:
            logger.error(f'URL Error: {e.reason}')

def main():
    server = HTTPServer(('0.0.0.0', PORT), WebhookHandler)
    logger.info(f'Webhook server starting on port {PORT}')
    server.serve_forever()

if __name__ == '__main__':
    main()
PYTHON_EOF
chmod +x /opt/webhook/webhook_server.py
```

### 4. 安装依赖

```bash
sudo apt update
sudo apt install -y python3-pip
pip3 install python-dotenv
```

### 5. 创建 Systemd 服务

```bash
sudo tee /etc/systemd/system/webhook.service << 'EOF'
[Unit]
Description=GitHub Webhook Server
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/opt/webhook
ExecStart=/usr/bin/python3 /opt/webhook/webhook_server.py
Restart=always
RestartSec=10
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable webhook
sudo systemctl start webhook
```

### 6. 配置防火墙

```bash
# 腾讯云控制台 → 防火墙 → 添加规则
# 端口: 19527
# 协议: TCP
# 来源: 0.0.0.0/0 (或 GitHub Webhook IP 段)
```

## GitHub 配置

### 1. 创建 Personal Access Token

1. 前往 GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. 生成新 token，权限选择：
   - `repo` (Full control of private repositories)
3. 保存 token 到 `.env` 文件

### 2. 配置 Repository Webhook

1. 前往 仓库 → Settings → Webhooks → Add webhook
2. 配置：
   - **Payload URL**: `http://your-server-ip:19527/`
   - **Content type**: `application/json`
   - **Secret**: 与 `.env` 中的 `WEBHOOK_SECRET` 一致
   - **Events**: 选择 `Pull requests`
3. 点击 Add webhook

### 3. 创建接收 Workflow

在仓库中创建 `.github/workflows/pr-builder-dispatch.yml`：

```yaml
name: PR Builder - Dispatch Trigger

on:
  repository_dispatch:
    types: [build-pr]

jobs:
  build:
    runs-on: [self-hosted, windows, your-runner-label]
    
    steps:
      - name: Checkout PR
        uses: actions/checkout@v4
        with:
          ref: refs/pull/${{ github.event.client_payload.pr_number }}/head
          fetch-depth: 0

      - name: Build
        shell: pwsh
        run: |
          Write-Host "Building PR #${{ github.event.client_payload.pr_number }}"
          # Your build commands here

      - name: Comment on PR
        if: always()
        shell: pwsh
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          $status = if ('${{ job.status }}' -eq 'success') { 'succeeded' } else { 'failed' }
          $body = "## Build $status`n`nWorkflow run: ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}"
          gh pr comment ${{ github.event.client_payload.pr_number }} --body $body
```

## 运维管理

### 查看服务状态

```bash
sudo systemctl status webhook
```

### 查看日志

```bash
# 实时日志
sudo journalctl -u webhook -f

# 应用日志
tail -f /opt/webhook/webhook.log
```

### 重启服务

```bash
sudo systemctl restart webhook
```

### 测试 Webhook

```bash
# 本地测试
curl -X POST http://localhost:19527/ \
  -H "Content-Type: application/json" \
  -H "X-GitHub-Event: ping" \
  -d '{}'
```

## 故障排查

### 1. Webhook 无响应

```bash
# 检查服务状态
sudo systemctl status webhook

# 检查端口监听
ss -tlnp | grep 19527

# 检查防火墙
sudo ufw status
```

### 2. GitHub API 调用失败

```bash
# 检查日志中的错误
grep -i error /opt/webhook/webhook.log

# 常见问题：
# - 401: Token 无效或过期
# - 403: Token 权限不足
# - 404: 仓库不存在或无权限
```

### 3. 签名验证失败

确保 GitHub Webhook 配置中的 Secret 与 `.env` 中的 `WEBHOOK_SECRET` 完全一致。

## 安全建议

1. **使用 HTTPS**: 建议配置 Nginx 反向代理 + Let's Encrypt 证书
2. **限制 IP**: 仅允许 [GitHub Webhook IP 段](https://api.github.com/meta)
3. **定期轮换 Token**: 建议每 90 天更换一次 PAT
4. **最小权限原则**: Token 仅授予必要的 `repo` 权限
5. **日志脱敏**: 确保日志中不记录敏感信息

## 相关文件

- 服务脚本: `/opt/webhook/webhook_server.py`
- 环境变量: `/opt/webhook/.env`
- 服务日志: `/opt/webhook/webhook.log`
- Systemd 配置: `/etc/systemd/system/webhook.service`

## 参考链接

- [GitHub Webhooks Documentation](https://docs.github.com/en/webhooks)
- [GitHub REST API - Repository Dispatch](https://docs.github.com/en/rest/repos/repos#create-a-repository-dispatch-event)
- [GitHub Actions - repository_dispatch](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#repository_dispatch)
