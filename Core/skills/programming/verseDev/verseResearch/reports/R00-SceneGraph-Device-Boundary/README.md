# SceneGraph 与 Device 边界与联动调研报告

> **报告编号**: R00-SceneGraph-Device-Boundary  
> **创建时间**: 2026-01-05  
> **调研基准**: 2026年1月（UEFN 最新版本）  
> **状态**: 进行中 🔄

---

## 执行摘要

### 调研背景

UEFN 新版 **SceneGraph** 系统正在逐步替代传统 **Device** 流程，但：

- SceneGraph 仍处于 **Beta** 阶段，官方文档有限
- 大部分开发者更熟悉 Device 系统
- 两者的能力边界、协作方式、最佳实践尚不清晰

本报告旨在为团队所有基础/核心模块开发提供**技术选型决策依据**。

### 核心结论（初步）

| 维度 | SceneGraph | Device | 推荐场景 |
|------|-----------|--------|----------|
| **架构模式** | Entity-Component-Event（模块化） | 蓝图式事件驱动（拖拽配置） | SG: 复杂逻辑；Device: 快速原型 |
| **开发方式** | Verse 代码编写 | UEFN 编辑器配置 + Verse 调用 | SG: 程序员主导；Device: 设计师友好 |
| **可维护性** | 高（组件化、解耦） | 中（依赖蓝图连接） | SG: 大型项目；Device: 小型关卡 |
| **学习曲线** | 陡峭（需理解 ECS 架构） | 平缓（可视化操作） | 根据团队技能选择 |
| **发布状态** | ⚠️ Beta（需发布前禁用） | ✅ 稳定（生产就绪） | Device: 正式发布项目 |

**关键发现**：

1. ✅ SceneGraph 和 Device **可以共存**，不是二选一的关系
2. ⚠️ SceneGraph 项目发布前必须禁用该功能，否则影响发布
3. 🔄 Epic 正在积极扩展 SceneGraph，未来可能成为主流
4. 🛠️ 混合使用是当前最佳实践：SG 处理核心逻辑，Device 处理外围功能

---

## 一、SceneGraph 能力清单

### 1.1 核心架构

SceneGraph 基于 **Entity-Component-Event (ECE)** 架构：

```text
场景中的一切都是 Entity（实体）
├── Entity 是容器，可包含：
│   ├── 子 Entity（形成层级树）
│   └── Component（定义行为和数据）
└── Component 通过 Scene Event 通信

```text

**设计理念**：

- 🎯 **模块化**：每个组件独立封装一个功能
- 🔄 **可重用**：通过 Prefab 复用实体和组件组合
- 🔌 **松耦合**：组件间通过事件通信，不直接依赖
- 🛠️ **易扩展**：运行时可动态添加/移除组件

**官方文档**：

- [Scene Graph 概述](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Scene Events 详解](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)

### 1.2 Entity（实体）系统

**核心能力**：

| API | 功能 | 用途 |
|-----|------|------|
| `GetParent()` | 获取父实体 | 向上遍历层级 |
| `AddEntities()` | 添加子实体 | 构建层级结构 |
| `RemoveFromParent()` | 从父实体移除 | 动态重构层级 |
| `GetEntities()` | 获取所有子实体 | 遍历子节点 |
| `AddComponents()` | 添加组件 | 动态赋予能力 |
| `GetComponent<T>()` | 获取特定类型组件 | 访问组件功能 |
| `GetComponents()` | 获取所有组件 | 遍历组件列表 |
| `SendUp()` | 向上发送事件 | 子向父报告 |
| `SendDown()` | 向下广播事件 | 父向子通知 |
| `SendDirect()` | 点对点发送事件 | 精确通信 |

**适用场景**：

- ✅ 需要动态组合功能（如角色可装备不同技能）
- ✅ 复杂的层级关系（如移动基地包含多个子系统）
- ✅ 运行时需要调整对象能力

**限制**：

- ⚠️ Beta 功能，API 可能变化
- ⚠️ 调试工具不如 Device 成熟
- ⚠️ 发布前必须禁用 SceneGraph 功能

### 1.3 Component（组件）系统

**核心特性**：

```verse
# 自定义组件模板
my_component := class(component):
    # 数据字段
    var Health:int = 100
    var IsActive:logic = true
    
    # 生命周期钩子
    OnBeginSimulation()<suspends>:void =
        # 初始化逻辑
        
    OnSimulate(DeltaTime:float)<suspends>:void =
        # 每帧更新逻辑
        
    OnEndSimulation()<suspends>:void =
        # 清理逻辑

```text

