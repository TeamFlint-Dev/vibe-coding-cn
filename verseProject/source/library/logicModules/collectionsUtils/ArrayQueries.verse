# 数组查询模块
# 功能：数组内容查询 - Contains, IndexOf, Count, FindMin/Max
# 架构：Logic 层 - 纯函数，无状态
# 应用场景：搜索、统计、范围查询
# 
# 注意：由于Verse泛型限制，提供int和float的专用版本

using { /Verse.org/Verse }

ArrayQueries<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 整数数组查询
    # ═══════════════════════════════════════════════════════════
    
    # 检查整数数组是否包含指定元素
    ContainsInt<public>(Arr:[]int, Element:int)<computes>:logic =
        ContainsIntRecursive(Arr, Element, 0)
    
    ContainsIntRecursive(Arr:[]int, Element:int, Index:int)<computes>:logic =
        if (Index >= Arr.Length):
            false
        else:
            if (Current := Arr[Index]):
                if (Current = Element):
                    true
                else:
                    ContainsIntRecursive(Arr, Element, Index + 1)
            else:
                false
    
    # 查找整数元素的第一次出现位置
    IndexOfInt<public>(Arr:[]int, Element:int)<decides>:int =
        IndexOfIntRecursive(Arr, Element, 0)
    
    IndexOfIntRecursive(Arr:[]int, Element:int, Index:int)<decides>:int =
        if (Index >= Arr.Length):
            false
        else:
            if (Current := Arr[Index]):
                if (Current = Element):
                    Index
                else:
                    IndexOfIntRecursive[Arr, Element, Index + 1]
            else:
                false
    
    # 统计整数元素出现次数
    CountInt<public>(Arr:[]int, Element:int)<computes>:int =
        CountIntRecursive(Arr, Element, 0, 0)
    
    CountIntRecursive(Arr:[]int, Element:int, Index:int, Acc:int)<computes>:int =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                NewAcc := if (Current = Element):
                    Acc + 1
                else:
                    Acc
                CountIntRecursive(Arr, Element, Index + 1, NewAcc)
            else:
                Acc
    
    # 查找整数数组的最小值
    FindMinInt<public>(Arr:[]int)<decides>:int =
        if (FirstVal := Arr[0]):
            FindMinIntRecursive(Arr, 1, FirstVal)
        else:
            false
    
    FindMinIntRecursive(Arr:[]int, Index:int, CurrentMin:int)<computes>:int =
        if (Index >= Arr.Length):
            CurrentMin
        else:
            if (Current := Arr[Index]):
                NewMin := if (Current < CurrentMin):
                    Current
                else:
                    CurrentMin
                FindMinIntRecursive(Arr, Index + 1, NewMin)
            else:
                CurrentMin
    
    # 查找整数数组的最大值
    FindMaxInt<public>(Arr:[]int)<decides>:int =
        if (FirstVal := Arr[0]):
            FindMaxIntRecursive(Arr, 1, FirstVal)
        else:
            false
    
    FindMaxIntRecursive(Arr:[]int, Index:int, CurrentMax:int)<computes>:int =
        if (Index >= Arr.Length):
            CurrentMax
        else:
            if (Current := Arr[Index]):
                NewMax := if (Current > CurrentMax):
                    Current
                else:
                    CurrentMax
                FindMaxIntRecursive(Arr, Index + 1, NewMax)
            else:
                CurrentMax
    
    # 查找整数数组最小值的索引
    FindMinIntIndex<public>(Arr:[]int)<decides>:int =
        if (FirstVal := Arr[0]):
            FindMinIntIndexRecursive(Arr, 1, 0, FirstVal)
        else:
            false
    
    FindMinIntIndexRecursive(Arr:[]int, Index:int, MinIndex:int, MinValue:int)<computes>:int =
        if (Index >= Arr.Length):
            MinIndex
        else:
            if (Current := Arr[Index]):
                if (Current < MinValue):
                    FindMinIntIndexRecursive(Arr, Index + 1, Index, Current)
                else:
                    FindMinIntIndexRecursive(Arr, Index + 1, MinIndex, MinValue)
            else:
                MinIndex
    
    # 查找整数数组最大值的索引
    FindMaxIntIndex<public>(Arr:[]int)<decides>:int =
        if (FirstVal := Arr[0]):
            FindMaxIntIndexRecursive(Arr, 1, 0, FirstVal)
        else:
            false
    
    FindMaxIntIndexRecursive(Arr:[]int, Index:int, MaxIndex:int, MaxValue:int)<computes>:int =
        if (Index >= Arr.Length):
            MaxIndex
        else:
            if (Current := Arr[Index]):
                if (Current > MaxValue):
                    FindMaxIntIndexRecursive(Arr, Index + 1, Index, Current)
                else:
                    FindMaxIntIndexRecursive(Arr, Index + 1, MaxIndex, MaxValue)
            else:
                MaxIndex
    
    # ═══════════════════════════════════════════════════════════
    # 浮点数数组查询
    # ═══════════════════════════════════════════════════════════
    
    # 检查浮点数数组是否包含指定元素（精确匹配）
    ContainsFloat<public>(Arr:[]float, Element:float)<computes>:logic =
        ContainsFloatRecursive(Arr, Element, 0)
    
    ContainsFloatRecursive(Arr:[]float, Element:float, Index:int)<computes>:logic =
        if (Index >= Arr.Length):
            false
        else:
            if (Current := Arr[Index]):
                if (Current = Element):
                    true
                else:
                    ContainsFloatRecursive(Arr, Element, Index + 1)
            else:
                false
    
    # 查找浮点数元素的第一次出现位置
    IndexOfFloat<public>(Arr:[]float, Element:float)<decides>:int =
        IndexOfFloatRecursive(Arr, Element, 0)
    
    IndexOfFloatRecursive(Arr:[]float, Element:float, Index:int)<decides>:int =
        if (Index >= Arr.Length):
            false
        else:
            if (Current := Arr[Index]):
                if (Current = Element):
                    Index
                else:
                    IndexOfFloatRecursive[Arr, Element, Index + 1]
            else:
                false
    
    # 统计浮点数元素出现次数
    CountFloat<public>(Arr:[]float, Element:float)<computes>:int =
        CountFloatRecursive(Arr, Element, 0, 0)
    
    CountFloatRecursive(Arr:[]float, Element:float, Index:int, Acc:int)<computes>:int =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                NewAcc := if (Current = Element):
                    Acc + 1
                else:
                    Acc
                CountFloatRecursive(Arr, Element, Index + 1, NewAcc)
            else:
                Acc
    
    # 查找浮点数数组的最小值
    FindMinFloat<public>(Arr:[]float)<decides>:float =
        if (FirstVal := Arr[0]):
            FindMinFloatRecursive(Arr, 1, FirstVal)
        else:
            false
    
    FindMinFloatRecursive(Arr:[]float, Index:int, CurrentMin:float)<computes>:float =
        if (Index >= Arr.Length):
            CurrentMin
        else:
            if (Current := Arr[Index]):
                NewMin := if (Current < CurrentMin):
                    Current
                else:
                    CurrentMin
                FindMinFloatRecursive(Arr, Index + 1, NewMin)
            else:
                CurrentMin
    
    # 查找浮点数数组的最大值
    FindMaxFloat<public>(Arr:[]float)<decides>:float =
        if (FirstVal := Arr[0]):
            FindMaxFloatRecursive(Arr, 1, FirstVal)
        else:
            false
    
    FindMaxFloatRecursive(Arr:[]float, Index:int, CurrentMax:float)<computes>:float =
        if (Index >= Arr.Length):
            CurrentMax
        else:
            if (Current := Arr[Index]):
                NewMax := if (Current > CurrentMax):
                    Current
                else:
                    CurrentMax
                FindMaxFloatRecursive(Arr, Index + 1, NewMax)
            else:
                CurrentMax
    
    # 查找浮点数数组最小值的索引
    FindMinFloatIndex<public>(Arr:[]float)<decides>:int =
        if (FirstVal := Arr[0]):
            FindMinFloatIndexRecursive(Arr, 1, 0, FirstVal)
        else:
            false
    
    FindMinFloatIndexRecursive(Arr:[]float, Index:int, MinIndex:int, MinValue:float)<computes>:int =
        if (Index >= Arr.Length):
            MinIndex
        else:
            if (Current := Arr[Index]):
                if (Current < MinValue):
                    FindMinFloatIndexRecursive(Arr, Index + 1, Index, Current)
                else:
                    FindMinFloatIndexRecursive(Arr, Index + 1, MinIndex, MinValue)
            else:
                MinIndex
    
    # 查找浮点数数组最大值的索引
    FindMaxFloatIndex<public>(Arr:[]float)<decides>:int =
        if (FirstVal := Arr[0]):
            FindMaxFloatIndexRecursive(Arr, 1, 0, FirstVal)
        else:
            false
    
    FindMaxFloatIndexRecursive(Arr:[]float, Index:int, MaxIndex:int, MaxValue:float)<computes>:int =
        if (Index >= Arr.Length):
            MaxIndex
        else:
            if (Current := Arr[Index]):
                if (Current > MaxValue):
                    FindMaxFloatIndexRecursive(Arr, Index + 1, Index, Current)
                else:
                    FindMaxFloatIndexRecursive(Arr, Index + 1, MaxIndex, MaxValue)
            else:
                MaxIndex
    
    # ═══════════════════════════════════════════════════════════
    # 通用数组工具
    # ═══════════════════════════════════════════════════════════
    
    # 检查数组是否为空
    IsEmpty<public>(Arr:[]t where t:type)<computes>:logic =
        if (Arr.Length = 0) then true else false
    
    # 检查数组是否非空
    IsNotEmpty<public>(Arr:[]t where t:type)<computes>:logic =
        if (Arr.Length > 0) then true else false
    
    # 获取数组长度
    GetCount<public>(Arr:[]t where t:type)<computes>:int =
        Arr.Length
    
    # 获取安全索引（带默认值）
    GetOrDefault<public>(Arr:[]t, Index:int, DefaultValue:t where t:type)<computes>:t =
        if (Element := Arr[Index]):
            Element
        else:
            DefaultValue
