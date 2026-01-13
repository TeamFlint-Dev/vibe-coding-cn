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

### ADR-013: vector3 类型选择决策

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `logicModules/validationUtils/VectorValidation.verse`

#### 上下文（Context）

在实现 TASK-084 (Vector Validation) 时，发现 Verse 提供了**两种** vector3 类型：

1. **Verse.org vector3** (`/Verse.org/SpatialMath`)
   - 使用语义化分量名：`.Forward`, `.Left`, `.Up`
   - 标记为官方稳定 API
   
2. **UnrealEngine vector3** (`/UnrealEngine.com/Temporary/SpatialMath`)
   - 使用传统分量名：`.X`, `.Y`, `.Z`
   - 标记为 Temporary API（临时 API）

需要选择一种类型作为 Logic Layer 的标准，确保模块间的一致性。

#### 决策（Decision）

**选择 `/Verse.org/SpatialMath/vector3`**（语义化命名版本）作为 Logic Layer 的标准 vector3 类型。

所有新的逻辑模块应使用此类型，除非有特殊原因需要使用 UE Temporary 版本。

#### 理由（Rationale）

**为什么选择 Verse.org vector3？**

1. **稳定性保证**
   - ✅ 官方稳定 API，不在 Temporary 命名空间下
   - ✅ 长期支持，不会在未来版本中突然变更
   - ⚠️ UE Temporary API 可能在未来版本中废弃或修改

2. **语义清晰性**
   - ✅ `.Forward`, `.Left`, `.Up` 更符合游戏开发的语义
   - ✅ 避免了 X/Y/Z 轴向的歧义（不同引擎有不同的轴向定义）
   - ✅ 代码可读性更强：`Velocity.Forward` vs `Velocity.X`

3. **Verse 生态一致性**
   - ✅ 与 Verse 官方示例和最佳实践保持一致
   - ✅ 未来 Verse API 更新更可能兼容此类型

**缺点和权衡**：

- ❌ 与传统 3D 数学库（使用 X/Y/Z）的习惯不同
- ❌ 从其他引擎迁移代码时需要转换命名
- ⚠️ 需要团队成员适应新的命名约定

**缓解措施**：

- 在文档中明确说明 Forward/Left/Up 与 X/Y/Z 的对应关系
- 如需与 UE Temporary API 互操作，提供转换函数

#### 替代方案（Alternatives Considered）

**方案 A: 使用 UE Temporary vector3**
- ✅ 优点：传统 X/Y/Z 命名，易于理解
- ❌ 缺点：API 不稳定，未来可能变更
- **未选择理由**：稳定性风险过高

**方案 B: 使用 tuple(float, float, float)**
- ✅ 优点：完全独立于 Verse API，最大灵活性
- ❌ 缺点：失去类型安全，无法使用 extension methods（如 .Length()）
- **未选择理由**：ADR-011 已在 MathGeometry3d 中使用 tuple，但那是为了轻量级设计。验证函数需要与原生 vector3 配合

**方案 C: 混合方案（同时支持两种）**
- ✅ 优点：最大兼容性
- ❌ 缺点：增加复杂度，需要维护转换逻辑
- **未选择理由**：过度设计，Logic Layer 应选择单一标准

#### 后果（Consequences）

**正面影响**：
- ✅ Logic Layer 所有模块使用统一的 vector3 类型
- ✅ 代码可读性和语义清晰度提升
- ✅ 未来升级 Verse 版本时风险更低

**负面影响**：
- ⚠️ 团队需要学习新的命名约定（Forward/Left/Up）
- ⚠️ 与 UE Temporary API 互操作时需要注意类型转换

**适用范围**：
- ✅ **应用于**：所有 Logic Layer 模块（logicModules/）
- ⚠️ **不强制**：Driver/Session 层（可能需要直接对接 UE API）

#### 实施指南

**新模块开发**：
```verse
# ✅ 推荐：使用 Verse.org vector3
using { /Verse.org/SpatialMath }

MyFunction<public>(Direction:vector3)<computes>:logic =
    ForwardComponent := Direction.Forward
    LeftComponent := Direction.Left
    UpComponent := Direction.Up
    # ...
```

**轴向对应关系**：
| Verse.org | 传统 | 含义 |
|-----------|------|------|
| `.Forward` | `.X` | 前方方向 |
| `.Left` | `-Y` | 左侧方向（注意负号） |
| `.Up` | `.Z` | 向上方向 |

**转换函数（如需要）**：
```verse
# 未来可在 conversionUtils 中提供
VerseToUEVector(V:Verse_vector3):UE_vector3
UEToVerseVector(V:UE_vector3):Verse_vector3
```

#### 参考（References）

- **研究报告**: `knowledge/research/vector3-research-20260113.md`
- **官方文档**: 
  - Verse.org vector3: `external/epic-docs-crawler/.../versedotorg/spatialmath/vector3/`
  - UE Temporary vector3: `external/epic-docs-crawler/.../temporary/spatialmath/vector3/`
- **相关猜想**: CONJ-004 (已证伪) - 记录在 `knowledge/CONJECTURES.md`
- **实现示例**: `validationUtils/VectorValidation.verse`
- **相关 ADR**: ADR-011 (MathGeometry3d 使用 tuple 的决策)

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

## ADR-008: 禁止递归，强制使用迭代循环

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: 所有 logicModules

### 上下文（Context）

在早期开发中，部分模块（如 `MathRanges.verse` 的 `NormalizeAngle360`）使用了递归来实现迭代逻辑。递归方法存在以下问题：

1. **堆栈溢出风险**: 深度递归可能导致堆栈溢出，尤其是输入值极端时
2. **难以预测**: 递归深度取决于输入值，无法提前预知执行深度
3. **调试困难**: 递归调用链难以追踪和调试
4. **性能开销**: 每次递归调用都有函数调用开销
5. **不够直观**: 递归逻辑对于维护者来说理解成本较高

### 决策（Decision）

**全面禁止使用递归，所有迭代逻辑必须使用 for 循环实现。**

具体要求：
1. ✅ **使用 for 循环** + var 实现所有迭代逻辑
2. ✅ **设置最大迭代次数**，防止无限循环
3. ✅ **使用 `<transacts>` 或 `<allocates>` 效果**支持 var
4. ❌ **禁止函数自调用**（递归）
5. ❌ **禁止互相递归**（函数 A 调用 B，B 调用 A）

### 理由（Rationale）

#### 为什么禁止递归？

**安全性问题**:
```verse
# ❌ 危险：递归可能导致堆栈溢出
NormalizeAngle360<public>(Angle:float)<computes>:float =
    if (Angle < 0.0):
        NormalizeAngle360(Angle + 360.0)  # 如果 Angle = -1e10，会递归数百万次
    else:
        Angle
```

**可预测性问题**:
- 递归深度取决于输入，无法保证不会崩溃
- 极端输入（如 -1e10 度）会导致深度递归

**维护性问题**:
- 递归逻辑需要更多心智负担理解
- 调试时难以追踪调用栈
- 性能分析困难

#### 为什么使用 for 循环？

**安全性保证**:
```verse
# ✅ 安全：固定最大迭代次数，不会堆栈溢出
NormalizeAngle360<public>(Angle:float)<transacts>:float =
    if (Angle < 0.0):
        var Result:float = Angle
        for (I := 0..100):  # 最多100次，绝对安全
            if (Result < 0.0):
                set Result = Result + 360.0
        Result
    else:
        Angle
```

