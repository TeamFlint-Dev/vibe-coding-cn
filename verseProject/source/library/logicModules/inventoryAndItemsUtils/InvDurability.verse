# 背包耐久度系统模块
# 功能：耐久度损耗计算、修理成本公式

using { /Verse.org/Simulation }

InvDurability<public> := module:
    
    DURABILITY_LOSS_RATE<public>:float = 1.0
    REPAIR_COST_FACTOR<public>:float = 0.25
    
    CalculateDurabilityLoss<public>(BaseLoss:float, Quality:int)<computes>:float =
        QualityFloat := Quality * 1.0
        QualityReduction := 1.0 - (QualityFloat * 0.05)
        BaseLoss * Max(QualityReduction, 0.5)
    
    CalculateRepairCost<public>(MaxDurability:float, CurrentDurability:float, ItemValue:float)<computes>:float =
        DurabilityPercent := 1.0 - (CurrentDurability / MaxDurability)
        ItemValue * DurabilityPercent * REPAIR_COST_FACTOR
    
    IsBroken<public>(CurrentDurability:float)<decides><transacts>:void =
        CurrentDurability <= 0.0
