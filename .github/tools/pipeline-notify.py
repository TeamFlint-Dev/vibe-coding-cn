#!/usr/bin/env python3
"""
Pipeline Notify CLI - 流水线事件通知工具

用途：
  让 Planner Agent 可以通过一条命令通知云端调度器启动流水线。
  封装了 HTTPS 请求和签名验证，Agent 只需调用此脚本。

用法：
  pipeline-notify ready --pipeline-id p001 --type skills-distill --stages "ingest,classify,extract,assemble,validate"
  pipeline-notify status --pipeline-id p001
  pipeline-notify cancel --pipeline-id p001

环境变量：
  PIPELINE_SERVER_URL  - 服务器地址 (默认: http://193.112.183.143:19527)
  PIPELINE_SECRET      - 签名密钥 (必需)
"""

import argparse
import hashlib
import hmac
import json
import os
import sys
import urllib.request
import urllib.error
from typing import Optional


# ==================== 配置 ====================

DEFAULT_SERVER_URL = "http://193.112.183.143:19527"


def get_config():
    """获取配置"""
    server_url = os.environ.get("PIPELINE_SERVER_URL", DEFAULT_SERVER_URL)
    secret = os.environ.get("PIPELINE_SECRET", "")
    
    return {
        "server_url": server_url.rstrip("/"),
        "secret": secret
    }


# ==================== 签名 ====================

def sign_payload(payload: bytes, secret: str) -> str:
    """对 payload 进行 HMAC-SHA256 签名"""
    if not secret:
        return ""
    return "sha256=" + hmac.new(
        secret.encode(),
        payload,
        hashlib.sha256
    ).hexdigest()


# ==================== HTTP 请求 ====================

def http_request(
    method: str,
    url: str,
    data: Optional[dict] = None,
    secret: str = ""
) -> dict:
    """发送 HTTP 请求"""
    headers = {
        "Content-Type": "application/json",
        "User-Agent": "pipeline-notify/1.0"
    }
    
    body = None
    if data:
        body = json.dumps(data).encode("utf-8")
        if secret:
            headers["X-Pipeline-Signature"] = sign_payload(body, secret)
    
    try:
        req = urllib.request.Request(
            url,
            data=body,
            headers=headers,
            method=method
        )
        
        with urllib.request.urlopen(req, timeout=30) as resp:
            response_body = resp.read().decode("utf-8")
            try:
                return {
                    "success": True,
                    "status_code": resp.status,
                    "data": json.loads(response_body)
                }
            except json.JSONDecodeError:
                return {
                    "success": True,
                    "status_code": resp.status,
                    "data": {"raw": response_body}
                }
                
    except urllib.error.HTTPError as e:
        error_body = ""
        try:
            error_body = e.read().decode("utf-8")
        except:
            pass
        return {
            "success": False,
            "status_code": e.code,
            "error": f"HTTP {e.code}: {e.reason}",
            "data": error_body
        }
    except urllib.error.URLError as e:
        return {
            "success": False,
            "status_code": 0,
            "error": f"Connection error: {e.reason}"
        }
    except Exception as e:
        return {
            "success": False,
            "status_code": 0,
            "error": str(e)
        }


# ==================== 命令处理 ====================

def cmd_ready(args):
    """发送 pipeline ready 通知"""
    config = get_config()
    
    # 解析 stages
    stages = [s.strip() for s in args.stages.split(",") if s.strip()]
    
    # 解析 stage_ids (可选)
    stage_ids = {}
    if args.stage_ids:
        for pair in args.stage_ids.split(","):
            if ":" in pair:
                stage, task_id = pair.split(":", 1)
                stage_ids[stage.strip()] = task_id.strip()
    
    payload = {
        "pipeline_id": args.pipeline_id,
        "type": args.type,
        "stages": stages,
        "source_url": args.source_url or "",
    }
    
    if stage_ids:
        payload["stage_ids"] = stage_ids
    
    # 添加分支信息（用于 Worker 提交）
    if args.branch:
        payload["branch"] = args.branch
    
    # 添加 memory 分支信息（用于调度器读取 pipeline 状态）
    if hasattr(args, 'memory_branch') and args.memory_branch:
        payload["memory_branch"] = args.memory_branch
    
    print(f"[pipeline-notify] Sending ready notification...")
    print(f"  Server: {config['server_url']}")
    print(f"  Pipeline ID: {args.pipeline_id}")
    print(f"  Type: {args.type}")
    print(f"  Stages: {stages}")
    if args.branch:
        print(f"  Branch: {args.branch}")
    if hasattr(args, 'memory_branch') and args.memory_branch:
        print(f"  Memory Branch: {args.memory_branch}")
    
    result = http_request(
        "POST",
        f"{config['server_url']}/pipeline/ready",
        data=payload,
        secret=config["secret"]
    )
    
    if result["success"]:
        print(f"[pipeline-notify] ✅ Success!")
        print(f"  Response: {json.dumps(result['data'], indent=2)}")
        return 0
    else:
        print(f"[pipeline-notify] ❌ Failed: {result.get('error', 'Unknown error')}")
        if result.get("data"):
            print(f"  Details: {result['data']}")
        return 1


