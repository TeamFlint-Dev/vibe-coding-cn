# 鱼线强度模块
# 功能：强度等级、断裂阈值、耐久消耗

using { /Verse.org/Simulation }

LineStrength<public> := module:
    
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
    
    # 线性插值
    LinearInterp<public>(StartValue:float, EndValue:float, T:float)<computes>:float =
        Result := StartValue + (EndValue - StartValue) * T
        return Result
    
    # 计算平方
    Square<public>(Value:float)<computes>:float =
        Result := Value * Value
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
    
    # 限制值范围
    ClampValue<public>(Value:float, MinVal:float, MaxVal:float)<computes>:float =
        if (Value < MinVal):
            return MinVal
        else if (Value > MaxVal):
            return MaxVal
        else:
            return Value
    
    # 归一化值
    NormalizeValue<public>(Value:float, MinVal:float, MaxVal:float)<computes>:float =
        Range := MaxVal - MinVal
        if (Range > 0.0):
            Normalized := (Value - MinVal) / Range
            return ClampValue(Normalized, 0.0, 1.0)
        else:
            return 0.0
