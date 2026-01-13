# 旋转数学模块
# 功能：四元数与欧拉角转换、朝向计算
# 注意：简化实现，避免复杂的 Verse 语法限制

using { /Verse.org/Simulation }

MathRotations<public> := module:
    
    # ========== 数据结构 ==========
    
    # 欧拉角（角度制）
    euler_angles<public> := struct<computes>:
        Pitch<public>:float = 0.0  # 俯仰角
        Yaw<public>:float = 0.0    # 偏航角
        Roll<public>:float = 0.0   # 翻滚角
    
    # ========== 角度归一化 ==========
    
    # 将角度归一化到 [0, 360) 范围
    NormalizeAngle360<public>(Angle:float)<computes>:float =
        if (Angle >= 0.0):
            if (Angle < 360.0) then Angle else Angle - 360.0
        else:
            Angle + 360.0
    
    # 将角度归一化到 [-180, 180) 范围
    NormalizeAngle180<public>(Angle:float)<computes>:float =
        Normalized := NormalizeAngle360(Angle)
        if (Normalized >= 180.0):
            Normalized - 360.0
        else:
            Normalized
    
    # ========== 角度差值计算 ==========
    
    # 计算两个角度之间的最小差值（-180 到 180）
    AngleDifference<public>(FromAngle:float, ToAngle:float)<computes>:float =
        Diff := ToAngle - FromAngle
        NormalizeAngle180(Diff)
    
    # ========== 旋转方向计算 ==========
    
    # 计算从一个方向到另一个方向的旋转方向（顺时针或逆时针）
    # 返回: 1.0 表示顺时针, -1.0 表示逆时针, 0.0 表示同向或反向
    RotationDirection2D<public>(FromX:float, FromY:float, ToX:float, ToY:float)<computes>:float =
        CrossZ := FromX * ToY - FromY * ToX
        if (CrossZ > 0.0001):
            1.0
        else if (CrossZ < -0.0001):
            -1.0
        else:
            0.0
    
    # ========== 旋转应用 ==========
    
    # 绕 Z 轴旋转二维点
    RotatePoint2D<public>(X:float, Y:float, AngleDegrees:float)<computes>:tuple(float, float) =
        AngleRad := AngleDegrees * 0.017453292519943295  # DEG_TO_RAD
        CosA := Cos(AngleRad)
        SinA := Sin(AngleRad)
        NewX := X * CosA - Y * SinA
        NewY := X * SinA + Y * CosA
        (NewX, NewY)
    
    # 创建欧拉角
    MakeEulerAngles<public>(Pitch:float, Yaw:float, Roll:float)<transacts>:euler_angles =
        euler_angles{
            Pitch := NormalizeAngle180(Pitch)
            Yaw := NormalizeAngle180(Yaw)
            Roll := NormalizeAngle180(Roll)
        }
    
    # ========== 角度插值 ==========
    
    # 球面线性插值角度（考虑环绕）
    LerpAngle<public>(FromAngle:float, ToAngle:float, Alpha:float)<computes>:float =
        Diff := AngleDifference(FromAngle, ToAngle)
        ClampedAlpha := Clamp(Alpha, 0.0, 1.0)
        Result := FromAngle + Diff * ClampedAlpha
        NormalizeAngle180(Result)
    
    # 计算角度是否在指定范围内
    IsAngleInRange<public>(Angle:float, MinAngle:float, MaxAngle:float)<decides><transacts>:void =
        NormAngle := NormalizeAngle180(Angle)
        NormMin := NormalizeAngle180(MinAngle)
        NormMax := NormalizeAngle180(MaxAngle)
        NormAngle >= NormMin
        NormAngle <= NormMax
