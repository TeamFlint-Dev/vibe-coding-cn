# VectorUtils - 向量工具模块
# 版本: 1.2
# 来源: 模板预置
# 更新: 重命名冲突函数，避免与 SpatialMath 标准库冲突

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
    GetDistance<public>(A:vector3, B:vector3):float =
        Distance(A, B)  # 调用标准库的 Distance
    
    # 计算两点间距离的平方（避免开方，用于比较）
    GetDistanceSquared<public>(A:vector3, B:vector3):float =
        DistanceSquared(A, B)  # 调用标准库的 DistanceSquared
    
    # 判断是否在范围内
    IsInRange<public>(From:vector3, To:vector3, Range:float):logic =
        if (DistanceSquared(From, To) <= Range * Range):
            true
        else:
            false
    
    # 获取从 From 指向 To 的方向向量（单位化）
    Direction<public>(From:vector3, To:vector3):vector3 =
        Diff := To - From
        Len := Diff.Length()
        if (Len > 0.0001):
            vector3{X := Diff.X / Len, Y := Diff.Y / Len, Z := Diff.Z / Len}
        else:
            Zero()
    
    # 向量线性插值
    LerpVector<public>(A:vector3, B:vector3, T:float):vector3 =
        Lerp(A, B, T)  # 调用标准库的 Lerp
    
    # 注意: Distance, DistanceSquared, Lerp 请直接使用 /UnrealEngine.com/Temporary/SpatialMath 标准库
