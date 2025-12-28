# TimerManager - 定时器管理类
# 版本: 1.1
# 添加时间: 2025-12-27
# 修改时间: 2025-12-28
# 层级: L2.5 Managers (有状态管理器)
# 来源: REQ-002 (循环迭代模式)
# 变更: CHANGE-005 - 从 Helpers/ 迁移至 Managers/ (ARC-008 合规)

using { /Verse.org/Simulation }

# 定时器句柄
timer_handle<public> := class<concrete>:
    var ID<internal>:int = 0
    var IsValid<internal>:logic = false

# 定时器状态
timer_state<public> := enum:
    Running
    Paused
    Completed
    Cancelled

# 内部定时器数据
timer_data<internal> := class:
    var Handle:timer_handle
    var Duration:float
    var RemainingTime:float
    var IsRepeating:logic
    var State:timer_state
    var Callback:type{():void}

# 定时器管理器
timer_manager<public> := class:
    var Timers<private>:[]timer_data = array{}
    var NextID<private>:int = 1
    var IsRunning<private>:logic = false
    
    # ==========================================
    # 管理器生命周期
    # ==========================================
    
    # 启动管理器（需要在协程中调用）
    StartManager<public>()<suspends>:void =
        set IsRunning = true
        loop:
            if not IsRunning:
                break
            UpdateTimers(GetDeltaTime())
            Sleep(0.0)
    
    # 停止管理器
    StopManager<public>():void =
        set IsRunning = false
        for (Timer in Timers):
            set Timer.State = timer_state.Cancelled
        set Timers = array{}
    
    # ==========================================
    # 创建定时器
    # ==========================================
    
    # 创建一次性定时器
    CreateTimer<public>(Duration:float, Callback:type{():void}):timer_handle =
        Handle := timer_handle{ID := NextID, IsValid := true}
        set NextID += 1
        
        NewTimer := timer_data{
            Handle := Handle,
            Duration := Duration,
            RemainingTime := Duration,
            IsRepeating := false,
            State := timer_state.Running,
            Callback := Callback
        }
        
        set Timers += array{NewTimer}
        return Handle
    
    # 创建重复定时器
    CreateRepeatingTimer<public>(Interval:float, Callback:type{():void}):timer_handle =
        Handle := timer_handle{ID := NextID, IsValid := true}
        set NextID += 1
        
        NewTimer := timer_data{
            Handle := Handle,
            Duration := Interval,
            RemainingTime := Interval,
            IsRepeating := true,
            State := timer_state.Running,
            Callback := Callback
        }
        
        set Timers += array{NewTimer}
        return Handle
    
    # 创建延迟调用（语法糖）
    Delay<public>(Duration:float, Callback:type{():void}):timer_handle =
        return CreateTimer(Duration, Callback)
    
    # ==========================================
    # 控制定时器
    # ==========================================
    
    CancelTimer<public>(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                set Timer.State = timer_state.Cancelled
                set Timer.Handle.IsValid = false
                return true
        return false
    
    PauseTimer<public>(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID and Timer.State = timer_state.Running:
                set Timer.State = timer_state.Paused
                return true
        return false
    
    ResumeTimer<public>(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID and Timer.State = timer_state.Paused:
                set Timer.State = timer_state.Running
                return true
        return false
    
    ResetTimer<public>(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                set Timer.RemainingTime = Timer.Duration
                set Timer.State = timer_state.Running
                return true
        return false
    
    # ==========================================
    # 查询定时器
    # ==========================================
    
    GetRemainingTime<public>(Handle:timer_handle):float =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                return Timer.RemainingTime
        return 0.0
    
    GetElapsedTime<public>(Handle:timer_handle):float =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                return Timer.Duration - Timer.RemainingTime
        return 0.0
    
    GetProgress<public>(Handle:timer_handle):float =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                if Timer.Duration > 0.0:
                    return 1.0 - (Timer.RemainingTime / Timer.Duration)
        return 0.0
    
    IsTimerValid<public>(Handle:timer_handle):logic =
        return Handle.IsValid
    
    IsTimerRunning<public>(Handle:timer_handle):logic =
        for (Timer in Timers):
            if Timer.Handle.ID = Handle.ID:
                return Timer.State = timer_state.Running
        return false
    
    GetActiveTimerCount<public>():int =
        Count := 0
        for (Timer in Timers):
            if Timer.State = timer_state.Running or Timer.State = timer_state.Paused:
                set Count += 1
        return Count
    
    # ==========================================
    # 内部更新
    # ==========================================
    
    UpdateTimers<private>(DeltaTime:float):void =
        TimersToRemove:[]int = array{}
        
        for (Index -> Timer in Timers):
            case (Timer.State):
                timer_state.Running =>
                    set Timer.RemainingTime -= DeltaTime
                    if Timer.RemainingTime <= 0.0:
                        Timer.Callback()
                        if Timer.IsRepeating:
                            set Timer.RemainingTime = Timer.Duration
                        else:
                            set Timer.State = timer_state.Completed
                            set Timer.Handle.IsValid = false
                            set TimersToRemove += array{Index}
                
                timer_state.Cancelled =>
                    set TimersToRemove += array{Index}
                
                _ =>
                    # Paused 或 Completed，不处理
        
        CleanupTimers(TimersToRemove)
    
    CleanupTimers<private>(Indices:[]int):void =
        NewTimers:[]timer_data = array{}
        for (Index -> Timer in Timers):
            ShouldRemove := false
            for (RemoveIndex in Indices):
                if Index = RemoveIndex:
                    set ShouldRemove = true
                    break
            if not ShouldRemove:
                set NewTimers += array{Timer}
        set Timers = NewTimers
