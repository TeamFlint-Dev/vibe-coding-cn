---
# 测试：多阶段流水线模拟
# 目的：验证单个 Agent 能否执行多阶段任务

on:
  workflow_dispatch:
    inputs:
      source_url:
        description: '信息源 URL（用于测试采集阶段）'
        required: false
        type: string
        default: 'https://github.com/anthropics/courses'
      target_skill:
        description: '目标 Skill 名称'
        required: false
        type: string
        default: 'claudeCourse'

permissions:
  contents: read
  issues: read

tools:
  bash: [":*"]
  edit:
  github:
    toolsets: [repos, issues]
  web-fetch:

engine:
  id: claude
  max-turns: 20  # 允许更多轮对话

safe-outputs:
  create-issue:
    max: 3
  add-comment:
    max: 5

---

# 多阶段知识蒸馏测试

这是一个测试工作流，验证单个 Agent 能否模拟多阶段流水线执行。

## 流水线阶段定义

你需要按顺序执行以下阶段，每个阶段完成后输出状态报告：

### 阶段 1: 采集 (Ingest)

**输入**: `${{ inputs.source_url }}`
**任务**:
1. 使用 web-fetch 获取目标 URL 的内容概览
2. 如果是 GitHub 仓库，列出其主要文件结构
3. 识别可用于 Skill 提取的内容类型

**输出**: 创建文件 `/tmp/gh-aw/stage1-ingest.json`，包含：
```json
{
  "stage": "ingest",
  "status": "success|failed",
  "source": "...",
  "content_types": ["api_docs", "tutorials", "examples"],
  "file_count": 10,
  "notes": "..."
}
```

**质检**: 如果内容为空或无法访问，标记 `status: failed` 并停止。

### 阶段 2: 分类 (Classify)

**输入**: 阶段 1 的输出
**任务**:
1. 根据内容类型，判断适合提取的 Skill 类型
2. 评估内容质量和数量是否足够

**输出**: 更新 `/tmp/gh-aw/stage2-classify.json`

**质检**: 如果内容不足以形成 Skill（少于 3 个模式），回退到阶段 1 建议补充更多信息源。

### 阶段 3: 提取 (Extract)

**输入**: 阶段 2 的分类结果
**任务**:
1. 从内容中提取 5-10 个可复用的模式/代码片段
2. 为每个模式编写简短描述

**输出**: `/tmp/gh-aw/stage3-extract.json`，包含 patterns 数组

**质检**: 模式数量 < 3 则失败

### 阶段 4: 组装 (Assemble)

**输入**: 阶段 3 的模式列表
**任务**:
1. 根据模式生成 SKILL.md 的草稿
2. 包含必要章节：When to Use, Quick Reference, Examples

**输出**: `/tmp/gh-aw/stage4-skill-draft.md`

### 阶段 5: 报告 (Report)

**任务**:
1. 汇总所有阶段的执行结果
2. 创建一个 Issue 报告整个流程的执行情况
3. 标题格式：`[Pipeline Test] Skills蒸馏测试 - {target_skill}`

## 执行规则

1. **顺序执行**: 必须按 1→2→3→4→5 顺序执行
2. **阶段回退**: 如果某阶段质检失败，在报告中说明原因和建议
3. **状态追踪**: 每个阶段结束时输出 `[STAGE N COMPLETE]` 或 `[STAGE N FAILED]`
4. **最终报告**: 无论成功失败，都要完成阶段 5 的报告

## 开始执行

请从阶段 1 开始，按上述定义执行流水线。
