# RPG 等级系统模块
# 功能：经验曲线计算、升级所需经验判定

using { /Verse.org/Simulation }

RpgLeveling<public> := module:
    
    # ========== 数据结构 ==========
    
    # 等级状态
    level_state<public> := struct<computes>:
        CurrentLevel<public>:int = 1
        CurrentExp<public>:int = 0
        ExpToNextLevel<public>:int = 100
    
    # 等级曲线类型
    CURVE_TYPE_LINEAR<public>:int = 0      # 线性增长
    CURVE_TYPE_EXPONENTIAL<public>:int = 1 # 指数增长
    CURVE_TYPE_LOGARITHMIC<public>:int = 2 # 对数增长
    CURVE_TYPE_CUSTOM<public>:int = 3      # 自定义曲线
    
    # ========== 常量定义 ==========
    
    # 线性曲线参数
    LINEAR_BASE_EXP<public>:int = 100      # 1级升2级所需经验
    LINEAR_INCREMENT<public>:int = 50      # 每级增加的经验
    
    # 指数曲线参数
    EXPONENTIAL_BASE<public>:float = 100.0
    EXPONENTIAL_MULTIPLIER<public>:float = 1.15  # 每级经验增长15%
    
    # 等级上限
    MAX_LEVEL<public>:int = 100
    
    # ========== 经验曲线计算 ==========
    
    # 线性曲线：ExpNeeded = Base + (Level - 1) * Increment
    CalculateLinearExpForLevel<public>(Level:int)<computes>:int =
        if (Level <= 1):
            0
        else:
            LINEAR_BASE_EXP + (Level - 1) * LINEAR_INCREMENT
    
    # 指数曲线：ExpNeeded = Base * (Multiplier ^ (Level - 1))
    CalculateExponentialExpForLevel<public>(Level:int)<computes>:int =
        if (Level <= 1):
            0
        else:
            ExpFloat := EXPONENTIAL_BASE * Pow(EXPONENTIAL_MULTIPLIER, Floor(Level - 1))
            Floor(ExpFloat)
    
    # 对数曲线：ExpNeeded = Base * log(Level + 1) * Level
    CalculateLogarithmicExpForLevel<public>(Level:int)<computes>:int =
        if (Level <= 1):
            0
        else:
            LevelFloat := Floor(Level)
            LogValue := Log(LevelFloat + 1.0)
            ExpFloat := EXPONENTIAL_BASE * LogValue * LevelFloat
            Floor(ExpFloat)
    
    # 自定义混合曲线（前期线性，后期指数）
    CalculateCustomExpForLevel<public>(Level:int)<computes>:int =
        if (Level <= 1):
            0
        else if (Level <= 20):
            # 前20级使用线性
            CalculateLinearExpForLevel(Level)
        else:
            # 20级后使用指数
            Level20Exp := CalculateLinearExpForLevel(20)
            AdditionalLevels := Level - 20
            AdditionalExp := Floor(200.0 * Pow(1.12, Floor(AdditionalLevels)))
            Level20Exp + AdditionalExp
    
    # 根据曲线类型计算等级所需经验
    GetExpRequiredForLevel<public>(Level:int, CurveType:int)<computes>:int =
        if (CurveType = CURVE_TYPE_LINEAR):
            CalculateLinearExpForLevel(Level)
        else if (CurveType = CURVE_TYPE_EXPONENTIAL):
            CalculateExponentialExpForLevel(Level)
        else if (CurveType = CURVE_TYPE_LOGARITHMIC):
            CalculateLogarithmicExpForLevel(Level)
        else if (CurveType = CURVE_TYPE_CUSTOM):
            CalculateCustomExpForLevel(Level)
        else:
            CalculateLinearExpForLevel(Level)
    
    # ========== 累计经验计算 ==========
    
    # 计算从1级到指定等级的累计经验
    CalculateTotalExpToLevel<public>(TargetLevel:int, CurveType:int)<computes>:int =
        if (TargetLevel <= 1):
            0
        else:
            var TotalExp:int = 0
            var Level:int = 2
            loop:
                if (Level > TargetLevel):
                    break
                set TotalExp += GetExpRequiredForLevel(Level, CurveType)
                set Level += 1
            TotalExp
    
    # ========== 升级判定 ==========
    
    # 检查是否可以升级
    CheckCanLevelUp<public>(CurrentExp:int, ExpRequired:int)<decides><transacts>:void =
        CurrentExp >= ExpRequired
    
    # 检查是否达到等级上限
    CheckMaxLevel<public>(CurrentLevel:int)<decides><transacts>:void =
        CurrentLevel >= MAX_LEVEL
    
    # 计算增加经验后的新状态（可能升级）
    AddExperience<public>(State:level_state, ExpGain:int, CurveType:int)<transacts>:level_state =
        NewExp := State.CurrentExp + ExpGain
        var NewLevel:int = State.CurrentLevel
        var RemainingExp:int = NewExp
        
        # 循环处理可能的多级升级
        loop:
            if (NewLevel >= MAX_LEVEL):
                # 达到等级上限
                break
            
            ExpNeeded := GetExpRequiredForLevel(NewLevel + 1, CurveType)
            if (RemainingExp >= ExpNeeded):
                set RemainingExp -= ExpNeeded
                set NewLevel += 1
            else:
                break
        
        NextLevelExp := if (NewLevel >= MAX_LEVEL):
            0
        else:
            GetExpRequiredForLevel(NewLevel + 1, CurveType)
        
        level_state{
            CurrentLevel := NewLevel
            CurrentExp := RemainingExp
            ExpToNextLevel := NextLevelExp
        }
    
    # ========== 经验百分比 ==========
    
    # 计算当前等级经验进度（0.0-1.0）
    GetLevelProgress<public>(State:level_state)<computes>:float =
        if (State.ExpToNextLevel <= 0):
            1.0
        else:
            Progress := Floor(State.CurrentExp) / Floor(State.ExpToNextLevel)
            Clamp(Progress, 0.0, 1.0)
    
    # ========== 经验奖励计算 ==========
    
    # 根据等级差计算经验奖励倍率
    CalculateExpMultiplierByLevelDiff<public>(PlayerLevel:int, TargetLevel:int)<computes>:float =
        LevelDiff := TargetLevel - PlayerLevel
        if (LevelDiff >= 5):
            # 高5级以上：120%
            1.2
        else if (LevelDiff >= 2):
            # 高2-4级：110%
            1.1
        else if (LevelDiff >= -2):
            # 相差2级以内：100%
            1.0
        else if (LevelDiff >= -5):
            # 低3-5级：70%
            0.7
        else if (LevelDiff >= -10):
            # 低6-10级：30%
            0.3
        else:
            # 低10级以上：10%
            0.1
    
    # 计算最终经验奖励
    CalculateFinalExpReward<public>(BaseExp:int, PlayerLevel:int, TargetLevel:int)<computes>:int =
        Multiplier := CalculateExpMultiplierByLevelDiff(PlayerLevel, TargetLevel)
        Floor(Floor(BaseExp) * Multiplier)
    
    # ========== 工具函数 ==========
    
    # 创建初始等级状态
    MakeInitialLevelState<public>(CurveType:int)<transacts>:level_state =
        level_state{
            CurrentLevel := 1
            CurrentExp := 0
            ExpToNextLevel := GetExpRequiredForLevel(2, CurveType)
        }
