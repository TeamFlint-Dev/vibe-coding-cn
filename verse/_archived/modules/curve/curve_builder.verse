# CurveBuilder - 曲线构造器工厂
# 版本: 1.0
# 说明: 提供便捷的曲线构造方法

using { /Verse.org/Simulation }
using { /Verse.org/Verse }

# 缓动类型枚举
easing_type<public> := enum:
    Linear
    EaseIn
    EaseOut
    EaseInOut

# 曲线构造器模块（工厂模式）
curve_builder<public> := module:
    # === 1D曲线工厂 ===
    
    # 创建线性曲线
    Linear<public>(Start:float, End:float)<computes>:linear_curve_1d =
        linear_curve_1d{Start := Start, End := End}
    
    # 创建三次贝塞尔曲线
    CubicBezier<public>(P0:float, P1:float, P2:float, P3:float)<computes>:cubic_bezier_curve_1d =
        cubic_bezier_curve_1d{P0 := P0, P1 := P1, P2 := P2, P3 := P3}
    
    # 创建正弦曲线
    Sine<public>(Amplitude:float, Frequency:float, Phase:float, Offset:float)<computes>:sinusoidal_curve_1d =
        sinusoidal_curve_1d{
            Amplitude := Amplitude, 
            Frequency := Frequency, 
            Phase := Phase, 
            Offset := Offset
        }
    
    # === 语义构造 ===
    
    # 创建缓动曲线
    EasingCurve<public>(Start:float, End:float, Type:easing_type)<computes>:curve_1d =
        if (Type = easing_type.Linear):
            Linear(Start, End)
        else if (Type = easing_type.EaseIn):
            # EaseIn: 缓入（慢启动）
            CubicBezier(Start, Start, End, End)
        else if (Type = easing_type.EaseOut):
            # EaseOut: 缓出（慢停止）
            CubicBezier(Start, Start, End, End)
        else if (Type = easing_type.EaseInOut):
            # EaseInOut: 缓入缓出
            MidPoint := (Start + End) / 2.0
            CubicBezier(Start, Lerp(Start, End, 0.42), Lerp(Start, End, 0.58), End)
        else:
            Linear(Start, End)
    
    # === 组合构造 ===
    
    # 创建串联曲线
    Sequential<public>(Segments:[]curve_segment)<computes>:sequential_curve =
        sequential_curve{Segments := Segments}
    
    # 创建加权混合曲线
    Blended<public>(Curves:[]weighted_curve)<computes>:blended_curve =
        blended_curve{Curves := Curves}
    
    # 创建叠加曲线
    Additive<public>(Curves:[]curve_1d)<computes>:additive_curve =
        additive_curve{Curves := Curves}

# 缓动预设
easing_presets<public> := module:
    # CSS标准缓动
    Ease<public>()<computes>:cubic_bezier_curve_1d = 
        cubic_bezier_curve_1d{P0 := 0.0, P1 := 0.25, P2 := 1.0, P3 := 1.0}
    
    EaseIn<public>()<computes>:cubic_bezier_curve_1d = 
        cubic_bezier_curve_1d{P0 := 0.0, P1 := 0.42, P2 := 1.0, P3 := 1.0}
    
    EaseOut<public>()<computes>:cubic_bezier_curve_1d = 
        cubic_bezier_curve_1d{P0 := 0.0, P1 := 0.0, P2 := 0.58, P3 := 1.0}
    
    EaseInOut<public>()<computes>:cubic_bezier_curve_1d = 
        cubic_bezier_curve_1d{P0 := 0.0, P1 := 0.42, P2 := 0.58, P3 := 1.0}
