"""
Account Manager - 多 GitHub 账号管理

管理多个 GitHub 用户 PAT，支持：
- 轮换选择账号
- 检测额度耗尽自动切换
- 账号健康状态监控
"""

import os
import time
from dataclasses import dataclass, field
from typing import List, Optional, Tuple
from urllib.request import Request, urlopen
from urllib.error import HTTPError, URLError
import json


@dataclass
class GitHubAccount:
    """GitHub 账号信息"""
    username: str
    pat: str
    is_active: bool = True
    failure_count: int = 0
    last_used: float = 0
    last_failure_reason: Optional[str] = None
    
    def to_dict(self) -> dict:
        """转换为字典（隐藏 PAT）"""
        return {
            "username": self.username,
            "pat": f"{self.pat[:8]}...{self.pat[-4:]}" if len(self.pat) > 12 else "***",
            "is_active": self.is_active,
            "failure_count": self.failure_count,
            "last_used": self.last_used,
            "last_failure_reason": self.last_failure_reason
        }


class AccountManager:
    """多账号管理器"""
    
    # 连续失败多少次后禁用账号
    MAX_FAILURES = 3
    
    def __init__(self):
        self._accounts: List[GitHubAccount] = []
        self._load_accounts()
    
    def _load_accounts(self):
        """从环境变量加载账号配置"""
        # 格式: username1:pat1,username2:pat2,...
        pats_config = os.environ.get("GITHUB_USER_PATS", "")
        
        if pats_config:
            for item in pats_config.split(","):
                item = item.strip()
                if ":" in item:
                    username, pat = item.split(":", 1)
                    self._accounts.append(GitHubAccount(
                        username=username.strip(),
                        pat=pat.strip()
                    ))
        
        # 兼容旧配置：单个 GITHUB_USER_PAT
        if not self._accounts:
            single_pat = os.environ.get("GITHUB_USER_PAT", "")
            if single_pat:
                # 尝试获取用户名
                username = self._get_username_from_pat(single_pat) or "unknown"
                self._accounts.append(GitHubAccount(
                    username=username,
                    pat=single_pat
                ))
    
    def _get_username_from_pat(self, pat: str) -> Optional[str]:
        """通过 PAT 获取用户名"""
        try:
            req = Request(
                "https://api.github.com/user",
                headers={
                    "Authorization": f"Bearer {pat}",
                    "Accept": "application/vnd.github+json"
                }
            )
            with urlopen(req, timeout=10) as response:
                data = json.loads(response.read().decode())
                return data.get("login")
        except Exception:
            return None
    
    def get_active_account(self) -> Optional[GitHubAccount]:
        """
        获取当前活跃账号
        
        策略：
        1. 选择 is_active=True 且 failure_count 最少的账号
        2. 如果 failure_count 相同，选择 last_used 最早的（轮换）
        """
        active_accounts = [a for a in self._accounts if a.is_active]
        
        if not active_accounts:
            return None
        
        # 按 failure_count 升序，last_used 升序排序
        active_accounts.sort(key=lambda a: (a.failure_count, a.last_used))
        
        return active_accounts[0]
    
    def get_account_pat(self) -> Optional[Tuple[str, str]]:
        """获取当前活跃账号的 (username, pat)"""
        account = self.get_active_account()
        if account:
            account.last_used = time.time()
            return (account.username, account.pat)
        return None
    
    def report_success(self, username: str):
        """报告账号使用成功，重置失败计数"""
        for account in self._accounts:
            if account.username == username:
                account.failure_count = 0
                account.last_failure_reason = None
                break
    
    def report_failure(self, username: str, reason: str = "unknown") -> bool:
        """
        报告账号使用失败
        
        返回：True 如果账号被禁用
        """
        for account in self._accounts:
            if account.username == username:
                account.failure_count += 1
                account.last_failure_reason = reason
                
                if account.failure_count >= self.MAX_FAILURES:
                    account.is_active = False
                    return True
                
                break
        
        return False
    
    def check_quota_error(self, error_message: str) -> bool:
        """检查是否是额度耗尽错误"""
        quota_keywords = [
            "rate limit",
            "quota",
            "exceeded",
            "too many requests",
            "429",
            "secondary rate limit"
        ]
        error_lower = error_message.lower()
        return any(keyword in error_lower for keyword in quota_keywords)
    
    def check_copilot_quota_exhausted(self, comment_body: str) -> bool:
        """
        检查评论是否表明 Copilot 额度耗尽
        
        示例消息：
        "Copilot stopped work on behalf of XXX due to an error...
        Your session could not start because you've used up the 300 premium requests allowance..."
        """
        copilot_quota_patterns = [
            "used up the 300 premium requests",
            "premium requests allowance",
            "you've used up the",
            "copilot stopped work",
            "session could not start",
            "allowance included in your copilot subscription"
        ]
        body_lower = comment_body.lower()
        return any(pattern in body_lower for pattern in copilot_quota_patterns)
    
    def disable_account_for_quota(self, username: str) -> bool:
        """
        因 Copilot 额度耗尽禁用账号
        
        返回: True 如果成功禁用
        """
        for account in self._accounts:
            if account.username.lower() == username.lower():
                account.is_active = False
                account.failure_count = self.MAX_FAILURES  # 直接设为最大
                account.last_failure_reason = "copilot_premium_quota_exhausted"
                log_msg = f"Account {username} disabled: Copilot premium quota exhausted"
                print(f"[account] {log_msg}", flush=True)
                return True
        return False
    
    def has_available_accounts(self) -> bool:
        """检查是否还有可用账号"""
        return any(a.is_active for a in self._accounts)
    
    def get_all_accounts_status(self) -> List[dict]:
        """获取所有账号状态（调试用）"""
        return [a.to_dict() for a in self._accounts]
    
    def reactivate_all(self):
        """重新激活所有账号（手动恢复）"""
        for account in self._accounts:
            account.is_active = True
            account.failure_count = 0
            account.last_failure_reason = None
    
    def get_stats(self) -> dict:
        """获取统计信息"""
        return {
            "total_accounts": len(self._accounts),
            "active_accounts": sum(1 for a in self._accounts if a.is_active),
            "accounts": self.get_all_accounts_status()
        }


# 全局单例
_manager: Optional[AccountManager] = None


def get_account_manager() -> AccountManager:
    """获取全局账号管理器实例"""
    global _manager
    if _manager is None:
        _manager = AccountManager()
    return _manager
