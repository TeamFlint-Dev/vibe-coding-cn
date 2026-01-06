# Fortnite.com/Animation 模块深度调研报告

## 1. 模块概述

### 1.1 模块用途

`/Fortnite.com/Animation` 模块是 UEFN/Verse 中专门用于**角色动画播放和控制**的核心API模块。它提供了在运行时动态播放动画序列的能力，允许开发者精确控制角色的动画状态。

**设计理念**：

- **声明式动画控制**：通过简洁的API接口播放和管理动画
- **异步友好**：提供 `suspends` 异步等待机制，方便编排动画流程
- **事件驱动**：提供丰富的动画生命周期事件
- **状态透明**：可随时查询动画播放状态

### 1.2 适用场景

| 场景类型 | 具体应用 |
|---------|---------|
| **角色表演** | NPC 对话动画、情绪表达、交互反馈 |
| **游戏机制** | 技能施放动画、受击反馈、死亡动画 |
| **过场动画** | 剧情演出、开场动画、教程演示 |
| **环境交互** | 拾取物品、开门、操作机关 |
| **UI反馈** | 角色预览动画、胜利姿态展示 |

**重要限制**：

- ⚠️ 此模块**仅支持 `fort_character` 对象**（玩家和NPC角色）
- ⚠️ **不支持道具动画**（道具动画需使用 `CreativeAnimation` 模块）
- ⚠️ 需要预先准备好 `animation_sequence` 资源

---

## 2. 核心类/接口清单

### 2.1 按功能分类

#### 动画控制器

| 类/接口 | 类型 | 用途 |
|--------|------|------|
| `play_animation_controller` | interface | 动画播放的主控制器，提供播放和等待方法 |

#### 动画实例

| 类/接口 | 类型 | 用途 |
|--------|------|------|
| `play_animation_instance` | class | 正在播放的动画实例，可查询状态和操控 |

#### 枚举类型

| 枚举 | 用途 |
|------|------|
| `play_animation_result` | 动画播放结果状态（完成/中断/错误） |
| `play_animation_state` | 动画实例的当前状态 |

### 2.2 完整API结构

```verse
Animation<public> := module:
    PlayAnimation<public> := module:
        # 播放结果枚举
        play_animation_result<native><public> := enum
        
        # 播放控制器接口
        play_animation_controller<native><public> := interface
        
        # 动画实例类
        play_animation_instance<native><public> := class
        
        # 状态枚举
        play_animation_state<native><public> := enum
```

---

## 3. 关键API详解

### 3.1 获取动画控制器

```verse
(InCharacter:fort_character).GetPlayAnimationController<native><public>()<transacts><decides>:play_animation_controller
```

**用途**：从 `fort_character` 获取动画控制器实例。

**参数**：无（扩展方法，直接在角色对象上调用）

**返回值**：`play_animation_controller` - 动画控制器实例

**注意事项**：

- ✅ `<decides>` 标记意味着此方法可能失败
- ❌ 角色已被消灭或无效时会失败
- ⚠️ 建议使用 `if` 表达式处理失败情况

---

### 3.2 play_animation_controller 接口

#### 3.2.1 PlayAndAwait - 播放并等待完成

```verse
PlayAndAwait<public>(
    AnimationSequence:animation_sequence,
    ?PlayRate:float = external {},
    ?PlayCount:float = external {},
    ?StartPositionSeconds:float = external {},
    ?BlendInTime:float = external {},
    ?BlendOutTime:float = external {}
)<suspends>:play_animation_result
```

**参数说明**：

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `AnimationSequence` | `animation_sequence` | 必填 | 要播放的动画资源 |
| `PlayRate` | `float` | `1.0` | 播放速率（2.0 = 双倍速，0.5 = 半速） |
| `PlayCount` | `float` | `1.0` | 播放次数（支持小数，如 2.5 次） |
| `StartPositionSeconds` | `float` | `0.0` | 起始播放位置（秒） |
| `BlendInTime` | `float` | `0.2` | 混入时间（秒），动画平滑过渡 |
| `BlendOutTime` | `float` | `0.2` | 混出时间（秒），动画结束过渡 |

**返回值**：`play_animation_result` 枚举值

