# 插值算法模块
# 功能：各种缓动算法

using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

MathInterpolation<public> := module:

    # ========== 基础插值 ==========

    # 线性插值
    LinearInterpolate<public>(From:float, To:float, Alpha:float)<computes>:float =
        From + (To - From) * Alpha

    # ========== 缓动函数 ==========

    # 二次缓入
    EaseInQuad<public>(T:float)<computes>:float =
        T * T

    # 二次缓出
    EaseOutQuad<public>(T:float)<computes>:float =
        1.0 - (1.0 - T) * (1.0 - T)

    # 三次缓入
    EaseInCubic<public>(T:float)<computes>:float =
        T * T * T

    # 三次缓出
    EaseOutCubic<public>(T:float)<transacts>:float =
        1.0 - Pow(1.0 - T, 3.0)

    # ========== 平滑函数 ==========

    # 平滑步进
    SmoothStep<public>(T:float)<computes>:float =
        ClampedT := Clamp(T, 0.0, 1.0)
        ClampedT * ClampedT * (3.0 - 2.0 * ClampedT)

    # 更平滑的步进
    SmootherStep<public>(T:float)<computes>:float =
        ClampedT := Clamp(T, 0.0, 1.0)
        ClampedT * ClampedT * ClampedT * (ClampedT * (ClampedT * 6.0 - 15.0) + 10.0)

    # ========== 向量插值 ==========

    # 向量线性插值
    LerpVector3<public>(From:vector3, To:vector3, Alpha:float)<transacts>:vector3 =
        vector3{
            X := Lerp(From.X, To.X, Alpha)
            Y := Lerp(From.Y, To.Y, Alpha)
            Z := Lerp(From.Z, To.Z, Alpha)
        }
