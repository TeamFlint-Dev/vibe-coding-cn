# 浮点数比较与容差模块
# 功能：处理浮点数精度问题的安全比较函数
# 架构：Logic 层 - 纯函数，无状态
# 验证：CONJ-003 (已证伪) - 正确实现浮点数比较

MathFloatComparison<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 常量定义
    # ═══════════════════════════════════════════════════════════
    
    # 默认 Epsilon 值 - 浮点数比较的默认容差
    # 选择理由：0.0001 适用于大多数游戏逻辑场景
    # 参考：IEEE 754 单精度浮点数精度约为 7 位有效数字
    DefaultEpsilon:float = 0.0001
    
    # 小 Epsilon - 用于高精度场景
    SmallEpsilon:float = 0.000001
    
    # 大 Epsilon - 用于低精度场景
    LargeEpsilon:float = 0.001
    
    # ═══════════════════════════════════════════════════════════
    # 核心比较函数
    # ═══════════════════════════════════════════════════════════
    
    # 判断两个浮点数是否近似相等
    # @param A: 第一个浮点数
    # @param B: 第二个浮点数
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 |A - B| <= Epsilon 则返回 true
    # 
    # 使用场景：
    # - 比较计算结果是否符合预期
    # - 判断物体是否到达目标位置
    # - 检查插值是否完成
    NearlyEqual<public>(A:float, B:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        Diff := A - B
        AbsDiff := if (Diff < 0.0) then -Diff else Diff
        if (AbsDiff <= Epsilon) then true else false
    
    # 判断浮点数是否近似为零
    # @param Value: 要检查的浮点数
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 |Value| <= Epsilon 则返回 true
    # 
    # 使用场景：
    # - 判断速度是否停止
    # - 检查是否需要归零
    # - 验证计算结果是否可忽略
    NearlyZero<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        AbsValue := if (Value < 0.0) then -Value else Value
        if (AbsValue <= Epsilon) then true else false
    
    # 判断第一个浮点数是否明显大于第二个
    # @param A: 第一个浮点数
    # @param B: 第二个浮点数
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 A > B + Epsilon 则返回 true
    # 
    # 注意：只有当 A 明显大于 B（差值超过 Epsilon）时才返回 true
    # 这避免了浮点数精度问题导致的误判
    # 
    # 使用场景：
    # - 排序算法中的比较
    # - 判断是否超过阈值
    # - 优先级比较
    NearlyGreater<public>(A:float, B:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (A > B + Epsilon) then true else false
    
    # 判断第一个浮点数是否明显小于第二个
    # @param A: 第一个浮点数
    # @param B: 第二个浮点数
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 A < B - Epsilon 则返回 true
    # 
    # 注意：只有当 A 明显小于 B（差值超过 Epsilon）时才返回 true
    # 
    # 使用场景：
    # - 判断资源是否不足
    # - 检查是否低于阈值
    # - 排序和优先级判断
    NearlyLess<public>(A:float, B:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (A < B - Epsilon) then true else false
    
    # 判断第一个浮点数是否大于等于第二个（容差范围内）
    # @param A: 第一个浮点数
    # @param B: 第二个浮点数
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 A >= B - Epsilon 则返回 true
    # 
    # 使用场景：
    # - 检查资源是否足够
    # - 验证条件是否满足
    NearlyGreaterOrEqual<public>(A:float, B:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (A >= B - Epsilon) then true else false
    
    # 判断第一个浮点数是否小于等于第二个（容差范围内）
    # @param A: 第一个浮点数
    # @param B: 第二个浮点数
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 A <= B + Epsilon 则返回 true
    NearlyLessOrEqual<public>(A:float, B:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (A <= B + Epsilon) then true else false
    
    # ═══════════════════════════════════════════════════════════
    # 辅助函数
    # ═══════════════════════════════════════════════════════════
    
    # 获取两个浮点数中的较大值（考虑精度）
    # @param A: 第一个浮点数
    # @param B: 第二个浮点数
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 较大的值，如果近似相等则返回 A
    MaxWithTolerance<public>(A:float, B:float, ?Epsilon:float = DefaultEpsilon)<computes>:float =
        IsAGreater := NearlyGreater(A, B, ?Epsilon := Epsilon)
        IsBGreater := NearlyGreater(B, A, ?Epsilon := Epsilon)
        if (IsAGreater = true):
            A
        else if (IsBGreater = true):
            B
        else:
            A  # 近似相等时返回第一个
    
    # 获取两个浮点数中的较小值（考虑精度）
    # @param A: 第一个浮点数
    # @param B: 第二个浮点数
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 较小的值，如果近似相等则返回 A
    MinWithTolerance<public>(A:float, B:float, ?Epsilon:float = DefaultEpsilon)<computes>:float =
        IsALess := NearlyLess(A, B, ?Epsilon := Epsilon)
        IsBLess := NearlyLess(B, A, ?Epsilon := Epsilon)
        if (IsALess = true):
            A
        else if (IsBLess = true):
            B
        else:
            A  # 近似相等时返回第一个
    
    # 判断值是否在范围内（考虑精度）
    # @param Value: 要检查的值
    # @param MinValue: 最小值（包含）
    # @param MaxValue: 最大值（包含）
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 MinValue <= Value <= MaxValue（考虑容差）则返回 true
    # 
    # 使用场景：
    # - 验证参数范围
    # - 检查插值参数 T ∈ [0, 1]
    # - 边界检查
    IsInRangeWithTolerance<public>(Value:float, MinValue:float, MaxValue:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        IsGreaterOrEqualToMin := NearlyGreaterOrEqual(Value, MinValue, ?Epsilon := Epsilon)
        IsLessOrEqualToMax := NearlyLessOrEqual(Value, MaxValue, ?Epsilon := Epsilon)
        if (IsGreaterOrEqualToMin = true):
            if (IsLessOrEqualToMax = true):
                true
            else:
                false
        else:
            false
    
    # ═══════════════════════════════════════════════════════════
    # 特殊值检查
    # ═══════════════════════════════════════════════════════════
    
    # 判断是否为正数（明显大于零）
    # @param Value: 要检查的值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 Value > Epsilon 则返回 true
    IsPositive<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (Value > Epsilon) then true else false
    
    # 判断是否为负数（明显小于零）
    # @param Value: 要检查的值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 Value < -Epsilon 则返回 true
    IsNegative<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (Value < -1.0 * Epsilon) then true else false
    
    # 判断是否为非负数（大于等于零，容差范围内）
    # @param Value: 要检查的值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 Value >= -Epsilon 则返回 true
    IsNonNegative<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (Value >= -1.0 * Epsilon) then true else false
    
    # 判断是否为非正数（小于等于零，容差范围内）
    # @param Value: 要检查的值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: 如果 Value <= Epsilon 则返回 true
    IsNonPositive<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (Value <= Epsilon) then true else false
