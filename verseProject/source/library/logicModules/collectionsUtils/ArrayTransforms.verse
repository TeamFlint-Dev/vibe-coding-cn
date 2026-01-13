# 数组转换模块
# 功能：常用数组过滤、映射和聚合操作的专用函数集
# 架构：Logic 层 - 纯函数，使用专用函数模式
# 
# 设计说明：
# Verse 不支持高阶函数（函数作为参数），因此采用"专用函数 + 内联表达式"模式
# 参考：RESEARCH-007 (Verse高阶函数调研), ADR-012 (专用函数模式决策)
# 
# 使用指导：
# 1. 对于常见操作，使用本模块的专用函数（性能最优）
# 2. 对于自定义条件，直接使用内联 for 表达式
# 3. 避免复杂嵌套，优先保持代码可读性

ArrayTransforms<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # Filter 系列 - 整数数组过滤
    # ═══════════════════════════════════════════════════════════
    
    # 过滤正数（> 0）
    # @param Arr: 整数数组
    # @returns: 所有正数组成的新数组
    # 
    # 使用场景：
    # - 筛选有效的得分
    # - 过滤增益值
    FilterPositiveInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr, Element > 0):
            Element
    
    # 过滤负数（< 0）
    # @param Arr: 整数数组
    # @returns: 所有负数组成的新数组
    FilterNegativeInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr, Element < 0):
            Element
    
    # 过滤非零数（!= 0）
    # @param Arr: 整数数组
    # @returns: 所有非零数组成的新数组
    FilterNonZeroInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr, Element > 0 or Element < 0):
            Element
    
    # 过滤偶数
    # @param Arr: 整数数组
    # @returns: 所有偶数组成的新数组
    FilterEvenInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr, Mod[Element, 2] = 0):
            Element
    
    # 过滤奇数
    # @param Arr: 整数数组
    # @returns: 所有奇数组成的新数组
    FilterOddInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr, Mod[Element, 2] > 0 or Mod[Element, 2] < 0):
            Element
    
    # 过滤大于阈值的元素
    # @param Arr: 整数数组
    # @param Threshold: 阈值
    # @returns: 所有大于阈值的元素
    FilterGreaterThanInt<public>(Arr:[]int, Threshold:int)<computes>:[]int =
        for (Element : Arr, Element > Threshold):
            Element
    
    # 过滤小于阈值的元素
    # @param Arr: 整数数组
    # @param Threshold: 阈值
    # @returns: 所有小于阈值的元素
    FilterLessThanInt<public>(Arr:[]int, Threshold:int)<computes>:[]int =
        for (Element : Arr, Element < Threshold):
            Element
    
    # 过滤大于等于阈值的元素
    # @param Arr: 整数数组
    # @param Threshold: 阈值
    # @returns: 所有大于等于阈值的元素
    FilterGreaterOrEqualInt<public>(Arr:[]int, Threshold:int)<computes>:[]int =
        for (Element : Arr, Element >= Threshold):
            Element
    
    # 过滤小于等于阈值的元素
    # @param Arr: 整数数组
    # @param Threshold: 阈值
    # @returns: 所有小于等于阈值的元素
    FilterLessOrEqualInt<public>(Arr:[]int, Threshold:int)<computes>:[]int =
        for (Element : Arr, Element <= Threshold):
            Element
    
    # 过滤范围内的元素（闭区间）
    # @param Arr: 整数数组
    # @param MinValue: 最小值（包含）
    # @param MaxValue: 最大值（包含）
    # @returns: 所有在 [MinValue, MaxValue] 范围内的元素
    FilterInRangeInt<public>(Arr:[]int, MinValue:int, MaxValue:int)<computes>:[]int =
        for (Element : Arr, Element >= MinValue and Element <= MaxValue):
            Element
    
    # 过滤范围外的元素
    # @param Arr: 整数数组
    # @param MinValue: 最小值
    # @param MaxValue: 最大值
    # @returns: 所有不在 [MinValue, MaxValue] 范围内的元素
    FilterOutOfRangeInt<public>(Arr:[]int, MinValue:int, MaxValue:int)<computes>:[]int =
        for (Element : Arr, Element < MinValue or Element > MaxValue):
            Element
    
    # ═══════════════════════════════════════════════════════════
    # Filter 系列 - 浮点数数组过滤
    # ═══════════════════════════════════════════════════════════
    
    # 过滤正数（> 0.0）
    # @param Arr: 浮点数数组
    # @returns: 所有正数组成的新数组
    FilterPositiveFloat<public>(Arr:[]float)<computes>:[]float =
        for (Element : Arr, Element > 0.0):
            Element
    
    # 过滤负数（< 0.0）
    # @param Arr: 浮点数数组
    # @returns: 所有负数组成的新数组
    FilterNegativeFloat<public>(Arr:[]float)<computes>:[]float =
        for (Element : Arr, Element < 0.0):
            Element
    
    # 过滤大于阈值的元素
    # @param Arr: 浮点数数组
    # @param Threshold: 阈值
    # @returns: 所有大于阈值的元素
    FilterGreaterThanFloat<public>(Arr:[]float, Threshold:float)<computes>:[]float =
        for (Element : Arr, Element > Threshold):
            Element
    
    # 过滤小于阈值的元素
    # @param Arr: 浮点数数组
    # @param Threshold: 阈值
    # @returns: 所有小于阈值的元素
    FilterLessThanFloat<public>(Arr:[]float, Threshold:float)<computes>:[]float =
        for (Element : Arr, Element < Threshold):
            Element
    
    # 过滤范围内的元素
    # @param Arr: 浮点数数组
    # @param MinValue: 最小值（包含）
    # @param MaxValue: 最大值（包含）
    # @returns: 所有在范围内的元素
    FilterInRangeFloat<public>(Arr:[]float, MinValue:float, MaxValue:float)<computes>:[]float =
        for (Element : Arr, Element >= MinValue and Element <= MaxValue):
            Element
    
    # ═══════════════════════════════════════════════════════════
    # Map 系列 - 整数数组映射
    # ═══════════════════════════════════════════════════════════
    
    # 映射：平方
    # @param Arr: 整数数组
    # @returns: 每个元素的平方
    MapSquareInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr):
            Element * Element
    
    # 映射：双倍
    # @param Arr: 整数数组
    # @returns: 每个元素的2倍
    MapDoubleInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr):
            Element * 2
    
    # 映射：取反
    # @param Arr: 整数数组
    # @returns: 每个元素的相反数
    MapNegateInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr):
            -Element
    
    # 映射：绝对值
    # @param Arr: 整数数组
    # @returns: 每个元素的绝对值
    MapAbsInt<public>(Arr:[]int)<computes>:[]int =
        for (Element : Arr):
            if (Element < 0) then -Element else Element
    
    # 映射：加法（每个元素加上常数）
    # @param Arr: 整数数组
    # @param Offset: 偏移量
    # @returns: 每个元素加上偏移量
    MapAddInt<public>(Arr:[]int, Offset:int)<computes>:[]int =
        for (Element : Arr):
            Element + Offset
    
    # 映射：乘法（每个元素乘以系数）
    # @param Arr: 整数数组
    # @param Multiplier: 乘数
    # @returns: 每个元素乘以乘数
    MapMultiplyInt<public>(Arr:[]int, Multiplier:int)<computes>:[]int =
        for (Element : Arr):
            Element * Multiplier
    
    # ═══════════════════════════════════════════════════════════
    # Map 系列 - 浮点数数组映射
    # ═══════════════════════════════════════════════════════════
    
    # 映射：平方
    # @param Arr: 浮点数数组
    # @returns: 每个元素的平方
    MapSquareFloat<public>(Arr:[]float)<computes>:[]float =
        for (Element : Arr):
            Element * Element
    
    # 映射：取反
    # @param Arr: 浮点数数组
    # @returns: 每个元素的相反数
    MapNegateFloat<public>(Arr:[]float)<computes>:[]float =
        for (Element : Arr):
            -Element
    
    # 映射：绝对值
    # @param Arr: 浮点数数组
    # @returns: 每个元素的绝对值
    MapAbsFloat<public>(Arr:[]float)<computes>:[]float =
        for (Element : Arr):
            if (Element < 0.0) then -Element else Element
    
    # 映射：乘以系数
    # @param Arr: 浮点数数组
    # @param Multiplier: 乘数
    # @returns: 每个元素乘以乘数
    MapMultiplyFloat<public>(Arr:[]float, Multiplier:float)<computes>:[]float =
        for (Element : Arr):
            Element * Multiplier
    
    # ═══════════════════════════════════════════════════════════
    # Reduce 系列 - 数组聚合（使用 transacts 因为需要 var）
    # ═══════════════════════════════════════════════════════════
    
    # 求和
    # @param Arr: 整数数组
    # @returns: 所有元素的和
    SumInt<public>(Arr:[]int)<transacts>:int =
        var Total:int = 0
        for (Element : Arr):
            set Total += Element
        Total
    
    # 求积
    # @param Arr: 整数数组
    # @returns: 所有元素的积
    ProductInt<public>(Arr:[]int)<transacts>:int =
        var Total:int = 1
        for (Element : Arr):
            set Total *= Element
        Total
    
    # 计数（非零元素）
    # @param Arr: 整数数组
    # @returns: 非零元素的数量
    CountNonZeroInt<public>(Arr:[]int)<transacts>:int =
        var Count:int = 0
        for (Element : Arr):
            if (Element > 0 or Element < 0):
                set Count += 1
        Count
    
    # 计数（满足条件的元素）
    # @param Arr: 整数数组
    # @param Threshold: 阈值
    # @returns: 大于阈值的元素数量
    CountGreaterThanInt<public>(Arr:[]int, Threshold:int)<transacts>:int =
        var Count:int = 0
        for (Element : Arr):
            if (Element > Threshold):
                set Count += 1
        Count
    
    # 浮点数求和
    # @param Arr: 浮点数数组
    # @returns: 所有元素的和
    SumFloat<public>(Arr:[]float)<transacts>:float =
        var Total:float = 0.0
        for (Element : Arr):
            set Total += Element
        Total
    
    # 浮点数求积
    # @param Arr: 浮点数数组
    # @returns: 所有元素的积
    ProductFloat<public>(Arr:[]float)<transacts>:float =
        var Total:float = 1.0
        for (Element : Arr):
            set Total *= Element
        Total
    
    # 浮点数平均值
    # @param Arr: 浮点数数组
    # @returns: 平均值，如果数组为空则返回 0.0
    AverageFloat<public>(Arr:[]float)<transacts>:float =
        if (Arr.Length = 0):
            0.0
        else:
            Total := SumFloat(Arr)
            Count := Arr.Length * 1.0  # 转换为 float
            Total / Count
