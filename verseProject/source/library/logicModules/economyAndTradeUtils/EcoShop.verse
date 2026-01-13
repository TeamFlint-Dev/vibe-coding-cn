# 经济商店系统模块
# 功能：动态定价逻辑、折扣计算、限购检查

using { /Verse.org/Simulation }

EcoShop<public> := module:
    
    # ========== 数据结构 ==========
    
    # 商品信息
    shop_item<public> := struct<computes>:
        ItemID<public>:int = 0
        BasePrice<public>:int = 0
        CurrentPrice<public>:int = 0
        Stock<public>:int = -1                  # -1表示无限库存
        PurchaseLimit<public>:int = -1          # -1表示无限购
        DiscountPercent<public>:float = 0.0
    
    # ========== 常量定义 ==========
    
    # 买卖价格差
    BUY_PRICE_MULTIPLIER<public>:float = 1.0    # 买入价
    SELL_PRICE_MULTIPLIER<public>:float = 0.5   # 卖出价（50%）
    
    # VIP折扣
    VIP_TIER_1_DISCOUNT<public>:float = 0.05    # 5%折扣
    VIP_TIER_2_DISCOUNT<public>:float = 0.10    # 10%折扣
    VIP_TIER_3_DISCOUNT<public>:float = 0.15    # 15%折扣
    
    # ========== 价格计算 ==========
    
    # 应用折扣
    ApplyDiscount<public>(BasePrice:int, DiscountPercent:float)<computes>:int =
        ClampedDiscount := Clamp(DiscountPercent, 0.0, 0.9)
        Discount := Floor(BasePrice) * ClampedDiscount
        Max(BasePrice - Floor(Discount), 1)
    
    # 计算VIP折扣后价格
    CalculatePriceWithVIPDiscount<public>(BasePrice:int, VIPTier:int)<computes>:int =
        Discount := if (VIPTier = 1):
            VIP_TIER_1_DISCOUNT
        else if (VIPTier = 2):
            VIP_TIER_2_DISCOUNT
        else if (VIPTier = 3):
            VIP_TIER_3_DISCOUNT
        else:
            0.0
        ApplyDiscount(BasePrice, Discount)
    
    # 计算卖出价格
    CalculateSellPrice<public>(ItemBasePrice:int)<computes>:int =
        SellPrice := Floor(ItemBasePrice) * SELL_PRICE_MULTIPLIER
        Max(Floor(SellPrice), 1)
    
    # ========== 限购检查 ==========
    
    # 检查是否可以购买
    CheckCanPurchase<public>(Item:shop_item, RequestedAmount:int, PlayerPurchasedCount:int)<decides><transacts>:void =
        # 检查库存
        StockOK := if (Item.Stock < 0) then true else Item.Stock >= RequestedAmount
        # 检查限购
        LimitOK := if (Item.PurchaseLimit < 0) then true else PlayerPurchasedCount + RequestedAmount <= Item.PurchaseLimit
        if (StockOK and LimitOK) then true else false
    
    # ========== 批量购买 ==========
    
    # 计算批量购买总价
    CalculateBatchPrice<public>(UnitPrice:int, Quantity:int)<computes>:int =
        UnitPrice * Quantity
    
    # 应用批量折扣
    ApplyBulkDiscount<public>(TotalPrice:int, Quantity:int)<computes>:int =
        if (Quantity >= 100):
            ApplyDiscount(TotalPrice, 0.15)  # 15%折扣
        else if (Quantity >= 50):
            ApplyDiscount(TotalPrice, 0.10)  # 10%折扣
        else if (Quantity >= 10):
            ApplyDiscount(TotalPrice, 0.05)  # 5%折扣
        else:
            TotalPrice
    
    # ========== 工具函数 ==========
    
    # 创建商品信息
    MakeShopItem<public>(ItemID:int, Price:int, Stock:int, Limit:int)<transacts>:shop_item =
        shop_item{
            ItemID := ItemID
            BasePrice := Price
            CurrentPrice := Price
            Stock := Stock
            PurchaseLimit := Limit
            DiscountPercent := 0.0
        }
