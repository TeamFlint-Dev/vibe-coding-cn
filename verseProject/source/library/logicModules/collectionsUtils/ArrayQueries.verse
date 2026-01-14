# 数组查询模块
# 功能：数组查找、统计、最值查询

using { /Verse.org/Simulation }

ArrayQueries<public> := module:
    
    # ========== 基础查询 ==========
    
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
    
    # 检查浮点数数组是否包含指定元素
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
