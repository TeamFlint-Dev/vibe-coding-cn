# 代码质量检查清单

> 用于 verse-code-auditor 的代码质量检查依据

---

## 命名规范 (QUA-001)

### 类型命名

| 类型 | 规范 | 示例 |
|------|------|------|
| Component | `snake_case` + `_component` 后缀 | `health_component` |
| Entity | `snake_case` + `_entity` 后缀 | `player_entity` |
| Event | `snake_case` + `_event` 后缀 | `damage_taken_event` |
| Helper 模块 | `PascalCase` | `DamageCalculator` |
| Helper 函数 | `PascalCase` | `CalculateDamage()` |

### 变量命名

| 场景 | 规范 | 示例 |
|------|------|------|
| 公开变量 | `PascalCase` | `var MaxHealth:int` |
| 私有变量 | `PascalCase` | `var CurrentHealth<private>:int` |
| 参数 | `PascalCase` | `(Amount:int, Target:entity)` |
| 局部变量 | `PascalCase` | `NewHealth := ...` |

### 禁止项

- ❌ 单字母变量名（除循环变量 `I`, `J`）
- ❌ 无意义缩写（`hp`, `dmg`, `amt`）
- ❌ 拼音命名
- ❌ 数字后缀区分同类变量（`Damage1`, `Damage2`）

---

## 空值检查 (QUA-002)

### 必须检查的场景

```verse
# 可选类型使用前
if (Char := Character?):
    Char.Damage(Amount)

# 数组访问
if (Index >= 0 and Index < Items.Length):
    Item := Items[Index]

# 查找操作
if (Found := FindTarget[]):
    ProcessTarget(Found)
```

### 禁止项

- ❌ 直接解引用可选类型
- ❌ 不检查数组边界直接访问
- ❌ 忽略失败分支的处理

---

## 边界验证 (QUA-003)

### 数值边界

```verse
# 设置值时钳制范围
SetHealth(Value:int):void =
    set CurrentHealth = Clamp(Value, 0, MaxHealth)

# 除法前检查除数
if (Divisor > 0):
    Result := Dividend / Divisor
```

### 集合边界

```verse
# 容量检查
AddItem(Item:item):logic =
    if (Items.Length >= MaxCapacity):
        return false
    # ...
```

### 禁止项

- ❌ 不验证用户输入的数值范围
- ❌ 不检查除数是否为零
- ❌ 不检查集合容量就添加元素

---

## 代码格式 (QUA-004)

### 缩进

- 使用 4 空格缩进
- 不混用空格和 Tab

### 空行

- 函数之间空 1 行
- 逻辑块之间空 1 行
- 文件末尾保留 1 空行

### 注释

```verse
# 单行注释：说明下一行代码
set CurrentHealth = MaxHealth

# 多行注释：复杂逻辑说明
# 计算实际伤害：
# 1. 应用护甲减免
# 2. 应用暴击倍率
# 3. 钳制最小值为 1
FinalDamage := CalculateFinalDamage(BaseDamage)
```

### 禁止项

- ❌ 超长单行（>100 字符）
- ❌ 无注释的复杂逻辑
- ❌ 注释与代码不一致

---

## 错误处理 (QUA-005)

### 失败情况处理

```verse
# 明确处理失败分支
TryAttack(Target:entity):logic =
    if (not IsInRange(Target)):
        return false  # 明确返回失败
    # ...
    return true

# 错误传播
ProcessData(Data:?data):?result =
    if (not D := Data?):
        return false  # 向上传播错误
    # ...
```

### 日志记录

```verse
# 关键操作记录日志
SpawnEnemy(SpawnPoint:vector3):?entity =
    if (SpawnedCount >= MaxSpawns):
        Log("SpawnEnemy failed: max spawns reached")
        return false
    # ...
```

### 禁止项

- ❌ 忽略操作失败（不返回、不处理）
- ❌ 吞掉错误不传播
- ❌ 关键失败不记录日志

---

## 检查流程

### 逐文件检查

对每个 `.verse` 文件执行：

1. **QUA-001**: 扫描所有标识符，检查命名规范
2. **QUA-002**: 查找 `?` 类型和数组访问，检查是否有保护
3. **QUA-003**: 查找数值设置和除法，检查边界验证
4. **QUA-004**: 检查缩进、空行、注释
5. **QUA-005**: 查找可能失败的操作，检查错误处理

### 问题记录格式

```markdown
### [QUA-XXX] 文件名:行号
**问题**: [问题描述]
**代码**: `[问题代码片段]`
**建议**: [修复建议]
```

---

## 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| 1.0.0 | 2025-12-27 | 初始版本 |

---

*最后更新: 2025-12-27*