| 返回值 | 含义 |
|--------|------|
| `Completed` | 动画正常完成 |
| `Interrupted` | 动画被其他动画打断 |
| `Error` | 发生错误（资源无效、角色已消灭等） |

**使用特点**：

- 🔄 `<suspends>` - 会暂停当前协程直到动画完成
- ✅ 适用于需要等待动画结束后再执行后续逻辑的场景
- ⚠️ 如果动画被打断或出错，仍会返回（不会永久挂起）

---

#### 3.2.2 Play - 启动动画并立即返回

```verse
Play<public>(
    AnimationSequence:animation_sequence,
    ?PlayRate:float = external {},
    ?PlayCount:float = external {},
    ?StartPositionSeconds:float = external {},
    ?BlendInTime:float = external {},
    ?BlendOutTime:float = external {}
):play_animation_instance
```

**参数说明**：与 `PlayAndAwait` 完全相同

**返回值**：`play_animation_instance` - 动画实例对象

**使用特点**：

- ⚡ 不会阻塞，立即返回动画实例
- 🎮 适用于"发射后不管"的动画（如待机动画、循环动画）
- 📡 可通过返回的实例后续查询状态或停止动画

---

### 3.3 play_animation_instance 类

#### 3.3.1 状态查询方法

```verse
# 获取当前状态
GetState<native><public>()<transacts>:play_animation_state

# 判断是否正在播放（包括混入/混出阶段）
IsPlaying<public>()<transacts><decides>:void
```

**状态枚举值**：

| 状态 | 说明 | 对应生命周期 |
|------|------|-------------|
| `BlendingIn` | 正在混入 | 动画刚启动，正在与前一个动画混合 |
| `Playing` | 正在播放 | 混入完成，处于主要播放阶段 |
| `BlendingOut` | 正在混出 | 即将结束，正在混出 |
| `Completed` | 已完成 | 正常播放结束 |
| `Stopped` | 已停止 | 被 `Stop()` 方法停止 |
| `Interrupted` | 被中断 | 被新动画打断 |
| `Error` | 错误 | 播放过程中出错 |

---

#### 3.3.2 控制方法

```verse
# 停止动画
Stop<native><public>():void

# 等待动画完成（类似 PlayAndAwait 的等待部分）
Await<public>()<suspends>:play_animation_result
```

**Stop() 使用说明**：

- 立即停止动画播放
- 不会触发 `CompletedEvent`
- 会触发 `InterruptedEvent`（如果有监听）
- 动画状态变为 `Stopped`

**Await() 使用说明**：

- 配合 `Play()` 使用，实现"先启动，后等待"的模式
- 返回值与 `PlayAndAwait` 相同

---

#### 3.3.3 事件监听

```verse
# 动画完成事件
CompletedEvent<native><public>:listenable(tuple()) = external {}

# 动画中断事件
InterruptedEvent<native><public>:listenable(tuple()) = external {}

# 混入完成事件
BlendedInEvent<native><public>:listenable(tuple()) = external {}

# 混出开始事件
BlendingOutEvent<native><public>:listenable(tuple()) = external {}
```

**事件触发时机**：

| 事件 | 触发时机 | 典型用途 |
|------|---------|---------|
| `CompletedEvent` | 动画正常播放完成 | 触发后续逻辑（如播放下一个动画） |
| `InterruptedEvent` | 被其他动画打断或被 `Stop()` 停止 | 清理资源、记录日志 |
| `BlendedInEvent` | 混入阶段完成，进入主播放阶段 | 精确时机控制（如特效同步） |
| `BlendingOutEvent` | 开始混出阶段 | 预告动画即将结束 |

---

### 3.4 play_animation_result 枚举

```verse
play_animation_result<native><public> := enum:
    Completed      # 正常完成
    Interrupted    # 被中断
    Error          # 发生错误
```

**使用场景**：

```verse
# 检查播放结果
Result := Controller.PlayAndAwait(MyAnimation)
if (Result = play_animation_result.Completed):
    Print("动画播放成功")
else if (Result = play_animation_result.Interrupted):
    Print("动画被打断")
else:
    Print("动画播放出错")
```

---

## 4. 代码示例

### 4.1 基础示例：播放单个动画并等待

