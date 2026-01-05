# 已知限制与 FAQ

> **调研日期**: 2026-01-05
>
> **调研目标**: 整理 SceneGraph 的已知限制、常见坑点及绕过方案

---

## 一、核心限制

### 🔴 发布限制（最重要）

**限制**: 使用 SceneGraph 的项目无法发布到 Fortnite

**原因**:

- SceneGraph 是 Beta 功能
- Epic Games 正在验证稳定性和兼容性
- 未来可能解除限制

**影响**:

- ❌ 无法发布到 Fortnite Creative 供玩家游玩
- ✅ 可用于学习、原型开发、内部测试

**绕过方案**:

1. **发布前禁用**: 在项目设置中禁用 SceneGraph，改用 Device
2. **等待 Epic 解除限制**: 关注官方公告
3. **混合架构**: 开发时用 SG，发布前迁移到 Device

**官方说明**: [SceneGraph 概述](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)

---

### ⚠️ 玩家管理限制

**限制**: 无法直接获取玩家列表（无 `GetPlayers()` API）

**影响**:

- ❌ 无法遍历所有玩家
- ❌ 无法直接查询玩家数量

**绕过方案**:

#### 方案 1: 通过 Device 事件获取玩家**

```verse
# 监听 Device 发送的玩家生成事件
player_tracker_component := class(component):
    var Players<private>:[]agent = array{}

    OnReceive<override>(Event:scene_event):logic =
        if (SpawnEvent := Event?player_spawned_event):
            AddPlayer(SpawnEvent.Player)
            return true
        else if (DespawnEvent := Event?player_despawned_event):
            RemovePlayer(DespawnEvent.Player)
            return true
        return false

    AddPlayer(Player:agent):void =
        set Players += Player

    RemovePlayer(Player:agent):void =
        set Players = Players.RemoveElement(Player)

    GetAllPlayers():[]agent = Players
```text

#### 方案 2: 通过碰撞检测发现玩家**

```verse
# 使用大范围的触发区域
player_detector_component := class(component):
    var DiscoveredPlayers<private>:map(agent, logic) = map{}

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        spawn:
            DetectionLoop()

    DetectionLoop()<suspends>:void =
        loop:
            Sleep(1.0)  # 每秒检测

            if (Owner := GetOwner()):
                Hits := Owner.FindOverlapHits()
                for (Hit : Hits):
                    if (HitAgent := Hit.HitAgent?):
                        if:
                            set DiscoveredPlayers[HitAgent] = true

    GetDiscoveredPlayers():[]agent =
        return DiscoveredPlayers.Keys()
```text

---

### ⚠️ UI 限制

**限制**: 无法创建 UI 界面（无 UI API）

**影响**:

- ❌ 无法显示 HUD、菜单、按钮
- ❌ 无法显示文本消息

**绕过方案**:

**使用 Device**:

- `hud_message_device` - 显示文本消息
- `billboard_device` - 显示浮动文本
- `canvas_device` - 显示自定义 UI

**混合方案**:

```verse
# SceneGraph 组件通知 Device 更新 UI
ui_notifier_component := class(component):
    ShowMessage(Message:string):void =
        if (Owner := GetOwner()):
            Event := show_message_event{Message := Message}
            Owner.SendUp(Event)  # Device 监听

show_message_event := class<concrete>(scene_event):
    var Message:string
```text

---

### ⚠️ 音频限制

**限制**: 无法播放音效或音乐（无音频 API）

**绕过方案**: 使用 `audio_player_device`

---

### ⚠️ 输入限制

**限制**: 无法获取玩家输入（键盘、鼠标、手柄）

**绕过方案**: 使用 `input_trigger_device`

---

### ⚠️ 资源加载限制

**限制**: 无法动态加载资源（Mesh、材质、音频）

**影响**:

- ❌ 无法在运行时加载外部资源
- ✅ 所有资源必须在编辑器中预配置

**绕过方案**:

1. **预配置**: 在编辑器中配置所有需要的资源
2. **使用 Prefab**: 通过 Prefab 复用资源组合
3. **对象池**: 预创建实体，运行时复用

---

### ⚠️ 网络同步限制

**限制**: 无原生网络复制支持

**影响**:

- ❌ 实体/组件数据不自动同步到客户端
- ⚠️ 需依赖 Fortnite 底层网络系统

**绕过方案**:

- 依赖 Fortnite 的内置同步机制（不明确）
- 使用 Device 提供的网络功能

---

### ⚠️ 持久化限制

**限制**: 无法保存数据到磁盘或云端

**影响**:

- ❌ 游戏会话结束后数据丢失
- ❌ 无法实现存档功能

**绕过方案**:

- 使用 `accolades_device` 实现成就系统
- 通过外部服务（如 Epic Online Services）

---

## 二、性能限制

### ⚠️ OnSimulate 性能

