#!/usr/bin/env python3
"""
Agent 调用模块 - 封装 Copilot Background Agent / OpenAI Codex 的调用

支持两种调用方式:
1. Copilot CLI (copilot agent --prompt)
2. OpenAI API (ChatCompletion)
"""

import json
import os
import subprocess
import time
from pathlib import Path
from typing import Optional

# 尝试导入 openai，可能未安装
try:
    import openai
    OPENAI_AVAILABLE = True
except ImportError:
    OPENAI_AVAILABLE = False


class AgentManager:
    """Agent 调用管理器"""

    def __init__(self, config: dict):
        self.config = config
        self.agent_config = config.get("agent", {})
        self.provider = self.agent_config.get("provider", "copilot")
        self.model = self.agent_config.get("model", "gpt-4")
        self.timeout = self.agent_config.get("timeout", 300)
        self.retry_attempts = self.agent_config.get("retry_attempts", 2)
        
        # 加载提示词模板
        self.prompts_dir = Path(__file__).parent.parent / "prompts"
        self.feedback_context = []
        
        # 初始化 OpenAI（如果使用）
        if self.provider == "openai" and OPENAI_AVAILABLE:
            api_key_env = self.agent_config.get("api_key_env", "OPENAI_API_KEY")
            openai.api_key = os.environ.get(api_key_env)
        
        # Demo 模式检测
        self.demo_mode = self.provider == "demo"
        if self.demo_mode:
            print("🎭 [演示模式] Agent调用将返回模拟数据")

    def _load_prompt_template(self, template_name: str) -> str:
        """加载提示词模板"""
        template_file = self.prompts_dir / f"{template_name}.md"
        if template_file.exists():
            return template_file.read_text(encoding="utf-8")
        return ""

    def _call_agent(self, prompt: str, working_dir: Optional[str] = None) -> str:
        """调用Agent的统一接口"""
        # Demo 模式直接返回模拟数据
        if self.demo_mode:
            return self._demo_response(prompt)
        
        for attempt in range(self.retry_attempts + 1):
            try:
                if self.provider == "copilot":
                    return self._call_copilot(prompt, working_dir)
                elif self.provider == "openai":
                    return self._call_openai(prompt)
                else:
                    raise ValueError(f"Unknown provider: {self.provider}")
            except Exception as e:
                if attempt < self.retry_attempts:
                    print(f"⚠️ Agent调用失败，重试 ({attempt + 1}/{self.retry_attempts}): {e}")
                    time.sleep(2 ** attempt)  # 指数退避
                else:
                    raise

    def _demo_response(self, prompt: str) -> str:
        """演示模式的模拟响应"""
        import random
        
        # 模拟编码任务响应
        if "编码任务" in prompt or "coding" in prompt.lower():
            return '''
# 演示模式生成的代码

```verse
demo_component := class<final_super>(component):
    @editable var DemoValue:int = 100
    
    OnInitialized<override>():void =
        Print("Demo component initialized")
```

```json
{
    "task_id": "DEMO-001",
    "agent": "coding",
    "compile_attempts": 1,
    "compile_success": true,
    "errors": [],
    "should_update_handbook": false
}
```
'''
        
        # 模拟评审响应
        elif "评审" in prompt or "review" in prompt.lower():
            score = random.randint(7, 9)
            return f'''
```json
{{
    "task_id": "DEMO-001",
    "agent": "reviewer",
    "verdict": "approve",
    "score": {score},
    "issues": [],
    "summary": "演示模式：代码质量良好",
    "should_update_handbook": false
}}
```
'''
        
        # 默认响应
        return '{"status": "demo", "message": "演示模式响应"}'

    def _call_copilot(self, prompt: str, working_dir: Optional[str] = None) -> str:
        """通过 Copilot CLI 调用 Background Agent"""
        cmd = ["copilot", "agent", "--prompt", prompt]
        
        if working_dir:
            cmd.extend(["--workdir", working_dir])
        
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=self.timeout,
            cwd=working_dir,
        )
        
        if result.returncode != 0:
            raise RuntimeError(f"Copilot agent failed: {result.stderr}")
        
        return result.stdout

    def _call_openai(self, prompt: str) -> str:
        """通过 OpenAI API 调用"""
        if not OPENAI_AVAILABLE:
            raise RuntimeError("OpenAI package not installed. Run: pip install openai")
        
        response = openai.ChatCompletion.create(
            model=self.model,
            messages=[
                {"role": "system", "content": self._get_system_prompt()},
                {"role": "user", "content": prompt}
            ],
            max_tokens=4096,
            timeout=self.timeout,
        )
        
        return response.choices[0].message.content

    def _get_system_prompt(self) -> str:
        """获取系统提示词"""
        return """You are an expert Verse programmer for UEFN (Unreal Editor for Fortnite).
You follow the SceneGraph Entity-Component-Event architecture strictly.
You always output structured JSON when required.
You write clean, well-documented code with proper error handling."""

    def _parse_structured_output(self, output: str, expected_type: str) -> dict:
        """解析结构化JSON输出"""
        # 尝试从输出中提取JSON
        try:
            # 查找 JSON 块
            import re
            json_match = re.search(r'```json\s*([\s\S]*?)\s*```', output)
            if json_match:
                return json.loads(json_match.group(1))
            
            # 尝试直接解析
            return json.loads(output)
        except json.JSONDecodeError:
            # 返回默认结构
            return self._get_default_structure(expected_type, output)

    def _get_default_structure(self, expected_type: str, raw_output: str) -> dict:
        """获取默认的结构化输出"""
        if expected_type == "coding":
            return {
                "task_id": "",
                "agent": "coding",
                "compile_attempts": 0,
                "compile_success": False,
                "errors": [],
                "should_update_handbook": False,
                "raw_output": raw_output,
            }
        elif expected_type.startswith("reviewer"):
            return {
                "task_id": "",
                "agent": expected_type,
                "verdict": "reject",
                "score": 5,
                "issues": [],
                "summary": "解析失败",
                "should_update_handbook": False,
                "raw_output": raw_output,
            }
        else:
            return {"raw_output": raw_output}

    def set_feedback_context(self, feedback: list):
        """设置反馈上下文（供下次编码使用）"""
        self.feedback_context = feedback

    def call_coding_agent(self, requirement: dict, handbook_context: str, task_id: str) -> dict:
        """调用编码Agent"""
        template = self._load_prompt_template("coding_agent")
        
        # 构建反馈部分
        feedback_section = ""
        if self.feedback_context:
            feedback_section = "\n## 上次评审反馈（请修复以下问题）\n\n"
            for fb in self.feedback_context:
                feedback_section += f"- **{fb.get('category', 'N/A')}**: {fb.get('description', '')}\n"
                if fb.get('suggested_fix'):
                    feedback_section += f"  建议: {fb['suggested_fix']}\n"
        
        prompt = f"""# 编码任务

## 任务ID
{task_id}

## 需求描述
{json.dumps(requirement, ensure_ascii=False, indent=2)}

## 战术手册（高频问题，请避免）
{handbook_context}
{feedback_section}
## 输出要求

1. 生成符合需求的 Verse 代码
2. 遵循 SceneGraph 分层架构
3. 最后输出结构化JSON报告:

```json
{{
  "task_id": "{task_id}",
  "agent": "coding",
  "compile_attempts": 0,
  "compile_success": false,
  "errors": [],
  "should_update_handbook": true/false
}}
```

{template}
"""
        
        output = self._call_agent(prompt)
        result = self._parse_structured_output(output, "coding")
        result["task_id"] = task_id
        result["raw_output"] = output
        
        # 清除反馈上下文
        self.feedback_context = []
        
        return result

    def call_review_agent(self, review_type: str, task_id: str) -> dict:
        """调用评审Agent"""
        template = self._load_prompt_template(f"reviewer_{review_type}")
        
        # 根据评审类型定义关注点
        focus_areas = {
            "utility": {
                "name": "实用性评审",
                "weight": "40%",
                "focus": [
                    "功能完整性 - 是否满足需求描述的所有功能点",
                    "边界处理 - 空值检查、范围验证、异常情况",
                    "API正确使用 - UEFN/Verse API 调用方式是否正确",
                    "性能考虑 - 是否有明显的性能问题",
                ],
            },
            "framework": {
                "name": "框架符合性评审",
                "weight": "40%",
                "focus": [
                    "分层规范 - Component不依赖Entity，Helper是纯函数",
                    "事件方向 - SendUp(子→父)、SendDown(父→子)使用正确",
                    "依赖方向 - 上层可依赖下层，下层不可依赖上层",
                    "职责划分 - 计算逻辑在Helper，状态管理在Component",
                ],
            },
            "quality": {
                "name": "代码质量评审",
                "weight": "20%",
                "focus": [
                    "命名规范 - 类名、变量名、函数名是否清晰",
                    "代码重复 - 是否有可提取的公共逻辑",
                    "职责单一 - 每个函数/类是否只做一件事",
                    "注释文档 - 关键逻辑是否有适当注释",
                ],
            },
        }
        
        review_info = focus_areas.get(review_type, focus_areas["quality"])
        
        prompt = f"""# {review_info['name']}

## 任务ID
{task_id}

## 权重
{review_info['weight']}

## 评审关注点
{chr(10).join(f"- {f}" for f in review_info['focus'])}

## 评审要求

1. 仔细审查当前分支的代码变更
2. 按照上述关注点逐项检查
3. 给出1-10分的评分
4. 列出发现的问题
5. 输出结构化JSON:

```json
{{
  "task_id": "{task_id}",
  "agent": "reviewer-{review_type}",
  "verdict": "approve" 或 "reject",
  "score": 1-10,
  "issues": [
    {{
      "category": "实用性/框架/质量",
      "subcategory": "具体子类",
      "severity": "critical/warning/info",
      "description": "问题描述",
      "location": "文件:行号",
      "suggested_fix": "建议修复方式",
      "root_cause_hint": "推测的根源原因"
    }}
  ],
  "summary": "一句话总结",
  "should_update_handbook": true/false
}}
```

## 评分标准
- 9-10: 优秀，无问题或仅有建议
- 7-8: 良好，有小问题但不影响功能
- 5-6: 及格，有明显问题需要修复
- 1-4: 不及格，有严重问题

## 通过条件
- 评分 >= 7 且无 critical 级别问题

{template}
"""
        
        output = self._call_agent(prompt)
        result = self._parse_structured_output(output, f"reviewer-{review_type}")
        result["task_id"] = task_id
        result["agent"] = f"reviewer-{review_type}"
        result["raw_output"] = output
        
        return result

    def call_fix_compile_errors(self, errors: list) -> str:
        """调用Agent修复编译错误"""
        prompt = f"""# 修复编译错误

## 编译错误列表
```json
{json.dumps(errors, ensure_ascii=False, indent=2)}
```

## 要求

1. 分析每个错误的原因
2. 修复代码中的问题
3. 确保修复不引入新问题

请直接修改代码文件。
"""
        
        return self._call_agent(prompt)

    def call_requirement_proposer(self) -> list:
        """调用需求生成Agent"""
        prompt = """# 生成新需求

请根据当前项目状态和代码库，生成3-5个新的功能需求。

## 要求

1. 需求应该是具体、可实现的
2. 需求应该符合当前项目的技术栈
3. 需求应该有明确的验收标准

## 输出格式

```json
{
  "requirements": [
    {
      "id": "REQ-XXX",
      "title": "需求标题",
      "description": "详细描述",
      "priority": 1-5,
      "acceptance_criteria": ["标准1", "标准2"]
    }
  ]
}
```
"""
        
        output = self._call_agent(prompt)
        result = self._parse_structured_output(output, "requirement")
        return result.get("requirements", [])

    def call_tactician(self, pending_reports: list) -> dict:
        """调用 Tactician 处理错误上报"""
        prompt = f"""# 战术手册维护任务

## 待处理上报
```json
{json.dumps(pending_reports, ensure_ascii=False, indent=2)}
```

## 任务

1. 分析每个错误/问题的根源
2. 检查是否与已有根源匹配
3. 归并相似问题或创建新根源
4. 更新对应的战术手册文件
5. 生成Git commit

## 输出

处理报告，包含:
- 归并统计
- 新增根源
- 更新的文件列表
"""
        
        output = self._call_agent(prompt)
        return {"raw_output": output}
