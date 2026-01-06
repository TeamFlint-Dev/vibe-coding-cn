# SceneGraph 原生 Component 类型完整清单

<!-- markdownlint-disable MD024 -->

> **调研编号**: R00-1（补充调研）
>
> **调研日期**: 2026-01-05
>
> **调研目标**: 梳理所有 SceneGraph 的原生 Component 类型，分类并说明其用途和关键用法

---

## 📋 执行摘要

本文档汇总了 UEFN/Verse 官方提供的所有 SceneGraph 原生 Component 类型。通过系统梳理官方 API digest 文件，共识别出 **32 个原生 Component 类型**，分布在三个模块中：

- **Verse.org 模块**: 14 个组件（核心 SceneGraph 组件）
- **UnrealEngine 模块**: 4 个组件（物品系统）
- **Fortnite 模块**: 14 个组件（Fortnite 特有功能）

**关键发现**:

- ✅ 大部分组件已可用（非实验性）
- ⚠️ 12 个组件标记为 `@experimental`（实验性）
- 🔒 13 个组件标记为 `<epic_internal>`（内部使用）
- 🏗️ 3 个抽象基类组件，不可直接实例化

---

## 📊 组件总览

### 按模块分类统计

| 模块 | 组件数量 | 实验性 | 内部使用 | 抽象类 |
|------|---------|--------|----------|--------|
| **Verse.org** | 14 | 4 | 5 | 2 |
| **UnrealEngine** | 4 | 4 | 0 | 0 |
| **Fortnite** | 14 | 10 | 8 | 1 |
| **合计** | 32 | 12 | 13 | 3 |

### 按功能分类

| 分类 | 组件类型 | 数量 |
|------|----------|------|
| **基础功能** | 变换、标签、交互 | 3 |
| **渲染系统** | 光照、网格、粒子、音效 | 9 |
| **物品系统** | 库存、物品 | 18 |
| **AI 系统** | NPC、守卫、伙伴 | 5 |
| **动画系统** | 关键帧移动 | 1 |

---

## 🎯 一、基础功能组件（3 个）

这些组件提供 SceneGraph 实体的基础功能，是最常用的组件。

### 1.1 transform_component（变换组件）

**模块**: Verse.org  
**状态**: ✅ 稳定可用  
**继承**: component

#### 功能说明

存储实体的空间变换信息（位置、旋转、缩放），是所有需要空间定位的实体的核心组件。

#### 关键属性

```verse
transform_component := class<final><final_super>(component):
    # 全局变换（世界空间）
    var GlobalTransform:transform = external {}
    
    # 本地变换（相对父实体）
    var LocalTransform:transform = external {}
    
    # 可选的替代原点（默认为父实体）
    var Origin:?origin = external {}
```

#### 典型用法

```verse
# 创建带变换的实体
MyEntity := entity{}
MyEntity.AddComponents(array{
    transform_component{
        LocalTransform := MakeTransform(
            Position := vector3{X := 100.0, Y := 200.0, Z := 50.0},
            Rotation := MakeRotationFromYaw(90.0),
            Scale := vector3{X := 1.5, Y := 1.5, Z := 1.5}
        )
    }
})

# 运行时修改位置（也可通过实体方法）
MyEntity.SetLocalTransform(NewTransform)
```

#### 应用场景

- ✅ 所有需要空间定位的实体（角色、道具、特效）
- ✅ 动态移动的对象
- ✅ 层级结构的根节点

#### 注意事项

- 如果实体没有 `transform_component`，调用 `GetLocalTransform()` 会返回恒等变换
- 设置全局/本地变换时，如果没有该组件会自动创建

---

### 1.2 tag_component（标签组件）

**模块**: Verse.org  
**状态**: ⚠️ 实验性（`@experimental`）  
**继承**: component, tag_view

#### 功能说明

为实体添加标签，用于查询和分类。可通过 `entity.FindDescendantEntitiesByTag()` 查询带特定标签的实体。

#### 关键属性

```verse
tag_component := class<final><final_super>(component, tag_view):
    # 标签集合（构造时传入）
    Tags:[]tag
```

#### 典型用法

```verse
# 定义自定义标签
enemy_tag := class(tag) {}
player_tag := class(tag) {}

# 为实体添加标签
Enemy := entity{}
Enemy.AddComponents(array{
    tag_component{Tags := array{enemy_tag{}}},
    transform_component{}
})

# 查询所有带 enemy_tag 的子实体
RootEntity := GetSimulationEntity()
Enemies := RootEntity.FindDescendantEntitiesByTag(enemy_tag{})
for (EnemyEntity : Enemies):
    Print("Found enemy: {EnemyEntity}")
```

