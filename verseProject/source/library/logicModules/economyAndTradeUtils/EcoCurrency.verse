# 经济货币系统模块
# 功能：多货币汇率转换、大数值格式化 (1k, 1m)

using { /Verse.org/Simulation }

EcoCurrency<public> := module:
    
    GOLD_TO_SILVER_RATE<public>:float = 100.0
    SILVER_TO_COPPER_RATE<public>:float = 100.0
    
    ConvertGoldToSilver<public>(Gold:float)<computes>:float =
        Gold * GOLD_TO_SILVER_RATE
    
    ConvertSilverToGold<public>(Silver:float)<computes>:float =
        Silver / GOLD_TO_SILVER_RATE
    
    ConvertSilverToCopper<public>(Silver:float)<computes>:float =
        Silver * SILVER_TO_COPPER_RATE
    
    ConvertCopperToSilver<public>(Copper:float)<computes>:float =
        Copper / SILVER_TO_COPPER_RATE