def cmd_status(args):
    """查询 pipeline 状态"""
    config = get_config()
    
    print(f"[pipeline-notify] Querying pipeline status...")
    print(f"  Pipeline ID: {args.pipeline_id}")
    
    result = http_request(
        "GET",
        f"{config['server_url']}/pipeline/status/{args.pipeline_id}"
    )
    
    if result["success"]:
        print(f"[pipeline-notify] ✅ Status:")
        print(json.dumps(result["data"], indent=2, ensure_ascii=False))
        return 0
    else:
        print(f"[pipeline-notify] ❌ Failed: {result.get('error', 'Unknown error')}")
        return 1


def cmd_cancel(args):
    """取消 pipeline"""
    config = get_config()
    
    print(f"[pipeline-notify] Cancelling pipeline...")
    print(f"  Pipeline ID: {args.pipeline_id}")
    
    result = http_request(
        "POST",
        f"{config['server_url']}/pipeline/cancel/{args.pipeline_id}",
        secret=config["secret"]
    )
    
    if result["success"]:
        print(f"[pipeline-notify] ✅ Pipeline cancelled")
        return 0
    else:
        print(f"[pipeline-notify] ❌ Failed: {result.get('error', 'Unknown error')}")
        return 1


def cmd_health(args):
    """检查服务器健康状态"""
    config = get_config()
    
    print(f"[pipeline-notify] Checking server health...")
    print(f"  Server: {config['server_url']}")
    
    result = http_request("GET", f"{config['server_url']}/health")
    
    if result["success"]:
        print(f"[pipeline-notify] ✅ Server is healthy")
        print(json.dumps(result["data"], indent=2))
        return 0
    else:
        print(f"[pipeline-notify] ❌ Server unreachable: {result.get('error', 'Unknown error')}")
        return 1


def cmd_list(args):
    """列出所有 pipeline"""
    config = get_config()
    
    print(f"[pipeline-notify] Listing pipelines...")
    
    result = http_request("GET", f"{config['server_url']}/pipeline/list")
    
    if result["success"]:
        data = result["data"]
        print(f"[pipeline-notify] ✅ Found {data.get('count', 0)} pipeline(s)")
        for p in data.get("pipelines", []):
            print(f"  - {p.get('pipeline_id')}: {p.get('status')} ({p.get('type')})")
        return 0
    else:
        print(f"[pipeline-notify] ❌ Failed: {result.get('error', 'Unknown error')}")
        return 1


def cmd_stage_complete(args):
    """通知阶段完成"""
    config = get_config()
    
    payload = {
        "pipeline_id": args.pipeline_id,
        "stage_id": args.stage_id,
        "task_id": args.task_id,
        "status": args.status,
    }
    
    if args.output:
        payload["output"] = args.output
    
    if args.error:
        payload["error"] = args.error
    
    print(f"[pipeline-notify] Sending stage completion notification...")
    print(f"  Server: {config['server_url']}")
    print(f"  Pipeline ID: {args.pipeline_id}")
    print(f"  Stage ID: {args.stage_id}")
    print(f"  Status: {args.status}")
    
    result = http_request(
        "POST",
        f"{config['server_url']}/pipeline/stage-complete",
        data=payload,
        secret=config["secret"]
    )
    
    if result["success"]:
        print(f"[pipeline-notify] ✅ Stage completion notified!")
        print(f"  Response: {json.dumps(result['data'], indent=2)}")
        return 0
    else:
        print(f"[pipeline-notify] ❌ Failed: {result.get('error', 'Unknown error')}")
        if result.get("data"):
            print(f"  Details: {result['data']}")
        return 1


