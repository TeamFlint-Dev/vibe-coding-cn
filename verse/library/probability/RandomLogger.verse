# RandomLogger - 随机日志系统
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第五层：调试与分析层
#
# 功能: 记录和追踪随机事件，用于调试和分析

using { /Verse.org/Simulation }
using { /Verse.org/Verse }

RandomLogger<public> := module:
    # ==========================================
    # 日志条目
    # ==========================================
    
    log_entry<public> := class:
        # 时间戳
        TimeStamp<public>:float
        
        # 事件类型
        EventType<public>:string
        
        # 描述
        Description<public>:string
        
        # 数值数据（可选）
        Value<public>:?float = false
        
        # 额外信息
        ExtraInfo<public>:string = ""
    
    # ==========================================
    # 随机事件日志器
    # ==========================================
    
    random_logger<public> := class:
        # 日志条目列表
        var LogEntries<private>:[]log_entry = array{}
        
        # 最大日志条目数
        MaxLogEntries<public>:int = 10000
        
        # 当前时间
        var CurrentTime<public>:float = 0.0
        
        # 是否启用
        var IsEnabled<public>:logic = true
        
        # 记录事件
        LogEvent<public>(EventType:string, Description:string):void =
            if (IsEnabled):
                Entry := log_entry{
                    TimeStamp := CurrentTime,
                    EventType := EventType,
                    Description := Description
                }
                AddEntry(Entry)
        
        # 记录带值的事件
        LogEventWithValue<public>(EventType:string, Description:string, Value:float):void =
            if (IsEnabled):
                Entry := log_entry{
                    TimeStamp := CurrentTime,
                    EventType := EventType,
                    Description := Description,
                    Value := option{Value}
                }
                AddEntry(Entry)
        
        # 记录带详细信息的事件
        LogEventDetailed<public>(EventType:string, Description:string, Value:float, ExtraInfo:string):void =
            if (IsEnabled):
                Entry := log_entry{
                    TimeStamp := CurrentTime,
                    EventType := EventType,
                    Description := Description,
                    Value := option{Value},
                    ExtraInfo := ExtraInfo
                }
                AddEntry(Entry)
        
        # 添加日志条目
        AddEntry<private>(Entry:log_entry):void =
            set LogEntries += array{Entry}
            
            # 限制大小
            if (LogEntries.Length > MaxLogEntries):
                set LogEntries = LogEntries.Slice[LogEntries.Length - MaxLogEntries, LogEntries.Length]
        
        # 更新时间
        UpdateTime<public>(NewTime:float):void =
            set CurrentTime = NewTime
        
        # 获取所有日志
        GetAllLogs<public>():[]log_entry = LogEntries
        
        # 按类型过滤日志
        GetLogsByType<public>(EventType:string):[]log_entry =
            var FilteredLogs:[]log_entry = array{}
            
            for (Entry : LogEntries):
                if (Entry.EventType = EventType):
                    set FilteredLogs += array{Entry}
            
            FilteredLogs
        
        # 获取时间范围内的日志
        GetLogsInTimeRange<public>(StartTime:float, EndTime:float):[]log_entry =
            var FilteredLogs:[]log_entry = array{}
            
            for (Entry : LogEntries):
                if (Entry.TimeStamp >= StartTime, Entry.TimeStamp <= EndTime):
                    set FilteredLogs += array{Entry}
            
            FilteredLogs
        
        # 获取最近N条日志
        GetRecentLogs<public>(Count:int):[]log_entry =
            if (Count >= LogEntries.Length):
                LogEntries
            else:
                LogEntries.Slice[LogEntries.Length - Count, LogEntries.Length]
        
        # 获取日志数量
        GetLogCount<public>():int = LogEntries.Length
        
        # 清除所有日志
        ClearLogs<public>():void =
            set LogEntries = array{}
        
        # 启用/禁用
        SetEnabled<public>(Enabled:logic):void =
            set IsEnabled = Enabled
    
    # 创建日志器
    CreateLogger<public>():random_logger =
        random_logger{}
    
    # ==========================================
    # 概率事件追踪器
    # ==========================================
    
    probability_tracker<public> := class:
        # 事件名称
        EventName<public>:string
        
        # 尝试次数
        var AttemptCount<private>:int = 0
        
        # 成功次数
        var SuccessCount<private>:int = 0
        
        # 失败次数
        var FailureCount<private>:int = 0
        
        # 连续成功
        var ConsecutiveSuccesses<private>:int = 0
        
        # 连续失败
        var ConsecutiveFailures<private>:int = 0
        
        # 最大连续成功
        var MaxConsecutiveSuccesses<private>:int = 0
        
        # 最大连续失败
        var MaxConsecutiveFailures<private>:int = 0
        
        # 记录尝试
        RecordAttempt<public>(Success:logic):void =
            set AttemptCount += 1
            
            if (Success):
                set SuccessCount += 1
                set ConsecutiveSuccesses += 1
                set ConsecutiveFailures = 0
                
                if (ConsecutiveSuccesses > MaxConsecutiveSuccesses):
                    set MaxConsecutiveSuccesses = ConsecutiveSuccesses
            else:
                set FailureCount += 1
                set ConsecutiveFailures += 1
                set ConsecutiveSuccesses = 0
                
                if (ConsecutiveFailures > MaxConsecutiveFailures):
                    set MaxConsecutiveFailures = ConsecutiveFailures
        
        # 获取成功率
        GetSuccessRate<public>():float =
            if (AttemptCount > 0):
                SuccessCount / AttemptCount
            else:
                0.0
        
        # 获取失败率
        GetFailureRate<public>():float =
            if (AttemptCount > 0):
                FailureCount / AttemptCount
            else:
                0.0
        
        # 获取统计
        GetAttemptCount<public>():int = AttemptCount
        GetSuccessCount<public>():int = SuccessCount
        GetFailureCount<public>():int = FailureCount
        GetConsecutiveSuccesses<public>():int = ConsecutiveSuccesses
        GetConsecutiveFailures<public>():int = ConsecutiveFailures
        GetMaxConsecutiveSuccesses<public>():int = MaxConsecutiveSuccesses
        GetMaxConsecutiveFailures<public>():int = MaxConsecutiveFailures
        
        # 重置
        Reset<public>():void =
            set AttemptCount = 0
            set SuccessCount = 0
            set FailureCount = 0
            set ConsecutiveSuccesses = 0
            set ConsecutiveFailures = 0
            set MaxConsecutiveSuccesses = 0
            set MaxConsecutiveFailures = 0
    
    # 创建追踪器
    CreateTracker<public>(EventName:string):probability_tracker =
        probability_tracker{EventName := EventName}
    
    # ==========================================
    # 性能分析器
    # ==========================================
    
    performance_analyzer<public> := class:
        # 操作名称
        OperationName<public>:string
        
        # 调用次数
        var CallCount<private>:int = 0
        
        # 总时间
        var TotalTime<private>:float = 0.0
        
        # 最小时间
        var MinTime<private>:float = 999999.0
        
        # 最大时间
        var MaxTime<private>:float = 0.0
        
        # 记录调用
        RecordCall<public>(Duration:float):void =
            set CallCount += 1
            set TotalTime += Duration
            
            if (Duration < MinTime):
                set MinTime = Duration
            
            if (Duration > MaxTime):
                set MaxTime = Duration
        
        # 获取平均时间
        GetAverageTime<public>():float =
            if (CallCount > 0):
                TotalTime / CallCount
            else:
                0.0
        
        # 获取统计
        GetCallCount<public>():int = CallCount
        GetTotalTime<public>():float = TotalTime
        GetMinTime<public>():float = if (CallCount > 0) then MinTime else 0.0
        GetMaxTime<public>():float = MaxTime
        
        # 重置
        Reset<public>():void =
            set CallCount = 0
            set TotalTime = 0.0
            set MinTime = 999999.0
            set MaxTime = 0.0
    
    # 创建性能分析器
    CreatePerformanceAnalyzer<public>(OperationName:string):performance_analyzer =
        performance_analyzer{OperationName := OperationName}
    
    # ==========================================
    # 会话记录器
    # ==========================================
    
    session_recorder<public> := class:
        # 会话ID
        SessionID<public>:string
        
        # 开始时间
        StartTime<public>:float
        
        # 结束时间
        var EndTime<public>:?float = false
        
        # 事件列表
        var Events<private>:[]string = array{}
        
        # 记录事件
        RecordEvent<public>(Event:string):void =
            set Events += array{Event}
        
        # 结束会话
        EndSession<public>(Time:float):void =
            set EndTime = option{Time}
        
        # 获取会话时长
        GetDuration<public>():?float =
            if (End := EndTime?):
                option{End - StartTime}
            else:
                false
        
        # 获取事件数量
        GetEventCount<public>():int = Events.Length
        
        # 获取所有事件
        GetEvents<public>():[]string = Events
    
    # 创建会话记录器
    CreateSessionRecorder<public>(SessionID:string, StartTime:float):session_recorder =
        session_recorder{
            SessionID := SessionID,
            StartTime := StartTime
        }
