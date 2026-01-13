# 经济奖励系统模块
# 功能：任务金币奖励随等级动态缩放逻辑

using { /Verse.org/Simulation }

EcoRewards<public> := module:
    
    # ========== 数据结构 ==========
    
    # 奖励信息
    reward_info<public> := struct<computes>:
        GoldReward<public>:int = 0
        ExpReward<public>:int = 0
        ItemRewards<public>:[]int = array{}
    
    # ========== 常量定义 ==========
    
    # 基础奖励
    BASE_QUEST_REWARD<public>:int = 100
    BASE_DAILY_REWARD<public>:int = 50
    
    # 等级缩放系数
    LEVEL_SCALING_MULTIPLIER<public>:float = 1.5
    
    # 每日登录奖励递增
    DAILY_LOGIN_INCREMENT<public>:int = 10
    MAX_DAILY_STREAK<public>:int = 7
    
    # ========== 任务奖励计算 ==========
    
    # 根据等级缩放奖励
    CalculateRewardByLevel<public>(BaseReward:int, PlayerLevel:int)<computes>:int =
        Multiplier := 1.0 + Floor(PlayerLevel) * 0.1
        Reward := Floor(BaseReward) * Multiplier
        Floor(Reward)
    
    # 根据任务难度调整奖励
    CalculateRewardByDifficulty<public>(BaseReward:int, Difficulty:int)<computes>:int =
        if (Difficulty = 0):
            BaseReward  # 简单
        else if (Difficulty = 1):
            Floor(BaseReward * 1.5)  # 普通
        else if (Difficulty = 2):
            Floor(BaseReward * 2.0)  # 困难
        else if (Difficulty = 3):
            Floor(BaseReward * 3.0)  # 史诗
        else:
            BaseReward
    
    # 计算任务金币奖励
    CalculateQuestReward<public>(PlayerLevel:int, QuestDifficulty:int)<computes>:int =
        BaseReward := CalculateRewardByLevel(BASE_QUEST_REWARD, PlayerLevel)
        CalculateRewardByDifficulty(BaseReward, QuestDifficulty)
    
    # ========== 每日奖励 ==========
    
    # 计算每日登录奖励（连续登录递增）
    CalculateDailyLoginReward<public>(StreakDays:int)<computes>:int =
        ClampedStreak := Min(StreakDays, MAX_DAILY_STREAK)
        BASE_DAILY_REWARD + ClampedStreak * DAILY_LOGIN_INCREMENT
    
    # 计算每日任务奖励
    CalculateDailyQuestReward<public>(PlayerLevel:int, CompletedCount:int)<computes>:int =
        BaseReward := CalculateRewardByLevel(BASE_DAILY_REWARD, PlayerLevel)
        BaseReward * CompletedCount
    
    # ========== 首次通关奖励 ==========
    
    # 首次通关额外奖励
    CalculateFirstClearBonus<public>(BaseReward:int)<computes>:int =
        Floor(BaseReward * 2.0)  # 双倍奖励
    
    # ========== 工具函数 ==========
    
    # 创建奖励信息
    MakeRewardInfo<public>(Gold:int, Exp:int)<transacts>:reward_info =
        reward_info{
            GoldReward := Gold
            ExpReward := Exp
            ItemRewards := array{}
        }
