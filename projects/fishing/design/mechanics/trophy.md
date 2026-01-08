# 🐟 战利品系统 - 机制设计

> **系统**：Trophy System  
> **版本**：v1.0  
> **前置依赖**：`@mechanics/fishing.md`  
> **生成者**：game-mechanics-designer

---

## 一、系统概述

**核心职责**：管理战利品的获取、存储、查看和状态追踪。

**设计目标**：

- 清晰的收集进度反馈
- 首次发现的惊喜感
- 背包管理简单直观

---

## 二、数据模型

### 2.1 鱼数据结构

```verse
fish_data := struct:
    Id : string           # 唯一标识 "fish_001"
    Name : string         # 显示名称 "小鲤鱼"
    Rarity : rarity_tier  # 稀有度等级
    BaseIncome : int      # 基础收益值
    Size : fish_size      # 尺寸分类
    Description : string  # 图鉴描述
    ModelRef : string     # 3D 模型引用

rarity_tier := enum:
    Common
    Uncommon
    Rare
    Epic
    Legendary

fish_size := enum:
    Small    # 小型鱼
    Medium   # 中型鱼
    Large    # 大型鱼
```

### 2.2 背包物品结构

```verse
inventory_item := struct:
    FishId : string       # 鱼种 ID
    Quantity : int        # 持有数量
    CaughtAt : timestamp  # 首次获取时间
```

### 2.3 图鉴条目结构

```verse
collection_entry := struct:
    FishId : string       # 鱼种 ID
    IsDiscovered : logic  # 是否已发现
    TotalCaught : int     # 累计捕获数
    LargestSize : float   # 最大尺寸记录
    FirstCaughtAt : ?timestamp
```

---

## 三、功能模块

### 3.1 背包管理 (Inventory)

**容量限制**：MVP 无上限（简化设计）

**操作清单**：

| 操作 | 触发条件 | 结果 |
|------|----------|------|
| AddFish | 钓鱼成功 | 数量 +1 或新增条目 |
| RemoveFish | 放置到展示位 | 数量 -1，为 0 则删除 |
| QueryFish | UI 查看 | 返回背包内容 |

**伪代码**：

```verse
AddToInventory(FishId : string) : void =
    if Inventory.Contains(FishId):
        Inventory[FishId].Quantity += 1
    else:
        Inventory.Add(FishId, inventory_item{
            FishId := FishId,
            Quantity := 1,
            CaughtAt := GetCurrentTime()
        })
    
    UpdateCollection(FishId)
```

---

### 3.2 图鉴系统 (Collection)

**进度追踪**：

| 统计项 | 描述 | 用途 |
|--------|------|------|
| 发现数 | 已发现的鱼种数 | 成就触发 |
| 总捕获 | 累计捕获所有鱼的数量 | 里程碑 |
| 稀有度分布 | 各稀有度捕获数 | 进度展示 |

**首次发现奖励**：

| 稀有度 | 首发奖励 | 视觉效果 |
|--------|----------|----------|
| Common | 10 金币 | 「新发现！」标签 |
| Uncommon | 25 金币 | 绿色闪光 |
| Rare | 100 金币 | 蓝色光柱 |
| Epic | 500 金币 | 紫色烟花 |

**伪代码**：

```verse
UpdateCollection(FishId : string) : void =
    entry := Collection[FishId]
    entry.TotalCaught += 1
    
    if not entry.IsDiscovered:
        entry.IsDiscovered = true
        entry.FirstCaughtAt = GetCurrentTime()
        
        fishData := FishDatabase.Get(FishId)
        reward := GetFirstDiscoveryReward(fishData.Rarity)
        Player.AddGold(reward)
        
        PlayFirstDiscoveryEffect(fishData.Rarity)
```

---

### 3.3 鱼种数据库 (FishDatabase)

**MVP 鱼种数据**：

| ID | 名称 | 稀有度 | 基础收益 | 尺寸 | 描述 |
|----|------|--------|----------|------|------|
| fish_001 | 小鲤鱼 | Common | 1 | Small | 最常见的淡水鱼，肉质鲜嫩 |
| fish_002 | 草鱼 | Common | 1 | Medium | 喜欢吃水草的温顺鱼类 |
| fish_003 | 金鲫鱼 | Uncommon | 2 | Small | 带有金色鳞片的观赏鱼 |
| fish_004 | 锦鲤 | Rare | 5 | Medium | 寓意吉祥的美丽鲤鱼 |
| fish_005 | 黄金锦鲤 | Epic | 15 | Large | 极其罕见的纯金色锦鲤 |

