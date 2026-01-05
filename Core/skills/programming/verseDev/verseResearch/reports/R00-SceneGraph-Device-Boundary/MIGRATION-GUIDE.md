# SceneGraph 与 Device 混合架构迁移指南

> **文档类型**: 实践指南  
> **目标读者**: UEFN 开发者  
> **更新日期**: 2026-01-05

---

## 目录

1. [迁移场景](#迁移场景)
2. [从纯 Device 到混合架构](#从纯-device-到混合架构)
3. [从纯 SceneGraph 到混合架构](#从纯-scenegraph-到混合架构)
4. [混合架构设计模式](#混合架构设计模式)
5. [常见迁移陷阱](#常见迁移陷阱)

---

## 迁移场景

### 场景 1: 纯 Device 项目希望引入可编程逻辑

**现状**：
- 大量设备配置
- 通过 Device 事件链实现逻辑
- 缺乏代码级控制

**迁移目标**：
- 保留 Device 系统功能（音频/VFX/官方机制）
- 用 SceneGraph 重构游戏逻辑
- 提高代码可维护性

**迁移步骤**：

1. **识别可迁移部分**
   ```
   可迁移到 SG:
   - ✅ 游戏状态管理
   - ✅ 玩家数据跟踪
   - ✅ 自定义 UI
   - ✅ 复杂交互逻辑
   
   必须保留 Device:
   - ❌ 音频播放
   - ❌ VFX 特效
   - ❌ 官方计分系统
   - ❌ 世界空间 UI
   ```

2. **创建 Device Bridge**
   ```verse
   # 在 SceneGraph 中引用 Device
   device_bridge := class(creative_device):
       @editable ScoreDevice : score_manager_device = score_manager_device{}
       @editable AudioDevice : audio_player_device = audio_player_device{}
       
       # 提供给 SG Component 调用的接口
       PlaySound():void = AudioDevice.Enable()
       AddScore(Player: agent, Points: int):void = 
           # ScoreDevice.AddScore(Player, Points)
   ```

3. **逐步迁移逻辑层**
   ```verse
   # 阶段 1: 创建 SG 游戏状态管理
   game_state_entity := class(entity):
       var CurrentRound : int = 1
       var PlayersAlive : int = 0
   
   game_state_component := class(component):
       NextRound():void =
           # 逻辑在 SG 中
           if (Owner := GetOwner[]):
               if (GameEntity := Owner):
                   # 更新状态
       
       OnRoundEnd():void =
           # 触发 Device
           DeviceBridge.PlaySound()
   ```

4. **建立通信机制**
   ```verse
   # Device 事件 → SG 事件
   OnDeviceTriggered(Agent: ?agent):void =
       if (MyEntity := GetGameEntity()):
           MyEntity.SendDown(player_entered_event{Player := Agent})
   ```

---

### 场景 2: SceneGraph 项目需要补充系统功能

**现状**：
- 完整的 SG 架构
- 缺少音频/VFX/官方机制

**迁移目标**：
- 保留 SG 逻辑架构
- 补充 Device 系统功能

**迁移步骤**：

1. **分析功能缺口**
   ```
   需要添加的 Device:
   - audio_player_device (背景音乐、音效)
   - vfx_spawner_device (特效)
   - score_manager_device (官方排行榜)
   - billboard_device (世界空间提示)
   ```

2. **设计 Device 接入点**
   ```verse
   # 创建 Device 管理组件
   audio_manager_component := class(component):
       @editable BGMDevice : audio_player_device = audio_player_device{}
       @editable SFXDevice : audio_player_device = audio_player_device{}
       
       OnAddedToScene()<override>:void =
           # 订阅场景事件
           SubscribeToEvent()
       
       SubscribeToEvent():void =
           # 监听 SG 事件，触发 Device
   
   # 场景事件定义
   play_sound_event := class(scene_event):
       SoundType : string
   ```

3. **事件驱动集成**
   ```verse
   # SG 逻辑层发送事件
   OnPlayerVictory():void =
       if (Owner := GetOwner[]):
           Owner.SendDown(play_sound_event{SoundType := "Victory"})
   
   # Device 管理组件接收事件
   OnSceneEvent(Event: scene_event):void =
       if (SoundEvent := Event as play_sound_event):
           if (SoundEvent.SoundType = "Victory"):
               VictorySFX.Enable()
   ```

---

## 从纯 Device 到混合架构

### 步骤 1: 审计现有 Device

**清单模板**：

```markdown
## Device 清单

### 可迁移到 SG 的 Device
- [ ] trigger_device → SG 场景事件（如果仅用于逻辑触发）
- [ ] 自定义计分逻辑 → SG 组件

### 必须保留的 Device
- [x] audio_player_device
- [x] vfx_spawner_device
- [x] score_manager_device (官方排行榜)
- [x] billboard_device

### 混合使用的 Device
- [~] trigger_device (物理触发保留，逻辑触发迁移)
```

### 步骤 2: 创建 SG 架构蓝图

```verse
# Entity 层级规划
Simulation Entity
    ├─ GameManager Entity
    │   ├─ GameStateComponent
    │   ├─ RoundTimerComponent
    │   └─ DeviceBridgeComponent (连接 Device)
    │
    ├─ Player Entity (per player)
    │   ├─ PlayerDataComponent
    │   └─ UIControllerComponent
    │
    └─ Environment Entity
        └─ InteractionComponent
```

### 步骤 3: 分阶段迁移

**阶段 1: 建立基础**
```verse
# 创建根实体和基础组件
root_game_entity := class(entity):
    OnInit():void =
        # 初始化游戏管理器
```

**阶段 2: 迁移逻辑**
```verse
# 逐个迁移 Device 事件链到 SG 场景事件
```

**阶段 3: Device 集成**
```verse
# 为保留的 Device 创建管理组件
```

---

## 从纯 SceneGraph 到混合架构

### 步骤 1: 识别 SG 无法实现的功能

**检查清单**：
```markdown
- [ ] 是否需要播放音频？ → 添加 audio_player_device
- [ ] 是否需要粒子特效？ → 添加 vfx_spawner_device
- [ ] 是否需要官方排行榜？ → 添加 score_manager_device
- [ ] 是否需要世界空间 UI？ → 添加 billboard_device
- [ ] 是否需要区域触发？ → 添加 trigger_device
```

### 步骤 2: 设计 Device 层

**最小化 Device 使用原则**：
- 仅添加 SG 无法实现的功能
- 通过 SG 组件统一管理 Device
- 避免 Device 直接相互连接

```verse
# 集中式 Device 管理
system_device_manager := class(component):
    @editable Audio : audio_player_device = audio_player_device{}
    @editable VFX : vfx_spawner_device = vfx_spawner_device{}
    @editable Score : score_manager_device = score_manager_device{}
    
    # 统一接口
    PlayAudio():void = Audio.Enable()
    SpawnVFX():void = VFX.Enable()
    UpdateScore(Player: agent, Points: int):void = 
        # Score.AddScore(Player, Points)
```

### 步骤 3: 建立通信桥梁

```verse
# 场景事件 → Device 动作
OnSceneEvent(Event: scene_event):void =
    if (AudioEvent := Event as audio_request_event):
        HandleAudioRequest(AudioEvent)
    else if (VFXEvent := Event as vfx_request_event):
        HandleVFXRequest(VFXEvent)

# 反向：Device 事件 → 场景事件
OnDeviceTrigger(Agent: ?agent):void =
    if (Owner := GetOwner[]):
        Owner.SendDown(device_triggered_event{Agent := Agent})
```

---

## 混合架构设计模式

### 模式 1: 分层通信

```
┌─────────────────────────────────────┐
│   SceneGraph Logic Layer            │
│   (游戏逻辑、状态管理)               │
└──────────────┬──────────────────────┘
               │ Scene Events
               ↓
┌─────────────────────────────────────┐
│   Device Bridge Component           │
│   (事件转换、Device 管理)           │
└──────────────┬──────────────────────┘
               │ Device API Calls
               ↓
┌─────────────────────────────────────┐
│   Device Layer                      │
│   (音频、VFX、官方机制)             │
└─────────────────────────────────────┘
```

**实现示例**：

```verse
# Logic Layer
game_logic_component := class(component):
    OnPlayerCollectItem():void =
        if (Owner := GetOwner[]):
            Owner.SendDown(item_collected_event{ItemType := "Coin"})

# Bridge Layer
device_bridge_component := class(component):
    @editable CoinSFX : audio_player_device = audio_player_device{}
    
    OnAddedToScene()<override>:void =
        # 订阅场景事件
    
    OnItemCollected(Event: item_collected_event):void =
        if (Event.ItemType = "Coin"):
            CoinSFX.Enable()
```

---

### 模式 2: 功能域隔离

```
Game Manager (SG)
    ├─ Audio Manager Component (Device)
    ├─ VFX Manager Component (Device)
    ├─ Score Manager Component (Device)
    └─ UI Manager Component (SG)
```

**优点**：
- 清晰的职责划分
- 易于维护和扩展
- 模块化替换

**实现**：

```verse
# 每个功能域一个管理组件
audio_manager := class(component):
    @editable BGM : audio_player_device = audio_player_device{}
    @editable SFX : []audio_player_device = array{}
    
    PlayBGM():void = BGM.Enable()
    PlaySFX(Index: int):void =
        if (SFX[Index]):
            SFX[Index].Enable()

vfx_manager := class(component):
    @editable Explosions : []vfx_spawner_device = array{}
    
    SpawnExplosion(Index: int):void =
        if (Explosions[Index]):
            Explosions[Index].Enable()
```

---

### 模式 3: 事件总线

```verse
# 全局事件总线
event_bus := class(component):
    var EventQueue : []scene_event = array{}
    
    Publish(Event: scene_event):void =
        # 广播到所有订阅者
        if (Owner := GetOwner[]):
            Owner.SendDown(Event)
    
    Subscribe<T>(Handler: T->void)<computes>:void where T:subtype(scene_event) =
        # 订阅特定事件类型

# 使用示例
OnGameStart():void =
    EventBus.Publish(game_started_event{})

# 订阅者
OnSceneEvent(Event: scene_event):void =
    if (StartEvent := Event as game_started_event):
        StartBGM()
```

---

## 常见迁移陷阱

### 陷阱 1: 过度依赖 Device 事件链

**问题**：
```verse
# ❌ 不推荐：复杂的 Device 事件链
trigger_device → conditional_button → score_manager → hud_message
```

**解决方案**：
```verse
# ✅ 推荐：SG 逻辑 + Device 执行
OnTrigger(Agent: ?agent):void =
    # SG 逻辑判断
    if (ShouldAddScore()):
        AddScore(Agent)
        ShowMessage(Agent)

AddScore(Agent: agent):void =
    # 调用 Device
    ScoreDevice.Enable()

ShowMessage(Agent: agent):void =
    # 调用 Device
    HUDDevice.Enable()
```

---

### 陷阱 2: SG 和 Device 状态不同步

**问题**：
```verse
# SG 记录的分数与 Device 不一致
var SGScore : int = 100
# ScoreDevice 显示 80
```

**解决方案**：
```verse
# 单一数据源原则
# 方案 A: Device 为数据源（官方排行榜）
UpdateScore(NewScore: int):void =
    ScoreDevice.SetScore(NewScore)
    # 不在 SG 中存储分数

# 方案 B: SG 为数据源（自定义逻辑）
UpdateScore(NewScore: int):void =
    set SGScore = NewScore
    UpdateUI(NewScore) # 通过 SG Widget 显示
```

---

### 陷阱 3: Device 过度配置导致维护困难

**问题**：
- 315 个 Device 类型，过度使用导致编辑器混乱
- Device 参数配置分散，难以追踪

**解决方案**：
```verse
# 集中管理 Device
device_registry := class(component):
    @editable AllAudioDevices : []audio_player_device = array{}
    @editable AllVFXDevices : []vfx_spawner_device = array{}
    
    GetAudioDevice(Name: string)<decides>:audio_player_device =
        # 根据名称查找
        # 返回对应 Device

    GetVFXDevice(Name: string)<decides>:vfx_spawner_device =
        # 查找逻辑
```

---

### 陷阱 4: 忽略 SceneGraph Beta 限制

**问题**：
- 使用 SG 的项目无法发布

**解决方案**：
- **开发阶段**：充分利用 SG 进行逻辑开发
- **发布阶段**：
  - 方案 A: 禁用 SG，迁回纯 Device（不推荐）
  - 方案 B: 等待 SG 正式发布
  - 方案 C: 保留 SG 用于测试，发布版本用 Device 重构（工作量大）

**当前建议**：
- 仅在实验性项目使用 SG
- 生产项目使用纯 Device 或等待 SG 正式版

---

## 迁移检查清单

### 开始迁移前

```markdown
- [ ] 明确迁移目标（性能/可维护性/功能扩展）
- [ ] 评估 SG Beta 风险（发布计划）
- [ ] 识别不可替代的 Device 功能
- [ ] 设计 SG-Device 通信机制
- [ ] 准备回退方案
```

### 迁移过程中

```markdown
- [ ] 分阶段迁移（避免大爆炸式重构）
- [ ] 每阶段测试（确保功能一致）
- [ ] 记录迁移日志（便于回滚）
- [ ] 代码审查（确保架构清晰）
```

### 迁移完成后

```markdown
- [ ] 性能测试（对比迁移前后）
- [ ] 功能验证（无遗漏/无破坏）
- [ ] 文档更新（架构文档、开发指南）
- [ ] 团队培训（新架构使用方法）
```

---

## 总结

**核心原则**：
1. **职责分离**：SG 负责逻辑，Device 负责系统功能
2. **最小化 Device**：仅在 SG 无法实现时使用
3. **单向依赖**：SG → Device，避免反向耦合
4. **事件驱动**：通过场景事件解耦
5. **渐进迁移**：分阶段，可回滚

**成功标准**：
- ✅ 代码可维护性提高
- ✅ 功能保持一致
- ✅ 性能无明显下降
- ✅ 团队理解新架构

---

**相关文档**：
- [主报告 README.md](./README.md)
- [SceneGraph 框架指南](../../shared/references/scenegraph-framework-guide.md)
- [Device 快速参考](../../shared/references/device-quick-reference.md)
