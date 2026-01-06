# Fortnite.com/Marketplace 模块 API 参考

## 1. 模块概述

### 1.1 模块用途

`/Fortnite.com/Marketplace` 模块提供了一套完整的商业化系统API，用于在 Fortnite Creative 地图中实现玩家内购（IAP）功能。该模块允许创作者：

- 定义和管理虚拟商品（Entitlements）
- 创建商品销售方案（Offers）
- 处理玩家购买流程
- 追踪和消费虚拟商品
- 监听商品变化事件

### 1.2 设计理念

Marketplace 模块基于以下核心理念设计：

1. **类型安全的商品系统**：使用 Verse 的类型系统确保商品定义的正确性
2. **合规性优先**：内置年龄限制、地区限制等合规检查机制
3. **事件驱动**：通过事件系统实时追踪商品状态变化
4. **灵活的定价模型**：支持 V-Bucks 定价和捆绑销售

### 1.3 适用场景

**典型使用场景**：

- **付费解锁内容**：特殊关卡、隐藏区域、额外角色等
- **消耗品商店**：生命值、道具、增益效果等可重复购买商品
- **装饰性道具**：皮肤、特效、表情等不影响游戏平衡的商品
- **捆绑包销售**：组合多个商品以折扣价格销售
- **会员系统**：通过 Entitlement 追踪会员状态

**不适用场景**：

- 赌博或抽奖机制（需要特别申报 `PaidRandomItem`）
- 付费获得游戏优势（必须设置 `ConsequentialToGameplay = true`）

### 1.4 模块规模统计

- **类定义数量**：0 个（主要通过抽象类和接口定义）
- **枚举类型**：0 个
- **核心类/接口**：7 个
- **代码行数**：127 行
- **依赖模块**：
  - `/Verse.org/Simulation` - 模拟系统
  - `/Verse.org/SceneGraph` - 场景图系统
  - `/Verse.org/Native` - 原生功能
  - `/Verse.org/Presentation` - 展示层
  - `/Verse.org/Assets` - 资源管理

---

## 2. 核心类/接口清单

### 2.1 按功能分类

#### 商品定义类

| 类名 | 用途 | 继承关系 |
|------|------|----------|
| `entitlement` | 商品权益基类，定义玩家可拥有的虚拟商品 | 继承自 `has_icon`, `has_description` |

#### 销售方案类

| 类名 | 用途 | 继承关系 |
|------|------|----------|
| `offer` | 销售方案抽象基类 | 继承自 `has_icon`, `has_description` |
| `entitlement_offer` | 单一商品销售方案 | 继承自 `offer` |
| `bundle_offer` | 捆绑包销售方案 | 继承自 `offer` |

#### 定价类

| 类名 | 用途 | 继承关系 |
|------|------|----------|
| `price_dimension` | 定价维度抽象基类 | 无 |
| `price_vbucks` | V-Bucks 定价实现 | 继承自 `price_dimension` |

#### 事件追踪类

| 类名 | 用途 | 继承关系 |
|------|------|----------|
| `entitlement_change` | 商品变化事件数据 | 无 |

#### 组件类

| 类名 | 用途 | 继承关系 |
|------|------|----------|
| `offer_interactable_component` | 可交互的销售点组件（实验性） | 继承自 `interactable_component` |

### 2.2 类关系图（文本表示）

```text
has_icon, has_description (接口)
    ├── entitlement (商品权益)
    └── offer (销售方案抽象类)
        ├── entitlement_offer (单品销售)
        └── bundle_offer (捆绑包销售)

price_dimension (定价抽象类)
    └── price_vbucks (V-Bucks 定价)

interactable_component
    └── offer_interactable_component (可交互销售点)

entitlement_change(t:type) (事件数据)
```

---

## 3. 关键 API 详解

### 3.1 商品权益类 (entitlement)

#### 类定义

```verse
entitlement<native><public> := class<castable>(has_icon, has_description):
    MaxCount<native><public>:int
    Consumable<native><public>:logic
    PaidRandomItem<native><public>:logic
    PaidArea<native><public>:logic
    ConsequentialToGameplay<native><public>:logic
```

#### entitlement 属性说明

| 属性 | 类型 | 说明 |
|------|------|------|
| `MaxCount` | `int` | 玩家可拥有的最大数量。<br>- 非消耗品：只能为 1<br>- 消耗品：可设置为任意正整数 |
| `Consumable` | `logic` | 是否为消耗品。<br>- `true`：可重复购买和消费<br>- `false`：一次性购买，永久拥有 |
| `PaidRandomItem` | `logic` | 是否为付费随机物品（抽奖机制）。<br>设为 `true` 时需遵守特殊合规要求 |
| `PaidArea` | `logic` | 是否为付费区域解锁 |
| `ConsequentialToGameplay` | `logic` | 是否影响游戏平衡。<br>如果商品提供游戏优势，**必须**设为 `true` |

#### 使用限制

