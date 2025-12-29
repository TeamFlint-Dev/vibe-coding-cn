#!/usr/bin/env python3
"""
日志检索工具 - 搜索和过滤历史日志

支持按关键词、任务ID、状态、时间范围检索日志。
"""

import argparse
import json
import re
from datetime import datetime
from pathlib import Path
from typing import Optional

from utils import parse_date_range


def search_logs(
    logs_dir: Path,
    keyword: Optional[str] = None,
    task_id: Optional[str] = None,
    status: Optional[str] = None,
    date_range: Optional[str] = None,
    output_file: Optional[str] = None,
) -> list:
    """
    搜索日志
    
    Args:
        logs_dir: 日志目录
        keyword: 关键词搜索
        task_id: 任务ID精确匹配
        status: 状态过滤 (completed/escalated)
        date_range: 时间范围 (7d/2w/1m)
        output_file: 输出文件路径
        
    Returns:
        匹配的日志条目列表
    """
    results = []
    
    # 确定搜索范围
    search_dirs = []
    
    if task_id:
        # 精确匹配任务ID
        for subdir in ["active", "archive", "escalation"]:
            task_path = logs_dir / subdir / task_id
            if task_path.exists():
                search_dirs.append(task_path)
            # 检查归档目录
            archive_path = logs_dir / "archive"
            if archive_path.exists():
                for month_dir in archive_path.iterdir():
                    task_archive = month_dir / task_id
                    if task_archive.exists():
                        search_dirs.append(task_archive)
    else:
        # 搜索所有目录
        if status == "escalated":
            search_dirs.append(logs_dir / "escalation")
        elif status == "completed":
            search_dirs.append(logs_dir / "active")
            search_dirs.append(logs_dir / "archive")
        else:
            search_dirs.extend([
                logs_dir / "active",
                logs_dir / "archive",
                logs_dir / "escalation",
            ])
    
    # 时间范围过滤
    start_time, end_time = None, None
    if date_range:
        start_time, end_time = parse_date_range(date_range)
    
    # 搜索
    for search_dir in search_dirs:
        if not search_dir.exists():
            continue
        
        for item in search_dir.rglob("*"):
            if not item.is_file():
                continue
            
            # 时间过滤
            if start_time and end_time:
                mtime = datetime.fromtimestamp(item.stat().st_mtime)
                if not (start_time <= mtime <= end_time):
                    continue
            
            # 关键词搜索
            if keyword:
                try:
                    content = item.read_text(encoding="utf-8")
                    if keyword.lower() not in content.lower():
                        continue
                    
                    # 提取匹配的上下文
                    matches = find_keyword_context(content, keyword)
                    if matches:
                        results.append({
                            "file": str(item),
                            "task_id": extract_task_id(item),
                            "matches": matches,
                        })
                except Exception:
                    continue
            else:
                # 无关键词，返回文件信息
                results.append({
                    "file": str(item),
                    "task_id": extract_task_id(item),
                    "size": item.stat().st_size,
                    "modified": datetime.fromtimestamp(item.stat().st_mtime).isoformat(),
                })
    
    # 输出结果
    if output_file:
        with open(output_file, "w", encoding="utf-8") as f:
            json.dump(results, f, ensure_ascii=False, indent=2)
        print(f"结果已保存到: {output_file}")
    
    return results


def find_keyword_context(content: str, keyword: str, context_lines: int = 2) -> list:
    """查找关键词及其上下文"""
    matches = []
    lines = content.split("\n")
    keyword_lower = keyword.lower()
    
    for i, line in enumerate(lines):
        if keyword_lower in line.lower():
            # 获取上下文
            start = max(0, i - context_lines)
            end = min(len(lines), i + context_lines + 1)
            context = lines[start:end]
            
            matches.append({
                "line_number": i + 1,
                "line": line.strip(),
                "context": "\n".join(context),
            })
    
    return matches


def extract_task_id(file_path: Path) -> str:
    """从文件路径提取任务ID"""
    for part in file_path.parts:
        if part.startswith("REQ-"):
            return part
    return ""


def print_results(results: list, verbose: bool = False):
    """打印搜索结果"""
    if not results:
        print("未找到匹配结果")
        return
    
    print(f"\n找到 {len(results)} 个匹配项:\n")
    
    for result in results:
        task_id = result.get("task_id", "N/A")
        file_path = result.get("file", "")
        
        print(f"📄 {task_id}: {file_path}")
        
        if verbose and "matches" in result:
            for match in result["matches"][:3]:  # 只显示前3个匹配
                print(f"   行 {match['line_number']}: {match['line'][:80]}...")
            if len(result["matches"]) > 3:
                print(f"   ... 还有 {len(result['matches']) - 3} 个匹配")
        
        print()


def main():
    """主入口"""
    parser = argparse.ArgumentParser(
        description="Verse Agent Loop 日志检索工具",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
    # 按关键词检索最近7天
    python search_logs.py --keyword "事件方向" --last 7d
    
    # 按任务ID检索
    python search_logs.py --task REQ-20251229-001
    
    # 检索升级的任务
    python search_logs.py --status escalated
    
    # 输出到文件
    python search_logs.py --keyword "编译错误" --output result.json
        """
    )
    
    parser.add_argument("-k", "--keyword", type=str,
                        help="关键词搜索")
    parser.add_argument("-t", "--task", type=str,
                        help="任务ID精确匹配")
    parser.add_argument("-s", "--status", type=str,
                        choices=["completed", "escalated"],
                        help="按状态过滤")
    parser.add_argument("-l", "--last", type=str, default="7d",
                        help="时间范围 (例: 7d, 2w, 1m)")
    parser.add_argument("-o", "--output", type=str,
                        help="输出文件路径")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="显示详细匹配内容")
    
    args = parser.parse_args()
    
    # 确定日志目录
    logs_dir = Path(__file__).parent.parent / "logs"
    
    if not logs_dir.exists():
        print(f"错误: 日志目录不存在: {logs_dir}")
        return
    
    # 执行搜索
    results = search_logs(
        logs_dir=logs_dir,
        keyword=args.keyword,
        task_id=args.task,
        status=args.status,
        date_range=args.last,
        output_file=args.output,
    )
    
    # 打印结果
    if not args.output:
        print_results(results, args.verbose)


if __name__ == "__main__":
    main()
