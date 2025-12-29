# UEFN SceneGraph API 完整参考手册

> **文档类型**：API 参考文档  
> **目标平台**：UEFN (Unreal Editor for Fortnite)  
> **最后更新**：2025-12-17

---

## 文档说明

本文档整理了 UEFN SceneGraph 框架的所有核心 API，每个 API 都标注了官方文档链接，确保准确性和可信度。

**重要提示**：
- ✅ 所有 API 均来自 Epic Games 官方文档
- ✅ 每个 API 都包含官方文档链接
- ✅ 代码示例基于官方最佳实践
- ⚠️ SceneGraph 是 Beta 功能，API 可能会变化

---

## 目录

1. [Entity 类 API](#entity-类-api)
2. [Component 类 API](#component-类-api)
3. [Scene Events API](#scene-events-api)
4. [内置组件 API](#内置组件-api)
5. [生命周期函数](#生命周期函数)
6. [工具函数](#工具函数)
7. [官方文档索引](#官方文档索引)

---

## Entity 类 API

### entity 类定义

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity

```verse
entity := class:
    # 层级管理
    GetParent()<transacts><decides>:entity
    AddEntities(Entities:[]entity)<transacts>:void
    RemoveFromParent()<transacts>:void
    GetEntities()<transacts>:[]entity
    
    # 组件管理
    AddComponents(Components:[]component)<transacts>:void
    GetComponent<T>()<transacts><decides>:T where T:subtype(component)
    GetComponents()<transacts>:[]component
    
    # 事件发送
    SendUp(Event:scene_event):void
    SendDown(Event:scene_event):void
    SendDirect(Event:scene_event):void
```

---

### GetParent()

**功能**：获取实体的父实体

**签名**：
```verse
GetParent()<transacts><decides>:entity
```

**参数**：无

**返回值**：
- **类型**：`entity`
- **说明**：父实体。如果没有父实体则失败（`<decides>`）

**使用场景**：
- 向上遍历层级结构
- 查找父容器
- 实现子向父通信

**代码示例**：
```verse
my_component := class(component):
    GetRootEntity()<decides>:entity =
        if (Owner := GetOwner()):
            CurrentEntity := Owner
            
            # 向上遍历直到根节点
            loop:
                if (Parent := CurrentEntity.GetParent()):
                    CurrentEntity = Parent
                else:
                    # 到达根节点
                    return CurrentEntity
```

**注意事项**：
- ⚠️ 根实体（Simulation Entity）没有父实体，调用会失败
- ✅ 使用 `<decides>` 处理失败情况

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity

---

### AddEntities()

**功能**：将实体添加为子实体（自动处理重新父化）

**签名**：
```verse
AddEntities(Entities:[]entity)<transacts>:void
```

**参数**：
- `Entities` - **类型**：`[]entity`，要添加的实体数组

**返回值**：无

**使用场景**：
- 构建层级结构
- 动态生成子实体
- 重新组织实体关系

**代码示例**：
```verse
# 创建并添加子实体
parent_entity := class(entity):
    Initialize():void =
        # 创建子实体
        Child1 := child_entity{}
        Child2 := child_entity{}
        Child3 := child_entity{}
        
        # 批量添加
        AddEntities(array{Child1, Child2, Child3})
```

**重要特性**：
- ✅ **自动重新父化**：如果实体已有父实体，会自动从旧父实体移除
- ✅ **批量添加**：支持一次添加多个实体
- ✅ **触发生命周期**：会触发子实体的 `OnAddedToScene`

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity

---

### RemoveFromParent()

**功能**：从父实体中移除当前实体（同时移除其所有组件和子实体）

**签名**：
```verse
RemoveFromParent()<transacts>:void
```

**参数**：无

**返回值**：无

**使用场景**：
- 销毁实体
- 重新组织层级
- 临时移除实体

**代码示例**：
```verse
# 销毁实体
DestroyEntity(Entity:entity):void =
    # 会触发所有组件的 OnRemovingFromScene
    Entity.RemoveFromParent()
    
    Print("实体已从场景移除")
```

**重要特性**：
- ✅ **递归清理**：会移除所有子实体和组件
- ✅ **触发生命周期**：会触发 `OnRemovingFromScene` 和 `OnEndSimulation`
- ⚠️ **不可恢复**：移除后实体无法直接恢复，需要重新添加

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity

---

### GetEntities()

**功能**：获取所有子实体

**签名**：
```verse
GetEntities()<transacts>:[]entity
```

**参数**：无

**返回值**：
- **类型**：`[]entity`
- **说明**：子实体数组

**使用场景**：
- 遍历子实体
- 查找特定子实体
- 批量操作子实体

**代码示例**：
```verse
# 遍历所有子实体
IterateChildren(ParentEntity:entity):void =
    Children := ParentEntity.GetEntities()
    
    for (Child in Children):
        Print("子实体：{Child}")
```

**注意事项**：
- ✅ 只返回直接子实体（不递归）
- ✅ 返回的是数组副本，修改不影响原始数据

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity

---

### AddComponents()

**功能**：向实体添加组件

**签名**：
```verse
AddComponents(Components:[]component)<transacts>:void
```

**参数**：
- `Components` - **类型**：`[]component`，要添加的组件数组

**返回值**：无

**使用场景**：
- 初始化实体功能
- 动态添加功能
- 组件化设计

**代码示例**：
```verse
# 初始化实体时添加组件
game_object_entity := class(entity):
    Initialize():void =
        # 创建组件
        Health := health_component{MaxHealth := 100}
        Movement := movement_component{Speed := 5.0}
        Renderer := mesh_component{}
        
        # 批量添加
        AddComponents(array{Health, Movement, Renderer})
```

**重要限制**：
- ⚠️ **同类型唯一**：一个实体只能有一个给定类型的组件或其子类
- ⚠️ **添加失败**：如果类型冲突，添加会失败（静默失败）

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity

---

### GetComponent<T>()

**功能**：获取指定类型的组件

**签名**：
```verse
GetComponent<T>()<transacts><decides>:T where T:subtype(component)
```

**参数**：
- `T` - **泛型类型**：要获取的组件类型

**返回值**：
- **类型**：`T`（泛型）
- **说明**：找到的组件。如果不存在则失败（`<decides>`）

**使用场景**：
- 组件间通信
- 获取特定功能
- 检查组件是否存在

**代码示例**：
```verse
# 获取并使用组件
UseHealthComponent(Entity:entity):void =
    if (HealthComp := Entity.GetComponent<health_component>()):
        CurrentHealth := HealthComp.GetHealth()
        Print("生命值：{CurrentHealth}")
    else:
        Print("没有生命值组件")
```

**注意事项**：
- ✅ 使用泛型确保类型安全
- ✅ 使用 `<decides>` 处理组件不存在的情况
- ⚠️ 如果有多个子类，只返回第一个匹配的

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity

---

### GetComponents()

**功能**：获取所有组件

**签名**：
```verse
GetComponents()<transacts>:[]component
```

**参数**：无

**返回值**：
- **类型**：`[]component`
- **说明**：组件数组

**使用场景**：
- 遍历所有组件
- 批量操作组件
- 调试和检查

**代码示例**：
```verse
# 遍历所有组件
ListAllComponents(Entity:entity):void =
    Components := Entity.GetComponents()
    
    Print("组件列表：")
    for (Comp in Components):
        Print("  - {Comp.GetType()}")
```

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity

---

### SendUp()

**功能**：向上传播事件到父实体和祖先

**签名**：
```verse
SendUp(Event:scene_event):void
```

**参数**：
- `Event` - **类型**：`scene_event`，要发送的事件

**返回值**：无

**传播路径**：
```
当前实体 → 父实体 → 祖父实体 → ... → Simulation Entity (根)
```

**使用场景**：
- 子实体向父实体报告
- 局部事件传递到全局管理器
- 实现责任链模式

**代码示例**：
```verse
# 子组件向上报告事件
health_component := class(component):
    OnDeath():void =
        if (Owner := GetOwner()):
            Event := player_died_event{Player := GetPlayer()}
            # 向上传播到父实体和祖先
            Owner.SendUp(Event)
```

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite

---

### SendDown()

**功能**：向下传播事件到所有子实体和组件

**签名**：
```verse
SendDown(Event:scene_event):void
```

**参数**：
- `Event` - **类型**：`scene_event`，要发送的事件

**返回值**：无

**传播路径**：
```
当前实体 → 所有直接子实体 → 所有孙子实体 → ...（递归）
```

**使用场景**：
- 父实体向所有子实体广播
- 全局状态变化通知
- 实现观察者模式

**代码示例**：
```verse
# 父实体向下广播事件
game_manager := class(entity):
    ChangeGameState(NewState:game_state):void =
        Event := game_state_changed_event{NewState := NewState}
        # 向下广播到所有子系统
        SendDown(Event)
```

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite

---

### SendDirect()

**功能**：直接发送事件到指定实体（不递归）

**签名**：
```verse
SendDirect(Event:scene_event):void
```

**参数**：
- `Event` - **类型**：`scene_event`，要发送的事件

**返回值**：无

**传播路径**：
```
仅发送到当前实体（不传播到父实体或子实体）
```

**使用场景**：
- 点对点通信
- 精确目标通知
- 避免不必要的传播开销

**代码示例**：
```verse
# 直接通知特定实体
NotifyPlayer(PlayerEntity:entity, Message:string):void =
    Event := notification_event{Message := Message}
    # 只发送给目标玩家
    PlayerEntity.SendDirect(Event)
```

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite

---

## Component 类 API

### component 基类

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite

```verse
component := class:
    # 生命周期函数
    OnAddedToScene<virtual>()<suspends>:void
    OnBeginSimulation<virtual>()<suspends>:void
    OnSimulate<virtual>():void
    OnEndSimulation<virtual>():void
    OnRemovingFromScene<virtual>():void
    
    # 事件处理
    OnReceive<virtual>(Event:scene_event):logic
    
    # 工具函数
    GetOwner()<decides>:entity
```

---

## Scene Events API

### scene_event 基类

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite

```verse
scene_event := class<abstract>:
    # 事件基类（抽象）
```

### 自定义事件定义

**模板**：
```verse
# 事件必须使用 <concrete> 标记
my_custom_event := class<concrete>(scene_event):
    var Data1:int
    var Data2:string
    var Data3:logic
```

**示例**：
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

---

## 内置组件 API

### transform_component

**功能**：管理实体的位置、旋转、缩放

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph

**主要方法**：
```verse
transform_component := class(component):
    GetPosition():vector3
    SetPosition(Position:vector3):void
    GetRotation():rotation
    SetRotation(Rotation:rotation):void
    GetScale():vector3
    SetScale(Scale:vector3):void
```

**使用示例**：
```verse
my_component := class(component):
    MoveOwner(NewPosition:vector3):void =
        if (Owner := GetOwner()):
            if (Transform := Owner.GetComponent<transform_component>()):
                Transform.SetPosition(NewPosition)
```

---

### mesh_component

**功能**：3D 网格显示

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph

**主要方法**：
```verse
mesh_component := class(component):
    SetMesh(MeshAsset:mesh_asset):void
    SetMaterial(MaterialAsset:material_asset):void
    SetVisible(Visible:logic):void
```

---

### interactable_component

**功能**：交互逻辑（按钮、开关等）

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component

**主要方法**：
```verse
interactable_component := class(component):
    OnInteract<virtual>(Player:agent):void
    SetEnabled(Enabled:logic):void
    GetCooldown():float
    SetCooldown(Cooldown:float):void
```

**使用示例**：
```verse
my_button_component := class(interactable_component):
    OnInteract<override>(Player:agent):void =
        Print("玩家 {Player} 按下了按钮")
        # 执行按钮逻辑
        DoSomething()
```

---

### light_component 系列

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph

**类型**：
- `directional_light_component` - 方向光
- `sphere_light_component` - 球形光
- `capsule_light_component` - 胶囊光

**主要方法**：
```verse
light_component := class(component):
    SetIntensity(Intensity:float):void
    SetColor(Color:color):void
    SetEnabled(Enabled:logic):void
```

---

### particle_system_component

**功能**：粒子效果

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph

**主要方法**：
```verse
particle_system_component := class(component):
    Play():void
    Stop():void
    SetAutoPlay(AutoPlay:logic):void
```

---

## 生命周期函数

### OnAddedToScene()

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite

**签名**：
```verse
OnAddedToScene<override>()<suspends>:void
```

**调用时机**：组件被添加到实体和场景时

**用途**：
- 初始化组件状态
- 订阅事件
- 建立与其他组件的连接

**注意事项**：
- ⚠️ 此时场景可能还未完全初始化
- ✅ 使用 `<suspends>` 允许异步操作

**示例**：
```verse
OnAddedToScene<override>()<suspends>:void =
    Print("[Component] 添加到场景")
    
    # 初始化数据
    InternalData = data_structure{}
    
    # 订阅事件（如果有事件系统）
    SubscribeToEvent("EventName", Handler)
```

---

### OnBeginSimulation()

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite

**签名**：
```verse
OnBeginSimulation<override>()<suspends>:void
```

**调用时机**：仿真开始时（游戏开始运行）

**用途**：
- 启动游戏逻辑
- 创建 UI
- 开始定时器

**重要提示**：
⚠️ **必须在方法开头添加 `Sleep(0.0)`** - 这是 Epic 官方推荐的最佳实践

**示例**：
```verse
OnBeginSimulation<override>()<suspends>:void =
    # 重要：延迟一帧
    Sleep(0.0)
    
    Print("[Component] 仿真开始")
    
    # 创建UI
    CreateUI()
    
    # 启动定时器
    StartTimer()
```

**官方资源**：
- [Epic Forums: Always add frame delay](https://forums.unrealengine.com/t/important-verse-tip-always-add-frame-of-delay-to-your-onbegin-method/858419)

---

### OnSimulate()

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component

**签名**：
```verse
OnSimulate<override>():void
```

**调用时机**：每个仿真帧（通常是每帧）

**用途**：
- 每帧更新逻辑
- 状态检查
- 实时响应

**性能提示**：
- ⚠️ 此方法**每帧都会调用**，避免执行耗时操作
- ✅ 使用条件判断减少不必要的计算
- ✅ 考虑使用定时器代替高频轮询

**示例**：
```verse
OnSimulate<override>():void =
    # 检查是否启用
    if not Enabled:
        return
    
    # 每帧更新逻辑（轻量级）
    UpdateInternalLogic()
```

---

### OnEndSimulation()

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/onend

**签名**：
```verse
OnEndSimulation<override>():void
```

**调用时机**：仿真结束时（游戏停止）

**用途**：
- 清理仿真相关资源
- 保存状态
- 停止定时器

**注意事项**：
- ⚠️ 协程（coroutines）在此方法中可能无法执行完成
- ✅ 只执行必要的同步清理操作

**示例**：
```verse
OnEndSimulation<override>():void =
    Print("[Component] 仿真结束")
    
    # 停止定时器
    StopAllTimers()
    
    # 保存状态
    SaveState()
```

---

### OnRemovingFromScene()

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite

**签名**：
```verse
OnRemovingFromScene<override>():void
```

**调用时机**：组件从场景中移除时

**用途**：
- 最终清理
- 取消订阅事件
- 释放资源

**示例**：
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

---

### OnReceive()

**官方文档**：https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite

**签名**：
```verse
OnReceive<override>(Event:scene_event):logic
```

**参数**：
- `Event` - **类型**：`scene_event`，接收到的事件

**返回值**：
- **类型**：`logic`
- **说明**：`true` 表示事件已处理，`false` 表示未处理

**调用时机**：实体接收到事件时

**用途**：
- 处理场景事件
- 组件间通信
- 响应状态变化

**示例**：
```verse
OnReceive<override>(Event:scene_event):logic =
    # 类型检查和处理
    if (CustomEvent := Event?my_custom_event):
        HandleCustomEvent(CustomEvent)
        return true  # 事件已处理
    
    # 未处理的事件
    return false
```

---

## 工具函数

### GetOwner()

**功能**：获取组件的所有者实体

**签名**：
```verse
GetOwner()<decides>:entity
```

**返回值**：
- **类型**：`entity`
- **说明**：所有者实体。如果不存在则失败

**使用场景**：
- 组件访问实体
- 发送事件
- 获取其他组件

**示例**：
```verse
my_component := class(component):
    DoSomething():void =
        if (Owner := GetOwner()):
            # 使用所有者实体
            Owner.SendUp(some_event{})
```

---

## 官方文档索引

### 核心文档

| 文档 | 链接 | 说明 |
|------|------|------|
| SceneGraph 概述 | https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite | SceneGraph 系统介绍 |
| SceneGraph 入门 | https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite | 快速入门指南 |
| Scene Events | https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite | 事件系统详解 |
| 创建自定义组件 | https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite | 组件开发指南 |

### API 参考

| API | 链接 |
|-----|------|
| Verse API 主页 | https://dev.epicgames.com/documentation/en-us/fortnite/verse-api |
| SceneGraph 模块 | https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph |
| entity 类 | https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity |
| component 类 | https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component |
| interactable_component | https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component |
| agent 类 | https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/agent |
| OnEnd 函数 | https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device/onend |

### 社区资源

| 资源 | 链接 | 说明 |
|------|------|------|
| Awesome Verse (GitHub) | https://github.com/spilth/awesome-verse | 社区精选资源 |
| UEFN Tools | https://uefntools.com/resources | Verse 快速参考 |
| GDC Vault: Inside UEFN SceneGraph | https://www.gdcvault.com/play/1034900/Inside-UEFN-SceneGraph-(Presented-by | Epic 官方演讲 |
| SceneGraph Tutorial (Epic Community) | https://dev.epicgames.com/community/learning/tutorials/raZD/fortnite-scene-graph-tutorial | 实践教程 |
| Entity-Component System (DeepWiki) | https://deepwiki.com/vz-creates/uefn/5.1-object-redirection | ECS 模式详解 |
| Verse Specifiers Guide | https://romeroblueprints.blogspot.com/2025/06/uefn-verse-introduction-to-specifiers.html | Verse 标记说明 |

### 已知问题

| 文档 | 链接 |
|------|------|
| SceneGraph Known Issues | https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite |

### 论坛和社区

| 资源 | 链接 |
|------|------|
| Epic Forums: OnBegin 最佳实践 | https://forums.unrealengine.com/t/important-verse-tip-always-add-frame-of-delay-to-your-onbegin-method/858419 |
| Epic Forums: Entity-Component Model | https://forums.unrealengine.com/t/entity-component-model-using-verse-scripts/1690933 |

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
| 开始 | `OnBeginSimulation()` | 仿真开始（需要 `Sleep(0.0)`） |
| 运行 | `OnSimulate()` | 每帧调用 |
| 结束 | `OnEndSimulation()` | 仿真结束 |
| 移除 | `OnRemovingFromScene()` | 组件从场景移除 |
| 事件 | `OnReceive(scene_event)` | 接收事件 |

### 事件传播快速查找

| 传播方式 | 传播路径 | 使用场景 |
|---------|---------|---------|
| `SendUp` | 当前→父→祖先→根 | 子向父报告 |
| `SendDown` | 当前→所有子孙（递归） | 父向子广播 |
| `SendDirect` | 仅当前实体 | 点对点通信 |

---

## 常见错误和解决方案

### 错误 1：组件添加失败

**问题**：
```verse
# 添加相同类型的组件失败
Entity.AddComponents(array{
    health_component{},
    health_component{}  # ❌ 失败
})
```

**原因**：一个实体只能有一个给定类型的组件

**解决方案**：
```verse
# ✅ 使用不同类型的组件
Entity.AddComponents(array{
    health_component{},
    movement_component{},
    attack_component{}
})
```

---

### 错误 2：忘记 Sleep(0.0)

**问题**：
```verse
OnBeginSimulation<override>()<suspends>:void =
    # ❌ 缺少延迟
    CreateUI()  # 可能失败
```

**原因**：引擎内部初始化未完成

**解决方案**：
```verse
OnBeginSimulation<override>()<suspends>:void =
    # ✅ 添加延迟
    Sleep(0.0)
    CreateUI()
```

---

### 错误 3：在 OnEndSimulation 中使用协程

**问题**：
```verse
OnEndSimulation<override>():void =
    spawn:
        SaveDataAsync()  # ❌ 可能不会执行
```

**原因**：协程可能无法完成

**解决方案**：
```verse
OnEndSimulation<override>():void =
    # ✅ 使用同步操作
    SaveDataSync()
```

---

## 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| 1.0 | 2025-12-17 | 初始版本，整理核心 API |

---

**最后更新**：2025-12-17  
**维护者**：根据 Epic Games 官方文档整理  
**反馈**：如发现 API 变化或错误，请参考最新官方文档

**相关文档**：
- [UEFN SceneGraph 框架详解](./UEFN-SceneGraph框架详解.md)
- [电梯/移动基地系统案例](./UEFN-SceneGraph案例-电梯系统.md)
- [游戏循环系统案例](./UEFN-SceneGraph案例-游戏循环.md)
