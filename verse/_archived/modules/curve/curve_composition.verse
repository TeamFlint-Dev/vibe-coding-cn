# CurveComposition - 曲线组合机制
# 版本: 1.0
# 说明: 实现串联、并联、叠加等曲线组合方式

using { /Verse.org/Simulation }
using { /Verse.org/Verse }

# 曲线段定义（用于串联组合）
curve_segment<public> := struct:
    Curve<public>:curve_1d     # 该段的曲线
    Duration<public>:float     # 该段的持续时间（秒）

# 串联曲线（Sequential Curve）
sequential_curve<public> := class<final>(curve_1d):
    Segments<public>:[]curve_segment = array{}
    
    # 获取总时长
    GetTotalDuration<public>()<computes>:float =
        var Total:float = 0.0
        for (Segment : Segments):
            set Total = Total + Segment.Duration
        Total
    
    GetDuration<override>()<computes>:float = GetTotalDuration()
    
    # 计算曲线值
    Evaluate<override>(T:float)<computes>:float =
        TotalDuration := GetTotalDuration()
        if (TotalDuration <= 0.0):
            return 0.0
        
        # 转换归一化时间到绝对时间
        AbsoluteTime := T * TotalDuration
        var AccumulatedTime:float = 0.0
        
        for (Segment : Segments):
            SegmentEndTime := AccumulatedTime + Segment.Duration
            
            if (AbsoluteTime < SegmentEndTime):
                # 找到对应段，计算局部时间
                if (Segment.Duration > 0.0):
                    LocalT := (AbsoluteTime - AccumulatedTime) / Segment.Duration
                    return Segment.Curve.Evaluate(LocalT)
                else:
                    return Segment.Curve.Evaluate(0.0)
            
            set AccumulatedTime = SegmentEndTime
        
        # 超出范围，返回最后一段的终点值
        if (Segments.Length > 0):
            LastSegment := Segments[Segments.Length - 1]
            return LastSegment.Curve.Evaluate(1.0)
        
        0.0

# 带权重的曲线（用于加权混合）
weighted_curve<public> := struct:
    Curve<public>:curve_1d
    Weight<public>:float = 1.0

# 加权混合曲线（Blended Curve）
blended_curve<public> := class<final>(curve_1d):
    Curves<public>:[]weighted_curve = array{}
    
    Evaluate<override>(T:float)<computes>:float =
        if (Curves.Length = 0):
            return 0.0
        
        # 归一化权重
        var TotalWeight:float = 0.0
        for (Item : Curves):
            set TotalWeight = TotalWeight + Item.Weight
        
        if (TotalWeight <= 0.0):
            return 0.0
        
        # 计算加权和
        var Result:float = 0.0
        for (Item : Curves):
            NormalizedWeight := Item.Weight / TotalWeight
            CurveValue := Item.Curve.Evaluate(T)
            set Result = Result + CurveValue * NormalizedWeight
        
        Result

# 叠加曲线（Additive Curve）
additive_curve<public> := class<final>(curve_1d):
    Curves<public>:[]curve_1d = array{}
    
    Evaluate<override>(T:float)<computes>:float =
        var Result:float = 0.0
        for (C : Curves):
            set Result = Result + C.Evaluate(T)
        Result
