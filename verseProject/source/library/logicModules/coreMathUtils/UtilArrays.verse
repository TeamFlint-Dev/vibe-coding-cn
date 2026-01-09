# 数组工具模块
# 功能：常用数组操作

using { /Verse.org/Simulation }

UtilArrays<public> := module:
    
    # ========== 访问函数 ==========
    
    # 获取第一个元素
    First<public>(Arr:[]t where t:type)<decides><transacts>:t =
        Arr[0]
    
    # 获取最后一个元素
    Last<public>(Arr:[]t where t:type)<decides><transacts>:t =
        Arr[Arr.Length - 1]
    
    # 获取元素或返回默认值
    GetOrDefault<public>(Arr:[]t, Index:int, Default:t where t:type)<computes>:t =
        if (Element := Arr[Index]):
            Element
        else:
            Default
    
    # ========== 检查函数 ==========
    
    # 检查数组是否为空
    CheckEmpty<public>(Arr:[]t where t:type)<decides><transacts>:void =
        Arr.Length = 0
    
    # 检查数组是否非空
    CheckNotEmpty<public>(Arr:[]t where t:type)<decides><transacts>:void =
        Arr.Length > 0
    
    # 检查索引是否有效
    CheckValidIndex<public>(Arr:[]t, Index:int where t:type)<decides><transacts>:void =
        Index >= 0
        Index < Arr.Length
    
    # ========== 切片函数 ==========
    
    # 获取前 N 个元素
    Take<public>(Arr:[]t, N:int where t:type)<computes>:[]t =
        ActualN := Min(N, Arr.Length)
        for (I := 0..ActualN - 1, Element := Arr[I]):
            Element
    
    # 跳过前 N 个元素
    Skip<public>(Arr:[]t, N:int where t:type)<computes>:[]t =
        StartIdx := Min(N, Arr.Length)
        for (I := StartIdx..Arr.Length - 1, Element := Arr[I]):
            Element
    
    # ========== 数学函数 (float 数组) ==========
    
    # 求和 - 使用 transacts 效果因为使用了 var
    SumFloat<public>(Arr:[]float)<transacts>:float =
        var Total:float = 0.0
        for (Value : Arr):
            set Total += Value
        Total
