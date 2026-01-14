# 数组集合操作模块
# 功能：去重、并集、交集、差集等集合操作

using { /Verse.org/Simulation }

ArraySetOps<public> := module:
    
    # 辅助函数：检查整数数组是否包含元素
    ContainsIntHelper(Arr:[]int, Element:int, Index:int)<computes>:logic =
        if (Index >= Arr.Length):
            false
        else:
            if (Current := Arr[Index]):
                if (Current = Element):
                    true
                else:
                    ContainsIntHelper(Arr, Element, Index + 1)
            else:
                false
    
    # 去重 - 整数数组
    UniqueInt<public>(Arr:[]int)<computes>:[]int =
        UniqueIntRecursive(Arr, 0, array{})
    
    UniqueIntRecursive(Arr:[]int, Index:int, Acc:[]int)<computes>:[]int =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                if (ContainsIntHelper(Acc, Current, 0)):
                    UniqueIntRecursive(Arr, Index + 1, Acc)
                else:
                    UniqueIntRecursive(Arr, Index + 1, Acc + array{Current})
            else:
                Acc
    
    # 并集 - 整数数组
    UnionInt<public>(Arr1:[]int, Arr2:[]int)<computes>:[]int =
        Combined := Arr1 + Arr2
        UniqueInt(Combined)
