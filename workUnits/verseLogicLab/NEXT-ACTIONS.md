# 下一步行动清单
# Next Actions

> **快速决策指南**: 现在应该做什么？  
> **详细分析**: 见 `knowledge/TASK-SELECTION-GUIDE.md`

---

## 🎯 立即可执行的前 3 个任务

### 1️⃣ TASK-003: 浮点数比较与容差 ⭐⭐⭐ (推荐首选)

```
价值评分: 9/10
估计时间: 1-2天
前置依赖: 无
```

**为什么现在做**:
- ✅ 零依赖，立即可开始
- ✅ 验证已证伪的 CONJ-003
- ✅ 为所有后续数学任务提供基础
- ✅ 简单明确，快速见效

**执行命令**:
```bash
# 开始任务
echo "Starting TASK-003: Float Comparison"
cd /home/runner/work/vibe-coding-cn/vibe-coding-cn

# Phase -1: 审查猜想
cat workUnits/verseLogicLab/knowledge/CONJECTURES.md | grep "CONJ-003"

# Phase 0: 检查知识资产
cat workUnits/verseLogicLab/knowledge/PATTERNS.md | grep -i "float"
cat workUnits/verseLogicLab/knowledge/DECISION_RECORDS.md | grep -i "float"

# Phase 1: 开始实现
# 创建文件: verseProject/source/library/logicModules/coreMathUtils/MathFloatComparison.verse
```

**预期产出**:
- ✅ NearlyEqual, NearlyZero, NearlyGreater, NearlyLess 函数
- ✅ 验证并更新 CONJ-003 状态
- ✅ 记录到 PATTERNS.md: "浮点数安全比较模式"
- ✅ 创建 ADR: "Epsilon 选择决策"

---

### 2️⃣ TASK-001: 安全数学运算库 ⭐⭐⭐

```
价值评分: 9/10
估计时间: 2-3天
前置依赖: 建议先完成 TASK-003
```

**为什么第二做**:
- ✅ 依赖 TASK-003 的浮点比较
- ✅ 验证 CONJ-002 (效果系统)
- ✅ 为所有数学计算提供安全保障
- ✅ 深度学习 `<decides>` 效果

**预期产出**:
- ✅ SafeAdd, SafeSubtract, SafeMultiply, SafeDivide, SafePower
- ✅ 验证 CONJ-002 关于效果系统的理解
- ✅ 记录到 COMPILATION_LESSONS.json: 数值边界处理
- ✅ 创建 ADR: "安全数学运算的错误处理策略"

---

### 3️⃣ TASK-023: 数组查询 ⭐⭐

```
价值评分: 8/10
估计时间: 2天
前置依赖: RESEARCH-003 已完成 (option[T] 研究)
```

**为什么第三做**:
- ✅ 验证 4 个 option 相关猜想 (CONJ-004-007)
- ✅ 实践 RESEARCH-003 的研究成果
- ✅ 为后续集合操作提供基础
- ✅ option[T] 使用的最佳实践案例

**预期产出**:
- ✅ Contains, IndexOf, LastIndexOf, FindAll, Count, Any, All
- ✅ 验证 CONJ-004, 005, 006, 007
- ✅ 记录到 PATTERNS.md: "option[T] 使用模式"
- ✅ 更新 SOURCES.md: 引用调研报告

---

## 📅 Week 1 执行计划

### Day 1-2: TASK-003 (Float Comparison)
- [ ] Phase -1: 审查 CONJ-003
- [ ] Phase 0: 检查现有知识资产
- [ ] Phase 1: Socratic 思考
- [ ] Phase 2: 实现 + 编译验证
- [ ] Phase 3: 知识沉淀 (强制)

### Day 3-4: TASK-001 (SafeMath)
- [ ] Phase -1: 审查 CONJ-002
- [ ] Phase 0: 检查数值边界知识
- [ ] Phase 1: 深度思考安全策略
- [ ] Phase 2: 实现 + 编译验证
- [ ] Phase 3: 知识沉淀 (强制)

