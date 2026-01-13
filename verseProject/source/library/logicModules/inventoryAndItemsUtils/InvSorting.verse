# 库存排序模块
# 功能：背包排序算法（按品质/类型/价值）

using { /Verse.org/Simulation }

InvSorting<public> := module:
    
    # ========== 排序类型 ==========
    
    SORT_BY_RARITY<public>:int = 0      # 按稀有度
    SORT_BY_TYPE<public>:int = 1        # 按类型
    SORT_BY_VALUE<public>:int = 2       # 按价值
    SORT_BY_NAME<public>:int = 3        # 按名称
    SORT_BY_LEVEL<public>:int = 4       # 按等级
    
    # ========== 数据结构 ==========
    
    # 可排序物品
    sortable_item<public> := struct<computes>:
        ItemID<public>:int = 0
        Rarity<public>:int = 0
        ItemType<public>:int = 0
        Value<public>:int = 0
        Level<public>:int = 1
        SortPriority<public>:int = 0        # 排序优先级
    
    # ========== 优先级计算 ==========
    
    # 按稀有度计算优先级
    CalculateRarityPriority<public>(Rarity:int)<computes>:int =
        # 稀有度越高，优先级越高（倒序）
        1000 - Rarity * 100
    
    # 按价值计算优先级
    CalculateValuePriority<public>(Value:int)<computes>:int =
        # 价值越高，优先级越高（倒序）
        1000000 - Value
    
    # 按类型计算优先级
    CalculateTypePriority<public>(ItemType:int)<computes>:int =
        # 装备>消耗品>材料>其他
        ItemType * 1000
    
    # 按等级计算优先级
    CalculateLevelPriority<public>(Level:int)<computes>:int =
        # 等级越高，优先级越高（倒序）
        10000 - Level * 100
    
    # 综合排序优先级（稀有度>类型>等级>价值）
    CalculateCompositePriority<public>(Item:sortable_item)<computes>:int =
        RarityWeight := CalculateRarityPriority(Item.Rarity)
        TypeWeight := CalculateTypePriority(Item.ItemType)
        LevelWeight := CalculateLevelPriority(Item.Level)
        ValueWeight := Floor(CalculateValuePriority(Item.Value) / 1000)  # 降低权重
        
        RarityWeight + TypeWeight + LevelWeight + ValueWeight
    
    # ========== 比较函数 ==========
    
    # 比较两个物品（返回是否A应该排在B前面）
    CompareItems<public>(ItemA:sortable_item, ItemB:sortable_item, SortType:int)<computes>:logic =
        if (SortType = SORT_BY_RARITY):
            # 稀有度降序
            if (ItemA.Rarity > ItemB.Rarity) then true else false
        else if (SortType = SORT_BY_TYPE):
            # 类型升序
            if (ItemA.ItemType < ItemB.ItemType) then true else false
        else if (SortType = SORT_BY_VALUE):
            # 价值降序
            if (ItemA.Value > ItemB.Value) then true else false
        else if (SortType = SORT_BY_LEVEL):
            # 等级降序
            if (ItemA.Level > ItemB.Level) then true else false
        else:
            # 默认综合排序
            if (ItemA.SortPriority < ItemB.SortPriority) then true else false
    
    # ========== 工具函数 ==========
    
    # 创建可排序物品
    MakeSortableItem<public>(ItemID:int, Rarity:int, Type:int, Value:int, Level:int)<transacts>:sortable_item =
        Item := sortable_item{
            ItemID := ItemID
            Rarity := Rarity
            ItemType := Type
            Value := Value
            Level := Level
            SortPriority := 0
        }
        # 计算综合优先级
        Priority := CalculateCompositePriority(Item)
        sortable_item{
            ItemID := ItemID
            Rarity := Rarity
            ItemType := Type
            Value := Value
            Level := Level
            SortPriority := Priority
        }