**生命周期**：

```text
OnBeginSimulation（初始化）
    ↓ Sleep(0.0) # 必须等待一帧！
    ↓
建立订阅关系
    ↓
OnSimulate（每帧更新）
    ↓
OnEndSimulation（清理）

```text

**内置组件**（部分）：

- `scene_graph_spawner_component` - 生成实体
- `transform_component` - 位置/旋转/缩放
- 更多内置组件见 [API 参考文档](../../../shared/references/scenegraph-api-reference.md)

**适用场景**：

- ✅ 可复用的功能模块（如 HealthComponent、InventoryComponent）
- ✅ 需要独立测试的逻辑单元
- ✅ 多个对象共享相同行为

**限制**：

- ⚠️ 组件间通信需通过事件，不能直接调用
- ⚠️ 生命周期钩子顺序需严格遵循
- ⚠️ `OnBeginSimulation` 中必须 `Sleep(0.0)` 才能访问其他组件

### 1.4 Scene Events（场景事件）系统

**事件传播策略**：

| 策略 | 传播方向 | 使用场景 | 示例 |
|------|----------|----------|------|
| **SendUp** | 从子到父 | 子组件向父容器报告状态 | 玩家受伤 → 通知游戏管理器 |
| **SendDown** | 从父到子 | 父容器向所有子组件广播 | 游戏开始 → 通知所有玩家 |
| **SendDirect** | 点对点 | 精确通信 | 武器 → 特定敌人造成伤害 |

**事件定义**：

```verse
# 事件必须标记为 <concrete>
player_damaged_event := class<concrete>(scene_event):
    var Player:agent
    var Damage:int
    var Source:?entity
    var DamageType:damage_type

damage_type := enum:
    Physical
    Fire
    Ice
    Poison

```text

**事件消耗**：

- 事件可被标记为"已消耗"，阻止进一步传播
- 实现事件优先级处理

**适用场景**：

- ✅ 松耦合的组件通信
- ✅ 一对多的广播通知
- ✅ 跨层级的消息传递

**限制**：

- ⚠️ 事件是异步的，无法立即获取返回值
- ⚠️ 调试事件流较困难
- ⚠️ 过度使用会导致系统复杂度上升

---

## 二、Device 能力清单

### 2.1 核心概念

Device 是 UEFN 的**传统开发模式**，基于**蓝图式事件驱动**：

```text
Device（设备）= 预制的游戏功能模块
├── 通过 UEFN 编辑器配置属性
├── 通过蓝图连接事件触发
└── 可通过 Verse 代码调用和控制

```text

**设计理念**：

- 🎨 **可视化**：拖拽配置，无需编码
- 🚀 **开箱即用**：200+ 预制设备覆盖常见需求
- 🔗 **事件驱动**：通过信号/通道连接设备
- 👥 **设计师友好**：降低技术门槛

### 2.2 Device 分类（315 种设备）

完整设备清单见 [Device 快速参考手册](../../../shared/references/device-quick-reference.md)

#### 核心类别：

| 类别 | 数量 | 代表设备 | 典型用途 |
|------|------|----------|----------|
| **生成器** | 47 | `item_spawner_device`, `npc_spawner_device` | 生成物品、NPC、道具 |
| **载具生成器** | 31 | `vehicle_spawner_*` 系列 | 生成各类交通工具 |
| **触发器** | 10 | `trigger_device`, `button_device` | 检测玩家进入、交互 |
| **UI/显示** | 10 | `hud_message_device`, `popup_dialog_device` | 显示消息、对话框 |
| **游戏玩法** | 20 | `score_manager_device`, `timer_device` | 计分、计时、回合 |
| **AI** | 15 | `npc_spawner_device`, `ai_patrol_path_device` | NPC 行为、巡逻 |
| **音频** | 22 | `audio_player_device`, `patchwork_*` 系列 | 音乐、音效、音乐制作 |
| **体积区域** | 8 | `mutator_zone_device`, `damage_volume_device` | 改变区域属性 |
| **物理** | 5 | `prop_mover_device`, `prop_manipulator_device` | 移动道具、物理交互 |
| **其他** | 147 | 相机、特效、风暴、竞速等 | 特殊功能 |