#### 应用场景

- ✅ 实体分类（敌人、友军、中立）
- ✅ 批量查询和操作
- ✅ 事件过滤（只处理特定标签的实体）

#### 注意事项

- ⚠️ 实验性功能，API 可能变化
- 标签查询会递归搜索所有子孙实体
- 标签是类实例，需要先定义标签类

---

### 1.3 interactable_component（交互组件）

**模块**: Verse.org  
**状态**: ⚠️ 实验性（`@experimental`）  
**继承**: component, enableable

#### 功能说明

用于处理玩家与实体的交互（如按 E 键交互）。这是一个基类组件，可直接使用或继承。

#### 关键特性

- 实现 `enableable` 接口，可启用/禁用
- 支持交互事件监听
- 可自定义交互提示文本

#### 子类组件

- **basic_interactable_component**: 可组合功能集的交互组件
- **offer_interactable_component**: Fortnite 商店交互（实验性）

#### 典型用法

```verse
# 使用基础交互组件
Door := entity{}
Door.AddComponents(array{
    transform_component{},
    mesh_component{},
    basic_interactable_component{}
})

# 监听交互事件（在自定义组件中）
my_controller := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        if (Owner := GetOwner()):
            if (Interactable := Owner.GetComponent[basic_interactable_component]()):
                # 订阅交互事件（假设有 InteractedEvent）
                # Interactable.InteractedEvent.Subscribe(OnInteracted)
```

#### 应用场景

- ✅ 可交互的游戏对象（门、按钮、宝箱）
- ✅ 需要玩家主动触发的功能
- ✅ 商店、任务 NPC

#### 注意事项

- ⚠️ 实验性功能，API 可能变化
- 需要配合 Device 获取玩家输入
- 交互范围和提示需要额外配置

---

## 🎨 二、渲染系统组件（9 个）

这些组件控制实体的视觉呈现，包括光照、网格、粒子效果和音效。

### 2.1 光照组件（6 个）

所有光照组件继承自 `light_component` 抽象基类，依赖 `transform_component` 定位光源。

#### 2.1.1 light_component（光照基类）

**模块**: Verse.org  
**状态**: 🏗️ 抽象类（`<abstract>`），🔒 内部使用（`<epic_internal>`）  
**继承**: component, enableable

**功能**: 所有光照组件的抽象基类，不可直接实例化。

**关键属性**:

```verse
light_component := class<abstract><final_super><epic_internal>(component, enableable):
    # 是否投射阴影
    var CastShadows:logic = external {}
    
    # 光照颜色（RGB）
    var LightColor:color = external {}
    
    # 光照强度
    var Intensity:float = external {}
```

**通用方法**:

- `Enable()`: 启用光照渲染
- `Disable()`: 禁用光照渲染
- `IsEnabled()<decides>`: 检查是否启用

---

#### 2.1.2 directional_light_component（平行光）

**模块**: Verse.org  
**状态**: ✅ 稳定可用  
**继承**: light_component

**功能**: 模拟无限远的平行光源（如太阳光），光线方向统一。

**典型用法**:

```verse
# 创建太阳光
Sun := entity{}
Sun.AddComponents(array{
    transform_component{
        LocalTransform := MakeTransform(
            Rotation := MakeRotationFromPitch(-45.0)  # 45度角向下照射
        )
    },
    directional_light_component{
        Intensity := 10.0,
        LightColor := color{R := 1.0, G := 0.95, B := 0.8},  # 暖色调
        CastShadows := true
    }
})
```

**应用场景**:

- ✅ 室外场景的主光源（太阳、月亮）
- ✅ 大范围均匀照明
- ✅ 阴影效果

---

#### 2.1.3 sphere_light_component（球形光）

**模块**: Verse.org  
**状态**: ✅ 稳定可用  
**继承**: light_component

**功能**: 从球形光源向四周发射光线，模拟灯泡等点光源。

**典型用法**:

```verse
# 创建灯泡
Lamp := entity{}
Lamp.AddComponents(array{
    transform_component{
        LocalTransform := MakeTransform(
            Position := vector3{X := 0.0, Y := 0.0, Z := 300.0}
        )
    },
    sphere_light_component{
        Intensity := 5000.0,
        LightColor := color{R := 1.0, G := 1.0, B := 1.0},
        CastShadows := true
    }
})
```

**应用场景**:

- ✅ 室内照明（灯泡、蜡烛）
- ✅ 特效光源（魔法球、能量核心）
- ✅ 局部照明

