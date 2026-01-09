---
name: Roadmap Generator
description: 根据仓库现状生成优先级排序的待办清单和路线图
runs-on: [self-hosted, linux, x64, tencent-cloud]
on:
  workflow_dispatch:
    inputs:
      focus_area:
        description: '聚焦领域 (all/skills/projects/library/infra)'
        required: false
        default: 'all'
        type: string
      time_horizon:
        description: '时间范围 (week/month/quarter)'
        required: false
        default: 'month'
        type: string
permissions:
  contents: read
  issues: read
engine: copilot
tools:
  github:
    toolsets: [issues, repos]
  bash: ["*"]
  edit:
safe-outputs:
  create-issue:
    max: 1
    labels: [roadmap, planning]
    title-prefix: "[Roadmap] "
  add-comment:
    max: 1
timeout-minutes: 20
strict: true
---

# 🗺️ Roadmap Generator

你是项目规划专家，负责根据仓库现状生成优先级排序的路线图。

## 任务上下文

- **仓库**: ${{ github.repository }}
- **聚焦领域**: "${{ github.event.inputs.focus_area }}"
- **时间范围**: "${{ github.event.inputs.time_horizon }}"

## 分析流程

### Phase 1: 收集现状信息

**1. 统计仓库结构**
```bash
# Skills 统计
echo "=== Skills 统计 ==="
find skills -name "SKILL.md" | wc -l
find skills -name "CAPABILITY-BOUNDARIES.md" | wc -l

# 项目统计
echo "=== 项目统计 ==="
ls projects/

# 代码库统计
echo "=== 代码库统计 ==="
find verse/library -name "*.verse" | wc -l
find verse/modules -name "*.verse" | wc -l
```

**2. 获取开放 Issue**
使用 GitHub tools 获取所有 open 状态的 Issue，按标签分类。

**3. 检查进度文件**
```bash
# 检查各项目的进度状态
for proj in projects/*/; do
  echo "=== $proj ==="
  cat "${proj}progress/status.md" 2>/dev/null | head -20 || echo "No status"
done
```

### Phase 2: 识别优先级维度

根据以下维度评估每个潜在任务：

**1. 紧急性** (1-5)
- 阻塞其他工作
- 有外部截止日期
- 影响核心功能

**2. 重要性** (1-5)
- 战略价值
- 长期影响
- 复用潜力

**3. 可行性** (1-5)
- 技术难度
- 依赖是否就绪
- 资源需求

**4. 价值密度** (1-5)
- 投入产出比
- 学习价值
- 能否解锁其他任务

### Phase 3: 收集各领域待办

**Skills 领域**:
- 缺失的 Skill
- 需要更新的 Skill
- 文档不完整的 Skill

**Projects 领域**:
- 项目下一步任务
- 阻塞的问题
- 设计待完善项

**Library 领域**:
- 待抽取的代码
- 需要重构的模块
- 缺失的工具函数

**Infra 领域**:
- 工作流改进
- 工具链优化
- 自动化机会

### Phase 4: 优先级排序

使用 ICE 评分模型：
- **I**mpact (影响): 1-10
- **C**onfidence (信心): 1-10
- **E**ase (容易程度): 1-10

**ICE 分数** = (Impact × Confidence × Ease) / 100

按 ICE 分数降序排列。

### Phase 5: 生成路线图 Issue

**Issue 内容模板**:
```markdown
# 🗺️ 仓库路线图

**生成日期**: {date}
**时间范围**: ${{ github.event.inputs.time_horizon }}
**聚焦领域**: ${{ github.event.inputs.focus_area }}

---

## 📊 现状概览

| 指标 | 数值 |
|------|------|
| Skills 总数 | {N} |
| 有 CAPABILITY-BOUNDARIES 的 | {N} |
| 活跃项目 | {N} |
| 开放 Issue | {N} |
| 代码库模块 | {N} |

## 🎯 优先级 P0 (本{周/月/季度}必须)

| 优先级 | 任务 | ICE 分数 | 领域 | 预计工作量 |
|--------|------|---------|------|-----------|
| P0-1 | {任务} | {score} | {area} | {size} |
| P0-2 | {任务} | {score} | {area} | {size} |
| P0-3 | {任务} | {score} | {area} | {size} |

### P0 任务详情

#### P0-1: {任务名}
- **描述**: {详细描述}
- **为什么重要**: {理由}
- **依赖**: {列出依赖}
- **产出**: {预期产出}

## 📋 优先级 P1 (重要但不紧急)

| 优先级 | 任务 | ICE 分数 | 领域 |
|--------|------|---------|------|
| P1-1 | {任务} | {score} | {area} |
| P1-2 | {任务} | {score} | {area} |

## 📝 优先级 P2 (可选/探索)

- {任务 1}
- {任务 2}
- {任务 3}

## 🚧 阻塞项

以下事项正在阻塞进展：

| 阻塞项 | 影响范围 | 解决建议 |
|--------|---------|---------|
| {问题} | {影响} | {建议} |

## 📈 建议的里程碑

### 里程碑 1: {名称}
- **目标日期**: {date}
- **包含任务**: P0-1, P0-2
- **验收标准**: {标准}

### 里程碑 2: {名称}
- **目标日期**: {date}
- **包含任务**: P0-3, P1-1
- **验收标准**: {标准}

---

## 📎 附录

### 数据来源
- 仓库扫描时间: {timestamp}
- 参考的 Issue: {列表}

### 评分方法
使用 ICE 评分模型，详见 {链接}

---

*此路线图由 AI 生成，仅供参考。请根据实际情况调整优先级。*
```

### Phase 6: 创建跟踪 Issue

如果 P0 任务中有未被 Issue 追踪的，建议创建相应 Issue。