1. **必须使用具体类型（concrete）**：你的派生类型必须是 `<concrete>` 才能被购买系统使用
2. **消耗品规则**：
   - 非消耗品（`Consumable = false`）：玩家只能拥有 1 个
   - 消耗品（`Consumable = true`）：玩家可拥有 `MaxCount` 个
3. **合规声明**：如果商品影响游戏平衡，必须设置 `ConsequentialToGameplay = true`

---

### 3.2 销售方案类 (offer)

#### 基类定义

```verse
offer<native><public> := class<abstract><castable><internal>(has_icon, has_description):
    @editable
    Price<native><public>:price_dimension

    GetMinPurchaseAge<native_callable><public>(
        CountryCode:string, 
        SubdivisionCode:string, 
        PlatformFamily:string
    )<computes><decides>:int
```

#### offer 方法说明

**`GetMinPurchaseAge`** - 获取最低购买年龄

- **参数**：
  - `CountryCode` (string)：ISO-3166-1 A-2 国家代码（如 "US", "CN"）
  - `SubdivisionCode` (string)：ISO-3166-2 省/州代码（不包含国家部分）。如果区域信息不可用则为空字符串
  - `PlatformFamily` (string)：平台类型，可选值：
    - Android, iOS, macOS, Nintendo, PlayStation, Windows, Xbox, Luna, GeForceNow
- **返回值**：
  - 成功：返回该地区的最低购买年龄（int）
  - 失败（`<decides>`）：该地区不允许销售此商品
- **注意**：如果返回的年龄高于该地区的最高可用年龄，商品将不可购买

#### 派生类：单品销售 (entitlement_offer)

```verse
entitlement_offer<native><public> := class<castable>(offer):
    @available {MinUploadedAtFNVersion := 3800}
    @editable
    EntitlementType<native><public>:concrete_subtype(entitlement)
```

- **用途**：销售单一商品
- **属性**：
  - `EntitlementType`：要销售的商品类型（必须是 entitlement 的具体子类型）

#### 派生类：捆绑包销售 (bundle_offer)

```verse
bundle_offer<native><public> := class<castable>(offer):
    Offers<native><public>:[]tuple(offer, int)
```

- **用途**：将多个 offer 打包销售
- **属性**：
  - `Offers`：offer 和数量的数组。每个元素是 `tuple(offer, int)`，表示包含的 offer 和数量

---

### 3.3 定价类 (price_vbucks)

```verse
price_vbucks<native><public> := class<final><computes><internal>(price_dimension)

MakePriceVBucks<native><public>(Amount:float)<converges>:price_vbucks
GetPriceVBucks<native><public>(P:price_vbucks):float
```

#### price_vbucks 函数说明

**`MakePriceVBucks`** - 创建 V-Bucks 价格

- **参数**：`Amount` (float) - V-Bucks 数量
- **返回值**：`price_vbucks` 对象
- **示例**：`MakePriceVBucks(500.0)` 表示 500 V-Bucks

**`GetPriceVBucks`** - 获取 V-Bucks 价格值

- **参数**：`P` (price_vbucks) - 价格对象
- **返回值**：V-Bucks 数量（float）

---

### 3.4 核心操作函数

#### 3.4.1 购买商品 (BuyOffer)

```verse
BuyOffer<native><public>(Player:player, Offer:offer)<suspends>:logic
```

- **功能**：显示 Epic 购买界面，让玩家购买指定商品
- **参数**：
  - `Player`：要购买的玩家
  - `Offer`：要购买的销售方案
- **返回值**：
  - `true`：购买成功
  - `false`：购买失败或取消
- **行为**：挂起当前协程，等待玩家完成购买流程
- **注意**：会自动处理合规检查（年龄、地区限制等）

#### 3.4.2 直接授予商品 (GrantEntitlement)

```verse
@available {MinUploadedAtFNVersion := 3800}
GrantEntitlement<native><public>(
    Player:player, 
    entitlement_type:concrete_subtype(entitlement), 
    ?Count:int = external {}
)<suspends>:logic
```

- **功能**：直接授予商品给玩家（无需购买）
- **参数**：
  - `Player`：接收商品的玩家
  - `entitlement_type`：商品类型（必须是具体子类型）
  - `Count`（可选）：授予数量，默认为 1
- **返回值**：
  - `true`：授予成功
  - `false`：授予失败（如超过 MaxCount）
- **注意**：
  - 不检查 EntitlementDisclosures
  - 总是尝试授予，只要满足 MaxCount 要求
  - 需要 UEFN 版本 >= 38.00

#### 3.4.3 查询已购商品 (GetPurchasedEntitlements)

```verse
GetPurchasedEntitlements<native><public>(
    Player:player, 
    entitlement_type:subtype(entitlement)
)<suspends>:[]tuple(entitlement_type, int)
```

- **功能**：获取玩家拥有的所有指定类型商品及数量
- **参数**：
  - `Player`：要查询的玩家
  - `entitlement_type`：商品类型（可以是基类，会查找所有派生类型）
