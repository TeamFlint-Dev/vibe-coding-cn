# WeightedSelector - 加权随机选择器
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第二层：选择器层
#
# 功能: 按权重进行随机选择

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

WeightedSelector<public> := module:
    # ==========================================
    # 加权选项结构
    # ==========================================
    
    weighted_item<public>(ItemType:type) := class:
        Item<public>:ItemType
        Weight<public>:float
    
    # ==========================================
    # 加权选择器类
    # ==========================================
    
    weighted_selector<public>(ItemType:type) := class:
        # 加权选项列表
        var Items<private>:[]weighted_item(ItemType) = array{}
        
        # 总权重（缓存）
        var TotalWeight<private>:float = 0.0
        
        # 选择统计
        var SelectionCounts<private>:[]int = array{}
        
        # 添加加权选项
        AddItem<public>(Item:ItemType, Weight:float):void =
            if (Weight > 0.0):
                WeightedItem := weighted_item(ItemType){Item := Item, Weight := Weight}
                set Items += array{WeightedItem}
                set TotalWeight += Weight
                set SelectionCounts += array{0}
        
        # 批量添加（项目和权重数组）
        AddItems<public>(NewItems:[]ItemType, Weights:[]float):void =
            for (I -> Item : NewItems):
                if (WeightOpt := Weights[I]):
                    if (WeightOpt > 0.0):
                        AddItem(Item, WeightOpt)
        
        # 更新选项权重
        UpdateWeight<public>(Index:int, NewWeight:float):void =
            if (Index >= 0, Index < Items.Length, NewWeight > 0.0):
                if (Item := Items[Index]):
                    OldWeight := Item.Weight
                    set Item.Weight = NewWeight
                    set TotalWeight = TotalWeight - OldWeight + NewWeight
        
        # 移除选项
        RemoveItem<public>(Index:int):void =
            if (Index >= 0, Index < Items.Length):
                if (Item := Items[Index]):
                    set TotalWeight -= Item.Weight
                    
                    NewItems := array:
                        for (I -> Itm : Items, I <> Index):
                            Itm
                    set Items = NewItems
                    
                    NewCounts := array:
                        for (I -> Count : SelectionCounts, I <> Index):
                            Count
                    set SelectionCounts = NewCounts
        
        # 清空选项
        ClearItems<public>():void =
            set Items = array{}
            set TotalWeight = 0.0
            set SelectionCounts = array{}
        
        # 按权重随机选择一个
        SelectOne<public>()<decides><transacts>:ItemType =
            Items.Length > 0
            TotalWeight > 0.0
            
            Roll := GetRandomFloat(0.0, TotalWeight)
            var CumulativeWeight:float = 0.0
            
            for (Index -> WeightedItem : Items):
                set CumulativeWeight += WeightedItem.Weight
                if (Roll <= CumulativeWeight):
                    IncrementCount(Index)
                    return WeightedItem.Item
            
            # fallback: 返回最后一个（由于浮点误差可能到达）
            LastIndex := Items.Length - 1
            IncrementCount(LastIndex)
            return Items[LastIndex].Item
        
        # 按权重选择多个（可重复）
        SelectMultiple<public>(Count:int)<transacts>:[]ItemType =
            var Result:[]ItemType = array{}
            if (Items.Length > 0, TotalWeight > 0.0):
                for (I := 0..Count - 1):
                    if (Item := SelectOne?[]):
                        set Result += array{Item}
            Result
        
        # 增加选择计数
        IncrementCount<private>(Index:int):void =
            if (Index >= 0, Index < SelectionCounts.Length):
                if (Count := SelectionCounts[Index]):
                    NewCounts := array:
                        for (I -> C : SelectionCounts):
                            if (I = Index) then C + 1 else C
                    set SelectionCounts = NewCounts
        
        # 获取选择统计
        GetSelectionCounts<public>():[]int = SelectionCounts
        
        # 重置统计
        ResetStatistics<public>():void =
            set SelectionCounts = array:
                for (I := 0..Items.Length - 1):
                    0
        
        # 获取选项数量
        GetItemCount<public>():int = Items.Length
        
        # 获取总权重
        GetTotalWeight<public>():float = TotalWeight
        
        # 获取某个选项的权重
        GetWeight<public>(Index:int):?float =
            if (Index >= 0, Index < Items.Length):
                if (Item := Items[Index]):
                    option{Item.Weight}
                else:
                    false
            else:
                false
    
    # ==========================================
    # 快捷函数
    # ==========================================
    
    # 快速加权选择
    SelectWeightedItem<public>(Items:[]t, Weights:[]float where t:type)<decides><transacts>:t =
        Items.Length > 0
        Weights.Length > 0
        Items.Length = Weights.Length
        
        var TotalWeight:float = 0.0
        for (W : Weights):
            set TotalWeight += W
        
        TotalWeight > 0.0
        
        Roll := GetRandomFloat(0.0, TotalWeight)
        var CumulativeWeight:float = 0.0
        
        for (Index -> Item : Items):
            if (Weight := Weights[Index]):
                set CumulativeWeight += Weight
                if (Roll <= CumulativeWeight):
                    return Item
        
        return Items[Items.Length - 1]
