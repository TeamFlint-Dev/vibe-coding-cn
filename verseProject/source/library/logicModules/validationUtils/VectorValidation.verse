# 向量验证模块
# 功能：提供 vector3 有效性检查函数，使用 <decides> 效果进行 fail-fast 验证
# 架构：Logic 层 - 无状态纯函数，使用 <decides> 效果
# 验证：CONJ-004 (vector3 分量访问) - 已证伪，vector3 支持分量访问
# 
# 设计决策：
# - 使用 /Verse.org/SpatialMath/vector3 (官方稳定 API)
# - 使用 MathFloatComparison 处理浮点精度问题
# - 遵循 RangeValidation 的 <decides><transacts> 模式

using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

VectorValidation<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 常量定义
    # ═══════════════════════════════════════════════════════════
    
    # 默认 Epsilon - 用于浮点数比较的容差
    # 与 MathFloatComparison 保持一致
    DefaultEpsilon:float = 0.0001
    
    # 单位向量判定的容差（略宽松，因为涉及开方）
    # 允许 magnitude ∈ [1.0 - 0.001, 1.0 + 0.001]
    NormalizedEpsilon:float = 0.001
    
    # ═══════════════════════════════════════════════════════════
    # 零向量检测
    # ═══════════════════════════════════════════════════════════
    
    # 判断向量是否为零向量（所有分量接近 0）
    # @param V: 要检查的向量
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: logic - 如果是零向量返回 true
    # 
    # 使用场景：
    # - 归一化前检查（避免除零）
    # - 判断物体是否静止
    # - 检查方向向量有效性
    # 
    # 注意：使用容差判断，避免浮点精度问题
    IsZeroVector<public>(V:vector3, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        ForwardIsZero := coreMathUtils.MathFloatComparison.NearlyZero(V.Forward, ?Epsilon := Epsilon)
        LeftIsZero := coreMathUtils.MathFloatComparison.NearlyZero(V.Left, ?Epsilon := Epsilon)
        UpIsZero := coreMathUtils.MathFloatComparison.NearlyZero(V.Up, ?Epsilon := Epsilon)
        
        if (ForwardIsZero = true):
            if (LeftIsZero = true):
                if (UpIsZero = true):
                    true
                else:
                    false
            else:
                false
        else:
            false
    
    # 验证向量不是零向量（fail-fast 版本）
    # @param V: 要验证的向量
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 如果是零向量则失败
    ValidateNotZeroVector<public>(V:vector3, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        # 如果是零向量，验证失败
        if (IsZeroVector(V, ?Epsilon := Epsilon) = false):
            void
        else:
            false  # Fail if zero vector
    
    # ═══════════════════════════════════════════════════════════
    # 归一化检测
    # ═══════════════════════════════════════════════════════════
    
    # 判断向量是否为单位向量（magnitude ≈ 1.0）
    # @param V: 要检查的向量
    # @param Epsilon: 容差值（可选，默认 0.001，略宽松）
    # @returns: logic - 如果是单位向量返回 true
    # 
    # 使用场景：
    # - 验证方向向量
    # - 检查旋转轴
    # - 确认归一化操作正确性
    # 
    # 注意：使用 NormalizedEpsilon (0.001) 作为默认值，因为开方操作会累积误差
    IsNormalized<public>(V:vector3, ?Epsilon:float = NormalizedEpsilon)<reads><computes>:logic =
        Mag := V.Length()  # 使用 vector3 extension method
        coreMathUtils.MathFloatComparison.NearlyEqual(Mag, 1.0, ?Epsilon := Epsilon)
    
    # 验证向量是单位向量（fail-fast 版本）
    # @param V: 要验证的向量
    # @param Epsilon: 容差值（可选，默认 0.001）
    # @returns: void - 如果不是单位向量则失败
    ValidateNormalized<public>(V:vector3, ?Epsilon:float = NormalizedEpsilon)<reads><decides>:void =
        Mag := V.Length()
        coreMathUtils.MathFloatComparison.NearlyEqual(Mag, 1.0, ?Epsilon := Epsilon)
    
    # ═══════════════════════════════════════════════════════════
    # 特殊值检测（NaN, Infinity）
    # ═══════════════════════════════════════════════════════════
    
    # 判断向量的任意分量是否为 NaN
    # @param V: 要检查的向量
    # @returns: logic - 如果包含 NaN 返回 true
    # 
    # 使用场景：
    # - 检测计算错误（如 0/0）
    # - 调试数值稳定性问题
    # - 验证输入数据完整性
    # 
    # 注意：NaN 的特性是 NaN != NaN，因此用自比较检测
    HasNaN<public>(V:vector3)<computes>:logic =
        ForwardIsNaN := if (V.Forward = V.Forward) then false else true
        LeftIsNaN := if (V.Left = V.Left) then false else true
        UpIsNaN := if (V.Up = V.Up) then false else true
        
        # 任意分量为 NaN 即返回 true
        if (ForwardIsNaN = true):
            true
        else if (LeftIsNaN = true):
            true
        else if (UpIsNaN = true):
            true
        else:
            false
    
    # 判断向量的所有分量是否都是有限数（非 NaN 且非 Infinity）
    # @param V: 要检查的向量
    # @returns: logic - 如果所有分量都有限返回 true
    # 
    # 使用场景：
    # - 验证物理计算结果
    # - 检查输入参数合法性
    # - 确保数值稳定性
    # 
    # 检测方法：
    # - 有限数满足：value == value（排除 NaN）且 abs(value) < MaxSafeFloat
    # - Infinity 检测：abs(value) > MaxSafeFloat
    IsFinite<public>(V:vector3)<computes>:logic =
        MaxSafeFloat := 1.0e+30  # 与 MathSafe 保持一致
        
        # 检查 Forward 分量
        ForwardIsNaN := if (V.Forward = V.Forward) then false else true
        AbsForward := if (V.Forward < 0.0) then -V.Forward else V.Forward
        ForwardIsInfinity := if (AbsForward > MaxSafeFloat) then true else false
        ForwardIsFinite := if (ForwardIsNaN = false):
            if (ForwardIsInfinity = false):
                true
            else:
                false
        else:
            false
        
        # 检查 Left 分量
        LeftIsNaN := if (V.Left = V.Left) then false else true
        AbsLeft := if (V.Left < 0.0) then -V.Left else V.Left
        LeftIsInfinity := if (AbsLeft > MaxSafeFloat) then true else false
        LeftIsFinite := if (LeftIsNaN = false):
            if (LeftIsInfinity = false):
                true
            else:
                false
        else:
            false
        
        # 检查 Up 分量
        UpIsNaN := if (V.Up = V.Up) then false else true
        AbsUp := if (V.Up < 0.0) then -V.Up else V.Up
        UpIsInfinity := if (AbsUp > MaxSafeFloat) then true else false
        UpIsFinite := if (UpIsNaN = false):
            if (UpIsInfinity = false):
                true
            else:
                false
        else:
            false
        
        # 所有分量都有限才返回 true
        if (ForwardIsFinite = true):
            if (LeftIsFinite = true):
                if (UpIsFinite = true):
                    true
                else:
                    false
            else:
                false
        else:
            false
    
    # 验证向量所有分量都是有限数（fail-fast 版本）
    # @param V: 要验证的向量
    # @returns: void - 如果包含 NaN 或 Infinity 则失败
    ValidateFinite<public>(V:vector3)<decides><transacts>:void =
        if (IsFinite(V) = true):
            void
        else:
            false  # Fail if not finite
    
    # ═══════════════════════════════════════════════════════════
    # 方向向量验证
    # ═══════════════════════════════════════════════════════════
    
    # 判断向量是否可以作为方向向量使用
    # 要求：非零 + 有限 + 可归一化
    # @param V: 要检查的向量
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: logic - 如果可作为方向向量返回 true
    # 
    # 使用场景：
    # - 验证移动方向
    # - 检查视线方向
    # - 确认力的方向
    # 
    # 验证标准：
    # 1. 不是零向量（避免归一化时除零）
    # 2. 所有分量有限（无 NaN 或 Infinity）
    # 3. 注意：不要求已归一化，因为可以归一化
    IsDirection<public>(V:vector3, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        IsZero := IsZeroVector(V, ?Epsilon := Epsilon)
        Finite := IsFinite(V)
        
        # 不是零向量 且 有限
        if (IsZero = false):
            if (Finite = true):
                true
            else:
                false
        else:
            false
    
    # 验证向量可以作为方向向量（fail-fast 版本）
    # @param V: 要验证的向量
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 如果不能作为方向向量则失败
    ValidateDirection<public>(V:vector3, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        # 验证非零
        ValidateNotZeroVector[V, ?Epsilon := Epsilon]
        # 验证有限
        ValidateFinite[V]
        # 如果两个验证都通过，则成功
        void
    
    # ═══════════════════════════════════════════════════════════
    # 组合验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证向量是有效的单位方向向量
    # 要求：归一化 + 有限
    # @param V: 要验证的向量
    # @param Epsilon: 容差值（可选，默认 0.001）
    # @returns: void - 如果不是有效单位方向则失败
    # 
    # 使用场景：
    # - 验证角色朝向
    # - 检查相机方向
    # - 确认旋转轴有效性
    ValidateUnitDirection<public>(V:vector3, ?Epsilon:float = NormalizedEpsilon)<decides><transacts>:void =
        # 验证归一化 - 需要使用 IsNormalized 而非 ValidateNormalized（因为后者有 <reads> 效果）
        if (IsNormalized(V, ?Epsilon := Epsilon) = true):
            # 验证有限
            ValidateFinite[V]
            void
        else:
            false  # 未归一化，失败
