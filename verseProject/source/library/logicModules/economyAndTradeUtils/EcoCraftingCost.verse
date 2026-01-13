# 经济合成成本模块
# 功能：合成配方检查、批量制作材料消耗计算

using { /Verse.org/Simulation }

EcoCraftingCost<public> := module:
    
    # ========== 数据结构 ==========
    
    # 材料需求
    material_requirement<public> := struct<computes>:
        ItemID<public>:int = 0
        RequiredAmount<public>:int = 1
    
    # 合成配方
    crafting_recipe<public> := struct<computes>:
        RecipeID<public>:int = 0
        OutputItemID<public>:int = 0
        OutputAmount<public>:int = 1
        GoldCost<public>:int = 0
        CraftingTime<public>:float = 1.0        # 制作时间（秒）
        RequiredSkillLevel<public>:int = 0
    
    # 批量制作信息
    batch_crafting_info<public> := struct<computes>:
        RecipeID<public>:int = 0
        BatchSize<public>:int = 1
        TotalGoldCost<public>:int = 0
        TotalCraftingTime<public>:float = 0.0
        SuccessChance<public>:float = 1.0
    
    # ========== 常量定义 ==========
    
    # 制作费用系数
    CRAFTING_FEE_MULTIPLIER<public>:float = 0.1  # 制作费用为材料总价的10%
    
    # 批量折扣
    BATCH_DISCOUNT_THRESHOLD<public>:int = 10   # 10个起打折
    BATCH_DISCOUNT_RATE<public>:float = 0.05    # 5%折扣
    
    # 技能加成
    SKILL_COST_REDUCTION_PER_LEVEL<public>:float = 0.01  # 每级技能减少1%成本
    
    # ========== 材料计算 ==========
    
    # 计算单次制作的材料需求
    CalculateMaterialsForSingle<public>(Requirements:[]material_requirement)<computes>:[]material_requirement =
        Requirements
    
    # 计算批量制作的材料需求
    CalculateMaterialsForBatch<public>(Requirements:[]material_requirement, BatchSize:int)<transacts>:[]material_requirement =
        var BatchRequirements:[]material_requirement = array{}
        for (Req : Requirements):
            NewReq := material_requirement{
                ItemID := Req.ItemID
                RequiredAmount := Req.RequiredAmount * BatchSize
            }
            set BatchRequirements += array{NewReq}
        BatchRequirements
    
    # ========== 成本计算 ==========
    
    # 计算单次制作金币成本
    CalculateSingleCraftCost<public>(Recipe:crafting_recipe)<computes>:int =
        Recipe.GoldCost
    
    # 计算批量制作总成本（含折扣）
    CalculateBatchCraftCost<public>(Recipe:crafting_recipe, BatchSize:int)<computes>:int =
        BaseCost := Recipe.GoldCost * BatchSize
        
        # 应用批量折扣
        if (BatchSize >= BATCH_DISCOUNT_THRESHOLD):
            Discount := Floor(BaseCost) * BATCH_DISCOUNT_RATE
            BaseCost - Floor(Discount)
        else:
            BaseCost
    
    # 根据技能等级计算折扣后成本
    CalculateCostWithSkillDiscount<public>(BaseCost:int, SkillLevel:int, RequiredLevel:int)<computes>:int =
        if (SkillLevel <= RequiredLevel):
            BaseCost
        else:
            ExtraLevels := SkillLevel - RequiredLevel
            DiscountPercent := Floor(ExtraLevels) * SKILL_COST_REDUCTION_PER_LEVEL
            ClampedDiscount := Min(DiscountPercent, 0.5)  # 最多减免50%
            Discount := Floor(BaseCost) * ClampedDiscount
            BaseCost - Floor(Discount)
    
    # ========== 制作时间计算 ==========
    
    # 计算批量制作总时间
    CalculateBatchCraftingTime<public>(Recipe:crafting_recipe, BatchSize:int)<computes>:float =
        Recipe.CraftingTime * Floor(BatchSize)
    
    # 技能加速制作时间
    CalculateTimeWithSkillBonus<public>(BaseTime:float, SkillLevel:int)<computes>:float =
        # 每10级技能减少5%时间
        SpeedBonus := Floor(SkillLevel / 10) * 0.05
        ClampedBonus := Min(SpeedBonus, 0.5)  # 最多减少50%时间
        BaseTime * (1.0 - ClampedBonus)
    
    # ========== 制作验证 ==========
    
    # 检查材料是否足够
    CheckMaterialsSufficient<public>(Required:int, Available:int)<decides><transacts>:void =
        Available >= Required
    
    # 检查技能等级是否满足
    CheckSkillLevelMet<public>(PlayerSkill:int, RequiredSkill:int)<decides><transacts>:void =
        PlayerSkill >= RequiredSkill
    
    # 检查金币是否足够
    CheckGoldSufficient<public>(PlayerGold:int, RequiredGold:int)<decides><transacts>:void =
        PlayerGold >= RequiredGold
    
    # ========== 批量制作信息 ==========
    
    # 创建批量制作信息
    MakeBatchCraftingInfo<public>(Recipe:crafting_recipe, BatchSize:int, SkillLevel:int)<transacts>:batch_crafting_info =
        BaseCost := CalculateBatchCraftCost(Recipe, BatchSize)
        TotalCost := CalculateCostWithSkillDiscount(BaseCost, SkillLevel, Recipe.RequiredSkillLevel)
        
        BaseTime := CalculateBatchCraftingTime(Recipe, BatchSize)
        TotalTime := CalculateTimeWithSkillBonus(BaseTime, SkillLevel)
        
        # 技能等级影响成功率
        SkillDiff := SkillLevel - Recipe.RequiredSkillLevel
        SuccessChance := if (SkillDiff >= 0):
            Min(0.9 + Floor(SkillDiff) * 0.01, 1.0)
        else:
            Max(0.5 + Floor(SkillDiff) * 0.05, 0.1)
        
        batch_crafting_info{
            RecipeID := Recipe.RecipeID
            BatchSize := BatchSize
            TotalGoldCost := TotalCost
            TotalCraftingTime := TotalTime
            SuccessChance := SuccessChance
        }
    
    # ========== 工具函数 ==========
    
    # 创建材料需求
    MakeMaterialRequirement<public>(ItemID:int, Amount:int)<transacts>:material_requirement =
        material_requirement{
            ItemID := ItemID
            RequiredAmount := Amount
        }
    
    # 创建合成配方
    MakeCraftingRecipe<public>(RecipeID:int, OutputID:int, GoldCost:int, SkillReq:int)<transacts>:crafting_recipe =
        crafting_recipe{
            RecipeID := RecipeID
            OutputItemID := OutputID
            OutputAmount := 1
            GoldCost := GoldCost
            CraftingTime := 1.0
            RequiredSkillLevel := SkillReq
        }
