# DistributionVisualizer - 分布可视化
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第五层：调试与分析层
#
# 功能: 生成分布数据的文本可视化（用于调试输出）
# 注意: UEFN不支持图形界面，此模块提供ASCII图表和统计摘要

using { /Verse.org/Simulation }
using { /Verse.org/Verse }

DistributionVisualizer<public> := module:
    # ==========================================
    # 直方图生成器
    # ==========================================
    
    histogram<public> := class:
        # 数据桶
        var Buckets<private>:[]int = array{}
        
        # 桶的数量
        BucketCount<public>:int = 10
        
        # 数据范围
        MinValue<public>:float = 0.0
        MaxValue<public>:float = 100.0
        
        # 桶宽度
        var BucketWidth<private>:float = 10.0
        
        # 总样本数
        var TotalSamples<private>:int = 0
        
        # 初始化
        Initialize<public>():void =
            set BucketWidth = (MaxValue - MinValue) / BucketCount
            set Buckets = array{}
            for (I := 0..BucketCount - 1):
                set Buckets += array{0}
            set TotalSamples = 0
        
        # 添加数据点
        AddValue<public>(Value:float):void =
            if (Value >= MinValue, Value <= MaxValue):
                # 计算桶索引
                NormalizedValue := (Value - MinValue) / (MaxValue - MinValue)
                Index := Floor(NormalizedValue * BucketCount)
                
                # 边界情况：最大值应该放在最后一个桶
                if (Index >= BucketCount):
                    set Index = BucketCount - 1
                
                # 更新桶计数
                if (Count := Buckets[Index]):
                    NewBuckets := array:
                        for (I -> C : Buckets):
                            if (I = Index) then C + 1 else C
                    set Buckets = NewBuckets
                
                set TotalSamples += 1
        
        # 批量添加
        AddValues<public>(Values:[]float):void =
            for (Value : Values):
                AddValue(Value)
        
        # 获取桶计数
        GetBucketCount<public>(BucketIndex:int):int =
            if (BucketIndex >= 0, BucketIndex < Buckets.Length):
                if (Count := Buckets[BucketIndex]):
                    Count
                else:
                    0
            else:
                0
        
        # 获取桶范围
        GetBucketRange<public>(BucketIndex:int):(float, float) =
            if (BucketIndex >= 0, BucketIndex < BucketCount):
                Start := MinValue + (BucketIndex * BucketWidth)
                End := Start + BucketWidth
                (Start, End)
            else:
                (0.0, 0.0)
        
        # 获取最大桶计数（用于归一化）
        GetMaxBucketCount<public>():int =
            var MaxCount:int = 0
            for (Count : Buckets):
                if (Count > MaxCount):
                    set MaxCount = Count
            MaxCount
        
        # 清除数据
        Clear<public>():void =
            Initialize()
        
        # 获取总样本数
        GetTotalSamples<public>():int = TotalSamples
    
    # 创建直方图
    CreateHistogram<public>(BucketCount:int, MinVal:float, MaxVal:float):histogram =
        Hist := histogram{
            BucketCount := BucketCount,
            MinValue := MinVal,
            MaxValue := MaxVal
        }
        Hist.Initialize()
        Hist
    
    # ==========================================
    # 摘要统计
    # ==========================================
    
    summary_stats<public> := class:
        # 数据名称
        Name<public>:string
        
        # 统计数据
        Count<public>:int = 0
        Mean<public>:float = 0.0
        MinValue<public>:float = 0.0
        MaxValue<public>:float = 0.0
        StdDev<public>:float = 0.0
        
        # 百分位数（如果计算了）
        P25<public>:float = 0.0
        P50<public>:float = 0.0
        P75<public>:float = 0.0
    
    # 计算摘要统计
    CalculateSummary<public>(Name:string, Data:[]float):summary_stats =
        if (Data.Length = 0):
            return summary_stats{Name := Name}
        
        # 计算基础统计
        var Sum:float = 0.0
        var MinVal:float = Data[0]
        var MaxVal:float = Data[0]
        
        for (Value : Data):
            set Sum += Value
            if (Value < MinVal):
                set MinVal = Value
            if (Value > MaxVal):
                set MaxVal = Value
        
        Mean := Sum / Data.Length
        
        # 计算标准差
        var SumSquaredDiff:float = 0.0
        for (Value : Data):
            Diff := Value - Mean
            set SumSquaredDiff += Diff * Diff
        
        Variance := SumSquaredDiff / Data.Length
        StdDev := Sqrt(Variance)
        
        summary_stats{
            Name := Name,
            Count := Data.Length,
            Mean := Mean,
            MinValue := MinVal,
            MaxValue := MaxVal,
            StdDev := StdDev
        }
    
    # ==========================================
    # 分桶分析
    # ==========================================
    
    bucket_analyzer<public> := class:
        # 桶定义（范围边界）
        var BucketBoundaries<private>:[]float = array{}
        
        # 桶计数
        var BucketCounts<private>:[]int = array{}
        
        # 桶标签
        var BucketLabels<private>:[]string = array{}
        
        # 添加桶
        AddBucket<public>(LowerBound:float, UpperBound:float, Label:string):void =
            set BucketBoundaries += array{LowerBound, UpperBound}
            set BucketCounts += array{0}
            set BucketLabels += array{Label}
        
        # 分类值
        Classify<public>(Value:float):void =
            var BucketIndex:int = -1
            
            # 找到合适的桶
            for (I := 0..BucketLabels.Length - 1):
                if (LowerBound := BucketBoundaries[I * 2], UpperBound := BucketBoundaries[I * 2 + 1]):
                    if (Value >= LowerBound, Value < UpperBound):
                        set BucketIndex = I
                        break
            
            # 更新计数
            if (BucketIndex >= 0, BucketIndex < BucketCounts.Length):
                if (Count := BucketCounts[BucketIndex]):
                    NewCounts := array:
                        for (I -> C : BucketCounts):
                            if (I = BucketIndex) then C + 1 else C
                    set BucketCounts = NewCounts
        
        # 获取桶计数
        GetBucketCount<public>(BucketIndex:int):int =
            if (BucketIndex >= 0, BucketIndex < BucketCounts.Length):
                if (Count := BucketCounts[BucketIndex]):
                    Count
                else:
                    0
            else:
                0
        
        # 获取桶标签
        GetBucketLabel<public>(BucketIndex:int):string =
            if (BucketIndex >= 0, BucketIndex < BucketLabels.Length):
                if (Label := BucketLabels[BucketIndex]):
                    Label
                else:
                    ""
            else:
                ""
        
        # 获取桶数量
        GetBucketCount<public>():int = BucketLabels.Length
        
        # 清除
        Clear<public>():void =
            # 重置计数
            set BucketCounts = array{}
            for (I := 0..BucketLabels.Length - 1):
                set BucketCounts += array{0}
    
    # 创建桶分析器
    CreateBucketAnalyzer<public>():bucket_analyzer =
        bucket_analyzer{}
    
    # ==========================================
    # 时间序列跟踪
    # ==========================================
    
    time_series<public> := class:
        # 数据点（时间 -> 值）
        var TimeStamps<private>:[]float = array{}
        var Values<private>:[]float = array{}
        
        # 最大数据点数
        MaxDataPoints<public>:int = 1000
        
        # 添加数据点
        AddDataPoint<public>(Time:float, Value:float):void =
            set TimeStamps += array{Time}
            set Values += array{Value}
            
            # 限制大小
            if (TimeStamps.Length > MaxDataPoints):
                set TimeStamps = TimeStamps.Slice[1, TimeStamps.Length]
                set Values = Values.Slice[1, Values.Length]
        
        # 获取数据点数量
        GetDataPointCount<public>():int = Values.Length
        
        # 获取值（按索引）
        GetValue<public>(Index:int):?float =
            if (Index >= 0, Index < Values.Length):
                if (Value := Values[Index]):
                    option{Value}
                else:
                    false
            else:
                false
        
        # 获取时间戳（按索引）
        GetTimeStamp<public>(Index:int):?float =
            if (Index >= 0, Index < TimeStamps.Length):
                if (Time := TimeStamps[Index]):
                    option{Time}
                else:
                    false
            else:
                false
        
        # 计算移动平均
        GetMovingAverage<public>(WindowSize:int):[]float =
            var Averages:[]float = array{}
            
            if (WindowSize <= 0 or WindowSize > Values.Length):
                return Averages
            
            for (I := WindowSize - 1..Values.Length - 1):
                var Sum:float = 0.0
                for (J := I - WindowSize + 1..I):
                    if (Value := Values[J]):
                        set Sum += Value
                
                Average := Sum / WindowSize
                set Averages += array{Average}
            
            Averages
        
        # 清除数据
        Clear<public>():void =
            set TimeStamps = array{}
            set Values = array{}
    
    # 创建时间序列
    CreateTimeSeries<public>(MaxPoints:int):time_series =
        time_series{MaxDataPoints := MaxPoints}
    
    # ==========================================
    # 比较分析
    # ==========================================
    
    # 比较两组数据
    CompareDistributions<public>(Data1:[]float, Data2:[]float):summary_stats =
        # 计算差异统计
        var Differences:[]float = array{}
        
        MinLength := if (Data1.Length < Data2.Length) then Data1.Length else Data2.Length
        
        for (I := 0..MinLength - 1):
            if (Val1 := Data1[I], Val2 := Data2[I]):
                Diff := Val1 - Val2
                set Differences += array{Diff}
        
        CalculateSummary("Difference", Differences)
    
    # ==========================================
    # 累积分布
    # ==========================================
    
    cumulative_distribution<public> := class:
        # 累积数据
        var CumulativeData<private>:[]float = array{}
        
        # 原始数据（排序后）
        var SortedData<private>:[]float = array{}
        
        # 构建累积分布
        Build<public>(Data:[]float):void =
            # 简化：假设数据已排序或使用原始顺序
            set SortedData = Data
            
            set CumulativeData = array{}
            var Cumulative:float = 0.0
            
            for (Value : Data):
                set Cumulative += Value
                set CumulativeData += array{Cumulative}
        
        # 获取累积值
        GetCumulativeValue<public>(Index:int):?float =
            if (Index >= 0, Index < CumulativeData.Length):
                if (Value := CumulativeData[Index]):
                    option{Value}
                else:
                    false
            else:
                false
        
        # 获取数据点数
        GetDataPointCount<public>():int = CumulativeData.Length
    
    # 创建累积分布
    CreateCumulativeDistribution<public>(Data:[]float):cumulative_distribution =
        CDF := cumulative_distribution{}
        CDF.Build(Data)
        CDF