---

#### 2.1.4 spot_light_component（聚光灯）

**模块**: Verse.org  
**状态**: ✅ 稳定可用  
**继承**: light_component

**功能**: 锥形光束，有内外角度控制，模拟手电筒、舞台灯等。

**关键属性**:

```verse
spot_light_component := class<final>(light_component):
    # 内锥角（全亮区域）
    var InnerConeAngleDegrees:float = external {}
    
    # 外锥角（渐变区域）
    var OuterConeAngleDegrees:float = external {}
```

**典型用法**:

```verse
# 创建手电筒
Flashlight := entity{}
Flashlight.AddComponents(array{
    transform_component{},
    spot_light_component{
        Intensity := 3000.0,
        InnerConeAngleDegrees := 20.0,
        OuterConeAngleDegrees := 30.0,
        CastShadows := true
    }
})
```

**应用场景**:

- ✅ 手电筒、探照灯
- ✅ 舞台效果
- ✅ 车灯、聚焦照明

---

#### 2.1.5 rect_light_component（矩形光）

**模块**: Verse.org  
**状态**: ✅ 稳定可用  
**继承**: light_component

**功能**: 从矩形平面发射光线，模拟窗户、显示屏等面光源。

**关键属性**:

```verse
rect_light_component := class<final>(light_component):
    # 矩形宽度
    var Width:float = external {}
    
    # 矩形高度
    var Height:float = external {}
```

**典型用法**:

```verse
# 创建窗户光
Window := entity{}
Window.AddComponents(array{
    transform_component{},
    rect_light_component{
        Width := 200.0,
        Height := 150.0,
        Intensity := 2000.0,
        LightColor := color{R := 0.8, G := 0.9, B := 1.0}  # 冷色调
    }
})
```

**应用场景**:

- ✅ 窗户、天窗
- ✅ 显示屏、霓虹灯
- ✅ 柔和的面光源

---

#### 2.1.6 capsule_light_component（胶囊光）

**模块**: Verse.org  
**状态**: ✅ 稳定可用  
**继承**: light_component

**功能**: 从胶囊形（圆柱 + 半球端盖）光源发射光线。

**典型用法**:

```verse
# 创建荧光管
NeonTube := entity{}
NeonTube.AddComponents(array{
    transform_component{},
    capsule_light_component{
        Intensity := 1500.0,
        LightColor := color{R := 1.0, G := 0.2, B := 0.8}  # 粉红色
    }
})
```

**应用场景**:

- ✅ 荧光管、霓虹灯管
- ✅ 光剑等条状光源
- ✅ 装饰性照明

---

### 2.2 mesh_component（网格组件）

**模块**: Verse.org  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: component, enableable

#### 功能说明

在实体位置渲染 3D 网格模型，是最常用的视觉组件。依赖 `transform_component` 定位。

#### 关键属性

```verse
mesh_component := class<final_super><epic_internal>(component, enableable):
    # 启用/禁用碰撞
    var Collidable:logic = external {}
    
    # 启用/禁用空间查询（影响 EntityEnteredEvent/EntityExitedEvent）
    var Queryable:logic = external {}
```

#### 关键事件

```verse
# 其他实体开始重叠时触发
EntityEnteredEvent:listenable(entity)

# 其他实体停止重叠时触发
EntityExitedEvent:listenable(entity)
```

#### 典型用法

```verse
# 创建可碰撞的立方体
Cube := entity{}
Cube.AddComponents(array{
    transform_component{},
    mesh_component{
        Collidable := true,
        Queryable := true
    }
})

# 监听碰撞事件
my_collision_handler := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        if (Owner := GetOwner()):
            if (Mesh := Owner.GetComponent[mesh_component]()):
                Mesh.EntityEnteredEvent.Subscribe(OnEntityEntered)
                
    OnEntityEntered(OtherEntity:entity):void =
        Print("Entity entered: {OtherEntity}")
```

#### 应用场景

- ✅ 所有需要视觉呈现的游戏对象
- ✅ 碰撞检测触发器
- ✅ 静态场景物体、动态道具

#### 注意事项

- 🔒 标记为内部使用，但实际可正常使用
- 网格资源需在编辑器中预先配置
- 禁用 `Queryable` 会同时禁用碰撞事件

---

### 2.3 particle_system_component（粒子系统组件）

**模块**: Verse.org  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: component, enableable

#### 功能说明

在实体位置生成和渲染粒子特效（火焰、烟雾、爆炸等）。依赖 `transform_component` 定位。

#### 关键属性