**可预测性**:
- 固定的最大迭代次数，执行时间可预测
- 不会因输入极端而无限执行
- 易于性能分析和优化

**易维护性**:
- 逻辑清晰直观
- 调试简单（可以单步执行每次迭代）
- 性能可控

### 替代方案（Alternatives）

**方案 A: 保留递归，添加深度限制**
- 优点：代码简洁
- 缺点：仍有堆栈溢出风险，深度限制难以选择
- **未选择理由**: 风险仍然存在

**方案 B: 使用尾递归优化**
- 优点：编译器可能优化为循环
- 缺点：依赖编译器优化，不可控
- **未选择理由**: Verse 编译器是否支持尾递归优化未知

**方案 C: 仅在特定场景使用递归**
- 优点：灵活
- 缺点：规则不一致，难以执行
- **未选择理由**: 全面禁止更简单明确

### 后果（Consequences）

**积极影响**:
- ✅ 消除堆栈溢出风险
- ✅ 执行时间可预测
- ✅ 代码更易理解和维护
- ✅ 调试更简单
- ✅ 性能可控

**需要注意**:
- ⚠️ 需要使用 `<transacts>` 或 `<allocates>` 效果（不能使用纯 `<computes>`）
- ⚠️ 需要合理设置最大迭代次数
- ⚠️ 某些算法（如树遍历）可能需要转换为迭代形式

**迁移指南**:
```verse
# 从递归转换为迭代的标准模式

# 旧代码（递归）
OldRecursive<public>(Value:float)<computes>:float =
    if (Condition):
        Value
    else:
        OldRecursive(Transform(Value))

# 新代码（迭代）
NewIterative<public>(Value:float, MaxIterations:int)<transacts>:float =
    var Result:float = Value
    for (I := 0..MaxIterations - 1):
        if (not Condition):
            set Result = Transform(Result)
    Result
```

**执行要求**:
- 所有新代码必须使用迭代循环
- 现有递归代码必须重构为迭代
- Code Review 时严格检查，发现递归立即拒绝

### 参考（References）

- **重构示例**: `MathRanges.verse` - NormalizeAngle360 从递归改为迭代
- **模式文档**: `PATTERNS.md` - Iterative Loop Pattern (section 2.4)
- **编译验证**: 重构后编译通过，0错误

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



## ADR-009: 角度归一化使用模运算而非迭代

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `logicModules/coreMathUtils/MathRanges.verse`

### 上下文（Context）

在 ADR-008 禁止递归后，`NormalizeAngle360` 最初使用迭代循环实现：

```verse
# 旧实现：迭代方式
var Result:float = Angle
for (I := 0..100):
    if (Result < 0.0):
        set Result = Result + 360.0
Result
```

**问题**：
1. **性能**：极端输入（如 ±36000°）需要 100 次迭代
2. **精度**：达到迭代上限时结果不精确
3. **代码复杂度**：需要两个分支（正数/负数）和循环变量

**用户反馈**（@stallsping）：为什么不使用取余（模运算）？

### 决策（Decision）

**改用数学模运算公式**：`Result = Angle - Floor(Angle / 360.0) * 360.0`

```verse
# 新实现：模运算方式
if (FloorValue := Floor[Angle / 360.0]):
    Remainder := Angle - (FloorValue * 1.0) * 360.0
    # 处理浮点误差
    if (Remainder < 0.0):
        Remainder + 360.0
    else if (Remainder >= 360.0):
        Remainder - 360.0
    else:
        Remainder
else:
    0.0  # Floor 失败时的安全值
```

### 理由（Rationale）

#### 为什么使用模运算？

**性能优势**：
- ✅ O(1) 时间复杂度（vs 迭代的 O(n)）
- ✅ 极端输入（±1e10°）：1 次计算 vs 100 次迭代
- ✅ 常见输入（±720°）：1 次计算 vs 1-2 次迭代

**精度优势**：
- ✅ 数学上精确（无迭代上限）
- ✅ 处理任意大小的角度值
- ✅ 仅受浮点数精度限制，而非人为迭代限制

**代码简洁性**：
- ✅ 单一数学公式，逻辑清晰
- ✅ 无需循环变量和上限判断
- ✅ 更易理解和维护

#### 为什么 Verse 没有内置 float mod？

**Verse API 限制**：
- ❌ `Mod` 函数仅支持 `int`，不支持 `float`
- ✅ 可使用 `Floor` 函数模拟：`x mod y = x - Floor(x/y) * y`

**效果系统考虑**：
- ⚠️ `Floor` 有 `<decides>` 效果（可能失败，如 NaN/Infinity）
- ✅ 必须在 if 表达式中调用以处理失败情况
- ✅ 失败时返回安全值 0.0（合理的默认角度）

#### 迭代 vs 模运算对比

| 维度 | 迭代方式 | 模运算方式 |
|------|---------|-----------|
| **时间复杂度** | O(n)，最坏 100 次 | O(1)，固定 1 次 |
| **精度** | 受限于迭代上限 | 数学上精确 |
| **极端输入** | ±36000° 达上限 | 任意大小均可 |
| **代码行数** | ~15 行（2 分支） | ~10 行（1 公式） |
| **可读性** | 需理解循环逻辑 | 直观的数学公式 |
| **安全性** | ⚠️ 需设置上限防止无限循环 | ✅ 天然有界 |

### 替代方案（Alternatives）

**方案 A: 保留迭代方式**
- 优点：无需 `Floor` 的 `<decides>` 效果处理
- 缺点：性能差、精度有限、代码复杂
- **未选择理由**：性能和精度问题明显

**方案 B: 使用查表（Lookup Table）**
- 优点：无浮点运算
- 缺点：仅适用于整数角度，无法处理任意 float
- **未选择理由**：不适用于连续值

**方案 C: 创建 Angle 类封装**（用户建议）
- 优点：类型安全、语义清晰、可封装更多操作
- 缺点：
  - ❌ **Verse 限制**：类在模块中难以使用（需要实例化）
  - ❌ **性能开销**：对象创建和内存分配
  - ❌ **复杂度**：简单的角度归一化不值得引入类
  - ❌ **互操作性**：与现有 float 角度参数不兼容
- **未选择理由**：过度设计，成本大于收益
- **未来考虑**：如果需要复杂的角度运算（如四元数、欧拉角转换），可重新评估

### 后果（Consequences）

**积极影响**：
- ✅ **性能提升**：极端输入快 100 倍
- ✅ **精度提升**：无上限限制
- ✅ **代码简化**：更少的行数和分支
- ✅ **维护性**：数学公式易于理解

**需要注意**：
- ⚠️ **Floor 失败处理**：NaN/Infinity 输入返回 0.0
- ⚠️ **效果组合**：`<transacts>` 效果包含 `<decides>`
- ⚠️ **浮点误差**：仍需边界检查（< 0 或 >= 360）

**性能对比（估算）**：
```
输入: -36000°
迭代方式: 100 次循环 * ~10 ns = 1000 ns
模运算方式: 1 次除法 + 1 次乘法 + 1 次减法 ~= 30 ns
加速比: ~33x
```

### 关于 Angle 类的进一步讨论

#### 为什么不创建 Angle 类？

