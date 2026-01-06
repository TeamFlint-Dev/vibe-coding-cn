# 问题收集日志

> 循环迭代与改进模式中收集的问题和改进建议

---

## 待处理队列

### 当前积累: 2 条

> 达到 5 条时触发改进模式

| ID | 类别 | 问题描述 | 来源 | 添加时间 |
|----|------|----------|------|----------|
| ISSUE-008 | WORKFLOW_GAP | Prompt修改类任务应强制要求 Plan 模式 | 用户反馈 | 2025-12-27 |
| ISSUE-009 | CONTEXT_GAP | 迭代任务 Skill 不知道上下文记忆位置和需求来源 | 用户反馈 | 2025-12-27 |

---

## ISSUE-008: Prompt修改类任务应强制要求 Plan 模式

**类别**: WORKFLOW_GAP  
**涉及 Skill**: verseOrchestrator, verseAuditDispatcher  
**添加时间**: 2025-12-27  
**严重程度**: 高  
**状态**: 🔴 待处理

### 问题描述

在执行 **Prompt 修改类任务**（如审计任务、改进任务）时，Agent 可能直接开始执行，缺乏充分的规划。这类任务影响范围大、不可逆，应强制要求用户切换到 **Plan 模式** 进行充分讨论后再执行。

### 涉及场景

| 任务类型 | 示例触发词 | 风险 |
|----------|-----------|------|
| 审计任务 | "审计代码"、"审计Prompt" | 可能产生大量误判建议 |
| 改进任务 | "执行改进"、"解决问题" | 修改 SKILL.md 影响后续所有会话 |
| 重构任务 | "重构架构"、"调整分层" | 破坏现有工作流 |

### 期望行为

```
用户: "进入审计模式" / "执行改进"
    ↓
Agent 检测到 Prompt 修改类任务
    ↓
【强制】提示用户：
"⚠️ 此任务涉及 Skill Prompt 修改，建议切换到 Plan 模式进行充分规划。
请输入：'切换 Plan 模式' 或 '确认直接执行'"
    ↓
用户切换到 Plan 模式
    ↓
在 Plan 模式中讨论:
- 审计/改进范围
- 预期变更清单
- 风险评估
    ↓
用户确认计划后执行
```

### 当前状态

- verseOrchestrator 的审计模式和改进模式没有强制 Plan 检查
- verseAuditDispatcher 直接进入审计流程，无规划阶段
- 用户可能在未充分理解影响的情况下触发大规模修改

### 建议实现

1. 在 `verseOrchestrator/SKILL.md` 的审计模式和改进模式入口添加 Plan 检查
2. 在 `verseAuditDispatcher/SKILL.md` 添加前置规划阶段
3. 定义"Prompt 修改类任务"的识别规则

### 安全边界检查

- 是否涉及可变区域: ✅ 是（工作流程属于可扩展区域）
- 是否影响核心职责: ❌ 否（增强安全检查，不改变核心功能）

---

## ISSUE-009: 迭代任务 Skill 不知道上下文记忆位置和需求来源

**类别**: CONTEXT_GAP  
**涉及 Skill**: verseOrchestrator（循环迭代模式）  
**添加时间**: 2025-12-27  
**严重程度**: 高  
**状态**: 🔴 待处理

### 问题描述

循环迭代模式执行时存在以下信息缺失：

1. **不知道上下文记忆在哪里**: 迭代任务 Skill 不清楚应该去哪里读取/写入持久化状态
2. **不知道需求清单位置**: 不知道去哪里检查是否存在待处理的迭代任务需求
3. **不知道需求闭环**: 当现有迭代任务都完成后，不知道应该调用需求 Skill 提供新的有价值的需求清单

### 期望行为

```
用户: "进入循环迭代模式"
    ↓
Agent 读取上下文记忆位置:
  - shared/projects/_iteration-mode/@checkpoint.md (进度)
  - shared/projects/_iteration-mode/@progress.md (状态)
  - shared/evolution-logs/@pending-requirements.md (需求清单)
    ↓
检查 @pending-requirements.md:
  - 有待处理需求 → 执行迭代
  - 无待处理需求 → 调用 verseRequirementProposer 生成新需求
    ↓
迭代完成后更新:
  - @checkpoint.md (保存断点)
  - @pending-requirements.md (标记完成)
    ↓
所有需求完成时:
  "当前需求清单已全部完成。
   是否调用需求梳理器生成新的迭代目标？"
```

