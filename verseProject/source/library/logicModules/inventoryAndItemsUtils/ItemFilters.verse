# 物品筛选模块
# 功能：物品按条件筛选（类型、等级、稀有度）

using { /Verse.org/Simulation }

ItemFilters<public> := module:
    
    FilterByRarity<public>(ItemRarity:int, TargetRarity:int)<decides><transacts>:void =
        ItemRarity >= TargetRarity
    
    FilterByLevel<public>(ItemLevel:int, MinLevel:int, MaxLevel:int)<decides><transacts>:void =
        ItemLevel >= MinLevel
        ItemLevel <= MaxLevel
    
    FilterByType<public>(ItemType:int, TargetType:int)<decides><transacts>:void =
        ItemType = TargetType
