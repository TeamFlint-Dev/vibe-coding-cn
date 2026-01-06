# LootTable - 掉落表系统
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第四层：游戏应用层
#
# 功能: 实现游戏掉落系统（单层、多层、条件掉落）

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

LootTable<public> := module:
    # ==========================================
    # 掉落物品定义
    # ==========================================
    
    loot_item<public>(ItemType:type) := class:
        # 物品数据
        Item<public>:ItemType
        
        # 掉落权重
        Weight<public>:float
        
        # 数量范围
        MinCount<public>:int
        MaxCount<public>:int
        
        # 掉落概率（0-1，独立于权重）
        DropChance<public>:float = 1.0
    
    # ==========================================
    # 基础掉落表
    # ==========================================
    
    loot_table<public>(ItemType:type) := class:
        # 掉落物品列表
        var Items<private>:[]loot_item(ItemType) = array{}
        
        # 是否允许重复掉落
        AllowDuplicates<public>:logic = true
        
        # 最大掉落数量
        MaxDrops<public>:int = -1  # -1表示无限制
        
        # 添加掉落物品
        AddItem<public>(Item:ItemType, Weight:float, MinCount:int, MaxCount:int, DropChance:float):void =
            LootItem := loot_item(ItemType){
                Item := Item,
                Weight := Weight,
                MinCount := MinCount,
                MaxCount := MaxCount,
                DropChance := DropChance
            }
            set Items += array{LootItem}
        
        # 简化添加（数量固定为1）
        AddSimpleItem<public>(Item:ItemType, Weight:float):void =
            AddItem(Item, Weight, 1, 1, 1.0)
        
        # 执行掉落
        RollLoot<public>()<transacts>:[]ItemType =
            var Results:[]ItemType = array{}
            
            if (Items.Length = 0):
                return Results
            
            # 计算总权重
            var TotalWeight:float = 0.0
            for (LootItem : Items):
                set TotalWeight += LootItem.Weight
            
            if (TotalWeight <= 0.0):
                return Results
            
            # 确定掉落次数
            DropCount := if (MaxDrops > 0) then MaxDrops else Items.Length
            
            # 创建可用物品列表
            var AvailableItems:[]loot_item(ItemType) = Items
            
            for (I := 0..DropCount - 1):
                if (AvailableItems.Length = 0):
                    break
                
                # 重新计算总权重
                set TotalWeight = 0.0
                for (LootItem : AvailableItems):
                    set TotalWeight += LootItem.Weight
                
                if (TotalWeight <= 0.0):
                    break
                
                # 随机选择
                Roll := GetRandomFloat(0.0, TotalWeight)
                var CumulativeWeight:float = 0.0
                var SelectedItem:?loot_item(ItemType) = false
                var SelectedIndex:int = -1
                
                for (Index -> LootItem : AvailableItems):
                    set CumulativeWeight += LootItem.Weight
                    if (Roll <= CumulativeWeight):
                        set SelectedItem = option{LootItem}
                        set SelectedIndex = Index
                        break
                
                # 处理选中的物品
                if (Item := SelectedItem?):
                    # 概率判定
                    if (GetRandomFloat(0.0, 1.0) <= Item.DropChance):
                        # 确定数量
                        Count := GetRandomInt(Item.MinCount, Item.MaxCount)
                        
                        # 添加到结果（重复Count次）
                        for (J := 0..Count - 1):
                            set Results += array{Item.Item}
                    
                    # 如果不允许重复，移除已选中的物品
                    if (not AllowDuplicates?, SelectedIndex >= 0):
                        set AvailableItems = array:
                            for (Idx -> Itm : AvailableItems, Idx <> SelectedIndex):
                                Itm
            
            Results
        
        # 获取物品数量
        GetItemCount<public>():int = Items.Length
        
        # 清空掉落表
        Clear<public>():void =
            set Items = array{}
    
    # 创建掉落表
    CreateLootTable<public>(ItemType:type):loot_table(ItemType) =
        loot_table(ItemType){}
    
    # ==========================================
    # 分层掉落表
    # ==========================================
    
    loot_tier<public>(ItemType:type) := class:
        # 层级名称（如"普通"、"稀有"、"史诗"）
        TierName<public>:string
        
        # 该层级的掉落表
        var Table<public>:loot_table(ItemType)
        
        # 该层级的权重
        Weight<public>:float
        
        # 初始化
        Initialize<public>(Name:string, Wt:float):void =
            set Table = CreateLootTable(ItemType)
    
    tiered_loot_table<public>(ItemType:type) := class:
        # 层级列表
        var Tiers<private>:[]loot_tier(ItemType) = array{}
        
        # 添加层级
        AddTier<public>(TierName:string, Weight:float):loot_tier(ItemType) =
            Tier := loot_tier(ItemType){
                TierName := TierName,
                Weight := Weight
            }
            Tier.Initialize(TierName, Weight)
            set Tiers += array{Tier}
            Tier
        
        # 执行分层掉落
        RollTieredLoot<public>()<transacts>:[]ItemType =
            if (Tiers.Length = 0):
                return array{}
            
            # 计算总权重
            var TotalWeight:float = 0.0
            for (Tier : Tiers):
                set TotalWeight += Tier.Weight
            
            if (TotalWeight <= 0.0):
                return array{}
            
            # 选择层级
            Roll := GetRandomFloat(0.0, TotalWeight)
            var CumulativeWeight:float = 0.0
            
            for (Tier : Tiers):
                set CumulativeWeight += Tier.Weight
                if (Roll <= CumulativeWeight):
                    # 从选中的层级掉落
                    return Tier.Table.RollLoot()
            
            # fallback
            if (LastTier := Tiers[Tiers.Length - 1]):
                LastTier.Table.RollLoot()
            else:
                array{}
        
        # 获取层级数量
        GetTierCount<public>():int = Tiers.Length
    
    # 创建分层掉落表
    CreateTieredLootTable<public>(ItemType:type):tiered_loot_table(ItemType) =
        tiered_loot_table(ItemType){}
    
    # ==========================================
    # 条件掉落系统
    # ==========================================
    
    conditional_loot<public>(ItemType:type, ConditionType:type) := class:
        # 基础掉落表
        var BaseTable<private>:loot_table(ItemType)
        
        # 条件掉落表（条件 -> 掉落表）
        var ConditionalTables<private>:[]ItemType = array{}  # 简化版
        
        # 初始化
        Initialize<public>():void =
            set BaseTable = CreateLootTable(ItemType)
        
        # 获取基础表
        GetBaseTable<public>():loot_table(ItemType) = BaseTable
        
        # 执行掉落（无条件）
        RollLoot<public>()<transacts>:[]ItemType =
            BaseTable.RollLoot()
    
    # 创建条件掉落系统
    CreateConditionalLoot<public>(ItemType:type, ConditionType:type):conditional_loot(ItemType, ConditionType) =
        System := conditional_loot(ItemType, ConditionType){}
        System.Initialize()
        System
    
    # ==========================================
    # 保底掉落表
    # ==========================================
    
    guaranteed_loot_table<public>(ItemType:type) := class:
        # 主掉落表
        var MainTable<private>:loot_table(ItemType)
        
        # 保底掉落表
        var GuaranteedTable<private>:loot_table(ItemType)
        
        # 保底计数器
        var PityCounter<private>:int = 0
        
        # 保底阈值
        PityThreshold<public>:int
        
        # 初始化
        Initialize<public>(Threshold:int):void =
            set MainTable = CreateLootTable(ItemType)
            set GuaranteedTable = CreateLootTable(ItemType)
        
        # 获取主表
        GetMainTable<public>():loot_table(ItemType) = MainTable
        
        # 获取保底表
        GetGuaranteedTable<public>():loot_table(ItemType) = GuaranteedTable
        
        # 执行掉落
        RollLoot<public>()<transacts>:[]ItemType =
            set PityCounter += 1
            
            # 达到保底
            if (PityCounter >= PityThreshold):
                set PityCounter = 0
                return GuaranteedTable.RollLoot()
            
            # 普通掉落
            Results := MainTable.RollLoot()
            
            # 检查是否掉落了保底物品（简化判断）
            if (Results.Length > 0):
                set PityCounter = 0
            
            Results
        
        # 获取当前计数
        GetPityCount<public>():int = PityCounter
        
        # 重置计数
        ResetPity<public>():void =
            set PityCounter = 0
    
    # 创建保底掉落表
    CreateGuaranteedLootTable<public>(ItemType:type, PityThreshold:int):guaranteed_loot_table(ItemType) =
        Table := guaranteed_loot_table(ItemType){PityThreshold := PityThreshold}
        Table.Initialize(PityThreshold)
        Table
    
    # ==========================================
    # 掉落历史追踪
    # ==========================================
    
    loot_history<public>(ItemType:type) := class:
        # 掉落记录
        var History<private>:[]ItemType = array{}
        
        # 最大历史记录
        MaxHistorySize<public>:int = 1000
        
        # 记录掉落
        RecordDrop<public>(Items:[]ItemType):void =
            set History += Items
            
            # 限制大小
            if (History.Length > MaxHistorySize):
                set History = History.Slice[History.Length - MaxHistorySize, History.Length]
        
        # 获取历史
        GetHistory<public>():[]ItemType = History
        
        # 清空历史
        ClearHistory<public>():void =
            set History = array{}
        
        # 获取历史数量
        GetHistoryCount<public>():int = History.Length
