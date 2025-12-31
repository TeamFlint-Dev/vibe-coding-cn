#!/usr/bin/env python3
"""
GitHub Webhook → repository_dispatch 转发服务

功能：
1. 当 Copilot 创建 PR 时，触发 repository_dispatch 启动构建
2. 当用户评论 /build 或 /编译 时，手动触发构建
3. 当构建失败时，以用户身份发表评论请求 Copilot 修复

这样可以绕过 Copilot 触发工作流需要人工批准的限制，
并且让 Copilot Agent 能够响应修复请求（GitHub Actions 的评论无法触发 Copilot）。
"""

import hashlib
import hmac
import json
import os
import re
import sys
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.request import Request, urlopen
from urllib.error import HTTPError, URLError

# ==================== 配置 ====================
# 从环境变量读取敏感信息
WEBHOOK_SECRET = os.environ.get("WEBHOOK_SECRET", "")
GITHUB_PAT = os.environ.get("GITHUB_PAT", "")  # 用于 repository_dispatch
GITHUB_USER_PAT = os.environ.get("GITHUB_USER_PAT", "")  # 用于以用户身份发表评论
REPO_OWNER = os.environ.get("REPO_OWNER", "TeamFlint-Dev")
REPO_NAME = os.environ.get("REPO_NAME", "vibe-coding-cn")
PORT = int(os.environ.get("PORT", "8080"))

# 手动构建命令模式
BUILD_COMMANDS = re.compile(r"^\s*(/build|/编译)\s*$", re.MULTILINE)

# ==================== 日志 ====================
def log(message: str):
    """简单日志"""
    print(f"[webhook] {message}", flush=True)

# ==================== Webhook 验证 ====================
def verify_signature(payload: bytes, signature: str) -> bool:
    """验证 GitHub webhook 签名"""
    if not WEBHOOK_SECRET:
        log("WARNING: WEBHOOK_SECRET not set, skipping signature verification")
        return True
    
    if not signature or not signature.startswith("sha256="):
        log("ERROR: Invalid signature format")
        return False
    
    expected = "sha256=" + hmac.new(
        WEBHOOK_SECRET.encode(),
        payload,
        hashlib.sha256
    ).hexdigest()
    
    return hmac.compare_digest(expected, signature)

# ==================== GitHub API ====================
def trigger_repository_dispatch(pr_number: int, pr_title: str, head_ref: str) -> bool:
    """调用 repository_dispatch API 触发工作流"""
    if not GITHUB_PAT:
        log("ERROR: GITHUB_PAT not set")
        return False
    
    url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/dispatches"
    
    payload = {
        "event_type": "build-pr",
        "client_payload": {
            "pr_number": pr_number,
            "pr_title": pr_title,
            "head_ref": head_ref
        }
    }
    
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_PAT}",
        "X-GitHub-Api-Version": "2022-11-28",
        "Content-Type": "application/json"
    }
    
    try:
        req = Request(url, data=json.dumps(payload).encode(), headers=headers, method="POST")
        with urlopen(req, timeout=30) as response:
            log(f"repository_dispatch triggered successfully (status: {response.status})")
            return True
    except HTTPError as e:
        log(f"ERROR: GitHub API returned {e.code}: {e.read().decode()}")
        return False
    except URLError as e:
        log(f"ERROR: Failed to connect to GitHub API: {e.reason}")
        return False


def post_comment_as_user(pr_number: int, body: str) -> bool:
    """以用户身份发表 PR 评论（可触发 Copilot Agent）"""
    if not GITHUB_USER_PAT:
        log("ERROR: GITHUB_USER_PAT not set - cannot post comment as user")
        return False
    
    url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/issues/{pr_number}/comments"
    
    payload = {"body": body}
    
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_USER_PAT}",
        "X-GitHub-Api-Version": "2022-11-28",
        "Content-Type": "application/json"
    }
    
    try:
        req = Request(url, data=json.dumps(payload).encode(), headers=headers, method="POST")
        with urlopen(req, timeout=30) as response:
            log(f"Comment posted successfully as user (status: {response.status})")
            return True
    except HTTPError as e:
        log(f"ERROR: GitHub API returned {e.code}: {e.read().decode()}")
        return False
    except URLError as e:
        log(f"ERROR: Failed to connect to GitHub API: {e.reason}")
        return False


