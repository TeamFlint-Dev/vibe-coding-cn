# 💰 收益系统 - 机制设计

> **系统**：Income System  
> **版本**：v1.0  
> **前置依赖**：`@mechanics/base.md`  
> **生成者**：game-mechanics-designer

---

## 一、系统概述

**核心职责**：计算并累积展示中战利品产生的被动收益。

**设计目标**：

- 被动收益给玩家「挂机有进度」的满足感
- 收益可视化，玩家清楚知道赚了多少
- 激励玩家放置更稀有的鱼

---

## 二、收益模型

### 2.1 基础公式

```
每秒收益 = Σ(展示鱼.BaseIncome × 稀有度倍率 × 全局加成)

稀有度倍率:
- Common    : 1.0x
- Uncommon  : 2.0x
- Rare      : 5.0x
- Epic      : 15.0x
- Legendary : 50.0x (MVP 不含)
```

### 2.2 示例计算

```
展示位 1: 小鲤鱼 (Common, BaseIncome=1)  → 1 × 1.0 = 1
展示位 2: 锦鲤 (Rare, BaseIncome=5)      → 5 × 5.0 = 25
展示位 3: 空

每秒总收益 = 1 + 25 = 26 金币/秒
```

### 2.3 全局加成（预留扩展）

| 加成类型 | 效果 | MVP 状态 |
|----------|------|----------|
| VIP 加成 | +50% 收益 | 不实现 |
| 活动加成 | 双倍收益 | 不实现 |
| 满展示奖励 | 3 个位都放满 +20% | 可选 |

---

## 三、累积机制

### 3.1 在线累积

```
┌─────────────────────────────────────────┐
│              累积定时器                  │
│                                         │
│  每 1 秒执行:                            │
│    1. 计算当前每秒收益                   │
│    2. 累积到待领取池                     │
│    3. 更新 UI 显示                       │
│                                         │
│  累积池上限: 3600 秒 (1 小时) 的收益     │
│                                         │
└─────────────────────────────────────────┘
```

### 3.2 离线收益（MVP 简化版）

```
进入游戏时:
    1. 读取上次退出时间
    2. 计算离线时长 (最大 4 小时)
    3. 离线收益 = 离线时长 × 上次每秒收益 × 离线效率(50%)
    4. 加入待领取池
```

**离线收益限制**：

| 参数 | 值 | 说明 |
|------|-----|------|
| 最大离线时长 | 4 小时 | 超过不再累积 |
| 离线效率 | 50% | 鼓励在线游玩 |
| 离线收益上限 | 10000 金币 | 防止经济膨胀 |

---

## 四、领取机制

### 4.1 领取触发

| 方式 | 描述 |
|------|------|
| 主动领取 | 点击「领取」按钮 |
| 自动领取 | 累积池满时自动触发 |

### 4.2 领取流程

```
┌──────────────┐
│ 玩家点击领取 │
└──────────────┘
       │
       ▼
┌──────────────┐
│ 检查累积池   │
└──────────────┘
       │
       │ 累积 > 0
       ▼
┌──────────────┐
│ 播放领取动画 │
│ 金币飞向钱包 │
└──────────────┘
       │
       ▼
┌──────────────┐
│ 转移到钱包   │
│ 清空累积池   │
└──────────────┘
       │
       ▼
┌──────────────┐
│ 显示获得数值 │
│ "+1234 金币" │
└──────────────┘
```

---

## 五、数据结构

```verse
income_system := class:
    var IncomePerSecond : float = 0.0       # 当前每秒收益
    var AccumulatedGold : float = 0.0       # 待领取池
    var LastUpdateTime : timestamp          # 上次更新时间
    var LastExitTime : ?timestamp           # 上次退出时间
    
    # 常量
    MAX_ACCUMULATION_SECONDS : float = 3600.0
    MAX_OFFLINE_HOURS : float = 4.0
    OFFLINE_EFFICIENCY : float = 0.5
    MAX_OFFLINE_GOLD : float = 10000.0
```

---

## 六、事件接口

### 6.1 接收事件

