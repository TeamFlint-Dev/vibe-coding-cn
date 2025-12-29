---
name: verse-orchestrator
description: UEFN Verse 代码编写协调器 - 任务调度、模式管理、进度追踪、自进化触发
version: 2.0.0
---

# Verse Orchestrator

> **类型**: 协调器（Orchestrator）  
> **职责**: 任务流程管理、模式切换、子Skill调度、进度追踪、自进化触发

---

## When to Use This Skill

当用户需要：
- 编写 UEFN Verse 代码
- 设计游戏架构
- 实现游戏功能
- 扩充 Verse 代码库
- 优化 Skill 效果

---

## 五种运行模式

### 1. 循环迭代模式 (Iteration Mode)

**目的**: 自主积累通用代码库

**工作流程**:
```
读取 @pending-requirements.md
    ↓
选择优先级最高的需求
    ↓
调度各层Skill实现
    ↓
将代码加入 @code-library.md
    ↓
循环（直到用户中断）
```

**触发方式**:
```markdown
"使用循环迭代模式"
"进入迭代模式"
```

**输出**:
- 扩充后的 `@code-library.md`
- 更新的 `@pending-requirements.md`

---

### 2. 架构设计模式 (Architecture Mode)

**目的**: 对话式框架设计，确定高质量架构

**工作流程**:
```
与用户对话，理解需求
    ↓
调用 verse-framework-designer
    ↓
输出初版架构 @architecture-blueprint.md
    ↓
使用架构检查清单验证
    ↓
发现问题，请求用户改进方向
    ↓
迭代优化架构
```

**触发方式**:
```markdown
"使用架构设计模式"
"进入架构模式"
"帮我设计游戏架构"
```

**对话要点**:
1. Entity 层级结构是否合理？
2. Component 职责是否单一？
3. 事件流向是否清晰？
4. 是否预留扩展点？

---

### 3. 分层执行模式 (Layered Execution Mode)

**目的**: 大型任务分段执行，支持跨对话恢复

**工作流程**:
```
检测 @checkpoint.md 是否存在
    ↓
存在 → 提供恢复选项列表
不存在 → 创建新任务
    ↓
分解需求到各层
    ↓
生成上下文注入内容
    ↓
在每层完成时保存检查点
    ↓
用户可开新对话恢复
```

**触发方式**:
```markdown
"使用分层执行模式"
"继续之前的工作"
```

**检查点格式** (见 `@checkpoint.md`):
```markdown
## 检查点信息
- 项目: 塔防游戏
- 当前层级: Layer 3 (组件层)
- 任务状态: 进行中
- 进度: 3/5 组件已完成

## 待完成项
- [ ] attack_component
- [ ] upgrade_component

## 依赖文件
- @architecture-blueprint.md
- @events-map.md

## 恢复指令
继续实现 attack_component，参考 @architecture-blueprint.md 中的设计
```

---

### 4. 对话/自动切换 (Interactive/Auto Mode)

**目的**: 灵活控制实现细节

**对话模式**:
- 每个决策点暂停确认
- 显示可选方案
- 等待用户选择

**自动模式**:
- 使用默认最佳实践
- 仅在关键点暂停
- 快速完成任务

**切换方式**:
```markdown
"切换到对话模式"  # 精细控制
"切换到自动模式"  # 快速执行
```

---

### 5. 改进模式 (Evolution Mode)

**目的**: Skill自进化，持续优化效果

### 改进模式核心原则【重要】

> ⚠️ 改进模式的产出是 **Skill Prompt 的修改**，不是代码文件

**改进模式 vs 循环迭代模式**:

| 模式 | 主要产出 | 目标 |
|------|----------|------|
| 循环迭代 | 代码库中的 `.verse` 文件 | 积累可复用代码 |
| **改进模式** | **SKILL.md 文件的修改** | **优化 Agent 行为** |

**改进类型识别**:

| 问题类型 | 改进目标 | 变更记录 |
|----------|----------|----------|
| Skill 行为不当 | 修改 `SKILL.md` | `@prompt-changelog.md` |
| 检查依据不足 | 修改 `checklists/*.md` | `@checklist-changelog.md` |
| 两者都需要 | 先 Skill，再检查依据 | 分别记录 |

**工作流程**:
```
读取 @issues-collected.md
    ↓
分析问题模式
    ↓
识别改进类型 (Skill Prompt / 检查依据 / 两者)
    ↓
【必须】修改相关 SKILL.md 或 checklist 文件
    ↓
【可选】创建参考代码文件作为示例
    ↓
记录到对应 changelog
```

