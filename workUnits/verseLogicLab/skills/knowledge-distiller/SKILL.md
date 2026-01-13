# Knowledge Distiller - 知识蒸馏器

> **职责**: 更新知识资产，沉淀经验，提炼模式  
> **使用阶段**: Phase 3 - Knowledge Distillation（任务完成后）

---

## 📖 概述

Knowledge Distiller 确保每次任务的经验都能被保存和复用。它管理三类知识资产：

1. **Architecture Decision Records (ADRs)** - 重要决策及其理由
2. **Compilation Lessons** - 编译错误和解决方法
3. **Logic Patterns** - 可复用的逻辑模式

---

## 🗃️ 知识资产管理

### 1. Architecture Decision Records (ADRs)

**文件**: `workUnits/verseLogicLab/knowledge/DECISION_RECORDS.md`

#### 什么时候记录 ADR？

**需要记录**:
- ✅ 选择了特定的算法或数据结构
- ✅ 在多个实现方案中做了权衡
- ✅ 引入了新的依赖或模式
- ✅ 违反了常规做法（有充分理由）
- ✅ 做出了影响未来扩展的决策

**不需要记录**:
- ❌ 简单的工具函数（如类型转换）
- ❌ 完全遵循现有模式的实现
- ❌ 显而易见的实现方式
- ❌ 临时的权宜之计（应该标记为 TODO）

#### ADR 模板

```markdown
## ADR-[编号]: [决策标题]

**日期**: 2026-01-12  
**状态**: Accepted / Superseded / Deprecated  
**相关模块**: `logicModules/[path]/[module].verse`

### 上下文（Context）

[描述做出这个决策时的背景和约束条件]

### 决策（Decision）

[清晰描述做出了什么决策]

### 理由（Rationale）

[为什么做出这个决策]

- **优点**:
  - [优点 1]
  - [优点 2]
  
- **缺点**:
  - [缺点 1]
  - [缺点 2]

### 替代方案（Alternatives）

- **方案 A**: [描述] - [为什么没选择]
- **方案 B**: [描述] - [为什么没选择]

### 后果（Consequences）

- [这个决策带来的影响]
- [未来需要注意的事项]
- [可能需要调整的场景]

### 参考（References）

- [相关代码文件]
- [相关文档或讨论]
```

#### 示例 ADR

```markdown
## ADR-001: 使用 Clamp 而非条件判断保护数值边界

**日期**: 2026-01-12  
**状态**: Accepted  
**相关模块**: `logicModules/characterAndStateUtils/RpgHealth.verse`

### 上下文

在生命值计算中，需要确保结果不超出 [0, MaxHP] 范围。

### 决策

使用 `Clamp(Value, 0.0, MaxHP)` 而非 `if-else` 条件判断。

### 理由

- **优点**:
  - 代码更简洁
  - 一行表达意图，易读
  - 性能相当（编译器可优化）
  
- **缺点**:
  - 对初学者可能不如 if-else 直观

### 替代方案

- **if-else**: 
  ```verse
  if (Value < 0.0): 0.0
  else if (Value > MaxHP): MaxHP
  else: Value
  ```
  更啰嗦，但意图同样清晰。

### 后果

- 所有数值计算模块应遵循此模式
- 提高代码一致性
- 新成员需要了解 Clamp 的语义

### 参考

- `RpgHealth.verse:38` - CalculateDamage 函数
```

---

### 2. Compilation Lessons（编译经验）

**文件**: `workUnits/verseLogicLab/knowledge/COMPILATION_LESSONS.json`

#### JSON 结构

```json
{
  "lessons": [
    {
      "id": "LESSON-001",
      "error": "完整的错误信息",
      "context": "发生这个错误的场景",
      "solution": "如何修复",
      "prevention": "如何预防",
      "date": "2026-01-12",
      "tags": ["type-error", "effect-mismatch"]
    }
  ]
}
```

#### 什么时候记录 Lesson？

**需要记录**:
- ✅ 第一次遇到某类错误
- ✅ 错误信息不直观，需要深入理解
- ✅ 修复方法不明显
- ✅ 容易重复犯的错误

**不需要记录**:
- ❌ 拼写错误（typo）
- ❌ 显而易见的错误（如缺少括号）
- ❌ 已经记录过的同类错误