- **返回值**：数组，每个元素是 `tuple(商品实例, 数量)`
- **重要警告**：
  - **不要**使用基类 `entitlement` 作为参数，会导致永久挂起
  - 必须使用具体的商品子类型

#### 3.4.4 消费商品 (ConsumeEntitlement)

```verse
@available {MinUploadedAtFNVersion := 3800}
ConsumeEntitlement<native><public>(
    Player:player, 
    entitlement_type:concrete_subtype(entitlement), 
    ?Count:int = external {}
)<suspends>:logic
```

- **功能**：消费玩家拥有的消耗品
- **参数**：
  - `Player`：玩家
  - `entitlement_type`：要消费的商品类型
  - `Count`（可选）：消费数量，默认为 1
- **返回值**：
  - `true`：消费成功
  - `false`：消费失败
- **失败条件**：
  - 商品不是消耗品（`Consumable = false`）
  - 玩家拥有的数量少于要消费的数量
- **需要版本**：>= 38.00

#### 3.4.5 监听商品变化 (GetEntitlementsChangedEvent)

```verse
GetEntitlementsChangedEvent<native><public>(
    Player:player, 
    entitlement_type:subtype(entitlement)
):listenable(tuple(player, []entitlement_change(entitlement_type)))
```

- **功能**：获取商品变化事件的监听器
- **参数**：
  - `Player`：要监听的玩家
  - `entitlement_type`：要监听的商品类型
- **返回值**：可订阅的事件对象
- **事件数据**：`tuple(player, []entitlement_change(...))`
  - `player`：发生变化的玩家
  - `[]entitlement_change(...)`：变化的商品列表
- **触发时机**：
  - 玩家购买商品
  - 玩家消费商品
  - 商品被退款
  - 商品被管理员修改
- **注意**：使用基类 `entitlement` 会导致运行时错误

#### 3.4.6 显示商店界面 (ShowOffersDialog)

```verse
ShowOffersDialog<native><public>(
    Player:player, 
    Offers:[]offer, 
    ?Title:message = external {}
)<suspends>:void
```

- **功能**：显示 Epic 提供的商店界面，展示多个商品
- **参数**：
  - `Player`：要显示界面的玩家
  - `Offers`：要展示的商品列表
  - `Title`（可选）：商店标题
- **行为**：挂起直到玩家关闭界面

---

### 3.5 合规检查函数

#### 3.5.1 检查付费随机物品限制 (RestrictPaidRandomItems)

```verse
RestrictPaidRandomItems<native><public>(Player:player)<reads><decides>:void
```

- **功能**：检查玩家是否可以购买付费随机物品（抽奖）
- **参数**：`Player` - 要检查的玩家
- **返回值**：
  - 成功：玩家可以购买
  - 失败（`<decides>`）：由于平台、地区、年龄或用户设置限制，玩家不能购买
- **用途**：在显示抽奖类商品前调用此函数

#### 3.5.2 检查直接购买提示限制 (RestrictDirectPromptsToPurchase)

```verse
RestrictDirectPromptsToPurchase<native><public>(Player:player)<reads><decides>:void
```

- **功能**：检查是否可以直接提示玩家购买
- **参数**：`Player` - 要检查的玩家
- **返回值**：
  - 成功：可以显示购买提示
  - 失败：受限制
- **用途**：在调用 `BuyOffer` 或 `ShowOffersDialog` 前检查

---

### 3.6 事件数据类 (entitlement_change)

```verse
entitlement_change<native><public>(t:type) := class<internal>:
    Entitlement<native><public>:t
    Quantity<native><public>:int
    Change<native><public>:int
```

#### entitlement_change 属性说明

| 属性 | 类型 | 说明 |
|------|------|------|
| `Entitlement` | `t` | 发生变化的商品实例 |
| `Quantity` | `int` | 变化后玩家拥有的总数量 |
| `Change` | `int` | 数量变化值（正数=增加，负数=减少） |

---

### 3.7 实验性功能：可交互销售点组件

```verse
@experimental
offer_interactable_component<native><public> := class(interactable_component):
    @editable
    var Offer<public>:offer
    
    var SucceededEventHandle<public>:?cancelable
    
    CanInteract<native><native_callable><override>(Agent:agent)<reads><decides>:void
    OnBeginSimulation<override>():void
    OnSucceed<protected>(Agent:agent):void
    InteractMessage<override>(Agent:agent)<reads><decides>:message
```

- **状态**：实验性功能，API 可能变化
- **用途**：在场景中放置可交互的销售点，玩家靠近并交互时触发购买
- **属性**：
  - `Offer`：绑定的销售方案
  - `SucceededEventHandle`：购买成功事件句柄
- **方法**：
  - `CanInteract`：判断玩家是否可以交互
  - `OnSucceed`：购买成功时调用
  - `InteractMessage`：显示给玩家的交互提示

