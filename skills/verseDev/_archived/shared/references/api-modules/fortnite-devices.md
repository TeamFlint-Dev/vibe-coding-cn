# Fortnite.com/Devices 模块深度调研报告

> **文档类型**：API 模块调研 - 设备系统详解  
> **目标平台**：UEFN (Unreal Editor for Fortnite)  
> **API 版本**：++Fortnite+Release-39.11-CL-49242330  
> **最后更新**：2026-01-04

---

## 文档说明

本文档是对 `/Fortnite.com/Devices` 模块的深度调研，旨在为开发者提供准确、全面的 API 能力参考，消除对该模块的错误认知。

**数据来源**：
- `skills/verseDev/shared/api-digests/Fortnite.digest.verse.md`
- Epic Games 官方 UEFN 文档

**重要提示**：
- ✅ Devices 模块是 UEFN 中最核心的模块之一，包含 213+ 设备类
- 🎯 所有 Creative 设备都继承自 `creative_device_base`
- 🔄 设备系统采用事件驱动架构，通过 `listenable` 事件进行交互
- 📦 设备可通过接口组合功能（如 `enableable`, `damageable`, `healthful`）

---

## 目录

1. [模块概述](#模块概述)
2. [核心架构](#核心架构)
3. [设备分类清单](#设备分类清单)
4. [关键 API 详解](#关键-api-详解)
5. [代码示例](#代码示例)
6. [常见误区澄清](#常见误区澄清)
7. [最佳实践](#最佳实践)
8. [参考资源](#参考资源)

---

## 模块概述

### 用途和设计理念

`/Fortnite.com/Devices` 模块提供了 UEFN Creative 模式中所有可放置设备的 Verse API 接口。这些设备是构建游戏玩法的核心工具，涵盖了从基础交互到复杂游戏逻辑的各个方面。

**设计理念**：
```
所有 Creative 设备 = creative_device_base (基类) + 功能接口 (Mixins)
                    + 设备特定 API + 事件驱动交互
```

**核心特点**：
- **统一基类**：所有设备都继承自 `creative_device_base`，提供统一的基础功能
- **接口组合**：通过 `enableable`, `damageable`, `healthful` 等接口灵活组合功能
- **事件驱动**：使用 `listenable` 模式进行设备间通信
- **类型安全**：强类型系统确保编译时检查
- **场景集成**：与 SceneGraph 系统深度集成

### 适用场景

- ✅ **游戏玩法编程**：通过代码控制放置在岛屿中的设备
- ✅ **事件响应系统**：监听设备事件并触发游戏逻辑
- ✅ **动态配置**：运行时修改设备属性和行为
- ✅ **设备间协作**：构建复杂的设备联动机制
- ✅ **玩家交互**：处理玩家与设备的交互逻辑

---

## 核心架构

### 类型层级结构

```
creative_object (基础对象)
    ├── creative_device_base (抽象设备基类)
    │   ├── 具体设备类 (213+ 个)
    │   │   ├── button_device
    │   │   ├── trigger_device
    │   │   ├── item_spawner_device
    │   │   └── ...
    └── creative_prop (道具对象)
```

### 核心基类和接口

#### creative_device_base

所有 Creative 设备的抽象基类，继承自 `creative_object`。

```verse
creative_device_base<native><public> := class<abstract><epic_internal>(creative_object)
```

**继承自 creative_object 的核心方法**：
- `GetTransform()<transacts>:transform` - 获取设备的空间变换信息
- `TeleportTo(Position:vector3, Rotation:rotation)<transacts><decides>:void` - 瞬移设备
- `MoveTo(Position:vector3, Rotation:rotation, OverTime:float)<suspends>:move_to_result` - 移动设备
- `FindCreativeObjectsWithTag(Tag:tag)<transacts>:generator(creative_object_interface)` - 按标签查找对象

#### 核心接口（Mixins）

设备可以实现多个接口来获得额外功能：

| 接口 | 用途 | 典型方法 |
|------|------|----------|
| `enableable` | 可启用/禁用 | `Enable()`, `Disable()` |
| `damageable` | 可受伤害 | `DamageReceived(agent, float)` |
| `healthful` | 有生命值 | `GetHealth()`, `GetMaxHealth()` |
| `healable` | 可治疗 | `Heal(float)` |
| `positional` | 有位置信息 | `GetTransform()` |
| `invalidatable` | 可失效 | `IsValid()`, `Dispose()` |

#### 核心枚举类型

```verse
# 进度设备状态
progress_device_state<public> := enum<open>:
    Progress    # 进度增加
    Regress     # 进度减少
    Pause       # 暂停

# 重生进度衰减行为
reboot_progress_decay_behavior<public> := enum<open>:
    # ... (具体值见 API digest)

# 生成时启用行为
spawn_on_enable_behavior<public> := enum<open>:
    # ... (具体值见 API digest)

# 守卫生成器精度
guard_spawner_accuracy<public> := enum<open>:
    # ... (具体值见 API digest)
```

---

## 设备分类清单

### 统计概览

- **总设备数**：213+ 个设备类
- **接口数**：4 个核心接口
- **枚举类型**：7 个
- **代码行数**：约 6,596 行

### 按功能分类的设备

#### 1. 游戏逻辑控制（Game Logic）

**用途**：控制游戏流程、回合管理、胜负判定

| 设备名称 | 功能说明 |
|---------|---------|
| `end_game_device` | 结束回合或游戏 |
| `round_settings_device` | 回合设置 |
| `game_settings_device` | 游戏设置 |
| `match_timer_device` | 比赛计时器 |
| `score_manager_device` | 分数管理 |
| `team_settings_and_inventory_device` | 团队设置和库存 |
| `team_status_indicator_device` | 团队状态指示器 |
| `spectator_spawn_pad_device` | 观察者重生点 |

#### 2. 玩家交互（Player Interaction）

**用途**：处理玩家输入、按钮、触发器等交互

| 设备名称 | 功能说明 |
|---------|---------|
| `button_device` | 按钮交互 |
| `trigger_device` | 触发器区域 |
| `input_trigger_device` | 输入触发器 |
| `mutator_zone_device` | 变异区域 |
| `capture_area_device` | 占领区域 |
| `player_spawner_device` | 玩家生成器 |
| `player_checkpoint_device` | 玩家检查点 |
| `changing_booth_device` | 换装亭 |
| `chair_device` | 椅子（可坐） |

#### 3. 物品和资源（Items & Resources）

**用途**：生成、管理物品和资源

| 设备名称 | 功能说明 |
|---------|---------|
| `item_spawner_device` | 物品生成器 |
| `item_granter_device` | 物品授予器 |
| `item_placer_device` | 物品放置器 |
| `item_remover_device` | 物品移除器 |
| `capture_item_spawner_device` | 占领物品生成器 |
| `carryable_spawner_device` | 可携带物品生成器 |
| `collectible_object_device` | 可收集物品 |
| `locker_device` | 储物柜 |
| `bank_vault_device` | 银行金库 |
| `supply_drop_spawner_device` | 空投生成器 |

#### 4. AI 和 NPC（AI & NPC）

**用途**：管理 NPC、生物、守卫

| 设备名称 | 功能说明 |
|---------|---------|
| `guard_spawner_device` | 守卫生成器 |
| `creature_spawner_device` | 生物生成器 |
| `creature_placer_device` | 生物放置器 |
| `creature_manager_device` | 生物管理器 |
| `wildlife_spawner_device` | 野生动物生成器 |
| `ai_patrol_path_device` | AI 巡逻路径 |
| `automated_turret_device` | 自动炮塔 |
| `character_device` | 角色设备 |

#### 5. 视觉和音频（Visual & Audio）

**用途**：视觉效果、音效、动画

| 设备名称 | 功能说明 |
|---------|---------|
| `vfx_spawner_device` | 视觉效果生成器 |
| `audio_player_device` | 音频播放器 |
| `audio_mixer_device` | 音频混合器 |
| `animated_mesh_device` | 动画网格 |
| `customizable_light_device` | 可定制灯光 |
| `post_process_device` | 后处理效果 |
| `cinematic_sequence_device` | 过场动画序列 |
| `billboard_device` | 广告牌 |
| `dance_mannequin_device` | 舞蹈人偶 |

#### 6. 环境和障碍（Environment & Obstacles）

**用途**：环境元素、障碍、陷阱

| 设备名称 | 功能说明 |
|---------|---------|
| `barrier_device` | 障碍物 |
| `damage_volume_device` | 伤害区域 |
| `campfire_device` | 篝火 |
| `air_vent_device` | 通风口（弹跳） |
| `bouncer_device` | 弹跳器 |
| `crash_pad_device` | 缓冲垫 |
| `grind_rail_device` | 滑轨 |
| `hazard_device` | 危险物 |
| `storm_controller_device` | 风暴控制器 |
| `time_of_day_device` | 时间控制 |
| `weather_controller_device` | 天气控制器 |

#### 7. UI 和显示（UI & Display）

**用途**：HUD、UI 提示、显示信息

| 设备名称 | 功能说明 |
|---------|---------|
| `hud_message_device` | HUD 消息 |
| `notification_device` | 通知设备 |
| `elimination_feed_device` | 淘汰信息流 |
| `billboard_device` | 广告牌 |
| `player_marker_device` | 玩家标记 |
| `objective_device` | 目标显示 |
| `tracker_device` | 追踪器 |
| `indicator_device` | 指示器 |

#### 8. 投票和社交（Voting & Social）

**用途**：投票系统、社交互动

| 设备名称 | 功能说明 |
|---------|---------|
| `vote_group_device` | 投票组（问题） |
| `vote_option_device` | 投票选项（答案） |
| `conversation_device` | 对话设备 |
| `accolades_device` | 荣誉奖励 |

#### 9. 工具和实用（Utility）

**用途**：辅助功能、数据处理、分析

| 设备名称 | 功能说明 |
|---------|---------|
| `analytics_device` | 分析设备 |
| `conditional_button_device` | 条件按钮 |
| `counter_device` | 计数器 |
| `player_counter_device` | 玩家计数器 |
| `timer_device` | 计时器 |
| `property_device` | 属性设备 |
| `randomizer_device` | 随机器 |
| `math_device` | 数学运算 |
| `sequence_device` | 序列设备 |
| `cable_splitter_device` | 信号分离器 |
| `channel_device` | 频道设备 |

#### 10. 进度和解锁（Progress & Unlocking）

**用途**：进度追踪、解锁机制

| 设备名称 | 功能说明 |
|---------|---------|
| `progress_based_mesh_device` | 基于进度的网格 |
| `race_checkpoint_device` | 竞速检查点 |
| `race_manager_device` | 竞速管理器 |
| `lock_device` | 锁定设备 |
| `key_card_device` | 钥匙卡 |
| `keycard_and_lock_device` | 钥匙卡和锁 |

#### 11. 特殊玩法（Special Gameplay）

**用途**：特定游戏模式的设备

| 设备名称 | 功能说明 |
|---------|---------|
| `reboot_van_device` | 重启货车 |
| `down_but_not_out_device` | 倒地不出局 |
| `service_station_device` | 服务站 |
| `upgrade_bench_device` | 升级工作台 |
| `disguise_device` | 伪装设备 |
| `teleporter_device` | 传送器 |
| `rift_spawner_device` | 裂缝生成器 |
| `launch_pad_device` | 发射台 |

#### 12. 载具相关（Vehicle Related）

**用途**：载具生成和管理

| 设备名称 | 功能说明 |
|---------|---------|
| `vehicle_spawner_device` | 载具生成器 |
| `vehicle_upgrade_device` | 载具升级 |
| `gas_pump_device` | 加油站 |

#### 13. 属性操作（Prop Manipulation）

**用途**：操作场景中的道具

| 设备名称 | 功能说明 |
|---------|---------|
| `prop_manipulator_device` | 道具操作器 |
| `prop_mover_device` | 道具移动器 |
| `prop_o_matic_device` | 道具自动机 |
| `color_changing_tiles_device` | 变色瓷砖 |

---

## 关键 API 详解

### 1. enableable 接口

最常用的设备接口，提供启用/禁用功能。

```verse
enableable := interface:
    Enable<public>():void
    Disable<public>():void
```

**使用示例**：

```verse
# 大多数设备都实现了此接口
trigger_device<public> := class<concrete><final>(creative_device_base, enableable)
item_spawner_device<public> := class<concrete><final>(creative_device_base, enableable)
```

**注意事项**：
- 禁用设备会停止其所有功能，但不会销毁设备
- 启用设备会恢复其功能状态
- 某些设备在禁用状态下不会触发事件

### 2. 事件监听机制

所有设备事件都使用 `listenable` 模式，这是 Verse 的核心异步编程模式。

**事件类型签名**：
```verse
# 无参数事件
EnabledEvent<public>:listenable(tuple()) = external {}

# 单参数事件（发送 agent）
ActivatedEvent<public>:listenable(agent) = external {}

# 多参数事件（发送多个值）
DamageEvent<public>:listenable(tuple(agent, float)) = external {}
```

**订阅事件的方法**：

```verse
# 使用 Subscribe 方法
MyDevice.ActivatedEvent.Subscribe(OnDeviceActivated)

# 使用 Await 等待事件
spawn:
    Agent := MyDevice.ActivatedEvent.Await()
    # 处理事件
```

### 3. 常用设备 API 模式

#### button_device（按钮设备）

```verse
button_device<public> := class<concrete><final>(creative_device_base):
    # 按钮被按下时触发
    InteractedWithEvent<public>:listenable(agent) = external {}
    
    # 设置按钮是否可交互
    SetEnabled<public>(Enabled:logic):void = external {}
    
    # 获取按钮当前状态
    IsEnabled<public>()<transacts><decides>:void = external {}
```

**典型用法**：
```verse
# 监听按钮按下
MyButton.InteractedWithEvent.Subscribe(OnButtonPressed)

OnButtonPressed(Agent:agent):void =
    Print("Button pressed by {Agent}")
```

#### trigger_device（触发器设备）

```verse
trigger_device<public> := class<concrete><final>(creative_device_base, enableable):
    # 玩家进入触发器
    TriggeredEvent<public>:listenable(agent) = external {}
    
    # 玩家离开触发器
    EndingEvent<public>:listenable(agent) = external {}
    
    # 启用/禁用触发器
    Enable<public>():void = external {}
    Disable<public>():void = external {}
```

#### item_spawner_device（物品生成器）

```verse
item_spawner_device<public> := class<concrete><final>(creative_device_base, enableable):
    # 物品被拾取
    ItemPickedUpEvent<public>:listenable(agent) = external {}
    
    # 生成物品
    Spawn<public>():void = external {}
    
    # 启用/禁用生成器
    Enable<public>():void = external {}
    Disable<public>():void = external {}
```

### 4. carryable_spawner_device（可携带物品生成器）

一个功能丰富的设备示例，展示了完整的生命周期管理：

```verse
carryable_spawner_device<public> := class<concrete><final>(creative_device_base, enableable):
    # 生成可携带物品
    Spawn<public>():void = external {}
    
    # 移除可携带物品
    Despawn<public>():void = external {}
    
    # 物品生成事件
    SpawnEvent<public>:listenable(tuple()) = external {}
    
    # 检查物品是否在世界中
    IsSpawned<public>()<reads><decides>:void = external {}
    
    # 引爆物品
    Explode<public>():void = external {}
    Explode<public>(Agent:agent):void = external {}
    
    # 爆炸事件（返回引发者和受影响的玩家）
    ExplodeEvent<public>:listenable(tuple(?agent, []agent)) = external {}
    
    # 强制玩家携带物品
    ForcePlayerToCarry<public>(Player:player):void = external {}
    
    # 生命周期事件
    PickUpEvent<public>:listenable(agent) = external {}
    DropEvent<public>:listenable(agent) = external {}
    ThrowEvent<public>:listenable(agent) = external {}
    ReleaseEvent<public>:listenable(agent) = external {}
```

**使用场景**：
- 创建可投掷的炸弹
- 实现夺旗模式的旗帜
- 制作需要运送的物品

### 5. player_counter_device（玩家计数器）

用于追踪区域内玩家数量的强大工具：

```verse
player_counter_device<public> := class<concrete><final>(creative_device_base):
    # 计数成功事件
    CountSucceedsEvent<public>:listenable(tuple()) = external {}
    
    # 计数失败事件
    CountFailsEvent<public>:listenable(tuple()) = external {}
    
    # 玩家被计数
    CountedEvent<public>:listenable(agent) = external {}
    
    # 玩家移除
    RemovedEvent<public>:listenable(agent) = external {}
    
    # 设置目标计数
    SetTargetCount<public>(Count:int):void = external {}
    
    # 获取当前计数
    GetCurrentCount<public>():int = external {}
    
    # 比较当前计数与目标
    CompareToTarget<public>():void = external {}
    
    # 注册/注销玩家
    Register<public>(Agent:agent):void = external {}
    Unregister<public>(Agent:agent):void = external {}
    UnregisterAll<public>():void = external {}
    
    # 显示/隐藏信息面板
    ShowInfoPanel<public>():void = external {}
    HideInfoPanel<public>():void = external {}
```

### 6. creative_device_base 通用方法

所有设备都继承这些方法：

```verse
# 获取设备所属的 playspace
(Device:creative_device_base).GetPlayspace<native><public>()<transacts>:fort_playspace

# 按标签查找创意对象
(Device:creative_device_base).FindCreativeObjectsWithTag<public>(Tag:tag)<transacts>:generator(creative_object_interface)

# 获取设备的标签视图
(Device:creative_device_base).GetTags<native><public>()<transacts>:tag_view

# 获取设备的变换信息
(Device:creative_device_base).GetTransform<override>()<transacts>:transform

# 传送设备
(Device:creative_device_base).TeleportTo<public>(Position:vector3, Rotation:rotation)<transacts><decides>:void

# 移动设备
(Device:creative_device_base).MoveTo<public>(Position:vector3, Rotation:rotation, OverTime:float)<suspends>:move_to_result
```

---

## 代码示例

### 示例 1：基础按钮触发器

**场景**：玩家按下按钮后生成物品

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

button_item_spawner_example := class(creative_device):
    @editable
    TriggerButton:button_device = button_device{}
    
    @editable
    ItemSpawner:item_spawner_device = item_spawner_device{}
    
    # 当设备加载时初始化
    OnBegin<override>()<suspends>:void =
        # 订阅按钮事件
        TriggerButton.InteractedWithEvent.Subscribe(OnButtonPressed)
    
    # 按钮被按下的处理函数
    OnButtonPressed(Agent:agent):void =
        Print("Button pressed by {Agent}")
        # 生成物品
        ItemSpawner.Spawn()
```

**关键点**：
- 使用 `@editable` 标记允许在编辑器中设置设备
- 在 `OnBegin` 中订阅事件
- 事件处理函数必须匹配事件的签名

### 示例 2：区域触发计数器

**场景**：当 3 名玩家同时进入区域时触发事件

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

area_trigger_counter := class(creative_device):
    @editable
    TriggerArea:trigger_device = trigger_device{}
    
    @editable
    PlayerCounter:player_counter_device = player_counter_device{}
    
    @editable
    TargetPlayerCount:int = 3
    
    OnBegin<override>()<suspends>:void =
        # 设置目标计数
        PlayerCounter.SetTargetCount(TargetPlayerCount)
        
        # 订阅触发事件
        TriggerArea.TriggeredEvent.Subscribe(OnPlayerEnter)
        TriggerArea.EndingEvent.Subscribe(OnPlayerExit)
        
        # 订阅计数成功事件
        PlayerCounter.CountSucceedsEvent.Subscribe(OnCountSuccess)
    
    OnPlayerEnter(Agent:agent):void =
        # 将玩家添加到计数器
        PlayerCounter.Register(Agent)
        Print("Player entered: {Agent}")
    
    OnPlayerExit(Agent:agent):void =
        # 从计数器移除玩家
        PlayerCounter.Unregister(Agent)
        Print("Player exited: {Agent}")
    
    OnCountSuccess():void =
        Print("Target player count reached!")
        CurrentCount := PlayerCounter.GetCurrentCount()
        Print("Current players in area: {CurrentCount}")
        # 在这里触发游戏逻辑
```

**关键点**：
- 组合多个设备实现复杂功能
- 使用 `Register`/`Unregister` 动态管理计数
- 分离事件处理逻辑

### 示例 3：可携带物品爆炸系统

**场景**：玩家携带炸弹 5 秒后自动爆炸

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Concurrency }

timed_bomb_system := class(creative_device):
    @editable
    BombSpawner:carryable_spawner_device = carryable_spawner_device{}
    
    @editable
    ExplosionDelay:float = 5.0
    
    var CurrentCarrier:?agent = false
    
    OnBegin<override>()<suspends>:void =
        # 订阅拾取和释放事件
        BombSpawner.PickUpEvent.Subscribe(OnBombPickedUp)
        BombSpawner.ReleaseEvent.Subscribe(OnBombReleased)
        BombSpawner.ExplodeEvent.Subscribe(OnBombExploded)
        
        # 初始生成炸弹
        BombSpawner.Spawn()
    
    OnBombPickedUp(Agent:agent):void =
        Print("{Agent} picked up the bomb!")
        set CurrentCarrier = option{Agent}
        
        # 启动爆炸计时器
        spawn:
            StartExplosionTimer()
    
    OnBombReleased(Agent:agent):void =
        Print("{Agent} released the bomb!")
        set CurrentCarrier = false
    
    StartExplosionTimer()<suspends>:void =
        # 等待指定时间
        Sleep(ExplosionDelay)
        
        # 如果炸弹仍被携带，则引爆
        if (BombSpawner.IsSpawned[]):
            if (Carrier := CurrentCarrier?):
                Print("Bomb exploding on {Carrier}!")
                BombSpawner.Explode(Carrier)
            else:
                Print("Bomb exploding!")
                BombSpawner.Explode()
    
    OnBombExploded(Instigator:?agent, AffectedAgents:[]agent):void =
        if (Instigator?):
            Print("Bomb exploded, instigator: {Instigator}")
        Print("Affected {AffectedAgents.Length} players")
        
        # 重新生成炸弹
        spawn:
            Sleep(2.0)
            BombSpawner.Spawn()
```

**关键点**：
- 使用 `spawn` 创建异步任务
- 使用 `Sleep` 实现延迟
- 使用可选类型 `?agent` 处理可能不存在的值
- 处理复杂的生命周期和状态管理

### 示例 4：动态进度显示

**场景**：根据玩家行动更新进度条

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

progress_tracker := class(creative_device):
    @editable
    ProgressMesh:progress_based_mesh_device = progress_based_mesh_device{}
    
    @editable
    TriggerButtons:[]button_device = array{}
    
    var CompletedSteps:int = 0
    
    OnBegin<override>()<suspends>:void =
        # 设置进度目标
        set ProgressMesh.ProgressTarget = 100.0
        set ProgressMesh.CurrentProgress = 0.0
        
        # 订阅所有按钮
        for (Button : TriggerButtons):
            Button.InteractedWithEvent.Subscribe(OnStepCompleted)
        
        # 订阅进度事件
        ProgressMesh.FillEvent.Subscribe(OnProgressComplete)
        ProgressMesh.ProgressChangeEvent.Subscribe(OnProgressChanged)
    
    OnStepCompleted(Agent:agent):void =
        set CompletedSteps += 1
        
        # 计算新的进度值（假设每个按钮占 25%）
        NewProgress := CompletedSteps * 25.0
        set ProgressMesh.CurrentProgress = NewProgress
        
        Print("{Agent} completed a step. Progress: {NewProgress}%")
    
    OnProgressChanged(NewValue:float):void =
        Print("Progress updated: {NewValue}")
    
    OnProgressComplete():void =
        Print("All steps completed! Progress reached 100%")
        # 触发完成逻辑
```

**关键点**：
- 使用数组管理多个设备
- 使用 `for` 循环批量订阅事件
- 使用 `var` 跟踪状态
- 实时更新设备属性

### 示例 5：投票系统实现

**场景**：创建一个简单的多选项投票系统

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

voting_system := class(creative_device):
    @editable
    VoteGroup:vote_group_device = vote_group_device{}
    
    @editable
    VoteOptions:[]vote_option_device = array{}
    
    OnBegin<override>()<suspends>:void =
        # 订阅投票组事件
        VoteGroup.VoteStartedEvent.Subscribe(OnVoteStarted)
        VoteGroup.VoteEndedEvent.Subscribe(OnVoteEnded)
        
        # 订阅所有选项的事件
        for (Option : VoteOptions):
            Option.CastVoteEvent.Subscribe(OnVoteCast)
            Option.WinVoteEvent.Subscribe(OnOptionWins)
    
    OnVoteStarted():void =
        Print("Voting has started!")
        
        # 显示投票问题
        Question := VoteGroup.GetPollQuestion()
        Print("Question: {Question}")
    
    OnVoteCast(Voter:agent):void =
        Print("{Voter} cast a vote")
    
    OnOptionWins(Winner:?agent):void =
        Print("An option has won the vote!")
        if (Winner?):
            Print("Winning agent: {Winner}")
    
    OnVoteEnded(WinningOption:?vote_option_device):void =
        Print("Voting has ended!")
        if (Winner := WinningOption?):
            Description := Winner.GetOptionDescription()
            Print("Winning option: {Description}")
            VoteCount := Winner.GetVoteCount()
            Print("Total votes: {VoteCount}")
```

**关键点**：
- 处理可选返回值 `?vote_option_device`
- 使用设备自带的查询方法获取信息
- 组合投票组和选项设备

---

## 常见误区澄清

### 误区 1：所有设备都可以通过 Verse 代码创建

❌ **错误理解**：可以用 `new` 关键字动态创建设备实例

✅ **正确理解**：
- Creative 设备必须先在 UEFN 编辑器中放置到岛屿上
- Verse 代码只能引用和控制已放置的设备
- 使用 `@editable` 标记在编辑器中关联设备

```verse
# ❌ 错误：无法这样创建设备
MyButton := button_device{}  # 这不会创建新的按钮

# ✅ 正确：引用编辑器中放置的设备
@editable
MyButton:button_device = button_device{}
```

### 误区 2：事件监听是同步的

❌ **错误理解**：订阅事件后，事件处理会立即阻塞执行

✅ **正确理解**：
- `Subscribe` 是异步注册，不会阻塞
- 事件触发时，处理函数在新的执行上下文中运行
- 如果需要等待事件，使用 `Await`

```verse
# ❌ 错误：期望同步等待
MyButton.InteractedWithEvent.Subscribe(HandlePress)
Print("This prints immediately")  # 不会等待事件

# ✅ 正确：使用 Await 等待事件
spawn:
    Agent := MyButton.InteractedWithEvent.Await()
    Print("Button pressed by {Agent}")
```

### 误区 3：Disable 会销毁设备

❌ **错误理解**：调用 `Disable()` 后设备被移除

✅ **正确理解**：
- `Disable()` 只是禁用设备功能
- 设备仍然存在，可以重新 `Enable()`
- 要真正移除设备，需要使用设备特定的方法（如果支持）

```verse
# ❌ 错误理解
MyDevice.Disable()  # 设备还在，只是禁用了

# ✅ 正确理解
MyDevice.Disable()  # 禁用设备
# ... 稍后 ...
MyDevice.Enable()   # 重新启用
```

### 误区 4：设备属性可以任意修改

❌ **错误理解**：所有设备的 `var` 属性都可以在运行时修改

✅ **正确理解**：
- 只有标记为 `var` 的属性才能在运行时修改
- 许多属性是只读的，只能在编辑器中设置
- 某些属性的修改有副作用（如触发事件）

```verse
# ❌ 可能失败：试图修改只读属性
# MyDevice.SomeReadOnlyProperty = NewValue  # 编译错误

# ✅ 正确：只修改可变属性
set ProgressMesh.CurrentProgress = 50.0  # 这是 var 属性
```

### 误区 5：所有设备事件都发送 agent

❌ **错误理解**：所有设备事件的参数都是 `agent` 类型

✅ **正确理解**：
- 事件签名各不相同
- 有些事件不发送参数：`listenable(tuple())`
- 有些事件发送多个参数：`listenable(tuple(agent, float))`
- 有些事件发送可选参数：`listenable(?agent)`

```verse
# ❌ 错误：假设所有事件都有 agent
MyDevice.SomeEvent.Subscribe(Handler)
Handler(Agent:agent):void = ...  # 可能不匹配

# ✅ 正确：检查事件签名
# EnabledEvent<public>:listenable(tuple()) = external {}
MyDevice.EnabledEvent.Subscribe(OnEnabled)
OnEnabled():void = Print("Device enabled")

# ExplodeEvent<public>:listenable(tuple(?agent, []agent)) = external {}
MyDevice.ExplodeEvent.Subscribe(OnExplode)
OnExplode(Instigator:?agent, Affected:[]agent):void = ...
```

### 误区 6：可以直接访问其他设备的私有属性

❌ **错误理解**：可以读取任何设备的内部状态

✅ **正确理解**：
- 只能访问 `<public>` 标记的 API
- 使用设备提供的查询方法获取状态
- 某些状态只能通过事件监听获知

```verse
# ❌ 错误：试图访问内部状态
# Count := MyCounter.InternalCount  # 不可访问

# ✅ 正确：使用公共 API
Count := MyCounter.GetCurrentCount()
```

### 误区 7：设备坐标系与 Unreal 坐标系相同

❌ **错误理解**：设备的位置单位是米

✅ **正确理解**：
- `GetTransform()` 返回的单位是厘米（cm）
- 需要进行单位转换
- 旋转使用 `rotation` 类型，不是欧拉角

```verse
# ✅ 正确：注意单位
Transform := MyDevice.GetTransform()
# Transform 中的位置单位是厘米
PositionInMeters := Transform.Translation / 100.0
```

---

## 最佳实践

### 1. 设备引用管理

**推荐做法**：
- 使用 `@editable` 在编辑器中设置设备引用
- 对于动态查找的设备，使用 `FindCreativeObjectsWithTag`
- 始终检查设备引用是否有效

```verse
# ✅ 推荐：编辑器引用
@editable
MyButton:button_device = button_device{}

# ✅ 推荐：使用标签查找
AllTriggers := GetCreativeObjectsWithTag(tag"gameplay_trigger")

# ✅ 推荐：检查有效性（针对可能被销毁的对象）
if (MyProp.IsValid[]):
    MyProp.Show()
```

### 2. 事件订阅模式

**推荐做法**：
- 在 `OnBegin` 中集中订阅事件
- 使用具名函数而非 lambda，便于调试
- 考虑使用 `spawn` 处理长时间运行的事件处理

```verse
# ✅ 推荐：清晰的事件订阅
OnBegin<override>()<suspends>:void =
    MyButton.InteractedWithEvent.Subscribe(OnButtonPressed)
    MyTrigger.TriggeredEvent.Subscribe(OnPlayerEnter)

OnButtonPressed(Agent:agent):void =
    # 简单快速的处理
    Print("Button pressed")

OnPlayerEnter(Agent:agent):void =
    # 复杂或耗时的处理使用 spawn
    spawn:
        HandlePlayerEntry(Agent)
```

### 3. 状态管理

**推荐做法**：
- 使用设备的内置状态而非自己维护
- 对于复杂状态，使用独立的数据结构
- 使用 `var` 标记可变状态

```verse
# ✅ 推荐：利用设备状态
if (ItemSpawner.IsSpawned[]):
    ItemSpawner.Despawn()

# ✅ 推荐：复杂状态使用数据结构
game_state := class:
    var PlayerScores:map(player, int) = map{}
    var CurrentRound:int = 1
```

### 4. 性能优化

**推荐做法**：
- 避免在高频事件中执行重计算
- 使用设备的批量操作而非循环
- 合理使用 `Sleep` 避免阻塞

```verse
# ❌ 不推荐：在高频事件中重复计算
OnProgressChanged(NewValue:float):void =
    for (Player : AllPlayers):  # 每次进度变化都遍历
        UpdatePlayerUI(Player, NewValue)

# ✅ 推荐：缓存结果或批量更新
OnProgressChanged(NewValue:float):void =
    set CachedProgress = NewValue
    spawn:
        BatchUpdateAllUI()
```

### 5. 错误处理

**推荐做法**：
- 使用 `<decides>` 方法的返回值判断成功
- 对可能失败的操作添加检查
- 使用可选类型处理可能不存在的值

```verse
# ✅ 推荐：检查操作是否成功
if (MyDevice.TeleportTo[NewPosition, NewRotation]):
    Print("Teleport successful")
else:
    Print("Teleport failed")

# ✅ 推荐：处理可选值
if (WinningOption := VoteGroup.GetWinningOption[]):
    ProcessWinner(WinningOption)
```

### 6. 设备组合模式

**推荐做法**：
- 使用多个简单设备组合实现复杂功能
- 创建自定义 `creative_device` 类封装逻辑
- 使用标签组织相关设备

```verse
# ✅ 推荐：封装设备组合
checkpoint_system := class(creative_device):
    @editable
    CheckpointTrigger:trigger_device = trigger_device{}
    
    @editable
    CheckpointMarker:player_marker_device = player_marker_device{}
    
    @editable
    CheckpointSpawner:player_spawner_device = player_spawner_device{}
    
    OnBegin<override>()<suspends>:void =
        SetupCheckpoint()
```

### 7. 调试技巧

**推荐做法**：
- 使用 `Print` 输出调试信息
- 使用设备的显示功能（如 `ShowInfoPanel`）
- 为事件处理添加日志

```verse
# ✅ 推荐：详细的调试日志
OnButtonPressed(Agent:agent):void =
    Print("Button pressed by {Agent}")
    if (ItemSpawner.IsSpawned[]):
        Print("Item already spawned, skipping")
        return
    Print("Spawning item...")
    ItemSpawner.Spawn()
    Print("Item spawned successfully")
```

### 8. 与 SceneGraph 集成

**推荐做法**：
- 使用 `GetSimulationEntity` 获取根实体
- 利用 `FindCreativeObjectsWithTag` 查找场景对象
- 理解设备在场景图中的位置

```verse
# ✅ 推荐：访问场景图
if (RootEntity := MyDevice.GetSimulationEntity[]):
    # 使用根实体进行场景操作
    AllTaggedObjects := RootEntity.FindCreativeObjectsWithTag(tag"important")
```

---

## 参考资源

### 官方文档

- [UEFN 官方文档](https://dev.epicgames.com/documentation/en-us/uefn)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [Creative 设备参考](https://dev.epicgames.com/documentation/en-us/uefn/creative-devices-reference)

### 相关 API 模块

本模块与以下模块紧密配合使用：

| 模块 | 路径 | 关系说明 |
|------|------|----------|
| Simulation | `/Verse.org/Simulation` | 提供 `agent`, `creative_device` 基类 |
| Playspaces | `/Fortnite.com/Playspaces` | 提供 `fort_playspace` 上下文 |
| SceneGraph | `/Verse.org/SceneGraph` | 提供场景对象管理 |
| SpatialMath | `/Verse.org/SpatialMath` | 提供空间计算 |
| UI | `/Fortnite.com/UI` | 提供 HUD 和 UI 控制 |

### 本仓库相关文档

- [API 模块清单](../api-modules-list.md) - 所有模块索引
- [SceneGraph 框架指南](../scenegraph-framework-guide.md) - 场景图系统详解
- [Verse 失败机制](../verse-failure-mechanisms.md) - `<decides>` 和错误处理

### API Digest 文件

完整的 API 定义请参考：
- `skills/verseDev/shared/api-digests/Fortnite.digest.verse.md`
  - Devices 模块：第 4630-11225 行（约 6,596 行）

---

## 版本历史

| 版本 | 日期 | 说明 |
|------|------|------|
| 1.0 | 2026-01-04 | 初始版本，基于 API 版本 39.11-CL-49242330 |

---

## 贡献者

本文档由 UEFN Verse 开发团队调研整理，欢迎提交改进建议。

---

**文档结束** | [返回顶部](#fortnitecomdevices-模块深度调研报告)
