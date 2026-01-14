# 经济掉落价值模块
# 功能：掉落物品的预估总价值计算

using { /Verse.org/Simulation }

EcoLootValue<public> := module:
    
    COMMON_VALUE<public>:float = 1.0
    UNCOMMON_VALUE<public>:float = 5.0
    RARE_VALUE<public>:float = 25.0
    EPIC_VALUE<public>:float = 100.0
    
    GetValueByRarity<public>(Rarity:int)<computes>:float =
        if (Rarity = 1):
            COMMON_VALUE
        else if (Rarity = 2):
            UNCOMMON_VALUE
        else if (Rarity = 3):
            RARE_VALUE
        else if (Rarity = 4):
            EPIC_VALUE
        else:
            COMMON_VALUE
    
    CalculateLootValue<public>(Rarity:int, Level:int)<computes>:float =
        BaseValue := GetValueByRarity(Rarity)
        LevelMultiplier := 1.0 + ((Level * 1.0) * 0.1)
        BaseValue * LevelMultiplier
