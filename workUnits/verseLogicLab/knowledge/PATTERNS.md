# Verse Logic Patterns

这份文档记录 Verse 逻辑模块中常见的可复用模式。

---

## 什么是模式？

模式是解决特定问题的通用方案，具有以下特征：

- **可复用** - 可以在多个场景中应用
- **经过验证** - 已在实际代码中使用并有效
- **可命名** - 有清晰的名称和意图
- **有结构** - 可以用代码模板表达

---

## 模式分类

### 1. 数据转换模式（Data Transformation）

数据格式或类型之间的转换。

---

### 2. 数值计算模式（Numeric Computation）

数学计算和边界保护。

#### 2.1 Safe Division（安全除法）

**意图**: 执行除法运算，避免除零错误

**使用场景**: 任何需要除法的场景，特别是除数可能为零时

**结构**:
```verse
SafeDivide<public>(Numerator:float, Denominator:float, Default:float)<computes>:float =
    if (Denominator != 0.0):
        Numerator / Denominator
    else:
        Default
```

**示例**:
```verse
# 计算生命值百分比
HealthPercent := SafeDivide(CurrentHP, MaxHP, 0.0)

# 计算平均值
Average := SafeDivide(Sum, Count, 0.0)
```

**注意事项**:
- Default 应该是业务上合理的值
- 对于必须有效的除法，考虑使用 `<decides>` 效果

**相关模式**:
- Clamp Pattern（边界限制模式）

---

#### 2.2 Clamp Pattern（边界限制模式）

**意图**: 确保数值在指定范围内

**使用场景**: 任何需要限制数值范围的场景

**结构**:
```verse
ClampedValue := Clamp(Value, MinValue, MaxValue)
```

**示例**:
```verse
# 限制生命值在 [0, MaxHP] 范围内
CurrentHP := Clamp(NewHP, 0.0, MaxHP)

# 限制百分比在 [0, 1] 范围内
Percent := Clamp(RawPercent, 0.0, 1.0)
```

**注意事项**:
- 比 if-else 更简洁
- 表意清晰
- 适合有明确边界的数值

**相关模式**:
- Safe Math Operations

---

### 3. 条件判断模式（Conditional Logic）

使用 `<decides>` 效果的谓词函数。

#### 3.1 Predicate Function（谓词函数）

**意图**: 判断条件是否满足，通过成功/失败表示结果

**使用场景**: 需要验证状态或条件时

**结构**:
```verse
CheckCondition<public>(State:state_type)<decides>:void =
    [条件表达式]
```

**示例**:
```verse
# 检查是否存活
CheckAlive<public>(HP:float)<decides>:void =
    HP > 0.0

# 检查是否在范围内
CheckInRange<public>(Value:float, Min:float, Max:float)<decides>:void =
    Value >= Min and Value <= Max
```

**注意事项**:
- 返回类型必须是 `void`
- 成功时继续执行，失败时跳过后续代码
- 适合用于状态验证

**相关模式**:
- State Query Pattern

---

### 4. 状态查询模式（State Query）

从状态数据中提取信息。

#### 4.1 Percent Calculation（百分比计算）

**意图**: 从当前值和最大值计算百分比

**使用场景**: 显示生命值、能量、经验等进度

**结构**:
```verse
GetPercent<public>(Current:float, Maximum:float)<computes>:float =
    if (Maximum > 0.0):
        Clamp(Current / Maximum, 0.0, 1.0)
    else:
        0.0
```

**示例**:
```verse
# 生命值百分比
HealthPercent := GetHealthPercent(CurrentHP, MaxHP)

# 经验值进度
ExpProgress := GetExpPercent(CurrentExp, RequiredExp)
```

**注意事项**:
- 防止除零
- 使用 Clamp 确保结果在 [0, 1] 范围内
- 空状态返回 0.0 是合理的默认值

**相关模式**:
- Safe Division

---

### 5. 集合操作模式（Collection Operations）

数组、列表的处理。

---

### 6. 类型派发模式（Type Dispatch）

使用 enum 类型进行函数派发。

#### 6.1 Enum Dispatch（枚举派发）

**意图**: 根据 enum 值选择不同的处理函数，实现多态行为

**使用场景**: 当有多个相关但实现不同的操作时，通过 enum 统一接口

**结构**:
```verse
operation_type := enum:
    OperationA
    OperationB
    OperationC

DispatchOperation<public>(OpType:operation_type, Input:float):float =
    if (OpType = operation_type.OperationA):
        ProcessA(Input)
    else if (OpType = operation_type.OperationB):
        ProcessB(Input)
    else if (OpType = operation_type.OperationC):
        ProcessC(Input)
    else:
        DefaultProcess(Input)
```

**示例**:
```verse
# 曲线类型派发
SampleEasingCurve<public>(CurveType:curve_type, T:float):float =
    if (CurveType = curve_type.CurveLinear):
        EaseLinear(T)
    else if (CurveType = curve_type.CurveInSine):
        EaseInSine(T)
    else:
        EaseLinear(T)
```

**注意事项**:
- Enum 值命名避免与函数名冲突（使用前缀如 "Curve*", "Type*"）
- 总是提供 else 分支处理未知类型
- if-else 链可能较长，但编译器可优化为跳转表
- 考虑按使用频率排序 if 分支

**相关模式**:
- Strategy Pattern（策略模式）
- Factory Pattern（工厂模式）

---

## 添加新模式

发现可复用模式时，使用以下模板添加到相应分类：

```markdown
### [模式名称]

**意图**: [一句话描述目的]

**使用场景**: [什么时候使用]

**结构**:
```verse
[代码模板]
```

**示例**:
```verse
[实际使用例子]
```

**注意事项**:
- [需要注意的点]

**相关模式**:
- [其他相关模式]
```

---

## 模式索引

### 按效果分类

| 模式 | 效果 | 分类 |
|------|------|------|
| Safe Division | `<computes>` | 数值计算 |
| Clamp Pattern | `<computes>` | 数值计算 |
| Predicate Function | `<decides>` | 条件判断 |
| Percent Calculation | `<computes>` | 状态查询 |
| Enum Dispatch | 推断（通常无效果） | 类型派发 |

### 按频率分类

| 模式 | 使用频率 |
|------|----------|
| Clamp Pattern | ⭐⭐⭐⭐⭐ |
| Safe Division | ⭐⭐⭐⭐ |
| Predicate Function | ⭐⭐⭐⭐ |
| Enum Dispatch | ⭐⭐⭐ |
| Percent Calculation | ⭐⭐⭐ |

---

## 反模式（Anti-Patterns）

记录应该避免的不良实践。

### ❌ 忽略边界检查

**问题**:
```verse
# 没有边界保护，可能产生负数或超出范围
NewHP := CurrentHP - Damage
```

**解决**:
```verse
# 使用 Clamp 保护边界
NewHP := Clamp(CurrentHP - Damage, 0.0, MaxHP)
```

---

### ❌ 未处理除零

**问题**:
```verse
# 除数可能为零，导致错误
Percent := Current / Maximum
```

**解决**:
```verse
# 使用 Safe Division 模式
Percent := SafeDivide(Current, Maximum, 0.0)
```

---

## 维护指南

1. **添加模式**: 在相应分类下追加
2. **更新索引**: 同时更新模式索引表
3. **标注来源**: 引用使用该模式的模块
4. **持续改进**: 发现更好实现时更新

---

_模式是经验的结晶。每次写代码，都在积累模式。_
