# CurveBuilder - 曲线基础接口
# 版本: 1.0
# 说明: 定义曲线系统的核心接口和基类

using { /Verse.org/Simulation }
using { /Verse.org/Verse }

# 曲线基类 - 所有曲线类型的抽象基类
curve_1d<public> := class<abstract>:
    # 核心方法：计算 t 时刻的曲线值（t ∈ [0, 1]）
    Evaluate<public><abstract>(T:float)<computes>:float
    
    # 获取曲线总时长（秒）
    GetDuration<public>()<computes>:float = 1.0
    
    # 获取 t 时刻的切线（导数，用于速度计算）
    GetTangent<public>(T:float)<computes>:float =
        Epsilon := 0.001
        V1 := Evaluate(T)
        V2 := Evaluate(T + Epsilon)
        (V2 - V1) / Epsilon

# 线性曲线（Linear Curve）
linear_curve_1d<public> := class<final>(curve_1d):
    Start<public>:float = 0.0
    End<public>:float = 1.0
    
    Evaluate<override>(T:float)<computes>:float =
        ClampedT := Clamp(T, 0.0, 1.0)
        Start + (End - Start) * ClampedT

# 三次贝塞尔曲线（Cubic Bezier Curve）
cubic_bezier_curve_1d<public> := class<final>(curve_1d):
    P0<public>:float = 0.0  # 起点
    P1<public>:float = 0.0  # 控制点1
    P2<public>:float = 1.0  # 控制点2
    P3<public>:float = 1.0  # 终点
    
    Evaluate<override>(T:float)<computes>:float =
        ClampedT := Clamp(T, 0.0, 1.0)
        U := 1.0 - ClampedT
        T2 := ClampedT * ClampedT
        T3 := T2 * ClampedT
        U2 := U * U
        U3 := U2 * U
        U3 * P0 + 3.0 * U2 * ClampedT * P1 + 3.0 * U * T2 * P2 + T3 * P3

# 正弦曲线（Sinusoidal Curve）
sinusoidal_curve_1d<public> := class<final>(curve_1d):
    Amplitude<public>:float = 1.0      # 振幅
    Frequency<public>:float = 1.0      # 频率（Hz）
    Phase<public>:float = 0.0          # 相位偏移（弧度）
    Offset<public>:float = 0.0         # 垂直偏移
    
    Evaluate<override>(T:float)<computes>:float =
        ClampedT := Clamp(T, 0.0, 1.0)
        Amplitude * Sin(2.0 * Pi * Frequency * ClampedT + Phase) + Offset
