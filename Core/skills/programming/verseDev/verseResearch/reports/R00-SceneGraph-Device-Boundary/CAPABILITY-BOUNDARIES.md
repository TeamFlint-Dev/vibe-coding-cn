# SceneGraph 能力边界文档

> **版本**: 1.0 | **更新日期**: 2026-01-05
>
> **目标**: 明确 SceneGraph 在 UEFN 环境下的原生能力和边界，无需 Device 即可实现的功能范围

---

## 能力速查矩阵

### 能做的事（绿灯区）

| 类别 | 具体能力 | API 支持 | 验证来源 |
|------|----------|----------|----------|
| **实体管理** | 创建、销毁、层级化组织实体 | `entity`, `AddEntities()`, `RemoveFromParent()` | [官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity) |
| **组件系统** | 自定义组件、挂载/卸载、生命周期管理 | `component`, `AddComponents()`, `GetComponent<T>()` | [官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component) |
| **事件通信** | SendUp/SendDown/SendDirect 三种传播 | `SendUp()`, `SendDown()`, `SendDirect()`, `OnReceive()` | [官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite) |
| **异步流程** | spawn 协程、Sleep 延迟、race 竞态 | `spawn{}`, `Sleep()`, `race{}`, `sync{}` | Verse 语言特性 |
| **空间查询** | 碰撞检测、Overlap 查询、Sweep 扫描 | `FindOverlapHits()`, `FindSweepHits()` | [Verse API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg) |
| **变换操作** | 位置、旋转、缩放控制 | `transform_component`, `GetPosition()`, `SetPosition()` | SceneGraph API |
| **层级遍历** | 父子关系查询、树形结构导航 | `GetParent()`, `GetEntities()`, `GetComponents()` | entity API |
| **数据容器** | array、map、option、集合操作 | Verse 标准库 | Verse 语言特性 |
| **生命周期** | OnAddedToScene/OnBeginSimulation/OnSimulate/OnDestroy | 组件生命周期方法 | component API |
| **Prefab** | 预制件实例化、复用实体组合 | UEFN 编辑器 + SceneGraph | [Getting Started](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite) |

### 不能做的事（红灯区）

| 类别 | 限制说明 | 原因 | 替代方案 |
|------|----------|------|----------|
| **发布限制** | ⚠️ **使用 SceneGraph 的项目无法发布** | Beta 功能限制 | 等待 Epic 解除限制或发布前禁用 SG |
| **玩家输入** | 无法直接获取玩家输入（键盘、鼠标、手柄） | 需要 Device 支持 | 使用 `input_trigger_device` |
| **UI 显示** | 无法创建 UI 界面、HUD、菜单 | 需要 Device 支持 | 使用 `hud_message_device`, `canvas_device` |
| **游戏规则** | 无法设置回合、得分、胜利条件 | 需要 Device 支持 | 使用 `end_game_device`, `score_manager_device` |
| **资源加载** | 无法动态加载外部资源（Mesh、材质、音频） | 资源需预定义 | 通过编辑器预配置或使用 Device |
| **网络同步** | 无原生网络复制支持 | 需要自行管理 | 依赖 Fortnite 底层网络系统 |
| **持久化** | 无法保存数据到磁盘或云端 | 无持久化 API | 使用 `accolades_device` 或外部服务 |
| **物理模拟** | 无法创建物理约束、关节 | 需要 Device 支持 | 使用 `physics_device` |
| **动画控制** | 无法播放骨骼动画、Montage | 需要 Device 支持 | 使用 `animation_controller_device` |
| **音频播放** | 无法播放音效、背景音乐 | 需要 Device 支持 | 使用 `audio_player_device` |

### 有条件能做的事（黄灯区）

| 类别 | 条件 | 实现方式 | 适用场景 |
|------|------|----------|----------|
| **玩家追踪** | 需要从外部获取 `agent` 引用 | 通过 Device 事件或 Prefab 参数传入 | 获取后可在 SG 内追踪 |
| **伤害系统** | 需要 `damage()` 函数（需要 agent） | 通过组件封装逻辑，外部提供 agent | 自定义生命值系统 |
| **计时器** | 通过异步流程实现 | `spawn{ loop: Sleep(Interval); Tick() }` | 游戏循环、定时事件 |
| **状态机** | 通过组件 + 事件实现 | 组件存储状态，事件触发转换 | AI 状态、游戏阶段 |
| **对象池** | 通过数组管理实体 | `var EntityPool:[]entity` | 优化生成/销毁性能 |
| **事件总线** | 通过根实体广播 | `SimulationEntity.SendDown(Event)` | 全局通知 |

