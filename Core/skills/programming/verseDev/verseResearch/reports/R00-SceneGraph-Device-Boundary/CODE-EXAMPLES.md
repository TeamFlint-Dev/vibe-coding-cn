# SceneGraph vs Device 实战代码示例集

> **文档类型**: 代码参考  
> **更新日期**: 2026-01-05

---

## 目录

1. [UI 系统示例](#ui-系统示例)
2. [音频系统示例](#音频系统示例)
3. [物理系统示例](#物理系统示例)
4. [游戏机制示例](#游戏机制示例)
5. [混合架构模板](#混合架构模板)

---

## UI 系统示例

### 示例 1: SceneGraph - 自定义血条 UI

```verse
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/SpatialMath }

# 血条组件
health_bar_component := class(component):
    var MaxHealth : float = 100.0
    var CurrentHealth : float = 100.0
    var HealthBarCanvas : ?canvas = false
    var HealthBarFill : ?color_block = false
    var HealthText : ?text_base = false # 实际需要 text_base 的具体子类
    
    OnAddedToScene()<override>:void =
        CreateHealthBar()
    
    CreateHealthBar():void =
        if (Player := GetPlayer[], PlayerUI := GetPlayerUI(Player)):
            # 创建血条容器
            BarCanvas := canvas{
                Slots := array{}
            }
            
            # 创建血条背景（黑色）
            Background := color_block{
                DefaultColor := NamedColors.Black,
                DefaultDesiredSize := vector2{X := 200.0, Y := 20.0},
                DefaultOpacity := 0.8
            }
            
            # 创建血条填充（红色）
            Fill := color_block{
                DefaultColor := NamedColors.Red,
                DefaultDesiredSize := vector2{X := 200.0, Y := 20.0},
                DefaultOpacity := 1.0
            }
            set HealthBarFill = option{Fill}
            
            # 添加到 Canvas
            BgSlot := MakeCanvasSlot(
                Background,
                vector2{X := 10.0, Y := 10.0},
                option{vector2{X := 200.0, Y := 20.0}}
            )
            FillSlot := MakeCanvasSlot(
                Fill,
                vector2{X := 10.0, Y := 10.0},
                option{vector2{X := 200.0, Y := 20.0}}
            )
            
            BarCanvas.AddWidget(BgSlot)
            BarCanvas.AddWidget(FillSlot)
            
            # 添加到 PlayerUI
            PlayerUI.AddWidget(BarCanvas)
            set HealthBarCanvas = option{BarCanvas}
    
    TakeDamage(Damage: float):void =
        set CurrentHealth = Max(0.0, CurrentHealth - Damage)
        UpdateHealthBar()
    
    UpdateHealthBar():void =
        if (Fill := HealthBarFill?):
            HealthPercent := CurrentHealth / MaxHealth
            NewWidth := 200.0 * HealthPercent
            Fill.SetDesiredSize(vector2{X := NewWidth, Y := 20.0})
            
            # 根据血量改变颜色
            if (HealthPercent < 0.3):
                Fill.SetColor(NamedColors.DarkRed)
            else if (HealthPercent < 0.6):
                Fill.SetColor(NamedColors.Orange)
            else:
                Fill.SetColor(NamedColors.Red)
    
    GetPlayer()<decides>:player =
        if (Owner := GetOwner[]):
            if (SimEntity := simulation_entity[Owner]):
                if (Players := SimEntity.GetPlayers()):
                    if (Players[0]):
                        return Players[0]
        false
    
    Max(A: float, B: float):float =
        if (A > B) then A else B
```

**使用场景**：
- ✅ 自定义 HUD 样式
- ✅ 动态更新（实时血量变化）
- ✅ 灵活布局（可添加其他 UI 元素）

---

### 示例 2: Device - 世界空间 Billboard

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/SpatialMath }

# Billboard 管理器
billboard_manager := class(creative_device):
    @editable PlayerNameBillboard : billboard_device = billboard_device{}
    @editable QuestMarkerBillboard : billboard_device = billboard_device{}
    
    OnBegin<override>():void =
        # 设置玩家名称 Billboard
        # 注: 具体 API 可能不同，需查阅文档
        # PlayerNameBillboard 的文本在编辑器中配置
        ShowPlayerName()
    
    ShowPlayerName():void =
        # 显示 Billboard（在编辑器中配置位置和文本）
        # Device 在场景中预先放置
        # Verse 仅控制显示/隐藏
    
    ShowQuestMarker():void =
        # 显示任务标记
        # QuestMarkerBillboard 在编辑器中配置
    
    HideQuestMarker():void =
        # 隐藏任务标记
```

**使用场景**：
- ✅ NPC 名称标签
- ✅ 任务标记
- ✅ 区域标签
- ❌ SceneGraph Widget 无法实现（仅屏幕空间）

**对比**：

| 特性 | SceneGraph Widget | billboard_device |
|------|------------------|------------------|
| 空间类型 | 屏幕空间 | 世界空间 |
| 动态创建 | ✅ | ❌ (需预先放置) |
| 自定义样式 | ✅ | ⚠️ (编辑器限制) |
| 代码控制 | ✅ 完全 | ⚠️ 部分 |

---

## 音频系统示例

### 示例 3: Device - 背景音乐和音效系统

```verse
using { /Fortnite.com/Devices }

# 音频管理器
audio_manager := class(creative_device):
    @editable BackgroundMusic : audio_player_device = audio_player_device{}
    @editable CoinSFX : audio_player_device = audio_player_device{}
    @editable ExplosionSFX : audio_player_device = audio_player_device{}
    @editable VictorySFX : audio_player_device = audio_player_device{}
    
    var IsMusicPlaying : logic = false
    
    OnBegin<override>():void =
        StartBackgroundMusic()
    
    StartBackgroundMusic():void =
        if (not IsMusicPlaying):
            BackgroundMusic.Enable()
            set IsMusicPlaying = true
    
    StopBackgroundMusic():void =
        if (IsMusicPlaying):
            BackgroundMusic.Disable()
            set IsMusicPlaying = false
    
    PlayCoinSound():void =
        # 播放硬币音效（在编辑器中配置音频文件）
        CoinSFX.Enable()
    
    PlayExplosionSound():void =
        ExplosionSFX.Enable()
    
    PlayVictorySound():void =
        # 先停止背景音乐
        StopBackgroundMusic()
        # 播放胜利音效
        VictorySFX.Enable()
```

**编辑器配置**（伪配置示例）：
```
audio_player_device 属性:
- Audio File: [选择音频资产]
- Volume: 0.8
- Loop: true/false
- 3D Sound: true (空间化音频)
- Attenuation Distance: 1000.0
```

**SceneGraph 对比**：
❌ **无法实现** - SG 无音频 API

---

### 示例 4: Device - Patchwork 音乐系统

```verse
using { /Fortnite.com/Devices }

# 动态音乐控制器
dynamic_music_controller := class(creative_device):
    @editable MusicManager : patchwork_music_manager_device = patchwork_music_manager_device{}
    @editable DrumSequencer : patchwork_drum_sequencer_device = patchwork_drum_sequencer_device{}
    @editable InstrumentPlayer : patchwork_instrument_player_device = patchwork_instrument_player_device{}
    @editable Speaker : patchwork_speaker_device = patchwork_speaker_device{}
    
    OnBegin<override>():void =
        # Patchwork 设备通过编辑器连接形成音乐网络
        # Verse 控制启动/停止
        StartMusic()
    
    StartMusic():void =
        MusicManager.Enable()
    
    StopMusic():void =
        MusicManager.Disable()
    
    # 根据游戏状态调整音乐
    OnCombatStart():void =
        # 增加鼓点强度（通过设备参数调整）
        DrumSequencer.Enable()
    
    OnCombatEnd():void =
        # 减弱鼓点
        DrumSequencer.Disable()
```

**适用场景**：
- 游戏音乐制作
- 动态音乐（根据游戏状态变化）
- 多层次音轨控制

---

## 物理系统示例

### 示例 5: SceneGraph - 施力和速度控制

```verse
using { /Fortnite.com/Game }
using { /Verse.org/SpatialMath }

# 物理控制组件
physics_controller := class(component):
    
    # 发射道具
    LaunchProp(Prop: creative_prop, Direction: vector3, Force: float):void =
        # 检查是否启用物理
        if (Prop.GetDynamic[]):
            # 施加冲量
            LaunchImpulse := Direction * Force
            Prop.ApplyLinearImpulse(LaunchImpulse)
    
    # 使道具悬浮
    LevitateObject(Prop: creative_prop, Height: float):void =
        if (Prop.GetDynamic[]):
            # 获取当前速度
            CurrentVelocity := Prop.GetLinearVelocity()
            
            # 抵消重力 + 向上速度
            UpwardForce := vector3{X := 0.0, Y := 0.0, Z := Height * 100.0}
            Prop.ApplyForce(UpwardForce)
    
    # 停止所有运动
    StopMovement(Prop: creative_prop):void =
        ZeroVector := vector3{X := 0.0, Y := 0.0, Z := 0.0}
        Prop.SetLinearVelocity(ZeroVector)
        Prop.SetAngularVelocity(ZeroVector)
    
    # 旋转道具
    SpinProp(Prop: creative_prop, AngularVelocity: vector3):void =
        Prop.SetAngularVelocity(AngularVelocity)
    
    # 启用/禁用物理
    EnablePhysics(Prop: creative_prop):void =
        Prop.SetDynamic(true)
    
    DisablePhysics(Prop: creative_prop):void =
        Prop.SetDynamic(false)
```

**使用示例**：

```verse
# 投掷物品
ThrowItem(Item: creative_prop):void =
    ForwardDirection := vector3{X := 1.0, Y := 0.0, Z := 0.3}
    ThrowForce := 1000.0
    PhysicsController.LaunchProp(Item, ForwardDirection, ThrowForce)

# 创建悬浮平台
CreateFloatingPlatform(Platform: creative_prop):void =
    PhysicsController.EnablePhysics(Platform)
    PhysicsController.LevitateObject(Platform, 5.0) # 悬浮在 5 米高
```

---

### 示例 6: Device - 碰撞检测和触发

```verse
using { /Fortnite.com/Devices }

# 碰撞检测系统
collision_detector := class(creative_device):
    @editable AreaTrigger : trigger_device = trigger_device{}
    @editable DoorMover : prop_mover_device = prop_mover_device{}
    @editable OpenSound : audio_player_device = audio_player_device{}
    
    OnBegin<override>():void =
        # 订阅触发事件
        AreaTrigger.TriggeredEvent.Subscribe(OnPlayerEnter)
    
    OnPlayerEnter(Agent: ?agent):void =
        if (Player := Agent?):
            OpenDoor()
            PlaySound()
    
    OpenDoor():void =
        # 移动门（在编辑器中配置移动路径）
        DoorMover.Enable()
    
    PlaySound():void =
        OpenSound.Enable()
```

**对比 SceneGraph**：
- ✅ Device: 区域检测简单高效
- ❌ SG: 无原生碰撞检测 API，需要自己实现位置检查（性能差）

---

## 游戏机制示例

### 示例 7: Device - 官方计分系统

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }

# 计分系统
scoring_system := class(creative_device):
    @editable ScoreManager : score_manager_device = score_manager_device{}
    @editable CoinTrigger : trigger_device = trigger_device{}
    @editable EnemyElimination : elimination_manager_device = elimination_manager_device{}
    
    OnBegin<override>():void =
        # 订阅硬币收集事件
        CoinTrigger.TriggeredEvent.Subscribe(OnCoinCollected)
        
        # 订阅淘汰事件
        # EnemyElimination.EliminationEvent.Subscribe(OnEnemyEliminated)
    
    OnCoinCollected(Agent: ?agent):void =
        if (Player := Agent?):
            AddScore(Player, 10)
    
    OnEnemyEliminated(Result: elimination_result):void =
        # 淘汰敌人加 50 分
        # if (Eliminator := Result.EliminatingAgent):
        #     AddScore(Eliminator, 50)
    
    AddScore(Player: agent, Points: int):void =
        # 调用 ScoreManager API（伪代码，实际 API 需查阅文档）
        # ScoreManager.AddScore(Player, Points)
        Print("Added {Points} points to player")
```

**优势**：
- ✅ 自动显示官方排行榜
- ✅ 与 Fortnite 统计系统集成
- ✅ 支持队伍计分

**SceneGraph 自建计分对比**：

```verse
# SG 自建计分（不与官方集成）
custom_score_component := class(component):
    var PlayerScores : [agent]int = map{}
    
    AddScore(Player: agent, Points: int):void =
        if (CurrentScore := PlayerScores[Player]):
            set PlayerScores[Player] = CurrentScore + Points
        else:
            set PlayerScores[Player] = Points
        
        UpdateScoreUI(Player)
    
    UpdateScoreUI(Player: agent):void =
        # 通过 SG Widget 显示（不在官方排行榜）
        # 需要自己实现所有 UI
```

**结论**：
- 官方排行榜 → 必须用 Device
- 自定义计分逻辑 → 可用 SG

---

### 示例 8: Device - 回合制系统

```verse
using { /Fortnite.com/Devices }

# 回合管理器
round_manager := class(creative_device):
    @editable RoundSettings : round_settings_device = round_settings_device{}
    @editable RoundTimer : timer_device = timer_device{}
    @editable AudioManager : audio_player_device = audio_player_device{}
    
    var CurrentRound : int = 0
    
    OnBegin<override>():void =
        # 订阅回合事件（伪代码，实际 API 可能不同）
        # RoundSettings.RoundStartEvent.Subscribe(OnRoundStart)
        # RoundSettings.RoundEndEvent.Subscribe(OnRoundEnd)
        StartRound()
    
    StartRound():void =
        set CurrentRound = CurrentRound + 1
        Print("Round {CurrentRound} started!")
        
        # 启动回合计时器
        RoundTimer.Enable()
        
        # 播放回合开始音效
        AudioManager.Enable()
    
    OnRoundStart():void =
        # 回合开始逻辑
        ResetPlayerPositions()
        SpawnEnemies()
    
    OnRoundEnd():void =
        # 回合结束逻辑
        CalculateScores()
        ShowResults()
    
    ResetPlayerPositions():void =
        # 重置玩家位置
    
    SpawnEnemies():void =
        # 生成敌人
    
    CalculateScores():void =
        # 计算分数
    
    ShowResults():void =
        # 显示回合结果
```

---

## 混合架构模板

### 模板 1: 完整游戏架构

```verse
using { /Verse.org/SceneGraph }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/UI }

# ============================================
# SceneGraph 层：游戏逻辑
# ============================================

# 游戏管理器实体
game_manager_entity := class(entity):
    OnInit():void =
        # 添加管理组件
        GameState := game_state_component{}
        DeviceBridge := device_bridge_component{}
        UIController := ui_controller_component{}
        
        AddComponents(array{GameState, DeviceBridge, UIController})

# 游戏状态组件
game_state_component := class(component):
    var CurrentRound : int = 1
    var GamePhase : string = "Waiting"
    var PlayersAlive : int = 0
    
    OnAddedToScene()<override>:void =
        StartGame()
    
    StartGame():void =
        set GamePhase = "Playing"
        BroadcastGameStart()
    
    BroadcastGameStart():void =
        if (Owner := GetOwner[]):
            Owner.SendDown(game_started_event{Round := CurrentRound})
    
    NextRound():void =
        set CurrentRound = CurrentRound + 1
        BroadcastRoundStart()
    
    BroadcastRoundStart():void =
        if (Owner := GetOwner[]):
            Owner.SendDown(round_started_event{Round := CurrentRound})

# 游戏事件定义
game_started_event := class(scene_event):
    Round : int

round_started_event := class(scene_event):
    Round : int

player_scored_event := class(scene_event):
    Player : agent
    Points : int

# ============================================
# Device Bridge 层：SG-Device 通信
# ============================================

device_bridge_component := class(component):
    @editable AudioManager : audio_manager_device = audio_manager_device{}
    @editable VFXManager : vfx_manager_device = vfx_manager_device{}
    @editable ScoreManager : score_manager_device = score_manager_device{}
    
    OnAddedToScene()<override>:void =
        SubscribeToEvents()
    
    SubscribeToEvents():void =
        # 监听场景事件，触发 Device
        # 实际实现需要事件订阅机制
    
    OnGameStarted(Event: game_started_event):void =
        # 播放游戏开始音乐
        AudioManager.PlayBGM()
    
    OnRoundStarted(Event: round_started_event):void =
        # 播放回合开始音效
        AudioManager.PlayRoundStart()
        
        # 显示回合特效
        VFXManager.SpawnRoundVFX()
    
    OnPlayerScored(Event: player_scored_event):void =
        # 更新官方计分
        # ScoreManager.AddScore(Event.Player, Event.Points)
        
        # 播放得分音效
        AudioManager.PlayScoreSound()

# ============================================
# UI 控制层：SceneGraph Widget
# ============================================

ui_controller_component := class(component):
    var CurrentRoundText : ?text_base = false
    var ScoreText : ?text_base = false
    
    OnAddedToScene()<override>:void =
        CreateUI()
        SubscribeToEvents()
    
    CreateUI():void =
        if (Player := GetPlayer[], PlayerUI := GetPlayerUI(Player)):
            # 创建 UI Canvas
            UICanvas := canvas{Slots := array{}}
            
            # 添加回合显示
            # 添加得分显示
            # ...
            
            PlayerUI.AddWidget(UICanvas)
    
    SubscribeToEvents():void =
        # 订阅游戏事件，更新 UI
    
    OnRoundChanged(NewRound: int):void =
        # 更新回合显示文本
        # if (RoundText := CurrentRoundText?):
        #     RoundText.SetText("Round {NewRound}")
    
    GetPlayer()<decides>:player =
        # 获取玩家逻辑
        false

# ============================================
# Device 层定义（在编辑器中配置）
# ============================================

# 音频管理 Device
audio_manager_device := class(creative_device):
    @editable BGMusic : audio_player_device = audio_player_device{}
    @editable RoundStartSFX : audio_player_device = audio_player_device{}
    @editable ScoreSFX : audio_player_device = audio_player_device{}
    
    PlayBGM():void = BGMusic.Enable()
    PlayRoundStart():void = RoundStartSFX.Enable()
    PlayScoreSound():void = ScoreSFX.Enable()

# VFX 管理 Device
vfx_manager_device := class(creative_device):
    @editable RoundVFX : vfx_spawner_device = vfx_spawner_device{}
    @editable ScoreVFX : vfx_spawner_device = vfx_spawner_device{}
    
    SpawnRoundVFX():void = RoundVFX.Enable()
    SpawnScoreVFX():void = ScoreVFX.Enable()

# 计分管理 Device
score_manager_device := class(creative_device):
    @editable OfficialScoreManager : score_manager_device = score_manager_device{}
    
    AddScore(Player: agent, Points: int):void =
        # OfficialScoreManager.AddScore(Player, Points)
```

**架构说明**：

```
┌───────────────────────────────────────────┐
│  game_manager_entity (SG)                 │
│    ├─ game_state_component (逻辑)         │
│    ├─ device_bridge_component (桥接)      │
│    └─ ui_controller_component (UI)        │
└────────────┬──────────────────────────────┘
             │ Scene Events
             ↓
┌───────────────────────────────────────────┐
│  Device Layer                             │
│    ├─ audio_manager_device (音频)         │
│    ├─ vfx_manager_device (特效)           │
│    └─ score_manager_device (计分)         │
└───────────────────────────────────────────┘
```

---

## 总结

### SceneGraph 擅长领域

- ✅ 复杂游戏逻辑
- ✅ 自定义 UI（屏幕空间）
- ✅ 组件化设计
- ✅ 事件驱动架构
- ✅ 基础物理控制（施力/速度）

### Device 必须领域

- ✅ 音频播放
- ✅ VFX 粒子效果
- ✅ 官方游戏机制（计分/回合）
- ✅ 世界空间 UI
- ✅ 区域触发检测

### 最佳实践

1. **职责分离**：逻辑用 SG，系统功能用 Device
2. **事件驱动**：通过场景事件解耦
3. **单向依赖**：SG → Device，避免反向
4. **集中管理**：Device 集中在 Bridge 层
5. **文档先行**：架构设计文档化

---

**相关文档**：
- [主报告 README.md](./README.md)
- [迁移指南 MIGRATION-GUIDE.md](./MIGRATION-GUIDE.md)
- [SceneGraph API 参考](../../shared/references/scenegraph-api-reference.md)
