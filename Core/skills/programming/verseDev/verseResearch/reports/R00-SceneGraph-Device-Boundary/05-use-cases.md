# 典型 UseCase 场景

> **调研日期**: 2026-01-05
>
> **调研目标**: 梳理无需 Device 时，SceneGraph 可原生实现的 UseCase 清单及代码示例

---

## 一、完全独立实现的场景

### UseCase 1: 对象生成系统（Spawner System）

**描述**: 定时生成敌人、道具或其他游戏对象。

**无需 Device**: ✅ 完全可独立实现

**核心机制**:

- spawn + Sleep 实现定时器
- entity 创建和 AddEntities
- array 管理对象池

**完整示例**:

```verse
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 生成器配置
spawner_config := struct:
    SpawnInterval:float = 2.0
    MaxActiveEntities:int = 10
    EntityPrefab:?entity = false  # 预制件引用

# 生成器组件
spawner_component := class(component):
    var Config<private>:spawner_config = spawner_config{}
    var ActiveEntities<private>:[]entity = array{}
    var IsRunning<private>:logic = false

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        StartSpawning()

    # 启动生成循环
    StartSpawning():void =
        set IsRunning = true
        spawn:
            SpawnLoop()

    SpawnLoop()<suspends>:void =
        loop:
            if not IsRunning:
                break

            Sleep(Config.SpawnInterval)

            # 检查是否达到上限
            if ActiveEntities.Length < Config.MaxActiveEntities:
                SpawnEntity()

    # 生成实体
    SpawnEntity():void =
        # 创建新实体
        NewEntity := entity{}

        # 添加组件
        NewEntity.AddComponents(array{
            enemy_component{},
            health_component{MaxHealth := 50},
            movement_component{}
        })

        # 添加到场景
        if (Owner := GetOwner()):
            Owner.AddEntities(array{NewEntity})

        # 记录
        set ActiveEntities += NewEntity

    # 移除实体（被销毁时调用）
    OnEntityDestroyed(DestroyedEntity:entity):void =
        set ActiveEntities = ActiveEntities.RemoveElement(DestroyedEntity)

    # 停止生成
    StopSpawning():void =
        set IsRunning = false

    OnDestroy<override>():void =
        StopSpawning()
```text

**使用场景**:

- 敌人生成系统
- 道具刷新系统
- 环境特效生成

---

### UseCase 2: 碰撞检测系统（Collision Detection）

**描述**: 检测玩家进入特定区域，触发事件。

**无需 Device**: ✅ 完全可独立实现

**核心机制**:

- FindOverlapHits() 空间查询
- spawn + Sleep 定期检测
- 事件通知

**完整示例**:

```verse
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 触发区域事件
zone_entered_event := class<concrete>(scene_event):
    var Agent:agent
    var Zone:entity

zone_exited_event := class<concrete>(scene_event):
    var Agent:agent
    var Zone:entity

# 触发区域组件
trigger_zone_component := class(component):
    var CheckInterval<private>:float = 0.2  # 每 0.2 秒检测
    var AgentsInZone<private>:map(agent, logic) = map{}
    var IsRunning<private>:logic = false

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        StartMonitoring()

    StartMonitoring():void =
        set IsRunning = true
        spawn:
            MonitorLoop()

    MonitorLoop()<suspends>:void =
        loop:
            if not IsRunning:
                break

            Sleep(CheckInterval)
            CheckOverlaps()

    CheckOverlaps():void =
        if (Owner := GetOwner()):
            # 获取当前碰撞的所有对象
            Hits := Owner.FindOverlapHits()

            var CurrentAgents:map(agent, logic) = map{}

            # 检测所有碰撞
            for (Hit : Hits):
                if (HitAgent := Hit.HitAgent?):
                    if:
                        set CurrentAgents[HitAgent] = true

                    # 如果是新进入的
                    if not AgentsInZone.HasKey(HitAgent):
                        OnAgentEntered(HitAgent)

            # 检测离开的 Agent
            for (Agent -> _ : AgentsInZone):
                if not CurrentAgents.HasKey(Agent):
                    OnAgentExited(Agent)

            # 更新列表
            set AgentsInZone = CurrentAgents

    OnAgentEntered(Agent:agent):void =
        if (Owner := GetOwner()):
            Event := zone_entered_event{Agent := Agent, Zone := Owner}
            Owner.SendUp(Event)

    OnAgentExited(Agent:agent):void =
        if (Owner := GetOwner()):
            Event := zone_exited_event{Agent := Agent, Zone := Owner}
            Owner.SendUp(Event)

    GetAgentsInZone():[]agent =
        return AgentsInZone.Keys()

    OnDestroy<override>():void =
        set IsRunning = false
```text

**使用场景**:

- 进入区域触发剧情
- 安全区/危险区检测
- 道具拾取检测

---

### UseCase 3: 状态机系统（State Machine）

**描述**: 管理游戏对象的状态转换（如敌人 AI、游戏阶段）。

**无需 Device**: ✅ 完全可独立实现

**核心机制**:

- 组件存储状态
- 事件驱动状态转换
- spawn 实现状态更新循环

**完整示例**:

```verse
using { /Verse.org/SceneGraph }

# 状态枚举
enemy_state := enum:
    Idle
    Patrol
    Chase
    Attack
    Retreat
    Dead

# 状态转换事件
state_changed_event := class<concrete>(scene_event):
    var OldState:enemy_state
    var NewState:enemy_state
    var Reason:string

# 状态机组件
enemy_state_machine := class(component):
    var CurrentState<private>:enemy_state = enemy_state.Idle
    var StateStartTime<private>:float = 0.0
    var IsRunning<private>:logic = false

    # 状态参数
    var IdleDuration<private>:float = 2.0
    var PatrolDuration<private>:float = 5.0
    var ChaseSpeed<private>:float = 10.0

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        StartStateMachine()

    StartStateMachine():void =
        set IsRunning = true
        spawn:
            StateMachineLoop()

    StateMachineLoop()<suspends>:void =
        loop:
            if not IsRunning:
                break

            # 根据当前状态执行逻辑
            if CurrentState = enemy_state.Idle:
                StateIdle()
            else if CurrentState = enemy_state.Patrol:
                StatePatrol()
            else if CurrentState = enemy_state.Chase:
                StateChase()
            else if CurrentState = enemy_state.Attack:
                StateAttack()
            else if CurrentState = enemy_state.Retreat:
                StateRetreat()
            else if CurrentState = enemy_state.Dead:
                StateDead()

            Sleep(0.1)  # 状态更新间隔

    # 状态逻辑
    StateIdle()<suspends>:void =
        ElapsedTime := GetTime() - StateStartTime
        if ElapsedTime > IdleDuration:
            ChangeState(enemy_state.Patrol, "Idle timeout")

    StatePatrol()<suspends>:void =
        ElapsedTime := GetTime() - StateStartTime

        # 巡逻逻辑
        MoveAlongPath()

        # 检测玩家
        if DetectPlayer():
            ChangeState(enemy_state.Chase, "Player detected")

        if ElapsedTime > PatrolDuration:
            ChangeState(enemy_state.Idle, "Patrol timeout")

    StateChase()<suspends>:void =
        # 追逐逻辑
        if IsPlayerInAttackRange():
            ChangeState(enemy_state.Attack, "Player in range")
        else if not DetectPlayer():
            ChangeState(enemy_state.Patrol, "Lost player")

    StateAttack()<suspends>:void =
        # 攻击逻辑
        PerformAttack()

        if not IsPlayerInAttackRange():
            ChangeState(enemy_state.Chase, "Player out of range")

    StateRetreat()<suspends>:void =
        # 撤退逻辑
        MoveAway()

        if IsHealthRestored():
            ChangeState(enemy_state.Patrol, "Health restored")

    StateDead()<suspends>:void =
        # 死亡逻辑
        # 停止状态机
        set IsRunning = false

    # 状态转换
    ChangeState(NewState:enemy_state, Reason:string):void =
        OldState := CurrentState
        set CurrentState = NewState
        set StateStartTime = GetTime()

        # 发送事件
        if (Owner := GetOwner()):
            Event := state_changed_event{
                OldState := OldState,
                NewState := NewState,
                Reason := Reason
            }
            Owner.SendUp(Event)

        # 状态进入回调
        OnStateEnter(NewState)
        OnStateExit(OldState)

    OnStateEnter(State:enemy_state):void =
        # 进入状态时的初始化
        if State = enemy_state.Attack:
            PrepareAttack()

    OnStateExit(State:enemy_state):void =
        # 退出状态时的清理
        if State = enemy_state.Attack:
            CleanupAttack()

    # 辅助方法
    MoveAlongPath():void = pass
    DetectPlayer():logic = false
    IsPlayerInAttackRange():logic = false
    PerformAttack():void = pass
    MoveAway():void = pass
    IsHealthRestored():logic = false
    PrepareAttack():void = pass
    CleanupAttack():void = pass

    GetTime():float = 0.0  # 需要实际实现

    OnDestroy<override>():void =
        set IsRunning = false
```text

**使用场景**:

- 敌人 AI 行为
- 游戏阶段管理（等待 → 游戏中 → 结束）
- Boss 战阶段切换

---

### UseCase 4: 计时器系统（Timer System）

**描述**: 实现倒计时、定时触发等功能。

**无需 Device**: ✅ 完全可独立实现