**执行检查清单**:
- [ ] 是否已修改相关 `SKILL.md` 文件？
- [ ] 是否已修改相关 `checklist` 文件？（如适用）
- [ ] 是否已更新 `@prompt-changelog.md`？
- [ ] 是否已更新 `@checklist-changelog.md`？（如适用）

**触发方式**:
- **累积触发**: 问题数量 ≥ 5 时提示用户
- **主动触发**: 用户说"进入改进模式"

**安全边界**:
```
┌─────────────────────────────────────┐
│ 不可变区 (禁止修改)                  │
│ - 核心职责定义                       │
│ - 输出格式规范                       │
│ - 层间协议                           │
├─────────────────────────────────────┤
│ 可变区 (允许修改)                    │
│ - 示例代码                           │
│ - 检查项列表                         │
│ - 提示语气和措辞                     │
│ - 最佳实践建议                       │
└─────────────────────────────────────┘
```

---

### 6. 审计模式 (Audit Mode)

**目的**: 主动发现代码库和 Skill Prompt 中的质量问题

**模式入口**: 识别审计意图后，调度 `verse-audit-dispatcher` 处理

**触发方式**:
```markdown
"进入审计模式"
"审计代码库"
"检查代码质量"
"审计 Skill"
"检查 Prompt 质量"
```

**调度流程**:
```
用户触发审计
    ↓
识别审计类型意图 (代码/Prompt/两者)
    ↓
调度 verse-audit-dispatcher
    ↓
dispatcher 解析深度和范围
    ↓
调度具体审计 Skill 执行
    ↓
汇总报告，与用户交互
```

**强制审计阻断**:
当检测到以下严重框架违规时，**必须完成审计才能继续编码**：
- 🔴 跨层依赖反转（如 Component 依赖 Entity）
- 🔴 Component 直接调用 UEFN API（绕过 Helper）
- 🔴 事件流向违规（子向父用 SendDown）

详细配置见 [verse-audit-dispatcher](../verse-audit-dispatcher/SKILL.md)

---

## 任务调度决策树

```
启动协调器
    │
    ├── 检测 @checkpoint.md 存在？
    │   ├── 是 → 显示恢复选项列表
    │   │       用户选择：恢复 / 新建
    │   └── 否 → 继续
    │
    ├── 检测强制审计条件？
    │   ├── 是 → 阻断！调度 verse-audit-dispatcher
    │   │       完成审计后才能继续
    │   └── 否 → 继续
    │
    ├── 用户指定模式？
    │   ├── 是 → 进入指定模式
    │   └── 否 → 询问需求，推荐模式
    │
    ├── 根据模式执行
    │   ├── 循环迭代 → 读取需求文档 → 逐个实现
    │   ├── 架构设计 → 对话确认 → 调用框架设计层
    │   ├── 分层执行 → 分解任务 → 逐层调度
    │   ├── 对话/自动 → 根据设置决定交互粒度
    │   ├── 改进模式 → 分析问题 → 调整Prompt/Checklist
    │   └── 审计模式 → 调度 verse-audit-dispatcher
    │
    └── 任务完成
        ├── 询问是否更新Memory-Bank模板
        └── 检查是否触发改进模式阈值
```

---

## 子Skill调度

### 架构层级（六层架构）

```
┌─────────────────────────────────────────────────────────────┐
│  Layer 5: 框架设计层 (verse-framework-designer)              │
│  └── Entity树、Component清单、事件流图、依赖关系             │
├─────────────────────────────────────────────────────────────┤
│  Layer 4: 事件流层 (verse-event-flow)                        │
│  └── Scene Event设计、事件传播策略、生命周期编排             │
├─────────────────────────────────────────────────────────────┤
│  Layer 3: 组件层 (verse-component)                           │
│  └── 自定义组件编写、Entity类封装、功能模块                  │
├─────────────────────────────────────────────────────────────┤
│  Layer 2: 操作层/Helper层 (verse-helpers)                   │
│  └── 纯函数计算(Calculator)、通用工具(Utils)、数据校验        │
├─────────────────────────────────────────────────────────────┤
│  Layer 1.5: Wrapper层 (verse-wrappers) 【新增】               │
│  └── 需求驱动的 UEFN API 封装，按业务域组织 digest API      │
├─────────────────────────────────────────────────────────────┤
│  Layer 1: 资产层 (verse-assets)                              │
│  └── Assets.digest解析、资产路径、占位接口                     │
└─────────────────────────────────────────────────────────────┘
```

### 调度顺序

