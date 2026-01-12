# 猜想记录（Conjectures）

这份文档记录尚未被多个信息源验证的假设和猜想。

---

## 为什么需要猜想记录？

在开发过程中，我们常常基于有限信息做出假设。这些假设可能：
- ✅ 基于单一信息源
- ✅ 基于推理而非验证
- ✅ 尚未经过实践检验
- ✅ 来自不完整的文档理解

记录猜想有助于：
1. **识别知识盲区** - 明确哪些是猜测，哪些是事实
2. **避免错误传播** - 防止将未验证的信息当作事实
3. **促进验证** - 提醒后续需要验证的内容
4. **学习轨迹** - 记录理解的演进过程

---

## 猜想模板

```markdown
## CONJ-[编号]: [猜想标题]

**日期**: YYYY-MM-DD  
**状态**: Unverified / Verified / Disproven / Superseded  
**置信度**: 低 / 中 / 高

### 猜想内容

[清晰描述你的假设或猜想]

### 信息来源

- **来源 1**: [单一文档/个人经验/推理等]
- **来源类型**: [官方文档/社区讨论/代码观察/推理]

### 需要验证的问题

- [ ] [验证问题 1]
- [ ] [验证问题 2]

### 影响范围

[这个猜想如果错误，会影响什么？]

### 验证计划

[如何验证这个猜想？需要什么信息？]

### 验证结果（填写后更新状态）

- **验证日期**: YYYY-MM-DD
- **结果**: [正确/错误/部分正确]
- **证据**: [验证依据]
- **修正**: [如果错误，正确的理解是什么]
```

---

## 猜想列表

### CONJ-001: ~~Verse `<decides>` 与 `<transacts>` 不兼容~~

**日期**: 2026-01-12  
**状态**: ❌ Disproven  
**置信度**: 曾经：高 → 现在：0（已证伪）

### 猜想内容

原始猜想：`<decides>` 效果与 `<transacts>` 效果不能同时使用，因为编译器报错提示 decides 在 transacts 上下文中不允许。

### 信息来源

- **来源 1**: 编译错误信息的表面解读
- **来源类型**: 代码观察 + 错误信息推理（不充分）

### 验证结果

- **验证日期**: 2026-01-12
- **结果**: ❌ 错误
- **证据**: 用户 @wyughakut 指出："其实 decide 和 transact 是可以同时使用的，甚至没有 transact 就不能使用 decide"
- **修正**: 
  - `<transacts>` 效果实际上包含了 `<decides>` 效果
  - `<decides>` 通常需要 `<transacts>` 配合使用
  - 正确的效果声明是 `<transacts><decides>` 或让编译器推断

### 教训

- ❌ 不要仅基于单次编译错误就得出结论
- ❌ 错误信息"不允许在此上下文"可能意味着缺少效果声明，而非效果冲突
- ✅ 需要多个信息源交叉验证
- ✅ 查阅官方文档或询问经验丰富的开发者

---

## 已验证的猜想

### CONJ-004: option[T] 查询操作符 `?` 隐式包含 `<decides>` 效果

**日期**: 2026-01-12  
**状态**: ✅ Verified  
**置信度**: 曾经：高 → 现在：确认（已验证）

### 猜想内容

option[T] 的查询操作符 `?` 是一个 failable expression，必须在 failure context 中使用。

### 验证结果

- **验证日期**: 2026-01-12
- **结果**: ✅ 完全正确
- **证据**: 官方文档明确说明（详见 RESEARCH-003）
- **官方文档引用**："Accessing the value stored in an option is a failable expression because there might not be a value in the option, and so must be used in a failure context."

### 关键发现

1. ✅ `MaybeValue?` 操作隐式具有 `<decides>` 效果
2. ✅ 必须在 failure context 中使用（如 `if` 条件）
3. ✅ 如果 option 为空，操作失败并触发 rollback

### 参考

- 完整研究报告: `knowledge/research/verse-option-type-research-20260112.md`

---

### CONJ-005: option 类型的 persistable 特性是递归的

**日期**: 2026-01-12  
**状态**: ✅ Verified  
**置信度**: 曾经：中 → 现在：确认（已验证）

### 猜想内容

如果 T 是 persistable 类型，则 option[T] 也是 persistable。

### 验证结果

- **验证日期**: 2026-01-12
- **结果**: ✅ 完全正确
- **证据**: 官方文档明确说明（详见 RESEARCH-003）
- **官方文档引用**："An option is persistable if its value is persistable, which means that you can use them in your module-scoped weak_map variables and have their values persist across game sessions."