### 当前状态

- verseOrchestrator 的循环迭代模式缺乏明确的"上下文路径指引"
- 没有定义"需求为空时"的处理流程
- 与 verseRequirementProposer 的协作接口不明确

### 建议实现

1. 在 `verseOrchestrator/SKILL.md` 循环迭代模式章节添加：
   - **上下文文件路径表**
   - **需求检查流程**
   - **需求闭环机制**

2. 定义与 verseRequirementProposer 的协作触发条件

```markdown
### 循环迭代模式上下文

**必读文件**:
| 文件 | 用途 | 何时读取 |
|------|------|----------|
| `@pending-requirements.md` | 待处理需求清单 | 进入迭代模式时 |
| `@checkpoint.md` | 上次中断点 | 恢复工作时 |
| `@code-library-index.md` | 代码库索引 | 写入新代码时 |

**需求闭环**:
当 @pending-requirements.md 中所有需求都标记为 ✅ 时:
1. 提示用户："当前需求已全部完成"
2. 询问："是否生成新的迭代需求？"
3. 若是 → 调用 verseRequirementProposer
4. 新需求写入 @pending-requirements.md
5. 继续迭代循环
```

### 安全边界检查

- 是否涉及可变区域: ✅ 是（工作流程说明属于可扩展区域）
- 是否影响核心职责: ❌ 否（补充上下文指引，不改变核心逻辑）

---

## 已解决问题

| ID | 类别 | 问题描述 | 解决日期 | 解决方案 |
|----|------|----------|----------|----------|
| ISSUE-006 | PROMPT_GAP | 改进模式忘记自身职责 | 2025-12-27 | 在 orchestrator 添加改进模式核心原则 |
| ISSUE-007 | WORKFLOW_GAP | 缺少审计模式 | 2025-12-27 | 创建审计子系统（dispatcher + 2 auditors） |

---

## ISSUE-007: 缺少审计模式，无法主动发现代码库问题

**类别**: WORKFLOW_GAP  
**涉及 Skill**: verseOrchestrator  
**添加时间**: 2025-12-27  
**严重程度**: 中  
**状态**: ✅ 已解决

### 解决方案

创建模块化审计子系统：

| 新增 Skill | 职责 |
|------------|------|
| verseAuditDispatcher | 审计意图解析、深度选择、强制阻断判断 |
| verseCodeAuditor | 代码质量审计执行 |
| versePromptAuditor | Skill Prompt 质量审计执行 |

**配套文件**:
- `shared/checklists/code-quality-checklist.md`
- `shared/checklists/architecture-compliance-checklist.md`  
- `shared/checklists/prompt-quality-checklist.md`

### 问题描述

当代码库变得庞大之后，用户无法通过人力主动审阅所有代码。需要一个新的运行模式——**审计模式**，能够：

1. **全局扫描**: 主动遍历代码库中的所有文件
2. **问题发掘**: 根据检查清单和最佳实践，识别潜在问题
3. **引导交互**: 将发现的问题汇总，引导用户查看特定代码
4. **主动对话**: 在发现重要问题时主动与用户交谈

### 期望行为

```
用户: "进入审计模式"
    ↓
Agent 读取代码库索引
    ↓
逐类别扫描 (Helpers → Components → Events → Entities)
    ↓
对每个文件执行检查:
  - 代码规范一致性
  - API 使用正确性
  - 与架构设计的符合度
  - 文档完整性
  - 潜在 bug 模式
    ↓
汇总发现的问题
    ↓
与用户交互:
  "在审计中发现以下问题:
   1. [严重] HealthComponent.verse 第45行: ...
   2. [建议] MovementComponent.verse: 缺少边界检查
   ...
   是否逐个查看？"
```

### 当前状态

verseOrchestrator 只有 5 种运行模式：
- 循环迭代模式
- 架构设计模式
- 分层执行模式
- 对话/自动模式
- 改进模式

