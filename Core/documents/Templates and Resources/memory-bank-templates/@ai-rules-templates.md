# AI 规则模板

> **用途**：为项目配置 AI 行为规则，确保 AI 助手遵循项目约定  
> **适用**：所有使用 AI 辅助开发的项目

---

## 目录结构

```
your-project/
├── AGENTS.md              # 通用 AI Agent 规则（GitHub Copilot 等）
├── CLAUDE.md              # Claude 专用规则
├── GEMINI.md              # Gemini 专用规则（可选）
└── .cursorrules           # Cursor 专用规则（可选）
```

---

## 模板文件

### AGENTS.md 模板

```markdown
# AGENTS.md

## 项目概述

[简要描述项目是什么、做什么]

## 技术栈

- **语言**：[语言]
- **框架**：[框架]
- **核心架构**：[架构模式]

## 代码风格

### 命名约定

- 类/模块：`PascalCase`
- 函数/方法：`camelCase` 或 `snake_case`
- 常量：`UPPER_SNAKE_CASE`
- 文件：`kebab-case` 或 `snake_case`

### 禁止事项

- ❌ [禁止事项 1]
- ❌ [禁止事项 2]
- ❌ [禁止事项 3]

### 必须遵守

- ✅ [必须事项 1]
- ✅ [必须事项 2]
- ✅ [必须事项 3]

## 文件组织

```
src/
├── [目录说明]
├── [目录说明]
└── [目录说明]
```

## 关键文件

| 文件 | 用途 |
|------|------|
| [文件路径] | [说明] |
| [文件路径] | [说明] |

## 工作流程

1. [步骤 1]
2. [步骤 2]
3. [步骤 3]

## 测试

- 测试框架：[框架]
- 运行命令：`[命令]`
- 覆盖率要求：[百分比]

## 常用命令

```bash
# 构建
[命令]

# 运行
[命令]

# 测试
[命令]

# 检查
[命令]
```
```

---

### CLAUDE.md 模板

```markdown
# CLAUDE.md

This file provides guidance to Claude when working with code in this repository.

## Project Overview

[Brief description of the project]

## Key Commands

```bash
# Build
[command]

# Run
[command]

# Test
[command]
```

## Architecture

[Key architectural decisions and patterns]

## Always Rules

When working on this project, Claude should ALWAYS:

1. [Rule 1 - e.g., "Use Component-ization boundary principle: if can be componentized, use SceneGraph"]
2. [Rule 2 - e.g., "Follow existing naming conventions"]
3. [Rule 3 - e.g., "Keep functions under 50 lines"]
4. [Rule 4 - e.g., "Add tests for new functionality"]

## Never Rules

Claude should NEVER:

1. [Rule 1 - e.g., "Never modify files in /vendor"]
2. [Rule 2 - e.g., "Never hardcode configuration values"]
3. [Rule 3 - e.g., "Never bypass type checking"]

## Code Patterns

### Preferred Pattern

```[language]
// Example of preferred code pattern
[code example]
```

### Avoid This Pattern

```[language]
// Example of what to avoid
[code example]
```

## File Organization

- `[directory]/` - [purpose]
- `[directory]/` - [purpose]
- `[directory]/` - [purpose]

## Development Workflow

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Context Documents

Before starting development, read:

- [path/to/doc1] - [purpose]
- [path/to/doc2] - [purpose]
```

---

## 使用指南

### 1. 复制模板

将上述模板复制到项目根目录，并根据项目实际情况填写。

### 2. 关键配置点

#### Always/Never 规则

这是最重要的部分，用于约束 AI 行为：

```markdown
## Always Rules

1. Apply Component-ization boundary principle (see R00 report)
2. Components communicate only through Scene Events
3. Each file should be under 300 lines
4. Run `make lint` before committing

## Never Rules

1. Never access components directly (use events)
2. Never hardcode game balance values
3. Never modify files in /references
```

#### 代码模式示例

提供具体的代码示例帮助 AI 理解期望的风格：

