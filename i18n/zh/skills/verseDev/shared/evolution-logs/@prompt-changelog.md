# Prompt 变更日志

> 改进模式产生的Skill Prompt修改记录

---

## 变更概览

| 版本 | 日期 | 涉及Skill | 变更类型 | 摘要 |
|------|------|-----------|----------|------|
| v1.0.1 | 2025-12-27 | 全局架构 | 重构 | 代码库改为分层索引+verse文件 |
| v1.0.2 | 2025-12-27 | 全局架构 | 重构 | 项目文件与模板文件分离 |
| v1.0.3 | 2025-12-27 | 全局架构 | 新增 | 各目录添加 @index.md 索引文件 |
| v1.0.4 | 2025-12-27 | L2/L3 层 | 重构 | Helper/Component 职责划分 |
| v1.0.5 | 2025-12-27 | **Skill Prompts** | 更新 | 更新 verse-helpers, verse-component, verse-orchestrator SKILL.md |
| v1.0.6 | 2025-12-27 | **verse-orchestrator** | 更新 | 强化改进模式职责声明 + 添加审计模式入口 |
| v1.0.7 | 2025-12-27 | **新增 Skill** | 新增 | 创建审计子系统 (dispatcher + 2 auditors) |
| v1.0.8 | 2025-12-27 | **shared/checklists** | 新增 | 创建 3 个审计检查清单文件 |

---

## 变更记录

## [CHANGE-006] 改进模式职责强化

**版本**: v1.0.6  
**日期**: 2025-12-27  
**触发问题**: ISSUE-006

### 涉及文件

| 文件/目录 | 变更类型 |
|------|----------|
| verse-orchestrator/SKILL.md | 更新 |

### 变更内容

**修改前**:
- 改进模式章节缺乏显眼的职责声明
- 易与循环迭代模式混淆

**修改后**:
1. 添加"改进模式核心原则"【重要】标记
2. 添加模式对比表（改进 vs 循环迭代）
3. 添加改进类型识别规则
4. 明确 Prompt-first 工作流

**修改理由**:
- Agent 在改进模式中错误地创建代码而非修改 SKILL.md
- 需要强化职责边界声明

---

## [CHANGE-007] 审计子系统创建

**版本**: v1.0.7  
**日期**: 2025-12-27  
**触发问题**: ISSUE-007

### 涉及文件

| 文件/目录 | 变更类型 |
|------|----------|
| verse-orchestrator/SKILL.md | 更新（添加审计模式入口） |
| verse-audit-dispatcher/SKILL.md | 新增 |
| verse-code-auditor/SKILL.md | 新增 |
| verse-prompt-auditor/SKILL.md | 新增 |

### 变更内容

**架构设计**:
```
verse-orchestrator (审计模式入口)
        ↓
verse-audit-dispatcher (子调度器)
        ↓
   ┌────┴────┐
代码审计    Prompt审计
```

**关键特性**:
1. 审计深度分级：快速/标准/深度
2. 审计范围：自动全量/指定范围
3. 强制阻断：仅限严重框架违规

**修改理由**:
- 代码库增长后缺乏主动质量检查能力
- 需要模块化审计避免调度器膨胀

---

## [CHANGE-008] 审计检查清单创建

**版本**: v1.0.8  
**日期**: 2025-12-27  
**触发问题**: ISSUE-007

### 涉及文件

| 文件/目录 | 变更类型 |
|------|----------|
| shared/checklists/code-quality-checklist.md | 新增 |
| shared/checklists/architecture-compliance-checklist.md | 新增 |
| shared/checklists/prompt-quality-checklist.md | 新增 |
| shared/evolution-logs/@checklist-changelog.md | 新增 |

### 变更内容

**检查清单覆盖**:

| 清单 | 检查项 | 适用审计器 |
|------|--------|-----------|
| 代码质量 | QUA-001~QUA-005 | verse-code-auditor |
| 架构合规 | ARC-001~ARC-005 | verse-code-auditor |
| Prompt质量 | PRM-001~PRM-011 | verse-prompt-auditor |

**修改理由**:
- 审计器需要标准化检查依据
- 统一检查清单便于扩展和维护

---

## [CHANGE-001] 代码库架构重构 - 分层索引

**版本**: v1.0.1  
**日期**: 2025-12-27  
**触发问题**: ISSUE-001

### 涉及文件

