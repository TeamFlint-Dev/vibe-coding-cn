# 第三章：组合模式原理与典型用例

> **章节编号**: R01-1.3
>
> **最后更新**: 2026-01-05

---

## 📋 本章概要

本章深入探讨 Verse Component 组合模式的原理、优势和典型用例。

**核心内容**:

- 组合模式的定义与原则
- 多组件协作的设计模式
- 事件驱动的组件间通信
- 组合模式的典型实践案例
- 组合 vs 继承的权衡

---

## 3.1 组合模式基础

### 什么是组合模式？

**组合模式（Composition Pattern）** 是将独立的功能封装为多个 Component，通过 Entity 聚合，形成 has-a 关系的设计模式。

```verse
# 继承模式（is-a）
player_component := class<final_super>(component):
    var Health:int = 100
    var Speed:float = 300.0
    var Inventory:[]item = array{}
    # 一个巨大的类

# ✅ 组合模式（has-a）
health_component := class<final_super>(component):
    var CurrentHealth:int = 100
    var MaxHealth:int = 100

movement_component := class<final_super>(component):
    var Speed:float = 300.0

inventory_component := class<final_super>(component):
    var Items:[]item = array{}

# 通过组合创建玩家
CreatePlayer():entity =
    Player := entity{}
    Player.AddComponents(array{
        health_component{},
        movement_component{},
        inventory_component{}
    })
    return Player
```

### 组合模式的核心原则

**1. 单一职责（Single Responsibility）**

每个 Component 只负责一个功能。

```verse
# ✅ 好的设计：职责单一
health_component := class<final_super>(component):
    var CurrentHealth:int = 100
    var MaxHealth:int = 100
    
    TakeDamage(Amount:int):void =
        set CurrentHealth = Clamp(CurrentHealth - Amount, 0, MaxHealth)
    
    Heal(Amount:int):void =
        set CurrentHealth = Clamp(CurrentHealth + Amount, 0, MaxHealth)
    
    IsDead()<computes>:logic =
        CurrentHealth <= 0

# ❌ 坏的设计：职责混乱
player_god_component := class<final_super>(component):
    var Health:int = 100
    var Speed:float = 300.0
    var Inventory:[]item = array{}
    var Position:vector3 = vector3{X:=0.0, Y:=0.0, Z:=0.0}
    # 太多不相关的职责！
```

**2. 松耦合（Loose Coupling）**

Component 间通过事件通信，避免直接引用。

```verse
# ✅ 好的设计：事件驱动
damage_event := struct:
    Amount:int
    Source:agent

health_component := class<final_super>(component):
    OnBeginSimulation<override>()<suspends>:void =
        # Entity property is directly available
            # 订阅伤害事件
            Entity.SendUp(scene_event{}.Subscribe(OnDamageReceived))
    
    OnDamageReceived(Event:damage_event):void =
        TakeDamage(Event.Amount)

# ❌ 坏的设计：紧耦合
health_component := class<final_super>(component):
    OnBeginSimulation<override>()<suspends>:void =
        # Entity property is directly available
            # 直接引用其他组件
            if (Combat := Entity.GetComponent[combat_component]()):
                # 强依赖 combat_component
```

**3. 高内聚（High Cohesion）**

Component 内部的功能紧密相关。

```verse
# ✅ 高内聚：inventory 相关功能都在一起
inventory_component := class<final_super>(component):
    var Items:[]item = array{}
    var MaxSlots:int = 20
    
    AddItem(Item:item)<decides>:void =
        if (Items.Length < MaxSlots):
            set Items = Items + array{Item}
        else:
            # 背包已满
            false
    
    RemoveItem(Item:item)<decides>:void =
        # 移除物品逻辑
    
    GetItemCount():int =
        Items.Length
    
    HasItem(ItemType:type{item})<decides>:logic =
        # 检查物品逻辑
```

**4. 可组合性（Composability）**

Component 可以自由组合，形成不同的功能集。

