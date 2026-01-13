# Logic Module Development Plan - Phase 1
# 逻辑模块开发计划 - 第一阶段

> **目标**: 构建完整的基础能力库，提供通用的、可复用的纯函数逻辑模块  
> **范围**: 仅限 Logic Layer（无状态纯函数）  
> **任务数**: 100个高价值开发任务  
> **优先级**: P0（核心）→ P1（高频）→ P2（专项）→ P3（增强）

---

## 📊 计划概览

### 当前状态（Baseline）
- **现有模块**: 40个文件，4个分类目录
- **覆盖领域**: 
  - 角色状态工具 (characterAndStateUtils): 10个模块
  - 核心数学工具 (coreMathUtils): 10个模块
  - 经济交易工具 (economyAndTradeUtils): 10个模块
  - 物品库存工具 (inventoryAndItemsUtils): 10个模块

### 目标状态（Target）
- **新增模块**: 100个任务产出 80-100个新模块
- **新增分类**: 4-6个新的分类目录
- **覆盖完整度**: 80%+ 常用游戏逻辑场景

---

## 🎯 任务分类与优先级

### 分类体系

| 分类 | 任务数 | 优先级分布 | 说明 |
|------|--------|-----------|------|
| **A. 核心数学与算法** | 20 | P0:8, P1:8, P2:4 | 基础计算能力 |
| **B. 数据结构与集合** | 15 | P0:5, P1:7, P2:3 | 数组、列表、映射操作 |
| **C. 游戏机制工具** | 15 | P1:10, P2:5 | 常见游戏系统逻辑 |
| **D. 物理与空间计算** | 10 | P1:5, P2:3, P3:2 | 几何、碰撞、运动学 |
| **E. AI与寻路逻辑** | 10 | P2:6, P3:4 | 决策树、路径查找 |
| **F. 状态机与行为** | 10 | P1:5, P2:5 | 状态转换、行为树逻辑 |
| **G. 验证与约束** | 10 | P0:5, P1:5 | 输入验证、规则检查 |
| **H. 格式化与转换** | 10 | P1:5, P2:5 | 字符串、时间、颜色处理 |

**优先级说明**:
- **P0 (核心基础)**: 18 tasks - 必须优先完成，其他模块依赖
- **P1 (高频使用)**: 45 tasks - 日常开发常用，显著提升效率
- **P2 (专项深化)**: 27 tasks - 特定领域深入
- **P3 (进阶优化)**: 10 tasks - 高级特性、性能优化

---

## 📋 详细任务清单

### A. 核心数学与算法 (20 tasks)

#### A1. 数值运算增强 (P0: 5 tasks)

**TASK-001** (P0): 安全数学运算库 (SafeMath)
- **目标**: 提供防溢出、防除零的安全数学运算
- **函数**: SafeAdd, SafeSubtract, SafeMultiply, SafeDivide, SafePower
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathSafe.verse`
- **依赖**: 无
- **验证**: 边界值测试（最大值、最小值、零）

**TASK-002** (P0): 数值范围映射 (Range Mapping)
- **目标**: 将数值从一个范围映射到另一个范围
- **函数**: MapRange, MapRangeClamped, InverseLerp
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathRanges.verse`
- **应用**: 血条显示、音量控制、属性转换
- **参考模式**: Clamp Pattern, Safe Division

**TASK-003** (P0): 浮点数比较与容差 (Float Comparison)
- **目标**: 处理浮点数精度问题的安全比较
- **函数**: NearlyEqual, NearlyZero, NearlyGreater, NearlyLess
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathFloatComparison.verse`
- **参数**: 可配置的 Epsilon (默认 0.0001)

**TASK-004** (P0): 数学常量库 (Math Constants)
- **目标**: 常用数学常量定义
- **常量**: PI, TAU, E, GOLDEN_RATIO, SQRT2, SQRT3, DEG_TO_RAD, RAD_TO_DEG
- **文件**: `coreMathUtils/MathConstants.verse`
- **注意**: Verse中常量如何定义需调研

**TASK-005** (P0): 位运算模拟 (Bitwise Operations)
- **目标**: 使用整数运算模拟位操作
- **函数**: BitwiseAnd, BitwiseOr, BitwiseXor, BitwiseNot, LeftShift, RightShift
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathBitwise.verse`
- **应用**: 标志位管理、权限系统

#### A2. 高级数学函数 (P1: 5 tasks)

**TASK-006** (P1): 三角函数扩展 (Trigonometry Extended)
- **目标**: 补充常用三角函数
- **函数**: Tan, Cot, Sec, Csc, Atan2, SinCos (同时计算sin和cos)
- **效果**: `<transacts>` (调用UEFN API)
- **文件**: `coreMathUtils/MathTrigonometry.verse`

**TASK-007** (P1): 统计函数 (Statistics)
- **目标**: 基础统计计算
- **函数**: Mean, Median, Mode, Variance, StandardDeviation, Percentile
- **效果**: `<computes>` + `<decides>` (数组访问)
- **文件**: `coreMathUtils/MathStatistics.verse`
- **输入**: []float

**TASK-008** (P1): 数列与级数 (Sequences & Series)
- **目标**: 常见数列生成和求和
- **函数**: ArithmeticSum, GeometricSum, Fibonacci, Factorial, Combination, Permutation
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathSequences.verse`
- **注意**: Factorial需处理大数溢出

**TASK-009** (P1): 插值函数库扩展 (Interpolation Extended)
- **目标**: 补充更多插值类型
- **函数**: CatmullRomSpline, HermiteSpline, BSpline, BounceInterpolate
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathInterpolationAdvanced.verse`
- **参考**: 现有 MathInterpolation.verse

