---
name: verse-component
description: 组件层 - 自定义组件编写、Entity类封装、功能模块实现
version: 1.0.0
layer: 3
---

# Verse Component

> **类型**: Layer 3 - 组件层  
> **职责**: 自定义组件编写规范、Entity类封装模式、可复用功能模块实现

---

## When to Use This Skill

当需要：
- 实现自定义 component 类
- 封装自定义 entity 类
- 创建可复用的功能模块
- 组装已有组件形成新功能

**前置条件**:
- `@architecture-blueprint.md` 中的 Component 清单已确定
- 事件流层已设计完成

---

## 核心职责

### 0. 设计原则【重要 - CHANGE-004 更新】

> **Component 层是状态管理和事件调度的唯一出口**

```
┌─────────────────────────────────────────────────────────────┐
│                 Component 层职责边界                         │
├─────────────────────────────────────────────────────────────┤
│ ✅ 持有状态变量（var CurrentHealth, var IsActive）          │
│ ✅ 提供事件处理器（OnReceiveDamage, OnCollision）            │
│ ✅ 绑定真实游戏对象（BoundCharacter: fort_character）        │
│ ✅ 发送事件通知（SendUp, Dispatch）                          │
│ ✅ 调用 Helper 层获取计算结果                                │
├─────────────────────────────────────────────────────────────┤
│ ❌ 包含复杂计算逻辑（应委托给 Helper）                        │
│ ❌ 直接调用 UEFN API（应通过 API 封装 Helper）                │
│ ❌ 硬编码数值（应使用 @editable 配置）                        │
└─────────────────────────────────────────────────────────────┘
```

**Component 的三层结构**:

| 层次 | 职责 | 示例 |
|------|------|------|
| **状态层** | 持有运行时状态变量 | `var CurrentHealth`, `var IsInvincible` |
| **接口层** | 提供公开方法和事件处理器 | `OnReceiveDamage()`, `GetCurrentHealth()` |
| **绑定层** | 连接真实游戏对象 | `var BoundCharacter: ?fort_character` |

**新的组件模式**（vs 旧模式对比）:

```verse
# ❌ 旧模式：Component 内含计算逻辑
health_component_old := class(component):
    TakeDamage(Amount:int):void =
        if IsInvincible:                           # 计算在 Component 内
            return
        set CurrentHealth = Max(0, CurrentHealth - Amount)  # 计算在 Component 内
        # ...

# ✅ 新模式：Component 只管状态，计算委托给 Helper
health_component := class(component):
    # 状态层
    var CurrentHealth<private>:int = 0
    var IsInvincible<private>:logic = false
    
    # 绑定层（连接真实游戏对象）
    var BoundCharacter<private>:?fort_character = false
    
    # 事件处理器
    OnReceiveDamage(Amount:int):void =
        # 1. 调用 Helper 计算结果（纯函数）
        Result := HealthHelper.CalculateDamageResult(
            CurrentHealth, MaxHealth, Amount, IsInvincible
        )
        
        # 2. 更新内部状态
        set CurrentHealth = Result.NewHealth
        
        # 3. 同步到真实游戏对象（通过 API 封装 Helper）
        if (Character := BoundCharacter?):
            CharacterHelper.ApplyDamage(Character, Result.ActualChange)
        
        # 4. 发送事件通知
        if (Owner := GetOwner()):
            Owner.SendUp(health_changed_event{...})
```

**为什么要这样设计**:
1. **可测试性**: Helper 纯函数可以独立单元测试
2. **可复用性**: 同一个 HealthHelper 可用于敌人、Boss、建筑等
3. **关注点分离**: Component 专注状态流转，Helper 专注计算逻辑
4. **游戏集成**: BoundCharacter 绑定解决了 ISSUE-004（变量与游戏系统脱节）

### 1. 自定义组件编写

实现 `@architecture-blueprint.md` 中定义的每个组件：

