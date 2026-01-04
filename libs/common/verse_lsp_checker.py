"""
Verse LSP Checker
提供与 verse-lsp 的 LSP 协议通信，用于语法检查

Usage:
    from libs.common.verse_lsp_checker import VerseChecker
    
    checker = VerseChecker()
    result = await checker.check_code(code_string, filename="test.verse")
    
    if result.is_valid:
        print("代码有效")
    else:
        for error in result.errors:
            print(f"错误 [{error.line}:{error.column}]: {error.message}")
"""

import os
import json
import asyncio
import platform
from pathlib import Path
from typing import List, Optional, Dict, Any
from dataclasses import dataclass, field
from enum import Enum


class DiagnosticSeverity(Enum):
    """诊断严重程度"""
    ERROR = 1
    WARNING = 2
    INFORMATION = 3
    HINT = 4


@dataclass
class Diagnostic:
    """诊断信息（错误/警告）"""
    line: int
    column: int
    message: str
    severity: DiagnosticSeverity
    code: Optional[str] = None
    source: str = "verse-lsp"
    end_line: Optional[int] = None
    end_column: Optional[int] = None
    
    @classmethod
    def from_lsp(cls, lsp_diagnostic: Dict[str, Any]) -> 'Diagnostic':
        """从 LSP 诊断数据创建"""
        range_data = lsp_diagnostic.get('range', {})
        start = range_data.get('start', {})
        end = range_data.get('end', {})
        
        severity_map = {
            1: DiagnosticSeverity.ERROR,
            2: DiagnosticSeverity.WARNING,
            3: DiagnosticSeverity.INFORMATION,
            4: DiagnosticSeverity.HINT,
        }
        
        severity = severity_map.get(
            lsp_diagnostic.get('severity', 1),
            DiagnosticSeverity.ERROR
        )
        
        return cls(
            line=start.get('line', 0) + 1,  # LSP 从 0 开始，转换为从 1 开始
            column=start.get('character', 0) + 1,
            message=lsp_diagnostic.get('message', ''),
            severity=severity,
            code=lsp_diagnostic.get('code'),
            source=lsp_diagnostic.get('source', 'verse-lsp'),
            end_line=end.get('line', start.get('line', 0)) + 1,
            end_column=end.get('character', start.get('character', 0)) + 1,
        )


@dataclass
class CheckResult:
    """检查结果"""
    is_valid: bool
    diagnostics: List[Diagnostic] = field(default_factory=list)
    
    @property
    def errors(self) -> List[Diagnostic]:
        """获取所有错误"""
        return [d for d in self.diagnostics if d.severity == DiagnosticSeverity.ERROR]
    
    @property
    def warnings(self) -> List[Diagnostic]:
        """获取所有警告"""
        return [d for d in self.diagnostics if d.severity == DiagnosticSeverity.WARNING]
    
    @property
    def infos(self) -> List[Diagnostic]:
        """获取所有信息"""
        return [d for d in self.diagnostics if d.severity == DiagnosticSeverity.INFORMATION]
    
    def to_dict(self) -> Dict[str, Any]:
        """转换为字典"""
        return {
            'is_valid': self.is_valid,
            'diagnostics': [
                {
                    'line': d.line,
                    'column': d.column,
                    'message': d.message,
                    'severity': d.severity.name,
                    'code': d.code,
                    'source': d.source,
                }
                for d in self.diagnostics
            ],
            'error_count': len(self.errors),
            'warning_count': len(self.warnings),
        }