**缺少**: 针对代码库质量的主动审计能力

### 建议实现

在 `verseOrchestrator/SKILL.md` 添加第 6 种模式：

```markdown
### 6. 审计模式 (Audit Mode)

**目的**: 主动发现代码库中的质量问题

**工作流程**:
```
读取 @code-library-index.md
    ↓
按类别遍历代码文件
    ↓
对每个文件执行检查清单
    ↓
收集问题到 @audit-report.md
    ↓
与用户交互，引导查看问题
```

**触发方式**:
- "进入审计模式"
- "审计代码库"
- "检查代码质量"

**检查维度**:
1. **代码规范**: 命名、格式、注释
2. **架构符合**: 是否遵循 SceneGraph 分层
3. **API 使用**: 是否使用了正确的 API 模式
4. **安全性**: 空值检查、边界处理
5. **文档**: 是否有清晰的使用说明

**输出**:
- `@audit-report.md`: 审计报告
- 按严重程度分类的问题列表
- 建议的修复优先级
```

### 安全边界检查

- 是否涉及可变区域: ✅ 是（新增运行模式属于可扩展区域）
- 是否影响核心职责: ❌ 否（扩展协调器能力，不改变现有模式）

---

## ISSUE-006: 改进模式忘记自身职责，未更新 Skill Prompt

**类别**: PROMPT_GAP  
**涉及 Skill**: verseOrchestrator（改进模式）  
**添加时间**: 2025-12-27  
**严重程度**: 高  
**状态**: ✅ 已解决

### 解决方案

在 `verseOrchestrator/SKILL.md` 改进模式章节添加：
1. **核心原则声明**：明确改进模式产出是 SKILL.md 修改
2. **模式对比表**：区分改进模式与循环迭代模式
3. **改进类型识别**：识别 Prompt 修改与代码产出

### 问题描述

在改进模式执行过程中，Agent 忘记了改进模式的核心职责是 **修改 Skill Prompt（SKILL.md）**，而不是创建代码文件。

具体表现：
1. 用户记录了 ISSUE-003/004/005
2. Agent 进入改进模式执行改进
3. Agent 创建了 `@index.md`、`HealthHelper.verse`、`CharacterHelper.verse` 等**代码文件**
4. **但没有更新实际的 Skill Prompt 文件**（verseHelpers/SKILL.md、verseComponent/SKILL.md）
5. 用户需要手动提醒："改进模式要改进的是 Skill 的 Prompt"

### 期望行为

改进模式应该：
1. **首先修改 Skill Prompt**（SKILL.md 文件中的设计原则、模板、示例）
2. 然后才考虑是否需要创建参考代码文件
3. 明确区分"Prompt 改进"和"代码产出"

### 实际行为

Agent 跳过了 Skill Prompt 修改，直接创建代码文件，把"改进模式"变成了"循环迭代模式"的行为。

### 根因分析

1. **职责混淆**: 改进模式的职责定义不够显眼，与循环迭代模式的产出容易混淆
2. **缺乏检查点**: 没有强制检查"是否已更新相关 SKILL.md"
3. **流程不清晰**: 改进模式的执行步骤没有明确"Prompt First"

### 建议 Prompt 修改

在 `verseOrchestrator/SKILL.md` 的改进模式章节添加：

```markdown
### 改进模式核心原则【重要】

> ⚠️ 改进模式的产出是 **Skill Prompt 的修改**，不是代码文件

```
改进模式执行顺序：
1. 分析问题 → 确定涉及哪些 Skill
2. 【必须】修改相关 SKILL.md 文件
   - 更新设计原则
   - 更新模板/示例
   - 添加检查清单项
3. 【可选】创建参考代码文件作为示例
4. 更新 @prompt-changelog.md 记录变更
```

**改进模式 vs 循环迭代模式**:

| 模式 | 主要产出 | 目标 |
|------|----------|------|
| 循环迭代 | 代码库中的 .verse 文件 | 积累可复用代码 |
| **改进模式** | **SKILL.md 文件的修改** | **优化 Agent 行为** |
```

### 安全边界检查

