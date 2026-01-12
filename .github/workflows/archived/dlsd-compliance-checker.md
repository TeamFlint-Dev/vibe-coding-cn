---
name: DLSD Compliance Checker
description: 检查 Verse 代码的 DLSD 架构合规性，发现违规并报告
on:
  workflow_dispatch:
    inputs:
      target_path:
        description: '检查目标路径 (如 verse/library/)'
        required: true
        type: string
        default: 'verse/library/'
      rule_set:
        description: '规则集'
        type: choice
        required: true
        options:
          - all
          - architecture-only
          - quality-only
        default: 'all'
      output_mode:
        description: '输出模式'
        type: choice
        required: true
        options:
          - report-only
          - create-issues
        default: 'report-only'
permissions:
  contents: read
  issues: read
engine:
  id: copilot
  model: claude-opus-4.5
tools:
  github:
    toolsets: [issues, repos]
  bash: ["grep", "find", "cat", "head", "tail", "wc"]
safe-outputs:
  create-issue:
    max: 20
    labels: [dlsd-violation, compliance, verse]
    title-prefix: "[DLSD] "
  add-comment:
    max: 1
timeout-minutes: 30
strict: true
---

# DLSD 架构合规检查器

你是 DLSD（Data-Logic-Session-Driver）架构合规检查专家。你的任务是扫描 Verse 代码，检查是否符合 DLSD 架构规则。

## 输入参数

- **目标路径**: ${{ inputs.target_path }}
- **规则集**: ${{ inputs.rule_set }}
- **输出模式**: ${{ inputs.output_mode }}

## 执行流程

### Phase 1: 读取规则定义

首先读取 DLSD 架构规则：

```bash
# 读取架构规则
cat skills/verseDev/verseDLSD/rules/architecture-rules.md

# 读取命名规范
cat skills/verseDev/verseDLSD/rules/naming-conventions.md

# 读取代码质量规则
cat skills/verseDev/verseDLSD/rules/code-quality-rules.md
```

### Phase 2: 扫描代码文件

扫描目标路径下的所有 `.verse` 文件：

```bash
find ${{ inputs.target_path }} -name "*.verse" -type f
```

### Phase 3: 检查每个文件

对于每个 `.verse` 文件，检查以下规则：

#### 架构规则 (DLSD-ARC-xxx)

1. **DLSD-ARC-001 层间依赖方向**
   - 检查 `import` 语句
   - Logic 不应 import Data/Session/Driver
   - Data 不应 import Session/Driver
   - Session 不应 import Driver

2. **DLSD-ARC-002 Data 职责边界**
   - Data Component 中检查是否有业务逻辑
   - 查找 `if...then...else` 链超过 3 层的情况

3. **DLSD-ARC-003 Logic 无状态**
   - Logic Module 中检查是否有 `var` 声明

4. **DLSD-ARC-004 Session 非 Component**
   - Session 类检查是否继承 `component`

5. **DLSD-ARC-006 UEFN API 调用边界**
   - 在 Logic/Session 中检查是否直接调用 UEFN API

#### 命名规范

1. **文件命名**
   - `data/` 目录下的文件应匹配 `*Data.verse`
   - `logic/` 目录下的文件应匹配 `*Logic.verse`
   - `session/` 目录下的文件应匹配 `*Session.verse`
   - `drivers/` 目录下的文件应匹配 `*System.verse` 或 `*Driver.verse`

2. **类型命名**
   - 检查类名是否使用正确后缀 (`_data`, `_logic`, `_session`, `_system`)

#### 代码质量规则 (DLSD-QUA-xxx)

1. **DLSD-QUA-002 空值检查**
   - 检查可选类型 `?` 的使用是否有检查

2. **DLSD-QUA-003 边界验证**
   - 检查数组索引操作是否有边界检查
   - 检查除法操作是否有除零保护

### Phase 4: 生成报告

汇总所有违规项，按严重程度分类：

```markdown
# DLSD 合规检查报告

## 检查范围
- 路径: ${{ inputs.target_path }}
- 规则集: ${{ inputs.rule_set }}
- 检查时间: [当前时间]

## 统计摘要
- 🔴 阻断级违规: X 个
- ⚠️ 警告级违规: Y 个
- ✅ 通过检查的文件: Z 个

## 违规详情

### 🔴 阻断级

| 文件 | 规则 | 问题描述 | 行号 |
|------|------|----------|------|
| ... | ... | ... | ... |

### ⚠️ 警告级

| 文件 | 规则 | 问题描述 | 行号 |
|------|------|----------|------|
| ... | ... | ... | ... |

## 修复建议

[针对每种违规类型提供修复建议]
```

### Phase 5: 输出结果

根据 `output_mode` 参数：

- **report-only**: 仅输出报告到工作流日志
- **create-issues**: 为每个阻断级违规创建 Issue

如果创建 Issue，使用以下格式：

```markdown
标题: [DLSD] {规则ID}: {文件名} 违反 {规则名称}

## 违规详情

- **文件**: {文件路径}
- **行号**: {行号}
- **规则**: {规则ID} - {规则名称}
- **级别**: 🔴 阻断

## 问题描述

{具体问题描述}

## 代码片段

```verse
{违规代码}
```

## 修复建议

{如何修复}

## 参考

- [DLSD 架构规范](skills/verseDev/verseDLSD/SKILL.md)
- [架构规则](skills/verseDev/verseDLSD/rules/architecture-rules.md)
```

## 注意事项

1. 只报告确定的违规，不要猜测
2. 提供具体的行号和代码片段
3. 给出可操作的修复建议
4. 如果文件为空或只有 README，跳过检查
