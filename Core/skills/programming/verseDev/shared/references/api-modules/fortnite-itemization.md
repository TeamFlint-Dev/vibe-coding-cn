# Fortnite.com/Itemization 模块完整参考

## 模块概述

### 基本信息

- **完整路径**: `/Fortnite.com/Itemization`
- **模块规模**: 1260+ 类定义，41 个子模块
- **代码行数**: 约 3972 行
- **API 版本**: Fortnite+Release-39.11-CL-49242330

### 设计理念

`/Fortnite.com/Itemization` 模块是 Fortnite Creative 中最大的 API 模块之一，专门用于管理游戏内的物品化系统（Itemization System）。该模块提供了：

1. **预制物品库**：包含 Fortnite 各个赛季的武器、道具、消耗品等游戏物品
2. **物品分类系统**：通过 `item_category` 对物品进行分类管理
3. **物品拾取组件**：`fort_item_pickup_component` 用于控制物品的拾取行为

### 适用场景

该模块适用于以下开发场景：

- **武器系统**：需要在地图中放置或生成各种 Fortnite 武器
- **战利品系统**：实现宝箱、战利品掉落等功能
- **物品管理**：创建自定义的物品收集和使用机制
- **赛季主题游戏**：使用特定赛季的物品集合重现游戏体验
- **PvP/PvE 玩法**：配置战斗所需的武器和道具

### 与其他模块的关系

`/Fortnite.com/Itemization` 主要依赖和配合以下模块：

- **`/UnrealEngine.com/Itemization`**：底层物品化系统，提供 `item_component`、`inventory_component` 等核心组件
- **`/Verse.org/SceneGraph`**：所有物品类都继承自 `entity`，需要场景图支持
- **`/Fortnite.com/Devices`**：设备系统中的物品生成器等设备会使用此模块的物品
- **`/Fortnite.com/Characters`**：角色系统与物品系统交互（装备、使用物品）

## 核心类/接口清单

### 按功能分类

#### 1. 物品分类系统（FortniteItemCategories）

**模块路径**: `/Fortnite.com/Itemization/FortniteItemCategories`

| 类名 | 类型 | 用途 |
|------|------|------|
| `WorldItem` | `item_category` | 世界物品分类（可在世界中拾取的物品） |
| `Currency` | `item_category` | 货币分类（金币、资源等） |
| `Collectible` | `item_category` | 收藏品分类（特殊收集物） |
| `Trap` | `item_category` | 陷阱分类（各类陷阱道具） |
| `Ammo` | `item_category` | 弹药分类（武器弹药） |

#### 2. 物品拾取组件

| 类名 | 类型 | 用途 |
|------|------|------|
| `fort_item_pickup_component` | `component` | Fortnite 特有的物品拾取组件，控制物品拾取行为和生命周期 |

**核心属性**：

- `PickupLifetime: float` - 物品拾取的存在时长（秒）

**核心方法**：

- `OnBeginSimulation(): void` - 模拟开始时调用
- `OnEndSimulation(): void` - 模拟结束时调用

#### 3. 赛季物品子模块（41 个）

Fortnite Itemization 按赛季和主题组织了 41 个子模块，每个子模块包含该赛季/主题的物品集合：

##### Chapter 1 赛季物品

| 子模块名 | 导入路径 | 主要内容 |
|---------|---------|---------|
| CH1S1Items | `/Fortnite.com/Itemization/CH1S1Items` | 第一章第1赛季物品（南瓜发射器、瞬移果汁等） |
| CH1S2Items | `/Fortnite.com/Itemization/CH1S2Items` | 第一章第2赛季物品（脉冲手雷等） |
| CH1S3Items | `/Fortnite.com/Itemization/CH1S3Items` | 第一章第3赛季物品（猎枪等） |
| CH1S4Items | `/Fortnite.com/Itemization/CH1S4Items` | 第一章第4赛季物品（爆裂突击步枪等） |
| CH1S5Items | `/Fortnite.com/Itemization/CH1S5Items` | 第一章第5赛季物品（冲锋枪变体） |
| CH1S6Items | `/Fortnite.com/Itemization/CH1S6Items` | 第一章第6赛季物品（泵动霰弹枪史诗/传奇） |
| CH1S7Items | `/Fortnite.com/Itemization/CH1S7Items` | 第一章第7赛季物品 |
| CH1S8Items | `/Fortnite.com/Itemization/CH1S8Items` | 第一章第8赛季物品（步兵步枪） |
| CH1S9Items | `/Fortnite.com/Itemization/CH1S9Items` | 第一章第9赛季物品（左轮手枪史诗/传奇） |
| CH1SXItems | `/Fortnite.com/Itemization/CH1SXItems` | 第一章第X赛季物品 |

