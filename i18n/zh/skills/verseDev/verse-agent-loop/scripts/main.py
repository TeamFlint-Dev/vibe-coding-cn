#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Verse Agent Loop - 全自动编码循环控制器主脚本

通过命令行调用多个 Copilot Agent（Background Agent / Codex）实现
"需求→编码→编译验证→多Agent评审→Git投票→战术手册更新"的完整闭环。

使用方法:
    python main.py --calibration      # 校准模式
    python main.py                    # 全自动模式
    python main.py --resume           # 恢复运行
"""

import argparse
import io
import json
import os
import signal
import sys
import time

# 修复 Windows 控制台编码问题
if sys.platform == "win32":
    # 设置控制台输出编码为 UTF-8
    if sys.stdout.encoding != 'utf-8':
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
    if sys.stderr.encoding != 'utf-8':
        sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')
    # 设置环境变量确保子进程也使用 UTF-8
    os.environ['PYTHONIOENCODING'] = 'utf-8'
from datetime import datetime
from pathlib import Path
from typing import Optional

from agents import AgentManager
from compiler import VerseCompiler
from git_manager import GitManager
from utils import (
    setup_logging,
    load_config,
    save_state,
    load_state,
    generate_task_id,
    load_pending_requirements,
    mark_requirement_done,
    archive_old_logs,
    generate_report,
)

# 全局状态
shutdown_requested = False
force_shutdown = False


def signal_handler(signum, frame):
    """处理 Ctrl+C 信号"""
    global shutdown_requested, force_shutdown
    if shutdown_requested:
        print("\n🔴 强制停止...")
        force_shutdown = True
        sys.exit(1)
    else:
        print("\n⚠️ 收到停止信号，将在当前需求完成后停止...")
        shutdown_requested = True


class VerseAgentLoop:
    """全自动编码循环控制器"""

    def __init__(self, config_path: str, calibration: bool = False, resume: bool = False):
        self.config = load_config(config_path)
        self.calibration = calibration
        self.resume = resume
        
        # 初始化路径
        self.base_dir = Path(__file__).parent.parent
        self.logs_dir = self.base_dir / "logs"
        self.reports_dir = self.base_dir / "reports"
        self.state_file = self.base_dir / "state.json"
        
        # 确保目录存在
        (self.logs_dir / "active").mkdir(parents=True, exist_ok=True)
        (self.logs_dir / "archive").mkdir(parents=True, exist_ok=True)
        (self.logs_dir / "escalation").mkdir(parents=True, exist_ok=True)
        self.reports_dir.mkdir(parents=True, exist_ok=True)
        
        # 初始化日志
        self.logger = setup_logging(self.logs_dir / "active" / "current.log")
        
        # 初始化组件
        self.agent_manager = AgentManager(self.config)
        self.compiler = VerseCompiler(self.config)
        self.git_manager = GitManager(self.config)
        
        # 状态
        self.state = self._init_state()
        self.pending_errors = []  # 待处理的错误队列
        self.start_time = datetime.now()

    def _init_state(self) -> dict:
        """初始化或恢复状态"""
        if self.resume and self.state_file.exists():
            self.logger.info("📂 从检查点恢复状态...")
            return load_state(self.state_file)
        
        return {
            "version": "1.0.0",
            "started_at": datetime.now().isoformat(),
            "completed_tasks": 0,
            "escalated_tasks": [],
            "current_task": None,
            "calibration_passed": 0,
            "mode": "calibration" if self.calibration else "auto",
            "pending_errors_count": 0,
        }

    def run(self):
        """主运行循环"""
        self.logger.info("🚀 Verse Agent Loop 启动")
        self.logger.info(f"   模式: {'校准' if self.calibration else '全自动'}")
        self.logger.info(f"   目标任务数: {self.config['loop']['max_tasks']}")
        
        try:
            while not self._should_exit():
                # 检查是否需要生成新需求
                self._check_requirement_queue()
                
                # 获取下一个需求
                requirement = self._get_next_requirement()
                if not requirement:
                    self.logger.info("📭 需求队列为空")
                    if self.config["loop"]["auto_generate_requirements"]:
                        self._generate_requirements()
                        continue
                    else:
                        break
                
                # 处理需求
                task_id = generate_task_id()
                self.state["current_task"] = task_id
                save_state(self.state_file, self.state)
                
                result = self._process_requirement(task_id, requirement)
                
                # 更新状态
                if result["status"] == "completed":
                    self.state["completed_tasks"] += 1
                    mark_requirement_done(requirement["id"])
                elif result["status"] == "escalated":
                    self.state["escalated_tasks"].append(task_id)
                
                self.state["current_task"] = None
                save_state(self.state_file, self.state)
                
                # 校准模式检查
                if self.calibration and self.state["completed_tasks"] <= 3:
                    if not self._calibration_confirm(task_id, result):
                        self.logger.warning("❌ 校准未通过，需要调整")
                        continue
                    self.state["calibration_passed"] += 1
                    if self.state["calibration_passed"] >= 3:
                        self.logger.info("✅ 校准完成，切换到全自动模式")
                        self.calibration = False
                        self.state["mode"] = "auto"
                
                # 战术手册更新
                self._maybe_update_handbook()
                
                # 归档旧日志
                archive_old_logs(
                    self.logs_dir / "active",
                    self.logs_dir / "archive",
                    self.config["logs"]["active_limit"]
                )
                
        except KeyboardInterrupt:
            self.logger.info("⚠️ 用户中断")
        finally:
            self._finalize()

    def _should_exit(self) -> bool:
        """检查是否应该退出"""
        if shutdown_requested or force_shutdown:
            return True
        if self.state["completed_tasks"] >= self.config["loop"]["max_tasks"]:
            self.logger.info(f"🎯 已完成目标任务数: {self.config['loop']['max_tasks']}")
            return True
        return False

    def _check_requirement_queue(self):
        """检查需求队列，必要时触发生成"""
        requirements = load_pending_requirements()
        if len(requirements) <= self.config["loop"]["requirement_queue_threshold"]:
            if self.config["loop"]["auto_generate_requirements"]:
                self.logger.info("📝 需求队列不足，触发需求生成...")
                self._generate_requirements()

    def _get_next_requirement(self) -> Optional[dict]:
        """获取下一个待处理需求"""
        requirements = load_pending_requirements()
        if requirements:
            return requirements[0]
        return None

    def _generate_requirements(self):
        """调用需求生成Agent"""
        self.logger.info("🔄 调用 verse-requirement-proposer 生成需求...")
        try:
            self.agent_manager.call_requirement_proposer()
        except Exception as e:
            self.logger.error(f"需求生成失败: {e}")

    def _process_requirement(self, task_id: str, requirement: dict) -> dict:
        """处理单个需求的完整流程"""
        self.logger.info(f"\n{'='*60}")
        self.logger.info(f"📋 开始处理需求: {task_id}")
        self.logger.info(f"   描述: {requirement.get('title', 'N/A')}")
        self.logger.info(f"{'='*60}")
        
        task_log_dir = self.logs_dir / "active" / task_id
        task_log_dir.mkdir(parents=True, exist_ok=True)
        
        # 保存任务元数据
        with open(task_log_dir / "task.json", "w", encoding="utf-8") as f:
            json.dump({
                "task_id": task_id,
                "requirement": requirement,
                "started_at": datetime.now().isoformat(),
            }, f, ensure_ascii=False, indent=2)
        
        rejection_count = 0
        max_rejections = self.config["loop"]["escalation_threshold"]
        
        while rejection_count < max_rejections:
            attempt = rejection_count + 1
            self.logger.info(f"\n--- 尝试 {attempt}/{max_rejections} ---")
            
            # 1. 创建 Git 分支
            branch_name = f"{self.config['git']['branch_prefix']}/{task_id}-attempt-{attempt}"
            self.git_manager.create_branch(branch_name)
            
            # 2. 调用编码Agent
            coding_result = self._run_coding_agent(task_id, requirement, task_log_dir, attempt)
            
            # 3. 编译验证
            compile_success = self._run_compile_loop(task_id, task_log_dir, attempt)
            coding_result["compile_success"] = compile_success
            
            # 4. 评审
            review_results = self._run_review_agents(task_id, task_log_dir)
            
            # 5. 投票统计
            vote_result = self._calculate_vote(review_results)
            
            # 保存本轮结果
            with open(task_log_dir / f"attempt-{attempt}-result.json", "w", encoding="utf-8") as f:
                json.dump({
                    "coding_result": coding_result,
                    "compile_success": compile_success,
                    "review_results": review_results,
                    "vote_result": vote_result,
                }, f, ensure_ascii=False, indent=2)
            
            if vote_result["passed"]:
                # 合并到主分支
                self.git_manager.merge_to_main(branch_name)
                self.logger.info(f"✅ 需求 {task_id} 完成!")
                
                # 收集错误供 Tactician 处理
                self._collect_errors(coding_result, review_results)
                
                return {
                    "status": "completed",
                    "attempts": attempt,
                    "score": vote_result["score"],
                }
            else:
                rejection_count += 1
                self.logger.warning(f"❌ 评审否决 ({rejection_count}/{max_rejections})")
                self.logger.warning(f"   原因: {vote_result.get('reason', 'N/A')}")
                
                # 收集错误
                self._collect_errors(coding_result, review_results)
                
                if rejection_count < max_rejections:
                    # 反馈问题给编码Agent
                    self._feedback_to_coding_agent(review_results)
        
        # 升级处理
        self.logger.error(f"⚠️ 需求 {task_id} 连续 {max_rejections} 次被否决，升级处理")
        self._escalate_task(task_id, task_log_dir)
        
        return {
            "status": "escalated",
            "attempts": max_rejections,
        }

    def _run_coding_agent(self, task_id: str, requirement: dict, log_dir: Path, attempt: int) -> dict:
        """运行编码Agent"""
        self.logger.info("🤖 调用编码Agent...")
        
        # 加载战术手册上下文
        handbook_context = self._load_handbook_context()
        
        # 调用Agent
        result = self.agent_manager.call_coding_agent(
            requirement=requirement,
            handbook_context=handbook_context,
            task_id=task_id,
        )
        
        # 保存日志
        with open(log_dir / f"coding-attempt-{attempt}.log", "w", encoding="utf-8") as f:
            f.write(result.get("raw_output", ""))
        
        return result

    def _run_compile_loop(self, task_id: str, log_dir: Path, attempt: int) -> bool:
        """编译验证循环"""
        max_compile_attempts = self.config["compile"]["max_attempts"]
        
        for compile_attempt in range(1, max_compile_attempts + 1):
            self.logger.info(f"🔨 编译尝试 {compile_attempt}/{max_compile_attempts}...")
            
            result = self.compiler.compile()
            
            # 保存编译日志
            with open(log_dir / f"compile-{attempt}-{compile_attempt}.log", "w", encoding="utf-8") as f:
                f.write(result.get("log", ""))
            
            if result["success"]:
                self.logger.info("✅ 编译成功!")
                return True
            else:
                self.logger.warning(f"❌ 编译失败: {result.get('error_count', 0)} 个错误")
                
                if compile_attempt < max_compile_attempts:
                    # 调用Agent修复
                    self.logger.info("🔧 调用Agent修复编译错误...")
                    self.agent_manager.call_fix_compile_errors(result["errors"])
        
        self.logger.error("❌ 编译验证失败，达到最大尝试次数")
        return False

    def _run_review_agents(self, task_id: str, log_dir: Path) -> list:
        """并行运行三个评审Agent"""
        self.logger.info("👥 调用评审Agents...")
        
        review_types = ["utility", "framework", "quality"]
        results = []
        
        # TODO: 可以改为并行执行
        for review_type in review_types:
            self.logger.info(f"   - {review_type} 评审中...")
            result = self.agent_manager.call_review_agent(review_type, task_id)
            results.append(result)
            
            # 保存结果
            with open(log_dir / f"review-{review_type}.json", "w", encoding="utf-8") as f:
                json.dump(result, f, ensure_ascii=False, indent=2)
            
            # Git notes 投票
            verdict = result.get("verdict", "reject")
            self.git_manager.add_vote_note(review_type, verdict)
        
        return results

    def _calculate_vote(self, review_results: list) -> dict:
        """计算投票结果"""
        weights = self.config["review"]["weights"]
        pass_threshold = self.config["review"]["pass_threshold"]
        require_no_critical = self.config["review"]["require_no_critical"]
        
        total_score = 0
        has_critical = False
        rejection_reasons = []
        
        for result in review_results:
            agent_type = result.get("agent", "").replace("reviewer-", "")
            weight = weights.get(agent_type, 0.33)
            score = result.get("score", 0)
            total_score += score * weight
            
            # 检查严重问题
            for issue in result.get("issues", []):
                if issue.get("severity") == "critical":
                    has_critical = True
                    rejection_reasons.append(issue.get("description", "严重问题"))
            
            if result.get("verdict") == "reject":
                rejection_reasons.append(result.get("summary", "评审否决"))
        
        passed = total_score >= pass_threshold
        if require_no_critical and has_critical:
            passed = False
        
        return {
            "passed": passed,
            "score": round(total_score, 2),
            "has_critical": has_critical,
            "reason": "; ".join(rejection_reasons) if rejection_reasons else None,
        }

    def _collect_errors(self, coding_result: dict, review_results: list):
        """收集错误供 Tactician 处理"""
        if coding_result.get("should_update_handbook", False):
            self.pending_errors.append({
                "type": "coding",
                "content": coding_result,
            })
        
        for result in review_results:
            if result.get("should_update_handbook", False):
                self.pending_errors.append({
                    "type": "review",
                    "content": result,
                })

    def _maybe_update_handbook(self):
        """根据模式决定是否更新战术手册"""
        frequency = (
            self.config["tactician"]["calibration_frequency"]
            if self.calibration
            else self.config["tactician"]["auto_frequency"]
        )
        
        if self.state["completed_tasks"] % frequency == 0:
            if self.pending_errors or not self.config["tactician"]["skip_if_no_updates"]:
                self._call_tactician()

    def _call_tactician(self):
        """调用 Tactician 更新战术手册"""
        if not self.pending_errors:
            return
        
        self.logger.info(f"📚 调用 Tactician 处理 {len(self.pending_errors)} 条上报...")
        
        try:
            self.agent_manager.call_tactician(self.pending_errors)
            self.pending_errors = []
        except Exception as e:
            self.logger.error(f"Tactician 调用失败: {e}")

    def _feedback_to_coding_agent(self, review_results: list):
        """将评审问题反馈给编码Agent"""
        feedback = []
        for result in review_results:
            for issue in result.get("issues", []):
                feedback.append({
                    "category": issue.get("category"),
                    "description": issue.get("description"),
                    "suggested_fix": issue.get("suggested_fix"),
                })
        
        self.agent_manager.set_feedback_context(feedback)

    def _escalate_task(self, task_id: str, task_log_dir: Path):
        """升级任务到人工处理"""
        escalation_dir = self.logs_dir / "escalation" / task_id
        escalation_dir.mkdir(parents=True, exist_ok=True)
        
        # 复制所有尝试记录
        import shutil
        shutil.copytree(task_log_dir, escalation_dir / "attempts", dirs_exist_ok=True)
        
        # 生成摘要
        summary = self._generate_escalation_summary(task_id, task_log_dir)
        with open(escalation_dir / "summary.md", "w", encoding="utf-8") as f:
            f.write(summary)
        
        # 创建空的 resolution.md
        with open(escalation_dir / "resolution.md", "w", encoding="utf-8") as f:
            f.write(f"# 人工解决记录: {task_id}\n\n")
            f.write("## 解决方案\n\n<!-- 在此填写解决方案 -->\n\n")
            f.write("## 解决人\n\n<!-- 填写处理人 -->\n\n")
            f.write("## 解决时间\n\n<!-- 填写时间 -->\n")

    def _generate_escalation_summary(self, task_id: str, task_log_dir: Path) -> str:
        """生成升级任务摘要"""
        summary = f"# 升级任务摘要: {task_id}\n\n"
        summary += f"**创建时间**: {datetime.now().isoformat()}\n"
        summary += f"**尝试次数**: {self.config['loop']['escalation_threshold']}\n\n"
        
        summary += "## 需求描述\n\n"
        task_file = task_log_dir / "task.json"
        if task_file.exists():
            with open(task_file, "r", encoding="utf-8") as f:
                task_data = json.load(f)
                summary += f"```json\n{json.dumps(task_data.get('requirement', {}), ensure_ascii=False, indent=2)}\n```\n\n"
        
        summary += "## 失败原因汇总\n\n"
        for i in range(1, self.config["loop"]["escalation_threshold"] + 1):
            result_file = task_log_dir / f"attempt-{i}-result.json"
            if result_file.exists():
                with open(result_file, "r", encoding="utf-8") as f:
                    result = json.load(f)
                    vote = result.get("vote_result", {})
                    summary += f"### 尝试 {i}\n"
                    summary += f"- 编译: {'✅' if result.get('compile_success') else '❌'}\n"
                    summary += f"- 评分: {vote.get('score', 'N/A')}\n"
                    summary += f"- 原因: {vote.get('reason', 'N/A')}\n\n"
        
        return summary

    def _load_handbook_context(self) -> str:
        """加载战术手册上下文"""
        overview_file = self.base_dir.parent / "shared" / "tactical-overview.json"
        if overview_file.exists():
            with open(overview_file, "r", encoding="utf-8") as f:
                data = json.load(f)
                return json.dumps(data.get("high_frequency_roots", []), ensure_ascii=False, indent=2)
        return "[]"

    def _calibration_confirm(self, task_id: str, result: dict) -> bool:
        """校准模式下的人工确认"""
        print(f"\n{'='*60}")
        print(f"🔍 校准确认: {task_id}")
        print(f"{'='*60}")
        print(f"状态: {result['status']}")
        print(f"尝试次数: {result.get('attempts', 'N/A')}")
        print(f"评分: {result.get('score', 'N/A')}")
        print(f"\n查看详细日志: {self.logs_dir / 'active' / task_id}")
        print(f"{'='*60}")
        
        while True:
            response = input("\n结果是否符合预期? (y/n/q): ").strip().lower()
            if response == 'y':
                return True
            elif response == 'n':
                return False
            elif response == 'q':
                global shutdown_requested
                shutdown_requested = True
                return True
            else:
                print("请输入 y(是), n(否), 或 q(退出)")

    def _finalize(self):
        """结束处理"""
        self.logger.info("\n" + "="*60)
        self.logger.info("🏁 Verse Agent Loop 结束")
        
        # 处理剩余的错误上报
        if self.pending_errors:
            self._call_tactician()
        
        # 保存最终状态
        self.state["ended_at"] = datetime.now().isoformat()
        save_state(self.state_file, self.state)
        
        # 生成报告
        report = generate_report(
            self.state,
            self.start_time,
            self.logs_dir,
            self.config,
        )
        
        report_file = self.reports_dir / f"run-{datetime.now().strftime('%Y%m%d-%H%M%S')}.md"
        with open(report_file, "w", encoding="utf-8") as f:
            f.write(report)
        
        self.logger.info(f"📊 报告已生成: {report_file}")
        self.logger.info(f"   完成任务: {self.state['completed_tasks']}")
        self.logger.info(f"   升级任务: {len(self.state['escalated_tasks'])}")


def main():
    """主入口"""
    parser = argparse.ArgumentParser(
        description="Verse Agent Loop - 全自动编码循环控制器",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
    python main.py --calibration      # 校准模式
    python main.py -n 10 -g           # 完成10个需求，启用自动生成
    python main.py --resume           # 恢复运行
        """
    )
    
    parser.add_argument("-c", "--calibration", action="store_true",
                        help="校准模式，前3个需求人工确认")
    parser.add_argument("-r", "--resume", action="store_true",
                        help="从检查点恢复")
    parser.add_argument("-n", "--max-tasks", type=int, default=None,
                        help="完成多少个需求后停止 (默认: 5)")
    parser.add_argument("-g", "--auto-generate", action="store_true",
                        help="需求队列空时自动生成新需求")
    parser.add_argument("-e", "--escalation-threshold", type=int, default=None,
                        help="连续否决多少次后升级 (默认: 3)")
    parser.add_argument("--config", type=str, default=None,
                        help="配置文件路径")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="详细日志")
    
    args = parser.parse_args()
    
    # 配置文件路径
    config_path = args.config or str(Path(__file__).parent.parent / "config" / "default.json")
    
    # 如果没有恢复，询问配置
    if not args.resume and not args.calibration:
        print("\n🚀 Verse Agent Loop 启动配置")
        print("="*40)
        
        if args.max_tasks is None:
            try:
                args.max_tasks = int(input("完成需求数量 [5]: ").strip() or "5")
            except ValueError:
                args.max_tasks = 5
        
        if not args.auto_generate:
            response = input("启用自动需求生成? (y/n) [n]: ").strip().lower()
            args.auto_generate = response == 'y'
        
        if args.escalation_threshold is None:
            try:
                args.escalation_threshold = int(input("升级阈值(连续否决次数) [3]: ").strip() or "3")
            except ValueError:
                args.escalation_threshold = 3
    
    # 注册信号处理
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)
    
    # 创建并运行循环
    loop = VerseAgentLoop(
        config_path=config_path,
        calibration=args.calibration,
        resume=args.resume,
    )
    
    # 应用命令行覆盖
    if args.max_tasks is not None:
        loop.config["loop"]["max_tasks"] = args.max_tasks
    if args.auto_generate:
        loop.config["loop"]["auto_generate_requirements"] = True
    if args.escalation_threshold is not None:
        loop.config["loop"]["escalation_threshold"] = args.escalation_threshold
    
    loop.run()


if __name__ == "__main__":
    main()