| 事件 | 来源 | 处理 |
|------|------|------|
| `OnDisplayChanged` | 基地系统 | 重新计算每秒收益 |
| `OnGameStart` | 游戏系统 | 计算离线收益 |
| `OnGameExit` | 游戏系统 | 记录退出时间 |

### 6.2 发出事件

| 事件 | 触发条件 | 数据 |
|------|----------|------|
| `OnIncomeUpdated` | 每秒收益变化 | newIncomePerSecond |
| `OnGoldClaimed` | 领取成功 | claimedAmount |
| `OnAccumulationFull` | 累积池满 | currentAmount |

---

## 七、UI 设计

### 7.1 收益面板（常驻）

```
┌────────────────────────────────┐
│  💰 金币: 1,234               │
│  📈 收益: 26/秒               │
│                                │
│  待领取: 156 金币              │
│  ████████░░ 15%               │
│  [  领  取  ]                  │
└────────────────────────────────┘
```

### 7.2 离线收益弹窗

```
┌────────────────────────────────────────┐
│                                        │
│     💤 欢迎回来！                       │
│                                        │
│     你离开了 2 小时 30 分               │
│                                        │
│     展示的鱼为你赚取了:                  │
│                                        │
│          💰 2,340 金币                 │
│                                        │
│         [  太棒了！  ]                  │
│                                        │
└────────────────────────────────────────┘
```

---

## 八、平衡参数表

| 参数 | 值 | 可调范围 | 影响 |
|------|-----|----------|------|
| `TICK_INTERVAL` | 1s | 0.5-2s | 累积精度 |
| `MAX_ACCUMULATION` | 1h | 30m-4h | 回流频率 |
| `MAX_OFFLINE_HOURS` | 4h | 2-8h | 离线收益上限 |
| `OFFLINE_EFFICIENCY` | 50% | 30-80% | 在线激励 |
| `FULL_DISPLAY_BONUS` | 20% | 10-30% | 放满奖励 |

---

## 九、UEFN 实现要点

### 9.1 定时累积

```verse
income_manager := class(creative_device):
    var AccumulatedGold : float = 0.0
    var IncomePerSecond : float = 0.0
    
    OnBegin<override>()<suspends> : void =
        loop:
            Sleep(1.0)
            AccumulateIncome()
    
    AccumulateIncome() : void =
        maxAccumulation := IncomePerSecond * 3600.0
        if AccumulatedGold < maxAccumulation:
            set AccumulatedGold += IncomePerSecond
            UpdateUI()
```

### 9.2 离线收益计算

```verse
CalculateOfflineIncome(LastExitTime : timestamp) : float =
    CurrentTime := GetCurrentTime()
    OfflineSeconds := Min(
        CurrentTime - LastExitTime,
        4.0 * 3600.0  # 最大 4 小时
    )
    
    RawIncome := OfflineSeconds * LastIncomePerSecond
    OfflineIncome := RawIncome * 0.5  # 50% 效率
    
    return Min(OfflineIncome, 10000.0)  # 上限 10000
```

---

## 十、收益曲线预估

### MVP 阶段收益预期

| 游戏阶段 | 展示配置 | 每秒收益 | 每小时收益 |
|----------|----------|----------|-----------|
| 新手期 | 1x Common | 1 | 3,600 |
| 成长期 | 2x Uncommon + 1x Common | 5 | 18,000 |
| 中期 | 2x Rare + 1x Uncommon | 27 | 97,200 |
| 后期 | 2x Epic + 1x Rare | 55 | 198,000 |

### 与升级系统的平衡

```
鱼竿 Lv1 → Lv2 费用: 150 金币
以新手期收益: 150 ÷ 3600 ≈ 2.5 分钟

鱼竿 Lv5 → Lv6 费用: 759 金币  
以成长期收益: 759 ÷ 18000 ≈ 2.5 分钟

→ 保持升级节奏相对恒定
```

---

## 十一、下一步

**收益系统机制设计完成** ✅

下一个系统：`@mechanics/upgrade.md` - 升级系统机制

---

*文档生成时间：2025-12-26*
