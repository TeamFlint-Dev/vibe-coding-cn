# 数组聚合模块
# 功能：数组统计和聚合 - Sum, Product, Average, Min, Max
# 架构：Logic 层 - 纯函数，无状态
# 应用场景：统计分析、数据汇总、批量计算

using { /Verse.org/Verse }

ArrayAggregation<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 整数数组聚合
    # ═══════════════════════════════════════════════════════════
    
    # 求和 - 整数数组
    # @param Arr: 整数数组
    # @returns: 所有元素的和
    # 
    # 使用场景：
    # - 总分计算
    # - 资源总量统计
    SumInt<public>(Arr:[]int)<computes>:int =
        SumIntRecursive(Arr, 0, 0)
    
    SumIntRecursive(Arr:[]int, Index:int, Acc:int)<computes>:int =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                SumIntRecursive(Arr, Index + 1, Acc + Current)
            else:
                Acc
    
    # 求积 - 整数数组
    # @param Arr: 整数数组
    # @returns: 所有元素的积
    # 
    # 使用场景：
    # - 倍率计算
    # - 复合加成
    # 
    # 注意：空数组返回1（乘法单位元）
    ProductInt<public>(Arr:[]int)<computes>:int =
        if (Arr.Length = 0):
            1
        else:
            ProductIntRecursive(Arr, 0, 1)
    
    ProductIntRecursive(Arr:[]int, Index:int, Acc:int)<computes>:int =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                ProductIntRecursive(Arr, Index + 1, Acc * Current)
            else:
                Acc
    
    # 平均值 - 整数数组
    # @param Arr: 整数数组（必须非空）
    # @returns: 平均值（整数除法，向下取整）
    # 
    # 使用场景：
    # - 平均分计算
    # - 平均等级
    # 
    # 注意：空数组返回0
    AverageInt<public>(Arr:[]int)<transacts><decides>:int =
        if (Arr.Length = 0):
            0  # 空数组返回0
        else:
            Total := SumInt(Arr)
            if (Result := Floor[Total * 1.0 / (Arr.Length * 1.0)]):
                Result
            else:
                0
    
    # 最小值和最大值 - 整数数组
    # @param Arr: 整数数组（必须非空）
    # @returns: (最小值, 最大值) 的元组
    # 
    # 使用场景：
    # - 一次获取范围
    # - 数据分析
    # 
    # 注意：空数组返回(0, 0)
    MinMaxInt<public>(Arr:[]int)<computes>:tuple(int, int) =
        if (Arr.Length = 0):
            (0, 0)
        else if (FirstVal := Arr[0]):
            MinMaxIntRecursive(Arr, 1, FirstVal, FirstVal)
        else:
            (0, 0)
    
    MinMaxIntRecursive(Arr:[]int, Index:int, CurrentMin:int, CurrentMax:int)<computes>:tuple(int, int) =
        if (Index >= Arr.Length):
            (CurrentMin, CurrentMax)
        else:
            if (Current := Arr[Index]):
                NewMin := if (Current < CurrentMin):
                    Current
                else:
                    CurrentMin
                NewMax := if (Current > CurrentMax):
                    Current
                else:
                    CurrentMax
                MinMaxIntRecursive(Arr, Index + 1, NewMin, NewMax)
            else:
                (CurrentMin, CurrentMax)
    
    # ═══════════════════════════════════════════════════════════
    # 浮点数数组聚合
    # ═══════════════════════════════════════════════════════════
    
    # 求和 - 浮点数数组
    # @param Arr: 浮点数数组
    # @returns: 所有元素的和
    # 
    # 使用场景：
    # - 伤害总计
    # - 时间累加
    SumFloat<public>(Arr:[]float)<computes>:float =
        SumFloatRecursive(Arr, 0, 0.0)
    
    SumFloatRecursive(Arr:[]float, Index:int, Acc:float)<computes>:float =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                SumFloatRecursive(Arr, Index + 1, Acc + Current)
            else:
                Acc
    
    # 求积 - 浮点数数组
    # @param Arr: 浮点数数组
    # @returns: 所有元素的积
    # 
    # 使用场景：
    # - 伤害倍率计算
    # - 连续衰减
    # 
    # 注意：空数组返回1.0
    ProductFloat<public>(Arr:[]float)<computes>:float =
        if (Arr.Length = 0):
            1.0
        else:
            ProductFloatRecursive(Arr, 0, 1.0)
    
    ProductFloatRecursive(Arr:[]float, Index:int, Acc:float)<computes>:float =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                ProductFloatRecursive(Arr, Index + 1, Acc * Current)
            else:
                Acc
    
    # 平均值 - 浮点数数组
    # @param Arr: 浮点数数组（必须非空）
    # @returns: 平均值
    # 
    # 使用场景：
    # - 平均伤害
    # - 平均速度
    AverageFloat<public>(Arr:[]float)<computes>:float =
        if (Arr.Length = 0):
            0.0  # 空数组返回0.0
        else:
            Total := SumFloat(Arr)
            Total / (Arr.Length * 1.0)
    
    # 最小值和最大值 - 浮点数数组
    # @param Arr: 浮点数数组（必须非空）
    # @returns: (最小值, 最大值) 的元组
    # 
    # 使用场景：
    # - 一次获取范围
    # - 数据分析
    # 
    # 注意：空数组返回(0.0, 0.0)
    MinMaxFloat<public>(Arr:[]float)<computes>:tuple(float, float) =
        if (Arr.Length = 0):
            (0.0, 0.0)
        else if (FirstVal := Arr[0]):
            MinMaxFloatRecursive(Arr, 1, FirstVal, FirstVal)
        else:
            (0.0, 0.0)
    
    MinMaxFloatRecursive(Arr:[]float, Index:int, CurrentMin:float, CurrentMax:float)<computes>:tuple(float, float) =
        if (Index >= Arr.Length):
            (CurrentMin, CurrentMax)
        else:
            if (Current := Arr[Index]):
                NewMin := if (Current < CurrentMin):
                    Current
                else:
                    CurrentMin
                NewMax := if (Current > CurrentMax):
                    Current
                else:
                    CurrentMax
                MinMaxFloatRecursive(Arr, Index + 1, NewMin, NewMax)
            else:
                (CurrentMin, CurrentMax)
    
    # ═══════════════════════════════════════════════════════════
    # 加权聚合
    # ═══════════════════════════════════════════════════════════
    
    # 加权和 - 浮点数数组
    # @param Values: 值数组
    # @param Weights: 权重数组（长度必须匹配）
    # @returns: 加权和 Σ(value[i] * weight[i])
    # 
    # 使用场景：
    # - 加权评分
    # - 加权伤害计算
    WeightedSum<public>(Values:[]float, Weights:[]float)<computes>:float =
        if (Values.Length = Weights.Length):
            WeightedSumRecursive(Values, Weights, 0, 0.0)
        else:
            0.0  # 长度不匹配，返回0
    
    WeightedSumRecursive(Values:[]float, Weights:[]float, Index:int, Acc:float)<computes>:float =
        if (Index >= Values.Length):
            Acc
        else:
            if (Val := Values[Index]):
                if (Weight := Weights[Index]):
                    WeightedSumRecursive(Values, Weights, Index + 1, Acc + (Val * Weight))
                else:
                    Acc
            else:
                Acc
    
    # 加权平均 - 浮点数数组
    # @param Values: 值数组
    # @param Weights: 权重数组（长度必须匹配）
    # @returns: 加权平均 Σ(value[i] * weight[i]) / Σ(weight[i])
    # 
    # 使用场景：
    # - 加权平均分
    # - 综合评估
    WeightedAverage<public>(Values:[]float, Weights:[]float)<computes>:float =
        if (Values.Length = Weights.Length):
            WSum := WeightedSum(Values, Weights)
            TotalWeight := SumFloat(Weights)
            if (TotalWeight > 0.0):
                WSum / TotalWeight
            else:
                0.0  # 总权重为0，返回0
        else:
            0.0  # 长度不匹配，返回0
    
    # ═══════════════════════════════════════════════════════════
    # 统计工具
    # ═══════════════════════════════════════════════════════════
    
    # 计数非零元素 - 整数数组
    # @param Arr: 整数数组
    # @returns: 非零元素的数量
    # 
    # 使用场景：
    # - 统计有效数据
    # - 计数激活项
    CountNonZeroInt<public>(Arr:[]int)<computes>:int =
        CountNonZeroIntRecursive(Arr, 0, 0)
    
    CountNonZeroIntRecursive(Arr:[]int, Index:int, Acc:int)<computes>:int =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                NewAcc := if (Current = 0):
                    Acc
                else:
                    Acc + 1
                CountNonZeroIntRecursive(Arr, Index + 1, NewAcc)
            else:
                Acc
    
    # 计数非零元素 - 浮点数数组
    # @param Arr: 浮点数数组
    # @returns: 非零元素的数量
    CountNonZeroFloat<public>(Arr:[]float)<computes>:int =
        CountNonZeroFloatRecursive(Arr, 0, 0)
    
    CountNonZeroFloatRecursive(Arr:[]float, Index:int, Acc:int)<computes>:int =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                NewAcc := if (Current = 0.0):
                    Acc
                else:
                    Acc + 1
                CountNonZeroFloatRecursive(Arr, Index + 1, NewAcc)
            else:
                Acc
    
    # 累积和 - 整数数组
    # @param Arr: 整数数组
    # @returns: 累积和数组 [a[0], a[0]+a[1], a[0]+a[1]+a[2], ...]
    # 
    # 使用场景：
    # - 前缀和计算
    # - 区间查询预处理
    CumulativeSumInt<public>(Arr:[]int)<computes>:[]int =
        CumulativeSumIntRecursive(Arr, 0, 0, array{})
    
    CumulativeSumIntRecursive(Arr:[]int, Index:int, Acc:int, Result:[]int)<computes>:[]int =
        if (Index >= Arr.Length):
            Result
        else:
            if (Current := Arr[Index]):
                NewAcc := Acc + Current
                CumulativeSumIntRecursive(Arr, Index + 1, NewAcc, Result + array{NewAcc})
            else:
                Result
    
    # 累积和 - 浮点数数组
    # @param Arr: 浮点数数组
    # @returns: 累积和数组
    CumulativeSumFloat<public>(Arr:[]float)<computes>:[]float =
        CumulativeSumFloatRecursive(Arr, 0, 0.0, array{})
    
    CumulativeSumFloatRecursive(Arr:[]float, Index:int, Acc:float, Result:[]float)<computes>:[]float =
        if (Index >= Arr.Length):
            Result
        else:
            if (Current := Arr[Index]):
                NewAcc := Acc + Current
                CumulativeSumFloatRecursive(Arr, Index + 1, NewAcc, Result + array{NewAcc})
            else:
                Result
    
    # ═══════════════════════════════════════════════════════════
    # 范围查询工具
    # ═══════════════════════════════════════════════════════════
    
    # 区间求和 - 整数数组
    # @param Arr: 整数数组
    # @param StartIndex: 起始索引（包含）
    # @param EndIndex: 结束索引（不包含）
    # @returns: 区间和
    # 
    # 使用场景：
    # - 部分统计
    # - 分段分析
    RangeSumInt<public>(Arr:[]int, StartIndex:int, EndIndex:int)<computes>:int =
        if (StartIndex < 0 or EndIndex > Arr.Length or StartIndex >= EndIndex):
            0
        else:
            RangeSumIntRecursive(Arr, StartIndex, EndIndex, 0)
    
    RangeSumIntRecursive(Arr:[]int, CurrentIndex:int, EndIndex:int, Acc:int)<computes>:int =
        if (CurrentIndex >= EndIndex):
            Acc
        else:
            if (Current := Arr[CurrentIndex]):
                RangeSumIntRecursive(Arr, CurrentIndex + 1, EndIndex, Acc + Current)
            else:
                Acc
    
    # 区间求和 - 浮点数数组
    # @param Arr: 浮点数数组
    # @param StartIndex: 起始索引（包含）
    # @param EndIndex: 结束索引（不包含）
    # @returns: 区间和
    RangeSumFloat<public>(Arr:[]float, StartIndex:int, EndIndex:int)<computes>:float =
        if (StartIndex < 0 or EndIndex > Arr.Length or StartIndex >= EndIndex):
            0.0
        else:
            RangeSumFloatRecursive(Arr, StartIndex, EndIndex, 0.0)
    
    RangeSumFloatRecursive(Arr:[]float, CurrentIndex:int, EndIndex:int, Acc:float)<computes>:float =
        if (CurrentIndex >= EndIndex):
            Acc
        else:
            if (Current := Arr[CurrentIndex]):
                RangeSumFloatRecursive(Arr, CurrentIndex + 1, EndIndex, Acc + Current)
            else:
                Acc