```verse
# 不同类型的实体通过组合不同的组件创建

# 玩家：health + movement + inventory + input
CreatePlayer():entity =
    Player := entity{}
    Player.AddComponents(array{
        health_component{MaxHealth := 100},
        movement_component{Speed := 300.0},
        inventory_component{MaxSlots := 30},
        player_input_component{}
    })
    return Player

# 敌人：health + ai + movement + attack
CreateEnemy():entity =
    Enemy := entity{}
    Enemy.AddComponents(array{
        health_component{MaxHealth := 50},
        ai_component{},
        movement_component{Speed := 200.0},
        attack_component{Damage := 10}
    })
    return Enemy

# 道具箱：transform + mesh + interactable + loot
CreateLootBox():entity =
    Box := entity{}
    Box.AddComponents(array{
        transform_component{},
        mesh_component{},
        interactable_component{},
        loot_container_component{}
    })
    return Box
```

---

## 3.2 多组件协作模式

### 模式 1：事件驱动协作

组件通过 Scene Events 进行解耦通信。

```verse
# 定义事件
player_died_event := struct:
    Player:agent

item_picked_event := struct:
    Item:entity

damage_dealt_event := struct:
    Amount:int
    Source:agent
    Target:agent

# 组件 1：health_component（发送事件）
health_component := class<final_super>(component):
    var CurrentHealth:int = 100
    
    TakeDamage(Amount:int):void =
        set CurrentHealth -= Amount
        
        if (CurrentHealth <= 0):
            # 发送死亡事件
            # Entity property is directly available
                Entity.SendUp(player_died_event{Player := GetAgent()})

# 组件 2：respawn_component（接收事件）
respawn_component := class<final_super>(component):
    var RespawnTime:float = 5.0
    
    OnBeginSimulation<override>()<suspends>:void =
        # Entity property is directly available
            # 订阅死亡事件
            Entity.SendUp(scene_event{}.Subscribe(OnPlayerDied))
    
    OnPlayerDied(Event:player_died_event)<suspends>:void =
        # 等待复活时间
        Sleep(RespawnTime)
        
        # 复活玩家
        # Entity property is directly available
            if (Health := Entity.GetComponent[health_component]()):
                Health.Respawn()

# 组件 3：score_component（接收事件）
score_component := class<final_super>(component):
    var Score:int = 0
    
    OnBeginSimulation<override>()<suspends>:void =
        # Entity property is directly available
            # 订阅伤害事件
            Entity.SendUp(scene_event{}.Subscribe(OnDamageDealt))
    
    OnDamageDealt(Event:damage_dealt_event):void =
        # 造成伤害时加分
        set Score += Event.Amount
```

**优势**:

- ✅ 解耦：组件不需要知道彼此的存在
- ✅ 灵活：可以添加/移除监听者而不影响发送者
- ✅ 可扩展：新组件可以订阅现有事件

### 模式 2：数据共享协作

通过共享数据结构进行协作（谨慎使用）。

```verse
# 共享数据结构
player_state := struct:
    var Health:int = 100
    var Position:vector3 = vector3{X:=0.0, Y:=0.0, Z:=0.0}
    var IsAlive:logic = true

# 组件 1：维护状态
state_manager_component := class<final_super>(component):
    var PlayerState:player_state = player_state{}
    
    UpdateHealth(NewHealth:int):void =
        set PlayerState.Health = NewHealth
        set PlayerState.IsAlive = NewHealth > 0

# 组件 2：读取状态
ui_component := class<final_super>(component):
    OnBeginSimulation<override>()<suspends>:void =
        spawn:
            loop:
                # Entity property is directly available
                    if (StateMgr := Entity.GetComponent[state_manager_component]()):
                        # 读取共享状态
                        DisplayHealth(StateMgr.PlayerState.Health)
                Sleep(0.1)
```

**注意事项**:

- ⚠️ 谨慎使用：容易导致耦合
- ⚠️ 线程安全：注意并发访问
- ✅ 适用场景：性能敏感的频繁数据访问

### 模式 3：观察者模式

一个组件监视另一个组件的状态变化。

```verse
# 被观察的组件
observable_health_component := class<final_super>(component):
    var CurrentHealth:int = 100
    var OnHealthChanged:event_type{int} = event_type{}
    
    SetHealth(NewHealth:int):void =
        if (NewHealth <> CurrentHealth):
            set CurrentHealth = NewHealth
            # 触发事件
            OnHealthChanged.Invoke(CurrentHealth)

# 观察者组件
health_bar_component := class<final_super>(component):
    OnBeginSimulation<override>()<suspends>:void =
        # Entity property is directly available
            if (Health := Entity.GetComponent[observable_health_component]()):
                # 订阅健康值变化
                Health.OnHealthChanged.Subscribe(UpdateHealthBar)
    
    UpdateHealthBar(NewHealth:int):void =
        # 更新血条显示
        Print("Health: {NewHealth}")
```

