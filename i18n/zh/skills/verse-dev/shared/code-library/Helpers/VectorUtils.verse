# VectorUtils - 向量工具模块
# 版本: 1.0
# 来源: 模板预置

using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

VectorUtils<public> := module:
    # 零向量
    Zero<public>():vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    # 单位向量
    One<public>():vector3 = vector3{X := 1.0, Y := 1.0, Z := 1.0}
    
    # 方向常量
    Up<public>():vector3 = vector3{X := 0.0, Y := 0.0, Z := 1.0}
    Forward<public>():vector3 = vector3{X := 1.0, Y := 0.0, Z := 0.0}
    Right<public>():vector3 = vector3{X := 0.0, Y := 1.0, Z := 0.0}
    
    # 计算两点间距离
    Distance<public>(A:vector3, B:vector3):float =
        return (B - A).Length()
    
    # 计算两点间距离的平方（避免开方，用于比较）
    DistanceSquared<public>(A:vector3, B:vector3):float =
        Diff := B - A
        return Diff.X * Diff.X + Diff.Y * Diff.Y + Diff.Z * Diff.Z
    
    # 判断是否在范围内
    IsInRange<public>(From:vector3, To:vector3, Range:float):logic =
        return DistanceSquared(From, To) <= Range * Range
    
    # 获取从 From 指向 To 的方向向量（单位化）
    Direction<public>(From:vector3, To:vector3):vector3 =
        Diff := To - From
        Len := Diff.Length()
        if Len > 0.0001:
            return vector3{X := Diff.X / Len, Y := Diff.Y / Len, Z := Diff.Z / Len}
        return Zero()
    
    # 向量线性插值
    Lerp<public>(A:vector3, B:vector3, T:float):vector3 =
        return vector3{
            X := A.X + (B.X - A.X) * T,
            Y := A.Y + (B.Y - A.Y) * T,
            Z := A.Z + (B.Z - A.Z) * T
        }
