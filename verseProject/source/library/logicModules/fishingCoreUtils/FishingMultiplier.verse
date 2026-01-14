# 倍率计算模块
# 功能：综合倍率、叠加规则、上限控制

using { /Verse.org/Simulation }

FishingMultiplier<public> := module:
    
    # ========== 常量定义 ==========
    
    MAX_TOTAL_MULTIPLIER<public>:float = 10.0
    ADDITIVE_MULT_CAP<public>:float = 3.0
    MULTIPLICATIVE_MULT_CAP<public>:float = 5.0
    DIMINISHING_THRESHOLD<public>:float = 2.0
    DIMINISHING_RATE<public>:float = 0.5
    
    # ========== 数据结构 ==========
    
    multiplier_breakdown<public> := struct<computes>:
        Base<public>:float = 1.0
        Equipment<public>:float = 1.0
        Skill<public>:float = 1.0
        Environment<public>:float = 1.0
        Combo<public>:float = 1.0
        Total<public>:float = 1.0
    
    # ========== 基础倍率计算 ==========
    
    # 计算加法叠加倍率
    CalculateAdditiveMultiplier<public>(Bonuses:[]float)<computes>:float =
        Sum := 0.0
        for (Bonus : Bonuses):
            set Sum += Bonus
        Result := Min(1.0 + Sum, ADDITIVE_MULT_CAP)
        return Result
    
    # 计算乘法叠加倍率
    CalculateMultiplicativeMultiplier<public>(Multipliers:[]float)<computes>:float =
        Product := 1.0
        for (Mult : Multipliers):
            set Product = Product * Mult
        Result := Min(Product, MULTIPLICATIVE_MULT_CAP)
        return Result
    
    # 计算混合倍率
    CalculateMixedMultiplier<public>(Additive:float, Multiplicative:float)<computes>:float =
        Result := Additive * Multiplicative
        return Result
    
    # ========== 递减收益系统 ==========
    
    # 计算递减收益
    CalculateDiminishingReturns<public>(Value:float, Threshold:float, Rate:float)<computes>:float =
        if (Value <= Threshold):
            return Value
        Excess := Value - Threshold
        Diminished := Excess * Rate
        Result := Threshold + Diminished
        return Result
    
    # 应用递减收益到倍率
    ApplyDiminishingToMultiplier<public>(Multiplier:float)<computes>:float =
        if (Multiplier <= DIMINISHING_THRESHOLD):
            return Multiplier
        Result := CalculateDiminishingReturns(Multiplier, DIMINISHING_THRESHOLD, DIMINISHING_RATE)
        return Result
    
    # ========== 装备倍率 ==========
    
    # 计算装备倍率
    CalculateEquipmentMultiplier<public>(RodBonus:float, BaitBonus:float, LineBonus:float)<computes>:float =
        Total := RodBonus + BaitBonus + LineBonus
        Result := 1.0 + Total
        return Result
    
    # 计算套装倍率
    CalculateSetBonus<public>(PiecesEquipped:int, TotalPieces:int, BonusPerPiece:float)<computes>:float =
        if (PiecesEquipped >= TotalPieces):
            FullSetBonus := TotalPieces * 1.0 * BonusPerPiece * 2.0
            Result := 1.0 + FullSetBonus
            return Result
        else:
            PartialBonus := PiecesEquipped * 1.0 * BonusPerPiece
            Result := 1.0 + PartialBonus
            return Result
    
    # ========== 技能倍率 ==========
    
    # 计算技能等级倍率
    CalculateSkillLevelMultiplier<public>(SkillLevel:int, BonusPerLevel:float)<computes>:float =
        Bonus := SkillLevel * 1.0 * BonusPerLevel
        Result := 1.0 + Bonus
        return Result
    
    # 计算天赋倍率
    CalculateTalentMultiplier<public>(ActiveTalents:[]float)<computes>:float =
        Result := CalculateMultiplicativeMultiplier(ActiveTalents)
        return Result
    
    # ========== 环境倍率 ==========
    
    # 计算天气倍率
    CalculateWeatherMultiplier<public>(WeatherType:int, FishPreference:int)<computes>:float =
        if (WeatherType = FishPreference):
            Result := 1.5
            return Result
        else:
            Result := 1.0
            return Result
    
    # 计算时间段倍率
    CalculateTimeMultiplier<public>(CurrentHour:int, OptimalHours:[]int)<computes>:float =
        for (Hour : OptimalHours):
            if (CurrentHour = Hour):
                return 1.3
        return 1.0
    
    # 计算钓点倍率
    CalculateSpotMultiplier<public>(SpotQuality:int, SpotLevel:int)<computes>:float =
        QualityBonus := SpotQuality * 0.1 * 1.0
        LevelBonus := SpotLevel * 0.05 * 1.0
        Result := 1.0 + QualityBonus + LevelBonus
        return Result
    
    # ========== 综合倍率 ==========
    
    # 计算总倍率
    CalculateTotalMultiplier<public>(Equipment:float, Skill:float, Environment:float, Combo:float)<computes>:float =
        Intermediate := Equipment * Skill
        Final := Intermediate * Environment * Combo
        Clamped := Min(Final, MAX_TOTAL_MULTIPLIER)
        Result := ApplyDiminishingToMultiplier(Clamped)
        return Result
    
    # 检查倍率是否达到上限
    IsMultiplierCapped<public>(Multiplier:float)<decides><transacts>:void =
        Multiplier >= MAX_TOTAL_MULTIPLIER
    
    # ========== 倍率分解 ==========
    
    # 创建倍率分解
    MakeMultiplierBreakdown<public>(Base:float, Equip:float, Skill:float, Env:float, Combo:float)<transacts>:multiplier_breakdown =
        Total := CalculateTotalMultiplier(Equip, Skill, Env, Combo)
        Result := multiplier_breakdown{
            Base := Base
            Equipment := Equip
            Skill := Skill
            Environment := Env
            Combo := Combo
            Total := Total
        }
        return Result
    
    # 获取最大贡献来源
    GetTopMultiplierSource<public>(Breakdown:multiplier_breakdown)<computes>:int =
        MaxVal := Max(Max(Max(Breakdown.Equipment, Breakdown.Skill), Breakdown.Environment), Breakdown.Combo)
        Result :=
            if (MaxVal = Breakdown.Equipment) then 1
            else if (MaxVal = Breakdown.Skill) then 2
            else if (MaxVal = Breakdown.Environment) then 3
            else 4
        return Result
    
    # 计算倍率效率
    CalculateMultiplierEfficiency<public>(ActualOutput:float, ExpectedOutput:float, Multiplier:float)<computes>:float =
        if (ExpectedOutput * Multiplier > 0.0):
            Efficiency := ActualOutput / (ExpectedOutput * Multiplier)
            Result := Clamp(Efficiency, 0.0, 1.0)
            return Result
        else:
            return 0.0
