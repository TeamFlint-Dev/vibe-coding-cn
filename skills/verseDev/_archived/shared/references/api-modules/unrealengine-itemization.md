# UnrealEngine.com/Itemization API 模块参考文档

## 1. 模块概述

### 1.1 模块用途和设计理念

`/UnrealEngine.com/Itemization` 是 UEFN 中的**底层物品化系统基础 API**，提供了实现物品（Item）和库存（Inventory）系统的核心组件和接口。该模块遵循以下设计理念：

- **组件化架构**：基于 Entity-Component 模式，通过 `item_component` 和 `inventory_component` 实现物品和库存功能
- **事件驱动**：使用 `scene_event` 和 `listenable` 机制实现物品状态变化的响应式编程
- **查询-验证模式**：通过 `query_event` 允许多个系统参与物品操作的验证和否决
- **结果类型安全**：使用 `result(T, E)` 类型处理可能失败的操作，强制错误处理
- **分层存储**：支持库存嵌套（子库存），形成树形结构管理物品

### 1.2 适用场景说明

本模块适用于需要实现以下功能的游戏开发场景：

- **库存系统**：背包、装备栏、仓库等物品存储功能
- **物品管理**：物品的添加、移除、堆叠、合并等操作
- **装备系统**：武器、装备的装备/卸下功能
- **物品交互**：拾取、丢弃、转移等物品交互行为
- **自定义物品行为**：通过继承和接口扩展实现特定物品逻辑

### 1.3 与 Fortnite.com/Itemization 的区别和联系

| 对比维度 | UnrealEngine.com/Itemization | Fortnite.com/Itemization |
|---------|------------------------------|--------------------------|
| **定位** | 底层基础 API | 高层 Fortnite 专用 API |
| **抽象层级** | 通用组件和接口 | Fortnite 游戏特化实现 |
| **类数量** | 18 个核心类/接口 | 1260+ 类（包含大量具体物品） |
| **依赖关系** | 被 Fortnite.com/Itemization 依赖 | 依赖并扩展 UnrealEngine.com/Itemization |
| **使用场景** | 自定义物品系统开发 | 使用 Fortnite 内置物品和库存 |

**关系说明**：

```verse
// Fortnite.com/Itemization 使用 UnrealEngine.com/Itemization
using {/UnrealEngine.com/Itemization}

// fort_inventory_component 继承自 inventory_component
fort_inventory_component<native><public> := class<epic_internal>(inventory_component)
```

**选择建议**：

- 如需使用 Fortnite 内置武器、道具 → 使用 `Fortnite.com/Itemization`
- 如需开发自定义物品和库存系统 → 使用 `UnrealEngine.com/Itemization`

---

## 2. 核心类/接口清单

### 2.1 核心组件类（2个）

| 类名 | 用途 | 继承关系 |
|------|------|----------|
| `inventory_component` | 库存组件，持有和管理物品 | 继承自 `component` |
| `item_component` | 物品组件，标识实体为物品 | 继承自 `component` |

### 2.2 辅助组件类（3个）

| 类名 | 用途 | 继承关系 |
|------|------|----------|
| `item_details_component` | 物品详情（名称、描述） | 继承自 `component, has_description` |
| `item_icon_component` | 物品图标 | 继承自 `component, has_icon` |
| `item_category` | 物品分类标识 | 独立类 |

### 2.3 操作结果类（7个）

| 类名 | 用途 | 返回场景 |
|------|------|----------|
| `add_item_result` | 添加物品操作的结果 | `AddItem` 成功时返回 |
| `remove_item_result` | 移除物品操作的结果 | `RemoveItem` 成功时返回 |
| `equip_item_result` | 装备物品操作的结果 | 装备事件触发时返回 |
| `unequip_item_result` | 卸下物品操作的结果 | 卸下事件触发时返回 |
| `change_inventory_result` | 物品更换库存的结果 | `ChangeInventoryEvent` 时返回 |
| `change_equipped_result` | 装备状态变化的结果 | `ChangeEquippedEvent` 时返回 |
| `change_stack_size_result` | 堆叠数量变化的结果 | `ChangeStackSizeEvent` 时返回 |
| `change_max_stack_size_result` | 最大堆叠数变化的结果 | `ChangeMaxStackSizeEvent` 时返回 |

