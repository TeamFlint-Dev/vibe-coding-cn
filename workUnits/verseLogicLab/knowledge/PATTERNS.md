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

#### 2.3 Float Comparison with Tolerance（浮点数容差比较模式）

**意图**: 安全地比较浮点数，避免精度问题导致的误判

**使用场景**: 
- 任何需要比较浮点数相等性的场景
- 判断计算结果是否符合预期
- 检查物体是否到达目标位置
- 验证插值是否完成

**核心原理**:
由于浮点数的二进制表示限制，直接使用 `==` 比较两个浮点数可能因为微小的精度误差而失败。
使用容差（Epsilon）比较可以解决这个问题：如果两个数的差值小于容差，就认为它们相等。

**结构**:
```verse
# 基础模式：相等性判断
NearlyEqual(A, B, Epsilon) := 
    AbsDiff := if (A - B < 0.0) then -(A - B) else (A - B)
    AbsDiff <= Epsilon

# 扩展模式：大于/小于判断
NearlyGreater(A, B, Epsilon) := A > B + Epsilon
NearlyLess(A, B, Epsilon) := A < B - Epsilon
```

**示例**:
```verse
using { MathFloatComparison }

# 判断插值是否完成（T 接近 1.0）
if (MathFloatComparison.NearlyEqual[T, 1.0]):
    # 插值完成
    CompleteAnimation()

# 判断物体是否停止（速度接近 0）
if (MathFloatComparison.NearlyZero[Velocity]):
    # 物体已停止
    StopMovement()

# 判断是否明显大于阈值（避免误判）
if (MathFloatComparison.NearlyGreater[Value, Threshold]):
    # Value 明显大于 Threshold
    TriggerEvent()
```

**Epsilon 选择指南**:
- **默认值 (0.0001)**: 适用于大多数游戏逻辑场景
- **小值 (0.000001)**: 高精度计算场景
- **大值 (0.001)**: 低精度场景或粗略比较

**注意事项**:
- ❌ 不要直接使用 `A == B` 比较浮点数
- ✅ 使用 NearlyEqual 代替
- ✅ 根据场景选择合适的 Epsilon
- ⚠️ Epsilon 过小可能导致误判，过大可能掩盖真实差异

**反模式**:
```verse
# ❌ 错误：直接比较浮点数
if (CalculatedValue == 1.0):  # 可能因精度问题失败
    DoSomething()

# ✅ 正确：使用容差比较
if (MathFloatComparison.NearlyEqual[CalculatedValue, 1.0]):
    DoSomething()
```

**相关模式**:
- Safe Division（安全除法）
- Range Validation（范围验证）

**实现参考**:
- `logicModules/coreMathUtils/MathFloatComparison.verse`

**验证猜想**:
- ✅ CONJ-003 已证伪：Floor 函数不用于 int → float 转换
- ✅ 正确方法：使用乘以 1.0 进行类型转换
- ✅ 浮点比较必须使用容差，不能直接用 `==`

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
- Validation Function Pattern (范围验证的标准模式)

---

#### 3.2 Validation Function Pattern（验证函数模式）

**意图**: 对输入参数进行验证，确保数据满足约束条件，使用 fail-fast 策略

**使用场景**: 
- 函数入口参数验证
- 数值范围检查
- 业务规则验证
- 前置条件断言

**核心原则**:
1. **Fail-Fast**: 验证失败时立即停止，不继续执行
2. **使用 `<decides><transacts>` 效果**: 标准验证签名
3. **返回 `void`**: 通过成功/失败而非返回值传递结果
4. **命名约定**: `Validate*` 前缀，清晰表达验证意图

**结构**:
```verse
# 基础模式
ValidateCondition<public>(Value:type, ...constraints)<decides><transacts>:void =
    [条件表达式1]
    [条件表达式2]
    ...

# 带容差的浮点数验证
ValidateFloat<public>(Value:float, ...constraints, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
    [使用 epsilon 的条件表达式]
```

**示例**:
```verse
using { RangeValidation }

# 整数范围验证
ValidateIntInRange<public>(Value:int, MinVal:int, MaxVal:int)<decides><transacts>:void =
    Value >= MinVal
    Value <= MaxVal

# 浮点数验证（带容差）
ValidateFloatPositive<public>(Value:float, ?Epsilon:float = 0.0001)<decides><transacts>:void =
    Value > Epsilon

# 组合验证（多条件）
ValidateIntRangeNonZero<public>(Value:int, MinVal:int, MaxVal:int)<decides><transacts>:void =
    Value >= MinVal
    Value <= MaxVal
    Value <> 0

# 使用示例：在函数入口验证参数
CalculateDamage<public>(BaseDamage:float, DefenseRating:float)<transacts>:float =
    # 验证输入参数
    RangeValidation.ValidateFloatNonNegative[BaseDamage]
    RangeValidation.ValidatePercent[DefenseRating]
    
    # 参数有效，继续计算
    FinalDamage := BaseDamage * (1.0 - DefenseRating)
    FinalDamage
```