### 2.3 Device 与 Verse 协作方式

**两种使用模式**：

#### 模式 1：纯编辑器配置（无代码）

```text
在 UEFN 编辑器中：

1. 拖拽 Device 到场景
2. 配置属性（触发条件、奖励数量等）
3. 连接蓝图事件（触发器 → 生成器）

```text

**适用场景**：

- ✅ 简单的线性流程
- ✅ 快速原型验证
- ✅ 设计师主导的关卡设计

#### 模式 2：Verse 代码控制（200 个设备有 API）
```verse
# 获取设备实例
<Decides>MyTrigger := trigger_device { }

# 订阅设备事件
MyTrigger.TriggeredEvent.Subscribe(OnPlayerEnter)

OnPlayerEnter(Agent:?agent):void =
    if (Player := Agent?):
        # 玩家进入触发区域

```text

**适用场景**：

- ✅ 需要复杂逻辑判断
- ✅ 需要动态调整参数
- ✅ 需要跨设备协作

### 2.4 Device 的核心能力

#### 玩家检测
```verse
# 方式 1：Trigger Device
trigger_device:
    .TriggeredEvent          # 玩家进入
    .EndedEvent             # 玩家离开
    
# 方式 2：Perception Trigger
perception_trigger_device:
    .AgentEntersEvent       # 代理（玩家/NPC）进入
    .AgentExitsEvent        # 代理离开

```text

#### 区域触发
```verse
# Mutator Zone - 改变区域属性
mutator_zone_device:
    .SetGravityScale()      # 重力调整
    .SetJumpScale()         # 跳跃高度
    
# Damage Volume - 伤害区域
damage_volume_device:
    .SetDamageAmount()      # 伤害值
    .Activate()             # 启用伤害

```text

#### 数值系统
```verse
# Score Manager - 计分系统
score_manager_device:
    .SetScore()             # 设置分数
    .IncrementScore()       # 增加分数
    .ScoreChangedEvent      # 分数变化事件
    
# Tracker - 通用追踪器
tracker_device:
    .SetValue()             # 设置数值
    .IncrementValue()       # 递增

```text

#### UI 显示
```verse
# HUD Message - HUD 消息
hud_message_device:
    .SetText()              # 设置消息文本
    .Show()                 # 显示消息
    
# Popup Dialog - 弹窗对话框
popup_dialog_device:
    .Show()                 # 显示对话框
    .ResultEvent            # 玩家选择结果

```text

#### 音频播放
```verse
# Audio Player - 音频播放器
audio_player_device:
    .Play()                 # 播放
    .Stop()                 # 停止
    .SetVolume()            # 音量调整

```text

### 2.5 Device 的优势与限制

**优势**：

- ✅ **稳定可靠**：生产就绪，可直接发布
- ✅ **功能丰富**：315 种设备覆盖大部分需求
- ✅ **开发迅速**：可视化配置，无需深入编码
- ✅ **调试友好**：UEFN 编辑器提供实时预览
- ✅ **文档完善**：官方教程和社区资源丰富

**限制**：

- ⚠️ **耦合度高**：设备间通过蓝图连接，重构困难
- ⚠️ **扩展性差**：无法创建自定义 Device 类型
- ⚠️ **维护成本**：大型项目中设备网络难以管理
- ⚠️ **代码复用**：相同逻辑需在多个设备中重复配置
- ⚠️ **部分设备无 API**：115 个设备仅支持编辑器配置

---

## 三、SceneGraph 与 Device 联动模式

### 3.1 协作架构

**推荐模式**：**分层协作 - SG 核心 + Device 外围**

```text
┌─────────────────────────────────────────────────────┐
│              应用层（玩家可见功能）                  │
├─────────────────────────────────────────────────────┤
│                                                      │
│  Device 层（外围功能）                               │
│  ├─ UI 显示（hud_message_device）                   │
│  ├─ 音效播放（audio_player_device）                 │
│  ├─ 特效生成（vfx_spawner_device）                  │
│  └─ 简单触发（trigger_device）                      │
│                      ↕                               │
│              事件/信号通信                           │
│                      ↕                               │
│  SceneGraph 层（核心逻辑）                          │
│  ├─ Entity 层级结构                                 │
│  ├─ 游戏状态管理（Component）                       │
│  ├─ 数值系统（Component）                           │
│  ├─ 事件流编排（Scene Events）                     │
│  └─ 业务逻辑（Component）                           │
│                                                      │
└─────────────────────────────────────────────────────┘

```text