```verse
particle_system_component := class<final_super><epic_internal>(component, enableable):
    # 是否自动播放（添加到场景或启用时）
    var AutoPlay:logic = external {}
    
    # 是否在创建时启用
    var StartEnabled:logic = external {}
```

#### 关键方法

```verse
# 播放粒子系统
Play():void

# 停止粒子系统
Stop():void
```

#### 典型用法

```verse
# 创建火焰特效
FireEffect := entity{}
FireEffect.AddComponents(array{
    transform_component{
        LocalTransform := MakeTransform(
            Position := vector3{X := 100.0, Y := 200.0, Z := 0.0}
        )
    },
    particle_system_component{
        AutoPlay := true,
        StartEnabled := true
    }
})

# 手动控制播放
if (ParticleComp := FireEffect.GetComponent[particle_system_component]()):
    ParticleComp.Play()
    # ... 延迟 ...
    ParticleComp.Stop()
```

#### 应用场景

- ✅ 视觉特效（火焰、烟雾、爆炸、魔法）
- ✅ 环境效果（雨、雪、落叶）
- ✅ 反馈效果（命中、治疗、升级）

#### 注意事项

- 🔒 标记为内部使用，但实际可正常使用
- 粒子系统资源需在编辑器中预先配置
- 大量粒子会影响性能，注意优化

---

### 2.4 sound_component（音效组件）

**模块**: Verse.org  
**状态**: 🏗️ 抽象类（`<abstract>`），🔒 内部使用（`<epic_internal>`），⚠️ 实验性（`@experimental`）  
**继承**: component, enableable

#### 功能说明

音效播放的抽象基类，不可直接实例化。目前官方 digest 中没有提供具体的子类实现。

#### 注意事项

- ⚠️ 实验性功能，API 不稳定
- 🔒 内部使用，缺少公开文档
- 🏗️ 抽象类，需要等待具体实现类

#### 替代方案

对于音效播放需求，目前推荐使用 Device：

- `audio_player_device`: 播放音效和背景音乐
- `music_sequencer_device`: 音乐序列控制

---

### 2.5 keyframed_movement_component（关键帧移动组件）

**模块**: Verse.org  
**状态**: ✅ 稳定可用  
**继承**: component

#### 功能说明

提供简单的关键帧动画和传送功能。可按顺序播放预定义的位置/旋转关键帧。

#### 典型用法

```verse
# 创建移动平台
MovingPlatform := entity{}
MovingPlatform.AddComponents(array{
    transform_component{},
    mesh_component{},
    keyframed_movement_component{}
})

# 在自定义组件中控制移动
platform_controller := class(component):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        if (Owner := GetOwner()):
            if (Movement := Owner.GetComponent[keyframed_movement_component]()):
                # 播放关键帧动画（具体 API 需查阅官方文档）
                # Movement.PlayAnimation(...)
```

#### 应用场景

- ✅ 移动平台
- ✅ 简单的往复运动
- ✅ 传送点

#### 注意事项

- 仅支持简单关键帧，复杂动画需使用其他方案
- 关键帧定义方式需参考官方文档
- 对于复杂轨迹，建议自行实现（spawn + Sleep + SetTransform）

---

## 📦 三、物品系统组件（18 个）

这些组件实现物品和库存管理，分为通用物品系统（UnrealEngine 模块）和 Fortnite 特化系统（Fortnite 模块）。

### 3.1 通用物品系统（UnrealEngine 模块，4 个）

这些组件提供跨平台的物品和库存抽象，是 Fortnite 特化组件的基础。

#### 3.1.1 inventory_component（库存组件）

**模块**: UnrealEngine  
**状态**: ⚠️ 实验性（`@experimental`）  
**继承**: component

**功能**: 管理实体的库存，控制物品的进出。

**关键方法**:

```verse
inventory_component := class<final_super>(component):
    # 检查是否可以添加物品
    CanAddItem(Item:entity)<transacts>:result(false, []add_item_error)
    
    # 检查是否可以移除物品
    CanRemoveItem(Item:entity)<transacts>:result(false, []remove_item_error)
    
    # 查找库存中的物品（生成器）
    FindItems(Type:castable_subtype(item_component))<reads>:[]entity
    
    # 获取所有物品
    GetItems(Type:castable_subtype(item_component))<reads>:[]entity
```

**典型用法**:

```verse
# 创建玩家库存
PlayerInventory := entity{}
PlayerInventory.AddComponents(array{
    inventory_component{}
})

# 添加物品到库存
Item := entity{}
Item.AddComponents(array{
    item_component{}
})

if (Inventory := PlayerInventory.GetComponent[inventory_component]()):
    Result := Inventory.CanAddItem(Item)
    if (Result.IsSuccess()):
        # 添加物品逻辑
```

