# 插值算法模块
# 功能：各种缓动算法

using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

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

    # 平滑步进
    SmoothStep<public>(T:float)<computes>:float =
        ClampedT := if (T < 0.0) then 0.0 else if (T > 1.0) then 1.0 else T
        ClampedT * ClampedT * (3.0 - 2.0 * ClampedT)

    # 更平滑的步进
    SmootherStep<public>(T:float)<computes>:float =
        ClampedT := if (T < 0.0) then 0.0 else if (T > 1.0) then 1.0 else T
        ClampedT * ClampedT * ClampedT * (ClampedT * (ClampedT * 6.0 - 15.0) + 10.0)

    # 向量线性插值
    LerpVector3<public>(From:vector3, To:vector3, Alpha:float)<computes>:vector3 =
        From + (To - From) * Alpha
