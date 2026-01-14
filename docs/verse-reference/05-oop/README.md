# Verse 面向对象编程 (OOP) 参考文档

本目录包含 Verse 语言面向对象编程特性的详细调研文档。

## 文档列表

### [01-class-definition.md](./01-class-definition.md) - 类定义与构造
**核心内容**：
- `class` 语法和字段声明规则
- 构造函数和原型（archetype）语法
- `Self` 标识符的使用
- 类修饰符：`<concrete>`, `<unique>`, `<final>`
- 块表达式在类体中的应用

**适合场景**：
- 创建新的类定义
- 理解类的实例化过程
- 设计不可变和可变字段

---

### [02-interfaces.md](./02-interfaces.md) - 接口与实现
**核心内容**：
- `interface` 定义语法
- 类实现接口的 `<override>` 要求
- 多接口实现
- 接口继承（接口组合）
- 接口与抽象类的区别

**适合场景**：
- 定义行为契约
- 实现多态和依赖注入
- 设计可扩展的系统

---

### [03-inheritance.md](./03-inheritance.md) - 继承与覆盖
**核心内容**：
- 类继承语法 `class(父类)`
- 字段和方法的 `<override>`
- `(super:)` 调用父类实现
- 抽象类 `<abstract>`
- `<final>` 修饰符防止继承
- is-a 关系和类型多态

**适合场景**：
- 建立类型层次结构
- 复用代码和共享行为
- 实现模板方法模式

---

### [04-access-control.md](./04-access-control.md) - 访问控制
**核心内容**：
- 四种访问级别：`<public>`, `<internal>`, `<protected>`, `<private>`
- 分离读写权限（`var<写权限> 字段<读权限>`）
- 类标识符和构造器的独立访问控制
- `<scoped>` 作用域限定
- 封装和最小权限原则

**适合场景**：
- 隐藏实现细节
- 设计类的公开 API
- 实现工厂方法和单例模式

---

## 快速查询表

### 常用修饰符速查

| 修饰符 | 用途 | 应用对象 |
|--------|------|----------|
| `<public>` | 公开访问 | 类、字段、方法 |
| `<private>` | 私有访问 | 字段、方法 |
| `<protected>` | 保护访问（类和子类） | 字段、方法 |
| `<internal>` | 模块内访问（默认） | 类、字段、方法 |
| `<override>` | 覆盖父类成员 | 字段、方法 |
| `<abstract>` | 抽象类/方法 | 类、方法 |
| `<final>` | 禁止继承/覆盖 | 类、字段、方法 |
| `<concrete>` | 可用空原型构造 | 类 |
| `<unique>` | 基于标识比较 | 类 |

### OOP 特性对比

| 特性 | Verse 语法 | 说明 |
|------|-----------|------|
| 定义类 | `类名 := class:` | 基本类定义 |
| 继承类 | `子类 := class(父类):` | 单继承 |
| 实现接口 | `类 := class(接口1, 接口2):` | 多接口 |
| 类+接口 | `类 := class(父类, 接口):` | 父类在前 |
| 覆盖成员 | `成员<override>` | 必须显式 |
| 调用父类 | `(super:)方法名()` | 访问父类实现 |
| 构造实例 | `实例 := 类{字段 := 值}` | 原型语法 |
| Self 引用 | `Self` | 当前实例 |

### 设计模式映射

| 模式 | 使用的 OOP 特性 | 参考文档 |
|------|----------------|----------|
| 工厂方法 | 私有构造器 + 公开静态方法 | 04-access-control.md |
| 模板方法 | 抽象类 + 覆盖 | 03-inheritance.md |
| 策略模式 | 接口 + 实现 | 02-interfaces.md |
| 单例模式 | 私有构造器 + 静态实例 | 04-access-control.md |
| 装饰器模式 | 继承 + super 调用 | 03-inheritance.md |

---

## 学习路径建议

### 初学者路径
1. **01-class-definition.md** - 掌握基本类定义
2. **04-access-control.md** - 理解封装和访问控制
3. **03-inheritance.md** - 学习继承和代码复用
4. **02-interfaces.md** - 理解接口和多态

### 进阶路径
1. 阅读所有文档的"高级用法"章节
2. 研究"编程 Agent 使用指南"
3. 实践"重构模式"中的示例
4. 深入理解效果系统与 OOP 的结合

---

## 相关资源

### 官方文档
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [Class 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)
- [Interface 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse)
- [Subclass 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse)
- [Specifiers and Attributes](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse)

### 本地资源
- `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/` - 爬取的官方文档

---

## 反馈与贡献

如发现文档中的错误或需要补充的内容，请：
1. 在仓库创建 Issue
2. 标注文档名称和问题位置
3. 提供修正建议或补充内容

---

**最后更新**: 2026-01-14
