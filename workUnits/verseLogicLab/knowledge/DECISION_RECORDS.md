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

---

## 当前的决策记录

### ADR-001: 浮点数比较默认 Epsilon 值选择

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `logicModules/coreMathUtils/MathFloatComparison.verse`

#### 上下文（Context）

在实现浮点数比较函数时，需要选择一个合适的默认 Epsilon 值作为容差。这个值需要在以下目标之间平衡：
- **精度**：足够小以检测真实的差异
- **容错**：足够大以容忍浮点运算的精度误差
- **易用性**：对大多数游戏逻辑场景都适用

Verse 使用 IEEE 754 标准的浮点数：
- `float` 可能是单精度（32位）或双精度（64位）
- 单精度浮点数有约 7 位十进制有效数字
- 双精度浮点数有约 15 位十进制有效数字

#### 决策（Decision）

选择 **0.0001** 作为默认 Epsilon 值，并提供 SmallEpsilon (0.000001) 和 LargeEpsilon (0.001) 供特殊场景使用。

#### 理由（Rationale）

**选择 0.0001 的理由**:

1. **游戏逻辑适用性**:
   - 游戏中的大多数数值（位置、速度、百分比）不需要超过 4 位小数的精度
   - 0.0001 对于位置差异（米级）是足够小的（0.1毫米误差）
   - 对于百分比差异，0.0001 = 0.01%，足够精确

2. **平衡精度与容错**:
   - 足够小：能区分真实的差异（如 1.0001 vs 1.0002）
   - 足够大：能容忍常见的浮点运算误差
   - 避免了 0.00001 可能过于敏感的问题

3. **行业实践**:
   - Unreal Engine 使用 KINDA_SMALL_NUMBER = 1.e-4f
   - Unity 使用 Epsilon = 0.00001f（我们的值稍大，更宽容）
   - 0.0001 是常见的工程折中选择

4. **可扩展性**:
   - 提供 SmallEpsilon (0.000001) 用于高精度场景（如物理模拟）
   - 提供 LargeEpsilon (0.001) 用于粗略比较（如 UI 显示）
   - 用户可以根据需求自定义 Epsilon

#### 替代方案（Alternatives）

**方案 A: 使用 0.00001（更小）**
- 优点：更高精度
- 缺点：可能对浮点运算误差过于敏感，导致误判
- **未选择理由**：游戏逻辑通常不需要这么高的精度

**方案 B: 使用 0.001（更大）**
- 优点：更宽容，减少误判
- 缺点：可能掩盖真实的差异
- **未选择理由**：对于插值等场景，0.001 可能太粗糙

**方案 C: 相对 Epsilon（基于值的大小）**
- 优点：对大数值和小数值都适用
- 缺点：实现复杂，性能开销更大
- **未选择理由**：游戏逻辑中的数值范围通常在可控范围内，绝对 Epsilon 足够

#### 后果（Consequences）

**正面影响**:
- ✅ 解决了浮点数直接比较的精度问题
- ✅ 提供了开箱即用的合理默认值
- ✅ 支持自定义 Epsilon 满足特殊需求
- ✅ 与行业标准实践一致

**负面影响**:
- ⚠️ 可能对极高精度场景（如科学计算）不够精确
  - 缓解：提供 SmallEpsilon 选项
- ⚠️ 对极粗糙场景（如粗略估算）可能过于精确
  - 缓解：提供 LargeEpsilon 选项

**使用指导**:
- 默认情况下使用 DefaultEpsilon (0.0001)
- 物理模拟等高精度场景使用 SmallEpsilon (0.000001)
- UI 显示等低精度场景使用 LargeEpsilon (0.001)
- 特殊场景可以传入自定义 Epsilon 值

#### 参考（References）

- **实现代码**: `verseProject/source/library/logicModules/coreMathUtils/MathFloatComparison.verse`
- **模式记录**: `workUnits/verseLogicLab/knowledge/PATTERNS.md` - Float Comparison with Tolerance
- **验证猜想**: CONJ-003 (已证伪) - 记录在 `knowledge/CONJECTURES.md`
- **行业参考**:
  - Unreal Engine: KINDA_SMALL_NUMBER = 1.e-4f
  - Unity: Mathf.Epsilon = 0.00001f (1.401298E-45f for float comparison)