```verse
using { /Fortnite.com/Animation/PlayAnimation }
using { /Fortnite.com/Characters }
using { /Verse.org/Assets }

# 播放一个简单的挥手动画
PlayWaveAnimation(Character:fort_character, WaveAnim:animation_sequence):void=
    # 获取动画控制器
    if (Controller := Character.GetPlayAnimationController[]):
        # 播放动画并等待完成
        Result := Controller.PlayAndAwait(WaveAnim)
        
        # 根据结果执行后续逻辑
        if (Result = play_animation_result.Completed):
            Print("角色挥手完成")
        else if (Result = play_animation_result.Interrupted):
            Print("挥手被打断")
```

**关键点**：

- 使用 `if` 表达式处理 `GetPlayAnimationController` 可能失败的情况
- `PlayAndAwait` 会阻塞直到动画完成
- 检查返回结果以判断动画是否成功播放

---

### 4.2 进阶示例：连续播放多个动画

```verse
# 播放动画序列：招手 -> 点头 -> 欢呼
PlayGreetingSequence<private>(
    Character:fort_character,
    WaveAnim:animation_sequence,
    NodAnim:animation_sequence,
    CheerAnim:animation_sequence
)<suspends>:void=
    if (Controller := Character.GetPlayAnimationController[]):
        # 第一步：播放招手动画
        Result1 := Controller.PlayAndAwait(WaveAnim, PlayRate := 1.2)
        
        if (Result1 = play_animation_result.Completed):
            # 第二步：播放点头动画（播放2次）
            Result2 := Controller.PlayAndAwait(
                NodAnim, 
                PlayCount := 2.0,
                BlendInTime := 0.1
            )
            
            if (Result2 = play_animation_result.Completed):
                # 第三步：播放欢呼动画
                Controller.PlayAndAwait(
                    CheerAnim,
                    PlayRate := 0.8  # 慢速播放
                )
```

**技巧总结**：

- ✅ 使用不同的 `PlayRate` 控制动画节奏
- ✅ 使用 `PlayCount` 重复播放动画
- ✅ 使用短 `BlendInTime` 实现快速切换
- ⚠️ 每次 `PlayAndAwait` 都应检查返回值，避免在动画被打断后继续执行

---

### 4.3 高级示例：使用事件监听

```verse
# 播放攻击动画，并在混入完成时触发特效
PlayAttackWithEffect<private>(
    Character:fort_character,
    AttackAnim:animation_sequence,
    EffectSpawner:creative_device
)<suspends>:void=
    if (Controller := Character.GetPlayAnimationController[]):
        # 启动动画（不等待完成）
        Instance := Controller.Play(AttackAnim, PlayRate := 1.5)
        
        # 监听混入完成事件
        race:
            # 分支1：等待混入完成，然后触发特效
            block:
                Instance.BlendedInEvent.Await()
                Print("攻击动画混入完成，触发特效")
                EffectSpawner.Enable()  # 启用特效
            
            # 分支2：等待动画完成或中断
            block:
                Result := Instance.Await()
                if (Result = play_animation_result.Completed):
                    Print("攻击动画播放完成")
                else:
                    Print("攻击动画被中断")
```

**核心技巧**：

- 🔀 使用 `race` 并发监听多个事件
- ⚡ 通过 `BlendedInEvent` 实现精确时机控制
- 🎯 `Play()` + `Await()` 模式适合需要中途处理的场景

---

### 4.4 实战示例：可中断的待机动画循环

```verse
# 持续播放待机动画，直到被外部信号中断
PlayIdleLoop<private>(
    Character:fort_character,
    IdleAnim:animation_sequence,
    var ShouldStop:logic  # 外部控制标志
)<suspends>:void=
    if (Controller := Character.GetPlayAnimationController[]):
        loop:
            if (ShouldStop):
                break
            
            # 播放一次待机动画
            Result := Controller.PlayAndAwait(
                IdleAnim,
                PlayCount := 1.0,
                BlendInTime := 0.3,
                BlendOutTime := 0.3
            )
            
            # 如果被其他动画打断，退出循环
            if (Result = play_animation_result.Interrupted):
                Print("待机动画被打断，退出循环")
                break
```

**应用场景**：

- NPC 待机状态管理
- 角色选择界面的预览动画
- 等待玩家输入时的动画循环

---

