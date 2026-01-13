# 经济掉落价值模块
# 功能：掉落物品的预估总价值计算

using { /Verse.org/Simulation }

EcoLootValue<public> := module:
    
    # ========== 数据结构 ==========
    
    # 物品价值信息
    item_value<public> := struct<computes>:
        ItemID<public>:int = 0
        BaseValue<public>:int = 0
        Rarity<public>:int = 0
        Quantity<public>:int = 1
    
    # 稀有度价值倍率
    RARITY_COMMON<public>:int = 0
    RARITY_UNCOMMON<public>:int = 1
    RARITY_RARE<public>:int = 2
    RARITY_EPIC<public>:int = 3
    RARITY_LEGENDARY<public>:int = 4
    
    # ========== 价值倍率 ==========
    
    # 获取稀有度价值倍率
    GetRarityValueMultiplier<public>(Rarity:int)<computes>:float =
        if (Rarity = RARITY_COMMON):
            1.0
        else if (Rarity = RARITY_UNCOMMON):
            2.0
        else if (Rarity = RARITY_RARE):
            5.0
        else if (Rarity = RARITY_EPIC):
            15.0
        else if (Rarity = RARITY_LEGENDARY):
            50.0
        else:
            1.0
    
    # ========== 价值计算 ==========
    
    # 计算单个物品价值
    CalculateItemValue<public>(Item:item_value)<computes>:int =
        Multiplier := GetRarityValueMultiplier(Item.Rarity)
        BaseValue := Floor(Item.BaseValue) * Multiplier
        Floor(BaseValue) * Item.Quantity
    
    # 计算掉落列表总价值
    CalculateTotalLootValue<public>(LootList:[]item_value)<computes>:int =
        var TotalValue:int = 0
        for (Item : LootList):
            set TotalValue += CalculateItemValue(Item)
        TotalValue
    
    # 计算平均掉落价值
    CalculateAverageLootValue<public>(LootList:[]item_value)<computes>:int =
        if (LootList.Length = 0):
            0
        else:
            TotalValue := CalculateTotalLootValue(LootList)
            Floor(TotalValue / LootList.Length)
    
    # ========== 价值评级 ==========
    
    # 获取价值评级（0-5星）
    GetValueRating<public>(TotalValue:int)<computes>:int =
        if (TotalValue >= 10000):
            5
        else if (TotalValue >= 5000):
            4
        else if (TotalValue >= 1000):
            3
        else if (TotalValue >= 500):
            2
        else if (TotalValue >= 100):
            1
        else:
            0
    
    # ========== 工具函数 ==========
    
    # 创建物品价值信息
    MakeItemValue<public>(ItemID:int, BaseValue:int, Rarity:int, Qty:int)<transacts>:item_value =
        item_value{
            ItemID := ItemID
            BaseValue := BaseValue
            Rarity := Rarity
            Quantity := Qty
        }
