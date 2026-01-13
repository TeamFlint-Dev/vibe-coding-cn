# 经济银行系统模块
# 功能：存款利息计算、仓库扩容费用计算

using { /Verse.org/Simulation }

EcoBanking<public> := module:
    
    # ========== 数据结构 ==========
    
    # 银行账户
    bank_account<public> := struct<computes>:
        AccountID<public>:int = 0
        Balance<public>:int = 0                 # 账户余额
        DepositTime<public>:float = 0.0         # 存款时间
        InterestRate<public>:float = 0.0        # 利率（年化）
        AccountTier<public>:int = 0             # 账户等级
    
    # 仓库信息
    storage_info<public> := struct<computes>:
        CurrentSlots<public>:int = 0            # 当前格子数
        MaxSlots<public>:int = 0                # 最大格子数
        UpgradeLevel<public>:int = 0            # 扩容等级
    
    # ========== 常量定义 ==========
    
    # 利率设置
    BASE_INTEREST_RATE<public>:float = 0.01     # 基础年化利率1%
    DAILY_RATE_DIVISOR<public>:float = 365.0    # 日利率除数
    HOURLY_RATE_DIVISOR<public>:float = 8760.0  # 小时利率除数（365*24）
    
    # 账户等级利率加成
    TIER_1_BONUS<public>:float = 0.0            # 普通账户
    TIER_2_BONUS<public>:float = 0.005          # VIP账户 +0.5%
    TIER_3_BONUS<public>:float = 0.015          # 高级VIP +1.5%
    
    # 仓库扩容参数
    BASE_STORAGE_SLOTS<public>:int = 20         # 基础仓库格子
    SLOTS_PER_UPGRADE<public>:int = 10          # 每次扩容增加格子
    MAX_UPGRADES<public>:int = 10               # 最大扩容次数
    
    # 扩容费用（指数增长）
    BASE_UPGRADE_COST<public>:int = 100
    UPGRADE_COST_MULTIPLIER<public>:float = 1.5
    
    # 提现手续费
    WITHDRAWAL_FEE_PERCENT<public>:float = 0.02 # 2%手续费
    MIN_WITHDRAWAL_FEE<public>:int = 1
    
    # ========== 利息计算 ==========
    
    # 获取账户等级利率加成
    GetTierInterestBonus<public>(Tier:int)<computes>:float =
        if (Tier = 0):
            TIER_1_BONUS
        else if (Tier = 1):
            TIER_2_BONUS
        else if (Tier = 2):
            TIER_3_BONUS
        else:
            TIER_3_BONUS
    
    # 计算有效利率
    CalculateEffectiveRate<public>(BaseRate:float, Tier:int)<computes>:float =
        Bonus := GetTierInterestBonus(Tier)
        BaseRate + Bonus
    
    # 计算单利（按天）
    CalculateSimpleInterest<public>(Principal:int, DailyRate:float, Days:int)<computes>:int =
        Interest := Floor(Principal) * DailyRate * Floor(Days)
        Floor(Interest)
    
    # 计算复利（按天）
    CalculateCompoundInterest<public>(Principal:int, DailyRate:float, Days:int)<computes>:int =
        if (Days <= 0):
            0
        else:
            # 复利公式：A = P * (1 + r)^n - P
            FinalAmount := Floor(Principal) * Pow(1.0 + DailyRate, Floor(Days))
            Interest := FinalAmount - Floor(Principal)
            Floor(Interest)
    
    # 计算年化利息
    CalculateAnnualInterest<public>(Principal:int, AnnualRate:float)<computes>:int =
        Interest := Floor(Principal) * AnnualRate
        Floor(Interest)
    
    # 计算到期利息（基于存款时长）
    CalculateMaturedInterest<public>(Account:bank_account, CurrentTime:float)<computes>:int =
        ElapsedTime := CurrentTime - Account.DepositTime
        ElapsedDays := Floor(ElapsedTime / 86400.0)  # 秒转天
        
        EffectiveRate := CalculateEffectiveRate(Account.InterestRate, Account.AccountTier)
        DailyRate := EffectiveRate / DAILY_RATE_DIVISOR
        
        CalculateSimpleInterest(Account.Balance, DailyRate, ElapsedDays)
    
    # ========== 存取款操作 ==========
    
    # 存款
    Deposit<public>(Account:bank_account, Amount:int, CurrentTime:float)<transacts>:bank_account =
        bank_account{
            AccountID := Account.AccountID
            Balance := Account.Balance + Amount
            DepositTime := CurrentTime
            InterestRate := Account.InterestRate
            AccountTier := Account.AccountTier
        }
    
    # 取款（扣除手续费）
    Withdraw<public>(Account:bank_account, Amount:int)<transacts>:tuple(bank_account, int) =
        # 计算手续费
        Fee := CalculateWithdrawalFee(Amount)
        ActualAmount := Amount - Fee
        
        NewAccount := bank_account{
            AccountID := Account.AccountID
            Balance := Account.Balance - Amount
            DepositTime := Account.DepositTime
            InterestRate := Account.InterestRate
            AccountTier := Account.AccountTier
        }
        
        (NewAccount, ActualAmount)
    
    # 计算提现手续费
    CalculateWithdrawalFee<public>(Amount:int)<computes>:int =
        Fee := Floor(Floor(Amount) * WITHDRAWAL_FEE_PERCENT)
        Max(Fee, MIN_WITHDRAWAL_FEE)
    
    # ========== 仓库扩容 ==========
    
    # 计算扩容费用
    CalculateUpgradeCost<public>(CurrentLevel:int)<computes>:int =
        if (CurrentLevel >= MAX_UPGRADES):
            0  # 已达上限，无法扩容
        else:
            Cost := Floor(BASE_UPGRADE_COST) * Pow(UPGRADE_COST_MULTIPLIER, Floor(CurrentLevel))
            Floor(Cost)
    
    # 计算扩容后的格子数
    CalculateUpgradedSlots<public>(CurrentLevel:int)<computes>:int =
        BASE_STORAGE_SLOTS + CurrentLevel * SLOTS_PER_UPGRADE
    
    # 执行仓库扩容
    UpgradeStorage<public>(Storage:storage_info)<transacts>:storage_info =
        if (Storage.UpgradeLevel >= MAX_UPGRADES):
            # 已达上限
            Storage
        else:
            NewLevel := Storage.UpgradeLevel + 1
            NewSlots := CalculateUpgradedSlots(NewLevel)
            storage_info{
                CurrentSlots := NewSlots
                MaxSlots := NewSlots
                UpgradeLevel := NewLevel
            }
    
    # 检查是否可以扩容
    CheckCanUpgrade<public>(Storage:storage_info)<decides><transacts>:void =
        Storage.UpgradeLevel < MAX_UPGRADES
    
    # ========== 账户等级系统 ==========
    
    # 根据余额计算账户等级
    CalculateAccountTier<public>(Balance:int)<computes>:int =
        if (Balance >= 100000):
            2  # 高级VIP
        else if (Balance >= 10000):
            1  # VIP
        else:
            0  # 普通
    
    # 升级账户等级
    UpgradeAccountTier<public>(Account:bank_account)<transacts>:bank_account =
        NewTier := CalculateAccountTier(Account.Balance)
        bank_account{
            AccountID := Account.AccountID
            Balance := Account.Balance
            DepositTime := Account.DepositTime
            InterestRate := Account.InterestRate
            AccountTier := NewTier
        }
    
    # ========== 贷款系统 ==========
    
    # 计算贷款利息（高于存款利率）
    CalculateLoanInterest<public>(LoanAmount:int, MonthlyRate:float, Months:int)<computes>:int =
        # 简单利息
        Interest := Floor(LoanAmount) * MonthlyRate * Floor(Months)
        Floor(Interest)
    
    # 计算月供
    CalculateMonthlyPayment<public>(LoanAmount:int, MonthlyRate:float, Months:int)<computes>:int =
        if (Months <= 0):
            LoanAmount
        else:
            # 等额本息公式
            TotalInterest := CalculateLoanInterest(LoanAmount, MonthlyRate, Months)
            TotalPayment := LoanAmount + TotalInterest
            Floor(TotalPayment / Months)
    
    # ========== 工具函数 ==========
    
    # 创建银行账户
    MakeBankAccount<public>(AccountID:int, InitialBalance:int, CurrentTime:float)<transacts>:bank_account =
        bank_account{
            AccountID := AccountID
            Balance := InitialBalance
            DepositTime := CurrentTime
            InterestRate := BASE_INTEREST_RATE
            AccountTier := CalculateAccountTier(InitialBalance)
        }
    
    # 创建仓库信息
    MakeStorageInfo<public>()<transacts>:storage_info =
        storage_info{
            CurrentSlots := BASE_STORAGE_SLOTS
            MaxSlots := BASE_STORAGE_SLOTS
            UpgradeLevel := 0
        }