- 是否涉及可变区域: ✅ 是（示例代码、检查清单、最佳实践）
- 是否影响核心职责: ❌ 否（只是强化职责描述）

---

## 问题分类

### API 缺失 (API_GAP)

> 需要的API不存在于digest文件中

#### 模板

```markdown
### [ISSUE-001] [问题标题]

**类别**: API_GAP  
**严重程度**: 高/中/低  
**添加时间**: [timestamp]  
**来源**: [需求ID 或 会话描述]

**问题描述**:
[详细说明缺失的API]

**期望功能**:
[期望API应提供的功能]

**当前替代方案**:
[临时解决方法，如有]

**影响范围**:
- [ ] 阻塞当前任务
- [ ] 影响代码质量
- [ ] 可绕过但不理想

**建议改进**:
[对Skill Prompt的改进建议]
```

---

### Prompt 不足 (PROMPT_GAP)

> Skill指令不够清晰或遗漏场景

#### 模板

```markdown
### [ISSUE-002] [问题标题]

**类别**: PROMPT_GAP  
**涉及Skill**: [skill名称]  
**添加时间**: [timestamp]

**问题描述**:
[什么情况下Skill指令不够用]

**期望行为**:
[Skill应该如何响应]

**实际行为**:
[Skill实际如何响应]

**建议Prompt修改**:
```
[建议添加的Prompt内容]
```

**安全边界检查**:
- 是否涉及可变区域: 是/否
- 是否影响核心职责: 是/否
```

---

### 模式缺失 (PATTERN_GAP)

> 常见场景缺乏标准模式

---

### ISSUE-001: 代码库单文件过大，需改为分层索引+项目结构

**类别**: WORKFLOW_GAP  
**涉及层级**: L2/L3/L4 (所有产出代码的层级)  
**添加时间**: 2025-12-27  
**严重程度**: 高  
**来源**: 用户反馈

**问题描述**:
当前所有 Verse 代码都放在 `@code-library.md` 单一文件中。随着代码积累，文件越来越大，阅读困难，Agent 也难以快速定位需要的代码片段。

**期望结构**:
```
shared/
├── memory-bank-template/
│   ├── @code-library-index.md    # 分层索引（Agent查询入口）
│   └── code-library/             # 仿真实项目结构
│       ├── Helpers/
│       │   ├── DamageCalculator.verse
│       │   ├── RandomUtils.verse
│       │   └── timer_manager.verse
│       ├── Components/
│       │   ├── health_component.verse
│       │   ├── movement_component.verse
│       │   └── ...
│       ├── Events/
│       │   ├── health_changed_event.verse
│       │   └── ...
│       └── Entities/
│           └── game_object_entity.verse
```

**期望行为**:
1. Agent 先读取 `@code-library-index.md` 获取分类目录
2. 根据需求，定向读取具体的 `.verse` 文件
3. 新增代码时，创建对应的 `.verse` 文件并更新索引

**当前问题**:
1. 单文件阅读困难
2. Agent 每次需要加载全部代码，上下文浪费
3. 无法按类别筛选
4. 与真实 UEFN 项目结构脱节

**建议改进**:
1. 创建 `code-library/` 目录，按类型分文件夹
2. 每个代码片段独立为 `.verse` 文件
3. `@code-library-index.md` 改为分层索引，包含：
   - 按类型分类的快速索引表
   - 每个模块的简介和用途
   - 文件路径引用
4. 更新 verseOrchestrator 和各层 Skill，使用新的查询/写入流程

**安全边界检查**:
- 是否涉及可变区域: 是（代码存储结构）
- 是否影响核心职责: 否（仅改变存储形式，不改变Skill职责）

---

### ISSUE-002: checkpoint应在项目文件夹而非template中

**类别**: WORKFLOW_GAP  
**涉及层级**: verseOrchestrator (协调器)  
**添加时间**: 2025-12-27  
**严重程度**: 高  
**来源**: 用户反馈

**问题描述**:
当前 `@checkpoint.md` 放在 `memory-bank-template/` 目录中，这是错误的。Template 目录应该只存放通用可复用的内容（如代码库），而 checkpoint 是项目特定的上下文，应该有独立的项目文件夹。

