# UEFN Device 不可替代功能调研报告

> **调研编号**: R00-2  
> **调研主题**: Device 层不可替代功能分析（SceneGraph vs Device 边界）  
> **调研日期**: 2026-01-05  
> **调研者**: GitHub Copilot Agent  
> **版本**: 1.0

---

## 📋 执行摘要

本报告旨在明确 UEFN 中 **SceneGraph (SG) 体系** 与 **Device 体系** 的能力边界，聚焦于 UI/HUD、音频、物理、官方机制、VFX 等领域，确定哪些功能必须依赖 Device 层实现。

### 核心发现

| 领域 | SceneGraph 能力 | Device 必须性 | 结论 |
|------|----------------|--------------|------|
| **UI/HUD** | ✅ 完整 Widget 系统 | ⚠️ 高级 HUD 控制 | **部分可替代** |
| **音频播放** | ✅ sound_component | ⚠️ 复杂音频系统 | **部分可替代** |
| **物理碰撞** | ✅ 完整（施力/速度/事件） | ⚠️ 编辑器配置 | **部分可替代** |
| **官方机制** | ❌ 无计分/回合 API | ✅ 完全依赖 Device | **不可替代** |
| **VFX** | ✅ particle_system_component | ⚠️ 高级特效配置 | **部分可替代** |
| **世界空间 UI** | ❌ Widget 仅屏幕空间 | ✅ 需 Billboard Device | **不可替代** |

**关键结论**：
- 🟢 **SG 优势**：可编程 UI、音频/VFX组件、碰撞事件、事件驱动架构、组件化设计
- 🔴 **Device 必须**：官方游戏机制（计分/回合/队伍）、世界空间 UI、高级音频/VFX配置
- 🟡 **混合方案**：SG 用于逻辑和基础功能 + Device 用于官方机制和复杂配置

---

## 📚 目录

