# 背包排序模块
# 功能：物品按稀有度、类型、价值排序

using { /Verse.org/Simulation }

InvSorting<public> := module:
    
    CompareByRarity<public>(Rarity1:int, Rarity2:int)<computes>:int =
        if (Rarity1 > Rarity2):
            -1
        else if (Rarity1 < Rarity2):
            1
        else:
            0
    
    CompareByValue<public>(Value1:float, Value2:float)<computes>:int =
        if (Value1 > Value2):
            -1
        else if (Value1 < Value2):
            1
        else:
            0
