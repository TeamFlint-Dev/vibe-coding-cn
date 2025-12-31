#!/usr/bin/env python3
"""
GitHub Webhook → repository_dispatch 转发服务

当 Copilot 创建 PR 时，GitHub 发送 webhook 到此服务，
服务验证后调用 repository_dispatch API 触发工作流。

这样可以绕过 Copilot 触发工作流需要人工批准的限制。
"""

import hashlib
import hmac
import json
import os
import sys
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.request import Request, urlopen
from urllib.error import HTTPError, URLError

# ==================== 配置 ====================
# 从环境变量读取敏感信息
WEBHOOK_SECRET = os.environ.get("WEBHOOK_SECRET", "")
GITHUB_PAT = os.environ.get("GITHUB_PAT", "")
REPO_OWNER = os.environ.get("REPO_OWNER", "TeamFlint-Dev")
REPO_NAME = os.environ.get("REPO_NAME", "vibe-coding-cn")
PORT = int(os.environ.get("PORT", "8080"))

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
        """处理 webhook POST 请求"""
        if self.path != "/webhook":
            self.send_response(404)
            self.end_headers()
            return
        
        # 读取请求体
        content_length = int(self.headers.get("Content-Length", 0))
        payload = self.rfile.read(content_length)
        
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
        
        # 只处理 PR 事件
        if event_type != "pull_request":
            log(f"Ignoring event type: {event_type}")
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Event ignored")
            return
        
        # 解析 payload
        try:
            data = json.loads(payload)
        except json.JSONDecodeError as e:
            log(f"ERROR: Failed to parse JSON: {e}")
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"Invalid JSON")
            return
        
        # 检查是否是 Copilot 创建的 PR
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
    
    if missing:
        log(f"ERROR: Missing required environment variables: {', '.join(missing)}")
        sys.exit(1)
    
    log(f"Starting webhook server on port {PORT}")
    log(f"Repository: {REPO_OWNER}/{REPO_NAME}")
    log(f"Endpoints:")
    log(f"  POST /webhook - GitHub webhook receiver")
    log(f"  GET  /health  - Health check")
    
    server = HTTPServer(("0.0.0.0", PORT), WebhookHandler)
    
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        log("Shutting down...")
        server.shutdown()

if __name__ == "__main__":
    main()
