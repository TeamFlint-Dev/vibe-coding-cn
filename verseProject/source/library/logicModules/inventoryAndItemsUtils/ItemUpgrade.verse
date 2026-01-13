# 物品强化模块
# 功能：强化成功率、强化失败惩罚逻辑

using { /Verse.org/Simulation }

ItemUpgrade<public> := module:
    
    # ========== 数据结构 ==========
    
    # 强化信息
    upgrade_info<public> := struct<computes>:
        CurrentLevel<public>:int = 0
        MaxLevel<public>:int = 10
        SuccessRate<public>:float = 1.0
        UpgradeCost<public>:int = 0
        FailurePenalty<public>:int = 0          # 0=无惩罚, 1=降级, 2=破坏
    
    # ========== 常量定义 ==========
    
    # 基础成功率
    BASE_SUCCESS_RATE<public>:float = 0.9      # 90%基础成功率
    
    # 每级成功率递减
    SUCCESS_RATE_DECAY<public>:float = 0.1     # 每级减少10%
    
    # 最低成功率
    MIN_SUCCESS_RATE<public>:float = 0.1       # 最低10%
    
    # 强化费用（指数增长）
    BASE_UPGRADE_COST<public>:int = 100
    COST_MULTIPLIER<public>:float = 1.5
    
    # 失败惩罚阈值
    SAFE_UPGRADE_LEVEL<public>:int = 5         # 5级以下无惩罚
    DOWNGRADE_LEVEL<public>:int = 8            # 8级以上失败降级
    DESTROY_LEVEL<public>:int = 12             # 12级以上失败破坏
    
    # ========== 成功率计算 ==========
    
    # 计算强化成功率
    CalculateSuccessRate<public>(CurrentLevel:int)<computes>:float =
        Decay := Floor(CurrentLevel) * SUCCESS_RATE_DECAY
        Rate := BASE_SUCCESS_RATE - Decay
        Clamp(Rate, MIN_SUCCESS_RATE, 1.0)
    
    # 使用保护道具提升成功率
    ApplyProtectionBonus<public>(BaseRate:float, BonusPercent:float)<computes>:float =
        Clamp(BaseRate + BonusPercent, 0.0, 1.0)
    
    # ========== 强化费用计算 ==========
    
    # 计算强化费用
    CalculateUpgradeCost<public>(CurrentLevel:int)<computes>:int =
        Cost := Floor(BASE_UPGRADE_COST) * Pow(COST_MULTIPLIER, Floor(CurrentLevel))
        Floor(Cost)
    
    # ========== 失败惩罚 ==========
    
    # 获取失败惩罚类型
    GetFailurePenalty<public>(CurrentLevel:int)<computes>:int =
        if (CurrentLevel >= DESTROY_LEVEL):
            2  # 破坏
        else if (CurrentLevel >= DOWNGRADE_LEVEL):
            1  # 降级
        else:
            0  # 无惩罚
    
    # 应用失败惩罚
    ApplyFailurePenalty<public>(CurrentLevel:int, PenaltyType:int)<computes>:int =
        if (PenaltyType = 2):
            # 破坏：归零
            0
        else if (PenaltyType = 1):
            # 降级：降1级
            Max(CurrentLevel - 1, 0)
        else:
            # 无惩罚：保持原样
            CurrentLevel
    
    # ========== 强化执行 ==========
    
    # 创建强化信息
    MakeUpgradeInfo<public>(CurrentLevel:int, MaxLevel:int)<transacts>:upgrade_info =
        SuccessRate := CalculateSuccessRate(CurrentLevel)
        Cost := CalculateUpgradeCost(CurrentLevel)
        Penalty := GetFailurePenalty(CurrentLevel)
        
        upgrade_info{
            CurrentLevel := CurrentLevel
            MaxLevel := MaxLevel
            SuccessRate := SuccessRate
            UpgradeCost := Cost
            FailurePenalty := Penalty
        }
    
    # 检查是否可以强化
    CheckCanUpgrade<public>(Info:upgrade_info)<decides><transacts>:void =
        Info.CurrentLevel < Info.MaxLevel
    
    # 检查是否在安全强化范围
    CheckSafeUpgrade<public>(CurrentLevel:int)<decides><transacts>:void =
        CurrentLevel < SAFE_UPGRADE_LEVEL
    
    # ========== 工具函数 ==========
    
    # 计算期望强化次数（达到目标等级）
    CalculateExpectedAttempts<public>(CurrentLevel:int, TargetLevel:int)<computes>:int =
        if (TargetLevel <= CurrentLevel):
            0
        else:
            LevelGap := TargetLevel - CurrentLevel
            AverageSuccessRate := CalculateSuccessRate((CurrentLevel + TargetLevel) / 2)
            if (AverageSuccessRate <= 0.0):
                999  # 几乎不可能
            else:
                ExpectedAttempts := Floor(LevelGap) / AverageSuccessRate
                Floor(ExpectedAttempts)