---

## 关键能力详解

### 1. 实体与组件系统

### ✅ 完全支持

- **实体创建**: 可运行时创建自定义 entity 类实例
- **层级管理**: 支持任意深度的父子关系（但不推荐过深）
- **组件挂载**: 动态添加/移除组件
- **生命周期**: 完整的生命周期钩子（OnAddedToScene → OnBeginSimulation → OnSimulate → OnDestroy）

**示例**:

```verse
# 创建自定义实体类
game_manager_entity := class(entity):
    var GameState<private>:game_state = game_state.Waiting

    Initialize():void =
        AddComponents(array{
            round_timer_component{},
            score_tracker_component{},
            state_machine_component{}
        })

# 运行时创建
Manager := game_manager_entity{}
Manager.Initialize()
SimulationRoot.AddEntities(array{Manager})
```text

### 2. 事件系统

### ✅ 完全支持

- **三种传播**: SendUp（子→父）、SendDown（父→子）、SendDirect（点对点）
- **自定义事件**: 继承 `scene_event` 定义任意数据结构
- **事件消耗**: 同实体内所有组件都收到事件，跨实体可被消耗

**示例**:

```verse
# 定义事件
player_scored_event := class<concrete>(scene_event):
    var Player:agent
    var Points:int

# 发送事件（向上报告）
scoring_zone_component := class(component):
    OnPlayerEnter(Player:agent):void =
        if (Owner := GetOwner()):
            Owner.SendUp(player_scored_event{Player := Player, Points := 100})

# 接收事件
score_tracker_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (ScoreEvent := Event?player_scored_event):
            UpdateScore(ScoreEvent.Player, ScoreEvent.Points)
            return true
        return false
```text

### 3. 异步机制

### ✅ 完全支持

- **spawn**: 创建并发协程，不阻塞主流程
- **Sleep**: 延迟执行（秒为单位）
- **race**: 竞态执行，首个完成即返回
- **sync**: 等待所有协程完成

**示例**:

```verse
# 定时器实现
timer_component := class(component):
    var IsRunning<private>:logic = false
    var ElapsedTime<private>:float = 0.0

    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 必须！官方推荐
        StartTimer()

    StartTimer()<suspends>:void =
        IsRunning = true
        spawn:
            loop:
                if not IsRunning:
                    break
                Sleep(0.1)
                ElapsedTime += 0.1
                CheckTimeout()
```text

### 4. 数据结构

### ✅ 部分支持

**原生支持**:

- `array<T>`: 动态数组
- `map<K, V>`: 键值对字典
- `option<T>`: 可选值
- `generator<T>`: 生成器（惰性序列）
- 基础类型: `int`, `float`, `string`, `logic`, `vector3`, `rotation`

**不支持**:

- Set（集合）: 需自行用 `map<T, logic>` 模拟
- 多线程安全容器: Verse 无多线程概念

**玩家追踪示例**:

```verse
# 追踪所有玩家
player_tracker_component := class(component):
    var Players<private>:[]agent = array{}
    var PlayerData<private>:map(agent, player_data) = map{}

    AddPlayer(Player:agent):void =
        set Players += Player
        if:
            set PlayerData[Player] = player_data{Health := 100, Score := 0}

    RemovePlayer(Player:agent):void =
        set Players = Players.RemoveElement(Player)
        if:
            set PlayerData = PlayerData.RemoveKey(Player)
```text

---

## 典型 UseCase（无需 Device）

### ✅ 可独立实现的场景

| 场景 | 实现方式 | 核心组件 |
|------|----------|----------|
| **对象生成系统** | 定时器 + 实体池 | spawn + array 管理 |
| **碰撞检测** | FindOverlapHits + 事件通知 | 空间查询 API |
| **状态机** | 组件存储状态 + 事件驱动转换 | OnReceive + 状态枚举 |
| **计时器** | spawn + Sleep 循环 | 异步流程 |
| **层级管理** | 父子实体嵌套 | AddEntities + GetParent |
| **事件总线** | 根实体广播 | SendDown 全局通知 |
| **数据同步** | 事件 + map 存储 | 自定义数据组件 |
| **AI 行为树** | 组件 + 状态机 + 定时器 | 组合上述机制 |

