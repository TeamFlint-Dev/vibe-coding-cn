# MathUtils - 数学工具模块
# 版本: 1.0
# 来源: 模板预置

using { /Verse.org/Simulation }

MathUtils<public> := module:
    # 钳制整数到范围内
    Clamp<public>(Value:int, MinVal:int, MaxVal:int):int =
        if Value < MinVal:
            return MinVal
        else if Value > MaxVal:
            return MaxVal
        return Value
    
    # 钳制浮点数到范围内
    ClampFloat<public>(Value:float, MinVal:float, MaxVal:float):float =
        if Value < MinVal:
            return MinVal
        else if Value > MaxVal:
            return MaxVal
        return Value
    
    # 取最小值
    Min<public>(A:int, B:int):int = if A < B then A else B
    
    # 取最大值
    Max<public>(A:int, B:int):int = if A > B then A else B
    
    # 取最小浮点值
    MinFloat<public>(A:float, B:float):float = if A < B then A else B
    
    # 取最大浮点值
    MaxFloat<public>(A:float, B:float):float = if A > B then A else B
    
    # 线性插值
    Lerp<public>(A:float, B:float, T:float):float =
        return A + (B - A) * T
    
    # 反向插值
    InverseLerp<public>(A:float, B:float, Value:float):float =
        if (B - A) = 0.0:
            return 0.0
        return (Value - A) / (B - A)
    
    # 重映射值从一个范围到另一个范围
    Remap<public>(Value:float, InMin:float, InMax:float, OutMin:float, OutMax:float):float =
        T := InverseLerp(InMin, InMax, Value)
        return Lerp(OutMin, OutMax, T)
