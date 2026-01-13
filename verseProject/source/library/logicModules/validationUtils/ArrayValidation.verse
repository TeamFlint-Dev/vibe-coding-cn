# 数组验证模块
# 功能：提供数组内容和结构验证函数，使用 <decides> 效果进行fail-fast验证
# 架构：Logic 层 - 无状态纯函数，使用 <decides> 效果

using { /Verse.org/Simulation }

ArrayValidation<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 基础数组验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证数组是否为空
    # @param Arr: 要验证的数组
    # @returns: void - 数组为空时成功，非空时失败
    # 
    # 使用场景：
    # - 检查清空操作是否成功
    # - 验证初始状态
    ValidateEmpty<public>(Arr:[]t where t:type)<decides><transacts>:void =
        Arr.Length = 0
    
    # 验证数组是否非空
    # @param Arr: 要验证的数组
    # @returns: void - 数组非空时成功，为空时失败
    # 
    # 使用场景：
    # - 确保有数据可处理
    # - 验证列表必须包含元素
    # - 检查操作前提条件
    ValidateNotEmpty<public>(Arr:[]t where t:type)<decides><transacts>:void =
        Arr.Length > 0
    
    # 验证数组至少包含指定数量的元素
    # @param Arr: 要验证的数组
    # @param MinCount: 最小元素数量
    # @returns: void - 元素数量 >= MinCount 时成功
    # 
    # 使用场景：
    # - 验证最小玩家数量
    # - 确保有足够的选项
    # - 检查批量操作的最小需求
    ValidateMinElements<public>(Arr:[]t, MinCount:int where t:type)<decides><transacts>:void =
        Arr.Length >= MinCount
    
    # 验证数组元素数量不超过指定值
    # @param Arr: 要验证的数组
    # @param MaxCount: 最大元素数量
    # @returns: void - 元素数量 <= MaxCount 时成功
    # 
    # 使用场景：
    # - 限制列表大小
    # - 防止性能问题
    # - 验证容量限制
    ValidateMaxElements<public>(Arr:[]t, MaxCount:int where t:type)<decides><transacts>:void =
        Arr.Length <= MaxCount
    
    # 验证数组元素数量在范围内
    # @param Arr: 要验证的数组
    # @param MinCount: 最小元素数量（包含）
    # @param MaxCount: 最大元素数量（包含）
    # @returns: void - MinCount <= 元素数量 <= MaxCount 时成功
    # 
    # 使用场景：
    # - 验证队伍大小（如 2-4 人）
    # - 检查选项数量范围
    # - 限制批量操作规模
    ValidateElementCountInRange<public>(Arr:[]t, MinCount:int, MaxCount:int where t:type)<decides><transacts>:void =
        Len := Arr.Length
        Len >= MinCount
        Len <= MaxCount
    
    # 验证数组元素数量精确匹配
    # @param Arr: 要验证的数组
    # @param ExactCount: 精确元素数量
    # @returns: void - 元素数量 = ExactCount 时成功
    # 
    # 使用场景：
    # - 验证固定大小的数据结构
    # - 检查配对或分组操作
    # - 确保特定数量的参数
    ValidateExactElementCount<public>(Arr:[]t, ExactCount:int where t:type)<decides><transacts>:void =
        Arr.Length = ExactCount
    
    # ═══════════════════════════════════════════════════════════
    # 索引和访问验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证索引是否在数组有效范围内
    # @param Arr: 数组
    # @param Index: 要验证的索引
    # @returns: void - 0 <= Index < Arr.Length 时成功
    # 
    # 使用场景：
    # - 访问数组元素前验证
    # - 防止越界访问
    # - 检查用户输入的索引
    ValidateIndexInBounds<public>(Arr:[]t, Index:int where t:type)<decides><transacts>:void =
        Index >= 0
        Index < Arr.Length
    
    # 验证所有索引都在数组有效范围内
    # @param Arr: 数组
    # @param Indices: 要验证的索引数组
    # @returns: void - 所有索引都有效时成功
    # 
    # 使用场景：
    # - 批量访问前验证
    # - 验证索引集合的有效性
    ValidateAllIndicesInBounds<public>(Arr:[]t, Indices:[]int where t:type)<decides><transacts>:void =
        for (Index : Indices):
            Index >= 0
            Index < Arr.Length
    
    # ═══════════════════════════════════════════════════════════
    # 数组内容验证（使用谓词）
    # ═══════════════════════════════════════════════════════════
    
    # 验证数组中所有整数都是正数
    # @param Arr: 要验证的整数数组
    # @returns: void - 所有元素 > 0 时成功
    # 
    # 使用场景：
    # - 验证ID列表
    # - 检查正数参数
    # - 确保有效的计数值
    ValidateAllPositiveInts<public>(Arr:[]int)<decides><transacts>:void =
        Arr.Length > 0
        for (Value : Arr):
            Value > 0
    
    # 验证数组中所有整数都是非负数
    # @param Arr: 要验证的整数数组
    # @returns: void - 所有元素 >= 0 时成功
    # 
    # 使用场景：
    # - 验证索引列表
    # - 检查数量数组
    # - 确保非负值
    ValidateAllNonNegativeInts<public>(Arr:[]int)<decides><transacts>:void =
        Arr.Length > 0
        for (Value : Arr):
            Value >= 0
    
    # 验证数组中所有浮点数都在范围内（带容差）
    # @param Arr: 要验证的浮点数数组
    # @param MinVal: 最小值（包含，带容差）
    # @param MaxVal: 最大值（包含，带容差）
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 所有元素都在范围内时成功
    # 
    # 使用场景：
    # - 验证百分比数组（0.0 到 1.0）
    # - 检查参数数组的有效范围
    # - 确保数值在合理区间
    ValidateAllFloatsInRange<public>(Arr:[]float, MinVal:float, MaxVal:float, ?Epsilon:float = 0.0001)<decides><transacts>:void =
        Arr.Length > 0
        for (Value : Arr):
            Value >= MinVal - Epsilon
            Value <= MaxVal + Epsilon
    
    # ═══════════════════════════════════════════════════════════
    # 数组唯一性验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证整数数组中没有重复元素
    # @param Arr: 要验证的整数数组
    # @returns: void - 没有重复元素时成功
    # 
    # 使用场景：
    # - 验证唯一ID列表
    # - 检查去重操作结果
    # - 确保集合语义
    # 
    # 注意：时间复杂度 O(n²)，大数组慎用
    ValidateNoDuplicateInts<public>(Arr:[]int)<decides><transacts>:void =
        # 空数组或单元素数组没有重复
        if (Arr.Length <= 1):
            true
        else:
            # 检查每对元素
            for (I -> ValueI : Arr):
                for (J -> ValueJ : Arr):
                    if (I < J):
                        # 确保不同位置的元素值不同
                        ValueI <> ValueJ
    
    # 验证字符串数组中没有重复元素
    # @param Arr: 要验证的字符串数组
    # @returns: void - 没有重复元素时成功
    # 
    # 使用场景：
    # - 验证唯一名称列表
    # - 检查标签集合
    # - 确保选项不重复
    # 
    # 注意：时间复杂度 O(n²)，大数组慎用
    ValidateNoDuplicateStrings<public>(Arr:[]string)<decides><transacts>:void =
        # 空数组或单元素数组没有重复
        if (Arr.Length <= 1):
            true
        else:
            # 检查每对元素
            for (I -> ValueI : Arr):
                for (J -> ValueJ : Arr):
                    if (I < J):
                        # 确保不同位置的元素值不同
                        ValueI <> ValueJ
    
    # ═══════════════════════════════════════════════════════════
    # 组合验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证数组非空且所有元素为正整数
    # @param Arr: 要验证的整数数组
    # @returns: void - 非空且所有元素 > 0 时成功
    # 
    # 使用场景：
    # - 验证ID列表（非空 + 正数）
    # - 检查有效的引用集合
    ValidateNonEmptyPositiveInts<public>(Arr:[]int)<decides><transacts>:void =
        Arr.Length > 0
        for (Value : Arr):
            Value > 0
    
    # 验证数组大小合理且所有元素在范围内
    # @param Arr: 要验证的整数数组
    # @param MinVal: 元素最小值
    # @param MaxVal: 元素最大值
    # @param MaxSize: 数组最大大小
    # @returns: void - 数组不超过最大大小且所有元素在范围内时成功
    # 
    # 使用场景：
    # - 验证用户输入的数值列表
    # - 检查配置数组
    # - 确保数据合规
    ValidateReasonableSizeAndRange<public>(Arr:[]int, MinVal:int, MaxVal:int, MaxSize:int)<decides><transacts>:void =
        # 大小检查
        Arr.Length > 0
        Arr.Length <= MaxSize
        # 范围检查
        for (Value : Arr):
            Value >= MinVal
            Value <= MaxVal
