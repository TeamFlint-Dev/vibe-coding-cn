---
name: versePromptAuditor
description: Prompt审计执行层 - 根据检查清单审计Skill Prompt质量
version: 1.0.0
---

# Verse Prompt Auditor

> **类型**: 审计执行层（Audit Executor）  
> **职责**: 按检查清单审计 Skill Prompt，生成审计报告

---

## When to Use This Skill

由 `verseAuditDispatcher` 调度，不应被用户直接调用。

接收参数格式：
```markdown
---
audit_type: prompt
audit_depth: quick | standard | deep
audit_scope: all | [Skill名称列表]
forced: false
---
```

---

## 检查依据

**文件**: `shared/checklists/prompt-quality-checklist.md`

检查维度：
1. **职责清晰度** - 核心职责是否明确
2. **输入输出** - 期望输入/输出是否清晰
3. **示例完整性** - 是否有足够的示例
4. **边界定义** - 可变/不可变区域是否明确
5. **协作接口** - 与其他 Skill 的协作点是否定义

---

## 审计范围

### 自动模式（全部）

审计所有 Skill：

```
verseDev/
├── verseOrchestrator/SKILL.md
├── verseAuditDispatcher/SKILL.md
├── verseCodeAuditor/SKILL.md
├── versePromptAuditor/SKILL.md
├── verseFrameworkDesigner/SKILL.md  (L5)
├── verseEventFlow/SKILL.md          (L4)
├── verseComponent/SKILL.md           (L3)
├── verseHelpers/SKILL.md             (L2)
└── verseAssets/SKILL.md              (L1)
```

### 指定模式

仅审计用户指定的 Skill：

```markdown
用户: "审计 verseComponent 和 verseHelpers"
    ↓
scope: ["verseComponent", "verseHelpers"]
```

---

## 执行流程

### 快速模式 (quick)

```
列出所有 SKILL.md 文件
    ↓
检查文件是否存在
    ↓
检查必需章节是否存在
    ↓
输出结构摘要
```

### 标准模式 (standard)

```
遍历目标 SKILL.md 文件
    ↓
检查必需章节
    ↓
验证职责定义清晰度
    ↓
检查示例数量和质量
    ↓
输出详细报告
```

### 深度模式 (deep)

```
遍历目标 SKILL.md 文件
    ↓
逐章节深度分析
    ↓
检查跨 Skill 一致性
    ↓
验证协作接口匹配
    ↓
输出完整报告 + 改进建议
```

---

## 问题分级

| 级别 | 图标 | 说明 | 处理方式 |
|------|------|------|----------|
| **严重** | 🔴 | 核心职责缺失/冲突 | 必须立即修复 |
| **警告** | 🟡 | 定义不清晰/示例不足 | 建议尽快修复 |
| **建议** | 🔵 | 可优化但不影响使用 | 可延后处理 |

---

## 检查项详情

### 职责清晰度

#### PRM-001: 核心职责定义

**检查**: SKILL.md 必须有明确的职责声明

```markdown
# ❌ 缺失
[没有职责说明]

# ✅ 完整
> **类型**: 组件层（Layer 3）  
> **职责**: 编写 Component 类代码，管理状态和事件
```

#### PRM-002: 职责边界

**检查**: 明确"做什么"和"不做什么"

```markdown
# ❌ 模糊
"处理组件相关的事情"

# ✅ 清晰
**职责范围**:
- ✅ 状态变量管理
- ✅ 事件监听和派发
- ❌ 复杂计算逻辑（委托给 Helper）
- ❌ 直接调用 UEFN API（使用 Helper 封装）
```

### 输入输出

#### PRM-003: 期望输入

**检查**: 明确说明 Skill 需要什么信息

```markdown
# ❌ 缺失
[没有说明需要什么输入]

# ✅ 完整
**期望输入**:
- 组件名称和职责描述
- 需要管理的状态变量
- 需要响应的事件列表
- 参考架构文档 @architecture-blueprint.md
```

#### PRM-004: 输出格式

**检查**: 明确说明输出的格式和结构

