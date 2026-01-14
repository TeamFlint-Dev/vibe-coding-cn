# 向量数学工具模块
# 功能：向量操作、距离计算

using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

MathVectors<public> := module:
    
    # ========== 基础计算 ==========
    
    # 计算向量长度的平方
    LengthSquared<public>(V:vector3)<computes>:float =
        Length(V) * Length(V)
    
    # 计算两向量距离的平方
    DistanceSquaredBetween<public>(A:vector3, B:vector3)<computes>:float =
        Dist := Distance(A, B)
        Dist * Dist
    
    # ========== 向量插值 (需要 transacts 效果) ==========
    
    # 向量线性插值
    LerpVector<public>(From:vector3, To:vector3, Alpha:float)<transacts>:vector3 =
        vector3{
            X := Lerp(From.X, To.X, Alpha)
            Y := Lerp(From.Y, To.Y, Alpha)
            Z := Lerp(From.Z, To.Z, Alpha)
        }
