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
    
    # ========== 时间转换 ==========
    
    # 秒转分钟（向下取整）
    SecondsToMinutes<public>(Seconds:float)<computes>:int =
        Floor(Seconds / SECONDS_PER_MINUTE)
    
    # 秒转小时（向下取整）
    SecondsToHours<public>(Seconds:float)<computes>:int =
        Floor(Seconds / SECONDS_PER_HOUR)
    
    # 将秒数分解为时分秒
    SecondsToTime<public>(TotalSeconds:float)<transacts>:time_duration =
        IntSeconds := Floor(TotalSeconds)
        IntSecondsFloat := Floor(TotalSeconds)
        
        Hours := Floor(IntSecondsFloat / SECONDS_PER_HOUR)
        HoursInSec := Hours * SECONDS_PER_HOUR
        Remaining := IntSecondsFloat - HoursInSec
        
        Minutes := Floor(Remaining / SECONDS_PER_MINUTE)
        MinutesInSec := Minutes * SECONDS_PER_MINUTE
        Seconds := Floor(Remaining - MinutesInSec)
        
        FracPart := TotalSeconds - IntSecondsFloat
        Milliseconds := Floor(FracPart * MILLISECONDS_PER_SECOND)
        
        time_duration{
            Hours := Hours
            Minutes := Minutes
            Seconds := Seconds
            Milliseconds := Milliseconds
        }
    
    # ========== 时间格式化 ==========
    
    # 格式化倒计时为 MM:SS
    FormatCountdown<public>(Seconds:float)<computes>:[]char =
        TotalSec := Floor(Max(Seconds, 0.0))
        Minutes := Floor(TotalSec / SECONDS_PER_MINUTE)
        MinutesInSec := Minutes * SECONDS_PER_MINUTE
        Secs := Floor(TotalSec - MinutesInSec)
        
        MinStr := if (Minutes < 10.0) then "0{Minutes}" else "{Minutes}"
        SecStr := if (Secs < 10.0) then "0{Secs}" else "{Secs}"
        "{MinStr}:{SecStr}"
    
    # 格式化时间为 HH:MM:SS
    FormatTime<public>(Seconds:float)<computes>:[]char =
        TotalSec := Floor(Max(Seconds, 0.0))
        
        Hours := Floor(TotalSec / SECONDS_PER_HOUR)
        HoursInSec := Hours * SECONDS_PER_HOUR
        Remaining := TotalSec - HoursInSec
        
        Minutes := Floor(Remaining / SECONDS_PER_MINUTE)
        MinutesInSec := Minutes * SECONDS_PER_MINUTE
        Secs := Floor(Remaining - MinutesInSec)
        
        HourStr := if (Hours < 10.0) then "0{Hours}" else "{Hours}"
        MinStr := if (Minutes < 10.0) then "0{Minutes}" else "{Minutes}"
        SecStr := if (Secs < 10.0) then "0{Secs}" else "{Secs}"
        "{HourStr}:{MinStr}:{SecStr}"
    
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
        HoursSec := Duration.Hours * SECONDS_PER_HOUR
        MinutesSec := Duration.Minutes * SECONDS_PER_MINUTE
        SecondsSec := Duration.Seconds * 1.0
        MillisSec := Duration.Milliseconds / MILLISECONDS_PER_SECOND
        HoursSec + MinutesSec + SecondsSec + MillisSec
    
    # 计算时间间隔百分比
    TimeProgress<public>(ElapsedTime:float, TotalTime:float)<computes>:float =
        if (TotalTime > 0.0):
            Clamp(ElapsedTime / TotalTime, 0.0, 1.0)
        else:
            0.0