- **IEEE 754**: 浮点数标准，定义了浮点运算的精度特性

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

## ADR-006: UEFN综合调研计划的组织原则

**日期**: 2026-01-12  
**状态**: Accepted  
**相关文档**: `knowledge/research/uefn-comprehensive-research-plan-20260112.md`

### 上下文（Context）

用户要求生成不少于100个UEFN调研任务清单，用于系统性地建立UEFN/Verse开发的知识体系。需要决定：
1. 如何组织这些任务？
2. 如何确保调研的系统性和完整性？
3. 如何让调研计划可执行？

### 决策（Decision）

创建120个调研任务，按以下原则组织：

**1. 六大部分分类**：
- Part 1: Verse语言核心（25任务） - 类型系统、效果系统、函数式编程
- Part 2: Fortnite API深度解析（30任务） - 游戏对象、游戏机制、UI交互
- Part 3: Creative Devices深度研究（20任务） - 核心设备、专用设备、高级设备
- Part 4: DLSD架构应用研究（15任务） - 四层架构的最佳实践
- Part 5: 性能优化专项（10任务） - 内存、运算、网络优化
- Part 6: 最佳实践与模式（20任务） - 游戏设计、代码质量、开发流程

**2. 四级优先级系统**：
- P0（核心基础，30任务）：必须优先完成，影响所有后续开发
- P1（高频使用，40任务）：日常开发常用，显著提升效率
- P2（专项深化，30任务）：特定领域深入研究
- P3（进阶优化，20任务）：性能优化、高级特性

**3. 四阶段执行策略**：
- 阶段1（Week 1-2）：完成所有P0任务，建立核心知识体系
- 阶段2（Week 3-5）：完成所有P1任务，掌握常用功能
- 阶段3（Week 6-8）：完成所有P2任务，深入特定领域
- 阶段4（Week 9-10）：完成所有P3任务，优化和高级特性

**4. 标准化任务结构**：
每个任务包含：
- 目标：清晰的调研问题
- 信息源：明确的查阅位置
- 覆盖点：具体的研究内容
- 产出：期望的交付物
- 验证方式：如何验证调研质量
- 关联猜想：与CONJECTURES.md的关联

### 理由（Rationale）

**为什么是120个任务？**
- 覆盖所有核心领域（语言、API、设备、架构、性能、实践）
- 粒度适中（既不过于琐碎，也不过于宏大）
- 可执行（10周全职或20周兼职可完成）

**为什么按这六个部分分类？**
- **Part 1（语言核心）**：基础，必须先掌握
- **Part 2（Fortnite API）**：17000+行digest文件，需系统解析
- **Part 3（Devices）**：5000+页文档中的核心工具
- **Part 4（DLSD架构）**：将架构理论应用到UEFN实践
- **Part 5（性能优化）**：专项研究，解决内存和性能问题
- **Part 6（最佳实践）**：综合性知识，提升开发质量

**为什么设置四级优先级？**
- 明确任务重要性，指导资源分配
- P0任务是基础，必须优先完成
- P1-P3可根据项目需求灵活调整

**为什么采用阶段式执行？**
- 避免同时启动所有任务导致的混乱
- 阶段验证确保知识积累质量
- 允许根据阶段反馈调整后续计划

**为什么关联CONJECTURES.md？**
- 明确哪些调研用于验证现有猜想
- 建立知识的可追溯性
- 避免基于未验证的假设开展工作

### 替代方案（Alternatives）

**方案A：按技术栈分类（放弃）**
- 如：Verse专项、UEFN Editor专项、Blueprint专项
- 问题：无法体现任务的优先级和执行顺序
- 问题：缺乏对DLSD架构的关注

**方案B：按开发流程分类（放弃）**
- 如：需求分析、设计、实现、测试、部署
- 问题：调研任务不完全对应开发流程
- 问题：难以体现知识的层次性

**方案C：按难度分级（放弃）**
- 如：初级、中级、高级
- 问题：难度是主观的，难以统一标准
- 问题：不利于系统性学习