### 4.5 复杂示例：状态机风格的动画管理

```verse
# 根据角色状态播放对应动画
ManageCharacterAnimations<private>(
    Character:fort_character,
    IdleAnim:animation_sequence,
    WalkAnim:animation_sequence,
    RunAnim:animation_sequence
)<suspends>:void=
    if (Controller := Character.GetPlayAnimationController[]):
        var CurrentState:int = 0  # 0=Idle, 1=Walk, 2=Run
        var PreviousState:int = -1
        var CurrentInstance:?play_animation_instance = false
        
        loop:
            # 检测状态变化
            if (CurrentState <> PreviousState):
                # 停止前一个动画
                if (PrevInstance := CurrentInstance?):
                    PrevInstance.Stop()
                
                # 根据新状态播放对应动画
                SelectedAnim := if (CurrentState = 0) then IdleAnim
                               else if (CurrentState = 1) then WalkAnim
                               else RunAnim
                
                # 启动新动画（循环播放）
                set CurrentInstance = option{Controller.Play(
                    SelectedAnim,
                    PlayCount := 999.0,  # 近似无限循环
                    BlendInTime := 0.2
                )}
                
                set PreviousState = CurrentState
            
            # 这里可以添加状态检测逻辑
            # 例如：根据角色速度更新 CurrentState
            
            Sleep(0.1)  # 每0.1秒检查一次
```

**设计亮点**：

- 🔄 状态机模式管理多个动画
- ⚡ 自动处理动画切换和混合
- 🎯 使用 `option` 类型处理动画实例的可选性

---

## 5. 常见误区澄清

### ❌ 误区1：Animation 模块可以用于道具动画

**错误认知**：

```verse
# 错误示例：尝试对道具播放动画
MyProp := creative_prop{}
if (Controller := MyProp.GetPlayAnimationController[]):  # ❌ 编译错误！
    Controller.PlayAndAwait(SomeAnimation)
```

**正确理解**：

- ✅ `Animation` 模块**仅支持 `fort_character`**
- ✅ 道具动画应使用 `/Fortnite.com/Devices/CreativeAnimation` 模块
- ✅ 通过 `creative_prop.GetAnimationController()` 获取道具动画控制器

**正确代码**：

```verse
using { /Fortnite.com/Devices/CreativeAnimation }

MyProp := creative_prop{}
if (PropController := MyProp.GetAnimationController[]):
    # 使用 CreativeAnimation 的 API
    PropController.SetAnimation(KeyframeDeltaArray)
    PropController.Play()
```

---

### ❌ 误区2：PlayAndAwait 会阻塞整个游戏

**错误认知**：

"调用 `PlayAndAwait` 会让游戏卡住，直到动画播放完"

**正确理解**：

- ✅ `PlayAndAwait` 只阻塞**当前协程**
- ✅ 其他协程和游戏逻辑继续正常运行
- ✅ 这是 Verse 的 `<suspends>` 机制，类似其他语言的 `async/await`

**对比示例**：

```verse
# 两个角色同时播放动画，互不阻塞
PlayBothCharactersAnimations<private>(
    Char1:fort_character,
    Char2:fort_character,
    Anim1:animation_sequence,
    Anim2:animation_sequence
)<suspends>:void=
    # 并发执行两个动画
    race:
        block:
            if (Controller1 := Char1.GetPlayAnimationController[]):
                Controller1.PlayAndAwait(Anim1)  # 阻塞此分支，但不阻塞另一个分支
        block:
            if (Controller2 := Char2.GetPlayAnimationController[]):
                Controller2.PlayAndAwait(Anim2)  # 同时播放
```

---

### ❌ 误区3：动画资源可以在运行时动态创建

**错误认知**：

"我可以通过代码生成 `animation_sequence` 对象"

**正确理解**：

- ❌ `animation_sequence` 是 `/Verse.org/Assets` 模块的资源类型
- ❌ **无法在运行时动态创建或修改**
- ✅ 必须在 UEFN 编辑器中预先准备动画资源
- ✅ 通过资源引用（`@editable` 属性）在代码中使用

**正确做法**：