---

## 3.3 典型组合模式实践案例

### 案例 1：RPG 玩家实体

```verse
# 独立的功能组件

# 1. 属性组件
character_stats_component := class<final_super>(component):
    var Level:int = 1
    var Experience:int = 0
    var Strength:int = 10
    var Agility:int = 10
    var Intelligence:int = 10
    
    AddExperience(Amount:int):void =
        set Experience += Amount
        CheckLevelUp()
    
    CheckLevelUp():void =
        ExpNeeded := Level * 100
        if (Experience >= ExpNeeded):
            set Level += 1
            set Experience -= ExpNeeded

# 2. 生命值组件
health_component := class<final_super>(component):
    var CurrentHealth:int = 100
    var MaxHealth:int = 100
    
    TakeDamage(Amount:int):void =
        set CurrentHealth = Clamp(CurrentHealth - Amount, 0, MaxHealth)

# 3. 法力值组件
mana_component := class<final_super>(component):
    var CurrentMana:int = 100
    var MaxMana:int = 100
    
    UseMana(Amount:int)<decides>:logic =
        if (CurrentMana >= Amount):
            set CurrentMana -= Amount
            true
        else:
            false

# 4. 装备组件
equipment_component := class<final_super>(component):
    var Weapon:?item = option{}
    var Armor:?item = option{}
    var Accessory:?item = option{}
    
    EquipWeapon(NewWeapon:item):void =
        set Weapon = option{NewWeapon}

# 5. 技能组件
skill_component := class<final_super>(component):
    var LearnedSkills:[]skill = array{}
    var ActiveSkills:[]skill = array{}
    
    LearnSkill(NewSkill:skill):void =
        set LearnedSkills = LearnedSkills + array{NewSkill}

# 6. 任务组件
quest_component := class<final_super>(component):
    var ActiveQuests:[]quest = array{}
    var CompletedQuests:[]quest = array{}
    
    AcceptQuest(NewQuest:quest):void =
        set ActiveQuests = ActiveQuests + array{NewQuest}

# 组合成完整的 RPG 玩家
CreateRPGPlayer():entity =
    Player := entity{}
    Player.AddComponents(array{
        character_stats_component{Level := 1},
        health_component{MaxHealth := 100},
        mana_component{MaxMana := 100},
        equipment_component{},
        skill_component{},
        quest_component{},
        inventory_component{MaxSlots := 30},
        movement_component{Speed := 300.0}
    })
    return Player
```

### 案例 2：塔防游戏的防御塔

```verse
# 独立的功能组件

# 1. 目标检测组件
targeting_component := class<final_super>(component):
    var DetectionRange:float = 500.0
    var CurrentTarget:?entity = option{}
    
    FindTarget()<suspends>:void =
        loop:
            # 查找范围内的敌人
            if (FoundTarget := ScanForEnemies(DetectionRange)):
                set CurrentTarget = option{FoundTarget}
            else:
                set CurrentTarget = option{}
            Sleep(0.5)

# 2. 攻击组件
attack_component := class<final_super>(component):
    var Damage:int = 10
    var AttackRate:float = 1.0
    var ProjectileSpeed:float = 1000.0
    
    Attack(Target:entity)<suspends>:void =
        # 发射弹药
        LaunchProjectile(Target, Damage, ProjectileSpeed)

# 3. 升级组件
upgrade_component := class<final_super>(component):
    var Level:int = 1
    var UpgradeCost:int = 100
    
    Upgrade()<decides>:logic =
        # 升级逻辑
        if (CanAffordUpgrade()):
            set Level += 1
            ApplyUpgradeBonus()
            true
        else:
            false

# 4. 特效组件
vfx_component := class<final_super>(component):
    var MuzzleFlashEffect:?particle_system = option{}
    var HitEffect:?particle_system = option{}
    
    PlayMuzzleFlash():void =
        # 播放枪口闪光
    
    PlayHitEffect():void =
        # 播放命中特效

# 组合成防御塔
CreateTurret():entity =
    Turret := entity{}
    Turret.AddComponents(array{
        transform_component{},
        mesh_component{},
        targeting_component{DetectionRange := 1000.0},
        attack_component{Damage := 20, AttackRate := 2.0},
        upgrade_component{},
        vfx_component{}
    })
    return Turret
```

