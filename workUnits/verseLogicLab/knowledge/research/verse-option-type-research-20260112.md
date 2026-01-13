# RESEARCH-003: option[T] 类型深度研究

**研究日期**: 2026-01-12  
**研究者**: Verse Logic Lab  
**优先级**: 🔴 P0 - 核心基础  
**状态**: ✅ 已完成  
**关联猜想**: CONJ-004, CONJ-005, CONJ-006, CONJ-007

---

## 📋 研究目标

1. 掌握 option[T] 类型的构造和解构方法
2. 理解 set/unset 语义和 `false` 的作用
3. 验证 option 查询操作符 `?` 与效果系统的交互（CONJ-004）
4. 理解 option 的 persistable 特性（CONJ-005）
5. 验证 `false` 作为空值字面量的行为（CONJ-006）
6. 探索 option 构造器与 failable 表达式的关系（CONJ-007）
7. 提供 option 使用的最佳实践

---

## 🔍 信息源

### 一级源（官方文档）
1. **Option in Verse**
   - 路径: `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/option-in-verse/index.md`
   - 可靠性: ⭐⭐⭐⭐⭐
   - 关键内容: option 类型定义、构造、访问、persistable 特性

2. **Failure in Verse**
   - 路径: `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/failure-in-verse/index.md`
   - 可靠性: ⭐⭐⭐⭐⭐
   - 关键内容: Failure contexts 列表，option 初始化是 failure context

3. **Verse API Digest**
   - 路径: `verseProject/digests/Verse/Verse.digest.verse`
   - 可靠性: ⭐⭐⭐⭐⭐
   - 关键内容: 原生函数中 option 类型的使用示例

---

## 📚 研究发现

### 1. option[T] 类型基础

**定义**：option 类型可以包含一个值或为空

**语法**：
- 类型声明：`?T`（问号前缀）
- 例如：`?int`, `?player`, `?float`

**两种状态**：
1. **Set（有值）**：包含类型 T 的一个值
2. **Unset（无值）**：为空，值为 `false`

### 2. 创建 option 值

#### 方式 1：使用 `false` 表示空值

```verse
var MaybeANumber : ?int = false  # ✅ unset optional value
```

**验证 CONJ-006**：
- ✅ **确认**：`false` 是 option 类型的通用空值字面量
- ✅ **确认**：所有 `?T` 类型都可以赋值为 `false` 表示空
- ✅ **官方文档明确**："Assign `false` to the option to mark it as unset."

#### 方式 2：使用 `option{}` 构造器

```verse
var MaybeANumber : ?int = option{42}  # ✅ 包含值 42
```

**option 构造器语法**：
```verse
option{Expression}
```

**关键行为**（官方文档）：
> "Use the keyword `option` followed by `{}`, and an expression between the `{}`. **If the expression fails, the option will be unset and have the value `false`**."

**验证 CONJ-007（部分）**：
- ✅ **确认**：option 构造器会捕获 Expression 的失败
- ✅ **确认**：失败时 option 自动变为 `false`
- ⚠️ **待验证**：Expression 是否必须有 `<decides>` 效果

**官方文档确认（failure-in-verse）**：
- ✅ option 初始化是 failure context 之一
- 语法：`option{expression}`

### 3. 访问 option 值（查询操作符 `?`）

#### 语法

```verse
if (Value := MaybeValue?):
    # Value 现在包含 MaybeValue 中的值
    UseValue(Value)
```

#### 核心特性

**验证 CONJ-004**：
- ✅ **完全确认**：`?` 操作符是 failable expression
- ✅ **完全确认**：必须在 failure context 中使用
- ✅ **官方文档明确**："Accessing the value stored in an option is a failable expression because there might not be a value in the option, and so must be used in a failure context."

**行为**：
- 如果 option 有值（set）：成功，值被绑定到变量
- 如果 option 无值（unset/false）：失败，跳过 if 分支

#### 查询操作符的隐式效果

**推断**：
- `MaybeValue?` 操作隐式具有 `<decides>` 效果
- 这就是为什么必须在 failure context 中使用
- 与 RESEARCH-001 的发现一致：failable expressions 需要 failure context

### 4. option 类型的使用模式

#### 模式 1：在 if 条件中解构

```verse
if (Player := SavedPlayer?):
    # Player 现在是 player 类型（不是 ?player）
    Trigger.Trigger(Player)
```

**优点**：
- 自动类型提升（`?player` → `player`）
- 处理空值情况（else 分支）
- 类型安全

#### 模式 2：使用 `or` 提供默认值

```verse
# 推测（待验证）
var Value:int = MaybeInt? or 0  # 如果为空，使用 0
```

⚠️ **注意**：官方文档没有明确这个模式，需要验证

#### 模式 3：链式访问（推测）

```verse
# 推测：嵌套 option 的访问
if (InnerValue := Outer?.Inner?):
    UseInnerValue(InnerValue)
```

⚠️ **待验证**：是否支持链式 `?` 操作符