**期望结构**:
```
shared/
├── memory-bank-template/           # 通用模板（可复用代码库）
│   ├── @code-library-index.md
│   └── code-library/
│
├── projects/                        # 项目专属文件夹
│   ├── _iteration-mode/             # 迭代模式视为Skill内部项目
│   │   ├── @checkpoint.md
│   │   ├── @progress.md
│   │   └── @pending-requirements.md
│   │
│   ├── tower-defense-game/          # 用户项目示例
│   │   ├── @checkpoint.md
│   │   ├── @architecture-blueprint.md
│   │   ├── @progress.md
│   │   └── @project-requirements.md
│   │
│   └── another-project/
│       └── ...
```

**核心区别**:
| 内容 | 存储位置 | 原因 |
|------|----------|------|
| 代码库 | template/ | 通用可复用 |
| checkpoint | projects/{project}/ | 项目特定上下文 |
| architecture | projects/{project}/ | 项目特定设计 |
| pending-requirements | projects/{project}/ | 项目特定需求 |

**迭代模式特殊处理**:
迭代模式虽然没有具体用户项目，但应视为 Skill 内部的一个“项目”，使用 `projects/_iteration-mode/` 存储其上下文。

**期望行为**:
1. 新建项目时，在 `projects/` 下创建项目文件夹
2. 项目的 checkpoint、blueprint、progress 都存在项目文件夹中
3. 实现代码时，从 template 组合通用代码 + 项目特定代码
4. 迭代模式的产出进入 template/code-library/，但进度记录在 projects/_iteration-mode/

**当前问题**:
1. template 和 project-specific 内容混在一起
2. 多项目同时进行时会冲突
3. checkpoint 被视为模板而非项目状态

**建议改进**:
1. 创建 `shared/projects/` 目录
2. 将项目特定文件（checkpoint, blueprint, progress, requirements）移至项目文件夹
3. template 中保留模板文件（作为新项目的初始化模板）
4. 更新 orchestrator 的项目初始化和恢复流程

**安全边界检查**:
- 是否涉及可变区域: 是（文件组织结构）
- 是否影响核心职责: 否（仅改变存储位置，不改变职责逻辑）

---

### ISSUE-003: Memory Bank文档层级过深，缺乏入口索引机制

**类别**: WORKFLOW_GAP  
**涉及层级**: 所有层级 (L1-L5)  
**添加时间**: 2025-12-27  
**严重程度**: 高  
**来源**: 用户反馈

**问题描述**:
Memory Bank 中的关键文档内容过长。Agent 在查阅时需要加载大量无关内容，浪费上下文窗口。当前缺乏一个清晰的层级索引机制，让 Agent 能够根据需要逐层深入查阅。

**当前问题**:
1. `@code-library-index.md` 虽已分层，但仍混入了过多细节
2. 没有统一的"入口文档"概念
3. Agent 无法按需加载，每次都要读取完整文档
4. 不同类型的知识（API、代码、模式）没有清晰边界

**期望结构**:
```
shared/
├── @ENTRY.md                      # 总入口：列出所有可查阅资源的摘要
│
├── api-digests/
│   ├── @index.md                  # API索引入口
│   └── [具体API文件].md
│
├── code-library/
│   ├── @index.md                  # 代码库索引入口
│   └── [分类目录]/[具体文件].verse
│
├── checklists/
│   ├── @index.md                  # 检查清单索引入口
│   └── [具体清单].md
│
└── references/
    ├── @index.md                  # 参考资料索引入口
    └── [具体资料].md
```

**期望行为**:
1. Agent 首先读取 `@ENTRY.md` 获取资源概览
2. 根据任务需要，选择性进入某个子目录的 `@index.md`
3. 再根据索引，读取具体的文件
4. 每层文档简洁，只提供本层摘要 + 下层链接

**建议改进**:
1. 创建 `@ENTRY.md` 作为 Memory Bank 总入口
2. 每个子目录创建 `@index.md` 作为该类型资源的索引
3. 索引文件只包含摘要信息，不包含具体实现
4. 更新 Skill Prompt，指导 Agent 使用分层查阅流程

