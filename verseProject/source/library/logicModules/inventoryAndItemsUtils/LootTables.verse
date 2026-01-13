# 掉落表系统模块
# 功能：掉落池权重计算、保底机制逻辑

using { /Verse.org/Simulation }
using { /Verse.org/Random }

LootTables<public> := module:
    
    # ========== 数据结构 ==========
    
    # 掉落项
    loot_entry<public> := struct<computes>:
        ItemID<public>:int = 0
        Weight<public>:float = 1.0
        MinQuantity<public>:int = 1
        MaxQuantity<public>:int = 1
        GuaranteedDrop<public>:logic = false    # 是否保底掉落
    
    # 保底状态
    pity_state<public> := struct<computes>:
        Counter<public>:int = 0                 # 当前未出货次数
        PityThreshold<public>:int = 10          # 保底阈值
        GuaranteedItemID<public>:int = 0        # 保底物品ID
    
    # ========== 常量定义 ==========
    
    # 默认保底阈值
    DEFAULT_PITY_THRESHOLD<public>:int = 10
    
    # ========== 权重计算 ==========
    
    # 计算总权重
    CalculateTotalWeight<public>(LootTable:[]loot_entry)<computes>:float =
        var TotalWeight:float = 0.0
        for (Entry : LootTable):
            set TotalWeight += Entry.Weight
        TotalWeight
    
    # 根据权重随机选择
    SelectByWeight<public>(LootTable:[]loot_entry)<transacts>:loot_entry =
        TotalWeight := CalculateTotalWeight(LootTable)
        
        if (TotalWeight <= 0.0 or LootTable.Length = 0):
            # 默认返回第一项
            if (LootTable.Length > 0):
                LootTable[0]
            else:
                loot_entry{}
        else:
            RandomValue := GetRandomFloat(0.0, TotalWeight)
            
            var Accumulator:float = 0.0
            var SelectedEntry:loot_entry = LootTable[0]
            for (Entry : LootTable):
                set Accumulator += Entry.Weight
                if (RandomValue < Accumulator):
                    set SelectedEntry = Entry
                    break
            SelectedEntry
    
    # ========== 保底机制 ==========
    
    # 检查是否触发保底
    CheckPityTriggered<public>(State:pity_state)<decides><transacts>:void =
        State.Counter >= State.PityThreshold
    
    # 更新保底计数器（未出货）
    IncrementPityCounter<public>(State:pity_state)<transacts>:pity_state =
        pity_state{
            Counter := State.Counter + 1
            PityThreshold := State.PityThreshold
            GuaranteedItemID := State.GuaranteedItemID
        }
    
    # 重置保底计数器（已出货）
    ResetPityCounter<public>(State:pity_state)<transacts>:pity_state =
        pity_state{
            Counter := 0
            PityThreshold := State.PityThreshold
            GuaranteedItemID := State.GuaranteedItemID
        }
    
    # 带保底的掉落
    SelectWithPity<public>(LootTable:[]loot_entry, PityState:pity_state)<transacts>:tuple(loot_entry, pity_state) =
        # 检查保底
        if (CheckPityTriggered[PityState]):
            # 触发保底，寻找保底物品
            var GuaranteedEntry:loot_entry = loot_entry{}
            var Found:logic = false
            for (Entry : LootTable):
                if (Entry.ItemID = PityState.GuaranteedItemID):
                    set GuaranteedEntry = Entry
                    set Found = true
                    break
            
            if (Found):
                NewPityState := ResetPityCounter(PityState)
                (GuaranteedEntry, NewPityState)
            else:
                # 找不到保底物品，正常掉落
                Entry := SelectByWeight(LootTable)
                NewPityState := IncrementPityCounter(PityState)
                (Entry, NewPityState)
        else:
            # 正常掉落
            Entry := SelectByWeight(LootTable)
            # 检查是否出货（暂定：史诗及以上算出货）
            IsRareItem := Entry.ItemID = PityState.GuaranteedItemID
            NewPityState := if (IsRareItem):
                ResetPityCounter(PityState)
            else:
                IncrementPityCounter(PityState)
            (Entry, NewPityState)
    
    # ========== 数量生成 ==========
    
    # 生成随机数量
    GenerateQuantity<public>(Entry:loot_entry)<transacts>:int =
        if (Entry.MaxQuantity <= Entry.MinQuantity):
            Entry.MinQuantity
        else:
            GetRandomInt(Entry.MinQuantity, Entry.MaxQuantity)
    
    # ========== 工具函数 ==========
    
    # 创建掉落项
    MakeLootEntry<public>(ItemID:int, Weight:float, MinQty:int, MaxQty:int)<transacts>:loot_entry =
        loot_entry{
            ItemID := ItemID
            Weight := Weight
            MinQuantity := MinQty
            MaxQuantity := MaxQty
            GuaranteedDrop := false
        }
    
    # 创建保底状态
    MakePityState<public>(Threshold:int, GuaranteedID:int)<transacts>:pity_state =
        pity_state{
            Counter := 0
            PityThreshold := Threshold
            GuaranteedItemID := GuaranteedID
        }