**TASK-010** (P1): 缓动曲线参数化 (Parametric Easing)
- **目标**: 支持参数的缓动函数
- **函数**: EaseInOutWithPower, EaseBackWithOvershoot, EaseElasticWithParams
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathEasingParametric.verse`
- **扩展**: MathCurves.verse

#### A3. 算法与优化 (P1: 3 tasks)

**TASK-011** (P1): 查找算法 (Search Algorithms)
- **目标**: 数组查找算法
- **函数**: BinarySearch, LinearSearch, FindMin, FindMax, FindKthSmallest
- **效果**: `<decides>` (可能找不到)
- **文件**: `algorithmsUtils/SearchAlgorithms.verse`
- **返回**: option[int] (索引) 或 option[T] (元素)

**TASK-012** (P1): 排序算法工具 (Sorting Utilities)
- **目标**: 数组排序和比较
- **函数**: QuickSort, MergeSort, IsSorted, ReverseArray, StablePartition
- **效果**: `<computes>` (返回新数组，不修改原数组)
- **文件**: `algorithmsUtils/SortingAlgorithms.verse`
- **注意**: 纯函数，不可变数组

**TASK-013** (P1): 哈希与校验 (Hashing & Checksum)
- **目标**: 简单哈希和校验和计算
- **函数**: SimpleHash, FNV1aHash, Checksum, ValidateChecksum
- **效果**: `<computes>`
- **文件**: `algorithmsUtils/HashingUtils.verse`
- **应用**: 数据完整性校验、简单加密

#### A4. 专项数学 (P2: 4 tasks)

**TASK-014** (P2): 矩阵运算 (Matrix Operations)
- **目标**: 2D/3D矩阵基础运算
- **函数**: MatrixMultiply, MatrixTranspose, MatrixDeterminant, MatrixInverse
- **效果**: `<computes>` + `<decides>` (不可逆矩阵)
- **文件**: `coreMathUtils/MathMatrix.verse`
- **应用**: 变换计算、物理模拟

**TASK-015** (P2): 四元数运算 (Quaternion Math)
- **目标**: 旋转计算辅助函数
- **函数**: QuatMultiply, QuatSlerp, QuatToEuler, EulerToQuat
- **效果**: `<transacts>` (可能调用API)
- **文件**: `coreMathUtils/MathQuaternions.verse`
- **参考**: MathRotations.verse

**TASK-016** (P2): 噪声函数 (Noise Functions)
- **目标**: 程序化生成噪声
- **函数**: PerlinNoise1D, PerlinNoise2D, WhiteNoise, ValueNoise
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathNoise.verse`
- **应用**: 地形生成、随机化效果

**TASK-017** (P2): 数论工具 (Number Theory)
- **目标**: 整数数论函数
- **函数**: GCD, LCM, IsPrime, Modulo, ModInverse
- **效果**: `<computes>` + `<decides>`
- **文件**: `coreMathUtils/MathNumberTheory.verse`
- **应用**: 循环逻辑、密码学基础

#### A5. 性能优化专项 (P2: 3 tasks)

