# Logic Module Tasks - Quick Reference
# 逻辑模块任务速查表

> **快速定位所需任务**  
> **详细计划**: `logic-module-development-plan-phase1.md`

---

## 📋 按优先级查找

### P0 - 核心基础 (18 tasks) - Week 1-2

| ID | 任务 | 分类 | 文件 |
|----|------|------|------|
| **001** | SafeMath | 数学 | coreMathUtils/MathSafe.verse |
| **002** | Range Mapping | 数学 | coreMathUtils/MathRanges.verse |
| **003** | Float Comparison | 数学 | coreMathUtils/MathFloatComparison.verse |
| **004** | Math Constants | 数学 | coreMathUtils/MathConstants.verse |
| **005** | Bitwise Operations | 数学 | coreMathUtils/MathBitwise.verse |
| **021** | Array Slicing | 集合 | collectionsUtils/ArraySlicing.verse |
| **022** | Array Filtering | 集合 | collectionsUtils/ArrayFunctional.verse |
| **023** | Array Queries | 集合 | collectionsUtils/ArrayQueries.verse |
| **024** | Array Set Ops | 集合 | collectionsUtils/ArraySetOps.verse |
| **025** | Array Aggregation | 集合 | collectionsUtils/ArrayAggregation.verse |
| **081** | Range Validation | 验证 | validationUtils/RangeValidation.verse |
| **082** | String Validation | 验证 | validationUtils/StringValidation.verse |
| **083** | Array Validation | 验证 | validationUtils/ArrayValidation.verse |
| **084** | Vector Validation | 验证 | validationUtils/VectorValidation.verse |
| **085** | Time Validation | 验证 | validationUtils/TimeValidation.verse |

**Phase 1 Milestone**: 基础数学和数组操作就绪

---

### P1 - 高频使用 (45 tasks) - Week 3-6

#### 数学 & 算法 (11 tasks)
- **006-010**: Trigonometry, Statistics, Sequences, Interpolation Advanced, Easing Parametric
- **011-013**: Search, Sorting, Hashing

#### 集合操作 (9 tasks)
- **026-030**: Multi-dim Arrays, Circular Buffer, Priority Queue, Sparse Array, String Arrays
- **031-032**: Key-Value Ops, Tuple Utils

#### 游戏机制 (10 tasks)
- **036-045**: Damage Formulas, Hit Calculation, Combo Logic, Cooldown, Stat Modifiers, Experience, Achievement, Leaderboard, Resource Validation, Price Balancing

#### 物理 & 空间 (5 tasks)
- **051-055**: Geometry 2D/3D Extended, Bounding Box, Distance Metrics, Direction Utils

#### 状态机 & 动画 (5 tasks)
- **071-075**: State Transition, Condition Evaluation, Hierarchical FSM, Animation Blending, Timing

#### 约束 & 规则 (5 tasks)
- **086-090**: Velocity Constraints, Angle Constraints, Resource Caps, Rule Evaluation, Permission Checks

**Phase 2 Milestone**: 日常开发工具完备

---

### P2 - 专项深化 (27 tasks) - Week 7-9

#### 高级数学 (7 tasks)
- **014-017**: Matrix, Quaternion, Noise, Number Theory
- **018-020**: Fast Math, Lookup Tables, Numerical Calculus

#### 专项集合 (3 tasks)
- **033-035**: BitSet, Finite Set, Tree Traversal

#### 游戏机制 (7 tasks)
- **046-050**: Loot Drop, Rarity System, Procedural Gen, Duration Calc, Scheduler Logic

#### 物理 (3 tasks)
- **056-058**: Projectile Motion, Trajectory Prediction, Kinematics

#### AI 决策 & 寻路 (6 tasks)
- **061-066**: Utility System, Threat Assessment, Flocking, Path Smoothing, Grid Navigation, A* Logic

#### 行为模式 (5 tasks)
- **076-080**: Patrol Path, Chase/Flee, Idle Behavior, Trigger Conditions, Event Priority