**方案D：无组织的任务列表（放弃）**
- 优点：简单直接
- 问题：无法指导执行顺序
- 问题：难以评估完整性

### 后果（Consequences）

**积极影响**：
- ✅ 系统性：覆盖UEFN开发的所有核心领域
- ✅ 可执行：优先级和阶段明确，可立即开始执行
- ✅ 可验证：每个任务都有明确的产出和验证方式
- ✅ 可追溯：与CONJECTURES.md和SOURCES.md关联
- ✅ 可扩展：未来可添加新任务或调整优先级

**执行要求**：
- ⚠️ 每个任务必须产出调研报告（存入`knowledge/research/`）
- ⚠️ 至少更新一个知识资产（ADR/Patterns/Lessons）
- ⚠️ 交叉引用信息源（更新SOURCES.md）
- ⚠️ 标记相关猜想（更新CONJECTURES.md）

**长期维护**：
- 定期评估任务完成情况（更新improvement-backlog.md）
- 根据实际需求调整优先级
- 识别新的知识缺口，添加新任务

**知识沉淀流程**：
```
执行RESEARCH-XXX 
    → 产出调研报告 
    → 更新知识资产（ADR/Patterns/Lessons） 
    → 标记knowledge-gaps.md为已完成
    → 更新improvement-backlog.md状态
```

### 参考（References）

- `knowledge/research/uefn-comprehensive-research-plan-20260112.md` - 完整调研计划
- `knowledge/improvement-backlog.md` - R-001任务及120个子任务
- `knowledge/knowledge-gaps.md` - 识别的知识缺口
- `verseProject/digests/` - API Digest文件（17,028行）
- `external/epic-docs-crawler/uefn_docs_organized/` - UEFN文档（5,071+页）
- `UEFN_Roadmap_2025.md` - 功能发展路线图

---

## ADR-007: Range Validation 设计决策

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `validationUtils/RangeValidation.verse`

### 上下文（Context）

需要为逻辑模块提供标准的参数验证机制。在实现 TASK-081（Range Validation）时，需要决定：
1. 验证函数应该返回 bool 还是使用 `<decides>` 效果？
2. 是否需要同时支持 int 和 float？
3. 浮点数验证是否需要容差？
4. 如何与现有的 MathFloatComparison 协调？

### 决策（Decision）

采用以下设计：
1. **使用 `<decides><transacts>:void` 签名**：验证失败时自动触发 rollback
2. **同时提供 int 和 float 版本**：满足不同类型的验证需求
3. **float 验证使用 epsilon 容差**：与 MathFloatComparison 保持一致
4. **统一命名约定**：`Validate*` 前缀，清晰表达验证意图

### 理由（Rationale）

#### 1. 为什么使用 `<decides>` 而非返回 bool？

**方案对比**:

```verse
# 方案 A: 返回 bool
IsInRange<public>(Value:int, Min:int, Max:int)<computes>:logic =
    if (Value >= Min):
        if (Value <= Max):
            true
        else:
            false
    else:
        false

# 使用时需要手动检查
if (IsInRange(Value, 0, 100) = true):
    DoSomething()
else:
    # 手动错误处理
    Print("Invalid value")

# 方案 B: 使用 <decides>
ValidateInRange<public>(Value:int, Min:int, Max:int)<decides><transacts>:void =
    Value >= Min
    Value <= Max

# 使用时自动失败回滚
ValidateInRange[Value, 0, 100]
DoSomething()  # 仅在验证通过后执行
```

**选择方案 B 的理由**:
- ✅ **Fail-Fast**: 验证失败立即停止，不需要手动检查返回值
- ✅ **事务性**: `<transacts>` 确保失败时自动回滚
- ✅ **简洁性**: 调用代码更简洁，无需 if-else 包裹
- ✅ **一致性**: 与现有验证函数（CheckEmpty, CheckAlive）保持一致
- ✅ **可组合性**: 多个验证可以顺序调用，任一失败即回滚

#### 2. 为什么同时支持 int 和 float？

- **int 验证**：不需要容差，精确比较
  - 数组索引、计数器、ID 等场景
  - 性能更好（无浮点运算）

- **float 验证**：需要容差，避免精度问题
  - 百分比、角度、物理参数等场景
  - 与 MathFloatComparison 一致