##### Chapter 2 赛季物品

| 子模块名 | 导入路径 | 主要内容 |
|---------|---------|---------|
| CH2S1Items | `/Fortnite.com/Itemization/CH2S1Items` | 第二章第1赛季物品 |
| CH2S2Items | `/Fortnite.com/Itemization/CH2S2Items` | 第二章第2赛季物品 |
| CH2S3Items | `/Fortnite.com/Itemization/CH2S3Items` | 第二章第3赛季物品 |
| CH2S4Items | `/Fortnite.com/Itemization/CH2S4Items` | 第二章第4赛季物品 |
| CH2S5Items | `/Fortnite.com/Itemization/CH2S5Items` | 第二章第5赛季物品 |

##### Chapter 4+ 赛季物品

| 子模块名 | 导入路径 | 主要内容 |
|---------|---------|---------|
| CH4S1Items | `/Fortnite.com/Itemization/CH4S1Items` | 第四章第1赛季物品 |
| CH6MS2Items | `/Fortnite.com/Itemization/CH6MS2Items` | 第六章混音第2赛季物品 |
| CH7S1Items | `/Fortnite.com/Itemization/CH7S1Items` | 第七章第1赛季物品 |

##### 主题物品集合

| 子模块名 | 导入路径 | 主题说明 | 代表物品 |
|---------|---------|---------|---------|
| AbsoluteDoomItems | `/Fortnite.com/Itemization/AbsoluteDoomItems` | 绝对毁灭主题 | 电锯、双微冲、模块化武器 |
| BallisticItems | `/Fortnite.com/Itemization/BallisticItems` | 弹道主题 | 气泡护盾、爆裂步枪、鼓式枪 |
| CreativeItems | `/Fortnite.com/Itemization/CreativeItems` | 创造模式专属物品 | - |
| CubedItems | `/Fortnite.com/Itemization/CubedItems` | 立方主题 | - |
| FlippedItems | `/Fortnite.com/Itemization/FlippedItems` | 翻转主题 | - |
| FortniteOGItems | `/Fortnite.com/Itemization/FortniteOGItems` | 原始经典物品 | 经典武器变体 |
| HuntersItems | `/Fortnite.com/Itemization/HuntersItems` | 猎人主题 | 猎枪、精准冲锋枪 |
| InvasionItems | `/Fortnite.com/Itemization/InvasionItems` | 入侵主题 | - |
| LastResortItems | `/Fortnite.com/Itemization/LastResortItems` | 最后手段主题 | - |
| LawlessItems | `/Fortnite.com/Itemization/LawlessItems` | 无法主题 | - |
| MEGAItems | `/Fortnite.com/Itemization/MEGAItems` | 超大主题 | 冲锋枪史诗/传奇版本 |
| MythsAndMortalsItems | `/Fortnite.com/Itemization/MythsAndMortalsItems` | 神话与凡人主题 | - |
| ParadiseItems | `/Fortnite.com/Itemization/ParadiseItems` | 天堂主题 | - |
| PreSeasonItems | `/Fortnite.com/Itemization/PreSeasonItems` | 预备赛季物品 | 基础武器系列 |
| PrimalItems | `/Fortnite.com/Itemization/PrimalItems` | 原始主题 | - |
| RebellionItems | `/Fortnite.com/Itemization/RebellionItems` | 叛军主题 | - |
| ShockNAwesomeItems | `/Fortnite.com/Itemization/ShockNAwesomeItems` | 震撼主题 | 南瓜发射器变体、瞬移果汁 |
| SuperItems | `/Fortnite.com/Itemization/SuperItems` | 超级主题 | - |
| UndergroundItems | `/Fortnite.com/Itemization/UndergroundItems` | 地下主题 | - |
| VibinItems | `/Fortnite.com/Itemization/VibinItems` | 律动主题 | - |
| WildsItems | `/Fortnite.com/Itemization/WildsItems` | 荒野主题 | - |
| WreckedItems | `/Fortnite.com/Itemization/WreckedItems` | 残破主题 | - |

