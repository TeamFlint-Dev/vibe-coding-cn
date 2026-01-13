# Vector3 类型研究报告
# Vector3 Type Research Report

> **调研日期**: 2026-01-13  
> **调研人**: Verse Logic Lab  
> **触发原因**: 用户反馈 @stallsping - RISK-003 关于 vector3 分量访问的假设不正确  
> **优先级**: 高（直接影响已实现的 MathGeometry3d 模块）

---

## 📋 执行摘要

**核心发现**: Verse 中存在 **两个** vector3 类型，分别支持不同的分量访问方式。

| 类型 | 命名空间 | 分量访问 | 稳定性 |
|------|---------|---------|--------|
| **Verse vector3** | `/Verse.org/SpatialMath` | `.Forward`, `.Left`, `.Up` | ✅ 稳定 (官方) |
| **UE vector3** | `/UnrealEngine.com/Temporary/SpatialMath` | `.X`, `.Y`, `.Z` | ⚠️ Temporary (临时API) |

**结论**: **RISK-003 假设错误** - vector3 确实支持分量访问，只是我们使用了错误的访问方式。

---

## 🔍 详细调研

### 1. Verse.org vector3 (官方稳定版)

**来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/vector3>

**定义**:
```verse
using { /Verse.org/SpatialMath }

vector3 struct:
    Forward : float  # 前方 (原 X)
    Left    : float  # 左侧 (原 -Y)
    Up      : float  # 向上 (原 Z)
```

**访问方式**:
```verse
MyVector : vector3 = vector3{Forward=1.0, Left=0.0, Up=0.0}
ForwardComponent := MyVector.Forward
LeftComponent := MyVector.Left
UpComponent := MyVector.Up
```

**命名约定**:
- `Forward` = 前方方向 (传统的 X 轴)
- `Left` = 左侧方向 (传统的 -Y 轴，注意负号)
- `Up` = 向上方向 (传统的 Z 轴)

**官方说明**: 使用语义化命名而非传统的 X/Y/Z，更符合游戏开发的直觉。

---

### 2. UnrealEngine vector3 (临时API)

**来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/vector3>

**定义**:
```verse
using { /UnrealEngine.com/Temporary/SpatialMath }

vector3 struct:
    X : float
    Y : float
    Z : float
```

**访问方式**:
```verse
MyVector : vector3 = vector3{X=1.0, Y=0.0, Z=0.0}
XComponent := MyVector.X
YComponent := MyVector.Y
ZComponent := MyVector.Z
```

**⚠️ 注意**: 此 API 位于 `/Temporary/` 命名空间，表示不稳定，可能在未来版本中变更。

**实际使用示例** (来自官方教程):
```verse
# 来源: verse-starter-01-creating-the-npc-behavior-in-unreal-editor-for-fortnite
X := NewTransform.Translation.X + Direction.X * TileDistance.X
Y := NewTransform.Translation.Y + Direction.Y * TileDistance.Y
Z := NewTransform.Translation.Z
set NewTransform.Translation.Z += 20.0
```

---

## ✅ 验证结果

### RISK-003 状态更新

**原始风险记录**:
> #### RISK-003: vector3 不暴露分量访问
> - **风险等级**: 🟡 中危
> - **状态**: ⚠️ 已知限制
> - **描述**: vector3 类型不提供 .X, .Y, .Z 成员访问

**验证结果**: ❌ **假设错误**

**正确理解**:
1. ✅ vector3 **确实暴露分量访问**
2. ✅ 官方 Verse vector3 使用 `.Forward`, `.Left`, `.Up`
3. ✅ UE Temporary vector3 使用 `.X`, `.Y`, `.Z`
4. ❌ 我们之前假设"不提供分量访问"是错误的

---

## 🎯 影响分析

### 对现有代码的影响

**已实现的模块**:
- ✅ `MathGeometry2d.verse` - 使用 tuple，不受影响
- ✅ `MathGeometry3d.verse` - **使用 tuple，需要重新评估**
- ✅ `UtilStrings.verse` - 不涉及 vector3

**MathGeometry3d 重构选项**:

| 选项 | 描述 | 优点 | 缺点 |
|------|------|------|------|
| **A. 保持 tuple** | 继续使用 tuple(float, float, float) | - 已实现<br>- 无需返工<br>- 独立于 Verse API 变化 | - 与原生 vector3 不兼容<br>- 需要手动转换 |
| **B. 迁移到 Verse vector3** | 使用 `/Verse.org/SpatialMath/vector3` | - 官方稳定 API<br>- 语义化命名<br>- 与 Verse 生态兼容 | - 需要重构代码<br>- 命名不同 (Forward/Left/Up vs X/Y/Z) |
| **C. 迁移到 UE vector3** | 使用 `/UnrealEngine.com/Temporary/SpatialMath/vector3` | - 传统 X/Y/Z 命名<br>- 与教程示例一致 | - API 不稳定 (Temporary)<br>- 可能未来变更 |
| **D. 混合方案** | 保留 tuple，提供与 vector3 的转换函数 | - 灵活性最高<br>- 兼容两种使用场景 | - 增加复杂度<br>- 需要维护转换逻辑 |

---

## 📊 推荐方案

### 短期行动 (立即执行)

1. **更新 RISK-003 状态**
   - 标记为 ✅ **已解决 / 假设错误**
   - 添加正确的 vector3 使用说明
   - 交叉引用本研究报告

2. **更新 CONJECTURES.md**
   - 如果存在相关猜想，标记为 ❌ Disproven
   - 记录正确的 vector3 API 信息

