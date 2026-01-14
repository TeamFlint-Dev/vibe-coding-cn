# 经济交易系统模块
# 功能：交易税计算、物品价值评估

using { /Verse.org/Simulation }

EcoTrading<public> := module:
    
    MIN_TRADE_LEVEL<public>:int = 10
    TRADE_TAX_RATE<public>:float = 0.02
    
    CanTrade<public>(PlayerLevel:int)<decides><transacts>:void =
        PlayerLevel >= MIN_TRADE_LEVEL
    
    CalculateTradeTax<public>(TradeValue:float)<computes>:float =
        TradeValue * TRADE_TAX_RATE
    
    CalculateNetValue<public>(TradeValue:float)<computes>:float =
        Tax := CalculateTradeTax(TradeValue)
        TradeValue - Tax