```
verse-framework-designer (Layer 5)
    ↓ 输出 @architecture-blueprint.md
verse-event-flow (Layer 4)
    ↓ 输出事件定义代码
verse-component (Layer 3)
    ↓ 输出组件代码
    ↓ [可能触发下沉请求]
verse-helpers (Layer 2)
    ↓ 输出 Calculator/Utils/Validator
    ↓ [可能触发 Wrapper 请求]
verse-wrappers (Layer 1.5) 【新增】
    ↓ 输出 API 封装模块
verse-assets (Layer 1)
    ↓ 输出资产引用/占位接口
```

### 代码库分层查阅【CHANGE-003 新增】

> 代码库采用分层索引结构，避免一次加载全部内容

**查阅流程**:
```
1. 首先读取 @code-library-index.md（全局索引，<100行）
      ↓
2. 根据需要的类别，读取对应目录的 @index.md
      ↓
   ├── Helpers/@index.md    → 需要工具函数时
   ├── Components/@index.md → 需要组件模板时
   ├── Events/@index.md     → 需要事件定义时
   └── Entities/@index.md   → 需要Entity模板时
      ↓
3. 只有确定需要时，才读取具体 .verse 文件
```

**索引文件结构**:
```markdown
# @code-library-index.md（全局入口）
| 目录 | 说明 | 模块数 |
|------|------|--------|
| Helpers/ | 工具函数和API封装 | 8 |
| Components/ | 组件模板 | 12 |
...

# Helpers/@index.md（四类分类索引）
| 类别 | 模块 | 职责 | digest 校验 |
|------|------|------|-------------|
| Utils | MathUtils, VectorUtils, RandomUtils | 纯函数工具 | ❌ |
| Calculator | HealthCalculator, DamageCalculator | 公式计算 | ❌ |
| Wrapper | CharacterWrapper | UEFN API 封装 | ✅ 必须 |
| Validator | (待扩展) | 数据校验 | ⚠️ 按需 |
...
```

**为什么需要分层查阅**:
1. **避免上下文溢出**: 代码库可能有数千行，一次加载不现实
2. **按需加载**: 只读取当前任务真正需要的部分
3. **快速定位**: 通过索引快速找到目标模块

### Helper/Wrapper 与 Component 协作模式【CHANGE-005 更新】

> 调度 verse-component、verse-helpers 和 verse-wrappers 时需遵循的职责边界

```
┌─────────────────────────────────────────────────────────────────┐
│         Helper/Wrapper → Component 协作                        │
├─────────────────────────────────────────────────────────────────┤
│  verse-wrappers (L1.5) 职责:                                     │
│  ├── 直接封装 UEFN digest API                                   │
│  ├── 处理边界条件和类型转换                                   │
│  └── 统一错误处理，返回结构化结果                             │
├─────────────────────────────────────────────────────────────────┤
│  verse-helpers (L2) 职责:                                        │
│  ├── 纯计算 Helper (HealthCalculator, MovementCalculator...)    │
│  │   → 输入完整状态，返回计算结果，无副作用                       │
│  ├── 通用工具 (MathUtils, VectorUtils, ArrayUtils...)           │
│  └── 组合调用 Wrapper 实现高级操作                              │
├─────────────────────────────────────────────────────────────────┤
│  verse-component (L3) 职责:                                      │
│  ├── 状态管理 (var CurrentHealth, var IsActive)                 │
│  ├── 事件处理器 (OnReceiveDamage, OnCollision)                  │
│  ├── 真实对象绑定 (BoundCharacter, BoundWeapon)                 │
│  └── 事件派发 (Owner.SendUp(xxx_event{}))                       │
├─────────────────────────────────────────────────────────────────┤
│  调度原则:                                                       │
│  1. Component 不应包含复杂计算 → 委托给 Helper (Calculator)      │
│  2. Component 不应直接调用 UEFN API → 通过 Wrapper 层           │
│  3. Helper 不应持有状态 → 所有状态由 Component 管理              │
│  4. Helper 不应发送事件 → 事件由 Component 派发                │
│  5. Wrapper 不应包含业务逻辑 → 只做 API 封装                    │
└─────────────────────────────────────────────────────────────────┘
```

**调度检查清单**:

| 检查项 | 正确 | 错误 |
|--------|------|------|
| Component 计算逻辑 | 调用 Helper (Calculator) | 内含计算 |
| Component 调用 UEFN API | 通过 Wrapper | 直接调用 |
| Helper 状态 | 无状态变量 | 有 var 声明 |
| Helper 事件 | 无 SendUp/Down | 有事件派发 |
| Wrapper 逻辑 | 只做边界检查+API调用 | 包含业务计算 |

