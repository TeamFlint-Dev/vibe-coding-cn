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

依赖：
  - Python 3.8+
  - 无外部依赖（仅使用标准库）
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
    return hmac.new(
        secret.encode('utf-8'),
        payload,
        hashlib.sha256
    ).hexdigest()


# ==================== HTTP 请求 ====================

def make_request(url: str, data: dict, secret: str) -> dict:
    """发送签名的 HTTP 请求"""
    payload = json.dumps(data).encode('utf-8')
    signature = sign_payload(payload, secret)
    
    headers = {
        "Content-Type": "application/json",
        "X-Pipeline-Signature": f"sha256={signature}"
    }
    
    req = urllib.request.Request(url, data=payload, headers=headers, method="POST")
    
    try:
        with urllib.request.urlopen(req, timeout=30) as response:
            return json.loads(response.read().decode('utf-8'))
    except urllib.error.HTTPError as e:
        error_body = e.read().decode('utf-8') if e.fp else str(e)
        return {"error": f"HTTP {e.code}: {error_body}"}
    except urllib.error.URLError as e:
        return {"error": f"连接失败: {e.reason}"}
    except Exception as e:
        return {"error": str(e)}


# ==================== 命令实现 ====================

def cmd_ready(args, config):
    """通知调度器流水线就绪"""
    url = f"{config['server_url']}/pipeline/ready"
    
    data = {
        "pipeline_id": args.pipeline_id,
        "pipeline_type": args.type,
        "stages": args.stages.split(",") if args.stages else [],
        "source_url": args.source_url or "",
        "callback_url": args.callback_url or ""
    }
    
    result = make_request(url, data, config['secret'])
    
    if args.json:
        print(json.dumps(result, indent=2, ensure_ascii=False))
    else:
        if "error" in result:
            print(f"❌ 错误: {result['error']}", file=sys.stderr)
            return 1
        print(f"✅ 流水线 {args.pipeline_id} 已通知调度器")
        print(f"   类型: {args.type}")
        print(f"   阶段: {args.stages}")
    
    return 0 if "error" not in result else 1


def cmd_status(args, config):
    """查询流水线状态"""
    url = f"{config['server_url']}/pipeline/status"
    
    data = {"pipeline_id": args.pipeline_id}
    result = make_request(url, data, config['secret'])
    
    if args.json:
        print(json.dumps(result, indent=2, ensure_ascii=False))
    else:
        if "error" in result:
            print(f"❌ 错误: {result['error']}", file=sys.stderr)
            return 1
        print(f"📊 流水线 {args.pipeline_id} 状态:")
        print(json.dumps(result, indent=2, ensure_ascii=False))
    
    return 0 if "error" not in result else 1


def cmd_cancel(args, config):
    """取消流水线"""
    url = f"{config['server_url']}/pipeline/cancel"
    
    data = {
        "pipeline_id": args.pipeline_id,
        "reason": args.reason or "用户取消"
    }
    result = make_request(url, data, config['secret'])
    
    if args.json:
        print(json.dumps(result, indent=2, ensure_ascii=False))
    else:
        if "error" in result:
            print(f"❌ 错误: {result['error']}", file=sys.stderr)
            return 1
        print(f"🛑 流水线 {args.pipeline_id} 已取消")
    
    return 0 if "error" not in result else 1


def cmd_stage_complete(args, config):
    """通知阶段完成"""
    url = f"{config['server_url']}/pipeline/stage-complete"
    
    data = {
        "pipeline_id": args.pipeline_id,
        "stage": args.stage,
        "status": args.status,
        "output": args.output or ""
    }
    result = make_request(url, data, config['secret'])
    
    if args.json:
        print(json.dumps(result, indent=2, ensure_ascii=False))
    else:
        if "error" in result:
            print(f"❌ 错误: {result['error']}", file=sys.stderr)
            return 1
        print(f"✅ 阶段 {args.stage} 已标记为 {args.status}")
    
    return 0 if "error" not in result else 1


# ==================== 主程序 ====================

def main():
    parser = argparse.ArgumentParser(
        description="Pipeline Notify CLI - 流水线事件通知工具",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  # 通知流水线就绪
  pipeline-notify ready --pipeline-id p001 --type skills-distill --stages "ingest,classify"
  
  # 查询状态
  pipeline-notify status --pipeline-id p001
  
  # 取消流水线
  pipeline-notify cancel --pipeline-id p001 --reason "测试取消"
  
  # 通知阶段完成
  pipeline-notify stage-complete --pipeline-id p001 --stage ingest --status completed
"""
    )
    
    parser.add_argument("--json", action="store_true", help="输出 JSON 格式")
    
    subparsers = parser.add_subparsers(dest="command", help="可用命令")
    
    # ready 命令
    ready_parser = subparsers.add_parser("ready", help="通知流水线就绪")
    ready_parser.add_argument("--pipeline-id", required=True, help="流水线 ID")
    ready_parser.add_argument("--type", required=True, help="流水线类型")
    ready_parser.add_argument("--stages", required=True, help="阶段列表，逗号分隔")
    ready_parser.add_argument("--source-url", help="源 URL")
    ready_parser.add_argument("--callback-url", help="回调 URL")
    ready_parser.add_argument("--json", action="store_true", help="输出 JSON 格式")
    
    # status 命令
    status_parser = subparsers.add_parser("status", help="查询流水线状态")
    status_parser.add_argument("--pipeline-id", required=True, help="流水线 ID")
    status_parser.add_argument("--json", action="store_true", help="输出 JSON 格式")
    
    # cancel 命令
    cancel_parser = subparsers.add_parser("cancel", help="取消流水线")
    cancel_parser.add_argument("--pipeline-id", required=True, help="流水线 ID")
    cancel_parser.add_argument("--reason", help="取消原因")
    cancel_parser.add_argument("--json", action="store_true", help="输出 JSON 格式")
    
    # stage-complete 命令
    stage_parser = subparsers.add_parser("stage-complete", help="通知阶段完成")
    stage_parser.add_argument("--pipeline-id", required=True, help="流水线 ID")
    stage_parser.add_argument("--stage", required=True, help="阶段名称")
    stage_parser.add_argument("--status", required=True, choices=["completed", "failed", "skipped"], help="完成状态")
    stage_parser.add_argument("--output", help="输出路径或说明")
    stage_parser.add_argument("--json", action="store_true", help="输出 JSON 格式")
    
    args = parser.parse_args()
    
    if not args.command:
        parser.print_help()
        return 1
    
    config = get_config()
    
    if not config['secret']:
        print("❌ 错误: 未设置 PIPELINE_SECRET 环境变量", file=sys.stderr)
        return 1
    
    commands = {
        "ready": cmd_ready,
        "status": cmd_status,
        "cancel": cmd_cancel,
        "stage-complete": cmd_stage_complete
    }
    
    return commands[args.command](args, config)


if __name__ == "__main__":
    sys.exit(main())