### 2.4 错误类型（4个）

| 类名 | 用途 | 使用场景 |
|------|------|----------|
| `add_item_error` | 添加物品失败的错误类型 | `AddItem` 失败时返回 |
| `remove_item_error` | 移除物品失败的错误类型 | `RemoveItem` 失败时返回 |
| `equip_item_error` | 装备物品失败的错误类型 | `Equip` 失败时返回 |
| `unequip_item_error` | 卸下物品失败的错误类型 | `Unequip` 失败时返回 |

### 2.5 事件类（6个）

| 类名 | 用途 | 事件类型 |
|------|------|----------|
| `find_inventory_event` | 查找合适库存的事件（向下传播） | `scene_event` |
| `add_item_query_event` | 添加物品查询事件（向上传播） | `scene_event` |
| `remove_item_query_event` | 移除物品查询事件（向上传播） | `scene_event` |
| `equip_item_query_event` | 装备物品查询事件 | `scene_event` |
| `unequip_item_query_event` | 卸下物品查询事件 | `scene_event` |

### 2.6 接口（1个）

| 接口名 | 用途 | 实现场景 |
|--------|------|----------|
| `has_item_merge_rules` | 物品合并规则接口 | 需要自定义物品合并逻辑时实现 |

---

## 3. 关键 API 详解

### 3.1 inventory_component - 库存组件

#### 3.1.1 添加物品

```verse
AddItem<native><final><public>(
    Item:entity, 
    ?AllowMergeItems:logic = external {}
)<transacts>:result(add_item_result, []add_item_error)
```

**参数**：

- `Item: entity` - 要添加的物品实体（必须包含 `item_component`）
- `AllowMergeItems: logic` - 是否允许与现有物品合并（可选，默认值由引擎决定）

**返回值**：

- 成功：`add_item_result` 包含新添加和修改的物品信息
- 失败：`[]add_item_error` 错误列表

**使用限制**：

- 需要 `<transacts>` 效应，必须在事务上下文中调用
- 最低版本要求：`MinUploadedAtFNVersion := 3800`

#### 3.1.2 移除物品

```verse
RemoveItem<native><final><public>(
    Item:entity
)<transacts>:result(remove_item_result, []remove_item_error)
```

**参数**：

- `Item: entity` - 要移除的物品实体

**返回值**：

- 成功：`remove_item_result` 包含移除的物品信息和数量
- 失败：`[]remove_item_error` 错误列表

**注意事项**：

- 会递归搜索子库存，可移除深层嵌套的物品
- 最低版本要求：`MinUploadedAtFNVersion := 3800`

#### 3.1.3 查询物品

```verse
# 获取直接子物品（不包含子库存中的物品）
GetItems<native><final><public>()<reads>:[]entity

# 获取特定类型的直接子物品
GetItems<native><final><public>(
    Type:castable_subtype(item_component)
)<reads>:[]entity

# 递归查找所有物品（包含子库存）
FindItems<native><final><public>()<reads>:generator(entity)

# 递归查找特定类型的所有物品
FindItems<native><final><public>(
    Type:castable_subtype(item_component)
)<reads>:[]entity
```

**区别**：

- `GetItems` - 只获取当前库存的直接子物品
- `FindItems` - 递归搜索所有子库存中的物品

#### 3.1.4 库存嵌套

```verse
# 获取直接子库存
GetInventories<native><final><public>()<reads>:[]inventory_component

# 递归查找所有子库存
FindInventories<native><final><public>()<reads>:generator(inventory_component)
```

#### 3.1.5 事件监听

```verse
AddItemEvent<native><final><public>:listenable(add_item_result)
RemoveItemEvent<native><final><public>:listenable(remove_item_result)
EquipItemEvent<native><final><public>:listenable(equip_item_result)
UnequipItemEvent<native><final><public>:listenable(unequip_item_result)
```

**使用方式**：

```verse
Inventory.AddItemEvent.Subscribe(OnItemAdded)

OnItemAdded(Result:add_item_result):void =
    # 处理物品添加事件
```

### 3.2 item_component - 物品组件

#### 3.2.1 装备和卸下

