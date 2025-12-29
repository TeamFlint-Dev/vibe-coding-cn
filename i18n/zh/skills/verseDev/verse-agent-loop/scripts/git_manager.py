#!/usr/bin/env python3
"""
Git 管理模块 - 封装 Git 操作

提供分支管理、投票机制（git notes）、合并等功能。
"""

import subprocess
from pathlib import Path
from typing import Optional


class GitManager:
    """Git 操作管理器"""

    def __init__(self, config: dict):
        self.config = config
        self.git_config = config.get("git", {})
        self.auto_commit = self.git_config.get("auto_commit", True)
        self.branch_prefix = self.git_config.get("branch_prefix", "agent-loop")
        self.main_branch = self.git_config.get("main_branch", "main")
        
        # 演示模式检测
        self.demo_mode = config.get("agent", {}).get("provider") == "demo"
        
        # 获取仓库根目录
        self.repo_root = self._find_repo_root()

    def _find_repo_root(self) -> Optional[Path]:
        """查找 Git 仓库根目录"""
        try:
            result = subprocess.run(
                ["git", "rev-parse", "--show-toplevel"],
                capture_output=True,
                text=True,
                timeout=10,
            )
            if result.returncode == 0:
                return Path(result.stdout.strip())
        except Exception:
            pass
        return None

    def _run_git(self, *args, check: bool = True) -> subprocess.CompletedProcess:
        """执行 Git 命令"""
        cmd = ["git"] + list(args)
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=60,
            cwd=self.repo_root,
        )
        if check and result.returncode != 0:
            raise RuntimeError(f"Git command failed: {' '.join(cmd)}\n{result.stderr}")
        return result

    def get_current_branch(self) -> str:
        """获取当前分支名"""
        result = self._run_git("rev-parse", "--abbrev-ref", "HEAD")
        return result.stdout.strip()

    def create_branch(self, branch_name: str) -> bool:
        """创建并切换到新分支"""
        if self.demo_mode:
            print(f"🎭 [演示模式] 模拟创建分支: {branch_name}")
            return True
        
        try:
            # 确保从主分支开始
            self._run_git("checkout", self.main_branch)
            self._run_git("pull", "--rebase", check=False)
            
            # 创建新分支
            self._run_git("checkout", "-b", branch_name)
            return True
        except Exception as e:
            print(f"⚠️ 创建分支失败: {e}")
            return False

    def switch_branch(self, branch_name: str) -> bool:
        """切换到指定分支"""
        try:
            self._run_git("checkout", branch_name)
            return True
        except Exception:
            return False

    def commit_changes(self, message: str) -> bool:
        """提交所有更改"""
        if not self.auto_commit:
            return True
        
        try:
            # 添加所有更改
            self._run_git("add", "-A")
            
            # 检查是否有更改
            result = self._run_git("status", "--porcelain")
            if not result.stdout.strip():
                return True  # 没有更改
            
            # 提交
            self._run_git("commit", "-m", message)
            return True
        except Exception as e:
            print(f"⚠️ 提交失败: {e}")
            return False

    def merge_to_main(self, branch_name: str) -> bool:
        """将分支合并到主分支"""
        if self.demo_mode:
            print(f"🎭 [演示模式] 模拟合并分支: {branch_name} → {self.main_branch}")
            return True
        
        try:
            # 切换到主分支
            self._run_git("checkout", self.main_branch)
            
            # 合并
            self._run_git("merge", branch_name, "--no-ff", "-m", f"Merge {branch_name}")
            
            # 删除已合并的分支
            self._run_git("branch", "-d", branch_name)
            
            return True
        except Exception as e:
            print(f"⚠️ 合并失败: {e}")
            return False

    def add_vote_note(self, reviewer: str, verdict: str, reason: str = "") -> bool:
        """
        添加投票注释（使用 git notes）
        
        Args:
            reviewer: 评审者标识 (utility/framework/quality)
            verdict: 投票结果 (APPROVE/REJECT)
            reason: 否决原因（仅当 verdict=REJECT 时）
        """
        try:
            # 获取当前 HEAD
            result = self._run_git("rev-parse", "HEAD")
            commit_sha = result.stdout.strip()
            
            # 构建注释内容
            if verdict.upper() == "APPROVE":
                note_content = f"APPROVE:{reviewer}"
            else:
                note_content = f"REJECT:{reviewer}:{reason}"
            
            # 添加注释（使用特定的命名空间）
            self._run_git(
                "notes", "--ref", "agent-loop-votes",
                "append", "-m", note_content, commit_sha
            )
            
            return True
        except Exception as e:
            print(f"⚠️ 添加投票注释失败: {e}")
            return False

    def get_vote_notes(self, commit_sha: Optional[str] = None) -> list:
        """获取投票注释"""
        try:
            if commit_sha is None:
                result = self._run_git("rev-parse", "HEAD")
                commit_sha = result.stdout.strip()
            
            result = self._run_git(
                "notes", "--ref", "agent-loop-votes",
                "show", commit_sha,
                check=False
            )
            
            if result.returncode != 0:
                return []
            
            votes = []
            for line in result.stdout.strip().split("\n"):
                if line.startswith("APPROVE:"):
                    reviewer = line.split(":", 1)[1]
                    votes.append({"reviewer": reviewer, "verdict": "approve", "reason": ""})
                elif line.startswith("REJECT:"):
                    parts = line.split(":", 2)
                    reviewer = parts[1] if len(parts) > 1 else ""
                    reason = parts[2] if len(parts) > 2 else ""
                    votes.append({"reviewer": reviewer, "verdict": "reject", "reason": reason})
            
            return votes
        except Exception:
            return []

    def count_votes(self, commit_sha: Optional[str] = None) -> dict:
        """统计投票结果"""
        votes = self.get_vote_notes(commit_sha)
        
        approve_count = sum(1 for v in votes if v["verdict"] == "approve")
        reject_count = sum(1 for v in votes if v["verdict"] == "reject")
        
        return {
            "approve": approve_count,
            "reject": reject_count,
            "total": len(votes),
            "passed": approve_count >= 2,  # 2/3 多数通过
            "votes": votes,
        }

    def delete_branch(self, branch_name: str, force: bool = False) -> bool:
        """删除分支"""
        try:
            flag = "-D" if force else "-d"
            self._run_git("branch", flag, branch_name)
            return True
        except Exception:
            return False

    def get_diff(self, base_branch: Optional[str] = None) -> str:
        """获取与基准分支的差异"""
        try:
            base = base_branch or self.main_branch
            result = self._run_git("diff", base)
            return result.stdout
        except Exception:
            return ""

    def get_changed_files(self, base_branch: Optional[str] = None) -> list:
        """获取变更的文件列表"""
        try:
            base = base_branch or self.main_branch
            result = self._run_git("diff", "--name-only", base)
            return [f for f in result.stdout.strip().split("\n") if f]
        except Exception:
            return []

    def stash_changes(self) -> bool:
        """暂存当前更改"""
        try:
            self._run_git("stash")
            return True
        except Exception:
            return False

    def pop_stash(self) -> bool:
        """恢复暂存的更改"""
        try:
            self._run_git("stash", "pop")
            return True
        except Exception:
            return False

    def reset_hard(self, commit: str = "HEAD") -> bool:
        """硬重置到指定提交"""
        try:
            self._run_git("reset", "--hard", commit)
            return True
        except Exception:
            return False

    def get_log(self, count: int = 10) -> list:
        """获取最近的提交日志"""
        try:
            result = self._run_git(
                "log", f"-{count}",
                "--pretty=format:%H|%s|%an|%ad",
                "--date=short"
            )
            
            logs = []
            for line in result.stdout.strip().split("\n"):
                if line:
                    parts = line.split("|")
                    if len(parts) >= 4:
                        logs.append({
                            "sha": parts[0],
                            "message": parts[1],
                            "author": parts[2],
                            "date": parts[3],
                        })
            
            return logs
        except Exception:
            return []