**问题**: OnSimulate 每帧调用，复杂逻辑会导致性能问题

**影响**:

- 🔴 每帧执行复杂计算会降低帧率
- 🔴 大量组件同时执行 OnSimulate 会卡顿

**最佳实践**:

```verse
# ❌ 避免：每帧复杂计算
OnSimulate<override>():void =
    for (i := 0..999):
        ComplexCalculation()  # 每帧执行！

# ✅ 推荐：使用定时器
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)
    spawn:
        loop:
            Sleep(1.0)  # 每秒一次
            for (i := 0..999):
                ComplexCalculation()
```text

---

### ⚠️ 深层嵌套性能

**问题**: 过深的实体层级会影响事件传播性能

**影响**:

- 🔴 SendDown 递归所有子孙实体
- 🔴 GetParent 向上遍历所有祖先

**推荐深度**: 3-4 层

**最佳实践**:

```verse
# ✅ 推荐：扁平化设计
Root
  ├─ GameManager
  ├─ Player1
  ├─ Player2
  └─ Enemy1

# ❌ 避免：过深嵌套
Root
  └─ Level1
      └─ Level2
          └─ Level3
              └─ Level4
                  └─ Level5  # 太深！
```text

---

### ⚠️ 频繁事件广播

**问题**: 频繁 SendDown 会递归所有子实体

**影响**:

- 🔴 性能开销大
- 🔴 事件风暴

**最佳实践**:

```verse
# ❌ 避免：每帧广播
OnSimulate<override>():void =
    if (Owner := GetOwner()):
        Owner.SendDown(tick_event{})  # 灾难！

# ✅ 推荐：降低频率或使用 SendDirect
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)
    spawn:
        loop:
            Sleep(1.0)  # 每秒一次
            if (Owner := GetOwner()):
                Owner.SendDown(update_event{})
```text

---

## 三、常见陷阱

### 🐛 陷阱 1: 忘记 Sleep(0.0)

**问题**: OnBeginSimulation 缺少 Sleep(0.0)

**影响**:

- ❌ 其他组件可能未准备好
- ❌ GetComponent 可能失败

**解决方案**:

```verse
# ✅ 正确
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # 必须！
    # 现在可以安全访问其他组件
```text

---

### 🐛 陷阱 2: 组件引用失效

**问题**: 保存的组件引用在组件被销毁后失效

**示例**:

```verse
# ❌ 危险
var HealthComp:?health_component = false

OnAddedToScene<override>()<suspends>:void =
    if (Owner := GetOwner()):
        if (Comp := Owner.GetComponent[health_component]()):
            set HealthComp = option{Comp}

# 如果 HealthComp 被移除，引用失效
DealDamage(Amount:int):void =
    if (Comp := HealthComp?):
        Comp.TakeDamage(Amount)  # 可能崩溃
```text

**解决方案**:

```verse
# ✅ 正确：每次查询
DealDamage(Amount:int):void =
    if (Owner := GetOwner()):
        if (Comp := Owner.GetComponent[health_component]()):
            Comp.TakeDamage(Amount)
```text

---

### 🐛 陷阱 3: 协程闭包陷阱

**问题**: 循环变量在协程中被捕获

**示例**:

```verse
# ❌ 错误
for (i := 0..9):
    spawn:
        Sleep(1.0)
        Print("Index: {i}")  # 所有协程可能打印相同值

# ✅ 正确
for (i := 0..9):
    Index := i  # 创建副本
    spawn:
        Sleep(1.0)
        Print("Index: {Index}")
```text

---

### 🐛 陷阱 4: 无法停止协程

**问题**: Verse 无法主动停止协程

**示例**:

```verse
# ❌ 错误：无法停止
spawn:
    loop:
        Sleep(1.0)
        DoWork()  # 永远执行

# ✅ 正确：使用标志位
var IsRunning:logic = true

spawn:
    loop:
        if not IsRunning:
            break
        Sleep(1.0)
        DoWork()

# 停止协程
set IsRunning = false
```text

---

### 🐛 陷阱 5: RemoveFromParent 递归销毁

**问题**: RemoveFromParent 会递归销毁所有子实体和组件

**影响**:

- ⚠️ 子实体也会被销毁
- ⚠️ 所有组件的 OnDestroy 被调用

**解决方案**:

```verse
# 如果只想移除父子关系而不销毁
# 需要先将子实体移到其他父实体

# 保存子实体
Children := ParentEntity.GetEntities()

# 移除父实体（子实体也会被销毁！）
ParentEntity.RemoveFromParent()

# 如果需要保留子实体，先重新父化
OtherParent.AddEntities(Children)  # 移到其他父实体
```text

---

### 🐛 陷阱 6: 事件消耗误解

**问题**: 误以为返回 `true` 会阻止同实体内其他组件接收

**实际行为**:

