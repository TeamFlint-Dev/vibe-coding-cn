# Verse Dev 技能生态系统

> **版本**: 1.0.0  
> **更新日期**: 2025-12-27  
> **核心框架**: SceneGraph (Entity-Component-Event)

---

## 概述

**Verse Dev** 是一个自进化的多模式 UEFN Verse 代码编写技能体系，遵循**胶水编程**思想构建。通过分层架构将游戏需求转换为高质量、高扩展性的 Verse 代码。

### 核心理念

```
需求 → 框架设计 → 事件流 → 组件 → 操作 → 资产
        ↑                              ↓
        └──────── 需求下沉机制 ─────────┘
```

**胶水编程原则**：
- 每层只负责自身编码
- 复用底层 API，不重复造轮子
- 通过层间协议传递需求
- API 边界明确，无法实现时上报

---

## 五层架构

```
┌─────────────────────────────────────────────────────────────┐
│  Layer 5: 框架设计层 (verseFrameworkDesigner)              │
│  └── Entity树、Component清单、事件流图、依赖关系             │
├─────────────────────────────────────────────────────────────┤
│  Layer 4: 事件流层 (verseEventFlow)                        │
│  └── Scene Event设计、事件传播策略、生命周期编排             │
├─────────────────────────────────────────────────────────────┤
│  Layer 3: 组件层 (verseComponent)                           │
│  └── 自定义组件编写、Entity类封装、功能模块                  │
├─────────────────────────────────────────────────────────────┤
│  Layer 2: 操作层/Helper层 (verseHelpers)                    │
│  └── API封装、原子操作、高级函数                             │
├─────────────────────────────────────────────────────────────┤
│  Layer 1: 资产层 (verseAssets)                              │
│  └── Assets.digest解析、资产路径、占位接口                   │
└─────────────────────────────────────────────────────────────┘
```

### 需求下沉机制

当某层无法实现需求时：
1. 使用**请求模板**向下层发起需求
2. 下层提供所需函数/接口
3. 逐层下沉直到**操作层**
4. 操作层明确报告 **API缺失** 时终止
5. API缺失记录到 `@api-gaps.md` 供游戏设计参考

---

## 协调器 (Orchestrator)

[verseOrchestrator](verseOrchestrator/SKILL.md) 是整个体系的入口，负责任务流程管理。

### 五种运行模式

| 模式 | 说明 | 适用场景 |
|------|------|----------|
| **循环迭代模式** | 消化需求文档→自主实现→扩充代码库→循环 | 积累通用代码库 |
| **架构设计模式** | 对话式框架设计→发现问题→请求改进方向 | 新项目架构确定 |
| **分层执行模式** | 检测恢复检查点→上下文注入→跨对话恢复 | 大型任务分段执行 |
| **对话/自动切换** | 细粒度控制 vs 默认处理 | 灵活控制实现细节 |
| **改进模式** | 收集问题→调整Prompt→Skill自进化 | 持续优化Skill |

### 模式切换

```markdown
# 在对话中切换模式
"切换到架构设计模式"
"使用循环迭代模式"
"进入改进模式"
```

---

## 技能清单

### 核心技能

| 技能 | 层级 | 职责 |
|------|------|------|
| [verseOrchestrator](verseOrchestrator/SKILL.md) | 协调器 | 任务调度、模式管理、进度追踪 |
| [verseRequirementProposer](verseRequirementProposer/SKILL.md) | 需求层 | 生成有价值需求、优先级排序 |
| [verseFrameworkDesigner](verseFrameworkDesigner/SKILL.md) | Layer 5 | 架构设计、Entity/Component规划 |
| [verseEventFlow](verseEventFlow/SKILL.md) | Layer 4 | 事件系统设计、生命周期编排 |
| [verseComponent](verseComponent/SKILL.md) | Layer 3 | 组件编写、功能封装 |
| [verseHelpers](verseHelpers/SKILL.md) | Layer 2 | API封装、原子操作 |
| [verseAssets](verseAssets/SKILL.md) | Layer 1 | 资产管理、占位接口 |

### 工具技能