---

## 4. 代码示例

### 4.1 示例 1：定义并销售单一消耗品

**场景**：创建一个生命药水商品，售价 100 V-Bucks，玩家可重复购买最多 99 个。

```verse
using { /Fortnite.com/Marketplace }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }

# 定义生命药水商品
health_potion<public> := class<concrete>(entitlement):
    # 最多拥有 99 个
    MaxCount<override>:int = 99
    # 这是消耗品
    Consumable<override>:logic = true
    # 不是随机物品
    PaidRandomItem<override>:logic = false
    # 不是付费区域
    PaidArea<override>:logic = false
    # 不影响游戏平衡（根据实际情况设置，这里假设不影响）
    ConsequentialToGameplay<override>:logic = false

# 定义销售方案
health_potion_offer<public> := class<concrete>(entitlement_offer):
    # 售价 100 V-Bucks
    Price<override>:price_dimension = MakePriceVBucks(100.0)
    # 销售的商品类型
    EntitlementType<override>:concrete_subtype(entitlement) = health_potion

# 游戏逻辑
potion_shop<public> := class(creative_device):
    OnBegin<override>()<suspends>:void =
        # 获取所有玩家
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            # 为每个玩家开启商店协程
            spawn { ShowShopToPlayer(Player) }

    # 显示商店给玩家
    ShowShopToPlayer<private>(Player:player)<suspends>:void =
        # 检查是否可以显示购买提示
        if (RestrictDirectPromptsToPurchase[Player]):
            # 受限制，不显示
            return
        
        # 创建商品实例
        MyOffer := health_potion_offer{}
        
        # 显示购买界面
        if (BuyOffer(Player, MyOffer)):
            # 购买成功
            Print("玩家购买了生命药水！")
```

---

### 4.2 示例 2：查询和消费商品

**场景**：当玩家受到伤害时，自动使用一个生命药水（如果拥有）。

```verse
using { /Fortnite.com/Marketplace }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }

potion_manager<public> := class(creative_device):
    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            spawn { MonitorPlayerHealth(Player) }

    # 监控玩家生命值
    MonitorPlayerHealth<private>(Player:player)<suspends>:void =
        if (FortCharacter := Player.GetFortCharacter[]):
            loop:
                # 等待玩家受伤
                FortCharacter.DamagedEvent().Await()
                
                # 尝试使用药水
                UseHealthPotion(Player)

    # 使用生命药水
    UseHealthPotion<private>(Player:player)<suspends>:void =
        # 查询玩家拥有的药水数量
        Entitlements := GetPurchasedEntitlements(Player, health_potion)
        
        if (Entitlements.Length > 0):
            if (Tuple := Entitlements[0]):
                (PotionInstance, Count) := Tuple
                if (Count > 0):
                    # 消费一个药水
                    if (ConsumeEntitlement(Player, health_potion, 1)):
                        # 消费成功，恢复生命值
                        if (FortCharacter := Player.GetFortCharacter[]):
                            # 假设有恢复生命的方法
                            Print("使用了生命药水！剩余 {Count - 1} 个")
```

---

### 4.3 示例 3：监听商品变化事件

**场景**：实时追踪玩家商品数量变化，并更新 UI 显示。

```verse
using { /Fortnite.com/Marketplace }
using { /Verse.org/Simulation }

inventory_tracker<public> := class(creative_device):
    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Player : AllPlayers):
            spawn { TrackPlayerInventory(Player) }

    # 追踪玩家库存
    TrackPlayerInventory<private>(Player:player)<suspends>:void =
        # 获取商品变化事件
        ChangeEvent := GetEntitlementsChangedEvent(Player, health_potion)
        
        # 监听事件
        ChangeEvent.Subscribe(OnInventoryChanged)
        
        # 初始化显示
        UpdateInventoryDisplay(Player)

    # 商品变化回调
    OnInventoryChanged<private>(EventData:tuple(player, []entitlement_change(health_potion))):void =
        (Player, Changes) := EventData
        
        for (Change : Changes):
            Print("玩家 {Player} 的生命药水数量变化:")
            Print("  变化量: {Change.Change}")
            Print("  当前数量: {Change.Quantity}")
        
        # 更新 UI 显示
        UpdateInventoryDisplay(Player)

    # 更新库存显示（实际实现需要 UI 系统）
    UpdateInventoryDisplay<private>(Player:player)<suspends>:void =
        Entitlements := GetPurchasedEntitlements(Player, health_potion)
        
        if (Entitlements.Length > 0):
            if (Tuple := Entitlements[0]):
                (_, Count) := Tuple
                Print("药水数量: {Count}")
```

---

### 4.4 示例 4：创建捆绑包销售

**场景**：创建一个"新手礼包"，包含 3 个生命药水和 1 个护甲，以折扣价销售。