```verse
# 装备物品
Equip<final><native><public>()<transacts>:result(false, []equip_item_error)

# 卸下物品
Unequip<final><native><public>()<transacts>:result(false, []unequip_item_error)

# 检查是否已装备
IsEquipped<native><final><public>()<reads><decides>:void
```

**注意事项**：

- 物品必须已经在库存中才能装备
- `IsEquipped` 使用 `<decides>` 效应，成功表示已装备，失败表示未装备
- 最低版本要求：`MinUploadedAtFNVersion := 3800`

#### 3.2.2 堆叠管理

```verse
# 当前堆叠数量（只读）
var<private> StackSize<native><public>:int

# 设置堆叠数量
SetStackSize<final><native><public>(NewStackSize:int)<transacts>:void

# 最大堆叠数量（只读）
var<private> MaxStackSize<native><public>:?int

# 设置最大堆叠数量
SetMaxStackSize<final><native><public>(
    NewMaxStackSize:int, 
    ?ClampStackSize:logic = external {}
)<transacts>:void
```

**注意事项**：

- `MaxStackSize` 为 `?int` 可选类型，`false` 表示无限堆叠
- `ClampStackSize` 为 `true` 时，会将 `StackSize` 限制在新的 `MaxStackSize` 内

#### 3.2.3 物品合并

```verse
# 检查是否可以合并到目标物品
CanMergeInto<final><native_callable><public>(
    TargetItem:entity
)<reads><decides>:void

# 合并到目标物品
MergeInto<final><native_callable><public>(
    TargetItem:entity, 
    ?TargetAmount:?int = external {}
)<transacts><decides>:void

# 可合并的物品类型列表
MergeableItemComponentClasses<native><public>:[]castable_subtype(item_component)
```

**合并条件**：

1. 目标物品类型在 `MergeableItemComponentClasses` 列表中
2. 通过 `has_item_merge_rules` 接口的自定义验证（如果实现）
3. 不能与自身合并

#### 3.2.4 拾取和丢弃

```verse
# 拾取物品到库存
PickUp<native><public>(Inventory:inventory_component)<transacts><decides>:void

# 丢弃物品到世界
Drop<native><public>()<transacts><decides>:void
```

**使用限制**：

- `PickUp` 要求物品不在任何库存中
- `Drop` 要求物品不是已经处于丢弃状态（pickup）

#### 3.2.5 物品分割

```verse
Take<native><public>(Amount:int)<transacts><decides>:entity
```

**重要说明**：

- **默认实现会失败**，必须在子类中重写此方法
- 需要创建一个新的 `entity`，包含新的 `item_component`
- 新实体不应在任何库存中
- 如果 `Amount` 等于当前堆叠数量，应返回物品自身

---

## 4. 代码示例

### 4.1 基础物品和库存创建

```verse
using { /UnrealEngine.com/Itemization }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# 创建自定义物品组件
my_item_component := class(item_component):
    # 继承 item_component 的所有功能

# 创建自定义库存组件
my_inventory_component := class(inventory_component):
    # 继承 inventory_component 的所有功能

# 使用示例
CreateInventoryWithItem<public>()<transacts>:void =
    # 创建库存实体
    InventoryEntity := entity:
        Components := array:
            my_inventory_component{}
    
    # 创建物品实体
    ItemEntity := entity:
        Components := array:
            my_item_component:
                StackSize := 1
                MaxStackSize := option{99}
    
    # 获取库存组件
    if (Inventory := InventoryEntity.GetComponent(my_inventory_component)):
        # 添加物品到库存
        AddResult := Inventory.AddItem(ItemEntity)
        if (AddResult):
            Print("物品添加成功")
```

### 4.2 物品堆叠和合并

```verse
using { /UnrealEngine.com/Itemization }

# 定义可堆叠的物品
stackable_item := class(item_component):
    # 设置可合并的物品类型
    MergeableItemComponentClasses<override>:[]castable_subtype(item_component) = 
        array{stackable_item}

# 合并物品示例
MergeItems<public>(SourceItem:entity, TargetItem:entity)<transacts>:void =
    if (SourceComponent := SourceItem.GetComponent(item_component)):
        # 检查是否可以合并
        if (SourceComponent.CanMergeInto(TargetItem)):
            # 执行合并（合并10个）
            SourceComponent.MergeInto(TargetItem, option{10})
            Print("物品合并成功")
        else:
            Print("物品无法合并")
```