#### 4. 典型物品类示例

所有物品类都继承自 `entity`，采用统一的命名模式：

**命名规则**：`item_{武器类型}_{品质等级}`

**品质等级**：

- `common` - 普通（灰色）
- `uncommon` - 罕见（绿色）
- `rare` - 稀有（蓝色）
- `epic` - 史诗（紫色）
- `legendary` - 传奇（金色）

**武器类型示例**：

| 类名 | 中文名称 | 所属模块 |
|------|---------|---------|
| `item_assault_rifle_common` | 普通突击步枪 | 多个模块 |
| `item_pump_shotgun_legendary` | 传奇泵动霰弹枪 | FortniteOGItems 等 |
| `item_burst_assault_rifle_epic` | 史诗爆裂突击步枪 | CH1S4Items 等 |
| `item_submachine_gun_rare` | 稀有冲锋枪 | CH1S5Items 等 |
| `item_hunting_rifle_uncommon` | 罕见猎枪 | HuntersItems 等 |
| `item_revolver_epic` | 史诗左轮手枪 | CH1S9Items 等 |
| `item_grenade` | 手雷 | 多个模块 |
| `item_slurp_juice` | 瞬移果汁 | ShockNAwesomeItems 等 |
| `item_pumpkin_launcher_legendary` | 传奇南瓜发射器 | ShockNAwesomeItems 等 |
| `item_chainsaw` | 电锯 | AbsoluteDoomItems |

## 关键 API 详解

### fort_item_pickup_component

#### 类定义

```verse
fort_item_pickup_component<native><final><public> := class<final_super>(component):
    var<private> PickupLifetime<native><public>:float
    OnBeginSimulation<override>():void
    OnEndSimulation<override>():void
```

#### 属性详解

##### PickupLifetime

- **类型**: `float`
- **访问**: `public`（可读写）
- **用途**: 设置物品拾取在世界中的存在时长（秒）
- **默认值**: 由 UEFN 引擎决定（通常为 60-120 秒）
- **注意事项**: 设置为 `-1.0` 表示永不消失

#### 方法详解

##### OnBeginSimulation()

- **签名**: `OnBeginSimulation<override>():void`
- **触发时机**: 游戏模拟开始时
- **用途**: 初始化物品拾取组件的状态
- **注意事项**: 这是重写方法，需要在自定义组件中调用父类实现

##### OnEndSimulation()

- **签名**: `OnEndSimulation<override>():void`
- **触发时机**: 游戏模拟结束时
- **用途**: 清理物品拾取组件的状态
- **注意事项**: 这是重写方法，确保正确清理资源

### item_category（来自 UnrealEngine.com/Itemization）

#### 定义

```verse
item_category<native><public> := class<castable><concrete><unique><final>
```

#### 用途说明

- **分类系统**: 用于对物品进行分类管理
- **预定义分类**: Fortnite 提供了 5 个预定义分类（WorldItem、Currency、Collectible、Trap、Ammo）
- **可扩展**: 理论上可以创建自定义分类，但需要引擎支持

#### 使用限制

- **不可实例化**: 这是一个抽象基类，使用预定义的分类常量
- **仅用于标识**: 主要用于物品识别和过滤

### 物品实体类（item_* classes）

#### 通用特征

所有 `/Fortnite.com/Itemization/*` 下的物品类都具有以下特征：

```verse
item_xxx<public> := class<final><concrete>(entity)
```

- **继承**: 所有物品类都继承自 `entity`（来自 `/Verse.org/SceneGraph`）
- **final**: 不可被继承
- **concrete**: 可以实例化
- **experimental**: 标记为实验性 API

#### 实例化和使用

**重要**: `/Fortnite.com/Itemization` 中的物品类**不能直接在 Verse 代码中实例化**！

这些类是：

1. **引用类型**：用于在 UEFN 编辑器中配置设备（如物品生成器）
2. **资产标识符**：表示特定的游戏物品资产

正确的使用方式是：

- 在 UEFN 编辑器中将物品放置到地图上
- 使用设备（如 Item Granter）配置物品
- 在 Verse 代码中通过 `inventory_component` 和 `item_component` 操作物品实例

## 代码示例

