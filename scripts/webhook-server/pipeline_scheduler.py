"""
Pipeline Scheduler - 流水线调度器

负责：
1. 接收 Planner Agent 的通知
2. 轮询 Beads 任务队列
3. 串行触发 Worker Agent
4. 处理失败重试和回退
5. 记录事件到 GitHub Issue
"""

import asyncio
import json
import os
import subprocess
import time
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from pathlib import Path
from typing import Optional

from pipeline_recorder import PipelineRecorder


def log(message: str):
    """简单日志"""
    print(f"[scheduler] {message}", flush=True)


# Beads CLI 路径 - 在 webhook 服务目录下
BD_PATH = os.environ.get('BD_PATH', '/opt/webhook/bd')


class PipelineStatus(Enum):
    """流水线状态"""
    PENDING = "pending"          # 等待开始
    RUNNING = "running"          # 运行中
    COMPLETED = "completed"      # 完成
    FAILED = "failed"            # 失败
    CANCELLED = "cancelled"      # 已取消


class StageStatus(Enum):
    """阶段状态"""
    PENDING = "pending"
    RUNNING = "running"
    COMPLETED = "completed"
    FAILED = "failed"
    SKIPPED = "skipped"


@dataclass
class StageInfo:
    """阶段信息"""
    id: str
    name: str
    status: StageStatus = StageStatus.PENDING
    task_id: Optional[str] = None
    run_id: Optional[int] = None
    started_at: Optional[float] = None
    completed_at: Optional[float] = None
    retry_count: int = 0
    output: Optional[str] = None
    error: Optional[str] = None


@dataclass
class PipelineInfo:
    """流水线信息"""
    pipeline_id: str
    pipeline_type: str
    status: PipelineStatus = PipelineStatus.PENDING
    issue_number: Optional[int] = None
    stages: list[StageInfo] = field(default_factory=list)
    source_url: Optional[str] = None
    branch: Optional[str] = None  # 工作分支名称（Worker 将提交到此分支）
    created_at: float = field(default_factory=time.time)
    updated_at: float = field(default_factory=time.time)
    
    def to_dict(self) -> dict:
        return {
            "pipeline_id": self.pipeline_id,
            "type": self.pipeline_type,
            "status": self.status.value,
            "issue_number": self.issue_number,
            "stages": [
                {
                    "id": s.id,
                    "name": s.name,
                    "status": s.status.value,
                    "task_id": s.task_id,
                    "run_id": s.run_id,
                    "retry_count": s.retry_count,
                }
                for s in self.stages
            ],
            "source_url": self.source_url,
            "branch": self.branch,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }


class RepoSync:
    """仓库同步管理"""
    
    def __init__(self, repo_path: str):
        self.repo_path = Path(repo_path)
        # Git 认证 - 使用 GH_TOKEN 环境变量
        self.git_env = os.environ.copy()
        gh_token = os.environ.get('GH_TOKEN') or os.environ.get('GITHUB_PAT')
        if gh_token:
            # 配置 git 使用 token 进行认证
            self.git_env['GIT_ASKPASS'] = '/bin/echo'
            self.git_env['GIT_USERNAME'] = 'x-access-token'
            self.git_env['GIT_PASSWORD'] = gh_token
            # 使用 credential helper
            self.git_env['GIT_TERMINAL_PROMPT'] = '0'
    
    def sync(self) -> bool:
        """拉取最新代码"""
        try:
            # 使用 token URL 进行 fetch
            gh_token = os.environ.get('GH_TOKEN') or os.environ.get('GITHUB_PAT')
            if gh_token:
                # 使用带 token 的 URL
                log(f"Syncing with token (first 4 chars: {gh_token[:4]}...)")
                subprocess.run(
                    ['git', 'fetch', f'https://x-access-token:{gh_token}@github.com/TeamFlint-Dev/vibe-coding-cn.git', 'main'],
                    cwd=self.repo_path,
                    check=True,
                    capture_output=True,
                    env=self.git_env
                )
            else:
                log("WARNING: No GH_TOKEN found, using origin URL")
                subprocess.run(
                    ['git', 'fetch', 'origin'],
                    cwd=self.repo_path,
                    check=True,
                    capture_output=True
                )
            subprocess.run(
                ['git', 'reset', '--hard', 'FETCH_HEAD'],
                cwd=self.repo_path,
                check=True,
                capture_output=True
            )
            
            # 注意: 使用 no-db 模式时，bd 命令会直接从 .beads/issues.jsonl 读取
            # 不需要执行 sync --import-only (那需要 SQLite 后端)
            
            log("Repository synced successfully")
            return True
            
        except subprocess.CalledProcessError as e:
            log(f"Sync failed: {e.stderr.decode() if e.stderr else str(e)}")
            return False
    
    def get_ready_tasks(self, pipeline_id: str) -> list[dict]:
        """获取可执行的任务"""
        try:
            result = subprocess.run(
                [BD_PATH, '--no-db', 'ready', '--label', f'pipeline:{pipeline_id}', '--json'],
                cwd=self.repo_path,
                capture_output=True,
                check=True
            )
            if result.stdout:
                return json.loads(result.stdout)
            return []
        except (subprocess.CalledProcessError, json.JSONDecodeError) as e:
            log(f"Failed to get ready tasks: {e}")
            return []
    
    def get_task_status(self, task_id: str) -> Optional[dict]:
        """获取任务状态"""
        try:
            result = subprocess.run(
                [BD_PATH, '--no-db', 'show', task_id, '--json'],
                cwd=self.repo_path,
                capture_output=True,
                check=True
            )
            if result.stdout:
                return json.loads(result.stdout)
            return None
        except (subprocess.CalledProcessError, json.JSONDecodeError):
            return None
    
    def update_task_status(self, task_id: str, status: str, reason: str = "") -> bool:
        """更新任务状态"""
        try:
            cmd = [BD_PATH, '--no-db', 'update', task_id, '--status', status]
            if reason:
                cmd.extend(['--reason', reason])
            subprocess.run(cmd, cwd=self.repo_path, check=True, capture_output=True)
            return True
        except subprocess.CalledProcessError:
            return False
    
    def close_task(self, task_id: str, reason: str) -> bool:
        """关闭任务"""
        try:
            subprocess.run(
                [BD_PATH, '--no-db', 'close', task_id, '--reason', reason],
                cwd=self.repo_path,
                check=True,
                capture_output=True
            )
            return True
        except subprocess.CalledProcessError:
            return False


class WorkerRunner:
    """Worker Agent 执行器"""
    
    def __init__(self, repo_path: str):
        self.repo_path = Path(repo_path)
    
    def trigger_worker(self, task_id: str, stage_id: str, branch: Optional[str] = None) -> Optional[int]:
        """触发 Worker Agent，返回 run_id
        
        Args:
            task_id: Beads 任务 ID
            stage_id: 阶段 ID
            branch: 工作分支名称（Worker 将提交到此分支）
        """
        try:
            # 构建参数列表
            cmd = [
                'gh', 'workflow', 'run', 'worker-agent.md',
                '-f', f'task_id={task_id}',
                '-f', f'stage_id={stage_id}'
            ]
            
            # 添加分支参数
            if branch:
                cmd.extend(['-f', f'branch={branch}'])
            
            result = subprocess.run(
                cmd,
                cwd=self.repo_path,
                capture_output=True,
                check=True
            )
            
            log(f"Worker workflow triggered for task {task_id}, stage {stage_id}" + (f", branch {branch}" if branch else ""))
            
            # gh workflow run 不直接返回 run_id，需要等待后查询
            # 等待几秒后获取最新的 run
            import time
            time.sleep(3)
            
            # 获取最新的 workflow run
            list_result = subprocess.run(
                [
                    'gh', 'run', 'list',
                    '--workflow', 'worker-agent.md',
                    '--limit', '1',
                    '--json', 'databaseId'
                ],
                cwd=self.repo_path,
                capture_output=True,
                check=True
            )
            
            if list_result.stdout:
                runs = json.loads(list_result.stdout)
                if runs:
                    run_id = runs[0].get('databaseId')
                    log(f"Worker triggered, run_id: {run_id}")
                    return run_id
            
            return None
            
        except subprocess.CalledProcessError as e:
            log(f"Failed to trigger worker: {e.stderr.decode() if e.stderr else str(e)}")
            return None
    
    def get_run_status(self, run_id: int) -> Optional[str]:
        """获取 workflow run 状态"""
        try:
            result = subprocess.run(
                ['gh', 'run', 'view', str(run_id), '--json', 'status,conclusion'],
                cwd=self.repo_path,
                capture_output=True,
                check=True
            )
            data = json.loads(result.stdout)
            
            if data.get('status') == 'completed':
                return data.get('conclusion', 'unknown')
            else:
                return 'running'
                
        except (subprocess.CalledProcessError, json.JSONDecodeError):
            return None
    
    def cancel_run(self, run_id: int) -> bool:
        """取消 workflow run"""
        try:
            subprocess.run(
                ['gh', 'run', 'cancel', str(run_id)],
                cwd=self.repo_path,
                check=True,
                capture_output=True
            )
            return True
        except subprocess.CalledProcessError:
            return False