### 4.3 装备系统实现

```verse
using { /UnrealEngine.com/Itemization }

# 装备槽组件
equipment_slot := class(inventory_component):
    var CurrentEquippedItem<public>:?entity = false
    
    # 监听装备事件
    OnEquipItem(Result:equip_item_result):void =
        set CurrentEquippedItem = option{Result.Item}
        Print("装备了物品")
    
    # 监听卸下事件
    OnUnequipItem(Result:unequip_item_result):void =
        set CurrentEquippedItem = false
        Print("卸下了物品")

# 初始化装备槽
InitEquipmentSlot<public>(SlotEntity:entity)<suspends>:void =
    if (Slot := SlotEntity.GetComponent(equipment_slot)):
        # 订阅装备事件
        Slot.EquipItemEvent.Subscribe(Slot.OnEquipItem)
        Slot.UnequipItemEvent.Subscribe(Slot.OnUnequipItem)

# 装备物品
EquipItem<public>(Item:entity)<transacts>:void =
    if (ItemComp := Item.GetComponent(item_component)):
        EquipResult := ItemComp.Equip()
        if (EquipResult):
            Print("装备成功")
        else:
            Print("装备失败")
```

### 4.4 物品拾取和丢弃

```verse
using { /UnrealEngine.com/Itemization }
using { /Verse.org/Simulation }

# 拾取地面物品
PickupGroundItem<public>(Player:entity, Item:entity)<transacts>:void =
    # 获取玩家的库存
    if (PlayerInventory := Player.GetComponent(inventory_component)):
        if (ItemComp := Item.GetComponent(item_component)):
            # 尝试拾取物品
            if (ItemComp.PickUp(PlayerInventory)):
                Print("拾取成功")
            else:
                Print("拾取失败，库存可能已满")

# 丢弃物品到世界
DropItemToWorld<public>(Item:entity)<transacts>:void =
    if (ItemComp := Item.GetComponent(item_component)):
        # 丢弃物品
        if (ItemComp.Drop()):
            Print("丢弃成功，物品已出现在世界中")
        else:
            Print("丢弃失败")
```

### 4.5 自定义物品分割逻辑

```verse
using { /UnrealEngine.com/Itemization }
using { /Verse.org/SceneGraph }

# 可分割的物品
splittable_item := class(item_component):
    # 重写 Take 方法实现分割
    Take<override>(Amount:int)<transacts><decides>:entity =
        CurrentStack := StackSize
        
        # 如果取走全部，返回自身
        if (Amount >= CurrentStack):
            return Self.GetEntity()
        
        # 创建新物品实体
        NewItemEntity := entity:
            Components := array:
                splittable_item:
                    StackSize := Amount
                    MaxStackSize := MaxStackSize
        
        # 减少当前物品的堆叠数
        SetStackSize(CurrentStack - Amount)
        
        return NewItemEntity

# 使用分割功能
SplitItem<public>(Item:entity, SplitAmount:int)<transacts>:?entity =
    if (ItemComp := Item.GetComponent(splittable_item)):
        if (NewItem := ItemComp.Take(SplitAmount)):
            Print("分割成功，创建了新物品")
            return option{NewItem}
    
    return false
```

---

## 5. 常见误区澄清

### 5.1 误区一：混淆 UnrealEngine 和 Fortnite 的 Itemization 模块

❌ **错误认知**：

"我需要使用武器，所以导入 `/UnrealEngine.com/Itemization`"

✅ **正确理解**：

- **UnrealEngine.com/Itemization**：底层基础框架，用于开发**自定义**物品系统
- **Fortnite.com/Itemization**：包含 Fortnite 内置的 1260+ 武器、道具等具体物品类

**正确做法**：

```verse
# 使用 Fortnite 内置武器
using { /Fortnite.com/Itemization }
using { /Fortnite.com/Itemization/BallisticItems }

# 使用内置武器类
Weapon := item_striker_ar_common{}

# 开发自定义物品系统
using { /UnrealEngine.com/Itemization }

# 创建自定义物品
custom_potion := class(item_component):
    # 自定义逻辑
```

### 5.2 误区二：不理解 Get 和 Find 方法的区别

