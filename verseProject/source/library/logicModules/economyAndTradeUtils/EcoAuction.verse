# 经济拍卖系统模块
# 功能：竞拍加价幅度规则、一口价判定

using { /Verse.org/Simulation }

EcoAuction<public> := module:
    
    MIN_BID_INCREMENT<public>:float = 1.0
    AUCTION_FEE_RATE<public>:float = 0.05
    
    CalculateMinimumBid<public>(CurrentBid:float)<computes>:float =
        CurrentBid + MIN_BID_INCREMENT
    
    CalculateAuctionFee<public>(FinalPrice:float)<computes>:float =
        FinalPrice * AUCTION_FEE_RATE
    
    IsValidBid<public>(NewBid:float, CurrentBid:float)<decides><transacts>:void =
        NewBid >= CalculateMinimumBid(CurrentBid)
