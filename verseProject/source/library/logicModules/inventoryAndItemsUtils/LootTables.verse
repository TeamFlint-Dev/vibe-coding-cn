# 掉落表模块
# 功能：掉落概率归一化、保底机制判定

using { /Verse.org/Simulation }

LootTables<public> := module:
    
    BASE_DROP_RATE<public>:float = 0.1
    PITY_INCREMENT<public>:float = 0.02
    
    CalculateDropChance<public>(BaseChance:float, Attempts:int)<computes>:float =
        PityBonus := (Attempts * 1.0) * PITY_INCREMENT
        FinalChance := BaseChance + PityBonus
        Min(FinalChance, 1.0)
    
    ResetPity<public>()<computes>:int =
        0
    
    IncrementPity<public>(CurrentPity:int)<computes>:int =
        CurrentPity + 1