#### 编码 & 压缩 (5 tasks)
- **096-099**: Base64, URL Encoding, JSON Helpers, RLE, Delta Encoding

**Phase 3 Milestone**: 专业领域能力增强

---

### P3 - 进阶优化 (10 tasks) - Week 10

#### 物理 (2 tasks)
- **059-060**: Collision Detection, Raycast Helpers

#### AI 感知 (4 tasks)
- **067-070**: Field of View, Stealth Calculation, Behavior Tree Evaluation, Blackboard Queries

**Phase 4 Milestone**: 完整基础库交付

---

## 🔍 按功能查找

### 数学计算
- **基础运算**: 001 (SafeMath), 002 (Range Mapping), 003 (Float Comparison)
- **三角函数**: 006 (Trigonometry Extended)
- **统计分析**: 007 (Statistics)
- **插值缓动**: 009 (Interpolation Advanced), 010 (Easing Parametric)
- **高级数学**: 014 (Matrix), 015 (Quaternion), 016 (Noise), 017 (Number Theory)
- **优化算法**: 018 (Fast Math), 019 (Lookup Tables), 020 (Numerical Calculus)

### 数据结构
- **数组操作**: 021-025 (Slicing, Filtering, Queries, Set Ops, Aggregation)
- **多维数组**: 026 (Multi-dimensional Arrays)
- **特殊结构**: 027 (Circular Buffer), 028 (Priority Queue), 029 (Sparse Array)
- **键值对**: 031 (Key-Value Operations)
- **位集合**: 033 (BitSet Logic)

### 游戏系统
- **战斗**: 036-040 (Damage, Hit, Combo, Cooldown, Stat Modifiers)
- **进度**: 041-043 (Experience, Achievement, Leaderboard)
- **经济**: 044-045 (Resource Validation, Price Balancing)
- **掉落**: 046-047 (Loot Drop, Rarity System)

### 物理 & 空间
- **几何**: 051-053 (Geometry 2D/3D, Bounding Box)
- **距离角度**: 054-055 (Distance Metrics, Direction Utils)
- **运动学**: 056-058 (Projectile, Trajectory, Kinematics)
- **碰撞**: 059-060 (Collision Detection, Raycast Helpers)

### AI & 行为
- **决策**: 061-062 (Utility System, Threat Assessment)
- **群体**: 063 (Flocking Logic)
- **寻路**: 064-066 (Path Smoothing, Grid Navigation, A* Logic)
- **感知**: 067-068 (Field of View, Stealth Calculation)
- **行为树**: 069-070 (BT Evaluation, Blackboard Queries)
- **巡逻追逐**: 076-077 (Patrol Path, Chase/Flee Logic)

### 状态机
- **状态转换**: 071-073 (Transition, Condition, Hierarchical FSM)
- **动画**: 074-075 (Animation Blending, Timing)

### 验证 & 约束
- **输入验证**: 081-085 (Range, String, Array, Vector, Time)
- **约束限制**: 086-088 (Velocity, Angle, Resource Caps)
- **规则引擎**: 089-090 (Rule Evaluation, Permission Checks)

### 格式化 & 转换
- **格式化**: 091-093 (Number, Time, Text Alignment)
- **转换**: 094-095 (Color Conversion, Unit Conversion)
- **编码**: 096-098 (Base64, URL, JSON)
- **压缩**: 099-100 (RLE, Delta Encoding)

---

## 📁 按文件目录查找

### coreMathUtils/ (18 files)
- MathSafe.verse (001)
- MathRanges.verse (002)
- MathFloatComparison.verse (003)
- MathConstants.verse (004)
- MathBitwise.verse (005)
- MathTrigonometry.verse (006)
- MathStatistics.verse (007)
- MathSequences.verse (008)
- MathInterpolationAdvanced.verse (009)
- MathEasingParametric.verse (010)
- MathMatrix.verse (014)
- MathQuaternions.verse (015)
- MathNoise.verse (016)
- MathNumberTheory.verse (017)
- MathFast.verse (018)
- MathCalculus.verse (020)