### 示例 1：检测玩家拾取特定物品

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Itemization }
using { /Verse.org/Concurrency }

item_pickup_tracker := class(creative_device):
    
    # 监听玩家物品变化
    MonitorPlayerInventory(Player: player): void =
        if:
            FortCharacter := Player.GetFortCharacter[]
            InventoryComp := FortCharacter.GetComponent[inventory_component][]
        then:
            # 订阅物品添加事件
            InventoryComp.AddItemEvent.Subscribe(OnItemAdded)
            
    # 物品添加回调
    OnItemAdded(Result: add_item_result): void =
        Print("玩家获得了新物品！")
        if:
            ItemComp := Result.ItemComponent
            ParentInventory := ItemComp.GetParentInventory[]
        then:
            StackSize := ItemComp.StackSize
            Print("物品堆叠数量: {StackSize}")
```

### 示例 2：自定义物品拾取生命周期

```verse
using { /Fortnite.com/Itemization }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

custom_pickup_manager := class(creative_device):
    
    # 配置物品拾取的生命周期
    ConfigurePickupLifetime(ItemEntity: entity, Lifetime: float): void =
        if:
            PickupComp := ItemEntity.GetComponent[fort_item_pickup_component][]
        then:
            # 设置拾取存在时长（秒）
            set PickupComp.PickupLifetime = Lifetime
            Print("物品拾取时长设置为: {Lifetime} 秒")
            
    # 创建永久物品拾取（不消失）
    MakePermanentPickup(ItemEntity: entity): void =
        ConfigurePickupLifetime(ItemEntity, -1.0)
```

### 示例 3：按物品分类过滤库存

```verse
using { /Fortnite.com/Itemization/FortniteItemCategories }
using { /UnrealEngine.com/Itemization }
using { /Fortnite.com/Characters }

inventory_filter := class(creative_device):
    
    # 获取玩家背包中的所有武器（WorldItem 分类）
    GetPlayerWeapons(Player: player): []entity =
        var Weapons: []entity = array{}
        
        if:
            FortCharacter := Player.GetFortCharacter[]
            InventoryComp := FortCharacter.GetComponent[inventory_component][]
        then:
            # 获取所有物品
            AllItems := InventoryComp.GetItems()
            
            # 过滤出武器类物品
            for (Item : AllItems):
                if:
                    ItemComp := Item.GetComponent[item_component][]
                    Categories := ItemComp.Categories
                then:
                    # 检查是否属于 WorldItem 分类
                    for (Category : Categories):
                        if (Category = WorldItem):
                            set Weapons += array{Item}
                            
        return Weapons
        
    # 统计特定分类的物品数量
    CountItemsByCategory(Inventory: inventory_component, TargetCategory: item_category): int =
        var Count: int = 0
        AllItems := Inventory.GetItems()
        
        for (Item : AllItems):
            if:
                ItemComp := Item.GetComponent[item_component][]
                Categories := ItemComp.Categories
            then:
                for (Category : Categories):
                    if (Category = TargetCategory):
                        set Count += 1
                        
        return Count
```

### 示例 4：物品堆叠管理

```verse
using { /UnrealEngine.com/Itemization }
using { /Verse.org/Simulation }

item_stack_manager := class(creative_device):
    
    # 设置物品的堆叠数量
    SetItemStack(ItemEntity: entity, Amount: int): void =
        if:
            ItemComp := ItemEntity.GetComponent[item_component][]
        then:
            # 设置堆叠数量
            ItemComp.SetStackSize(Amount)
            Print("物品堆叠设置为: {Amount}")
            
    # 设置物品的最大堆叠数
    SetMaxStackSize(ItemEntity: entity, MaxAmount: int): void =
        if:
            ItemComp := ItemEntity.GetComponent[item_component][]
        then:
            # 设置最大堆叠数，并自动调整当前堆叠到上限
            ItemComp.SetMaxStackSize(MaxAmount, true)
            Print("最大堆叠设置为: {MaxAmount}")
            
    # 尝试合并两个物品
    TryMergeItems(SourceItem: entity, TargetItem: entity): void =
        if:
            SourceComp := SourceItem.GetComponent[item_component][]
            TargetComp := TargetItem.GetComponent[item_component][]
        then:
            # 检查是否可以合并
            if (SourceComp.CanMergeInto(TargetItem)):
                # 执行合并
                SourceComp.MergeInto(TargetItem)
                Print("物品合并成功")
            else:
                Print("物品无法合并")
