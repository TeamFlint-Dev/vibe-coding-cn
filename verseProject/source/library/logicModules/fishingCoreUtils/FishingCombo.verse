# 连击系统模块
# 功能：连击计数、连击加成、连击重置

using { /Verse.org/Simulation }

FishingCombo<public> := module:
    
    # ========== 常量定义 ==========
    
    MAX_COMBO<public>:int = 99
    COMBO_DECAY_TIME<public>:float = 30.0
    COMBO_MULTIPLIER_BASE<public>:float = 0.05
    PERFECT_COMBO_BONUS<public>:float = 0.1
    SUPER_COMBO_THRESHOLD<public>:int = 20
    
    # ========== 数据结构 ==========
    
    combo_state<public> := struct<computes>:
        Count<public>:int = 0
        Multiplier<public>:float = 1.0
        TimeSinceLastCatch<public>:float = 0.0
        BestCombo<public>:int = 0
    
    # ========== 连击计数 ==========
    
    # 增加连击数
    IncrementCombo<public>(CurrentCombo:int)<computes>:int =
        Result := Min(CurrentCombo + 1, MAX_COMBO)
        return Result
    
    # 重置连击
    ResetCombo<public>()<computes>:int =
        return 0
    
    # 检查连击是否有效
    IsComboActive<public>(TimeSinceLastCatch:float)<decides><transacts>:void =
        TimeSinceLastCatch < COMBO_DECAY_TIME
    
    # 更新最佳连击记录
    UpdateBestCombo<public>(CurrentCombo:int, BestCombo:int)<computes>:int =
        Result := Max(CurrentCombo, BestCombo)
        return Result
    
    # ========== 连击加成计算 ==========
    
    # 计算连击倍率
    CalculateComboMultiplier<public>(ComboCount:int)<computes>:float =
        BaseBonus := ComboCount * 1.0 * COMBO_MULTIPLIER_BASE
        Result := 1.0 + Min(BaseBonus, 3.0)
        return Result
    
    # 计算完美连击奖励
    CalculatePerfectComboBonus<public>(PerfectCount:int, TotalCount:int)<computes>:float =
        if (TotalCount = 0):
            return 1.0
        PerfectRate := (PerfectCount * 1.0) / (TotalCount * 1.0)
        if (PerfectRate >= 0.8):
            Result := 1.0 + PERFECT_COMBO_BONUS * PerfectRate
            return Result
        else:
            return 1.0
    
    # 计算超级连击奖励
    CalculateSuperComboBonus<public>(ComboCount:int)<computes>:float =
        if (ComboCount >= SUPER_COMBO_THRESHOLD):
            ExtraCombo := ComboCount - SUPER_COMBO_THRESHOLD
            Bonus := 1.0 + (ExtraCombo * 1.0 * 0.02)
            Result := Min(Bonus, 2.0)
            return Result
        else:
            return 1.0
    
    # 计算连击总奖励
    CalculateTotalComboBonus<public>(BaseMultiplier:float, PerfectBonus:float, SuperBonus:float)<computes>:float =
        Result := BaseMultiplier * PerfectBonus * SuperBonus
        return Result
    
    # ========== 连击等级 ==========
    
    # 获取连击等级
    GetComboRank<public>(ComboCount:int)<computes>:int =
        Result :=
            if (ComboCount >= 50) then 6
            else if (ComboCount >= 30) then 5
            else if (ComboCount >= 20) then 4
            else if (ComboCount >= 10) then 3
            else if (ComboCount >= 5) then 2
            else if (ComboCount >= 2) then 1
            else 0
        return Result
    
    # 检查是否达到连击里程碑
    IsComboMilestone<public>(ComboCount:int)<decides><transacts>:void =
        Remainder := ComboCount mod 10
        Remainder = 0
        ComboCount > 0
    
    # ========== 连击衰减 ==========
    
    # 计算连击衰减
    CalculateComboDecay<public>(TimeSinceLastCatch:float, DecayRate:float)<computes>:float =
        if (TimeSinceLastCatch >= COMBO_DECAY_TIME):
            return 0.0
        DecayAmount := TimeSinceLastCatch * DecayRate
        Result := Max(1.0 - DecayAmount, 0.0)
        return Result
    
    # 检查连击是否应该重置
    ShouldResetCombo<public>(TimeSinceLastCatch:float, Failed:logic)<decides><transacts>:void =
        if (Failed):
            true
        else:
            TimeSinceLastCatch >= COMBO_DECAY_TIME
    
    # ========== 连击统计 ==========
    
    # 计算平均连击长度
    CalculateAverageCombo<public>(ComboHistory:[]int)<computes>:float =
        if (Length(ComboHistory) = 0):
            return 0.0
        Sum := 0.0
        for (Combo : ComboHistory):
            set Sum += Combo * 1.0
        Result := Sum / (Length(ComboHistory) * 1.0)
        return Result
    
    # 统计连击达成次数
    CountComboAchievements<public>(ComboHistory:[]int, Threshold:int)<computes>:int =
        Count := 0
        for (Combo : ComboHistory):
            if (Combo >= Threshold):
                set Count += 1
        return Count
    
    # ========== 工具函数 ==========
    
    # 创建连击状态
    MakeComboState<public>(Count:int, Multiplier:float, TimeSince:float, Best:int)<transacts>:combo_state =
        Result := combo_state{
            Count := Count
            Multiplier := Multiplier
            TimeSinceLastCatch := TimeSince
            BestCombo := Best
        }
        return Result
    
    # 更新连击状态
    UpdateComboState<public>(State:combo_state, NewCount:int, DeltaTime:float)<transacts>:combo_state =
        NewMult := CalculateComboMultiplier(NewCount)
        NewTime := if (NewCount > State.Count) then 0.0 else State.TimeSinceLastCatch + DeltaTime
        NewBest := UpdateBestCombo(NewCount, State.BestCombo)
        Result := combo_state{
            Count := NewCount
            Multiplier := NewMult
            TimeSinceLastCatch := NewTime
            BestCombo := NewBest
        }
        return Result
