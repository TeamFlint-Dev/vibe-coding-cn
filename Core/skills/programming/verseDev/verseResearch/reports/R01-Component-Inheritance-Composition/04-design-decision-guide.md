# 第四章：场景判定与选型决策指南

> **章节编号**: R01-1.4
>
> **最后更新**: 2026-01-05

---

## 📋 本章概要

本章提供继承与组合模式的场景判定标准和决策流程。

**核心内容**:

- 继承 vs 组合的决策树
- 场景分析与模式选择
- 混合使用策略
- 实战决策案例

---

## 4.1 继承 vs 组合决策树

### 完整决策流程

```text
开始设计 Component 功能
        │
        ▼
[问题 1] 是否有明确的 is-a 关系？
        │
        ├─ 是 → [问题 2] 是否属于同一个「类型族」？
        │        │
        │        ├─ 是 → [问题 3] 是否需要共享大量公共实现？
        │        │        │
        │        │        ├─ 是 → ✅ 使用继承
        │        │        │       (示例: light_component 族)
        │        │        │
        │        │        └─ 否 → 问题 4] 是否需要多态性？
        │        │                 │
        │        │                 ├─ 是 → ✅ 使用继承
        │        │                 │
        │        │                 └─ 否 → ⚠️ 考虑组合
        │        │
        │        └─ 否 → ⚠️ 不推荐继承
        │                (示例: car 不应继承 engine)
        │
        └─ 否 → [问题 5] 是否需要聚合多个功能？
                 │
                 ├─ 是 → ✅ 使用组合
                 │       (示例: player = health + movement + inventory)
                 │
                 └─ 否 → ✅ 创建独立 Component
                         (示例: timer_component)
```

### 决策矩阵

| 场景特征 | 继承 | 组合 | 推荐 |
|---------|------|------|------|
| 明确的 is-a 关系 | ✅ | ⚠️ | 继承 |
| has-a 关系 | ❌ | ✅ | 组合 |
| 需要共享大量实现 | ✅ | ⚠️ | 继承 |
| 功能需要灵活组合 | ❌ | ✅ | 组合 |
| 需要多态性 | ✅ | ⚠️ | 继承 |
| 跨类型复用功能 | ❌ | ✅ | 组合 |
| 类型互斥（只能是一种） | ✅ | ⚠️ | 继承 |
| 运行时动态调整 | ❌ | ✅ | 组合 |
| 避免类爆炸 | ❌ | ✅ | 组合 |

---

## 4.2 场景分析与模式选择

### 场景 1：光源类型 → ✅ 使用继承

**需求**: 实现多种类型的光源（平行光、点光源、聚光灯等）。

**分析**:

- ✅ is-a 关系：spot_light **is-a** light
- ✅ 类型族：都属于光源类型
- ✅ 共享实现：颜色、强度、阴影等属性
- ✅ 类型互斥：一个实体不能同时是两种光源
- ✅ 多态性：可以用 light_component 统一处理

**设计**:

```verse
light_component := class<abstract><final_super>(component):
    var LightColor:color = external {}
    var Intensity:float = external {}
    var CastShadows:logic = external {}

spot_light_component := class<final>(light_component):
    var InnerConeAngleDegrees:float = external {}
    var OuterConeAngleDegrees:float = external {}

directional_light_component := class<final>(light_component):
    # 平行光特有属性
```

**结论**: ✅ 继承是正确选择

---

### 场景 2：玩家能力 → ✅ 使用组合

**需求**: 玩家需要生命值、移动、库存、技能等功能。

**分析**:

- ❌ 非 is-a 关系：player **has-a** health（不是 player **is-a** health）
- ✅ 功能聚合：多个独立功能组合
- ✅ 跨类型复用：health、inventory 可用于敌人、NPC 等
- ✅ 灵活组合：可选择性添加功能
- ✅ 动态调整：可运行时添加/移除能力

**设计**:

