# 经济交易系统模块
# 功能：交易税计算、物品价值评估

using { /Verse.org/Simulation }

EcoTrading<public> := module:
    
    # ========== 数据结构 ==========
    
    # 交易信息
    trade_info<public> := struct<computes>:
        TradeID<public>:int = 0
        PlayerAOffered<public>:int = 0          # 玩家A提供的总价值
        PlayerBOffered<public>:int = 0          # 玩家B提供的总价值
        TradeTax<public>:int = 0                # 交易税
        IsFair<public>:logic = false            # 是否公平交易
    
    # ========== 常量定义 ==========
    
    # 交易税率
    TRADE_TAX_RATE<public>:float = 0.05         # 5%交易税
    MIN_TRADE_TAX<public>:int = 1
    
    # 公平交易阈值
    FAIR_TRADE_THRESHOLD<public>:float = 0.2    # 价值差距20%内算公平
    
    # ========== 交易税计算 ==========
    
    # 计算交易税
    CalculateTradeTax<public>(TradeValue:int)<computes>:int =
        Tax := Floor(TradeValue) * TRADE_TAX_RATE
        Max(Floor(Tax), MIN_TRADE_TAX)
    
    # 计算双方交易税（基于较高价值）
    CalculateBilateralTradeTax<public>(ValueA:int, ValueB:int)<computes>:int =
        HigherValue := if (ValueA > ValueB) then ValueA else ValueB
        CalculateTradeTax(HigherValue)
    
    # ========== 公平性验证 ==========
    
    # 检查交易是否公平
    CheckTradeFairness<public>(ValueA:int, ValueB:int)<decides><transacts>:void =
        if (ValueA <= 0 and ValueB <= 0):
            false
        else:
            HigherValue := if (ValueA > ValueB) then Floor(ValueA) else Floor(ValueB)
            LowerValue := if (ValueA > ValueB) then Floor(ValueB) else Floor(ValueA)
            
            if (HigherValue = 0):
                false
            else:
                Ratio := LowerValue / HigherValue
                Ratio >= (1.0 - FAIR_TRADE_THRESHOLD)
    
    # 计算价值差距百分比
    CalculateValueGap<public>(ValueA:int, ValueB:int)<computes>:float =
        HigherValue := if (ValueA > ValueB) then Floor(ValueA) else Floor(ValueB)
        LowerValue := if (ValueA > ValueB) then Floor(ValueB) else Floor(ValueA)
        
        if (HigherValue <= 0):
            0.0
        else:
            Gap := HigherValue - LowerValue
            Floor(Gap) / Floor(HigherValue)
    
    # ========== 交易验证 ==========
    
    # 验证交易有效性
    ValidateTrade<public>(ValueA:int, ValueB:int, PlayerAGold:int)<decides><transacts>:void =
        # 至少一方提供了物品/金币
        HasOffer := ValueA > 0 or ValueB > 0
        # 玩家A有足够金币支付税
        Tax := CalculateBilateralTradeTax(ValueA, ValueB)
        CanPayTax := PlayerAGold >= Tax
        
        if (HasOffer and CanPayTax) then true else false
    
    # ========== 工具函数 ==========
    
    # 创建交易信息
    MakeTradeInfo<public>(TradeID:int, ValueA:int, ValueB:int)<transacts>:trade_info =
        Tax := CalculateBilateralTradeTax(ValueA, ValueB)
        IsFair := if (CheckTradeFairness[ValueA, ValueB]) then true else false
        
        trade_info{
            TradeID := TradeID
            PlayerAOffered := ValueA
            PlayerBOffered := ValueB
            TradeTax := Tax
            IsFair := IsFair
        }