```verse
# 组件模板
my_component := class(component):
    # 配置属性（可在编辑器中设置）
    @editable var MaxValue:int = 100
    
    # 运行时状态
    var CurrentValue<private>:int = 0
    
    # 生命周期
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        Initialize()
    
    # 对外接口
    GetCurrentValue():int = CurrentValue
    SetCurrentValue(Value:int):void =
        set CurrentValue = Clamp(Value, 0, MaxValue)
```

### 2. Entity类封装

为复杂系统创建自定义Entity类：

```verse
# 自定义Entity类（复杂系统推荐）
player_entity := class(entity):
    var PlayerID<private>:string
    
    # 初始化方法
    Initialize(ID:string):void =
        set PlayerID = ID
        AddComponents(array{
            health_component{MaxHealth := 100},
            inventory_component{SlotCount := 20},
            movement_component{Speed := 5.0}
        })
    
    # 对外接口
    GetHealth():int =
        if (HC := GetComponent<health_component>()):
            return HC.GetCurrentHealth()
        return 0
    
    TakeDamage(Amount:int):void =
        if (HC := GetComponent<health_component>()):
            HC.TakeDamage(Amount)
```

### 3. 功能模块实现

将相关组件组合成完整功能模块：

```verse
# 功能模块：战斗系统
# 包含：health_component + attack_component + shield_component

combat_module := struct:
    Health:health_component
    Attack:attack_component
    Shield:?shield_component  # 可选

SetupCombatModule(Entity:entity, Config:combat_config):combat_module =
    HC := health_component{MaxHealth := Config.MaxHealth}
    AC := attack_component{BaseDamage := Config.BaseDamage}
    SC := if Config.HasShield:
        option{shield_component{MaxShield := Config.MaxShield}}
    else:
        false
    
    Components := array{HC, AC}
    if (Shield := SC?):
        set Components += array{Shield}
    
    Entity.AddComponents(Components)
    
    return combat_module{Health := HC, Attack := AC, Shield := SC}
```

---

## 组件设计原则

### 单一职责

```verse
# ✅ 好：每个组件只负责一件事
health_component := class(component):
    # 只负责生命值
    var CurrentHealth:int
    var MaxHealth:int
    TakeDamage(Amount:int):void
    Heal(Amount:int):void

shield_component := class(component):
    # 只负责护盾
    var CurrentShield:int
    var MaxShield:int
    AbsorbDamage(Amount:int):int  # 返回剩余伤害

# ❌ 差：职责过多
combat_component := class(component):
    # 混合了生命值、护盾、攻击
    var Health:int
    var Shield:int
    var Damage:int
    TakeDamage():void
    Attack():void
    UseShield():void
```

### 数据驱动

```verse
# ✅ 好：通过配置驱动行为
attack_component := class(component):
    @editable var BaseDamage:int = 10
    @editable var AttackRange:float = 5.0
    @editable var AttackCooldown:float = 1.0
    @editable var DamageType:damage_type = damage_type.Physical

# ❌ 差：硬编码数值
attack_component := class(component):
    Attack():void =
        DealDamage(10)  # 硬编码
        Wait(1.0)       # 硬编码
```

### 松耦合

```verse
# ✅ 好：通过事件通信
attack_component := class(component):
    OnAttackHit(Target:entity):void =
        if (Owner := GetOwner()):
            Event := damage_dealt_event{Target := Target, Damage := BaseDamage}
            Owner.SendUp(Event)  # 通过事件通知

# ❌ 差：直接引用其他组件
attack_component := class(component):
    var ScoreComponent:score_component  # 直接引用！
    
    OnAttackHit(Target:entity):void =
        ScoreComponent.AddScore(10)  # 紧耦合
```

---

## 常用组件模板

### 生命值组件（新模式）