**Verse 语言限制**：
```verse
# ❌ 问题：模块中的类难以作为参数类型
MathRanges := module:
    Angle := class:
        Degrees:float
    
    # ❌ 其他模块难以使用这个类型
    RotateBy<public>(A:Angle):void = ...  # 需要显式实例化
```

**设计哲学**：
- ✅ **Logic Layer 应为纯函数**：无状态、可组合
- ✅ **类适合 Session Layer**：有状态、生命周期管理
- ❌ **类不适合基础数学运算**：开销大、互操作性差

**何时考虑引入类**：
- ✅ 复杂的数学对象（如矩阵、四元数）
- ✅ 需要封装多个相关操作和状态
- ✅ 在 Session 或 Component 层使用（非 Logic Layer）

**当前方案（primitive obsession 是可接受的）**：
- ✅ `float` 表示角度：简单、高效、通用
- ✅ 函数提供语义：`NormalizeAngle360(Degrees:float)`
- ✅ 注释说明单位：`@param Degrees: 角度值（度）`

### 参考（References）

- **相关决策**: ADR-008 (禁止递归)
- **用户反馈**: @stallsping comment #3743798239
- **模式文档**: PATTERNS.md - Iterative Loop Pattern
- **Verse API**: `Floor` 函数文档
- **性能分析**: RISK-006 (迭代次数限制)

---

## ADR-010: 何时使用类封装数值类型

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: 未来的数值封装库

### 上下文（Context）

在 ADR-009 中讨论了为何角度不使用类封装，理由是：
- 简单的角度归一化不值得引入类
- Logic Layer 应使用纯函数
- 与现有 float 参数兼容性

**用户反馈**（@stallsping）：
> "当用户的钱变成几十个亿的时候，你不能无脑增加字段长度去记录，而是应该考虑使用类定义，封装这些定义。不过这些类定义内容都放到一起，方便管理。"

**核心问题**：
1. **何时原始类型不够用？** float/int 在某些场景下有明显局限
2. **何时应该使用类？** 需要清晰的判断标准
3. **如何组织类定义？** 避免散落各处，集中管理

### 决策（Decision）

**建立数值类型封装的判断标准**，并创建集中的类型定义库。

#### 判断标准：何时使用类封装？

**使用类封装的场景**（满足以下任一条件）：

1. **数值范围超出原始类型**
   - ✅ 货币：几十亿、万亿级别（float 精度不足）
   - ✅ 大整数：超过 int 范围（需要 BigInteger）
   - ✅ 高精度计算：科学计算、金融计算

2. **需要复杂的语义约束**
   - ✅ 货币：不能为负、需要货币单位、汇率转换
   - ✅ 百分比：0-100% 或 0-1 范围约束
   - ✅ 时间：年月日时分秒组合、时区处理

3. **需要附加元数据**
   - ✅ 带单位的数值：温度（°C/°F）、距离（m/km/ft）
   - ✅ 精度要求：小数位数、舍入规则
   - ✅ 验证规则：最小值、最大值、有效性检查

4. **需要封装多个操作**
   - ✅ 货币：加减乘除、格式化、解析
   - ✅ 时间：加减、比较、格式化
   - ✅ 复数：算术运算、三角函数

**不使用类的场景**（继续用 float/int）：

1. **简单数值运算**
   - ✅ 角度归一化（ADR-009 已说明）
   - ✅ 简单的范围检查
   - ✅ 临时计算结果

2. **性能关键路径**
   - ✅ 每帧执行的物理计算
   - ✅ 大量数组元素的遍历
   - ✅ GPU 相关的向量运算

3. **与外部 API 交互**
   - ✅ UEFN API 要求 float/int 参数
   - ✅ 需要与现有代码兼容

#### 类型定义的组织结构

**创建集中的类型库**（未来实现）：

```
verseProject/source/library/
├── logicModules/
│   └── ... (现有逻辑模块)
└── types/  # 新增：集中的类型定义
    ├── numeric/
    │   ├── Currency.verse        # 货币类
    │   ├── BigInteger.verse       # 大整数类
    │   ├── Percentage.verse       # 百分比类
    │   └── FixedPoint.verse       # 定点数类
    ├── temporal/
    │   ├── Duration.verse         # 时长类
    │   ├── Timestamp.verse        # 时间戳类
    │   └── Calendar.verse         # 日历类
    └── physical/
        ├── Temperature.verse      # 温度类
        ├── Distance.verse         # 距离类
        └── Mass.verse             # 质量类
```

**组织原则**：
- ✅ **按领域分类**：numeric, temporal, physical 等
- ✅ **一个文件一个类**：便于维护和查找
- ✅ **清晰的命名**：类名即用途（Currency, BigInteger）
- ✅ **集中管理**：统一在 types/ 目录下

### 理由（Rationale）

#### 为什么需要类封装大数值？

**以货币为例**：

**问题 1: float 精度不足**
```verse
# ❌ 问题：float 只有 ~7 位有效数字
Money:float = 9876543210.0  # 实际存储可能是 9876543000.0
Loss:float = 9876543210.0 - Money  # 210.0 丢失！
```

**问题 2: 无法表达语义**
```verse
# ❌ 问题：负数货币没有意义，但 float 允许
PlayerMoney:float = -100.0  # 编译通过，但逻辑错误
```

**问题 3: 缺少操作封装**
```verse
# ❌ 问题：格式化、验证需要分散的工具函数
FormattedMoney := FormatCurrency(Money)  # 函数散落各处
ValidateCurrency[Money]  # 验证也是独立函数
```

**解决方案：Currency 类**
```verse
Currency := class:
    # 使用 int 存储分（避免浮点精度问题）
    AmountInCents:int  # 1亿元 = 100_0000_0000 分
    
    # 构造函数验证
    New(Cents:int)<transacts>:Currency =
        if (Cents < 0):
            # 拒绝负数
            fail
        Currency{AmountInCents := Cents}
    
    # 封装操作
    Add<public>(Other:Currency)<computes>:Currency =
        Currency{AmountInCents := AmountInCents + Other.AmountInCents}
    
    Format<public>()<computes>:string =
        # 格式化为 "¥1,234,567.89"
        # ...实现略
```

**优势**：
- ✅ **精度保证**：用 int 存储分，支持万亿级别
- ✅ **类型安全**：编译时检查，不能与普通 int 混用
- ✅ **语义清晰**：`Currency` 比 `float` 更明确
- ✅ **操作封装**：加减、格式化、验证都在类内部

#### 为什么集中管理类定义？

**分散管理的问题**：
```verse
# ❌ 问题：类定义散落在业务模块中
gameLogic/ShopSystem.verse:
    Currency := class:
        ...

gameLogic/InventorySystem.verse:
    Money := class:  # 重复定义！
        ...
```

**集中管理的好处**：
```verse
# ✅ 解决：统一在 types/ 目录
types/numeric/Currency.verse:
    Currency := class:
        ...

# 业务模块只需引用
using { /VibeCodingCN/library/types/numeric/Currency }

ShopSystem := module:
    BuyItem(Price:Currency)<transacts>:void =
        # 使用统一的 Currency 类
```

**优势**：
- ✅ **避免重复**：一个类型只定义一次
- ✅ **易于查找**：所有类型在 types/ 目录下
- ✅ **版本一致**：所有模块使用相同版本的类
- ✅ **便于维护**：修改类定义只需更新一处

