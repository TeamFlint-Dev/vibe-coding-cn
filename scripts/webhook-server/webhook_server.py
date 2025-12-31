#!/usr/bin/env python3
"""
GitHub Webhook 中转站 (Central Hub)

功能：
1. 接收 GitHub 事件（PR、评论），触发 GitHub Actions
2. 接收 Actions 回调，根据结果决定下一步操作
3. 多账号管理，自动切换以 @copilot 请求修复
4. 状态跟踪，支持查询任务状态

架构：
  GitHub Events → /webhook → Decision → repository_dispatch → Actions
                                ↑
  Actions Result → /callback ───┘
"""

import hashlib
import hmac
import json
import os
import re
import sys
from http.server import HTTPServer, BaseHTTPRequestHandler
from typing import Optional

# 本地模块
from state_store import get_store, TaskStatus
from account_manager import get_account_manager
from github_client import get_github_client
from decision_engine import get_decision_engine

# ==================== 配置 ====================
WEBHOOK_SECRET = os.environ.get("WEBHOOK_SECRET", "")
CALLBACK_SECRET = os.environ.get("CALLBACK_SECRET", "")
PORT = int(os.environ.get("PORT", "8080"))

# 手动构建命令模式
BUILD_COMMANDS = re.compile(r"^\s*(/build|/编译)\s*$", re.MULTILINE)


# ==================== 日志 ====================
def log(message: str):
    """简单日志"""
    print(f"[hub] {message}", flush=True)


# ==================== 签名验证 ====================
def verify_github_signature(payload: bytes, signature: str) -> bool:
    """验证 GitHub webhook 签名"""
    if not WEBHOOK_SECRET:
        log("WARNING: WEBHOOK_SECRET not set, skipping verification")
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


def verify_callback_signature(payload: bytes, signature: str) -> bool:
    """验证 Actions 回调签名"""
    if not CALLBACK_SECRET:
        log("WARNING: CALLBACK_SECRET not set, skipping verification")
        return True
    
    if not signature or not signature.startswith("sha256="):
        log("ERROR: Invalid callback signature format")
        return False
    
    expected = "sha256=" + hmac.new(
        CALLBACK_SECRET.encode(),
        payload,
        hashlib.sha256
    ).hexdigest()
    
    return hmac.compare_digest(expected, signature)


