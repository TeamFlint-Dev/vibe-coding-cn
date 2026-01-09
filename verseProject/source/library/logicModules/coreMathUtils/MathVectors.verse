# 向量数学工具模块
# 功能：向量操作、距离计算

using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

MathVectors<public> := module:
    
    # ========== 常量 ==========
    Zero<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    One<public>:vector3 = vector3{X := 1.0, Y := 1.0, Z := 1.0}
    UnitX<public>:vector3 = vector3{X := 1.0, Y := 0.0, Z := 0.0}
    UnitY<public>:vector3 = vector3{X := 0.0, Y := 1.0, Z := 0.0}
    UnitZ<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 1.0}
    
    # ========== 基础计算 ==========
    
    # 计算向量长度的平方
    LengthSquared<public>(V:vector3)<computes>:float =
        V.X * V.X + V.Y * V.Y + V.Z * V.Z
    
    # 计算两向量距离的平方
    DistanceSquaredBetween<public>(A:vector3, B:vector3)<computes>:float =
        DX := A.X - B.X
        DY := A.Y - B.Y
        DZ := A.Z - B.Z
        DX * DX + DY * DY + DZ * DZ
    
    # ========== 向量插值 (需要 transacts 效果) ==========
    
    # 向量线性插值
    LerpVector<public>(From:vector3, To:vector3, Alpha:float)<transacts>:vector3 =
        vector3{
            X := Lerp(From.X, To.X, Alpha)
            Y := Lerp(From.Y, To.Y, Alpha)
            Z := Lerp(From.Z, To.Z, Alpha)
        }
    
    # ========== 向量比较 ==========
    
    # 检查两向量是否近似相等
    IsNearlyEqual<public>(A:vector3, B:vector3, Tolerance:float)<decides><transacts>:void =
        Abs(A.X - B.X) < Tolerance
        Abs(A.Y - B.Y) < Tolerance
        Abs(A.Z - B.Z) < Tolerance
