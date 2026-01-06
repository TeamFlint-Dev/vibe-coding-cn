#!/usr/bin/env python3
"""
Verse Compile Server - 云端编译调度服务

功能：
1. 接收 Agent 的编译请求
2. 触发 GitHub Actions Workflow (Self-hosted Runner)
3. 接收 Runner 回传的编译结果
4. 提供轮询接口让 Agent 获取结果
5. 评论编译结果到 PR

架构:
  Agent → POST /verse/compile → 触发 Workflow → Runner 执行 → POST /verse/result → Agent 轮询获取结果
"""

import hashlib
import hmac
import json
import os
import time
import uuid
from http.server import HTTPServer, BaseHTTPRequestHandler
from threading import Lock
from typing import Optional, Dict, Any
from urllib.request import Request, urlopen
from urllib.error import HTTPError, URLError
from datetime import datetime

# ==================== 配置 ====================
PORT = int(os.environ.get("PORT", "19527"))
GITHUB_PAT = os.environ.get("GITHUB_PAT", "")
WEBHOOK_SECRET = os.environ.get("WEBHOOK_SECRET", "")
RUNNER_SECRET = os.environ.get("RUNNER_SECRET", "")  # Runner 回调签名密钥

# 默认仓库
DEFAULT_REPO_OWNER = os.environ.get("REPO_OWNER", "TeamFlint-Dev")
DEFAULT_REPO_NAME = os.environ.get("REPO_NAME", "vibe-coding-cn")

# 编译请求存储 (生产环境应该用 Redis)
compile_requests: Dict[str, Dict[str, Any]] = {}
compile_requests_lock = Lock()


# ==================== 日志 ====================
def log(message: str):
    """简单日志"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{timestamp}] {message}", flush=True)


# ==================== GitHub API ====================
def trigger_workflow(
    repo_owner: str,
    repo_name: str,
    workflow_file: str,
    inputs: Dict[str, str]
) -> bool:
    """触发 GitHub Actions Workflow"""
    url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/actions/workflows/{workflow_file}/dispatches"
    
    data = {
        "ref": "main",  # 触发分支
        "inputs": inputs
    }
    
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_PAT}",
        "X-GitHub-Api-Version": "2022-11-28",
        "Content-Type": "application/json"
    }
    
    try:
        body = json.dumps(data).encode()
        req = Request(url, data=body, headers=headers, method="POST")
        
        with urlopen(req, timeout=30) as response:
            log(f"Workflow triggered: {workflow_file}")
            return True
    except HTTPError as e:
        error_body = e.read().decode()
        log(f"Failed to trigger workflow: HTTP {e.code} - {error_body}")
        return False
    except Exception as e:
        log(f"Failed to trigger workflow: {e}")
        return False


def comment_on_pr(
    repo_owner: str,
    repo_name: str,
    branch: str,
    comment_body: str
) -> bool:
    """在分支对应的 PR 上评论"""
    # 1. 先找到分支对应的 PR
    pr_url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/pulls?head={repo_owner}:{branch}&state=open"
    
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_PAT}",
        "X-GitHub-Api-Version": "2022-11-28"
    }
    
    try:
        req = Request(pr_url, headers=headers, method="GET")
        with urlopen(req, timeout=30) as response:
            prs = json.loads(response.read().decode())
        
        if not prs:
            log(f"No open PR found for branch: {branch}")
            return False
        
        pr_number = prs[0]["number"]
        
        # 2. 发表评论
        comment_url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/issues/{pr_number}/comments"
        
        data = {"body": comment_body}
        body = json.dumps(data).encode()
        
        req = Request(comment_url, data=body, headers={**headers, "Content-Type": "application/json"}, method="POST")
        with urlopen(req, timeout=30) as response:
            log(f"Commented on PR #{pr_number}")
            return True
            
    except Exception as e:
        log(f"Failed to comment on PR: {e}")
        return False


def format_compile_result_comment(result: Dict[str, Any]) -> str:
    """格式化编译结果为 Markdown 评论"""
    if result.get("success"):
        status = "✅ **编译成功**"
    else:
        status = "❌ **编译失败**"
    
    comment = f"""## 🔨 Verse 编译结果

{status}

