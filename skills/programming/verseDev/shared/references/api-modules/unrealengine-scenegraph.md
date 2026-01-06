# UnrealEngine.com/SceneGraph API 模块详解

> **文档类型**: API 模块调研文档
> **目标平台**: UEFN (Unreal Editor for Fortnite)
> **模块路径**: `/UnrealEngine.com/SceneGraph`
> **最后更新**: 2026-01-04

---

## 文档说明

本文档基于 Epic Games 官方 API Digest (Build: ++Fortnite+Release-39.11-CL-49242330) 进行调研，
旨在澄清 `/UnrealEngine.com/SceneGraph` 模块的真实用途和能力边界，消除开发者对该模块的常见误解。

**重要发现**：
- ⚠️ `/UnrealEngine.com/SceneGraph` 是一个**空模块**，不包含任何实际的类、接口或函数
- ✅ 实际的 SceneGraph 功能全部位于 `/Verse.org/SceneGraph` 模块中
- 🎯 该模块存在的目的可能是为了命名空间占位或未来扩展预留

---

## 目录

1. [模块概述](#模块概述)
2. [核心类/接口清单](#核心类接口清单)
3. [与 Verse.org/SceneGraph 的关系](#与-verseorgscenegraph-的关系)
4. [常见误区澄清](#常见误区澄清)
5. [正确的使用方式](#正确的使用方式)
6. [参考资源](#参考资源)

---

## 模块概述

### 模块定义

根据官方 API Digest，`/UnrealEngine.com/SceneGraph` 模块的完整定义如下：

```verse
# Module import path: /UnrealEngine.com/SceneGraph
(/UnrealEngine.com:)SceneGraph<public> := module:
    using {/Verse.org/Native}
```

### 模块用途

从上述定义可以看出：

1. **模块为空**：除了导入 `/Verse.org/Native` 外，该模块不包含任何内容
2. **没有导出**：该模块没有导出任何类、接口、函数或常量
3. **命名空间占位**：该模块可能是为了保留 UnrealEngine 命名空间下的 SceneGraph 名称

### 设计理念

可能的设计理念包括：

- **命名空间管理**：在 UnrealEngine.com 命名空间下预留 SceneGraph 名称
- **未来扩展**：为将来可能添加的 Unreal Engine 特有的 SceneGraph 功能预留空间
- **架构清晰性**：明确区分不同层级的 API（Verse.org vs UnrealEngine.com）

### 适用场景

**当前版本**：该模块不适用于任何实际开发场景，因为它不包含任何可用的 API。

**未来可能**：如果 Epic Games 在未来版本中向该模块添加内容，它可能用于：
- Unreal Engine 特有的场景图扩展
- 与 UE5 引擎深度集成的场景管理功能
- 区别于 Verse 标准 SceneGraph 的高级特性

---

## 核心类/接口清单

### 当前版本 (Build: ++Fortnite+Release-39.11-CL-49242330)

**类数量**: 0
**接口数量**: 0
**枚举数量**: 0
**函数数量**: 0

**结论**: 该模块当前版本完全为空，不包含任何可用的 API 元素。

---

## 与 Verse.org/SceneGraph 的关系

### 对比分析

| 特性 | `/UnrealEngine.com/SceneGraph` | `/Verse.org/SceneGraph` |
|------|--------------------------------|-------------------------|
| **模块状态** | 空模块 | 功能完整 |
| **类数量** | 0 | 50+ |
| **核心类** | 无 | `entity`, `component`, `scene_event` |
| **代码行数** | 2 行 | 983 行 |
| **实际用途** | 无 | Entity-Component-Event 架构核心 |
| **导入依赖** | `/Verse.org/Native` | `/Verse.org/Simulation` |

### 功能边界

```
┌─────────────────────────────────────────────────────────────┐
│                  SceneGraph 功能分布                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  /Verse.org/SceneGraph (983 行代码)                         │
│  ├── entity 类 - 实体系统核心                                │
│  ├── component 类 - 组件基类                                 │
│  ├── scene_event 接口 - 事件系统                             │
│  ├── interactable_component - 交互组件                       │
│  ├── light_component - 光照组件族                            │
│  ├── mesh_component - 网格组件                               │
│  ├── audio_component - 音频组件                              │
│  └── 50+ 其他组件和工具类                                    │
│                                                              │
│  /UnrealEngine.com/SceneGraph (2 行代码)                    │
│  └── (空) - 仅导入 /Verse.org/Native                        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 依赖关系

```
Verse 代码
    │
    ├── using {/Verse.org/SceneGraph}         ← ✅ 正确的导入
    │       │
    │       └── 获得完整的 SceneGraph 功能
    │
    └── using {/UnrealEngine.com/SceneGraph}  ← ⚠️ 导入了空模块
            │
            └── 仅获得 /Verse.org/Native 的间接访问
```

---

## 常见误区澄清

### 误区 1: 认为该模块包含 UE 特有的 SceneGraph 功能

**错误认知**：
```verse
# ❌ 错误假设
using {/UnrealEngine.com/SceneGraph}

MyComponent := class(component):  # 期望使用 UE 特有的组件基类
    # ...
```

**真实情况**：
- `/UnrealEngine.com/SceneGraph` 模块不包含任何组件基类
- 所有组件基类都在 `/Verse.org/SceneGraph` 中定义

**正确做法**：
```verse
# ✅ 正确导入
using {/Verse.org/SceneGraph}

MyComponent := class(component):  # 使用 Verse.org 的组件基类
    # ...
```

### 误区 2: 认为需要同时导入两个 SceneGraph 模块

**错误认知**：
```verse
# ❌ 错误假设
using {/Verse.org/SceneGraph}
using {/UnrealEngine.com/SceneGraph}  # 认为需要额外导入

MyEntity := class(entity):
    # ...
```

**真实情况**：
- 只需要导入 `/Verse.org/SceneGraph` 即可
- 导入 `/UnrealEngine.com/SceneGraph` 不会提供任何额外功能

**正确做法**：
```verse
# ✅ 正确导入
using {/Verse.org/SceneGraph}

MyEntity := class(entity):
    # ...
```

### 误区 3: 认为该模块提供了底层引擎访问

**错误认知**：
- 认为 `/UnrealEngine.com/SceneGraph` 提供了对 Unreal Engine 底层场景图的直接访问
- 认为可以通过该模块操作 UE5 的原生场景节点

**真实情况**：
- 该模块完全为空，不提供任何引擎访问功能
- Verse 的 SceneGraph 是一个独立的抽象层，不直接映射到 UE5 场景图

**正确理解**：
- Verse SceneGraph 是 UEFN 特有的 Entity-Component 架构
- 它运行在 Verse VM 中，与 UE5 原生场景图是不同的系统
- 两者之间的交互由 UEFN 运行时自动处理

### 误区 4: 认为该模块是必需的依赖

**错误认知**：
```verse
# ❌ 错误假设
# 认为必须导入此模块才能使用 SceneGraph 功能
using {/UnrealEngine.com/SceneGraph}
using {/Verse.org/SceneGraph}
```

**真实情况**：
- `/UnrealEngine.com/SceneGraph` 不是任何功能的必需依赖
- 所有 SceneGraph 开发只需要 `/Verse.org/SceneGraph`

**正确做法**：
```verse
# ✅ 正确导入
using {/Verse.org/SceneGraph}
# 无需导入 UnrealEngine.com/SceneGraph
```

---

## 正确的使用方式

### 1. SceneGraph 开发的标准导入

对于所有 SceneGraph 相关开发，使用以下导入：

```verse
using {/Verse.org/SceneGraph}
using {/Verse.org/Simulation}  # 如需要 agent, simulation 等
using {/Verse.org/SpatialMath}  # 如需要 transform, vector3 等
```

### 2. Entity-Component 开发示例

```verse
using {/Verse.org/SceneGraph}
using {/Verse.org/Simulation}

# 定义自定义组件
health_component := class(component):
    var CurrentHealth:int = 100
    var MaxHealth:int = 100
    
    OnBeginSimulation<override>():void =
        Print("Health component initialized")
    
    TakeDamage(Amount:int):void =
        set CurrentHealth = Max(0, CurrentHealth - Amount)
        if CurrentHealth = 0 then
            OnDeath()
    
    OnDeath():void =
        Print("Entity died")

# 创建实体并添加组件
CreatePlayer():entity =
    PlayerEntity := entity{}
    HealthComp := health_component{}
    PlayerEntity.AddComponents(array{HealthComp})
    PlayerEntity
```

### 3. 事件系统使用示例

```verse
using {/Verse.org/SceneGraph}

# 定义自定义事件
damage_event := class(scene_event):
    Amount<public>:int
    Source<public>:entity

# 在组件中处理事件
damageable_component := class(component):
    
    SendDown<override>(SceneEvent:scene_event):logic =
        if DamageEvent := damage_event[SceneEvent] then
            HandleDamage(DamageEvent)
            true  # 消费事件
        else
            false  # 不处理，继续传播
    
    HandleDamage(Event:damage_event):void =
        Print("Received {Event.Amount} damage")
```

### 4. 实体层级管理

```verse
using {/Verse.org/SceneGraph}

# 构建父子层级
CreateVehicleWithParts():entity =
    # 主车辆实体
    VehicleEntity := entity{}
    
    # 创建子实体（车轮）
    Wheel1 := entity{}
    Wheel2 := entity{}
    Wheel3 := entity{}
    Wheel4 := entity{}
    
    # 添加子实体
    VehicleEntity.AddEntities(array{Wheel1, Wheel2, Wheel3, Wheel4})
    
    # 查询子实体
    Wheels := VehicleEntity.GetEntities()
    Print("Vehicle has {Wheels.Length} wheels")
    
    VehicleEntity
```

---

## 最佳实践

### 1. 始终使用 Verse.org/SceneGraph

**推荐**：
```verse
using {/Verse.org/SceneGraph}
```

**避免**：
```verse
using {/UnrealEngine.com/SceneGraph}  # 无意义的导入
```

### 2. 理解模块的实际内容

在使用任何 API 模块前，建议：

1. 查阅官方 API Digest 文件
2. 确认模块实际包含的类和函数
3. 避免基于命名假设模块功能

### 3. 关注官方文档更新

由于 UEFN 仍在快速迭代：

- 定期检查 API Digest 的更新
- 关注 Epic Games 的发布说明
- `/UnrealEngine.com/SceneGraph` 未来可能会添加内容

### 4. 使用正确的架构模式

```verse
# ✅ 推荐的 SceneGraph 架构模式
using {/Verse.org/SceneGraph}
using {/Verse.org/Simulation}

# 1. 定义组件（封装行为和数据）
my_component := class(component):
    # 组件逻辑

# 2. 定义实体预制件（组合多个组件）
my_prefab := class(entity):
    # 构造函数中添加组件

# 3. 在游戏管理器中创建和管理实体
game_manager := class(component):
    OnBeginSimulation<override>():void =
        SpawnEntity()
    
    SpawnEntity():void =
        NewEntity := my_prefab{}
        # Entity 是 component 基类的属性，指向该组件的父实体
        Entity.AddEntities(array{NewEntity})
```

---

## 代码示例：完整的 SceneGraph 组件

以下示例展示如何正确使用 `/Verse.org/SceneGraph` 创建功能完整的组件：

```verse
using {/Verse.org/SceneGraph}
using {/Verse.org/Simulation}

# 可收集物品组件
collectible_component := class(component):
    # 物品价值
    @editable
    var Value<public>:int = 10
    
    # 是否已被收集
    var<private> IsCollected:logic = false
    
    # 组件开始模拟时的初始化
    OnBeginSimulation<override>():void =
        Print("Collectible spawned with value: {Value}")
    
    # 收集物品的方法
    Collect(Collector:agent):void =
        if not IsCollected then
            set IsCollected = true
            OnCollected(Collector)
    
    # 收集成功的回调
    OnCollected(Collector:agent):void =
        Print("Item collected by agent")
        # Entity 是 component 基类的属性，指向该组件的父实体
        # 可以在这里发送事件通知其他系统
        CollectedEvent := collectible_collected_event{
            Collector := Collector,
            Value := Value
        }
        Entity.SendUp(CollectedEvent)
        
        # 从场景中移除实体
        Entity.RemoveFromParent()

# 收集事件
collectible_collected_event := class(scene_event):
    Collector<public>:agent
    Value<public>:int

# 收集管理器组件（监听收集事件）
collection_manager := class(component):
    var<private> TotalScore:int = 0
    
    OnBeginSimulation<override>():void =
        Print("Collection manager initialized")
    
    # 处理收集事件
    SendDown<override>(SceneEvent:scene_event):logic =
        if Event := collectible_collected_event[SceneEvent] then
            HandleCollected(Event)
            true  # 消费事件
        else
            false
    
    HandleCollected(Event:collectible_collected_event):void =
        set TotalScore += Event.Value
        Print("Total score: {TotalScore}")
```

---

## 性能优化建议

虽然 `/UnrealEngine.com/SceneGraph` 本身为空，但使用 `/Verse.org/SceneGraph` 时需要注意：

### 1. 组件查询优化

```verse
# ❌ 避免在每帧查询
OnSimulate<override>()<suspends>:void =
    loop:
        # Entity 是 component 基类的属性，指向该组件的父实体
        if HealthComp := Entity.GetComponent[health_component][] then
            # 每帧都查询，性能差
            CurrentHP := HealthComp.CurrentHealth
            Print("Current Health: {CurrentHP}")
        Sleep(0.0)

# ✅ 在初始化时缓存组件引用
var<private> CachedHealthComp:?health_component = false

OnBeginSimulation<override>():void =
    # Entity 是 component 基类的属性，指向该组件的父实体
    set CachedHealthComp = Entity.GetComponent[health_component][]

OnSimulate<override>()<suspends>:void =
    if HealthComp := CachedHealthComp? then
        loop:
            CurrentHP := HealthComp.CurrentHealth
            Print("Current Health: {CurrentHP}")
            Sleep(0.0)
```

### 2. 事件系统性能

```verse
# ✅ 事件处理应该快速完成
SendDown<override>(SceneEvent:scene_event):logic =
    if MyEvent := my_event[SceneEvent] then
        # 快速处理，不要阻塞
        HandleEventQuickly(MyEvent)
        true
    else
        false

# ❌ 避免在事件处理中执行耗时操作
SendDown<override>(SceneEvent:scene_event):logic =
    if MyEvent := my_event[SceneEvent] then
        # 不要在这里执行复杂计算或 suspends 操作
        ExpensiveOperation()  # 会阻塞事件系统
        true
    else
        false
```

### 3. 实体层级深度控制

```verse
# ✅ 保持合理的层级深度（建议 < 5 层）
Root
├── Level1_A
│   ├── Level2_A1
│   └── Level2_A2
└── Level1_B

# ❌ 避免过深的层级（性能和维护性差）
Root
├── L1
    └── L2
        └── L3
            └── L4
                └── L5
                    └── L6  # 太深了
```

---

## 参考资源

### 官方文档

| 资源 | 链接 |
|------|------|
| Scene Graph 官方文档 | <https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite> |
| SceneGraph 快速入门 | <https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite> |
| Verse API 参考 | <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api-reference> |
| entity 类文档 | <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity> |
| component 类文档 | <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component> |

### 相关 API 模块

| 模块路径 | 说明 |
|---------|------|
| `/Verse.org/SceneGraph` | ✅ SceneGraph 功能的实际位置 |
| `/Verse.org/Simulation` | 提供 agent, simulation 等类型 |
| `/Verse.org/SpatialMath` | 提供空间数学类型（transform, vector3 等） |
| `/UnrealEngine.com/SceneGraph` | ⚠️ 空模块，无实际功能 |

### 本仓库相关文档

| 文档 | 路径 |
|------|------|
| SceneGraph 框架详解 | `skills/programming/verseDev/shared/references/scenegraph-framework-guide.md` |
| SceneGraph API 参考手册 | `skills/programming/verseDev/shared/references/scenegraph-api-reference.md` |
| API 模块清单 | `skills/programming/verseDev/shared/references/api-modules-list.md` |
| API 模块能力调研 | `skills/programming/verseDev/shared/references/api-modules-research.md` |
| Verse API Digest | `skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md` |
| UnrealEngine API Digest | `skills/programming/verseDev/shared/api-digests/UnrealEngine.digest.verse.md` |

---

## 总结

### 关键要点

1. **`/UnrealEngine.com/SceneGraph` 是空模块** - 当前版本不包含任何可用 API
2. **所有 SceneGraph 功能在 `/Verse.org/SceneGraph`** - 这是开发的唯一正确选择
3. **不要基于命名假设功能** - 始终查阅官方 API Digest 确认实际内容
4. **关注未来更新** - 该模块可能在未来版本中添加内容

### 开发建议

```verse
# 标准的 SceneGraph 开发模板
using {/Verse.org/SceneGraph}      # ✅ 必需
using {/Verse.org/Simulation}      # ✅ 如需要 agent 等类型
using {/Verse.org/SpatialMath}     # ✅ 如需要空间数学
# using {/UnrealEngine.com/SceneGraph}  # ❌ 不需要

my_game_component := class(component):
    OnBeginSimulation<override>():void =
        # 游戏逻辑
```

### 后续研究方向

1. 监控 Epic Games 的 API Digest 更新
2. 如果 `/UnrealEngine.com/SceneGraph` 添加了内容，更新本文档
3. 深入研究 `/Verse.org/SceneGraph` 的高级用法
4. 探索 SceneGraph 与其他系统（如 Devices, Itemization）的集成

---

**文档版本**: 1.0.0
**基于 API Build**: ++Fortnite+Release-39.11-CL-49242330
**作者**: Copilot Agent
**最后更新**: 2026-01-04
