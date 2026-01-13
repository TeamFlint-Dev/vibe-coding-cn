# 经济回收系统模块
# 功能：物品分解产出计算、返还率逻辑

using { /Verse.org/Simulation }

EcoRecycling<public> := module:
    
    BASE_RECYCLE_RATE<public>:float = 0.25
    RARE_BONUS<public>:float = 0.1
    
    CalculateRecycleValue<public>(ItemValue:float, Quality:int)<computes>:float =
        BaseReturn := ItemValue * BASE_RECYCLE_RATE
        QualityBonus := (Quality * 1.0) * RARE_BONUS
        TotalRate := Clamp(BASE_RECYCLE_RATE + QualityBonus, 0.0, 0.9)
        ItemValue * TotalRate