```verse
health_component := class<final_super>(component):
    var CurrentHealth:int = 100
    var MaxHealth:int = 100

movement_component := class<final_super>(component):
    var Speed:float = 300.0

inventory_component := class<final_super>(component):
    var Items:[]item = array{}

skill_component := class<final_super>(component):
    var Skills:[]skill = array{}

# 组合
CreatePlayer():entity =
    Player := entity{}
    Player.AddComponents(array{
        health_component{},
        movement_component{},
        inventory_component{},
        skill_component{}
    })
    return Player
```

**结论**: ✅ 组合是正确选择

---

### 场景 3：武器系统 → ✅ 使用继承

**需求**: 实现手枪、步枪、霰弹枪等不同武器。

**分析**:

- ✅ is-a 关系：pistol **is-a** weapon
- ✅ 类型族：都属于武器类型
- ✅ 共享实现：伤害、射程、射速等属性
- ✅ 类型互斥：武器槽位只能装备一种武器
- ✅ 多态性：用 weapon_component 统一接口

**设计**:

```verse
weapon_component := class<abstract><final_super>(component):
    var Damage:int = 10
    var Range:float = 100.0
    var FireRate:float = 1.0
    
    Fire(Target:agent)<transacts>:void

pistol_component := class<final>(weapon_component):
    var MagazineSize:int = 12
    
    Fire<override>(Target:agent)<transacts>:void =
        # 手枪射击逻辑

rifle_component := class<final>(weapon_component):
    var BurstCount:int = 3
    
    Fire<override>(Target:agent)<transacts>:void =
        # 步枪射击逻辑
```

**结论**: ✅ 继承是正确选择

---

### 场景 4：NPC 行为 → ⚖️ 混合策略

**需求**: 实现巡逻、追击、守卫等不同 AI 行为。

**分析**:

- ⚠️ 模糊区域：
  - 可以用继承（patrol_ai **is-a** ai）
  - 也可以用组合（npc **has-a** patrol_behavior）
- ✅ 继承优势：共享 AI 基础设施
- ✅ 组合优势：行为可灵活切换

**设计 A：使用继承（基于类型）**

```verse
ai_component := class<abstract><final_super>(component):
    var Target:?agent = option{}
    
    Think()<suspends>:void

patrol_ai_component := class<final>(ai_component):
    var PatrolPoints:[]vector3 = array{}
    
    Think<override>()<suspends>:void =
        # 巡逻逻辑

chase_ai_component := class<final>(ai_component):
    Think<override>()<suspends>:void =
        # 追击逻辑
```

**设计 B：使用组合（基于行为）**

```verse
# AI 框架组件（管理行为）
ai_controller_component := class<final_super>(component):
    var CurrentBehavior:?ai_behavior = option{}
    
    SetBehavior(NewBehavior:ai_behavior):void =
        set CurrentBehavior = option{NewBehavior}

# 独立的行为组件
patrol_behavior_component := class<final_super>(component):
    var PatrolPoints:[]vector3 = array{}
    
    Execute()<suspends>:void =
        # 巡逻逻辑

chase_behavior_component := class<final_super>(component):
    var Target:?agent = option{}
    
    Execute()<suspends>:void =
        # 追击逻辑
```

**结论**: ⚖️ 根据需求选择

- 如果行为固定 → 使用继承（设计 A）
- 如果行为需要动态切换 → 使用组合（设计 B）

---

## 4.3 混合使用策略

### 策略 1：继承基类 + 组合功能

使用继承定义类型族，用组合添加额外功能。

```verse
# 继承定义武器类型
weapon_component := class<abstract><final_super>(component):
    var Damage:int = 10
    
    Fire(Target:agent)<transacts>:void

pistol_component := class<final>(weapon_component):
    Fire<override>(Target:agent)<transacts>:void =
        # 手枪逻辑

# 组合添加额外功能
CreateEnchantedPistol():entity =
    Pistol := entity{}
    Pistol.AddComponents(array{
        pistol_component{Damage := 20},      # 继承自 weapon_component
        fire_element_component{},            # 组合：火焰附魔
        knockback_component{},               # 组合：击退效果
        glow_effect_component{}              # 组合：发光特效
    })
    return Pistol
```

