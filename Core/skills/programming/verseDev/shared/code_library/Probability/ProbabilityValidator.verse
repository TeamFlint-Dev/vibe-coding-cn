# ProbabilityValidator - 概率验证器
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第五层：调试与分析层
#
# 功能: 验证概率系统的正确性和分布特征

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

ProbabilityValidator<public> := module:
    # ==========================================
    # 验证结果
    # ==========================================
    
    validation_result<public> := class:
        # 测试名称
        TestName<public>:string
        
        # 是否通过
        Passed<public>:logic
        
        # 期望值
        ExpectedValue<public>:float
        
        # 实际值
        ActualValue<public>:float
        
        # 偏差
        Deviation<public>:float
        
        # 偏差百分比
        DeviationPercent<public>:float
        
        # 测试次数
        SampleSize<public>:int
        
        # 详细信息
        Details<public>:string
    
    # ==========================================
    # 概率验证器
    # ==========================================
    
    probability_validator<public> := class:
        # 允许的偏差（百分比）
        TolerancePercent<public>:float = 5.0
        
        # 默认测试次数
        DefaultSampleSize<public>:int = 10000
        
        # 验证记录
        var ValidationResults<private>:[]validation_result = array{}
        
        # 验证简单概率
        ValidateSimpleProbability<public>(TestName:string, Probability:float, SampleSize:int)<transacts>:validation_result =
            var Successes:int = 0
            
            for (I := 0..SampleSize - 1):
                if (GetRandomFloat(0.0, 1.0) <= Probability):
                    set Successes += 1
            
            ActualRate := Successes / SampleSize
            Expected := Probability
            Deviation := ActualRate - Expected
            DeviationPct := if (Expected > 0.0):
                Abs(Deviation / Expected) * 100.0
            else:
                0.0
            
            Passed := DeviationPct <= TolerancePercent
            
            Result := validation_result{
                TestName := TestName,
                Passed := Passed,
                ExpectedValue := Expected,
                ActualValue := ActualRate,
                Deviation := Deviation,
                DeviationPercent := DeviationPct,
                SampleSize := SampleSize,
                Details := "Simple probability test"
            }
            
            set ValidationResults += array{Result}
            Result
        
        # 验证加权选择
        ValidateWeightedSelection<public>(TestName:string, Weights:[]float, SampleSize:int)<transacts>:validation_result =
            if (Weights.Length = 0):
                return validation_result{
                    TestName := TestName,
                    Passed := false,
                    ExpectedValue := 0.0,
                    ActualValue := 0.0,
                    Deviation := 0.0,
                    DeviationPercent := 0.0,
                    SampleSize := SampleSize,
                    Details := "Empty weights"
                }
            
            # 计算总权重和期望概率
            var TotalWeight:float = 0.0
            for (W : Weights):
                set TotalWeight += W
            
            # 统计每个选项的选择次数
            var Counts:[]int = array{}
            for (I := 0..Weights.Length - 1):
                set Counts += array{0}
            
            # 执行采样
            for (I := 0..SampleSize - 1):
                Roll := GetRandomFloat(0.0, TotalWeight)
                var CumulativeWeight:float = 0.0
                
                for (Index -> Weight : Weights):
                    set CumulativeWeight += Weight
                    if (Roll <= CumulativeWeight):
                        if (Count := Counts[Index]):
                            NewCounts := array:
                                for (Idx -> C : Counts):
                                    if (Idx = Index) then C + 1 else C
                            set Counts = NewCounts
                        break
            
            # 计算最大偏差
            var MaxDeviation:float = 0.0
            for (Index -> Weight : Weights):
                Expected := Weight / TotalWeight
                if (Count := Counts[Index]):
                    Actual := Count / SampleSize
                    Deviation := Abs(Actual - Expected)
                    if (Expected > 0.0):
                        DeviationPct := (Deviation / Expected) * 100.0
                        if (DeviationPct > MaxDeviation):
                            set MaxDeviation = DeviationPct
            
            Passed := MaxDeviation <= TolerancePercent
            
            Result := validation_result{
                TestName := TestName,
                Passed := Passed,
                ExpectedValue := 0.0,
                ActualValue := 0.0,
                Deviation := 0.0,
                DeviationPercent := MaxDeviation,
                SampleSize := SampleSize,
                Details := "Weighted selection test"
            }
            
            set ValidationResults += array{Result}
            Result
        
        # 验证均匀分布
        ValidateUniformDistribution<public>(TestName:string, MinVal:float, MaxVal:float, SampleSize:int)<transacts>:validation_result =
            var Sum:float = 0.0
            
            for (I := 0..SampleSize - 1):
                Value := GetRandomFloat(MinVal, MaxVal)
                set Sum += Value
            
            Average := Sum / SampleSize
            Expected := (MinVal + MaxVal) / 2.0
            Deviation := Average - Expected
            DeviationPct := if (Expected <> 0.0):
                Abs(Deviation / Expected) * 100.0
            else:
                Abs(Deviation) * 100.0
            
            Passed := DeviationPct <= TolerancePercent
            
            Result := validation_result{
                TestName := TestName,
                Passed := Passed,
                ExpectedValue := Expected,
                ActualValue := Average,
                Deviation := Deviation,
                DeviationPercent := DeviationPct,
                SampleSize := SampleSize,
                Details := "Uniform distribution test"
            }
            
            set ValidationResults += array{Result}
            Result
        
        # 获取所有验证结果
        GetValidationResults<public>():[]validation_result = ValidationResults
        
        # 获取通过的测试数
        GetPassedCount<public>():int =
            var Count:int = 0
            for (Result : ValidationResults):
                if (Result.Passed):
                    set Count += 1
            Count
        
        # 获取失败的测试数
        GetFailedCount<public>():int =
            var Count:int = 0
            for (Result : ValidationResults):
                if (not[Result.Passed]):
                    set Count += 1
            Count
        
        # 清除结果
        ClearResults<public>():void =
            set ValidationResults = array{}
    
    # 创建验证器
    CreateValidator<public>():probability_validator =
        probability_validator{}
    
    # ==========================================
    # 分布统计
    # ==========================================
    
    distribution_stats<public> := class:
        # 样本数据
        var Samples<private>:[]float = array{}
        
        # 最大样本数
        MaxSamples<public>:int = 100000
        
        # 添加样本
        AddSample<public>(Value:float):void =
            set Samples += array{Value}
            
            if (Samples.Length > MaxSamples):
                set Samples = Samples.Slice[1, Samples.Length]
        
        # 批量添加样本
        AddSamples<public>(Values:[]float):void =
            set Samples += Values
            
            if (Samples.Length > MaxSamples):
                set Samples = Samples.Slice[Samples.Length - MaxSamples, Samples.Length]
        
        # 计算均值
        GetMean<public>():float =
            if (Samples.Length = 0):
                return 0.0
            
            var Sum:float = 0.0
            for (Sample : Samples):
                set Sum += Sample
            
            Sum / Samples.Length
        
        # 计算最小值
        GetMin<public>():float =
            if (Samples.Length = 0):
                return 0.0
            
            var MinVal:float = Samples[0]
            for (Sample : Samples):
                if (Sample < MinVal):
                    set MinVal = Sample
            
            MinVal
        
        # 计算最大值
        GetMax<public>():float =
            if (Samples.Length = 0):
                return 0.0
            
            var MaxVal:float = Samples[0]
            for (Sample : Samples):
                if (Sample > MaxVal):
                    set MaxVal = Sample
            
            MaxVal
        
        # 计算方差
        GetVariance<public>():float =
            if (Samples.Length <= 1):
                return 0.0
            
            Mean := GetMean()
            var SumSquaredDiff:float = 0.0
            
            for (Sample : Samples):
                Diff := Sample - Mean
                set SumSquaredDiff += Diff * Diff
            
            SumSquaredDiff / Samples.Length
        
        # 计算标准差
        GetStandardDeviation<public>():float =
            Sqrt(GetVariance())
        
        # 获取样本数
        GetSampleCount<public>():int = Samples.Length
        
        # 清除样本
        Clear<public>():void =
            set Samples = array{}
    
    # 创建分布统计器
    CreateDistributionStats<public>():distribution_stats =
        distribution_stats{}
    
    # ==========================================
    # 卡方检验（简化版）
    # ==========================================
    
    # 执行卡方检验
    ChiSquareTest<public>(Observed:[]int, Expected:[]float):float =
        if (Observed.Length <> Expected.Length):
            return -1.0
        
        var ChiSquare:float = 0.0
        
        for (I := 0..Observed.Length - 1):
            if (Obs := Observed[I], Exp := Expected[I]):
                if (Exp > 0.0):
                    Diff := Obs - Exp
                    set ChiSquare += (Diff * Diff) / Exp
        
        ChiSquare
    
    # ==========================================
    # 频率分析
    # ==========================================
    
    frequency_analyzer<public> := class:
        # 频率表（整数值 -> 出现次数）
        var FrequencyTable<private>:[]int = array{}
        
        # 值域范围
        MinValue<public>:int = 0
        MaxValue<public>:int = 100
        
        # 初始化频率表
        Initialize<public>():void =
            Range := MaxValue - MinValue + 1
            set FrequencyTable = array{}
            for (I := 0..Range - 1):
                set FrequencyTable += array{0}
        
        # 记录值
        Record<public>(Value:int):void =
            if (Value >= MinValue, Value <= MaxValue):
                Index := Value - MinValue
                if (Count := FrequencyTable[Index]):
                    NewTable := array:
                        for (I -> C : FrequencyTable):
                            if (I = Index) then C + 1 else C
                    set FrequencyTable = NewTable
        
        # 获取频率
        GetFrequency<public>(Value:int):int =
            if (Value >= MinValue, Value <= MaxValue):
                Index := Value - MinValue
                if (Count := FrequencyTable[Index]):
                    Count
                else:
                    0
            else:
                0
        
        # 获取最常见的值
        GetMostFrequent<public>():int =
            var MaxCount:int = 0
            var MaxIndex:int = 0
            
            for (Index -> Count : FrequencyTable):
                if (Count > MaxCount):
                    set MaxCount = Count
                    set MaxIndex = Index
            
            MinValue + MaxIndex
        
        # 清除
        Clear<public>():void =
            Initialize()
    
    # 创建频率分析器
    CreateFrequencyAnalyzer<public>(MinVal:int, MaxVal:int):frequency_analyzer =
        Analyzer := frequency_analyzer{
            MinValue := MinVal,
            MaxValue := MaxVal
        }
        Analyzer.Initialize()
        Analyzer
