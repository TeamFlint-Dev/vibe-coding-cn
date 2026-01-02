"""
Pipeline Recorder - 流水线事件记录器

将调度事件记录到 GitHub Issue，提供可视化的执行历史
"""

import json
import os
from datetime import datetime
from typing import Optional
from urllib.request import Request, urlopen
from urllib.error import HTTPError


def log(message: str):
    """简单日志"""
    print(f"[recorder] {message}", flush=True)


class PipelineRecorder:
    """将流水线事件记录到 GitHub Issue"""
    
    def __init__(self, repo: str, token: str):
        self.repo = repo
        self.token = token
        self.headers = {
            "Authorization": f"token {token}",
            "Accept": "application/vnd.github.v3+json",
            "Content-Type": "application/json"
        }
    
    def _api_request(
        self,
        endpoint: str,
        method: str = "GET",
        data: Optional[dict] = None
    ) -> Optional[dict]:
        """GitHub API 请求"""
        url = f"https://api.github.com/repos/{self.repo}/{endpoint}"
        
        try:
            body = json.dumps(data).encode() if data else None
            req = Request(url, data=body, headers=self.headers, method=method)
            
            with urlopen(req, timeout=30) as response:
                return json.loads(response.read().decode())
                
        except HTTPError as e:
            log(f"API Error {e.code}: {e.read().decode()}")
            return None
        except Exception as e:
            log(f"Request Error: {e}")
            return None
    
    def create_pipeline_issue(self, pipeline_id: str, config: dict) -> Optional[int]:
        """创建流水线 Issue（仪表板）"""
        stages_checklist = "\n".join(
            f"- [ ] {stage}" for stage in config.get('stages', [])
        )
        
        body = f"""## 流水线信息

| 属性 | 值 |
|------|------|
| **ID** | `{pipeline_id}` |
| **类型** | {config.get('type', 'unknown')} |
| **来源** | {config.get('source_url', 'N/A')} |
| **触发时间** | {datetime.now().isoformat()} |
| **状态** | 🔄 运行中 |

---

## 阶段进度

{stages_checklist}

---

## 执行日志

> 事件将以评论形式记录在下方 👇
"""
        
        result = self._api_request(
            "issues",
            method="POST",
            data={
                "title": f"[Pipeline] {config.get('type', 'unknown')} #{pipeline_id}",
                "body": body,
                "labels": ["pipeline", f"pipeline:{pipeline_id}", "automated"]
            }
        )
        
        if result:
            issue_number = result.get('number')
            log(f"Created pipeline issue #{issue_number}")
            return issue_number
        return None
    
    def log_stage_event(
        self,
        issue_number: int,
        event_type: str,
        data: dict
    ):
        """记录阶段事件为 Comment"""
        templates = {
            "started": """### 🚀 Stage Started: `{stage}`

| 属性 | 值 |
|------|------|
| **时间** | {time} |
| **任务 ID** | `{task_id}` |
""",
            "worker_triggered": """### 🔧 Worker Triggered: `{stage}`

| 属性 | 值 |
|------|------|
| **Run ID** | [{run_id}]({run_url}) |
""",
            "completed": """### ✅ Stage Completed: `{stage}`

| 属性 | 值 |
|------|------|
| **时间** | {time} |
| **耗时** | {duration} |
| **输出** | {output} |
""",
            "failed": """### ❌ Stage Failed: `{stage}`

| 属性 | 值 |
|------|------|
| **时间** | {time} |
| **错误** | {error} |
| **重试次数** | {retry_count}/3 |
""",
        }
        
        template = templates.get(event_type)
        if not template:
            log(f"Unknown event type: {event_type}")
            return
        
        body = template.format(**data)
        
        self._api_request(
            f"issues/{issue_number}/comments",
            method="POST",
            data={"body": body}
        )
        log(f"Logged {event_type} event for stage {data.get('stage', 'unknown')}")
    
    def log_pipeline_event(
        self,
        issue_number: int,
        event_type: str,
        data: dict
    ):
        """记录流水线级别事件"""
        templates = {
            "pipeline_completed": """### 🎉 Pipeline Completed!

| 属性 | 值 |
|------|------|
| **Pipeline ID** | `{pipeline_id}` |
| **总耗时** | {duration:.1f} 秒 |
| **状态** | ✅ 成功 |
""",
            "pipeline_failed": """### 💥 Pipeline Failed

| 属性 | 值 |
|------|------|
| **Pipeline ID** | `{pipeline_id}` |
| **失败阶段** | `{failed_stage}` |
| **错误** | {error} |
| **状态** | ❌ 失败 |

需要人工介入检查问题。
""",
            "pipeline_error": """### ⚠️ Pipeline Error

**错误信息**: {error}

流水线遇到意外错误，请检查日志。
""",
            "cancelled": """### 🚫 Pipeline Cancelled

**Pipeline ID**: `{pipeline_id}`

流水线已被手动取消。
""",
        }
        
        template = templates.get(event_type)
        if not template:
            log(f"Unknown pipeline event type: {event_type}")
            return
        
        body = template.format(**data)
        
        self._api_request(
            f"issues/{issue_number}/comments",
            method="POST",
            data={"body": body}
        )
        log(f"Logged pipeline event: {event_type}")
        
        # 如果是完成或失败，更新 Issue 状态
        if event_type in ("pipeline_completed", "pipeline_failed", "cancelled"):
            self._update_issue_status(issue_number, event_type)
    
    def _update_issue_status(self, issue_number: int, event_type: str):
        """更新 Issue 状态（关闭或添加标签）"""
        status_map = {
            "pipeline_completed": ("closed", ["completed"]),
            "pipeline_failed": ("open", ["failed", "needs-attention"]),
            "cancelled": ("closed", ["cancelled"]),
        }
        
        state, labels = status_map.get(event_type, ("open", []))
        
        # 更新状态
        self._api_request(
            f"issues/{issue_number}",
            method="PATCH",
            data={"state": state}
        )
        
        # 添加标签
        if labels:
            self._api_request(
                f"issues/{issue_number}/labels",
                method="POST",
                data={"labels": labels}
            )
    
    def update_stage_progress(
        self,
        issue_number: int,
        stages: list[dict]
    ):
        """更新 Issue 描述中的阶段进度（可选功能）"""
        # 构建新的进度列表
        progress_lines = []
        for stage in stages:
            status = stage.get('status', 'pending')
            name = stage.get('name', stage.get('id', 'unknown'))
            
            if status == 'completed':
                progress_lines.append(f"- [x] {name} ✅")
            elif status == 'running':
                progress_lines.append(f"- [ ] {name} 🔄")
            elif status == 'failed':
                progress_lines.append(f"- [ ] {name} ❌")
            else:
                progress_lines.append(f"- [ ] {name}")
        
        # 获取当前 Issue 内容
        result = self._api_request(f"issues/{issue_number}")
        if not result:
            return
        
        current_body = result.get('body', '')
        
        # 替换阶段进度部分（简单实现）
        new_progress = "\n".join(progress_lines)
        
        # 查找并替换 "## 阶段进度" 到 "---" 之间的内容
        import re
        pattern = r"(## 阶段进度\n\n)(.*?)(---)"
        replacement = f"\\1{new_progress}\n\n\\3"
        new_body = re.sub(pattern, replacement, current_body, flags=re.DOTALL)
        
        if new_body != current_body:
            self._api_request(
                f"issues/{issue_number}",
                method="PATCH",
                data={"body": new_body}
            )
            log(f"Updated stage progress for issue #{issue_number}")