```verse
# ============================================
# health_component - 遵循 CHANGE-004 架构
# ============================================
# 职责边界：
# - ✅ 持有状态（CurrentHealth, IsInvincible）
# - ✅ 提供事件处理器（OnReceiveDamage, OnReceiveHeal）
# - ✅ 绑定真实游戏对象（BoundCharacter）
# - ✅ 发送事件通知
# - ❌ 不含计算逻辑（委托给 HealthHelper）
# - ❌ 不直接调用 UEFN API（通过 CharacterHelper）
# ============================================

health_component := class(component):
    # ========================================
    # 配置属性（可在编辑器中设置）
    # ========================================
    @editable var MaxHealth:int = 100
    @editable var EnableRegen:logic = false
    @editable var RegenRate:int = 5
    @editable var RegenInterval:float = 1.0
    
    # ========================================
    # 状态层（私有运行时状态）
    # ========================================
    var CurrentHealth<private>:int = 0
    var IsInvincible<private>:logic = false
    var IsDead<private>:logic = false
    
    # ========================================
    # 绑定层（连接真实游戏对象）
    # ========================================
    var BoundCharacter<private>:?fort_character = false
    
    # ========================================
    # 生命周期
    # ========================================
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        set CurrentHealth = MaxHealth
        
        # 启动自动回复（如果启用）
        if EnableRegen:
            spawn{ RegenLoop() }
    
    # ========================================
    # 绑定方法（连接真实游戏对象）
    # ========================================
    BindCharacter(Character:fort_character):void =
        set BoundCharacter = option{Character}
        
        # 同步初始血量到真实角色
        if (CurrentHP := CharacterHelper.GetHealth(Character)?):
            set CurrentHealth = CurrentHP
        if (MaxHP := CharacterHelper.GetMaxHealth(Character)?):
            set MaxHealth = MaxHP
    
    UnbindCharacter():void =
        set BoundCharacter = false
    
    # ========================================
    # 事件处理器（对外接口）
    # ========================================
    
    # 接收伤害事件
    OnReceiveDamage(Amount:int):void =
        if IsDead:
            return
        
        # 1. 调用 Helper 计算结果（纯函数，无副作用）
        Result := HealthHelper.CalculateDamageResult(
            CurrentHealth, MaxHealth, Amount, IsInvincible
        )
        
        # 2. 更新内部状态
        set CurrentHealth = Result.NewHealth
        
        # 3. 同步到真实游戏对象（通过 API 封装 Helper）
        if (Character := BoundCharacter?):
            CharacterHelper.ApplyDamage(Character, Result.ActualChange)
        
        # 4. 发送事件通知
        DispatchHealthChanged()
        
        # 5. 检查死亡
        if Result.WasLethal:
            HandleDeath()
    
    # 接收治疗事件
    OnReceiveHeal(Amount:int):void =
        if IsDead:
            return
        
        # 1. 调用 Helper 计算结果
        Result := HealthHelper.CalculateHealResult(
            CurrentHealth, MaxHealth, Amount
        )
        
        # 2. 更新内部状态
        set CurrentHealth = Result.NewHealth
        
        # 3. 同步到真实游戏对象
        if (Character := BoundCharacter?):
            CharacterHelper.ApplyHeal(Character, Result.ActualChange)
        
        # 4. 发送事件通知
        DispatchHealthChanged()
    
    # 设置无敌状态
    SetInvincible(Duration:float)<suspends>:void =
        set IsInvincible = true
        Sleep(Duration)
        set IsInvincible = false
    
    # ========================================
    # 状态查询（只读接口）
    # ========================================
    GetCurrentHealth():int = CurrentHealth
    GetMaxHealth():int = MaxHealth
    IsAlive():logic = not IsDead
    GetHealthPercent():float = HealthHelper.GetHealthPercent(CurrentHealth, MaxHealth)
    
    # ========================================
    # 内部方法
    # ========================================
    HandleDeath<private>():void =
        set IsDead = true
        if (Owner := GetOwner()):
            Owner.SendUp(entity_died_event{})
    
    DispatchHealthChanged<private>():void =
        if (Owner := GetOwner()):
            Owner.SendUp(health_changed_event{
                CurrentHealth := CurrentHealth,
                MaxHealth := MaxHealth,
                Percent := GetHealthPercent()
            })
    
    RegenLoop<private>()<suspends>:void =
        loop:
            Sleep(RegenInterval)
            if not IsDead and CurrentHealth < MaxHealth:
                OnReceiveHeal(RegenRate)
```

