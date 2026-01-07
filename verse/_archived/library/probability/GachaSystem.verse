# GachaSystem - 抽卡系统
# 版本: 1.0
# 添加时间: 2026-01-05
# 来源: 随机数与概率系统 - 第四层：游戏应用层
#
# 功能: 实现完整的抽卡系统（卡池、保底、UP概率）

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }

GachaSystem<public> := module:
    # ==========================================
    # 卡牌定义
    # ==========================================
    
    gacha_card<public>(CardType:type) := class:
        # 卡牌数据
        Card<public>:CardType
        
        # 稀有度（1-5星）
        Rarity<public>:int
        
        # 是否为UP卡
        IsRateUp<public>:logic = false
        
        # 卡牌权重（同稀有度内的权重）
        Weight<public>:float = 1.0
    
    # ==========================================
    # 卡池配置
    # ==========================================
    
    gacha_pool_config<public> := class:
        # 五星基础概率
        FiveStarRate<public>:float = 0.006
        
        # 四星基础概率
        FourStarRate<public>:float = 0.051
        
        # 三星基础概率（剩余的）
        ThreeStarRate<public>:float = 0.943
        
        # 五星保底
        FiveStarPity<public>:int = 90
        
        # 四星保底
        FourStarPity<public>:int = 10
        
        # 五星软保底起始
        FiveStarSoftPity<public>:int = 75
        
        # 软保底增量
        SoftPityIncrement<public>:float = 0.06
        
        # UP概率（抽到五星时）
        FiveStarUpRate<public>:float = 0.5
        
        # UP概率（抽到四星时）
        FourStarUpRate<public>:float = 0.5
    
    # ==========================================
    # 卡池系统
    # ==========================================
    
    gacha_pool<public>(CardType:type) := class:
        # 配置
        Config<public>:gacha_pool_config
        
        # 卡牌列表
        var FiveStarCards<private>:[]gacha_card(CardType) = array{}
        var FourStarCards<private>:[]gacha_card(CardType) = array{}
        var ThreeStarCards<private>:[]gacha_card(CardType) = array{}
        
        # 保底计数器
        var FiveStarCounter<private>:int = 0
        var FourStarCounter<private>:int = 0
        
        # 是否下次必定UP
        var GuaranteedFiveStar<private>:logic = false
        var GuaranteedFourStar<private>:logic = false
        
        # 统计
        var TotalPulls<private>:int = 0
        var FiveStarPulls<private>:int = 0
        var FourStarPulls<private>:int = 0
        var ThreeStarPulls<private>:int = 0
        
        # 添加卡牌
        AddCard<public>(Card:CardType, Rarity:int, IsUp:logic, Weight:float):void =
            GachaCard := gacha_card(CardType){
                Card := Card,
                Rarity := Rarity,
                IsRateUp := IsUp,
                Weight := Weight
            }
            
            if (Rarity = 5):
                set FiveStarCards += array{GachaCard}
            else if (Rarity = 4):
                set FourStarCards += array{GachaCard}
            else:
                set ThreeStarCards += array{GachaCard}
        
        # 单抽
        SinglePull<public>()<decides><transacts>:gacha_card(CardType) =
            set TotalPulls += 1
            set FiveStarCounter += 1
            set FourStarCounter += 1
            
            # 判定稀有度
            Rarity := DetermineRarity()
            
            if (Rarity = 5):
                set FiveStarPulls += 1
                SelectFiveStarCard()
            else if (Rarity = 4):
                set FourStarPulls += 1
                SelectFourStarCard()
            else:
                set ThreeStarPulls += 1
                SelectThreeStarCard()
        
        # 十连抽
        TenPull<public>()<transacts>:[]gacha_card(CardType) =
            var Results:[]gacha_card(CardType) = array{}
            
            for (I := 0..9):
                if (Card := SinglePull?[]):
                    set Results += array{Card}
            
            Results
        
        # 判定稀有度
        DetermineRarity<private>()<transacts>:int =
            # 五星硬保底
            if (FiveStarCounter >= Config.FiveStarPity):
                set FiveStarCounter = 0
                return 5
            
            # 四星硬保底
            if (FourStarCounter >= Config.FourStarPity):
                set FourStarCounter = 0
                return 4
            
            # 计算当前五星概率（软保底）
            CurrentFiveStarRate := if (FiveStarCounter >= Config.FiveStarSoftPity):
                ExtraCount := FiveStarCounter - Config.FiveStarSoftPity
                IncreasedRate := Config.FiveStarRate + (ExtraCount * Config.SoftPityIncrement)
                if (IncreasedRate > 1.0) then 1.0 else IncreasedRate
            else:
                Config.FiveStarRate
            
            # 随机判定
            Roll := GetRandomFloat(0.0, 1.0)
            
            if (Roll <= CurrentFiveStarRate):
                set FiveStarCounter = 0
                5
            else if (Roll <= CurrentFiveStarRate + Config.FourStarRate):
                set FourStarCounter = 0
                4
            else:
                3
        
        # 选择五星卡
        SelectFiveStarCard<private>()<decides><transacts>:gacha_card(CardType) =
            FiveStarCards.Length > 0
            
            # 判定是否UP
            IsUp := if (GuaranteedFiveStar):
                set GuaranteedFiveStar = false
                true
            else:
                if (GetRandomFloat(0.0, 1.0) <= Config.FiveStarUpRate):
                    true
                else:
                    set GuaranteedFiveStar = true
                    false
            
            # 筛选卡牌
            var EligibleCards:[]gacha_card(CardType) = array{}
            for (Card : FiveStarCards):
                if (IsUp):
                    if (Card.IsRateUp):
                        set EligibleCards += array{Card}
                else:
                    if (not Card.IsRateUp?):
                        set EligibleCards += array{Card}
            
            # 如果没有符合条件的，使用全部
            if (EligibleCards.Length = 0):
                set EligibleCards = FiveStarCards
            
            # 按权重选择
            SelectWeightedCard(EligibleCards)
        
        # 选择四星卡
        SelectFourStarCard<private>()<decides><transacts>:gacha_card(CardType) =
            FourStarCards.Length > 0
            
            IsUp := if (GuaranteedFourStar):
                set GuaranteedFourStar = false
                true
            else:
                if (GetRandomFloat(0.0, 1.0) <= Config.FourStarUpRate):
                    true
                else:
                    set GuaranteedFourStar = true
                    false
            
            var EligibleCards:[]gacha_card(CardType) = array{}
            for (Card : FourStarCards):
                if (IsUp):
                    if (Card.IsRateUp):
                        set EligibleCards += array{Card}
                else:
                    if (not Card.IsRateUp?):
                        set EligibleCards += array{Card}
            
            if (EligibleCards.Length = 0):
                set EligibleCards = FourStarCards
            
            SelectWeightedCard(EligibleCards)
        
        # 选择三星卡
        SelectThreeStarCard<private>()<decides><transacts>:gacha_card(CardType) =
            ThreeStarCards.Length > 0
            SelectWeightedCard(ThreeStarCards)
        
        # 按权重选择卡牌
        SelectWeightedCard<private>(Cards:[]gacha_card(CardType))<decides><transacts>:gacha_card(CardType) =
            Cards.Length > 0
            
            var TotalWeight:float = 0.0
            for (Card : Cards):
                set TotalWeight += Card.Weight
            
            TotalWeight > 0.0
            
            Roll := GetRandomFloat(0.0, TotalWeight)
            var CumulativeWeight:float = 0.0
            
            for (Card : Cards):
                set CumulativeWeight += Card.Weight
                if (Roll <= CumulativeWeight):
                    Card
            
            Cards[Cards.Length - 1]
        
        # 获取统计信息
        GetTotalPulls<public>():int = TotalPulls
        GetFiveStarCount<public>():int = FiveStarPulls
        GetFourStarCount<public>():int = FourStarPulls
        GetThreeStarCount<public>():int = ThreeStarPulls
        
        GetFiveStarPityCount<public>():int = FiveStarCounter
        GetFourStarPityCount<public>():int = FourStarCounter
        
        IsGuaranteedFiveStar<public>():logic = GuaranteedFiveStar
        IsGuaranteedFourStar<public>():logic = GuaranteedFourStar
        
        # 重置统计
        ResetStatistics<public>():void =
            set TotalPulls = 0
            set FiveStarPulls = 0
            set FourStarPulls = 0
            set ThreeStarPulls = 0
        
        # 重置保底
        ResetPity<public>():void =
            set FiveStarCounter = 0
            set FourStarCounter = 0
            set GuaranteedFiveStar = false
            set GuaranteedFourStar = false
    
    # 创建卡池
    CreateGachaPool<public>(CardType:type, Config:gacha_pool_config):gacha_pool(CardType) =
        gacha_pool(CardType){Config := Config}
    
    # 创建默认卡池配置
    CreateDefaultConfig<public>():gacha_pool_config =
        gacha_pool_config{}
    
    # ==========================================
    # 抽卡模拟器
    # ==========================================
    
    gacha_simulator<public>(CardType:type) := class:
        var Pool<private>:gacha_pool(CardType)
        
        # 最大模拟次数（可配置）
        MaxSimulationAttempts<public>:int = 1000
        
        # 模拟N次单抽
        SimulatePulls<public>(Count:int)<transacts>:[]gacha_card(CardType) =
            var Results:[]gacha_card(CardType) = array{}
            
            for (I := 0..Count - 1):
                if (Card := Pool.SinglePull?[]):
                    set Results += array{Card}
            
            Results
        
        # 计算期望抽数（到第一个五星）
        SimulateUntilFiveStar<public>()<transacts>:int =
            var Attempts:int = 0
            
            loop:
                set Attempts += 1
                if (Card := Pool.SinglePull?[]):
                    if (Card.Rarity = 5):
                        break
                
                # 防止无限循环
                if (Attempts >= MaxSimulationAttempts):
                    break
            
            Attempts