```verse
using { /Fortnite.com/Marketplace }

# 护甲商品定义
armor<public> := class<concrete>(entitlement):
    MaxCount<override>:int = 1
    Consumable<override>:logic = false  # 非消耗品，一次性购买
    PaidRandomItem<override>:logic = false
    PaidArea<override>:logic = false
    ConsequentialToGameplay<override>:logic = true  # 提供游戏优势

# 护甲销售方案
armor_offer<public> := class<concrete>(entitlement_offer):
    Price<override>:price_dimension = MakePriceVBucks(500.0)
    EntitlementType<override>:concrete_subtype(entitlement) = armor

# 新手礼包（捆绑包）
starter_bundle<public> := class<concrete>(bundle_offer):
    # 礼包售价 400 V-Bucks（原价 3*100 + 500 = 800，折扣 50%）
    Price<override>:price_dimension = MakePriceVBucks(400.0)
    
    # 包含的商品
    Offers<override>:[]tuple(offer, int) = array:
        (health_potion_offer{}, 3)  # 3 个生命药水
        (armor_offer{}, 1)           # 1 个护甲

# 销售逻辑
bundle_shop<public> := class(creative_device):
    ShowBundle<public>(Player:player)<suspends>:void =
        Bundle := starter_bundle{}
        
        # 显示商店界面，标题为"新手礼包"
        ShowOffersDialog(Player, array{Bundle}, "新手礼包")
```

---

### 4.5 示例 5：地区和年龄限制

**场景**：创建一个商品，只在特定国家和年龄段销售。

```verse
using { /Fortnite.com/Marketplace }

# 定义需要年龄限制的商品
mature_content<public> := class<concrete>(entitlement):
    MaxCount<override>:int = 1
    Consumable<override>:logic = false
    PaidRandomItem<override>:logic = false
    PaidArea<override>:logic = false
    ConsequentialToGameplay<override>:logic = false

# 自定义销售方案，带年龄限制
mature_offer<public> := class<concrete>(entitlement_offer):
    Price<override>:price_dimension = MakePriceVBucks(300.0)
    EntitlementType<override>:concrete_subtype(entitlement) = mature_content
    
    # 重写年龄检查方法
    GetMinPurchaseAge<override>(
        CountryCode:string, 
        SubdivisionCode:string, 
        PlatformFamily:string
    )<computes><decides>:int =
        # 美国需要 18 岁
        if (CountryCode = "US"):
            return 18
        
        # 中国不允许销售
        if (CountryCode = "CN"):
            return false  # 失败，不允许销售
        
        # 其他地区 16 岁
        return 16

# 销售逻辑
age_restricted_shop<public> := class(creative_device):
    TrySellMatureContent<public>(Player:player)<suspends>:void =
        Offer := mature_offer{}
        
        # BuyOffer 会自动调用 GetMinPurchaseAge 进行检查
        if (BuyOffer(Player, Offer)):
            Print("购买成功！")
        else:
            Print("购买失败或取消")
```

---

## 5. 常见误区澄清

### 5.1 误区：直接使用基类 `entitlement`

**❌ 错误示例**：

```verse
# 这会导致永久挂起！
Entitlements := GetPurchasedEntitlements(Player, entitlement)
```

**✅ 正确做法**：

```verse
# 使用具体的商品子类型
Entitlements := GetPurchasedEntitlements(Player, health_potion)
```

**原因**：API 文档明确说明，使用基类 `entitlement` 会导致函数永久挂起（suspend forever）。这是设计上的限制，因为系统需要知道具体的商品类型才能正确查询数据库。

---

### 5.2 误区：忘记设置 `<concrete>` 修饰符

**❌ 错误示例**：

```verse
# 缺少 <concrete> 修饰符
my_item := class(entitlement):
    MaxCount<override>:int = 1
    # ...
```

**✅ 正确做法**：

```verse
# 必须添加 <concrete> 修饰符
my_item<public> := class<concrete>(entitlement):
    MaxCount<override>:int = 1
    # ...
```

**原因**：购买系统需要能够实例化商品对象，只有 `<concrete>` 类型才能被实例化。抽象类型无法用于实际交易。

---

### 5.3 误区：混淆 `GrantEntitlement` 和 `BuyOffer`

**容易混淆的概念**：

- **`GrantEntitlement`**：直接授予商品，**不需要玩家付费**，不显示购买界面
- **`BuyOffer`**：显示购买界面，玩家需要支付 V-Bucks

**使用场景区分**：

| 场景 | 使用函数 |
|------|---------|
| 每日登录奖励 | `GrantEntitlement` |
| 任务完成奖励 | `GrantEntitlement` |
| 管理员补偿 | `GrantEntitlement` |
| 玩家主动购买 | `BuyOffer` |
| 显示商店界面 | `ShowOffersDialog` + `BuyOffer` |

---

### 5.4 误区：认为消费非消耗品会成功

**❌ 错误认知**：

```verse
# 护甲是非消耗品（Consumable = false）
# 尝试消费会失败
if (ConsumeEntitlement(Player, armor, 1)):
    # 这里永远不会执行
    Print("消费成功")
```