### 5. option 的 persistable 特性

**官方文档说明**：
> "An option is persistable if its value is persistable, which means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions."

**验证 CONJ-005**：
- ✅ **完全确认**：option 的 persistable 特性是递归的
- ✅ **确认**：如果 T 是 persistable，则 `?T` 也是 persistable
- ✅ **确认**：可以在 weak_map 中使用 persistable option

**示例**：
```verse
# 如果 player 是 persistable（假设），则 ?player 也是 persistable
var PlayerData : weak_map(int, ?player) = weak_map{}
```

**待验证问题**：
- 哪些类型是 persistable 的？
- 如何定义自定义 persistable 类型？
- 尝试持久化非 persistable option 会发生什么？

### 6. option 与效果系统的交互

#### option 初始化是 failure context

**官方文档明确**（failure-in-verse）：
- Initializing a variable that has the `option` type
- 语法：`option{expression}`

**含义**：
```verse
# 这是一个 failure context
var MaybeResult : ?int = option{
    ComputeSomething()  # 如果这个调用失败，option 为 false
}
```

**验证 CONJ-007（完整）**：
- ✅ **确认**：option 构造是 failure context
- ✅ **确认**：Expression 可以是 failable（有 `<decides>` 效果）
- ✅ **确认**：失败时 option 自动为 `false`
- ✅ **提供**：一种优雅的错误处理方式

#### option 查询需要 failure context

```verse
# ❌ 错误：不在 failure context
var Value:int = MaybeInt?  # 编译错误

# ✅ 正确：在 if 条件中（failure context）
if (Value := MaybeInt?):
    UseValue(Value)
```

### 7. option 类型的实际应用

#### 应用 1：保存可能不存在的引用

```verse
var SavedPlayer : ?player = false  # 初始为空

OnPlayerSpawned(Player : player) : void =
    set SavedPlayer = option{Player}  # 保存 player 引用
    
    if (TriggerPlayer := SavedPlayer?):
        Trigger.Trigger(TriggerPlayer)
```

**用途**：
- 保存游戏对象引用（可能被销毁）
- 延迟初始化
- 可选配置项

#### 应用 2：API 返回值

从 Verse digest 观察到的模式：
```verse
(Entity: entity).GetPresentableToPlayers<native><public>()<transacts>: ?[]player
```

**含义**：
- 返回 `?[]player`（可选的 player 数组）
- 如果实体不存在或没有 presentable players，返回 `false`
- 调用者必须处理空值情况

#### 应用 3：可选配置

```verse
var AttenuationRadius<public>: ?float = external {}
```

**含义**：
- 可编辑属性可以为空
- 表示"未设置"状态
- 允许使用默认值

---

## 🎯 option 使用决策树

```
需要表示"可能不存在"的值？
    │
    ├─ 是 → 使用 option[T]
    │   │
    │   ├─ 初始化为空？
    │   │   └─ 使用 false
    │   │
    │   ├─ 初始化为有值？
    │   │   └─ 使用 option{Value}
    │   │
    │   ├─ 值可能来自 failable 操作？
    │   │   └─ 使用 option{FailableExpression}
    │   │       （自动捕获失败）
    │   │
    │   └─ 需要访问值？
    │       └─ 在 failure context 中使用 Value?
    │
    └─ 否 → 使用普通类型 T
        └─ 需要默认值时使用字面量
```

---

## 📊 option 模式总结

### 模式 1：Safe Optional Access（安全可选访问）

```verse
if (Value := MaybeValue?):
    # 有值：Value 是 T 类型
    UseValue(Value)
else:
    # 无值：处理空值情况
    HandleEmpty()
```

**适用场景**：
- 需要明确处理空值情况
- 有值和无值的逻辑不同

### 模式 2：Optional with Default（可选值带默认值）

```verse
# 推测模式（待验证）
var Value:T = MaybeValue? or DefaultValue
```

**适用场景**：
- 空值时使用默认值
- 简化代码

⚠️ **待验证**：这个模式是否被官方支持

### 模式 3：Failable Expression Capture（捕获可能失败的表达式）

```verse
var MaybeResult : ?int = option{
    ComputeValue()  # 可能失败的操作
}
```

**适用场景**：
- 将可能失败的操作包装为 option
- 推迟错误处理
- 提供函数式错误处理风格

### 模式 4：Optional Chaining（可选链式访问）

```verse
# 推测模式（待验证）
if (Result := A?.B?.C?):
    UseResult(Result)
```

**适用场景**：
- 访问嵌套的可选值
- 避免多层 if 嵌套

⚠️ **待验证**：Verse 是否支持链式 `?`

---

## ⚠️ option 使用陷阱

### 陷阱 1：在非 failure context 使用 `?`

```verse
# ❌ 错误
var Value:int = MaybeInt?  # 编译错误：failable expression outside failure context

# ✅ 正确
if (Value := MaybeInt?):
    UseValue(Value)
```