**核心机制**:

- spawn + Sleep 实现定时
- 事件通知

**完整示例**:

```verse
using { /Verse.org/SceneGraph }

# 计时器事件
timer_tick_event := class<concrete>(scene_event):
    var RemainingTime:float
    var ElapsedTime:float

timer_complete_event := class<concrete>(scene_event):
    var TotalTime:float

# 计时器组件
timer_component := class(component):
    var Duration<private>:float = 10.0
    var RemainingTime<private>:float = 10.0
    var ElapsedTime<private>:float = 0.0
    var IsRunning<private>:logic = false
    var TickInterval<private>:float = 1.0  # 每秒触发一次事件

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

    # 启动计时器
    Start(DurationSeconds:float):void =
        set Duration = DurationSeconds
        set RemainingTime = DurationSeconds
        set ElapsedTime = 0.0
        set IsRunning = true

        spawn:
            TimerLoop()

    TimerLoop()<suspends>:void =
        var LastTickTime:float = 0.0

        loop:
            if not IsRunning:
                break

            Sleep(0.1)  # 精度

            set ElapsedTime += 0.1
            set RemainingTime = Duration - ElapsedTime

            # 检查是否完成
            if RemainingTime <= 0.0:
                OnTimerComplete()
                break

            # 每秒触发事件
            if ElapsedTime - LastTickTime >= TickInterval:
                set LastTickTime = ElapsedTime
                OnTick()

    OnTick():void =
        if (Owner := GetOwner()):
            Event := timer_tick_event{
                RemainingTime := RemainingTime,
                ElapsedTime := ElapsedTime
            }
            Owner.SendUp(Event)

    OnTimerComplete():void =
        set IsRunning = false

        if (Owner := GetOwner()):
            Event := timer_complete_event{TotalTime := Duration}
            Owner.SendUp(Event)

    # 暂停/恢复
    Pause():void =
        set IsRunning = false

    Resume():void =
        set IsRunning = true
        spawn:
            TimerLoop()

    # 重置
    Reset():void =
        set ElapsedTime = 0.0
        set RemainingTime = Duration
        set IsRunning = false

    # 查询
    GetRemainingTime():float = RemainingTime
    GetElapsedTime():float = ElapsedTime
    GetProgress():float = ElapsedTime / Duration
```text

**使用场景**:

- 回合计时
- 技能冷却
- 事件倒计时

---

### UseCase 5: 事件总线系统（Event Bus）

**描述**: 全局事件广播和订阅。

**无需 Device**: ✅ 完全可独立实现

**核心机制**:

- 根实体 SendDown 实现全局广播
- 组件 OnReceive 订阅事件

**完整示例**:

```verse
using { /Verse.org/SceneGraph }

# 全局事件总线组件（单例）
event_bus_component := class(component):
    var Instance<private>:?event_bus_component = false

    OnAddedToScene<override>()<suspends>:void =
        if (Inst := Instance?):
            Print("Event bus already exists")
            # 销毁重复实例
            if (Owner := GetOwner()):
                Owner.RemoveFromParent()
        else:
            set Instance = option{Self}

    # 全局广播
    Broadcast<public>(Event:scene_event):void =
        if (Owner := GetOwner()):
            if (Root := FindRootEntity(Owner)):
                Root.SendDown(Event)

    # 向特定实体发送
    SendTo<public>(Target:entity, Event:scene_event):void =
        Target.SendDirect(Event)

    # 查找根实体
    FindRootEntity(Start:entity)<private><decides>:entity =
        Current := Start
        loop:
            if (Parent := Current.GetParent()):
                set Current = Parent
            else:
                return Current

    # 获取单例
    GetInstance<public>()<decides>:event_bus_component =
        if (Inst := Instance?):
            return Inst
        Fail()

# 使用示例：发布者
publisher_component := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)

        # 延迟 3 秒后广播事件
        Sleep(3.0)
        PublishEvent()

    PublishEvent():void =
        if (EventBus := event_bus_component.GetInstance[]):
            Event := global_notification_event{
                Message := "Hello from publisher!",
                Timestamp := GetTime()
            }
            EventBus.Broadcast(Event)

    GetTime():float = 0.0  # 需实现

# 使用示例：订阅者
subscriber_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (NotificationEvent := Event?global_notification_event):
            Print("Received: {NotificationEvent.Message}")
            return true
        return false

# 全局通知事件
global_notification_event := class<concrete>(scene_event):
    var Message:string
    var Timestamp:float
```text

**使用场景**:

- 全局游戏事件通知
- 跨系统通信
- 解耦模块间依赖

---

## 二、需要 Device 辅助的场景

### UseCase 6: 玩家输入响应

**描述**: 响应玩家键盘/鼠标输入。