```

### 示例 5：物品装备管理

```verse
using { /UnrealEngine.com/Itemization }
using { /Fortnite.com/Characters }

equipment_manager := class(creative_device):
    
    # 装备物品
    EquipItem(Player: player, ItemEntity: entity): void =
        if:
            ItemComp := ItemEntity.GetComponent[item_component][]
            # 检查物品是否可以装备
            Result := ItemComp.CanEquip()
        then:
            # 可以装备
            if (EquipResult := ItemComp.Equip[]):
                Print("物品装备成功")
            else:
                Print("装备失败")
                
    # 卸下物品
    UnequipItem(ItemEntity: entity): void =
        if:
            ItemComp := ItemEntity.GetComponent[item_component][]
            ItemComp.IsEquipped[]
        then:
            if (UnequipResult := ItemComp.Unequip[]):
                Print("物品卸下成功")
            else:
                Print("卸下失败")
                
    # 获取玩家当前装备的物品
    GetEquippedItems(Player: player): []entity =
        var EquippedItems: []entity = array{}
        
        if:
            FortCharacter := Player.GetFortCharacter[]
            InventoryComp := FortCharacter.GetComponent[inventory_component][]
        then:
            EquippedItems = InventoryComp.GetEquippedItems()
            
        return EquippedItems
```

## 常见误区澄清

### 误区 1：可以在 Verse 代码中直接实例化物品类

**错误理解**：

```verse
# ❌ 错误！无法编译
MyWeapon := item_assault_rifle_common{}
```

**正确理解**：

`/Fortnite.com/Itemization` 中的物品类是**资产引用类型**，不是可实例化的类。这些类：

- 代表 Fortnite 游戏中的预制物品资产
- 用于在 UEFN 编辑器中配置设备和道具生成器
- 不能在 Verse 代码中直接使用构造函数创建

**正确做法**：

1. 在 UEFN 编辑器中放置物品或配置 Item Granter 设备
2. 在 Verse 中通过 `inventory_component` 和 `item_component` 操作物品实例
3. 使用场景查询（如 `GetCreativeObjectsWithTag`）查找放置在地图上的物品

### 误区 2：fort_item_pickup_component 可用于所有物品

**错误理解**：

"所有物品实体都有 `fort_item_pickup_component`"

**正确理解**：

`fort_item_pickup_component` 是 **Fortnite 特有的拾取组件**，只有以下情况才有此组件：

- 物品被 `Drop()` 方法掉落到世界中时
- 物品在地图上作为可拾取物品放置时

玩家背包中的物品**没有** `fort_item_pickup_component`，只有 `item_component`。

**正确用法**：

```verse
# ✅ 正确：检查组件是否存在
if (PickupComp := ItemEntity.GetComponent[fort_item_pickup_component][]):
    # 这是一个可拾取的物品
    set PickupComp.PickupLifetime = 30.0
else:
    # 这个物品不在世界中，可能在背包里
    Print("物品没有拾取组件")
```

### 误区 3：物品分类可以自由创建

**错误理解**：

"可以创建自定义的 `item_category` 来分类物品"

**正确理解**：

`item_category` 是一个 `<native>` 类，目前只能使用 Fortnite 预定义的 5 个分类：

- `WorldItem` - 世界物品
- `Currency` - 货币
- `Collectible` - 收藏品
- `Trap` - 陷阱
- `Ammo` - 弹药

**替代方案**：

如果需要自定义分类，可以：

1. 使用 entity 的 tag 系统
2. 创建自定义组件来存储分类信息
3. 使用物品名称或其他元数据进行分类

### 误区 4：不同模块的同名物品是同一个物品

**错误理解**：

"FortniteOGItems 的 `item_pump_shotgun_common` 和 CH1SXItems 的 `item_pump_shotgun_common` 是同一个物品"

**正确理解**：

即使名字相同，**不同子模块的物品类是不同的类型**：

- 完整类型路径不同（包含模块命名空间）
- 可能有不同的属性和行为
- 在物品配置时会被视为不同的物品

**示例**：

```verse
# 这是两个不同的类型
using { /Fortnite.com/Itemization/FortniteOGItems }
using { /Fortnite.com/Itemization/CH1SXItems }

