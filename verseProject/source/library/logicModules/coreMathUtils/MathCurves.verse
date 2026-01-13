# 曲线与缓动函数模块
# 功能：贝塞尔曲线、缓动函数 (Easing functions)
# 架构：Logic 层 - 纯函数，无状态

MathCurves<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 常量定义
    # ═══════════════════════════════════════════════════════════
    
    Pi:float = 3.14159265359
    Epsilon:float = 0.0001
    
    # ═══════════════════════════════════════════════════════════
    # 贝塞尔曲线 (Bezier Curves)
    # ═══════════════════════════════════════════════════════════
    
    # 线性插值贝塞尔曲线 (Linear Bezier)
    # @param P0: 起点
    # @param P1: 终点
    # @param T: 插值参数 [0.0, 1.0]
    # @returns: 曲线上的点
    LinearBezier<public>(P0:float, P1:float, T:float):float =
        P0 * (1.0 - T) + P1 * T
    
    # 二次贝塞尔曲线 (Quadratic Bezier)
    # @param P0: 起点
    # @param P1: 控制点
    # @param P2: 终点
    # @param T: 插值参数 [0.0, 1.0]
    # @returns: 曲线上的点
    QuadraticBezier<public>(P0:float, P1:float, P2:float, T:float):float =
        OneMinusT := 1.0 - T
        OneMinusT * OneMinusT * P0 + 2.0 * OneMinusT * T * P1 + T * T * P2
    
    # 三次贝塞尔曲线 (Cubic Bezier)
    # @param P0: 起点
    # @param P1: 第一个控制点
    # @param P2: 第二个控制点
    # @param P3: 终点
    # @param T: 插值参数 [0.0, 1.0]
    # @returns: 曲线上的点
    CubicBezier<public>(P0:float, P1:float, P2:float, P3:float, T:float):float =
        OneMinusT := 1.0 - T
        OneMinusTSquared := OneMinusT * OneMinusT
        OneMinusTCubed := OneMinusTSquared * OneMinusT
        TSquared := T * T
        TCubed := TSquared * T
        
        OneMinusTCubed * P0 + 
        3.0 * OneMinusTSquared * T * P1 + 
        3.0 * OneMinusT * TSquared * P2 + 
        TCubed * P3
    
    # ═══════════════════════════════════════════════════════════
    # 缓动函数 (Easing Functions)
    # 所有缓动函数接收参数 T ∈ [0.0, 1.0]，返回缓动后的值
    # ═══════════════════════════════════════════════════════════
    
    # 线性缓动 (无缓动效果)
    EaseLinear<public>(T:float):float = T
    
    # ───────────────────────────────────────────────────────────
    # Sine 系列缓动
    # ───────────────────────────────────────────────────────────
    
    # Sine 缓入 (Ease In)
    EaseInSine<public>(T:float):float =
        1.0 - Cos(T * Pi / 2.0)
    
    # Sine 缓出 (Ease Out)
    EaseOutSine<public>(T:float):float =
        Sin(T * Pi / 2.0)
    
    # Sine 缓入缓出 (Ease In-Out)
    EaseInOutSine<public>(T:float):float =
        -(Cos(Pi * T) - 1.0) / 2.0
    
    # ───────────────────────────────────────────────────────────
    # Quadratic 系列缓动 (二次方)
    # ───────────────────────────────────────────────────────────
    
    # Quad 缓入
    EaseInQuad<public>(T:float):float =
        T * T
    
    # Quad 缓出
    EaseOutQuad<public>(T:float):float =
        1.0 - (1.0 - T) * (1.0 - T)
    
    # Quad 缓入缓出
    EaseInOutQuad<public>(T:float):float =
        if (T < 0.5):
            2.0 * T * T
        else:
            OneMinusT := 1.0 - T
            1.0 - 2.0 * OneMinusT * OneMinusT
    
    # ───────────────────────────────────────────────────────────
    # Cubic 系列缓动 (三次方)
    # ───────────────────────────────────────────────────────────
    
    # Cubic 缓入
    EaseInCubic<public>(T:float):float =
        T * T * T
    
    # Cubic 缓出
    EaseOutCubic<public>(T:float):float =
        OneMinusT := 1.0 - T
        1.0 - OneMinusT * OneMinusT * OneMinusT
    
    # Cubic 缓入缓出
    EaseInOutCubic<public>(T:float):float =
        if (T < 0.5):
            4.0 * T * T * T
        else:
            OneMinusT := 1.0 - T
            1.0 - 4.0 * OneMinusT * OneMinusT * OneMinusT
    
    # ───────────────────────────────────────────────────────────
    # Quartic 系列缓动 (四次方)
    # ───────────────────────────────────────────────────────────
    
    # Quartic 缓入
    EaseInQuart<public>(T:float):float =
        T * T * T * T
    
    # Quartic 缓出
    EaseOutQuart<public>(T:float):float =
        OneMinusT := 1.0 - T
        1.0 - OneMinusT * OneMinusT * OneMinusT * OneMinusT
    
    # Quartic 缓入缓出
    EaseInOutQuart<public>(T:float):float =
        if (T < 0.5):
            8.0 * T * T * T * T
        else:
            OneMinusT := 1.0 - T
            1.0 - 8.0 * OneMinusT * OneMinusT * OneMinusT * OneMinusT
    
    # ───────────────────────────────────────────────────────────
    # Exponential 系列缓动 (指数)
    # ───────────────────────────────────────────────────────────
    
    # Exponential 缓入
    EaseInExpo<public>(T:float):float =
        if (T < Epsilon):
            0.0
        else:
            Pow(2.0, 10.0 * (T - 1.0))
    
    # Exponential 缓出
    EaseOutExpo<public>(T:float):float =
        if (T > 1.0 - Epsilon):
            1.0
        else:
            1.0 - Pow(2.0, -10.0 * T)
    
    # Exponential 缓入缓出
    EaseInOutExpo<public>(T:float):float =
        if (T < Epsilon):
            0.0
        else if (T > 1.0 - Epsilon):
            1.0
        else if (T < 0.5):
            Pow(2.0, 20.0 * T - 10.0) / 2.0
        else:
            (2.0 - Pow(2.0, -20.0 * T + 10.0)) / 2.0
    
    # ───────────────────────────────────────────────────────────
    # Back 系列缓动 (回弹)
    # ───────────────────────────────────────────────────────────
    
    # Back 缓入
    EaseInBack<public>(T:float):float =
        C1 := 1.70158
        C3 := C1 + 1.0
        C3 * T * T * T - C1 * T * T
    
    # Back 缓出
    EaseOutBack<public>(T:float):float =
        C1 := 1.70158
        C3 := C1 + 1.0
        OneMinusT := 1.0 - T
        1.0 + C3 * OneMinusT * OneMinusT * OneMinusT + C1 * OneMinusT * OneMinusT
    
    # Back 缓入缓出
    EaseInOutBack<public>(T:float):float =
        C1 := 1.70158
        C2 := C1 * 1.525
        
        if (T < 0.5):
            T2 := 2.0 * T
            (T2 * T2 * ((C2 + 1.0) * T2 - C2)) / 2.0
        else:
            T2 := 2.0 * T - 2.0
            (T2 * T2 * ((C2 + 1.0) * T2 + C2) + 2.0) / 2.0
    
    # ═══════════════════════════════════════════════════════════
    # 辅助工具函数
    # ═══════════════════════════════════════════════════════════
    
    # 钳制值到 [0.0, 1.0] 范围
    ClampT<public>(T:float):float =
        if (T < 0.0):
            0.0
        else if (T > 1.0):
            1.0
        else:
            T
    
    # 值域映射：将 [0.0, 1.0] 映射到 [MinValue, MaxValue]
    MapRange<public>(T:float, MinValue:float, MaxValue:float):float =
        MinValue + T * (MaxValue - MinValue)
    
    # ═══════════════════════════════════════════════════════════
    # 曲线构建与采样系统 (Curve Construction & Sampling)
    # ═══════════════════════════════════════════════════════════
    
    # 曲线类型枚举
    # 定义支持的所有曲线类型
    curve_type<public> := enum:
        CurveLinear
        CurveInSine
        CurveOutSine
        CurveInOutSine
        CurveInQuad
        CurveOutQuad
        CurveInOutQuad
        CurveInCubic
        CurveOutCubic
        CurveInOutCubic
        CurveInQuart
        CurveOutQuart
        CurveInOutQuart
        CurveInExpo
        CurveOutExpo
        CurveInOutExpo
        CurveInBack
        CurveOutBack
        CurveInOutBack
    
    # ───────────────────────────────────────────────────────────
    # 缓动曲线采样器
    # ───────────────────────────────────────────────────────────
    
    # 根据曲线类型采样缓动曲线
    # @param CurveType: 曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 曲线在 T 处的值
    SampleEasingCurve<public>(CurveType:curve_type, T:float):float =
        ClampedT := ClampT(T)
        
        if (CurveType = curve_type.CurveLinear):
            EaseLinear(ClampedT)
        else if (CurveType = curve_type.CurveInSine):
            EaseInSine(ClampedT)
        else if (CurveType = curve_type.CurveOutSine):
            EaseOutSine(ClampedT)
        else if (CurveType = curve_type.CurveInOutSine):
            EaseInOutSine(ClampedT)
        else if (CurveType = curve_type.CurveInQuad):
            EaseInQuad(ClampedT)
        else if (CurveType = curve_type.CurveOutQuad):
            EaseOutQuad(ClampedT)
        else if (CurveType = curve_type.CurveInOutQuad):
            EaseInOutQuad(ClampedT)
        else if (CurveType = curve_type.CurveInCubic):
            EaseInCubic(ClampedT)
        else if (CurveType = curve_type.CurveOutCubic):
            EaseOutCubic(ClampedT)
        else if (CurveType = curve_type.CurveInOutCubic):
            EaseInOutCubic(ClampedT)
        else if (CurveType = curve_type.CurveInQuart):
            EaseInQuart(ClampedT)
        else if (CurveType = curve_type.CurveOutQuart):
            EaseOutQuart(ClampedT)
        else if (CurveType = curve_type.CurveInOutQuart):
            EaseInOutQuart(ClampedT)
        else if (CurveType = curve_type.CurveInExpo):
            EaseInExpo(ClampedT)
        else if (CurveType = curve_type.CurveOutExpo):
            EaseOutExpo(ClampedT)
        else if (CurveType = curve_type.CurveInOutExpo):
            EaseInOutExpo(ClampedT)
        else if (CurveType = curve_type.CurveInBack):
            EaseInBack(ClampedT)
        else if (CurveType = curve_type.CurveOutBack):
            EaseOutBack(ClampedT)
        else if (CurveType = curve_type.CurveInOutBack):
            EaseInOutBack(ClampedT)
        else:
            EaseLinear(ClampedT)
    
    # 采样缓动曲线并映射到目标值域
    # @param CurveType: 曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @param MinValue: 目标值域最小值
    # @param MaxValue: 目标值域最大值
    # @returns: 映射后的值
    SampleEasingCurveMapped<public>(CurveType:curve_type, T:float, MinValue:float, MaxValue:float):float =
        NormalizedValue := SampleEasingCurve(CurveType, T)
        MapRange(NormalizedValue, MinValue, MaxValue)
    
    # ───────────────────────────────────────────────────────────
    # 曲线运算库 (Curve Operations)
    # ───────────────────────────────────────────────────────────
    
    # 曲线段结构
    # 表示一段曲线及其在整体中的时间范围
    curve_segment<public> := struct<computes>:
        CurveType<public>:curve_type  # 曲线类型
        StartT<public>:float          # 段起始时间 [0.0, 1.0]
        EndT<public>:float            # 段结束时间 [0.0, 1.0]
    
    # 连接两条曲线（首尾相连）
    # @param FirstCurve: 第一条曲线类型
    # @param SecondCurve: 第二条曲线类型
    # @param T: 采样参数 [0.0, 1.0]，[0.0, 0.5] 采样第一条，[0.5, 1.0] 采样第二条
    # @returns: 连接后的曲线在 T 处的值
    ConcatenateCurves<public>(FirstCurve:curve_type, SecondCurve:curve_type, T:float):float =
        ClampedT := ClampT(T)
        if (ClampedT < 0.5):
            # 第一段：将 [0.0, 0.5] 映射到 [0.0, 1.0]
            LocalT := ClampedT * 2.0
            SampleEasingCurve(FirstCurve, LocalT)
        else:
            # 第二段：将 [0.5, 1.0] 映射到 [0.0, 1.0]
            LocalT := (ClampedT - 0.5) * 2.0
            SampleEasingCurve(SecondCurve, LocalT)
    
    # 采样多段连接曲线
    # @param Segments: 曲线段数组，每段指定曲线类型和时间范围
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 多段曲线在 T 处的值
    SampleMultiSegmentCurve<public>(Segments:[]curve_segment, T:float):float =
        ClampedT := ClampT(T)
        
        # 遍历所有段，找到 T 所在的段
        for (Segment : Segments):
            if (ClampedT >= Segment.StartT and ClampedT <= Segment.EndT):
                # 计算段内的局部 T
                SegmentDuration := Segment.EndT - Segment.StartT
                if (SegmentDuration > Epsilon):
                    LocalT := (ClampedT - Segment.StartT) / SegmentDuration
                    return SampleEasingCurve(Segment.CurveType, LocalT)
        
        # 如果未找到匹配的段，返回 0.0
        0.0
    
    # 加权叠加两条曲线
    # @param Curve1: 第一条曲线类型
    # @param Curve2: 第二条曲线类型
    # @param Weight1: 第一条曲线的权重 [0.0, 1.0]
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 加权叠加后的值（Weight1 * Curve1 + (1-Weight1) * Curve2）
    BlendCurves<public>(Curve1:curve_type, Curve2:curve_type, Weight1:float, T:float):float =
        ClampedT := ClampT(T)
        ClampedWeight := Clamp(Weight1, 0.0, 1.0)
        Weight2 := 1.0 - ClampedWeight
        
        Value1 := SampleEasingCurve(Curve1, ClampedT)
        Value2 := SampleEasingCurve(Curve2, ClampedT)
        
        Value1 * ClampedWeight + Value2 * Weight2
    
    # 多曲线加权平均
    # @param Curves: 曲线类型数组
    # @param Weights: 对应的权重数组（长度应与 Curves 相同）
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 加权平均后的值
    WeightedAverageCurves<public>(Curves:[]curve_type, Weights:[]float, T:float):float =
        ClampedT := ClampT(T)
        
        # 计算总权重和加权和
        var TotalWeight:float = 0.0
        var WeightedSum:float = 0.0
        
        for (I := 0..Curves.Length - 1):
            if:
                Curve := Curves[I]
                Weight := Weights[I]
            then:
                Value := SampleEasingCurve(Curve, ClampedT)
                set WeightedSum += Value * Weight
                set TotalWeight += Weight
        
        # 归一化
        if (TotalWeight > Epsilon):
            WeightedSum / TotalWeight
        else:
            0.0
    
    # 曲线相加
    # @param Curve1: 第一条曲线类型
    # @param Curve2: 第二条曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 两条曲线值的和
    AddCurves<public>(Curve1:curve_type, Curve2:curve_type, T:float):float =
        ClampedT := ClampT(T)
        Value1 := SampleEasingCurve(Curve1, ClampedT)
        Value2 := SampleEasingCurve(Curve2, ClampedT)
        Value1 + Value2
    
    # 曲线相乘
    # @param Curve1: 第一条曲线类型
    # @param Curve2: 第二条曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 两条曲线值的乘积
    MultiplyCurves<public>(Curve1:curve_type, Curve2:curve_type, T:float):float =
        ClampedT := ClampT(T)
        Value1 := SampleEasingCurve(Curve1, ClampedT)
        Value2 := SampleEasingCurve(Curve2, ClampedT)
        Value1 * Value2
    
    # 曲线取反（1.0 - curve）
    # @param CurveType: 曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 1.0 - 曲线值
    InvertCurve<public>(CurveType:curve_type, T:float):float =
        ClampedT := ClampT(T)
        Value := SampleEasingCurve(CurveType, ClampedT)
        1.0 - Value
    
    # 曲线缩放（curve * scale）
    # @param CurveType: 曲线类型
    # @param Scale: 缩放因子
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 曲线值 * 缩放因子
    ScaleCurve<public>(CurveType:curve_type, Scale:float, T:float):float =
        ClampedT := ClampT(T)
        Value := SampleEasingCurve(CurveType, ClampedT)
        Value * Scale
    
    # 曲线偏移（curve + offset）
    # @param CurveType: 曲线类型
    # @param Offset: 偏移量
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 曲线值 + 偏移量
    OffsetCurve<public>(CurveType:curve_type, Offset:float, T:float):float =
        ClampedT := ClampT(T)
        Value := SampleEasingCurve(CurveType, ClampedT)
        Value + Offset
    
    # ───────────────────────────────────────────────────────────
    # 高级曲线操作 (Advanced Curve Operations)
    # ───────────────────────────────────────────────────────────
    
    # 曲线反转（时间反向）
    # @param CurveType: 曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 在 (1.0 - T) 处采样的曲线值
    ReverseCurve<public>(CurveType:curve_type, T:float):float =
        ClampedT := ClampT(T)
        ReversedT := 1.0 - ClampedT
        SampleEasingCurve(CurveType, ReversedT)
    
    # 曲线垂直镜像（关于 y=0.5 镜像）
    # @param CurveType: 曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 1.0 - 曲线值
    MirrorCurveVertical<public>(CurveType:curve_type, T:float):float =
        InvertCurve(CurveType, T)
    
    # 曲线水平镜像（关于 x=0.5 镜像）
    # @param CurveType: 曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 在镜像位置采样的曲线值
    MirrorCurveHorizontal<public>(CurveType:curve_type, T:float):float =
        ReverseCurve(CurveType, T)
    
    # Ping-Pong 曲线（来回往返）
    # @param CurveType: 曲线类型
    # @param T: 采样参数 [0.0, 1.0]，[0.0, 0.5] 正向，[0.5, 1.0] 反向
    # @returns: Ping-pong 效果的曲线值
    PingPongCurve<public>(CurveType:curve_type, T:float):float =
        ClampedT := ClampT(T)
        if (ClampedT <= 0.5):
            # 前半段：正常播放
            LocalT := ClampedT * 2.0
            SampleEasingCurve(CurveType, LocalT)
        else:
            # 后半段：反向播放
            LocalT := (1.0 - ClampedT) * 2.0
            SampleEasingCurve(CurveType, LocalT)
    
    # 曲线循环（重复 N 次）
    # @param CurveType: 曲线类型
    # @param Cycles: 循环次数（必须 >= 1.0）
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 循环后的曲线值
    # 说明：将 T 映射到 Cycles 个重复周期中
    LoopCurve<public>(CurveType:curve_type, Cycles:float, T:float):float =
        ClampedT := ClampT(T)
        ClampedCycles := if (Cycles < 1.0) then 1.0 else Cycles
        
        # 计算缩放后的时间
        ScaledT := ClampedT * ClampedCycles
        
        # 使用循环实现取模运算（取小数部分）
        LocalT := if (ScaledT >= 1.0):
            var Temp:float = ScaledT
            loop:
                if (Temp < 1.0):
                    break
                set Temp -= 1.0
            Temp
        else:
            ScaledT
        
        SampleEasingCurve(CurveType, LocalT)
    
    # 曲线时间缩放（加速/减速）
    # @param CurveType: 曲线类型
    # @param TimeScale: 时间缩放因子（>1 加速，<1 减速）
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 时间缩放后的曲线值
    TimeScaleCurve<public>(CurveType:curve_type, TimeScale:float, T:float):float =
        ClampedT := ClampT(T)
        ScaledT := ClampT(ClampedT * TimeScale)
        SampleEasingCurve(CurveType, ScaledT)
    
    # 曲线幂运算（curve ^ power）
    # @param CurveType: 曲线类型
    # @param Power: 指数
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 曲线值的 Power 次方
    PowerCurve<public>(CurveType:curve_type, Power:float, T:float):float =
        ClampedT := ClampT(T)
        Value := SampleEasingCurve(CurveType, ClampedT)
        # 确保 Value >= 0 以避免负数的非整数次方
        ClampedValue := Max(Value, 0.0)
        Pow(ClampedValue, Power)
    
    # 曲线输出限制到范围
    # @param CurveType: 曲线类型
    # @param MinValue: 最小输出值
    # @param MaxValue: 最大输出值
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 限制在 [MinValue, MaxValue] 范围内的曲线值
    ClampCurveOutput<public>(CurveType:curve_type, MinValue:float, MaxValue:float, T:float):float =
        ClampedT := ClampT(T)
        Value := SampleEasingCurve(CurveType, ClampedT)
        Clamp(Value, MinValue, MaxValue)
    
    # 两条曲线取最小值
    # @param Curve1: 第一条曲线类型
    # @param Curve2: 第二条曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 两条曲线值的最小值
    MinCurves<public>(Curve1:curve_type, Curve2:curve_type, T:float):float =
        ClampedT := ClampT(T)
        Value1 := SampleEasingCurve(Curve1, ClampedT)
        Value2 := SampleEasingCurve(Curve2, ClampedT)
        Min(Value1, Value2)
    
    # 两条曲线取最大值
    # @param Curve1: 第一条曲线类型
    # @param Curve2: 第二条曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 两条曲线值的最大值
    MaxCurves<public>(Curve1:curve_type, Curve2:curve_type, T:float):float =
        ClampedT := ClampT(T)
        Value1 := SampleEasingCurve(Curve1, ClampedT)
        Value2 := SampleEasingCurve(Curve2, ClampedT)
        Max(Value1, Value2)
    
    # 动态混合曲线（使用第三条曲线控制混合权重）
    # @param Curve1: 第一条曲线类型
    # @param Curve2: 第二条曲线类型
    # @param BlendCurve: 控制混合的曲线类型（0.0 = Curve1, 1.0 = Curve2）
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 动态混合后的曲线值
    DynamicBlendCurves<public>(Curve1:curve_type, Curve2:curve_type, BlendCurve:curve_type, T:float):float =
        ClampedT := ClampT(T)
        Value1 := SampleEasingCurve(Curve1, ClampedT)
        Value2 := SampleEasingCurve(Curve2, ClampedT)
        BlendWeight := SampleEasingCurve(BlendCurve, ClampedT)
        ClampedWeight := Clamp(BlendWeight, 0.0, 1.0)
        
        Value1 * (1.0 - ClampedWeight) + Value2 * ClampedWeight
    
    # Smoothstep 插值（Hermite 插值）
    # @param Edge0: 起始边界
    # @param Edge1: 结束边界
    # @param T: 采样参数
    # @returns: Smoothstep 插值结果
    Smoothstep<public>(Edge0:float, Edge1:float, T:float):float =
        ClampedT := Clamp((T - Edge0) / (Edge1 - Edge0), 0.0, 1.0)
        ClampedT * ClampedT * (3.0 - 2.0 * ClampedT)
    
    # 使用 Smoothstep 的曲线过渡
    # @param CurveType: 曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 应用 smoothstep 后的曲线值
    SmoothstepCurve<public>(CurveType:curve_type, T:float):float =
        ClampedT := ClampT(T)
        # 先对时间应用 smoothstep，再采样曲线
        SmoothedT := Smoothstep(0.0, 1.0, ClampedT)
        SampleEasingCurve(CurveType, SmoothedT)
    
    # 曲线差值（Curve1 - Curve2）
    # @param Curve1: 第一条曲线类型
    # @param Curve2: 第二条曲线类型
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 两条曲线值的差
    SubtractCurves<public>(Curve1:curve_type, Curve2:curve_type, T:float):float =
        ClampedT := ClampT(T)
        Value1 := SampleEasingCurve(Curve1, ClampedT)
        Value2 := SampleEasingCurve(Curve2, ClampedT)
        Value1 - Value2
    
    # 曲线除法（Curve1 / Curve2，带保护）
    # @param Curve1: 第一条曲线类型（分子）
    # @param Curve2: 第二条曲线类型（分母）
    # @param DefaultValue: 当分母为零时的默认值
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 两条曲线值的商，分母为零时返回默认值
    DivideCurves<public>(Curve1:curve_type, Curve2:curve_type, DefaultValue:float, T:float):float =
        ClampedT := ClampT(T)
        Value1 := SampleEasingCurve(Curve1, ClampedT)
        Value2 := SampleEasingCurve(Curve2, ClampedT)
        
        if (Abs(Value2) > Epsilon):
            Value1 / Value2
        else:
            DefaultValue
    
    # 曲线平均值（多条曲线的简单平均）
    # @param Curves: 曲线类型数组
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 所有曲线值的平均值
    AverageCurves<public>(Curves:[]curve_type, T:float):float =
        ClampedT := ClampT(T)
        
        Length := Curves.Length
        if (Length = 0):
            return 0.0
        
        var Sum:float = 0.0
        var Count:float = 0.0
        for (Curve : Curves):
            Value := SampleEasingCurve(Curve, ClampedT)
            set Sum += Value
            set Count += 1.0
        
        if (Count > 0.0):
            Sum / Count
        else:
            0.0
    
    # 曲线序列链接（使用自定义分段点）
    # @param Curves: 曲线类型数组
    # @param SplitPoints: 分段点数组（递增，范围 [0.0, 1.0]）
    # @param T: 采样参数 [0.0, 1.0]
    # @returns: 链接后的曲线值
    ChainCurvesCustom<public>(Curves:[]curve_type, SplitPoints:[]float, T:float):float =
        ClampedT := ClampT(T)
        
        if (Curves.Length = 0):
            return 0.0
        
        # 找到 T 所在的区间
        for (I := 0..Curves.Length - 1):
            if:
                StartPoint := if (I = 0) then 0.0 else SplitPoints[I - 1]
                EndPoint := if (I = Curves.Length - 1) then 1.0 else SplitPoints[I]
                Curve := Curves[I]
            then:
                if (ClampedT >= StartPoint and ClampedT <= EndPoint):
                    # 计算段内的局部 T
                    SegmentDuration := EndPoint - StartPoint
                    if (SegmentDuration > Epsilon):
                        LocalT := (ClampedT - StartPoint) / SegmentDuration
                        return SampleEasingCurve(Curve, LocalT)
        
        # 默认返回最后一条曲线的终点值
        if:
            LastCurve := Curves[Curves.Length - 1]
        then:
            SampleEasingCurve(LastCurve, 1.0)
        else:
            0.0
