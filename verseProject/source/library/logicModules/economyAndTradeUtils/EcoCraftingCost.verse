# 经济合成成本模块
# 功能：合成配方检查、批量制作材料消耗计算

using { /Verse.org/Simulation }

EcoCraftingCost<public> := module:
    
    BASE_CRAFTING_FEE<public>:float = 10.0
    MATERIAL_COST_MULTIPLIER<public>:float = 1.5
    
    CalculateCraftingCost<public>(MaterialCost:float, CraftingLevel:int)<computes>:float =
        LevelDiscount := (CraftingLevel * 1.0) * 0.01
        FinalMultiplier := Max(MATERIAL_COST_MULTIPLIER - LevelDiscount, 1.0)
        MaterialCost * FinalMultiplier + BASE_CRAFTING_FEE
    
    CalculateMaterialValue<public>(MaterialCount:int, UnitPrice:float)<computes>:float =
        (MaterialCount * 1.0) * UnitPrice