# FortniteOGItems:item_pump_shotgun_common
# CH1SXItems:item_pump_shotgun_common
```

### 误区 5：可以直接修改物品的属性（如伤害、射速）

**错误理解**：

"可以通过 Verse 代码修改武器的伤害值、射速等属性"

**正确理解**：

`/Fortnite.com/Itemization` 的物品类是**只读引用**，不暴露游戏性属性（gameplay attributes）的修改接口。

物品的具体属性（伤害、射速、弹药等）由 Fortnite 引擎内部管理，无法直接通过 Verse 修改。

**可以做的**：

- 修改物品的堆叠数量（`StackSize`）
- 修改物品的最大堆叠数（`MaxStackSize`）
- 控制物品的装备状态（`Equip/Unequip`）
- 管理物品的库存归属（`Drop/PickUp`）

**不能做的**：

- 修改武器伤害
- 修改武器射速
- 修改弹药容量
- 修改武器特效

### 误区 6：物品实体在删除前需要手动清理

**错误理解**：

"必须调用某个方法来'销毁'物品实体"

**正确理解**：

物品实体的生命周期由引擎管理，通常不需要手动销毁：

- 调用 `Drop()` 后，物品会自动在 `PickupLifetime` 后消失
- 物品在背包中时，由 `inventory_component` 管理
- 使用 `RemoveItem()` 从背包移除物品时，引擎会自动清理

**注意**：不要尝试通过场景图的 `Delete()` 等方法删除物品实体，这可能导致未定义行为。

## 最佳实践

### 1. 选择合适的物品集合模块

**原则**：根据游戏主题和目标赛季选择物品集合

**推荐**：

- **原始经典体验**：使用 `FortniteOGItems` 或 `PreSeasonItems`
- **赛季主题游戏**：使用对应的 `CH*S*Items` 模块
- **现代武器**：使用最新的主题模块（如 `AbsoluteDoomItems`、`WildsItems`）
- **多样化武器池**：混合使用多个模块

**示例**：

```verse
# 经典 Battle Royale 武器
using { /Fortnite.com/Itemization/FortniteOGItems }

# 加入现代武器增加多样性
using { /Fortnite.com/Itemization/AbsoluteDoomItems }
```

### 2. 合理使用物品分类系统

**原则**：利用 `item_category` 进行物品过滤和管理

**推荐模式**：

```verse
# 定义物品过滤器
GetWeapons(Inventory: inventory_component): []entity =
    # WorldItem 通常代表武器和道具
    FilterItemsByCategory(Inventory, WorldItem)

GetAmmo(Inventory: inventory_component): []entity =
    # Ammo 代表弹药
    FilterItemsByCategory(Inventory, Ammo)

# 通用过滤函数
FilterItemsByCategory(Inventory: inventory_component, Category: item_category): []entity =
    var FilteredItems: []entity = array{}
    AllItems := Inventory.GetItems()
    
    for (Item : AllItems):
        if:
            ItemComp := Item.GetComponent[item_component][]
            Categories := ItemComp.Categories
        then:
            for (Cat : Categories):
                if (Cat = Category):
                    set FilteredItems += array{Item}
                    break
                    
    return FilteredItems
```

### 3. 监听物品事件而非轮询

**原则**：使用事件订阅而非每帧检查物品状态

**❌ 不推荐（性能差）**：

```verse
# 每帧检查物品变化 - 浪费性能
OnUpdate(): void =
    # 不断检查背包...
```

**✅ 推荐（事件驱动）**：

```verse
InitializeInventoryTracking(Inventory: inventory_component): void =
    # 订阅物品添加事件
    Inventory.AddItemEvent.Subscribe(OnItemAdded)
    
    # 订阅物品移除事件
    Inventory.RemoveItemEvent.Subscribe(OnItemRemoved)
    
    # 订阅物品装备事件
    Inventory.EquipItemEvent.Subscribe(OnItemEquipped)
    
    # 订阅物品卸下事件
    Inventory.UnequipItemEvent.Subscribe(OnItemUnequipped)

OnItemAdded(Result: add_item_result): void =
    # 处理物品添加
    
OnItemRemoved(Result: remove_item_result): void =
    # 处理物品移除
