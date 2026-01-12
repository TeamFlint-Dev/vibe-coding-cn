# Architecture Decision Records

这份文档记录 Verse Logic Lab 的重要架构决策。

---

## 为什么需要 ADR？

Architecture Decision Records (ADR) 记录重要的技术决策及其背景，帮助：

1. **理解历史** - 为什么当初这样设计？
2. **避免重复讨论** - 已经权衡过的方案
3. **传承知识** - 新成员快速了解系统
4. **追溯决策** - 出现问题时回溯原因

---

## 记录原则

### 应该记录的决策
- ✅ 算法或数据结构的选择
- ✅ 多方案权衡后的选择
- ✅ 引入新的依赖或模式
- ✅ 违反常规的做法（有充分理由）
- ✅ 影响未来扩展的决策

### 不需要记录的决策
- ❌ 简单的工具函数
- ❌ 完全遵循现有模式
- ❌ 显而易见的实现
- ❌ 临时的权宜之计

---

## ADR 模板

```markdown
## ADR-[编号]: [决策标题]

**日期**: YYYY-MM-DD  
**状态**: Accepted / Superseded / Deprecated  
**相关模块**: `logicModules/[path]/[module].verse`

### 上下文（Context）
[背景和约束条件]

### 决策（Decision）
[做出了什么决策]

### 理由（Rationale）
- **优点**: [...]
- **缺点**: [...]

### 替代方案（Alternatives）
- **方案 A**: [...] - [为什么没选择]

### 后果（Consequences）
- [决策带来的影响]

### 参考（References）
- [相关代码或文档]
```

---

## ADR 列表

### ADR-000: 示例决策（删除此条目）

**日期**: 2026-01-12  
**状态**: Example  
**相关模块**: N/A

### 上下文

这是一个示例 ADR，展示如何记录决策。实际使用时请删除此条目。

### 决策

使用 ADR 记录所有重要的架构决策。

### 理由

- **优点**:
  - 知识可追溯
  - 团队共识明确
  - 避免重复讨论

- **缺点**:
  - 需要额外的文档维护时间

### 替代方案

- **不记录**: 依赖口头传递和记忆 - 知识容易丢失
- **使用 Git Commits**: 在提交信息中说明 - 难以检索和汇总

### 后果

- 每次重要决策后需要更新此文件
- 需要定期审查和维护

### 参考

- 详细指南见 `skills/knowledge-distiller/SKILL.md`

---

## 状态说明

| 状态 | 说明 |
|------|------|
| **Proposed** | 提议中，待讨论 |
| **Accepted** | 已接受，正在执行 |
| **Superseded** | 已被新决策取代 |
| **Deprecated** | 已废弃，不再使用 |

---

## 维护指南

1. **添加新 ADR**: 使用递增编号，在文件末尾追加
2. **更新状态**: 决策变更时更新状态字段
3. **交叉引用**: 在代码注释中引用相关 ADR
4. **定期审查**: 每季度检查是否有过时的 ADR

---

## ADR-001: 使用 Enum 派发而非 Struct + 参数数组

**日期**: 2026-01-12  
**状态**: Accepted  
**相关模块**: `logicModules/coreMathUtils/MathCurves.verse`

### 上下文（Context）

需要为缓动曲线（Easing Curves）提供统一的采样接口。有两种设计方案：
1. 使用 struct 存储曲线类型和参数数组，通过动态解析参数调用对应函数
2. 使用 enum 类型标识曲线，直接通过类型派发到对应函数

### 决策（Decision）

选择方案 2：使用 `curve_type` enum 和 enum 派发的 `SampleEasingCurve` 函数。

### 理由（Rationale）

- **优点**:
  - 类型安全：enum 在编译时验证，避免运行时类型错误
  - 无效果冲突：不需要数组访问（`<decides>`），避免与 `<transacts>` 冲突
  - 更简洁：缓动曲线无参数，不需要参数数组
  - 性能更好：直接函数调用，无需数组解析
  - 易于扩展：添加新曲线类型只需扩展 enum 和 if-else 链

- **缺点**:
  - if-else 链较长（19 个曲线类型）
  - 不支持动态曲线类型（需要编译时已知）
  - 无法表示参数化曲线（如需要控制点的 Bezier 曲线）

### 替代方案（Alternatives）

- **方案 A（Struct + 参数数组）**:  
  ```verse
  curve_config := struct:
      Type:curve_type
      Params:[]float
  
  SampleCurve(Config:curve_config, T:float)<transacts><decides>:float
  ```
  - 更灵活，可以表示参数化曲线
  - 需要处理数组访问的 `<decides>` 效果（可能失败）
  - 实现复杂度较高，需要更多的错误处理逻辑
  - **更正说明**：原 ADR 错误地认为 `<decides>` 与 `<transacts>` 不兼容。实际上 `<transacts><decides>` 可以组合使用

### 后果（Consequences）

- 缓动曲线采用 enum 派发，简单高效
- Bezier 曲线仍然直接使用原有函数（LinearBezier, QuadraticBezier, CubicBezier）
- 未来如需参数化曲线，可以创建独立的 struct 系统（与缓动曲线分离）
- 保持了代码的简洁性和可维护性

### 参考（References）

