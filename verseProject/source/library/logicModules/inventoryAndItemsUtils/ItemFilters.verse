# 物品过滤模块
# 功能：物品拾取过滤规则（只捡紫色以上）

using { /Verse.org/Simulation }

ItemFilters<public> := module:
    
    # ========== 过滤条件 ==========
    
    FILTER_BY_RARITY<public>:int = 0
    FILTER_BY_VALUE<public>:int = 1
    FILTER_BY_TYPE<public>:int = 2
    FILTER_BY_LEVEL<public>:int = 3
    
    # ========== 数据结构 ==========
    
    # 过滤器配置
    filter_config<public> := struct<computes>:
        MinRarity<public>:int = 0               # 最低稀有度
        MinValue<public>:int = 0                # 最低价值
        AllowedTypes<public>:[]int = array{}    # 允许的类型
        MinLevel<public>:int = 0                # 最低等级
        MaxLevel<public>:int = 100              # 最高等级
    
    # 物品信息
    filter_item_info<public> := struct<computes>:
        ItemID<public>:int = 0
        Rarity<public>:int = 0
        Value<public>:int = 0
        ItemType<public>:int = 0
        Level<public>:int = 1
    
    # ========== 单条件过滤 ==========
    
    # 按稀有度过滤
    FilterByRarity<public>(Item:filter_item_info, MinRarity:int)<decides><transacts>:void =
        Item.Rarity >= MinRarity
    
    # 按价值过滤
    FilterByValue<public>(Item:filter_item_info, MinValue:int)<decides><transacts>:void =
        Item.Value >= MinValue
    
    # 按类型过滤
    FilterByType<public>(Item:filter_item_info, AllowedTypes:[]int)<decides><transacts>:void =
        if (AllowedTypes.Length = 0):
            true  # 空列表表示允许所有类型
        else:
            var IsAllowed:logic = false
            for (Type : AllowedTypes):
                if (Item.ItemType = Type):
                    set IsAllowed = true
            IsAllowed
    
    # 按等级过滤
    FilterByLevel<public>(Item:filter_item_info, MinLevel:int, MaxLevel:int)<decides><transacts>:void =
        if (Item.Level >= MinLevel and Item.Level <= MaxLevel):
            true
        else:
            false
    
    # ========== 综合过滤 ==========
    
    # 应用完整过滤器
    ApplyFilter<public>(Item:filter_item_info, Config:filter_config)<decides><transacts>:void =
        RarityOK := if (FilterByRarity[Item, Config.MinRarity]) then true else false
        ValueOK := if (FilterByValue[Item, Config.MinValue]) then true else false
        TypeOK := if (FilterByType[Item, Config.AllowedTypes]) then true else false
        LevelOK := if (FilterByLevel[Item, Config.MinLevel, Config.MaxLevel]) then true else false
        
        if (RarityOK and ValueOK and TypeOK and LevelOK) then true else false
    
    # ========== 预设过滤器 ==========
    
    # 只拾取稀有以上
    MakeRareOnlyFilter<public>()<transacts>:filter_config =
        filter_config{
            MinRarity := 2  # 稀有
            MinValue := 0
            AllowedTypes := array{}
            MinLevel := 0
            MaxLevel := 100
        }
    
    # 只拾取史诗以上
    MakeEpicOnlyFilter<public>()<transacts>:filter_config =
        filter_config{
            MinRarity := 3  # 史诗
            MinValue := 0
            AllowedTypes := array{}
            MinLevel := 0
            MaxLevel := 100
        }
    
    # 高价值过滤器
    MakeHighValueFilter<public>(MinValue:int)<transacts>:filter_config =
        filter_config{
            MinRarity := 0
            MinValue := MinValue
            AllowedTypes := array{}
            MinLevel := 0
            MaxLevel := 100
        }
    
    # ========== 工具函数 ==========
    
    # 创建物品信息
    MakeFilterItemInfo<public>(ItemID:int, Rarity:int, Value:int, Type:int, Level:int)<transacts>:filter_item_info =
        filter_item_info{
            ItemID := ItemID
            Rarity := Rarity
            Value := Value
            ItemType := Type
            Level := Level
        }
