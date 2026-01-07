# TimerManager - 定时器管理类
# 版本: 1.4
# 添加时间: 2025-12-27
# 修改时间: 2025-12-29
# 更新: 修复回调类型语法，移除不可用的 GetDeltaTime
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
    var Handle:timer_handle = timer_handle{}
    var Duration:float = 0.0
    var RemainingTime:float = 0.0
    var IsRepeating:logic = false
    var State:timer_state = timer_state.Running
    var Callback:type { _(): void }

# 定时器管理器
timer_manager<public> := class:
    var Timers<private>:[]timer_data = array{}
    var NextID<private>:int = 1
    var IsRunning<private>:logic = false
    
    # ==========================================
    # 管理器生命周期
    # ==========================================
    
    # 启动管理器（需要在协程中调用）
    # 注意：使用固定的 delta time 间隔
    StartManager<public>()<suspends>:void =
        set IsRunning = true
        loop:
            if (not IsRunning?):
                break
            # 使用固定的 delta time（16.67ms ≈ 60fps）
            DeltaTime := 0.01667
            UpdateTimers(DeltaTime)
            Sleep(0.0)
    
    # 停止管理器
    StopManager<public>():void =
        set IsRunning = false
        for (Timer : Timers):
            set Timer.State = timer_state.Cancelled
        set Timers = array{}
    
    # ==========================================
    # 创建定时器
    # ==========================================
    
    # 创建一次性定时器
    CreateTimer<public>(Duration:float, Callback:type { _(): void }):timer_handle =
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
        Handle
    
    # 创建重复定时器
    CreateRepeatingTimer<public>(Interval:float, Callback:type { _(): void }):timer_handle =
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
        Handle
    
    # 创建延迟调用（语法糖）
    Delay<public>(Duration:float, Callback:type { _(): void }):timer_handle =
        CreateTimer(Duration, Callback)
    
    # ==========================================
    # 控制定时器
    # ==========================================
    
    CancelTimer<public>(Handle:timer_handle):logic =
        var Found:logic = false
        for (Timer : Timers):
            if (Timer.Handle.ID = Handle.ID):
                set Timer.State = timer_state.Cancelled
                set Timer.Handle.IsValid = false
                set Found = true
        Found
    
    PauseTimer<public>(Handle:timer_handle):logic =
        var Found:logic = false
        for (Timer : Timers):
            if (Timer.Handle.ID = Handle.ID and Timer.State = timer_state.Running):
                set Timer.State = timer_state.Paused
                set Found = true
        Found
    
    ResumeTimer<public>(Handle:timer_handle):logic =
        var Found:logic = false
        for (Timer : Timers):
            if (Timer.Handle.ID = Handle.ID and Timer.State = timer_state.Paused):
                set Timer.State = timer_state.Running
                set Found = true
        Found
    
    ResetTimer<public>(Handle:timer_handle):logic =
        var Found:logic = false
        for (Timer : Timers):
            if (Timer.Handle.ID = Handle.ID):
                set Timer.RemainingTime = Timer.Duration
                set Timer.State = timer_state.Running
                set Found = true
        Found
    
    # ==========================================
    # 查询定时器
    # ==========================================
    
    GetRemainingTime<public>(Handle:timer_handle):float =
        var Result:float = 0.0
        for (Timer : Timers):
            if (Timer.Handle.ID = Handle.ID):
                set Result = Timer.RemainingTime
        Result
    
    GetElapsedTime<public>(Handle:timer_handle):float =
        var Result:float = 0.0
        for (Timer : Timers):
            if (Timer.Handle.ID = Handle.ID):
                set Result = Timer.Duration - Timer.RemainingTime
        Result
    
    GetProgress<public>(Handle:timer_handle):float =
        var Result:float = 0.0
        for (Timer : Timers):
            if (Timer.Handle.ID = Handle.ID):
                if (Timer.Duration > 0.0):
                    set Result = 1.0 - (Timer.RemainingTime / Timer.Duration)
        Result
    
    IsTimerValid<public>(Handle:timer_handle):logic =
        Handle.IsValid
    
    IsTimerRunning<public>(Handle:timer_handle):logic =
        var Result:logic = false
        for (Timer : Timers, Timer.Handle.ID = Handle.ID, Timer.State = timer_state.Running):
            set Result = true
        Result
    
    GetActiveTimerCount<public>():int =
        var Count:int = 0
        for (Timer : Timers, Timer.State = timer_state.Running):
            set Count += 1
        for (Timer : Timers, Timer.State = timer_state.Paused):
            set Count += 1
        Count
    
    # ==========================================
    # 内部更新
    # ==========================================
    
    UpdateTimers<private>(DeltaTime:float):void =
        var TimersToRemove:[]int = array{}
        
        for (Index -> Timer : Timers, Timer.State = timer_state.Running):
            set Timer.RemainingTime -= DeltaTime
            if (Timer.RemainingTime <= 0.0):
                Timer.Callback()
                if (Timer.IsRepeating?):
                    set Timer.RemainingTime = Timer.Duration
                else:
                    set Timer.State = timer_state.Completed
                    set Timer.Handle.IsValid = false
                    set TimersToRemove += array{Index}
        
        for (Index -> Timer : Timers, Timer.State = timer_state.Cancelled):
            set TimersToRemove += array{Index}
        
        CleanupTimers(TimersToRemove)
    
    CleanupTimers<private>(Indices:[]int):void =
        var NewTimers:[]timer_data = array{}
        for (Index -> Timer : Timers):
            var ShouldRemove:logic = false
            for (RemoveIndex : Indices, Index = RemoveIndex):
                set ShouldRemove = true
            if (not ShouldRemove?):
                set NewTimers += array{Timer}
        set Timers = NewTimers
