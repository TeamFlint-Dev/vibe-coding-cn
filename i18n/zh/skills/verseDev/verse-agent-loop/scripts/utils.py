#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
工具函数模块 - 通用工具函数

提供日志、配置、状态管理、报告生成等功能。
"""

import json
import logging
import re
import shutil
from datetime import datetime, timedelta
from pathlib import Path
from typing import Optional


def setup_logging(log_file: Path, level: int = logging.INFO) -> logging.Logger:
    """设置日志"""
    logger = logging.getLogger("verse-agent-loop")
    logger.setLevel(level)
    
    # 文件处理器
    file_handler = logging.FileHandler(log_file, encoding="utf-8")
    file_handler.setLevel(level)
    file_formatter = logging.Formatter(
        "%(asctime)s [%(levelname)s] %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S"
    )
    file_handler.setFormatter(file_formatter)
    
    # 控制台处理器
    console_handler = logging.StreamHandler()
    console_handler.setLevel(level)
    console_formatter = logging.Formatter("%(message)s")
    console_handler.setFormatter(console_formatter)
    
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)
    
    return logger


def load_config(config_path: str) -> dict:
    """加载配置文件"""
    config_file = Path(config_path)
    
    # 默认配置
    default_config = {
        "version": "1.0.0",
        "loop": {
            "max_tasks": 5,
            "auto_generate_requirements": False,
            "requirement_queue_threshold": 2,
            "escalation_threshold": 3,
        },
        "compile": {
            "max_attempts": 3,
            "verse_cli_path": "../verse-cli/verse-build.js",
        },
        "review": {
            "weights": {
                "utility": 0.4,
                "framework": 0.4,
                "quality": 0.2,
            },
            "pass_threshold": 7.0,
            "require_no_critical": True,
        },
        "tactician": {
            "calibration_frequency": 1,
            "auto_frequency": 5,
            "skip_if_no_updates": True,
        },
        "agent": {
            "provider": "copilot",
            "model": "gpt-4",
            "timeout": 300,
            "retry_attempts": 2,
        },
        "git": {
            "auto_commit": True,
            "branch_prefix": "agent-loop",
            "main_branch": "main",
        },
        "logs": {
            "active_limit": 20,
            "archive_by": "month",
        },
    }
    
    if config_file.exists():
        with open(config_file, "r", encoding="utf-8") as f:
            user_config = json.load(f)
            # 深度合并
            return deep_merge(default_config, user_config)
    
    return default_config


def deep_merge(base: dict, override: dict) -> dict:
    """深度合并两个字典"""
    result = base.copy()
    for key, value in override.items():
        if key in result and isinstance(result[key], dict) and isinstance(value, dict):
            result[key] = deep_merge(result[key], value)
        else:
            result[key] = value
    return result


def save_state(state_file: Path, state: dict):
    """保存状态"""
    with open(state_file, "w", encoding="utf-8") as f:
        json.dump(state, f, ensure_ascii=False, indent=2)


def load_state(state_file: Path) -> dict:
    """加载状态"""
    if state_file.exists():
        with open(state_file, "r", encoding="utf-8") as f:
            return json.load(f)
    return {}


def generate_task_id() -> str:
    """生成任务ID"""
    now = datetime.now()
    date_part = now.strftime("%Y%m%d")
    time_part = now.strftime("%H%M%S")
    return f"REQ-{date_part}-{time_part}"


def load_pending_requirements() -> list:
    """加载待处理需求队列"""
    # 查找需求文件
    base_dir = Path(__file__).parent.parent.parent
    
    # 尝试多个可能的位置
    possible_paths = [
        base_dir / "shared" / "memory-bank-template" / "@pending-requirements.md",
        base_dir / "shared" / "projects" / "current" / "@pending-requirements.md",
        base_dir.parent.parent / "shared" / "@pending-requirements.md",
    ]
    
    requirements = []
    
    for req_file in possible_paths:
        if req_file.exists():
            content = req_file.read_text(encoding="utf-8")
            requirements = parse_requirements_md(content)
            break
    
    return requirements


def parse_requirements_md(content: str) -> list:
    """解析 Markdown 格式的需求文件"""
    requirements = []
    
    # 格式1: 表格行 | 排序 | 需求名 | 分数 | 类型 | 状态 |
    # 例如: | 1 | buff_system_component | 9.25 | Component | ⬜ 待实现 |
    priority_table_pattern = re.compile(
        r'\|\s*(\d+)\s*\|\s*([a-z_]+)\s*\|\s*([\d.]+)\s*\|\s*(\w+)\s*\|\s*([^|]+)\s*\|'
    )
    
    # 格式2: 需求详情标题 ### REQ-013: buff_system_component
    detail_pattern = re.compile(
        r'###\s*(REQ-\d+):\s*(\S+)'
    )
    
    # 格式3: 旧表格格式 | REQ-001 | 需求标题 | 待处理 | 高 |
    old_table_pattern = re.compile(
        r'\|\s*(REQ-\d+)\s*\|\s*([^|]+)\s*\|\s*([^|]+)\s*\|\s*([^|]+)\s*\|'
    )
    
    # 格式4: 列表格式 - [ ] REQ-001: 需求标题
    list_pattern = re.compile(
        r'-\s*\[\s*\]\s*(REQ-\d+):\s*(.+)'
    )
    
    # 先收集详情中的 REQ-ID 映射
    detail_map = {}
    for match in detail_pattern.finditer(content):
        req_id, name = match.groups()
        detail_map[name.strip()] = req_id.strip()
    
    # 解析优先级表格 (新格式)
    for match in priority_table_pattern.finditer(content):
        rank, name, score, req_type, status = match.groups()
        name = name.strip()
        status = status.strip()
        if "待实现" in status or "待处理" in status or "pending" in status.lower():
            # 尝试从详情映射获取 REQ-ID，否则生成一个
            req_id = detail_map.get(name, f"REQ-{rank.zfill(3)}")
            requirements.append({
                "id": req_id,
                "title": name,
                "priority": score,
                "type": req_type.strip(),
            })
    
    # 如果新格式没有匹配，尝试旧格式
    if not requirements:
        for match in old_table_pattern.finditer(content):
            req_id, title, status, priority = match.groups()
            if "待处理" in status or "pending" in status.lower():
                requirements.append({
                    "id": req_id.strip(),
                    "title": title.strip(),
                    "priority": priority.strip(),
                })
    
    for match in list_pattern.finditer(content):
        req_id, title = match.groups()
        requirements.append({
            "id": req_id.strip(),
            "title": title.strip(),
            "priority": "normal",
        })
    
    return requirements


def mark_requirement_done(req_id: str):
    """标记需求为已完成"""
    # TODO: 实现更新需求文件的逻辑
    pass


def archive_old_logs(active_dir: Path, archive_dir: Path, limit: int):
    """归档旧日志"""
    if not active_dir.exists():
        return
    
    # 获取所有任务目录
    task_dirs = [d for d in active_dir.iterdir() if d.is_dir() and d.name.startswith("REQ-")]
    
    # 按修改时间排序
    task_dirs.sort(key=lambda d: d.stat().st_mtime, reverse=True)
    
    # 归档超出限制的目录
    if len(task_dirs) > limit:
        for task_dir in task_dirs[limit:]:
            # 确定归档月份
            mtime = datetime.fromtimestamp(task_dir.stat().st_mtime)
            month_dir = archive_dir / mtime.strftime("%Y-%m")
            month_dir.mkdir(parents=True, exist_ok=True)
            
            # 移动目录
            target = month_dir / task_dir.name
            if not target.exists():
                shutil.move(str(task_dir), str(target))


def generate_report(state: dict, start_time: datetime, logs_dir: Path, config: dict) -> str:
    """生成运行报告"""
    end_time = datetime.now()
    duration = end_time - start_time
    
    # 计算统计数据
    completed = state.get("completed_tasks", 0)
    escalated = len(state.get("escalated_tasks", []))
    total = completed + escalated
    success_rate = (completed / total * 100) if total > 0 else 0
    
    report = f"""# 运行报告: {end_time.strftime("%Y-%m-%d %H:%M:%S")}

