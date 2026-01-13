# 数组集合操作模块
# 功能：集合运算 - Unique, Union, Intersection, Difference, IsSubset
# 架构：Logic 层 - 纯函数，无状态
# 应用场景：标签系统、权限判断、去重处理

using { /Verse.org/Verse }

ArraySetOps<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 整数数组集合操作
    # ═══════════════════════════════════════════════════════════
    
    # 去重 - 整数数组
    # @param Arr: 整数数组
    # @returns: 去重后的数组（保持原顺序）
    # 
    # 使用场景：
    # - 去除重复ID
    # - 唯一标签列表
    UniqueInt<public>(Arr:[]int)<computes>:[]int =
        UniqueIntRecursive(Arr, 0, array{})
    
    UniqueIntRecursive(Arr:[]int, Index:int, Acc:[]int)<computes>:[]int =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                # 检查当前元素是否已在结果中
                Contains := ContainsIntHelper(Acc, Current, 0)
                if (Contains):
                    # 已存在，跳过
                    UniqueIntRecursive(Arr, Index + 1, Acc)
                else:
                    # 不存在，添加
                    UniqueIntRecursive(Arr, Index + 1, Acc + array{Current})
            else:
                Acc
    
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
    
    # 并集 - 整数数组
    # @param Arr1: 第一个数组
    # @param Arr2: 第二个数组
    # @returns: 两个数组的并集（去重）
    # 
    # 使用场景：
    # - 合并权限列表
    # - 组合标签
    UnionInt<public>(Arr1:[]int, Arr2:[]int)<computes>:[]int =
        # 先合并，再去重
        Combined := Arr1 + Arr2
        UniqueInt(Combined)
    
    # 交集 - 整数数组
    # @param Arr1: 第一个数组
    # @param Arr2: 第二个数组
    # @returns: 两个数组的交集
    # 
    # 使用场景：
    # - 共同权限
    # - 共同标签
    IntersectionInt<public>(Arr1:[]int, Arr2:[]int)<computes>:[]int =
        IntersectionIntRecursive(Arr1, Arr2, 0, array{})
    
    IntersectionIntRecursive(Arr1:[]int, Arr2:[]int, Index:int, Acc:[]int)<computes>:[]int =
        if (Index >= Arr1.Length):
            Acc
        else:
            if (Current := Arr1[Index]):
                # 检查当前元素是否在第二个数组中
                InArr2 := ContainsIntHelper(Arr2, Current, 0)
                InAcc := ContainsIntHelper(Acc, Current, 0)
                if (InArr2 and not InAcc):
                    # 在第二个数组中且不在结果中，添加
                    IntersectionIntRecursive(Arr1, Arr2, Index + 1, Acc + array{Current})
                else:
                    IntersectionIntRecursive(Arr1, Arr2, Index + 1, Acc)
            else:
                Acc
    
    # 差集 - 整数数组
    # @param Arr1: 第一个数组
    # @param Arr2: 第二个数组
    # @returns: Arr1中有但Arr2中没有的元素
    # 
    # 使用场景：
    # - 移除权限
    # - 标签差异
    DifferenceInt<public>(Arr1:[]int, Arr2:[]int)<computes>:[]int =
        DifferenceIntRecursive(Arr1, Arr2, 0, array{})
    
    DifferenceIntRecursive(Arr1:[]int, Arr2:[]int, Index:int, Acc:[]int)<computes>:[]int =
        if (Index >= Arr1.Length):
            Acc
        else:
            if (Current := Arr1[Index]):
                # 检查当前元素是否在第二个数组中
                InArr2 := ContainsIntHelper(Arr2, Current, 0)
                InAcc := ContainsIntHelper(Acc, Current, 0)
                if (not InArr2 and not InAcc):
                    # 不在第二个数组中且不在结果中，添加
                    DifferenceIntRecursive(Arr1, Arr2, Index + 1, Acc + array{Current})
                else:
                    DifferenceIntRecursive(Arr1, Arr2, Index + 1, Acc)
            else:
                Acc
    
    # 是否为子集 - 整数数组
    # @param Subset: 可能的子集
    # @param Superset: 可能的超集
    # @returns: 如果Subset的所有元素都在Superset中则返回true
    # 
    # 使用场景：
    # - 权限验证
    # - 标签包含检查
    IsSubsetInt<public>(Subset:[]int, Superset:[]int)<computes>:logic =
        IsSubsetIntRecursive(Subset, Superset, 0)
    
    IsSubsetIntRecursive(Subset:[]int, Superset:[]int, Index:int)<computes>:logic =
        if (Index >= Subset.Length):
            true  # 所有元素都检查过了，都在超集中
        else:
            if (Current := Subset[Index]):
                InSuperset := ContainsIntHelper(Superset, Current, 0)
                if (InSuperset):
                    # 当前元素在超集中，继续检查下一个
                    IsSubsetIntRecursive(Subset, Superset, Index + 1)
                else:
                    # 当前元素不在超集中，不是子集
                    false
            else:
                # 跳过无效元素
                IsSubsetIntRecursive(Subset, Superset, Index + 1)
    
    # ═══════════════════════════════════════════════════════════
    # 浮点数数组集合操作
    # ═══════════════════════════════════════════════════════════
    
    # 去重 - 浮点数数组
    # @param Arr: 浮点数数组
    # @returns: 去重后的数组（保持原顺序）
    # 
    # 注意：使用精确匹配（=），不考虑浮点误差
    UniqueFloat<public>(Arr:[]float)<computes>:[]float =
        UniqueFloatRecursive(Arr, 0, array{})
    
    UniqueFloatRecursive(Arr:[]float, Index:int, Acc:[]float)<computes>:[]float =
        if (Index >= Arr.Length):
            Acc
        else:
            if (Current := Arr[Index]):
                Contains := ContainsFloatHelper(Acc, Current, 0)
                if (Contains):
                    UniqueFloatRecursive(Arr, Index + 1, Acc)
                else:
                    UniqueFloatRecursive(Arr, Index + 1, Acc + array{Current})
            else:
                Acc
    
    ContainsFloatHelper(Arr:[]float, Element:float, Index:int)<computes>:logic =
        if (Index >= Arr.Length):
            false
        else:
            if (Current := Arr[Index]):
                if (Current = Element):
                    true
                else:
                    ContainsFloatHelper(Arr, Element, Index + 1)
            else:
                false
    
    # 并集 - 浮点数数组
    UnionFloat<public>(Arr1:[]float, Arr2:[]float)<computes>:[]float =
        Combined := Arr1 + Arr2
        UniqueFloat(Combined)
    
    # 交集 - 浮点数数组
    IntersectionFloat<public>(Arr1:[]float, Arr2:[]float)<computes>:[]float =
        IntersectionFloatRecursive(Arr1, Arr2, 0, array{})
    
    IntersectionFloatRecursive(Arr1:[]float, Arr2:[]float, Index:int, Acc:[]float)<computes>:[]float =
        if (Index >= Arr1.Length):
            Acc
        else:
            if (Current := Arr1[Index]):
                InArr2 := ContainsFloatHelper(Arr2, Current, 0)
                InAcc := ContainsFloatHelper(Acc, Current, 0)
                if (InArr2 and not InAcc):
                    IntersectionFloatRecursive(Arr1, Arr2, Index + 1, Acc + array{Current})
                else:
                    IntersectionFloatRecursive(Arr1, Arr2, Index + 1, Acc)
            else:
                Acc
    
    # 差集 - 浮点数数组
    DifferenceFloat<public>(Arr1:[]float, Arr2:[]float)<computes>:[]float =
        DifferenceFloatRecursive(Arr1, Arr2, 0, array{})
    
    DifferenceFloatRecursive(Arr1:[]float, Arr2:[]float, Index:int, Acc:[]float)<computes>:[]float =
        if (Index >= Arr1.Length):
            Acc
        else:
            if (Current := Arr1[Index]):
                InArr2 := ContainsFloatHelper(Arr2, Current, 0)
                InAcc := ContainsFloatHelper(Acc, Current, 0)
                if (not InArr2 and not InAcc):
                    DifferenceFloatRecursive(Arr1, Arr2, Index + 1, Acc + array{Current})
                else:
                    DifferenceFloatRecursive(Arr1, Arr2, Index + 1, Acc)
            else:
                Acc
    
    # 是否为子集 - 浮点数数组
    IsSubsetFloat<public>(Subset:[]float, Superset:[]float)<computes>:logic =
        IsSubsetFloatRecursive(Subset, Superset, 0)
    
    IsSubsetFloatRecursive(Subset:[]float, Superset:[]float, Index:int)<computes>:logic =
        if (Index >= Subset.Length):
            true
        else:
            if (Current := Subset[Index]):
                InSuperset := ContainsFloatHelper(Superset, Current, 0)
                if (InSuperset):
                    IsSubsetFloatRecursive(Subset, Superset, Index + 1)
                else:
                    false
            else:
                IsSubsetFloatRecursive(Subset, Superset, Index + 1)
    
    # ═══════════════════════════════════════════════════════════
    # 实用工具
    # ═══════════════════════════════════════════════════════════
    
    # 是否有交集 - 整数数组
    # @param Arr1: 第一个数组
    # @param Arr2: 第二个数组
    # @returns: 如果有共同元素返回true
    # 
    # 使用场景：
    # - 快速判断是否有共同权限
    # - 标签重叠检查
    HasIntersectionInt<public>(Arr1:[]int, Arr2:[]int)<computes>:logic =
        HasIntersectionIntRecursive(Arr1, Arr2, 0)
    
    HasIntersectionIntRecursive(Arr1:[]int, Arr2:[]int, Index:int)<computes>:logic =
        if (Index >= Arr1.Length):
            false
        else:
            if (Current := Arr1[Index]):
                InArr2 := ContainsIntHelper(Arr2, Current, 0)
                if (InArr2):
                    true  # 找到共同元素
                else:
                    HasIntersectionIntRecursive(Arr1, Arr2, Index + 1)
            else:
                HasIntersectionIntRecursive(Arr1, Arr2, Index + 1)
    
    # 是否有交集 - 浮点数数组
    HasIntersectionFloat<public>(Arr1:[]float, Arr2:[]float)<computes>:logic =
        HasIntersectionFloatRecursive(Arr1, Arr2, 0)
    
    HasIntersectionFloatRecursive(Arr1:[]float, Arr2:[]float, Index:int)<computes>:logic =
        if (Index >= Arr1.Length):
            false
        else:
            if (Current := Arr1[Index]):
                InArr2 := ContainsFloatHelper(Arr2, Current, 0)
                if (InArr2):
                    true
                else:
                    HasIntersectionFloatRecursive(Arr1, Arr2, Index + 1)
            else:
                HasIntersectionFloatRecursive(Arr1, Arr2, Index + 1)