**验证函数的分类**:

| 类别 | 函数示例 | 用途 |
|------|----------|------|
| **范围验证** | ValidateIntInRange, ValidateFloatInRange | 检查值是否在 [min, max] 内 |
| **符号验证** | ValidatePositive, ValidateNonNegative | 检查正负性 |
| **特殊值验证** | ValidatePercent, ValidateAngleDegrees | 验证特定领域的值 |
| **索引验证** | ValidateArrayIndex | 检查数组访问是否安全 |
| **组合验证** | ValidateIntRangeNonZero | 多条件组合验证 |

**为什么使用 `<decides><transacts>` 而非返回 bool？**

```verse
# ❌ 不推荐：返回 bool 需要手动检查
if (IsInRange(Value, 0, 100) = true):
    DoSomething()
else:
    # 错误处理...

# ✅ 推荐：使用 <decides> 自动失败回滚
ValidateInRange[Value, 0, 100]  # 失败时自动 rollback
DoSomething()  # 仅在验证通过后执行
```

**浮点数验证的特殊考虑**:
- **问题**: 直接比较浮点数存在精度问题
- **解决**: 使用 epsilon 容差
- **实践**: 与 MathFloatComparison 保持一致的 DefaultEpsilon (0.0001)

```verse
# 浮点数范围验证考虑容差
ValidateFloatInRange<public>(Value:float, MinVal:float, MaxVal:float, ?Epsilon:float = 0.0001)<decides><transacts>:void =
    Value >= MinVal - Epsilon  # 允许略小于 MinVal
    Value <= MaxVal + Epsilon  # 允许略大于 MaxVal
```

**注意事项**:
- ✅ 验证函数应该是纯粹的条件检查，不应有副作用
- ✅ 使用 `[方括号]` 调用验证函数（`<decides>` 效果要求）
- ✅ 验证失败会触发 rollback，确保事务性
- ⚠️ 过度验证会影响性能，在性能关键路径上谨慎使用
- ⚠️ 验证仅检查格式，不检查业务逻辑的语义正确性

**与其他模式的关系**:
- **Predicate Function**: 验证函数是谓词函数的特殊应用
- **Safe Math Operations**: 常与验证配合使用（先验证再计算）
- **Effect-Aware Function Call**: 必须用方括号调用

**实现参考**:
- `validationUtils/RangeValidation.verse` - 完整的范围验证实现
- `coreMathUtils/UtilArrays.verse` - CheckEmpty, CheckValidIndex
- `characterAndStateUtils/RpgHealth.verse` - CheckAlive, CheckFullHealth

**验证猜想**:
- ✅ CONJ-002 验证：`<decides>` 必须配合 `<transacts>` 使用
- ✅ 验证函数标准签名：`<decides><transacts>:void`

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

### 2.4 Iterative Loop Pattern（迭代循环模式）

**意图**: 使用 for 循环实现迭代逻辑，避免递归

**使用场景**: 需要循环或迭代处理的所有情况

**问题**: 递归存在以下风险：
- 堆栈溢出风险（深度递归）
- 难以预测执行深度
- 调试困难
- 性能开销（函数调用开销）

**解决方案**: 使用 for 循环 + var（需要 `<transacts>` 或 `<allocates>` 效果）

**结构**:
```verse
# 使用 for 循环实现迭代
ProcessIterative<public>(Value:float, MaxIterations:int)<transacts>:float =
    var Result:float = Value
    for (I := 0..MaxIterations - 1):
        # 迭代处理
        if (Result < 0.0):
            set Result = Result + 360.0
    Result
```

**示例（角度归一化）**:
```verse
# 使用迭代循环实现角度归一化
NormalizeAngle360<public>(Angle:float)<transacts>:float =
    if (Angle >= 0.0 and Angle < 360.0):
        Angle  # 已在范围内
    else if (Angle < 0.0):
        # 负数：迭代加360直到为正
        var Result:float = Angle
        for (I := 0..100):  # 最多100次迭代
            if (Result < 0.0):
                set Result = Result + 360.0
        Result
    else:
        # 大于360：迭代减360直到进入范围
        var Result:float = Angle
        for (I := 0..100):
            if (Result >= 360.0):
                set Result = Result - 360.0
        Result
```

**注意事项**:
- ✅ 总是设置最大迭代次数，防止无限循环
- ✅ 使用 `var` 需要 `<transacts>` 或 `<allocates>` 效果
- ✅ 循环次数应该基于实际需求合理设置
- ❌ **禁止使用递归** - 递归存在堆栈溢出和难以预测的风险
- ✅ 对于已知次数的迭代，直接使用固定范围的 for 循环

