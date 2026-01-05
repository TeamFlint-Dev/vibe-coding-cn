# Distribution - 随机分布函数
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第一层：基础设施层
#
# 功能: 实现多种概率分布函数

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/SpatialMath }

Distribution<public> := module:
    # ==========================================
    # 基础分布函数
    # ==========================================
    
    # 均匀分布 [Min, Max]
    UniformFloat<public>(MinVal:float, MaxVal:float)<transacts>:float =
        GetRandomFloat(MinVal, MaxVal)
    
    # 均匀整数分布 [Min, Max]
    UniformInt<public>(MinVal:int, MaxVal:int)<transacts>:int =
        GetRandomInt(MinVal, MaxVal)
    
    # ==========================================
    # 正态分布（高斯分布）
    # ==========================================
    
    # Box-Muller变换实现正态分布
    # Mean: 均值, StdDev: 标准差
    Normal<public>(Mean:float, StdDev:float)<transacts>:float =
        U1 := GetRandomFloat(0.0001, 1.0)  # 避免log(0)
        U2 := GetRandomFloat(0.0, 1.0)
        
        # Box-Muller变换
        Z := Sqrt(-2.0 * Log(U1)) * Cos(2.0 * 3.14159265359 * U2)
        Mean + Z * StdDev
    
    # 标准正态分布（均值0，标准差1）
    StandardNormal<public>()<transacts>:float =
        Normal(0.0, 1.0)
    
    # ==========================================
    # 三角分布
    # ==========================================
    
    # 三角分布 [Min, Max, Mode]
    # Mode: 众数（最可能出现的值）
    Triangular<public>(MinVal:float, MaxVal:float, Mode:float)<transacts>:float =
        U := GetRandomFloat(0.0, 1.0)
        F := (Mode - MinVal) / (MaxVal - MinVal)
        
        if (U < F):
            MinVal + Sqrt(U * (MaxVal - MinVal) * (Mode - MinVal))
        else:
            MaxVal - Sqrt((1.0 - U) * (MaxVal - MinVal) * (MaxVal - Mode))
    
    # ==========================================
    # 指数分布
    # ==========================================
    
    # 指数分布
    # Lambda: 速率参数（λ > 0）
    Exponential<public>(Lambda:float)<transacts>:float =
        U := GetRandomFloat(0.0001, 1.0)  # 避免log(0)
        -Log(U) / Lambda
    
    # ==========================================
    # 伽马分布（简化版）
    # ==========================================
    
    # 伽马分布（使用整数形状参数的特殊情况）
    # Shape: 形状参数, Scale: 尺度参数
    Gamma<public>(Shape:int, Scale:float)<transacts>:float =
        var Sum:float = 0.0
        for (I := 0..Shape - 1):
            U := GetRandomFloat(0.0001, 1.0)
            set Sum += -Log(U)
        Sum * Scale
    
    # ==========================================
    # 贝塔分布（简化版）
    # ==========================================
    
    # 贝塔分布（使用整数参数）
    # Alpha, Beta: 形状参数
    Beta<public>(Alpha:int, Beta:int)<transacts>:float =
        X := Gamma(Alpha, 1.0)
        Y := Gamma(Beta, 1.0)
        X / (X + Y)
    
    # ==========================================
    # 泊松分布（离散）
    # ==========================================
    
    # 泊松分布
    # Lambda: 平均发生率
    Poisson<public>(Lambda:float)<transacts>:int =
        L := Exp(-Lambda)
        var K:int = 0
        var P:float = 1.0
        
        loop:
            set K += 1
            U := GetRandomFloat(0.0, 1.0)
            set P *= U
            if (P > L):
                # 继续循环
                true
            else:
                # 退出循环
                break
        
        K - 1
    
    # ==========================================
    # 几何分布
    # ==========================================
    
    # 几何分布（首次成功需要的试验次数）
    # P: 成功概率 (0 < P <= 1)
    Geometric<public>(P:float)<transacts>:int =
        U := GetRandomFloat(0.0001, 1.0)
        Floor(Log(U) / Log(1.0 - P)) + 1
    
    # ==========================================
    # 二项分布
    # ==========================================
    
    # 二项分布（N次试验中成功的次数）
    # N: 试验次数, P: 单次成功概率
    Binomial<public>(N:int, P:float)<transacts>:int =
        var Successes:int = 0
        for (I := 0..N - 1):
            if (GetRandomFloat(0.0, 1.0) < P):
                set Successes += 1
        Successes
    
    # ==========================================
    # 帕累托分布（幂律分布）
    # ==========================================
    
    # 帕累托分布（80/20法则）
    # Scale: 尺度参数, Alpha: 形状参数
    Pareto<public>(Scale:float, Alpha:float)<transacts>:float =
        U := GetRandomFloat(0.0001, 1.0)
        Scale / Pow(U, 1.0 / Alpha)
    
    # ==========================================
    # 对数正态分布
    # ==========================================
    
    # 对数正态分布
    # Mu: 对数均值, Sigma: 对数标准差
    LogNormal<public>(Mu:float, Sigma:float)<transacts>:float =
        Z := Normal(0.0, 1.0)
        Exp(Mu + Sigma * Z)
    
    # ==========================================
    # 柯西分布
    # ==========================================
    
    # 柯西分布（重尾分布）
    # Location: 位置参数, Scale: 尺度参数
    Cauchy<public>(Location:float, Scale:float)<transacts>:float =
        U := GetRandomFloat(0.0001, 0.9999)
        Location + Scale * Tan(3.14159265359 * (U - 0.5))
    
    # ==========================================
    # 韦布尔分布
    # ==========================================
    
    # 韦布尔分布（可靠性分析）
    # Lambda: 尺度参数, K: 形状参数
    Weibull<public>(Lambda:float, K:float)<transacts>:float =
        U := GetRandomFloat(0.0001, 1.0)
        Lambda * Pow(-Log(U), 1.0 / K)
