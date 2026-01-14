# 经济商店系统模块
# 功能：动态定价逻辑、折扣计算、限购检查

using { /Verse.org/Simulation }

EcoShop<public> := module:
    
    SELL_PRICE_RATIO<public>:float = 0.5
    VIP_DISCOUNT<public>:float = 0.1
    
    CalculateSellPrice<public>(BuyPrice:float)<computes>:float =
        BuyPrice * SELL_PRICE_RATIO
    
    ApplyDiscount<public>(BasePrice:float, DiscountPercent:float)<computes>:float =
        BasePrice * (1.0 - Clamp(DiscountPercent, 0.0, 1.0))
    
    CalculateVIPPrice<public>(BasePrice:float, VIPLevel:int)<computes>:float =
        VIPFloat := VIPLevel * 1.0
        TotalDiscount := Min(VIPFloat * VIP_DISCOUNT, 0.5)
        ApplyDiscount(BasePrice, TotalDiscount)