```verse
using { /Verse.org/Assets }

my_device := class(creative_device):
    # 在 UEFN 编辑器中设置的动画资源引用
    @editable
    AttackAnimation:animation_sequence = animation_sequence{}
    
    @editable
    DefendAnimation:animation_sequence = animation_sequence{}
    
    OnBegin<override>()<suspends>:void=
        # 使用预先设置好的动画资源
        # 无需也无法在运行时创建
```

---

### ❌ 误区4：同一个角色可以同时播放多个动画

**错误认知**：

"我可以同时播放角色的上半身和下半身动画"

**正确理解**：

- ❌ `play_animation_controller` **不支持动画分层或混合**
- ❌ 新动画会**中断**正在播放的动画
- ✅ 一个角色同一时间只能播放一个 `animation_sequence`
- ⚠️ 如果需要复杂的动画混合，需要在 UE 动画蓝图层面处理

**行为示例**：

```verse
if (Controller := Character.GetPlayAnimationController[]):
    # 启动第一个动画
    Instance1 := Controller.Play(Animation1, PlayCount := 5.0)
    
    Sleep(1.0)
    
    # 启动第二个动画 -> Animation1 会被中断！
    Instance2 := Controller.Play(Animation2)
    
    # Instance1 的状态变为 Interrupted
    State1 := Instance1.GetState()  # 返回 play_animation_state.Interrupted
```

---

### ❌ 误区5：BlendInTime 和 BlendOutTime 可以设置为0以节省性能

**错误认知**：

"设置混合时间为0可以让动画立即切换，更节省资源"

**正确理解**：

- ⚠️ 混合时间为 `0.0` 会导致**生硬的动画切换**
- ✅ 适当的混合时间（0.1 - 0.3秒）可以让动画过渡更自然
- ✅ 混合计算的性能消耗极小，不应为了"优化"而牺牲视觉效果
- 🎯 只有在需要即时响应的场景（如受击反馈）才考虑极短混合时间

**推荐设置**：

| 场景 | BlendInTime | BlendOutTime |
|------|-------------|--------------|
| 待机 -> 行走 | 0.2 - 0.3 | 0.2 - 0.3 |
| 行走 -> 跑步 | 0.1 - 0.2 | 0.1 - 0.2 |
| 待机 -> 攻击 | 0.05 - 0.1 | 0.1 - 0.2 |
| 受击反馈 | 0.0 - 0.05 | 0.1 |
| 技能施放 | 0.1 - 0.15 | 0.15 - 0.25 |

---

## 6. 最佳实践

### 6.1 推荐的使用模式

#### ✅ 模式1：简单的单次动画播放

```verse
# 适用场景：NPC 对话、技能施放等一次性动画
PlayOneShotAnimation(Character:fort_character, Anim:animation_sequence)<suspends>:void=
    if (Controller := Character.GetPlayAnimationController[]):
        Result := Controller.PlayAndAwait(Anim)
        # 根据结果执行后续逻辑
```

**优点**：

- 代码简洁清晰
- 自动等待完成
- 容易处理结果

---

#### ✅ 模式2：事件驱动的动画管理

```verse
# 适用场景：需要在动画特定时刻触发逻辑
PlayAnimationWithEvents(
    Character:fort_character,
    Anim:animation_sequence,
    OnBlendedIn:type{_():void},  # 回调函数
    OnCompleted:type{_():void}
)<suspends>:void=
    if (Controller := Character.GetPlayAnimationController[]):
        Instance := Controller.Play(Anim)
        
        # 使用 race 监听多个事件
        race:
            block:
                Instance.BlendedInEvent.Await()
                OnBlendedIn()
            block:
                Instance.CompletedEvent.Await()
                OnCompleted()
```

**优点**：

- 精确控制时机
- 支持回调解耦
- 灵活性高

---

#### ✅ 模式3：可取消的动画播放

```verse
# 适用场景：可被玩家输入中断的动画
PlayCancelableAnimation(
    Character:fort_character,
    Anim:animation_sequence,
    CancelSignal:awaitable(void)
)<suspends>:play_animation_result=
    var Result:play_animation_result = play_animation_result.Error
    
    if (Controller := Character.GetPlayAnimationController[]):
        Instance := Controller.Play(Anim)
        
        race:
            # 分支1：等待动画完成
            block:
                set Result = Instance.Await()
            # 分支2：等待取消信号
            block:
                CancelSignal.Await()
                Instance.Stop()
                set Result = play_animation_result.Interrupted
    
    Result
```