**相关模式**:
- Lookup Table Pattern（对于可预计算的值，优先使用查表）

**来源**:
- `MathRanges.verse` - NormalizeAngle360/180（已从递归重构为迭代）

---

### 2.5 Lookup Table Pattern（查表模式）

**意图**: 用预计算的值表替代复杂计算或迭代

**使用场景**: 计算结果可预知且数量有限

**结构**:
```verse
# 不推荐：使用迭代计算2的幂（每次调用都要循环）
PowerOf2Iterative(N:int)<transacts>:int =
    var Result:int = 1
    for (I := 0..N - 1):
        set Result = Result * 2
    Result

# 推荐：使用查表（O(1) 查找）
PowerOf2<public>(N:int)<computes>:int =
    if (N <= 0):
        1
    else if (N = 1):
        2
    else if (N = 2):
        4
    else if (N = 3):
        8
    # ... 继续到N=30
    else:
        2147483648  # 2^31
```

**应用场景**:
- 2的幂次（位运算）
- 阶乘（小范围）
- 常见三角函数值
- 预定义配置值

**优势**:
- O(1) 查找时间
- 无迭代开销
- 编译器可能优化为跳转表
- 代码清晰，易于理解

**注意事项**:
- 仅适用于有限的、可预知的值集合
- 表格过大会增加代码体积
- 值变化频繁不适合查表

**来源**:
- `MathBitwise.verse` - PowerOf2(), IsPowerOf2()
- `MathConstants.verse` - 预定义常量

---

### 2.6 Effect-Aware Function Call（效果感知调用模式）

**意图**: 根据函数效果使用正确的调用语法

**使用场景**: 调用带有不同效果的函数

**规则**:
```verse
# <computes> 函数：使用圆括号 ()
Result := PureFunction(Arg1, Arg2)

# <decides> 函数：使用方括号 []
Result := FailableFunction[Arg1, Arg2]

# 在 failure context 中使用带 ? 的访问
if (FailableFunction[Arg]?):
    # 成功分支
else:
    # 失败分支
```

**示例**:
```verse
# 正确：TestBit 有 <decides> 效果，使用方括号
HasFlag := TestBit[Flags, 3]

# 错误：使用圆括号调用 <decides> 函数
HasFlag := TestBit(Flags, 3)  # ❌ 编译错误

# 在 if 条件中使用
if (TestBit[Value, Index]?):
    # 位为1的处理
else:
    # 位为0或失败的处理
```

**常见带 `<decides>` 的函数**:
- `Floor[]`, `Ceil[]`, `Mod[]` - 数学函数
- `Array[Index]` - 数组访问
- 自定义的可能失败的函数

**注意事项**:
- 编译器会强制正确的调用语法
- 效果不匹配会导致编译错误
- 查看函数签名确定效果类型

**来源**:
- `MathBitwise.verse` - TestBit, RightShift 调用
- LESSON-009 (COMPILATION_LESSONS.json)

---

### 2.7 Parameter Naming to Avoid Conflicts（参数命名避免冲突模式）

**意图**: 避免参数名与内置函数冲突

**使用场景**: 定义函数参数时

**问题**: Verse 内置函数名（如 Min, Max, Abs）与参数名冲突导致歧义

**结构**:
```verse
# 错误：参数名与内置函数冲突
InverseLerp(Value:float, Min:float, Max:float):float =
    Range := Max - Min  # ❌ 编译器不知道是参数 Min 还是函数 Min()
    # ...

# 正确：使用描述性后缀避免冲突
InverseLerp(Value:float, MinVal:float, MaxVal:float):float =
    Range := MaxVal - MinVal  # ✅ 清晰无歧义
    # ...
```

**常见冲突名称**:
- `Min`, `Max` → `MinVal`, `MaxVal`
- `Abs` → `AbsVal`, `AbsoluteValue`
- `Floor`, `Ceil` → `FloorVal`, `CeilVal`
- `Sin`, `Cos` → `SineVal`, `CosineVal`

**推荐后缀**:
- `Val` - 用于数值参数
- `Param` - 用于配置参数
- `Input` - 用于输入值
- `Arg` - 用于通用参数

**来源**:
- `MathRanges.verse` - InverseLerp, IsInRange 等
- `MathConstants.verse` - IsNearZero
- LESSON-006 (COMPILATION_LESSONS.json)

---

## 维护指南

1. **添加模式**: 在相应分类下追加
2. **更新索引**: 同时更新模式索引表
3. **标注来源**: 引用使用该模式的模块
4. **持续改进**: 发现更好实现时更新

---

_模式是经验的结晶。每次写代码，都在积累模式。_
