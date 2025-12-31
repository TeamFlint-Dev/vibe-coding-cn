"""
State Store - 内存状态管理

管理任务状态和历史记录（纯内存，无持久化需求）
"""

import time
import uuid
from dataclasses import dataclass, field
from typing import Dict, List, Optional
from enum import Enum


class TaskStatus(Enum):
    """任务状态枚举"""
    TRIGGERED = "triggered"      # 已触发，等待 Actions 执行
    BUILDING = "building"        # 构建中
    SUCCESS = "success"          # 构建成功
    FAILURE = "failure"          # 构建失败
    SKIPPED = "skipped"          # 跳过（无需构建）
    AWAITING_FIX = "awaiting_fix"  # 等待 Copilot 修复
    ESCALATED = "escalated"      # 已升级到人工处理


@dataclass
class TaskHistory:
    """任务历史记录"""
    timestamp: float
    event: str
    details: Optional[str] = None


@dataclass
class Task:
    """任务数据结构"""
    task_id: str
    pr_number: int
    head_sha: str
    head_ref: str
    status: TaskStatus
    retry_count: int = 0
    created_at: float = field(default_factory=time.time)
    updated_at: float = field(default_factory=time.time)
    build_output: Optional[str] = None
    history: List[TaskHistory] = field(default_factory=list)
    
    def to_dict(self) -> dict:
        """转换为字典"""
        return {
            "task_id": self.task_id,
            "pr_number": self.pr_number,
            "head_sha": self.head_sha,
            "head_ref": self.head_ref,
            "status": self.status.value,
            "retry_count": self.retry_count,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
            "build_output": self.build_output[:500] if self.build_output else None,
            "history": [
                {"timestamp": h.timestamp, "event": h.event, "details": h.details}
                for h in self.history[-10:]  # 只返回最近10条
            ]
        }


class StateStore:
    """内存状态存储"""
    
    def __init__(self, max_tasks: int = 200):
        self._tasks: Dict[str, Task] = {}
        self._pr_to_tasks: Dict[int, List[str]] = {}  # PR -> task_ids 映射
        self._max_tasks = max_tasks
    
    def create_task(
        self,
        pr_number: int,
        head_sha: str,
        head_ref: str,
        trigger_type: str = "pr-event"
    ) -> str:
        """创建新任务，返回 task_id"""
        task_id = f"task_{uuid.uuid4().hex[:12]}"
        
        task = Task(
            task_id=task_id,
            pr_number=pr_number,
            head_sha=head_sha,
            head_ref=head_ref,
            status=TaskStatus.TRIGGERED,
            history=[TaskHistory(
                timestamp=time.time(),
                event="created",
                details=f"Triggered by {trigger_type}"
            )]
        )
        
        self._tasks[task_id] = task
        
        # 更新 PR -> tasks 映射
        if pr_number not in self._pr_to_tasks:
            self._pr_to_tasks[pr_number] = []
        self._pr_to_tasks[pr_number].append(task_id)
        
        # 清理旧任务（保持内存使用可控）
        self._cleanup_old_tasks()
        
        return task_id
    
    def get_task(self, task_id: str) -> Optional[Task]:
        """获取任务"""
        return self._tasks.get(task_id)
    
    def get_pr_tasks(self, pr_number: int) -> List[Task]:
        """获取 PR 的所有任务"""
        task_ids = self._pr_to_tasks.get(pr_number, [])
        return [self._tasks[tid] for tid in task_ids if tid in self._tasks]
    
    def get_pr_retry_count(self, pr_number: int) -> int:
        """获取 PR 的连续失败次数"""
        tasks = self.get_pr_tasks(pr_number)
        if not tasks:
            return 0
        
        # 按时间倒序，计算连续失败次数
        sorted_tasks = sorted(tasks, key=lambda t: t.created_at, reverse=True)
        count = 0
        for task in sorted_tasks:
            if task.status == TaskStatus.FAILURE or task.status == TaskStatus.AWAITING_FIX:
                count += 1
            elif task.status == TaskStatus.SUCCESS:
                break  # 遇到成功就停止计数
        return count
    
    def update_task(
        self,
        task_id: str,
        status: Optional[TaskStatus] = None,
        build_output: Optional[str] = None,
        event: Optional[str] = None,
        event_details: Optional[str] = None
    ) -> bool:
        """更新任务状态"""
        task = self._tasks.get(task_id)
        if not task:
            return False
        
        task.updated_at = time.time()
        
        if status:
            task.status = status
        
        if build_output:
            task.build_output = build_output
        
        if event:
            task.history.append(TaskHistory(
                timestamp=time.time(),
                event=event,
                details=event_details
            ))
        
        return True
    
    def increment_retry(self, task_id: str) -> int:
        """增加重试次数，返回当前次数"""
        task = self._tasks.get(task_id)
        if not task:
            return 0
        
        task.retry_count += 1
        task.updated_at = time.time()
        task.history.append(TaskHistory(
            timestamp=time.time(),
            event="retry_incremented",
            details=f"Retry count: {task.retry_count}"
        ))
        
        return task.retry_count
    
    def get_all_tasks(self) -> List[Task]:
        """获取所有任务（调试用）"""
        return list(self._tasks.values())
    
    def get_stats(self) -> dict:
        """获取统计信息"""
        tasks = list(self._tasks.values())
        status_counts = {}
        for task in tasks:
            status = task.status.value
            status_counts[status] = status_counts.get(status, 0) + 1
        
        return {
            "total_tasks": len(tasks),
            "total_prs": len(self._pr_to_tasks),
            "status_counts": status_counts
        }
    
    def _cleanup_old_tasks(self):
        """清理旧任务，保持内存使用可控"""
        if len(self._tasks) <= self._max_tasks:
            return
        
        # 按创建时间排序，删除最旧的任务
        sorted_tasks = sorted(
            self._tasks.values(),
            key=lambda t: t.created_at
        )
        
        to_remove = len(self._tasks) - self._max_tasks
        for task in sorted_tasks[:to_remove]:
            del self._tasks[task.task_id]
            # 清理 PR 映射
            if task.pr_number in self._pr_to_tasks:
                self._pr_to_tasks[task.pr_number] = [
                    tid for tid in self._pr_to_tasks[task.pr_number]
                    if tid != task.task_id
                ]
                if not self._pr_to_tasks[task.pr_number]:
                    del self._pr_to_tasks[task.pr_number]


# 全局单例
_store: Optional[StateStore] = None


def get_store() -> StateStore:
    """获取全局状态存储实例"""
    global _store
    if _store is None:
        _store = StateStore()
    return _store