### collectionsUtils/ (15 files)
- ArraySlicing.verse (021)
- ArrayFunctional.verse (022)
- ArrayQueries.verse (023)
- ArraySetOps.verse (024)
- ArrayAggregation.verse (025)
- Array2D.verse (026)
- CircularBuffer.verse (027)
- PriorityQueue.verse (028)
- SparseArray.verse (029)
- StringArrays.verse (030)
- KeyValuePairs.verse (031)
- TupleUtils.verse (032)
- BitSet.verse (033)
- FiniteSet.verse (034)
- TreeTraversal.verse (035)

### combatUtils/ (5 files)
- DamageCalculation.verse (036)
- HitCalculation.verse (037)
- ComboLogic.verse (038)
- CooldownLogic.verse (039)
- StatModifiers.verse (040)

### progressionUtils/ (3 files)
- ExperienceCalc.verse (041)
- AchievementLogic.verse (042)
- LeaderboardLogic.verse (043)

### economyUtils/ (2 files)
- ResourceValidation.verse (044)
- PriceBalancing.verse (045)

### lootUtils/ (2 files)
- LootDropLogic.verse (046)
- RarityLogic.verse (047)

### generationUtils/ (1 file)
- ProceduralUtils.verse (048)

### timeUtils/ (2 files)
- DurationCalc.verse (049)
- SchedulerLogic.verse (050)

### spatialUtils/ (5 files)
- Geometry2DExtended.verse (051)
- Geometry3DExtended.verse (052)
- BoundingBox.verse (053)
- DistanceMetrics.verse (054)
- DirectionUtils.verse (055)

### physicsUtils/ (6 files)
- ProjectileMotion.verse (056)
- TrajectoryPrediction.verse (057)
- Kinematics.verse (058)
- CollisionDetection.verse (059)
- RaycastHelpers.verse (060)

### aiUtils/ (8 files)
- UtilitySystem.verse (061)
- ThreatAssessment.verse (062)
- FlockingBehavior.verse (063)
- FieldOfView.verse (067)
- StealthLogic.verse (068)
- BehaviorTreeLogic.verse (069)
- BlackboardQueries.verse (070)

### pathfindingUtils/ (3 files)
- PathSmoothing.verse (064)
- GridNavigation.verse (065)
- AStarLogic.verse (066)

### stateMachineUtils/ (3 files)
- TransitionLogic.verse (071)
- ConditionEvaluation.verse (072)
- HierarchicalFSM.verse (073)

### animationUtils/ (2 files)
- BlendingLogic.verse (074)
- TimingLogic.verse (075)

### behaviorUtils/ (3 files)
- PatrolLogic.verse (076)
- ChaseFleeLogic.verse (077)
- IdleBehavior.verse (078)

### triggerUtils/ (2 files)
- TriggerConditions.verse (079)
- EventPriority.verse (080)

### validationUtils/ (5 files)
- RangeValidation.verse (081)
- StringValidation.verse (082)
- ArrayValidation.verse (083)
- VectorValidation.verse (084)
- TimeValidation.verse (085)

### constraintsUtils/ (3 files)
- VelocityConstraints.verse (086)
- AngleConstraints.verse (087)
- ResourceCaps.verse (088)

### rulesUtils/ (2 files)
- RuleEvaluation.verse (089)
- PermissionChecks.verse (090)

### formattingUtils/ (3 files)
- NumberFormatting.verse (091)
- TimeFormatting.verse (092)
- TextAlignment.verse (093)

### conversionUtils/ (2 files)
- ColorConversion.verse (094)
- UnitConversion.verse (095)

### encodingUtils/ (3 files)
- Base64.verse (096)
- URLEncoding.verse (097)
- JSONHelpers.verse (098)

### compressionUtils/ (2 files)
- RunLengthEncoding.verse (099)
- DeltaEncoding.verse (100)

### algorithmsUtils/ (3 files)
- SearchAlgorithms.verse (011)
- SortingAlgorithms.verse (012)
- HashingUtils.verse (013)
- LookupTables.verse (019)