class VerseChecker:
    """Verse 代码检查器"""
    
    def __init__(self, lsp_path: Optional[str] = None, digest_dir: Optional[str] = None):
        """
        初始化检查器
        
        Args:
            lsp_path: LSP 二进制路径，如果为 None 则自动检测
            digest_dir: Digest 文件目录，如果为 None 则使用默认位置
        """
        self.lsp_path = lsp_path or self._detect_lsp_path()
        self.digest_dir = digest_dir or self._get_default_digest_dir()
        self.process: Optional[asyncio.subprocess.Process] = None
        self.message_id = 0
        self._initialized = False
        
    def _detect_lsp_path(self) -> str:
        """自动检测 LSP 二进制路径"""
        # 获取仓库根目录
        script_dir = Path(__file__).parent.parent.parent
        sdk_dir = script_dir / '.verse-sdk' / 'bin'
        
        # 根据操作系统选择二进制
        system = platform.system()
        if system == 'Linux':
            lsp_path = sdk_dir / 'Linux' / 'verse-lsp'
        elif system == 'Darwin':
            lsp_path = sdk_dir / 'Mac' / 'verse-lsp'
        elif system == 'Windows':
            lsp_path = sdk_dir / 'Win64' / 'verse-lsp.exe'
        else:
            raise RuntimeError(f"不支持的操作系统: {system}")
        
        if not lsp_path.exists():
            raise FileNotFoundError(
                f"未找到 verse-lsp 二进制: {lsp_path}\n"
                f"请先运行 scripts/verse-lsp/setup-verse-env.sh"
            )
        
        return str(lsp_path)
    
    def _get_default_digest_dir(self) -> str:
        """获取默认 digest 目录"""
        script_dir = Path(__file__).parent.parent.parent
        digest_dir = script_dir / '.verse-sdk' / 'digests'
        return str(digest_dir)
    
    async def start(self):
        """启动 LSP 服务"""
        if self.process is not None:
            return
        
        # 启动 LSP 进程
        self.process = await asyncio.create_subprocess_exec(
            self.lsp_path,
            stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )
        
        # 初始化 LSP
        await self._initialize()
    
    async def stop(self):
        """停止 LSP 服务"""
        if self.process is None:
            return
        
        # 发送 shutdown 请求
        try:
            await self._send_request('shutdown', {})
            await self._send_notification('exit', {})
        except:
            pass
        
        # 等待进程结束
        try:
            await asyncio.wait_for(self.process.wait(), timeout=5.0)
        except asyncio.TimeoutError:
            self.process.kill()
            await self.process.wait()
        
        self.process = None
        self._initialized = False
    
    async def _initialize(self):
        """初始化 LSP"""
        if self._initialized:
            return
        
        # 发送 initialize 请求
        init_params = {
            'processId': os.getpid(),
            'rootUri': f"file://{self.digest_dir}",
            'capabilities': {
                'textDocument': {
                    'publishDiagnostics': {}
                }
            },
        }
        
        response = await self._send_request('initialize', init_params)
        
        # 发送 initialized 通知
        await self._send_notification('initialized', {})
        
        self._initialized = True
    
    async def _send_request(self, method: str, params: Dict[str, Any]) -> Dict[str, Any]:
        """发送 LSP 请求并等待响应"""
        if self.process is None or self.process.stdin is None:
            raise RuntimeError("LSP 进程未启动")
        
        self.message_id += 1
        request = {
            'jsonrpc': '2.0',
            'id': self.message_id,
            'method': method,
            'params': params,
        }
        
        # 发送请求
        content = json.dumps(request)
        message = f"Content-Length: {len(content)}\r\n\r\n{content}"
        self.process.stdin.write(message.encode('utf-8'))
        await self.process.stdin.drain()
        
        # 读取响应
        response = await self._read_message()
        
        if 'error' in response:
            raise RuntimeError(f"LSP 错误: {response['error']}")
        
        return response.get('result', {})
    
    async def _send_notification(self, method: str, params: Dict[str, Any]):
        """发送 LSP 通知（无需响应）"""
        if self.process is None or self.process.stdin is None:
            raise RuntimeError("LSP 进程未启动")
        
        notification = {
            'jsonrpc': '2.0',
            'method': method,
            'params': params,
        }
        
        content = json.dumps(notification)
        message = f"Content-Length: {len(content)}\r\n\r\n{content}"
        self.process.stdin.write(message.encode('utf-8'))
        await self.process.stdin.drain()
    
    async def _read_message(self) -> Dict[str, Any]:
        """读取 LSP 消息"""
        if self.process is None or self.process.stdout is None:
            raise RuntimeError("LSP 进程未启动")
        
        # 读取 Content-Length header
        headers = {}
        while True:
            line = await self.process.stdout.readline()
            if not line or line == b'\r\n':
                break
            
            header = line.decode('utf-8').strip()
            if ':' in header:
                key, value = header.split(':', 1)
                headers[key.strip()] = value.strip()
        
        # 读取内容
        content_length = int(headers.get('Content-Length', 0))
        if content_length == 0:
            return {}
        
        content = await self.process.stdout.readexactly(content_length)
        return json.loads(content.decode('utf-8'))
    
    async def check_code(self, code: str, filename: str = "temp.verse") -> CheckResult:
        """
        检查 Verse 代码
        
        Args:
            code: Verse 代码字符串
            filename: 文件名（用于错误报告）
        
        Returns:
            CheckResult: 检查结果
        """
        # 确保 LSP 已启动
        if self.process is None:
            await self.start()
        
        # 构造文件 URI
        file_uri = f"file:///temp/{filename}"
        
        # 发送 textDocument/didOpen 通知
        await self._send_notification('textDocument/didOpen', {
            'textDocument': {
                'uri': file_uri,
                'languageId': 'verse',
                'version': 1,
                'text': code,
            }
        })
        
        # 等待一小段时间让 LSP 处理
        await asyncio.sleep(0.5)
        
        # 读取诊断信息（通过 publishDiagnostics 通知）
        diagnostics = []
        try:
            # 尝试读取可能的诊断通知
            while True:
                try:
                    message = await asyncio.wait_for(
                        self._read_message(),
                        timeout=0.1
                    )
                    
                    if message.get('method') == 'textDocument/publishDiagnostics':
                        params = message.get('params', {})
                        for diag in params.get('diagnostics', []):
                            diagnostics.append(Diagnostic.from_lsp(diag))
                except asyncio.TimeoutError:
                    break
        except:
            pass
        
        # 发送 textDocument/didClose 通知
        await self._send_notification('textDocument/didClose', {
            'textDocument': {
                'uri': file_uri,
            }
        })
        
        # 判断是否有效（无错误）
        is_valid = not any(d.severity == DiagnosticSeverity.ERROR for d in diagnostics)
        
        return CheckResult(is_valid=is_valid, diagnostics=diagnostics)
    
    async def check_file(self, file_path: str) -> CheckResult:
        """
        检查 Verse 文件
        
        Args:
            file_path: 文件路径
        
        Returns:
            CheckResult: 检查结果
        """
        with open(file_path, 'r', encoding='utf-8') as f:
            code = f.read()
        
        filename = Path(file_path).name
        return await self.check_code(code, filename)
    
    async def __aenter__(self):
        """异步上下文管理器入口"""
        await self.start()
        return self
    
    async def __aexit__(self, exc_type, exc_val, exc_tb):
        """异步上下文管理器出口"""
        await self.stop()


# 便捷函数
async def check_verse_code(code: str, filename: str = "temp.verse") -> CheckResult:
    """
    检查 Verse 代码（便捷函数）
    
    Args:
        code: Verse 代码字符串
        filename: 文件名
    
    Returns:
        CheckResult: 检查结果
    """
    async with VerseChecker() as checker:
        return await checker.check_code(code, filename)


async def check_verse_file(file_path: str) -> CheckResult:
    """
    检查 Verse 文件（便捷函数）
    
    Args:
        file_path: 文件路径
    
    Returns:
        CheckResult: 检查结果
    """
    async with VerseChecker() as checker:
        return await checker.check_file(file_path)
