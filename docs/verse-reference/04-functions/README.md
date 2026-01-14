# Verse 函数参考文档

本目录包含 Verse 函数系统的完整参考文档，涵盖函数定义、效果系统、重载、扩展方法等核心特性。

## 文档列表

### [01-function-syntax.md](./01-function-syntax.md) - 函数定义语法
- 函数签名、参数列表、返回类型
- 默认参数和命名参数
- 函数修饰符和效果标记
- 自动返回机制

**关键内容**：
- 参数声明：`Parameter:Type`
- 命名参数：`?Name:Type = DefaultValue`
- 返回类型：`:ReturnType`（必须显式声明）
- 自动返回：最后表达式的值

### [02-effects-system.md](./02-effects-system.md) - 效果系统
- 5种核心效果：`<computes>`, `<decides>`, `<transacts>`, `<suspends>`, `<no_rollback>`
- 效果组合规则和传播机制
- 6种失败上下文（Failure Context）
- 投机执行和事务回滚

**关键发现**：
- ✅ `<decides>` 必须与 `<transacts>` 配对使用
- ✅ 用户函数默认是 `<no_rollback>`
- ✅ 失败时自动回滚状态变化
- ✅ 编译期强制效果检查

### [03-lambda-closures.md](./03-lambda-closures.md) - Lambda 与闭包
- Verse 当前**不支持** Lambda 表达式和高阶函数
- 替代方案：`for` 表达式实现过滤和映射
- 可实现和不可实现的函数式模式
- 从其他语言迁移的建议

**重要限制**：
- ❌ 无 Lambda 语法
- ❌ 不能将函数作为参数
- ❌ 不支持闭包捕获
- ✅ 可使用 `for` 表达式实现类似功能

### [04-overloading.md](./04-overloading.md) - 函数重载
- 重载规则和类型分发机制
- 歧义解决策略
- 类类型重载的限制
- 效果标记参与重载

**核心规则**：
- ✅ 按参数类型和数量重载
- ✅ 效果标记可用于区分
- ❌ 禁止类/接口类型重载
- ❌ 返回类型不参与重载解析

### [05-extension-methods.md](./05-extension-methods.md) - 扩展方法
- `(Self:type).Method()` 语法
- 扩展方法的设计和使用场景
- 与成员方法的区别
- 命名空间和可见性

**关键特性**：
- ✅ 非侵入式扩展现有类型
- ✅ 支持泛型扩展
- ✅ 可重载
- ❌ 不能修改 `Self`
- ❌ 不能访问私有成员

### [06-failable-functions.md](./06-failable-functions.md) - 可失败函数
- `<decides>` 函数的设计和使用
- 6种触发失败的方式
- 失败上下文和控制流
- 事务性回滚示例

**核心机制**：
- 调用语法：`Function[Args]`（方括号）
- 失败触发：`false?`, 比较表达式, 数组越界等
- 控制流：`if-else`, `for` 过滤, `or` 回退
- 事务性：失败时自动回滚状态

## 快速参考

### 函数定义模板

```verse
# 基本函数
FunctionName(Param:Type):ReturnType =
    Expression

# 带命名参数
FunctionName(Required:Type, ?Optional:Type = Default):ReturnType =
    Expression

# 可失败函数
FunctionName(Param:Type)<decides><transacts>:ReturnType =
    if (Condition):
        Value
    else:
        false?

# 异步函数
FunctionName(Param:Type)<suspends>:ReturnType =
    Sleep(1.0)
    Expression

# 扩展方法
(Self:Type).MethodName(Param:OtherType):ReturnType =
    Expression
```

### 效果速查

| 效果 | 用途 | 示例 |
|------|------|------|
| `<computes>` | 纯计算 | `Square(X:int)<computes>:int = X * X` |
| `<decides>` | 可失败 | `IsPositive(X:int)<decides><transacts>:void = X > 0` |
| `<transacts>` | 支持回滚 | 与 `<decides>` 配对使用 |
| `<suspends>` | 异步等待 | `WaitSeconds(T:float)<suspends>:void = Sleep(T)` |
| `<no_rollback>` | 不可回滚 | 用户函数默认效果 |

### 常见模式

**安全访问**：
```verse
SafeGet(Array:[]t, Index:int where t:type)<decides><transacts>:t =
    Array[Index]
```

**条件验证**：
```verse
ValidateAge(Age:int)<decides><transacts>:void =
    if (Age < 18 or Age > 100):
        false?
```

**链式调用**：
```verse
Result := Data
    .FilterPositive()
    .MapDouble()
    .Sum()
```

**事务性更新**：
```verse
UpdateIfValid(var State:int, NewValue:int)<decides><transacts>:void =
    if (NewValue < 0):
        false?
    set State = NewValue
```

## 学习路径建议

### 初学者
1. 阅读 **01-function-syntax.md** 了解基本语法
2. 阅读 **02-effects-system.md** 的"概述"部分理解效果系统
3. 阅读 **06-failable-functions.md** 学习 `<decides>` 的基本用法

### 中级开发者
1. 深入学习 **02-effects-system.md** 的失败上下文和回滚机制
2. 学习 **04-overloading.md** 的重载规则
3. 学习 **05-extension-methods.md** 扩展现有类型

### 高级开发者
1. 理解 **03-lambda-closures.md** 的限制和替代方案
2. 掌握 **02-effects-system.md** 的效果组合和传播
3. 设计符合 Verse 习惯的 API（参考所有文档的"编程 Agent 使用指南"）

## 相关资源

### 官方文档
- [Verse Language Reference - Functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [UEFN Documentation](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-documentation)

### 仓库中的相关研究
- `workUnits/verseLogicLab/knowledge/research/verse-effects-system-research-20260112.md` - 效果系统完整规范
- `workUnits/verseLogicLab/knowledge/research/verse-higher-order-functions-research-20260113.md` - 高阶函数支持调研

### 其他参考
- `skills/verseDev/verseDLSD/` - DLSD 架构规范（使用效果系统的实践）
- `verse/library/` - DLSD 代码库（实际代码示例）

## 贡献指南

本文档基于以下来源创建：
1. 官方 Verse Language Reference
2. 仓库中的实际研究成果
3. 代码实践验证

如发现错误或需要补充：
1. 创建 Issue 说明问题
2. 提供具体的代码示例或文档引用
3. 如果是基于新发现，先在 `workUnits/verseLogicLab/knowledge/research/` 创建调研报告

## 文档更新历史

- **2026-01-14**: 创建完整的函数参考文档集（6份文档）
  - 基于官方文档和仓库研究成果
  - 包含完整的代码示例和使用指南
  - 记录了 Verse 的独特特性和限制

---

**下一步计划**：
- 添加更多实际项目中的代码示例
- 创建交互式教程
- 补充性能优化建议
