# 经济银行系统模块
# 功能：存款利息计算、仓库扩容费用计算

using { /Verse.org/Simulation }

EcoBanking<public> := module:
    
    DAILY_INTEREST_RATE<public>:float = 0.001
    WITHDRAWAL_FEE<public>:float = 0.01
    
    CalculateInterest<public>(Principal:float, Days:float)<computes>:float =
        Principal * DAILY_INTEREST_RATE * Days
    
    CalculateWithdrawalFee<public>(Amount:float)<computes>:float =
        Amount * WITHDRAWAL_FEE
    
    CalculateTotalWithInterest<public>(Principal:float, Days:float)<computes>:float =
        Interest := CalculateInterest(Principal, Days)
        Principal + Interest
