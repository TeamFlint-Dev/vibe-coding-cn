# Verse.org/SceneGraph 模块深度调研

> **文档类型**: API 模块调研报告  
> **模块路径**: `/Verse.org/SceneGraph`  
> **目标**: 消除误解,建立准确的 API 能力参考  
> **最后更新**: 2026-01-04

---

## 目录

1. [模块概述](#模块概述)
2. [核心类/接口清单](#核心类接口清单)
3. [关键API详解](#关键api详解)
4. [代码示例](#代码示例)
5. [常见误区澄清](#常见误区澄清)
6. [最佳实践](#最佳实践)
7. [参考资源](#参考资源)

---

## 模块概述

### 模块用途

**Verse.org/SceneGraph** 是 UEFN (Unreal Editor for Fortnite) 中的**实体-组件系统 (Entity-Component System, ECS)** 核心模块,提供场景图架构和组件化开发能力。

**设计理念**:
- **场景图 (Scene Graph)**: 场景中的所有对象都是 Entity,形成树形层级结构
- **组件化 (Component-Based)**: 功能通过可复用的 Component 实现,而非继承
- **事件驱动 (Event-Driven)**: 使用 Scene Events 实现解耦通信
- **运行时灵活性**: 支持动态添加/移除实体和组件

**Beta 状态提示** (⚠️ 重要):
- SceneGraph 目前是 **Beta 功能**
- 使用 SceneGraph 的项目**发布前需要禁用该功能**,否则可能影响发布
- Epic Games 正在验证稳定性,未来可能解除限制

**官方文档**:
- [Scene Graph in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Getting Started in Scene Graph](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite)
- [Known Issues](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite)

### 适用场景

**推荐使用场景**:
- ✅ **RPG 游戏**: 玩家、NPC、装备系统
- ✅ **模拟游戏**: 建筑系统、资源管理
- ✅ **策略游戏**: 单位管理、技能系统
- ✅ **需要复杂层级结构的项目**: 电梯系统、移动基地
- ✅ **需要高度模块化的项目**: 多人协作、快速迭代

**不推荐使用场景**:
- ❌ **简单的线性游戏**: 过度设计,增加复杂度
- ❌ **需要立即发布的项目**: Beta 功能限制
- ❌ **性能极敏感的场景**: 事件传播有一定开销

---

## 核心类/接口清单

### 按功能分类

#### 1. 核心架构类

| 类名 | 功能 | 官方文档 |
|------|------|---------|
| `entity` | 场景图节点,可包含子实体和组件 | [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity) |
| `component` | 组件基类,封装功能和行为 | [component API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component) |
| `scene_event` | 事件基类,用于实体间通信 | [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite) |

#### 2. 变换和渲染组件

| 组件类型 | 功能 | 用途 |
|---------|------|------|
| `transform_component` | 管理位置、旋转、缩放 | 所有需要空间变换的实体 |
| `mesh_component` | 3D 网格渲染 | 显示 3D 模型 |
| `static_mesh_component` | 静态网格 | 不需要动画的 3D 对象 |
| `skeletal_mesh_component` | 骨骼网格 | 支持动画的角色/生物 |

#### 3. 光照组件

| 组件类型 | 功能 | 适用场景 |
|---------|------|---------|
| `light_component` | 光照基类 | - |
| `directional_light_component` | 方向光 | 太阳光、月光 |
| `sphere_light_component` | 球形光 | 灯泡、火把 |
| `capsule_light_component` | 胶囊光 | 荧光灯管 |
| `rect_light_component` | 矩形光 | 窗户光、屏幕光 |

#### 4. 物理和碰撞组件

| 类型 | 功能 | 说明 |
|------|------|------|
| `collision_channel` | 碰撞通道 | 定义物体可碰撞类型 |
| `collision_profile` | 碰撞配置文件 | 预定义的碰撞行为 |
| `overlap_hit` | 重叠检测结果 | 存储碰撞检测数据 |
| `collision_query_params` | 碰撞查询参数 | 配置碰撞检测行为 |

**内置碰撞通道** (来自 `CollisionChannels` 模块):
- `stationary` - 静态物体通道
- `dynamic` - 动态物体通道
- `avatar` - 角色通道
- `visibility` - 可见性通道
- `camera` - 相机通道
- `physics` - 物理通道

**内置碰撞配置** (来自 `CollisionProfiles` 模块):
- `StationaryIgnoreAll` - 静态物体,忽略所有碰撞
- `StationaryOverlapAll` - 静态物体,与所有重叠
- `StationaryBlockAll` - 静态物体,阻挡所有
- `DynamicIgnoreAll` - 动态物体,忽略所有
- `DynamicOverlapAll` - 动态物体,与所有重叠
- `DynamicBlockAll` - 动态物体,阻挡所有
- `StationaryBlockVisible` - 静态但可见(如玻璃、隐形墙)
- `VisibilityOverlapAll` - 用于可见性测试

#### 5. 交互和特效组件

| 组件类型 | 功能 | 使用场景 |
|---------|------|---------|
| `interactable_component` | 交互逻辑 | 按钮、开关、可拾取物品 |
| `particle_system_component` | 粒子效果 | 爆炸、火焰、魔法特效 |
| `audio_component` | 音频播放 | 背景音乐、音效 |

#### 6. 动画系统

| 模块/类 | 功能 | 说明 |
|---------|------|------|
| `KeyframedMovement` 模块 | 关键帧动画 | 使用关键帧驱动实体移动 |
| `easing_function` | 缓动函数基类 | 定义动画速度曲线 |
| `cubic_bezier_easing_function` | 贝塞尔缓动 | 自定义缓动曲线 |
| `linear_easing_function` | 线性缓动 | 匀速运动 |
| `ease_cubic_bezier_easing_function` | 平滑缓动 | 开始慢、中间快、结束慢 |
| `ease_in_cubic_bezier_easing_function` | 渐入缓动 | 开始慢、结束快 |

#### 7. 工具和辅助类

| 类型 | 功能 | 用途 |
|------|------|------|
| `guid` | 全局唯一标识符 | 实体/组件的唯一 ID |
| `transformation` | 空间变换数据 | 位置、旋转、缩放的组合 |

---

## 关键API详解

### Entity 类 API

#### 层级管理

##### GetParent()

**功能**: 获取实体的父实体

**签名**:
```verse
GetParent()<transacts><decides>:entity
```

**返回值**:
- 类型: `entity`
- 说明: 父实体。如果没有父实体则失败 (`<decides>`)

**使用限制**:
- ⚠️ 根实体 (Simulation Entity) 没有父实体,调用会失败
- ✅ 必须使用 `<decides>` 处理失败情况

**代码示例**:
```verse
# 向上遍历到根实体
GetRootEntity(CurrentEntity:entity)<decides>:entity =
    loop:
        if (Parent := CurrentEntity.GetParent[]):
            CurrentEntity = Parent
        else:
            # 到达根实体
            return CurrentEntity
```

**官方文档**: [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

---

##### AddEntities()

**功能**: 将实体添加为子实体 (自动处理重新父化)

**签名**:
```verse
AddEntities(Entities:[]entity)<transacts>:void
```

**参数**:
- `Entities` - 类型: `[]entity`,要添加的实体数组

**重要特性**:
- ✅ **自动重新父化**: 如果实体已有父实体,会自动从旧父实体移除
- ✅ **批量添加**: 支持一次添加多个实体
- ✅ **触发生命周期**: 会触发子实体的 `OnAddedToScene`

**代码示例**:
```verse
# 构建层级结构
BuildHierarchy():void =
    ParentEntity := entity{}
    Child1 := entity{}
    Child2 := entity{}
    
    # 批量添加子实体
    ParentEntity.AddEntities(array{Child1, Child2})
    
    # 重新父化示例
    AnotherParent := entity{}
    AnotherParent.AddEntities(array{Child1})  # Child1 自动从 ParentEntity 移除
```

**官方文档**: [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

---

##### RemoveFromParent()

**功能**: 从父实体中移除当前实体 (同时移除其所有组件和子实体)

**签名**:
```verse
RemoveFromParent()<transacts>:void
```

**重要特性**:
- ✅ **递归清理**: 会移除所有子实体和组件
- ✅ **触发生命周期**: 会触发 `OnRemovingFromScene` 和 `OnEndSimulation`
- ⚠️ **不可恢复**: 移除后实体无法直接恢复,需要重新添加

**代码示例**:
```verse
# 销毁实体
DestroyEntity(Entity:entity):void =
    # 会递归清理所有子实体和组件
    Entity.RemoveFromParent()
    Print("实体已从场景移除")
```

**官方文档**: [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

---

##### GetEntities()

**功能**: 获取所有子实体

**签名**:
```verse
GetEntities()<transacts>:[]entity
```

**返回值**:
- 类型: `[]entity`
- 说明: 子实体数组 (只返回直接子实体,不递归)

**注意事项**:
- ✅ 只返回直接子实体
- ✅ 返回的是数组副本,修改不影响原始数据

**代码示例**:
```verse
# 遍历所有子实体
IterateChildren(ParentEntity:entity):void =
    Children := ParentEntity.GetEntities()
    
    for (Child in Children):
        Print("子实体: {Child}")
        
        # 递归遍历孙子实体
        IterateChildren(Child)
```

**官方文档**: [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

---

#### 组件管理

##### AddComponents()

**功能**: 向实体添加组件

**签名**:
```verse
AddComponents(Components:[]component)<transacts>:void
```

**参数**:
- `Components` - 类型: `[]component`,要添加的组件数组

**重要限制**:
- ⚠️ **同类型唯一**: 一个实体只能有一个给定类型的组件或其子类
- ⚠️ **添加失败**: 如果类型冲突,添加会失败 (静默失败)

**代码示例**:
```verse
# 初始化游戏对象
CreateGameObject():entity =
    GameObject := entity{}
    
    # 批量添加组件
    GameObject.AddComponents(array{
        health_component{MaxHealth := 100},
        movement_component{Speed := 5.0},
        attack_component{Damage := 10}
    })
    
    return GameObject
```

**官方文档**: [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

---

##### GetComponent<T>()

**功能**: 获取指定类型的组件

**签名**:
```verse
GetComponent<T>()<transacts><decides>:T where T:subtype(component)
```

**参数**:
- `T` - 泛型类型: 要获取的组件类型

**返回值**:
- 类型: `T` (泛型)
- 说明: 找到的组件。如果不存在则失败 (`<decides>`)

**注意事项**:
- ✅ 使用泛型确保类型安全
- ✅ 使用 `<decides>` 处理组件不存在的情况
- ⚠️ 如果有多个子类,只返回第一个匹配的

**代码示例**:
```verse
# 获取并使用组件
UseHealthComponent(Entity:entity):void =
    if (HealthComp := Entity.GetComponent[health_component][]):
        CurrentHealth := HealthComp.GetHealth()
        Print("当前生命值: {CurrentHealth}")
    else:
        Print("没有生命值组件")
```

**官方文档**: [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

---

##### GetComponents()

**功能**: 获取所有组件

**签名**:
```verse
GetComponents()<transacts>:[]component
```

**返回值**:
- 类型: `[]component`
- 说明: 组件数组

**代码示例**:
```verse
# 列出所有组件
ListAllComponents(Entity:entity):void =
    Components := Entity.GetComponents()
    
    Print("组件列表:")
    for (Comp in Components):
        Print("  - {Comp}")
```

**官方文档**: [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

---

#### 事件发送

##### SendUp()

**功能**: 向上传播事件到父实体和祖先

**签名**:
```verse
SendUp(Event:scene_event):void
```

**传播路径**:
```
当前实体 → 父实体 → 祖父实体 → ... → Simulation Entity (根)
```

**使用场景**:
- 子实体向父实体报告
- 局部事件传递到全局管理器
- 实现责任链模式

**代码示例**:
```verse
# 子组件向上报告事件
health_component := class(component):
    OnDeath():void =
        if (Owner := GetOwner[]):
            Event := player_died_event{Player := GetPlayer()}
            # 向上传播到父实体和祖先
            Owner.SendUp(Event)
```

**官方文档**: [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)

---

##### SendDown()

**功能**: 向下传播事件到所有子实体和组件

**签名**:
```verse
SendDown(Event:scene_event):void
```

**传播路径**:
```
当前实体 → 所有直接子实体 → 所有孙子实体 → ... (递归)
```

**使用场景**:
- 父实体向所有子实体广播
- 全局状态变化通知
- 实现观察者模式

**代码示例**:
```verse
# 父实体向下广播事件
game_manager := class(component):
    ChangeGameState(NewState:game_state):void =
        if (Owner := GetOwner[]):
            Event := game_state_changed_event{NewState := NewState}
            # 向下广播到所有子系统
            Owner.SendDown(Event)
```

**官方文档**: [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)

---

##### SendDirect()

**功能**: 直接发送事件到指定实体 (不递归)

**签名**:
```verse
SendDirect(Event:scene_event):void
```

**传播路径**:
```
仅发送到当前实体 (不传播到父实体或子实体)
```

**使用场景**:
- 点对点通信
- 精确目标通知
- 避免不必要的传播开销

**代码示例**:
```verse
# 直接通知特定实体
NotifyPlayer(PlayerEntity:entity, Message:string):void =
    Event := notification_event{Message := Message}
    # 只发送给目标玩家
    PlayerEntity.SendDirect(Event)
```

**官方文档**: [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)

---

### Component 类 API

#### 生命周期函数

##### OnAddedToScene()

**签名**:
```verse
OnAddedToScene<virtual>()<suspends>:void
```

**调用时机**: 组件被添加到实体和场景时

**用途**:
- 初始化组件状态
- 订阅事件
- 建立与其他组件的连接

**注意事项**:
- ⚠️ 此时场景可能还未完全初始化
- ✅ 使用 `<suspends>` 允许异步操作

**代码示例**:
```verse
OnAddedToScene<override>()<suspends>:void =
    Print("[Component] 添加到场景")
    
    # 初始化数据
    InternalData = data_structure{}
    
    # 获取其他组件引用
    if (Owner := GetOwner[]):
        if (Transform := Owner.GetComponent[transform_component][]):
            MyTransform = Transform
```

**官方文档**: [Creating Component](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verseComponent-in-unreal-editor-for-fortnite)

---

##### OnBeginSimulation()

**签名**:
```verse
OnBeginSimulation<virtual>()<suspends>:void
```

**调用时机**: 仿真开始时 (游戏开始运行)

**用途**:
- 启动游戏逻辑
- 创建 UI
- 开始定时器

**重要提示**:
⚠️ **必须在方法开头添加 `Sleep(0.0)`** - 这是 Epic 官方推荐的最佳实践

**代码示例**:
```verse
OnBeginSimulation<override>()<suspends>:void =
    # 重要: 延迟一帧
    Sleep(0.0)
    
    Print("[Component] 仿真开始")
    
    # 创建UI
    CreateUI()
    
    # 启动定时器
    StartTimer()
```

**官方资源**:
- [Epic Forums: Always add frame delay](https://forums.unrealengine.com/t/important-verse-tip-always-add-frame-of-delay-to-your-onbegin-method/858419)

---

##### OnSimulate()

**签名**:
```verse
OnSimulate<virtual>():void
```

**调用时机**: 每个仿真帧 (通常是每帧)

**用途**:
- 每帧更新逻辑
- 状态检查
- 实时响应

**性能提示**:
- ⚠️ 此方法**每帧都会调用**,避免执行耗时操作
- ✅ 使用条件判断减少不必要的计算
- ✅ 考虑使用定时器代替高频轮询

**代码示例**:
```verse
OnSimulate<override>():void =
    # 检查是否启用
    if not Enabled:
        return
    
    # 每帧更新逻辑 (轻量级)
    UpdateInternalLogic()
```

**官方文档**: [interactable_component](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component)

---

##### OnEndSimulation()

**签名**:
```verse
OnEndSimulation<virtual>():void
```

**调用时机**: 仿真结束时 (游戏停止)

**用途**:
- 清理仿真相关资源
- 保存状态
- 停止定时器

**注意事项**:
- ⚠️ 协程 (coroutines) 在此方法中可能无法执行完成
- ✅ 只执行必要的同步清理操作

**代码示例**:
```verse
OnEndSimulation<override>():void =
    Print("[Component] 仿真结束")
    
    # 停止定时器
    StopAllTimers()
    
    # 保存状态
    SaveState()
```

**官方文档**: [OnEnd API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/onend)

---

##### OnRemovingFromScene()

**签名**:
```verse
OnRemovingFromScene<virtual>():void
```

**调用时机**: 组件从场景中移除时

**用途**:
- 最终清理
- 取消订阅事件
- 释放资源

**代码示例**:
```verse
OnRemovingFromScene<override>():void =
    Print("[Component] 从场景移除")
    
    # 取消订阅事件
    UnsubscribeFromAllEvents()
    
    # 销毁UI
    DestroyUI()
    
    # 清理数据
    InternalData = false
```

**官方文档**: [Creating Component](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verseComponent-in-unreal-editor-for-fortnite)

---

##### OnReceive()

**签名**:
```verse
OnReceive<virtual>(Event:scene_event):logic
```

**参数**:
- `Event` - 类型: `scene_event`,接收到的事件

**返回值**:
- 类型: `logic`
- 说明: `true` 表示事件已处理,`false` 表示未处理

**调用时机**: 实体接收到事件时

**用途**:
- 处理场景事件
- 组件间通信
- 响应状态变化

**代码示例**:
```verse
OnReceive<override>(Event:scene_event):logic =
    # 类型检查和处理
    if (CustomEvent := scene_event?my_custom_event):
        HandleCustomEvent(CustomEvent)
        return true  # 事件已处理
    
    # 未处理的事件
    return false
```

**官方文档**: [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)

---

#### 工具函数

##### GetOwner()

**功能**: 获取组件的所有者实体

**签名**:
```verse
GetOwner()<decides>:entity
```

**返回值**:
- 类型: `entity`
- 说明: 所有者实体。如果不存在则失败

**代码示例**:
```verse
my_component := class(component):
    DoSomething():void =
        if (Owner := GetOwner[]):
            # 使用所有者实体
            Owner.SendUp(some_event{})
```

---

### Scene Events API

#### 自定义事件定义

**模板**:
```verse
# 事件必须使用 <concrete> 标记
my_custom_event := class<concrete>(scene_event):
    var Data1:int
    var Data2:string
    var Data3:logic
```

**示例**:
```verse
# 玩家死亡事件
player_died_event := class<concrete>(scene_event):
    var Player:agent
    var Killer:?agent
    var DeathPosition:vector3
    var DeathTime:float

# 物品拾取事件
item_picked_up_event := class<concrete>(scene_event):
    var Item:item_data
    var Picker:agent
    var PickupTime:float
```

**注意事项**:
- ✅ 必须继承 `scene_event`
- ✅ 必须使用 `<concrete>` 标记
- ✅ 包含所有必要的上下文信息

---

## 代码示例

### 示例 1: 创建基础游戏对象

**场景**: 创建一个带有生命值、移动和攻击功能的游戏对象

```verse
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# 生命值组件
health_component := class(component):
    var CurrentHealth:int = 100
    var MaxHealth:int = 100
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        Print("生命值组件初始化: {CurrentHealth}/{MaxHealth}")
    
    TakeDamage(Amount:int):void =
        CurrentHealth = CurrentHealth - Amount
        if (CurrentHealth <= 0):
            OnDeath()
    
    OnDeath():void =
        Print("死亡!")
        if (Owner := GetOwner[]):
            Event := entity_died_event{DeadEntity := Owner}
            Owner.SendUp(Event)

# 移动组件
movement_component := class(component):
    var Speed:float = 5.0
    var CanMove:logic = true
    
    MoveTo(Target:vector3):void =
        if CanMove:
            Print("移动到: {Target}")
            # 实际移动逻辑

# 攻击组件
attack_component := class(component):
    var Damage:int = 10
    var AttackCooldown:float = 1.0
    
    Attack(Target:entity):void =
        Print("攻击目标,造成 {Damage} 伤害")
        # 发送攻击事件
        if (HealthComp := Target.GetComponent[health_component][]):
            HealthComp.TakeDamage(Damage)

# 创建游戏对象
CreateGameObject():entity =
    GameObject := entity{}
    
    # 添加组件
    GameObject.AddComponents(array{
        health_component{MaxHealth := 100},
        movement_component{Speed := 5.0},
        attack_component{Damage := 10}
    })
    
    return GameObject

# 使用示例
UseGameObject():void =
    Player := CreateGameObject()
    Enemy := CreateGameObject()
    
    # 获取攻击组件并攻击敌人
    if (AttackComp := Player.GetComponent[attack_component][]):
        AttackComp.Attack(Enemy)
```

---

### 示例 2: 使用事件系统实现观察者模式

**场景**: 实现一个事件驱动的得分系统,当玩家得分时通知UI和成就系统

```verse
using { /Verse.org/SceneGraph }

# 定义事件
score_changed_event := class<concrete>(scene_event):
    var NewScore:int
    var OldScore:int
    var Player:agent

# 得分管理器组件
score_manager_component := class(component):
    var CurrentScore:int = 0
    
    AddScore(Amount:int):void =
        OldScore := CurrentScore
        CurrentScore = CurrentScore + Amount
        
        # 发送事件
        if (Owner := GetOwner[]):
            Event := score_changed_event{
                NewScore := CurrentScore,
                OldScore := OldScore,
                Player := GetPlayer()
            }
            # 向下广播到所有观察者
            Owner.SendDown(Event)

# UI 组件 (观察者)
score_ui_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (ScoreEvent := scene_event?score_changed_event):
            UpdateScoreDisplay(ScoreEvent.NewScore)
            return true
        return false
    
    UpdateScoreDisplay(Score:int):void =
        Print("更新UI显示: 得分 {Score}")

# 成就系统组件 (观察者)
achievement_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (ScoreEvent := scene_event?score_changed_event):
            CheckAchievements(ScoreEvent.NewScore)
            return true
        return false
    
    CheckAchievements(Score:int):void =
        if Score >= 100:
            Print("解锁成就: 得分达到100!")

# 构建系统
BuildScoreSystem():entity =
    # 创建根实体
    GameManager := entity{}
    
    # 添加得分管理器
    GameManager.AddComponents(array{
        score_manager_component{}
    })
    
    # 创建观察者实体
    UIEntity := entity{}
    UIEntity.AddComponents(array{score_ui_component{}})
    
    AchievementEntity := entity{}
    AchievementEntity.AddComponents(array{achievement_component{}})
    
    # 建立层级关系
    GameManager.AddEntities(array{UIEntity, AchievementEntity})
    
    return GameManager

# 使用示例
UseScoreSystem():void =
    GameManager := BuildScoreSystem()
    
    # 获取得分管理器并增加分数
    if (ScoreManager := GameManager.GetComponent[score_manager_component][]):
        ScoreManager.AddScore(50)   # UI 和成就系统都会收到通知
        ScoreManager.AddScore(60)   # 总分达到 110, 解锁成就
```

---

### 示例 3: 实现一个安全区组件

**场景**: 创建一个安全区组件,阻止怪物进入特定区域

```verse
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

# 安全区组件
safe_zone_component := class(component):
    var Radius:float = 5.0
    var CenterPosition:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    var ActiveMonsters:[]agent = array{}
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 获取中心位置
        if (Owner := GetOwner[]):
            if (Transform := Owner.GetComponent[transform_component][]):
                CenterPosition = Transform.GetPosition()
        
        # 启动检测循环
        spawn:
            loop:
                CheckMonsters()
                Sleep(0.1)  # 每 0.1 秒检测一次
    
    OnReceive<override>(Event:scene_event):logic =
        # 监听怪物生成事件
        if (SpawnEvent := scene_event?monster_spawned_event):
            set ActiveMonsters += array{SpawnEvent.Monster}
            return true
        return false
    
    CheckMonsters():void =
        for (Monster in ActiveMonsters):
            if IsInSafeZone(Monster):
                RepelMonster(Monster)
    
    IsInSafeZone(Monster:agent):logic =
        MonsterPos := Monster.GetTransform().Translation
        Distance := Distance(MonsterPos, CenterPosition)
        return Distance <= Radius
    
    RepelMonster(Monster:agent):void =
        # 计算反方向
        MonsterPos := Monster.GetTransform().Translation
        Direction := Normalize(MonsterPos - CenterPosition)
        RepelPosition := CenterPosition + Direction * (Radius + 2.0)
        
        # 传送怪物到安全区外
        Monster.TeleportTo(RepelPosition)
        Print("怪物被驱逐出安全区")
```

---

### 示例 4: 实现层级结构 - 移动基地系统

**场景**: 创建一个包含多个子系统的移动基地

```verse
using { /Verse.org/SceneGraph }

# 移动基地实体
mobile_base_entity := class(entity):
    var TeamID:int
    var CurrentFloor:int = 1
    
    Initialize(Team:int):void =
        TeamID = Team
        SetupComponents()
        SetupSubsystems()
    
    SetupComponents()<private>:void =
        AddComponents(array{
            safe_zone_component{Radius := 10.0},
            transform_component{}
        })
    
    SetupSubsystems()<private>:void =
        # 创建子系统实体
        DescentDevice := entity{}
        DescentDevice.AddComponents(array{
            descent_device_component{}
        })
        
        TradingTerminal := entity{}
        TradingTerminal.AddComponents(array{
            trading_terminal_component{}
        })
        
        # 添加为子实体
        AddEntities(array{DescentDevice, TradingTerminal})
    
    DescendToNextFloor():void =
        CurrentFloor = CurrentFloor + 1
        
        # 广播楼层变化事件
        Event := floor_changed_event{NewFloor := CurrentFloor}
        SendDown(Event)

# 下潜设备组件
descent_device_component := class(component):
    var Cost:int = 100
    
    OnReceive<override>(Event:scene_event):logic =
        if (FloorEvent := scene_event?floor_changed_event):
            UpdateCost(FloorEvent.NewFloor)
            return true
        return false
    
    UpdateCost(Floor:int):void =
        Cost = 100 * Floor
        Print("下潜到第 {Floor} 层费用: {Cost}")

# 交易终端组件
trading_terminal_component := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (FloorEvent := scene_event?floor_changed_event):
            RefreshInventory(FloorEvent.NewFloor)
            return true
        return false
    
    RefreshInventory(Floor:int):void =
        Print("根据第 {Floor} 层刷新商品")

# 使用示例
CreateMobileBase(Team:int):mobile_base_entity =
    Base := mobile_base_entity{}
    Base.Initialize(Team)
    return Base

UseMobileBase():void =
    Base := CreateMobileBase(1)
    
    # 下潜到下一层
    Base.DescendToNextFloor()  # 所有子系统都会收到通知
```

---

### 示例 5: 使用关键帧动画移动实体

**场景**: 使用 `KeyframedMovement` 模块实现平滑移动

```verse
using { /Verse.org/SceneGraph }
using { /Verse.org/SceneGraph/KeyframedMovement }
using { /Verse.org/SpatialMath }

# 移动平台组件
moving_platform_component := class(component):
    var TargetPosition:vector3 = vector3{X := 10.0, Y := 0.0, Z := 0.0}
    var MoveDuration:float = 2.0
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 启动循环移动
        spawn:
            loop:
                MoveToTarget()
                Sleep(MoveDuration)
                MoveToOrigin()
                Sleep(MoveDuration)
    
    MoveToTarget()<suspends>:void =
        if (Owner := GetOwner[]):
            if (Transform := Owner.GetComponent[transform_component][]):
                # 使用缓动函数实现平滑移动
                EasingFunc := ease_cubic_bezier_easing_function{}
                
                StartPos := Transform.GetPosition()
                
                # 使用插值实现移动 (简化示例)
                TimeElapsed := 0.0
                loop:
                    if TimeElapsed >= MoveDuration:
                        break
                    
                    Progress := TimeElapsed / MoveDuration
                    EasedProgress := EasingFunc.Evaluate(Progress)
                    
                    CurrentPos := Lerp(StartPos, TargetPosition, EasedProgress)
                    Transform.SetPosition(CurrentPos)
                    
                    Sleep(0.016)  # 约 60 FPS
                    TimeElapsed = TimeElapsed + 0.016
    
    MoveToOrigin()<suspends>:void =
        # 返回原点 (类似实现)
        set{}
```

---

## 常见误区澄清

### 误区 1: "Entity 应该包含游戏逻辑"

❌ **错误认知**:
```verse
# 错误: 在 Entity 类中实现大量游戏逻辑
player_entity := class(entity):
    var Health:int = 100
    var Inventory:[]item = array{}
    
    TakeDamage(Amount:int):void =
        Health = Health - Amount
        if Health <= 0:
            Die()
    
    PickupItem(Item:item):void =
        set Inventory += array{Item}
    
    Die():void =
        # 大量逻辑...
```

✅ **正确做法**:
```verse
# 正确: 逻辑放在 Component 中
player_entity := class(entity):
    # Entity 只是容器,功能由组件提供
    
health_component := class(component):
    var CurrentHealth:int = 100
    TakeDamage(Amount:int):void = ...
    
inventory_component := class(component):
    var Items:[]item = array{}
    PickupItem(Item:item):void = ...
```

**原因**: Epic Games 推荐组件化设计,保持 Entity 作为容器的简单性

---

### 误区 2: "同一实体可以添加多个相同类型的组件"

❌ **错误认知**:
```verse
# 错误: 尝试添加多个相同类型的组件
MyEntity.AddComponents(array{
    health_component{MaxHealth := 100},
    health_component{MaxHealth := 50}  # ❌ 会失败
})
```

✅ **正确理解**:
- 一个实体只能有一个给定类型的组件或其子类
- 如果需要多个相似功能,创建不同的组件类型

```verse
# 正确: 使用不同的组件类型
health_component := class(component):
    var MaxHealth:int = 100

shield_component := class(component):
    var MaxShield:int = 50

MyEntity.AddComponents(array{
    health_component{},
    shield_component{}
})
```

---

### 误区 3: "忘记在 OnBeginSimulation 中延迟一帧"

❌ **错误认知**:
```verse
OnBeginSimulation<override>()<suspends>:void =
    # ❌ 直接执行,可能导致初始化失败
    CreateUI()
    StartGameLogic()
```

✅ **正确做法**:
```verse
OnBeginSimulation<override>()<suspends>:void =
    # ✅ 必须延迟一帧
    Sleep(0.0)
    
    # 现在可以安全执行
    CreateUI()
    StartGameLogic()
```

**原因**: 引擎内部初始化可能未完成,延迟一帧确保所有系统就绪

**官方资源**: [Epic Forums 最佳实践](https://forums.unrealengine.com/t/important-verse-tip-always-add-frame-of-delay-to-your-onbegin-method/858419)

---

### 误区 4: "事件消耗会阻止兄弟组件接收事件"

❌ **错误认知**:
```verse
# 错误理解: 认为 Component A 返回 true 后,Component B 不会收到事件

# 同一 Entity 的两个组件
component_a := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Component A 处理")
            return true  # 消耗事件

component_b := class(component):
    OnReceive<override>(Event:scene_event):logic =
        if (Event?my_event):
            Print("Component B 不会执行?")  # ❌ 错误!
            return true
```

✅ **正确理解**:
- **同一 Entity 的所有组件都会收到事件**,无论任何组件返回 `true` 还是 `false`
- 事件消耗 (`return true`) 只影响是否传播到**子实体**

**事件传播规则**:
1. **兄弟组件** (同一 Entity): 互不影响,都会收到事件
2. **子实体传播**: 父实体任何组件返回 `true`,就阻止传播到子实体

```verse
# 正确理解:
# Entity A (父)
#   ├─ Component A1: return true   # 消耗
#   └─ Component A2: return false  # 仍然收到事件
#   └─ Entity B (子) ← 不会收到事件 (被父实体消耗)
```

---

### 误区 5: "在 OnEndSimulation 中使用协程"

❌ **错误认知**:
```verse
OnEndSimulation<override>():void =
    spawn:
        SaveDataAsync()  # ❌ 可能不会执行完成
```

✅ **正确做法**:
```verse
OnEndSimulation<override>():void =
    # ✅ 使用同步操作
    SaveDataSync()
    StopTimers()
```

**原因**: 仿真结束时,协程可能没有足够时间完成

---

### 误区 6: "GetParent() 总是成功"

❌ **错误认知**:
```verse
# 错误: 没有处理失败情况
Parent := MyEntity.GetParent()  # ❌ 如果没有父实体会失败
Parent.DoSomething()
```

✅ **正确做法**:
```verse
# 正确: 使用 <decides> 处理失败
if (Parent := MyEntity.GetParent[]):
    Parent.DoSomething()
else:
    Print("没有父实体")
```

**原因**: 根实体 (Simulation Entity) 没有父实体,调用 `GetParent()` 会失败

---

## 最佳实践

### 1. 架构设计

#### 使用组件而非继承

✅ **推荐**:
```verse
# 通过组合实现功能
enemy_entity := entity{}
enemy_entity.AddComponents(array{
    health_component{},
    attack_component{},
    ai_component{}
})
```

❌ **不推荐**:
```verse
# 通过继承添加功能
base_entity := class(entity): ...
enemy_entity := class(base_entity): ...
boss_entity := class(enemy_entity): ...
```

**原因**: 组合比继承更灵活,更符合 ECS 设计理念

---

#### 保持组件单一职责

✅ **推荐**:
```verse
# 每个组件只做一件事
health_component := class(component):
    # 只负责生命值管理
    var CurrentHealth:int
    TakeDamage(Amount:int):void

movement_component := class(component):
    # 只负责移动
    var Speed:float
    MoveTo(Target:vector3):void
```

❌ **不推荐**:
```verse
# 组件职责过多
player_component := class(component):
    var Health:int
    var Inventory:[]item
    var Speed:float
    TakeDamage(Amount:int):void
    PickupItem(Item:item):void
    MoveTo(Target:vector3):void
```

**原因**: 单一职责使组件更易复用和维护

---

### 2. 事件系统

#### 明确事件传播路径

```verse
# 子向父报告: SendUp
OnItemCollected():void =
    if (Owner := GetOwner[]):
        Owner.SendUp(item_collected_event{})

# 父向子广播: SendDown
OnGameStateChange():void =
    if (Owner := GetOwner[]):
        Owner.SendDown(game_state_changed_event{})

# 点对点: SendDirect
NotifyPlayer(Player:entity):void =
    Player.SendDirect(notification_event{})
```

---

#### 事件命名规范

✅ **推荐**:
```verse
# 动词过去时 + _event
player_died_event
item_purchased_event
floor_changed_event
```

❌ **不推荐**:
```verse
# 其他命名风格
PlayerDeath
item_purchase
FloorChange
```

---

### 3. 性能优化

#### 减少 OnSimulate 开销

❌ **避免**:
```verse
OnSimulate<override>():void =
    # 每帧执行复杂计算
    for (Player in AllPlayers):
        CalculateComplexValue(Player)
```

✅ **推荐**:
```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)
    spawn:
        loop:
            # 每秒执行一次
            CalculateForAllPlayers()
            Sleep(1.0)

OnSimulate<override>():void =
    # 只执行轻量级检查
    if NeedsQuickUpdate:
        QuickUpdate()
```

---

#### 避免过深的层级结构

❌ **避免**:
```
Root → A → B → C → D → E → F (太深!)
```

✅ **推荐**:
```
Root
 ├─ GameManager
 ├─ PlayerManager
 └─ LevelManager
     ├─ Floor1
     └─ Floor2
```

**原因**: 深层级影响性能和可维护性

---

### 4. 调试技巧

#### 添加生命周期日志

```verse
my_component := class(component):
    var ComponentName:string = "MyComponent"
    
    OnAddedToScene<override>()<suspends>:void =
        Print("[{ComponentName}] OnAddedToScene")
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        Print("[{ComponentName}] OnBeginSimulation")
    
    OnSimulate<override>():void =
        if FrameCount mod 60 = 0:
            Print("[{ComponentName}] OnSimulate - Frame {FrameCount}")
```

---

#### 事件调试

```verse
OnReceive<override>(Event:scene_event):logic =
    Print("[{ComponentName}] Received: {Event}")
    
    if (SpecificEvent := scene_event?item_purchased_event):
        Print("  - Item: {SpecificEvent.Item}")
        Print("  - Price: {SpecificEvent.Price}")
        HandlePurchase(SpecificEvent)
        return true
    
    return false
```

---

### 5. 模块化和可重用性

#### 创建可重用的组件

```verse
# 可重用的计时器组件
timer_component := class(component):
    var Duration:float
    var OnTimerTick:event()
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        spawn:
            loop:
                Sleep(Duration)
                OnTimerTick.Signal()

# 在不同地方复用
UIEntity.AddComponents(array{
    timer_component{Duration := 1.0, OnTimerTick := UpdateUI}
})

GameEntity.AddComponents(array{
    timer_component{Duration := 5.0, OnTimerTick := SpawnEnemy}
})
```

---

## 参考资源

### 官方文档

#### 核心文档
- [Scene Graph in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite) - SceneGraph 系统介绍
- [Getting Started in Scene Graph](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite) - 快速入门指南
- [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite) - 事件系统详解
- [Creating Custom Components](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verseComponent-in-unreal-editor-for-fortnite) - 组件开发指南
- [Known Issues](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite) - 已知问题

#### API 参考
- [Verse API 主页](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [SceneGraph 模块](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph)
- [entity 类](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)
- [component 类](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component)
- [interactable_component](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component)
- [agent 类](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/agent)
- [OnEnd 函数](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/onend)

### 社区资源

- [Awesome Verse (GitHub)](https://github.com/spilth/awesome-verse) - 社区精选资源
- [UEFN Tools](https://uefntools.com/resources) - Verse 快速参考
- [GDC Vault: Inside UEFN SceneGraph](https://www.gdcvault.com/play/1034900/Inside-UEFN-SceneGraph-(Presented-by) - Epic 官方演讲
- [SceneGraph Tutorial](https://dev.epicgames.com/community/learning/tutorials/raZD/fortnite-scene-graph-tutorial) - 实践教程
- [Entity-Component System](https://deepwiki.com/vz-creates/uefn/5.1-object-redirection) - ECS 模式详解
- [Verse Specifiers Guide](https://romeroblueprints.blogspot.com/2025/06/uefn-verse-introduction-to-specifiers.html) - Verse 标记说明

### 论坛讨论

- [Epic Forums: OnBegin 最佳实践](https://forums.unrealengine.com/t/important-verse-tip-always-add-frame-of-delay-to-your-onbegin-method/858419)
- [Epic Forums: Entity-Component Model](https://forums.unrealengine.com/t/entity-component-model-using-verse-scripts/1690933)

### 本仓库相关文档

- [API 模块清单](../api-modules-list.md) - 所有 API 模块索引
- [SceneGraph API 参考](../scenegraph-api-reference.md) - 完整 API 参考手册
- [SceneGraph 框架指南](../scenegraph-framework-guide.md) - 框架详细说明
- [API Digests](../../api-digests/) - 完整 API digest 文件

---

## 快速参考卡

### Entity API 快速查找

| 需求 | 使用的 API |
|------|-----------|
| 添加子实体 | `AddEntities([]entity)` |
| 获取父实体 | `GetParent()` |
| 获取所有子实体 | `GetEntities()` |
| 从场景移除 | `RemoveFromParent()` |
| 添加组件 | `AddComponents([]component)` |
| 获取特定组件 | `GetComponent<T>()` |
| 获取所有组件 | `GetComponents()` |
| 向上发送事件 | `SendUp(scene_event)` |
| 向下广播事件 | `SendDown(scene_event)` |
| 直接发送事件 | `SendDirect(scene_event)` |

### Component 生命周期快速查找

| 阶段 | 生命周期函数 | 调用时机 |
|------|-------------|---------|
| 添加 | `OnAddedToScene()` | 组件添加到场景 |
| 开始 | `OnBeginSimulation()` | 仿真开始 (需要 `Sleep(0.0)`) |
| 运行 | `OnSimulate()` | 每帧调用 |
| 结束 | `OnEndSimulation()` | 仿真结束 |
| 移除 | `OnRemovingFromScene()` | 组件从场景移除 |
| 事件 | `OnReceive(scene_event)` | 接收事件 |

### 事件传播快速查找

| 传播方式 | 传播路径 | 使用场景 |
|---------|---------|---------|
| `SendUp` | 当前→父→祖先→根 | 子向父报告 |
| `SendDown` | 当前→所有子孙 (递归) | 父向子广播 |
| `SendDirect` | 仅当前实体 | 点对点通信 |

---

**最后更新**: 2026-01-04  
**维护者**: 根据 Epic Games 官方文档整理  
**反馈**: 如发现 API 变化或错误,请参考最新官方文档
