# 钓鱼小游戏模块
# 功能：QTE判定、难度系数、成功率计算

using { /Verse.org/Simulation }

FishingMinigame<public> := module:
    
    # ========== 常量定义 ==========
    
    BASE_DIFFICULTY<public>:float = 0.5
    PERFECT_WINDOW<public>:float = 0.15
    GOOD_WINDOW<public>:float = 0.3
    SUCCESS_THRESHOLD<public>:float = 0.6
    COMBO_MULTIPLIER<public>:float = 1.1
    MAX_COMBO<public>:int = 10
    
    # ========== 数据结构 ==========
    
    minigame_result<public> := struct<computes>:
        Success<public>:logic = false
        Score<public>:float = 0.0
        Rating<public>:int = 0
        ComboCount<public>:int = 0
    
    # ========== QTE判定 ==========
    
    # 检查QTE完美判定
    CalculateQTEAccuracy<public>(InputTime:float, TargetTime:float, WindowSize:float)<computes>:float =
        Diff := if (InputTime > TargetTime) then InputTime - TargetTime else TargetTime - InputTime
        Result := Clamp(1.0 - Diff / WindowSize, 0.0, 1.0)
        return Result
    
    CheckPerfectQTE<public>(Accuracy:float)<decides><transacts>:void =
        Accuracy >= 0.9
    
    CheckGoodQTE<public>(Accuracy:float)<decides><transacts>:void =
        Accuracy >= 0.7
    
    CalculateQTEScore<public>(Accuracy:float, ComboCount:int)<computes>:float =
        BaseScore := Accuracy * 100.0
        ComboBonus := Min(ComboCount * 5.0 * 1.0, 50.0)
        Result := BaseScore + ComboBonus
        return Result
    
    # ========== 难度系统 ==========
    
    CalculateDifficulty<public>(FishRarity:int, PlayerLevel:int, EnvironmentFactor:float)<computes>:float =
        RarityFactor := FishRarity * 0.15 * 1.0
        LevelReduction := Min(PlayerLevel * 0.02 * 1.0, 0.3)
        EnvMod := Clamp(EnvironmentFactor, -0.2, 0.3)
        Result := Clamp(BASE_DIFFICULTY + RarityFactor - LevelReduction + EnvMod, 0.1, 1.0)
        return Result
    
    CalculateDynamicDifficulty<public>(BaseDifficulty:float, PlayerPerformance:float, AdaptiveRate:float)<computes>:float =
        Adjustment := (PlayerPerformance - 0.5) * AdaptiveRate
        Result := Clamp(BaseDifficulty - Adjustment, 0.1, 1.0)
        return Result
    
    GetDifficultyMultiplier<public>(Difficulty:float)<computes>:float =
        Result := 1.0 + Difficulty * 2.0
        return Result
    
    # ========== 成功率计算 ==========
    
    CalculateSuccessRate<public>(Difficulty:float, PlayerSkill:int, EquipmentBonus:float)<computes>:float =
        SkillFactor := Min(PlayerSkill * 0.05 * 1.0, 0.5)
        EquipFactor := Clamp(EquipmentBonus, 0.0, 0.3)
        DifficultyPenalty := Difficulty * 0.5
        Result := Clamp(0.5 + SkillFactor + EquipFactor - DifficultyPenalty, 0.05, 0.95)
        return Result
    
    CheckMinigameSuccess<public>(Score:float, Threshold:float)<decides><transacts>:void =
        Score >= Threshold
    
    CalculateSuccessBonus<public>(Score:float, Threshold:float)<computes>:float =
        Excess := Max(Score - Threshold, 0.0)
        Result := Min(Excess * 0.5, 50.0)
        return Result
    
    # ========== 连击系统 ==========
    
    IncrementCombo<public>(CurrentCombo:int)<computes>:int =
        Result := Min(CurrentCombo + 1, MAX_COMBO)
        return Result
    
    ResetCombo<public>()<computes>:int =
        return 0
    
    CalculateComboMultiplier<public>(ComboCount:int)<computes>:float =
        Multiplier := Pow(COMBO_MULTIPLIER, Min(ComboCount * 1.0, MAX_COMBO * 1.0))
        Result := Min(Multiplier, 3.0)
        return Result
    
    GetComboRank<public>(ComboCount:int)<computes>:int =
        Result :=
            if (ComboCount >= 10) then 5
            else if (ComboCount >= 7) then 4
            else if (ComboCount >= 5) then 3
            else if (ComboCount >= 3) then 2
            else 1
        return Result
    
    # ========== 工具函数 ==========
    
    MakeMinigameResult<public>(Success:logic, Score:float, Rating:int, Combo:int)<transacts>:minigame_result =
        Result := minigame_result{
            Success := Success
            Score := Score
            Rating := Rating
            ComboCount := Combo
        }
        return Result
    
    CalculateFinalScore<public>(BaseScore:float, Difficulty:float, Combo:int)<computes>:float =
        DiffMult := GetDifficultyMultiplier(Difficulty)
        ComboMult := CalculateComboMultiplier(Combo)
        Result := BaseScore * DiffMult * ComboMult
        return Result
