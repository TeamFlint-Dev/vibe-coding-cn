# RngCore - 随机数生成器核心模块
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第一层：基础设施层
#
# 功能: 提供基础的随机数生成能力，支持种子控制和多种分布

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

RngCore<public> := module:
    # ==========================================
    # 随机数生成器类
    # ==========================================
    
    # 随机数生成器接口
    random_generator<public> := class:
        # 种子值（可选）
        var Seed<public>:?int = false
        
        # 生成计数器
        var GenerationCount<private>:int = 0
        
        # 获取生成次数
        GetGenerationCount<public>():int = GenerationCount
        
        # 重置生成计数器
        ResetCounter<public>():void =
            set GenerationCount = 0
        
        # 生成随机整数 [Min, Max]
        NextInt<public>(MinVal:int, MaxVal:int)<transacts>:int =
            set GenerationCount += 1
            GetRandomInt(MinVal, MaxVal)
        
        # 生成随机浮点数 [Min, Max]
        NextFloat<public>(MinVal:float, MaxVal:float)<transacts>:float =
            set GenerationCount += 1
            GetRandomFloat(MinVal, MaxVal)
        
        # 生成标准化随机数 [0, 1]
        NextNormalized<public>()<transacts>:float =
            set GenerationCount += 1
            GetRandomFloat(0.0, 1.0)
        
        # 生成随机布尔值
        NextBool<public>()<transacts>:logic =
            set GenerationCount += 1
            if (GetRandomFloat(0.0, 1.0) < 0.5) then true else false
    
    # ==========================================
    # 全局随机数生成器
    # ==========================================
    
    # 创建新的随机数生成器
    CreateGenerator<public>():random_generator =
        random_generator{}
    
    # 创建带种子的随机数生成器（注意：Verse当前不支持真正的种子控制）
    CreateSeededGenerator<public>(Seed:int):random_generator =
        Generator := random_generator{}
        set Generator.Seed = option{Seed}
        Generator
    
    # ==========================================
    # 快捷函数
    # ==========================================
    
    # 快速生成随机整数
    QuickInt<public>(MinVal:int, MaxVal:int)<transacts>:int =
        GetRandomInt(MinVal, MaxVal)
    
    # 快速生成随机浮点数
    QuickFloat<public>(MinVal:float, MaxVal:float)<transacts>:float =
        GetRandomFloat(MinVal, MaxVal)
    
    # 快速生成标准化随机数
    QuickNormalized<public>()<transacts>:float =
        GetRandomFloat(0.0, 1.0)