---

## 四、UI 界面设计

### 4.1 背包界面

```
┌────────────────────────────────────────────────┐
│  🎒 我的背包                        [X] 关闭   │
├────────────────────────────────────────────────┤
│                                                │
│  ┌────┐  ┌────┐  ┌────┐  ┌────┐  ┌────┐       │
│  │🐟  │  │🐟  │  │🐟  │  │🐟  │  │🐟  │       │
│  │ x3 │  │ x1 │  │ x2 │  │ x1 │  │    │       │
│  └────┘  └────┘  └────┘  └────┘  └────┘       │
│  小鲤鱼   草鱼   金鲫鱼   锦鲤                  │
│                                                │
├────────────────────────────────────────────────┤
│  选中: 锦鲤 ⭐⭐⭐ (稀有)                       │
│  收益: 5 金币/秒                               │
│  描述: 寓意吉祥的美丽鲤鱼                       │
│                                                │
│  [放置到展示位]                                 │
└────────────────────────────────────────────────┘
```

### 4.2 图鉴界面

```
┌────────────────────────────────────────────────┐
│  📖 鱼类图鉴              已发现: 4/5          │
├────────────────────────────────────────────────┤
│                                                │
│  ┌────────────────────────────────────────┐    │
│  │ 🐟 小鲤鱼                    捕获: 12  │    │
│  │    ⚪ 普通 | 收益: 1 | 首发: 2025-12-26│    │
│  └────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────┐    │
│  │ 🐟 草鱼                       捕获: 8  │    │
│  │    ⚪ 普通 | 收益: 1 | 首发: 2025-12-26│    │
│  └────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────┐    │
│  │ 🐟 金鲫鱼                     捕获: 3  │    │
│  │    🟢 稀有 | 收益: 2 | 首发: 2025-12-26│    │
│  └────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────┐    │
│  │ 🐟 锦鲤                       捕获: 1  │    │
│  │    🔵 精良 | 收益: 5 | 首发: 2025-12-26│    │
│  └────────────────────────────────────────┘    │
│  ┌────────────────────────────────────────┐    │
│  │ ❓ ???                        捕获: 0  │    │
│  │    🟣 史诗 | 尚未发现                  │    │
│  └────────────────────────────────────────┘    │
│                                                │
└────────────────────────────────────────────────┘
```

---

## 五、事件接口

### 5.1 接收事件

| 事件 | 来源 | 处理 |
|------|------|------|
| `OnFishCaught` | 钓鱼系统 | 添加到背包，更新图鉴 |

### 5.2 发出事件

| 事件 | 触发条件 | 数据 |
|------|----------|------|
| `OnInventoryChanged` | 背包变化 | itemList |
| `OnNewDiscovery` | 首次发现 | fishData, reward |
| `OnTrophyPlaced` | 放置到展示位 | fishId, slotId |

---

## 六、与基地系统的交互

### 放置流程

```
玩家打开背包
    │
    ▼
选择一条鱼
    │
    ▼
点击「放置到展示位」
    │
    ▼
查询可用展示位 ──[无可用]──▶ 提示「展示位已满」
    │
  [有可用]
    │
    ▼
显示展示位选择界面
    │
    ▼
玩家选择位置
    │
    ▼
从背包移除 + 通知基地系统
    │
    ▼
基地系统放置鱼 + 更新收益
```

---

## 七、UEFN 实现要点

### 数据持久化

```verse
# 使用 Fortnite 的持久化存储
trophy_persistence := class:
    InventoryData : [string]int     # FishId -> Quantity
    CollectionData : [string]int    # FishId -> TotalCaught
    DiscoveredSet : [string]logic   # FishId -> IsDiscovered
    
    SaveToPlayer(Player : agent) : void =
        # 使用 UEFN 的 persistable 特性保存
        
    LoadFromPlayer(Player : agent) : void =
        # 从玩家存档读取
```

### 性能考虑

- 图鉴数据在游戏开始时一次性加载
- 背包变化采用增量更新
- UI 只在打开时刷新，不实时渲染

---

## 八、下一步

**战利品系统机制设计完成** ✅

下一个系统：`@mechanics/base.md` - 基地系统机制

---

*文档生成时间：2025-12-26*