**优点**：

- 支持外部中断
- 提升交互响应性
- 适用于可打断的技能

---

### 6.2 性能优化建议

#### 优化1：避免频繁获取控制器

```verse
# ❌ 不推荐：每次播放都获取控制器
PlayAnimationBad(Character:fort_character, Anim:animation_sequence)<suspends>:void=
    if (Controller := Character.GetPlayAnimationController[]):
        Controller.PlayAndAwait(Anim)

# ✅ 推荐：缓存控制器引用
my_animator := class:
    Character:fort_character
    Controller:?play_animation_controller = false
    
    Init():void=
        if (Ctrl := Character.GetPlayAnimationController[]):
            set Controller = option{Ctrl}
    
    Play(Anim:animation_sequence)<suspends>:void=
        if (Ctrl := Controller?):
            Ctrl.PlayAndAwait(Anim)
```

---

#### 优化2：合理使用 PlayCount 而非循环播放

```verse
# ❌ 不推荐：手动循环播放
loop:
    Controller.PlayAndAwait(Anim)

# ✅ 推荐：使用 PlayCount
Controller.PlayAndAwait(Anim, PlayCount := 999.0)  # 近似无限循环
```

**原因**：

- 减少 Verse 协程切换开销
- 动画引擎内部循环更高效
- 混合处理更平滑

---

#### 优化3：批量动画预加载

```verse
# 在设备初始化时预加载所有可能用到的动画
my_device := class(creative_device):
    @editable var Animations:[]animation_sequence = array{}
    
    OnBegin<override>()<suspends>:void=
        # 通过播放极短时间来触发资源预加载
        if (TestChar := GetTestCharacter[]):
            if (Controller := TestChar.GetPlayAnimationController[]):
                for (Anim : Animations):
                    Controller.Play(Anim, StartPositionSeconds := 0.0)
                    Sleep(0.01)  # 立即停止
```

**注意**：这是一个高级优化技巧，通常不需要。

---

### 6.3 与其他模块的配合使用

#### 配合1：Animation + Characters

```verse
using { /Fortnite.com/Animation/PlayAnimation }
using { /Fortnite.com/Characters }

# 角色消灭时播放死亡动画
HandleCharacterElimination(Character:fort_character, DeathAnim:animation_sequence)<suspends>:void=
    # 监听消灭事件
    Character.EliminatedEvent().Await()
    
    # 播放死亡动画
    if (Controller := Character.GetPlayAnimationController[]):
        Controller.PlayAndAwait(DeathAnim, PlayRate := 0.8)
```

---

#### 配合2：Animation + Game (Stasis)

```verse
using { /Fortnite.com/Animation/PlayAnimation }
using { /Fortnite.com/Characters }

# 播放动画时禁用角色移动
PlayAnimationInStasis(Character:fort_character, Anim:animation_sequence)<suspends>:void=
    # 进入静止状态（禁止移动，但允许转身和表情）
    Character.PutInStasis(stasis_args{
        AllowTurning := true,
        AllowFalling := false,
        AllowEmotes := true
    })
    
    # 播放动画
    if (Controller := Character.GetPlayAnimationController[]):
        Controller.PlayAndAwait(Anim)
    
    # 恢复移动能力
    Character.ReleaseFromStasis()
```

**典型场景**：

- 过场动画
- 技能施放动画（禁止移动）
- NPC 对话

---

#### 配合3：Animation + Devices

```verse
using { /Fortnite.com/Animation/PlayAnimation }
using { /Fortnite.com/Devices }

# 按钮触发角色动画
button_device := class(creative_device):
    @editable
    TargetCharacter:fort_character = fort_character{}
    
    @editable
    TriggerAnimation:animation_sequence = animation_sequence{}
    
    @editable
    ButtonDevice:button_device = button_device{}
    
    OnBegin<override>()<suspends>:void=
        ButtonDevice.InteractedWithEvent.Subscribe(OnButtonPressed)
    
    OnButtonPressed(Agent:agent):void=
        spawn{PlayAnimationOnTrigger()}
    
    PlayAnimationOnTrigger()<suspends>:void=
        if (Controller := TargetCharacter.GetPlayAnimationController[]):
            Controller.PlayAndAwait(TriggerAnimation)
```