#### 记录流程

1. **复制完整错误信息**
   ```
   path/to/file.verse:10:5:10:20:error:3588:Ambiguous identifier 'Calculate'
   ```

2. **描述上下文**
   ```
   在多个模块都定义了 Calculate 函数，直接使用时编译器无法确定使用哪个。
   ```

3. **记录解决方案**
   ```
   使用模块限定符：MyModule.Calculate(A, B)
   ```

4. **提炼预防方法**
   ```
   在使用跨模块函数前，先检查是否有重名。优先使用唯一的函数名。
   ```

5. **添加标签**
   ```
   ["ambiguous-identifier", "naming"]
   ```

#### 示例 Lesson

```json
{
  "id": "LESSON-001",
  "error": "error:3588:Ambiguous identifier 'Calculate'",
  "context": "在定义同名函数时未使用模块限定符，多个模块都有 Calculate 函数",
  "solution": "使用完整的模块路径：MyModule.Calculate 而非 Calculate",
  "prevention": "命名函数时尽量使用描述性名称（如 CalculateDistance），避免泛化名称（如 Calculate）",
  "date": "2026-01-12",
  "tags": ["ambiguous-identifier", "naming", "beginner"]
}
```

---

### 3. Logic Patterns（逻辑模式）

**文件**: `workUnits/verseLogicLab/knowledge/PATTERNS.md`

#### 什么是可复用模式？

**模式特征**:
- 解决常见问题
- 可泛化到多个场景
- 有清晰的意图和结构
- 经过验证有效

#### 模式分类

| 分类 | 描述 | 示例 |
|------|------|------|
| **数据转换** | 数据格式或类型转换 | Float ↔ Int, Vector ↔ Tuple |
| **数值计算** | 数学计算和边界保护 | Clamp, Lerp, Normalize |
| **条件判断** | 使用 `<decides>` 的谓词 | CheckInRange, CheckAlive |
| **集合操作** | 数组/列表处理 | Filter, Map, Fold |
| **状态查询** | 从状态数据提取信息 | GetPercent, GetStatus |

#### 模式模板

```markdown
### [模式名称]

**意图**: [一句话描述这个模式的目的]

**使用场景**: [什么时候应该使用这个模式]

**结构**:
```verse
PatternName<public>(参数)<效果>:返回类型 =
    [伪代码或真实代码]
```

**示例**:
```verse
[实际使用的例子]
```

**注意事项**:
- [使用这个模式时需要注意的点]
- [常见错误]

**相关模式**:
- [其他相关的模式]
```

#### 示例 Pattern

```markdown
### Safe Division（安全除法）

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
- Default 应该是业务上合理的值（如 0.0, 1.0, 或特定的最小/最大值）
- 对于必须有效的除法，考虑使用 `<decides>` 效果而非返回默认值

**相关模式**:
- Safe Math Operations（安全数学运算）
- Clamp Pattern（边界限制模式）
```

---

## 📋 知识沉淀流程

### Step 1: 任务回顾

完成代码编写后，回顾整个过程：

- [ ] 遇到了哪些编译错误？
- [ ] 做了哪些重要的设计决策？
- [ ] 发现了哪些可复用的模式？
- [ ] 有哪些经验值得分享？

### Step 2: 评估记录必要性

对于每个发现，问自己：

**ADR 评估**:
- 这个决策是否影响未来的设计？
- 未来的开发者是否需要理解这个决策的背景？
- 是否有权衡和替代方案需要记录？

**Lesson 评估**:
- 这个错误是否容易再次发生？
- 错误信息是否足够清晰？（如果不清晰，更需要记录）
- 解决方法是否显而易见？（如果不明显，需要记录）

**Pattern 评估**:
- 这个实现是否可以泛化？
- 其他模块是否可能需要类似功能？
- 是否形成了可命名的模式？

### Step 3: 记录知识

根据评估结果，更新相应的知识文件。

**ADR**:
```bash
# 编辑 DECISION_RECORDS.md
# 在文件末尾添加新的 ADR 条目
# 使用递增的编号（ADR-001, ADR-002, ...）
```

**Lesson**:
```bash
# 编辑 COMPILATION_LESSONS.json
# 在 lessons 数组中添加新条目
# 使用递增的 ID（LESSON-001, LESSON-002, ...）
```