# ==================== HTTP Handler ====================
class HubHandler(BaseHTTPRequestHandler):
    """中转站 HTTP 处理器"""
    
    def __init__(self, *args, **kwargs):
        self.store = get_store()
        self.github = get_github_client()
        self.engine = get_decision_engine()
        self.accounts = get_account_manager()
        super().__init__(*args, **kwargs)
    
    def log_message(self, format, *args):
        """重写日志格式"""
        log(f"HTTP {args[0]}")
    
    def _send_json(self, status: int, data: dict):
        """发送 JSON 响应"""
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())
    
    # ==================== GET 端点 ====================
    
    def do_GET(self):
        """处理 GET 请求"""
        if self.path == "/health":
            self._handle_health()
        elif self.path.startswith("/status/"):
            task_id = self.path[8:]  # 去掉 "/status/"
            self._handle_status(task_id)
        elif self.path == "/accounts":
            self._handle_accounts()
        elif self.path == "/stats":
            self._handle_stats()
        else:
            self._send_json(404, {"error": "Not found"})
    
    def _handle_health(self):
        """健康检查"""
        self._send_json(200, {
            "status": "ok",
            "accounts_available": self.accounts.has_available_accounts()
        })
    
    def _handle_status(self, task_id: str):
        """查询任务状态"""
        task = self.store.get_task(task_id)
        if task:
            self._send_json(200, task.to_dict())
        else:
            self._send_json(404, {"error": "Task not found"})
    
    def _handle_accounts(self):
        """查询账号状态"""
        self._send_json(200, self.accounts.get_stats())
    
    def _handle_stats(self):
        """查询统计信息"""
        self._send_json(200, {
            "tasks": self.store.get_stats(),
            "accounts": self.accounts.get_stats()
        })
    
    # ==================== POST 端点 ====================
    
    def do_POST(self):
        """处理 POST 请求"""
        content_length = int(self.headers.get("Content-Length", 0))
        payload = self.rfile.read(content_length)
        
        if self.path == "/webhook":
            self._handle_webhook(payload)
        elif self.path == "/callback":
            self._handle_callback(payload)
        else:
            self._send_json(404, {"error": "Not found"})
    
    def _handle_webhook(self, payload: bytes):
        """处理 GitHub Webhook"""
        # 验证签名
        signature = self.headers.get("X-Hub-Signature-256", "")
        if not verify_github_signature(payload, signature):
            self._send_json(401, {"error": "Invalid signature"})
            return
        
        # 解析事件
        event_type = self.headers.get("X-GitHub-Event", "")
        log(f"Received GitHub event: {event_type}")
        
        try:
            data = json.loads(payload)
        except json.JSONDecodeError as e:
            self._send_json(400, {"error": f"Invalid JSON: {e}"})
            return
        
        # 路由到具体处理器
        if event_type == "pull_request":
            self._handle_pr_event(data)
        elif event_type == "issue_comment":
            self._handle_comment_event(data)
        elif event_type == "ping":
            self._send_json(200, {"message": "pong"})
        else:
            log(f"Ignoring event: {event_type}")
            self._send_json(200, {"message": "Event ignored"})
    
    def _handle_pr_event(self, data: dict):
        """处理 PR 事件"""
        action = data.get("action", "")
        pr = data.get("pull_request", {})
        pr_number = pr.get("number", 0)
        pr_title = pr.get("title", "")
        head_ref = pr.get("head", {}).get("ref", "")
        head_sha = pr.get("head", {}).get("sha", "")
        user_login = pr.get("user", {}).get("login", "")
        
        log(f"PR #{pr_number}: action={action}, user={user_login}")
        
        # 只处理 opened 和 synchronize
        if action not in ("opened", "synchronize"):
            self._send_json(200, {"message": f"Action '{action}' ignored"})
            return
        
        # 创建任务
        task_id = self.store.create_task(
            pr_number=pr_number,
            head_sha=head_sha,
            head_ref=head_ref,
            trigger_type=f"pr-{action}"
        )
        
        log(f"Created task {task_id} for PR #{pr_number}")
        
        # 触发 repository_dispatch
        success = self.github.trigger_dispatch(
            event_type="build-pr",
            client_payload={
                "task_id": task_id,
                "pr_number": pr_number,
                "pr_title": pr_title,
                "head_ref": head_ref,
                "head_sha": head_sha
            }
        )
        
        if success:
            self.store.update_task(
                task_id,
                status=TaskStatus.BUILDING,
                event="dispatch_sent"
            )
            self._send_json(200, {
                "message": "Build dispatched",
                "task_id": task_id
            })
        else:
            self._send_json(500, {"error": "Failed to dispatch"})
    
    def _handle_comment_event(self, data: dict):
        """处理评论事件"""
        action = data.get("action", "")
        
        if action != "created":
            self._send_json(200, {"message": "Action ignored"})
            return
        
        # 检查是否是 PR 评论
        issue = data.get("issue", {})
        if "pull_request" not in issue:
            self._send_json(200, {"message": "Not a PR comment"})
            return
        
        comment = data.get("comment", {})
        comment_body = comment.get("body", "")
        comment_user = comment.get("user", {}).get("login", "")
        pr_number = issue.get("number", 0)
        
        # 检测构建命令
        if not BUILD_COMMANDS.search(comment_body):
            self._send_json(200, {"message": "No build command"})
            return
        
        log(f"Build command from {comment_user} on PR #{pr_number}")
        
        # 获取 PR 信息
        pr_info = self.github.get_pr_info(pr_number)
        if not pr_info:
            self._send_json(500, {"error": "Failed to get PR info"})
            return
        
        head_ref = pr_info.get("head", {}).get("ref", "")
        head_sha = pr_info.get("head", {}).get("sha", "")
        pr_title = pr_info.get("title", "")
        
        # 创建任务
        task_id = self.store.create_task(
            pr_number=pr_number,
            head_sha=head_sha,
            head_ref=head_ref,
            trigger_type=f"command-{comment_user}"
        )
        
        log(f"Created task {task_id} for manual build")
        
        # 触发构建
        success = self.github.trigger_dispatch(
            event_type="build-pr",
            client_payload={
                "task_id": task_id,
                "pr_number": pr_number,
                "pr_title": pr_title,
                "head_ref": head_ref,
                "head_sha": head_sha
            }
        )
        
        if success:
            self.store.update_task(
                task_id,
                status=TaskStatus.BUILDING,
                event="dispatch_sent",
                event_details=f"Manual trigger by {comment_user}"
            )
            self._send_json(200, {
                "message": "Build dispatched",
                "task_id": task_id,
                "triggered_by": comment_user
            })
        else:
            self._send_json(500, {"error": "Failed to dispatch"})
    
    def _handle_callback(self, payload: bytes):
        """处理 Actions 回调"""
        # 验证签名
        signature = self.headers.get("X-Callback-Signature", "")
        if not verify_callback_signature(payload, signature):
            self._send_json(401, {"error": "Invalid callback signature"})
            return
        
        try:
            data = json.loads(payload)
        except json.JSONDecodeError as e:
            self._send_json(400, {"error": f"Invalid JSON: {e}"})
            return
        
        task_id = data.get("task_id", "")
        result = data.get("result", "")
        build_output = data.get("build_output", "")
        
        log(f"Callback received: task={task_id}, result={result}")
        
        if not task_id or not result:
            self._send_json(400, {"error": "Missing task_id or result"})
            return
        
        # 调用决策引擎处理
        actions = self.engine.process_callback(
            task_id=task_id,
            result=result,
            build_output=build_output
        )
        
        self._send_json(200, {
            "message": "Callback processed",
            "task_id": task_id,
            "actions_executed": len(actions)
        })


# ==================== 主程序 ====================
def main():
    """启动中转站"""
    # 检查环境变量
    github_pat = os.environ.get("GITHUB_PAT", "")
    if not github_pat:
        log("ERROR: GITHUB_PAT is required")
        sys.exit(1)
    
    if not WEBHOOK_SECRET:
        log("WARNING: WEBHOOK_SECRET not set")
    
    if not CALLBACK_SECRET:
        log("WARNING: CALLBACK_SECRET not set")
    
    # 初始化组件
    store = get_store()
    accounts = get_account_manager()
    github = get_github_client()
    
    log("=" * 60)
    log("GitHub Webhook Hub Starting")
    log("=" * 60)
    log(f"Port: {PORT}")
    log(f"Repository: {github.repo_owner}/{github.repo_name}")
    log(f"User accounts: {len(accounts.get_all_accounts_status())}")
    log("")
    log("Endpoints:")
    log("  POST /webhook   - GitHub events")
    log("  POST /callback  - Actions results")
    log("  GET  /status/<id> - Task status")
    log("  GET  /accounts  - Account status")
    log("  GET  /stats     - Statistics")
    log("  GET  /health    - Health check")
    log("=" * 60)
    
    server = HTTPServer(("0.0.0.0", PORT), HubHandler)
    
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        log("Shutting down...")
        server.shutdown()


if __name__ == "__main__":
    main()
