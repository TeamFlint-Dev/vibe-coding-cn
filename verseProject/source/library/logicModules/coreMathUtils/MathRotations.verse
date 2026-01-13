# 旋转数学模块
# 功能：四元数与欧拉角转换、朝向计算

using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }

MathRotations<public> := module:
    
    # ========== 数据结构 ==========
    
    # 欧拉角表示（角度制）
    euler_angles<public> := struct<computes>:
        Pitch<public>:float = 0.0  # 俯仰角（绕Y轴）
        Yaw<public>:float = 0.0    # 偏航角（绕Z轴）
        Roll<public>:float = 0.0   # 翻滚角（绕X轴）
    
    # 方向向量
    direction_vectors<public> := struct<computes>:
        Forward<public>:vector3 = vector3{X := 1.0, Y := 0.0, Z := 0.0}
        Right<public>:vector3 = vector3{X := 0.0, Y := 1.0, Z := 0.0}
        Up<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 1.0}
    
    # ========== 角度归一化 ==========
    
    # 将角度归一化到 [-180, 180) 范围
    NormalizeAngle<public>(Angle:float)<computes>:float =
        var NormalizedAngle:float = Angle
        # 先归一化到 [0, 360)
        loop:
            if (NormalizedAngle >= 360.0):
                set NormalizedAngle -= 360.0
            else if (NormalizedAngle < 0.0):
                set NormalizedAngle += 360.0
            else:
                break
        # 再转到 [-180, 180)
        if (NormalizedAngle >= 180.0):
            NormalizedAngle - 360.0
        else:
            NormalizedAngle
    
    # 将弧度归一化到 [-π, π) 范围
    NormalizeRadians<public>(Radians:float)<computes>:float =
        PI := 3.141592653589793
        TWO_PI := 6.283185307179586
        var NormalizedRad:float = Radians
        loop:
            if (NormalizedRad >= PI):
                set NormalizedRad -= TWO_PI
            else if (NormalizedRad < -PI):
                set NormalizedRad += TWO_PI
            else:
                break
        NormalizedRad
    
    # ========== 朝向计算 ==========
    
    # 计算从位置A到位置B的水平朝向角度（Yaw）
    CalculateYawToTarget<public>(FromPos:vector3, ToPos:vector3)<computes>:float =
        Delta := vector3{X := ToPos.X - FromPos.X, Y := ToPos.Y - FromPos.Y, Z := 0.0}
        DeltaLength := Sqrt(Delta.X * Delta.X + Delta.Y * Delta.Y)
        if (DeltaLength < 0.0001):
            0.0
        else:
            # 使用 atan2 计算角度
            AngleRad := Atan(Delta.Y, Delta.X)
            RAD_TO_DEG := 57.29577951308232
            NormalizeAngle(AngleRad * RAD_TO_DEG)
    
    # 计算从位置A到位置B的俯仰角度（Pitch）
    CalculatePitchToTarget<public>(FromPos:vector3, ToPos:vector3)<computes>:float =
        DeltaXY := vector3{X := ToPos.X - FromPos.X, Y := ToPos.Y - FromPos.Y, Z := 0.0}
        HorizontalDist := Sqrt(DeltaXY.X * DeltaXY.X + DeltaXY.Y * DeltaXY.Y)
        DeltaZ := ToPos.Z - FromPos.Z
        if (HorizontalDist < 0.0001):
            if (DeltaZ > 0.0) then 90.0 else if (DeltaZ < 0.0) then -90.0 else 0.0
        else:
            AngleRad := Atan(DeltaZ, HorizontalDist)
            RAD_TO_DEG := 57.29577951308232
            NormalizeAngle(AngleRad * RAD_TO_DEG)
    
    # 计算完整的欧拉角朝向目标
    CalculateRotationToTarget<public>(FromPos:vector3, ToPos:vector3)<transacts>:euler_angles =
        euler_angles{
            Pitch := CalculatePitchToTarget(FromPos, ToPos)
            Yaw := CalculateYawToTarget(FromPos, ToPos)
            Roll := 0.0
        }
    
    # ========== 方向向量计算 ==========
    
    # 根据Yaw角度计算前向向量（水平面）
    GetForwardVectorFromYaw<public>(YawDegrees:float)<transacts>:vector3 =
        DEG_TO_RAD := 0.017453292519943295
        YawRad := YawDegrees * DEG_TO_RAD
        vector3{
            X := Cos(YawRad)
            Y := Sin(YawRad)
            Z := 0.0
        }
    
    # 根据Yaw角度计算右向向量（水平面）
    GetRightVectorFromYaw<public>(YawDegrees:float)<transacts>:vector3 =
        DEG_TO_RAD := 0.017453292519943295
        YawRad := YawDegrees * DEG_TO_RAD
        vector3{
            X := -Sin(YawRad)
            Y := Cos(YawRad)
            Z := 0.0
        }
    
    # 根据欧拉角计算方向向量组
    GetDirectionVectorsFromEuler<public>(Angles:euler_angles)<transacts>:direction_vectors =
        Forward := GetForwardVectorFromYaw(Angles.Yaw)
        Right := GetRightVectorFromYaw(Angles.Yaw)
        direction_vectors{
            Forward := Forward
            Right := Right
            Up := vector3{X := 0.0, Y := 0.0, Z := 1.0}
        }
    
    # ========== 角度运算 ==========
    
    # 计算两个角度之间的最短角度差（有符号）
    # 结果在 [-180, 180) 范围内
    AngleDifference<public>(FromAngle:float, ToAngle:float)<computes>:float =
        Diff := NormalizeAngle(ToAngle - FromAngle)
        Diff
    
    # 检查角度是否在扇形范围内
    # CenterAngle: 扇形中心角度
    # HalfAngle: 扇形半角（扇形总角度的一半）
    CheckAngleInCone<public>(TestAngle:float, CenterAngle:float, HalfAngle:float)<decides><transacts>:void =
        Diff := AngleDifference(CenterAngle, TestAngle)
        AbsDiff := if (Diff < 0.0) then -Diff else Diff
        AbsDiff <= HalfAngle
    
    # 向目标角度插值（最短路径）
    LerpAngle<public>(FromAngle:float, ToAngle:float, Alpha:float)<computes>:float =
        ClampedAlpha := Clamp(Alpha, 0.0, 1.0)
        Diff := AngleDifference(FromAngle, ToAngle)
        NormalizeAngle(FromAngle + Diff * ClampedAlpha)
