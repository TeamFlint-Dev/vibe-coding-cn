# Verse 模块与组织系统

本目录包含关于 Verse 模块系统、导入机制和包管理的完整研究报告。

## 文档清单

### [01-module-system.md](./01-module-system.md) - 模块系统

**核心内容**：
- `module` 关键字定义语法
- 嵌套模块的层次结构
- 访问控制（`<public>`、`<internal>`、`<private>`）
- 文件夹自动成为模块的机制
- 导入导出规则
- 模块命名和组织最佳实践

**关键概念**：
- 文件夹即模块：每个文件夹自动创建模块
- 默认私有：模块默认 `<internal>`，需显式 `<public>` 公开
- 同文件夹共享：同一文件夹的 `.verse` 文件共享命名空间

**适用场景**：
- 创建新的代码模块
- 组织项目结构
- 设计公开 API 接口
- 实现 DLSD 架构分层

---

### [02-using-statement.md](./02-using-statement.md) - using 语句

**核心内容**：
- `using { ... }` 导入语法
- 三种路径类型：全局路径、项目路径、本地路径
- 嵌套模块的导入顺序规则
- 命名冲突的检测和解决
- 路径解析优先级

**关键概念**：
- 只导入模块，不导入成员（与其他语言不同）
- 必须先导入父模块再导入子模块
- 文件级作用域（无块级导入）
- 路径大小写敏感

**适用场景**：
- 引用外部模块
- 解决导入错误
- 处理命名冲突
- 优化依赖关系

---

### [03-packages.md](./03-packages.md) - 包与版本

**核心内容**：
- UEFN 插件系统架构
- `.uplugin` 文件配置
- Verse 包的组织结构
- 依赖管理策略
- 版本兼容性和迁移
- Epic Games 的向后兼容承诺

**关键概念**：
- 无内置包管理器（不同于 npm/cargo）
- 依赖通过 `using` 隐式声明
- 标准库和 Fortnite API 保证稳定
- 临时 API（`/UnrealEngine.com/Temporary/*`）可能变更

**适用场景**：
- 创建可复用的 Verse 库
- 开发 UEFN 插件
- 管理项目依赖
- 处理 API 版本升级

---

## 快速索引

### 常见任务

| 任务 | 参考文档 | 关键章节 |
|------|----------|----------|
| 创建新模块 | 01-module-system.md | 语法规范、示例代码 |
| 导入其他模块 | 02-using-statement.md | 语法规范、路径解析规则 |
| 组织项目结构 | 01-module-system.md | 文件夹即模块、高级用法 |
| 解决导入错误 | 02-using-statement.md | 常见错误与陷阱 |
| 处理命名冲突 | 02-using-statement.md | 命名冲突处理 |
| 创建 UEFN 插件 | 03-packages.md | UEFN 插件系统 |
| 管理依赖 | 03-packages.md | Verse 包依赖 |
| 版本升级迁移 | 03-packages.md | 版本兼容性 |

### 语法速查

**定义模块**：
```verse
MyModule<public> := module:
    SubModule<public> := module:
        Function<public>():void = ...
```

**导入模块**：
```verse
using { /Verse.org/Simulation }
using { /MyProject/Utils }
using { parent.child }
```

**文件夹模块**：
```verse
# File: library/export.verse
library<public> := module:
    utils<public> := module:
```

### 错误诊断

**"Module not found"**：
1. 检查路径拼写和大小写
2. 确认模块标记为 `<public>`
3. 确认文件夹有 `export.verse`
4. 确认父模块已导入（嵌套模块）

**"Identifier is ambiguous"**：
1. 使用完全限定名（`Module.Function`）
2. 检查是否有多个同名导入
3. 重命名本地定义

**"Module is not accessible"**：
1. 确认模块标记为 `<public>`
2. 确认父模块也是 `<public>`（嵌套模块）
3. 检查访问控制链路完整性

---

## 设计原则

### 模块设计原则

1. **单一职责**：每个模块只解决一个领域的问题
2. **最小公开**：只公开必要的接口，保持实现细节私有
3. **依赖最小**：减少外部依赖，提高模块独立性
4. **层次清晰**：嵌套层级控制在 3 层以内
5. **命名一致**：模块名与文件夹名保持一致

### 导入原则

1. **按类别分组**：标准库、Fortnite API、项目模块分组
2. **精确导入**：只导入需要的模块，避免过度依赖
3. **避免循环**：检查并消除循环依赖
4. **限定使用**：始终使用模块前缀访问成员

### 包设计原则

1. **职责单一**：包解决特定领域问题
2. **接口稳定**：公开 API 设计考虑向后兼容
3. **文档完整**：提供使用说明和示例
4. **依赖隔离**：封装不稳定的外部依赖
5. **版本管理**：在注释中记录版本和变更历史

---

## DLSD 架构集成

Verse 模块系统与 DLSD 架构的映射：

```
library/
├── export.verse              # 公开整个库
├── dataComponents/           # Data 层
│   ├── export.verse
│   └── ...
├── logicModules/             # Logic 层
│   ├── export.verse
│   ├── coreMathUtils/
│   ├── validationUtils/
│   └── ...
├── sessions/                 # Session 层
│   ├── export.verse
│   └── ...
└── driverComponents/         # Driver 层
    ├── export.verse
    └── ...
```

**依赖规则**：
- Driver → Session → Logic → Data
- 禁止反向依赖（Data 不能导入 Logic）
- 禁止跨层依赖（Driver 不能直接导入 Logic）

**导入示例**：

```verse
# Driver 层组件
using { /MyProject/library/dataComponents }
using { /MyProject/library/sessions }
# ❌ 不能直接导入 logicModules

# Session 层
using { /MyProject/library/dataComponents }
using { /MyProject/library/logicModules }
# ❌ 不能导入 driverComponents

# Logic 层
# ❌ 不导入任何项目模块（只导入标准库）
using { /Verse.org/Random }

# Data 层
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
# ❌ 不导入任何项目模块
```

---

## 扩展阅读

### 官方文档
- [Modules and Paths in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse)
- [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference)
- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [Create Your Own Device in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite)

### 相关技能文档
- `skills/verseDev/verseDLSD/SKILL.md` - DLSD 架构规范
- `skills/verseDev/verseDLSD/rules/` - 架构规则详解
- `verseProject/source/export.verse` - 实际项目示例

### 示例代码
- `verseProject/source/library/` - DLSD 架构实现
- `verseProject/source/library/logicModules/validationUtils/` - Logic 层模块示例
- `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/` - 官方教程

---

**最后更新**：2026-01-14  
**作者**：AI Agent (Copilot)  
**版本**：1.0.0