❌ **错误认知**：

"用 `GetItems()` 查找所有物品"

✅ **正确理解**：

- **GetItems/GetInventories**：只返回**直接子节点**
- **FindItems/FindInventories**：**递归搜索**所有后代节点

**示例场景**：

```verse
# 库存结构：
# 主背包 (MainInventory)
#   ├─ 武器1
#   ├─ 武器2
#   └─ 子背包 (SubInventory)
#       ├─ 道具1
#       └─ 道具2

# GetItems 只返回 [武器1, 武器2]
DirectItems := MainInventory.GetItems()  # 2 个物品

# FindItems 返回 [武器1, 武器2, 道具1, 道具2]
AllItems := MainInventory.FindItems()  # 4 个物品
```

### 5.3 误区三：忽略 result 类型的错误处理

❌ **错误代码**：

```verse
# 直接调用，忽略可能的失败
Inventory.AddItem(Item)
```

✅ **正确代码**：

```verse
# 使用 if 检查结果
AddResult := Inventory.AddItem(Item)
if (AddResult):
    # 处理成功情况
    Print("添加成功")
else:
    # 处理失败情况
    Errors := AddResult.Errors
    Print("添加失败")
```

### 5.4 误区四：没有重写 Take 方法就使用物品分割

❌ **错误理解**：

"所有物品都可以直接调用 `Take()` 方法分割"

✅ **正确理解**：

- `Take()` 方法**默认实现会失败**
- 必须在自定义物品类中**重写** `Take()` 方法
- 重写时需要创建新的实体并正确设置堆叠数量