class PipelineScheduler:
    """流水线调度器"""
    
    def __init__(
        self,
        repo_path: str,
        github_token: str,
        repo_owner: str,
        repo_name: str
    ):
        self.repo_sync = RepoSync(repo_path)
        self.worker = WorkerRunner(repo_path)
        self.recorder = PipelineRecorder(
            repo=f"{repo_owner}/{repo_name}",
            token=github_token
        )
        
        self._pipelines: dict[str, PipelineInfo] = {}
        self._running_tasks: dict[str, asyncio.Task] = {}
        
        # 配置
        self.max_retries = int(os.environ.get('PIPELINE_MAX_RETRIES', '3'))
        self.stage_timeout = int(os.environ.get('PIPELINE_STAGE_TIMEOUT', '1800'))  # 30 分钟
        self.poll_interval = int(os.environ.get('PIPELINE_POLL_INTERVAL', '30'))
    
    async def start_pipeline(
        self,
        pipeline_id: str,
        pipeline_type: str,
        stages: list[str],
        source_url: Optional[str] = None,
        stage_ids: Optional[dict[str, str]] = None,
        issue_number: Optional[int] = None,
        branch: Optional[str] = None
    ) -> PipelineInfo:
        """启动新流水线
        
        Args:
            pipeline_id: 流水线 ID
            pipeline_type: 流水线类型
            stages: 阶段名称列表
            source_url: 源 URL
            stage_ids: 阶段 ID 映射 {stage_name: beads_task_id}
            issue_number: 已创建的 Issue 号（可选，用于关联现有 Issue）
            branch: 工作分支名称（Worker 将提交到此分支）
        """
        
        # 如果指定了分支，先创建分支
        if branch:
            if not self._create_branch(branch):
                log(f"Warning: Failed to create branch {branch}, continuing anyway")
        
        # 创建流水线信息
        pipeline = PipelineInfo(
            pipeline_id=pipeline_id,
            pipeline_type=pipeline_type,
            source_url=source_url,
            branch=branch,
            stages=[
                StageInfo(
                    id=stage_name, 
                    name=stage_name,
                    task_id=stage_ids.get(stage_name) if stage_ids else None
                )
                for stage_name in stages
            ]
        )
        
        # 创建或使用已有的 GitHub Issue 作为仪表板
        if issue_number:
            pipeline.issue_number = issue_number
        else:
            pipeline.issue_number = self.recorder.create_pipeline_issue(
                pipeline_id=pipeline_id,
                config={
                    "type": pipeline_type,
                    "source_url": source_url,
                    "stages": stages,
                    "stage_ids": stage_ids
                }
            )
        
        # 保存并启动
        self._pipelines[pipeline_id] = pipeline
        
        # 在后台启动调度循环
        task = asyncio.create_task(self._run_pipeline_loop(pipeline_id))
        self._running_tasks[pipeline_id] = task
        
        log(f"Pipeline {pipeline_id} started, issue #{pipeline.issue_number}")
        return pipeline
    
    def get_pipeline(self, pipeline_id: str) -> Optional[PipelineInfo]:
        """获取流水线信息"""
        return self._pipelines.get(pipeline_id)
    
    def get_all_pipelines(self) -> list[PipelineInfo]:
        """获取所有流水线"""
        return list(self._pipelines.values())
    
    async def cancel_pipeline(self, pipeline_id: str) -> bool:
        """取消流水线"""
        pipeline = self._pipelines.get(pipeline_id)
        if not pipeline:
            return False
        
        # 取消运行中的任务
        if pipeline_id in self._running_tasks:
            self._running_tasks[pipeline_id].cancel()
            del self._running_tasks[pipeline_id]
        
        # 更新状态
        pipeline.status = PipelineStatus.CANCELLED
        pipeline.updated_at = time.time()
        
        # 记录
        if pipeline.issue_number:
            self.recorder.log_pipeline_event(
                issue_number=pipeline.issue_number,
                event_type="cancelled",
                data={"pipeline_id": pipeline_id}
            )
        
        return True
    
    def _create_branch(self, branch_name: str) -> bool:
        """创建工作分支
        
        Args:
            branch_name: 分支名称 (如 pipeline/p001)
            
        Returns:
            是否成功创建分支
        """
        try:
            # 先同步仓库
            self.repo_sync.sync()
            
            # 检查分支是否已存在
            result = subprocess.run(
                ['git', 'branch', '-r', '--list', f'origin/{branch_name}'],
                cwd=self.repo_sync.repo_path,
                capture_output=True
            )
            if result.stdout.strip():
                log(f"Branch {branch_name} already exists")
                return True
            
            # 创建新分支
            subprocess.run(
                ['git', 'checkout', '-b', branch_name],
                cwd=self.repo_sync.repo_path,
                check=True,
                capture_output=True,
                env=self.repo_sync.git_env
            )
            
            # 推送到远程 - 使用 token URL
            gh_token = os.environ.get('GH_TOKEN') or os.environ.get('GITHUB_PAT')
            if gh_token:
                push_url = f'https://x-access-token:{gh_token}@github.com/TeamFlint-Dev/vibe-coding-cn.git'
                subprocess.run(
                    ['git', 'push', '-u', push_url, branch_name],
                    cwd=self.repo_sync.repo_path,
                    check=True,
                    capture_output=True,
                    env=self.repo_sync.git_env
                )
            else:
                subprocess.run(
                    ['git', 'push', '-u', 'origin', branch_name],
                    cwd=self.repo_sync.repo_path,
                    check=True,
                    capture_output=True,
                    env=self.repo_sync.git_env
                )
            
            # 切回 main
            subprocess.run(
                ['git', 'checkout', 'main'],
                cwd=self.repo_sync.repo_path,
                check=True,
                capture_output=True,
                env=self.repo_sync.git_env
            )
            
            log(f"Created branch: {branch_name}")
            return True
            
        except subprocess.CalledProcessError as e:
            log(f"Failed to create branch {branch_name}: {e.stderr.decode() if e.stderr else str(e)}")
            return False
        except Exception as e:
            log(f"Error creating branch: {e}")
            return False
    
    def _create_merge_pr(self, pipeline: PipelineInfo) -> Optional[int]:
        """创建合并 PR，将工作分支合并到 main
        
        Returns:
            PR 号，如果创建失败返回 None
        """
        if not pipeline.branch:
            return None
        
        try:
            # 使用 GitHub API 创建 PR
            import urllib.request
            import urllib.error
            
            gh_token = os.environ.get('GH_TOKEN') or os.environ.get('GITHUB_PAT')
            if not gh_token:
                log("No GH_TOKEN for PR creation")
                return None
            
            pr_body = f'''## Pipeline Completion

**Pipeline ID**: `{pipeline.pipeline_id}`
**Type**: `{pipeline.pipeline_type}`
**Branch**: `{pipeline.branch}`
**Stages**: {len(pipeline.stages)} completed

### Stages Completed
{chr(10).join(f'- ✅ {s.name}' for s in pipeline.stages)}

### Review Notes
- All pipeline stages have completed successfully
- Please review the changes before merging
- Related Issue: #{pipeline.issue_number}
'''
            
            data = json.dumps({
                "title": f'[Pipeline {pipeline.pipeline_id}] {pipeline.pipeline_type} completed',
                "body": pr_body,
                "head": pipeline.branch,
                "base": "main"
            }).encode('utf-8')
            
            req = urllib.request.Request(
                "https://api.github.com/repos/TeamFlint-Dev/vibe-coding-cn/pulls",
                data=data,
                headers={
                    "Authorization": f"token {gh_token}",
                    "Accept": "application/vnd.github.v3+json",
                    "Content-Type": "application/json"
                },
                method="POST"
            )
            
            with urllib.request.urlopen(req) as resp:
                result = json.loads(resp.read().decode())
                pr_number = result.get('number')
                log(f"Created PR #{pr_number} for pipeline {pipeline.pipeline_id}")
                return pr_number
            
        except urllib.error.HTTPError as e:
            log(f"Failed to create PR for pipeline {pipeline.pipeline_id}: HTTP {e.code} - {e.read().decode()}")
            return None
        except Exception as e:
            log(f"Error creating PR: {e}")
            return None

    async def _run_pipeline_loop(self, pipeline_id: str):
        """流水线调度主循环"""
        pipeline = self._pipelines[pipeline_id]
        pipeline.status = PipelineStatus.RUNNING
        
        try:
            for stage in pipeline.stages:
                success = await self._execute_stage(pipeline, stage)
                
                if not success:
                    # 阶段失败，检查是否需要回退
                    if not await self._handle_stage_failure(pipeline, stage):
                        # 无法恢复，标记流水线失败
                        pipeline.status = PipelineStatus.FAILED
                        self.recorder.log_pipeline_event(
                            issue_number=pipeline.issue_number,
                            event_type="pipeline_failed",
                            data={
                                "pipeline_id": pipeline_id,
                                "failed_stage": stage.id,
                                "error": stage.error
                            }
                        )
                        return
            
            # 所有阶段完成
            pipeline.status = PipelineStatus.COMPLETED
            pipeline.updated_at = time.time()
            
            # 如果有工作分支，创建 PR
            if pipeline.branch:
                pr_number = self._create_merge_pr(pipeline)
                if pr_number:
                    log(f"Pipeline {pipeline_id} completed, PR #{pr_number} created")
                    self.recorder.log_pipeline_event(
                        issue_number=pipeline.issue_number,
                        event_type="pipeline_completed",
                        data={
                            "pipeline_id": pipeline_id,
                            "duration": time.time() - pipeline.created_at,
                            "pr_number": pr_number,
                            "branch": pipeline.branch
                        }
                    )
                else:
                    log(f"Pipeline {pipeline_id} completed, but PR creation failed")
                    self.recorder.log_pipeline_event(
                        issue_number=pipeline.issue_number,
                        event_type="pipeline_completed",
                        data={
                            "pipeline_id": pipeline_id,
                            "duration": time.time() - pipeline.created_at,
                            "pr_creation_failed": True,
                            "branch": pipeline.branch
                        }
                    )
            else:
                self.recorder.log_pipeline_event(
                    issue_number=pipeline.issue_number,
                    event_type="pipeline_completed",
                    data={
                        "pipeline_id": pipeline_id,
                        "duration": time.time() - pipeline.created_at
                    }
                )
            log(f"Pipeline {pipeline_id} completed successfully")
            
        except asyncio.CancelledError:
            log(f"Pipeline {pipeline_id} was cancelled")
            raise
        except Exception as e:
            log(f"Pipeline {pipeline_id} error: {e}")
            pipeline.status = PipelineStatus.FAILED
            self.recorder.log_pipeline_event(
                issue_number=pipeline.issue_number,
                event_type="pipeline_error",
                data={"error": str(e)}
            )
    
    async def _execute_stage(self, pipeline: PipelineInfo, stage: StageInfo) -> bool:
        """执行单个阶段"""
        log(f"Executing stage: {stage.id}")
        
        # 同步仓库
        self.repo_sync.sync()
        
        # 获取阶段对应的 Beads 任务
        ready_tasks = self.repo_sync.get_ready_tasks(pipeline.pipeline_id)
        stage_task = next(
            (t for t in ready_tasks if f'stage:{stage.id}' in t.get('labels', [])),
            None
        )
        
        if not stage_task:
            log(f"No ready task for stage {stage.id}, checking if already completed...")
            # 可能任务已完成，检查状态
            return True
        
        stage.task_id = stage_task['id']
        stage.status = StageStatus.RUNNING
        stage.started_at = time.time()
        
        # 记录阶段开始
        self.recorder.log_stage_event(
            issue_number=pipeline.issue_number,
            event_type="started",
            data={
                "stage": stage.id,
                "time": datetime.now().isoformat(),
                "task_id": stage.task_id,
                "run_id": "",
                "run_url": ""
            }
        )
        
        # 触发 Worker（传递分支信息）
        run_id = self.worker.trigger_worker(stage.task_id, stage.id, pipeline.branch)
        if not run_id:
            stage.status = StageStatus.FAILED
            stage.error = "Failed to trigger worker"
            return False
        
        stage.run_id = run_id
        
        # 更新记录中的 run_id
        self.recorder.log_stage_event(
            issue_number=pipeline.issue_number,
            event_type="worker_triggered",
            data={
                "stage": stage.id,
                "run_id": run_id,
                "run_url": f"https://github.com/{self.recorder.repo}/actions/runs/{run_id}"
            }
        )
        
        # 等待完成
        success = await self._wait_for_completion(stage, run_id)
        
        stage.completed_at = time.time()
        duration = stage.completed_at - stage.started_at
        
        if success:
            stage.status = StageStatus.COMPLETED
            self.recorder.log_stage_event(
                issue_number=pipeline.issue_number,
                event_type="completed",
                data={
                    "stage": stage.id,
                    "time": datetime.now().isoformat(),
                    "duration": f"{int(duration // 60)}m {int(duration % 60)}s",
                    "output": stage.output or "N/A"
                }
            )
        else:
            stage.status = StageStatus.FAILED
            self.recorder.log_stage_event(
                issue_number=pipeline.issue_number,
                event_type="failed",
                data={
                    "stage": stage.id,
                    "time": datetime.now().isoformat(),
                    "error": stage.error or "Unknown error",
                    "retry_count": stage.retry_count
                }
            )
        
        return success
    
    async def _wait_for_completion(self, stage: StageInfo, run_id: int) -> bool:
        """等待 workflow 完成"""
        start_time = time.time()
        
        while True:
            # 检查超时
            if time.time() - start_time > self.stage_timeout:
                stage.error = f"Stage timeout after {self.stage_timeout}s"
                self.worker.cancel_run(run_id)
                return False
            
            # 检查状态
            status = self.worker.get_run_status(run_id)
            
            if status == 'running':
                await asyncio.sleep(self.poll_interval)
                continue
            elif status == 'success':
                return True
            elif status == 'failure':
                stage.error = "Worker failed"
                return False
            elif status == 'cancelled':
                stage.error = "Worker was cancelled"
                return False
            else:
                stage.error = f"Unknown status: {status}"
                return False
    
    async def _handle_stage_failure(self, pipeline: PipelineInfo, stage: StageInfo) -> bool:
        """处理阶段失败"""
        stage.retry_count += 1
        
        if stage.retry_count < self.max_retries:
            log(f"Retrying stage {stage.id} ({stage.retry_count}/{self.max_retries})")
            
            # 重置状态
            stage.status = StageStatus.PENDING
            stage.error = None
            
            # 重新执行
            return await self._execute_stage(pipeline, stage)
        
        log(f"Stage {stage.id} failed after {self.max_retries} retries")
        return False


# 全局单例
_scheduler: Optional[PipelineScheduler] = None


def get_scheduler() -> Optional[PipelineScheduler]:
    """获取调度器实例"""
    return _scheduler


def init_scheduler(
    repo_path: str,
    github_token: str,
    repo_owner: str,
    repo_name: str
) -> PipelineScheduler:
    """初始化调度器"""
    global _scheduler
    _scheduler = PipelineScheduler(
        repo_path=repo_path,
        github_token=github_token,
        repo_owner=repo_owner,
        repo_name=repo_name
    )
    return _scheduler