---

#### 配合4：Animation + SceneGraph

```verse
using { /Fortnite.com/Animation/PlayAnimation }
using { /Verse.org/SceneGraph }

# 在特定位置播放角色动画
TeleportAndPlayAnimation(
    Character:fort_character,
    TargetPos:vector3,
    TargetRot:rotation,
    Anim:animation_sequence
)<suspends>:void=
    # 传送到目标位置
    Character.TeleportTo(TargetPos, TargetRot)
    
    # 等待传送完成（短暂延迟）
    Sleep(0.1)
    
    # 播放动画
    if (Controller := Character.GetPlayAnimationController[]):
        Controller.PlayAndAwait(Anim)
```

---

### 6.4 调试技巧

#### 技巧1：动画状态日志

```verse
# 创建带日志的动画播放器
PlayAnimationWithLogging(
    Character:fort_character,
    Anim:animation_sequence,
    AnimName:string
)<suspends>:void=
    Print("开始播放动画: {AnimName}")
    
    if (Controller := Character.GetPlayAnimationController[]):
        Instance := Controller.Play(Anim)
        
        # 并发监听所有事件
        race:
            block:
                Instance.BlendedInEvent.Await()
                Print("[{AnimName}] 混入完成")
            block:
                Instance.BlendingOutEvent.Await()
                Print("[{AnimName}] 开始混出")
            block:
                Instance.CompletedEvent.Await()
                Print("[{AnimName}] 播放完成")
            block:
                Instance.InterruptedEvent.Await()
                Print("[{AnimName}] 被中断")
            block:
                Result := Instance.Await()
                Print("[{AnimName}] 最终结果: {Result}")
```

---

#### 技巧2：动画状态检查工具

```verse
# 诊断角色动画状态
DiagnoseAnimationState(Character:fort_character):void=
    if (Controller := Character.GetPlayAnimationController[]):
        Print("✅ 控制器获取成功")
        
        # 这里无法直接查询当前播放的动画
        # 需要在播放时保存 Instance 引用
    else:
        Print("❌ 控制器获取失败 - 角色可能已被消灭或无效")
```

**注意**：

- `play_animation_controller` 不提供"当前播放动画"查询方法
- 需要在代码层面维护动画状态（见后续状态机模式）

---

## 7. 参考资源

### 7.1 官方文档

| 文档 | 链接/路径 |
|------|----------|
| Fortnite API Digest | `skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md` (第11700-11850行) |
| Verse.org Assets 模块 | `skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md` |
| Animation 模块研究报告 | `skills/programming/verseDev/shared/references/api-modules-research.md` |

---

### 7.2 相关API模块

| 模块 | 关系 | 说明 |
|------|------|------|
| `/Fortnite.com/Characters` | 密切相关 | 提供 `fort_character` 接口，是动画的载体 |
| `/Verse.org/Assets` | 依赖 | 提供 `animation_sequence` 资源类型 |
| `/Fortnite.com/Devices/CreativeAnimation` | 姊妹模块 | 用于道具动画，API 设计完全不同 |
| `/Fortnite.com/Game` | 配合使用 | 提供 `stasis_args` 等游戏状态控制 |
| `/Verse.org/Concurrency` | 配合使用 | 提供 `race`、`spawn` 等并发控制 |

---

### 7.3 重要概念对比

#### Animation vs CreativeAnimation

| 对比项 | `/Fortnite.com/Animation` | `/Fortnite.com/Devices/CreativeAnimation` |
|--------|---------------------------|------------------------------------------|
| **适用对象** | `fort_character` （角色） | `creative_prop` （道具） |
| **动画类型** | 骨骼动画序列 | 关键帧位移/旋转/缩放 |
| **控制方式** | `play_animation_controller` | `animation_controller` |
| **资源类型** | `animation_sequence` | `[]keyframe_delta` |
| **混合支持** | ✅ BlendIn/BlendOut | ✅ Bezier 插值 |
| **循环模式** | PlayCount 参数 | OneShot/PingPong/Loop 枚举 |

**选择指南**：