#### 3. 为什么 float 使用 epsilon = 0.0001？

**与 MathFloatComparison 保持一致**:
- ✅ 已有的 ADR-001 详细说明了 epsilon 选择理由
- ✅ 0.0001 适用于大多数游戏逻辑场景
- ✅ 提供灵活性：可选参数允许自定义 epsilon

**示例**:
```verse
# 默认 epsilon (0.0001)
ValidatePercent[Value]  # 检查 0.0 <= Value <= 1.0

# 自定义 epsilon（高精度场景）
ValidatePercent[Value, ?Epsilon := 0.000001]
```

#### 4. 为什么采用 `Validate*` 命名约定？

**对比其他命名方案**:

| 方案 | 示例 | 优点 | 缺点 |
|------|------|------|------|
| `Check*` | CheckInRange | 简短 | 与查询混淆（如 CheckEmpty 是查询） |
| `Is*` | IsInRange | 符合布尔函数习惯 | 暗示返回 bool，与 `<decides>` 不符 |
| `Assert*` | AssertInRange | 明确表达断言语义 | 在某些语言中有特殊含义（调试用） |
| **`Validate*`** | **ValidateInRange** | **清晰表达验证意图** | **稍长** |

**选择 `Validate*` 的理由**:
- ✅ 明确表达"验证"而非"查询"
- ✅ 与现有函数区分（Check* 用于查询，Validate* 用于验证）
- ✅ 行业标准（许多语言和框架使用 Validate 表示验证）

### 替代方案（Alternatives）

**方案 A: 仅提供 bool 返回值函数**
- 优点：灵活，用户可以自行处理错误
- 缺点：需要手动检查，容易遗漏，代码冗长
- **未选择理由**: Verse 的 `<decides>` 机制更优雅

**方案 B: 仅提供 float 版本，int 自动转换**
- 优点：减少代码重复
- 缺点：性能损失，类型不明确
- **未选择理由**: int 和 float 有不同的验证语义（精确 vs 容差）

**方案 C: 使用 option[T] 返回值**
- 优点：可以返回详细的错误信息
- 缺点：调用代码复杂，需要解包 option
- **未选择理由**: 验证不需要返回详细信息，失败即可

### 后果（Consequences）

**积极影响**:
- ✅ 统一的验证函数接口，易于学习和使用
- ✅ Fail-fast 机制减少错误传播
- ✅ 与现有代码风格一致
- ✅ 浮点数验证避免了精度陷阱
- ✅ 为所有逻辑模块提供了标准的参数验证工具

**使用指南**:
```verse
using { RangeValidation }

# 函数入口验证参数
CalculatePercent<public>(Current:int, Total:int)<transacts>:float =
    # 验证参数有效性
    RangeValidation.ValidatePositive[Total]      # Total 必须 > 0
    RangeValidation.ValidateNonNegative[Current]  # Current 必须 >= 0
    
    # 参数已验证，安全计算
    Result := (Current * 1.0) / (Total * 1.0)
    Result

# 组合多个验证
ProcessValue<public>(Value:float)<transacts>:void =
    RangeValidation.ValidatePercent[Value]        # 0 <= Value <= 1
    RangeValidation.ValidateFloatNonZero[Value]   # Value != 0
    # Value 在 (0, 1] 范围内，继续处理
```

**注意事项**:
- ⚠️ 验证会增加函数调用开销，在性能关键路径谨慎使用
- ⚠️ 过度验证会使代码冗长，仅验证真正的前置条件
- ⚠️ 验证失败会触发 rollback，确保调用方在 failure context 中

### 参考（References）

- **实现代码**: `validationUtils/RangeValidation.verse`
- **模式记录**: `PATTERNS.md` - Validation Function Pattern
- **相关 ADR**: ADR-001 (Float Epsilon 选择)
- **效果系统**: CONJ-002 (已验证) - `<decides>` 与 `<transacts>` 的关系
- **现有验证函数**:
  - `UtilArrays.verse` - CheckEmpty, CheckValidIndex
  - `RpgHealth.verse` - CheckAlive, CheckFullHealth
  - `MathProbability.verse` - CheckProbability

---