### 移动组件

```verse
movement_component := class(component):
    @editable var MoveSpeed:float = 5.0
    @editable var RotationSpeed:float = 180.0
    
    var CurrentVelocity<private>:vector3 = vector3{}
    var IsMoving<private>:logic = false
    
    # 接口
    MoveTo(Position:vector3)<suspends>:void =
        if (Owner := GetOwner()):
            if (Transform := Owner.GetComponent<transform_component>()):
                set IsMoving = true
                
                StartPos := Transform.GetPosition()
                Distance := CalculateDistance(StartPos, Position)
                Duration := Distance / MoveSpeed
                
                # 使用插值移动
                MoveOverTime(Transform, StartPos, Position, Duration)
                
                set IsMoving = false
    
    Stop():void =
        set IsMoving = false
        set CurrentVelocity = vector3{}
    
    # 内部方法
    MoveOverTime(Transform:transform_component, From:vector3, To:vector3, Duration:float)<suspends>:void =
        ElapsedTime := 0.0
        loop:
            if not IsMoving:
                break
            
            ElapsedTime += GetDeltaTime()
            Progress := Min(1.0, ElapsedTime / Duration)
            
            CurrentPos := Lerp(From, To, Progress)
            Transform.SetPosition(CurrentPos)
            
            if Progress >= 1.0:
                break
            
            Sleep(0.0)
```

### 交互组件

```verse
my_interactable := class(interactable_component):
    @editable var InteractionPrompt:string = "按 E 交互"
    @editable var InteractionCooldown:float = 1.0
    @editable var MaxUses:int = -1  # -1 表示无限
    
    var UseCount<private>:int = 0
    var LastUseTime<private>:float = -999.0
    
    # 重写交互方法
    OnInteract<override>(Player:agent):void =
        CurrentTime := GetSimulationTime()
        
        # 检查冷却
        if (CurrentTime - LastUseTime) < InteractionCooldown:
            return
        
        # 检查使用次数
        if MaxUses > 0 and UseCount >= MaxUses:
            return
        
        # 执行交互
        set UseCount = UseCount + 1
        set LastUseTime = CurrentTime
        
        HandleInteraction(Player)
        
        # 发送事件
        if (Owner := GetOwner()):
            Owner.SendUp(interaction_event{
                Player := Player,
                Interactable := Owner
            })
    
    # 子类实现
    HandleInteraction(Player:agent):void = {}
```

---

## Entity类 vs 纯组件

### 何时使用自定义Entity类

| 场景 | 推荐方式 | 原因 |
|------|----------|------|
| 复杂游戏对象（玩家、Boss） | 自定义Entity类 | 需要统一对外接口 |
| 需要严格控制组件组合 | 自定义Entity类 | 防止错误组合 |
| 简单道具、特效 | 纯组件 | 灵活性优先 |
| 动态生成的临时对象 | 纯组件 | 便于动态修改 |

### 混合模式

```verse
# 复杂系统：自定义Entity类
boss_entity := class(entity):
    Initialize():void =
        AddComponents(array{
            health_component{MaxHealth := 10000},
            boss_ai_component{},
            boss_phase_component{PhaseCount := 3}
        })
    
    # 对外接口
    GetCurrentPhase():int
    TriggerRage():void

# 简单对象：纯组件方式
CreateProjectile(Position:vector3, Direction:vector3):entity =
    Projectile := entity{}
    Projectile.AddComponents(array{
        projectile_component{Speed := 20.0, Direction := Direction},
        damage_component{Damage := 50},
        lifetime_component{Duration := 5.0}
    })
    return Projectile
```