**职责划分**：

| 层级 | 负责内容 | 技术选型 | 理由 |
|------|----------|----------|------|
| **核心逻辑层** | 游戏状态、数值计算、规则判断 | SceneGraph | 需要模块化、可测试、可复用 |
| **外围功能层** | UI、音效、特效、简单触发 | Device | 成熟稳定、快速实现、设计师友好 |
| **桥接层** | 逻辑与表现的通信 | Verse 代码 | 灵活控制、类型安全 |

### 3.2 联动实现方式

#### 方式 1：SG Component → Device API

**场景**：SceneGraph 组件控制 Device 的行为

```verse
score_component := class(component):
    var CurrentScore:int = 0
    
    @editable
    var ScoreDisplay:hud_message_device = hud_message_device{}
    
    AddScore(Points:int):void =
        set CurrentScore += Points
        
        # 更新 Device 显示
        ScoreDisplay.SetText("Score: {CurrentScore}")
        ScoreDisplay.Show(AllPlayers)

```text

**适用场景**：

- ✅ 需要 SG 控制 UI 显示
- ✅ 需要 SG 触发音效/特效
- ✅ 逻辑复杂但表现简单

#### 方式 2：Device Event → SG Component

**场景**：Device 事件触发 SceneGraph 逻辑

```verse
game_manager := class(component):
    @editable
    var StartButton:button_device = button_device{}
    
    OnBeginSimulation()<suspends>:void =
        Sleep(0.0)  # 必须等待
        
        # 订阅 Device 事件
        StartButton.InteractedWithEvent.Subscribe(OnGameStart)
    
    OnGameStart(Agent:agent):void =
        # 触发 SceneGraph 事件
        Owner.SendDown(game_started_event{})

```text

**适用场景**：

- ✅ 玩家通过 Device 交互（按钮、触发器）
- ✅ Device 事件作为逻辑入口
- ✅ 需要将 Device 集成到 SG 架构中

#### 方式 3：混合模式 - 双向通信

**场景**：SG 和 Device 相互通信

```verse
# SG 组件
health_component := class(component):
    var Health:int = 100
    
    @editable
    var DamageZone:damage_volume_device = damage_volume_device{}
    
    @editable
    var HealthBar:hud_message_device = hud_message_device{}
    
    OnBeginSimulation()<suspends>:void =
        Sleep(0.0)
        
        # 监听 Device 事件
        DamageZone.AgentEntersEvent.Subscribe(OnEnterDamage)
    
    OnEnterDamage(Agent:agent):void =
        # 更新状态
        set Health -= 10
        
        # 更新 Device 显示
        HealthBar.SetText("HP: {Health}")
        
        # 触发 SG 事件
        if (Health <= 0):
            Owner.SendUp(player_died_event{Player=Agent})

```text

**适用场景**：

- ✅ 复杂交互场景
- ✅ 需要状态同步
- ✅ Device 和 SG 各自发挥优势

### 3.3 联动最佳实践

#### ✅ DO（推荐做法）

1. **明确职责边界**
   - SG：管理状态和业务逻辑
   - Device：处理表现和简单交互

2. **统一数据源**
   ```verse
   # SG 组件作为唯一数据源
   score_manager := class(component):
       var Score:int = 0  # 权威数据
       
       UpdateUI():void =
           # 将数据同步到 Device
           ScoreDisplay.SetText("Score: {Score}")

```text

3. **封装 Device 访问**
   ```verse
   # 创建 Device Wrapper Component
   ui_manager := class(component):
       @editable var HUD:hud_message_device = hud_message_device{}
       
       ShowMessage(Text:string):void =
           HUD.SetText(Text)
           HUD.Show(AllPlayers)

```text

4. **使用类型安全的通信**
   ```verse
   # 通过事件而非直接调用
   ui_update_event := class<concrete>(scene_event):
       var MessageText:string

```text

#### ❌ DON'T（避免做法）

1. **不要让 Device 持有核心状态**
   ```verse
   # ❌ 错误：分数存储在 Device 中
   score_manager_device.SetScore(100)
   
   # ✅ 正确：分数存储在 SG Component 中
   ScoreComponent.SetScore(100)
   ScoreComponent.SyncToDevice()

```text

