# Components 索引

> Component 层：状态管理 + 事件处理

---

## 快速导航

| 组件 | 文件 | 职责 |
|------|------|------|
| [HealthComponent](#healthcomponent) | [HealthComponent.verse](HealthComponent.verse) | 生命值状态管理 |
| [MovementComponent](#movementcomponent) | [MovementComponent.verse](MovementComponent.verse) | 移动状态管理 |
| [AttackComponent](#attackcomponent) | [AttackComponent.verse](AttackComponent.verse) | 攻击状态管理 |
| [ProjectileComponent](#projectilecomponent) | [ProjectileComponent.verse](ProjectileComponent.verse) | 投射物状态 |
| [SpawnerComponent](#spawnercomponent) | [SpawnerComponent.verse](SpawnerComponent.verse) | 生成器状态 |
| [TriggerZoneComponent](#triggerzonecomponent) | [TriggerZoneComponent.verse](TriggerZoneComponent.verse) | 触发区域状态 |
| [InventoryComponent](#inventorycomponent) | [InventoryComponent.verse](InventoryComponent.verse) | 库存状态 |
| [StateMachineComponent](#statemachinecomponent) | [StateMachineComponent.verse](StateMachineComponent.verse) | 状态机管理 |

---

## 设计原则

### Component 层职责

```
┌─────────────────────────────────────────────────────────┐
│                  Component 层职责                        │
├─────────────────────────────────────────────────────────┤
│ ✅ 持有状态变量                                          │
│ ✅ 响应事件（OnXxx 处理器）                              │
│ ✅ 派发事件（通知其他系统）                              │
│ ✅ 调用 Helper 进行逻辑计算                              │
│ ✅ 绑定真实游戏对象（可选）                              │
├─────────────────────────────────────────────────────────┤
│ ❌ 包含复杂计算逻辑（应委托给 Helper）                    │
│ ❌ 直接调用 UEFN API（应通过 Helper 封装）               │
│ ❌ 硬编码业务规则                                        │
└─────────────────────────────────────────────────────────┘
```

### 标准 Component 结构

```verse
my_component := class(component):
    # ═══════════ 状态变量 ═══════════
    var StateA<private>:int = 0
    var StateB<private>:logic = false
    
    # ═══════════ 绑定对象（可选）═══════════
    var BoundObject<public>:?some_type = false
    
    # ═══════════ 事件处理器 ═══════════
    OnSomeEvent<public>(Data:event_data):void =
        # 1. 调用 Helper 计算
        Result := SomeHelper.Calculate(StateA, Data.Value)
        
        # 2. 更新状态
        set StateA = Result.NewValue
        
        # 3. 执行真实效果（通过 Helper）
        if (Obj := BoundObject):
            SomeHelper.ApplyEffect(Obj, Result)
        
        # 4. 派发结果事件
        if (Owner := GetOwner()):
            Owner.SendUp(result_event{...})
    
    # ═══════════ 状态查询（只读）═══════════
    GetStateA<public>():int = StateA
    IsStateB<public>():logic = StateB
```

---

## 组件详情

### HealthComponent

**职责**: 生命值状态管理  
**依赖 Helper**: HealthHelper, CharacterHelper  
**派发事件**: health_changed_event, entity_died_event

| 状态 | 类型 | 说明 |
|------|------|------|
| CurrentHealth | int | 当前生命值 |
| MaxHealth | int | 最大生命值 |
| IsInvincible | logic | 无敌状态 |

| 事件处理器 | 触发条件 | 行为 |
|------------|----------|------|
| OnReceiveDamage | 收到伤害 | 计算→更新→应用→派发 |
| OnReceiveHeal | 收到治疗 | 计算→更新→应用→派发 |

---

### MovementComponent

**职责**: 移动状态管理  
**依赖 Helper**: MovementHelper (待创建)  
**派发事件**: movement_state_changed_event

| 状态 | 类型 | 说明 |
|------|------|------|
| CurrentState | movement_state | 移动状态枚举 |
| BaseSpeed | float | 基础移动速度 |
| SpeedModifiers | []float | 速度修饰符列表 |

---

### AttackComponent

**职责**: 攻击状态管理  
**依赖 Helper**: DamageCalculator, CooldownManager  
**派发事件**: attack_event, attack_hit_event

---

*(其他组件详情见各自 .verse 文件)*

---

## 版本历史

| 日期 | 变更 |
|------|------|
| 2025-12-27 | CHANGE-004: 重构职责划分 |
| 2025-12-27 | 创建索引文件 |

---

*最后更新: 2025-12-27*
