# Verse 类型系统调研文档

本目录包含 Verse 类型系统的全面调研报告，每份文档都遵循统一的结构模板，便于 AI Agent 和开发者快速查阅。

## 文档列表

| 文档 | 主题 | 关键内容 |
|------|------|----------|
| [01-primitive-types.md](./01-primitive-types.md) | **基础类型全览** | `int`, `float`, `string`, `logic`, `char` 的定义、范围、默认值、字面量语法 |
| [02-option-types.md](./02-option-types.md) | **可选类型** | `?` 语法、`option{T}` 用法、失败上下文中的行为、查询操作符 |
| [03-container-types.md](./03-container-types.md) | **容器类型** | `array`, `map` 的声明、初始化、常用操作、Set 模拟 |
| [04-tuples.md](./04-tuples.md) | **元组与命名元组** | 元组语法 `(A, B)`、元素访问、解构赋值、与 struct 对比 |
| [05-type-inference.md](./05-type-inference.md) | **类型推断机制** | `:=` 语法、推断规则、何时必须显式标注、推断 vs 显式决策树 |
| [06-type-conversion.md](./06-type-conversion.md) | **类型转换与强制** | Float↔Int 转换、`Floor/Ceil/Round`、字符串插值、元组 coercion |
| [07-generics.md](./07-generics.md) | **泛型** | `(t:type)=>...` 语法、`where` 约束、泛型类与函数、常见泛型模式 |
| [08-subtyping.md](./08-subtyping.md) | **子类型与超类型** | `class(base)` 继承、`interface` 实现、`subtype/supertype` 约束、类型转换 |

## 文档结构

每份文档都包含以下标准章节：

1. **概述** - 一句话定义 + 适用场景
2. **语法规范** - 完整语法格式 + 关键词说明表
3. **示例代码**
   - 最小示例（Quick Start）
   - 常见用法（实际场景）
   - 高级用法（复杂模式）
4. **常见错误与陷阱** - 典型错误示例 + 正确做法
5. **与其他语言对比** - TypeScript/C#/Rust/Python 对比表
6. **编程 Agent 使用指南**
   - 生成代码时的最佳实践
   - 决策树和检查清单
   - 常见任务代码模板
7. **参考资源** - 官方文档链接

## 快速导航

### 按使用频率

**高频使用**（基础必读）：
- [基础类型](./01-primitive-types.md) - `int`, `float`, `string` 等
- [可选类型](./02-option-types.md) - 处理可能为空的值
- [容器类型](./03-container-types.md) - 数组和映射
- [类型推断](./05-type-inference.md) - `:=` 语法

**中频使用**（按需查阅）：
- [元组](./04-tuples.md) - 多值返回和临时分组
- [类型转换](./06-type-conversion.md) - 数值和字符串转换

**高级主题**（深入学习）：
- [泛型](./07-generics.md) - 编写通用代码
- [子类型系统](./08-subtyping.md) - 继承和多态

### 按问题场景

| 场景 | 推荐文档 |
|------|----------|
| "如何存储可能不存在的值？" | [02-option-types.md](./02-option-types.md) |
| "如何管理玩家列表？" | [03-container-types.md](./03-container-types.md) |
| "函数如何返回多个值？" | [04-tuples.md](./04-tuples.md) |
| "如何在 int 和 float 之间转换？" | [06-type-conversion.md](./06-type-conversion.md) |
| "如何写通用的 Map/Filter 函数？" | [07-generics.md](./07-generics.md) |
| "如何实现类继承？" | [08-subtyping.md](./08-subtyping.md) |
| "何时需要显式类型标注？" | [05-type-inference.md](./05-type-inference.md) |

### 按编程任务

**数据建模**：
1. [基础类型](./01-primitive-types.md) - 选择合适的基本类型
2. [容器类型](./03-container-types.md) - 选择 array/map/set
3. [元组](./04-tuples.md) vs [子类型](./08-subtyping.md) - 临时分组 vs 正式结构

**算法实现**：
1. [泛型](./07-generics.md) - 编写类型安全的通用算法
2. [类型转换](./06-type-conversion.md) - 处理类型转换
3. [可选类型](./02-option-types.md) - 处理可能失败的操作

**架构设计**：
1. [子类型](./08-subtyping.md) - 设计类层级
2. [泛型](./07-generics.md) - 设计通用组件
3. [容器类型](./03-container-types.md) - 设计数据结构

## 使用建议

### 对于 AI Agent

1. **生成代码前**：查阅相关文档的"编程 Agent 使用指南"章节
2. **遇到错误**：检查"常见错误与陷阱"章节
3. **不确定语法**：查看"示例代码"章节的最小示例
4. **需要模板**：使用"常见任务代码模板"

### 对于开发者

1. **初学者**：按文档编号顺序阅读 01-05
2. **进阶学习**：深入研究 06-08
3. **问题排查**：使用"按问题场景"导航快速定位
4. **代码审查**：参考"最佳实践总结"章节

## 维护说明

- **更新频率**：Verse 语言更新时同步更新
- **版本标记**：每份文档顶部标注适用的 Verse 版本（如需要）
- **补充说明**：发现官方文档未覆盖的内容时添加到相应章节
- **错误修正**：如发现错误或过时内容，请及时更新

## 贡献指南

如需补充或修正文档：

1. 保持统一的文档结构
2. 示例代码必须来自实际可运行的代码或官方文档
3. 错误示例使用 `❌` 标记，正确示例使用 `✅` 标记
4. 对比表格保持一致的列顺序
5. 添加参考资源链接时优先使用官方文档

## 相关资源

- [Verse 官方语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [Verse API 文档](https://dev.epicgames.com/documentation/en-us/uefn/verse-api)
- [UEFN 官方教程](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-documentation)

---

**最后更新**: 2026-01-14  
**文档版本**: 1.0  
**适用 Verse 版本**: Current (UEFN)