### 关键发现

1. ✅ persistable 特性是递归的（取决于内部类型）
2. ✅ 可以在 weak_map 中使用 persistable option
3. ✅ 这个规则递归应用（如 option[option[int]] 也是 persistable）

### 参考

- 完整研究报告: `knowledge/research/verse-option-type-research-20260112.md`

---

### CONJ-006: `false` 是 option 类型的"空值"字面量

**日期**: 2026-01-12  
**状态**: ✅ Verified  
**置信度**: 曾经：高 → 现在：确认（已验证）

### 猜想内容

`false` 是所有 option 类型的通用空值表示。

### 验证结果

- **验证日期**: 2026-01-12
- **结果**: ✅ 完全正确
- **证据**: 官方文档明确说明（详见 RESEARCH-003）
- **官方文档引用**："Assign `false` to the option to mark it as unset."

### 关键发现

1. ✅ `false` 是所有 `?T` 类型的通用空值字面量
2. ✅ `false` 在 option 上下文中不是 logic 类型的 false
3. ✅ 任何 `?T` 类型都可以赋值为 `false` 表示空

### 参考

- 完整研究报告: `knowledge/research/verse-option-type-research-20260112.md`

---

### CONJ-007: option[T] 与 failable 表达式的深度关联

**日期**: 2026-01-12  
**状态**: ✅ Verified  
**置信度**: 曾经：中 → 现在：确认（已验证）

### 猜想内容

`option{Expression}` 构造器会自动捕获 Expression 的失败，option 构造是一个 failure context。

### 验证结果

- **验证日期**: 2026-01-12
- **结果**: ✅ 完全正确
- **证据**: 官方文档明确说明（详见 RESEARCH-003）
- **官方文档引用 1**："If the expression fails, the option will be unset and have the value `false`."
- **官方文档引用 2**（failure-in-verse）："Initializing a variable that has the `option` type: `option{expression}`"（列在 failure contexts 中）

### 关键发现

1. ✅ option 构造器是 failure context
2. ✅ Expression 可以是 failable（有 `<decides>` 效果）
3. ✅ 失败时 option 自动为 `false`
4. ✅ 提供了一种优雅的错误处理方式

### 参考

- 完整研究报告: `knowledge/research/verse-option-type-research-20260112.md`

---

### CONJ-002: Verse 效果系统层次关系

**日期**: 2026-01-12  
**状态**: ✅ Verified（部分） 
**置信度**: 曾经：中 → 现在：高（已验证）

### 猜想内容

关于 Verse 效果系统的几个假设：
1. `<transacts>` 效果包含 `<decides>` 和 `<no_rollback>` 效果
2. `<decides>` 需要 `<transacts>` 配合使用
3. 存在一个效果层次结构，某些效果"包含"其他效果

### 信息来源

- **来源 1**: 用户 @wyughakut 的反馈（2026-01-12）："decide 和 transact 是可以同时使用的，甚至没有 transact 就不能使用 decide"
- **来源类型**: 用户反馈（二级源）
- **来源 2**: Verse 官方文档 - failure-in-verse/index.md（一级源）
- **来源 3**: Verse 官方文档 - if-in-verse/index.md（一级源）

### 验证结果

- **验证日期**: 2026-01-12
- **结果**: ✅ 部分正确，需要修正理解
- **证据**: 官方文档明确说明（详见 RESEARCH-001）
- **修正**:
  1. ❌ **不准确**: `<transacts>` 不"包含" `<decides>`，而是 `<decides>` **依赖** `<transacts>`
  2. ✅ **正确**: `<decides>` 必须配合 `<transacts>` 使用（官方文档："Currently it is also necessary to add `<transacts>` when using `<decides>`"）
  3. ❌ **不准确**: `<transacts>` 不"包含" `<no_rollback>`，而是**覆盖**它（用户函数默认是 `<no_rollback>`）
  4. ✅ **部分正确**: 存在效果兼容性规则，但不是严格的"层次结构"，而是"依赖"和"覆盖"关系

### 更新后的理解

```
<no_rollback>（用户函数默认） ← <transacts>（覆盖） ← <decides>（依赖）
                                                    ↓
                                             必须同时标注
```

**核心规则**：
- 用户函数默认拥有隐式的 `<no_rollback>` 效果
- 显式标注 `<transacts>` 会覆盖 `<no_rollback>`
- `<decides>` 函数必须同时标注 `<transacts>`（语言强制要求）
- Failure context 禁止调用 `<no_rollback>` 函数

### 影响