**安全边界检查**:
- 是否涉及可变区域: 是（文档组织结构）
- 是否影响核心职责: 否（仅优化信息获取方式）

---

### ISSUE-004: 组件缺乏全局思维，变量与游戏系统脱节

**类别**: DESIGN_GAP  
**涉及层级**: L3 (Component层)  
**添加时间**: 2025-12-27  
**严重程度**: 高  
**来源**: 用户反馈

**问题描述**:
以 `HealthComponent` 为例，该组件自己维护了 `CurrentHealth` 变量，但这个变量：
1. 没有与任何真实游戏系统关联
2. 无法影响角色的实际状态（如 UEFN 的 `fort_character`）
3. 只是一个孤立的数值，不产生任何实际效果

**核心问题**:
编写组件时缺乏"全局思维"——没有思考这个组件如何融入整个游戏系统，变量如何与引擎/框架交互。

**具体表现** (HealthComponent):
```verse
# 当前问题：CurrentHealth 是孤立变量
var CurrentHealth<private>:int = 0

TakeDamage<public>(Amount:int):void =
    set CurrentHealth = Max(0, CurrentHealth - Amount)  # 改变了变量
    # 但是...然后呢？角色并不会真的受伤或死亡
```

**期望行为**:
组件应该明确：
1. 它管理的状态如何与引擎/框架交互
2. 状态变化如何产生实际效果
3. 如果是"纯逻辑"组件，应明确标注使用场景

**建议改进**:
1. **方案A - 集成真实系统**: 
   - 研究 UEFN 的 `fort_character.Damage()` 等 API
   - 组件直接调用引擎 API 产生实际效果

2. **方案B - 明确为"逻辑层"组件**:
   - 组件只负责逻辑计算和事件派发
   - 通过事件通知外部系统执行实际操作
   - 文档明确说明"需要外部系统响应事件"

3. **方案C - 提供集成指南**:
   - 每个组件附带"集成示例"
   - 说明如何将组件与真实游戏对象绑定

**代码库改进建议**:
```verse
# 改进后的 HealthComponent 应该：
# 1. 发送事件，由外部系统响应
# 2. 或直接提供与真实系统的绑定接口

health_component := class(component):
    # 绑定的真实角色（可选）
    var BoundCharacter<public>:?fort_character = false
    
    TakeDamage<public>(Amount:int):void =
        # ... 逻辑计算 ...
        
        # 如果绑定了真实角色，产生实际效果
        if (Char := BoundCharacter):
            Char.Damage(CalculatedDamage)
```

**安全边界检查**:
- 是否涉及可变区域: 是（组件设计哲学）
- 是否影响核心职责: 是（影响 L3 组件的设计原则）

---

### ISSUE-005: 组件职责划分不当，逻辑应抽象到Helper

**类别**: ARCHITECTURE_GAP  
**涉及层级**: L2 (Helper层) / L3 (Component层)  
**添加时间**: 2025-12-27  
**严重程度**: 高  
**来源**: 用户反馈

**问题描述**:
以 `HealthComponent.TakeDamage()` 为例，当前实现将计算逻辑和状态管理混在一起。更好的设计是：
- **Component** 专注于：状态变量管理 + 事件监听/派发
- **Helper** 专注于：状态无关的纯函数计算

**当前问题代码**:
```verse
# HealthComponent 中混合了多种职责
TakeDamage<public>(Amount:int):void =
    if IsInvincible:                              # 状态检查
        return
    set CurrentHealth = Max(0, CurrentHealth - Amount)  # 计算+状态修改
    if (Owner := GetOwner()):
        Owner.SendUp(health_changed_event{...})   # 事件派发
        if CurrentHealth <= 0:
            Owner.SendUp(entity_died_event{})     # 事件派发
```

**期望职责划分**:

