# 数值范围映射模块
# 功能：在不同数值范围之间进行映射和转换
# 架构：Logic 层 - 纯函数，无状态
# 应用场景：血条显示、音量控制、属性转换、UI 缩放等

MathRanges<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 范围映射函数
    # ═══════════════════════════════════════════════════════════
    
    # 将数值从一个范围映射到另一个范围（无限制）
    # @param Value: 输入值
    # @param FromMin: 源范围的最小值
    # @param FromMax: 源范围的最大值
    # @param ToMin: 目标范围的最小值
    # @param ToMax: 目标范围的最大值
    # @returns: 映射后的值
    # 
    # 公式：(Value - FromMin) / (FromMax - FromMin) * (ToMax - ToMin) + ToMin
    # 
    # 使用场景：
    # - 将 [0, 100] 的生命值映射到 [0, 1] 的进度条
    # - 将 [0, 1] 的音量映射到 [0, 100] 的分贝值
    # - 将 [-1, 1] 的输入映射到 [0, 360] 的角度
    # 
    # 注意：
    # - 如果 FromMin == FromMax，返回 ToMin（避免除零）
    # - 输出值可能超出目标范围（使用 MapRangeClamped 自动限制）
    MapRange<public>(Value:float, FromMin:float, FromMax:float, ToMin:float, ToMax:float)<computes>:float =
        # 检查源范围是否有效
        FromRange := FromMax - FromMin
        if (FromRange = 0.0):
            # 源范围无效，返回目标范围的起点
            ToMin
        else:
            # 计算在源范围中的归一化位置 [0, 1]
            NormalizedPosition := (Value - FromMin) / FromRange
            # 映射到目标范围
            ToRange := ToMax - ToMin
            ToMin + (NormalizedPosition * ToRange)
    
    # 将数值从一个范围映射到另一个范围（自动限制在目标范围内）
    # @param Value: 输入值
    # @param FromMin: 源范围的最小值
    # @param FromMax: 源范围的最大值
    # @param ToMin: 目标范围的最小值
    # @param ToMax: 目标范围的最大值
    # @returns: 映射并限制后的值，保证在 [ToMin, ToMax] 范围内
    # 
    # 使用场景：
    # - 需要保证输出在目标范围内的所有场景
    # - UI 进度条显示（保证在 [0, 1]）
    # - 音量控制（保证在有效范围）
    # - 属性转换（保证在允许的范围）
    MapRangeClamped<public>(Value:float, FromMin:float, FromMax:float, ToMin:float, ToMax:float)<computes>:float =
        # 先映射
        MappedValue := MapRange(Value, FromMin, FromMax, ToMin, ToMax)
        # 再限制
        ActualMin := if (ToMin < ToMax) then ToMin else ToMax
        ActualMax := if (ToMin < ToMax) then ToMax else ToMin
        Clamp(MappedValue, ActualMin, ActualMax)
    
    # 反向插值 - 计算值在范围中的归一化位置
    # @param Value: 输入值
    # @param MinVal: 范围的最小值
    # @param MaxVal: 范围的最大值
    # @returns: 归一化位置 [0, 1]，如果 Value == MinVal 返回 0.0，Value == MaxVal 返回 1.0
    # 
    # 这是 Lerp 的反向操作：
    # - Lerp(MinVal, MaxVal, t) 给定 t 计算值
    # - InverseLerp(MinVal, MaxVal, Value) 给定值计算 t
    # 
    # 使用场景：
    # - 计算进度百分比
    # - 判断值在范围中的相对位置
    # - 作为 MapRange 的组成部分
    # 
    # 注意：
    # - 如果 MinVal == MaxVal，返回 0.0（避免除零）
    # - 输出值可能超出 [0, 1]（如果 Value 在范围外）
    InverseLerp<public>(Value:float, MinVal:float, MaxVal:float)<computes>:float =
        Range := MaxVal - MinVal
        if (Range = 0.0):
            0.0
        else:
            (Value - MinVal) / Range
    
    # 反向插值（限制版）- 计算值在范围中的归一化位置，自动限制在 [0, 1]
    # @param Value: 输入值
    # @param MinVal: 范围的最小值
    # @param MaxVal: 范围的最大值
    # @returns: 归一化位置，保证在 [0, 1] 范围内
    InverseLerpClamped<public>(Value:float, MinVal:float, MaxVal:float)<computes>:float =
        t := InverseLerp(Value, MinVal, MaxVal)
        Clamp(t, 0.0, 1.0)
    
    # ═══════════════════════════════════════════════════════════
    # 范围检查函数
    # ═══════════════════════════════════════════════════════════
    
    # 检查值是否在指定范围内（包含边界）
    # @param Value: 要检查的值
    # @param MinVal: 范围的最小值
    # @param MaxVal: 范围的最大值
    # @returns: 如果 Value 在 [MinVal, MaxVal] 内返回 true
    IsInRange<public>(Value:float, MinVal:float, MaxVal:float)<computes>:logic =
        ActualMin := if (MinVal < MaxVal) then MinVal else MaxVal
        ActualMax := if (MinVal < MaxVal) then MaxVal else MinVal
        if (Value >= ActualMin and Value <= ActualMax) then true else false
    
    # 检查值是否在指定范围内（不包含边界）
    # @param Value: 要检查的值
    # @param MinVal: 范围的最小值
    # @param MaxVal: 范围的最大值
    # @returns: 如果 Value 在 (MinVal, MaxVal) 内返回 true
    IsInRangeExclusive<public>(Value:float, MinVal:float, MaxVal:float)<computes>:logic =
        ActualMin := if (MinVal < MaxVal) then MinVal else MaxVal
        ActualMax := if (MinVal < MaxVal) then MaxVal else MinVal
        if (Value > ActualMin and Value < ActualMax) then true else false
    
    # ═══════════════════════════════════════════════════════════
    # 范围工具函数
    # ═══════════════════════════════════════════════════════════
    
    # 计算范围的大小
    # @param MinVal: 范围的最小值
    # @param MaxVal: 范围的最大值
    # @returns: 范围大小（MaxVal - MinVal）
    RangeSize<public>(MinVal:float, MaxVal:float)<computes>:float =
        if (MaxVal > MinVal):
            MaxVal - MinVal
        else:
            MinVal - MaxVal
    
    # 计算范围的中点
    # @param MinVal: 范围的最小值
    # @param MaxVal: 范围的最大值
    # @returns: 范围的中点 (MinVal + MaxVal) / 2
    RangeCenter<public>(MinVal:float, MaxVal:float)<computes>:float =
        (MinVal + MaxVal) * 0.5
    
    # ═══════════════════════════════════════════════════════════
    # 常见映射预设
    # ═══════════════════════════════════════════════════════════
    
    # 百分比转归一化 [0, 100] → [0, 1]
    PercentToNormalized<public>(Percent:float)<computes>:float =
        MapRangeClamped(Percent, 0.0, 100.0, 0.0, 1.0)
    
    # 归一化转百分比 [0, 1] → [0, 100]
    NormalizedToPercent<public>(Normalized:float)<computes>:float =
        MapRangeClamped(Normalized, 0.0, 1.0, 0.0, 100.0)
    
    # 角度归一化到 [0, 360)
    # @param Angle: 任意角度值
    # @returns: 归一化到 [0, 360) 的角度
    # 
    # 实现说明：使用数学模运算公式而非迭代，提高性能和精度
    # 公式：Result = Angle - Floor(Angle / 360.0) * 360.0
    # 注意：Verse 的 Floor 有 <decides> 效果，必须在 if 表达式中调用
    NormalizeAngle360<public>(Angle:float)<transacts>:float =
        if (Angle >= 0.0 and Angle < 360.0):
            # 已在范围内，直接返回
            Angle
        else:
            # 使用模运算公式：Angle - Floor(Angle/360) * 360
            # 这等价于数学中的 Angle mod 360
            if (FloorValue := Floor[Angle / 360.0]):
                # Floor 成功，计算余数
                Remainder := Angle - (FloorValue * 1.0) * 360.0
                # 处理浮点误差：确保结果严格在 [0, 360) 范围内
                if (Remainder < 0.0):
                    Remainder + 360.0
                else if (Remainder >= 360.0):
                    Remainder - 360.0
                else:
                    Remainder
            else:
                # Floor 失败（理论上不应该发生），回退到简单处理
                # 对于 NaN 或无穷大，返回 0.0 作为安全值
                0.0
    
    # 角度归一化到 [-180, 180)
    # @param Angle: 任意角度值
    # @returns: 归一化到 [-180, 180) 的角度
    NormalizeAngle180<public>(Angle:float)<transacts>:float =
        # 先归一化到 [0, 360)
        Normalized360 := NormalizeAngle360(Angle)
        # 转换到 [-180, 180)
        if (Normalized360 >= 180.0):
            Normalized360 - 360.0
        else:
            Normalized360
