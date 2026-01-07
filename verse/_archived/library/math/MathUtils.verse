# MathUtils - 数学工具模块
# 版本: 1.3
# 来源: 模板预置
# 更新: 删除与标准库 /Verse.org/Verse 冲突的函数（Clamp, Min, Max, Lerp）
# 说明: 请直接使用标准库的 Clamp, Min, Max, Lerp 函数

using { /Verse.org/Simulation }

MathUtils<public> := module:
    # 注意: Clamp, Min, Max, Lerp 函数请使用 /Verse.org/Verse 标准库
    # 以下是标准库中没有的扩展函数
    
    # 绝对值函数
    Abs<public>(X:float):float =
        if (X >= 0.0):
            X
        else:
            -X
    
    # 钳制浮点数到范围内（标准库只有整数版本的 Clamp）
    ClampFloat<public>(Value:float, MinVal:float, MaxVal:float):float =
        if (Value < MinVal):
            MinVal
        else if (Value > MaxVal):
            MaxVal
        else:
            Value
    
    # 取最小浮点值（扩展函数）
    MinFloat<public>(A:float, B:float):float = if (A < B) then A else B
    
    # 取最大浮点值（扩展函数）
    MaxFloat<public>(A:float, B:float):float = if (A > B) then A else B
    
    # 反向插值（标准库没有此函数）
    InverseLerp<public>(A:float, B:float, Value:float):float =
        Diff := B - A
        if (Abs(Diff) < 0.0001):
            0.0
        else:
            (Value - A) / Diff
    
    # 重映射值从一个范围到另一个范围
    Remap<public>(Value:float, InMin:float, InMax:float, OutMin:float, OutMax:float):float =
        T := InverseLerp(InMin, InMax, Value)
        Lerp(OutMin, OutMax, T)
