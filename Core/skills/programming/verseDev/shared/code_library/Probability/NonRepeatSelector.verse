# NonRepeatSelector - 无重复随机选择器
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第二层：选择器层
#
# 功能: 确保不连续重复选择同一项

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

NonRepeatSelector<public> := module:
    # ==========================================
    # 无重复选择器类
    # ==========================================
    
    non_repeat_selector<public>(ItemType:type) := class:
        # 可选项列表
        var Items<public>:[]ItemType = array{}
        
        # 最近选择的索引
        var LastSelectedIndex<private>:?int = false
        
        # 最近N次选择历史
        var RecentHistory<private>:[]int = array{}
        
        # 不重复的历史长度
        NoRepeatDepth<public>:int = 1
        
        # 添加选项
        AddItem<public>(Item:ItemType):void =
            set Items += array{Item}
        
        # 批量添加选项
        AddItems<public>(NewItems:[]ItemType):void =
            set Items += NewItems
        
        # 移除选项
        RemoveItem<public>(Index:int):void =
            if (Index >= 0, Index < Items.Length):
                NewItems := array:
                    for (I -> Item : Items, I <> Index):
                        Item
                set Items = NewItems
        
        # 清空选项
        ClearItems<public>():void =
            set Items = array{}
            set LastSelectedIndex = false
            set RecentHistory = array{}
        
        # 随机选择（避免重复）
        SelectOne<public>()<decides><transacts>:ItemType =
            Items.Length > 0
            
            # 如果只有一个选项，直接返回
            if (Items.Length = 1):
                RecordSelection(0)
                Items[0]
            else:
                # 创建可选索引列表（排除最近选择的）
                var AvailableIndices:[]int = array{}
                for (I := 0..Items.Length - 1):
                    if (not IsInRecentHistory(I)?):
                        set AvailableIndices += array{I}
                
                # 如果所有选项都在历史中，清空历史重新选择
                if (AvailableIndices.Length = 0):
                    set RecentHistory = array{}
                    for (I := 0..Items.Length - 1):
                        set AvailableIndices += array{I}
                
                # 从可用索引中随机选择
                AvailableIndices.Length > 0
                RandomPos := GetRandomInt(0, AvailableIndices.Length - 1)
                SelectedIndex := AvailableIndices[RandomPos]
                RecordSelection(SelectedIndex)
                Items[SelectedIndex]
        
        # 检查索引是否在最近历史中
        IsInRecentHistory<private>(Index:int):logic =
            for (HistoryIndex : RecentHistory):
                if (HistoryIndex = Index):
                    return true
            false
        
        # 记录选择
        RecordSelection<private>(Index:int):void =
            set LastSelectedIndex = option{Index}
            
            # 添加到历史
            set RecentHistory += array{Index}
            
            # 保持历史长度
            if (RecentHistory.Length > NoRepeatDepth):
                set RecentHistory = RecentHistory.Slice[1, RecentHistory.Length]
        
        # 随机选择多个（确保不重复）
        SelectMultiple<public>(Count:int)<transacts>:[]ItemType =
            if (Items.Length = 0 or Count <= 0):
                array{}
            else:
                ActualCount := if (Count < Items.Length) then Count else Items.Length
                Shuffled := Shuffle(Items)
                
                var Result:[]ItemType = array{}
                for (I := 0..ActualCount - 1):
                    if (Item := Shuffled[I]):
                        set Result += array{Item}
                Result
        
        # 获取最近选择的索引
        GetLastSelectedIndex<public>():?int = LastSelectedIndex
        
        # 获取最近历史
        GetRecentHistory<public>():[]int = RecentHistory
        
        # 清除历史
        ClearHistory<public>():void =
            set LastSelectedIndex = false
            set RecentHistory = array{}
        
        # 获取选项数量
        GetItemCount<public>():int = Items.Length
    
    # ==========================================
    # 加权无重复选择器
    # ==========================================
    
    weighted_non_repeat_selector<public>(ItemType:type) := class:
        # 加权选项
        var Items<private>:[]ItemType = array{}
        var Weights<private>:[]float = array{}
        
        # 最近选择历史
        var RecentHistory<private>:[]int = array{}
        
        # 不重复深度
        NoRepeatDepth<public>:int = 1
        
        # 添加加权选项
        AddItem<public>(Item:ItemType, Weight:float):void =
            if (Weight > 0.0):
                set Items += array{Item}
                set Weights += array{Weight}
        
        # 选择（加权且避免重复）
        SelectOne<public>()<decides><transacts>:ItemType =
            Items.Length > 0
            
            # 计算可用选项的权重
            var AvailableIndices:[]int = array{}
            var AvailableWeights:[]float = array{}
            
            for (I := 0..Items.Length - 1):
                if (not[IsInRecentHistory(I)]):
                    set AvailableIndices += array{I}
                    if (W := Weights[I]):
                        set AvailableWeights += array{W}
            
            # 如果没有可用选项，重置历史
            if (AvailableIndices.Length = 0):
                set RecentHistory = array{}
                for (I := 0..Items.Length - 1):
                    set AvailableIndices += array{I}
                    if (W := Weights[I]):
                        set AvailableWeights += array{W}
            
            # 加权随机选择
            var TotalWeight:float = 0.0
            for (W : AvailableWeights):
                set TotalWeight += W
            
            TotalWeight > 0.0
            
            Roll := GetRandomFloat(0.0, TotalWeight)
            var CumulativeWeight:float = 0.0
            var SelectedIndexInAvailable:int = 0
            
            for (I -> W : AvailableWeights):
                set CumulativeWeight += W
                if (Roll <= CumulativeWeight):
                    set SelectedIndexInAvailable = I
                    break
            
            ActualIndex := AvailableIndices[SelectedIndexInAvailable]
            RecordSelection(ActualIndex)
            Items[ActualIndex]
        
        # 检查是否在历史中
        IsInRecentHistory<private>(Index:int):logic =
            for (HistoryIndex : RecentHistory):
                if (HistoryIndex = Index):
                    return true
            false
        
        # 记录选择
        RecordSelection<private>(Index:int):void =
            set RecentHistory += array{Index}
            if (RecentHistory.Length > NoRepeatDepth):
                set RecentHistory = RecentHistory.Slice[1, RecentHistory.Length]
        
        # 清空
        ClearItems<public>():void =
            set Items = array{}
            set Weights = array{}
            set RecentHistory = array{}