#### 何时实现类型库？

**分阶段实现**：

**Phase 1（当前）**：
- ✅ 使用原始类型 + 工具函数（Logic Layer）
- ✅ 简单场景无需引入类（如角度归一化）
- ✅ 记录 ADR-010 作为未来指导

**Phase 2（需求驱动）**：
- ⏰ 遇到实际需求时才实现（如真的需要处理亿级货币）
- ⏰ 创建 types/ 目录和第一个类型（如 Currency）
- ⏰ 在 Session/Component 层使用（非 Logic Layer）

**Phase 3（库完善）**：
- ⏰ 根据使用情况扩展类型库
- ⏰ 添加更多领域的类型（temporal, physical）
- ⏰ 建立类型使用的最佳实践

**现阶段不实现的原因**：
- ❌ **YAGNI 原则**：目前没有实际需求（You Aren't Gonna Need It）
- ❌ **避免过度设计**：Logic Layer 当前任务只需纯函数
- ✅ **保持聚焦**：先完成 P0 任务，再扩展类型系统

### 示例：Currency 类设计草案

**未来实现参考**（存档备用）：

```verse
# verseProject/source/library/types/numeric/Currency.verse

Currency := class:
    # 私有字段：存储分（1元 = 100分）
    # 使用 int 支持 ±21亿分 = ±2100万元（如需更大，用数组模拟 BigInt）
    var AmountInCents:int
    
    # 构造函数：从元创建
    FromYuan<public>(Yuan:float)<decides><transacts>:Currency =
        Cents := Floor[Yuan * 100.0]
        if (CentsInt := Cents):
            if (CentsInt >= 0):
                Currency{AmountInCents := CentsInt}
            else:
                # 拒绝负数货币
                fail
        else:
            # Floor 失败（NaN/Infinity）
            fail
    
    # 算术运算
    Add<public>(Other:Currency)<computes>:Currency =
        Currency{AmountInCents := AmountInCents + Other.AmountInCents}
    
    Subtract<public>(Other:Currency)<decides><computes>:Currency =
        NewAmount := AmountInCents - Other.AmountInCents
        if (NewAmount >= 0):
            Currency{AmountInCents := NewAmount}
        else:
            # 余额不足
            fail
    
    # 格式化
    Format<public>()<computes>:string =
        Yuan := AmountInCents / 100
        Cents := AmountInCents mod 100
        # 返回 "¥1,234.56"
        "¥{Yuan}.{Cents}"
    
    # 比较
    IsGreaterThan<public>(Other:Currency)<computes>:logic =
        AmountInCents > Other.AmountInCents
```

**使用示例**：
```verse
# 在 Session 层使用
PlayerSession := class:
    var Money:Currency = Currency{AmountInCents := 0}
    
    AddMoney<public>(Amount:Currency)<transacts>:void =
        set Money = Money.Add(Amount)
    
    Buy<public>(Price:Currency)<transacts>:void =
        if (NewMoney := Money.Subtract(Price)):
            set Money = NewMoney
        else:
            # 余额不足，购买失败
            Print("余额不足！")
```

### 替代方案（Alternatives）

**方案 A: 继续使用 float/int + 工具函数**
- 优点：简单、性能好
- 缺点：缺少类型安全、语义不清晰、操作分散
- **适用场景**：简单数值运算（当前使用）

**方案 B: 使用 tuple 封装**
```verse
Currency := tuple(int, string)  # (金额, 货币代码)
```
- 优点：轻量级
- 缺点：无法封装方法、类型不安全（任何 tuple 都能传入）
- **未选择理由**：不如类强大

**方案 C: 每个模块定义自己的类**
- 优点：灵活
- 缺点：重复定义、版本不一致、难以维护
- **未选择理由**：违反 DRY 原则

**方案 D: 使用第三方库**
- 优点：成熟、经过测试
- 缺点：Verse 生态尚未成熟，暂无可用库
- **未选择理由**：不可行

### 后果（Consequences）

**积极影响**：
- ✅ **明确标准**：何时用类、何时用原始类型
- ✅ **集中管理**：未来类型库有清晰的组织结构
- ✅ **避免过度设计**：按需实现，不提前优化
- ✅ **指导未来工作**：遇到相关需求时有章可循

**需要注意**：
- ⚠️ **暂不实现**：当前无实际需求，避免 YAGNI
- ⚠️ **性能权衡**：类有开销，性能关键路径慎用
- ⚠️ **兼容性**：类与 UEFN API 的 float/int 参数可能需要转换

**未来行动**：
- 📝 记录到 improvement-backlog.md 作为未来任务
- 📝 遇到大数值需求时，启动 types/ 库实现
- 📝 在 RISK-POINTS.md 中标注原始类型的精度风险

### 参考（References）

- **相关决策**: ADR-009 (为何角度不用类)
- **用户反馈**: @stallsping comment #3743808637
- **设计原则**: YAGNI, DRY, SOLID
- **架构层次**: DLSD 架构 - Session Layer 使用类
- **性能考虑**: RISK-007 (浮点精度问题)

---

### ADR-014: 时间表示和单位选择决策

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `logicModules/validationUtils/TimeValidation.verse`

#### 上下文（Context）

在实现 TASK-085 (Time Validation) 时，需要确定如何表示时间和持续时间：
1. **类型选择**：int（整数毫秒）vs float（浮点秒）
2. **单位选择**：秒、毫秒、还是其他单位
3. **时间戳起点**：从 0 开始还是使用 Unix 时间戳
4. **持续时间语义**：是否允许负值

这些决策影响所有时间相关的逻辑模块和游戏系统。

#### 决策（Decision）

**选择 `float` 类型表示时间，单位为秒，时间戳从 0.0 开始（游戏开始时刻）。**

具体规则：
- **时间戳（Timestamp）**: `float` 类型，单位秒，范围 [0.0, MaxReasonableTimestamp]
- **持续时间（Duration）**: `float` 类型，单位秒，范围 [0.0, +∞)
- **时间戳起点**: 0.0 表示游戏开始时刻
- **持续时间语义**: 0.0 表示瞬间/无持续时间，负值非法
- **浮点精度**: 使用 Epsilon (0.0001) 处理浮点比较

#### 理由（Rationale）

**为什么选择 float（浮点秒）？**

1. **Verse 生态一致性**
   - ✅ Verse/UEFN API 普遍使用 float 表示时间（秒）
   - ✅ GetSimulationElapsedTime() 返回 float
   - ✅ Delay() 函数接受 float 参数
   - ✅ 与引擎和设备 API 直接兼容，无需转换

2. **精度与范围平衡**
   - ✅ float 精度对游戏时间足够（误差 < 0.0001 秒，人类无法感知）
   - ✅ 范围足够大：可表示数小时的游戏时长
   - ✅ 0.0001 秒精度 = 0.1 毫秒，对大多数游戏机制已足够

3. **使用便利性**
   - ✅ 直接表达时间概念：1.5 秒 vs 1500 毫秒
   - ✅ 浮点运算更自然：速度 * 时间 = 距离
   - ✅ 无需频繁的单位转换

**为什么时间戳从 0.0 开始？**

1. **游戏时间 vs 真实时间**
   - ✅ 游戏时间从游戏开始计算，0.0 是自然起点
   - ✅ 无需处理 Unix 时间戳（1970-01-01）的大数值
   - ✅ 简化调试（时间戳 = 游戏运行时长）