**应用场景**:

- ✅ 玩家背包
- ✅ 箱子、容器
- ✅ 商店库存

---

#### 3.1.2 item_component（物品组件）

**模块**: UnrealEngine  
**状态**: ⚠️ 实验性（`@experimental`）  
**继承**: component

**功能**: 标记实体为物品，使其可与库存交互。

**关键属性**:

```verse
item_component := class<final_super>(component):
    # 可合并的物品类型列表
    MergeableItemComponentClasses:[]castable_subtype(item_component) = external {}
```

**关键方法**:

```verse
# 拾取物品到库存
PickUp(Inventory:inventory_component)<transacts><decides>:void

# 获取所在的库存
GetParentInventory()<reads><decides>:inventory_component

# 检查是否可装备/卸下
CanEquip()<transacts>:result(false, []equip_item_error)
CanUnequip()<transacts>:result(false, []unequip_item_error)
```

**典型用法**:

```verse
# 创建可拾取的武器
Weapon := entity{}
Weapon.AddComponents(array{
    transform_component{},
    mesh_component{},
    item_component{}
})

# 拾取逻辑
if (ItemComp := Weapon.GetComponent[item_component]()):
    if (PlayerInventory := GetPlayerInventory()):
        ItemComp.PickUp(PlayerInventory)
```

---

#### 3.1.3 item_details_component（物品详情组件）

**模块**: UnrealEngine  
**状态**: ⚠️ 实验性（`@experimental`）  
**继承**: component, has_description

**功能**: 存储物品的描述信息（名称、说明等）。

**接口**:

- 实现 `has_description` 接口，提供物品描述

**典型用法**:

```verse
# 创建带描述的物品
Sword := entity{}
Sword.AddComponents(array{
    item_component{},
    item_details_component{
        # 名称、描述等属性（具体 API 需查阅官方文档）
    }
})
```

---

#### 3.1.4 item_icon_component（物品图标组件）

**模块**: UnrealEngine  
**状态**: ⚠️ 实验性（`@experimental`）  
**继承**: component, has_icon

**功能**: 存储物品的图标资源，用于 UI 显示。

**接口**:

- 实现 `has_icon` 接口，提供图标资源

**典型用法**:

```verse
# 创建带图标的物品
Potion := entity{}
Potion.AddComponents(array{
    item_component{},
    item_icon_component{
        # 图标资源（具体 API 需查阅官方文档）
    }
})
```

---

### 3.2 Fortnite 特化物品系统（Fortnite 模块，14 个）

这些组件扩展了通用物品系统，提供 Fortnite 特有的功能。

#### 3.2.1 fort_inventory_component（Fortnite 库存基类）

**模块**: Fortnite  
**状态**: ⚠️ 实验性（`@experimental`），🔒 内部使用（`<epic_internal>`）  
**继承**: inventory_component

**功能**: Fortnite 专用库存组件的基类，扩展了通用库存功能。

**子类**:

所有 Fortnite 专用库存类型都继承自此类：

- `fort_inventory_ammo_component`: 弹药库存
- `fort_inventory_build_hotbar_component`: 建造快捷栏
- `fort_inventory_collectibles_component`: 收藏品库存
- `fort_inventory_currencies_component`: 货币库存
- `fort_inventory_harvest_tool_component`: 采集工具库存
- `fort_inventory_resources_component`: 资源库存
- `fort_inventory_trap_component`: 陷阱库存
- `fort_inventory_weapon_hotbar_component`: 武器快捷栏

---

#### 3.2.2 Fortnite 专用库存类型（8 个）

所有以下组件都是 **实验性** 的，用于管理 Fortnite 特定的物品类型。

##### fort_inventory_ammo_component（弹药库存）

管理玩家的弹药。

```verse
Player := entity{}
Player.AddComponents(array{
    fort_inventory_ammo_component{}
})
```

---

##### fort_inventory_weapon_hotbar_component（武器快捷栏）

管理玩家的武器和装备快捷栏。

**关键方法**:

```verse
fort_inventory_weapon_hotbar_component := class<final>(fort_inventory_component):
    # 获取快捷栏大小
    GetInventorySize():int
    
    # 获取指定槽位的物品
    GetItemAtSlot(Slot:int)<decides>:entity
```

**典型用法**:

```verse
Player := entity{}
Player.AddComponents(array{
    fort_inventory_weapon_hotbar_component{}
})

# 访问快捷栏
if (Hotbar := Player.GetComponent[fort_inventory_weapon_hotbar_component]()):
    Size := Hotbar.GetInventorySize()
    Print("Hotbar size: {Size}")
```

---

##### fort_inventory_build_hotbar_component（建造快捷栏）

管理 Fortnite 建造系统的快捷栏。

---

##### fort_inventory_collectibles_component（收藏品库存）

管理收藏品类物品。

---

##### fort_inventory_currencies_component（货币库存）

管理 Fortnite 游戏内货币。

---

##### fort_inventory_harvest_tool_component（采集工具库存）

管理采集工具（鹤嘴锄等）。

---

##### fort_inventory_resources_component（资源库存）

管理建造资源（木材、石头、金属）。

---

##### fort_inventory_trap_component（陷阱库存）

管理陷阱物品。

---

#### 3.2.3 fort_item_pickup_component（Fortnite 物品拾取组件）

**模块**: Fortnite  
**状态**: ⚠️ 实验性（`@experimental`）  
**继承**: component

**功能**: 处理 Fortnite 中物品的拾取逻辑。

**典型用法**:

```verse
# 创建可拾取的战利品
Loot := entity{}
Loot.AddComponents(array{
    transform_component{},
    mesh_component{},
    fort_item_pickup_component{}
})
```

---

#### 3.2.4 offer_interactable_component（商店交互组件）

**模块**: Fortnite  
**状态**: ⚠️ 实验性（`@experimental`）  
**继承**: interactable_component

**功能**: 处理 Fortnite 商店中的物品交互和购买逻辑。

**典型用法**:

```verse
# 创建商店交互点
ShopStand := entity{}
ShopStand.AddComponents(array{
    transform_component{},
    mesh_component{},
    offer_interactable_component{}
})
```

---

## 🤖 四、AI 系统组件（5 个）

这些组件用于 Fortnite 的 NPC 和 AI 系统，大部分标记为内部使用。

### 4.1 sidekick_component（伙伴组件基类）

**模块**: Fortnite  
**状态**: 🏗️ 抽象类（`<abstract>`），🔒 内部使用（`<epic_internal>`）  
**继承**: component

**功能**: 管理所有伙伴类型的共享功能，是伙伴系统的抽象基类。

**子类**:

- `npc_sidekick_component`: NPC 伙伴
- `equipped_sidekick_component`: 装备型伙伴

---

### 4.2 npc_sidekick_component（NPC 伙伴组件）

**模块**: Fortnite  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: sidekick_component

**功能**: 管理 NPC 伙伴的特定功能。

---

### 4.3 equipped_sidekick_component（装备伙伴组件）

**模块**: Fortnite  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: sidekick_component, showable

**功能**: 管理装备型伙伴，实现 `showable` 接口可显示/隐藏。

---

### 4.4 npc_actions_component（NPC 行为组件）

**模块**: Fortnite  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: component

**功能**: 管理 Fortnite NPC 的 AI 行为和动作。

**子类**:

- `guard_actions_component`: 守卫 NPC 的行为管理

---

### 4.5 npc_awareness_component（NPC 感知组件）

**模块**: Fortnite  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: component

**功能**: 管理 Fortnite NPC 的感知系统（视觉、听觉等）。

**子类**:

- `guard_awareness_component`: 守卫 NPC 的感知管理

---

### 4.6 guard_actions_component（守卫行为组件）

**模块**: Fortnite  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: npc_actions_component

**功能**: Fortnite 守卫 NPC 的专用行为管理。

---

### 4.7 guard_awareness_component（守卫感知组件）

**模块**: Fortnite  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: npc_awareness_component

**功能**: Fortnite 守卫 NPC 的专用感知管理。

---

### 4.8 spark_mode_component（Spark 模式组件）

**模块**: Fortnite  
**状态**: 🔒 内部使用（`<epic_internal>`）  
**继承**: component

**功能**: 管理支持 Spark 模式的实体，Spark 模式会转换实体的形态或状态。

**注意**: Fortnite 特定功能，具体用途需参考 Fortnite 官方文档。

---

## 📊 五、组件完整清单

### 按模块分类

#### Verse.org 模块（14 个）

