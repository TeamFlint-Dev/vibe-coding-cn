# Helpers 索引

> Helper 层：纯函数计算工具 + UEFN API 封装

---

## 分类规范

Helper 按功能分为四类，通过命名后缀区分：

| 类别 | 后缀 | 职责 | digest 校验 |
|------|------|------|-------------|
| **Utils** | `XXXUtils` | 纯函数通用工具（数学、向量等） | ❌ 不需要 |
| **Calculator** | `XXXCalculator` | 复杂公式计算（伤害、生命值等） | ❌ 不需要 |
| **Wrapper** | `XXXWrapper` | UEFN API 封装 | ✅ **必须校验** |
| **Validator** | `XXXValidator` | 数据校验工具 | ⚠️ 按需 |

> **重要**: Wrapper 类文件必须与 `shared/api-digests/` 中的 API 定义保持一致

---

## 快速导航

### Utils（纯函数工具）

| 模块 | 文件 | 职责 |
|------|------|------|
| MathUtils | [MathUtils.verse](MathUtils.verse) | 数学计算：Clamp、Min/Max、Lerp |
| VectorUtils | [VectorUtils.verse](VectorUtils.verse) | 向量操作：距离、方向、插值 |
| RandomUtils | [RandomUtils.verse](RandomUtils.verse) | 随机工具：选择、权重、洗牌 |
| **⭐ Probability** | [**../Probability/**](../Probability/) | **完整的随机数与概率系统（18个模块）** |

### Calculator（公式计算）

| 模块 | 文件 | 职责 |
|------|------|------|
| DamageCalculator | [DamageCalculator.verse](DamageCalculator.verse) | 伤害计算：暴击、护甲、穿甲 |
| HealthCalculator | [HealthCalculator.verse](HealthCalculator.verse) | 生命值计算：伤害/治疗结果 |

### Wrapper（API 封装）⚠️ 需要 digest 校验

| 模块 | 文件 | 封装 API | digest 参考 |
|------|------|----------|-------------|
| CharacterWrapper | [CharacterWrapper.verse](CharacterWrapper.verse) | `fort_character` | [Fortnite.digest.verse](../api-digests/Fortnite.digest.verse) L11777 |

---

## 设计原则

### Helper 层职责边界

```
┌─────────────────────────────────────────────────────────┐
│                    Helper 层职责                         │
├─────────────────────────────────────────────────────────┤
│ ✅ 纯函数计算（输入 → 输出，无副作用）                    │
│ ✅ UEFN API 封装（统一接口，处理边界条件）                │
│ ✅ 数据验证与安全检查                                    │
│ ✅ 复杂算法实现（可独立测试）                            │
├─────────────────────────────────────────────────────────┤
│ ❌ 持有状态变量                                          │
│ ❌ 直接修改外部状态                                      │
│ ❌ 发送事件                                              │
│ ❌ 依赖运行时上下文                                      │
└─────────────────────────────────────────────────────────┘
```

### Wrapper 编写规范

Wrapper 类文件**必须**：

1. **引用 API 来源**: 在文件头注释中标明 digest 文件和行号
2. **使用正确类型**: 与 digest 定义完全匹配（如 `float` 而非 `int`）
3. **直接调用接口**: `fort_character` 直接实现 `damageable`/`healthful` 等接口，无需 getter

```verse
# ✅ 正确的 Wrapper 实现（基于 Fortnite.digest.verse）
ApplyDamage<public>(Character:fort_character, Amount:float):void =
    # fort_character 直接实现 damageable 接口
    Character.Damage(Amount)

# ❌ 错误的实现（使用不存在的 getter）
ApplyDamage<public>(Character:fort_character, Amount:int):void =
    if (Damageable := Character.GetDamageable[]):  # 不存在！
        Damageable.Damage(Amount)
```

### 调用模式

```verse
# Component 调用 Helper 的标准模式
OnReceiveDamage(Amount:float):void =
    # 1. 调用 Calculator 计算结果（纯逻辑）
    Result := HealthCalculator.CalculateDamageResult(
        CurrentHealth, MaxHealth, Amount, IsInvincible
    )
    
    # 2. 更新本地状态
    set CurrentHealth = Result.NewHealth
    
    # 3. 调用 Wrapper 执行真实效果
    if (Char := BoundCharacter):
        CharacterWrapper.ApplyDamage(Char, -Result.ActualChange)
    
    # 4. 派发事件
    DispatchHealthChanged(Result)
```

---

## 模块详情

### MathUtils

**类型**: Utils（纯函数）  
**职责**: 通用数学计算  
**依赖**: 无

| 函数 | 签名 | 说明 |
|------|------|------|
| Clamp | `(Value, Min, Max) → int/float` | 钳制数值 |
| Min/Max | `(A, B) → int/float` | 取最小/最大 |
| Lerp | `(A, B, T) → float` | 线性插值 |
| Remap | `(Value, InMin, InMax, OutMin, OutMax) → float` | 值重映射 |

---

### VectorUtils

**类型**: Utils（纯函数）  
**职责**: 向量运算  
**依赖**: 无

| 函数 | 签名 | 说明 |
|------|------|------|
| Distance | `(A, B) → float` | 两点距离 |
| IsInRange | `(From, To, Range) → logic` | 范围判定 |
| Direction | `(From, To) → vector3` | 方向向量 |
| Normalize | `(V) → vector3` | 归一化 |

---

### RandomUtils

**类型**: Utils（纯函数）  
**职责**: 随机数工具  
**依赖**: 无

| 函数 | 签名 | 说明 |
|------|------|------|
| SelectRandom | `(Items) → T` | 随机选择 |
| SelectWeighted | `(Items, Weights) → T` | 权重选择 |
| Shuffle | `(Items) → []T` | 洗牌 |
| RandomChance | `(Probability) → logic` | 概率判定 |

---

### DamageCalculator

**类型**: Calculator（公式计算）  
**职责**: 伤害公式计算  
**依赖**: 无

| 函数 | 签名 | 说明 |
|------|------|------|
| CalculateDamage | `(...) → damage_result` | 完整伤害计算 |
| ApplyCritical | `(Damage, Chance, Multi) → (float, logic)` | 暴击计算 |
| ApplyArmorReduction | `(Damage, Armor) → float` | 护甲减免 |
| ApplyArmorPenetration | `(Armor, FlatPen, PctPen) → float` | 穿甲计算 |

---

### HealthCalculator

**类型**: Calculator（公式计算）  
**职责**: 生命值相关计算（纯函数，不调用 API）  
**依赖**: 无

| 函数 | 签名 | 说明 |
|------|------|------|
| CalculateDamageResult | `(HP, MaxHP, Damage, Invincible) → health_change_result` | 伤害结果计算 |
| CalculateHealResult | `(HP, MaxHP, Amount) → health_change_result` | 治疗结果计算 |
| IsLethalDamage | `(HP, Damage, Invincible) → logic` | 致死判定 |
| IsAlive | `(HP) → logic` | 存活判定 |
| IsLowHealth | `(HP, MaxHP, Threshold) → logic` | 低血量判定 |
| ClampHealth | `(HP, MaxHP) → float` | 生命值钳制 |
| GetHealthPercent | `(HP, MaxHP) → float` | 生命值百分比 |
| HitsToKill | `(HP, DamagePerHit) → int` | 击杀所需次数 |

---

### CharacterWrapper

**类型**: Wrapper（API 封装）⚠️ **需要 digest 校验**  
**职责**: UEFN `fort_character` API 封装  
**依赖**: UEFN API  
**API 参考**: [Fortnite.digest.verse](../api-digests/Fortnite.digest.verse) L11777

> `fort_character` 直接实现: `positional`, `healable`, `healthful`, `damageable`, `shieldable`

| 函数 | 签名 | 封装的 API |
|------|------|-----------|
| ApplyDamage | `(Character, Amount:float) → character_op_result` | `damageable.Damage(float)` |
| ApplyHeal | `(Character, Amount:float) → character_op_result` | `healable.Heal(float)` |
| SetHealth | `(Character, Amount:float) → character_op_result` | `healthful.SetHealth(float)` |
| GetHealth | `(Character) → float` | `healthful.GetHealth()` |
| GetMaxHealth | `(Character) → float` | `healthful.GetMaxHealth()` |
| GetShield | `(Character) → float` | `shieldable.GetShield()` |
| SetShield | `(Character, Amount:float) → character_op_result` | `shieldable.SetShield(float)` |
| IsCharacterValid | `(Character) → logic` | `fort_character.IsActive[]` |
| IsAlive | `(Character) → logic` | 检查 `GetHealth() > 0` |
| GetPosition | `(Character) → vector3` | `positional.GetTransform()` |
| TeleportTo | `(Character, Position, Rotation) → logic` | `fort_character.TeleportTo[]` |

---

## 版本历史

| 日期 | 变更 |
|------|------|
| 2025-12-28 | API 一致性修复: HealthHelper → HealthCalculator, CharacterHelper → CharacterWrapper |
| 2025-12-28 | 添加 Helper 分类规范（Utils/Calculator/Wrapper/Validator） |
| 2025-12-27 | CHANGE-004: 添加 HealthHelper, CharacterHelper |
| 2025-12-27 | 创建索引文件 |

---

*最后更新: 2025-12-28*
