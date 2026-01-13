# 经济通货膨胀模块
# 功能：通货膨胀系数、全局价格浮动算法

using { /Verse.org/Simulation }

EcoInflation<public> := module:
    
    # ========== 数据结构 ==========
    
    # 通货膨胀状态
    inflation_state<public> := struct<computes>:
        InflationRate<public>:float = 0.0       # 通胀率（0.05 = 5%）
        PriceIndex<public>:float = 1.0          # 价格指数（基准1.0）
        LastUpdateTime<public>:float = 0.0      # 上次更新时间
        TotalMoneySupply<public>:int = 0        # 总货币供应量
    
    # 物价分类
    CATEGORY_BASIC_GOODS<public>:int = 0        # 基础商品
    CATEGORY_LUXURY_GOODS<public>:int = 1       # 奢侈品
    CATEGORY_RAW_MATERIALS<public>:int = 2      # 原材料
    CATEGORY_CRAFTED_ITEMS<public>:int = 3      # 制作品
    
    # ========== 常量定义 ==========
    
    # 基础通胀率
    BASE_INFLATION_RATE<public>:float = 0.02    # 基础2%年通胀
    
    # 货币供应影响系数
    MONEY_SUPPLY_IMPACT<public>:float = 0.0001  # 货币供应对通胀的影响
    
    # 价格波动范围
    PRICE_VOLATILITY<public>:float = 0.1        # 价格波动±10%
    
    # 不同类别的通胀敏感度
    BASIC_GOODS_SENSITIVITY<public>:float = 0.5     # 基础商品抗通胀
    LUXURY_GOODS_SENSITIVITY<public>:float = 1.5    # 奢侈品通胀敏感
    RAW_MATERIALS_SENSITIVITY<public>:float = 1.0
    CRAFTED_ITEMS_SENSITIVITY<public>:float = 1.2
    
    # ========== 通胀计算 ==========
    
    # 根据货币供应量计算通胀率
    CalculateInflationFromSupply<public>(TotalSupply:int, BaseSupply:int)<computes>:float =
        if (BaseSupply <= 0):
            BASE_INFLATION_RATE
        else:
            SupplyRatio := Floor(TotalSupply) / Floor(BaseSupply)
            # 供应量增加导致通胀
            ExcessInflation := (SupplyRatio - 1.0) * MONEY_SUPPLY_IMPACT
            BASE_INFLATION_RATE + ExcessInflation
    
    # 更新通胀率（基于时间）
    UpdateInflationRate<public>(State:inflation_state, CurrentTime:float, BaseSupply:int)<transacts>:inflation_state =
        ElapsedTime := CurrentTime - State.LastUpdateTime
        ElapsedDays := ElapsedTime / 86400.0
        
        # 计算当前通胀率
        CurrentRate := CalculateInflationFromSupply(State.TotalMoneySupply, BaseSupply)
        
        # 应用时间累积的通胀
        DailyRate := CurrentRate / 365.0
        NewPriceIndex := State.PriceIndex * Pow(1.0 + DailyRate, ElapsedDays)
        
        inflation_state{
            InflationRate := CurrentRate
            PriceIndex := NewPriceIndex
            LastUpdateTime := CurrentTime
            TotalMoneySupply := State.TotalMoneySupply
        }
    
    # ========== 价格调整 ==========
    
    # 获取类别敏感度
    GetCategorySensitivity<public>(Category:int)<computes>:float =
        if (Category = CATEGORY_BASIC_GOODS):
            BASIC_GOODS_SENSITIVITY
        else if (Category = CATEGORY_LUXURY_GOODS):
            LUXURY_GOODS_SENSITIVITY
        else if (Category = CATEGORY_RAW_MATERIALS):
            RAW_MATERIALS_SENSITIVITY
        else if (Category = CATEGORY_CRAFTED_ITEMS):
            CRAFTED_ITEMS_SENSITIVITY
        else:
            1.0
    
    # 应用通胀到价格
    ApplyInflation<public>(BasePrice:int, PriceIndex:float, Category:int)<computes>:int =
        Sensitivity := GetCategorySensitivity(Category)
        # 调整后的价格指数
        AdjustedIndex := 1.0 + (PriceIndex - 1.0) * Sensitivity
        AdjustedPrice := Floor(BasePrice) * AdjustedIndex
        Floor(AdjustedPrice)
    
    # 计算通胀调整后的价格
    CalculateInflatedPrice<public>(BasePrice:int, State:inflation_state, Category:int)<computes>:int =
        ApplyInflation(BasePrice, State.PriceIndex, Category)
    
    # ========== 价格波动 ==========
    
    # 计算随机价格波动（基于市场供需）
    CalculatePriceVolatility<public>(BasePrice:int, SupplyDemandRatio:float)<computes>:int =
        # 供需比 < 1：供不应求，涨价
        # 供需比 > 1：供过于求，降价
        if (SupplyDemandRatio < 1.0):
            # 涨价
            Increase := Floor(BasePrice) * (1.0 - SupplyDemandRatio) * PRICE_VOLATILITY
            BasePrice + Floor(Increase)
        else if (SupplyDemandRatio > 1.0):
            # 降价
            Decrease := Floor(BasePrice) * (SupplyDemandRatio - 1.0) * PRICE_VOLATILITY
            Max(BasePrice - Floor(Decrease), Floor(BasePrice / 2))  # 最低半价
        else:
            BasePrice
    
    # 应用综合价格调整（通胀+波动）
    CalculateFinalPrice<public>(BasePrice:int, State:inflation_state, Category:int, SupplyDemandRatio:float)<computes>:int =
        # 先应用通胀
        InflatedPrice := CalculateInflatedPrice(BasePrice, State, Category)
        # 再应用波动
        CalculatePriceVolatility(InflatedPrice, SupplyDemandRatio)
    
    # ========== 货币供应管理 ==========
    
    # 增加货币供应（铸币）
    AddMoneySupply<public>(State:inflation_state, Amount:int)<transacts>:inflation_state =
        inflation_state{
            InflationRate := State.InflationRate
            PriceIndex := State.PriceIndex
            LastUpdateTime := State.LastUpdateTime
            TotalMoneySupply := State.TotalMoneySupply + Amount
        }
    
    # 减少货币供应（销毁货币）
    RemoveMoneySupply<public>(State:inflation_state, Amount:int)<transacts>:inflation_state =
        NewSupply := Max(State.TotalMoneySupply - Amount, 0)
        inflation_state{
            InflationRate := State.InflationRate
            PriceIndex := State.PriceIndex
            LastUpdateTime := State.LastUpdateTime
            TotalMoneySupply := NewSupply
        }
    
    # ========== 通缩处理 ==========
    
    # 检查是否处于通缩状态
    CheckDeflation<public>(State:inflation_state)<decides><transacts>:void =
        State.PriceIndex < 1.0
    
    # 计算通缩率
    CalculateDeflationRate<public>(State:inflation_state)<computes>:float =
        if (State.PriceIndex < 1.0):
            1.0 - State.PriceIndex
        else:
            0.0
    
    # ========== 工具函数 ==========
    
    # 创建初始通胀状态
    MakeInitialInflationState<public>(InitialSupply:int, CurrentTime:float)<transacts>:inflation_state =
        inflation_state{
            InflationRate := BASE_INFLATION_RATE
            PriceIndex := 1.0
            LastUpdateTime := CurrentTime
            TotalMoneySupply := InitialSupply
        }
    
    # 重置价格指数（经济重置）
    ResetPriceIndex<public>(State:inflation_state)<transacts>:inflation_state =
        inflation_state{
            InflationRate := BASE_INFLATION_RATE
            PriceIndex := 1.0
            LastUpdateTime := State.LastUpdateTime
            TotalMoneySupply := State.TotalMoneySupply
        }
