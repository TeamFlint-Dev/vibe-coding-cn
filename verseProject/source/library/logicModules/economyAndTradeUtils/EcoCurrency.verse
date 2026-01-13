# 经济货币系统模块
# 功能：多货币汇率转换、大数值格式化 (1k, 1m)

using { /Verse.org/Simulation }

EcoCurrency<public> := module:
    
    # ========== 货币类型枚举 ==========
    
    CURRENCY_GOLD<public>:int = 0       # 金币
    CURRENCY_SILVER<public>:int = 1     # 银币
    CURRENCY_COPPER<public>:int = 2     # 铜币
    CURRENCY_GEMS<public>:int = 3       # 宝石（高级货币）
    CURRENCY_TOKENS<public>:int = 4     # 代币（活动货币）
    
    # ========== 数据结构 ==========
    
    # 货币数额
    currency_amount<public> := struct<computes>:
        CurrencyType<public>:int = 0
        Amount<public>:int = 0
    
    # 多货币钱包
    wallet<public> := struct<computes>:
        Gold<public>:int = 0
        Silver<public>:int = 0
        Copper<public>:int = 0
        Gems<public>:int = 0
        Tokens<public>:int = 0
    
    # ========== 汇率常量 ==========
    
    # 基础货币转换率（以铜币为基准）
    COPPER_TO_COPPER<public>:int = 1
    SILVER_TO_COPPER<public>:int = 100      # 1银 = 100铜
    GOLD_TO_COPPER<public>:int = 10000      # 1金 = 100银 = 10000铜
    
    # 高级货币转换率
    GEMS_TO_GOLD<public>:int = 100          # 1宝石 = 100金
    TOKENS_TO_GOLD<public>:int = 10         # 1代币 = 10金
    
    # ========== 汇率转换 ==========
    
    # 获取货币到铜币的汇率
    GetCurrencyToCopper<public>(CurrencyType:int)<computes>:int =
        if (CurrencyType = CURRENCY_COPPER):
            COPPER_TO_COPPER
        else if (CurrencyType = CURRENCY_SILVER):
            SILVER_TO_COPPER
        else if (CurrencyType = CURRENCY_GOLD):
            GOLD_TO_COPPER
        else if (CurrencyType = CURRENCY_GEMS):
            GEMS_TO_GOLD * GOLD_TO_COPPER
        else if (CurrencyType = CURRENCY_TOKENS):
            TOKENS_TO_GOLD * GOLD_TO_COPPER
        else:
            1
    
    # 转换为铜币
    ConvertToCopper<public>(Amount:int, CurrencyType:int)<computes>:int =
        Rate := GetCurrencyToCopper(CurrencyType)
        Amount * Rate
    
    # 从铜币转换为指定货币
    ConvertFromCopper<public>(CopperAmount:int, TargetCurrency:int)<computes>:int =
        Rate := GetCurrencyToCopper(TargetCurrency)
        if (Rate <= 0):
            0
        else:
            Floor(CopperAmount / Rate)
    
    # 货币间转换
    ConvertCurrency<public>(Amount:int, FromType:int, ToType:int)<computes>:int =
        CopperValue := ConvertToCopper(Amount, FromType)
        ConvertFromCopper(CopperValue, ToType)
    
    # ========== 货币拆分 ==========
    
    # 将铜币拆分为金银铜
    SplitToGoldSilverCopper<public>(TotalCopper:int)<transacts>:tuple(int, int, int) =
        Gold := Floor(TotalCopper / GOLD_TO_COPPER)
        RemainingAfterGold := TotalCopper - Gold * GOLD_TO_COPPER
        
        Silver := Floor(RemainingAfterGold / SILVER_TO_COPPER)
        Copper := RemainingAfterGold - Silver * SILVER_TO_COPPER
        
        (Gold, Silver, Copper)
    
    # 将金银铜合并为总铜币
    MergeToCopper<public>(Gold:int, Silver:int, Copper:int)<computes>:int =
        Gold * GOLD_TO_COPPER + Silver * SILVER_TO_COPPER + Copper
    
    # ========== 数值格式化 ==========
    
    # 格式化为人类可读（1k, 1m, 1b）
    FormatLargeNumber<public>(Amount:int)<computes>:string =
        if (Amount >= 1000000000):
            # 十亿级别
            Billions := Floor(Amount / 1000000000)
            "{Billions}b"
        else if (Amount >= 1000000):
            # 百万级别
            Millions := Floor(Amount / 1000000)
            "{Millions}m"
        else if (Amount >= 1000):
            # 千级别
            Thousands := Floor(Amount / 1000)
            "{Thousands}k"
        else:
            "{Amount}"
    
    # 格式化货币显示（带单位）
    FormatCurrency<public>(Amount:int, CurrencyType:int)<computes>:string =
        FormattedNum := FormatLargeNumber(Amount)
        if (CurrencyType = CURRENCY_GOLD):
            "{FormattedNum}G"
        else if (CurrencyType = CURRENCY_SILVER):
            "{FormattedNum}S"
        else if (CurrencyType = CURRENCY_COPPER):
            "{FormattedNum}C"
        else if (CurrencyType = CURRENCY_GEMS):
            "{FormattedNum}💎"
        else if (CurrencyType = CURRENCY_TOKENS):
            "{FormattedNum}🎫"
        else:
            "{FormattedNum}"
    
    # 格式化为金银铜显示
    FormatAsGoldSilverCopper<public>(TotalCopper:int)<computes>:string =
        (Gold, Silver, Copper) := SplitToGoldSilverCopper(TotalCopper)
        if (Gold > 0):
            if (Silver > 0 or Copper > 0):
                "{Gold}G {Silver}S {Copper}C"
            else:
                "{Gold}G"
        else if (Silver > 0):
            if (Copper > 0):
                "{Silver}S {Copper}C"
            else:
                "{Silver}S"
        else:
            "{Copper}C"
    
    # ========== 钱包操作 ==========
    
    # 添加货币到钱包
    AddToWallet<public>(Wallet:wallet, Amount:int, CurrencyType:int)<transacts>:wallet =
        if (CurrencyType = CURRENCY_GOLD):
            wallet{Gold := Wallet.Gold + Amount, Silver := Wallet.Silver, Copper := Wallet.Copper, Gems := Wallet.Gems, Tokens := Wallet.Tokens}
        else if (CurrencyType = CURRENCY_SILVER):
            wallet{Gold := Wallet.Gold, Silver := Wallet.Silver + Amount, Copper := Wallet.Copper, Gems := Wallet.Gems, Tokens := Wallet.Tokens}
        else if (CurrencyType = CURRENCY_COPPER):
            wallet{Gold := Wallet.Gold, Silver := Wallet.Silver, Copper := Wallet.Copper + Amount, Gems := Wallet.Gems, Tokens := Wallet.Tokens}
        else if (CurrencyType = CURRENCY_GEMS):
            wallet{Gold := Wallet.Gold, Silver := Wallet.Silver, Copper := Wallet.Copper, Gems := Wallet.Gems + Amount, Tokens := Wallet.Tokens}
        else if (CurrencyType = CURRENCY_TOKENS):
            wallet{Gold := Wallet.Gold, Silver := Wallet.Silver, Copper := Wallet.Copper, Gems := Wallet.Gems, Tokens := Wallet.Tokens + Amount}
        else:
            Wallet
    
    # 检查钱包是否有足够货币
    CheckWalletHasCurrency<public>(Wallet:wallet, Amount:int, CurrencyType:int)<decides><transacts>:void =
        if (CurrencyType = CURRENCY_GOLD):
            Wallet.Gold >= Amount
        else if (CurrencyType = CURRENCY_SILVER):
            Wallet.Silver >= Amount
        else if (CurrencyType = CURRENCY_COPPER):
            Wallet.Copper >= Amount
        else if (CurrencyType = CURRENCY_GEMS):
            Wallet.Gems >= Amount
        else if (CurrencyType = CURRENCY_TOKENS):
            Wallet.Tokens >= Amount
        else:
            false
    
    # ========== 工具函数 ==========
    
    # 创建货币数额
    MakeCurrencyAmount<public>(Type:int, Amount:int)<transacts>:currency_amount =
        currency_amount{
            CurrencyType := Type
            Amount := Amount
        }
    
    # 创建空钱包
    MakeEmptyWallet<public>()<transacts>:wallet =
        wallet{
            Gold := 0
            Silver := 0
            Copper := 0
            Gems := 0
            Tokens := 0
        }
