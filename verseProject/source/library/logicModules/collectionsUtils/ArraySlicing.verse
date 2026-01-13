# 数组切片与分块模块
# 功能：数组子集操作 - Slice, Take, Drop, Split, Chunk, Window
# 架构：Logic 层 - 纯函数，无状态
# 应用场景：分页、批处理、滑动窗口分析

using { /Verse.org/Verse }

ArraySlicing<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 基础切片操作
    # ═══════════════════════════════════════════════════════════
    
    # 切片 - 提取数组的子集 [Start, End)
    # @param Arr: 源数组
    # @param StartIndex: 起始索引（包含）
    # @param EndIndex: 结束索引（不包含）
    # @returns: 子数组
    # 
    # 使用场景：
    # - 分页显示
    # - 提取特定范围数据
    # - 数组分段处理
    # 
    # 注意：
    # - StartIndex < 0 从数组末尾计数
    # - EndIndex 超出范围自动截断到数组长度
    Slice<public>(Arr:[]t, StartIndex:int, EndIndex:int where t:type)<computes>:[]t =
        ArrayLength := Arr.Length
        
        # 处理负数索引
        ActualStart := if (StartIndex < 0):
            if (ArrayLength + StartIndex > 0):
                ArrayLength + StartIndex
            else:
                0
        else:
            if (StartIndex < ArrayLength):
                StartIndex
            else:
                ArrayLength
        
        ActualEnd := if (EndIndex < 0):
            if (ArrayLength + EndIndex > 0):
                ArrayLength + EndIndex
            else:
                0
        else:
            if (EndIndex < ArrayLength):
                EndIndex
            else:
                ArrayLength
        
        # 确保 Start <= End
        if (ActualStart >= ActualEnd):
            array{}  # 返回空数组
        else:
            SliceRecursive(Arr, ActualStart, ActualEnd, 0, array{})
    
    # 切片的递归实现
    SliceRecursive(Arr:[]t, StartVal:int, EndVal:int, CurrentIndex:int, Acc:[]t where t:type)<computes>:[]t =
        if (CurrentIndex >= EndVal):
            Acc
        else if (CurrentIndex < StartVal):
            SliceRecursive(Arr, StartVal, EndVal, CurrentIndex + 1, Acc)
        else:
            if (Element := Arr[CurrentIndex]):
                SliceRecursive(Arr, StartVal, EndVal, CurrentIndex + 1, Acc + array{Element})
            else:
                # 索引越界，停止
                Acc
    
    # 取前 N 个元素
    # @param Arr: 源数组
    # @param Count: 要取的元素数量
    # @returns: 前 Count 个元素
    # 
    # 使用场景：
    # - 显示排行榜前10名
    # - 提取最新的N条消息
    Take<public>(Arr:[]t, Count:int where t:type)<computes>:[]t =
        if (Count <= 0):
            array{}
        else:
            Slice(Arr, 0, Count)
    
    # 跳过前 N 个元素
    # @param Arr: 源数组
    # @param Count: 要跳过的元素数量
    # @returns: 剩余元素
    # 
    # 使用场景：
    # - 分页跳过前面的页
    # - 忽略初始数据
    Drop<public>(Arr:[]t, Count:int where t:type)<computes>:[]t =
        if (Count <= 0):
            Arr
        else:
            Slice(Arr, Count, Arr.Length)
    
    # ═══════════════════════════════════════════════════════════
    # 分割操作
    # ═══════════════════════════════════════════════════════════
    
    # 在指定索引处分割数组
    # @param Arr: 源数组
    # @param Index: 分割点索引
    # @returns: (左半部分, 右半部分)
    # 
    # 使用场景：
    # - 二分查找后分割
    # - 快速排序分区
    # 
    # 注意：左半部分包含索引位置的元素，右半部分不包含
    SplitAt<public>(Arr:[]t, Index:int where t:type)<computes>:tuple([]t, []t) =
        LeftPart := Slice(Arr, 0, Index)
        RightPart := Slice(Arr, Index, Arr.Length)
        (LeftPart, RightPart)
    
    # 将数组分成两半
    # @param Arr: 源数组
    # @returns: (前半部分, 后半部分)
    # 
    # 使用场景：
    # - 归并排序
    # - 分治算法
    SplitHalf<public>(Arr:[]t where t:type)<transacts><decides>:tuple([]t, []t) =
        MidIndex := Floor[Arr.Length * 0.5]
        SplitAt(Arr, MidIndex)
    
    # ═══════════════════════════════════════════════════════════
    # 分块操作
    # ═══════════════════════════════════════════════════════════
    
    # 将数组分成固定大小的块
    # @param Arr: 源数组
    # @param ChunkSize: 每块的大小
    # @returns: 块数组
    # 
    # 使用场景：
    # - 批量处理数据
    # - 网格布局
    # - 分批加载
    # 
    # 注意：最后一块可能小于 ChunkSize
    Chunk<public>(Arr:[]t, ChunkSize:int where t:type)<computes>:[][]t =
        if (ChunkSize <= 0 or Arr.Length = 0):
            array{}
        else:
            ChunkRecursive(Arr, ChunkSize, 0, array{})
    
    # 分块的递归实现
    ChunkRecursive(Arr:[]t, ChunkSize:int, StartIndex:int, Acc:[][]t where t:type)<computes>:[][]t =
        if (StartIndex >= Arr.Length):
            Acc
        else:
            EndIndex := if (StartIndex + ChunkSize < Arr.Length):
                StartIndex + ChunkSize
            else:
                Arr.Length
            CurrentChunk := Slice(Arr, StartIndex, EndIndex)
            ChunkRecursive(Arr, ChunkSize, EndIndex, Acc + array{CurrentChunk})
    
    # ═══════════════════════════════════════════════════════════
    # 滑动窗口
    # ═══════════════════════════════════════════════════════════
    
    # 创建滑动窗口视图
    # @param Arr: 源数组
    # @param WindowSize: 窗口大小
    # @returns: 所有窗口的数组
    # 
    # 使用场景：
    # - 移动平均计算
    # - 局部特征提取
    # - 序列分析
    # 
    # 示例：Window([1,2,3,4,5], 3) = [[1,2,3], [2,3,4], [3,4,5]]
    Window<public>(Arr:[]t, WindowSize:int where t:type)<computes>:[][]t =
        if (WindowSize <= 0 or WindowSize > Arr.Length):
            array{}
        else:
            WindowRecursive(Arr, WindowSize, 0, array{})
    
    # 滑动窗口的递归实现
    WindowRecursive(Arr:[]t, WindowSize:int, StartIndex:int, Acc:[][]t where t:type)<computes>:[][]t =
        EndIndex := StartIndex + WindowSize
        if (EndIndex > Arr.Length):
            Acc
        else:
            CurrentWindow := Slice(Arr, StartIndex, EndIndex)
            WindowRecursive(Arr, WindowSize, StartIndex + 1, Acc + array{CurrentWindow})
    
    # 创建重叠窗口（指定步长）
    # @param Arr: 源数组
    # @param WindowSize: 窗口大小
    # @param StepSize: 步长
    # @returns: 所有窗口的数组
    # 
    # 使用场景：
    # - 降采样
    # - 跳跃式扫描
    # 
    # 示例：WindowWithStep([1,2,3,4,5,6], 3, 2) = [[1,2,3], [3,4,5]]
    WindowWithStep<public>(Arr:[]t, WindowSize:int, StepSize:int where t:type)<computes>:[][]t =
        if (WindowSize <= 0 or StepSize <= 0 or WindowSize > Arr.Length):
            array{}
        else:
            WindowStepRecursive(Arr, WindowSize, StepSize, 0, array{})
    
    # 带步长窗口的递归实现
    WindowStepRecursive(Arr:[]t, WindowSize:int, StepSize:int, StartIndex:int, Acc:[][]t where t:type)<computes>:[][]t =
        EndIndex := StartIndex + WindowSize
        if (EndIndex > Arr.Length):
            Acc
        else:
            CurrentWindow := Slice(Arr, StartIndex, EndIndex)
            WindowStepRecursive(Arr, WindowSize, StepSize, StartIndex + StepSize, Acc + array{CurrentWindow})
    
    # ═══════════════════════════════════════════════════════════
    # 实用工具
    # ═══════════════════════════════════════════════════════════
    
    # 获取数组的第一个元素
    # @param Arr: 源数组
    # @returns: 第一个元素（如果存在）
    First<public>(Arr:[]t where t:type)<transacts><decides>:t =
        Arr[0]
    
    # 获取数组的最后一个元素
    # @param Arr: 源数组
    # @returns: 最后一个元素（如果存在）
    Last<public>(Arr:[]t where t:type)<transacts><decides>:t =
        Arr[Arr.Length - 1]
    
    # 获取数组除了第一个元素外的所有元素
    # @param Arr: 源数组
    # @returns: 尾部数组
    # 
    # 使用场景：
    # - 递归列表处理
    # - 跳过标题行
    Tail<public>(Arr:[]t where t:type)<computes>:[]t =
        Drop(Arr, 1)
    
    # 获取数组除了最后一个元素外的所有元素
    # @param Arr: 源数组
    # @returns: 初始数组
    Init<public>(Arr:[]t where t:type)<computes>:[]t =
        if (Arr.Length <= 1):
            array{}
        else:
            Slice(Arr, 0, Arr.Length - 1)
    
    # 反转数组
    # @param Arr: 源数组
    # @returns: 反转后的数组
    # 
    # 使用场景：
    # - 倒序显示
    # - 从后向前处理
    Reverse<public>(Arr:[]t where t:type)<computes>:[]t =
        ReverseRecursive(Arr, Arr.Length - 1, array{})
    
    # 反转的递归实现
    ReverseRecursive(Arr:[]t, Index:int, Acc:[]t where t:type)<computes>:[]t =
        if (Index < 0):
            Acc
        else:
            if (Element := Arr[Index]):
                ReverseRecursive(Arr, Index - 1, Acc + array{Element})
            else:
                Acc
    
    # 分页获取
    # @param Arr: 源数组
    # @param PageNumber: 页码（从0开始）
    # @param PageSize: 每页大小
    # @returns: 指定页的数据
    # 
    # 使用场景：
    # - UI分页显示
    # - 数据分批加载
    Paginate<public>(Arr:[]t, PageNumber:int, PageSize:int where t:type)<computes>:[]t =
        if (PageNumber < 0 or PageSize <= 0):
            array{}
        else:
            StartIndex := PageNumber * PageSize
            EndIndex := StartIndex + PageSize
            Slice(Arr, StartIndex, EndIndex)
