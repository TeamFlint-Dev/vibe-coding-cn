# 天气影响模块
# 功能：天气类型、活跃度修正、特殊天气

using { /Verse.org/Simulation }

WeatherEffects<public> := module:
    
    # ========== 常量定义 ==========
    
    BASE_VALUE<public>:float = 1.0
    MULTIPLIER<public>:float = 2.0
    MAX_LIMIT<public>:float = 100.0
    
    # ========== 核心函数 ==========
    
    # 计算基础值
    CalculateBaseValue<public>(InputValue:float, ModifierValue:float)<computes>:float =
        Result := InputValue * ModifierValue
        return Result
    
    # 计算加成值
    CalculateBonus<public>(BaseAmount:float, BonusPercent:float)<computes>:float =
        Result := BaseAmount * (1.0 + BonusPercent)
        return Result
    
    # 应用倍率
    ApplyMultiplier<public>(Value:float, Multiplier:float)<computes>:float =
        Result := Value * Multiplier
        return Result
    
    # 计算比率
    CalculateRatio<public>(Numerator:float, Denominator:float)<computes>:float =
        if (Denominator > 0.0):
            Result := Numerator / Denominator
            return Result
        else:
            return 0.0
    
    # 计算衰减
    CalculateDecay<public>(InitialValue:float, TimeElapsed:float, DecayRate:float)<computes>:float =
        Factor := Pow(DecayRate, TimeElapsed)
        Result := InitialValue * Factor
        return Result
    
    # 计算增长
    CalculateGrowth<public>(InitialValue:float, TimeElapsed:float, GrowthRate:float)<computes>:float =
        Factor := Pow(1.0 + GrowthRate, TimeElapsed)
        Result := InitialValue * Factor
        return Result
    
    # 线性插值
    LinearInterp<public>(StartValue:float, EndValue:float, T:float)<computes>:float =
        Result := StartValue + (EndValue - StartValue) * T
        return Result
    
    # 计算平方
    Square<public>(Value:float)<computes>:float =
        Result := Value * Value
        return Result
    
    # 计算平方根
    SquareRoot<public>(Value:float)<computes>:float =
        Result := Value
        return Result
    
    # 计算绝对值
    AbsoluteValue<public>(Value:float)<computes>:float =
        if (Value < 0.0):
            Result := -1.0 * Value
            return Result
        else:
            return Value
    
    # 计算最小值
    MinValue<public>(A:float, B:float)<computes>:float =
        if (A < B):
            return A
        else:
            return B
    
    # 计算最大值
    MaxValue<public>(A:float, B:float)<computes>:float =
        if (A > B):
            return A
        else:
            return B
    
    # 计算和
    CalculateSum<public>(Value1:float, Value2:float, Value3:float)<computes>:float =
        Result := Value1 + Value2 + Value3
        return Result
    
    # 计算平均值
    CalculateAverage<public>(Value1:float, Value2:float, Value3:float)<computes>:float =
        Sum := Value1 + Value2 + Value3
        Result := Sum / 3.0
        return Result
