# 装备槽位系统模块
# 功能：装备槽位规则、套装效果激活判定

using { /Verse.org/Simulation }

InvEquipment<public> := module:
    
    SLOT_HEAD<public>:int = 1
    SLOT_CHEST<public>:int = 2
    SLOT_LEGS<public>:int = 3
    SLOT_WEAPON<public>:int = 4
    MIN_SET_PIECES<public>:int = 3
    
    IsValidSlot<public>(SlotID:int)<decides><transacts>:void =
        SlotID >= SLOT_HEAD
        SlotID <= SLOT_WEAPON
    
    HasSetBonus<public>(EquippedPieces:int)<decides><transacts>:void =
        EquippedPieces >= MIN_SET_PIECES
    
    CalculateSetBonus<public>(BaseStat:float, SetPieces:int)<computes>:float =
        BonusPercent := (SetPieces * 1.0) * 0.1
        BaseStat * (1.0 + BonusPercent)
