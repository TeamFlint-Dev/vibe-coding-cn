"""
Copilot Monitor - Copilot 状态监控

通过轮询 GitHub Timeline API 监控 Copilot 工作状态，
当检测到失败（如额度耗尽）时自动切换账号。
"""

import json
import os
import threading
import time
from dataclasses import dataclass
from datetime import datetime
from typing import Dict, List, Optional, Tuple
from urllib.request import Request, urlopen
from urllib.error import HTTPError, URLError


def log(message: str):
    """简单日志"""
    print(f"[copilot-monitor] {message}", flush=True)


@dataclass
class CopilotRequest:
    """Copilot 请求追踪"""
    pr_number: int
    username: str           # 发起请求的用户
    task_id: str            # 关联的任务 ID
    requested_at: float     # 请求时间
    last_checked: float = 0  # 上次检查时间
    timeline_event_id: Optional[int] = None  # 已处理的最新事件 ID


class CopilotMonitor:
    """Copilot 状态监控器"""
    
    # 检查间隔（秒）
    CHECK_INTERVAL = 30
    
    # 请求超时（秒）- 超过这个时间还没响应就认为异常
    REQUEST_TIMEOUT = 600  # 10 分钟
    
    def __init__(self):
        self._pending_requests: Dict[str, CopilotRequest] = {}  # key: f"{pr_number}:{username}"
        self._lock = threading.Lock()
        self._running = False
        self._thread: Optional[threading.Thread] = None
        
        # GitHub API 配置
        self.repo_owner = os.environ.get("REPO_OWNER", "TeamFlint-Dev")
        self.repo_name = os.environ.get("REPO_NAME", "vibe-coding-cn")
        self.api_pat = os.environ.get("GITHUB_PAT", "")
        
        # 回调函数（由外部设置）
        self.on_copilot_success: Optional[callable] = None
        self.on_copilot_failure: Optional[callable] = None
    
    def register_request(
        self,
        pr_number: int,
        username: str,
        task_id: str
    ) -> str:
        """
        注册一个 Copilot 请求，开始监控
        
        返回: 请求 key
        """
        key = f"{pr_number}:{username}"
        
        with self._lock:
            self._pending_requests[key] = CopilotRequest(
                pr_number=pr_number,
                username=username,
                task_id=task_id,
                requested_at=time.time()
            )
        
        log(f"Registered Copilot request: PR #{pr_number} by {username}")
        
        # 确保监控线程在运行
        self._ensure_running()
        
        return key
    
    def _ensure_running(self):
        """确保监控线程在运行"""
        if self._running:
            return
        
        self._running = True
        self._thread = threading.Thread(target=self._monitor_loop, daemon=True)
        self._thread.start()
        log("Monitor thread started")
    
    def _monitor_loop(self):
        """监控循环"""
        while self._running:
            try:
                self._check_all_requests()
            except Exception as e:
                log(f"Error in monitor loop: {e}")
            
            time.sleep(self.CHECK_INTERVAL)
    
    def _check_all_requests(self):
        """检查所有待处理的请求"""
        with self._lock:
            requests_to_check = list(self._pending_requests.items())
        
        if not requests_to_check:
            return
        
        for key, request in requests_to_check:
            try:
                self._check_request(key, request)
            except Exception as e:
                log(f"Error checking request {key}: {e}")
    
    def _check_request(self, key: str, request: CopilotRequest):
        """检查单个请求的状态"""
        now = time.time()
        
        # 检查超时
        if now - request.requested_at > self.REQUEST_TIMEOUT:
            log(f"Request {key} timed out")
            self._remove_request(key)
            return
        
        # 获取 PR timeline
        events = self._get_timeline_events(request.pr_number)
        if not events:
            return
        
        # 查找 Copilot 事件
        for event in events:
            event_type = event.get("event", "")
            if not event_type.startswith("copilot_"):
                continue
            
            actor = event.get("actor", {}).get("login", "")
            event_id = event.get("id", 0)
            created_at = event.get("created_at", "")
            
            # 跳过已处理的事件
            if request.timeline_event_id and event_id <= request.timeline_event_id:
                continue
            
            # 检查是否是我们的请求
            if actor.lower() != request.username.lower():
                continue
            
            # 检查事件时间是否在请求之后
            event_time = self._parse_time(created_at)
            if event_time and event_time < request.requested_at:
                continue
            
            # 更新已处理的事件 ID
            with self._lock:
                if key in self._pending_requests:
                    self._pending_requests[key].timeline_event_id = event_id
            
            # 处理事件
            if event_type == "copilot_work_started":
                log(f"Copilot started work for {key}")
            
            elif event_type == "copilot_work_finished":
                log(f"Copilot finished work successfully for {key}")
                self._handle_success(key, request)
                return
            
            elif event_type == "copilot_work_finished_failure":
                log(f"Copilot failed for {key}")
                self._handle_failure(key, request)
                return
    
    def _get_timeline_events(self, pr_number: int) -> List[dict]:
        """获取 PR 的 timeline 事件"""
        url = f"https://api.github.com/repos/{self.repo_owner}/{self.repo_name}/issues/{pr_number}/timeline"
        
        headers = {
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28"
        }
        
        if self.api_pat:
            headers["Authorization"] = f"Bearer {self.api_pat}"
        
        try:
            req = Request(url, headers=headers)
            with urlopen(req, timeout=30) as response:
                return json.loads(response.read().decode())
        except Exception as e:
            log(f"Error fetching timeline: {e}")
            return []
    
    def _parse_time(self, iso_time: str) -> Optional[float]:
        """解析 ISO 时间为 timestamp"""
        try:
            # 格式: 2025-12-31T18:28:25Z
            dt = datetime.fromisoformat(iso_time.replace("Z", "+00:00"))
            return dt.timestamp()
        except Exception:
            return None
    
    def _handle_success(self, key: str, request: CopilotRequest):
        """处理 Copilot 成功"""
        self._remove_request(key)
        
        if self.on_copilot_success:
            self.on_copilot_success(
                pr_number=request.pr_number,
                username=request.username,
                task_id=request.task_id
            )
    
    def _handle_failure(self, key: str, request: CopilotRequest):
        """处理 Copilot 失败"""
        self._remove_request(key)
        
        if self.on_copilot_failure:
            self.on_copilot_failure(
                pr_number=request.pr_number,
                username=request.username,
                task_id=request.task_id
            )
    
    def _remove_request(self, key: str):
        """移除请求"""
        with self._lock:
            if key in self._pending_requests:
                del self._pending_requests[key]
    
    def get_stats(self) -> dict:
        """获取统计信息"""
        with self._lock:
            pending = [
                {
                    "pr_number": r.pr_number,
                    "username": r.username,
                    "task_id": r.task_id,
                    "requested_at": r.requested_at,
                    "age_seconds": time.time() - r.requested_at
                }
                for r in self._pending_requests.values()
            ]
        
        return {
            "pending_requests": len(pending),
            "requests": pending
        }
    
    def stop(self):
        """停止监控"""
        self._running = False


# 全局单例
_monitor: Optional[CopilotMonitor] = None


def get_copilot_monitor() -> CopilotMonitor:
    """获取全局 Copilot 监控器实例"""
    global _monitor
    if _monitor is None:
        _monitor = CopilotMonitor()
    return _monitor