### 案例 3：载具系统

```verse
# 独立的功能组件

# 1. 驾驶组件
drivable_component := class<final_super>(component):
    var Driver:?agent = option{}
    var MaxSpeed:float = 800.0
    var Acceleration:float = 200.0
    
    EnterVehicle(Player:agent)<decides>:logic =
        if (not Driver?):
            set Driver = option{Player}
            true
        else:
            false
    
    ExitVehicle()<decides>:logic =
        if (Driver?):
            set Driver = option{}
            true
        else:
            false

# 2. 载具物理组件
vehicle_physics_component := class<final_super>(component):
    var CurrentSpeed:float = 0.0
    var CurrentDirection:vector3 = vector3{X:=1.0, Y:=0.0, Z:=0.0}
    
    ApplyAcceleration(Amount:float):void =
        set CurrentSpeed += Amount
    
    ApplyBraking(Amount:float):void =
        set CurrentSpeed = Max(CurrentSpeed - Amount, 0.0)
    
    Turn(Angle:float):void =
        # 转向逻辑

# 3. 座位组件
seating_component := class<final_super>(component):
    var Seats:[]seat_data = array{}
    var MaxPassengers:int = 4
    
    AddPassenger(Player:agent)<decides>:logic =
        if (Seats.Length < MaxPassengers):
            # 添加乘客
            true
        else:
            false

# 4. 载具生命值组件
vehicle_health_component := class<final_super>(component):
    var CurrentHealth:int = 1000
    var MaxHealth:int = 1000
    var IsDestroyed:logic = false
    
    TakeDamage(Amount:int):void =
        set CurrentHealth -= Amount
        
        if (CurrentHealth <= 0):
            Destroy()
    
    Destroy():void =
        set IsDestroyed = true
        # 强制所有乘客下车
        EjectAllPassengers()

# 组合成载具
CreateCar():entity =
    Car := entity{}
    Car.AddComponents(array{
        transform_component{},
        mesh_component{},
        drivable_component{MaxSpeed := 1000.0},
        vehicle_physics_component{},
        seating_component{MaxPassengers := 4},
        vehicle_health_component{MaxHealth := 1000}
    })
    return Car
```

---

## 3.4 组合模式的优势

### 优势对比表

| 维度 | 组合模式 | 继承模式 |
|------|---------|---------|
| **灵活性** | ✅ 高（运行时可变） | ⚠️ 低（编译时确定） |
| **复用性** | ✅ 组件跨类型复用 | ⚠️ 通过基类复用 |
| **耦合度** | ✅ 低（事件驱动） | ⚠️ 高（子类依赖父类） |
| **扩展性** | ✅ 易扩展（添加组件） | ⚠️ 难扩展（修改基类） |
| **维护性** | ✅ 易维护（独立组件） | ⚠️ 难维护（牵一发动全身） |
| **可测试性** | ✅ 易测试（单元测试） | ⚠️ 难测试（依赖关系复杂） |

### 具体优势说明

**1. 运行时灵活性**

```verse
# ✅ 组合：可以动态添加/移除功能
Player := entity{}
Player.AddComponents(array{
    health_component{}
})

# 运行时添加飞行能力
Player.AddComponents(array{
    flying_component{}
})

# 继承：无法运行时改变类型
# player 实例一旦创建，类型就固定了
```

**2. 功能跨类型复用**

```verse
# ✅ 组合：health_component 可用于任何实体
Player.AddComponents(array{health_component{MaxHealth := 100}})
Enemy.AddComponents(array{health_component{MaxHealth := 50}})
Vehicle.AddComponents(array{health_component{MaxHealth := 1000}})
DestructibleProp.AddComponents(array{health_component{MaxHealth := 20}})

# ⚠️ 继承：需要为每种类型创建子类
# player_with_health
# enemy_with_health
# vehicle_with_health
# ...
```

**3. 避免类爆炸**

```verse
# ✅ 组合：通过组合创建任意功能集
# 飞行 + 射击 + 护盾
CreateFlyingShootingShieldedEnemy():entity =
    Enemy := entity{}
    Enemy.AddComponents(array{
        flying_component{},
        shooting_component{},
        shield_component{}
    })
    return Enemy

# ⚠️ 继承：需要创建大量子类
# flying_enemy
# shooting_enemy
# flying_shooting_enemy
# shielded_enemy
# flying_shielded_enemy
# shooting_shielded_enemy
# flying_shooting_shielded_enemy  # 类爆炸！
```

