# 时间工具模块
# 功能：时间戳转换、倒计时格式化 (MM:SS)、帧率计算

using { /Verse.org/Simulation }

UtilTime<public> := module:
    
    # ========== 时间常量 ==========
    
    SECONDS_PER_MINUTE<public>:float = 60.0
    SECONDS_PER_HOUR<public>:float = 3600.0
    SECONDS_PER_DAY<public>:float = 86400.0
    MILLISECONDS_PER_SECOND<public>:float = 1000.0
    
    # ========== 数据结构 ==========
    
    # 时间表示结构
    time_duration<public> := struct<computes>:
        Hours<public>:int = 0
        Minutes<public>:int = 0
        Seconds<public>:int = 0
        Milliseconds<public>:int = 0
    
    # ========== 帧率计算 ==========
    
    # 根据帧时间计算 FPS
    CalculateFPS<public>(DeltaTime:float)<computes>:float =
        if (DeltaTime > 0.0001):
            1.0 / DeltaTime
        else:
            0.0
    
    # 根据 FPS 计算帧时间
    FPSToFrameTime<public>(FPS:float)<computes>:float =
        if (FPS > 0.0001):
            1.0 / FPS
        else:
            0.0
    
    # ========== 时间判定 ==========
    
    # 检查是否超时
    CheckTimeout<public>(ElapsedTime:float, TimeoutSeconds:float)<decides><transacts>:void =
        ElapsedTime >= TimeoutSeconds
    
    # 检查是否在时间窗口内
    CheckWithinTimeWindow<public>(CurrentTime:float, StartTime:float, Duration:float)<decides><transacts>:void =
        Elapsed := CurrentTime - StartTime
        Elapsed >= 0.0
        Elapsed <= Duration
    
    # ========== 工具函数 ==========
    
    # 创建时间持续结构
    MakeTimeDuration<public>(Hours:int, Minutes:int, Seconds:int, ?Milliseconds:int = 0)<transacts>:time_duration =
        time_duration{
            Hours := Max(Hours, 0)
            Minutes := Clamp(Minutes, 0, 59)
            Seconds := Clamp(Seconds, 0, 59)
            Milliseconds := Clamp(Milliseconds, 0, 999)
        }
    
    # 将时间持续转换为总秒数
    DurationToSeconds<public>(Duration:time_duration)<computes>:float =
        HoursSec := (Duration.Hours * 1.0) * SECONDS_PER_HOUR
        MinutesSec := (Duration.Minutes * 1.0) * SECONDS_PER_MINUTE
        SecondsSec := Duration.Seconds * 1.0
        MillisSec := (Duration.Milliseconds * 1.0) / MILLISECONDS_PER_SECOND
        HoursSec + MinutesSec + SecondsSec + MillisSec
    
    # 计算时间间隔百分比
    TimeProgress<public>(ElapsedTime:float, TotalTime:float)<computes>:float =
        if (TotalTime > 0.0):
            Clamp(ElapsedTime / TotalTime, 0.0, 1.0)
        else:
            0.0