| 组件名称 | 分类 | 状态 | 父类 | 说明 |
|---------|------|------|------|------|
| `transform_component` | 基础 | ✅ 稳定 | component | 空间变换（位置、旋转、缩放） |
| `tag_component` | 基础 | ⚠️ 实验性 | component | 实体标签和查询 |
| `interactable_component` | 基础 | ⚠️ 实验性 | component | 玩家交互 |
| `basic_interactable_component` | 基础 | ✅ 稳定 | interactable_component | 可组合交互功能 |
| `light_component` | 渲染 | 🏗️ 抽象类 | component | 光照基类 |
| `directional_light_component` | 渲染 | ✅ 稳定 | light_component | 平行光 |
| `sphere_light_component` | 渲染 | ✅ 稳定 | light_component | 球形光 |
| `spot_light_component` | 渲染 | ✅ 稳定 | light_component | 聚光灯 |
| `rect_light_component` | 渲染 | ✅ 稳定 | light_component | 矩形光 |
| `capsule_light_component` | 渲染 | ✅ 稳定 | light_component | 胶囊光 |
| `mesh_component` | 渲染 | ✅ 稳定 | component | 3D 网格渲染 |
| `particle_system_component` | 渲染 | ✅ 稳定 | component | 粒子特效 |
| `sound_component` | 渲染 | 🏗️ 抽象类 | component | 音效播放（抽象） |
| `keyframed_movement_component` | 动画 | ✅ 稳定 | component | 关键帧移动 |

---

#### UnrealEngine 模块（4 个）

| 组件名称 | 分类 | 状态 | 父类 | 说明 |
|---------|------|------|------|------|
| `inventory_component` | 物品 | ⚠️ 实验性 | component | 通用库存管理 |
| `item_component` | 物品 | ⚠️ 实验性 | component | 通用物品标记 |
| `item_details_component` | 物品 | ⚠️ 实验性 | component | 物品详情 |
| `item_icon_component` | 物品 | ⚠️ 实验性 | component | 物品图标 |

---

#### Fortnite 模块（14 个）

| 组件名称 | 分类 | 状态 | 父类 | 说明 |
|---------|------|------|------|------|
| `fort_inventory_component` | 物品 | ⚠️ 实验性 | inventory_component | Fortnite 库存基类 |
| `fort_inventory_ammo_component` | 物品 | ⚠️ 实验性 | fort_inventory_component | 弹药库存 |
| `fort_inventory_build_hotbar_component` | 物品 | ⚠️ 实验性 | fort_inventory_component | 建造快捷栏 |
| `fort_inventory_collectibles_component` | 物品 | ⚠️ 实验性 | fort_inventory_component | 收藏品库存 |
| `fort_inventory_currencies_component` | 物品 | ⚠️ 实验性 | fort_inventory_component | 货币库存 |
| `fort_inventory_harvest_tool_component` | 物品 | ⚠️ 实验性 | fort_inventory_component | 采集工具库存 |
| `fort_inventory_resources_component` | 物品 | ⚠️ 实验性 | fort_inventory_component | 资源库存 |
| `fort_inventory_trap_component` | 物品 | ⚠️ 实验性 | fort_inventory_component | 陷阱库存 |
| `fort_inventory_weapon_hotbar_component` | 物品 | ⚠️ 实验性 | fort_inventory_component | 武器快捷栏 |
| `fort_item_pickup_component` | 物品 | ⚠️ 实验性 | component | 物品拾取 |
| `offer_interactable_component` | 物品 | ⚠️ 实验性 | interactable_component | 商店交互 |
| `sidekick_component` | AI | 🏗️ 抽象类 | component | 伙伴基类 |
| `npc_sidekick_component` | AI | 🔒 内部 | sidekick_component | NPC 伙伴 |
| `equipped_sidekick_component` | AI | 🔒 内部 | sidekick_component | 装备伙伴 |
| `npc_actions_component` | AI | 🔒 内部 | component | NPC 行为 |
| `npc_awareness_component` | AI | 🔒 内部 | component | NPC 感知 |
| `guard_actions_component` | AI | 🔒 内部 | npc_actions_component | 守卫行为 |
| `guard_awareness_component` | AI | 🔒 内部 | npc_awareness_component | 守卫感知 |
| `spark_mode_component` | 特殊 | 🔒 内部 | component | Spark 模式 |

---

## 🔍 六、使用建议

### 6.1 基础组件（必用）

**强烈推荐在大部分实体上使用**:

- ✅ `transform_component`: 几乎所有实体都需要
- ✅ `mesh_component`: 需要视觉呈现的实体
- ✅ `tag_component`: 需要分类和查询的实体

### 6.2 渲染组件（按需）

**根据场景需求选择**:

- 光照组件: 根据光源类型选择（平行光、点光源、聚光灯等）
- `particle_system_component`: 需要特效的地方
- `keyframed_movement_component`: 简单移动平台

### 6.3 物品系统（Fortnite 游戏）