- ✅ 同实体内所有组件都会收到
- ✅ 返回 `true` 只影响跨实体传播

**正确理解**:

```verse
# Entity A 有 2 个组件

# 组件 1
component_a := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("A received")
            return true  # 消耗事件

# 组件 2：仍然会收到！
component_b := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("B received")  # 仍然执行
            return false
```text

---

## 四、已知 Bug（截至 2026-01-05）

### 🐛 Bug 1: GetComponent 偶尔失败

**描述**: GetComponent 在某些情况下返回失败，即使组件存在

**复现条件**:

- OnBeginSimulation 中缺少 Sleep(0.0)
- 组件刚添加到实体

**解决方案**:

- 始终在 OnBeginSimulation 第一行添加 Sleep(0.0)
- 如果仍失败，添加额外的 Sleep(0.1)

---

### 🐛 Bug 2: 事件传播顺序不确定

**描述**: 同实体内组件接收事件的顺序不确定

**影响**:

- ⚠️ 不能依赖特定的接收顺序

**解决方案**:

- 不依赖组件接收顺序
- 如需顺序，通过事件链实现

---

## 五、FAQ

### Q1: SceneGraph 何时可以发布？

**答**: 未知。Epic Games 未给出明确时间表。关注官方公告。

---

### Q2: 可以混用 SceneGraph 和 Device 吗？

**答**: 可以。推荐混合架构：

- SceneGraph 管理游戏逻辑
- Device 处理玩家交互（输入、UI、音频）

---

### Q3: SceneGraph 支持多人游戏吗？

**答**: 理论上支持，但网络同步机制不明确。需实际测试。

---

### Q4: 如何调试 SceneGraph 代码？

**答**:

1. 使用 `Print()` 输出日志
2. 在组件生命周期方法中添加日志
3. 监控事件传播（在 OnReceive 中打印）

```verse
OnReceive<override>(Event:scene_event):logic =
    Print("[{GetType()}] Received: {Event.GetType()}")
    # 处理逻辑...
```text

---

### Q5: 为什么 OnBeginSimulation 必须 Sleep(0.0)？

**答**: 延迟一帧确保：

1. 引擎内部初始化完成
2. 所有组件的 OnAddedToScene 已执行
3. 组件间引用已建立

---

### Q6: 可以在 OnSimulate 中使用 Sleep 吗？

**答**: 不可以。OnSimulate 不支持 `<suspends>`。

---

### Q7: 如何实现单例组件？

**答**:

```verse
singleton_component := class(component):
    var Instance<private>:?singleton_component = false

    OnAddedToScene<override>()<suspends>:void =
        if (Inst := Instance?):
            # 已存在，销毁当前实例
            if (Owner := GetOwner()):
                Owner.RemoveFromParent()
        else:
            set Instance = option{Self}

    GetInstance<public>()<decides>:singleton_component =
        if (Inst := Instance?):
            return Inst
        Fail()
```text

---

### Q8: 如何在组件中获取时间？

**答**: Verse 无内置时间 API。需自行实现：

```verse
timer_component := class(component):
    var ElapsedTime<private>:float = 0.0

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        spawn:
            loop:
                Sleep(0.1)
                set ElapsedTime += 0.1

    GetTime():float = ElapsedTime
```text

或使用全局时间管理器单例。

---

### Q9: 可以在运行时添加/移除组件吗？

**答**: 可以，但不推荐频繁操作。

```verse
# 添加组件
Entity.AddComponents(array{new_component{}})

# 移除组件（需移除整个实体）
# Verse 无直接移除组件的 API
```text

---

### Q10: 如何优化大量实体的性能？

**答**:

1. **对象池**: 复用实体而非频繁创建/销毁
2. **扁平化**: 避免过深的层级嵌套
3. **降低频率**: 使用定时器代替 OnSimulate
4. **批量处理**: 减少事件广播次数

---

## 六、临时绕过方案总结

| 限制 | 临时绕过方案 |
|------|-------------|
| **无法发布** | 发布前禁用 SG 或等待 Epic 解除 |
| **无玩家 API** | 通过 Device 事件获取玩家 |
| **无 UI** | 使用 hud_message_device |
| **无音频** | 使用 audio_player_device |
| **无输入** | 使用 input_trigger_device |
| **无持久化** | 使用 accolades_device 或外部服务 |
| **性能问题** | 降低频率、扁平化、对象池 |

---

## 七、推荐开发流程

1. **原型阶段**: 使用 SceneGraph 快速迭代
2. **测试阶段**: 验证逻辑和性能
3. **发布准备**:
   - 选项 A: 禁用 SG，迁移到 Device
   - 选项 B: 等待 Epic 解除发布限制
4. **发布后**: 根据反馈优化

---

**更新日志**:

- 2026-01-05: 初始版本，基于官方文档和社区反馈
