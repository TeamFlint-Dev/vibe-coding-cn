#!/usr/bin/env python3
"""
编译集成模块 - 封装 verse-cli 的调用

通过 Node.js 脚本与 UEFN Workflow Server 通信，执行编译操作。
"""

import json
import os
import re
import subprocess
from pathlib import Path
from typing import Optional


class VerseCompiler:
    """Verse 编译器封装"""

    def __init__(self, config: dict):
        self.config = config
        self.compile_config = config.get("compile", {})
        
        # 演示模式检测
        self.demo_mode = config.get("agent", {}).get("provider") == "demo"
        self.skip_in_demo = self.compile_config.get("skip_in_demo", True)
        
        # verse-cli 路径
        cli_path = self.compile_config.get("verse_cli_path", "../verse-cli/verse-build.js")
        self.verse_cli = Path(__file__).parent.parent.parent / "verse-cli" / "verse-build.js"
        
        if not self.verse_cli.exists():
            # 尝试相对路径
            self.verse_cli = Path(__file__).parent.parent / cli_path
        
        self.max_attempts = self.compile_config.get("max_attempts", 3)

    def compile(self, push: bool = False) -> dict:
        """
        执行编译
        
        Args:
            push: 编译成功后是否推送代码
            
        Returns:
            dict: {
                "success": bool,
                "error_count": int,
                "warning_count": int,
                "errors": list,
                "warnings": list,
                "log": str,
            }
        """
        # 演示模式直接返回成功
        if self.demo_mode and self.skip_in_demo:
            print("🎭 [演示模式] 跳过编译验证")
            return {
                "success": True,
                "error_count": 0,
                "warning_count": 0,
                "errors": [],
                "warnings": [],
                "log": "[Demo Mode] Compile skipped",
            }
        
        if not self.verse_cli.exists():
            return {
                "success": False,
                "error_count": 1,
                "warning_count": 0,
                "errors": [{
                    "error_code": "CLI-NOT-FOUND",
                    "message": f"verse-cli not found at {self.verse_cli}",
                    "file": "",
                    "line": 0,
                }],
                "warnings": [],
                "log": f"Error: verse-cli not found at {self.verse_cli}",
            }
        
        cmd = ["node", str(self.verse_cli)]
        if push:
            cmd.append("--push")
        
        try:
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=120,
                cwd=self.verse_cli.parent,
            )
            
            log = result.stdout + "\n" + result.stderr
            
            # 解析结果
            if result.returncode == 0:
                return {
                    "success": True,
                    "error_count": 0,
                    "warning_count": self._count_warnings(log),
                    "errors": [],
                    "warnings": self._parse_warnings(log),
                    "log": log,
                }
            elif result.returncode == 1:
                # 编译有错误
                errors = self._parse_errors(log)
                return {
                    "success": False,
                    "error_count": len(errors),
                    "warning_count": self._count_warnings(log),
                    "errors": errors,
                    "warnings": self._parse_warnings(log),
                    "log": log,
                }
            elif result.returncode == 2:
                # 连接失败
                return {
                    "success": False,
                    "error_count": 1,
                    "warning_count": 0,
                    "errors": [{
                        "error_code": "CONNECTION-FAILED",
                        "message": "Failed to connect to UEFN Workflow Server. Is UEFN running?",
                        "file": "",
                        "line": 0,
                    }],
                    "warnings": [],
                    "log": log,
                }
            else:
                return {
                    "success": False,
                    "error_count": 1,
                    "warning_count": 0,
                    "errors": [{
                        "error_code": f"UNKNOWN-{result.returncode}",
                        "message": f"Unknown error (exit code {result.returncode})",
                        "file": "",
                        "line": 0,
                    }],
                    "warnings": [],
                    "log": log,
                }
                
        except subprocess.TimeoutExpired:
            return {
                "success": False,
                "error_count": 1,
                "warning_count": 0,
                "errors": [{
                    "error_code": "TIMEOUT",
                    "message": "Compile timeout (120s)",
                    "file": "",
                    "line": 0,
                }],
                "warnings": [],
                "log": "Compile timeout after 120 seconds",
            }
        except Exception as e:
            return {
                "success": False,
                "error_count": 1,
                "warning_count": 0,
                "errors": [{
                    "error_code": "EXCEPTION",
                    "message": str(e),
                    "file": "",
                    "line": 0,
                }],
                "warnings": [],
                "log": f"Exception: {e}",
            }

    def _parse_errors(self, log: str) -> list:
        """解析编译错误"""
        errors = []
        
        # 匹配 Verse 编译错误格式
        # 例: file.verse(42): error V1234: Type mismatch
        error_pattern = re.compile(
            r'([^(]+)\((\d+)\):\s*error\s+(\w+):\s*(.+)',
            re.IGNORECASE
        )
        
        for match in error_pattern.finditer(log):
            errors.append({
                "error_code": match.group(3),
                "message": match.group(4).strip(),
                "file": match.group(1).strip(),
                "line": int(match.group(2)),
                "severity": "critical",
                "suspected_root_cause": "",
                "is_api_related": False,
                "is_requirement_related": False,
            })
        
        # 如果没有匹配到标准格式，尝试提取 [ERROR] 行
        if not errors:
            simple_pattern = re.compile(r'\[ERROR\]\s*(.+)', re.IGNORECASE)
            for match in simple_pattern.finditer(log):
                errors.append({
                    "error_code": "COMPILE-ERR",
                    "message": match.group(1).strip(),
                    "file": "",
                    "line": 0,
                    "severity": "critical",
                    "suspected_root_cause": "",
                    "is_api_related": False,
                    "is_requirement_related": False,
                })
        
        return errors

    def _parse_warnings(self, log: str) -> list:
        """解析编译警告"""
        warnings = []
        
        # 匹配警告格式
        warning_pattern = re.compile(
            r'([^(]+)\((\d+)\):\s*warning\s+(\w+):\s*(.+)',
            re.IGNORECASE
        )
        
        for match in warning_pattern.finditer(log):
            warnings.append({
                "warning_code": match.group(3),
                "message": match.group(4).strip(),
                "file": match.group(1).strip(),
                "line": int(match.group(2)),
            })
        
        return warnings

    def _count_warnings(self, log: str) -> int:
        """统计警告数量"""
        return len(re.findall(r'warning\s+\w+:', log, re.IGNORECASE))

    def verify_connection(self) -> bool:
        """验证与 UEFN 的连接"""
        if not self.verse_cli.exists():
            return False
        
        # 尝试简单的连接测试
        try:
            result = subprocess.run(
                ["node", str(self.verse_cli), "--help"],
                capture_output=True,
                text=True,
                timeout=10,
            )
            return result.returncode == 0
        except Exception:
            return False
