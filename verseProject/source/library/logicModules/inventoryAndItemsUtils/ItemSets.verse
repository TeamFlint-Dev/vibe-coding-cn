# 套装系统模块
# 功能：套装进度计算、多套装效果叠加

using { /Verse.org/Simulation }

ItemSets<public> := module:
    
    CalculateSetProgress<public>(OwnedPieces:int, TotalPieces:int)<computes>:float =
        if (TotalPieces > 0):
            (OwnedPieces * 1.0) / (TotalPieces * 1.0)
        else:
            0.0
    
    IsSetComplete<public>(OwnedPieces:int, TotalPieces:int)<decides><transacts>:void =
        OwnedPieces >= TotalPieces
    
    CalculateSetBonusPower<public>(BasePower:float, CompletedSets:int)<computes>:float =
        BonusPercent := (CompletedSets * 1.0) * 0.15
        BasePower * (1.0 + BonusPercent)
