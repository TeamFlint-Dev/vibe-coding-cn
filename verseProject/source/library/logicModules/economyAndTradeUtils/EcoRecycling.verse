# 经济回收系统模块
# 功能：物品分解产出计算、返还率逻辑

using { /Verse.org/Simulation }

EcoRecycling<public> := module:
    
    # ========== 数据结构 ==========
    
    # 回收结果
    recycle_result<public> := struct<computes>:
        MaterialID<public>:int = 0
        Amount<public>:int = 0
        ReturnRate<public>:float = 0.0
    
    # ========== 常量定义 ==========
    
    # 基础返还率
    BASE_RETURN_RATE<public>:float = 0.25          # 25%返还
    
    # 稀有度返还率加成
    UNCOMMON_BONUS<public>:float = 0.05
    RARE_BONUS<public>:float = 0.10
    EPIC_BONUS<public>:float = 0.15
    LEGENDARY_BONUS<public>:float = 0.20
    
    # 耐久度影响
    DURABILITY_IMPACT<public>:float = 0.5          # 耐久度影响50%返还率
    
    # ========== 返还率计算 ==========
    
    # 根据稀有度计算返还率
    CalculateReturnRateByRarity<public>(Rarity:int)<computes>:float =
        BaseRate := BASE_RETURN_RATE
        if (Rarity = 1):
            BaseRate + UNCOMMON_BONUS
        else if (Rarity = 2):
            BaseRate + RARE_BONUS
        else if (Rarity = 3):
            BaseRate + EPIC_BONUS
        else if (Rarity = 4):
            BaseRate + LEGENDARY_BONUS
        else:
            BaseRate
    
    # 根据耐久度调整返还率
    AdjustReturnRateByDurability<public>(BaseRate:float, CurrentDurability:float, MaxDurability:float)<computes>:float =
        if (MaxDurability <= 0.0):
            BaseRate
        else:
            DurabilityPercent := CurrentDurability / MaxDurability
            DurabilityBonus := DurabilityPercent * DURABILITY_IMPACT
            BaseRate * (0.5 + DurabilityBonus)  # 最低50%返还率
    
    # ========== 回收产出计算 ==========
    
    # 计算回收材料数量
    CalculateRecycleAmount<public>(MaterialCost:int, ReturnRate:float)<computes>:int =
        Amount := Floor(MaterialCost) * ReturnRate
        Max(Floor(Amount), 1)  # 至少返还1个
    
    # 计算完整回收结果
    CalculateRecycleResult<public>(MaterialID:int, MaterialCost:int, Rarity:int, Durability:float, MaxDurability:float)<transacts>:recycle_result =
        BaseRate := CalculateReturnRateByRarity(Rarity)
        FinalRate := AdjustReturnRateByDurability(BaseRate, Durability, MaxDurability)
        Amount := CalculateRecycleAmount(MaterialCost, FinalRate)
        
        recycle_result{
            MaterialID := MaterialID
            Amount := Amount
            ReturnRate := FinalRate
        }
    
    # ========== 工具函数 ==========
    
    # 创建回收结果
    MakeRecycleResult<public>(MatID:int, Amt:int, Rate:float)<transacts>:recycle_result =
        recycle_result{
            MaterialID := MatID
            Amount := Amt
            ReturnRate := Rate
        }
