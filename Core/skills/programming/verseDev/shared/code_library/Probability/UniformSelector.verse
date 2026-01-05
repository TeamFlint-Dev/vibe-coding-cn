# UniformSelector - 均匀随机选择器
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第二层：选择器层
#
# 功能: 提供均匀随机选择功能

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

UniformSelector<public> := module:
    # ==========================================
    # 均匀选择器类
    # ==========================================
    
    uniform_selector<public>(ItemType:type) := class:
        # 可选项列表
        var Items<public>:[]ItemType = array{}
        
        # 选择历史
        var SelectionHistory<private>:[]int = array{}
        
        # 最大历史记录数
        MaxHistorySize<public>:int = 1000
        
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
        
        # 随机选择一个（均匀分布）
        SelectOne<public>()<decides><transacts>:ItemType =
            Items.Length > 0
            Index := GetRandomInt(0, Items.Length - 1)
            RecordSelection(Index)
            Items[Index]
        
        # 随机选择多个（不重复）
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
        
        # 随机选择多个（可重复）
        SelectMultipleWithReplacement<public>(Count:int)<transacts>:[]ItemType =
            var Result:[]ItemType = array{}
            if (Items.Length > 0):
                for (I := 0..Count - 1):
                    Index := GetRandomInt(0, Items.Length - 1)
                    if (Item := Items[Index]):
                        set Result += array{Item}
                        RecordSelection(Index)
            Result
        
        # 记录选择历史
        RecordSelection<private>(Index:int):void =
            if (SelectionHistory.Length >= MaxHistorySize):
                if (SelectionHistory.Length > 0):
                    set SelectionHistory = SelectionHistory.Slice[1, SelectionHistory.Length]
            set SelectionHistory += array{Index}
        
        # 获取选择历史
        GetSelectionHistory<public>():[]int = SelectionHistory
        
        # 清除历史
        ClearHistory<public>():void =
            set SelectionHistory = array{}
        
        # 获取选项数量
        GetItemCount<public>():int = Items.Length
    
    # ==========================================
    # 快捷函数
    # ==========================================
    
    # 从数组中随机选择一个
    SelectRandomItem<public>(Items:[]t where t:type)<decides><transacts>:t =
        Items.Length > 0
        Index := GetRandomInt(0, Items.Length - 1)
        Items[Index]
    
    # 从数组中随机选择多个（不重复）
    SelectRandomItems<public>(Items:[]t, Count:int where t:type)<transacts>:[]t =
        if (Items.Length = 0 or Count <= 0):
            array{}
        else:
            ActualCount := if (Count < Items.Length) then Count else Items.Length
            Shuffled := Shuffle(Items)
            
            var Result:[]t = array{}
            for (I := 0..ActualCount - 1):
                if (Item := Shuffled[I]):
                    set Result += array{Item}
            Result