**✅ 正确理解**：

- `ConsumeEntitlement` **只能**用于消耗品（`Consumable = true`）
- 调用时会检查商品的 `Consumable` 属性
- 如果商品不是消耗品，函数返回 `false`

**建议**：在消费前检查商品类型，或使用设计模式确保只消费消耗品。

---

### 5.5 误区：超过 `MaxCount` 后继续授予

**现象**：

```verse
# 假设 health_potion 的 MaxCount = 99
# 玩家已有 99 个药水
if (GrantEntitlement(Player, health_potion, 1)):
    # 这会返回 false，因为超过了 MaxCount
    Print("授予成功")
else:
    Print("授予失败，超过最大数量")
```

**正确理解**：

- `GrantEntitlement` 和购买操作都会检查 `MaxCount`
- 如果授予后总数超过 `MaxCount`，操作会失败
- 对于消耗品，需要先消费再购买/授予

**最佳实践**：

```verse
# 授予前检查当前数量
Entitlements := GetPurchasedEntitlements(Player, health_potion)
if (Entitlements.Length > 0):
    if (Tuple := Entitlements[0]):
        (_, CurrentCount) := Tuple
        
        # 检查是否有空间
        if (CurrentCount < 99):
            GrantEntitlement(Player, health_potion, 1)
        else:
            Print("库存已满！")
```

---

### 5.6 误区：混淆 `entitlement_offer` 和 `bundle_offer`

**容易混淆的点**：

| 特性 | entitlement_offer | bundle_offer |
|------|-------------------|--------------|
| 销售内容 | 单一商品 | 多个 offer 打包 |
| `EntitlementType` 属性 | 有，指向具体商品 | 无 |
| `Offers` 属性 | 无 | 有，包含多个 (offer, 数量) |
| 适用场景 | 单品销售 | 捆绑包、礼包 |

**示例对比**：

```verse
# 单品销售
single_offer := class<concrete>(entitlement_offer):
    EntitlementType<override> = my_item  # 销售一种商品

# 捆绑包销售
bundle := class<concrete>(bundle_offer):
    Offers<override> = array:
        (item_a_offer{}, 2)  # 包含多个商品
        (item_b_offer{}, 1)
```

---

## 6. 最佳实践

### 6.1 推荐的使用模式

#### 6.1.1 商品定义模式

**推荐结构**：

```verse
# 1. 定义商品基类（如果有多个类似商品）
consumable_item<abstract> := class(entitlement):
    MaxCount<override>:int = 99
    Consumable<override>:logic = true
    PaidRandomItem<override>:logic = false
    PaidArea<override>:logic = false

# 2. 定义具体商品
health_potion<public> := class<concrete>(consumable_item):
    ConsequentialToGameplay<override>:logic = false

mana_potion<public> := class<concrete>(consumable_item):
    ConsequentialToGameplay<override>:logic = false

# 3. 为每个商品创建对应的 offer
health_potion_offer<public> := class<concrete>(entitlement_offer):
    Price<override> = MakePriceVBucks(100.0)
    EntitlementType<override> = health_potion
```

**优点**：

- 代码复用，减少重复
- 统一管理同类商品的属性
- 易于维护和扩展

---

#### 6.1.2 商店管理器模式

**推荐实现**：

```verse
shop_manager<public> := class(creative_device):
    var AllOffers<private>:[]offer = array{}
    
    # 初始化商店商品
    OnBegin<override>()<suspends>:void =
        # 注册所有商品
        set AllOffers = array:
            health_potion_offer{}
            mana_potion_offer{}
            armor_offer{}
    
    # 显示完整商店
    ShowShop<public>(Player:player)<suspends>:void =
        if (RestrictDirectPromptsToPurchase[Player]):
            return
        
        ShowOffersDialog(Player, AllOffers, "游戏商店")
    
    # 显示特定分类
    ShowConsumables<public>(Player:player)<suspends>:void =
        ConsumableOffers := array:
            health_potion_offer{}
            mana_potion_offer{}
        
        ShowOffersDialog(Player, ConsumableOffers, "消耗品商店")
```

**优点**：

- 集中管理所有商品
- 易于实现分类和筛选
- 便于添加促销和限时活动

---

#### 6.1.3 库存管理器模式

**推荐实现**：

```verse
inventory_manager<public> := class(creative_device):
    # 查询商品数量
    GetItemCount<public>(Player:player, ItemType:subtype(entitlement))<suspends>:int =
        Entitlements := GetPurchasedEntitlements(Player, ItemType)
        
        if (Entitlements.Length > 0):
            if (Tuple := Entitlements[0]):
                (_, Count) := Tuple
                return Count
        
        return 0
    
    # 安全消费商品
    SafeConsumeItem<public>(
        Player:player, 
        ItemType:concrete_subtype(entitlement), 
        Amount:int
    )<suspends>:logic =
        # 检查数量是否足够
        CurrentCount := GetItemCount(Player, ItemType)
        
        if (CurrentCount >= Amount):
            return ConsumeEntitlement(Player, ItemType, Amount)
        
        return false
    
    # 检查是否拥有商品
    HasItem<public>(Player:player, ItemType:subtype(entitlement))<suspends>:logic =
        Count := GetItemCount(Player, ItemType)
        return if (Count > 0) then true else false
```

