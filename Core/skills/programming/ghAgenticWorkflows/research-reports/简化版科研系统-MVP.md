# 简化版全自动化科研系统

> **版本**: 0.1.0 (MVP)  
> **日期**: 2026-01-04  
> **状态**: 可部署

---

## 1. 设计理念

**最小可行方案**：剔除所有复杂依赖，使用 GitHub 原生能力完成调研任务闭环。

### 1.1 核心简化

| 原方案 | 简化后 | 简化原因 |
|--------|--------|----------|
| Planner + Worker 双 Workflow | 仅 Planner | 减少维护成本 |
| repo-memory 分支存储 | 直接 PR 合并 | 避免分支初始化问题 |
| 定时触发 + Issue 触发 | 仅手动触发 | 先验证流程再自动化 |
| 自动循环迭代 | 单次任务 | 降低复杂度 |
| 自定义 Worker 调研 | Copilot 原生调研 | 利用现有能力 |

### 1.2 剔除的风险点

| 风险点 | 处理方式 |
|--------|----------|
| ❌ Memory 分支不存在 | 不使用 repo-memory，调研结果直接进 PR |
| ❌ Issue 无限重复触发 | 不使用 Issue 事件触发，仅手动触发 |
| ❌ Worker 并发写入冲突 | 没有 Worker，每次只创建 1 个任务 |
| ❌ Issue 状态管理复杂 | Copilot 完成后 PR 自动关联 Issue |
| ❌ MCP 工具依赖 | 不依赖外部 MCP，仅用 Copilot 内置能力 |

---

## 2. 架构设计

### 2.1 系统流程

```
┌─────────────────────────────────────────────────────────────┐
│                     简化版触发链                             │
└─────────────────────────────────────────────────────────────┘

    用户手动触发
    (workflow_dispatch)
          │
          │ 输入: topic, output_path
          ▼
    ┌─────────────┐
    │   Planner   │
    │  Workflow   │
    └──────┬──────┘
           │
           │ create-issue + assign-to-agent
           ▼
    ┌─────────────┐
    │   GitHub    │
    │    Issue    │
    │ [Research]  │
    └──────┬──────┘
           │
           │ Copilot 自动接收任务
           ▼
    ┌─────────────┐
    │   Copilot   │
    │   Agent     │
    └──────┬──────┘
           │
           │ 创建 PR（包含调研结果）
           ▼
    ┌─────────────┐
    │    Pull     │
    │   Request   │
    └──────┬──────┘
           │
           │ 人工 Review & Merge
           ▼
    ┌─────────────┐
    │    主分支   │
    │ docs/研究报告│
    └─────────────┘
```

### 2.2 文件结构

```
.github/
└── workflows/
    └── research-planner.md    # 唯一需要的 Workflow

docs/
└── research/                  # 调研结果输出目录
    ├── triggers.md            # 触发器调研
    ├── safe-outputs.md        # 安全输出调研
    └── ...                    # 更多调研报告
```

---

## 3. 使用方法

### 3.1 编译 Workflow

```bash
gh aw compile research-planner
```

### 3.2 运行调研任务

```bash
# 示例：调研 gh-aw 触发器类型
gh aw run research-planner \
  -f topic="GitHub Agentic Workflows 触发器类型" \
  -f output_path="docs/research/triggers.md"
```

### 3.3 查看结果

```bash
# 查看创建的 Issue
gh issue list --label research-task

# 查看 Copilot 创建的 PR
gh pr list --author @me
```

---

## 4. 能力边界

### 4.1 能做的事 ✅

| 能力 | 说明 |
|------|------|
| 创建结构化调研任务 | Issue 包含清晰的调研目标和输出要求 |
| 自动分配给 Copilot | 使用 assign-to-agent |
| Copilot 仓库内调研 | 搜索仓库代码和文档 |
| 自动创建 PR | Copilot 输出调研结果 |
| 人工审核合并 | 保证调研质量 |

### 4.2 不能做的事 ❌

| 限制 | 替代方案 |
|------|----------|
| 无法爬取外部网站 | 人工补充外部信息 |
| 无法搜索论文 | 在 Issue 中提供论文链接让 Copilot 读取 |
| 无法自动迭代 | 手动触发下一个任务 |
| 无法深度思考 | 拆分为多个小任务 |

---

## 5. 验证清单

首次使用前，验证以下内容：

### 5.1 前置条件

- [ ] 仓库已启用 GitHub Copilot
- [ ] 仓库已启用 GitHub Agentic Workflows
- [ ] 已安装 `gh aw` CLI 扩展
- [ ] 创建 `docs/research/` 目录

### 5.2 功能验证

```bash
# Step 1: 编译
gh aw compile research-planner

# Step 2: 运行测试任务
gh aw run research-planner \
  -f topic="测试任务 - 验证 Planner 功能" \
  -f output_path="docs/research/test.md"

# Step 3: 检查 Issue 是否创建成功
gh issue list --label research-task

# Step 4: 检查 Issue 是否分配给 Copilot
gh issue view <issue-number>

# Step 5: 等待 Copilot 创建 PR（通常 5-15 分钟）
gh pr list

# Step 6: 验证 PR 内容
gh pr view <pr-number>
```

---

## 6. 后续扩展路径

当基础流程验证通过后，可逐步添加：

| 阶段 | 扩展内容 | 复杂度 |
|------|----------|--------|
| **v0.2** | 添加定时触发 (`schedule`) | 低 |
| **v0.3** | 添加进度追踪 (`cache-memory`) | 中 |
| **v0.4** | 添加 MCP 工具 (Tavily) | 中 |
| **v0.5** | 添加自动迭代循环 | 高 |

---

## 7. 故障排除

| 问题 | 可能原因 | 解决方案 |
|------|----------|----------|
| Issue 未创建 | Workflow 编译失败 | 检查 `gh aw compile` 输出 |
| Issue 未分配给 Copilot | assign-to-agent 未触发 | 检查 safe-outputs 配置 |
| Copilot 未响应 | Copilot 未启用或排队中 | 检查仓库 Copilot 设置 |
| PR 内容不符合预期 | Issue 指令不够清晰 | 改进 Issue body 模板 |

---

## 8. Workflow 源码

文件路径：`.github/workflows/research-planner.md`

```yaml
---
name: Research Planner
description: 科研规划者 - 创建调研任务并分配给 Copilot 执行
on:
  workflow_dispatch:
    inputs:
      topic:
        description: '调研主题'
        required: true
        type: string
      output_path:
        description: '输出文件路径 (如 docs/research/xxx.md)'
        required: true
        type: string
permissions:
  contents: read
  issues: write
engine: claude
tools:
  github:
    toolsets: [issues, repos]
safe-outputs:
  create-issue:
    max: 1
    labels: [research-task, copilot-task]
    title-prefix: "[Research] "
    assignees: copilot
  assign-to-agent:
timeout-minutes: 10
strict: true
---

# Prompt Body (见完整文件)
```

---

> **下一步**: 运行验证清单，确认基础流程可用
