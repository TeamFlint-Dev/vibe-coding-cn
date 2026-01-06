#!/usr/bin/env python3
"""
Verse 代码检查 CLI 工具
检查单个或多个 .verse 文件的语法错误

Usage:
    python check-verse.py file.verse
    python check-verse.py file1.verse file2.verse
    python check-verse.py --dir src/
    python check-verse.py --json file.verse
"""

import sys
import asyncio
import argparse
import json
from pathlib import Path
from typing import List

# 添加 libs 到路径
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from libs.common.verse_lsp_checker import (
    VerseChecker, 
    CheckResult, 
    DiagnosticSeverity
)


class Colors:
    """终端颜色"""
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    MAGENTA = '\033[0;35m'
    CYAN = '\033[0;36m'
    BOLD = '\033[1m'
    NC = '\033[0m'  # No Color


def print_colored(text: str, color: str = Colors.NC):
    """打印带颜色的文本"""
    print(f"{color}{text}{Colors.NC}")


def format_diagnostic(diagnostic, file_path: str = "") -> str:
    """格式化诊断信息"""
    severity_colors = {
        DiagnosticSeverity.ERROR: Colors.RED,
        DiagnosticSeverity.WARNING: Colors.YELLOW,
        DiagnosticSeverity.INFORMATION: Colors.BLUE,
        DiagnosticSeverity.HINT: Colors.CYAN,
    }
    
    severity_symbols = {
        DiagnosticSeverity.ERROR: '✗',
        DiagnosticSeverity.WARNING: '⚠',
        DiagnosticSeverity.INFORMATION: 'ℹ',
        DiagnosticSeverity.HINT: '💡',
    }
    
    color = severity_colors.get(diagnostic.severity, Colors.NC)
    symbol = severity_symbols.get(diagnostic.severity, '•')
    
    location = f"{file_path}:" if file_path else ""
    location += f"{diagnostic.line}:{diagnostic.column}"
    
    message = diagnostic.message
    if diagnostic.code:
        message = f"[{diagnostic.code}] {message}"
    
    return f"{color}{symbol} {location}: {message}{Colors.NC}"


def print_result(file_path: str, result: CheckResult, verbose: bool = False):
    """打印检查结果"""
    print()
    print_colored(f"{'='*60}", Colors.BOLD)
    print_colored(f"检查文件: {file_path}", Colors.BOLD)
    print_colored(f"{'='*60}", Colors.BOLD)
    
    if result.is_valid:
        print_colored("✓ 代码有效，没有发现错误", Colors.GREEN)
        
        if verbose and result.warnings:
            print_colored(f"\n发现 {len(result.warnings)} 个警告:", Colors.YELLOW)
            for warning in result.warnings:
                print(format_diagnostic(warning, file_path))
    else:
        print_colored(f"✗ 发现 {len(result.errors)} 个错误", Colors.RED)
        
        # 打印错误
        for error in result.errors:
            print(format_diagnostic(error, file_path))
        
        # 打印警告
        if result.warnings:
            print_colored(f"\n发现 {len(result.warnings)} 个警告:", Colors.YELLOW)
            for warning in result.warnings:
                print(format_diagnostic(warning, file_path))
    
    # 打印信息
    if verbose and result.infos:
        print_colored(f"\n信息 ({len(result.infos)}):", Colors.BLUE)
        for info in result.infos:
            print(format_diagnostic(info, file_path))
    
    print()


def print_json_result(file_path: str, result: CheckResult):
    """以 JSON 格式打印结果"""
    output = {
        'file': file_path,
        **result.to_dict()
    }
    print(json.dumps(output, indent=2, ensure_ascii=False))


def find_verse_files(directory: str) -> List[Path]:
    """查找目录下的所有 .verse 文件"""
    path = Path(directory)
    if not path.exists():
        return []
    
    if path.is_file() and path.suffix == '.verse':
        return [path]
    
    return list(path.rglob('*.verse'))


async def check_files(files: List[str], json_output: bool = False, verbose: bool = False):
    """检查多个文件"""
    # 创建检查器
    async with VerseChecker() as checker:
        total_files = len(files)
        valid_files = 0
        total_errors = 0
        total_warnings = 0
        
        for file_path in files:
            try:
                result = await checker.check_file(file_path)
                
                if json_output:
                    print_json_result(file_path, result)
                else:
                    print_result(file_path, result, verbose)
                
                if result.is_valid:
                    valid_files += 1
                
                total_errors += len(result.errors)
                total_warnings += len(result.warnings)
                
            except FileNotFoundError:
                print_colored(f"✗ 文件未找到: {file_path}", Colors.RED)
            except Exception as e:
                print_colored(f"✗ 检查文件失败 {file_path}: {e}", Colors.RED)
        
        # 打印汇总
        if not json_output and total_files > 1:
            print_colored(f"\n{'='*60}", Colors.BOLD)
            print_colored("检查汇总", Colors.BOLD)
            print_colored(f"{'='*60}", Colors.BOLD)
            print(f"总文件数: {total_files}")
            print_colored(f"有效文件: {valid_files}", Colors.GREEN if valid_files == total_files else Colors.YELLOW)
            print_colored(f"总错误数: {total_errors}", Colors.RED if total_errors > 0 else Colors.GREEN)
            print_colored(f"总警告数: {total_warnings}", Colors.YELLOW if total_warnings > 0 else Colors.GREEN)
            print()
            
            # 返回状态码
            return 0 if total_errors == 0 else 1
        
        return 0 if total_errors == 0 else 1


def main():
    """主函数"""
    parser = argparse.ArgumentParser(
        description='Verse 代码语法检查工具',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  %(prog)s file.verse                    # 检查单个文件
  %(prog)s file1.verse file2.verse       # 检查多个文件
  %(prog)s --dir src/                    # 检查目录下所有 .verse 文件
  %(prog)s --json file.verse             # JSON 格式输出
  %(prog)s --verbose file.verse          # 显示详细信息（包括警告和信息）
        """
    )
    
    parser.add_argument(
        'files',
        nargs='*',
        help='要检查的 .verse 文件'
    )
    
    parser.add_argument(
        '--dir', '-d',
        help='检查目录下的所有 .verse 文件'
    )
    
    parser.add_argument(
        '--json', '-j',
        action='store_true',
        help='以 JSON 格式输出结果'
    )
    
    parser.add_argument(
        '--verbose', '-v',
        action='store_true',
        help='显示详细信息（包括警告和信息）'
    )
    
    args = parser.parse_args()
    
    # 收集要检查的文件
    files_to_check = []
    
    if args.dir:
        # 从目录查找
        verse_files = find_verse_files(args.dir)
        files_to_check.extend([str(f) for f in verse_files])
    
    if args.files:
        # 添加命令行指定的文件
        files_to_check.extend(args.files)
    
    if not files_to_check:
        parser.print_help()
        print_colored("\n错误: 未指定要检查的文件", Colors.RED)
        return 1
    
    # 检查文件
    try:
        exit_code = asyncio.run(check_files(
            files_to_check,
            json_output=args.json,
            verbose=args.verbose
        ))
        return exit_code
    except KeyboardInterrupt:
        print_colored("\n\n检查被用户中断", Colors.YELLOW)
        return 130
    except Exception as e:
        print_colored(f"\n错误: {e}", Colors.RED)
        import traceback
        traceback.print_exc()
        return 1


if __name__ == '__main__':
    sys.exit(main())