---

## 下沉请求模板

当组件层需要底层支持时：

```markdown
## 下沉请求: CMPREQ-001

**请求层级**: Layer 2 (操作层)
**请求类型**: helper-request

**需求描述**:
health_component 需要数值钳制函数

**期望接口**:
```verse
Clamp(Value:int, Min:int, Max:int):int
Min(A:int, B:int):int
Max(A:int, B:int):int
```

**上下文约束**:
- 需要支持 int 和 float 类型
- 高频调用，需要高性能
```

---

## 问题上报模板

```markdown
## Issue Report: CMP-001

**Skill**: verse-component
**层级**: Layer 3
**问题描述**: 组件间数据共享模式不清晰
**触发场景**: 多个组件需要访问同一数据时
**当前处理**: 通过GetComponent互相访问
**建议改进**: 在SKILL.md中添加数据共享模式说明
```

---

## Quick Reference

### 组件生命周期

```
OnAddedToScene → OnBeginSimulation → OnSimulate(循环) → OnEndSimulation → OnRemovingFromScene
```

### 组件与Helper协作模式【CHANGE-004】

```
┌─────────────────────────────────────────────────────────────────┐
│                  Component → Helper 调用流程                     │
├─────────────────────────────────────────────────────────────────┤
│  事件触发                                                        │
│      ↓                                                          │
│  Component.OnReceiveXxx()                                       │
│      ↓                                                          │
│  XxxHelper.CalculateResult()  ← 纯函数计算                       │
│      ↓                                                          │
│  更新 Component 状态变量                                         │
│      ↓                                                          │
│  CharacterHelper.ApplyXxx()   ← 同步到真实游戏对象                │
│      ↓                                                          │
│  Owner.SendUp(xxx_event{})    ← 发送事件通知                     │
└─────────────────────────────────────────────────────────────────┘
```

### 依赖的 Helper 模块

| Component | 依赖的 Helper | 用途 |
|-----------|---------------|------|
| health_component | HealthHelper | 伤害/治疗计算 |
| health_component | CharacterHelper | 同步到 fort_character |
| attack_component | AttackHelper | 攻击判定计算 |
| movement_component | MovementHelper | 移动插值计算 |

### 组件通信方式

| 方式 | 适用场景 | 代码 |
|------|----------|------|
| 事件 | 松耦合通信 | `SendUp/Down(event)` |
| GetComponent | 同Entity组件 | `Owner.GetComponent<T>()` |
| 参数传递 | 初始化时 | 构造函数参数 |

### 属性修饰符

| 修饰符 | 作用 |
|--------|------|
| `@editable` | 可在编辑器中设置 |
| `<private>` | 私有，外部不可访问 |
| `var` | 可变变量 |

### 新模式 vs 旧模式速查

```verse
# ❌ 旧模式 - Component 内含计算
TakeDamage(Amount:int):void =
    set CurrentHealth = Max(0, CurrentHealth - Amount)  # 计算在 Component

# ✅ 新模式 - 计算委托给 Helper
OnReceiveDamage(Amount:int):void =
    Result := HealthHelper.CalculateDamageResult(...)   # 计算在 Helper
    set CurrentHealth = Result.NewHealth                 # Component 只更新状态
    CharacterHelper.ApplyDamage(BoundCharacter, ...)    # API 调用也委托
```

---

## Reference Files

- [@architecture-blueprint.md](../shared/memory-bank-template/@architecture-blueprint.md) - 架构大纲
- [scenegraph-framework-guide.md](../shared/references/scenegraph-framework-guide.md) - 组件系统详解
- [helper-request.md](../shared/request-templates/helper-request.md) - Helper请求模板
- [verse-helpers/SKILL.md](../verse-helpers/SKILL.md) - Helper层技能（HealthHelper, CharacterHelper）

---

*最后更新: 2025-12-27 (CHANGE-004: Helper/Component 职责分离)*
