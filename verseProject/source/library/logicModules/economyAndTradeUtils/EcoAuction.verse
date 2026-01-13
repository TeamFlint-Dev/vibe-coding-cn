# 经济拍卖系统模块
# 功能：竞拍加价幅度规则、一口价判定

using { /Verse.org/Simulation }

EcoAuction<public> := module:
    
    # ========== 数据结构 ==========
    
    # 拍卖信息
    auction_info<public> := struct<computes>:
        ItemID<public>:int = 0
        StartingBid<public>:int = 0             # 起拍价
        CurrentBid<public>:int = 0              # 当前出价
        BuyoutPrice<public>:int = 0             # 一口价
        MinimumIncrement<public>:int = 0        # 最小加价幅度
        BidCount<public>:int = 0                # 出价次数
        TimeRemaining<public>:float = 0.0       # 剩余时间（秒）
        HighestBidderID<public>:int = 0         # 最高出价者ID
    
    # 出价记录
    bid_record<public> := struct<computes>:
        BidderID<public>:int = 0
        BidAmount<public>:int = 0
        BidTime<public>:float = 0.0
        IsAutoBid<public>:logic = false         # 是否自动出价
    
    # ========== 常量定义 ==========
    
    # 最小加价幅度（相对于当前价格的百分比）
    MIN_INCREMENT_PERCENT<public>:float = 0.05  # 5%
    
    # 绝对最小加价金额
    ABSOLUTE_MIN_INCREMENT<public>:int = 1
    
    # 一口价加成（相对于起拍价）
    BUYOUT_MULTIPLIER<public>:float = 3.0       # 一口价通常是起拍价的3倍
    
    # 拍卖延时阈值（最后N秒内出价会延长拍卖）
    SNIPE_PROTECTION_TIME<public>:float = 30.0  # 最后30秒
    SNIPE_EXTENSION_TIME<public>:float = 60.0   # 延长60秒
    
    # 拍卖手续费百分比
    AUCTION_FEE_PERCENT<public>:float = 0.05    # 5%手续费
    
    # ========== 加价幅度计算 ==========
    
    # 计算最小加价幅度
    CalculateMinimumIncrement<public>(CurrentPrice:int)<computes>:int =
        # 基于百分比计算
        PercentBased := Floor(Floor(CurrentPrice) * MIN_INCREMENT_PERCENT)
        # 取较大值
        Max(PercentBased, ABSOLUTE_MIN_INCREMENT)
    
    # 计算建议加价（分层）
    CalculateSuggestedBid<public>(CurrentBid:int)<computes>:int =
        if (CurrentBid < 100):
            # 100以下：+5
            CurrentBid + 5
        else if (CurrentBid < 1000):
            # 1000以下：+10%
            CurrentBid + Floor(Floor(CurrentBid) * 0.1)
        else if (CurrentBid < 10000):
            # 10000以下：+5%
            CurrentBid + Floor(Floor(CurrentBid) * 0.05)
        else:
            # 10000以上：+2%
            CurrentBid + Floor(Floor(CurrentBid) * 0.02)
    
    # ========== 出价验证 ==========
    
    # 检查出价是否有效
    CheckBidValid<public>(NewBid:int, CurrentBid:int, MinIncrement:int)<decides><transacts>:void =
        NewBid >= CurrentBid + MinIncrement
    
    # 检查是否达到一口价
    CheckBuyoutReached<public>(BidAmount:int, BuyoutPrice:int)<decides><transacts>:void =
        BidAmount >= BuyoutPrice
    
    # 检查玩家是否已是最高出价者
    CheckIsHighestBidder<public>(BidderID:int, HighestBidderID:int)<decides><transacts>:void =
        BidderID = HighestBidderID
    
    # ========== 一口价计算 ==========
    
    # 根据起拍价计算一口价
    CalculateBuyoutPrice<public>(StartingBid:int)<computes>:int =
        Floor(Floor(StartingBid) * BUYOUT_MULTIPLIER)
    
    # 计算一口价与当前价差距
    CalculateBuyoutGap<public>(CurrentBid:int, BuyoutPrice:int)<computes>:int =
        Max(BuyoutPrice - CurrentBid, 0)
    
    # ========== 拍卖时间管理 ==========
    
    # 检查是否在狙击保护时间内
    CheckInSnipeWindow<public>(TimeRemaining:float)<decides><transacts>:void =
        TimeRemaining <= SNIPE_PROTECTION_TIME
    
    # 计算延长后的拍卖时间
    ExtendAuctionTime<public>(CurrentTimeRemaining:float)<computes>:float =
        if (CurrentTimeRemaining < SNIPE_PROTECTION_TIME):
            SNIPE_EXTENSION_TIME
        else:
            CurrentTimeRemaining
    
    # 更新拍卖时间（有新出价时）
    UpdateAuctionTime<public>(Auction:auction_info, NewBid:int)<transacts>:auction_info =
        # 如果在狙击保护时间内，延长拍卖
        NewTime := if (Auction.TimeRemaining <= SNIPE_PROTECTION_TIME):
            SNIPE_EXTENSION_TIME
        else:
            Auction.TimeRemaining
        
        auction_info{
            ItemID := Auction.ItemID
            StartingBid := Auction.StartingBid
            CurrentBid := NewBid
            BuyoutPrice := Auction.BuyoutPrice
            MinimumIncrement := CalculateMinimumIncrement(NewBid)
            BidCount := Auction.BidCount + 1
            TimeRemaining := NewTime
            HighestBidderID := Auction.HighestBidderID
        }
    
    # ========== 手续费计算 ==========
    
    # 计算拍卖手续费
    CalculateAuctionFee<public>(SalePrice:int)<computes>:int =
        Floor(Floor(SalePrice) * AUCTION_FEE_PERCENT)
    
    # 计算卖家实际收入（扣除手续费）
    CalculateSellerProfit<public>(SalePrice:int)<computes>:int =
        Fee := CalculateAuctionFee(SalePrice)
        SalePrice - Fee
    
    # ========== 自动出价系统 ==========
    
    # 计算自动出价的下一次出价金额
    CalculateAutoBidAmount<public>(CurrentBid:int, MaxAutoBid:int, MinIncrement:int)<computes>:int =
        NextBid := CurrentBid + MinIncrement
        # 不超过用户设定的最高价
        Min(NextBid, MaxAutoBid)
    
    # 检查自动出价是否应该触发
    CheckShouldAutoBid<public>(NewBid:int, MaxAutoBid:int)<decides><transacts>:void =
        NewBid < MaxAutoBid
    
    # ========== 拍卖统计 ==========
    
    # 计算平均竞价增幅
    CalculateAverageBidIncrease<public>(StartingBid:int, CurrentBid:int, BidCount:int)<computes>:float =
        if (BidCount <= 0):
            0.0
        else:
            TotalIncrease := Floor(CurrentBid - StartingBid)
            Floor(TotalIncrease) / Floor(BidCount)
    
    # 计算竞争激烈度（出价次数/小时）
    CalculateCompetitiveness<public>(BidCount:int, ElapsedTimeHours:float)<computes>:float =
        if (ElapsedTimeHours <= 0.0):
            0.0
        else:
            Floor(BidCount) / ElapsedTimeHours
    
    # ========== 工具函数 ==========
    
    # 创建拍卖信息
    MakeAuctionInfo<public>(ItemID:int, StartingBid:int, Duration:float)<transacts>:auction_info =
        BuyoutPrice := CalculateBuyoutPrice(StartingBid)
        auction_info{
            ItemID := ItemID
            StartingBid := StartingBid
            CurrentBid := StartingBid
            BuyoutPrice := BuyoutPrice
            MinimumIncrement := CalculateMinimumIncrement(StartingBid)
            BidCount := 0
            TimeRemaining := Duration
            HighestBidderID := 0
        }
    
    # 创建出价记录
    MakeBidRecord<public>(BidderID:int, Amount:int, Time:float, IsAuto:logic)<transacts>:bid_record =
        bid_record{
            BidderID := BidderID
            BidAmount := Amount
            BidTime := Time
            IsAutoBid := IsAuto
        }