**Pattern**:
```bash
# 编辑 PATTERNS.md
# 在相应分类下添加新模式
# 如果需要，创建新的分类
```

### Step 4: 交叉引用

在记录时，添加交叉引用：

- ADR 中引用相关的代码文件
- Lesson 中引用相关的 ADR（如果存在）
- Pattern 中引用使用该模式的模块

### Step 5: 标记和索引

确保记录可被检索：

- ADR: 使用清晰的标题和编号
- Lesson: 添加有意义的标签
- Pattern: 归入正确的分类

---

## 🎯 质量标准

### 好的 ADR 特征
- ✅ 清晰描述问题背景
- ✅ 明确说明决策内容
- ✅ 列出优缺点和权衡
- ✅ 记录替代方案
- ✅ 说明未来影响

### 好的 Lesson 特征
- ✅ 完整的错误信息
- ✅ 清晰的上下文描述
- ✅ 可操作的解决方案
- ✅ 可预防性建议
- ✅ 有帮助的标签

### 好的 Pattern 特征
- ✅ 清晰的意图说明
- ✅ 可运行的代码示例
- ✅ 明确的使用场景
- ✅ 注意事项和陷阱
- ✅ 相关模式的链接

---

## 📊 知识资产维护

### 定期审查

每季度或积累一定量的记录后，审查知识库：

- [ ] 是否有过时的 ADR？（状态改为 Superseded）
- [ ] 是否有已解决的 Lesson？（更新或删除）
- [ ] 是否有更好的 Pattern 实现？（更新）
- [ ] 是否需要重新组织分类？

### 重构知识库

当知识库变得庞大时：

- **ADR**: 按模块或时间归档
- **Lesson**: 按错误类型分组
- **Pattern**: 创建更细粒度的分类

### 知识传播

定期将重要知识传播到更广的范围：

- 更新工作单元的 `SKILL.md`
- 更新 `CHECKLISTS.md` 检查项
- 分享到团队文档或 Wiki

---

## 🛠️ 工具和技巧

### 技巧 1: 即时记录

在编码过程中遇到问题时，立即在旁边打开知识文件，边修复边记录。不要等到事后才回忆。

### 技巧 2: 模板使用

保持模板文件，快速填充：

```bash
# ADR 模板
cp templates/adr-template.md knowledge/DECISION_RECORDS.md

# 在末尾追加新 ADR
```

### 技巧 3: 自动化标签

使用一致的标签体系：

**Lesson 标签**:
- `type-error`, `effect-mismatch`, `ambiguous-identifier`
- `beginner`, `advanced`
- `common`, `rare`

### 技巧 4: 代码链接

在记录中使用明确的代码引用：

```markdown
参考：`logicModules/mathUtils/SafeMath.verse:42-58`
```

---

## 📝 检查清单

任务完成后，确认：

### 编译经验
- [ ] 所有编译错误都已记录（如果值得记录）
- [ ] 解决方案清晰可操作
- [ ] 添加了预防措施建议
- [ ] 标签完整且有意义

### 架构决策
- [ ] 重要决策已记录
- [ ] 上下文和理由清晰
- [ ] 替代方案和权衡已说明
- [ ] 未来影响已考虑

### 逻辑模式
- [ ] 可复用模式已提取
- [ ] 代码示例可运行
- [ ] 使用场景清晰
- [ ] 分类正确

### 质量检查
- [ ] 内容准确无误
- [ ] 格式规范一致
- [ ] 交叉引用完整
- [ ] 可被未来的自己理解

---

## 🎓 学习与改进

### 从知识库学习

定期回顾知识库：

- 每月阅读一次 DECISION_RECORDS.md
- 在遇到类似问题时查询 COMPILATION_LESSONS.json
- 在编码前浏览 PATTERNS.md 寻找灵感

### 反馈循环

```
任务 → 踩坑 → 记录 Lesson → 提炼检查项 → 下次避免
任务 → 决策 → 记录 ADR → 传播知识 → 团队受益
任务 → 模式 → 记录 Pattern → 复用 → 提高效率
```

---

**记住**：今天的经验是明天的资产。花在记录上的时间，会在未来多次返还。知识沉淀是代码工厂的核心竞争力。
