# 失败处理模块
# 功能：失败原因、惩罚计算、重试机制

using { /Verse.org/Simulation }

FishingFailed<public> := module:
    
    # ========== 常量定义 ==========
    
    BREAK_PENALTY<public>:float = 0.3
    ESCAPE_PENALTY<public>:float = 0.2
    TIMEOUT_PENALTY<public>:float = 0.1
    RETRY_COOLDOWN<public>:float = 5.0
    DURABILITY_LOSS<public>:float = 10.0
    
    # ========== 数据结构 ==========
    
    failure_result<public> := struct<computes>:
        Reason<public>:int = 0
        Penalty<public>:float = 0.0
        CanRetry<public>:logic = true
        CooldownTime<public>:float = 0.0
    
    # ========== 失败原因判定 ==========
    
    # 检查是否断线失败
    CheckLineBroken<public>(Tension:float, MaxTension:float)<decides><transacts>:void =
        Tension > MaxTension
    
    # 检查是否超时失败
    CheckTimeout<public>(ElapsedTime:float, MaxTime:float)<decides><transacts>:void =
        ElapsedTime >= MaxTime
    
    # 检查是否逃脱
    CheckFishEscaped<public>(EscapeChance:float, RandomValue:float)<decides><transacts>:void =
        RandomValue <= EscapeChance
    
    # 获取失败原因代码
    GetFailureReason<public>(LineBroken:logic, Timeout:logic, Escaped:logic)<computes>:int =
        Result :=
            if (LineBroken) then 1
            else if (Timeout) then 2
            else if (Escaped) then 3
            else 0
        return Result
    
    # ========== 惩罚计算 ==========
    
    # 计算失败惩罚
    CalculateFailurePenalty<public>(Reason:int, InvestmentValue:float)<computes>:float =
        PenaltyRate :=
            if (Reason = 1) then BREAK_PENALTY
            else if (Reason = 2) then TIMEOUT_PENALTY
            else if (Reason = 3) then ESCAPE_PENALTY
            else 0.0
        Result := InvestmentValue * PenaltyRate
        return Result
    
    # 计算耐久损失
    CalculateDurabilityLoss<public>(Reason:int, Intensity:float)<computes>:float =
        BaseLoss :=
            if (Reason = 1) then DURABILITY_LOSS * 2.0
            else if (Reason = 2) then DURABILITY_LOSS * 0.5
            else DURABILITY_LOSS
        Result := BaseLoss * Intensity
        return Result
    
    # 计算经验损失
    CalculateExpLoss<public>(Reason:int, PotentialExp:float)<computes>:float =
        if (Reason = 1):
            Result := PotentialExp * 0.1
            return Result
        else:
            return 0.0
    
    # 计算声望损失
    CalculatePrestigeLoss<public>(Reason:int, CurrentPrestige:float)<computes>:float =
        if (Reason = 1):
            Result := Min(CurrentPrestige * 0.05, 100.0)
            return Result
        else:
            return 0.0
    
    # ========== 重试机制 ==========
    
    # 检查是否可以重试
    CheckCanRetry<public>(Reason:int, AttemptsLeft:int)<decides><transacts>:void =
        AttemptsLeft > 0
        Reason <> 1
    
    # 计算重试冷却时间
    CalculateRetryCooldown<public>(FailureCount:int)<computes>:float =
        Multiplier := 1.0 + (FailureCount - 1) * 0.5 * 1.0
        Result := RETRY_COOLDOWN * Multiplier
        return Result
    
    # 计算重试成本
    CalculateRetryCost<public>(BaseCost:float, RetryCount:int)<computes>:float =
        CostMult := Pow(1.5, RetryCount * 1.0)
        Result := BaseCost * CostMult
        return Result
    
    # 减少剩余重试次数
    DecrementRetries<public>(Current:int)<computes>:int =
        Result := Max(Current - 1, 0)
        return Result
    
    # ========== 失败分析 ==========
    
    # 分析失败模式
    AnalyzeFailurePattern<public>(Reasons:[]int)<computes>:int =
        if (Length(Reasons) = 0):
            return 0
        BreakCount := 0
        TimeoutCount := 0
        EscapeCount := 0
        for (Reason : Reasons):
            if (Reason = 1):
                set BreakCount += 1
            else if (Reason = 2):
                set TimeoutCount += 1
            else if (Reason = 3):
                set EscapeCount += 1
        MaxCount := Max(Max(BreakCount, TimeoutCount), EscapeCount)
        if (MaxCount = BreakCount):
            return 1
        else if (MaxCount = TimeoutCount):
            return 2
        else:
            return 3
    
    # 计算失败率
    CalculateFailureRate<public>(TotalAttempts:int, FailedAttempts:int)<computes>:float =
        if (TotalAttempts = 0):
            return 0.0
        Result := (FailedAttempts * 1.0) / (TotalAttempts * 1.0)
        return Result
    
    # ========== 工具函数 ==========
    
    # 创建失败结果
    MakeFailureResult<public>(Reason:int, Penalty:float, CanRetry:logic, Cooldown:float)<transacts>:failure_result =
        Result := failure_result{
            Reason := Reason
            Penalty := Penalty
            CanRetry := CanRetry
            CooldownTime := Cooldown
        }
        return Result