### 策略 2：接口 + 组合

使用接口定义契约，用组合实现功能。

```verse
# 接口定义能力
damageable := interface:
    TakeDamage(Amount:int):void

healable := interface:
    Heal(Amount:int):void

# 独立组件实现接口
health_component := class<final_super>(component, damageable, healable):
    var CurrentHealth:int = 100
    var MaxHealth:int = 100
    
    TakeDamage<override>(Amount:int):void =
        set CurrentHealth -= Amount
    
    Heal<override>(Amount:int):void =
        set CurrentHealth = Clamp(CurrentHealth + Amount, 0, MaxHealth)

# 组合使用
CreateCharacter():entity =
    Character := entity{}
    Character.AddComponents(array{
        health_component{},          # 实现 damageable + healable
        movement_component{}
    })
    return Character
```

### 策略 3：数据驱动 + 组合

使用数据配置替代继承。

```verse
# 不使用继承，而是数据驱动
weapon_config := struct:
    WeaponType:string = "pistol"
    Damage:int = 10
    FireRate:float = 1.0
    ProjectileType:string = "bullet"

# 通用武器组件
generic_weapon_component := class<final_super>(component):
    var Config:weapon_config = weapon_config{}
    
    Fire(Target:agent)<transacts>:void =
        # 根据 Config 决定行为
        if (Config.WeaponType = "pistol"):
            FirePistol(Target)
        else if (Config.WeaponType = "rifle"):
            FireRifle(Target)

# 通过配置创建不同武器
CreatePistol():entity =
    Weapon := entity{}
    Weapon.AddComponents(array{
        generic_weapon_component{Config := weapon_config{
            WeaponType := "pistol",
            Damage := 15
        }}
    })
    return Weapon
```

---

## 4.4 实战决策案例

### 案例 1：技能系统设计

**需求**: 实现火球术、治疗术、闪电链等技能。

**决策过程**:

1. **is-a 关系？** 是（fireball **is-a** skill）
2. **类型族？** 是（都属于技能）
3. **共享实现？** 部分（冷却时间、消耗）
4. **多态性？** 需要（统一技能接口）
5. **灵活组合？** 可能需要（技能组合）

**方案 A：纯继承**

```verse
skill_component := class<abstract><final_super>(component):
    var Cooldown:float = 1.0
    var ManaCost:int = 10
    
    Cast(Caster:agent, Target:agent)<transacts>:void

fireball_skill := class<final>(skill_component):
    var Damage:int = 50
    
    Cast<override>(Caster:agent, Target:agent)<transacts>:void =
        # 火球逻辑

healing_skill := class<final>(skill_component):
    var HealAmount:int = 30
    
    Cast<override>(Caster:agent, Target:agent)<transacts>:void =
        # 治疗逻辑
```

**方案 B：组合**

```verse
skill_data_component := class<final_super>(component):
    var SkillName:string = ""
    var Cooldown:float = 1.0
    var ManaCost:int = 10

skill_effect_component := class<final_super>(component):
    var EffectType:string = "damage"
    var Value:int = 50
    
    Apply(Target:agent):void =
        if (EffectType = "damage"):
            # 造成伤害
        else if (EffectType = "healing"):
            # 治疗

# 组合创建技能
CreateFireball():entity =
    Fireball := entity{}
    Fireball.AddComponents(array{
        skill_data_component{
            SkillName := "Fireball",
            Cooldown := 2.0,
            ManaCost := 20
        },
        skill_effect_component{
            EffectType := "damage",
            Value := 50
        },
        projectile_component{Speed := 1000.0},
        area_of_effect_component{Radius := 200.0}
    })
    return Fireball
```

**决策**: ⚖️ 根据项目规模

