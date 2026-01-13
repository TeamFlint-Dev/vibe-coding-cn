# 物品升级模块
# 功能：装备强化成功率、属性提升计算

using { /Verse.org/Simulation }

ItemUpgrade<public> := module:
    
    BASE_SUCCESS_RATE<public>:float = 0.8
    SUCCESS_DECREASE_PER_LEVEL<public>:float = 0.1
    
    CalculateUpgradeSuccess<public>(CurrentLevel:int)<computes>:float =
        LevelPenalty := (CurrentLevel * 1.0) * SUCCESS_DECREASE_PER_LEVEL
        SuccessRate := BASE_SUCCESS_RATE - LevelPenalty
        Clamp(SuccessRate, 0.1, 1.0)
    
    CalculateUpgradedStat<public>(BaseStat:float, UpgradeLevel:int)<computes>:float =
        BonusPercent := (UpgradeLevel * 1.0) * 0.1
        BaseStat * (1.0 + BonusPercent)
    
    CalculateUpgradeCost<public>(BaseValue:float, UpgradeLevel:int)<computes>:float =
        # Simplified - avoid Pow
        LevelFloat := UpgradeLevel * 1.0
        LevelMultiplier := 1.0 + (LevelFloat * 0.5)
        BaseValue * LevelMultiplier