```

### 4. 处理异步操作和失败情况

**原则**：物品操作可能失败，始终检查返回值

**推荐模式**：

```verse
# 安全地装备物品
SafeEquipItem(ItemEntity: entity): logic =
    if:
        ItemComp := ItemEntity.GetComponent[item_component][]
    then:
        # 检查是否可以装备
        CanEquipResult := ItemComp.CanEquip()
        if (CanEquipResult[0] = false):
            # 无法装备，处理错误
            Errors := CanEquipResult[1]
            Print("无法装备物品，错误数量: {Errors.Length}")
            return false
            
        # 尝试装备
        if (EquipResult := ItemComp.Equip[]):
            Print("装备成功")
            return true
        else:
            Print("装备失败")
            return false
    else:
        Print("物品没有 item_component")
        return false
```

### 5. 使用类型安全的物品查找

**原则**：使用泛型查找方法减少类型转换错误

**推荐**：

```verse
# ✅ 使用泛型查找特定类型的物品组件
FindSpecificItems<ItemType>(Inventory: inventory_component): []entity where ItemType: item_component =
    # 使用类型参数查找
    Inventory.FindItems[ItemType]()

# 使用示例
# FindSpecificItems[custom_weapon_component](PlayerInventory)
```

### 6. 管理物品拾取的生命周期

**原则**：根据游戏需求设置合理的拾取存在时间

**推荐配置**：

```verse
ConfigureItemPickups(GameMode: string): void =
    case (GameMode):
        # Battle Royale - 较短的拾取时间
        "BattleRoyale" =>
            DefaultPickupLifetime := 60.0
            
        # 休闲模式 - 较长的拾取时间
        "Casual" =>
            DefaultPickupLifetime := 180.0
            
        # 创造模式 - 永久拾取
        "Creative" =>
            DefaultPickupLifetime := -1.0
            
        # 其他
        _ =>
            DefaultPickupLifetime := 120.0
```

### 7. 优化物品查询性能

**原则**：缓存常用的物品查询结果，避免重复查询

**推荐模式**：

```verse
item_cache_manager := class(creative_device):
    var CachedWeapons: []entity = array{}
    var CacheValid: logic = false
    var LastUpdateTime: float = 0.0
    
    # 获取武器列表（带缓存）
    GetWeaponsWithCache(Inventory: inventory_component, CacheTimeout: float): []entity =
        CurrentTime := GetSimulationElapsedTime()
        
        # 检查缓存是否有效
        if (CacheValid and (CurrentTime - LastUpdateTime < CacheTimeout)):
            return CachedWeapons
            
        # 重新查询
        set CachedWeapons = GetWeapons(Inventory)
        set CacheValid = true
        set LastUpdateTime = CurrentTime
        
        return CachedWeapons
        
    # 使物品缓存失效
    InvalidateCache(): void =
        set CacheValid = false
```

### 8. 与其他模块协同使用

**原则**：结合 `/UnrealEngine.com/Itemization` 的底层 API 使用

**推荐架构**：

```verse
# 导入底层物品系统
using { /UnrealEngine.com/Itemization }

# 导入 Fortnite 物品集合
using { /Fortnite.com/Itemization/FortniteOGItems }
using { /Fortnite.com/Itemization/AbsoluteDoomItems }

# 导入分类系统
using { /Fortnite.com/Itemization/FortniteItemCategories }

# 在代码中：
# - 使用 /UnrealEngine.com/Itemization 的 inventory_component 和 item_component 操作物品
# - 使用 /Fortnite.com/Itemization 的物品分类进行过滤
# - （可选）使用 fort_item_pickup_component 管理拾取行为
```

## 性能优化建议

### 1. 避免频繁的物品查询

```verse
# ❌ 不推荐：每次都遍历整个背包
for (I := 1..100):
    AllItems := Inventory.GetItems()  # 每次都创建新数组
    # ...

# ✅ 推荐：查询一次，重复使用
AllItems := Inventory.GetItems()
for (I := 1..100):
    # 使用 AllItems
    # ...
```

### 2. 使用 generator 而非数组（适用场景）

```verse
# 对于大型背包，使用 generator 可以避免创建大数组
# 在 API 3200+ 可用
ItemsGenerator := Inventory.FindItems()

# 只处理需要的物品，可以提前 break
for (Item : ItemsGenerator):
    if (SomeCondition):
        break
```

### 3. 减少组件查询次数

```verse
# ❌ 不推荐：重复查询组件
if (ItemComp := Item.GetComponent[item_component][]):
    # 使用 ItemComp