def get_pr_info(pr_number: int) -> dict:
    """获取 PR 信息"""
    if not GITHUB_PAT:
        log("ERROR: GITHUB_PAT not set")
        return {}
    
    url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/pulls/{pr_number}"
    
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_PAT}",
        "X-GitHub-Api-Version": "2022-11-28"
    }
    
    try:
        req = Request(url, headers=headers, method="GET")
        with urlopen(req, timeout=30) as response:
            return json.loads(response.read().decode())
    except HTTPError as e:
        log(f"ERROR: GitHub API returned {e.code}: {e.read().decode()}")
        return {}
    except URLError as e:
        log(f"ERROR: Failed to connect to GitHub API: {e.reason}")
        return {}

# ==================== HTTP Handler ====================
class WebhookHandler(BaseHTTPRequestHandler):
    """处理 GitHub Webhook 请求"""
    
    def log_message(self, format, *args):
        """重写日志格式"""
        log(f"HTTP {args[0]}")
    
    def do_GET(self):
        """健康检查端点"""
        if self.path == "/health":
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps({"status": "ok"}).encode())
        else:
            self.send_response(404)
            self.end_headers()
    
    def do_POST(self):
        """处理 POST 请求"""
        # 读取请求体
        content_length = int(self.headers.get("Content-Length", 0))
        payload = self.rfile.read(content_length)
        
        # 路由到不同的处理器
        if self.path == "/webhook":
            self._handle_github_webhook(payload)
        elif self.path == "/copilot-request":
            self._handle_copilot_request(payload)
        else:
            self.send_response(404)
            self.end_headers()
    
    def _handle_copilot_request(self, payload: bytes):
        """处理 Copilot 修复请求 - 以用户身份发表评论"""
        # 解析 payload
        try:
            data = json.loads(payload)
        except json.JSONDecodeError as e:
            log(f"ERROR: Failed to parse JSON: {e}")
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid JSON")
            return
        
        event_type = data.get("event_type", "")
        if event_type != "copilot-fix-request":
            log(f"Ignoring copilot-request event type: {event_type}")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Event ignored")
            return
        
        pr_number = data.get("pr_number", 0)
        build_output = data.get("build_output", "Build output not available")
        head_sha = data.get("head_sha", "unknown")
        
        log(f"Received copilot-fix-request for PR #{pr_number}")
        
        # 构建评论内容 - 以用户身份 @copilot
        # 截断过长的构建输出
        if len(build_output) > 4000:
            build_output = build_output[:4000] + "\n\n... (truncated)"
        
        comment_body = f"""@copilot The build failed. Please analyze the error below and fix it:

```
{build_output}
```

Please fix the issues and push a new commit.

<!-- copilot-fix-request: {head_sha} -->"""
        
        # 以用户身份发表评论
        if post_comment_as_user(pr_number, comment_body):
            log(f"Successfully requested Copilot fix for PR #{pr_number}")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Copilot fix requested")
        else:
            log(f"Failed to request Copilot fix for PR #{pr_number}")
            self.send_response(500)
            self.end_headers()
            self.wfile.write(b"Failed to request Copilot fix")
    
    def _handle_github_webhook(self, payload: bytes):
        """处理 GitHub Webhook 请求"""
        # 验证签名
        signature = self.headers.get("X-Hub-Signature-256", "")
        if not verify_signature(payload, signature):
            log("ERROR: Signature verification failed")
            self.send_response(401)
            self.end_headers()
            self.wfile.write(b"Signature verification failed")
            return
        
        # 解析事件类型
        event_type = self.headers.get("X-GitHub-Event", "")
        log(f"Received event: {event_type}")
        
        # 解析 payload
        try:
            data = json.loads(payload)
        except json.JSONDecodeError as e:
            log(f"ERROR: Failed to parse JSON: {e}")
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid JSON")
            return
        
        # 根据事件类型分发处理
        if event_type == "pull_request":
            self._handle_pr_event(data)
        elif event_type == "issue_comment":
            self._handle_comment_event(data)
        else:
            log(f"Ignoring event type: {event_type}")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Event ignored")
    
    def _handle_comment_event(self, data: dict):
        """处理 PR 评论事件 - 检测 /build 或 /编译 命令"""
        action = data.get("action", "")
        
        # 只处理新创建的评论
        if action != "created":
            log(f"Ignoring comment action: {action}")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Action ignored")
            return
        
        # 检查是否是 PR 的评论（而不是 Issue 的评论）
        issue = data.get("issue", {})
        if "pull_request" not in issue:
            log("Ignoring comment on non-PR issue")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Not a PR comment")
            return
        
        comment = data.get("comment", {})
        comment_body = comment.get("body", "")
        comment_user = comment.get("user", {}).get("login", "")
        pr_number = issue.get("number", 0)
        
        log(f"PR #{pr_number}: comment from {comment_user}")
        
        # 检测 /build 或 /编译 命令
        if not BUILD_COMMANDS.search(comment_body):
            log("No build command found in comment")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"No build command")
            return
        
        log(f"Build command detected from {comment_user} on PR #{pr_number}")
        
        # 获取 PR 信息以获取分支名
        pr_info = get_pr_info(pr_number)
        if not pr_info:
            log(f"Failed to get PR info for #{pr_number}")
            self.send_response(500)
            self.end_headers()
            self.wfile.write(b"Failed to get PR info")
            return
        
        pr_title = pr_info.get("title", "")
        head_ref = pr_info.get("head", {}).get("ref", "")
        
        log(f"Triggering manual build for PR #{pr_number} (branch: {head_ref})")
        
        # 触发构建
        if trigger_repository_dispatch(pr_number, pr_title, head_ref):
            # 可选：发表确认评论
            post_comment_as_user(pr_number, f"🔨 Build triggered manually by @{comment_user}")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Build triggered")
        else:
            self.send_response(500)
            self.end_headers()
            self.wfile.write(b"Failed to trigger build")
    
    def _handle_pr_event(self, data: dict):
        """处理 PR 创建/更新事件"""
        action = data.get("action", "")
        pr = data.get("pull_request", {})
        pr_number = pr.get("number", 0)
        pr_title = pr.get("title", "")
        head_ref = pr.get("head", {}).get("ref", "")
        user_login = pr.get("user", {}).get("login", "")
        
        log(f"PR #{pr_number}: action={action}, user={user_login}, branch={head_ref}")
        
        # 只处理 opened 和 synchronize 事件
        if action not in ("opened", "synchronize"):
            log(f"Ignoring action: {action}")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Action ignored")
            return
        
        # 检查是否是 Copilot 或 bot 用户（可选，根据需要调整）
        # 目前我们处理所有 PR，你可以取消注释下面的代码来过滤
        # if "copilot" not in user_login.lower() and "[bot]" not in user_login:
        #     log(f"Ignoring non-Copilot PR from: {user_login}")
        #     self.send_response(200)
        #     self.end_headers()
        #     self.wfile.write(b"Non-Copilot PR ignored")
        #     return
        
        # 检查 PR 是否涉及 .verse 文件（匹配 workflow 的 paths 过滤器）
        # 这里我们信任 GitHub 已经按照 webhook 配置过滤了
        
        # 触发 repository_dispatch
        if trigger_repository_dispatch(pr_number, pr_title, head_ref):
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Dispatch triggered")
        else:
            self.send_response(500)
            self.end_headers()
            self.wfile.write(b"Failed to trigger dispatch")

