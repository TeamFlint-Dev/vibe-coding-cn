# Logic Analyzer - 逻辑分析器

> **职责**: 分析现有代码，理解上下文，识别可复用模块  
> **使用阶段**: Phase 2 - Implementation Path（编码前分析）

---

## 📖 概述

Logic Analyzer 是 Verse Logic Lab 的情报收集技能。在编写新代码之前，它帮助你：

1. **理解现有代码结构** - 分析已有的逻辑模块
2. **识别可复用组件** - 发现可以直接使用的函数
3. **分析依赖关系** - 理清模块间的依赖链
4. **避免重复造轮子** - 确保不与现有功能冲突

---

## 🎯 核心任务

### 1. 分析现有模块

**目标目录**: `verseProject/source/library/logicModules/`

**分析维度**:

#### 1.1 模块目录结构
```bash
cd verseProject/source/library/logicModules
find . -type f -name "*.verse"
```

**记录**:
- 有哪些子目录？（如 `characterAndStateUtils/`, `mathUtils/` 等）
- 每个目录的职责是什么？
- 模块命名规范是什么？

#### 1.2 模块内容分析

**对于每个相关模块**，提取：

- **导出的公共函数** - 查找 `<public>` 标记的函数
- **数据结构** - 查找 `struct<computes>` 定义
- **效果使用** - 函数使用了哪些效果（`<computes>`, `<decides>`, `<transacts>`）
- **依赖关系** - `using` 语句引入了哪些外部依赖

**分析示例**:

```verse
# 模块: RpgHealth.verse
# 职责: 生命值计算逻辑
# 导出函数:
#   - GetHealthPercent(state)<computes>:float
#   - CheckAlive(state)<decides><transacts>:void
#   - CalculateDamage(...)<computes>:float
# 数据结构:
#   - health_state := struct<computes> (Current, Maximum, Shield)
# 依赖:
#   - /Verse.org/Simulation
```

### 2. 识别可复用功能

**问题清单**:

- [ ] 我需要的功能是否已经存在？
- [ ] 现有函数的接口是否满足我的需求？
- [ ] 是否可以通过组合现有函数实现？
- [ ] 是否需要扩展现有模块而非创建新模块？

**决策矩阵**:

| 情况 | 行动 |
|------|------|
| 功能完全存在 | 直接使用，不编写新代码 |
| 功能部分存在 | 扩展现有模块，添加新函数 |
| 功能不存在但相关 | 在相关目录下创建新文件 |
| 功能完全独立 | 创建新的子目录和模块 |

### 3. 依赖关系分析

**绘制依赖图**:

```
MyNewModule
├── 依赖 RpgHealth (生命值计算)
│   └── 依赖 /Verse.org/Simulation
└── 依赖 MathUtils (数学工具)
    └── 无外部依赖
```

**检查循环依赖**:
- [ ] A 依赖 B，B 是否依赖 A？（循环依赖）
- [ ] 依赖链是否过长？（超过 3 层）
- [ ] 是否引入了不必要的依赖？

### 4. 模式识别

**常见模式识别**:

| 模式 | 示例 | 使用场景 |
|------|------|----------|
| **状态查询** | `GetHealthPercent(state)` | 从状态数据中提取信息 |
| **状态验证** | `CheckAlive(state)<decides>` | 验证状态是否满足条件 |
| **计算转换** | `CalculateDamage(hp, dmg)` | 纯计算，无状态依赖 |
| **组合计算** | `ApplyDamageAndHeal(...)` | 组合多个计算步骤 |

**当前项目的模式**:

通过分析 `logicModules/characterAndStateUtils/` 发现的模式：

1. **Struct-based State（基于结构的状态）**
   - 使用 `struct<computes>` 定义状态数据
   - 状态不可变，函数返回新状态

2. **Pure Calculation Functions（纯计算函数）**
   - 使用 `<computes>` 效果
   - 输入 → 输出，无副作用

3. **Predicate Functions（谓词函数）**
   - 使用 `<decides>` 效果
   - 返回 void，通过成功/失败表示结果

4. **Safe Math（安全数学）**
   - 使用 `Clamp`, `Min`, `Max` 保护边界
   - 明确处理除零、负数等情况

---

## 🛠️ 分析工具和命令

### 查找特定模式

**查找所有公共函数**:
```bash
cd verseProject/source/library/logicModules
grep -r "<public>" --include="*.verse"
```

**查找结构定义**:
```bash
grep -r "struct<computes>" --include="*.verse"
```

**查找使用特定效果的函数**:
```bash
grep -r "<decides>" --include="*.verse"
```

**列出所有 using 语句**:
```bash
grep -r "^using" --include="*.verse"
```

### 代码度量

**统计模块数量**:
```bash
find verseProject/source/library/logicModules -name "*.verse" | wc -l
```

**统计代码行数**:
```bash
find verseProject/source/library/logicModules -name "*.verse" -exec wc -l {} + | tail -1
```

---

## 📋 分析流程

当接到新任务时，遵循以下流程：

### Step 1: 快速扫描
- [ ] 列出 `logicModules/` 下的所有子目录
- [ ] 识别与任务相关的子目录

### Step 2: 深度阅读
- [ ] 阅读相关模块的完整代码
- [ ] 理解每个公共函数的职责
- [ ] 记录可直接使用的函数

### Step 3: 决策制定
- [ ] 确定是扩展现有模块还是创建新模块
- [ ] 规划新代码的组织结构
- [ ] 确认不会引入循环依赖

### Step 4: 文档化发现
- [ ] 记录分析结果（哪些模块相关、哪些函数可用）
- [ ] 列出需要注意的模式和约定
- [ ] 向用户呈现分析结论

---

## 📝 输出模板

完成分析后，使用以下模板向用户报告：

```markdown
## Logic Analysis Report

### 相关现有模块
- `logicModules/[path]/[module].verse` - [职责描述]
  - 可复用函数: [函数列表]
  - 相关结构: [数据结构]

### 依赖关系
- 需要依赖: [模块列表]
- 无循环依赖: ✅ / ⚠️

### 实现策略
- [ ] 直接使用现有功能
- [ ] 扩展现有模块 [模块名]
- [ ] 创建新模块 [位置]

### 注意事项
- [需要注意的模式或约定]
- [潜在的问题或风险]
```

---

## 🎯 最佳实践

### DO（应该做）
- ✅ **先分析，后编码** - 避免重复造轮子
- ✅ **理解现有模式** - 保持代码风格一致
- ✅ **记录分析结果** - 便于后续决策
- ✅ **识别可复用性** - 发现通用模式

### DON'T（不应该做）
- ❌ **跳过分析直接编码** - 可能与现有代码冲突
- ❌ **孤立地看待问题** - 忽略整体架构
- ❌ **过度依赖记忆** - 总是查看最新代码
- ❌ **忽略命名规范** - 破坏一致性

---

## 🔄 持续学习

每次分析后，更新你对代码库的理解：

1. **模式库更新** - 发现新模式时记录到 `knowledge/PATTERNS.md`
2. **依赖图更新** - 维护模块依赖关系的心智模型
3. **最佳实践** - 识别并传播优秀的代码示例

---

**记住**：理解现有代码是编写高质量新代码的前提。花时间分析永远是值得的。