if (ItemComp := Item.GetComponent[item_component][]):  # 重复查询
    # 再次使用

# ✅ 推荐：查询一次，重复使用
if (ItemComp := Item.GetComponent[item_component][]):
    # 第一次使用
    # ...
    # 第二次使用
    # ...
```

### 4. 批量操作而非逐个操作

```verse
# 如果需要对多个物品执行相同操作，考虑批量处理
BatchProcessItems(Items: []entity): void =
    # 预处理
    # ...
    
    # 批量执行
    for (Item : Items):
        ProcessSingleItem(Item)
        
    # 后处理
    # ...
```

## 参考资源

### 官方文档

- **UEFN 文档主页**: [https://dev.epicgames.com/documentation/en-us/uefn](https://dev.epicgames.com/documentation/en-us/uefn)
- **Verse API 参考**: [https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference)
- **Item Granter 设备**: UEFN 编辑器中的物品授予器设备文档

### 相关 API 模块

#### 核心依赖模块

- **`/UnrealEngine.com/Itemization`** - 物品化系统基础 API
  - 提供 `inventory_component`（库存组件）
  - 提供 `item_component`（物品组件）
  - 提供 `item_category`（物品分类）
  - 提供物品合并、装备等核心功能

- **`/Verse.org/SceneGraph`** - 场景图系统
  - 所有物品实体继承自 `entity`
  - 提供组件系统支持

#### 配合使用的模块

- **`/Fortnite.com/Devices`** - 设备系统
  - Item Granter（物品授予器）
  - Item Spawner（物品生成器）
  - Vending Machine（自动售货机）

- **`/Fortnite.com/Characters`** - 角色系统
  - `fort_character` 提供 `inventory_component` 访问
  - 角色装备物品的交互

- **`/Fortnite.com/Game`** - 游戏逻辑
  - 游戏规则与物品系统的集成

### 内部参考文档

- **API Digest**: `/Core/skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md`
  - 完整的 Fortnite API 定义文件
  - 包含所有物品类的详细定义

- **UnrealEngine Itemization API Digest**: `/Core/skills/programming/verseDev/shared/api-digests/UnrealEngine.digest.verse.md`
  - 底层物品化系统 API 定义
  - `inventory_component` 和 `item_component` 详细文档

- **API 模块清单**: `/Core/skills/programming/verseDev/shared/references/api-modules-list.md`
  - 所有 API 模块的索引
  - 模块关系说明

- **API 模块能力调研**: `/Core/skills/programming/verseDev/shared/references/api-modules-research.md`
  - 各模块的能力分析
  - 模块统计信息

### 版本信息

- **当前 API 版本**: Fortnite+Release-39.11-CL-49242330
- **最低支持版本**: 根据 `@available` 注解，部分 API 需要特定版本
  - `FindItems()` generator 版本: MinUploadedAtFNVersion := 2930
  - `FindItems<T>()` 泛型版本: MinUploadedAtFNVersion := 3200
  - `CanAddItem()`: MinUploadedAtFNVersion := 3800
  - `Equip()/Unequip()`: MinUploadedAtFNVersion := 3800

### 实验性 API 警告

本模块的所有内容都标记为 `@experimental`，这意味着：

- API 可能在未来版本中发生变化
- 部分功能可能不稳定
- 建议在生产环境使用前进行充分测试
- 关注 UEFN 更新日志以了解 API 变更

## 总结

`/Fortnite.com/Itemization` 模块是 Fortnite Creative 中规模最大、内容最丰富的物品资产库，包含 1260+ 个预制物品类和 41 个主题子模块。该模块的关键特征：

1. **资产引用模式**：物品类是只读的资产引用，不能在 Verse 中实例化
2. **赛季主题组织**：按 Fortnite 赛季和主题划分子模块，便于选择合适的物品集合
3. **配合底层 API**：必须结合 `/UnrealEngine.com/Itemization` 的 `inventory_component` 和 `item_component` 使用
4. **事件驱动设计**：通过事件订阅监听物品变化，避免轮询
5. **分类系统**：使用 `item_category` 进行物品分类和过滤

正确使用该模块的核心是理解"物品类是资产引用，不是实例"这一概念，所有物品操作都应通过底层的组件 API 完成。
