# 数组查询模块
# 功能：数组内容查询和搜索操作  
# 架构：Logic 层 - 简化版本，专注于整数和浮点数数组
# 验证：CONJ-004-007 (option[T] 系列猜想)

using { /Verse.org/Simulation }

ArrayQueries<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 索引查找 - 使用 option[T] 进行安全查询
    # ═══════════════════════════════════════════════════════════
    
    # 查找整数元素的第一个索引位置
    # @param Arr: 要搜索的数组
    # @param Target: 要查找的元素
    # @returns: option[int] - 找到返回索引，未找到返回 false
    # 
    # 验证 CONJ-006: false 是 option 类型的空值字面量
    # 验证 CONJ-004: option 查询操作符的使用
    # 
    # 使用场景：
    # - 查找玩家在排行榜中的位置
    # - 定位特定元素
    IndexOfInt<public>(Arr:[]int, Target:int)<transacts>:?int =
        var Result:?int = false
        for (Index -> Element : Arr):
            if (Element = Target):
                if (not Result?):
                    set Result = option{Index}
        Result
    
    # 查找整数元素的最后一个索引位置
    # @param Arr: 要搜索的数组
    # @param Target: 要查找的元素
    # @returns: option[int] - 找到返回索引，未找到返回 false
    # 
    # 使用场景：
    # - 查找最后一次出现的位置
    # - 反向搜索
    LastIndexOfInt<public>(Arr:[]int, Target:int)<transacts>:?int =
        var LastIndex:?int = false
        for (Index -> Element : Arr):
            if (Element = Target):
                set LastIndex = option{Index}
        LastIndex
    
    # ═══════════════════════════════════════════════════════════
    # 过滤函数 - 返回满足条件的所有元素
    # ═══════════════════════════════════════════════════════════
    
    # 查找所有匹配的整数元素
    # @param Arr: 要搜索的数组
    # @param Target: 要查找的元素
    # @returns: 包含所有匹配元素的新数组
    FindAllInt<public>(Arr:[]int, Target:int)<computes>:[]int =
        for (Element : Arr, Element = Target):
            Element
    
    # 查找所有大于阈值的整数
    # @param Arr: 整数数组
    # @param Threshold: 阈值
    # @returns: 所有大于阈值的元素
    FindGreaterThanInt<public>(Arr:[]int, Threshold:int)<computes>:[]int =
        for (Element : Arr, Element > Threshold):
            Element
    
    # 查找所有大于阈值的浮点数
    # @param Arr: 浮点数组
    # @param Threshold: 阈值
    # @returns: 所有大于阈值的元素
    FindGreaterThanFloat<public>(Arr:[]float, Threshold:float)<computes>:[]float =
        for (Element : Arr, Element > Threshold):
            Element
    
    # 查找所有小于阈值的整数
    # @param Arr: 整数数组
    # @param Threshold: 阈值
    # @returns: 所有小于阈值的元素
    FindLessThanInt<public>(Arr:[]int, Threshold:int)<computes>:[]int =
        for (Element : Arr, Element < Threshold):
            Element
    
    # ═══════════════════════════════════════════════════════════
    # 计数函数 - 使用 transacts 因为需要可变变量
    # ═══════════════════════════════════════════════════════════
    
    # 统计指定整数元素出现的次数
    # @param Arr: 要搜索的数组
    # @param Target: 要统计的元素
    # @returns: 出现次数
    CountOccurrencesInt<public>(Arr:[]int, Target:int)<transacts>:int =
        var Count:int = 0
        for (Element : Arr):
            if (Element = Target):
                set Count += 1
        Count
    
    # 统计大于阈值的整数数量
    # @param Arr: 整数数组
    # @param Threshold: 阈值
    # @returns: 大于阈值的元素数量
    CountGreaterThanInt<public>(Arr:[]int, Threshold:int)<transacts>:int =
        var Count:int = 0
        for (Element : Arr):
            if (Element > Threshold):
                set Count += 1
        Count
    
    # 统计非零元素数量
    # @param Arr: 整数数组
    # @returns: 非零元素数量
    CountNonZeroInt<public>(Arr:[]int)<transacts>:int =
        var Count:int = 0
        for (Element : Arr):
            if (Element > 0):
                set Count += 1
            else if (Element < 0):
                set Count += 1
        Count
    
    # ═══════════════════════════════════════════════════════════
    # 存在性检查函数
    # ═══════════════════════════════════════════════════════════
    
    # 检查整数数组是否包含指定元素
    # @param Arr: 要搜索的数组
    # @param Target: 要查找的元素
    # @returns: 如果找到则返回 true
    ContainsInt<public>(Arr:[]int, Target:int)<transacts>:logic =
        Result := IndexOfInt(Arr, Target)
        if (Result?) then true else false
    
    # 检查是否有任意元素大于零
    # @param Arr: 要检查的数组
    # @returns: 如果有任意元素大于零则返回 true
    AnyPositiveInt<public>(Arr:[]int)<transacts>:logic =
        Count := CountGreaterThanInt(Arr, 0)
        if (Count > 0) then true else false
    
    # 检查是否所有元素都非零
    # @param Arr: 要检查的数组
    # @returns: 如果所有元素都非零则返回 true
    AllNonZeroInt<public>(Arr:[]int)<transacts>:logic =
        NonZeroCount := CountNonZeroInt(Arr)
        TotalCount := Arr.Length
        if (NonZeroCount = TotalCount) then true else false
    
    # ═══════════════════════════════════════════════════════════
    # 辅助函数
    # ═══════════════════════════════════════════════════════════
    
    # 获取整数数组长度
    # @param Arr: 数组
    # @returns: 数组长度
    GetLengthInt<public>(Arr:[]int)<computes>:int =
        Arr.Length
    
    # 检查整数数组是否为空
    # @param Arr: 数组
    # @returns: 如果为空返回 true
    IsEmptyInt<public>(Arr:[]int)<computes>:logic =
        if (Arr.Length = 0) then true else false
    
    # 检查整数数组是否非空
    # @param Arr: 数组
    # @returns: 如果非空返回 true
    IsNotEmptyInt<public>(Arr:[]int)<computes>:logic =
        if (Arr.Length > 0) then true else false
    
    # 检查索引是否有效
    # @param Arr: 数组
    # @param Index: 索引
    # @returns: 如果索引有效返回 true
    IsValidIndexInt<public>(Arr:[]int, Index:int)<computes>:logic =
        InRange := if (Index >= 0) then true else false
        BelowLength := if (Index < Arr.Length) then true else false
        if (InRange = true):
            if (BelowLength = true):
                true
            else:
                false
        else:
            false