## 概览

| 指标 | 数值 |
|------|------|
| 运行时长 | {format_duration(duration)} |
| 完成需求 | {completed} |
| 成功率 | {success_rate:.1f}% ({completed}/{total}) |
| 升级数 | {escalated} |
| 运行模式 | {state.get('mode', 'auto')} |

## 配置

| 配置项 | 值 |
|--------|-----|
| 目标任务数 | {config['loop']['max_tasks']} |
| 升级阈值 | {config['loop']['escalation_threshold']} |
| 编译尝试上限 | {config['compile']['max_attempts']} |
| 通过分数阈值 | {config['review']['pass_threshold']} |

## 需求详情

"""
    
    # 读取活跃日志获取详细信息
    active_dir = logs_dir / "active"
    if active_dir.exists():
        report += "| 任务ID | 状态 | 编译尝试 | 评审分数 |\n"
        report += "|--------|------|----------|----------|\n"
        
        for task_dir in sorted(active_dir.iterdir()):
            if task_dir.is_dir() and task_dir.name.startswith("REQ-"):
                result_file = task_dir / "result.json"
                if result_file.exists():
                    with open(result_file, "r", encoding="utf-8") as f:
                        result = json.load(f)
                        status = "✅ 完成" if result.get("status") == "completed" else "⚠️ 升级"
                        attempts = result.get("attempts", "N/A")
                        score = result.get("score", "N/A")
                        report += f"| {task_dir.name} | {status} | {attempts} | {score} |\n"
    
    # 升级任务列表
    if state.get("escalated_tasks"):
        report += "\n## 升级任务\n\n"
        for task_id in state["escalated_tasks"]:
            report += f"- {task_id}: 见 `logs/escalation/{task_id}/summary.md`\n"
    
    # 战术手册更新
    report += "\n## 战术手册\n\n"
    report += "详见 `shared/tactical-overview.json`\n"
    
    return report


def format_duration(duration: timedelta) -> str:
    """格式化时长"""
    total_seconds = int(duration.total_seconds())
    hours, remainder = divmod(total_seconds, 3600)
    minutes, seconds = divmod(remainder, 60)
    
    if hours > 0:
        return f"{hours}小时{minutes}分钟"
    elif minutes > 0:
        return f"{minutes}分钟{seconds}秒"
    else:
        return f"{seconds}秒"


def parse_date_range(range_str: str) -> tuple:
    """解析日期范围字符串"""
    now = datetime.now()
    
    if range_str.endswith("d"):
        days = int(range_str[:-1])
        start = now - timedelta(days=days)
        return (start, now)
    elif range_str.endswith("w"):
        weeks = int(range_str[:-1])
        start = now - timedelta(weeks=weeks)
        return (start, now)
    elif range_str.endswith("m"):
        months = int(range_str[:-1])
        start = now - timedelta(days=months * 30)
        return (start, now)
    else:
        return (now - timedelta(days=7), now)
