# Verse 控制流调研报告

本目录包含 Verse 语言控制流特性的深度调研文档，基于官方文档 [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference) 整理而成。

## 文档清单

### [01-conditionals.md](./01-conditionals.md) - 条件表达式
调研 Verse 中的条件控制机制，包括：
- `if...then...else` 语法及其变体
- `if` 块语法与多行条件
- 嵌套条件的使用模式
- 条件表达式的返回值特性
- 事务性回滚机制
- 与失败上下文的深度集成

**核心特点**：基于成功/失败机制而非布尔值，支持自动回滚副作用。

### [02-loops.md](./02-loops.md) - 循环结构
深入研究 Verse 的两种循环：`for` 和 `loop`，包括：
- `for` 循环的有界迭代（范围、数组、映射）
- `loop` 循环的无界迭代与退出机制
- 迭代器模式与生成器语法
- `break` 语句的作用域与行为
- `for` 表达式的返回值特性（返回数组）

**核心特点**：`for` 是表达式可返回数组，`loop` 用于无界迭代。

### [03-failure-context.md](./03-failure-context.md) - 失败上下文
研究 Verse 独特的"失败即控制流"设计理念，包括：
- 可失败表达式（Failable Expression）的概念
- `?` 操作符的失败传播机制
- `or` 操作符的失败恢复机制
- 失败链与推测性执行
- `<decides>` 和 `<transacts>` 效果系统
- 事务性回滚的实现原理

**核心特点**：失败是正常控制流，副作用可自动回滚，验证与访问合二为一。

### [04-case-matching.md](./04-case-matching.md) - case/switch 匹配
调研 Verse 的模式匹配机制，包括：
- `case` 表达式的语法与语义
- 常量匹配（int/logic/string/char/enum）
- 穷尽性检查机制
- 默认分支 `_` 的使用
- 与其他控制流的配合
- 非穷尽 case 的失败行为

**核心特点**：作为表达式可返回值，支持枚举穷尽性检查。

### [05-expression-oriented.md](./05-expression-oriented.md) - 表达式导向编程
研究 Verse "一切皆表达式"的设计理念，包括：
- 表达式与语句的区别
- 块表达式的返回值机制
- 控制流表达式的返回值
- `void` 类型的语义
- 函数式编程模式
- 表达式组合与链式调用

**核心特点**：所有代码构造都是表达式，鼓励函数式风格，减少可变性。

## 核心设计理念

Verse 控制流的三大核心理念：

1. **失败即控制流**（Failure as Control Flow）
   - 使用成功/失败机制替代布尔值
   - 失败自动触发事务回滚
   - 验证与访问合二为一，减少错误

2. **一切皆表达式**（Everything is an Expression）
   - 所有控制流都可返回值
   - 支持函数式编程风格
   - 鼓励不可变性和组合性

3. **效果系统集成**（Effect System Integration）
   - 通过 `<decides>` 标注可失败代码
   - 通过 `<transacts>` 启用事务性
   - 编译期静态检查效果传播

## 文档结构

每份调研报告遵循统一结构：

```
# 特性名称

## 概述
## 语法规范
## 示例代码
### 最小示例
### 常见用法
### 高级用法
## 常见错误与陷阱
## 与其他语言对比
## 编程 Agent 使用指南
```

## 参考资源

- [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference) - 官方语言参考
- [Control Flow in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/control-flow-in-verse) - 控制流官方文档
- [Failure in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse) - 失败机制官方文档
- [Expressions in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/expressions-in-verse) - 表达式官方文档

## 相关资源

- `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/` - 爬取的官方文档
- `skills/verseDev/verseDLSD/` - Verse 开发技能（DLSD 架构）
- `verse/library/` - Verse 代码库示例

## 使用建议

1. **入门者**：按顺序阅读 01 → 02 → 04 → 03 → 05
   - 先掌握基本控制流（条件、循环、匹配）
   - 再理解失败上下文的高级概念
   - 最后学习表达式导向编程范式

2. **有经验开发者**：重点关注
   - 03-failure-context.md（Verse 独有特性）
   - 05-expression-oriented.md（范式转变）
   - 各文档的"与其他语言对比"章节

3. **AI Agent**：使用"编程 Agent 使用指南"章节
   - 模式推荐
   - 性能考虑
   - 调试技巧
   - 最佳实践

## 维护说明

- **创建时间**：2026-01-14
- **基于版本**：Verse Language Version 1
- **更新策略**：随官方文档更新而更新
- **贡献指南**：发现错误或改进建议请提交 Issue

---

**注意**：这些文档是研究性质的，旨在帮助开发者和 AI Agent 理解 Verse 控制流的设计理念和使用模式。实际开发时请以官方文档为准。