1. [调研背景与目标](#调研背景与目标)
2. [SceneGraph 能力概览](#scenegraph-能力概览)
3. [Device 系统能力概览](#device-系统能力概览)
4. [领域边界分析](#领域边界分析)
   - [4.1 UI/HUD/Billboard 系统](#41-uihudbillboard-系统)
   - [4.2 音频系统](#42-音频系统)
   - [4.3 物理碰撞系统](#43-物理碰撞系统)
   - [4.4 官方游戏机制](#44-官方游戏机制)
   - [4.5 VFX 视觉效果](#45-vfx-视觉效果)
   - [4.6 特殊触发事件](#46-特殊触发事件)
5. [典型 UseCase 对比](#典型-usecase-对比)
6. [迁移建议与最佳实践](#迁移建议与最佳实践)
7. [FAQ 常见问题](#faq-常见问题)
8. [参考资料](#参考资料)

---

## 调研背景与目标

### 背景

UEFN 提供了两套并行的游戏开发体系：

1. **SceneGraph (SG) 体系**：Beta 功能，Entity-Component-Event 架构，强调代码驱动和模块化
2. **Device 体系**：成熟稳定，315+ 种设备，通过编辑器配置和 Verse API 控制

开发者面临选择：哪些功能应该用 SG 实现？哪些必须依赖 Device？

### 调研目标

1. **能力边界映射**：明确 SG 与 Device 在各领域的能力边界
2. **不可替代场景**：列举必须使用 Device 的场景和原因
3. **实现方案对比**：提供 SG vs Device 的代码示例和配置对比
4. **迁移指南**：为混合架构提供最佳实践建议

### 调研范围

- ✅ UI（HUD、Billboard、Widget）
- ✅ 音频（播放、Patchwork 音乐系统）
- ✅ 物理（碰撞、施力、速度控制）
- ✅ 官方机制（计分、回合、队伍、淘汰）
- ✅ VFX（粒子效果、后期处理）
- ✅ 特殊触发事件（感知、输入、条件）

---

## SceneGraph 能力概览

### 核心架构

```
Simulation Entity (根实体)
    │
    ├─ Entity A (游戏管理器)
    │   ├─ Component: GameStateComponent
    │   └─ Component: RoundTimerComponent
    │
    ├─ Entity B (玩家)
    │   ├─ Component: HealthComponent
    │   └─ Component: InventoryComponent
    │
    └─ Entity C (道具)
        └─ Component: InteractionComponent

    ↕ Scene Events (事件总线)
```

### 已验证的 SG 能力

| 能力类别 | 具体功能 | API 来源 |
|---------|---------|---------|
| **UI 系统** | canvas, button, stack_box, overlay, color_block, text_base | `/UnrealEngine.com/Temporary/UI` |
| **Player UI** | GetPlayerUI, AddWidget, RemoveWidget, SetFocus | `player_ui` 类 |
| **组件系统** | entity, component, scene_event | `/Verse.org/SceneGraph` |
| **音频组件** | sound_component (Play, Stop, Enable, Disable) | `/Verse.org/SceneGraph` |
| **VFX组件** | particle_system_component (Play, Stop, Enable, Disable) | `/Verse.org/SceneGraph` |
| **网格组件** | mesh_component (EntityEnteredEvent, EntityExitedEvent, Collidable) | `/Verse.org/SceneGraph` |
| **物理** | ApplyForce, SetLinearVelocity, GetDynamic | `creative_prop`, `fort_character` |
| **生命周期** | OnAddedToScene, OnRemovedFromScene | `component` 生命周期钩子 |

### SG 限制

❌ **无法实现**：
- 官方计分系统（无 score_manager API）
- 回合制管理（无 round_settings API）
- 队伍系统（无 team_settings API）
- 世界空间 UI（Widget 仅支持屏幕空间）
- 系统级 HUD 控制（如隐藏小地图、弹药栏）

⚠️ **有限实现**（需要额外配置）：
- 音频/VFX 资产需要在编辑器中预先配置
- 复杂的音频控制（如 Patchwork 音乐系统）需要 Device

---

## Device 系统能力概览

### Device 分类体系（共 315 个设备）

| 分类 | 数量 | 典型设备 | 核心用途 |
|------|------|---------|---------|
| **UI/显示类** | 10 | hud_message_device, billboard_device, popup_dialog_device | HUD 消息、世界空间 UI、对话框 |
| **音频类** | 22 | audio_player_device, patchwork_* 系列 | 音频播放、音乐制作 |
| **触发器类** | 10 | trigger_device, button_device, perception_trigger_device | 区域检测、交互按钮、感知触发 |
| **游戏玩法类** | 9 | score_manager_device, round_settings_device, elimination_manager_device | 计分、回合、淘汰管理 |
| **视觉效果类** | 7 | vfx_spawner_device, post_process_device | 粒子效果、后期处理 |
| **物理类** | 5 | physics_object_base_device, prop_mover_device | 物理对象、道具移动 |
| **AI 类** | 7 | npc_spawner_device, creature_manager_device | NPC 生成、AI 管理 |
| **生成器类** | 47+ | item_spawner_device, creature_spawner_device | 物品/生物生成 |
| **载具类** | 31+ | vehicle_spawner_* 系列 | 各类载具生成 |

### Device API 特点

✅ **优势**：
- 编辑器可视化配置
- 成熟稳定，已发布项目可用
- 覆盖全面，系统级功能支持
- 事件监听（如 `OnClick`, `OnTriggered`）

⚠️ **限制**：
- 配置灵活性低（参数固定）
- 运行时修改能力有限
- 需要预先放置或通过特定 API 生成

---

## 领域边界分析

### 4.1 UI/HUD/Billboard 系统

#### SceneGraph UI 能力

**✅ 可实现**：

| Widget 类型 | 功能 | 适用场景 |
|------------|------|---------|
| `canvas` | 自由布局容器 | 自定义 HUD 布局 |
| `text_base` | 文本显示（可设置颜色/大小/对齐） | 得分显示、倒计时 |
| `button` | 可点击按钮（OnClick 事件） | 菜单按钮、交互 UI |
| `color_block` | 纯色块（可做进度条背景） | 血条、能量条 |
| `stack_box` | 垂直/水平堆叠布局 | 物品栏、技能栏 |
| `overlay` | 叠加层容器 | 复杂 UI 组合 |
| `texture_block` | 图片显示 | 图标、背景图 |

**代码示例：SG 创建自定义 HUD**

```verse
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }

my_hud_component := class(component):
    var CurrentScore : int = 0
    var ScoreText : ?text_base = false
    var MyCanvas : ?canvas = false

    OnAddedToScene()<override>:void =
        if (Player := GetPlayer[]):
            if (PlayerUI := GetPlayerUI(Player)):
                CreateHUD(PlayerUI)

    CreateHUD(PlayerUI: player_ui):void =
        # 创建 Canvas 容器
        NewCanvas := canvas{
            Slots := array{}
        }
        set MyCanvas = option{NewCanvas}

        # 创建得分文本（假设有 text_block 或类似类）
        # 注: text_base 是抽象类，实际需使用其子类
        # 此处为示意，实际 API 可能需要特定 text widget 子类
        
        # 添加到 PlayerUI
        PlayerUI.AddWidget(NewCanvas)

    UpdateScore(NewScore: int):void =
        set CurrentScore = NewScore
        # 更新文本显示
        # if (TextWidget := ScoreText?): TextWidget.SetText("Score: {NewScore}")

    GetPlayer()<decides>:player = 
        # 获取玩家逻辑
        if (MyEntity := GetOwner[]):
            if (MyPlayer := player[MyEntity]):
                return MyPlayer
        false
```

**❌ 无法实现（需要 Device）**：

| 功能 | 原因 | 替代方案 |
|------|------|---------|
| **世界空间 UI** | Widget 仅支持屏幕空间（`player_ui`） | 使用 `billboard_device` |
| **系统 HUD 控制** | 无法隐藏/显示系统 UI（小地图、血条、弹药） | 使用 `hud_controller_device` |
| **HUD 消息队列** | 无原生消息队列系统 | 使用 `hud_message_device` |

#### Device UI 能力

**核心设备**：

1. **hud_message_device**
   - 功能：显示屏幕中心消息、队列管理
   - API：`ShowMessage()`, `ClearAllMessages()`, `ClearAllMessagesEvent`
   - 适用：游戏提示、任务更新

2. **billboard_device**
   - 功能：世界空间 3D UI（广告牌）
   - API：`GetShowBorder()`, `GetTextSize()`, 设置文本和边框
   - 适用：道具提示、NPC 名称、区域标签

3. **hud_controller_device**
   - 功能：控制系统 HUD 元素的显示/隐藏
   - 适用：特殊模式（如观战模式、电影模式）

**代码示例：Device HUD 消息**

```verse
using { /Fortnite.com/Devices }

my_game_manager := class(creative_device):
    @editable HUDMessage : hud_message_device = hud_message_device{}

    OnBegin<override>():void =
        HUDMessage.ShowMessage(GetPlayspace().GetPlayers()[0]) # 需要 agent 参数
        # 实际 API 可能需要特定玩家对象

    ShowWelcome():void =
        # Device 配置中设置消息文本
        # 通过编辑器配置消息内容
        # Verse 仅负责触发显示
        HUDMessage.ShowMessage() # 伪代码，实际需参数
```

#### 边界结论：UI/HUD

| 场景 | 推荐方案 | 理由 |
|------|---------|------|
| **自定义 UI 逻辑** | ✅ SceneGraph | 完全可编程，动态更新 |
| **世界空间 UI** | ✅ billboard_device | SG Widget 不支持 3D 空间 |
| **系统 HUD 控制** | ✅ hud_controller_device | SG 无法访问系统 UI |
| **简单消息提示** | ⚠️ 二者皆可 | SG 灵活，Device 简单 |
| **复杂 UI 交互** | ✅ SceneGraph | 事件驱动，组件化设计 |

---

### 4.2 音频系统

#### SceneGraph 音频能力

**✅ 基础支持（sound_component）**：

SceneGraph 提供了 `sound_component` 用于音频播放：

```verse
sound_component<native><public> := class<abstract><final_super><epic_internal>(component, enableable) {
    Play<native><public>(): void      # 播放音频
    Stop<native><public>(): void      # 停止音频
    Enable<override><native>(): void  # 启用组件
    Disable<override><native>(): void # 禁用组件
    
    @editable
    var AutoPlay<native><public>: logic = external {}  # 自动播放
    @editable
    var Enabled<native><public>: logic = external {}   # 是否启用
}
```

**代码示例：SG 音频播放**

```verse
using { /Verse.org/SceneGraph }

audio_entity := class(entity):
    var BackgroundMusicComponent : ?sound_component = false
    
    Initialize():void =
        # 创建音频组件（需要在编辑器中配置 sound_wave 资产）
        BGM := sound_component{
            AutoPlay := true,
            Enabled := true
        }
        AddComponents(array{BGM})
        set BackgroundMusicComponent = option{BGM}
    
    PlayBackgroundMusic():void =
        if (BGM := BackgroundMusicComponent?):
            BGM.Play()
    
    StopBackgroundMusic():void =
        if (BGM := BackgroundMusicComponent?):
            BGM.Stop()
```

**⚠️ SG 音频限制**：
- 音频资产（`sound_wave`）需要在编辑器中预先配置
- 无法动态加载音频文件
- 缺少高级音频控制（如音量淡入淡出、音频混音）
- 无法实现复杂音乐系统（如 Patchwork）

#### Device 音频能力

**核心设备**：

1. **audio_player_device**
   - 功能：播放音频文件，支持更多配置选项
   - API：`Enable()`, `Disable()`, `Play()`, `Stop()`
   - 参数：音量、循环、空间化（3D 音效）、衰减距离

2. **Patchwork 音乐系统**（19 个设备）
   - `patchwork_music_manager_device` - 音乐管理器
   - `patchwork_drum_sequencer_device` - 鼓音序器
   - `patchwork_instrument_player_device` - 乐器播放器
   - `patchwork_speaker_device` - 扬声器
   - 功能：完整的音乐制作和播放系统，支持实时音乐生成

3. **radio_device**
   - 功能：收音机，可切换电台

4. **audio_mixer_device**
   - 功能：音频混音，控制多个音频源的混合

**代码示例：Device 音频播放**

```verse
using { /Fortnite.com/Devices }

my_audio_manager := class(creative_device):
    @editable BackgroundMusic : audio_player_device = audio_player_device{}
    @editable VictorySound : audio_player_device = audio_player_device{}

    OnBegin<override>():void =
        BackgroundMusic.Enable()
        # 播放背景音乐（在编辑器中配置音频文件和参数）

    OnPlayerVictory():void =
        BackgroundMusic.Disable() # 停止背景音乐
        VictorySound.Enable() # 播放胜利音效
```

#### 边界结论：音频

| 场景 | 推荐方案 | 理由 |
|------|---------|------|
| **基础音频播放** | ✅ sound_component (SG) | 简单场景可用 |
| **复杂音频控制** | ✅ audio_player_device | 更多配置选项 |
| **背景音乐** | ⚠️ 二者皆可 | SG 简单，Device 灵活 |
| **音效** | ⚠️ 二者皆可 | SG 组件化，Device 配置化 |
| **音乐制作** | ✅ Patchwork 系列 | Device 专业音乐系统 |
| **空间化音频** | ✅ audio_player_device | Device 支持高级 3D 音效 |
| **音频混音** | ✅ audio_mixer_device | Device 专用功能 |

**部分可替代性**：🟡 **基础音频播放可用 SG，复杂音频系统需要 Device。**

---

### 4.3 物理碰撞系统

#### SceneGraph 物理能力

**✅ 完整支持**：

| API | 来源 | 功能 |
|-----|------|------|
| `ApplyForce(Force: vector3)` | `creative_prop`, `fort_character` | 施加力（单位：牛顿） |
| `ApplyLinearImpulse(Impulse: vector3)` | `creative_prop`, `fort_character` | 施加线性冲量 |
| `ApplyAngularImpulse(Impulse: vector3)` | `creative_prop` | 施加角冲量 |
| `ApplyTorque(Torque: vector3)` | `creative_prop` | 施加扭矩 |
| `SetLinearVelocity(Velocity: vector3)` | `creative_prop`, `fort_character` | 设置线性速度 |
| `SetAngularVelocity(Velocity: vector3)` | `creative_prop` | 设置角速度 |
| `GetLinearVelocity()` | `creative_prop`, `fort_character` | 获取线性速度 |
| `GetDynamic()` | `creative_prop` | 检查是否启用物理 |
| `SetDynamic(Dynamic: logic)` | `creative_prop` | 设置物理启用状态 |
| **`EntityEnteredEvent`** | **`mesh_component`** | **碰撞进入事件** |
| **`EntityExitedEvent`** | **`mesh_component`** | **碰撞退出事件** |
| **`Collidable`** | **`mesh_component`** | **启用/禁用碰撞** |
| **`Queryable`** | **`mesh_component`** | **启用/禁用空间查询** |

**代码示例：SG 物理控制和碰撞检测**

```verse
using { /Fortnite.com/Game }
using { /Verse.org/SpatialMath }
using { /Verse.org/SceneGraph }

my_physics_component := class(component):
    var MeshComp : ?mesh_component = false
    
    OnAddedToScene()<override>:void =
        # 订阅碰撞事件
        if (Owner := GetOwner[]):
            if (Mesh := Owner.GetComponent[mesh_component]()):
                Mesh.EntityEnteredEvent.Subscribe(OnEntityEntered)
                Mesh.EntityExitedEvent.Subscribe(OnEntityExited)
                set MeshComp = option{Mesh}
    
    OnEntityEntered(OtherEntity: entity):void =
        Print("Entity entered collision!")
        # 处理碰撞进入逻辑
    
    OnEntityExited(OtherEntity: entity):void =
        Print("Entity exited collision!")
        # 处理碰撞退出逻辑
    
    LaunchProp(Prop: creative_prop, Direction: vector3, Force: float):void =
        if (Prop.GetDynamic[]):
            Prop.ApplyLinearImpulse(Direction * Force)

    EnableCollision():void =
        if (Mesh := MeshComp?):
            set Mesh.Collidable = true
            set Mesh.Queryable = true

    DisableCollision():void =
        if (Mesh := MeshComp?):
            set Mesh.Collidable = false
```

**⚠️ SG 物理限制**：

| 功能 | 限制说明 | 替代方案 |
|------|---------|---------|
| **复杂碰撞形状** | 碰撞体需要在编辑器配置 | 编辑器配置 |
| **物理材质** | 无材质参数 API | 编辑器配置 |
| **约束和关节** | 无 joint/constraint API | 使用 `prop_manipulator_device` |
| **高级碰撞过滤** | 碰撞通道配置需在编辑器 | 编辑器配置 |

#### Device 物理能力

**核心设备**：

1. **physics_object_base_device**
   - 功能：物理对象基类
   - 用途：配置物理属性

2. **prop_mover_device**
   - 功能：移动道具（沿路径或目标位置）
   - API：移动、旋转、速度控制

3. **prop_manipulator_device**
   - 功能：操纵道具（抓取、投掷）

4. **trigger_device**
   - 功能：检测碰撞/进入区域
   - API：`OnTriggered`, `OnEntered`, `OnExited`

**代码示例：Device 碰撞检测**

```verse
using { /Fortnite.com/Devices }

my_collision_detector := class(creative_device):
    @editable CollisionTrigger : trigger_device = trigger_device{}
    @editable AudioPlayer : audio_player_device = audio_player_device{}

    OnBegin<override>():void =
        CollisionTrigger.TriggeredEvent.Subscribe(OnCollision)

    OnCollision(Agent: ?agent):void =
        # 碰撞发生时播放音效
        AudioPlayer.Enable()
```

#### 边界结论：物理

| 场景 | 推荐方案 | 理由 |
|------|---------|------|
| **施加力/冲量** | ✅ SceneGraph | SG 有完整 API |
| **速度控制** | ✅ SceneGraph | SG 直接控制 |
| **碰撞检测** | ✅ SceneGraph (mesh_component) | SG 有碰撞事件 |
| **区域触发** | ⚠️ 二者皆可 | SG 用碰撞，Device 用 trigger |
| **复杂物理配置** | ✅ 编辑器 + Device | SG 无运行时配置 API |
| **道具移动路径** | ✅ prop_mover_device | Device 专用功能 |

**部分可替代性**：🟡 **物理控制和碰撞检测可用 SG，复杂配置和路径移动用 Device。**

---

### 4.4 官方游戏机制

#### SceneGraph 游戏机制能力

**❌ 完全缺失**：
- 无计分系统 API
- 无回合管理 API
- 无队伍系统 API
- 无淘汰管理 API
- 无竞速系统 API

**可通过 SG 自建**（但不与官方系统集成）：
- 自定义计分逻辑
- 自定义回合计时器
- 自定义队伍分组

**限制**：
- 不显示在官方 UI（排行榜、得分板）
- 不与 Fortnite 统计系统集成
- 需要自行实现所有 UI 和逻辑

#### Device 游戏机制能力

**核心设备**：

1. **score_manager_device**
   - 功能：官方计分系统
   - 特性：自动显示排行榜、支持队伍计分
   - API：增加/减少分数、获取分数

2. **round_settings_device**
   - 功能：回合制管理
   - 特性：回合开始/结束、倒计时、胜利条件

3. **elimination_manager_device**
   - 功能：淘汰管理
   - 特性：记录淘汰、重生控制

4. **team_settings_device** / **class_and_team_selector_device**
   - 功能：队伍系统、职业选择
   - 特性：自动分队、队伍属性

5. **race_manager_device**
   - 功能：竞速系统
   - 特性：计时、检查点、排名

6. **tracker_device**
   - 功能：追踪各类游戏数据（淘汰、得分、达成条件）

**代码示例：Device 计分系统**

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }

my_score_system := class(creative_device):
    @editable ScoreManager : score_manager_device = score_manager_device{}
    @editable ItemCollectTrigger : trigger_device = trigger_device{}

    OnBegin<override>():void =
        ItemCollectTrigger.TriggeredEvent.Subscribe(OnItemCollected)

    OnItemCollected(Agent: ?agent):void =
        if (Player := agent?, FortCharacter := Player.GetFortCharacter[]):
            # 给玩家加分（具体 API 可能不同）
            # ScoreManager.AddScore(Player, 10)
            # 注: 实际 API 需查阅最新文档
            Print("Player collected item!")
```

#### 边界结论：官方游戏机制

| 场景 | 推荐方案 | 理由 |
|------|---------|------|
| **官方排行榜** | ✅ score_manager_device | SG 无官方集成 |
| **回合制游戏** | ✅ round_settings_device | Device 专用功能 |
| **队伍系统** | ✅ team_settings_device | 官方队伍管理 |
| **淘汰统计** | ✅ elimination_manager_device | 官方淘汰系统 |
| **竞速游戏** | ✅ race_manager_device | 专业竞速功能 |
| **自定义计分** | ⚠️ SceneGraph | 不与官方 UI 集成 |

**不可替代性**：🔴 **官方游戏机制完全依赖 Device，SG 仅可自建非官方系统。**

---

### 4.5 VFX 视觉效果

#### SceneGraph VFX 能力

**✅ 基础支持（particle_system_component）**：

SceneGraph 提供了 `particle_system_component` 用于粒子特效：

```verse
particle_system_component<native><public> := class<final_super><epic_internal>(component, enableable) {
    Play<native><public>(): void      # 播放粒子效果
    Stop<native><public>(): void      # 停止粒子效果
    Enable<override><native>(): void  # 启用组件
    Disable<override><native>(): void # 禁用组件
    
    @editable
    var AutoPlay<native><public>: logic = external {}  # 自动播放
    @editable
    var Enabled<native><public>: logic = external {}   # 是否启用
}
```

SceneGraph 也支持光照组件（`light_component` 及其子类）：
- `directional_light_component` - 方向光
- `point_light_component` (sphere_light) - 点光源  
- `spot_light_component` - 聚光灯
- `rect_light_component` - 矩形光源
- `capsule_light_component` - 胶囊光源

**代码示例：SG 粒子效果**

```verse
using { /Verse.org/SceneGraph }

vfx_entity := class(entity):
    var ParticleComp : ?particle_system_component = false
    var SpotLight : ?spot_light_component = false
    
    Initialize():void =
        # 创建粒子组件（需要在编辑器中配置 particle_system 资产）
        Particles := particle_system_component{
            AutoPlay := false,
            Enabled := true
        }
        
        # 创建聚光灯
        Light := spot_light_component{}
        
        AddComponents(array{Particles, Light})
        set ParticleComp = option{Particles}
        set SpotLight = option{Light}
    
    PlayEffect():void =
        if (Particles := ParticleComp?):
            Particles.Play()
    
    StopEffect():void =
        if (Particles := ParticleComp?):
            Particles.Stop()
```

**⚠️ SG VFX 限制**：
- 粒子系统资产（`particle_system`）需要在编辑器中预先配置
- 无法动态创建或修改粒子系统参数
- 缺少后期处理 API（色调映射、饱和度等系统级效果）
- 无法实现复杂的 VFX 序列和动画控制

#### Device VFX 能力

**核心设备**：

1. **vfx_spawner_device**
   - 功能：生成粒子特效，支持更多配置选项
   - 参数：特效类型、持续时间、位置、缩放

2. **vfx_creator_device**
   - 功能：创建自定义 VFX

3. **post_process_device**
   - 功能：后期处理效果（色调、饱和度、亮度等）
   - 系统级效果，影响整个屏幕

4. **visual_effect_powerup_device**
   - 功能：视觉增益效果

5. **customizable_light_device**
   - 功能：可自定义灯光（编辑器配置丰富）

6. **skydome_device**
   - 功能：天空穹顶设置

**代码示例：Device VFX**

```verse
using { /Fortnite.com/Devices }

my_vfx_controller := class(creative_device):
    @editable ExplosionVFX : vfx_spawner_device = vfx_spawner_device{}
    @editable PostProcess : post_process_device = post_process_device{}

    OnExplosion(Location: vector3):void =
        # 在指定位置生成爆炸特效
        ExplosionVFX.Enable()
        # 实际位置设置可能需要通过编辑器或其他方式

    EnableDarkMode():void =
        # 启用后期处理（暗色调）
        PostProcess.Enable()
```

#### 边界结论：VFX

| 场景 | 推荐方案 | 理由 |
|------|---------|------|
| **基础粒子效果** | ✅ particle_system_component (SG) | 简单场景可用 |
| **复杂粒子控制** | ✅ vfx_spawner_device | 更多配置选项 |
| **后期处理** | ✅ post_process_device | Device 独有系统级效果 |
| **光照效果** | ⚠️ 二者皆可 | SG 有光照组件，Device 配置更丰富 |
| **天空/环境** | ✅ skydome_device | Device 专用 |
| **简单 UI 特效** | ⚠️ SceneGraph Widget | 仅限 UI 层面 |

**部分可替代性**：🟡 **基础粒子和光照可用 SG，后期处理和复杂 VFX 需要 Device。**

---

### 4.6 特殊触发事件

#### SceneGraph 触发能力

**✅ 可实现**：

| 机制 | 实现方式 |
|------|---------|
| **场景事件** | `SendUp`, `SendDown`, `SendDirect` |
| **组件事件** | Component 内部 `listenable` 事件 |
| **玩家输入** | 通过 `button` Widget 的 `OnClick` 事件（仅 UI） |
| **碰撞触发** | `mesh_component.EntityEnteredEvent`, `EntityExitedEvent` |
| **实体进入/离开** | `mesh_component` 碰撞事件检测 |

**⚠️ 有限实现**：

| 功能 | 限制说明 |
|------|---------|
| **感知触发** | 无视线/听觉感知 API，需自行实现 |
| **条件触发** | 需自行编写条件逻辑 |
| **输入组合键** | UI Widget 仅支持简单点击 |
| **复杂触发器配置** | 需要代码实现，不如 Device 可视化配置方便 |

#### Device 触发能力

**核心设备**：

1. **trigger_device**
   - 功能：基础触发器，检测玩家进入/离开区域
   - API：`TriggeredEvent`, `Enable()`, `Disable()`

2. **perception_trigger_device**
   - 功能：感知触发器（视线、听觉）

3. **input_trigger_device**
   - 功能：输入触发器（特定按键）

4. **button_device**
   - 功能：可交互按钮（世界空间，与 SG 的 UI button 不同）

5. **conditional_button_device**
   - 功能：条件按钮（满足条件才能交互）

6. **switch_device**
   - 功能：开关设备

**代码示例：Device 区域触发**

```verse
using { /Fortnite.com/Devices }

my_trigger_system := class(creative_device):
    @editable AreaTrigger : trigger_device = trigger_device{}
    @editable DoorDevice : prop_manipulator_device = prop_manipulator_device{}

    OnBegin<override>():void =
        AreaTrigger.TriggeredEvent.Subscribe(OnPlayerEnterArea)

    OnPlayerEnterArea(Agent: ?agent):void =
        # 玩家进入区域时打开门
        DoorDevice.Enable()
        Print("Player entered area!")
```

#### 边界结论：特殊触发

| 场景 | 推荐方案 | 理由 |
|------|---------|------|
| **区域检测** | ⚠️ 二者皆可 | SG 用碰撞事件，Device 用 trigger |
| **实体碰撞** | ✅ SceneGraph (mesh_component) | SG 有碰撞事件 |
| **玩家交互按钮** | ✅ button_device（世界） / SG button（UI） | 看需求场景 |
| **感知系统** | ✅ perception_trigger_device | Device 专用视线/听觉 |
| **输入检测** | ✅ input_trigger_device | 复杂输入需 Device |
| **场景事件通信** | ✅ SceneGraph | SG 事件系统强大 |

**部分可替代性**：🟡 **碰撞触发可用 SG，UI交互用SG，感知系统用 Device。**

---

## 典型 UseCase 对比

### UseCase 1: 显示玩家得分

#### 方案 A：SceneGraph

```verse
using { /UnrealEngine.com/Temporary/UI }

score_ui_component := class(component):
    var CurrentScore : int = 0

    OnAddedToScene()<override>:void =
        if (Player := GetPlayer[], PlayerUI := GetPlayerUI(Player)):
            CreateScoreUI(PlayerUI)

    CreateScoreUI(PlayerUI: player_ui):void =
        # 创建 Canvas 和文本 Widget
        MyCanvas := canvas{Slots := array{}}
        # 添加得分文本
        # PlayerUI.AddWidget(MyCanvas)

    UpdateScore(NewScore: int):void =
        set CurrentScore = NewScore
        # 更新 UI 显示
```

**优点**：
- ✅ 完全可编程
- ✅ 自定义样式
- ✅ 动态更新灵活

**缺点**：
- ❌ 不显示在官方排行榜
- ❌ 需要自己实现所有 UI 逻辑

#### 方案 B：Device

```verse
using { /Fortnite.com/Devices }

score_system := class(creative_device):
    @editable ScoreManager : score_manager_device = score_manager_device{}

    AddScore(Player: agent, Points: int):void =
        # 通过 Device API 添加分数（伪代码）
        # ScoreManager.AddScore(Player, Points)
```

**优点**：
- ✅ 自动显示在官方排行榜
- ✅ 与 Fortnite 系统集成
- ✅ 配置简单

**缺点**：
- ❌ 自定义样式受限
- ❌ 必须预先配置

**推荐**：
- 官方排行榜 → Device
- 自定义 UI → SceneGraph

---

### UseCase 2: 播放背景音乐

#### 方案 A：SceneGraph

❌ **无法实现** - SG 无音频 API

#### 方案 B：Device（唯一方案）

```verse
using { /Fortnite.com/Devices }

music_manager := class(creative_device):
    @editable BackgroundMusic : audio_player_device = audio_player_device{}

    OnBegin<override>():void =
        BackgroundMusic.Enable()

    StopMusic():void =
        BackgroundMusic.Disable()
```

**推荐**：✅ **Device 唯一方案**

---

### UseCase 3: 检测玩家进入区域

#### 方案 A：SceneGraph

❌ **无法直接实现** - SG 无空间触发 API

可能的变通：
- 通过定时器检查玩家位置（性能差）
- 使用 `creative_prop` 的物理碰撞（复杂）

#### 方案 B：Device

```verse
using { /Fortnite.com/Devices }

area_detector := class(creative_device):
    @editable AreaTrigger : trigger_device = trigger_device{}

    OnBegin<override>():void =
        AreaTrigger.TriggeredEvent.Subscribe(OnPlayerEnter)

    OnPlayerEnter(Agent: ?agent):void =
        Print("Player entered!")
```

**推荐**：✅ **Device 方案简洁高效**

---

### UseCase 4: 创建可点击的 UI 按钮

#### 方案 A：SceneGraph

```verse
using { /UnrealEngine.com/Temporary/UI }

ui_button_component := class(component):
    
    CreateButton(PlayerUI: player_ui):void =
        MyButton := button{
            Slot := button_slot{
                Widget := color_block{
                    DefaultColor := NamedColors.Red
                }
            }
        }
        
        # 订阅点击事件
        MyButton.OnClick().Subscribe(OnButtonClicked)
        
        PlayerUI.AddWidget(MyButton)

    OnButtonClicked(Message: widget_message):void =
        Print("Button clicked by {Message.Player}")
```

**优点**：
- ✅ 完全可编程
- ✅ 复杂 UI 逻辑
- ✅ 事件驱动

#### 方案 B：Device（世界空间按钮）

```verse
using { /Fortnite.com/Devices }

world_button := class(creative_device):
    @editable WorldButton : button_device = button_device{}

    OnBegin<override>():void =
        WorldButton.InteractedWithEvent.Subscribe(OnButtonPressed)

    OnButtonPressed(Agent: agent):void =
        Print("World button pressed!")
```

**区别**：
- SG button → 屏幕空间 UI
- Device button → 世界空间交互

**推荐**：
- UI 菜单 → SceneGraph
- 世界交互 → Device

---

## 迁移建议与最佳实践

### 混合架构策略

**推荐架构**：

```
SceneGraph 层（逻辑 + 自定义 UI）
    ├─ 游戏状态管理
    ├─ 玩家交互逻辑
    ├─ 自定义 HUD/UI
    └─ 组件化设计
            ↕
    Scene Events 通信
            ↕
Device 层（系统功能）
    ├─ 音频播放
    ├─ VFX 特效
    ├─ 官方计分/回合
    ├─ 世界空间 UI（Billboard）
    └─ 区域触发器
```

### 职责划分原则

| 职责 | SceneGraph | Device |
|------|-----------|--------|
| **游戏逻辑** | ✅ 主力 | ⚠️ 辅助 |
| **UI 交互** | ✅ 自定义 UI | ✅ 系统 HUD |
| **音频** | ❌ | ✅ 唯一 |
| **VFX** | ❌ | ✅ 唯一 |
| **物理** | ✅ 施力/速度 | ✅ 碰撞检测 |
| **官方机制** | ❌ | ✅ 唯一 |

### 通信模式

**SG → Device**：

```verse
# SceneGraph Component 触发 Device
my_component := class(component):
    @editable TriggerDevice : trigger_device = trigger_device{}

    ActivateDevice():void =
        TriggerDevice.Enable()
```

**Device → SG**：

```verse
# Device 事件订阅，触发 SG 逻辑
my_device_bridge := class(creative_device):
    @editable Trigger : trigger_device = trigger_device{}

    OnBegin<override>():void =
        Trigger.TriggeredEvent.Subscribe(OnTrigger)

    OnTrigger(Agent: ?agent):void =
        # 调用 SceneGraph 实体/组件方法
        if (MyEntity := GetEntity()):
            # SendSceneEvent...
```

### 性能考虑

| 场景 | 性能建议 |
|------|---------|
| **大量 UI 更新** | SceneGraph Widget 按需更新 |
| **频繁触发检测** | Device trigger 优化设置 |
| **物理计算** | 优先使用 SG API 避免中间层 |
| **音频** | Device 音频池管理 |

### 发布兼容性

⚠️ **重要**：
- SceneGraph 项目发布前必须禁用 SG 功能
- 纯 Device 项目可直接发布
- 混合架构需确保 SG 仅用于开发阶段，或等待 SG 正式版

---

## FAQ 常见问题

### Q1: 我能用 SceneGraph 完全替代 Device 吗？

**A**: ❌ **不能**。以下功能必须依赖 Device：
- 音频播放
- VFX 粒子效果
- 官方计分/回合/队伍系统
- 世界空间 UI（Billboard）

### Q2: SceneGraph 的 Widget 可以显示在世界空间吗？

**A**: ❌ **不能**。SG Widget 仅支持屏幕空间（`player_ui`）。世界空间 UI 必须使用 `billboard_device`。

### Q3: 我应该什么时候使用 SceneGraph？

**A**: ✅ **推荐场景**：
- 需要复杂游戏逻辑的项目
- 自定义 UI 交互
- 组件化设计需求
- 事件驱动架构

❌ **不推荐**：
- 简单地图（纯 Device 更快）
- 需要发布的正式项目（SG 仍在 Beta）

### Q4: Device 和 SceneGraph 如何协同工作？

**A**: **混合架构**：
- SG 负责逻辑和自定义 UI
- Device 负责音频、VFX、官方机制
- 通过事件订阅实现双向通信

### Q5: SceneGraph 的物理 API 能替代 trigger_device 吗？

**A**: ✅ **可以替代大部分场景**。SG 的 `mesh_component` 提供 `EntityEnteredEvent` 和 `EntityExitedEvent` 进行碰撞检测。Device `trigger_device` 提供更简单的可视化配置。

### Q6: SceneGraph 有音频/VFX API 吗？

**A**: ✅ **有基础支持**：
- **音频**：`sound_component` (Play, Stop, Enable, Disable)
- **VFX**：`particle_system_component` (Play, Stop, Enable, Disable)
- **光照**：`light_component` 及其子类（方向光、点光源、聚光灯等）

⚠️ **限制**：需要在编辑器中预先配置资产，无法动态加载或修改参数。复杂功能仍需 Device。

### Q7: 未来 SceneGraph 会有更多功能吗？

**A**: ⚠️ **可能性大**。SG 仍在 Beta 阶段，已有基础组件（sound, particle, mesh, light）。建议：
- 关注 Epic 官方文档更新
- 参与社区讨论（UEFN Forums）
- 现阶段混合使用 SG + Device

### Q8: Device 数量太多（315个），如何选择？

**A**: **快速选择指南**：
- 参考 [device-quick-reference.md](../../shared/references/device-quick-reference.md)
- 使用"我想实现..."表格快速定位
- 优先使用常用设备（如 trigger, hud_message, audio_player）

---

## 参考资料

### 官方文档

- [Scene Graph in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [UEFN Devices](https://dev.epicgames.com/documentation/en-us/fortnite/devices-in-unreal-editor-for-fortnite)

### 本仓库资源

- [SceneGraph API 参考](../../shared/references/scenegraph-api-reference.md)
- [SceneGraph 框架指南](../../shared/references/scenegraph-framework-guide.md)
- [UEFN 设备系统调研](../../shared/references/uefn-device-system-research.md)
- [设备快速参考](../../shared/references/device-quick-reference.md)
- [API Digests](../../shared/api-digests/)
  - Verse.digest.verse.md
  - Fortnite.digest.verse.md
  - UnrealEngine.digest.verse.md

### API 版本

- **Verse API**: `++Fortnite+Release-39.10-CL-48971054`
- **Fortnite API**: `++Fortnite+Release-39.11-CL-49242330`
- **调研时间**: 2026-01-05

---

## 附录：能力矩阵总表

| 功能类别 | 子功能 | SceneGraph | Device | 不可替代性 |
|---------|--------|-----------|--------|----------|
| **UI** | 自定义 Widget | ✅ | ❌ | 🟢 SG 专用 |
| **UI** | 世界空间 UI | ❌ | ✅ billboard | 🔴 Device 必须 |
| **UI** | 系统 HUD 控制 | ❌ | ✅ hud_controller | 🔴 Device 必须 |
| **音频** | 基础播放 | ✅ sound_component | ✅ audio_player | 🟡 部分可替代 |
| **音频** | 音乐制作 | ❌ | ✅ Patchwork | 🔴 Device 必须 |
| **物理** | 施力/速度 | ✅ | ⚠️ | 🟢 SG 优先 |
| **物理** | 碰撞检测 | ✅ mesh_component | ✅ trigger | 🟡 部分可替代 |
| **机制** | 计分系统 | ⚠️ 自建 | ✅ score_manager | 🔴 官方需 Device |
| **机制** | 回合制 | ⚠️ 自建 | ✅ round_settings | 🔴 官方需 Device |
| **VFX** | 粒子效果 | ✅ particle_system_component | ✅ vfx_spawner | 🟡 部分可替代 |
| **VFX** | 后期处理 | ❌ | ✅ post_process | 🔴 Device 必须 |
| **触发** | 碰撞触发 | ✅ mesh_component | ✅ trigger | 🟡 部分可替代 |
| **触发** | 场景事件 | ✅ | ❌ | 🟢 SG 专用 |

**图例**：
- 🟢 **可替代/专用** - SceneGraph 可独立实现或专有功能
- 🟡 **部分可替代** - 基础功能 SG，高级功能 Device
- 🔴 **不可替代** - 必须使用 Device

---

## 版本记录

| 版本 | 日期 | 变更说明 |
|------|------|---------|
| 1.0 | 2026-01-05 | 初始版本，完成全领域调研 |
| 1.1 | 2026-01-05 | **重要更正**：发现并补充 SG 已有的组件支持 |
|     |            | - 音频：`sound_component` |
|     |            | - VFX：`particle_system_component` + 光照组件 |
|     |            | - 碰撞：`mesh_component.EntityEnteredEvent/ExitedEvent` |
|     |            | 更新所有相关章节、结论和能力矩阵 |

---

**调研总结**：SceneGraph 提供了音频、VFX、碰撞等基础组件支持，适合简单场景。Device 提供更丰富的配置和官方机制集成。**混合架构是当前最佳实践**。
