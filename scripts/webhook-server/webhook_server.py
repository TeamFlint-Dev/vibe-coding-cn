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
from pipeline_scheduler import get_scheduler, init_scheduler

# ==================== 配置 ====================
WEBHOOK_SECRET = os.environ.get("WEBHOOK_SECRET", "")
CALLBACK_SECRET = os.environ.get("CALLBACK_SECRET", "")
PIPELINE_SECRET = os.environ.get("PIPELINE_SECRET", "")  # Pipeline 专用密钥
PORT = int(os.environ.get("PORT", "8080"))

# Pipeline 配置
PIPELINE_REPO_PATH = os.environ.get("PIPELINE_REPO_PATH", "/opt/pipeline-repo")

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


def verify_pipeline_signature(payload: bytes, signature: str) -> bool:
    """验证 Pipeline 请求签名"""
    if not PIPELINE_SECRET:
        log("WARNING: PIPELINE_SECRET not set, skipping verification")
        return True
    
    if not signature or not signature.startswith("sha256="):
        log("ERROR: Invalid pipeline signature format")
        return False
    
    expected = "sha256=" + hmac.new(
        PIPELINE_SECRET.encode(),
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
        # Pipeline 相关端点
        elif self.path.startswith("/pipeline/status/"):
            pipeline_id = self.path[17:]  # 去掉 "/pipeline/status/"
            self._handle_pipeline_status(pipeline_id)
        elif self.path == "/pipeline/list":
            self._handle_pipeline_list()
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
    
    # ==================== Pipeline GET 端点 ====================
    
    def _handle_pipeline_status(self, pipeline_id: str):
        """查询流水线状态"""
        scheduler = get_scheduler()
        if not scheduler:
            self._send_json(503, {"error": "Pipeline scheduler not initialized"})
            return
        
        pipeline = scheduler.get_pipeline(pipeline_id)
        if pipeline:
            self._send_json(200, pipeline.to_dict())
        else:
            self._send_json(404, {"error": "Pipeline not found"})
    
    def _handle_pipeline_list(self):
        """列出所有流水线"""
        scheduler = get_scheduler()
        if not scheduler:
            self._send_json(503, {"error": "Pipeline scheduler not initialized"})
            return
        
        pipelines = scheduler.get_all_pipelines()
        self._send_json(200, {
            "count": len(pipelines),
            "pipelines": [p.to_dict() for p in pipelines]
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
        # Pipeline 相关端点
        elif self.path == "/pipeline/ready":
            self._handle_pipeline_ready(payload)
        elif self.path.startswith("/pipeline/cancel/"):
            pipeline_id = self.path[17:]  # 去掉 "/pipeline/cancel/"
            self._handle_pipeline_cancel(pipeline_id)
        else:
            self._send_json(404, {"error": "Not found"})
    
    # ==================== Pipeline POST 端点 ====================
    
    def _handle_pipeline_ready(self, payload: bytes):
        """处理 Planner Agent 的流水线启动通知
        
        请求格式:
        {
            "pipeline_id": "p20260101120000",
            "type": "skills-distill",
            "stages": ["ingest", "classify", "extract", "assemble", "validate"],
            "stage_ids": {"ingest": "bd-abc123", "classify": "bd-def456", ...},  # 可选
            "source_url": "https://..."  # 可选
        }
        """
        import asyncio
        
        # 验证签名
        signature = self.headers.get("X-Pipeline-Signature", "")
        if not verify_pipeline_signature(payload, signature):
            log("Pipeline ready: Invalid signature")
            self._send_json(401, {"error": "Invalid signature"})
            return
        
        try:
            data = json.loads(payload)
        except json.JSONDecodeError as e:
            log(f"Pipeline ready: Invalid JSON - {e}")
            self._send_json(400, {"error": f"Invalid JSON: {e}"})
            return
        
        # 验证必需字段
        pipeline_id = data.get("pipeline_id")
        pipeline_type = data.get("type")
        stages = data.get("stages", [])
        
        if not pipeline_id:
            self._send_json(400, {"error": "Missing required field: pipeline_id"})
            return
        if not pipeline_type:
            self._send_json(400, {"error": "Missing required field: type"})
            return
        if not stages:
            self._send_json(400, {"error": "Missing required field: stages (must be non-empty array)"})
            return
        
        # 可选字段
        stage_ids = data.get("stage_ids", {})
        source_url = data.get("source_url", "")
        branch = data.get("branch", "")  # 工作分支名称
        
        log(f"Pipeline ready: id={pipeline_id}, type={pipeline_type}, stages={stages}")
        if stage_ids:
            log(f"  stage_ids: {stage_ids}")
        if branch:
            log(f"  branch: {branch}")
        
        scheduler = get_scheduler()
        if not scheduler:
            log("Pipeline ready: Scheduler not initialized")
            self._send_json(503, {"error": "Pipeline scheduler not initialized"})
            return
        
        # 启动流水线
        try:
            # 在事件循环中运行
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            pipeline = loop.run_until_complete(
                scheduler.start_pipeline(
                    pipeline_id=pipeline_id,
                    pipeline_type=pipeline_type,
                    stages=stages,
                    stage_ids=stage_ids,
                    source_url=source_url,
                    branch=branch if branch else None
                )
            )
            
            log(f"Pipeline {pipeline_id} started, issue #{pipeline.issue_number}")
            self._send_json(200, {
                "status": "accepted",
                "pipeline_id": pipeline_id,
                "type": pipeline_type,
                "stages": stages,
                "issue_number": pipeline.issue_number,
                "message": f"Pipeline started successfully. Track at issue #{pipeline.issue_number}"
            })
        except Exception as e:
            log(f"Failed to start pipeline {pipeline_id}: {e}")
            import traceback
            traceback.print_exc()
            self._send_json(500, {"error": str(e), "pipeline_id": pipeline_id})
    
    def _handle_pipeline_cancel(self, pipeline_id: str):
        """取消流水线"""
        import asyncio
        
        scheduler = get_scheduler()
        if not scheduler:
            self._send_json(503, {"error": "Pipeline scheduler not initialized"})
            return
        
        try:
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            success = loop.run_until_complete(scheduler.cancel_pipeline(pipeline_id))
            
            if success:
                self._send_json(200, {"status": "cancelled", "pipeline_id": pipeline_id})
            else:
                self._send_json(404, {"error": "Pipeline not found"})
        except Exception as e:
            log(f"Failed to cancel pipeline: {e}")
            self._send_json(500, {"error": str(e)})
    
    # ==================== Webhook 处理 ====================

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
        elif event_type == "issues":
            self._handle_issues_event(data)
        elif event_type == "workflow_run":
            self._handle_workflow_run_event(data)
        elif event_type == "ping":
            self._send_json(200, {"message": "pong"})
        else:
            log(f"Ignoring event: {event_type}")
            self._send_json(200, {"message": "Event ignored"})
    
    def _handle_workflow_run_event(self, data: dict):
        """处理 workflow_run 事件 - 当 Planner Agent 完成时启动流水线"""
        import asyncio
        import urllib.request
        import zipfile
        import io
        
        action = data.get("action", "")
        workflow_run = data.get("workflow_run", {})
        workflow_name = workflow_run.get("name", "")
        conclusion = workflow_run.get("conclusion", "")
        run_id = workflow_run.get("id", 0)
        
        log(f"Workflow run: name={workflow_name}, action={action}, conclusion={conclusion}")
        
        # 只处理 planner-agent workflow 的成功完成
        if action != "completed":
            self._send_json(200, {"message": f"Ignoring workflow action: {action}"})
            return
            
        if workflow_name != "planner-agent":
            self._send_json(200, {"message": f"Ignoring workflow: {workflow_name}"})
            return
            
        if conclusion != "success":
            log(f"Planner workflow failed with conclusion: {conclusion}")
            self._send_json(200, {"message": f"Planner failed: {conclusion}"})
            return
        
        log(f"Planner Agent completed successfully, fetching artifacts from run {run_id}")
        
        # 从 workflow artifacts 获取 pipeline 信息
        try:
            pipeline_info = self._fetch_pipeline_artifact(run_id)
            if not pipeline_info:
                log("No pipeline artifact found")
                self._send_json(200, {"message": "No pipeline artifact found"})
                return
            
            log(f"Pipeline info from artifact: {pipeline_info}")
            
            # 启动调度器
            scheduler = get_scheduler()
            if not scheduler:
                log("Pipeline scheduler not initialized")
                self._send_json(503, {"error": "Pipeline scheduler not initialized"})
                return
            
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            pipeline = loop.run_until_complete(
                scheduler.start_pipeline(
                    pipeline_id=pipeline_info["pipeline_id"],
                    pipeline_type=pipeline_info.get("type", "unknown"),
                    stages=pipeline_info.get("stages", []),
                    stage_ids=pipeline_info.get("stage_ids", {}),
                    source_url=pipeline_info.get("source_url", "")
                )
            )
            log(f"Pipeline {pipeline_info['pipeline_id']} started from workflow_run")
            self._send_json(200, {
                "message": "Pipeline started",
                "pipeline_id": pipeline_info["pipeline_id"]
            })
        except Exception as e:
            log(f"Failed to start pipeline from workflow_run: {e}")
            self._send_json(500, {"error": str(e)})
    
    def _fetch_pipeline_artifact(self, run_id: int) -> Optional[dict]:
        """从 workflow run 的 artifacts 获取 pipeline 信息"""
        import urllib.request
        import zipfile
        import io
        
        # GitHub API: 获取 artifacts 列表
        token = os.environ.get("GITHUB_TOKEN", "")
        if not token:
            log("GITHUB_TOKEN not set, cannot fetch artifacts")
            return None
        
        repo = os.environ.get("GITHUB_REPO", "TeamFlint-Dev/vibe-coding-cn")
        url = f"https://api.github.com/repos/{repo}/actions/runs/{run_id}/artifacts"
        
        req = urllib.request.Request(url)
        req.add_header("Authorization", f"Bearer {token}")
        req.add_header("Accept", "application/vnd.github+json")
        req.add_header("X-GitHub-Api-Version", "2022-11-28")
        
        try:
            with urllib.request.urlopen(req, timeout=30) as response:
                data = json.loads(response.read().decode())
        except Exception as e:
            log(f"Failed to fetch artifacts list: {e}")
            return None
        
        # 查找 pipeline-info artifact
        artifacts = data.get("artifacts", [])
        pipeline_artifact = None
        for artifact in artifacts:
            if artifact.get("name") == "pipeline-info":
                pipeline_artifact = artifact
                break
        
        if not pipeline_artifact:
            log("No pipeline-info artifact found")
            return None
        
        # 下载 artifact (是一个 zip 文件)
        download_url = pipeline_artifact.get("archive_download_url")
        if not download_url:
            log("No download URL for artifact")
            return None
        
        req = urllib.request.Request(download_url)
        req.add_header("Authorization", f"Bearer {token}")
        req.add_header("Accept", "application/vnd.github+json")
        
        try:
            with urllib.request.urlopen(req, timeout=60) as response:
                zip_data = response.read()
        except Exception as e:
            log(f"Failed to download artifact: {e}")
            return None
        
        # 解压并读取 pipeline.json
        try:
            with zipfile.ZipFile(io.BytesIO(zip_data)) as zf:
                with zf.open("pipeline.json") as f:
                    return json.loads(f.read().decode())
        except Exception as e:
            log(f"Failed to parse artifact: {e}")
            return None

    def _handle_issues_event(self, data: dict):
        """处理 Issue 事件 - 用于 Pipeline 自动调度"""
        import asyncio
        
        action = data.get("action", "")
        issue = data.get("issue", {})
        issue_number = issue.get("number", 0)
        title = issue.get("title", "")
        body = issue.get("body", "")
        labels = [l.get("name", "") for l in issue.get("labels", [])]
        
        log(f"Issue #{issue_number}: action={action}, labels={labels}")
        
        # 只处理带 pipeline 标签的新 Issue
        if action != "opened" or "pipeline" not in labels:
            self._send_json(200, {"message": "Issue ignored (not a pipeline trigger)"})
            return
        
        # 解析 Pipeline 信息
        pipeline_info = self._parse_pipeline_from_issue(title, body)
        if not pipeline_info:
            log(f"Could not parse pipeline info from issue #{issue_number}")
            self._send_json(200, {"message": "Could not parse pipeline info"})
            return
        
        log(f"Parsed pipeline: {pipeline_info['pipeline_id']}, stages: {pipeline_info['stages']}")
        
        # 启动调度器
        scheduler = get_scheduler()
        if not scheduler:
            log("Pipeline scheduler not initialized")
            self._send_json(503, {"error": "Pipeline scheduler not initialized"})
            return
        
        try:
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            pipeline = loop.run_until_complete(
                scheduler.start_pipeline(
                    pipeline_id=pipeline_info["pipeline_id"],
                    pipeline_type=pipeline_info.get("type", "unknown"),
                    stages=pipeline_info["stages"],
                    stage_ids=pipeline_info.get("stage_ids", {}),
                    source_url=pipeline_info.get("source_url", ""),
                    issue_number=issue_number
                )
            )
            log(f"Pipeline {pipeline_info['pipeline_id']} started from issue #{issue_number}")
            self._send_json(200, {
                "message": "Pipeline started",
                "pipeline_id": pipeline_info["pipeline_id"],
                "issue_number": issue_number
            })
        except Exception as e:
            log(f"Failed to start pipeline: {e}")
            self._send_json(500, {"error": str(e)})
    
    def _parse_pipeline_from_issue(self, title: str, body: str) -> Optional[dict]:
        """从 Issue 内容解析 Pipeline 信息"""
        import re
        
        result = {}
        
        # 从标题解析 pipeline_id (格式: "Pipeline xxx ...")
        # 支持多种格式: p20260102150202, test004, my-pipeline-1 等
        title_match = re.search(r'Pipeline\s+([^\s-]+(?:-[^\s]+)?)', title, re.IGNORECASE)
        if title_match:
            result["pipeline_id"] = title_match.group(1)
        else:
            # 尝试从 body 解析
            body_match = re.search(r'\*\*Pipeline ID\*\*:\s*`?([^`\s]+)`?', body)
            if body_match:
                result["pipeline_id"] = body_match.group(1)
            else:
                log(f"Could not find pipeline_id in title or body")
                return None
        
        # 解析 type
        type_match = re.search(r'\*\*Type\*\*:\s*`?([a-z0-9-]+)`?', body, re.IGNORECASE)
        if type_match:
            result["type"] = type_match.group(1)
        
        # 解析 source_url
        source_match = re.search(r'\*\*Source\*\*:\s*`?([^`\s]+)`?', body)
        if source_match:
            result["source_url"] = source_match.group(1)
        
        # 解析 stages 和 stage_ids 从表格
        # | Stage | Beads ID | ...
        # | 1. ingest | `xxx-yyy-zzz` | ...
        stages = []
        stage_ids = {}
        stage_pattern = re.compile(
            r'\|\s*\d+\.\s*(\w+)\s*\|\s*`([^`]+)`\s*\|',
            re.IGNORECASE
        )
        for match in stage_pattern.finditer(body):
            stage_name = match.group(1).lower()
            stage_id = match.group(2)
            stages.append(stage_name)
            stage_ids[stage_name] = stage_id
            log(f"Parsed stage: {stage_name} -> {stage_id}")
        
        if stages:
            result["stages"] = stages
            result["stage_ids"] = stage_ids
        else:
            # 尝试从 JSON 块解析
            json_match = re.search(r'"stages":\s*\[([^\]]+)\]', body)
            if json_match:
                try:
                    stages_str = json_match.group(1)
                    stages = [s.strip().strip('"').strip("'") for s in stages_str.split(",")]
                    result["stages"] = stages
                except:
                    pass
        
        if not result.get("stages"):
            return None
        
        return result
    
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
        
        # 检测 Copilot 额度耗尽消息
        if self._check_copilot_quota_message(comment_body, comment_user, pr_number):
            self._send_json(200, {"message": "Copilot quota exhausted handled"})
            return
        
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
    
    def _check_copilot_quota_message(self, comment_body: str, comment_user: str, pr_number: int) -> bool:
        """
        检测 Copilot 额度耗尽消息，触发账号切换
        
        消息示例：
        "Copilot stopped work on behalf of Maybank01 due to an error...
        Your session could not start because you've used up the 300 premium requests allowance..."
        
        返回: True 如果检测到并处理了额度耗尽消息
        """
        # 检查是否是 Copilot 额度耗尽消息
        if not self.accounts.check_copilot_quota_exhausted(comment_body):
            return False
        
        # 从消息中提取被禁用的账号名
        # 格式: "Copilot stopped work on behalf of USERNAME due to an error"
        import re
        match = re.search(r"copilot stopped work on behalf of (\w+)", comment_body.lower())
        
        if match:
            exhausted_username = match.group(1)
            log(f"Detected Copilot quota exhausted for user: {exhausted_username}")
            
            # 禁用该账号
            disabled = self.accounts.disable_account_for_quota(exhausted_username)
            
            if disabled:
                log(f"Account {exhausted_username} disabled due to Copilot quota exhaustion")
                
                # 检查是否还有可用账号
                if self.accounts.has_available_accounts():
                    # 发送通知并用新账号重新请求 Copilot
                    next_account = self.accounts.get_active_account()
                    if next_account:
                        log(f"Switching to account: {next_account.username}")
                        
                        # 发送系统通知
                        self.github.post_comment(
                            pr_number,
                            f"⚠️ **Copilot Quota Exhausted**\n\n"
                            f"Account `{exhausted_username}` has used up its Copilot premium requests quota.\n"
                            f"Switching to account `{next_account.username}` and retrying...\n\n"
                            f"<!-- quota-switch: {exhausted_username} -> {next_account.username} -->",
                            use_user_account=False  # 用 bot 发通知
                        )
                        
                        # 用新账号重新 @copilot
                        self.github.post_comment(
                            pr_number,
                            "@copilot Please continue fixing the issues in this PR.",
                            use_user_account=True  # 用新账号发
                        )
                else:
                    # 没有可用账号了，通知人工
                    log("No more available accounts, escalating to human")
                    notify_user = os.environ.get("NOTIFY_USER", "")
                    mention = f"@{notify_user}" if notify_user else "maintainer"
                    
                    self.github.post_comment(
                        pr_number,
                        f"🚨 **All Copilot Accounts Exhausted**\n\n"
                        f"All configured user accounts have exceeded their Copilot premium request quotas.\n\n"
                        f"{mention} Please investigate manually or wait for quota reset.\n\n"
                        f"<!-- all-accounts-exhausted -->",
                        use_user_account=False
                    )
            
            return True
        
        return False
    
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
    
    if not PIPELINE_SECRET:
        log("WARNING: PIPELINE_SECRET not set")
    
    # 初始化组件
    store = get_store()
    accounts = get_account_manager()
    github = get_github_client()
    
    # 初始化 Pipeline Scheduler
    if PIPELINE_REPO_PATH and os.path.exists(PIPELINE_REPO_PATH):
        scheduler = init_scheduler(
            repo_path=PIPELINE_REPO_PATH,
            github_token=github_pat,
            repo_owner=github.repo_owner,
            repo_name=github.repo_name
        )
        log(f"Pipeline Scheduler initialized: {PIPELINE_REPO_PATH}")
    else:
        log(f"WARNING: Pipeline repo not found at {PIPELINE_REPO_PATH}, scheduler disabled")
    
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
    log("")
    log("Pipeline Endpoints:")
    log("  POST /pipeline/ready      - Start pipeline")
    log("  POST /pipeline/cancel/<id> - Cancel pipeline")
    log("  GET  /pipeline/status/<id> - Pipeline status")
    log("  GET  /pipeline/list       - List pipelines")
    log("=" * 60)
    
    server = HTTPServer(("0.0.0.0", PORT), HubHandler)
    
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        log("Shutting down...")
        server.shutdown()


if __name__ == "__main__":
    main()