3. **创建知识资产**
   - 添加 "Vector3 API 使用指南" 到 PATTERNS.md
   - 记录两种 vector3 的差异和选择标准

### 中期决策 (需要讨论)

**关于 MathGeometry3d 的处理**:

**推荐**: **选项 A - 保持 tuple** (短期) + **选项 D - 添加转换函数** (长期)

**理由**:
1. **ADR-011 决策仍然有效**: 在 Logic Layer 使用轻量级 tuple 是合理的
2. **避免不必要的返工**: 已实现的代码编译通过，功能正确
3. **提供灵活性**: 添加 `ToVector3()` 和 `FromVector3()` 转换函数
4. **渐进式改进**: 不破坏现有代码，增量添加功能

**实施计划**:
```verse
# 阶段 1: 保持现有 tuple 定义
Point3D := tuple(float, float, float)

# 阶段 2: 添加转换函数 (新增)
ToVerseVector3<public>(P:Point3D)<computes>:vector3 =
    vector3{Forward=P(0), Left=P(1), Up=P(2)}

FromVerseVector3<public>(V:vector3)<computes>:Point3D =
    (V.Forward, V.Left, V.Up)
```

### 长期策略

**研究任务队列**:
- [ ] **RESEARCH-NEW**: Verse vs UE vector3 性能对比
- [ ] **RESEARCH-NEW**: vector3 在 UEFN 中的最佳实践
- [ ] **RESEARCH-NEW**: SpatialMath API 完整功能调研

**决策记录**:
- [ ] **ADR-012**: 是否在 Logic Layer 使用原生 vector3 (待评估)

---

## 📚 信息源

### 一级源 (官方文档)

1. **Verse.org vector3 定义**
   - 路径: `external/epic-docs-crawler/uefn_docs_organized/API/verse-api/versedotorg/spatialmath/vector3/index.md`
   - URL: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/spatialmath/vector3>
   - 可靠性: ⭐⭐⭐⭐⭐ (官方稳定 API)

2. **UnrealEngine vector3 定义**
   - 路径: `external/epic-docs-crawler/uefn_docs_organized/API/verse-api/unrealenginedotcom/temporary/spatialmath/vector3/index.md`
   - URL: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/vector3>
   - 可靠性: ⭐⭐⭐ (Temporary API，不稳定)

3. **官方教程示例**
   - 路径: `external/epic-docs-crawler/uefn_docs_organized/Tutorials/Starter-Templates/verse-starter-01-creating-the-npc-behavior-in-unreal-editor-for-fortnite/index.md`
   - 可靠性: ⭐⭐⭐⭐ (官方教程)
   - 示例代码: 使用 UE vector3 (.X, .Y, .Z)

### 验证方法

- [x] 查阅官方 API 文档
- [x] 对比两个命名空间的 vector3 定义
- [x] 检查官方教程中的实际使用示例
- [ ] **待验证**: 在实际 Verse 代码中测试分量访问
- [ ] **待验证**: 编译测试两种 vector3 的互操作性

---

## 🎓 关键学习

### 错误根源分析

**为什么产生 RISK-003 错误假设？**

1. **信息不完整**: 可能只查看了部分文档，未全面搜索
2. **假设传统命名**: 预期使用 .X/.Y/.Z，未考虑 Verse 可能使用语义化命名
3. **未验证就记录**: 将未验证的推测直接记录为"已知限制"
4. **缺少源头追溯**: RISK-003 未引用具体的信息源或验证尝试

### 改进措施

**流程改进**:
1. ✅ **强制源头验证**: 任何"限制"必须有官方文档或编译错误佐证
2. ✅ **区分猜想和事实**: 不确定的信息放入 CONJECTURES.md，不是 RISK-POINTS.md
3. ✅ **定期审查风险**: 每月审查 RISK-POINTS，验证是否仍然有效
4. ✅ **标注置信度**: 风险记录应标注信息来源和置信度

**知识管理改进**:
- 在 RISK-POINTS.md 中添加 "信息来源" 字段
- 要求所有风险必须引用具体文档或错误信息
- 建立 "风险验证检查清单"

---

## ✅ 行动项

### 立即执行

- [x] 完成 vector3 研究报告
- [ ] 更新 RISK-003 状态为"已解决/假设错误"
- [ ] 在 CONJECTURES.md 添加相关验证记录
- [ ] 添加 Vector3 使用模式到 PATTERNS.md
- [ ] 更新 SOURCES.md 添加 vector3 API 文档引用

### 后续任务

- [ ] 评估是否需要重构 MathGeometry3d
- [ ] 创建 vector3 转换函数（如果选择混合方案）
- [ ] 编写 vector3 使用示例和测试
- [ ] 更新 ADR-011 添加 vector3 vs tuple 的讨论

---

## 📝 结论

**RISK-003 是一个错误的假设**，基于不完整的信息。Verse **确实支持** vector3 分量访问，只是使用了不同的命名约定。

**关键教训**: 
- ❌ 不要基于假设记录"已知限制"
- ✅ 始终查阅官方文档验证
- ✅ 区分"猜想"和"已验证的事实"
- ✅ 保持开放心态，准备推翻自己的假设

**下一步**: 更新知识资产，确保所有相关文档反映正确的 vector3 理解。

---

**报告状态**: ✅ 完成  
**审核人**: 待用户确认  
**相关文档**: RISK-POINTS.md, CONJECTURES.md, ADR-011, PATTERNS.md