2. **不要创建循环依赖**
   ```verse
   # ❌ 错误：SG → Device → SG
   Component A 更新 Device
   Device 触发事件
   Component B 响应并更新 Component A
   
   # ✅ 正确：单向数据流
   Component A 发送 Scene Event
   Component B 响应并更新自身
   Component B 通知 Device 更新显示

```text

3. **不要过度混合**
   ```verse
   # ❌ 错误：在一个 Component 中管理 10+ 个 Device
   
   # ✅ 正确：创建专门的 DeviceManager Component
   device_manager := class(component):
       # 集中管理所有 Device

```text

---

## 四、典型场景选择推荐

### 4.1 场景分析矩阵

| 场景类型 | 推荐方案 | 理由 | 示例 |
|---------|---------|------|------|
| **简单触发流程** | Device | 开发快速，无需复杂逻辑 | 玩家踩到按钮 → 开门 |
| **复杂游戏规则** | SceneGraph | 需要模块化、可测试 | 塔防游戏（资源、建造、升级） |
| **UI 密集型** | Device + SG | Device 负责显示，SG 管理状态 | 计分系统、排行榜 |
| **多玩家协作** | SceneGraph | 需要同步状态、事件驱动 | 团队任务、共享资源池 |
| **动态对象生成** | SceneGraph | 运行时组合组件 | 随机敌人（不同技能组合） |
| **音乐/音效** | Device | 成熟的 Audio Device 系统 | 背景音乐、Patchwork 音乐制作 |
| **快速原型** | Device | 可视化配置，无需编码 | 验证玩法可行性 |
| **长期维护项目** | SceneGraph | 组件化利于迭代 | 持续运营的游戏模式 |

### 4.2 典型用例实现对比

#### 用例 1：玩家进入区域触发奖励

**Device 实现**：

```text
在 UEFN 编辑器中：

1. 拖拽 trigger_device 到区域
2. 拖拽 item_granter_device 到场景
3. 连接蓝图：Trigger.Triggered → ItemGranter.Grant

```text

**SceneGraph 实现**：
```verse
reward_zone_component := class(component):
    @editable var RewardItem:string = "GoldCoin"
    @editable var RewardAmount:int = 10
    
    OnBeginSimulation()<suspends>:void =
        Sleep(0.0)
        Owner.SubscribeToEvent<player_entered_event>(OnPlayerEnter)
    
    OnPlayerEnter(Event:player_entered_event):void =
        # 奖励逻辑
        GrantReward(Event.Player, RewardItem, RewardAmount)

```text

**推荐**：**Device**（简单场景，无需复杂逻辑）

---

#### 用例 2：生命值系统（可被多种方式影响）

**Device 实现**：

```markdown
# 难以实现：需要多个 Device 协作
# - 伤害区域：damage_volume_device
# - 治疗道具：item_granter_device + 自定义逻辑
# - UI 显示：hud_message_device
# 状态分散在多个 Device 中，难以同步

```text

**SceneGraph 实现**：
```verse
health_component := class(component):
    var Health:int = 100
    var MaxHealth:int = 100
    
    TakeDamage(Amount:int):void =
        set Health = Max(0, Health - Amount)
        Owner.SendUp(health_changed_event{NewHealth=Health})
        
        if (Health = 0):
            Owner.SendUp(player_died_event{})
    
    Heal(Amount:int):void =
        set Health = Min(MaxHealth, Health + Amount)
        Owner.SendUp(health_changed_event{NewHealth=Health})

```text

**推荐**：**SceneGraph**（核心数值系统，需统一管理）

---

#### 用例 3：UI 消息显示

**Device 实现**：
```verse
<Decides>MyHUD := hud_message_device{}

ShowScore(Score:int):void =
    MyHUD.SetText("Score: {Score}")
    MyHUD.Show(AllPlayers)

```text

**SceneGraph 实现**：
```verse
# SceneGraph 没有内置 UI 组件
# 需要通过 Device 或自定义 Widget

```text

**推荐**：**Device**（UI 显示是 Device 的优势领域）

---

#### 用例 4：角色技能系统（装备不同技能）

**Device 实现**：

```markdown
# 无法实现：Device 不支持动态组合

```text

**SceneGraph 实现**：
```verse
skill_component<public> := interface:
    Activate()<suspends>:void
    Deactivate():void

fireball_skill := class(component, skill_component):
    Activate()<suspends>:void =
        # 发射火球逻辑

# 运行时动态添加技能
Player.AddComponents(fireball_skill{})

```text

