"""
Decision Engine - 决策引擎

根据构建结果决定下一步操作：
- 成功 → 发评论通知审查
- 失败 → @copilot 请求修复（最多重试 5 次）
- 5 次失败 → @maintainer 人工介入
- 跳过 → 发评论说明
"""

import os
from typing import List, Optional
from dataclasses import dataclass
from enum import Enum

from state_store import Task, TaskStatus, get_store
from github_client import get_github_client
from account_manager import get_account_manager


def log(message: str):
    """简单日志"""
    print(f"[decision] {message}", flush=True)


class ActionType(Enum):
    """操作类型"""
    COMMENT_BOT = "comment_bot"       # Bot 发评论
    COMMENT_USER = "comment_user"     # 用户发评论（可触发 Copilot）
    ADD_LABEL = "add_label"
    REMOVE_LABEL = "remove_label"
    ESCALATE = "escalate"             # 升级到人工


@dataclass
class Action:
    """待执行的操作"""
    action_type: ActionType
    params: dict


class DecisionEngine:
    """决策引擎"""
    
    def __init__(self):
        self.max_retry = int(os.environ.get("MAX_RETRY_COUNT", "5"))
        self.notify_user = os.environ.get("NOTIFY_USER", "")
        self.reviewer = os.environ.get("REVIEWER_USER", "")
        self.github = get_github_client()
        self.store = get_store()
        self.account_manager = get_account_manager()
    
    def process_callback(
        self,
        task_id: str,
        result: str,
        build_output: Optional[str] = None
    ) -> List[Action]:
        """
        处理回调，返回需要执行的操作列表
        
        参数:
            task_id: 任务 ID
            result: 构建结果 (success/failure/skipped)
            build_output: 构建输出
        """
        task = self.store.get_task(task_id)
        if not task:
            log(f"Task not found: {task_id}")
            return []
        
        log(f"Processing callback for task {task_id}: result={result}")
        
        # 更新任务状态
        if result == "success":
            return self._handle_success(task, build_output)
        elif result == "skipped":
            return self._handle_skipped(task)
        elif result == "failure":
            return self._handle_failure(task, build_output)
        else:
            log(f"Unknown result: {result}")
            return []
    
    def _handle_success(self, task: Task, build_output: Optional[str]) -> List[Action]:
        """处理构建成功"""
        self.store.update_task(
            task.task_id,
            status=TaskStatus.SUCCESS,
            build_output=build_output,
            event="build_success"
        )
        
        # 构建成功评论
        output_preview = ""
        if build_output:
            output_preview = build_output[:2000] if len(build_output) > 2000 else build_output
        
        reviewer_mention = f"@{self.reviewer} " if self.reviewer else ""
        
        comment = f"""## ✅ Build Succeeded

The Verse build completed successfully!

<details>
<summary>Build Output</summary>

```
{output_preview}
```

</details>

{reviewer_mention}Please review and merge this PR.

<!-- task-id: {task.task_id} -->"""
        
        return self._execute_actions([
            Action(ActionType.COMMENT_BOT, {"body": comment, "pr_number": task.pr_number}),
            Action(ActionType.REMOVE_LABEL, {"label": "build-failed", "pr_number": task.pr_number}),
            Action(ActionType.ADD_LABEL, {"label": "ready-for-review", "pr_number": task.pr_number})
        ])
    
    def _handle_skipped(self, task: Task) -> List[Action]:
        """处理构建跳过"""
        self.store.update_task(
            task.task_id,
            status=TaskStatus.SKIPPED,
            event="build_skipped"
        )
        
        comment = f"""## ⏭️ Build Skipped

No Verse code changes detected. Build skipped automatically.

*Changed files do not include `.verse` files or Verse-related directories.*

<!-- task-id: {task.task_id} -->"""
        
        return self._execute_actions([
            Action(ActionType.COMMENT_BOT, {"body": comment, "pr_number": task.pr_number})
        ])
    
    def _handle_failure(self, task: Task, build_output: Optional[str]) -> List[Action]:
        """处理构建失败"""
        # 获取 PR 的连续失败次数
        retry_count = self.store.get_pr_retry_count(task.pr_number) + 1
        
        self.store.update_task(
            task.task_id,
            status=TaskStatus.FAILURE,
            build_output=build_output,
            event="build_failure",
            event_details=f"Retry count: {retry_count}"
        )
        
        log(f"PR #{task.pr_number} failure count: {retry_count}/{self.max_retry}")
        
        if retry_count >= self.max_retry:
            return self._escalate_to_human(task, build_output, retry_count)
        else:
            return self._request_copilot_fix(task, build_output, retry_count)
    
    def _request_copilot_fix(
        self,
        task: Task,
        build_output: Optional[str],
        retry_count: int
    ) -> List[Action]:
        """请求 Copilot 修复"""
        self.store.update_task(
            task.task_id,
            status=TaskStatus.AWAITING_FIX,
            event="copilot_fix_requested",
            event_details=f"Attempt {retry_count}"
        )
        
        # 截断过长的输出
        output_preview = ""
        if build_output:
            output_preview = build_output[:4000] if len(build_output) > 4000 else build_output
        
        # 系统消息（Bot 发）
        system_comment = f"""## ❌ Build Failed (Attempt {retry_count}/{self.max_retry})

The Verse build failed. See error details below:

```
{output_preview}
```

*Requesting Copilot assistance...*

<!-- task-id: {task.task_id} -->"""
        
        # Copilot 请求（用户发，可触发 Copilot）
        copilot_comment = f"""@copilot The build failed. Please analyze the error and fix it:

```
{output_preview}
```

Please fix the issues and push a new commit.

<!-- copilot-fix-request: {task.task_id} -->"""
        
        return self._execute_actions([
            Action(ActionType.COMMENT_BOT, {"body": system_comment, "pr_number": task.pr_number}),
            Action(ActionType.COMMENT_USER, {"body": copilot_comment, "pr_number": task.pr_number}),
            Action(ActionType.ADD_LABEL, {"label": "build-failed", "pr_number": task.pr_number})
        ])
    
    def _escalate_to_human(
        self,
        task: Task,
        build_output: Optional[str],
        retry_count: int
    ) -> List[Action]:
        """升级到人工处理"""
        self.store.update_task(
            task.task_id,
            status=TaskStatus.ESCALATED,
            event="escalated_to_human",
            event_details=f"After {retry_count} failures"
        )
        
        output_preview = ""
        if build_output:
            output_preview = build_output[:4000] if len(build_output) > 4000 else build_output
        
        notify_mention = f"@{self.notify_user}" if self.notify_user else "maintainer"
        
        comment = f"""## 🚨 Build Failed - Human Intervention Required

The build has failed **{retry_count} times** consecutively. Automatic fixes have been exhausted.

{notify_mention} Please investigate manually.

<details>
<summary>Last Error Output</summary>

```
{output_preview}
```

</details>

<!-- task-id: {task.task_id} -->
<!-- escalated: true -->"""
        
        return self._execute_actions([
            Action(ActionType.COMMENT_BOT, {"body": comment, "pr_number": task.pr_number}),
            Action(ActionType.ADD_LABEL, {"label": "needs-human-help", "pr_number": task.pr_number})
        ])
    
    def _execute_actions(self, actions: List[Action]) -> List[Action]:
        """执行操作列表"""
        executed = []
        
        for action in actions:
            try:
                if action.action_type == ActionType.COMMENT_BOT:
                    success, _ = self.github.post_comment(
                        action.params["pr_number"],
                        action.params["body"],
                        use_user_account=False
                    )
                    if success:
                        executed.append(action)
                
                elif action.action_type == ActionType.COMMENT_USER:
                    # 检查是否有可用账号
                    if not self.account_manager.has_available_accounts():
                        log("No available user accounts, skipping user comment")
                        # 发一条 bot 消息说明情况
                        self.github.post_comment(
                            action.params["pr_number"],
                            "⚠️ Unable to request Copilot fix: All user accounts are unavailable.",
                            use_user_account=False
                        )
                        continue
                    
                    success, username = self.github.post_comment(
                        action.params["pr_number"],
                        action.params["body"],
                        use_user_account=True
                    )
                    if success:
                        executed.append(action)
                        log(f"Copilot request sent by {username}")
                
                elif action.action_type == ActionType.ADD_LABEL:
                    self.github.add_label(
                        action.params["pr_number"],
                        action.params["label"]
                    )
                    executed.append(action)
                
                elif action.action_type == ActionType.REMOVE_LABEL:
                    self.github.remove_label(
                        action.params["pr_number"],
                        action.params["label"]
                    )
                    executed.append(action)
                    
            except Exception as e:
                log(f"Error executing action {action.action_type}: {e}")
        
        return executed


# 全局单例
_engine: Optional[DecisionEngine] = None


def get_decision_engine() -> DecisionEngine:
    """获取全局决策引擎实例"""
    global _engine
    if _engine is None:
        _engine = DecisionEngine()
    return _engine