2. **数值稳定性**
   - ✅ 避免大数值运算的精度损失
   - ✅ 时间差计算更简单：Duration = EndTime - StartTime

**为什么持续时间不允许负值？**

1. **语义清晰性**
   - ✅ 持续时间是"时长"概念，负值无物理意义
   - ✅ 0.0 表示瞬间/无持续时间（合法）
   - ✅ 负值通常是逻辑错误，应该立即失败

2. **防御性编程**
   - ✅ 尽早发现时间计算错误
   - ✅ 避免负持续时间导致的隐蔽 bug

#### 替代方案（Alternatives Considered）

**方案 A: 使用 int 表示毫秒**
```verse
Timestamp:int  # 毫秒，如 1500 表示 1.5 秒
```
- ✅ 优点：避免浮点精度问题，整数运算更快
- ❌ 缺点：与 Verse API 不兼容（需要频繁转换），表达不自然
- **未选择理由**：与 Verse 生态脱节，转换开销大于浮点精度问题

**方案 B: 使用 int 表示帧数**
```verse
Timestamp:int  # 帧数，如 60 表示 1 秒（假设 60 FPS）
```
- ✅ 优点：精确，无浮点误差
- ❌ 缺点：帧率可变时失效，难以理解和调试
- **未选择理由**：帧率非固定，游戏时间应与帧率解耦

**方案 C: 使用 Unix 时间戳（秒自 1970-01-01）**
```verse
Timestamp:float  # Unix 时间戳，如 1705147200.0
```
- ✅ 优点：与真实世界时间对应，跨系统通用
- ❌ 缺点：大数值精度损失，游戏内不需要真实时钟
- **未选择理由**：游戏使用相对时间，不需要绝对时钟

#### 后果（Consequences）

**正面影响**：
- ✅ 与 Verse/UEFN API 无缝集成，无需类型转换
- ✅ 代码可读性强：`Cooldown := 5.0` 比 `Cooldown := 5000` 更直观
- ✅ 浮点精度对游戏逻辑完全够用（误差小于人类感知）
- ✅ 时间计算简单：直接加减乘除

**负面影响**：
- ⚠️ 浮点精度问题：需要使用 Epsilon 进行比较
- ⚠️ 极长时间可能累积误差（但游戏通常不会运行数天）

**缓解措施**：
- 所有时间比较使用 Epsilon 容差（DefaultEpsilon = 0.0001）
- 设置合理的最大时间戳（MaxReasonableTimestamp = 100000 秒 ≈ 27.7 小时）
- 文档中明确说明浮点精度限制

#### 实施指南

**标准用法**：
```verse
# ✅ 推荐：使用 float 秒
Timestamp:float = 10.5  # 10.5 秒
Duration:float = 5.0    # 5 秒持续时间

# ❌ 不推荐：使用 int 毫秒
Timestamp:int = 10500  # 需要额外转换，不兼容 API
```

**时间验证**：
```verse
using { validationUtils.TimeValidation }

# 验证时间戳有效性
TimeValidation.ValidateTimestamp[EventTime]

# 验证持续时间
TimeValidation.ValidateDuration[CooldownTime]

# 时间比较（使用 Epsilon）
if (TimeValidation.IsFuture(EventTime, CurrentTime)):
    # 事件尚未发生
```

**常见时间值**：
| 描述 | 值（秒） | 说明 |
|------|---------|------|
| 瞬间 | 0.0 | 无持续时间 |
| 1 帧（60 FPS） | 0.0167 | 约 16.7 毫秒 |
| 半秒 | 0.5 | 常用于短冷却 |
| 1 秒 | 1.0 | 标准计时单位 |
| 1 分钟 | 60.0 | 长冷却、buff 时长 |
| 1 小时 | 3600.0 | 超长 buff、每日重置 |

**Epsilon 选择**：
- **DefaultEpsilon = 0.0001** - 通用时间比较（0.1 毫秒容差）
- 对于大多数游戏机制，0.1 毫秒误差完全可接受
- 如需更精确，可传入自定义 Epsilon

#### 参考（References）

- **Verse API**: GetSimulationElapsedTime() 返回 float 秒
- **实现代码**: `validationUtils/TimeValidation.verse`
- **相关 ADR**: ADR-001 (浮点数比较 Epsilon 选择)
- **相关模式**: PATTERNS.md - 时间验证模式（待添加）
- **IEEE 754**: 浮点数标准，定义 float 精度约 7 位有效数字

---

## ADR-011: 2D 几何类型使用 Tuple 而非 Struct

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `logicModules/coreMathUtils/MathGeometry2d.verse`

### 上下文（Context）

在实现 MathGeometry2d 模块时，需要定义 2D 几何类型（点、矩形、圆形）。有两种主要选择：

1. **使用 Tuple**：
   ```verse
   Point2D := tuple(float, float)  # (X, Y)
   Rect2D := tuple(Point2D, Point2D)  # (MinPoint, MaxPoint)
   ```

2. **使用 Struct**：
   ```verse
   Point2D := struct{X:float, Y:float}
   Rect2D := struct{MinPoint:Point2D, MaxPoint:Point2D}
   ```

设计约束：
- 这些类型用于 Logic Layer（无状态纯函数）
- 需要高性能（UI 和游戏循环中频繁使用）
- 需要简洁（开发者频繁创建和传递）
- 无需复杂的行为或方法

### 决策（Decision）

**选择使用 Tuple 定义 2D 几何类型**，理由如下：

```verse
# 数据类型定义
Point2D<public> := tuple(float, float)  # (X, Y)
Rect2D<public> := tuple(Point2D, Point2D)  # (MinPoint, MaxPoint)
Circle2D<public> := tuple(Point2D, float)  # (Center, Radius)
```

**访问方式**：使用索引访问 `P(0)` 和 `P(1)`

### 理由（Rationale）

**为什么选择 Tuple？**

1. **简洁性**：
   - 创建更简洁：`(100.0, 200.0)` vs `Point2D{X=100.0, Y=200.0}`
   - 无需显式构造函数
   - 适合 Logic Layer 的轻量级数据

2. **性能**：
   - Tuple 是 Verse 的原生类型，可能有优化
   - 无分配开销（stack-based value type）
   - 适合高频率操作（UI 每帧更新）

3. **模式一致性**：
   - 与 DLSD 架构一致：Logic Layer 使用简单类型，Session Layer 使用类
   - 参考 ADR-010：角度也使用 float 而非类

4. **功能充分性**：
   - 2D 点只需存储 X, Y 坐标，无需方法
   - 所有操作都是纯函数，定义在模块层级
   - 不需要状态或行为（如果需要，应在 Session Layer）

**Tuple 索引的权衡**：

- ✅ 优点：访问速度快（编译时索引）
- ⚠️ 缺点：`P(0)` 和 `P(1)` 不如 `P.X` 和 `P.Y` 直观
- ✅ 缓解：通过清晰的注释说明（如 `# (X, Y)`）

**替代方案及为何未选择**：

1. **Struct**：
   - ❌ 过于重量级，Logic Layer 不需要
   - ❌ 创建语法冗长
   - ✅ 但字段访问更直观（`P.X` vs `P(0)`）