### ❌ 必须使用 Device 的场景

| 场景 | 原因 | 需要的 Device |
|------|------|---------------|
| **玩家输入** | 无输入 API | `input_trigger_device` |
| **UI 显示** | 无 UI API | `hud_message_device`, `billboard_device` |
| **音效播放** | 无音频 API | `audio_player_device` |
| **回合规则** | 无游戏规则 API | `end_game_device`, `round_settings_device` |
| **得分统计** | 无得分 API | `score_manager_device` |
| **物品生成** | 无物品 API | `item_spawner_device` |
| **玩家传送** | 无传送 API | `teleporter_device` |
| **伤害系统** | 需要 agent 引用 | `damage_volume_device` 获取 agent |

---

## 已知限制与警告

### 🔴 核心限制

1. **发布限制（最重要）**
   - SceneGraph 是 Beta 功能
   - **使用 SceneGraph 的项目无法发布到 Fortnite**
   - Epic 正在验证稳定性，未来可能解除

2. **无原生玩家管理**
   - 无法直接获取 `GetPlayers()` 等 API
   - 需要通过 Device 事件（如 `player_spawned_event`）获取 agent 引用
   - 获取后可在 SceneGraph 内自行追踪

3. **无 UI 支持**
   - 无法创建按钮、面板、HUD
   - 所有 UI 必须通过 Device 实现

4. **资源限制**
   - 无法动态加载 Mesh、材质、音频
   - 所有资源必须在编辑器中预配置

### ⚠️ 性能警告

1. **OnSimulate 开销**
   - 每帧调用，避免复杂计算
   - 推荐用 spawn + Sleep 实现定时逻辑

2. **深层嵌套**
   - 过深的实体层级影响性能
   - 推荐扁平化设计或限制在 3-4 层

3. **事件风暴**
   - SendDown 会递归所有子实体
   - 避免频繁广播大量事件

### 💡 最佳实践

1. **Sleep(0.0) 必须**
   - OnBeginSimulation 第一行必须 `Sleep(0.0)`
   - 延迟一帧确保引擎初始化完成

2. **组件单一职责**
   - 每个组件只做一件事
   - 通过事件解耦通信

3. **混合架构**
   - 复杂系统用自定义 Entity 类封装
   - 简单对象用纯组件方式

---

## 边界验证来源

| 能力 | 验证方式 | 文档链接 |
|------|----------|----------|
| 实体/组件 API | 官方 API 文档 | [entity](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity), [component](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component) |
| 事件系统 | 官方教程 | [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite) |
| 异步机制 | Verse 语言规范 | Verse 语言特性 |
| 发布限制 | 官方文档警告 | [SceneGraph 概述](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite) |
| Device 依赖 | 设备系统调研 | [UEFN 设备系统调研](../../shared/references/uefn-device-system-research.md) |

---

## 快速决策流程图

```text
需求：实现某功能
    │
    ▼
是否涉及玩家输入/UI/音频/物理？
    │
    ├─ 是 → 必须使用 Device
    │
    └─ 否 → 检查下一步
         │
         ▼
    是否需要游戏规则（回合、得分）？
         │
         ├─ 是 → 必须使用 Device
         │
         └─ 否 → 检查下一步
              │
              ▼
         是否需要动态加载资源？
              │
              ├─ 是 → 必须使用 Device
              │
              └─ 否 → ✅ 可用 SceneGraph 独立实现
```text

---

## 待验证的未知区

| 类别 | 不确定的能力 | 验证方法 |
|------|--------------|----------|
| 网络同步 | 多人游戏下实体同步行为 | 实际测试 |
| 性能上限 | 大量实体/组件的性能表现 | 压力测试 |
| 跨 Prefab 通信 | Prefab 实例间事件传播 | 实验验证 |
| Device 交互 | SG 与 Device 的混合使用模式 | 案例研究 |

---

**更新日志**:

- 2026-01-05: 初始版本，基于官方文档和现有参考资料整理