**需要 Device**: ⚠️ `input_trigger_device`

**原因**: SceneGraph 无输入 API

**混合方案**:

```verse
# Device 部分（UEFN 编辑器配置）
# input_trigger_device 配置为监听特定键

# SceneGraph 组件接收 Device 事件
input_handler_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        # 假设 Device 发送的事件
        if (InputEvent := Event?input_triggered_event):
            HandleInput(InputEvent.InputName)
            return true
        return false

    HandleInput(InputName:string):void =
        if InputName = "Jump":
            OnJump()
        else if InputName = "Fire":
            OnFire()

    OnJump():void =
        Print("Player jumped")

    OnFire():void =
        Print("Player fired")

# 假设的输入事件
input_triggered_event := class<concrete>(scene_event):
    var InputName:string
    var Player:agent
```text

---

### UseCase 7: UI 显示

**描述**: 显示 HUD、菜单、得分板。

**需要 Device**: ⚠️ `hud_message_device`, `billboard_device`

**原因**: SceneGraph 无 UI API

**混合方案**:

```verse
# SceneGraph 组件通知 Device 更新 UI
ui_controller_component := class(component):
    UpdateScoreDisplay(Player:agent, Score:int):void =
        # 发送事件给 Device 组件（假设）
        if (Owner := GetOwner()):
            Event := update_score_ui_event{Player := Player, Score := Score}
            Owner.SendUp(Event)  # Device 监听此事件

update_score_ui_event := class<concrete>(scene_event):
    var Player:agent
    var Score:int
```text

---

### UseCase 8: 音效播放

**描述**: 播放音效、背景音乐。

**需要 Device**: ⚠️ `audio_player_device`

**原因**: SceneGraph 无音频 API

**混合方案**:

```verse
# SceneGraph 组件触发音效
audio_controller_component := class(component):
    PlaySound(SoundName:string):void =
        # 发送事件给 Device
        if (Owner := GetOwner()):
            Event := play_sound_event{SoundName := SoundName}
            Owner.SendUp(Event)

play_sound_event := class<concrete>(scene_event):
    var SoundName:string
```text

---

## 三、UseCase 总结表

| UseCase | 独立实现 | 需要 Device | 核心机制 |
|---------|----------|-------------|----------|
| **对象生成系统** | ✅ | ❌ | spawn + Sleep + entity |
| **碰撞检测** | ✅ | ❌ | FindOverlapHits + 事件 |
| **状态机** | ✅ | ❌ | 组件状态 + 事件 |
| **计时器** | ✅ | ❌ | spawn + Sleep |
| **事件总线** | ✅ | ❌ | SendDown + OnReceive |
| **层级管理** | ✅ | ❌ | AddEntities + GetParent |
| **数据同步** | ✅ | ❌ | map + 事件 |
| **对象池** | ✅ | ❌ | array + entity 复用 |
| **玩家输入** | ❌ | ✅ | input_trigger_device |
| **UI 显示** | ❌ | ✅ | hud_message_device |
| **音效播放** | ❌ | ✅ | audio_player_device |
| **物理模拟** | ❌ | ✅ | physics_device |
| **游戏规则** | ❌ | ✅ | end_game_device |
| **伤害系统** | ⚠️ | 部分 | 需 agent 引用（Device 提供） |

**图例**:

- ✅ 完全可独立实现
- ❌ 必须使用 Device
- ⚠️ 需要 Device 辅助（提供部分数据）

---

## 四、混合架构最佳实践

### 模式 1: Device → SceneGraph（事件驱动）

```verse
# Device 触发事件 → SceneGraph 组件处理

# SceneGraph 组件
device_event_handler := class(component):
    OnReceive<override>(Event:scene_event):logic =
        # 监听 Device 发送的事件
        if (DeviceEvent := Event?device_triggered_event):
            HandleDeviceEvent(DeviceEvent)
            return true
        return false

    HandleDeviceEvent(Event:device_triggered_event):void =
        # 处理 Device 事件
        Print("Device triggered: {Event.Data}")
```text

### 模式 2: SceneGraph → Device（命令模式）

```verse
# SceneGraph 发送命令 → Device 执行

command_sender_component := class(component):
    SendCommandToDevice(Command:string, Data:string):void =
        if (Owner := GetOwner()):
            Event := device_command_event{Command := Command, Data := Data}
            Owner.SendUp(Event)  # Device 监听

device_command_event := class<concrete>(scene_event):
    var Command:string
    var Data:string
```text

---

**总结**:

- ✅ SceneGraph 可独立实现大量游戏逻辑
- ⚠️ 玩家交互（输入、UI、音频）需 Device 辅助
- 🔄 推荐混合架构：SceneGraph 管理逻辑，Device 处理交互