**正确实现**：参见 [代码示例 4.5](#45-自定义物品分割逻辑)

### 5.5 误区五：不理解事件传播方向

❌ **错误理解**：

"所有事件都是向上传播的"

✅ **正确理解**：

| 事件类型 | 传播方向 | 用途 |
|---------|---------|------|
| `find_inventory_event` | **向下传播** | 查找最合适的库存接收物品 |
| `add_item_query_event` | **向上传播** | 验证并可能否决物品添加 |
| `remove_item_query_event` | **向上传播** | 验证并可能否决物品移除 |

**应用场景**：

```verse
# 场景：实现"VIP专用库存"，普通物品不能放入

vip_inventory := class(inventory_component):
    # 监听向上传播的查询事件
    OnAddItemQuery(Event:add_item_query_event):void =
        Item := Event.Item
        
        # 检查物品是否为 VIP 物品
        if (not IsVIPItem(Item)):
            # 添加错误，阻止物品添加
            Event.AddError(custom_vip_only_error{})
```

---

## 6. 最佳实践

### 6.1 推荐的使用模式

#### 6.1.1 分层库存设计

推荐使用嵌套库存实现复杂的物品管理：

```verse
# 玩家主库存
player_main_inventory := class(inventory_component):
    # 包含多个子库存

# 武器库存
weapon_inventory := class(inventory_component):
    # 专门存放武器

# 消耗品库存
consumable_inventory := class(inventory_component):
    # 专门存放消耗品

# 结构：
# PlayerInventory
#   ├─ WeaponInventory (武器子库存)
#   ├─ ConsumableInventory (消耗品子库存)
#   └─ EquipmentInventory (装备子库存)
```

**优势**：

- 逻辑清晰，易于管理
- 可以对不同子库存设置不同规则
- 支持使用 `FindItems()` 统一查询

#### 6.1.2 使用事件而非轮询

❌ **不推荐**：

```verse
# 每帧检查物品数量
loop:
    Items := Inventory.GetItems()
    if (Items.Length > PreviousCount):
        Print("添加了物品")
```

✅ **推荐**：

```verse
# 订阅事件
Inventory.AddItemEvent.Subscribe(OnItemAdded)

OnItemAdded(Result:add_item_result):void =
    Print("添加了物品")
```

#### 6.1.3 实现 has_item_merge_rules 接口自定义合并逻辑

```verse
# 自定义合并规则
quality_item := class(item_component, has_item_merge_rules):
    var Quality<public>:int = 1
    
    # 自定义合并条件：只有相同品质的物品才能合并
    CanMergeInto<override>(TargetItem:entity)<reads><decides>:void =
        if (TargetComp := TargetItem.GetComponent(quality_item)):
            if (Quality = TargetComp.Quality):
                return  # 成功，允许合并
        
        # 失败，品质不同
        fails
    
    # 合并时的自定义逻辑
    OnMergeInto<override>(TargetItem:entity, MergeAmount:int)<transacts>:void =
        Print("合并了 {MergeAmount} 个品质 {Quality} 的物品")
```

### 6.2 性能优化建议

#### 6.2.1 减少深度递归

**问题**：频繁使用 `FindItems()` 在深层嵌套库存中搜索会影响性能

**优化方案**：

1. 限制库存嵌套深度（建议不超过 3 层）
2. 使用 `GetItems()` 替代 `FindItems()`，手动控制搜索范围
3. 缓存常用查询结果

```verse
# 不推荐：每次都递归搜索
AllWeapons := MainInventory.FindItems(weapon_component)

# 推荐：直接访问武器子库存
if (WeaponInv := GetWeaponInventory(MainInventory)):
    Weapons := WeaponInv.GetItems(weapon_component)
```

#### 6.2.2 批量操作优化

**问题**：逐个添加/移除物品会触发多次事件

**优化方案**：

```verse
# 设计支持批量操作的自定义方法
BatchAddItems<public>(Inventory:inventory_component, Items:[]entity)<transacts>:void =
    for (Item : Items):
        Inventory.AddItem(Item)
    
    # 只触发一次批量完成事件
    OnBatchOperationComplete()
```

#### 6.2.3 避免在事件处理中执行重操作

```verse
# ❌ 不推荐：在事件中进行复杂计算
OnItemAdded(Result:add_item_result):void =
    # 遍历所有物品统计价值（性能差）
    AllItems := Inventory.FindItems()
    TotalValue := CalculateTotalValue(AllItems)

# ✅ 推荐：维护增量更新的缓存
var TotalValue<private>:int = 0

OnItemAdded(Result:add_item_result):void =
    # 只更新增量
    for (AddedItem : Result.AddedItems):
        if (ItemComp := AddedItem.GetComponent(item_component)):
            set TotalValue += GetItemValue(ItemComp)
```

### 6.3 与其他模块的配合使用

#### 6.3.1 与 SceneGraph 结合实现物品拾取

```verse
using { /UnrealEngine.com/Itemization }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# 物品拾取触发器
item_pickup_trigger := class(trigger_component):
    ItemEntity<public>:entity
    
    OnTriggerEnter<override>(TriggerEvent:trigger_event):void =
        if (Player := TriggerEvent.TriggeringEntity):
            if (PlayerInv := Player.GetComponent(inventory_component)):
                if (ItemComp := ItemEntity.GetComponent(item_component)):
                    ItemComp.PickUp(PlayerInv)
```

#### 6.3.2 与 Simulation 结合实现物品生成

```verse
using { /UnrealEngine.com/Itemization }
using { /Verse.org/Simulation }

# 物品生成器
item_spawner := class:
    SpawnItem<public>(ItemClass:subtype(item_component))<transacts>:entity =
        NewItem := entity:
            Components := array:
                ItemClass{}
                transform_component:
                    Translation := vector3{X:=0.0, Y:=0.0, Z:=0.0}
        
        return NewItem
```

#### 6.3.3 与 UI 模块结合显示库存

```verse
using { /UnrealEngine.com/Itemization }
using { /Fortnite.com/UI }

# 库存 UI 管理器
inventory_ui_manager := class:
    UpdateInventoryDisplay<public>(Inventory:inventory_component):void =
        Items := Inventory.GetItems()
        
        for (Item : Items, Index := 0..Items.Length):
            if (ItemComp := Item.GetComponent(item_component)):
                # 显示物品信息
                DisplayItemInSlot(Index, ItemComp)
```

---

## 7. 参考资源

### 7.1 官方文档

- **Epic Games UEFN 文档**：[https://dev.epicgames.com/documentation/en-us/uefn](https://dev.epicgames.com/documentation/en-us/uefn)
- **Verse API 参考**：查看 UEFN 编辑器内的 API 文档
- **Itemization 系统指南**：[https://dev.epicgames.com/documentation/en-us/uefn/itemization-in-verse](https://dev.epicgames.com/documentation/en-us/uefn/itemization-in-verse)

### 7.2 相关 API 模块

#### 7.2.1 依赖的模块

```verse
using {/Verse.org/Assets}        # 资源管理
using {/Verse.org/Presentation}  # 展示层
using {/Verse.org/Simulation}    # 模拟系统
using {/Verse.org/Native}        # 原生功能
using {/Verse.org/SceneGraph}    # 场景图和组件系统
```

#### 7.2.2 相关的 API 模块

| 模块路径 | 关系说明 |
|---------|---------|
| `/Fortnite.com/Itemization` | 继承并扩展本模块，提供 Fortnite 特化实现 |
| `/Verse.org/SceneGraph` | 提供 `entity` 和 `component` 基础类型 |
| `/Verse.org/Simulation` | 提供 `player` 等模拟相关类型 |

### 7.3 内部参考文档

- [API 模块清单](./api-modules-list.md) - 所有 API 模块的索引
- [API 模块能力调研报告](./api-modules-research.md) - 模块能力详细分析
- [SceneGraph API 参考](./scenegraph-api-reference.md) - 场景图框架说明
- [UnrealEngine API Digest](../api-digests/UnrealEngine.digest.verse.md) - 完整 API 定义
- [Fortnite API Digest](../api-digests/Fortnite.digest.verse.md) - Fortnite 扩展 API

### 7.4 版本信息

- **API 来源版本**：`++Fortnite+Release-39.11-CL-49242330`
- **最低支持版本**：部分 API 需要 `MinUploadedAtFNVersion >= 2930/3200/3800`
- **实验性标记**：所有类和接口都标记为 `@experimental`，API 可能在未来版本变化

---

## 附录：完整类型签名速查

### A.1 inventory_component 方法速查

| 方法 | 签名 | 最低版本 |
|------|------|----------|
| AddItem | `(Item:entity, ?AllowMergeItems:logic)<transacts>:result(add_item_result, []add_item_error)` | 3800 |
| RemoveItem | `(Item:entity)<transacts>:result(remove_item_result, []remove_item_error)` | 3800 |
| GetItems | `()<reads>:[]entity` | - |
| GetItems | `(Type:castable_subtype(item_component))<reads>:[]entity` | 3200 |
| FindItems | `()<reads>:generator(entity)` | 2930 |
| FindItems | `(Type:castable_subtype(item_component))<reads>:[]entity` | 3200 |
| GetInventories | `()<reads>:[]inventory_component` | - |
| FindInventories | `()<reads>:generator(inventory_component)` | 2930 |
| GetEquippedItems | `():[]entity` | - |
| CanAddItem | `(Item:entity, ?AllowMergeItems:logic)<transacts>:result(false, []add_item_error)` | 3800 |
| CanRemoveItem | `(Item:entity)<transacts>:result(false, []remove_item_error)` | 3800 |

### A.2 item_component 方法速查

| 方法 | 签名 | 最低版本 |
|------|------|----------|
| GetParentInventory | `()<reads><decides>:inventory_component` | - |
| IsEquipped | `()<reads><decides>:void` | - |
| Equip | `()<transacts>:result(false, []equip_item_error)` | 3800 |
| Unequip | `()<transacts>:result(false, []unequip_item_error)` | 3800 |
| Take | `(Amount:int)<transacts><decides>:entity` | - |
| CanMergeInto | `(TargetItem:entity)<reads><decides>:void` | - |
| MergeInto | `(TargetItem:entity, ?TargetAmount:?int)<transacts><decides>:void` | - |
| SetStackSize | `(NewStackSize:int)<transacts>:void` | - |
| SetMaxStackSize | `(NewMaxStackSize:int, ?ClampStackSize:logic)<transacts>:void` | - |
| Drop | `()<transacts><decides>:void` | - |
| PickUp | `(Inventory:inventory_component)<transacts><decides>:void` | - |
| CanEquip | `()<transacts>:result(false, []equip_item_error)` | 3800 |
| CanUnequip | `()<transacts>:result(false, []unequip_item_error)` | 3800 |

---

**文档维护信息**：

- **创建日期**：2026-01-04
- **最后更新**：2026-01-04
- **维护者**：UEFN Agent Team
- **文档版本**：v1.0