```markdown
### Preferred: Event-based Communication

```verse
# 正确：通过事件通信
ParentEntity.SendUp(item_collected_event:
    Player := Player
    Item := Item
)
```

### Avoid: Direct References

```verse
# 错误：直接引用其他组件
OtherComponent.DoSomething()  # ❌ 不要这样做
```
```

### 3. Memory-bank 集成

在 CLAUDE.md 中引用 memory-bank 文档：

```markdown
## Context Documents

Before starting development, read these memory-bank files:

- `memory-bank/@game-design-document.md` - Game design and core loop
- `memory-bank/@tech-stack.md` - Technology decisions and constraints
- `memory-bank/@architecture.md` - System architecture and data flow
- `memory-bank/@implementation-plan.md` - Current tasks and priorities
- `memory-bank/@progress.md` - Project status and blockers
```

---

## 示例：UEFN 项目的 CLAUDE.md

```markdown
# CLAUDE.md

This file provides guidance to Claude when working with this UEFN island game project.

## Project Overview

A UEFN-based idle/collection game where players fish for items, display them in slots to earn passive income, and use earnings to unlock more slots.

## Key Commands

```bash
# No CLI commands - use UEFN editor
# Verse files are in: Content/Verse/
```

## Architecture

- **Pattern**: SceneGraph (Entity-Component-Event)
- **Boundary Principle**: Component-ization boundary (if can be componentized → use SceneGraph)
- **Communication**: Scene Events (SendUp/SendDown/SendDirect)
- **Data Flow**: Unidirectional, event-driven

## Always Rules

1. **Apply Component-ization boundary principle** - Check R00-SceneGraph-Device-Boundary report
2. **Components communicate only through Scene Events** - Never direct references
3. **Each component has single responsibility** - Split if doing multiple things
4. **Follow existing naming conventions** - `snake_case` for entities/components
5. **Keep files under 300 lines** - Split into multiple components if needed
6. **Reference item_config.verse for all items** - No inline item definitions
7. **Use constants from constants.verse** - No hardcoded values

## Never Rules

1. **Never violate Component-ization boundary** - Use Device for non-componentizable features
2. **Never access components directly** - Use events for communication
3. **Never hardcode game balance values** - Put them in constants.verse
4. **Never modify existing events** - Add new events instead
5. **Never put business logic in entities** - Logic goes in components

## Code Patterns

### Preferred: Event-based State Change

```verse
# Component sends event up to parent
PlaceItem(Item:item_type)<transacts>:void =
    set CurrentItem = option{Item}
    if (ParentEntity := GetParentEntity[]):
        ParentEntity.SendUp(display_slot_updated_event:
            SlotIndex := SlotIndex
            NewItem := CurrentItem
        )
```

### Avoid: Direct Component Access

```verse
# DON'T DO THIS
UpdateSlot():void =
    DisplaySystem.Slots[0].CurrentItem := Item  # ❌ Direct access
```

## File Organization

- `Entities/` - Scene graph nodes (containers)
- `Components/` - Behavior and data (attach to entities)
- `Events/` - Scene event definitions
- `Data/` - Data structures and configurations
- `Utils/` - Helper functions and constants

## Context Documents

Before starting development, read:

- `memory-bank/@game-design-document.md` - Core loop and item design
- `memory-bank/@tech-stack.md` - SceneGraph constraints
- `memory-bank/@architecture.md` - Entity hierarchy and events
- `memory-bank/@implementation-plan.md` - Current phase and tasks
- `memory-bank/@progress.md` - What's done, what's blocked
```

---

## 最佳实践

1. **保持简洁**：规则应该清晰易懂，不要过于冗长
2. **具体优于抽象**：提供代码示例比纯文字描述更有效
3. **优先级明确**：Always/Never 规则应该涵盖最重要的约束
4. **定期更新**：随着项目演进更新规则文档
5. **与 memory-bank 配合**：规则文件定义行为，memory-bank 提供上下文
