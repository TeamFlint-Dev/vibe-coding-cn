# 掉落生成模块
# 功能：随机词条生成、物品品质判定

using { /Verse.org/Simulation }
using { /Verse.org/Random }

LootGeneration<public> := module:
    
    # ========== 数据结构 ==========
    
    # 掉落物品
    generated_loot<public> := struct<computes>:
        ItemID<public>:int = 0
        Rarity<public>:int = 0
        Quantity<public>:int = 1
        AffixCount<public>:int = 0              # 词条数量
    
    # ========== 稀有度权重 ==========
    
    COMMON_WEIGHT<public>:float = 60.0          # 60%
    UNCOMMON_WEIGHT<public>:float = 25.0        # 25%
    RARE_WEIGHT<public>:float = 10.0            # 10%
    EPIC_WEIGHT<public>:float = 4.0             # 4%
    LEGENDARY_WEIGHT<public>:float = 1.0        # 1%
    
    # ========== 稀有度生成 ==========
    
    # 根据权重生成稀有度
    GenerateRarity<public>()<transacts>:int =
        RandomValue := GetRandomFloat(0.0, 100.0)
        
        if (RandomValue < LEGENDARY_WEIGHT):
            4  # 传说
        else if (RandomValue < LEGENDARY_WEIGHT + EPIC_WEIGHT):
            3  # 史诗
        else if (RandomValue < LEGENDARY_WEIGHT + EPIC_WEIGHT + RARE_WEIGHT):
            2  # 稀有
        else if (RandomValue < LEGENDARY_WEIGHT + EPIC_WEIGHT + RARE_WEIGHT + UNCOMMON_WEIGHT):
            1  # 精良
        else:
            0  # 普通
    
    # 根据稀有度获取词条数量
    GetAffixCountByRarity<public>(Rarity:int)<transacts>:int =
        if (Rarity = 0):
            # 普通：0词条
            0
        else if (Rarity = 1):
            # 精良：1-2词条
            GetRandomInt(1, 2)
        else if (Rarity = 2):
            # 稀有：2-3词条
            GetRandomInt(2, 3)
        else if (Rarity = 3):
            # 史诗：3-4词条
            GetRandomInt(3, 4)
        else if (Rarity = 4):
            # 传说：4-6词条
            GetRandomInt(4, 6)
        else:
            0
    
    # ========== 数量生成 ==========
    
    # 根据稀有度生成数量
    GenerateQuantityByRarity<public>(Rarity:int, BaseQuantity:int)<transacts>:int =
        if (Rarity = 0):
            # 普通：基础数量±20%
            Variance := Floor(BaseQuantity * 0.2)
            BaseQuantity + GetRandomInt(-Variance, Variance)
        else if (Rarity >= 3):
            # 史诗及以上：单个
            1
        else:
            # 其他：基础数量
            BaseQuantity
    
    # ========== 掉落生成 ==========
    
    # 生成掉落物品
    GenerateLoot<public>(ItemID:int, BaseQuantity:int)<transacts>:generated_loot =
        Rarity := GenerateRarity()
        Quantity := GenerateQuantityByRarity(Rarity, BaseQuantity)
        AffixCount := GetAffixCountByRarity(Rarity)
        
        generated_loot{
            ItemID := ItemID
            Rarity := Rarity
            Quantity := Quantity
            AffixCount := AffixCount
        }
    
    # ========== 工具函数 ==========
    
    # 创建固定稀有度掉落
    MakeFixedRarityLoot<public>(ItemID:int, Rarity:int, Qty:int)<transacts>:generated_loot =
        AffixCount := GetAffixCountByRarity(Rarity)
        generated_loot{
            ItemID := ItemID
            Rarity := Rarity
            Quantity := Qty
            AffixCount := AffixCount
        }
