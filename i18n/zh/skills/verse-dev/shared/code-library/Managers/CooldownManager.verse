# CooldownManager - 冷却时间管理器
# 版本: 1.1
# 添加时间: 2025-12-27
# 修改时间: 2025-12-28
# 层级: L2.5 Managers (有状态管理器)
# 来源: REQ-005 (循环迭代模式)
# 变更: CHANGE-005 - 从 Helpers/ 迁移至 Managers/ (ARC-008 合规)

using { /Verse.org/Simulation }

# 冷却状态
cooldown_state<public> := enum:
    Ready       # 就绪，可使用
    OnCooldown  # 冷却中
    Disabled    # 禁用

# 冷却数据
cooldown_data<internal> := class:
    var ID:string
    var Duration:float
    var RemainingTime:float
    var State:cooldown_state

# 冷却管理器
cooldown_manager<public> := class:
    var Cooldowns<private>:[string]cooldown_data = map{}
    var IsRunning<private>:logic = false
    var GlobalCooldownReduction<private>:float = 0.0  # 全局冷却缩减 (0.0 ~ 1.0)
    
    # ==========================================
    # 管理器生命周期
    # ==========================================
    
    # 启动管理器（需要在协程中调用）
    StartManager<public>()<suspends>:void =
        set IsRunning = true
        loop:
            if not IsRunning:
                break
            UpdateCooldowns(GetDeltaTime())
            Sleep(0.0)
    
    # 停止管理器
    StopManager<public>():void =
        set IsRunning = false
    
    # ==========================================
    # 冷却控制
    # ==========================================
    
    # 启动冷却
    StartCooldown<public>(ID:string, Duration:float):void =
        ActualDuration := Duration * (1.0 - GlobalCooldownReduction)
        
        if (Existing := Cooldowns[ID]):
            set Existing.Duration = ActualDuration
            set Existing.RemainingTime = ActualDuration
            set Existing.State = cooldown_state.OnCooldown
        else:
            NewCD := cooldown_data{
                ID := ID,
                Duration := ActualDuration,
                RemainingTime := ActualDuration,
                State := cooldown_state.OnCooldown
            }
            if (set Cooldowns[ID] = NewCD) {}
    
    # 检查是否在冷却中
    IsOnCooldown<public>(ID:string):logic =
        if (CD := Cooldowns[ID]):
            return CD.State = cooldown_state.OnCooldown
        return false
    
    # 检查是否就绪
    IsReady<public>(ID:string):logic =
        if (CD := Cooldowns[ID]):
            return CD.State = cooldown_state.Ready
        return true  # 未注册的默认就绪
    
    # 获取剩余冷却时间
    GetRemainingCooldown<public>(ID:string):float =
        if (CD := Cooldowns[ID]):
            return CD.RemainingTime
        return 0.0
    
    # 获取冷却进度 (0.0 = 刚开始, 1.0 = 完成)
    GetCooldownProgress<public>(ID:string):float =
        if (CD := Cooldowns[ID]):
            if CD.Duration > 0.0:
                return 1.0 - (CD.RemainingTime / CD.Duration)
        return 1.0
    
    # 重置冷却（立即就绪）
    ResetCooldown<public>(ID:string):void =
        if (CD := Cooldowns[ID]):
            set CD.RemainingTime = 0.0
            set CD.State = cooldown_state.Ready
    
    # 重置所有冷却
    ResetAllCooldowns<public>():void =
        for (ID -> CD in Cooldowns):
            set CD.RemainingTime = 0.0
            set CD.State = cooldown_state.Ready
    
    # 减少冷却时间
    ReduceCooldown<public>(ID:string, Amount:float):void =
        if (CD := Cooldowns[ID]):
            set CD.RemainingTime = Max(0.0, CD.RemainingTime - Amount)
            if CD.RemainingTime <= 0.0:
                set CD.State = cooldown_state.Ready
    
    # 增加冷却时间
    ExtendCooldown<public>(ID:string, Amount:float):void =
        if (CD := Cooldowns[ID]):
            set CD.RemainingTime += Amount
            set CD.Duration = Max(CD.Duration, CD.RemainingTime)
    
    # ==========================================
    # 全局冷却缩减
    # ==========================================
    
    # 设置全局冷却缩减 (0.0 ~ 1.0)
    # 例: 0.2 = 所有冷却减少20%
    SetGlobalCooldownReduction<public>(Reduction:float):void =
        set GlobalCooldownReduction = Clamp(Reduction, 0.0, 0.9)  # 最多90%
    
    GetGlobalCooldownReduction<public>():float =
        return GlobalCooldownReduction
    
    # ==========================================
    # 禁用/启用
    # ==========================================
    
    # 禁用某个冷却（无法使用）
    DisableCooldown<public>(ID:string):void =
        if (CD := Cooldowns[ID]):
            set CD.State = cooldown_state.Disabled
        else:
            NewCD := cooldown_data{
                ID := ID,
                Duration := 0.0,
                RemainingTime := 0.0,
                State := cooldown_state.Disabled
            }
            if (set Cooldowns[ID] = NewCD) {}
    
    # 启用某个冷却
    EnableCooldown<public>(ID:string):void =
        if (CD := Cooldowns[ID]):
            if CD.State = cooldown_state.Disabled:
                set CD.State = cooldown_state.Ready
    
    # 检查是否被禁用
    IsDisabled<public>(ID:string):logic =
        if (CD := Cooldowns[ID]):
            return CD.State = cooldown_state.Disabled
        return false
    
    # ==========================================
    # 查询
    # ==========================================
    
    # 获取所有冷却中的ID
    GetAllOnCooldown<public>():[]string =
        Result:[]string = array{}
        for (ID -> CD in Cooldowns):
            if CD.State = cooldown_state.OnCooldown:
                set Result += array{ID}
        return Result
    
    # 获取所有就绪的ID
    GetAllReady<public>():[]string =
        Result:[]string = array{}
        for (ID -> CD in Cooldowns):
            if CD.State = cooldown_state.Ready:
                set Result += array{ID}
        return Result
    
    # ==========================================
    # 内部更新
    # ==========================================
    
    UpdateCooldowns<private>(DeltaTime:float):void =
        for (ID -> CD in Cooldowns):
            if CD.State = cooldown_state.OnCooldown:
                set CD.RemainingTime -= DeltaTime
                if CD.RemainingTime <= 0.0:
                    set CD.RemainingTime = 0.0
                    set CD.State = cooldown_state.Ready
    
    # 工具函数
    Max<private>(A:float, B:float):float = if A > B then A else B
    Clamp<private>(Value:float, MinVal:float, MaxVal:float):float =
        if Value < MinVal: return MinVal
        else if Value > MaxVal: return MaxVal
        return Value
