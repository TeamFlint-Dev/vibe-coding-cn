# 时机判定模块
# 功能：完美时机、时间窗口、反应加成

using { /Verse.org/Simulation }

FishingTiming<public> := module:
    
    # ========== 常量定义 ==========
    
    PERFECT_WINDOW_MS<public>:float = 150.0
    GOOD_WINDOW_MS<public>:float = 300.0
    REACTION_BONUS_MAX<public>:float = 2.0
    EARLY_PENALTY<public>:float = 0.5
    LATE_PENALTY<public>:float = 0.7
    
    # ========== 数据结构 ==========
    
    timing_result<public> := struct<computes>:
        IsPerfect<public>:logic = false
        IsGood<public>:logic = false
        ReactionTime<public>:float = 0.0
        Bonus<public>:float = 1.0
    
    # ========== 时机判定 ==========
    
    CheckPerfectTiming<public>(ReactionTime:float, OptimalTime:float, WindowMS:float)<decides><transacts>:void =
        Diff := if (ReactionTime > OptimalTime) then ReactionTime - OptimalTime else OptimalTime - ReactionTime
        DiffMS := Diff * 1000.0
        DiffMS <= WindowMS
    
    CheckGoodTiming<public>(ReactionTime:float, OptimalTime:float)<decides><transacts>:void =
        Diff := if (ReactionTime > OptimalTime) then ReactionTime - OptimalTime else OptimalTime - ReactionTime
        DiffMS := Diff * 1000.0
        DiffMS <= GOOD_WINDOW_MS
    
    CalculateTimingAccuracy<public>(ReactionTime:float, OptimalTime:float, WindowMS:float)<computes>:float =
        Diff := if (ReactionTime > OptimalTime) then ReactionTime - OptimalTime else OptimalTime - ReactionTime
        DiffMS := Diff * 1000.0
        Result := Clamp(1.0 - DiffMS / WindowMS, 0.0, 1.0)
        return Result
    
    GetTimingRank<public>(Accuracy:float)<computes>:int =
        Result :=
            if (Accuracy >= 0.95) then 5
            else if (Accuracy >= 0.85) then 4
            else if (Accuracy >= 0.7) then 3
            else if (Accuracy >= 0.5) then 2
            else 1
        return Result
    
    # ========== 反应时间分析 ==========
    
    CalculateReactionBonus<public>(ReactionTime:float, BaselineTime:float)<computes>:float =
        if (ReactionTime < BaselineTime):
            Improvement := (BaselineTime - ReactionTime) / BaselineTime
            Bonus := Min(Improvement * REACTION_BONUS_MAX, REACTION_BONUS_MAX)
            Result := 1.0 + Bonus
            return Result
        else:
            return 1.0
    
    IsFastReaction<public>(ReactionTime:float, ThresholdMS:float)<decides><transacts>:void =
        ReactionMS := ReactionTime * 1000.0
        ReactionMS <= ThresholdMS
    
    CalculateAverageReactionTime<public>(Times:[]float)<computes>:float =
        if (Length(Times) = 0):
            return 0.0
        Sum := 0.0
        for (Time : Times):
            set Sum += Time
        Result := Sum / (Length(Times) * 1.0)
        return Result
    
    # ========== 时间窗口管理 ==========
    
    CalculateDynamicWindow<public>(Difficulty:float, PlayerSkill:int)<computes>:float =
        BaseDiff := Difficulty * 0.5
        SkillBonus := Min(PlayerSkill * 0.01 * 1.0, 0.2)
        WindowModifier := 1.0 - BaseDiff + SkillBonus
        Result := Clamp(PERFECT_WINDOW_MS * WindowModifier, 50.0, 500.0)
        return Result
    
    CheckInWindow<public>(ElapsedTime:float, WindowStart:float, WindowEnd:float)<decides><transacts>:void =
        ElapsedTime >= WindowStart
        ElapsedTime <= WindowEnd
    
    CalculateWindowProgress<public>(ElapsedTime:float, WindowStart:float, WindowEnd:float)<computes>:float =
        if (ElapsedTime < WindowStart):
            return 0.0
        else if (ElapsedTime > WindowEnd):
            return 1.0
        else:
            Duration := WindowEnd - WindowStart
            Progress := (ElapsedTime - WindowStart) / Duration
            Result := Clamp(Progress, 0.0, 1.0)
            return Result
    
    # ========== 早晚惩罚 ==========
    
    CalculateEarlyPenalty<public>(EarlyTime:float, WindowStart:float)<computes>:float =
        if (EarlyTime >= WindowStart):
            return 1.0
        EarlyAmount := WindowStart - EarlyTime
        Penalty := Min(EarlyAmount * 2.0, EARLY_PENALTY)
        Result := 1.0 - Penalty
        return Result
    
    CalculateLatePenalty<public>(LateTime:float, WindowEnd:float)<computes>:float =
        if (LateTime <= WindowEnd):
            return 1.0
        LateAmount := LateTime - WindowEnd
        Penalty := Min(LateAmount * 3.0, LATE_PENALTY)
        Result := 1.0 - Penalty
        return Result
    
    IsEarlyInput<public>(InputTime:float, OptimalTime:float)<decides><transacts>:void =
        InputTime < OptimalTime
    
    IsLateInput<public>(InputTime:float, OptimalTime:float)<decides><transacts>:void =
        InputTime > OptimalTime
    
    # ========== 连续时机判定 ==========
    
    CalculateConsistencyBonus<public>(TimingScores:[]float)<computes>:float =
        if (Length(TimingScores) < 2):
            return 1.0
        Variance := 0.0
        Avg := CalculateAverageReactionTime(TimingScores)
        for (Score : TimingScores):
            Diff := Score - Avg
            set Variance += Diff * Diff
        set Variance = Variance / (Length(TimingScores) * 1.0)
        StdDev := Sqrt(Variance)
        ConsistencyScore := Max(1.0 - StdDev, 0.5)
        Result := ConsistencyScore * 0.5 + 0.5
        return Result
    
    CountPerfectTimings<public>(Results:[]timing_result)<computes>:int =
        Count := 0
        for (Result : Results):
            if (Result.IsPerfect):
                set Count += 1
        return Count
    
    # ========== 工具函数 ==========
    
    MakeTimingResult<public>(IsPerfect:logic, IsGood:logic, ReactionTime:float, Bonus:float)<transacts>:timing_result =
        Result := timing_result{
            IsPerfect := IsPerfect
            IsGood := IsGood
            ReactionTime := ReactionTime
            Bonus := Bonus
        }
        return Result
    
    CalculateTimingScore<public>(Accuracy:float, Bonus:float, Combo:int)<computes>:float =
        BaseScore := Accuracy * 100.0
        BonusScore := BaseScore * (Bonus - 1.0)
        ComboBonus := Min(Combo * 2.0 * 1.0, 20.0)
        Result := BaseScore + BonusScore + ComboBonus
        return Result