---

## 🎯 执行建议

### Week 1: 数值基础 (P0: 001-005)
**目标**: 安全可靠的数值计算基础

1. TASK-001: SafeMath - 防溢出、防除零
2. TASK-002: Range Mapping - 数值范围转换
3. TASK-003: Float Comparison - 浮点数精度处理
4. TASK-004: Math Constants - 常用数学常量
5. TASK-005: Bitwise Operations - 位运算模拟

**验证**: 编译通过 + 边界测试

### Week 2: 数组基础 + 验证 (P0: 021-025, 081-085)
**目标**: 完善的数组操作和输入验证

**Day 1-3: 数组操作**
- TASK-021: Array Slicing
- TASK-022: Array Filtering (研究Verse高阶函数支持)
- TASK-023: Array Queries

**Day 4-5: 数组集合 + 聚合**
- TASK-024: Array Set Ops
- TASK-025: Array Aggregation

**Day 6-7: 输入验证全套**
- TASK-081-085: 5个验证模块

**里程碑**: Phase 1 Complete - 核心基础就绪

### Week 3-4: 高频数学 + 游戏机制 (P1 部分)
- 高级数学函数 (006-010)
- 战斗系统逻辑 (036-040)
- 进度系统 (041-043)

### Week 5-6: 空间计算 + 状态机 (P1 部分)
- 几何计算 (051-055)
- 状态机逻辑 (071-075)
- 集合操作 (026-032)

**里程碑**: Phase 2 Complete - 高频工具完备

### Week 7-8: AI + 专项数学 (P2 部分)
- AI决策寻路 (061-066)
- 高级数学 (014-020)
- 游戏机制专项 (046-050)

### Week 9: 物理 + 行为 (P2 部分)
- 运动学 (056-058)
- 行为模式 (076-080)
- 编码压缩 (096-100)

**里程碑**: Phase 3 Complete - 专项能力增强

### Week 10: 进阶优化 (P3 全部)
- 碰撞检测 (059-060)
- AI感知行为树 (067-070)

**里程碑**: Phase 4 Complete - 完整基础库交付

---

## ✅ 任务执行模板

每个任务遵循 4-Phase 流程：

### Phase -1: 猜想审查
- [ ] 阅读 `CONJECTURES.md`
- [ ] 识别相关假设
- [ ] 评估可靠性

### Phase 0: 知识缺口
- [ ] 检查 PATTERNS.md
- [ ] 检查 DECISION_RECORDS.md
- [ ] 检查 COMPILATION_LESSONS.json
- [ ] 确定是否需要调研

### Phase 1: 元认知
- [ ] Socratic提问
- [ ] 质疑需求
- [ ] 检查并发安全

### Phase 2: 实现
- [ ] 编写代码（DLSD规范）
- [ ] 标注效果
- [ ] 添加注释
- [ ] **编译验证**: `./analyze.sh --format agent`

### Phase 3: 知识沉淀（强制）
- [ ] 至少更新2个知识资产
- [ ] 验证/更新猜想
- [ ] 记录信息源

---

## 📈 统计看板

### 总体进度
- **总任务数**: 100
- **已完成**: 0 (0%)
- **进行中**: 0
- **待开始**: 100

### 按优先级
- **P0**: 0/18 (0%)
- **P1**: 0/45 (0%)
- **P2**: 0/27 (0%)
- **P3**: 0/10 (0%)

### 按分类
- **A. 数学**: 0/20 (0%)
- **B. 集合**: 0/15 (0%)
- **C. 游戏**: 0/15 (0%)
- **D. 物理**: 0/10 (0%)
- **E. AI**: 0/10 (0%)
- **F. 状态机**: 0/10 (0%)
- **G. 验证**: 0/10 (0%)
- **H. 格式化**: 0/10 (0%)

---

**更新日期**: 2026-01-13  
**详细计划**: `logic-module-development-plan-phase1.md`  
**任务管理**: `improvement-backlog.md` (D-001)

---

**Let's build! 🚀**