**TASK-018** (P2): 快速数学近似 (Fast Math Approximations)
- **目标**: 牺牲精度换性能的近似计算
- **函数**: FastSqrt, FastInverseSqrt, FastSin, FastCos, FastPow
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathFast.verse`
- **注意**: 在注释中标明精度损失

**TASK-019** (P2): 查找表优化 (Lookup Tables)
- **目标**: 预计算查找表生成
- **函数**: GenerateSinTable, GeneratePowTable, LookupInterpolate
- **效果**: `<computes>`
- **文件**: `algorithmsUtils/LookupTables.verse`
- **应用**: 高频调用的计算

**TASK-020** (P2): 数值积分与微分 (Numerical Calculus)
- **目标**: 数值方法求解微积分
- **函数**: TrapezoidalIntegrate, SimpsonIntegrate, NumericalDerivative
- **效果**: `<computes>`
- **文件**: `coreMathUtils/MathCalculus.verse`
- **应用**: 物理模拟、轨迹预测

---

### B. 数据结构与集合 (15 tasks)

#### B1. 数组操作增强 (P0: 5 tasks)

**TASK-021** (P0): 数组切片与分块 (Array Slicing)
- **目标**: 数组子集操作
- **函数**: Slice, Take, Drop, Split, Chunk, Window
- **效果**: `<computes>` + `<decides>`
- **文件**: `collectionsUtils/ArraySlicing.verse`
- **参考**: 现有 UtilArrays.verse

**TASK-022** (P0): 数组过滤与映射 (Array Filtering)
- **目标**: 函数式数组操作
- **函数**: Filter, Map, Reduce, FlatMap, Zip
- **效果**: `<computes>` (高阶函数需研究Verse支持)
- **文件**: `collectionsUtils/ArrayFunctional.verse`
- **挑战**: Verse是否支持函数作为参数？

**TASK-023** (P0): 数组查询 (Array Queries)
- **目标**: 数组内容查询
- **函数**: Contains, IndexOf, LastIndexOf, FindAll, Count, Any, All
- **效果**: `<computes>` + `<decides>`
- **文件**: `collectionsUtils/ArrayQueries.verse`

**TASK-024** (P0): 数组去重与集合 (Array Set Operations)
- **目标**: 集合操作
- **函数**: Unique, Union, Intersection, Difference, IsSubset
- **效果**: `<computes>`
- **文件**: `collectionsUtils/ArraySetOps.verse`
- **应用**: 标签系统、权限判断

**TASK-025** (P0): 数组聚合 (Array Aggregation)
- **目标**: 数组统计和聚合
- **函数**: Sum, Product, Min, Max, Average, MinMax (返回tuple)
- **效果**: `<computes>` + `<decides>` (空数组)
- **文件**: `collectionsUtils/ArrayAggregation.verse`

#### B2. 高级集合操作 (P1: 5 tasks)

**TASK-026** (P1): 多维数组工具 (Multi-dimensional Arrays)
- **目标**: 2D数组操作
- **函数**: GetCell, SetCell, Transpose, GetRow, GetColumn, Flatten
- **效果**: `<computes>` + `<decides>`
- **文件**: `collectionsUtils/Array2D.verse`
- **应用**: 棋盘、网格系统

**TASK-027** (P1): 环形缓冲区逻辑 (Circular Buffer Logic)
- **目标**: 循环数组索引计算
- **函数**: CircularIndex, CircularNext, CircularPrev, CircularDistance
- **效果**: `<computes>`
- **文件**: `collectionsUtils/CircularBuffer.verse`
- **应用**: 轮播、历史记录

**TASK-028** (P1): 优先队列逻辑 (Priority Queue Logic)
- **目标**: 堆排序和优先队列算法
- **函数**: HeapInsert, HeapExtractMax, Heapify, IsHeap
- **效果**: `<computes>`
- **文件**: `collectionsUtils/PriorityQueue.verse`
- **应用**: AI决策、事件调度

**TASK-029** (P1): 稀疏数组压缩 (Sparse Array Compression)
- **目标**: 稀疏数据的紧凑表示
- **函数**: CompressSparse, DecompressSparse, GetSparse, SetSparse
- **效果**: `<computes>`
- **文件**: `collectionsUtils/SparseArray.verse`
- **应用**: 大地图、稀疏矩阵

**TASK-030** (P1): 字符串数组处理 (String Array Utils)
- **目标**: 字符串数组专用操作
- **函数**: Join, Split, TrimAll, FilterEmpty, SortAlphabetically
- **效果**: `<computes>` + `<decides>`
- **文件**: `collectionsUtils/StringArrays.verse`
- **应用**: 标签处理、文本分析

#### B3. 映射与元组 (P1: 2 tasks)

**TASK-031** (P1): 键值对操作 (Key-Value Operations)
- **目标**: 模拟映射操作（使用数组+元组）
- **函数**: FindByKey, FilterByKey, MapValues, GetKeys, GetValues
- **效果**: `<computes>` + `<decides>`
- **文件**: `collectionsUtils/KeyValuePairs.verse`
- **结构**: []tuple(KeyType, ValueType)

**TASK-032** (P1): 元组工具 (Tuple Utilities)
- **目标**: 元组操作辅助函数
- **函数**: SwapPair, SortByFirst, SortBySecond, Unzip
- **效果**: `<computes>`
- **文件**: `collectionsUtils/TupleUtils.verse`

#### B4. 专项数据结构 (P2: 3 tasks)

**TASK-033** (P2): 位集合逻辑 (BitSet Logic)
- **目标**: 使用整数数组模拟位集合
- **函数**: BitSetAdd, BitSetRemove, BitSetContains, BitSetUnion, BitSetIntersect
- **效果**: `<computes>`
- **文件**: `collectionsUtils/BitSet.verse`
- **应用**: 标志位管理、权限系统

**TASK-034** (P2): 有限状态集合 (Finite Set Logic)
- **目标**: 小规模集合的优化实现
- **函数**: AddToSet, RemoveFromSet, SetContains, SetSize
- **效果**: `<computes>`
- **文件**: `collectionsUtils/FiniteSet.verse`
- **优化**: 小于16元素时使用线性搜索

**TASK-035** (P2): 树结构逻辑 (Tree Structure Logic)
- **目标**: 树遍历和查询算法
- **函数**: TreeDepthFirstSearch, TreeBreadthFirstSearch, TreeHeight, TreeNodeCount
- **效果**: `<computes>` + `<decides>`
- **文件**: `collectionsUtils/TreeTraversal.verse`
- **应用**: 场景树、技能树

---

### C. 游戏机制工具 (15 tasks)

#### C1. 战斗系统逻辑 (P1: 5 tasks)

**TASK-036** (P1): 伤害计算公式库 (Damage Formulas)
- **目标**: 常见伤害计算公式
- **函数**: DamageWithArmor, DamageWithResistance, CriticalDamage, TrueDamage, PercentageDamage
- **效果**: `<computes>`
- **文件**: `combatUtils/DamageCalculation.verse`
- **扩展**: 现有 RpgDamage.verse

**TASK-037** (P1): 命中与闪避计算 (Hit & Evasion)
- **目标**: 命中率、闪避率计算
- **函数**: CalculateHitChance, WillHit, CalculateEvasion, WillDodge
- **效果**: `<computes>` (概率) + `<decides>` (判定结果)
- **文件**: `combatUtils/HitCalculation.verse`
- **依赖**: MathProbability.verse

**TASK-038** (P1): 连击与组合技 (Combo System Logic)
- **目标**: 连击计数和加成计算
- **函数**: CalculateComboMultiplier, ComboDecay, ComboBreak, MaxCombo
- **效果**: `<computes>`
- **文件**: `combatUtils/ComboLogic.verse`
- **应用**: 格斗游戏、动作游戏

**TASK-039** (P1): 冷却时间管理 (Cooldown Management)
- **目标**: 技能冷却计算
- **函数**: CalculateCooldown, IsCooldownReady, GetRemainingCooldown, ReduceCooldown
- **效果**: `<computes>`
- **文件**: `combatUtils/CooldownLogic.verse`
- **参数**: 当前时间、上次使用时间、冷却时长

**TASK-040** (P1): 属性加成计算 (Stat Modifiers)
- **目标**: 属性修正器叠加计算
- **函数**: ApplyAdditiveModifiers, ApplyMultiplicativeModifiers, CalculateFinalStat
- **效果**: `<computes>`
- **文件**: `combatUtils/StatModifiers.verse`
- **模式**: 加法→乘法→最终值

#### C2. 等级与进度系统 (P1: 3 tasks)

**TASK-041** (P1): 经验值计算 (Experience Calculation)
- **目标**: 经验值和等级转换
- **函数**: ExpForLevel, LevelForExp, ExpToNextLevel, ExpProgress
- **效果**: `<computes>`
- **文件**: `progressionUtils/ExperienceCalc.verse`
- **支持**: 线性、指数、自定义曲线

**TASK-042** (P1): 成就与里程碑 (Achievement Logic)
- **目标**: 成就进度计算
- **函数**: CalculateProgress, IsAchievementComplete, CountCompletions, NextMilestone
- **效果**: `<computes>` + `<decides>`
- **文件**: `progressionUtils/AchievementLogic.verse`

**TASK-043** (P1): 排行榜排序 (Leaderboard Sorting)
- **目标**: 排行榜排名计算
- **函数**: CalculateRank, CalculatePercentile, IsTopPercent, RankDifference
- **效果**: `<computes>`
- **文件**: `progressionUtils/LeaderboardLogic.verse`

#### C3. 资源与平衡 (P1: 2 tasks)

**TASK-044** (P1): 资源消耗验证 (Resource Cost Validation)
- **目标**: 检查资源是否足够
- **函数**: CanAfford, CalculateAffordableQuantity, ResourceShortage
- **效果**: `<computes>` + `<decides>`
- **文件**: `economyUtils/ResourceValidation.verse`

**TASK-045** (P1): 价格平衡算法 (Price Balancing)
- **目标**: 动态定价和平衡
- **函数**: CalculateDynamicPrice, SupplyDemandPrice, BulkDiscount
- **效果**: `<computes>`
- **文件**: `economyUtils/PriceBalancing.verse`

#### C4. 随机与掉落 (P2: 3 tasks)

**TASK-046** (P2): 战利品掉落算法 (Loot Drop Algorithm)
- **目标**: 战利品掉落计算
- **函数**: RollLoot, WeightedRandomPick, GuaranteedPity, LuckModifier
- **效果**: `<computes>` + `<decides>`
- **文件**: `lootUtils/LootDropLogic.verse`
- **参考**: MathProbability.verse

**TASK-047** (P2): 稀有度系统 (Rarity System)
- **目标**: 稀有度判定和转换
- **函数**: RarityToWeight, WeightToRarity, RarityCompare, UpgradeRarity
- **效果**: `<computes>`
- **文件**: `lootUtils/RarityLogic.verse`
- **枚举**: rarity_tier (Common, Uncommon, Rare, Epic, Legendary)

**TASK-048** (P2): 程序化生成工具 (Procedural Generation)
- **目标**: 随机生成辅助函数
- **函数**: RandomSeed, SeededRandom, ShuffleArray, RandomSubset
- **效果**: `<computes>`
- **文件**: `generationUtils/ProceduralUtils.verse`
- **依赖**: MathProbability.verse

#### C5. 时间与调度 (P2: 2 tasks)

**TASK-049** (P2): 时间戳与持续时间 (Timestamp & Duration)
- **目标**: 时间计算辅助函数
- **函数**: AddDuration, SubtractDuration, DurationBetween, IsExpired
- **效果**: `<computes>`
- **文件**: `timeUtils/DurationCalc.verse`
- **参考**: UtilTime.verse

**TASK-050** (P2): 调度器逻辑 (Scheduler Logic)
- **目标**: 事件调度计算
- **函数**: NextScheduledTime, IsScheduleDue, CalculateInterval, CronLikeSchedule
- **效果**: `<computes>` + `<decides>`
- **文件**: `timeUtils/SchedulerLogic.verse`
- **应用**: 定时任务、循环事件

---

### D. 物理与空间计算 (10 tasks)

#### D1. 几何计算 (P1: 3 tasks)

**TASK-051** (P1): 2D几何扩展 (Geometry 2D Extended)
- **目标**: 补充2D几何函数
- **函数**: PointInPolygon, PolygonArea, PolygonCentroid, LineLineIntersection
- **效果**: `<computes>` + `<decides>`
- **文件**: `spatialUtils/Geometry2DExtended.verse`
- **扩展**: MathGeometry2d.verse

**TASK-052** (P1): 3D几何扩展 (Geometry 3D Extended)
- **目标**: 补充3D几何函数
- **函数**: PointInBox, PointInSphere, SphereSphereIntersect, RayPlaneIntersect
- **效果**: `<computes>` + `<decides>`
- **文件**: `spatialUtils/Geometry3DExtended.verse`
- **扩展**: MathGeometry3d.verse

**TASK-053** (P1): 边界盒计算 (Bounding Box)
- **目标**: AABB边界盒操作
- **函数**: BoundsFromPoints, BoundsIntersect, BoundsContains, ExpandBounds
- **效果**: `<computes>`
- **文件**: `spatialUtils/BoundingBox.verse`
- **结构**: bounds := struct(Min:vector3, Max:vector3)

#### D2. 距离与方向 (P1: 2 tasks)

**TASK-054** (P1): 距离计算增强 (Distance Calculations)
- **目标**: 各种距离度量
- **函数**: ManhattanDistance, ChebyshevDistance, Distance2D, DistanceSquared
- **效果**: `<computes>`
- **文件**: `spatialUtils/DistanceMetrics.verse`
- **应用**: AI寻路、近战判定

**TASK-055** (P1): 方向与角度 (Direction & Angle)
- **目标**: 方向向量和角度计算
- **函数**: DirectionTo, AngleBetween, SignedAngle, LookRotation
- **效果**: `<computes>` + `<transacts>`
- **文件**: `spatialUtils/DirectionUtils.verse`

#### D3. 运动学 (P2: 3 tasks)

**TASK-056** (P2): 抛物线运动 (Projectile Motion)
- **目标**: 抛射体轨迹计算
- **函数**: ProjectileHeight, ProjectileRange, ProjectileAngle, ProjectileTime
- **效果**: `<computes>`
- **文件**: `physicsUtils/ProjectileMotion.verse`
- **参数**: 初速度、角度、重力

**TASK-057** (P2): 轨迹预测 (Trajectory Prediction)
- **目标**: 移动目标预测
- **函数**: PredictPosition, LeadTarget, InterceptPoint, TimeToIntercept
- **效果**: `<computes>` + `<decides>`
- **文件**: `physicsUtils/TrajectoryPrediction.verse`
- **应用**: AI瞄准、导弹追踪

**TASK-058** (P2): 运动学公式 (Kinematics Formulas)
- **目标**: 基础运动学计算
- **函数**: VelocityFromAccel, PositionFromVelocity, StoppingDistance, TimeToStop
- **效果**: `<computes>`
- **文件**: `physicsUtils/Kinematics.verse`

#### D4. 碰撞与射线 (P3: 2 tasks)

**TASK-059** (P3): 碰撞检测逻辑 (Collision Detection Logic)
- **目标**: 简单碰撞检测算法
- **函数**: AABBvsAABB, SphereVsSphere, CapsuleVsSphere, OBBvsOBB
- **效果**: `<computes>`
- **文件**: `physicsUtils/CollisionDetection.verse`
- **注意**: 仅逻辑，不涉及物理引擎

**TASK-060** (P3): 射线投射辅助 (Raycast Helpers)
- **目标**: 射线计算辅助函数
- **函数**: RayAtDistance, ClosestPointOnRay, RaySphereIntersect, RayBoxIntersect
- **效果**: `<computes>` + `<decides>`
- **文件**: `physicsUtils/RaycastHelpers.verse`

---

### E. AI与寻路逻辑 (10 tasks)

#### E1. 决策与评分 (P2: 3 tasks)

**TASK-061** (P2): 效用系统 (Utility System)
- **目标**: 效用评分和决策
- **函数**: CalculateUtility, BestUtility, NormalizeScores, WeightedUtility
- **效果**: `<computes>`
- **文件**: `aiUtils/UtilitySystem.verse`
- **应用**: AI决策、行为选择

**TASK-062** (P2): 威胁评估 (Threat Assessment)
- **目标**: 目标威胁度计算
- **函数**: CalculateThreat, PrioritizeTargets, ThreatDecay, CombinedThreat
- **效果**: `<computes>`
- **文件**: `aiUtils/ThreatAssessment.verse`
- **因素**: 距离、生命值、伤害输出

**TASK-063** (P2): 群体行为逻辑 (Flocking Logic)
- **目标**: 群体行为算法
- **函数**: CalculateSeparation, CalculateAlignment, CalculateCohesion, CombineBehaviors
- **效果**: `<computes>`
- **文件**: `aiUtils/FlockingBehavior.verse`
- **应用**: 鸟群、鱼群、群体NPC

#### E2. 路径与导航 (P2: 3 tasks)

**TASK-064** (P2): 路径平滑 (Path Smoothing)
- **目标**: 路径点平滑处理
- **函数**: SmoothPath, SimplifyPath, CatmullRomPath, RemoveRedundantPoints
- **效果**: `<computes>`
- **文件**: `pathfindingUtils/PathSmoothing.verse`
- **输入**: []vector3

**TASK-065** (P2): 网格导航辅助 (Grid Navigation)
- **目标**: 网格坐标转换和邻居查找
- **函数**: WorldToGrid, GridToWorld, GetNeighbors4, GetNeighbors8, ManhattanHeuristic
- **效果**: `<computes>`
- **文件**: `pathfindingUtils/GridNavigation.verse`
- **应用**: 回合制游戏、网格地图

**TASK-066** (P2): A*算法核心逻辑 (A* Core Logic)
- **目标**: A*算法的纯函数实现
- **函数**: CalculateHeuristic, ReconstructPath, AStarStep
- **效果**: `<computes>` + `<decides>`
- **文件**: `pathfindingUtils/AStarLogic.verse`
- **注意**: 纯逻辑，不维护开放/关闭列表状态

#### E3. 感知与视野 (P3: 2 tasks)

**TASK-067** (P3): 视野计算 (Field of View)
- **目标**: 视野范围判定
- **函数**: IsInFOV, CalculateVisibilityAngle, FOVContains, RadialFOV
- **效果**: `<computes>`
- **文件**: `aiUtils/FieldOfView.verse`
- **参数**: 位置、朝向、FOV角度、距离

**TASK-068** (P3): 隐蔽度计算 (Stealth Calculation)
- **目标**: 隐蔽和可见性计算
- **函数**: CalculateVisibility, CalculateStealth, LightExposure, SoundExposure
- **效果**: `<computes>`
- **文件**: `aiUtils/StealthLogic.verse`
- **因素**: 距离、光照、声音、移动速度

#### E4. 行为树逻辑 (P3: 2 tasks)

**TASK-069** (P3): 行为树评估 (Behavior Tree Evaluation)
- **目标**: 行为树节点评估逻辑
- **函数**: EvaluateSequence, EvaluateSelector, EvaluateParallel, EvaluateDecorator
- **效果**: `<computes>` + `<decides>`
- **文件**: `aiUtils/BehaviorTreeLogic.verse`
- **返回**: behavior_result (Success, Failure, Running)

**TASK-070** (P3): 黑板数据查询 (Blackboard Queries)
- **目标**: 行为树黑板数据查询逻辑
- **函数**: QueryBlackboard, CompareValues, IsKeySet, GetKeyAge
- **效果**: `<computes>` + `<decides>`
- **文件**: `aiUtils/BlackboardQueries.verse`
- **注意**: 查询逻辑，不维护黑板状态

---

### F. 状态机与行为 (10 tasks)

#### F1. 状态机逻辑 (P1: 3 tasks)

**TASK-071** (P1): 状态转换验证 (State Transition Validation)
- **目标**: 状态转换规则验证
- **函数**: CanTransition, IsValidTransition, GetAllowedTransitions, TransitionCost
- **效果**: `<computes>` + `<decides>`
- **文件**: `stateMachineUtils/TransitionLogic.verse`
- **输入**: 当前状态、目标状态、转换规则表

**TASK-072** (P1): 状态条件评估 (State Condition Evaluation)
- **目标**: 状态进入/退出条件判定
- **函数**: EvaluateConditions, AllConditionsMet, AnyConditionMet, ConditionPriority
- **效果**: `<computes>` + `<decides>`
- **文件**: `stateMachineUtils/ConditionEvaluation.verse`

**TASK-073** (P1): 层次状态机逻辑 (Hierarchical FSM Logic)
- **目标**: 层次化状态机导航
- **函数**: FindParentState, FindChildStates, IsAncestor, GetStatePath
- **效果**: `<computes>`
- **文件**: `stateMachineUtils/HierarchicalFSM.verse`
- **结构**: 状态树表示

#### F2. 动画状态逻辑 (P1: 2 tasks)

**TASK-074** (P1): 动画混合计算 (Animation Blending)
- **目标**: 动画权重和混合计算
- **函数**: CalculateBlendWeight, BlendTime, CrossfadeProgress, LayerBlending
- **效果**: `<computes>`
- **文件**: `animationUtils/BlendingLogic.verse`

**TASK-075** (P1): 动画时间控制 (Animation Timing)
- **目标**: 动画时间和速度计算
- **函数**: NormalizeTime, CalculatePlaybackSpeed, LoopTime, PingPongTime
- **效果**: `<computes>`
- **文件**: `animationUtils/TimingLogic.verse`

#### F3. 行为模式 (P2: 3 tasks)

**TASK-076** (P2): 巡逻路径逻辑 (Patrol Path Logic)
- **目标**: 巡逻路径计算
- **函数**: NextPatrolPoint, PatrolProgress, LoopPatrol, PingPongPatrol, RandomPatrol
- **效果**: `<computes>`
- **文件**: `behaviorUtils/PatrolLogic.verse`
- **输入**: []vector3 (路径点)

**TASK-077** (P2): 追逐与逃跑逻辑 (Chase & Flee Logic)
- **目标**: 追逐和逃跑行为计算
- **函数**: CalculateChaseDirection, CalculateFleeDirection, KeepDistance, OrbitTarget
- **效果**: `<computes>`
- **文件**: `behaviorUtils/ChaseFleeLogic.verse`

**TASK-078** (P2): 待机行为生成 (Idle Behavior Generation)
- **目标**: 待机行为随机化
- **函数**: PickIdleAnimation, IdleDuration, ShouldTransitionFromIdle
- **效果**: `<computes>` + `<decides>`
- **文件**: `behaviorUtils/IdleBehavior.verse`
- **应用**: NPC待机动作

#### F4. 反应与触发 (P2: 2 tasks)

**TASK-079** (P2): 触发器条件 (Trigger Conditions)
- **目标**: 触发器条件判定
- **函数**: EvaluateTrigger, TriggerCooldownReady, TriggerCount, ResetTrigger
- **效果**: `<computes>` + `<decides>`
- **文件**: `triggerUtils/TriggerConditions.verse`

**TASK-080** (P2): 事件优先级 (Event Priority)
- **目标**: 事件优先级排序
- **函数**: CalculatePriority, SortEvents, FilterEvents, MergeEvents
- **效果**: `<computes>`
- **文件**: `triggerUtils/EventPriority.verse`

---

### G. 验证与约束 (10 tasks)

#### G1. 输入验证 (P0: 5 tasks)

**TASK-081** (P0): 数值范围验证 (Range Validation)
- **目标**: 数值范围检查
- **函数**: IsInRange, IsPositive, IsNonNegative, IsBetween, ValidateRange
- **效果**: `<decides>`
- **文件**: `validationUtils/RangeValidation.verse`

**TASK-082** (P0): 字符串验证 (String Validation)
- **目标**: 字符串格式验证
- **函数**: IsEmpty, HasLength, ContainsOnly, IsAlphanumeric, IsValidName
- **效果**: `<decides>`
- **文件**: `validationUtils/StringValidation.verse`

**TASK-083** (P0): 数组验证 (Array Validation)
- **目标**: 数组内容验证
- **函数**: IsEmpty, HasElements, AllValid, AnyInvalid, NoDuplicates
- **效果**: `<decides>`
- **文件**: `validationUtils/ArrayValidation.verse`

**TASK-084** (P0): 向量验证 (Vector Validation)
- **目标**: 向量有效性检查
- **函数**: IsZeroVector, IsNormalized, IsFinite, HasNaN, IsDirection
- **效果**: `<decides>`
- **文件**: `validationUtils/VectorValidation.verse`

**TASK-085** (P0): 时间验证 (Time Validation)
- **目标**: 时间和持续时间验证
- **函数**: IsValidTimestamp, IsFuture, IsPast, IsValidDuration, IsWithinTimeframe
- **效果**: `<decides>`
- **文件**: `validationUtils/TimeValidation.verse`

#### G2. 约束与限制 (P1: 3 tasks)

**TASK-086** (P1): 速度限制 (Velocity Constraints)
- **目标**: 速度约束计算
- **函数**: ClampVelocity, ClampSpeed, LimitAcceleration, SmoothVelocityChange
- **效果**: `<computes>`
- **文件**: `constraintsUtils/VelocityConstraints.verse`

**TASK-087** (P1): 角度限制 (Angle Constraints)
- **目标**: 角度约束和归一化
- **函数**: ClampAngle, NormalizeAngle, ShortestAngleDifference, ClampRotation
- **效果**: `<computes>`
- **文件**: `constraintsUtils/AngleConstraints.verse`

**TASK-088** (P1): 资源上限 (Resource Caps)
- **目标**: 资源上限管理
- **函数**: ApplyCap, IsAtCap, RemainingCapacity, OverCapAmount
- **效果**: `<computes>`
- **文件**: `constraintsUtils/ResourceCaps.verse`

#### G3. 规则引擎 (P1: 2 tasks)

**TASK-089** (P1): 规则评估 (Rule Evaluation)
- **目标**: 规则条件评估
- **函数**: EvaluateRule, ApplyRules, RuleMatches, PrioritizeRules
- **效果**: `<computes>` + `<decides>`
- **文件**: `rulesUtils/RuleEvaluation.verse`

**TASK-090** (P1): 权限检查 (Permission Checks)
- **目标**: 权限验证逻辑
- **函数**: HasPermission, RequiresAllPermissions, RequiresAnyPermission, IsAuthorized
- **效果**: `<decides>`
- **文件**: `rulesUtils/PermissionChecks.verse`

---

### H. 格式化与转换 (10 tasks)

#### H1. 字符串格式化 (P1: 3 tasks)

**TASK-091** (P1): 数字格式化 (Number Formatting)
- **目标**: 数字转字符串格式化
- **函数**: FormatInt, FormatFloat, FormatPercentage, FormatLargeNumber (K, M, B)
- **效果**: `<computes>`
- **文件**: `formattingUtils/NumberFormatting.verse`
- **示例**: 1234567 → "1.23M"

**TASK-092** (P1): 时间格式化 (Time Formatting)
- **目标**: 时间显示格式化
- **函数**: FormatDuration, FormatCountdown, FormatTimestamp, FormatElapsed
- **效果**: `<computes>`
- **文件**: `formattingUtils/TimeFormatting.verse`
- **示例**: 3665秒 → "1:01:05"

**TASK-093** (P1): 文本对齐与填充 (Text Alignment)
- **目标**: 字符串对齐和填充
- **函数**: PadLeft, PadRight, PadCenter, Truncate, Ellipsis
- **效果**: `<computes>`
- **文件**: `formattingUtils/TextAlignment.verse`

#### H2. 数据转换 (P1: 2 tasks)

**TASK-094** (P1): 颜色转换 (Color Conversion)
- **目标**: 颜色格式转换
- **函数**: RGBToHSV, HSVToRGB, HexToRGB, RGBToHex, ColorToFloat, FloatToColor
- **效果**: `<computes>`
- **文件**: `conversionUtils/ColorConversion.verse`

**TASK-095** (P1): 单位转换 (Unit Conversion)
- **目标**: 常用单位转换
- **函数**: MetersToFeet, KilometersToMiles, CelsiusToFahrenheit, DegreesToRadians
- **效果**: `<computes>`
- **文件**: `conversionUtils/UnitConversion.verse`

#### H3. 编码与解码 (P2: 3 tasks)

**TASK-096** (P2): Base64编码 (Base64 Encoding)
- **目标**: 简单的Base64编码解码
- **函数**: Base64Encode, Base64Decode, IsValidBase64
- **效果**: `<computes>` + `<decides>`
- **文件**: `encodingUtils/Base64.verse`
- **注意**: 简化实现，仅支持ASCII

**TASK-097** (P2): URL编码 (URL Encoding)
- **目标**: URL字符转义
- **函数**: URLEncode, URLDecode, EncodeURIComponent
- **效果**: `<computes>`
- **文件**: `encodingUtils/URLEncoding.verse`

**TASK-098** (P2): JSON解析辅助 (JSON Helpers)
- **目标**: 简单JSON字符串处理
- **函数**: EscapeJSONString, UnescapeJSONString, IsValidJSON, ExtractJSONValue
- **效果**: `<computes>` + `<decides>`
- **文件**: `encodingUtils/JSONHelpers.verse`
- **注意**: 简化实现，不做完整解析

#### H4. 压缩与编码 (P2: 2 tasks)

**TASK-099** (P2): 游程编码 (Run-Length Encoding)
- **目标**: 简单的RLE压缩
- **函数**: RLEEncode, RLEDecode, RLESize, RLEEfficiency
- **效果**: `<computes>`
- **文件**: `compressionUtils/RunLengthEncoding.verse`
- **应用**: 简单数据压缩

**TASK-100** (P2): 差分编码 (Delta Encoding)
- **目标**: 差分压缩算法
- **函数**: DeltaEncode, DeltaDecode, DeltaSize
- **效果**: `<computes>`
- **文件**: `compressionUtils/DeltaEncoding.verse`
- **应用**: 时间序列数据压缩

---

## 📅 执行计划

### Phase 1: 核心基础 (Week 1-2) - P0 Tasks (18 tasks)
- A1. 数值运算增强 (5 tasks)
- B1. 数组操作增强 (5 tasks)
- G1. 输入验证 (5 tasks)
- A4. 数学常量、浮点比较、位运算 (3 tasks)

**里程碑**: 基础数学和数组操作就绪

### Phase 2: 高频工具 (Week 3-6) - P1 Tasks (45 tasks)
- A2. 高级数学函数 (5 tasks)
- A3. 算法与优化 (3 tasks)
- B2. 高级集合操作 (5 tasks)
- B3. 映射与元组 (2 tasks)
- C1-C2. 游戏机制工具 (10 tasks)
- D1-D2. 物理与空间计算 (5 tasks)
- F1-F2. 状态机与动画 (5 tasks)
- G2-G3. 约束与规则 (5 tasks)
- H1-H2. 格式化与转换 (5 tasks)

**里程碑**: 日常开发工具完备

### Phase 3: 专项深化 (Week 7-9) - P2 Tasks (27 tasks)
- A4-A5. 专项数学 (7 tasks)
- B4. 专项数据结构 (3 tasks)
- C3-C5. 资源、随机、时间 (7 tasks)
- D3. 运动学 (3 tasks)
- E1-E2. AI决策与寻路 (6 tasks)
- H3-H4. 编码与压缩 (5 tasks)

**里程碑**: 专业领域能力增强

### Phase 4: 进阶优化 (Week 10) - P3 Tasks (10 tasks)
- D4. 碰撞与射线 (2 tasks)
- E3-E4. AI感知与行为树 (4 tasks)
- F3-F4. 行为模式与触发 (4 tasks)

**里程碑**: 完整基础库交付

---

## 🔍 质量保证

### 每个任务必须遵循的检查清单

#### Phase -1: 猜想库审查
- [ ] 阅读 `CONJECTURES.md`，识别相关猜想
- [ ] 评估假设可靠性，标记需要验证的猜想
- [ ] 制定验证计划

#### Phase 0: 知识缺口分析
- [ ] 检查 `knowledge/PATTERNS.md` 是否有参考模式
- [ ] 检查 `knowledge/DECISION_RECORDS.md` 是否有相关决策
- [ ] 检查 `knowledge/COMPILATION_LESSONS.json` 是否有相关经验
- [ ] 确定是否需要前置调研

#### Phase 1: Meta-Cognition
- [ ] 使用 `skills/socratic-architect/SKILL.md` 进行深度思考
- [ ] 质疑需求的合理性和必要性
- [ ] 检查并发和状态安全

#### Phase 2: Implementation
- [ ] 编写符合 DLSD 架构的代码
- [ ] 使用清晰的效果标注 (`<computes>`, `<decides>`, `<transacts>`)
- [ ] 添加充分的注释
- [ ] **强制编译验证**: `cd verseProject && ./analyze.sh --format agent`

#### Phase 3: Knowledge Distillation（强制）
- [ ] 至少更新两个知识资产（ADR / Patterns / Lessons / Research）
- [ ] 更新或验证相关猜想（`CONJECTURES.md`）
- [ ] 记录信息来源（`SOURCES.md`）
- [ ] 产出清晰、可操作的知识记录

---

## 📊 进度追踪

### 任务统计

| 阶段 | 优先级 | 任务数 | 完成数 | 进度 |
|------|--------|--------|--------|------|
| Phase 1 | P0 | 18 | 0 | 0% |
| Phase 2 | P1 | 45 | 0 | 0% |
| Phase 3 | P2 | 27 | 0 | 0% |
| Phase 4 | P3 | 10 | 0 | 0% |
| **总计** | - | **100** | **0** | **0%** |

### 分类统计

| 分类 | 任务数 | 完成数 | 进度 |
|------|--------|--------|------|
| A. 核心数学与算法 | 20 | 0 | 0% |
| B. 数据结构与集合 | 15 | 0 | 0% |
| C. 游戏机制工具 | 15 | 0 | 0% |
| D. 物理与空间计算 | 10 | 0 | 0% |
| E. AI与寻路逻辑 | 10 | 0 | 0% |
| F. 状态机与行为 | 10 | 0 | 0% |
| G. 验证与约束 | 10 | 0 | 0% |
| H. 格式化与转换 | 10 | 0 | 0% |

---

## 🎓 学习目标

通过完成这100个任务，Verse Logic Lab 将：

1. **建立完整的基础能力库** - 覆盖80%+常见游戏逻辑场景
2. **积累丰富的知识资产** - ADR、Patterns、Lessons 全面更新
3. **验证猜想和假设** - 清空或减少 `CONJECTURES.md` 中的未验证项
4. **形成可复用的模式** - 提炼通用的逻辑模块设计模式
5. **提升代码质量** - 通过强制编译验证和知识沉淀提升质量
6. **建立索引体系** - 让未来开发者能快速找到所需工具

---

## 🔗 相关文档

- **工作单元文档**: `workUnits/verseLogicLab/SKILL.md`
- **检查清单**: `workUnits/verseLogicLab/CHECKLISTS.md`
- **知识库**: `workUnits/verseLogicLab/knowledge/`
- **验证工具**: `verseProject/analyze.sh`
- **目标目录**: `verseProject/source/library/logicModules/`

---

**记住**: 这是一个长期计划，质量优先于速度。每个模块都是未来项目的基石，值得投入时间打磨。

**开始日期**: 2026-01-13  
**预计完成**: 2026-03-13 (10周全职) 或 2026-05-13 (20周兼职)

---

**Let's build the foundation! 🚀**