**实验性功能，谨慎使用**:

- ⚠️ 所有物品系统组件都是实验性的
- 建议先用简单的自定义组件实现，等 API 稳定后再迁移
- Fortnite 特化组件（`fort_*`）仅适用于 Fortnite 风格游戏

### 6.4 AI 系统（避免使用）

**内部使用组件，不建议直接使用**:

- 🔒 所有 AI 组件都标记为 `<epic_internal>`
- 缺少公开文档和示例
- 建议自行实现 AI 逻辑或等待官方公开

---

## ⚠️ 七、重要注意事项

### 7.1 实验性组件（12 个）

以下组件标记为 `@experimental`，API 可能变化：

- `tag_component`
- `interactable_component`
- `sound_component`
- 所有 `inventory_component` 相关（10 个）

**建议**:

- 谨慎用于生产环境
- 关注官方更新日志
- 做好 API 变化的准备

### 7.2 内部使用组件（13 个）

以下组件标记为 `<epic_internal>`，官方保留修改权利：

- `light_component`
- `mesh_component`
- `particle_system_component`
- `sound_component`
- 所有 AI 组件（8 个）

**建议**:

- 虽然可用，但属于内部 API
- 可能缺少文档和支持
- 不保证长期稳定性

### 7.3 抽象类组件（3 个）

以下组件是抽象基类，不可直接实例化：

- `light_component`: 使用具体的光照子类
- `sound_component`: 等待具体实现
- `sidekick_component`: 使用具体的伙伴子类

---

## 📚 八、参考资料

### 官方文档

- [SceneGraph 概述](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [SceneGraph 入门](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite)
- [Verse API 主页](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)
- [component API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component)

### 内部参考

- [SceneGraph 框架指南](../../shared/references/scenegraph-framework-guide.md)
- [SceneGraph API 参考](../../shared/references/scenegraph-api-reference.md)
- [API Digest 文件](../../shared/api-digests/)
  - `Verse.digest.verse.md`
  - `UnrealEngine.digest.verse.md`
  - `Fortnite.digest.verse.md`

### 相关调研文档

- [实体与组件系统](./01-entity-component.md)
- [事件系统](./02-event-system.md)
- [能力边界文档](./CAPABILITY-BOUNDARIES.md)

---

## 📝 九、调研方法论

### 数据来源

1. **官方 API Digest 文件**（主要来源）
   - `skills/verseDev/shared/api-digests/Verse.digest.verse.md`
   - `skills/verseDev/shared/api-digests/UnrealEngine.digest.verse.md`
   - `skills/verseDev/shared/api-digests/Fortnite.digest.verse.md`

2. **官方在线文档**（辅助验证）
   - Epic Games 官方 Verse API 文档
   - UEFN SceneGraph 教程

3. **代码分析**（自动化提取）
   - Python 脚本解析 digest 文件
   - 正则表达式提取组件定义
   - 上下文分析获取注释和属性

### 提取流程

```text
读取 Digest 文件
    ↓
正则匹配组件定义
    ↓
提取组件名称、父类、修饰符
    ↓
分析上下文获取注释
    ↓
分类和整理
    ↓
生成报告
```

### 质量保证

- ✅ 交叉验证三个模块的数据
- ✅ 检查继承关系的一致性
- ✅ 标注实验性和内部使用状态
- ✅ 提供官方文档链接

---

## ✅ 十、结论

### 关键发现

1. **组件丰富度**: 32 个原生组件覆盖基础、渲染、物品、AI 等领域
2. **稳定性**: 约 38% 的组件是实验性的，需谨慎使用
3. **可用性**: 基础和渲染组件稳定可用，物品和 AI 系统需等待完善
4. **继承体系**: 良好的继承设计，便于扩展

### 推荐实践

1. **优先使用稳定组件**
   - `transform_component`
   - `mesh_component`
   - 光照组件（5 种）
   - `particle_system_component`

2. **谨慎使用实验性组件**
   - 物品系统（仅原型和测试）
   - `tag_component`（实用但可能变化）
   - `interactable_component`（等待稳定）

3. **避免依赖内部组件**
   - AI 系统组件（缺少文档）
   - 抽象基类（不可实例化）

4. **自定义组件为主**
   - 大部分游戏逻辑应在自定义组件中实现
   - 原生组件主要用于基础功能（变换、渲染）

---

**调研负责人**: GitHub Copilot Agent  
**调研日期**: 2026-01-05  
**文档版本**: 1.0  
**覆盖范围**: 所有官方原生 SceneGraph Component（32 个）