**优点**：

- 封装复杂的库存操作
- 提供安全检查
- 避免重复代码

---

### 6.2 性能优化建议

#### 6.2.1 缓存查询结果

**❌ 低效做法**：

```verse
# 每次都查询数据库
loop:
    Entitlements := GetPurchasedEntitlements(Player, health_potion)
    # 处理...
    Sleep(1.0)
```

**✅ 优化做法**：

```verse
# 使用事件驱动，只在变化时更新
var CachedCount<private>:int = 0

OnBegin<override>()<suspends>:void =
    # 初始查询
    UpdateCache(Player)
    
    # 监听变化事件
    ChangeEvent := GetEntitlementsChangedEvent(Player, health_potion)
    ChangeEvent.Subscribe(OnCountChanged)

OnCountChanged<private>(EventData:tuple(player, []entitlement_change(health_potion))):void =
    (Player, Changes) := EventData
    UpdateCache(Player)

UpdateCache<private>(Player:player)<suspends>:void =
    # 只查询一次，更新缓存
    Entitlements := GetPurchasedEntitlements(Player, health_potion)
    if (Entitlements.Length > 0, Tuple := Entitlements[0]):
        (_, Count) := Tuple
        set CachedCount = Count
```

**优点**：

- 减少网络请求
- 降低服务器负载
- 提高响应速度

---

#### 6.2.2 批量操作

**❌ 低效做法**：

```verse
# 逐个显示商品
for (Offer : AllOffers):
    BuyOffer(Player, Offer)  # 每次都打开界面
```

**✅ 优化做法**：

```verse
# 一次性显示所有商品
ShowOffersDialog(Player, AllOffers, "商店")
```

**优点**：

- 更好的用户体验
- 减少界面切换
- 降低 UI 开销

---

### 6.3 与其他模块的配合使用

#### 6.3.1 与 UI 模块配合

**场景**：在自定义 UI 中显示商品数量

```verse
using { /Fortnite.com/UI }
using { /Fortnite.com/Marketplace }
using { /Verse.org/Simulation }

ui_inventory_display<public> := class(creative_device):
    # 假设有 UI 组件（实际需要根据 UI 系统实现）
    
    UpdateInventoryUI<public>(Player:player)<suspends>:void =
        # 查询库存
        PotionCount := GetItemCount(Player, health_potion)
        ArmorOwned := HasItem(Player, armor)
        
        # 更新 UI 文本（伪代码）
        # SetUIText(PotionCountLabel, "药水: {PotionCount}")
        # SetUIVisible(ArmorIcon, ArmorOwned)
```

---

#### 6.3.2 与 Devices 模块配合

**场景**：使用按钮设备触发购买

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Marketplace }

shop_button<public> := class(creative_device):
    @editable
    ShopButton<public>:button_device = button_device{}
    
    OnBegin<override>()<suspends>:void =
        ShopButton.InteractedWithEvent.Subscribe(OnButtonPressed)
    
    OnButtonPressed<private>(Agent:agent):void =
        if (Player := player[Agent]):
            spawn { OpenShop(Player) }
    
    OpenShop<private>(Player:player)<suspends>:void =
        if (RestrictDirectPromptsToPurchase[Player]):
            return
        
        Offers := array{health_potion_offer{}}
        ShowOffersDialog(Player, Offers, "药水商店")
```

---

#### 6.3.3 与 Game 模块配合

**场景**：根据游戏阶段解锁商品

```verse
using { /Fortnite.com/Game }
using { /Fortnite.com/Marketplace }

progression_shop<public> := class(creative_device):
    var GamePhase<private>:int = 1
    
    # 根据游戏阶段显示不同商品
    ShowPhaseShop<public>(Player:player)<suspends>:void =
        Offers := if (GamePhase = 1):
            # 第一阶段：只有基础商品
            array{health_potion_offer{}}
        else if (GamePhase = 2):
            # 第二阶段：解锁高级商品
            array{health_potion_offer{}, armor_offer{}}
        else:
            # 第三阶段：全部商品
            array{health_potion_offer{}, armor_offer{}, starter_bundle{}}
        
        ShowOffersDialog(Player, Offers, "商店 - 阶段 {GamePhase}")
```

---

#### 6.3.4 与 Teams 模块配合

**场景**：团队共享商品

```verse
using { /Fortnite.com/Teams }
using { /Fortnite.com/Marketplace }