```verse
# ============ Helper 层 (状态无关) ============
# DamageHelper.verse
CalculateDamageResult<public>(CurrentHP:int, Damage:int, IsInvincible:logic):damage_result =
    if IsInvincible:
        return damage_result{ActualDamage := 0, NewHP := CurrentHP, IsDead := false}
    NewHP := Max(0, CurrentHP - Damage)
    return damage_result{ActualDamage := Damage, NewHP := NewHP, IsDead := NewHP <= 0}

# ============ Component 层 (状态管理+事件) ============
# HealthComponent.verse
health_component := class(component):
    var CurrentHealth<private>:int = 0
    var IsInvincible<private>:logic = false
    
    # 事件处理器：响应伤害事件
    OnReceiveDamage<public>(Amount:int):void =
        # 调用 Helper 计算
        Result := CalculateDamageResult(CurrentHealth, Amount, IsInvincible)
        
        # 更新状态
        set CurrentHealth = Result.NewHP
        
        # 派发事件
        if Result.ActualDamage > 0:
            SendHealthChanged(-Result.ActualDamage)
        if Result.IsDead:
            SendDied()
```

**职责边界**:

| 层级 | 职责 | 特点 |
|------|------|------|
| Helper | 纯函数计算 | 无状态、可测试、可复用 |
| Component | 状态管理 | 持有变量、响应事件、派发事件 |
| Event | 系统通信 | 解耦组件间依赖 |

**改进收益**:
1. **可测试性**: Helper 函数可以独立单元测试
2. **可复用性**: 计算逻辑可在多个组件中复用
3. **清晰边界**: 每层职责单一，易于理解和维护
4. **事件驱动**: 通过事件编排流程，而非硬编码调用

**建议改进**:
1. 重构现有 Component，将计算逻辑抽取到 Helper
2. Component 改为 `OnXxx` 事件处理器模式
3. 更新 L2/L3 Skill Prompt，明确职责边界
4. 添加"职责划分检查清单"到 checklists

**安全边界检查**:
- 是否涉及可变区域: 是（组件架构模式）
- 是否影响核心职责: 是（重新定义 L2/L3 边界）

---

#### 模板

```markdown
### [ISSUE-003] [问题标题]

**类别**: PATTERN_GAP  
**场景类型**: [UI/战斗/移动/网络等]  
**添加时间**: [timestamp]

**场景描述**:
[什么场景需要标准模式]

**建议模式**:
```verse
[代码模式]
```

**适用条件**:
[何时应用此模式]

**入库建议**:
- 目标位置: @code-library.md / 其他
- 分类: 组件/Helper/事件/Entity
```

---

### 工作流问题 (WORKFLOW_GAP)

> 层间协作或流程问题

#### 模板

```markdown
### [ISSUE-004] [问题标题]

**类别**: WORKFLOW_GAP  
**涉及层级**: [L5/L4/L3/L2/L1]  
**添加时间**: [timestamp]

**问题描述**:
[工作流中遇到的问题]

**期望流程**:
[应该如何运作]

**建议改进**:
[对编排器或层级的改进建议]
```

---

## 已处理问题

> 改进模式处理后归档

| ID | 类别 | 问题描述 | 处理方式 | 处理时间 |
|----|------|----------|----------|----------|
| ISSUE-001 | WORKFLOW_GAP | 代码库单文件过大 | CHANGE-001 架构重构 | 2025-12-27 |
| ISSUE-002 | WORKFLOW_GAP | checkpoint位置错误 | CHANGE-002 项目分离 | 2025-12-27 |
| ISSUE-003 | WORKFLOW_GAP | 文档层级深，缺入口索引 | CHANGE-003 分层索引体系 | 2025-12-27 |
| ISSUE-004 | DESIGN_GAP | 组件与游戏系统脱节 | CHANGE-004 绑定机制+API封装 | 2025-12-27 |
| ISSUE-005 | ARCHITECTURE_GAP | 组件职责划分不当 | CHANGE-004 Helper/Component分离 | 2025-12-27 |

---

## 统计

| 类别 | 待处理 | 已处理 |
|------|--------|--------|
| API_GAP | 0 | 0 |
| PROMPT_GAP | 0 | 0 |
| PATTERN_GAP | 0 | 0 |
| WORKFLOW_GAP | 0 | 3 |
| DESIGN_GAP | 0 | 1 |
| ARCHITECTURE_GAP | 0 | 1 |
| **总计** | **0** | **5** |

---

*最后更新: 2025-12-27*
