# 经济奖励系统模块
# 功能：任务金币奖励随等级动态缩放逻辑

using { /Verse.org/Simulation }

EcoRewards<public> := module:
    
    BASE_QUEST_REWARD<public>:float = 100.0
    DAILY_BONUS_MULTIPLIER<public>:float = 1.5
    
    CalculateQuestReward<public>(QuestLevel:int, PlayerLevel:int)<computes>:float =
        QuestFloat := QuestLevel * 1.0
        PlayerFloat := PlayerLevel * 1.0
        LevelDiff := Abs(QuestFloat - PlayerFloat)
        Penalty := if (LevelDiff > 5.0) then 0.5 else 1.0
        BASE_QUEST_REWARD * QuestFloat * Penalty
    
    CalculateDailyReward<public>(BaseReward:float, Streak:int)<computes>:float =
        StreakBonus := Min((Streak * 1.0) * 0.1, 1.0)
        BaseReward * (1.0 + StreakBonus)