| 项目 | 值 |
|------|-----|
| 分支 | `{result.get('branch', 'unknown')}` |
| Commit | `{result.get('commit', 'unknown')[:8]}` |
| 错误数 | {result.get('error_count', 0)} |
| 警告数 | {result.get('warning_count', 0)} |
| 耗时 | {result.get('duration', 'N/A')} |
"""
    
    errors = result.get("errors", [])
    if errors:
        comment += "\n### ❌ 错误\n\n```\n"
        for err in errors[:10]:  # 最多显示10个
            comment += f"{err}\n"
        if len(errors) > 10:
            comment += f"... 还有 {len(errors) - 10} 个错误\n"
        comment += "```\n"
    
    warnings = result.get("warnings", [])
    if warnings:
        comment += "\n### ⚠️ 警告\n\n```\n"
        for warn in warnings[:5]:  # 最多显示5个
            comment += f"{warn}\n"
        if len(warnings) > 5:
            comment += f"... 还有 {len(warnings) - 5} 个警告\n"
        comment += "```\n"
    
    return comment


# ==================== 请求管理 ====================
def create_compile_request(
    branch: str,
    commit: str,
    repo_owner: str = DEFAULT_REPO_OWNER,
    repo_name: str = DEFAULT_REPO_NAME
) -> str:
    """创建编译请求"""
    request_id = f"vc-{int(time.time())}-{uuid.uuid4().hex[:6]}"
    
    request_data = {
        "request_id": request_id,
        "branch": branch,
        "commit": commit,
        "repo_owner": repo_owner,
        "repo_name": repo_name,
        "status": "pending",
        "created_at": datetime.now().isoformat(),
        "updated_at": datetime.now().isoformat(),
        "result": None
    }
    
    with compile_requests_lock:
        compile_requests[request_id] = request_data
    
    return request_id


def update_compile_request(request_id: str, updates: Dict[str, Any]):
    """更新编译请求"""
    with compile_requests_lock:
        if request_id in compile_requests:
            compile_requests[request_id].update(updates)
            compile_requests[request_id]["updated_at"] = datetime.now().isoformat()


def get_compile_request(request_id: str) -> Optional[Dict[str, Any]]:
    """获取编译请求"""
    with compile_requests_lock:
        return compile_requests.get(request_id)


# ==================== 签名验证 ====================
def verify_runner_signature(payload: bytes, signature: str) -> bool:
    """验证 Runner 回调签名"""
    if not RUNNER_SECRET:
        log("WARNING: RUNNER_SECRET not set, skipping verification")
        return True
    
    if not signature or not signature.startswith("sha256="):
        log("ERROR: Invalid runner signature format")
        return False
    
    expected = "sha256=" + hmac.new(
        RUNNER_SECRET.encode(),
        payload,
        hashlib.sha256
    ).hexdigest()
    
    return hmac.compare_digest(expected, signature)


# ==================== HTTP Handler ====================
class VerseCompileHandler(BaseHTTPRequestHandler):
    """Verse 编译服务 HTTP 处理器"""
    
    def log_message(self, format, *args):
        """重写日志格式"""
        log(f"HTTP {args[0]}")
    
    def _send_json(self, status: int, data: dict):
        """发送 JSON 响应"""
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())
    
    # ==================== GET 端点 ====================
    
    def do_GET(self):
        """处理 GET 请求"""
        if self.path == "/health":
            self._handle_health()
        elif self.path.startswith("/verse/status/"):
            request_id = self.path[14:]  # 去掉 "/verse/status/"
            self._handle_status(request_id)
        elif self.path == "/verse/list":
            self._handle_list()
        else:
            self._send_json(404, {"error": "Not found"})
    
    def _handle_health(self):
        """健康检查"""
        self._send_json(200, {
            "status": "ok",
            "service": "verse-compile-server",
            "pending_requests": len([r for r in compile_requests.values() if r["status"] == "pending"]),
            "running_requests": len([r for r in compile_requests.values() if r["status"] == "running"])
        })
    
    def _handle_status(self, request_id: str):
        """查询编译状态"""
        request = get_compile_request(request_id)
        if request:
            # 构造响应
            response = {
                "request_id": request["request_id"],
                "status": request["status"],
                "branch": request["branch"],
                "commit": request["commit"],
                "created_at": request["created_at"],
                "updated_at": request["updated_at"]
            }
            
            # 如果已完成，包含结果
            if request["status"] in ["completed", "failed"] and request.get("result"):
                response.update(request["result"])
            
            self._send_json(200, response)
        else:
            self._send_json(404, {"error": "Request not found"})
    
    def _handle_list(self):
        """列出所有请求"""
        with compile_requests_lock:
            requests_list = list(compile_requests.values())
        
        # 只返回最近 50 个
        requests_list.sort(key=lambda x: x["created_at"], reverse=True)
        requests_list = requests_list[:50]
        
        self._send_json(200, {
            "count": len(requests_list),
            "requests": requests_list
        })
    
    # ==================== POST 端点 ====================
    
    def do_POST(self):
        """处理 POST 请求"""
        content_length = int(self.headers.get("Content-Length", 0))
        payload = self.rfile.read(content_length)
        
        if self.path == "/verse/compile":
            self._handle_compile(payload)
        elif self.path == "/verse/result":
            self._handle_result(payload)
        else:
            self._send_json(404, {"error": "Not found"})
    
    def _handle_compile(self, payload: bytes):
        """处理编译请求
        
        请求格式:
        {
            "branch": "feature/xxx",
            "commit": "abc123...",
            "repo_owner": "TeamFlint-Dev",  // 可选
            "repo_name": "vibe-coding-cn"   // 可选
        }
        """
        try:
            data = json.loads(payload)
        except json.JSONDecodeError as e:
            log(f"Compile request: Invalid JSON - {e}")
            self._send_json(400, {"error": f"Invalid JSON: {e}"})
            return
        
        # 验证必需字段
        branch = data.get("branch")
        
        if not branch:
            self._send_json(400, {"error": "Missing required field: branch"})
            return
        
        repo_owner = data.get("repo_owner", DEFAULT_REPO_OWNER)
        repo_name = data.get("repo_name", DEFAULT_REPO_NAME)
        
        # commit 现在是可选的，因为会在 UEFN 仓库中自动获取
        commit = data.get("commit", "auto")
        
        log(f"Compile request: branch={branch}, repo={repo_owner}/{repo_name}")
        
        # 创建请求记录
        request_id = create_compile_request(branch, commit, repo_owner, repo_name)
        log(f"Created request: {request_id}")
        
        # 触发 Workflow (不再传 commit，由 Runner 在 UEFN 仓库获取)
        success = trigger_workflow(
            repo_owner=repo_owner,
            repo_name=repo_name,
            workflow_file="verse-uefn-compile.yml",
            inputs={
                "request_id": request_id,
                "branch": branch,
                "callback_url": f"http://193.112.183.143:{PORT}/verse/result"
            }
        )
        
        if success:
            update_compile_request(request_id, {"status": "running"})
            self._send_json(200, {
                "request_id": request_id,
                "status": "running",
                "message": "Compile workflow triggered"
            })
        else:
            update_compile_request(request_id, {"status": "failed", "result": {"error": "Failed to trigger workflow"}})
            self._send_json(500, {
                "request_id": request_id,
                "status": "failed",
                "error": "Failed to trigger workflow"
            })
    
    def _handle_result(self, payload: bytes):
        """处理 Runner 回传的编译结果
        
        请求格式:
        {
            "request_id": "vc-xxx",
            "success": true/false,
            "error_count": 0,
            "warning_count": 2,
            "errors": [...],
            "warnings": [...],
            "duration": "15s"
        }
        """
        # 验证签名
        signature = self.headers.get("X-Runner-Signature", "")
        if not verify_runner_signature(payload, signature):
            log("Result callback: Invalid signature")
            self._send_json(401, {"error": "Invalid signature"})
            return
        
        try:
            data = json.loads(payload)
        except json.JSONDecodeError as e:
            log(f"Result callback: Invalid JSON - {e}")
            self._send_json(400, {"error": f"Invalid JSON: {e}"})
            return
        
        request_id = data.get("request_id")
        if not request_id:
            self._send_json(400, {"error": "Missing request_id"})
            return
        
        request = get_compile_request(request_id)
        if not request:
            self._send_json(404, {"error": "Request not found"})
            return
        
        log(f"Result received: request_id={request_id}, success={data.get('success')}")
        
        # 更新请求状态
        result = {
            "success": data.get("success", False),
            "error_count": data.get("error_count", 0),
            "warning_count": data.get("warning_count", 0),
            "errors": data.get("errors", []),
            "warnings": data.get("warnings", []),
            "duration": data.get("duration", "N/A"),
            "raw_output": data.get("raw_output", ""),
            "branch": request["branch"],
            "commit": request["commit"]
        }
        
        status = "completed" if data.get("success") else "failed"
        update_compile_request(request_id, {"status": status, "result": result})
        
        # 评论到 PR
        try:
            comment_body = format_compile_result_comment(result)
            comment_on_pr(
                repo_owner=request["repo_owner"],
                repo_name=request["repo_name"],
                branch=request["branch"],
                comment_body=comment_body
            )
        except Exception as e:
            log(f"Failed to comment on PR: {e}")
        
        self._send_json(200, {"status": "ok", "message": "Result recorded"})
    
    # ==================== OPTIONS (CORS) ====================
    
    def do_OPTIONS(self):
        """处理 CORS 预检请求"""
        self.send_response(200)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type, X-Runner-Signature")
        self.end_headers()


# ==================== 主入口 ====================
def main():
    log(f"Starting Verse Compile Server on port {PORT}")
    
    if not GITHUB_PAT:
        log("WARNING: GITHUB_PAT not set, workflow triggering will fail")
    
    server = HTTPServer(("0.0.0.0", PORT), VerseCompileHandler)
    
    try:
        log(f"Server listening on http://0.0.0.0:{PORT}")
        log("Endpoints:")
        log("  GET  /health           - Health check")
        log("  GET  /verse/status/<id> - Get compile status")
        log("  GET  /verse/list       - List all requests")
        log("  POST /verse/compile    - Submit compile request")
        log("  POST /verse/result     - Runner result callback")
        server.serve_forever()
    except KeyboardInterrupt:
        log("Shutting down...")
        server.shutdown()


if __name__ == "__main__":
    main()