### Day 5: 前置调研
- [ ] RESEARCH-XXX: Verse 高阶函数支持
  - 调研 Verse 是否支持函数作为参数
  - 如何传递函数（如果支持）
  - 替代方案设计（如果不支持）
- [ ] 更新 knowledge-gaps.md
- [ ] 创建调研报告

### Day 6-7: TASK-023 (Array Queries)
- [ ] Phase -1: 审查 CONJ-004-007
- [ ] Phase 0: 复习 RESEARCH-003
- [ ] Phase 1: 思考 option[T] 使用策略
- [ ] Phase 2: 实现 + 编译验证
- [ ] Phase 3: 验证猜想 + 知识沉淀

---

## ⚡ 快速决策树

```
现在有时间吗？
│
├─ 是 → 有多少时间？
│      │
│      ├─ 1-2 小时 → 做调研或知识整理
│      │            • 阅读 CONJECTURES.md
│      │            • 整理 PATTERNS.md
│      │            • 更新 improvement-backlog.md
│      │
│      ├─ 半天 (4小时) → 开始 TASK-003
│      │                • 轻量、快速见效
│      │
│      └─ 1-2 天 → 完整执行 TASK-003 + TASK-001
│
└─ 否 → 等有时间再开始
       • 不要匆忙开始任务
       • 质量 > 速度
```

---

## 🚨 执行检查清单

### 开始任务前 (必须检查)

- [ ] ✅ 阅读了 `CHECKLISTS.md`
- [ ] ✅ 阅读了 `CONJECTURES.md` 相关猜想
- [ ] ✅ 检查了 `PATTERNS.md` 和 `DECISION_RECORDS.md`
- [ ] ✅ 确认 UEFN 编辑器已打开（用于编译验证）
- [ ] ✅ 确认 `verseProject/analyze.sh` 可用

### 完成任务后 (强制执行)

- [ ] ✅ 编译验证通过 (0 错误)
- [ ] ✅ 至少更新了 2 个知识资产
- [ ] ✅ 验证或更新了相关猜想
- [ ] ✅ 记录了信息来源
- [ ] ✅ 提交代码并推送

---

## 📊 本周目标

### 量化目标

- ✅ 完成 3 个 P0 任务
- ✅ 完成 1 个前置调研
- ✅ 验证 5+ 个猜想
- ✅ 新增 3+ ADR
- ✅ 新增 5+ Pattern
- ✅ 所有任务编译通过

### 知识增长目标

- ✅ 深入理解浮点数精度处理
- ✅ 掌握安全数学运算模式
- ✅ 熟练使用 option[T] 类型
- ✅ 理解 Verse 效果系统
- ✅ 建立验证函数标准模式

---

## 🎓 学习重点

### 本周应该深入理解的概念

1. **浮点数精度** (TASK-003)
   - 为什么不能直接用 `==` 比较浮点数
   - Epsilon 的选择标准
   - 不同场景下的精度要求

2. **错误处理策略** (TASK-001)
   - `<decides>` 效果的正确使用
   - 何时返回 option[T]
   - 何时直接失败

3. **option[T] 类型** (TASK-023)
   - `?` 操作符的行为
   - failure context 的理解
   - `false` 作为空值的语义

---

## 🔗 相关文档

- **详细分析**: `knowledge/TASK-SELECTION-GUIDE.md`
- **任务计划**: `knowledge/logic-module-development-plan-phase1.md`
- **任务索引**: `knowledge/TASK-QUICKREF.md`
- **检查清单**: `CHECKLISTS.md`
- **猜想库**: `knowledge/CONJECTURES.md`

---

## 💡 记住

- **质量优先**: 宁可少做，不可做错
- **知识沉淀**: 每个任务必须有收获
- **持续学习**: 每个任务都是学习机会
- **诚实面对**: 不确定时查文档，不猜测

---

**更新日期**: 2026-01-13  
**下次评估**: Week 1 结束后 (2026-01-20)

---

**准备好了吗？开始 TASK-003! 🚀**
