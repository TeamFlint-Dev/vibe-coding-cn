# DLSD 代码质量规则

> 规则前缀：`DLSD-QUA-xxx`
> 版本：1.0.0

---

## 规则总览

| ID | 名称 | 级别 | 描述 |
|----|------|------|------|
| DLSD-QUA-001 | 命名规范 | 🔴 阻断 | 必须遵循 DLSD 命名约定 |
| DLSD-QUA-002 | 空值检查 | 🔴 阻断 | 可选类型使用前必须检查 |
| DLSD-QUA-003 | 边界验证 | ⚠️ 警告 | 数值和集合边界必须验证 |
| DLSD-QUA-004 | 函数复杂度 | ⚠️ 警告 | 单个函数不超过 30 行 |
| DLSD-QUA-005 | 注释规范 | ⚠️ 警告 | 公开接口必须有注释 |

---

## 规则详解

### DLSD-QUA-001: 命名规范

**级别**: 🔴 阻断

**描述**: 所有代码必须遵循 DLSD 命名约定。

**检查项**:

| 元素 | 规范 |
|------|------|
| Data Component | `xxx_data` |
| Logic Module | `xxx_logic` |
| Session Class | `xxx_session` |
| Driver Component | `xxx_system` / `xxx_driver` |
| 文件名 | PascalCase.verse |
| 函数名 | PascalCase |
| 变量名 | PascalCase |

**详见**: [naming-conventions.md](naming-conventions.md)

---

### DLSD-QUA-002: 空值检查

**级别**: 🔴 阻断

**描述**: 可选类型（`?T`、`option{T}`）在使用前必须进行检查。

**违规示例**:

```verse
# ❌ 错误：未检查直接使用
ProcessPlayer(MaybePlayer:?player):void =
    MaybePlayer.Damage(10)  # 违规！可能为空
```

**正确示例**:

```verse
# ✅ 正确：先检查再使用
ProcessPlayer(MaybePlayer:?player):void =
    if (Player := MaybePlayer?):
        Player.Damage(10)

# ✅ 或使用 for 解包
ProcessPlayer(MaybePlayer:?player):void =
    for (Player := MaybePlayer?):
        Player.Damage(10)
```

---

### DLSD-QUA-003: 边界验证

**级别**: ⚠️ 警告

**描述**: 数值和集合操作必须进行边界验证。

**数值边界**:

```verse
# ❌ 警告：未做边界检查
SetHealth(Value:int):void =
    set CurrentHealth = Value

# ✅ 正确：边界检查
SetHealth(Value:int):void =
    set CurrentHealth = Clamp(Value, 0, MaxHealth)
```

**集合边界**:

```verse
# ❌ 警告：直接索引
GetItem(Index:int):item_data =
    Items[Index]

# ✅ 正确：边界检查
GetItem(Index:int):?item_data =
    if (Index >= 0 and Index < Items.Length):
        option{Items[Index]}
    else:
        false
```

**除法操作**:

```verse
# ❌ 警告：可能除零
CalculateRatio(A:float, B:float):float =
    A / B

# ✅ 正确：除零保护
CalculateRatio(A:float, B:float):float =
    if (B != 0.0):
        A / B
    else:
        0.0
```

---

### DLSD-QUA-004: 函数复杂度

**级别**: ⚠️ 警告

**描述**: 单个函数不应超过 30 行代码。超过应拆分为多个子函数。

**违规示例**:

```verse
# ❌ 警告：函数过长
ProcessCombat():void =
    # 50+ 行代码...
```

**正确示例**:

```verse
# ✅ 正确：拆分为子函数
ProcessCombat():void =
    ValidateState()
    CalculateDamage()
    ApplyEffects()
    UpdateUI()

ValidateState():void = # ...
CalculateDamage():void = # ...
ApplyEffects():void = # ...
UpdateUI():void = # ...
```

---

### DLSD-QUA-005: 注释规范

**级别**: ⚠️ 警告

**描述**: 公开接口必须有注释说明用途和参数。

**推荐格式**:

```verse
# 计算伤害值
# @param BaseDamage - 基础伤害
# @param Armor - 护甲值
# @param Multiplier - 伤害倍率
# @return 最终伤害值
CalculateDamage(BaseDamage:float, Armor:float, Multiplier:float):float =
    Max(0.0, BaseDamage * Multiplier - Armor)
```

**必须注释的情况**:

- 公开的 CRUD 接口
- 复杂的计算逻辑
- 非显而易见的业务规则
- `<suspends>` 异步函数的行为说明

---

## 快速检查清单

- [ ] 所有类型遵循 DLSD 命名后缀
- [ ] 文件名使用 PascalCase
- [ ] 可选类型使用前已检查
- [ ] 数值操作有边界保护
- [ ] 集合索引有边界检查
- [ ] 除法有除零保护
- [ ] 函数不超过 30 行
- [ ] 公开接口有注释