2. **命名 Tuple**（如果 Verse 支持）：
   - ✅ 最佳方案：兼具简洁和可读性
   - ❌ Verse 目前可能不支持（未在文档中找到）

3. **直接使用 float 对**：
   - ❌ 无类型安全，容易混淆参数顺序
   - ❌ 不如 `Point2D` 类型语义清晰

### 后果（Consequences）

**积极影响**：
- ✅ 代码简洁：几何操作的调用代码更短
- ✅ 性能优化：避免了不必要的抽象开销
- ✅ 架构一致：符合 DLSD 分层原则

**负面影响**：
- ⚠️ 可读性略低：`P(0)` 不如 `P.X` 直观
- ⚠️ 维护成本：需要在注释中明确索引含义

**缓解措施**：
- 在类型定义处添加清晰注释：`Point2D := tuple(float, float)  # (X, Y)`
- 在函数中使用有意义的变量名：
  ```verse
  PX := Point(0)  # X 坐标
  PY := Point(1)  # Y 坐标
  ```
- 考虑未来添加辅助函数（如 `GetX(P:Point2D):float`）提升可读性

**使用建议**：
- 仅在 Logic Layer 使用 Tuple 类型
- 如果需要复杂行为或状态，迁移到 Session Layer 使用 class
- 3D 几何类型（MathGeometry3d）应遵循相同模式

### 参考（References）

- **相关决策**: ADR-010 (为何货币不立即实现类)
- **相关模式**: Tuple Indexing Pattern (PATTERNS.md)
- **相关模块**: `MathGeometry2d.verse`
- **性能考虑**: Logic Layer 轻量级设计原则

---

## ADR-011: 安全数学运算的错误处理策略

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `logicModules/coreMathUtils/MathSafe.verse`

### 上下文（Context）

在实现安全数学运算库（TASK-001）时，需要选择合适的错误处理策略来应对以下运算错误：

1. **整数溢出**：Verse 中整数溢出会导致 runtime error（官方文档明确说明）
2. **除零错误**：除数为零会导致运行时崩溃
3. **浮点数溢出**：结果超出范围会产生 Infinity 或 NaN

关键约束：
- Verse 是64位有符号整数，范围 `[-2^63, 2^63-1]`
- 整数溢出**不会**环绕（wrap-around），而是产生运行时错误
- 必须在运算**之前**检测潜在溢出，而非运算后检查结果

### 决策（Decision）

**选择使用 `<transacts><decides>` 效果进行 fail-fast 错误处理。**

所有安全数学函数采用统一签名：
```verse
SafeOperation<public>(A:type, B:type)<transacts><decides>:type
```

- **成功时**：返回计算结果
- **失败时**：触发 rollback，调用者的 transaction 失败

### 理由（Rationale）

#### 为什么选择 `<decides>` 而非 `option[T]`？

**方案 A: `<decides>` 效果（已选择）**
```verse
SafeAddInt<public>(A:int, B:int)<transacts><decides>:int
使用：Result := SafeAddInt[A, B]  # 失败时自动 rollback
```

**优点**:
1. ✅ **自动错误传播**：调用者无需显式检查，失败会自动向上传播
2. ✅ **事务语义**：错误会回滚整个计算流程，避免部分执行
3. ✅ **简洁使用**：调用代码不需要 `or` 或 `if` 判断
4. ✅ **符合 Verse 习惯**：Verse 推荐使用 `<decides>` 处理可能失败的操作
5. ✅ **强制错误处理**：必须在 failure context 中调用，强制调用者考虑失败场景

**缺点**:
- ⚠️ 不够灵活：无法提供默认值降级
- ⚠️ 必须用方括号调用（不是缺点，而是安全特性）

**方案 B: 返回 `option[T]`（未选择）**
```verse
SafeAddInt<public>(A:int, B:int)<computes>:option[int]
使用：Result := SafeAddInt(A, B) or DefaultValue
```

**优点**:
- ✅ 灵活降级：调用者可以选择默认值
- ✅ 显式错误处理：调用者明确知道操作可能失败

**缺点**:
- ❌ **容易被忽略**：调用者可能忘记检查 option，导致隐藏的 bug
- ❌ **代码冗长**：每次调用都需要 `or` 或 `if` 判断
- ❌ **部分执行风险**：不会自动回滚，可能导致不一致状态

#### 为什么需要 `<transacts>` 配合 `<decides>`？

根据 CONJ-002（已验证）和官方文档：
- `<decides>` **必须**配合 `<transacts>` 使用
- Verse 编译器强制要求：`<decides>` 函数必须同时标注 `<transacts>`
- 原因：rollback 机制需要 transaction 上下文

#### 溢出检测策略

**整数加法溢出检测**：
```verse
# 两个正数相加，检查 A + B > MaxSafeInt
# 避免计算 A + B（会溢出），改用 A > MaxSafeInt - B
if (A > 0 and B > 0):
    if (A > MaxSafeInt - B):
        false  # 会溢出
```

**整数乘法溢出检测**：
```verse
# 检查 |A| * |B| > MaxSafeInt
# 避免计算乘积，改用 |A| > MaxSafeInt / |B|
# 使用 Quotient[] 进行整数除法
Threshold := Quotient[MaxSafeInt, AbsB]
if (AbsA > Threshold):
    false  # 会溢出
```

**关键**：
- ✅ 溢出检测在运算**之前**进行
- ✅ 检测逻辑本身不会溢出（使用数学等价变换）
- ✅ 使用 `Quotient[]` 而非 `/` 运算符（int/int 返回 rational）

### 替代方案（Alternatives）

**方案 C: 混合策略（未选择）**
```verse
# Fail-fast 版本
SafeAddInt<public>(A:int, B:int)<transacts><decides>:int

# Option 版本
SafeAddIntOr<public>(A:int, B:int, Default:int)<computes>:int
```

**未选择理由**：
- 增加 API 复杂度，调用者需要选择使用哪个版本
- 容易混淆，不如统一使用 `<decides>` + `or` 语法
- 调用者可以使用 `SafeAddInt[A, B] or Default` 实现降级

**方案 D: 不检查溢出，依赖 Verse 运行时（未选择）**

**未选择理由**：
- ❌ 运行时错误会导致整个游戏崩溃
- ❌ 难以调试和恢复
- ❌ 违背"安全"数学的初衷

### 后果（Consequences）

**积极影响**：
- ✅ **防止运行时崩溃**：所有潜在溢出都在编译时和运行时被捕获
- ✅ **强制错误处理**：调用者必须考虑失败场景
- ✅ **事务一致性**：错误不会导致部分状态修改
- ✅ **API 简洁**：统一的函数签名，易于理解和使用

**负面影响**：
- ⚠️ **性能开销**：每次运算前都需要检查（但比崩溃好得多）
  - 缓解：检查逻辑简单，开销可接受
- ⚠️ **不够灵活**：无法直接提供默认值降级
  - 缓解：调用者可以使用 `Result := SafeOp[A, B] or Default`

**使用指导**：

```verse
# 1. 基本使用（失败时自动 rollback）
Result := SafeAddInt[A, B]

# 2. 提供默认值（失败时降级）
Result := SafeAddInt[A, B] or 0

# 3. 在 if 条件中使用（成功才执行）
if (SafeValue := SafeMultiplyInt[A, B]):
    Print("Result: {SafeValue}")

# 4. 级联运算（任何一步失败都会 rollback）
Result := SafeAddInt[SafeMultiplyInt[A, B], C]
```

