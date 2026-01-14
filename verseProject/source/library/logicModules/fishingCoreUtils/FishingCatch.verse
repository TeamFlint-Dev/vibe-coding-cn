# 捕获处理模块
# 功能：捕获成功逻辑、奖励计算、品质判定

using { /Verse.org/Simulation }

FishingCatch<public> := module:
    
    # ========== 常量定义 ==========
    
    BASE_CATCH_CHANCE<public>:float = 0.7
    QUALITY_BONUS_MULT<public>:float = 1.5
    SIZE_BONUS_FACTOR<public>:float = 0.1
    PERFECT_CATCH_THRESHOLD<public>:float = 0.95

    # ========== 数据结构 ==========

    catch_result<public> := struct<computes>:
        Success<public>:logic = false
        Quality<public>:int = 1
        SizeBonus<public>:float = 1.0
        TotalReward<public>:float = 0.0

    # ========== 核心函数 ==========

    # 计算捕获成功率
    CalculateCatchChance<public>(TensionControl:float, TimingScore:float)<computes>:float =
        ControlFactor := Clamp(TensionControl, 0.0, 1.0) * 0.5
        TimingFactor := Clamp(TimingScore / 100.0, 0.0, 1.0) * 0.5
        Result := Clamp(BASE_CATCH_CHANCE + ControlFactor + TimingFactor, 0.0, 1.0)
        return Result

    # 检查是否成功捕获
    CheckCatchSuccess<public>(CatchChance:float, RandomValue:float)<decides><transacts>:void =
        ClampedRandom := Clamp(RandomValue, 0.0, 1.0)
        ClampedRandom <= CatchChance

    # 计算品质评级
    CalculateQualityRating<public>(PerfectActions:int, TotalActions:int)<computes>:int =
        if (TotalActions = 0):
            return 1
        SuccessRate := (PerfectActions * 1.0) / (TotalActions * 1.0)
        Result :=
            if (SuccessRate >= 0.95) then 5
            else if (SuccessRate >= 0.8) then 4
            else if (SuccessRate >= 0.6) then 3
            else if (SuccessRate >= 0.4) then 2
            else 1
        return Result

    # 计算尺寸加成
    CalculateSizeBonus<public>(FishSize:float, AverageSize:float)<computes>:float =
        SizeRatio := FishSize / AverageSize
        Bonus := Max((SizeRatio - 1.0) * SIZE_BONUS_FACTOR, 0.0)
        Result := 1.0 + Bonus
        return Result

    # 计算捕获奖励
    CalculateCatchReward<public>(BaseValue:float, QualityRating:int, SizeBonus:float)<computes>:float =
        QualityMult := 1.0 + (QualityRating - 1) * 0.25 * 1.0
        Result := BaseValue * QualityMult * SizeBonus
        return Result

    # 判定是否完美捕获
    IsPerfectCatch<public>(OverallScore:float)<decides><transacts>:void =
        NormalizedScore := OverallScore / 100.0
        NormalizedScore >= PERFECT_CATCH_THRESHOLD

    # 计算经验奖励
    CalculateExpReward<public>(FishRarity:int, QualityRating:int)<computes>:float =
        BaseExp := FishRarity * 20.0 * 1.0
        QualityBonus := QualityRating * 10.0 * 1.0
        Result := BaseExp + QualityBonus
        return Result

    # 计算综合奖励倍率
    CalculateBonusMultiplier<public>(Combo:int, LuckValue:float)<computes>:float =
        ComboMult := 1.0 + Min(Combo * 0.05 * 1.0, 0.5)
        LuckMult := 1.0 + Clamp(LuckValue, 0.0, 0.3)
        Result := ComboMult * LuckMult
        return Result

    # 检查是否首次捕获该鱼种
    CheckFirstCatch<public>(FishID:int, CaughtIDs:[]int)<computes>:logic =
        for (ID : CaughtIDs):
            if (ID = FishID):
                return false
        return true

    # 计算首次捕获奖励
    CalculateFirstCatchBonus<public>(BaseReward:float)<computes>:float =
        Result := BaseReward * 2.0
        return Result

    # 创建捕获结果
    MakeCatchResult<public>(Success:logic, Quality:int, SizeBonus:float, Reward:float)<transacts>:catch_result =
        Result := catch_result{
            Success := Success
            Quality := Quality
            SizeBonus := SizeBonus
            TotalReward := Reward
        }
        return Result