```markdown
# ❌ 模糊
"输出组件代码"

# ✅ 清晰
**输出格式**:
```verse
[component_name] := class(component):
    # 状态变量
    var [VariableName]<private>:[Type] = [DefaultValue]
    
    # 生命周期
    OnBeginSimulation<override>()<suspends>:void = ...
    
    # 事件处理器
    On[EventName]<public>([Params]):[ReturnType] = ...
```

### 示例完整性

#### PRM-005: 示例数量

**检查**: 至少 2 个不同场景的示例

```markdown
# ❌ 不足
[只有 1 个简单示例]

# ✅ 充足
**示例 1**: 基础组件（无状态）
**示例 2**: 带状态管理的组件
**示例 3**: 带事件处理的组件
```

#### PRM-006: 示例质量

**检查**: 示例应该是可运行的完整代码

```markdown
# ❌ 片段
"使用 var 声明变量"

# ✅ 完整
```verse
health_component := class(component):
    @editable var MaxHealth:int = 100
    var CurrentHealth<private>:int = 0
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        set CurrentHealth = MaxHealth
```

### 协作接口

#### PRM-007: 上下游关系

**检查**: 明确与其他 Skill 的协作关系

```markdown
# ❌ 孤立
[没有说明与其他 Skill 的关系]

# ✅ 完整
**上游依赖**:
- `verseFrameworkDesigner`: 提供架构设计
- `verseEventFlow`: 提供事件定义

**下游服务**:
- 为 `verseHelpers` 提供需求下沉请求
```

#### PRM-008: 接口格式

**检查**: 与其他 Skill 的数据交换格式一致

```markdown
# ❌ 不一致
[输出格式与下游期望不匹配]

# ✅ 一致
**下沉请求格式**:
```markdown
需要 Helper 函数:
- 名称: CalculateDamage
- 输入: (BaseDamage:int, Armor:int)
- 输出: int
- 用途: 计算护甲减免后的伤害
```

---

## 报告格式

```markdown
# Prompt 审计报告

**审计时间**: 2025-12-27 14:30
**审计深度**: 标准
**审计范围**: 全部 (9 个 Skill)

## 统计摘要

| 级别 | 数量 |
|------|------|
| 🔴 严重 | 0 |
| 🟡 警告 | 3 |
| 🔵 建议 | 5 |

## Skill 状态总览

| Skill | 状态 | 问题数 |
|-------|------|--------|
| verseOrchestrator | ✅ | 0 |
| verseComponent | ⚠️ | 2 |
| verseHelpers | ⚠️ | 1 |
| ... | ... | ... |

## 警告问题 (建议修复)

### [PRM-005] verseComponent
**问题**: 示例数量不足
**当前**: 1 个示例
**建议**: 添加带事件处理的组件示例

### [PRM-007] verseHelpers
**问题**: 上下游关系未明确
**建议**: 添加与 verseComponent 的协作说明

...

## 建议改进

### [PRM-006] verseEventFlow
**问题**: 示例缺少注释
**建议**: 为示例代码添加行内注释

...

## 跨 Skill 一致性检查

| 检查项 | 结果 |
|--------|------|
| 术语一致性 | ✅ |
| 格式规范一致性 | ✅ |
| 协作接口匹配 | ⚠️ 发现 1 处不匹配 |

## 下一步行动

1. 修复 verseComponent 示例不足问题
2. 补充 verseHelpers 协作说明
3. 解决协作接口不匹配问题
```

---

## 与改进模式联动

当审计发现系统性问题时：

```
问题模式: 多个 Skill 缺少相同类型的定义
    ↓
推断: 可能需要制定统一的 Skill 编写规范
    ↓
建议: 
1. 记录到 @issues-collected.md
2. 创建 Skill 编写模板
    ↓
触发改进模式处理
```

---

## Reference Files

- [verseAuditDispatcher](../verseAuditDispatcher/SKILL.md) - 调度层
- [prompt-quality-checklist](../shared/checklists/prompt-quality-checklist.md) - Prompt质量检查清单
- [evolution-logs/](../shared/evolution-logs/) - 问题收集和变更日志

---

*最后更新: 2025-12-27*
