---
name: Project Next Step
description: 根据项目当前状态，分析并建议下一步开发任务
on:
  workflow_dispatch:
    inputs:
      project_name:
        description: '项目名称 (如 trophyFishing)'
        required: true
        type: string
permissions:
  contents: read
  issues: read
engine:
  id: copilot
  model: claude-sonnet-4
tools:
  github:
    toolsets: [issues, repos]
  bash: ["*"]
  edit:
safe-outputs:
  create-issue:
    max: 3
    labels: [project-task, next-step]
    title-prefix: "[Next Step] "
  add-comment:
    max: 1
timeout-minutes: 15
strict: true
---

# 🚀 Project Next Step Advisor

你是项目进度分析专家，负责根据项目当前状态建议下一步任务。

## 任务上下文

- **仓库**: ${{ github.repository }}
- **项目名称**: "${{ github.event.inputs.project_name }}"
- **项目路径**: `projects/${{ github.event.inputs.project_name }}/`

## 分析流程

### Phase 1: 读取项目状态

```bash
# 读取项目进度状态
cat "projects/${{ github.event.inputs.project_name }}/progress/status.md" 2>/dev/null || echo "No status file found"

# 列出项目文档结构
find "projects/${{ github.event.inputs.project_name }}" -name "*.md" | head -20
```

### Phase 2: 分析设计文档完成度

检查设计阶段文档：
- `design/concept.md` - 概念设计
- `design/systems.md` - 系统设计
- `design/mechanics/` - 机制设计
- `design/economy.md` - 经济设计

```bash
# 检查设计文档
ls -la "projects/${{ github.event.inputs.project_name }}/design/"
```

### Phase 3: 分析架构文档完成度

检查技术架构：
- `architecture/tech-stack.md` - 技术栈
- `architecture/implementation-plan.md` - 实施计划
- `architecture/` 其他架构文档

```bash
# 检查架构文档
ls -la "projects/${{ github.event.inputs.project_name }}/architecture/" 2>/dev/null || echo "No architecture folder"
```

### Phase 4: 查找相关 Issue

查找与该项目相关的现有 Issue：

使用 GitHub tools 搜索：
- 标签包含项目名的 Issue
- 标题包含项目名的 Issue
- 状态为 open 的相关 Issue

### Phase 5: 确定项目当前阶段

根据文档完成度判断项目处于哪个阶段：

```
概念阶段 → 系统设计阶段 → 机制设计阶段 → 技术规划阶段 → 实施阶段 → 测试阶段
```

### Phase 6: 生成下一步建议

根据当前阶段，创建 1-3 个具体的下一步任务 Issue：

**Issue 内容模板**:
```markdown
## 项目

${{ github.event.inputs.project_name }}

## 当前阶段

{阶段名称}

## 任务描述

{具体要做什么}

## 前置条件

- [ ] {需要先完成的事项}

## 预期产出

- {产出文件或成果}

## 相关 Skill

- 建议使用: {Skill 名称及路径}

## 参考资料

- {相关文档链接}
```

### Phase 7: 优先级排序

如果有多个建议任务，按以下维度排序：
1. 依赖关系（被依赖的先做）
2. 阻塞程度（阻塞其他任务的先做）
3. 复杂度（简单的先做，快速产出价值）
