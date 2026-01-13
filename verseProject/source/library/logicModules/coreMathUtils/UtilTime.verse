# 时间工具模块
# 功能：时间戳转换、倒计时格式化 (MM:SS)、帧率计算

using { /Verse.org/Simulation }

UtilTime<public> := module:
    
    # ========== 常量定义 ==========
    
    SECONDS_PER_MINUTE<public>:int = 60
    SECONDS_PER_HOUR<public>:int = 3600
    SECONDS_PER_DAY<public>:int = 86400
    MILLISECONDS_PER_SECOND<public>:float = 1000.0
    
    # ========== 数据结构 ==========
    
    # 时间组件
    time_components<public> := struct<computes>:
        Hours<public>:int = 0
        Minutes<public>:int = 0
        Seconds<public>:int = 0
        Milliseconds<public>:int = 0
    
    # 帧率统计
    fps_stats<public> := struct<computes>:
        CurrentFPS<public>:float = 60.0
        AverageFPS<public>:float = 60.0
        MinFPS<public>:float = 60.0
        MaxFPS<public>:float = 60.0
    
    # ========== 时间转换 ==========
    
    # 秒转分钟（向下取整）
    SecondsToMinutes<public>(Seconds:int)<computes>:int =
        Floor(Seconds / SECONDS_PER_MINUTE)
    
    # 秒转小时（向下取整）
    SecondsToHours<public>(Seconds:int)<computes>:int =
        Floor(Seconds / SECONDS_PER_HOUR)
    
    # 秒转天（向下取整）
    SecondsToDays<public>(Seconds:int)<computes>:int =
        Floor(Seconds / SECONDS_PER_DAY)
    
    # 秒转时间组件
    SecondsToComponents<public>(TotalSeconds:int)<transacts>:time_components =
        AbsSeconds := if (TotalSeconds < 0) then 0 else TotalSeconds
        Hours := Floor(AbsSeconds / SECONDS_PER_HOUR)
        RemainingAfterHours := AbsSeconds - (Hours * SECONDS_PER_HOUR)
        Minutes := Floor(RemainingAfterHours / SECONDS_PER_MINUTE)
        Seconds := RemainingAfterHours - (Minutes * SECONDS_PER_MINUTE)
        time_components{
            Hours := Hours
            Minutes := Minutes
            Seconds := Seconds
            Milliseconds := 0
        }
    
    # 时间组件转秒
    ComponentsToSeconds<public>(Components:time_components)<computes>:int =
        Components.Hours * SECONDS_PER_HOUR + 
        Components.Minutes * SECONDS_PER_MINUTE + 
        Components.Seconds
    
    # ========== 格式化输出 ==========
    
    # 格式化为 MM:SS
    FormatMMSS<public>(TotalSeconds:int)<computes>:string =
        AbsSeconds := if (TotalSeconds < 0) then 0 else TotalSeconds
        Minutes := Floor(AbsSeconds / SECONDS_PER_MINUTE)
        Seconds := AbsSeconds - (Minutes * SECONDS_PER_MINUTE)
        MinStr := if (Minutes < 10) then "0{Minutes}" else "{Minutes}"
        SecStr := if (Seconds < 10) then "0{Seconds}" else "{Seconds}"
        "{MinStr}:{SecStr}"
    
    # 格式化为 HH:MM:SS
    FormatHHMMSS<public>(TotalSeconds:int)<computes>:string =
        Components := SecondsToComponents(TotalSeconds)
        HourStr := if (Components.Hours < 10) then "0{Components.Hours}" else "{Components.Hours}"
        MinStr := if (Components.Minutes < 10) then "0{Components.Minutes}" else "{Components.Minutes}"
        SecStr := if (Components.Seconds < 10) then "0{Components.Seconds}" else "{Components.Seconds}"
        "{HourStr}:{MinStr}:{SecStr}"
    
    # 格式化倒计时（自动选择格式）
    # 小于1小时显示 MM:SS，否则显示 HH:MM:SS
    FormatCountdown<public>(TotalSeconds:int)<computes>:string =
        if (TotalSeconds < SECONDS_PER_HOUR):
            FormatMMSS(TotalSeconds)
        else:
            FormatHHMMSS(TotalSeconds)
    
    # 格式化为人类可读字符串（如 "2h 30m 15s"）
    FormatHumanReadable<public>(TotalSeconds:int)<computes>:string =
        if (TotalSeconds <= 0):
            "0s"
        else:
            Components := SecondsToComponents(TotalSeconds)
            var Result:string = ""
            if (Components.Hours > 0):
                set Result = "{Components.Hours}h "
            if (Components.Minutes > 0):
                set Result = "{Result}{Components.Minutes}m "
            if (Components.Seconds > 0 or Components.Hours = 0 and Components.Minutes = 0):
                set Result = "{Result}{Components.Seconds}s"
            Result
    
    # ========== 帧率计算 ==========
    
    # 根据帧时间计算FPS
    CalculateFPS<public>(DeltaTime:float)<computes>:float =
        if (DeltaTime > 0.0):
            1.0 / DeltaTime
        else:
            0.0
    
    # 根据帧时间（毫秒）计算FPS
    CalculateFPSFromMS<public>(DeltaTimeMS:float)<computes>:float =
        if (DeltaTimeMS > 0.0):
            MILLISECONDS_PER_SECOND / DeltaTimeMS
        else:
            0.0
    
    # 平滑FPS（使用指数移动平均）
    SmoothFPS<public>(CurrentFPS:float, NewFPS:float, SmoothFactor:float)<computes>:float =
        ClampedFactor := Clamp(SmoothFactor, 0.0, 1.0)
        CurrentFPS * (1.0 - ClampedFactor) + NewFPS * ClampedFactor
    
    # ========== 时间判定 ==========
    
    # 检查是否超时
    CheckTimeout<public>(ElapsedTime:float, TimeoutDuration:float)<decides><transacts>:void =
        ElapsedTime >= TimeoutDuration
    
    # 检查是否在时间窗口内
    CheckInTimeWindow<public>(CurrentTime:float, StartTime:float, Duration:float)<decides><transacts>:void =
        ElapsedTime := CurrentTime - StartTime
        if (ElapsedTime >= 0.0 and ElapsedTime < Duration):
            true
        else:
            false
    
    # 计算剩余时间
    GetRemainingTime<public>(ElapsedTime:float, TotalDuration:float)<computes>:float =
        Remaining := TotalDuration - ElapsedTime
        Max(Remaining, 0.0)
    
    # 计算时间进度（0.0 到 1.0）
    GetTimeProgress<public>(ElapsedTime:float, TotalDuration:float)<computes>:float =
        if (TotalDuration > 0.0):
            Clamp(ElapsedTime / TotalDuration, 0.0, 1.0)
        else:
            1.0
    
    # ========== 冷却时间相关 ==========
    
    # 检查冷却是否完成
    CheckCooldownReady<public>(LastUseTime:float, CurrentTime:float, CooldownDuration:float)<decides><transacts>:void =
        ElapsedTime := CurrentTime - LastUseTime
        ElapsedTime >= CooldownDuration
    
    # 计算冷却剩余时间
    GetCooldownRemaining<public>(LastUseTime:float, CurrentTime:float, CooldownDuration:float)<computes>:float =
        ElapsedTime := CurrentTime - LastUseTime
        GetRemainingTime(ElapsedTime, CooldownDuration)
