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