### 上下文注入模板

```markdown
---
项目: [项目名称]
当前阶段: [Layer X - 层名称]
任务: [具体任务描述]
---

## 项目上下文

### 架构大纲
[从 @architecture-blueprint.md 提取相关部分]

### 已完成内容
[列出已完成的组件/函数]

### 当前任务
[详细描述当前需要实现的内容]

### 约束条件
[任何需要遵守的约束]

---

请执行你的Skill职责。
```

---

## 进度追踪

### 进度文件: `@progress.md`

```markdown
# 项目进度

## 基本信息
- 项目: 塔防游戏
- 开始时间: 2025-12-27
- 当前状态: 进行中

## 层级进度

| 层级 | 状态 | 完成度 |
|------|------|--------|
| Layer 5 框架设计 | ✅ 完成 | 100% |
| Layer 4 事件流 | 🔄 进行中 | 60% |
| Layer 3 组件 | ⬜ 未开始 | 0% |
| Layer 2 操作 | ⬜ 未开始 | 0% |
| Layer 1 资产 | ⬜ 未开始 | 0% |

## 详细记录

### [2025-12-27] Layer 5: 框架设计
**状态**: ✅ 完成
**产出**: @architecture-blueprint.md
**内容**: 确定了5个Entity、12个Component、8个Event

### [2025-12-27] Layer 4: 事件流
**状态**: 🔄 进行中
**已完成**: 
- enemy_spawned_event
- tower_attack_event
- enemy_died_event
**待完成**:
- wave_completed_event
- game_over_event
```

---

## Memory-Bank模板更新

### 更新询问时机

在以下情况询问用户是否更新模板：
1. 成功完成一个完整功能
2. 发现可复用的架构模式
3. 积累了通用代码片段

### 询问格式

```markdown
协调器: "本次实现完成了 [功能名称]。

发现以下可复用内容：
1. [架构模式名称] - 可添加到架构模板
2. [代码片段描述] - 可添加到代码库

是否更新 Memory-Bank 模板？(是/否/选择性更新)"
```

---

## 问题上报收集

### 收集格式

当任何层Skill遇到问题时，记录到 `@issues-collected.md`:

```markdown
## Issue #[编号]
- **时间**: [timestamp]
- **Skill**: [skill名称]
- **层级**: [Layer X]
- **问题描述**: [详细描述]
- **触发场景**: [什么情况下遇到]
- **当前处理**: [如何绕过/解决]
- **建议改进**: [对Skill的改进建议]
```

### 改进模式触发阈值

```
问题数量 ≥ 5 → 提示: "已收集到5个问题，是否进入改进模式优化Skill？"
```

---

## Quick Reference

### 模式切换命令

| 命令 | 效果 |
|------|------|
| "循环迭代模式" | 自主消化需求，扩充代码库 |
| "架构设计模式" | 对话式架构设计 |
| "分层执行模式" | 大任务分段执行 |
| "对话模式" | 每步确认 |
| "自动模式" | 快速执行 |
| "改进模式" | Skill/Checklist 自进化 |
| "审计模式" | 主动检查代码库/Prompt质量 |

### 常用查询

| 命令 | 效果 |
|------|------|
| "显示进度" | 展示当前项目进度 |
| "当前在哪一层" | 显示当前执行层级 |
| "查看检查点" | 列出可恢复的检查点 |
| "更新模板" | 触发Memory-Bank更新 |

---

## 错误处理

### API缺失处理

```
verse-helpers 报告: "当前API不支持 [功能]"
    ↓
协调器: 记录到 @api-gaps.md
    ↓
协调器: 通知用户，建议替代方案或标记为TODO
```

### 层间请求失败

```
上层请求: "需要 [功能]"
下层响应: "无法实现，原因: [原因]"
    ↓
协调器: 
1. 记录问题
2. 尝试替代方案
3. 如无替代，上报用户
```

---

## Reference Files

- [Index.md](../Index.md) - 生态系统总览
- [verse-wrappers](../verse-wrappers/SKILL.md) - Wrapper 层 (L1.5) Skill
- [shared/checklists/architecture-review.md](../shared/checklists/architecture-review.md) - 架构检查清单
- [shared/memory-bank-template/](../shared/memory-bank-template/) - Memory-Bank模板
- [shared/evolution-logs/](../shared/evolution-logs/) - 自进化日志

---

*最后更新: 2025-12-28*