| 技能 | 类型 | 职责 |
|------|------|------|
| [verseCli](verseCli/SKILL.md) | 命令行工具 | 通过终端触发 UEFN 编译，支持监听模式 |

### 共享资源

| 目录 | 内容 |
|------|------|
| [shared/references/](shared/references/) | SceneGraph框架指南、API参考 |
| [shared/api-digests/](shared/api-digests/) | 三大核心API文件 (Verse/Fortnite/UnrealEngine) |
| [shared/memory-bank-template/](shared/memory-bank-template/) | Memory-Bank模板（持续进化） |
| [shared/request-templates/](shared/request-templates/) | 层间请求模板 |
| [shared/evolution-logs/](shared/evolution-logs/) | 自进化日志 |
| [shared/checklists/](shared/checklists/) | 架构检查清单 |

---

## 快速开始

### 1. 新项目架构设计

```markdown
# 启动协调器，选择架构设计模式
@verseOrchestrator 架构设计模式

# 描述你的游戏需求
我需要一个塔防游戏，包含：
- 防御塔建造系统
- 敌人生成和寻路
- 金币和升级系统
```

### 2. 实现特定功能

```markdown
# 使用分层执行模式
@verseOrchestrator 分层执行模式

# 描述功能需求
实现一个可交互的商店系统，玩家可以购买武器
```

### 3. 扩充代码库

```markdown
# 使用循环迭代模式
@verseOrchestrator 循环迭代模式

# 协调器会自动：
# 1. 读取 @pending-requirements.md
# 2. 选择优先级最高的需求
# 3. 调度各层Skill实现
# 4. 将代码加入 @code-library.md
```

---

## 自进化机制

### 问题收集

各层Skill在执行过程中发现的问题会记录到：

```
shared/evolution-logs/@issues-collected.md
```

**问题格式**：
```markdown
## Issue #001
- **Skill**: verseComponent
- **问题描述**: 组件生命周期钩子顺序不清晰
- **触发场景**: 创建需要初始化顺序的组件时
- **建议改进**: 在SKILL.md中添加生命周期流程图
```

### 改进触发

1. **累积阈值触发**: 问题累积到 N 个后，协调器提示进入改进模式
2. **用户主动触发**: 随时可以说"进入改进模式"

### Prompt安全边界

| 区域 | 内容 | 可否修改 |
|------|------|----------|
| **不可变区** | 核心职责、输出格式、层间协议 | ❌ 禁止 |
| **可变区** | 示例、检查项、提示语气、最佳实践 | ✅ 允许 |

---

## Memory-Bank模板进化

每次成功实现功能后，可选择更新模板：

```markdown
协调器: "本次实现了商店系统，是否更新Memory-Bank模板？"
用户: "是"
协调器: "已将商店系统的架构模式添加到模板中"
```

**模板文件**：
- `@architecture-blueprint.md` - 框架大纲模板
- `@checkpoint.md` - 恢复检查点模板
- `@code-library.md` - 代码库模板

---

## API Digest 文件

三大核心 API 文件位于 `shared/api-digests/`：

| 文件 | 行数 | 内容范围 |
|------|------|----------|
| `Verse.digest.verse` | ~2,400 | 语言核心、SceneGraph、Simulation |
| `Fortnite.digest.verse` | ~12,200 | UI、Devices、Characters、AI |
| `UnrealEngine.digest.verse` | ~1,400 | Itemization、SpatialMath、Widgets |

**版本**: `++Fortnite+Release-39.11-CL-49242330`

**更新来源**: [vz-creates/uefn](https://github.com/vz-creates/uefn)

---

## 相关资源

### 官方文档
- [SceneGraph 概述](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Scene Events 详解](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [Verse API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)

### 社区资源
- [Awesome Verse](https://github.com/spilth/awesome-verse)
- [UEFN Tools](https://uefntools.com/resources)

---

## 贡献指南

1. 遇到问题时，按格式记录到 `@issues-collected.md`
2. 实现新功能后，考虑更新 Memory-Bank 模板
3. 发现 API 缺失时，记录到 `@api-gaps.md`
4. 有价值的需求可添加到 `@pending-requirements.md`

---

*最后更新: 2025-12-27*
