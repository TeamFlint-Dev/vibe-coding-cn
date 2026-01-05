# UEFN 玩家检测与追踪实现路径调研报告

> **文档类型**: 技术调研报告 - 实现路径分析
> **调研范围**: Scene Graph 体系、Device 体系及混合方案
> **目标读者**: UEFN/Verse 游戏开发者
> **最后更新**: 2026-01-05

---

## 文档说明

本文档围绕**玩家检测与追踪**功能,深入调研 UEFN 中两大技术体系的实现路径:

- **Scene Graph 体系**: 基于 Entity 组件化架构的现代化方案
- **Device 体系**: 基于传统设备系统的成熟方案
- **混合方案**: 结合两者优势的实战策略

**核心焦点**:

1. 玩家出现/离开检测机制
2. 玩家状态变更监听
3. 技术方案能力边界对比
4. 典型场景推荐与代码实现
5. 已知限制、常见坑点及规避建议

**重要提示**:

- ✅ 所有 API 引用来自 Epic Games 官方文档
- ⚠️ Scene Graph 当前为 Beta 功能,发布前需禁用
- 🔄 Device 体系更成熟稳定,推荐生产环境优先使用
- 🎯 建议根据项目复杂度选择合适方案

---

## 目录

1. [核心流程分解](#核心流程分解)
2. [技术方案对比](#技术方案对比)
3. [Scene Graph 方案详解](#scene-graph-方案详解)
4. [Device 方案详解](#device-方案详解)
5. [混合方案设计](#混合方案设计)
6. [代码实现骨架](#代码实现骨架)
7. [已知限制与规避](#已知限制与规避)
8. [最佳实践建议](#最佳实践建议)
9. [参考资源](#参考资源)

---

## 核心流程分解

### 玩家检测的三大核心场景

#### 1. 玩家进入/离开区域检测

**业务需求**:

- 玩家进入特定区域触发事件(如:进入安全区、触发陷阱)
- 玩家离开区域触发事件(如:离开商店、离开战斗区)
- 实时查询区域内玩家列表

**核心挑战**:

- 精确的空间边界定义
- 高频率玩家位置变化的性能优化
- 多玩家同时进出的事件处理顺序

#### 2. 玩家状态变更监听

**业务需求**:

- 玩家生命值变化(受伤/治疗)
- 玩家装备变化(拾取/丢弃物品)
- 玩家行为状态(跳跃/冲刺/蹲下)
- 玩家游戏状态(淘汰/重生)

**核心挑战**:

- 状态变更事件的及时性
- 多种状态的统一管理
- 状态变更的可靠通知机制

#### 3. 玩家交互行为检测

**业务需求**:

- 玩家与按钮/开关交互
- 玩家拾取物品
- 玩家使用技能
- 玩家视线检测(看向某物体)

**核心挑战**:

- 交互行为的优先级处理
- 交互反馈的即时性
- 复杂交互逻辑的解耦

---

## 技术方案对比

### 方案概览表

| 维度 | Scene Graph 方案 | Device 方案 | 混合方案 |
|------|-----------------|------------|---------|
| **技术基础** | Entity 组件 + 碰撞检测 | trigger_device 等设备 | 两者结合 |
| **成熟度** | ⚠️ Beta (实验性) | ✅ 稳定成熟 | ⚖️ 取决于组合 |
| **学习曲线** | 陡峭 (需理解 ECS) | 平缓 (编辑器配置) | 中等 |
| **灵活性** | ✅ 极高 (运行时动态) | ⚖️ 中等 (部分可编程) | ✅ 高 |
| **性能** | ⚖️ 依赖实现质量 | ✅ 优化良好 | ⚖️ 需权衡 |
| **代码复杂度** | 高 (需手写组件逻辑) | 低 (设备封装好) | 中 |
| **发布限制** | ❌ 需禁用 SceneGraph | ✅ 无限制 | ⚠️ 部分受限 |
| **适用项目** | 复杂系统、模块化需求高 | 快速原型、简单交互 | 大型项目 |

### 能力边界对比

#### Scene Graph 方案

**能做的事 (绿灯区)**:

- ✅ **精确碰撞检测**: `FindOverlapHits()` 可检测任意形状碰撞
- ✅ **射线扫描**: `FindSweepHits()` 支持视线检测、路径预测
- ✅ **动态组件添加**: 运行时添加/移除检测组件
- ✅ **自定义碰撞形状**: box、sphere、capsule 任意组合
- ✅ **碰撞通道分层**: 区分玩家、敌人、道具等不同碰撞类型
- ✅ **完全代码驱动**: 所有逻辑可通过 Verse 控制
- ✅ **事件驱动架构**: SendUp/SendDown/SendDirect 灵活通信

**不能做/有限制的事 (红灯区)**:

- ❌ **无内置区域进入/离开事件**: 需要手动实现持续检测逻辑
- ❌ **发布前必须禁用**: Beta 功能限制
- ⚠️ **性能需自己优化**: 高频碰撞检测需要合理设计
- ⚠️ **调试难度高**: 碰撞可视化需额外工具
- ⚠️ **文档相对较少**: 社区案例不如 Device 丰富

**官方文档**:

- [FindOverlapHits API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)
- [Collision Profiles](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/collisionprofiles)

#### Device 方案

**能做的事 (绿灯区)**:

- ✅ **开箱即用的区域检测**: `trigger_device` 自动监听进入/离开
- ✅ **丰富的内置事件**: `AgentEntersEvent`, `AgentExitsEvent` 等
- ✅ **编辑器可视化配置**: 所见即所得的区域设置
- ✅ **生产环境稳定**: 无发布限制,性能优化良好
- ✅ **多种触发类型**:
  - `trigger_device` - 基础区域触发
  - `perception_trigger_device` - 视线检测
  - `input_trigger_device` - 输入检测
  - `mutator_zone_device` - 改变玩家属性的区域
  - `damage_volume_device` - 伤害区域
  - `capture_area_device` - 占领区域
- ✅ **查询区域内玩家**: `GetAgentsInVolume()` 直接返回列表
- ✅ **丰富的社区案例**: 成熟的最佳实践

**不能做/有限制的事 (红灯区)**:

- ❌ **运行时动态创建设备**: 必须在编辑器中预先放置
- ❌ **灵活的碰撞形状**: 只能使用预定义形状(圆柱、方盒)
- ⚠️ **代码控制受限**: 部分属性无法通过 Verse 修改
- ⚠️ **设备数量限制**: 过多设备可能影响性能
- ⚠️ **依赖编辑器配置**: 纯代码项目不适用

**官方文档**:

- [trigger_device API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_device)
- [perception_trigger_device API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/perception_trigger_device)
- [Trigger Device Tutorial](https://dev.epicgames.com/documentation/en-us/uefn/trigger-device-in-verse)

---

## Scene Graph 方案详解

### 方案架构

**核心组件**:

1. **Entity (实体)**: 玩家检测区域的容器
2. **mesh_component (网格组件)**: 定义碰撞形状
3. **collision_profile (碰撞配置)**: 设置碰撞行为
4. **自定义 component**: 实现检测逻辑

**工作原理**:

```
玩家移动
    ↓
OnSimulate() 每帧检测
    ↓
Entity.FindOverlapHits()
    ↓
对比上一帧结果
    ↓
触发 EnterEvent / ExitEvent
```

### 关键 API

#### 1. 碰撞检测 API

```verse
# 查找当前重叠的所有对象
Entity.FindOverlapHits()<transacts>: generator(overlap_hit)

# 查找指定变换位置的重叠对象
Entity.FindOverlapHits(GlobalTransform: transform)<transacts>: generator(overlap_hit)

# 使用自定义碰撞体积查找重叠
Entity.FindOverlapHits(
    GlobalTransform: transform,
    Volume: collision_volume
)<transacts>: generator(overlap_hit)

# 扫描检测 (射线检测)
Entity.FindSweepHits(Displacement: vector3)<transacts>: generator(sweep_hit)
```

#### 2. 碰撞配置

**内置碰撞通道**:

```verse
using { /Verse.org/SceneGraph/CollisionChannels }

avatar     # 玩家通道
dynamic    # 动态物体
stationary # 静态物体
visibility # 可见性检测
camera     # 相机通道
physics    # 物理通道
```

**内置碰撞配置文件**:

```verse
using { /Verse.org/SceneGraph/CollisionProfiles }

DynamicOverlapAll     # 动态物体,与所有重叠
StationaryBlockAll    # 静态物体,阻挡所有
VisibilityOverlapAll  # 可见性测试,与所有重叠
```

### 实现流程

#### 步骤 1: 创建检测区域 Entity

```verse
# 自定义玩家检测区域 Entity
player_detection_zone_entity := class(entity):
    var ZoneRadius<private>:float = 5.0
    var ZoneName<private>:string = "未命名区域"
    var PlayersInZone<private>:[]agent = array{}
    
    Initialize(Name:string, Radius:float):void =
        ZoneName = Name
        ZoneRadius = Radius
        
        # 添加检测组件
        DetectionComponent := player_detection_component{
            Radius := Radius
        }
        AddComponents(array{DetectionComponent})
```

#### 步骤 2: 实现检测组件

```verse
using { /Verse.org/SceneGraph }
using { /Verse.org/SceneGraph/CollisionChannels }
using { /Verse.org/Simulation }

player_detection_component := class(component):
    var Radius:float = 5.0
    var CurrentPlayers<private>:[]agent = array{}
    var CheckInterval:float = 0.1  # 每 0.1 秒检测一次
    
    # 进入事件
    PlayerEnteredEvent<private>:event(agent) = event(agent){}
    
    # 离开事件
    PlayerExitedEvent<private>:event(agent) = event(agent){}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 必须的帧延迟
        
        # 启动检测循环
        spawn:
            DetectionLoop()
    
    DetectionLoop()<suspends>:void =
        loop:
            PerformDetection()
            Sleep(CheckInterval)
    
    PerformDetection()<transacts>:void =
        # 获取所有者 Entity
        if (Owner := GetOwner[entity]):
            # 查找重叠的对象
            OverlapHits := Owner.FindOverlapHits()
            
            # 提取玩家 agents
            NewPlayers := array{}
            for (Hit : OverlapHits):
                if (HitAgent := agent[Hit.HitEntity]):
                    set NewPlayers += array{HitAgent}
            
            # 检测新进入的玩家
            for (Player : NewPlayers):
                if (not CurrentPlayers.Contains[Player]):
                    PlayerEnteredEvent.Signal(Player)
                    Print("玩家 {Player} 进入区域")
            
            # 检测离开的玩家
            for (Player : CurrentPlayers):
                if (not NewPlayers.Contains[Player]):
                    PlayerExitedEvent.Signal(Player)
                    Print("玩家 {Player} 离开区域")
            
            # 更新当前玩家列表
            set CurrentPlayers = NewPlayers
    
    # 公开的订阅接口
    SubscribeOnPlayerEntered(Callback:(agent) -> void):void =
        PlayerEnteredEvent.Subscribe(Callback)
    
    SubscribeOnPlayerExited(Callback:(agent) -> void):void =
        PlayerExitedEvent.Subscribe(Callback)
    
    # 查询当前区域内的玩家
    GetPlayersInZone():[]agent = CurrentPlayers
```

#### 步骤 3: 配置碰撞形状和配置文件

```verse
# 在编辑器中或代码中设置碰撞形状
# 使用基础形状组件 (来自 /UnrealEngine.com/BasicShapes)
using { /UnrealEngine.com/BasicShapes }

CreateDetectionZone(Radius:float):entity =
    # 创建 Entity
    Zone := player_detection_zone_entity{}
    Zone.Initialize("安全区", Radius)
    
    # 添加碰撞形状 (球体)
    CollisionShape := sphere{}
    # 设置碰撞配置为 Overlap (重叠检测)
    # 注意: 具体配置方法取决于 UEFN 版本和 API 更新
    
    Zone.AddComponents(array{CollisionShape})
    
    return Zone
```

### 优势与局限

**优势**:

- ✅ 完全自定义的检测逻辑
- ✅ 运行时动态调整检测范围
- ✅ 支持任意复杂形状的碰撞检测
- ✅ 可与其他 Scene Graph 组件无缝集成

**局限**:

- ⚠️ 需要手动实现进入/离开检测逻辑
- ⚠️ 性能优化需要开发者自己负责
- ⚠️ Beta 功能,发布前需禁用
- ⚠️ 调试困难,需要额外的可视化工具

---

## Device 方案详解

### 方案架构

**核心设备**:

1. **trigger_device**: 基础触发器,检测玩家进入/离开
2. **perception_trigger_device**: 视线感知触发器
3. **mutator_zone_device**: 改变玩家属性的区域
4. **damage_volume_device**: 伤害区域
5. **capture_area_device**: 占领区域

**工作原理**:

```
玩家移动进入设备区域
    ↓
设备内部自动检测 (引擎级)
    ↓
触发 TriggeredEvent / AgentEntersEvent
    ↓
Verse 代码订阅事件并处理
```

### 关键 API

#### 1. trigger_device (基础触发器)

**核心事件**:

```verse
trigger_device<public> := class<concrete><final>(trigger_base_device):
    # 触发事件 (玩家进入触发器时)
    TriggeredEvent<public>: listenable(?agent)
    
    # 手动触发
    Trigger<public>(): void
    Trigger<public>(Agent: agent): void
```

**使用方法**:

```verse
# 在编辑器中放置 trigger_device,在 Verse 中获取引用
@editable
var PlayerDetectionTrigger:trigger_device = trigger_device{}

OnBegin<override>()<suspends>:void =
    # 订阅触发事件
    PlayerDetectionTrigger.TriggeredEvent.Subscribe(OnPlayerEnter)

OnPlayerEnter(MaybeAgent:?agent):void =
    if (Player := MaybeAgent?):
        Print("玩家 {Player} 触发了触发器")
        # 处理玩家进入逻辑
```

**限制**:

- ❌ `trigger_device` 只提供"触发"事件,**不区分进入和离开**
- ❌ 无法直接查询当前区域内的玩家列表
- ✅ 需要配合其他设备或自己维护状态

#### 2. mutator_zone_device (变异区域)

**核心事件**:

```verse
mutator_zone_device<public> := class<concrete><final>(creative_device_base):
    # 玩家进入区域事件
    AgentEntersEvent<public>: listenable(agent)
    
    # 玩家离开区域事件
    AgentExitsEvent<public>: listenable(agent)
    
    # 查询区域内的玩家
    GetAgentsInVolume<public>()<reads>: []agent
    
    # 检查玩家是否在区域内
    IsInVolume<public>(Agent: agent)<transacts><decides>: void
```

**使用方法**:

```verse
@editable
var SafeZone:mutator_zone_device = mutator_zone_device{}

OnBegin<override>()<suspends>:void =
    # 订阅进入事件
    SafeZone.AgentEntersEvent.Subscribe(OnPlayerEnterSafeZone)
    
    # 订阅离开事件
    SafeZone.AgentExitsEvent.Subscribe(OnPlayerExitSafeZone)

OnPlayerEnterSafeZone(Player:agent):void =
    Print("玩家 {Player} 进入安全区")
    # 应用安全区效果 (设备自动处理属性变更)

OnPlayerExitSafeZone(Player:agent):void =
    Print("玩家 {Player} 离开安全区")
    # 移除安全区效果

# 实时查询区域内玩家
GetPlayersInSafeZone():[]agent =
    SafeZone.GetAgentsInVolume()
```

**优势**:

- ✅ **开箱即用**: 自动检测进入/离开,无需手动轮询
- ✅ **性能优化好**: 引擎级优化,无需担心性能问题
- ✅ **实时查询**: `GetAgentsInVolume()` 直接返回当前玩家列表
- ✅ **可视化配置**: 编辑器中拖拽调整区域大小

#### 3. perception_trigger_device (视线感知触发器)

**核心事件**:

```verse
perception_trigger_device<public> := class<concrete><final>(trigger_base_device):
    # 玩家看向设备时
    AgentLooksAtDeviceEvent<public>: listenable(agent)
    
    # 玩家看向别处时
    AgentLooksAwayFromDeviceEvent<public>: listenable(agent)
    
    # 设备看到玩家时
    DeviceSeesAgentEvent<public>: listenable(agent)
    
    # 设备失去玩家视线时
    DeviceLosesSightOfAgentEvent<public>: listenable(agent)
    
    # 查询正在看向设备的玩家
    GetLookingAtDeviceAgents<public>()<reads>: []agent
    
    # 查询被设备感知到的玩家
    GetPerceivedAgents<public>()<reads>: []agent
```

**使用场景**:

- 敌人 AI 的视线检测
- 玩家注视触发剧情
- 隐身/潜行机制

**使用方法**:

```verse
@editable
var EnemySensor:perception_trigger_device = perception_trigger_device{}

OnBegin<override>()<suspends>:void =
    # 敌人发现玩家
    EnemySensor.DeviceSeesAgentEvent.Subscribe(OnEnemySeesPlayer)
    
    # 敌人失去玩家视线
    EnemySensor.DeviceLosesSightOfAgentEvent.Subscribe(OnEnemyLosesPlayer)

OnEnemySeesPlayer(Player:agent):void =
    Print("敌人发现了玩家 {Player}!")
    # 触发追击逻辑

OnEnemyLosesPlayer(Player:agent):void =
    Print("敌人失去了玩家 {Player} 的视线")
    # 触发搜索逻辑
```

#### 4. capture_area_device (占领区域)

**核心事件**:

```verse
capture_area_device<public> := class<concrete><final>(creative_device_base):
    # 玩家进入占领区域
    AgentEntersEvent<public>: listenable(agent)
    
    # 玩家离开占领区域
    AgentExitsEvent<public>: listenable(agent)
    
    # 第一个玩家进入
    FirstAgentEntersEvent<public>: listenable(agent)
    
    # 区域被占领
    AreaIsScoredEvent<public>: listenable(agent)
    
    # 区域被争夺
    AreaIsContestedEvent<public>: listenable(agent)
    
    # 控制权变更
    ControlChangeEvent<public>: listenable(agent)
    
    # 查询区域内玩家
    GetAgentsInVolume<public>()<reads>: []agent
    
    # 获取区域半径和高度
    GetRadius<public>()<reads>: float
    GetHeight<public>()<reads>: float
```

**适用场景**:

- 据点占领玩法
- 团队对抗区域
- 领地争夺系统

### 设备选择指南

| 需求 | 推荐设备 | 原因 |
|------|---------|------|
| **简单区域触发** | `trigger_device` | 最轻量,适合一次性触发 |
| **进入/离开检测** | `mutator_zone_device` | 有完整的进入/离开事件 |
| **视线检测** | `perception_trigger_device` | 专门用于视线感知 |
| **占领玩法** | `capture_area_device` | 内置占领逻辑 |
| **伤害区域** | `damage_volume_device` | 自动处理伤害 |
| **改变玩家属性** | `mutator_zone_device` | 可配置速度、跳跃等属性 |

---

## 混合方案设计

### 为什么需要混合方案

**单一方案的局限**:

- **纯 Scene Graph**: 发布受限,开发成本高
- **纯 Device**: 灵活性不足,无法运行时动态创建

**混合方案的优势**:

- ✅ 用 Device 处理核心检测逻辑 (稳定可靠)
- ✅ 用 Scene Graph 实现复杂的玩家状态管理 (灵活强大)
- ✅ 两者通过事件系统解耦通信
- ✅ 可发布 (只使用 Device 作为检测器)

### 混合架构设计

**架构图**:

```
Device 层 (检测器)
    ├── mutator_zone_device (进入/离开检测)
    ├── perception_trigger_device (视线检测)
    └── 触发 Verse 事件
         ↓
Scene Graph 层 (状态管理)
    ├── player_tracker_component (玩家追踪组件)
    ├── zone_manager_entity (区域管理实体)
    └── 通过 Scene Events 通知其他系统
         ↓
游戏逻辑层
    └── 响应玩家进入/离开,执行游戏逻辑
```

### 实现示例:安全区系统

**需求**:

- 玩家进入安全区时,不受怪物攻击
- 玩家离开安全区时,恢复正常
- 显示区域内玩家数量
- 支持多个安全区,统一管理

**实现**:

#### 步骤 1: Device 层 - 检测器

```verse
# 在编辑器中放置 mutator_zone_device
@editable
var SafeZoneDetector:mutator_zone_device = mutator_zone_device{}
```

#### 步骤 2: Scene Graph 层 - 状态管理

```verse
using { /Verse.org/SceneGraph }
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# 安全区管理器组件
safe_zone_manager_component := class(component):
    var PlayersInZone<private>:[]agent = array{}
    var ZoneName:string = "安全区"
    
    # 注入 Device 引用
    var Detector:mutator_zone_device = mutator_zone_device{}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 订阅 Device 事件
        Detector.AgentEntersEvent.Subscribe(OnPlayerEnter)
        Detector.AgentExitsEvent.Subscribe(OnPlayerExit)
    
    OnPlayerEnter(Player:agent):void =
        # 添加到列表
        set PlayersInZone += array{Player}
        
        Print("玩家进入 {ZoneName},当前人数: {PlayersInZone.Length}")
        
        # 通过 Scene Event 通知其他系统
        if (Owner := GetOwner[entity]):
            Event := player_entered_safe_zone_event{
                Player := Player,
                ZoneName := ZoneName
            }
            Owner.SendDown(Event)
    
    OnPlayerExit(Player:agent):void =
        # 从列表移除
        set PlayersInZone = PlayersInZone.Filter((P:agent):P <> Player)
        
        Print("玩家离开 {ZoneName},当前人数: {PlayersInZone.Length}")
        
        # 通过 Scene Event 通知其他系统
        if (Owner := GetOwner[entity]):
            Event := player_exited_safe_zone_event{
                Player := Player,
                ZoneName := ZoneName
            }
            Owner.SendDown(Event)
    
    # 查询接口
    GetPlayerCount():int = PlayersInZone.Length
    GetPlayers():[]agent = PlayersInZone

# 自定义 Scene Event
player_entered_safe_zone_event := class<concrete>(scene_event):
    var Player:agent
    var ZoneName:string

player_exited_safe_zone_event := class<concrete>(scene_event):
    var Player:agent
    var ZoneName:string
```

#### 步骤 3: 游戏逻辑层 - 响应事件

```verse
# 怪物 AI 组件 - 监听玩家进入安全区
monster_ai_component := class(component):
    var TargetPlayer:?agent = false
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 订阅根实体的 Scene Events
        if (Root := GetRootEntity()):
            # 通过 Scene Event 系统监听
            # 注意: 实际实现需要根据 SceneGraph 框架调整
    
    OnReceive<override>(Event:scene_event):logic =
        # 玩家进入安全区
        if (EnterEvent := player_entered_safe_zone_event[Event]):
            if (Target := TargetPlayer?, Target = EnterEvent.Player):
                Print("目标玩家进入安全区,停止追击")
                set TargetPlayer = false
                return true
        
        # 玩家离开安全区
        if (ExitEvent := player_exited_safe_zone_event[Event]):
            Print("玩家 {ExitEvent.Player} 离开安全区,可以攻击")
            return true
        
        return false
    
    GetRootEntity()<decides>:entity =
        if (Owner := GetOwner[entity]):
            CurrentEntity := Owner
            loop:
                if (Parent := CurrentEntity.GetParent()):
                    set CurrentEntity = Parent
                else:
                    return CurrentEntity
```

### 混合方案的最佳实践

1. **Device 作为数据源**: 所有位置/区域检测使用 Device
2. **Scene Graph 作为状态管理**: 复杂的玩家状态用组件管理
3. **事件驱动解耦**: Device 事件 → Scene Event → 游戏逻辑
4. **发布时禁用 SceneGraph**: 只保留 Device 逻辑,确保可发布

---

## 代码实现骨架

### 完整示例:玩家追踪系统

**功能需求**:

- 追踪所有进入特定区域的玩家
- 记录玩家进入/离开时间
- 提供查询接口:当前在线玩家、历史记录
- 支持多个追踪区域

#### 方案选择: Device 方案 (推荐生产环境)

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Time }

# 玩家记录数据结构
player_visit_record := struct<public>:
    Player:agent
    EnterTime:float
    ExitTime:?float = false
    StayDuration:float = 0.0

# 玩家追踪器
player_tracker_device := class<concrete>(creative_device):
    # 编辑器中配置的检测区域
    @editable
    var TrackingZone:mutator_zone_device = mutator_zone_device{}
    
    @editable
    var ZoneName:string = "追踪区域"
    
    # 当前在区域内的玩家
    var CurrentPlayers<private>:[]agent = array{}
    
    # 历史访问记录
    var VisitHistory<private>:[]player_visit_record = array{}
    
    OnBegin<override>()<suspends>:void =
        # 订阅区域事件
        TrackingZone.AgentEntersEvent.Subscribe(OnPlayerEnter)
        TrackingZone.AgentExitsEvent.Subscribe(OnPlayerExit)
        
        Print("{ZoneName} 追踪器已启动")
    
    OnPlayerEnter(Player:agent):void =
        CurrentTime := GetSimulationElapsedTime()
        
        # 添加到当前玩家列表
        set CurrentPlayers += array{Player}
        
        # 创建访问记录
        Record := player_visit_record{
            Player := Player,
            EnterTime := CurrentTime
        }
        set VisitHistory += array{Record}
        
        Print("[{ZoneName}] 玩家进入: {Player}, 时间: {CurrentTime}")
        
        # 可触发额外逻辑
        OnPlayerEnterZone(Player)
    
    OnPlayerExit(Player:agent):void =
        CurrentTime := GetSimulationElapsedTime()
        
        # 从当前玩家列表移除
        set CurrentPlayers = CurrentPlayers.Filter((P:agent):P <> Player)
        
        # 更新历史记录
        for (Index := 0..VisitHistory.Length - 1):
            if (Record := VisitHistory[Index]):
                if (Record.Player = Player, Record.ExitTime = false):
                    Duration := CurrentTime - Record.EnterTime
                    UpdatedRecord := player_visit_record{
                        Player := Record.Player,
                        EnterTime := Record.EnterTime,
                        ExitTime := option{CurrentTime},
                        StayDuration := Duration
                    }
                    set VisitHistory[Index] = UpdatedRecord
                    
                    Print("[{ZoneName}] 玩家离开: {Player}, 停留: {Duration} 秒")
                    break
        
        # 可触发额外逻辑
        OnPlayerExitZone(Player)
    
    # 扩展点:子类可重写
    OnPlayerEnterZone(Player:agent):void = set{}
    OnPlayerExitZone(Player:agent):void = set{}
    
    # 查询接口
    GetCurrentPlayerCount():int = CurrentPlayers.Length
    GetCurrentPlayers():[]agent = CurrentPlayers
    GetVisitHistory():[]player_visit_record = VisitHistory
    
    # 统计接口
    GetTotalVisits():int = VisitHistory.Length
    
    GetAverageStayDuration():float =
        if (VisitHistory.Length > 0):
            TotalDuration := 0.0
            ValidCount := 0
            for (Record : VisitHistory):
                if (Record.ExitTime?):
                    set TotalDuration += Record.StayDuration
                    set ValidCount += 1
            if (ValidCount > 0):
                return TotalDuration / ValidCount
        return 0.0
```

#### 使用示例

```verse
# 游戏管理器
game_manager := class<concrete>(creative_device):
    var SafeZoneTracker:player_tracker_device = player_tracker_device{}
    var BattleZoneTracker:player_tracker_device = player_tracker_device{}
    
    OnBegin<override>()<suspends>:void =
        # 定时打印统计信息
        spawn:
            loop:
                Sleep(10.0)
                PrintStatistics()
    
    PrintStatistics():void =
        Print("=== 区域统计 ===")
        Print("安全区: {SafeZoneTracker.GetCurrentPlayerCount()} 人在线")
        Print("安全区平均停留: {SafeZoneTracker.GetAverageStayDuration()} 秒")
        Print("战斗区: {BattleZoneTracker.GetCurrentPlayerCount()} 人在线")
        Print("战斗区总访问: {BattleZoneTracker.GetTotalVisits()} 次")
```

---

## 已知限制与规避

### Scene Graph 方案限制

#### 限制 1: Beta 功能,发布受限

**问题**:

- SceneGraph 是实验性功能
- 使用 SceneGraph 的项目发布前必须禁用该功能

**规避方案**:

- ✅ **开发期使用,发布前切换**: 开发时用 SceneGraph,发布前切换到 Device
- ✅ **仅用于工具和测试**: 不在生产逻辑中使用
- ✅ **等待官方稳定版**: 关注 Epic 的 Beta 解除公告

#### 限制 2: 无内置进入/离开事件

**问题**:

- `FindOverlapHits()` 只返回当前状态,不触发事件
- 需要手动对比前后帧结果

**规避方案**:

```verse
# 封装一个通用的区域监听器组件
zone_listener_component := class(component):
    var PreviousAgents:[]agent = array{}
    
    OnSimulate<override>():void =
        if (Owner := GetOwner[entity]):
            Overlaps := Owner.FindOverlapHits()
            CurrentAgents := array{}
            
            # 提取 agents
            for (Hit : Overlaps):
                if (Agent := agent[Hit.HitEntity]):
                    set CurrentAgents += array{Agent}
            
            # 检测变化
            DetectChanges(CurrentAgents)
            set PreviousAgents = CurrentAgents
    
    DetectChanges(Current:[]agent):void =
        # 检测新进入
        for (Agent : Current):
            if (not PreviousAgents.Contains[Agent]):
                OnAgentEnter(Agent)
        
        # 检测离开
        for (Agent : PreviousAgents):
            if (not Current.Contains[Agent]):
                OnAgentExit(Agent)
    
    OnAgentEnter(Agent:agent):void = set{}
    OnAgentExit(Agent:agent):void = set{}
```

#### 限制 3: 性能优化需要开发者自己负责

**问题**:

- 高频调用 `FindOverlapHits()` 可能影响性能
- 大量 Entity 的碰撞检测开销大

**规避方案**:

```verse
# 1. 降低检测频率
var CheckInterval:float = 0.2  # 每 0.2 秒检测一次

DetectionLoop()<suspends>:void =
    loop:
        PerformDetection()
        Sleep(CheckInterval)  # 不要每帧检测

# 2. 使用碰撞通道过滤
# 只检测玩家通道,忽略其他物体

# 3. 分区域管理
# 只激活玩家附近的检测区域
```

### Device 方案限制

#### 限制 1: 无法运行时动态创建设备

**问题**:

- 所有 Device 必须在编辑器中预先放置
- 运行时无法通过代码创建新的触发器

**规避方案**:

```verse
# 1. 预先放置足够数量的设备,运行时启用/禁用
@editable
var TriggerPool:[]trigger_device = array{}

var ActiveTriggers:[]trigger_device = array{}
var InactiveTriggers:[]trigger_device = array{}

OnBegin<override>()<suspends>:void =
    # 初始化:全部禁用
    for (Trigger : TriggerPool):
        Trigger.Disable()
    set InactiveTriggers = TriggerPool

# 运行时"创建"触发器 (实际上是激活)
ActivateTrigger()<decides>:trigger_device =
    if (Trigger := InactiveTriggers[0]):
        Trigger.Enable()
        set ActiveTriggers += array{Trigger}
        set InactiveTriggers = InactiveTriggers.Slice(1, InactiveTriggers.Length)
        return Trigger

# 运行时"销毁"触发器 (实际上是禁用)
DeactivateTrigger(Trigger:trigger_device):void =
    Trigger.Disable()
    set InactiveTriggers += array{Trigger}
    set ActiveTriggers = ActiveTriggers.Filter((T:trigger_device):T <> Trigger)
```

#### 限制 2: trigger_device 不区分进入和离开

**问题**:

- `trigger_device.TriggeredEvent` 只在玩家"触发"时调用
- 无法直接监听玩家离开事件

**规避方案**:

```verse
# 方案 1: 使用 mutator_zone_device 代替
# 它有完整的 AgentEntersEvent 和 AgentExitsEvent

# 方案 2: 自己维护玩家状态
var PlayersInTrigger:[]agent = array{}

OnPlayerTriggered(MaybeAgent:?agent):void =
    if (Player := MaybeAgent?):
        if (PlayersInTrigger.Contains[Player]):
            # 玩家已在触发器内,视为离开
            set PlayersInTrigger = PlayersInTrigger.Filter((P:agent):P <> Player)
            OnPlayerExit(Player)
        else:
            # 玩家首次触发,视为进入
            set PlayersInTrigger += array{Player}
            OnPlayerEnter(Player)
```

#### 限制 3: 设备属性部分无法通过 Verse 修改

**问题**:

- 某些设备属性只能在编辑器中设置
- 运行时无法动态调整区域大小、形状等

**规避方案**:

```verse
# 1. 使用多个不同大小的设备,运行时切换
@editable
var SmallZone:mutator_zone_device = mutator_zone_device{}

@editable
var MediumZone:mutator_zone_device = mutator_zone_device{}

@editable
var LargeZone:mutator_zone_device = mutator_zone_device{}

var CurrentActiveZone:mutator_zone_device = SmallZone

SetZoneSize(Size:string):void =
    # 禁用当前区域
    CurrentActiveZone.Disable()
    
    # 切换到新区域
    if (Size = "Small"):
        set CurrentActiveZone = SmallZone
    else if (Size = "Medium"):
        set CurrentActiveZone = MediumZone
    else if (Size = "Large"):
        set CurrentActiveZone = LargeZone
    
    # 启用新区域
    CurrentActiveZone.Enable()
```

### 常见坑点

#### 坑点 1: 玩家快速穿过触发器导致漏检

**现象**:

- 玩家移动速度很快时,可能"跳过"触发器区域
- 导致进入/离开事件漏触发

**原因**:

- 检测是离散的(按帧或按时间间隔)
- 两次检测之间,玩家可能已经穿过了区域

**解决方案**:

```verse
# 1. 增大检测区域
# 在编辑器中增大触发器的半径/范围

# 2. 提高检测频率
var CheckInterval:float = 0.05  # 从 0.1 提高到 0.05

# 3. 使用扫描检测 (SceneGraph 方案)
# 预测玩家下一帧的位置
PredictNextPosition(Player:agent, DeltaTime:float):vector3 =
    CurrentPos := GetPlayerPosition(Player)
    Velocity := GetPlayerVelocity(Player)
    return CurrentPos + Velocity * DeltaTime

# 扫描从当前位置到预测位置的路径
Displacement := PredictNextPosition(Player, CheckInterval) - CurrentPos
SweepHits := Owner.FindSweepHits(Displacement)
```

#### 坑点 2: 多玩家同时进入导致事件顺序问题

**现象**:

- 多个玩家同时进入区域时,事件触发顺序不确定
- 可能导致逻辑错乱(如:只允许一个玩家的场景)

**解决方案**:

```verse
# 使用队列 + 锁机制
var ProcessingQueue:[]agent = array{}
var IsProcessing:logic = false

OnPlayerEnter(Player:agent):void =
    # 加入队列
    set ProcessingQueue += array{Player}
    
    # 如果没有在处理,启动处理
    if (not IsProcessing):
        spawn:
            ProcessQueue()

ProcessQueue()<suspends>:void =
    set IsProcessing = true
    
    loop:
        if (ProcessingQueue.Length > 0):
            if (Player := ProcessingQueue[0]):
                # 处理玩家进入逻辑
                HandlePlayerEnterLogic(Player)
                
                # 从队列移除
                set ProcessingQueue = ProcessingQueue.Slice(1, ProcessingQueue.Length)
        else:
            # 队列为空,退出
            break
        
        # 每个玩家之间间隔一小段时间
        Sleep(0.1)
    
    set IsProcessing = false
```

#### 坑点 3: OnBeginSimulation 中忘记 Sleep(0.0)

**现象**:

- 组件初始化时出现各种奇怪问题
- UI 无法创建、事件订阅失败等

**原因**:

- Epic 官方要求:**必须在 OnBeginSimulation 开头添加 Sleep(0.0)**
- 这是为了延迟一帧,确保引擎内部初始化完成

**解决方案**:

```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # ⚠️ 必须添加!
    
    # 其他初始化逻辑
    InitializeComponents()
```

---

## 最佳实践建议

### 1. 方案选择决策树

```
开始
    │
    ▼
是否需要发布? ────── 是 ──→ 使用 Device 方案
    │
    否
    │
    ▼
是否需要极致灵活性? ── 是 ──→ 使用 Scene Graph 方案
    │
    否
    │
    ▼
是否有复杂状态管理? ── 是 ──→ 使用混合方案
    │
    否
    │
    ▼
使用 Device 方案 (简单可靠)
```

### 2. 性能优化建议

#### 检测频率优化

```verse
# 根据游戏类型调整检测频率
# 快节奏射击游戏: 0.05 - 0.1 秒
# 慢节奏策略游戏: 0.2 - 0.5 秒
# 回合制游戏: 按需检测(不需要轮询)

var CheckInterval:float = 0.1
```

#### 分区域管理

```verse
# 只激活玩家附近的检测区域
var AllZones:[]mutator_zone_device = array{}
var ActiveZones:[]mutator_zone_device = array{}

UpdateActiveZones(PlayerPosition:vector3):void =
    # 禁用所有远离的区域
    for (Zone : AllZones):
        Distance := CalculateDistance(PlayerPosition, GetZonePosition(Zone))
        if (Distance > 50.0):
            Zone.Disable()
        else:
            Zone.Enable()
```

#### 事件批处理

```verse
# 累积事件,批量处理
var PendingEnterEvents:[]agent = array{}
var BatchProcessInterval:float = 0.5

OnPlayerEnter(Player:agent):void =
    set PendingEnterEvents += array{Player}

# 定时批量处理
loop:
    Sleep(BatchProcessInterval)
    if (PendingEnterEvents.Length > 0):
        ProcessBatch(PendingEnterEvents)
        set PendingEnterEvents = array{}
```

### 3. 代码组织建议

#### 模块化设计

```verse
# 分离关注点:检测器、管理器、逻辑处理器

# 检测器:负责原始事件
player_detector := class(component):
    OnPlayerDetected(Player:agent):void = set{}

# 管理器:负责状态管理
player_manager := class(component):
    var Players:[]player_data = array{}
    AddPlayer(Player:agent):void = set{}
    RemovePlayer(Player:agent):void = set{}

# 逻辑处理器:负责业务逻辑
game_logic_handler := class(component):
    OnPlayerJoinZone(Player:agent):void =
        # 游戏逻辑
        GrantBonus(Player)
```

#### 接口抽象

```verse
# 定义统一的玩家追踪接口
player_tracker_interface := interface:
    SubscribeOnPlayerEnter(Callback:(agent) -> void):void
    SubscribeOnPlayerExit(Callback:(agent) -> void):void
    GetCurrentPlayers():[]agent

# Device 实现
device_tracker := class(player_tracker_interface):
    var Detector:mutator_zone_device = mutator_zone_device{}
    # ...

# SceneGraph 实现
scenegraph_tracker := class(player_tracker_interface):
    var DetectionComponent:zone_listener_component = zone_listener_component{}
    # ...
```

### 4. 调试技巧

#### 可视化检测区域

```verse
# 使用 Print 输出调试信息
OnPlayerEnter(Player:agent):void =
    Print("[DEBUG] 玩家 {Player} 进入区域,时间: {GetSimulationElapsedTime()}")

# 记录事件日志
var EventLog:[]string = array{}

LogEvent(Message:string):void =
    Timestamp := GetSimulationElapsedTime()
    Entry := "[{Timestamp}] {Message}"
    set EventLog += array{Entry}
    Print(Entry)
```

#### 测试用例

```verse
# 创建测试组件
test_player_detection := class(component):
    var Detector:mutator_zone_device = mutator_zone_device{}
    var TestPassed:logic = false
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        RunTests()
    
    RunTests()<suspends>:void =
        Print("=== 开始测试玩家检测 ===")
        
        # 测试 1: 验证事件订阅
        TestEventSubscription()
        
        # 测试 2: 验证玩家列表更新
        TestPlayerList()
        
        Print("=== 测试完成 ===")
    
    TestEventSubscription():void =
        Detector.AgentEntersEvent.Subscribe(OnTestPlayerEnter)
        Print("[TEST] 事件订阅成功")
    
    OnTestPlayerEnter(Player:agent):void =
        set TestPassed = true
        Print("[TEST] 检测到玩家进入事件")
```

---

## 参考资源

### 官方文档

**Scene Graph**:

- [Scene Graph in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Scene Graph API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph)
- [Creating Components](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verseComponent-in-unreal-editor-for-fortnite)
- [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [Known Issues](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite)

**Devices**:

- [trigger_device API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/trigger_device)
- [mutator_zone_device API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/mutator_zone_device)
- [perception_trigger_device API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/perception_trigger_device)
- [Trigger Device Tutorial](https://dev.epicgames.com/documentation/en-us/uefn/trigger-device-in-verse)

### 本地参考文档

- `Core/skills/programming/verseDev/shared/references/scenegraph-framework-guide.md` - SceneGraph 框架详解
- `Core/skills/programming/verseDev/shared/references/uefn-device-system-research.md` - Device 系统调研
- `Core/skills/programming/verseDev/shared/references/device-quick-reference.md` - Device 快速参考
- `Core/skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md` - Fortnite API 摘要
- `Core/skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md` - Verse API 摘要

### 社区资源

- [UEFN Forums - Verse](https://forums.unrealengine.com/c/development-discussion/fortnite-uefn-verse/3750)
- [Epic Developer Community](https://dev.epicgames.com/community/fortnite/learning)
- [Awesome Verse (GitHub)](https://github.com/spilth/awesome-verse)

---

## 总结

### 核心要点

1. **技术选择**:
   - **生产环境**: 优先使用 Device 方案 (稳定可靠)
   - **原型开发**: 可尝试 Scene Graph (灵活强大)
   - **复杂项目**: 使用混合方案 (发挥各自优势)

2. **实现路径**:
   - **简单触发**: `trigger_device` 即可
   - **区域检测**: `mutator_zone_device` 完美适配
   - **视线检测**: `perception_trigger_device` 专业工具
   - **自定义逻辑**: Scene Graph + 组件化

3. **常见陷阱**:
   - ⚠️ Scene Graph 发布前必须禁用
   - ⚠️ OnBeginSimulation 必须 Sleep(0.0)
   - ⚠️ trigger_device 不区分进入/离开
   - ⚠️ 高速移动可能导致漏检

4. **性能优化**:
   - 降低检测频率 (0.1 - 0.2 秒)
   - 分区域管理(只激活附近区域)
   - 批量处理事件
   - 使用碰撞通道过滤

### 下一步行动

- ✅ 根据项目需求选择合适方案
- ✅ 参考代码骨架实现基础功能
- ✅ 进行性能测试和优化
- ✅ 阅读官方文档获取最新 API

---

**文档状态**: 完整版 v1.0  
**最后更新**: 2026-01-05  
**维护者**: UEFN/Verse 开发团队