team_inventory<public> := class(creative_device):
    # 检查团队是否拥有商品
    TeamHasItem<public>(Player:player, ItemType:subtype(entitlement))<suspends>:logic =
        if (PlayerTeam := Player.GetTeam[]):
            TeamPlayers := PlayerTeam.GetPlayers()
            
            for (TeamPlayer : TeamPlayers):
                Count := GetItemCount(TeamPlayer, ItemType)
                if (Count > 0):
                    return true
        
        return false
    
    # 从团队中找到拥有商品的玩家
    FindItemOwner<public>(
        Player:player, 
        ItemType:subtype(entitlement)
    )<suspends>:?player =
        if (PlayerTeam := Player.GetTeam[]):
            TeamPlayers := PlayerTeam.GetPlayers()
            
            for (TeamPlayer : TeamPlayers):
                Count := GetItemCount(TeamPlayer, ItemType)
                if (Count > 0):
                    return option{TeamPlayer}
        
        return false
```

---

## 7. 参考资源

### 7.1 官方文档

- **UEFN 官方文档**：[https://dev.epicgames.com/documentation/en-us/uefn](https://dev.epicgames.com/documentation/en-us/uefn)
- **Verse 语言参考**：[https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- **Commerce System Guide**：官方商业化系统指南（在 UEFN 文档中搜索 "Commerce"）

### 7.2 相关 API 模块

#### 推荐配合使用的模块

| 模块 | 用途 | 配合场景 |
|------|------|----------|
| `/Fortnite.com/UI` | UI 界面系统 | 显示库存、商品信息 |
| `/Fortnite.com/Devices` | 设备系统 | 创建商店 NPC、售货机 |
| `/Fortnite.com/Game` | 游戏逻辑 | 游戏进度解锁商品 |
| `/Fortnite.com/Teams` | 团队系统 | 团队共享商品 |
| `/Verse.org/Simulation` | 模拟系统 | 事件监听、协程管理 |

#### 参考文档索引

- [API 模块清单](./api-modules-list.md) - 所有模块的快速索引
- [API 模块能力调研报告](./api-modules-research.md) - 模块能力分析
- [SceneGraph API 参考](./scenegraph-api-reference.md) - 场景图系统详解

### 7.3 内部参考资料

- **API Digest 文件**：`skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md`
  - 第 11573-11699 行：Marketplace 模块完整定义
- **代码库示例**：`skills/programming/verseDev/shared/code_library/`
  - 查找包含 `Marketplace` 的实际项目代码示例

---

## 附录：快速参考表

### A. 核心类型速查

| 类型 | 用途 | 必需修饰符 |
|------|------|-----------|
| `entitlement` | 商品定义 | `<concrete>` |
| `entitlement_offer` | 单品销售 | `<concrete>` |
| `bundle_offer` | 捆绑销售 | `<concrete>` |
| `price_vbucks` | V-Bucks 定价 | - |

### B. 核心函数速查

| 函数 | 用途 | 挂起 |
|------|------|------|
| `BuyOffer` | 购买商品 | ✓ |
| `GrantEntitlement` | 授予商品 | ✓ |
| `GetPurchasedEntitlements` | 查询商品 | ✓ |
| `ConsumeEntitlement` | 消费商品 | ✓ |
| `GetEntitlementsChangedEvent` | 监听变化 | ✗ |
| `ShowOffersDialog` | 显示商店 | ✓ |
| `RestrictPaidRandomItems` | 检查限制 | ✗ |
| `RestrictDirectPromptsToPurchase` | 检查限制 | ✗ |

### C. entitlement 属性速查

| 属性 | 类型 | 用途 | 注意事项 |
|------|------|------|----------|
| `MaxCount` | `int` | 最大拥有数量 | 非消耗品只能为 1 |
| `Consumable` | `logic` | 是否消耗品 | 影响购买和消费逻辑 |
| `PaidRandomItem` | `logic` | 是否随机物品 | 涉及合规要求 |
| `PaidArea` | `logic` | 是否付费区域 | - |
| `ConsequentialToGameplay` | `logic` | 是否影响平衡 | 有优势必须设为 true |

### D. 常见错误速查

| 错误现象 | 可能原因 | 解决方案 |
|---------|---------|----------|
| 永久挂起 | 使用基类 `entitlement` 查询 | 使用具体子类型 |
| 无法购买 | 缺少 `<concrete>` 修饰符 | 添加修饰符 |
| 消费失败 | 商品不是消耗品 | 检查 `Consumable` 属性 |
| 授予失败 | 超过 `MaxCount` | 先消费或检查数量 |
| 运行时错误 | 使用基类监听事件 | 使用具体子类型 |

---

**文档版本**：v1.0
**基于 UEFN 版本**：Release-39.11-CL-49242330
**最后更新**：2026-01-04
**作者**：GitHub Copilot Agent
**审核状态**：待审核

---

## 变更记录

| 日期 | 版本 | 变更说明 |
|------|------|----------|
| 2026-01-04 | v1.0 | 初始版本，完整覆盖 Marketplace 模块 API |