# ==================== 主程序 ====================
def main():
    """启动服务器"""
    # 验证必要的环境变量
    missing = []
    if not GITHUB_PAT:
        missing.append("GITHUB_PAT")
    if not WEBHOOK_SECRET:
        log("WARNING: WEBHOOK_SECRET not set - signature verification disabled!")
    if not GITHUB_USER_PAT:
        log("WARNING: GITHUB_USER_PAT not set - Copilot fix requests will fail!")
    
    if missing:
        log(f"ERROR: Missing required environment variables: {', '.join(missing)}")
        sys.exit(1)
    
    log(f"Starting webhook server on port {PORT}")
    log(f"Repository: {REPO_OWNER}/{REPO_NAME}")
    log(f"Copilot fix requests: {'enabled' if GITHUB_USER_PAT else 'disabled'}")
    log(f"Supported GitHub events:")
    log(f"  - pull_request (opened, synchronize) → auto build")
    log(f"  - issue_comment (/build, /编译) → manual build")
    log(f"Endpoints:")
    log(f"  POST /webhook         - GitHub webhook receiver")
    log(f"  POST /copilot-request - Copilot fix request (from GitHub Actions)")
    log(f"  GET  /health          - Health check")
    
    server = HTTPServer(("0.0.0.0", PORT), WebhookHandler)
    
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        log("Shutting down...")
        server.shutdown()

if __name__ == "__main__":
    main()
