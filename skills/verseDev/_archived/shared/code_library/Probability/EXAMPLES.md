# EXAMPLES.md - 随机数与概率系统使用示例

本文档展示各模块的实际使用案例。

## 目录
1. [基础随机数生成](#基础随机数生成)
2. [加权随机选择](#加权随机选择)
3. [PRD暴击系统](#prd暴击系统)
4. [掉落表系统](#掉落表系统)
5. [抽卡系统](#抽卡系统)
6. [保底机制](#保底机制)
7. [随机事件](#随机事件)
8. [概率验证](#概率验证)

---

## 基础随机数生成

### 示例1: 使用RNG核心

```verse
using { /YourProject/Probability/RngCore }

# 创建随机数生成器
MyRNG := CreateGenerator()

# 生成随机整数
RandomValue := MyRNG.NextInt(1, 100)

# 生成随机浮点数
RandomFloat := MyRNG.NextFloat(0.0, 1.0)

# 生成随机布尔
RandomBool := MyRNG.NextBool()

# 检查生成次数
GenerationCount := MyRNG.GetGenerationCount()
```

### 示例2: 使用分布函数

```verse
using { /YourProject/Probability/Distribution }

# 正态分布（均值100，标准差15）
NormalValue := Normal(100.0, 15.0)<transacts>

# 指数分布（λ = 0.5）
ExponentialValue := Exponential(0.5)<transacts>

# 泊松分布（平均发生率3）
PoissonValue := Poisson(3.0)<transacts>

# 三角分布（最小0，最大100，众数60）
TriangularValue := Triangular(0.0, 100.0, 60.0)<transacts>
```

---

## 加权随机选择

### 示例3: 装备品质选择

```verse
using { /YourProject/Probability/WeightedSelector }

# 定义装备品质
QualityType := enum{Common, Rare, Epic, Legendary}

# 创建加权选择器
QualitySelector := weighted_selector(QualityType){}

# 添加品质和权重
QualitySelector.AddItem(QualityType.Common, 50.0)      # 50%权重
QualitySelector.AddItem(QualityType.Rare, 30.0)        # 30%权重
QualitySelector.AddItem(QualityType.Epic, 15.0)        # 15%权重
QualitySelector.AddItem(QualityType.Legendary, 5.0)    # 5%权重

# 随机选择
if (SelectedQuality := QualitySelector.SelectOne?[]):
    Print("获得装备品质: {SelectedQuality}")
```

### 示例4: 无重复选择

```verse
using { /YourProject/Probability/NonRepeatSelector }

# 创建BGM选择器（避免连续播放同一首）
BGMSelector := non_repeat_selector(string){}
BGMSelector.AddItem("battle_theme_1")
BGMSelector.AddItem("battle_theme_2")
BGMSelector.AddItem("battle_theme_3")

# 设置不重复深度（最近2次不重复）
set BGMSelector.NoRepeatDepth = 2

# 每次战斗开始时选择BGM
if (NextBGM := BGMSelector.SelectOne?[]):
    Print("播放BGM: {NextBGM}")
```

---

## PRD暴击系统

### 示例5: Dota风格暴击

```verse
using { /YourProject/Probability/PseudoRandomDistribution }
using { /YourProject/Probability/CriticalHit }

# 创建PRD暴击计算器（25%目标暴击率，2倍伤害）
MyCritSystem := CreatePRDCritCalculator(0.25, 2.0)

# 每次攻击时计算
AttackEnemy()<transacts>:void =
    BaseDamage := 100.0
    Result := MyCritSystem.CalculateDamage(BaseDamage)
    
    if (Result.IsCritical):
        Print("暴击！造成 {Result.FinalDamage} 伤害")
        # 播放暴击特效
    else:
        Print("普通攻击，造成 {Result.FinalDamage} 伤害")
    
    # PRD会自动调整下次暴击概率
    CurrentProb := MyCritSystem.GetCurrentProbability()
    Print("下次暴击概率: {CurrentProb}")
```

### 示例6: 多重暴击

```verse
using { /YourProject/Probability/CriticalHit }

# 创建多重暴击系统
# 30%普通暴击 → 50%超级暴击 → 20%极限暴击
MultiCrit := CreateMultiCritCalculator(0.30, 0.50, 0.20)

# 设置伤害倍率
set MultiCrit.NormalCritDamage = 2.0   # 2倍
set MultiCrit.SuperCritDamage = 3.0    # 3倍
set MultiCrit.UltraCritDamage = 5.0    # 5倍

# 攻击
Result := MultiCrit.CalculateDamage(100.0)

if (Result.CritLevel = 3):
    Print("极限暴击！{Result.FinalDamage}伤害")
else if (Result.CritLevel = 2):
    Print("超级暴击！{Result.FinalDamage}伤害")
else if (Result.CritLevel = 1):
    Print("暴击！{Result.FinalDamage}伤害")
```

---

## 掉落表系统

### 示例7: 简单掉落表

```verse
using { /YourProject/Probability/LootTable }

# 定义物品类型
ItemType := enum{Gold, Potion, Gem, Sword}

# 创建掉落表
MonsterLoot := CreateLootTable(ItemType)

# 添加掉落物品
# 参数: (物品, 权重, 最小数量, 最大数量, 掉落概率)
MonsterLoot.AddItem(ItemType.Gold, 50.0, 10, 50, 1.0)      # 100%掉金币
MonsterLoot.AddItem(ItemType.Potion, 30.0, 1, 3, 0.8)      # 80%掉药水
MonsterLoot.AddItem(ItemType.Gem, 15.0, 1, 1, 0.3)         # 30%掉宝石
MonsterLoot.AddItem(ItemType.Sword, 5.0, 1, 1, 0.1)        # 10%掉剑

# 执行掉落
DroppedItems := MonsterLoot.RollLoot()<transacts>

for (Item : DroppedItems):
    Print("掉落: {Item}")
```

### 示例8: 分层掉落（品质系统）

```verse
using { /YourProject/Probability/LootTable }

# 创建分层掉落表
TieredLoot := CreateTieredLootTable(string)

# 添加品质层级
CommonTier := TieredLoot.AddTier("Common", 60.0)      # 60%权重
RareTier := TieredLoot.AddTier("Rare", 30.0)          # 30%权重
EpicTier := TieredLoot.AddTier("Epic", 10.0)          # 10%权重

# 为每个层级添加具体物品
CommonTier.Table.AddSimpleItem("Iron Sword", 1.0)
CommonTier.Table.AddSimpleItem("Leather Armor", 1.0)

RareTier.Table.AddSimpleItem("Steel Sword", 1.0)
RareTier.Table.AddSimpleItem("Chain Armor", 1.0)

EpicTier.Table.AddSimpleItem("Legendary Blade", 1.0)
EpicTier.Table.AddSimpleItem("Dragon Armor", 1.0)

# 执行掉落
LootedItems := TieredLoot.RollTieredLoot()<transacts>
```

---

## 抽卡系统

### 示例9: 原神风格抽卡

```verse
using { /YourProject/Probability/GachaSystem }

# 创建卡池配置
Config := CreateDefaultConfig()
set Config.FiveStarRate = 0.006        # 0.6%五星基础概率
set Config.FiveStarPity = 90            # 90抽硬保底
set Config.FiveStarSoftPity = 75        # 75抽软保底
set Config.FiveStarUpRate = 0.5         # 50% UP概率

# 创建卡池
CharacterPool := CreateGachaPool(string, Config)

# 添加五星角色
CharacterPool.AddCard("Zhongli", 5, true, 1.0)   # UP角色
CharacterPool.AddCard("Diluc", 5, false, 1.0)    # 常驻五星
CharacterPool.AddCard("Qiqi", 5, false, 1.0)     # 常驻五星

# 添加四星角色
CharacterPool.AddCard("Xingqiu", 4, true, 1.0)   # UP四星
CharacterPool.AddCard("Bennett", 4, false, 1.0)  # 常驻四星

# 添加三星武器
CharacterPool.AddCard("Cool Steel", 3, false, 1.0)

# 单抽
if (Card := CharacterPool.SinglePull?[]):
    if (Card.Rarity = 5):
        Print("★★★★★ 获得五星: {Card.Card}")
    else if (Card.Rarity = 4):
        Print("★★★★ 获得四星: {Card.Card}")

# 十连抽
TenPullResults := CharacterPool.TenPull()<transacts>

# 查看保底状态
Print("五星保底: {CharacterPool.GetFiveStarPityCount()}/90")
Print("是否保底UP: {CharacterPool.IsGuaranteedFiveStar()}")
```

---

## 保底机制

### 示例10: 软保底系统

```verse
using { /YourProject/Probability/PitySystem }

# 创建软保底系统
# 参数: 软保底起始, 硬保底, 基础概率, 软保底增量
SoftPitySystem := CreateSoftPity(
    75,      # 75抽开始软保底
    90,      # 90抽硬保底
    0.006,   # 0.6%基础概率
    0.06     # 每抽增加6%
)

# 执行抽卡
for (I := 1..100):
    if (SoftPitySystem.Roll()):
        Print("第{I}抽获得五星！")
        CurrentProb := SoftPitySystem.GetCurrentProbability()
        Print("当前概率: {CurrentProb}")
        break
```

### 示例11: 双保底系统

```verse
using { /YourProject/Probability/PitySystem }

# 创建双保底（角色保底 + UP保底）
DoublePitySystem := CreateDoublePity(
    90,    # 角色保底（第一层）
    2,     # UP保底（第二层，歪两次必中）
    0.006, # 基础五星概率
    0.5    # UP概率（50%）
)

# 模拟抽卡
for (I := 1..200):
    if (DoublePitySystem.Roll()):
        IsUP := not[DoublePitySystem.IsGuaranteedUP()]
        if (IsUP):
            Print("第{I}抽: 获得UP角色！")
        else:
            Print("第{I}抽: 歪了，下次必定UP")
```

---

## 随机事件

### 示例12: 随机遭遇系统

```verse
using { /YourProject/Probability/RandomEvents }

# 定义遭遇类型
EncounterType := enum{Treasure, Enemy, Merchant, Nothing}

# 创建事件管理器
EncounterManager := CreateEventManager(EncounterType)

# 添加事件
EncounterManager.AddEvent(
    EncounterType.Treasure,  # 事件
    10.0,                     # 权重
    1.0,                      # 触发概率
    300.0,                    # 冷却时间（秒）
    false,                    # 不可重复
    1                         # 最多触发1次
)

EncounterManager.AddEvent(EncounterType.Enemy, 40.0, 1.0, 0.0, true, -1)
EncounterManager.AddEvent(EncounterType.Merchant, 15.0, 1.0, 600.0, false, 1)
EncounterManager.AddEvent(EncounterType.Nothing, 35.0, 1.0, 0.0, true, -1)

# 每隔一段时间触发
UpdateEncounter(CurrentTime:float)<transacts>:void =
    EncounterManager.UpdateTime(CurrentTime)
    
    if (Event := EncounterManager.TryTriggerEvent?[]):
        if (Event = EncounterType.Treasure):
            SpawnTreasure()
        else if (Event = EncounterType.Enemy):
            SpawnEnemy()
        else if (Event = EncounterType.Merchant):
            SpawnMerchant()
```

### 示例13: 定时事件

```verse
using { /YourProject/Probability/RandomEvents }

# 创建定时事件管理器
TimedEvents := CreateTimedEventManager(string)

# 添加定时事件
# 每60±10秒刷新一次宝箱
TimedEvents.AddTimedEvent(
    "Treasure Spawn",  # 事件名
    60.0,              # 基础间隔
    10.0,              # 随机范围
    0.0                # 开始时间
)

# 每300±30秒出现BOSS
TimedEvents.AddTimedEvent(
    "Boss Spawn",
    300.0,
    30.0,
    0.0
)

# 每帧更新
OnUpdate(DeltaTime:float)<transacts>:void =
    CurrentGameTime += DeltaTime
    TriggeredEvents := TimedEvents.Update(CurrentGameTime)
    
    for (EventName : TriggeredEvents):
        Print("触发事件: {EventName}")
```

---

## 概率验证

### 示例14: 验证暴击率

```verse
using { /YourProject/Probability/ProbabilityValidator }

# 创建验证器
Validator := CreateValidator()
set Validator.TolerancePercent = 5.0  # 允许5%偏差

# 验证25%暴击率（测试10000次）
Result := Validator.ValidateSimpleProbability(
    "Crit Rate Test",  # 测试名称
    0.25,              # 期望概率
    10000              # 样本数量
)<transacts>

if (Result.Passed):
    Print("✓ 暴击率验证通过")
    Print("期望: {Result.ExpectedValue}")
    Print("实际: {Result.ActualValue}")
    Print("偏差: {Result.DeviationPercent}%")
else:
    Print("✗ 暴击率验证失败")
    Print("偏差过大: {Result.DeviationPercent}%")
```

### 示例15: 验证加权选择

```verse
using { /YourProject/Probability/ProbabilityValidator }

# 定义权重
Weights := array{50.0, 30.0, 15.0, 5.0}  # Common, Rare, Epic, Legendary

# 验证加权选择（测试10000次）
Result := Validator.ValidateWeightedSelection(
    "Loot Quality Test",
    Weights,
    10000
)<transacts>

if (Result.Passed):
    Print("✓ 掉落品质分布正确")
else:
    Print("✗ 掉落品质分布有问题")
    Print("最大偏差: {Result.DeviationPercent}%")
```

### 示例16: 概率追踪

```verse
using { /YourProject/Probability/RandomLogger }

# 创建概率追踪器
CritTracker := CreateTracker("Crit Rate")

# 每次攻击记录结果
OnAttack(IsCrit:logic):void =
    CritTracker.RecordAttempt(IsCrit)
    
    # 每100次攻击输出统计
    if (CritTracker.GetAttemptCount() mod 100 = 0):
        SuccessRate := CritTracker.GetSuccessRate()
        MaxStreak := CritTracker.GetMaxConsecutiveSuccesses()
        Print("暴击率: {SuccessRate}")
        Print("最大连击: {MaxStreak}")
```

---

## 组合使用示例

### 示例17: 完整的战利品系统

```verse
using { /YourProject/Probability/LootTable }
using { /YourProject/Probability/PitySystem }
using { /YourProject/Probability/RandomLogger }

# 战利品管理器
loot_manager := class:
    var LootTable:loot_table(string)
    var PitySystem:pity_counter
    var Logger:random_logger
    
    # 初始化
    Initialize():void =
        set LootTable = CreateLootTable(string)
        set PitySystem = CreatePityCounter(10, 0.1)  # 10次保底，10%基础概率
        set Logger = CreateLogger()
        
        # 配置掉落表
        LootTable.AddItem("Common Item", 50.0, 1, 3, 1.0)
        LootTable.AddItem("Rare Item", 30.0, 1, 2, 0.5)
        LootTable.AddItem("Epic Item", 15.0, 1, 1, 0.2)
        LootTable.AddItem("Legendary Item", 5.0, 1, 1, 0.05)
    
    # 执行掉落
    RollLoot()<transacts>:[]string =
        # 检查保底
        if (PitySystem.Roll()):
            Logger.LogEvent("Pity", "保底触发！")
            # 保底给予稀有物品
            return array{"Legendary Item"}
        
        # 普通掉落
        Items := LootTable.RollLoot()
        Logger.LogEvent("Normal Loot", "掉落{Items.Length}个物品")
        
        Items
```

---

## 性能优化提示

1. **重用对象**: 不要每次都创建新的选择器
2. **限制历史**: 设置合理的历史记录大小
3. **批量操作**: 使用 `AddItems()` 而不是多次 `AddItem()`
4. **关闭日志**: 生产环境禁用详细日志

```verse
# ✓ 好的做法
GlobalCritSystem := CreateCritCalculator(0.25, 2.0)

OnAttack()<transacts>:void =
    Result := GlobalCritSystem.CalculateDamage(100.0)

# ✗ 不好的做法（每次都创建新对象）
OnAttack()<transacts>:void =
    TempCritSystem := CreateCritCalculator(0.25, 2.0)
    Result := TempCritSystem.CalculateDamage(100.0)
```

---

更多示例和详细文档请参考 README.md