**推荐**：**SceneGraph**（动态组合是 SG 的核心能力）

---

### 4.3 选择决策树

```text
开始
  │
  ▼
是否需要发布到正式环境？
  ├─ 是 → 使用 Device（SG 需发布前禁用）
  └─ 否 → 继续
           │
           ▼
         逻辑是否复杂？（多个状态、复杂计算）
           ├─ 是 → 使用 SceneGraph
           └─ 否 → 继续
                    │
                    ▼
                  是否需要运行时动态组合？
                    ├─ 是 → 使用 SceneGraph
                    └─ 否 → 继续
                             │
                             ▼
                           是否 UI/音效密集？
                             ├─ 是 → 使用 Device
                             └─ 否 → 继续
                                      │
                                      ▼
                                    是否快速原型验证？
                                      ├─ 是 → 使用 Device
                                      └─ 否 → 使用 SceneGraph（更好的可维护性）

```text

---

## 五、FAQ 与风险点

### 5.1 常见问题

#### Q1: SceneGraph 和 Device 可以在同一个项目中使用吗？

**A**: ✅ 可以。推荐使用**分层协作模式**：

- SceneGraph 处理核心逻辑
- Device 处理外围功能（UI、音效等）
- 通过 Verse 代码桥接两者

**示例**：
```verse
game_manager := class(component):
    @editable var HUD:hud_message_device = hud_message_device{}
    
    OnScoreChanged(Event:score_changed_event):void =
        # SG 事件 → Device 显示
        HUD.SetText("Score: {Event.NewScore}")

```text

---

#### Q2: SceneGraph 项目可以发布吗？

**A**: ⚠️ **需要发布前禁用 SceneGraph 功能**

Epic 官方说明：
> SceneGraph is currently in Beta. Projects using SceneGraph must disable the feature before publishing.

**解决方案**：

1. 开发阶段使用 SceneGraph
2. 发布前通过配置禁用（具体步骤待官方文档）
3. 或等待 SceneGraph 正式发布

**当前建议**：

- 内部测试/原型：可以使用 SceneGraph
- 正式发布项目：使用 Device 或混合模式（确保核心功能不依赖 SG）

---

#### Q3: 如何在 SceneGraph 中实现 Device 的触发器功能？

**A**: 两种方式：

**方式 1：使用 Device 触发器**
```verse
zone_component := class(component):
    @editable var TriggerZone:trigger_device = trigger_device{}
    
    OnBeginSimulation()<suspends>:void =
        Sleep(0.0)
        TriggerZone.TriggeredEvent.Subscribe(OnPlayerEnter)
    
    OnPlayerEnter(Agent:?agent):void =
        # 处理逻辑

```text

**方式 2：自定义 Component（未来可能）**
```verse
# 当前 SceneGraph API 不支持自定义触发检测
# 需要依赖 Device 或等待官方更新

```text

**推荐**：**混合使用**（Device 触发 + SG 逻辑处理）

---

#### Q4: SceneGraph 的性能如何？

**A**: 📊 **需要实测，但理论上有优势**

**SceneGraph 优势**：

- ✅ 基于 ECS 架构，理论上更高效
- ✅ 组件按需加载/卸载
- ✅ 事件系统异步处理

**Device 优势**：

- ✅ 经过多年优化，稳定可靠
- ✅ 官方保证性能

**建议**：

- 小型项目：性能差异不明显，选择开发效率更高的方案
- 大型项目：需进行性能测试对比

---

#### Q5: 如何选择使用哪个系统？