- 🎭 播放角色动作 → 使用 `Animation`
- 📦 移动/旋转道具 → 使用 `CreativeAnimation`
- 🚪 门/机关动画 → 使用 `CreativeAnimation`
- 🎬 过场剧情 → 根据对象类型选择

---

### 7.4 扩展阅读

**推荐学习路径**：

1. **基础阶段**：
   - 阅读 `fort_character` 文档，理解角色接口
   - 学习 Verse 的 `<suspends>` 和协程机制
   - 掌握 `if-then-else` 的 `<decides>` 模式

2. **进阶阶段**：
   - 研究 `race` 和 `sync` 并发控制
   - 学习 `option` 类型和 `?` 语法
   - 探索 `listenable` 事件机制

3. **高级阶段**：
   - 设计基于状态机的动画管理系统
   - 结合 `stasis` 实现复杂的角色控制
   - 优化动画资源加载和切换性能

---

## 8. 附录

### 8.1 完整类型签名速查

```verse
# 获取控制器
(InCharacter:fort_character).GetPlayAnimationController()<transacts><decides>:play_animation_controller

# 控制器接口
play_animation_controller := interface:
    PlayAndAwait(animation_sequence, ?float, ?float, ?float, ?float, ?float)<suspends>:play_animation_result
    Play(animation_sequence, ?float, ?float, ?float, ?float, ?float):play_animation_instance

# 动画实例
play_animation_instance := class:
    GetState()<transacts>:play_animation_state
    Stop():void
    Await()<suspends>:play_animation_result
    IsPlaying()<transacts><decides>:void
    CompletedEvent:listenable(tuple())
    InterruptedEvent:listenable(tuple())
    BlendedInEvent:listenable(tuple())
    BlendingOutEvent:listenable(tuple())

# 枚举类型
play_animation_result := enum { Completed, Interrupted, Error }
play_animation_state := enum { BlendingIn, Playing, BlendingOut, Completed, Stopped, Interrupted, Error }
```

---

### 8.2 常见错误代码对照

| 错误现象 | 可能原因 | 解决方案 |
|---------|---------|---------|
| `GetPlayAnimationController` 失败 | 角色已被消灭 | 先检查 `Character.IsActive()` |
| `PlayAndAwait` 返回 `Error` | 动画资源无效 | 检查 UEFN 中的资源设置 |
| 动画不混合 | BlendTime 为 0 | 设置合理的混合时间（0.1-0.3） |
| 动画循环不流畅 | 使用 loop 播放 | 使用 `PlayCount := 999.0` |
| 动画突然停止 | 被新动画打断 | 监听 `InterruptedEvent` 排查 |
| 角色卡死不动 | `PlayAndAwait` 永久挂起 | 检查动画资源和角色有效性 |

---

### 8.3 版本兼容性说明

**当前文档基于**：

- UEFN 版本：最新稳定版（基于 API Digest）
- Verse 语言版本：当前标准规范

**已知变更**：

- 早期版本可能不支持 `BlendedInEvent` 和 `BlendingOutEvent`
- `PlayCount` 参数在早期版本可能为整数类型

**兼容性建议**：

- 优先使用核心 API（`PlayAndAwait`、`Play`、`Stop`）
- 高级功能（如事件）使用前测试兼容性
- 关注 UEFN 更新日志中的 Animation 模块变更

---

### 8.4 调研总结

**本次调研发现的关键信息**：

1. ✅ Animation 模块设计简洁，API 数量少但功能完整
2. ✅ 异步机制（`<suspends>`）是核心设计理念
3. ⚠️ 模块能力边界清晰：**仅支持角色，不支持道具**
4. ⚠️ **无法查询当前播放的动画**，需自行维护状态
5. ✅ 事件系统完善，支持精确的生命周期控制

**开发者注意事项**：

- 🚨 **区分 Animation 和 CreativeAnimation**，它们完全不同
- 🚨 **动画资源必须预先准备**，无法运行时创建
- 🚨 **一次只能播放一个动画**，新动画会中断旧动画
- ✅ 善用 `race` 实现并发事件监听
- ✅ 使用 `option` 类型处理控制器和实例的可选性

---

**文档版本**：v1.0  
**更新日期**：2026-01-04  
**调研人员**：GitHub Copilot Agent  
**审核状态**：待审核