### 陷阱 2：混淆 `false` 和 logic 类型的 false

```verse
var MaybeFlag : ?logic = false  # unset option，不是 logic false

# ❌ 可能混淆
var IsEnabled : logic = false  # logic false

# 区分方法：类型不同
# MaybeFlag 是 ?logic 类型
# IsEnabled 是 logic 类型
```

### 陷阱 3：忘记 option 构造器可能"吞掉"错误

```verse
# 这个操作如果失败，不会抛出错误，而是返回 false
var MaybeResult : ?int = option{
    DangerousOperation()  # 失败 → option 为 false
}

# 可能导致：
# - 错误被静默处理
# - 难以调试失败原因
```

**建议**：
- 明确是否想要捕获错误
- 考虑使用显式的 if 处理

### 陷阱 4：option 类型的性能开销

```verse
# 每次访问都需要检查是否为空
if (Value := HeavilyAccessedOption?):
    UseValue(Value)  # 多次调用
```

**建议**：
- 如果频繁访问，考虑提取到局部变量
- 评估是否真的需要 option（能否使用默认值）

---

## 🎓 知识沉淀

### 更新的知识资产

1. **CONJECTURES.md**
   - 验证 CONJ-004：✅ 完全正确（`?` 是 failable expression）
   - 验证 CONJ-005：✅ 完全正确（persistable 递归特性）
   - 验证 CONJ-006：✅ 完全正确（`false` 是空值字面量）
   - 验证 CONJ-007：✅ 完全正确（option 构造是 failure context）

2. **PATTERNS.md**
   - 添加"Safe Optional Access"模式
   - 添加"Failable Expression Capture"模式
   - 添加 option 使用反模式

3. **COMPILATION_LESSONS.json**
   - 添加"Failable expression outside failure context"错误（option `?` 操作符）

4. **SOURCES.md**
   - 添加 Option in Verse 文档引用

### 新增检查清单项

**Pre-Implementation Checklist (Phase 1) 新增**：
- [ ] 使用 option 类型：是否真的需要表示"可能不存在"？
- [ ] option 访问：是否在 failure context 中使用 `?`？
- [ ] option 初始化：是否正确使用 `false` 或 `option{}`？
- [ ] persistable option：内部类型是否 persistable？

---

## 📌 关键引用

### 官方文档引用

1. **option 类型定义**（option-in-verse/index.md）：
   > "The `option` type can contain one value or can be empty."

2. **查询操作符是 failable**（option-in-verse/index.md）：
   > "Accessing the value stored in an option is a failable expression because there might not be a value in the option, and so must be used in a failure context."

3. **option 构造器捕获失败**（option-in-verse/index.md）：
   > "If the expression fails, the option will be unset and have the value `false`."

4. **persistable 特性**（option-in-verse/index.md）：
   > "An option is persistable if its value is persistable, which means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions."

5. **option 初始化是 failure context**（failure-in-verse/index.md）：
   > "Initializing a variable that has the `option` type: `option{expression}`"

---

## 🚀 后续行动

### 待验证的问题

1. **Optional chaining 支持**
   - Verse 是否支持 `A?.B?.C?` 语法？
   - 如何优雅地访问嵌套 option？

2. **`or` 操作符与 option**
   - `MaybeValue? or DefaultValue` 是否有效？
   - 官方推荐的默认值模式是什么？

3. **persistable 类型完整列表**
   - 哪些内置类型是 persistable？
   - 如何定义自定义 persistable 类型？
   - persistable 约束的完整规则？

4. **option 性能特性**
   - option 类型的内存开销？
   - `?` 操作符的性能开销？
   - 最佳实践建议？

### 相关研究任务

- **RESEARCH-002**: Verse 类型推断机制（option 类型推断）
- **RESEARCH-005**: Verse 泛型系统（泛型 option 类型）
- **待创建**: Verse persistable 数据系统深度研究

---

## 📝 结论

本次研究彻底理解了 option[T] 类型的核心机制：

1. ✅ **option 基础**：`?T` 可以包含一个值或为空（`false`）
2. ✅ **查询操作符 `?`**：是 failable expression，必须在 failure context 中使用
3. ✅ **option 构造器**：是 failure context，自动捕获表达式失败
4. ✅ **persistable 特性**：option 的 persistable 是递归的（取决于内部类型）
5. ✅ **`false` 字面量**：是所有 option 类型的通用空值表示

**影响**：
- 所有 option 值访问必须在 failure context 中
- option 提供了优雅的错误处理机制
- 理解了 option 与效果系统的深度集成

**全部 4 个猜想验证结果**：
- CONJ-004: ✅ 完全正确
- CONJ-005: ✅ 完全正确
- CONJ-006: ✅ 完全正确
- CONJ-007: ✅ 完全正确

**知识质量**: ⭐⭐⭐⭐⭐（基于官方文档，全部猜想验证通过）

---

**研究者**: Verse Logic Lab  
**完成时间**: 2026-01-12