- ✅ 所有逻辑模块的函数效果标注现在有明确依据
- ✅ 理解了为什么某些编译错误会发生
- ✅ 可以正确在 failure context 中调用函数

### 参考

- 完整研究报告: `knowledge/research/verse-effects-system-research-20260112.md`

---

## 当前未验证的猜想

### CONJ-004: option[T] 查询操作符 `?` 隐式包含 `<decides>` 效果

**日期**: 2026-01-12  
**状态**: ⚠️ Unverified  
**置信度**: 高

### 猜想内容

基于官方文档的描述，`option[T]` 的查询操作符 `?` 是一个 failable expression，因为 option 可能为空。因此，我猜测：
1. 使用 `MaybeValue?` 访问 option 值时，这个操作隐式具有 `<decides>` 效果
2. 必须在 failure context 中使用（如 `if` 条件、`or` 表达式）
3. 如果 option 为空（`false`），操作会失败并触发 rollback

### 信息来源

- **来源 1**: Verse 官方文档 - option-in-verse/index.md（一级源）
- **来源 2**: 文档明确说明："Accessing the value stored in an option is a failable expression because there might not be a value in the option, and so must be used in a failure context."
- **来源类型**: 官方文档明确说明

### 需要验证的问题

- [ ] `?` 操作符的效果签名是什么？
- [ ] 是否可以在非 failure context 中使用？（应该不行）
- [ ] 如果 option 为空，是否会触发 rollback？
- [ ] 是否可以链式访问嵌套的 option？（如 `A?.B?`）

### 影响范围

如果理解正确：
- 所有访问 option 值的代码都需要在 failure context 中
- 需要处理 option 为空的情况（使用 `or` 或 `if`）
- 与效果系统的交互需要特别注意

### 验证计划

1. 查阅 Verse API digest 中关于 option 的定义
2. 查找 `?` 操作符的效果签名
3. 创建测试代码验证不同使用场景
4. 执行 RESEARCH-003（option[T] 类型深度研究）

---

### CONJ-005: option 类型的 persistable 特性是递归的

**日期**: 2026-01-12  
**状态**: ⚠️ Unverified  
**置信度**: 中

### 猜想内容

官方文档提到"An option is persistable if its value is persistable"。我猜测：
1. 如果 `T` 是 persistable 类型，则 `option[T]` 也是 persistable
2. 如果 `T` 不是 persistable，则 `option[T]` 也不是 persistable
3. 这个规则是递归应用的（如 `option[option[int]]` 也是 persistable）

### 信息来源

- **来源 1**: Verse 官方文档 - option-in-verse/index.md（一级源）
- **来源类型**: 官方文档提示，但未详细说明

### 需要验证的问题

- [ ] 哪些类型是 persistable 的？（int, float, string？）
- [ ] 如何判断一个自定义类型是否 persistable？
- [ ] 嵌套的 option 是否也遵循这个规则？
- [ ] 如果尝试持久化不可持久化的 option 会发生什么？

### 影响范围

如果理解正确：
- 使用 weak_map 存储 option 时需要确保内部类型可持久化
- 设计数据结构时需要考虑持久化需求

### 验证计划

1. 查阅 Verse 文档关于 persistable 的定义
2. 查看 Verse API digest 中 persistable 约束的使用
3. 创建测试代码验证

---

### CONJ-006: `false` 是 option 类型的"空值"字面量

**日期**: 2026-01-12  
**状态**: ⚠️ Unverified  
**置信度**: 高

### 猜想内容

官方文档示例中使用 `false` 来表示 unset option：
```verse
var MaybeANumber : ?int = false # unset optional value
```

我猜测：
1. `false` 是所有 option 类型的通用空值表示
2. `false` 在 option 上下文中不是 logic 类型的 false，而是特殊的空值字面量
3. 任何 `?T` 类型都可以赋值为 `false` 表示空

### 信息来源

- **来源 1**: Verse 官方文档 - option-in-verse/index.md（一级源）
- **来源 2**: 代码示例明确使用 `false` 表示 unset
- **来源类型**: 官方文档示例

### 需要验证的问题

- [ ] `false` 在 option 上下文中的类型是什么？
- [ ] 是否可以使用其他值表示空？（如 `None`、`null`）
- [ ] `false` 是否只能用于 option 类型？
- [ ] 比较 `MaybeValue == false` 是否能判断 option 是否为空？

### 影响范围

如果理解正确：
- 所有 option 初始化为空值都使用 `false`
- 可能与 logic 类型的 `false` 产生混淆

### 验证计划

1. 查阅 Verse 类型系统文档
2. 测试不同的空值表示方式
3. 测试 `false` 在不同上下文中的行为