# ==================== 主入口 ====================

def main():
    parser = argparse.ArgumentParser(
        description="Pipeline Notify CLI - 流水线事件通知工具",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例：
  # 通知调度器启动流水线
  pipeline-notify ready \\
    --pipeline-id p20260101120000 \\
    --type skills-distill \\
    --stages "ingest,classify,extract,assemble,validate" \\
    --source-url "https://github.com/anthropics/courses"

  # 带分支信息（Worker 将提交到此分支）
  pipeline-notify ready \\
    --pipeline-id p001 \\
    --type skills-distill \\
    --stages "ingest,classify" \\
    --branch "pipeline/p001"

  # 带 stage_ids (Beads 任务 ID 映射)
  pipeline-notify ready \\
    --pipeline-id p001 \\
    --type skills-distill \\
    --stages "ingest,classify" \\
    --stage-ids "ingest:bd-abc123,classify:bd-def456"

  # 查询状态
  pipeline-notify status --pipeline-id p001

  # 取消流水线
  pipeline-notify cancel --pipeline-id p001

  # 检查服务器健康
  pipeline-notify health

  # 列出所有流水线
  pipeline-notify list

环境变量：
  PIPELINE_SERVER_URL  服务器地址 (默认: http://193.112.183.143:19527)
  PIPELINE_SECRET      签名密钥
"""
    )
    
    subparsers = parser.add_subparsers(dest="command", help="子命令")
    
    # ready 命令
    ready_parser = subparsers.add_parser("ready", help="通知调度器启动流水线")
    ready_parser.add_argument("--pipeline-id", required=True, help="流水线 ID")
    ready_parser.add_argument("--type", required=True, help="流水线类型 (如 skills-distill)")
    ready_parser.add_argument("--stages", required=True, help="阶段列表，逗号分隔")
    ready_parser.add_argument("--stage-ids", help="阶段 ID 映射，格式: stage:id,stage:id")
    ready_parser.add_argument("--source-url", help="源 URL")
    ready_parser.add_argument("--branch", help="工作分支名称 (如 pipeline/p001)")
    ready_parser.add_argument("--memory-branch", help="Memory 分支名称 (如 memory/pipelines)")
    
    # stage-complete 命令
    stage_complete_parser = subparsers.add_parser("stage-complete", help="通知阶段完成")
    stage_complete_parser.add_argument("--pipeline-id", required=True, help="流水线 ID")
    stage_complete_parser.add_argument("--stage-id", required=True, help="阶段 ID")
    stage_complete_parser.add_argument("--task-id", required=True, help="Beads 任务 ID")
    stage_complete_parser.add_argument("--status", required=True, choices=["completed", "failed"], help="完成状态")
    stage_complete_parser.add_argument("--output", help="产物路径")
    stage_complete_parser.add_argument("--error", help="错误信息")
    
    # status 命令
    status_parser = subparsers.add_parser("status", help="查询流水线状态")
    status_parser.add_argument("--pipeline-id", required=True, help="流水线 ID")
    
    # cancel 命令
    cancel_parser = subparsers.add_parser("cancel", help="取消流水线")
    cancel_parser.add_argument("--pipeline-id", required=True, help="流水线 ID")
    
    # health 命令
    subparsers.add_parser("health", help="检查服务器健康状态")
    
    # list 命令
    subparsers.add_parser("list", help="列出所有流水线")
    
    args = parser.parse_args()
    
    if args.command == "ready":
        sys.exit(cmd_ready(args))
    elif args.command == "stage-complete":
        sys.exit(cmd_stage_complete(args))
    elif args.command == "status":
        sys.exit(cmd_status(args))
    elif args.command == "cancel":
        sys.exit(cmd_cancel(args))
    elif args.command == "health":
        sys.exit(cmd_health(args))
    elif args.command == "list":
        sys.exit(cmd_list(args))
    else:
        parser.print_help()
        sys.exit(1)


if __name__ == "__main__":
    main()