**A**: 参考 [选择决策树](#43-选择决策树)

**简化原则**：

- **Device 优先**：除非有明确理由使用 SceneGraph
- **SceneGraph 理由**：
  1. 需要复杂的状态管理
  2. 需要运行时动态组合
  3. 需要高度模块化（如代码复用、单元测试）
  4. 项目不需要立即发布

---

### 5.2 风险点

#### ⚠️ 风险 1：SceneGraph Beta 稳定性

**风险描述**：

- SceneGraph 仍是 Beta 功能
- API 可能变化
- 调试工具不完善

**缓解措施**：

1. **核心功能双轨实现**：准备 Device 备用方案
2. **持续关注官方更新**：订阅 Epic 开发者新闻
3. **封装 SG API**：创建 Wrapper 层，便于未来迁移

**示例**：
```verse
# 创建抽象层
trigger_interface<public> := interface:
    OnEnter(Agent:agent):void

# Device 实现
device_trigger := class(trigger_interface):
    # 使用 trigger_device

# SceneGraph 实现
sg_trigger := class(trigger_interface):
    # 使用 SceneGraph 事件

```text

---

#### ⚠️ 风险 2：发布限制

**风险描述**：

- 使用 SceneGraph 的项目无法直接发布
- 需要发布前禁用功能

**缓解措施**：

1. **明确项目发布计划**：短期发布项目避免重度依赖 SG
2. **功能隔离**：将 SG 功能与 Device 功能分离
3. **发布检查清单**：
   ```markdown
   - [ ] 禁用 SceneGraph 功能
   - [ ] 验证核心功能正常运行
   - [ ] 测试所有游戏流程

```text

---

#### ⚠️ 风险 3：学习曲线

**风险描述**：

- SceneGraph 的 ECS 架构较复杂
- 团队需要学习时间

**缓解措施**：

1. **培训资源**：
   - 阅读 [SceneGraph 框架指南](../../../shared/references/scenegraph-framework-guide.md)
   - 阅读 [SceneGraph API 参考](../../../shared/references/scenegraph-api-reference.md)
2. **渐进式采用**：
   - 先在小功能中尝试 SceneGraph
   - 积累经验后再用于核心模块
3. **最佳实践沉淀**：
   - 记录成功案例
   - 创建组件库

---

#### ⚠️ 风险 4：Device API 覆盖不全

**风险描述**：

- 315 个 Device 中，115 个没有 Verse API
- 仅支持编辑器配置，无法通过代码控制

**缓解措施**：

1. **事先调研**：使用前确认 Device 是否有 API
2. **替代方案**：
   - 使用有 API 的类似 Device
   - 通过蓝图事件触发（编辑器配置）
3. **文档参考**：
   - [Device 快速参考手册](../../../shared/references/device-quick-reference.md)
   - [UEFN 设备系统调研报告](../../../shared/references/uefn-device-system-research.md)

---

#### ⚠️ 风险 5：混合使用复杂度

**风险描述**：

- SG + Device 混合使用增加系统复杂度
- 状态同步、调试困难

**缓解措施**：

1. **明确职责边界**：参考 [联动最佳实践](#33-联动最佳实践)
2. **统一数据流**：

```text
   SceneGraph 组件（权威数据）
       ↓
   Scene Event（状态变化通知）
       ↓
   Device Manager Component（同步到 Device）

```text
3. **调试工具**：
   - 创建调试组件，打印事件流
   - 使用 UEFN 编辑器的 Device 可视化工具

---

## 六、后续调研建议

### 6.1 需要深入调研的领域

| 领域 | 优先级 | 调研目标 | 预期产出 |
|------|--------|----------|----------|
| **SceneGraph 性能测试** | 高 | 对比 SG 和 Device 在不同场景下的性能 | 性能测试报告 |
| **SceneGraph 发布流程** | 高 | 澄清如何禁用 SG 功能并保持项目可发布 | 发布检查清单 |
| **Device API 覆盖** | 中 | 明确哪些 Device 有 API，哪些没有 | Device API 对照表 |
| **混合架构模式** | 中 | 总结 SG + Device 混合使用的最佳实践 | 架构模式库 |
| **组件库建设** | 中 | 创建可复用的 SG Component 库 | Component 代码库 |
| **调试工具** | 低 | 开发 SG 事件流可视化工具 | 调试工具 |

### 6.2 拆分子任务建议

基于当前发现，建议创建以下子任务：

#### Task 1: SceneGraph 性能基准测试

- 目标：对比 SG 和 Device 在不同规模下的性能
- 测试场景：
  1. 100 个对象的更新频率
  2. 1000 次事件传播
  3. 复杂层级结构（10 层嵌套）
- 产出：性能测试报告

#### Task 2: SceneGraph 发布流程澄清

- 目标：验证如何禁用 SG 功能并保持项目运行
- 步骤：
  1. 创建包含 SG 的测试项目
  2. 禁用 SG 功能
  3. 验证 Device 部分正常工作
- 产出：发布检查清单

#### Task 3: Device API 完整对照表

- 目标：列出所有 Device 的 API 可用性
- 方法：
  1. 遍历 315 个 Device
  2. 标记是否有 Verse API
  3. 记录主要 API 方法
- 产出：`device-api-coverage.md`

#### Task 4: 混合架构实践案例

- 目标：在实际项目中验证混合架构
- 实现：
  1. 选择典型场景（如塔防游戏）
  2. 使用 SG 处理核心逻辑
  3. 使用 Device 处理 UI/音效
- 产出：案例研究报告

#### Task 5: 可复用组件库

- 目标：创建通用 SceneGraph Component 库
- 组件清单：
  - HealthComponent
  - InventoryComponent
  - TimerComponent
  - StateManagerComponent
- 产出：`Core/skills/programming/verseDev/shared/component-library/`

---

## 七、参考资源

### 7.1 内部文档

| 文档 | 路径 | 说明 |
|------|------|------|
| SceneGraph 框架指南 | `shared/references/scenegraph-framework-guide.md` | 完整框架说明 |
| SceneGraph API 参考 | `shared/references/scenegraph-api-reference.md` | 所有 API 详细说明 |
| Device 快速参考 | `shared/references/device-quick-reference.md` | Device 分类索引 |
| Device 系统调研 | `shared/references/uefn-device-system-research.md` | 315 个 Device 完整清单 |
| verseEventFlow Skill | `../verseEventFlow/SKILL.md` | 事件流层技能 |
| verseComponent Skill | `../verseComponent/SKILL.md` | 组件层技能 |

### 7.2 官方文档

| 文档 | 链接 |
|------|------|
| SceneGraph 概述 | https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite |
| SceneGraph 入门 | https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite |
| Scene Events 详解 | https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite |
| Verse API 文档 | https://dev.epicgames.com/documentation/en-us/fortnite/verse-api |
| Device 文档索引 | https://dev.epicgames.com/documentation/en-us/fortnite/creative-devices-in-unreal-editor-for-fortnite |

### 7.3 社区资源

| 资源 | 链接 | 说明 |
|------|------|------|
| Awesome Verse | https://github.com/spilth/awesome-verse | Verse 资源汇总 |
| UEFN Tools | https://uefntools.com/resources | UEFN 工具和教程 |
| Epic Developer Forum | https://forums.unrealengine.com/c/fortnite/uefn/ | 官方论坛 |

---

## 八、版本历史

| 版本 | 日期 | 作者 | 变更说明 |
|------|------|------|----------|
| 0.1 | 2026-01-05 | Copilot Agent | 初始版本：框架搭建、能力清单、联动模式 |

---

## 九、附录

### 附录 A：术语表

| 术语 | 英文 | 说明 |
|------|------|------|
| SceneGraph | SceneGraph | UEFN 的实体-组件-事件架构系统（Beta） |
| Device | Device | UEFN 的传统预制功能模块系统 |
| Entity | Entity | SceneGraph 中的实体，场景中所有对象的基类 |
| Component | Component | SceneGraph 中的组件，定义实体的行为和数据 |
| Scene Event | Scene Event | SceneGraph 中的事件，组件间通信的机制 |
| ECS | Entity-Component-System | 实体-组件-系统架构模式 |
| Verse | Verse | UEFN 的编程语言 |
| UEFN | Unreal Editor for Fortnite | 堡垒之夜创意模式编辑器 |

### 附录 B：快速参考卡片

#### SceneGraph 核心 API

```verse
# Entity
entity.AddEntities([]entity)
entity.GetComponent<T>()
entity.SendUp(scene_event)
entity.SendDown(scene_event)

# Component
component.GetOwner()<decides>:entity
component.OnBeginSimulation()<suspends>:void
component.OnSimulate(float)<suspends>:void

# Scene Event
scene_event := class<abstract>
my_event := class<concrete>(scene_event)

```text

#### Device 常用 API

```verse
# Trigger
trigger_device.TriggeredEvent
trigger_device.EndedEvent

# HUD Message
hud_message_device.SetText(string)
hud_message_device.Show([]agent)

# Score Manager
score_manager_device.SetScore(agent, int)
score_manager_device.IncrementScore(agent, int)

```text

---

**报告状态**：✅ 初步完成，持续更新中

**下一步行动**：

1. 审阅报告并收集反馈
2. 执行后续调研任务（性能测试、发布流程等）
3. 在实际项目中验证推荐方案
4. 持续补充 FAQ 和最佳实践

---

*最后更新：2026-01-05*
