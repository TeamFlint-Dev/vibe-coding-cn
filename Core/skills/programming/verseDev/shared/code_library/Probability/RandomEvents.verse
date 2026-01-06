# RandomEvents - 随机事件系统
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第四层：游戏应用层
#
# 功能: 实现游戏随机事件触发系统

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

RandomEvents<public> := module:
    # 辅助函数：模运算 - 已移至标准库 /Verse.org/Verse:Mod
    # 请直接使用标准库函数
    
    # ==========================================
    # 事件定义
    # ==========================================
    
    random_event<public>(EventType:type) := class:
        # 事件数据
        Event<public>:EventType
        
        # 事件权重
        Weight<public>:float
        
        # 触发概率（独立判定）
        TriggerChance<public>:float = 1.0
        
        # 冷却时间（秒）
        Cooldown<public>:float = 0.0
        
        # 最后触发时间
        var LastTriggerTime<public>:float = -999999.0
        
        # 是否可重复触发
        CanRepeat<public>:logic = true
        
        # 已触发次数
        var TriggerCount<private>:int = 0
        
        # 最大触发次数（-1表示无限制）
        MaxTriggers<public>:int = -1
        
        # 检查是否在冷却中
        IsOnCooldown<public>(CurrentTime:float):logic =
            if (Cooldown > 0.0):
                (CurrentTime - LastTriggerTime) < Cooldown
            else:
                false
        
        # 检查是否可以触发
        CanTrigger<public>(CurrentTime:float):logic =
            # 检查冷却
            if (IsOnCooldown(CurrentTime)):
                return false
            
            # 检查最大触发次数
            if (MaxTriggers > 0, TriggerCount >= MaxTriggers):
                return false
            
            # 检查是否可重复
            if (not CanRepeat?, TriggerCount > 0):
                return false
            
            true
        
        # 记录触发
        RecordTrigger<public>(CurrentTime:float):void =
            set LastTriggerTime = CurrentTime
            set TriggerCount += 1
        
        # 获取触发次数
        GetTriggerCount<public>():int = TriggerCount
        
        # 重置
        Reset<public>():void =
            set LastTriggerTime = -999999.0
            set TriggerCount = 0
    
    # ==========================================
    # 事件管理器
    # ==========================================
    
    event_manager<public>(EventType:type) := class:
        # 事件列表
        var Events<private>:[]random_event(EventType) = array{}
        
        # 当前游戏时间（需要外部更新）
        var CurrentTime<public>:float = 0.0
        
        # 事件触发历史
        var TriggerHistory<private>:[]EventType = array{}
        
        # 最大历史记录
        MaxHistorySize<public>:int = 100
        
        # 添加事件
        AddEvent<public>(Event:EventType, Weight:float, TriggerChance:float, Cooldown:float, CanRepeat:logic, MaxTriggers:int):void =
            RandomEvent := random_event(EventType){
                Event := Event,
                Weight := Weight,
                TriggerChance := TriggerChance,
                Cooldown := Cooldown,
                CanRepeat := CanRepeat,
                MaxTriggers := MaxTriggers
            }
            set Events += array{RandomEvent}
        
        # 简化添加（无限制）
        AddSimpleEvent<public>(Event:EventType, Weight:float):void =
            AddEvent(Event, Weight, 1.0, 0.0, true, -1)
        
        # 尝试触发事件
        TryTriggerEvent<public>()<decides><transacts>:EventType =
            # 筛选可触发的事件
            var EligibleEvents:[]random_event(EventType) = array{}
            var EligibleWeights:[]float = array{}
            
            for (Event : Events):
                if (Event.CanTrigger(CurrentTime)):
                    set EligibleEvents += array{Event}
                    set EligibleWeights += array{Event.Weight}
            
            EligibleEvents.Length > 0
            
            # 按权重选择
            var TotalWeight:float = 0.0
            for (W : EligibleWeights):
                set TotalWeight += W
            
            TotalWeight > 0.0
            
            Roll := GetRandomFloat(0.0, TotalWeight)
            var CumulativeWeight:float = 0.0
            
            for (Index -> Event : EligibleEvents):
                if (Weight := EligibleWeights[Index]):
                    set CumulativeWeight += Weight
                    if (Roll <= CumulativeWeight):
                        # 概率判定
                        if (GetRandomFloat(0.0, 1.0) <= Event.TriggerChance):
                            Event.RecordTrigger(CurrentTime)
                            RecordHistory(Event.Event)
                            Event.Event
            
            # fallback: 由于浮点误差，选择最后一个
            LastIndex := EligibleEvents.Length - 1
            LastEvent := EligibleEvents[LastIndex]
            if (GetRandomFloat(0.0, 1.0) <= LastEvent.TriggerChance):
                LastEvent.RecordTrigger(CurrentTime)
                RecordHistory(LastEvent.Event)
            LastEvent.Event
        
        # 记录历史
        RecordHistory<private>(Event:EventType):void =
            set TriggerHistory += array{Event}
            
            if (TriggerHistory.Length > MaxHistorySize):
                set TriggerHistory = TriggerHistory.Slice[1, TriggerHistory.Length]
        
        # 更新时间
        UpdateTime<public>(NewTime:float):void =
            set CurrentTime = NewTime
        
        # 获取事件数量
        GetEventCount<public>():int = Events.Length
        
        # 获取可触发事件数量
        GetEligibleEventCount<public>():int =
            var Count:int = 0
            for (Event : Events):
                if (Event.CanTrigger(CurrentTime)):
                    set Count += 1
            Count
        
        # 获取触发历史
        GetTriggerHistory<public>():[]EventType = TriggerHistory
        
        # 清空历史
        ClearHistory<public>():void =
            set TriggerHistory = array{}
        
        # 重置所有事件
        ResetAllEvents<public>():void =
            for (Event : Events):
                Event.Reset()
            set TriggerHistory = array{}
    
    # 创建事件管理器
    CreateEventManager<public>(EventType:type):event_manager(EventType) =
        event_manager(EventType){}
    
    # ==========================================
    # 定时事件系统
    # ==========================================
    
    timed_event<public>(EventType:type) := class:
        # 事件数据
        Event<public>:EventType
        
        # 触发间隔（秒）
        Interval<public>:float
        
        # 间隔随机范围（±）
        IntervalVariance<public>:float = 0.0
        
        # 下次触发时间
        var NextTriggerTime<private>:float = 0.0
        
        # 是否启用
        var IsEnabled<public>:logic = true
        
        # 初始化
        Initialize<public>(StartTime:float):void =
            ScheduleNext(StartTime)
        
        # 安排下次触发
        ScheduleNext<private>(CurrentTime:float):void =
            # 计算随机间隔
            ActualInterval := if (IntervalVariance > 0.0):
                Interval + GetRandomFloat(-IntervalVariance, IntervalVariance)
            else:
                Interval
            
            set NextTriggerTime = CurrentTime + ActualInterval
        
        # 检查是否应该触发
        ShouldTrigger<public>(CurrentTime:float):logic =
            IsEnabled and (CurrentTime >= NextTriggerTime)
        
        # 触发并重新安排
        TriggerAndReschedule<public>(CurrentTime:float):void =
            ScheduleNext(CurrentTime)
        
        # 启用/禁用
        SetEnabled<public>(Enabled:logic):void =
            set IsEnabled = Enabled
        
        # 获取下次触发时间
        GetNextTriggerTime<public>():float = NextTriggerTime
    
    # ==========================================
    # 定时事件管理器
    # ==========================================
    
    timed_event_manager<public>(EventType:type) := class:
        # 定时事件列表
        var TimedEvents<private>:[]timed_event(EventType) = array{}
        
        # 当前时间
        var CurrentTime<public>:float = 0.0
        
        # 添加定时事件
        AddTimedEvent<public>(Event:EventType, Interval:float, Variance:float, StartTime:float):void =
            TimedEvent := timed_event(EventType){
                Event := Event,
                Interval := Interval,
                IntervalVariance := Variance
            }
            TimedEvent.Initialize(StartTime)
            set TimedEvents += array{TimedEvent}
        
        # 更新并检查触发
        Update<public>(NewTime:float)<transacts>:[]EventType =
            set CurrentTime = NewTime
            
            var TriggeredEvents:[]EventType = array{}
            
            for (TimedEvent : TimedEvents):
                if (TimedEvent.ShouldTrigger(CurrentTime)):
                    set TriggeredEvents += array{TimedEvent.Event}
                    TimedEvent.TriggerAndReschedule(CurrentTime)
            
            TriggeredEvents
        
        # 获取事件数量
        GetEventCount<public>():int = TimedEvents.Length
    
    # 创建定时事件管理器
    CreateTimedEventManager<public>(EventType:type):timed_event_manager(EventType) =
        timed_event_manager(EventType){}
    
    # ==========================================
    # 链式事件系统
    # ==========================================
    
    event_chain<public>(EventType:type) := class:
        # 事件链
        var EventSequence<private>:[]EventType = array{}
        
        # 当前索引
        var CurrentIndex<private>:int = 0
        
        # 是否循环
        IsLooping<public>:logic = false
        
        # 添加事件到链
        AddToChain<public>(Event:EventType):void =
            set EventSequence += array{Event}
        
        # 获取下一个事件
        GetNextEvent<public>()<decides>:EventType =
            EventSequence.Length > 0
            CurrentIndex < EventSequence.Length or IsLooping
            
            Index := if (IsLooping):
                Mod(CurrentIndex, EventSequence.Length)
            else:
                CurrentIndex
            
            Event := EventSequence[Index]
            set CurrentIndex += 1
            
            Event
        
        # 重置链
        Reset<public>():void =
            set CurrentIndex = 0
        
        # 检查是否完成
        IsComplete<public>():logic =
            if (IsLooping):
                false
            else:
                CurrentIndex >= EventSequence.Length
        
        # 获取进度
        GetProgress<public>():float =
            if (EventSequence.Length = 0):
                0.0
            else:
                CurrentIndex / EventSequence.Length
    
    # 创建事件链
    CreateEventChain<public>(EventType:type, IsLooping:logic):event_chain(EventType) =
        event_chain(EventType){IsLooping := IsLooping}
    
    # ==========================================
    # 条件事件系统
    # ==========================================
    
    conditional_event<public>(EventType:type, ConditionType:type) := class:
        # 事件数据
        Event<public>:EventType
        
        # 条件（简化：只存储是否满足）
        var ConditionMet<public>:logic = false
        
        # 权重
        Weight<public>:float = 1.0
        
        # 检查是否可触发
        CanTrigger<public>():logic = ConditionMet
    
    # 创建条件事件
    CreateConditionalEvent<public>(EventType:type, ConditionType:type, Event:EventType, Weight:float):conditional_event(EventType, ConditionType) =
        conditional_event(EventType, ConditionType){
            Event := Event,
            Weight := Weight
        }
