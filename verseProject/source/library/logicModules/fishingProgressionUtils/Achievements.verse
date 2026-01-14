# 成就系统模块
# 功能：成就条件、成就奖励、稀有成就

using { /Verse.org/Simulation }

Achievements<public> := module:
    
    # ========== 常量定义 ==========
    
    ACHIEVEMENT_REWARD_BASE<public>:float = 100.0
    RARE_ACHIEVEMENT_MULT<public>:float = 5.0
    ACHIEVEMENT_POINT_VALUE<public>:int = 10

    # ========== 核心函数 ==========
    
    # 计算基础值
    CalculateBaseValue<public>(Input:float, Modifier:float)<computes>:float =
        Result := Input * Modifier
        return Result
    
    # 验证范围
    ValidateRange<public>(Value:float, Min:float, Max:float)<decides><transacts>:void =
        Value >= Min
        Value <= Max
    
    # 计算加成
    CalculateBonus<public>(Base:float, BonusPercent:float)<computes>:float =
        Result := Base * (1.0 + BonusPercent)
        return Result
    
    # 应用倍率
    ApplyMultiplier<public>(Value:float, Multiplier:float)<computes>:float =
        Result := Value * Multiplier
        return Result
    
    # 计算百分比
    CalculatePercent<public>(Part:float, Whole:float)<computes>:float =
        if (Whole > 0.0):
            Result := Clamp(Part / Whole, 0.0, 1.0)
            return Result
        else:
            return 0.0
    
    # 获取等级
    GetTier<public>(Value:float, Threshold1:float, Threshold2:float)<computes>:int =
        Result :=
            if (Value >= Threshold2) then 3
            else if (Value >= Threshold1) then 2
            else 1
        return Result
    
    # 计算衰减值
    CalculateDecay<public>(Initial:float, Time:float, DecayRate:float)<computes>:float =
        DecayFactor := Pow(DecayRate, Time)
        Result := Initial * DecayFactor
        return Result
    
    # 计算增长值
    CalculateGrowth<public>(Initial:float, Time:float, GrowthRate:float)<computes>:float =
        GrowthFactor := Pow(1.0 + GrowthRate, Time)
        Result := Initial * GrowthFactor
        return Result
    
    # 插值计算
    Interpolate<public>(Start:float, End:float, T:float)<computes>:float =
        ClampedT := Clamp(T, 0.0, 1.0)
        Result := Start + (End - Start) * ClampedT
        return Result
    
    # 随机范围值
    RandomInRange<public>(Min:float, Max:float, Seed:float)<computes>:float =
        Range := Max - Min
        NormalizedSeed := Clamp(Seed, 0.0, 1.0)
        Result := Min + Range * NormalizedSeed
        return Result
    
    # 计算平均值
    CalculateAverage<public>(Values:[]float)<computes>:float =
        if (Length(Values) = 0):
            return 0.0
        Sum := 0.0
        for (Val : Values):
            set Sum += Val
        Result := Sum / (Length(Values) * 1.0)
        return Result
    
    # 查找最大值
    FindMax<public>(Values:[]float)<computes>:float =
        if (Length(Values) = 0):
            return 0.0
        MaxVal := Values[0]
        for (Val : Values):
            if (Val > MaxVal):
                set MaxVal = Val
        return MaxVal
    
    # 查找最小值
    FindMin<public>(Values:[]float)<computes>:float =
        if (Length(Values) = 0):
            return 0.0
        MinVal := Values[0]
        for (Val : Values):
            if (Val < MinVal):
                set MinVal = Val
        return MinVal
    
    # 计算标准差
    CalculateStdDev<public>(Values:[]float, Mean:float)<computes>:float =
        if (Length(Values) = 0):
            return 0.0
        Variance := 0.0
        for (Val : Values):
            Diff := Val - Mean
            set Variance += Diff * Diff
        set Variance = Variance / (Length(Values) * 1.0)
        Result := Sqrt(Variance)
        return Result
    
    # 归一化值
    Normalize<public>(Value:float, Min:float, Max:float)<computes>:float =
        if (Max - Min > 0.0):
            Result := (Value - Min) / (Max - Min)
            return Clamp(Result, 0.0, 1.0)
        else:
            return 0.0