**性能考虑**：
- 溢出检查开销：约 2-5 条额外指令
- 相比运行时崩溃，开销微不足道
- 对性能极端敏感的场景，可以使用原生运算符（需确保输入安全）

**已知限制**：
- `SafePowerInt` 限制指数最大为 100（防止过长计算）
- 浮点数溢出检测使用保守边界 (1.0e+30)，不是精确的 float 最大值

### 参考（References）

- **官方文档**: `external/epic-docs-crawler/uefn_docs_organized/Verse-Language/int-in-verse/index.md`
  - "整数运算溢出会导致 runtime error"
- **已验证猜想**: CONJ-002 - Verse 效果系统层次关系
  - `<decides>` 必须配合 `<transacts>` 使用
- **研究报告**: RESEARCH-006 - 数值类型转换与精度
  - `Quotient[]` 用于整数除法
- **实现代码**: `verseProject/source/library/logicModules/coreMathUtils/MathSafe.verse`
- **相关模式**: `knowledge/PATTERNS.md` - Safe Math Operations Pattern
- **相关风险**: `knowledge/RISK-POINTS.md` - RISK-007 (浮点精度问题)

---

**总结**：采用 `<transacts><decides>` 效果的 fail-fast 策略，既保证了运行时安全，又提供了 Verse 习惯的优雅错误处理。通过提前检测溢出，避免了运行时崩溃，同时保持了 API 的简洁性和一致性。

## ADR-012: 不实现通用高阶函数，采用专用函数模式

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `logicModules/collectionsUtils/ArrayTransforms.verse` (计划)

### 上下文（Context）

在规划 TASK-022 (Array Filtering/Mapping) 时，需要决定如何实现函数式的数组操作。理想的实现是通用的高阶函数：

```verse
# 理想但不可行的实现
Filter<public>(Arr:[]t, Predicate:(t)->logic)<computes>:[]t
Map<public>(Arr:[]t, Transform:(t)->u)<computes>:[]u
Reduce<public>(Arr:[]t, Accumulator:(t, t)->t, Initial:t)<computes>:t
```

然而，经过调研（详见 RESEARCH-007），发现：
- ❌ Verse 不支持将函数作为参数传递（高阶函数）
- ❌ Verse 没有 lambda 表达式或匿名函数
- ❌ 无法使用泛型的 `type` 参数表示函数类型

这导致无法实现标准的函数式编程模式。

### 决策（Decision）

**采用"专用函数 + 内联表达式"模式，放弃通用高阶函数**

具体方案：
1. 为常见操作提供专用函数（如 `FilterPositive`, `MapSquare`）
2. 在文档中指导用户使用内联 for 表达式处理自定义条件
3. 不尝试模拟高阶函数（如使用 enum 表示操作类型）

### 理由（Rationale）

#### 为什么选择专用函数模式？

**方案 A: 专用函数模式（已选择）**
```verse
FilterPositiveInt<public>(Arr:[]int)<computes>:[]int =
    for (Element : Arr, Element > 0):
        Element

FilterGreaterThanInt<public>(Arr:[]int, Threshold:int)<computes>:[]int =
    for (Element : Arr, Element > Threshold):
        Element
```

**优点**:
1. ✅ **符合语言能力**：完全在 Verse 支持范围内
2. ✅ **性能最优**：无间接调用开销，编译器可内联优化
3. ✅ **类型安全**：编译时完全检查，无运行时错误
4. ✅ **代码清晰**：函数名直接表达意图，易于理解
5. ✅ **实用性**：覆盖 80% 的常见场景

**缺点**:
- ⚠️ 代码量较大：每种操作需要一个函数
- ⚠️ 通用性受限：添加新操作需要新函数

**方案 B: Enum 模拟操作类型（未选择）**
```verse
filter_operation := enum:
    Positive
    Even
    GreaterThanZero

FilterWithOperation<public>(Arr:[]int, Op:filter_operation)<transacts>:[]int =
    var Result:[]int = array{}
    for (Element : Arr):
        ShouldInclude := if (Op = filter_operation.Positive):
            Element > 0
        else if (Op = filter_operation.Even):
            Mod[Element, 2] = 0
        else:
            false
        if (ShouldInclude):
            set Result += array{Element}
    Result
```

**未选择理由**:
- ❌ 性能较差：需要运行时分支判断
- ❌ 不够灵活：仍然只支持预定义操作
- ❌ 代码复杂：函数内部需要大量 if-else 分支
- ❌ 类型不安全：编译器无法检查操作的有效性

**方案 C: 仅使用内联 for 表达式（作为补充）**
```verse
# 调用者直接使用
PositiveNumbers := for (Num : Numbers, Num > 0):
    Num
```

**作为补充的理由**:
- ✅ 最简洁
- ✅ Verse 原生支持
- ✅ 完全灵活（任意条件）
- ⚠️ 但不能复用（每次都要写条件）

#### 为什么不尝试其他模拟方案？

其他尝试过的方案：
- ❌ **使用字符串表示函数名**：需要在运行时反射，Verse 不支持
- ❌ **使用类封装函数**：仍然需要多态或接口，Verse 的类系统不支持函数多态
- ❌ **使用宏**：Verse 没有宏系统

#### 实践中如何使用？

**场景 1: 常见操作（使用专用函数）**
```verse
using { ArrayTransforms }

# 过滤正数
PositiveScores := ArrayTransforms.FilterPositiveInt(Scores)

# 映射平方
SquaredValues := ArrayTransforms.MapSquareInt(Values)

# 求和
TotalScore := ArrayTransforms.SumInt(Scores)
```

**场景 2: 自定义条件（使用内联 for）**
```verse
# 自定义过滤条件
HighScores := for (Score : Scores, Score > 1000 and Score < 5000):
    Score

# 自定义映射
AdjustedScores := for (Score : Scores):
    Score * Multiplier + Bonus
```

**场景 3: 复杂操作（组合使用）**
```verse
# 先过滤再映射
FinalScores := ArrayTransforms.MapSquareInt(
    ArrayTransforms.FilterPositiveInt(RawScores)
)
```

### 替代方案（Alternatives）

已在"理由"部分详细说明，未选择的主要原因是性能、复杂度和语言限制。

### 后果（Consequences）

**积极影响**:
- ✅ **性能最优**：直接编译为高效代码，无额外开销
- ✅ **类型安全**：编译时检查所有类型错误
- ✅ **易于维护**：每个函数职责单一，易于理解和测试
- ✅ **符合 Verse 习惯**：不引入非原生的抽象
- ✅ **覆盖常见场景**：20-30 个专用函数可满足 80% 需求

**负面影响**:
- ⚠️ **代码量增加**：估计 ArrayTransforms.verse 会有 500-800 行
  - 缓解：函数模式重复，易于编写和维护
- ⚠️ **通用性受限**：无法在运行时动态选择操作
  - 缓解：通过内联 for 表达式处理特殊情况
- ⚠️ **新操作需要新函数**：扩展性受限
  - 缓解：80% 场景已覆盖，剩余 20% 可用 for 表达式

**使用指导**:
1. **优先使用专用函数**（性能最优，代码清晰）
2. **特殊条件使用 for 表达式**（最灵活）
3. **避免复杂嵌套**（可读性下降）