**4. 易于单元测试**

```verse
# ✅ 组合：可以独立测试每个组件
TestHealthComponent():void =
    TestEntity := entity{}
    Health := health_component{MaxHealth := 100}
    TestEntity.AddComponents(array{Health})
    
    # 测试 TakeDamage
    Health.TakeDamage(30)
    Assert(Health.CurrentHealth = 70)
    
    # 测试 Heal
    Health.Heal(20)
    Assert(Health.CurrentHealth = 90)

# ⚠️ 继承：需要创建完整的对象层次
TestPlayer():void =
    Player := player_component{}  # 可能依赖很多父类功能
    # 难以隔离测试单个功能
```

---

## 3.5 组合模式的挑战

### 挑战 1：组件间协调复杂度

当多个组件需要协作时，协调逻辑可能变得复杂。

```verse
# 问题示例：多个组件需要同步
# health_component 死亡时，需要：
# - movement_component 停止移动
# - attack_component 停止攻击
# - ai_component 停止 AI
# - animation_component 播放死亡动画

# 解决方案：使用事件协调
player_died_event := struct:
    Player:agent

health_component := class<final_super>(component):
    OnDeath():void =
        # Entity property is directly available
            # 发送死亡事件，所有相关组件监听
            Entity.SendUp(player_died_event{Player := GetAgent()})

movement_component := class<final_super>(component):
    OnBeginSimulation<override>()<suspends>:void =
        # Entity property is directly available
            Entity.SendUp(scene_event{}.Subscribe(OnPlayerDied))
    
    OnPlayerDied(Event:player_died_event):void =
        StopMovement()
```

### 挑战 2：性能开销

过多的组件和事件订阅可能影响性能。

**优化策略**:

- ✅ 使用对象池复用组件实例
- ✅ 批量处理事件而非逐个处理
- ✅ 避免每帧都查询组件
- ✅ 缓存常用的组件引用

```verse
# ✅ 好的实践：缓存组件引用
my_controller := class<final_super>(component):
    var CachedHealth:?health_component = option{}
    var CachedMovement:?movement_component = option{}
    
    OnBeginSimulation<override>()<suspends>:void =
        # Entity property is directly available
            # 初始化时缓存组件引用
            set CachedHealth = Entity.GetComponent[health_component]()
            set CachedMovement = Entity.GetComponent[movement_component]()
    
    Update():void =
        # 使用缓存的引用，避免重复查询
        if (Health := CachedHealth?):
            # 使用 Health
```

### 挑战 3：组件依赖管理

某些组件可能依赖其他组件的存在。

```verse
# 问题：health_bar_component 依赖 health_component

# 解决方案 1：在 OnBegin 中检查依赖
health_bar_component := class<final_super>(component):
    OnBeginSimulation<override>()<suspends>:void =
        # Entity property is directly available
            if (not Entity.GetComponent[health_component]()):
                # 缺少依赖的组件
                Print("Error: health_bar_component requires health_component")

# 解决方案 2：使用工厂函数确保依赖
CreatePlayerWithHealthBar():entity =
    Player := entity{}
    Player.AddComponents(array{
        health_component{},         # 先添加依赖
        health_bar_component{}      # 再添加依赖者
    })
    return Player
```

---

## 📊 本章总结

| 主题 | 核心要点 |
|------|----------|
| **组合定义** | 通过 Entity 聚合多个独立 Component，形成 has-a 关系 |
| **核心原则** | 单一职责、松耦合、高内聚、可组合性 |
| **协作模式** | 事件驱动、数据共享、观察者模式 |
| **典型案例** | RPG 玩家、防御塔、载具系统 |
| **主要优势** | 灵活性高、复用性强、解耦、易扩展、易维护、易测试 |
| **主要挑战** | 协调复杂度、性能开销、依赖管理 |
| **推荐度** | ✅ 官方推荐，优先使用 |

---

## 📚 下一章预告

[第四章：场景判定与选型决策指南](./04-design-decision-guide.md)

- 继承 vs 组合的决策流程
- 场景分析与模式选择
- 混合使用的策略
- 实战决策案例分析

---

**章节作者**: GitHub Copilot Agent
**最后审核**: 2026-01-05
