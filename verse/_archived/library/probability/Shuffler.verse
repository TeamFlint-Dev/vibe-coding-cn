# Shuffler - 洗牌器
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第二层：选择器层
#
# 功能: 实现各种洗牌和排列算法

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

Shuffler<public> := module:
    # ==========================================
    # 洗牌算法
    # ==========================================
    
    # Fisher-Yates洗牌（标准库包装）
    ShuffleArray<public>(Items:[]t where t:type)<transacts>:[]t =
        Shuffle(Items)
    
    # 部分洗牌（只洗前N个）
    PartialShuffle<public>(Items:[]t, Count:int where t:type)<transacts>:[]t =
        if (Items.Length = 0 or Count <= 0):
            Items
        else:
            Shuffled := Shuffle(Items)
            # 返回洗牌后的前Count个，其余保持不变
            var Result:[]t = array{}
            ActualCount := if (Count < Items.Length) then Count else Items.Length
            
            for (I := 0..ActualCount - 1):
                if (Item := Shuffled[I]):
                    set Result += array{Item}
            
            # 添加剩余未洗牌的部分
            for (I := ActualCount..Items.Length - 1):
                if (Item := Items[I]):
                    set Result += array{Item}
            
            Result
    
    # ==========================================
    # 牌堆管理器
    # ==========================================
    
    deck_shuffler<public>(CardType:type) := class:
        # 原始牌堆
        var OriginalDeck<private>:[]CardType = array{}
        
        # 当前牌堆（已洗牌）
        var CurrentDeck<private>:[]CardType = array{}
        
        # 已抽取的牌
        var DrawnCards<private>:[]CardType = array{}
        
        # 洗牌次数统计
        var ShuffleCount<private>:int = 0
        
        # 初始化牌堆
        InitializeDeck<public>(Cards:[]CardType):void =
            set OriginalDeck = Cards
            set CurrentDeck = Cards
            set DrawnCards = array{}
        
        # 洗牌
        ShuffleDeck<public>()<transacts>:void =
            set CurrentDeck = Shuffle(CurrentDeck)
            set ShuffleCount += 1
        
        # 抽一张牌
        DrawCard<public>()<decides><transacts>:CardType =
            CurrentDeck.Length > 0
            
            # 从顶部抽牌
            TopCard := CurrentDeck[0]
            
            # 移除第一张牌
            set CurrentDeck = CurrentDeck.Slice[1, CurrentDeck.Length]
            
            # 记录到已抽取
            set DrawnCards += array{TopCard}
            
            TopCard
        
        # 抽多张牌
        DrawCards<public>(Count:int)<transacts>:[]CardType =
            var Result:[]CardType = array{}
            
            ActualCount := if (Count < CurrentDeck.Length) then Count else CurrentDeck.Length
            
            for (I := 0..ActualCount - 1):
                if (Card := DrawCard?[]):
                    set Result += array{Card}
            
            Result
        
        # 从底部抽牌
        DrawFromBottom<public>()<decides><transacts>:CardType =
            CurrentDeck.Length > 0
            
            BottomCard := CurrentDeck[CurrentDeck.Length - 1]
            
            # 移除最后一张
            if (CurrentDeck.Length > 1):
                set CurrentDeck = CurrentDeck.Slice[0, CurrentDeck.Length - 1]
            else:
                set CurrentDeck = array{}
            
            set DrawnCards += array{BottomCard}
            
            BottomCard
        
        # 将已抽取的牌放回并洗牌
        Reshuffle<public>()<transacts>:void =
            set CurrentDeck += DrawnCards
            set DrawnCards = array{}
            ShuffleDeck()
        
        # 重置牌堆（恢复到初始状态）
        ResetDeck<public>()<transacts>:void =
            set CurrentDeck = OriginalDeck
            set DrawnCards = array{}
            ShuffleDeck()
        
        # 查看顶部N张牌（不抽取）
        PeekTop<public>(Count:int):[]CardType =
            var Result:[]CardType = array{}
            ActualCount := if (Count < CurrentDeck.Length) then Count else CurrentDeck.Length
            
            for (I := 0..ActualCount - 1):
                if (Card := CurrentDeck[I]):
                    set Result += array{Card}
            
            Result
        
        # 获取剩余牌数
        GetRemainingCount<public>():int = CurrentDeck.Length
        
        # 获取已抽取牌数
        GetDrawnCount<public>():int = DrawnCards.Length
        
        # 获取洗牌次数
        GetShuffleCount<public>():int = ShuffleCount
        
        # 检查牌堆是否为空
        IsEmpty<public>():logic = CurrentDeck.Length = 0
    
    # ==========================================
    # 随机排列生成器
    # ==========================================
    
    # 生成随机排列（索引数组）
    GeneratePermutation<public>(N:int)<transacts>:[]int =
        var Indices:[]int = array{}
        for (I := 0..N - 1):
            set Indices += array{I}
        Shuffle(Indices)
    
    # 生成部分随机排列（只打乱前K个）
    GeneratePartialPermutation<public>(N:int, K:int)<transacts>:[]int =
        var Indices:[]int = array{}
        for (I := 0..N - 1):
            set Indices += array{I}
        
        if (K >= N or K <= 0):
            Shuffle(Indices)
        else:
            # 只打乱前K个位置
            Shuffled := Shuffle(Indices)
            var Result:[]int = array{}
            
            for (I := 0..K - 1):
                if (Idx := Shuffled[I]):
                    set Result += array{Idx}
            
            # 保持剩余部分不变
            for (I := K..N - 1):
                if (Idx := Indices[I]):
                    set Result += array{Idx}
            
            Result
    
    # ==========================================
    # 分组洗牌
    # ==========================================
    
    # 将数组分成N组，每组内部洗牌
    ShuffleInGroups<public>(Items:[]t, GroupSize:int where t:type)<transacts>:[]t =
        if (Items.Length = 0 or GroupSize <= 0):
            Items
        else:
            var Result:[]t = array{}
            var CurrentGroup:[]t = array{}
            
            for (I -> Item : Items):
                set CurrentGroup += array{Item}
                
                # 当组满了或到达末尾时，洗牌并添加
                if (CurrentGroup.Length >= GroupSize or I = Items.Length - 1):
                    ShuffledGroup := Shuffle(CurrentGroup)
                    set Result += ShuffledGroup
                    set CurrentGroup = array{}
            
            Result
    
    # 交错洗牌（将两个数组交错合并）
    InterleaveShuffle<public>(Items1:[]t, Items2:[]t where t:type)<transacts>:[]t =
        var Result:[]t = array{}
        MaxLength := if (Items1.Length > Items2.Length) then Items1.Length else Items2.Length
        
        for (I := 0..MaxLength - 1):
            # 随机决定从哪个数组取
            if (GetRandomFloat(0.0, 1.0) < 0.5):
                if (Item := Items1[I]):
                    set Result += array{Item}
                if (Item := Items2[I]):
                    set Result += array{Item}
            else:
                if (Item := Items2[I]):
                    set Result += array{Item}
                if (Item := Items1[I]):
                    set Result += array{Item}
        
        Result
