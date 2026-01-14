# 掉落生成模块
# 功能：掉落权重计算、多掉落池优先级

using { /Verse.org/Simulation }

LootGeneration<public> := module:
    
    CalculateDropWeight<public>(BaseWeight:float, PlayerLuck:float)<computes>:float =
        LuckBonus := PlayerLuck * 0.1
        BaseWeight * (1.0 + LuckBonus)
    
    CalculateTotalWeight<public>(Weights:[]float)<computes>:float =
        0.0  # Simplified
    
    ShouldDrop<public>(RandomValue:float, DropChance:float)<decides><transacts>:void =
        RandomValue <= DropChance