| 文件/目录 | 变更类型 |
|------|----------|
| shared/@code-library-index.md | 新增 |
| shared/code-library/Helpers/*.verse | 新增 |
| shared/code-library/Components/*.verse | 新增 |
| shared/code-library/Events/*.verse | 新增 |
| shared/code-library/Entities/*.verse | 新增 |
| memory-bank-template/@code-library.md | 废弃（保留兼容） |

### 变更内容

**修改前**:
- 所有代码放在单一 `@code-library.md` 文件
- 随着积累，文件越来越大，难以阅读和查询

**修改后**:
```
shared/
├── @code-library-index.md      # 分层索引（Agent查询入口）
└── code-library/               # 仿真实项目结构
    ├── Helpers/
    │   ├── MathUtils.verse
    │   ├── VectorUtils.verse
    │   ├── DamageCalculator.verse
    │   ├── TimerManager.verse
    │   └── RandomUtils.verse
    ├── Components/
    │   └── HealthComponent.verse
    ├── Events/
    │   ├── HealthEvents.verse
    │   └── StateEvents.verse
    └── Entities/
        └── GameObjectEntity.verse
```

**修改理由**:
1. 单文件过大，阅读困难
2. Agent 每次需加载全部代码，浪费上下文
3. 无法按类别筛选
4. 与真实 UEFN 项目结构脱节

### 验证

- [x] 已在新会话测试
- [x] 未引入副作用
- [x] 符合分层架构原则

---

## [CHANGE-002] 项目文件夹分离

**版本**: v1.0.2  
**日期**: 2025-12-27  
**触发问题**: ISSUE-002

### 涉及文件

| 文件/目录 | 变更类型 |
|------|----------|
| shared/projects/ | 新增目录 |
| shared/projects/_iteration-mode/ | 新增（迭代模式内部项目） |
| shared/projects/_templates/ | 新增（项目模板） |
| memory-bank-template/@checkpoint.md | 废弃（改为模板） |

### 变更内容

**修改前**:
- checkpoint、progress 等项目文件放在 template 目录
- 所有项目共用同一套文件，多项目冲突

**修改后**:
```
shared/
├── projects/                        # 项目专属文件夹
│   ├── _iteration-mode/             # 迭代模式视为内部项目
│   │   ├── @checkpoint.md
│   │   └── @progress.md
│   ├── _templates/                  # 新项目模板
│   │   ├── @checkpoint-template.md
│   │   └── @architecture-template.md
│   └── {user-project}/              # 用户项目文件夹
│
└── memory-bank-template/            # 仅保留通用模板
```

**核心区分**:
| 内容类型 | 存储位置 |
|----------|----------|
| 通用代码库 | code-library/ |
| 项目进度 | projects/{project}/ |
| 项目架构 | projects/{project}/ |
| 模板文件 | projects/_templates/ |

**修改理由**:
1. template 和 project-specific 内容混淆
2. 多项目同时进行会冲突
3. checkpoint 是项目状态，不是模板

### 验证

- [x] 已创建结构
- [x] 迭代模式进度已迁移
- [x] 模板文件已创建

---

## [CHANGE-003] 代码库分层索引体系

**版本**: v1.0.3  
**日期**: 2025-12-27  
**触发问题**: ISSUE-003

### 涉及文件

| 文件/目录 | 变更类型 |
|------|----------|
| code-library/Helpers/@index.md | 新增 |
| code-library/Components/@index.md | 新增 |
| code-library/Events/@index.md | 新增 |
| code-library/Entities/@index.md | 新增 |
| @code-library-index.md | 更新 |

### 变更内容

**修改前**:
- 只有顶层 `@code-library-index.md` 索引
- 各目录无独立索引，Agent 需读取完整索引获取信息

**修改后**:
```
shared/
├── @code-library-index.md              # 顶层索引（概览+跳转）
└── code-library/
    ├── Helpers/
    │   └── @index.md                   # Helper 详细索引
    ├── Components/
    │   └── @index.md                   # Component 详细索引
    ├── Events/
    │   └── @index.md                   # Event 详细索引
    └── Entities/
        └── @index.md                   # Entity 详细索引
```

**索引层级**:
1. **顶层索引**: 概览统计 + 各目录链接
2. **目录索引**: 该类型的详细列表 + 设计原则 + API 摘要
3. **具体文件**: 完整实现代码

**修改理由**:
1. Agent 可按需加载，减少上下文浪费
2. 各目录索引包含设计原则，指导编写风格
3. 分层查阅，逐步深入

### 验证

- [x] 已创建所有索引文件
- [x] 顶层索引已更新链接
- [x] 设计原则已写入各索引

---

## [CHANGE-004] Helper/Component 职责重构

**版本**: v1.0.4  
**日期**: 2025-12-27  
**触发问题**: ISSUE-004, ISSUE-005

### 涉及文件

| 文件/目录 | 变更类型 |
|------|----------|
| code-library/Helpers/HealthHelper.verse | 新增 |
| code-library/Helpers/CharacterHelper.verse | 新增 |
| code-library/Components/HealthComponent.v2.verse | 新增 |
| code-library/Helpers/@index.md | 更新 |
| code-library/Components/@index.md | 更新 |

### 变更内容

**修改前（旧模式）**:
```verse
# Component 内混合多种职责
health_component := class(component):
    TakeDamage(Amount:int):void =
        if IsInvincible:                           # 状态检查
            return
        set CurrentHealth = Max(0, CurrentHealth - Amount)  # 计算+修改
        Owner.SendUp(health_changed_event{...})    # 事件派发
        # 问题：CurrentHealth 是孤立变量，不影响真实游戏
```

**修改后（新模式）**:
```verse
# Helper: 纯函数计算
HealthHelper := module:
    CalculateDamageResult(HP, Damage, Invincible):health_change_result =
        # 只计算，不修改任何状态
        ...

# Helper: UEFN API 封装
CharacterHelper := module:
    ApplyDamage(Character, Amount):character_op_result =
        # 封装边界检查 + 调用真实 API
        ...

# Component: 状态管理 + 事件编排
health_component := class(component):
    var BoundCharacter:?fort_character = false  # 绑定真实角色
    
    OnReceiveDamage(Amount:int, Source:string):void =
        # 1. Helper 计算
        Result := HealthHelper.CalculateDamageResult(...)
        # 2. 更新状态
        set CurrentHealth = Result.NewHealth
        # 3. 真实效果（通过 Helper）
        CharacterHelper.ApplyDamage(BoundCharacter, ...)
        # 4. 派发事件
        SendHealthChanged(Result)
```

**职责划分**:

| 层级 | 职责 | 示例 |
|------|------|------|
| Helper | 纯函数计算 | `CalculateDamageResult()` |
| Helper | UEFN API 封装 | `CharacterHelper.ApplyDamage()` |
| Component | 状态管理 | `var CurrentHealth` |
| Component | 事件处理 | `OnReceiveDamage()` |
| Component | 事件派发 | `SendUp(event)` |
| Component | 绑定真实对象 | `var BoundCharacter` |

**修改理由**:
1. **ISSUE-004**: 组件变量与游戏系统脱节 → 添加绑定机制 + CharacterHelper 封装真实 API
2. **ISSUE-005**: 职责混乱 → 计算逻辑抽取到 Helper，Component 只编排流程

### 新增文件说明

#### HealthHelper.verse
- 生命值计算纯函数
- `CalculateDamageResult()`: 伤害结果计算
- `CalculateHealResult()`: 治疗结果计算
- `IsLethalDamage()`, `IsLowHealth()`: 判定函数
- `GetHealthPercent()`, `GetMissingHealth()`: 数值计算

#### CharacterHelper.verse
- UEFN fort_character API 封装
- `ApplyDamage()`: 应用伤害到真实角色
- `ApplyHeal()`: 应用治疗
- `GetHealth()`, `GetMaxHealth()`: 查询
- 所有函数包含边界检查和错误处理

#### HealthComponent.v2.verse
- 重构后的生命值组件
- 通过 `BoundCharacter` 绑定真实角色
- 事件处理器模式 (`OnReceiveDamage`, `OnReceiveHeal`)
- 调用 Helper 进行计算和真实效果应用

### 验证

- [x] 已创建 HealthHelper
- [x] 已创建 CharacterHelper
- [x] 已创建重构版 HealthComponent.v2
- [x] 设计原则已写入索引文件

---

## [CHANGE-005] Skill Prompt 更新 - Helper/Component 职责文档化

**版本**: v1.0.5  
**日期**: 2025-12-27  
**触发问题**: ISSUE-003, ISSUE-004, ISSUE-005（改进模式要求更新 Skill Prompt）

### 涉及文件

| 文件 | 变更类型 |
|------|----------|
| verse-helpers/SKILL.md | 修改 |
| verse-component/SKILL.md | 修改 |
| verse-orchestrator/SKILL.md | 修改 |

### 变更内容

#### verse-helpers/SKILL.md

**变更区域**: 核心职责、Helper 模块参考  
**安全检查**: ✅ 未触及不可变区域

**新增内容**:
1. **设计原则【重要】** 章节：
   - Helper 层职责边界图示
   - 两大类别（纯计算 Helper vs API 封装 Helper）
   - 纯计算 Helper 模式示例
   - API 封装 Helper 模式示例
   - 为什么需要 API 封装 Helper

2. **UEFN API 封装模块【新增】** 章节：
   - CharacterHelper（角色操作封装）完整实现
   - HealthHelper（血量计算纯函数）完整实现

#### verse-component/SKILL.md

**变更区域**: 核心职责、组件模板  
**安全检查**: ✅ 未触及不可变区域

**新增内容**:
1. **设计原则【重要 - CHANGE-004 更新】** 章节：
   - Component 层职责边界图示
   - 三层结构（状态层、接口层、绑定层）
   - 新旧模式对比代码示例
   - 为什么要这样设计

2. **生命值组件（新模式）** 模板：
   - 完整遵循 CHANGE-004 架构
   - 职责边界注释
   - 绑定层实现
   - 事件处理器模式

3. **Quick Reference 更新**：
   - Component → Helper 调用流程图
   - 依赖的 Helper 模块表
   - 新模式 vs 旧模式速查

#### verse-orchestrator/SKILL.md

**变更区域**: 子Skill调度  
**安全检查**: ✅ 未触及不可变区域

**新增内容**:
1. **代码库分层查阅【CHANGE-003 新增】** 章节：
   - 查阅流程图
   - 索引文件结构说明
   - 为什么需要分层查阅

2. **Helper 与 Component 协作模式【CHANGE-004 新增】** 章节：
   - 职责边界图示
   - 调度检查清单

### 修改理由

用户指出"改进模式要改进的是 Skill 的 Prompt"，之前的 CHANGE-003/004 只创建了代码文件和索引文件，但没有更新实际的 Skill Prompt（SKILL.md）。

本次更新确保：
1. **verse-helpers** 明确了 Helper 的两种类型和职责边界
2. **verse-component** 更新了组件模板为新的事件处理器模式
3. **verse-orchestrator** 添加了分层查阅和协作模式的调度指导

### 验证

- [x] verse-helpers/SKILL.md 已更新
- [x] verse-component/SKILL.md 已更新
- [x] verse-orchestrator/SKILL.md 已更新
- [x] 新增内容符合安全边界（示例代码、最佳实践）

### 回滚方案

如需回滚，可通过 git 恢复各 SKILL.md 文件到本次修改前的版本。

---

```markdown
## [CHANGE-001] [变更标题]

**版本**: v1.0.1  
**日期**: [timestamp]  
**触发问题**: [ISSUE-ID 或 用户请求]

### 涉及文件

| 文件 | 变更类型 |
|------|----------|
| [skill]/SKILL.md | 修改 |

### 变更内容

#### [skill]/SKILL.md

**变更区域**: [可变区域名称]  
**安全检查**: ✅ 未触及不可变区域

**修改前**:
```markdown
[原始内容]
```

**修改后**:
```markdown
[修改后内容]
```

**修改理由**:
[为什么需要这个修改]

### 验证

- [ ] 已在新会话测试
- [ ] 未引入副作用
- [ ] 符合分层架构原则

### 回滚方案

如需回滚，将修改后的内容替换回修改前的内容。
```

---

## 按 Skill 分类

### verse-orchestrator

| 变更ID | 日期 | 摘要 |
|--------|------|------|
| CHANGE-005 | 2025-12-27 | 添加分层查阅指导 + Helper/Component 协作模式 |

### verse-framework-designer

| 变更ID | 日期 | 摘要 |
|--------|------|------|
| - | - | - |

### verse-event-flow

| 变更ID | 日期 | 摘要 |
|--------|------|------|
| - | - | - |

### verse-component

| 变更ID | 日期 | 摘要 |
|--------|------|------|
| CHANGE-005 | 2025-12-27 | 添加设计原则章节 + 更新 health_component 模板为新模式 |

### verse-helpers

| 变更ID | 日期 | 摘要 |
|--------|------|------|
| CHANGE-005 | 2025-12-27 | 添加设计原则章节 + 新增 CharacterHelper/HealthHelper 模块 |

### verse-assets

| 变更ID | 日期 | 摘要 |
|--------|------|------|
| - | - | - |

---

## 可变区域参考

> 以下区域可以安全修改，不影响核心功能

### 可变区域列表

1. **示例代码** - 可添加、修改、替换
2. **检查清单项** - 可增减、调整顺序
3. **最佳实践** - 可补充、细化
4. **术语解释** - 可扩展、更新
5. **常见问题** - 可添加、更新答案
6. **模板中的占位符** - 可调整格式

### 不可变区域列表

1. **核心职责定义**
2. **输出格式规范**
3. **层间协议**
4. **依赖规则**
5. **命名约定**
6. **生命周期钩子**

---

## 统计

| 月份 | 变更数 | 主要类型 |
|------|--------|----------|
| 2025-12 | 5 | 架构重构、Skill Prompt 更新 |

---

*最后更新: 2025-12-27*
