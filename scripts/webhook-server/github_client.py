"""
GitHub Client - GitHub API 封装

封装所有 GitHub API 调用，支持：
- 发表评论
- 触发 repository_dispatch
- 添加/删除标签
"""

import json
import os
from typing import Optional, Tuple
from urllib.request import Request, urlopen
from urllib.error import HTTPError, URLError

from account_manager import get_account_manager


def log(message: str):
    """简单日志"""
    print(f"[github] {message}", flush=True)


class GitHubClient:
    """GitHub API 客户端"""
    
    def __init__(self):
        self.repo_owner = os.environ.get("REPO_OWNER", "TeamFlint-Dev")
        self.repo_name = os.environ.get("REPO_NAME", "vibe-coding-cn")
        self.dispatch_pat = os.environ.get("GITHUB_PAT", "")
        self.account_manager = get_account_manager()
    
    def _make_request(
        self,
        url: str,
        method: str = "GET",
        data: Optional[dict] = None,
        pat: Optional[str] = None
    ) -> Tuple[bool, str]:
        """
        发起 GitHub API 请求
        
        返回: (success, response_or_error)
        """
        headers = {
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28"
        }
        
        if pat:
            headers["Authorization"] = f"Bearer {pat}"
        
        if data:
            headers["Content-Type"] = "application/json"
        
        try:
            body = json.dumps(data).encode() if data else None
            req = Request(url, data=body, headers=headers, method=method)
            
            with urlopen(req, timeout=30) as response:
                result = response.read().decode()
                return (True, result)
        
        except HTTPError as e:
            error_body = e.read().decode()
            log(f"HTTP Error {e.code}: {error_body}")
            return (False, f"HTTP {e.code}: {error_body}")
        
        except URLError as e:
            log(f"URL Error: {e.reason}")
            return (False, f"URL Error: {e.reason}")
        
        except Exception as e:
            log(f"Request Error: {str(e)}")
            return (False, str(e))
    
    def trigger_dispatch(
        self,
        event_type: str,
        client_payload: dict
    ) -> bool:
        """触发 repository_dispatch"""
        url = f"https://api.github.com/repos/{self.repo_owner}/{self.repo_name}/dispatches"
        
        data = {
            "event_type": event_type,
            "client_payload": client_payload
        }
        
        success, response = self._make_request(
            url,
            method="POST",
            data=data,
            pat=self.dispatch_pat
        )
        
        if success:
            log(f"Dispatch triggered: {event_type}")
        else:
            log(f"Failed to trigger dispatch: {response}")
        
        return success
    
    def post_comment(
        self,
        pr_number: int,
        body: str,
        use_user_account: bool = False
    ) -> Tuple[bool, Optional[str]]:
        """
        发表 PR 评论
        
        参数:
            pr_number: PR 编号
            body: 评论内容
            use_user_account: 是否使用用户账号（用于 @copilot）
        
        返回:
            (success, username_or_error)
        """
        url = f"https://api.github.com/repos/{self.repo_owner}/{self.repo_name}/issues/{pr_number}/comments"
        
        if use_user_account:
            account_info = self.account_manager.get_account_pat()
            if not account_info:
                log("No available user account for posting comment")
                return (False, "No available accounts")
            
            username, pat = account_info
            log(f"Posting comment as user: {username}")
        else:
            # 使用 dispatch PAT（通常是 bot 或组织账号）
            pat = self.dispatch_pat
            username = "bot"
        
        success, response = self._make_request(
            url,
            method="POST",
            data={"body": body},
            pat=pat
        )
        
        if success:
            log(f"Comment posted by {username} on PR #{pr_number}")
            if use_user_account:
                self.account_manager.report_success(username)
            return (True, username)
        else:
            log(f"Failed to post comment: {response}")
            if use_user_account:
                # 检查是否是额度问题
                if self.account_manager.check_quota_error(response):
                    disabled = self.account_manager.report_failure(username, "quota_exceeded")
                    if disabled:
                        log(f"Account {username} disabled due to quota issues")
                        # 尝试使用下一个账号
                        return self.post_comment(pr_number, body, use_user_account=True)
                else:
                    self.account_manager.report_failure(username, response[:100])
            
            return (False, response)
    
    def get_pr_info(self, pr_number: int) -> Optional[dict]:
        """获取 PR 信息"""
        url = f"https://api.github.com/repos/{self.repo_owner}/{self.repo_name}/pulls/{pr_number}"
        
        success, response = self._make_request(url, pat=self.dispatch_pat)
        
        if success:
            return json.loads(response)
        
        return None
    
    def add_label(self, pr_number: int, label: str) -> bool:
        """添加标签"""
        url = f"https://api.github.com/repos/{self.repo_owner}/{self.repo_name}/issues/{pr_number}/labels"
        
        success, _ = self._make_request(
            url,
            method="POST",
            data={"labels": [label]},
            pat=self.dispatch_pat
        )
        
        return success
    
    def remove_label(self, pr_number: int, label: str) -> bool:
        """删除标签"""
        url = f"https://api.github.com/repos/{self.repo_owner}/{self.repo_name}/issues/{pr_number}/labels/{label}"
        
        success, _ = self._make_request(
            url,
            method="DELETE",
            pat=self.dispatch_pat
        )
        
        return success


# 全局单例
_client: Optional[GitHubClient] = None


def get_github_client() -> GitHubClient:
    """获取全局 GitHub 客户端实例"""
    global _client
    if _client is None:
        _client = GitHubClient()
    return _client