- `MathCurves.verse:218-296` - curve_type enum 和 SampleEasingCurve 实现
- Verse 效果系统文档（关于 transacts, decides, no_rollback 的兼容性）

---

## ADR-002: Enum 命名使用 "Curve" 前缀避免函数名冲突

**日期**: 2026-01-12  
**状态**: Accepted  
**相关模块**: `logicModules/coreMathUtils/MathCurves.verse`

### 上下文（Context）

`MathCurves` 模块中已有 19 个缓动函数（EaseLinear, EaseInSine, EaseOutSine 等）。创建曲线类型 enum 时，如果使用相同名称，会导致编译器报错 "ambiguous identifier"。

### 决策（Decision）

Enum 值使用 "Curve" 前缀：`CurveLinear`, `CurveInSine`, `CurveOutSine` 等。

### 理由（Rationale）

- **优点**:
  - 完全避免名称冲突
  - 语义清晰：CurveLinear 表示"线性曲线类型"，与 EaseLinear（线性缓动函数）区分
  - 符合 Verse 命名规范（enum 值使用名词性质的标识符）
  - 易于扩展：未来添加其他曲线类别（如 BezierCurve*）不会冲突

- **缺点**:
  - Enum 值名称略长
  - 需要记住两套名称（函数名和 enum 值名）

### 替代方案（Alternatives）

- **方案 A（使用函数名）**: 
  `EaseLinear`, `EaseInSine` 等
  - ❌ 与函数名冲突，无法编译

- **方案 B（使用后缀）**:
  `LinearCurve`, `InSineCurve` 等
  - 可行，但不够一致（Linear vs InSine 不对称）
  
- **方案 C（使用简写）**:
  `Lin`, `InSin`, `OutSin` 等
  - 过于简短，可读性差

### 后果（Consequences）

- 使用时需要显式写 `curve_type.CurveLinear`
- 与函数名（`EaseLinear`）明确区分，避免混淆
- 为未来添加其他曲线类型预留了命名空间

### 参考（References）

- `MathCurves.verse:220-241` - curve_type enum 定义
- Compilation Lesson LESSON-001 - ambiguous identifier 错误案例

---

## ADR-005: 创建综合信息源索引系统

**日期**: 2026-01-12  
**状态**: Accepted  
**相关文档**: `knowledge/SOURCES.md`, `knowledge/research/information-sources-research-20260112.md`

### 上下文（Context）

在开发过程中，团队需要频繁查阅以下信息：
1. Verse API 定义和文档
2. UEFN 功能和设备说明
3. 编译错误解决方案
4. 代码模式和最佳实践

这些信息散落在仓库的不同位置，缺乏统一的索引，导致：
- 重复搜索浪费时间
- 难以确定信息的权威性
- 新成员不知道如何查找资源
- 无法追溯知识来源

### 决策（Decision）

在 `knowledge/SOURCES.md` 中建立综合信息源索引系统，包含：

1. **按可靠性分级**：一级源（官方）、二级源（社区）、三级源（内部）
2. **详细索引结构**：
   - API Digest 文件（15,950 行官方定义）
   - UEFN 文档本地副本（5,071+ 页）
   - 工具和配置文件
   - 内部知识资产
3. **快速导航体系**：按任务类型提供查找路径
4. **查询命令示例**：提供常用的 grep/find/jq 命令
5. **信息源查找流程**：系统化的查询步骤

### 理由（Rationale）

**为什么需要索引？**
- 仓库包含大量信息源（5000+ 页文档），但难以发现
- 信息质量参差不齐，需要明确可靠性等级
- 缺乏系统化的查找方法，依赖个人经验

**为什么选择这种结构？**
- **分级索引**：明确信息源的可靠性，避免依赖不可靠的信息
- **按任务索引**：开发者通常基于任务查找信息，而非按资源类型
- **提供命令**：降低使用门槛，即使不熟悉仓库结构也能快速查询
- **记录路径**：保存在版本控制中，随仓库演进

**替代方案**：
1. **Wiki 或在线文档**：需要维护两套系统，容易过时
2. **README 说明**：不够详细，难以扩展
3. **口口相传**：知识流失风险高，无法传承

### 后果（Consequences）

**积极影响**：
- ✅ 提升信息查找效率：从随机搜索到系统查询
- ✅ 降低学习曲线：新成员可快速了解可用资源
- ✅ 建立知识可追溯性：明确每个结论的信息源
- ✅ 减少重复工作：避免重复搜索同样的信息

**维护成本**：
- ⚠️ 需要定期更新索引（尤其是 UEFN 文档）
- ⚠️ 新增资源时需要更新 SOURCES.md
- ✅ 成本可接受：更新频率低（月度级别），收益远大于成本

**使用建议**：
- 每次使用新的信息源时，及时添加到 SOURCES.md
- 在 ADR、Lessons、Patterns 中引用信息源，建立可追溯链条
- 定期审查信息源的有效性和准确性

### 参考（References）

- `knowledge/SOURCES.md` - 信息源索引主文档
- `knowledge/research/information-sources-research-20260112.md` - 详细调研报告
- `external/epic-docs-crawler/README.md` - UEFN 文档说明
- `external/epic-docs-crawler/uefn_docs_organized/README.md` - 完整文档索引

---