- 小型项目（技能少）→ 方案 A（继承，简单直接）
- 大型项目（技能多、需要组合）→ 方案 B（组合，灵活可扩展）

---

### 案例 2：载具系统设计

**需求**: 实现汽车、船、飞机等载具。

**决策过程**:

1. **is-a 关系？** 是（car **is-a** vehicle）
2. **类型互斥？** 是（一个实体不能同时是车和船）
3. **共享实现？** 部分（座位系统、生命值）
4. **特有功能差异大？** 是（陆地/水面/空中物理）

**方案：继承 + 组合**

```verse
# 继承定义载具类型
vehicle_component := class<abstract><final_super>(component):
    var MaxSpeed:float = 500.0
    
    Move(Direction:vector3):void

car_component := class<final>(vehicle_component):
    var WheelCount:int = 4
    
    Move<override>(Direction:vector3):void =
        # 陆地移动逻辑

boat_component := class<final>(vehicle_component):
    var HasSail:logic = false
    
    Move<override>(Direction:vector3):void =
        # 水面移动逻辑

airplane_component := class<final>(vehicle_component):
    var WingSpan:float = 20.0
    
    Move<override>(Direction:vector3):void =
        # 空中移动逻辑

# 组合添加共享功能
CreateCar():entity =
    Car := entity{}
    Car.AddComponents(array{
        car_component{MaxSpeed := 800.0},    # 继承：定义类型
        seating_component{MaxSeats := 4},    # 组合：座位系统
        vehicle_health_component{},          # 组合：生命值
        fuel_component{}                     # 组合：燃料系统
    })
    return Car
```

**决策**: ✅ 混合策略最佳

- 继承定义载具类型（类型互斥）
- 组合添加共享功能（灵活复用）

---

## 4.5 常见错误与纠正

### 错误 1：滥用继承

**错误示例**:

```verse
# ❌ 错误：player 继承 health
player_component := class<final_super>(component):
    var Health:int = 100
    var Speed:float = 300.0
    var Inventory:[]item = array{}
    # 混合了太多职责
```

**纠正**:

```verse
# ✅ 正确：使用组合
CreatePlayer():entity =
    Player := entity{}
    Player.AddComponents(array{
        health_component{},
        movement_component{},
        inventory_component{}
    })
    return Player
```

---

### 错误 2：过度组合导致复杂度

**错误示例**:

```verse
# ❌ 错误：为每个小功能都创建组件
CreateButton():entity =
    Button := entity{}
    Button.AddComponents(array{
        button_position_component{},
        button_size_component{},
        button_color_component{},
        button_text_component{},
        button_click_handler_component{},
        button_hover_effect_component{},
        button_sound_component{}
        # 太细粒度了！
    })
    return Button
```

**纠正**:

```verse
# ✅ 正确：合并相关功能
button_component := class<final_super>(component):
    var Position:vector2 = vector2{X:=0.0, Y:=0.0}
    var Size:vector2 = vector2{X:=100.0, Y:=50.0}
    var Color:color = color{R:=1.0, G:=1.0, B:=1.0}
    var Text:string = "Button"
    
    OnClick():void = {}
    OnHover():void = {}
```

---

## 📊 本章总结

| 主题 | 核心要点 |
|------|----------|
| **决策树** | 基于 is-a、has-a 关系判断 |
| **场景分析** | 光源、玩家、武器等典型案例 |
| **混合策略** | 继承+组合、接口+组合、数据驱动 |
| **实战案例** | 技能系统、载具系统设计 |
| **常见错误** | 滥用继承、过度组合 |
| **推荐原则** | 优先组合，谨慎继承 |

---

## 📚 下一章预告

[第五章：生命周期协同、事件与状态流转](./05-lifecycle-and-events.md)

- Component 生命周期详解
- 多组件生命周期协同
- Scene Events 事件系统
- 状态机与状态流转

---

**章节作者**: GitHub Copilot Agent
**最后审核**: 2026-01-05