---

### CONJ-007: option[T] 与 failable 表达式的深度关联

**日期**: 2026-01-12  
**状态**: ⚠️ Unverified  
**置信度**: 中

### 猜想内容

基于效果系统和 option 类型的观察，我猜测：
1. `option{Expression}` 构造器会自动捕获 `Expression` 的失败
   - 如果 Expression 成功，option 包含其值
   - 如果 Expression 失败，option 为空（`false`）
2. 这提供了一种"安全执行"模式：将可能失败的操作包装在 option 中
3. option 构造是一个 failure context

### 信息来源

- **来源 1**: Verse 官方文档 - option-in-verse/index.md："If the expression fails, the option will be unset and have the value `false`."
- **来源 2**: Verse 官方文档 - failure-in-verse/index.md：列出了所有 failure contexts
- **来源类型**: 官方文档，但需要深入理解交互

### 需要验证的问题

- [ ] `option{Expression}` 中的 Expression 是否必须有 `<decides>` 效果？
- [ ] 如果 Expression 没有 `<decides>`，会发生什么？
- [ ] option 构造器是否在 failure contexts 列表中？
- [ ] 是否可以嵌套使用 option 构造器？

### 影响范围

如果理解正确：
- option 可以作为错误处理的一种方式
- 可以避免显式的 if-else 错误处理
- 提供了更函数式的编程风格

### 验证计划

1. 深入研究 option 构造语法
2. 测试 option 构造器与不同效果的交互
3. 对比 option 和 failure context 的异同

---

## 已证伪的猜想

### CONJ-003: ~~Floor 函数用于 int → float 类型转换~~

**日期**: 2026-01-12  
**状态**: ❌ Disproven  
**置信度**: 曾经：低 → 现在：0（已证伪）

### 猜想内容

原始猜想：`Floor(I + 0.0)` 或 `Floor(0.0 + I)` 可以用于将 int 转换为 float。

### 信息来源

- **来源 1**: 代码尝试中发现的"可行"方案
- **来源类型**: 实验推理（低可靠性）
- **来源 2**: Verse 官方文档 - type-casting-and-conversion-in-verse/index.md（一级源）

### 验证结果

- **验证日期**: 2026-01-12
- **结果**: ❌ 错误
- **证据**: 官方文档明确说明（详见 RESEARCH-006）
- **修正**:
  1. ❌ **类型签名错误**: `Floor` 的签名是 `(float)<reads><decides>:int`，返回 **int**，不是 float
  2. ❌ **用途错误**: `Floor` 用于 **float → int** 转换（向下取整），不是 int → float
  3. ✅ **正确方法**: Int → Float 的标准方法是**乘以 1.0**（官方推荐）
     ```verse
     var IntValue:int = 42
     var FloatValue:float = IntValue * 1.0  # ✅ 官方标准方法
     ```

### 教训

- ❌ 不要凭推测使用函数，先查阅官方文档
- ❌ 不要仅通过"可行"就认为是正确方法
- ❌ 函数名称可能具有误导性（Floor 看起来像"基础转换"，实际是"向下取整"）
- ✅ 类型签名是最可靠的信息来源
- ✅ 官方文档明确推荐的方法才是标准方法

### 参考

- 完整研究报告: `knowledge/research/verse-numeric-conversion-research-20260112.md`

---

## 使用指南

### 何时添加猜想？

- ✅ 当你基于推理而非文档做出假设时
- ✅ 当只有单一信息源时
- ✅ 当你对某个结论"不太确定"时
- ✅ 当实现某个方案但不确定是否最佳时

### 何时验证猜想？

- 遇到编译错误或运行时问题时
- 阅读到官方文档相关内容时
- 得到用户反馈时
- 代码 review 时收到质疑时

### 猜想的生命周期

```
提出猜想 → 标记为 Unverified
         ↓
实践中使用 → 观察结果
         ↓
收集证据 → Verified（正确）/ Disproven（错误）/ Superseded（被更好理解取代）
         ↓
更新相关文档（ADR、Lessons、Patterns）
```

---

## 置信度分级

| 置信度 | 说明 | 典型来源 |
|--------|------|----------|
| **低** | 纯推测，缺乏依据 | 个人猜测、不完整的代码片段观察 |
| **中** | 有一定依据但未充分验证 | 单一文档来源、社区讨论 |
| **高** | 有较强依据但未完全确认 | 多个相似案例、官方文档暗示 |

---

**记住**：承认"不确定"是专业素养。记录猜想比假装知道更有价值。