**设计原则**:
- 每个专用函数做好一件事
- 函数命名清晰表达意图（如 `FilterPositive` 而非 `Filter1`）
- 为常见操作提供专用函数（如 Even, Odd, Positive, Negative）
- 为可配置操作提供参数化函数（如 `FilterGreaterThan(Threshold)`）

### 参考（References）

- **研究报告**: `knowledge/research/verse-higher-order-functions-research-20260113.md`
- **官方文档**: Parametric Types in Verse (证明 type 不能用于函数类型)
- **相关任务**: TASK-022 (Array Filtering/Mapping)
- **实现文件**: `collectionsUtils/ArrayTransforms.verse` (待创建)

---

**总结**：由于 Verse 语言限制，我们选择实用主义的专用函数模式，而非追求理论上完美但无法实现的高阶函数模式。这个决策在性能、可维护性和实用性之间取得了良好平衡。


## ADR-013: 浮点数比较 Epsilon 值选择

**日期**: 2026-01-13  
**状态**: Accepted  
**相关模块**: `logicModules/coreMathUtils/MathFloatComparison.verse`

### 上下文（Context）

在实现 TASK-003 (Float Comparison) 时，需要选择合适的 Epsilon 值用于浮点数比较。由于浮点数的精度限制，直接使用 `==` 比较可能导致错误判断。

关键考虑：
- IEEE 754 单精度浮点数约有7位有效数字
- 游戏逻辑中常见的精度需求
- 不同场景对精度的不同要求

### 决策（Decision）

**选择 0.0001 作为默认 Epsilon 值**

同时提供三个预定义的 Epsilon 常量：
- `DefaultEpsilon: 0.0001` - 默认值，适用于大多数游戏逻辑
- `SmallEpsilon: 0.000001` - 高精度场景
- `LargeEpsilon: 0.001` - 低精度/性能优先场景

### 理由（Rationale）

#### 为什么选择 0.0001？

**实践考虑**:
1. ✅ **覆盖游戏常见场景**：
   - 位置比较（单位：米）- 0.1mm 精度足够
   - 百分比计算（0-100）- 0.01% 精度
   - 角度比较（0-360）- 0.036° 精度
   
2. ✅ **避免常见浮点误差**：
   - 0.1 + 0.2 = 0.30000000000000004 ✅ 在容差内
   - 1.0 / 3.0 * 3.0 ≈ 1.0 ✅ 在容差内

3. ✅ **性能与精度平衡**：
   - 不会过于严格导致误判
   - 不会过于宽松导致错误相等

**与其他值的对比**:

| Epsilon | 适用场景 | 优点 | 缺点 |
|---------|---------|------|------|
| **0.0001** (选择) | 通用游戏逻辑 | 平衡，覆盖80%场景 | 非最精确 |
| 0.00001 | 高精度数值计算 | 更精确 | 可能误判（浮点误差） |
| 0.001 | 性能敏感场景 | 宽松，快速 | 精度较低 |
| 0.01 | UI显示比较 | 符合显示精度 | 对数值计算过于宽松 |

**科学依据**:

IEEE 754 单精度浮点数：
- 有效位数：约 7 位十进制数字
- 机器精度（Machine Epsilon）：约 1.19e-7

选择 0.0001 (1e-4) 的理由：
- 大于机器精度约 1000 倍，避免误判
- 小于实际应用精度需求约 10-100 倍，保证准确性

#### 为什么提供多个 Epsilon？

不同场景有不同需求：

**SmallEpsilon (0.000001) - 高精度场景**:
```verse
# 物理模拟中的精确计算
if (MathFloatComparison.NearlyEqual(Position.X, Target.X, MathFloatComparison.SmallEpsilon)):
    Arrived()
```

**DefaultEpsilon (0.0001) - 通用场景**:
```verse
# 大多数游戏逻辑
if (MathFloatComparison.NearlyEqual(Health, MaxHealth)):
    FullHealth()
```

**LargeEpsilon (0.001) - 性能优先**:
```verse
# UI显示，人类感知极限
if (MathFloatComparison.NearlyEqual(SliderValue, TargetValue, MathFloatComparison.LargeEpsilon)):
    UpdateUI()
```

### 替代方案（Alternatives）

**方案 A: 单一固定 Epsilon（未选择）**
```verse
# 仅提供一个 Epsilon
DefaultEpsilon: 0.0001
```

**未选择理由**:
- ❌ 不够灵活，无法适应不同精度需求
- ❌ 开发者可能自己定义不一致的值

**方案 B: 相对 Epsilon（未选择）**
```verse
# 基于数值大小的相对误差
RelativeEpsilon(A, B, Tolerance) :=
    Threshold := Max(Abs(A), Abs(B)) * Tolerance
    Abs(A - B) <= Threshold
```

**未选择理由**:
- ❌ 复杂度更高
- ❌ 游戏场景多使用绝对误差
- ✅ 但可以作为未来扩展

**方案 C: 可配置全局 Epsilon（未选择）**
```verse
# 运行时可修改的全局变量
var GlobalEpsilon:float = 0.0001
```

**未选择理由**:
- ❌ Verse Logic层避免可变状态
- ❌ 可能导致不一致的比较结果
- ❌ 难以追踪和调试

### 后果（Consequences）

**积极影响**:
- ✅ **标准化**: 整个项目使用一致的精度标准
- ✅ **灵活性**: 三个预定义值覆盖不同场景
- ✅ **可维护性**: 明确的精度定义，易于理解
- ✅ **正确性**: 避免浮点数直接比较的陷阱

**负面影响**:
- ⚠️ **可能过于宽松**: 某些高精度场景可能需要更小的epsilon
  - 缓解：提供 SmallEpsilon 选项
- ⚠️ **可能过于严格**: 某些UI场景可能不需要这么高精度
  - 缓解：提供 LargeEpsilon 选项

**使用指导**:

```verse
# 场景 1: 位置到达判断（默认）
if (MathFloatComparison.NearlyEqual(CurrentPos, TargetPos)):
    ReachedTarget()

# 场景 2: 物理碰撞检测（高精度）
if (MathFloatComparison.NearlyEqual(
    Distance, 
    CollisionThreshold, 
    MathFloatComparison.SmallEpsilon
)):
    OnCollision()

# 场景 3: UI滑块比较（低精度）
if (MathFloatComparison.NearlyEqual(
    SliderValue, 
    Setting, 
    MathFloatComparison.LargeEpsilon
)):
    SettingMatched()

# 场景 4: 自定义精度
if (MathFloatComparison.NearlyEqual(Value1, Value2, 0.5)):
    # 自定义容差
    WithinRange()
```

**边界情况处理**:
- ✅ 零值比较：`NearlyZero(Value)` 专用函数
- ✅ 极大值：Epsilon 相对值仍然合理
- ✅ 极小值：SmallEpsilon 可处理

### 参考（References）

- **IEEE 754**: 浮点数标准
- **游戏开发最佳实践**: Unity, Unreal等引擎的epsilon选择
- **相关模块**: `coreMathUtils/MathFloatComparison.verse`
- **相关决策**: ADR-001 (早期 Epsilon 选择，已被本决策替代)

---

**总结**: 0.0001 作为默认 Epsilon 在游戏开发中是经过验证的最佳实践，同时提供多个预定义值确保了灵活性。这个决策在精度、性能和易用性之间取得了良好平衡。

