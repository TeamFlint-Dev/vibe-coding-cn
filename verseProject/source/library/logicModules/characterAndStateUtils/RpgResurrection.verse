# RPG 复活系统模块
# 功能：复活时间惩罚计算、虚弱状态计算

using { /Verse.org/Simulation }

RpgResurrection<public> := module:
    
    # ========== 数据结构 ==========
    
    # 复活状态
    resurrection_state<public> := struct<computes>:
        DeathCount<public>:int = 0              # 连续死亡次数
        LastDeathTime<public>:float = 0.0       # 上次死亡时间
        TotalDeaths<public>:int = 0             # 累计死亡次数
        ResurrectionPenalty<public>:float = 0.0 # 当前惩罚系数
    
    # 虚弱状态
    weakness_state<public> := struct<computes>:
        Duration<public>:float = 0.0            # 虚弱持续时间
        HealthPenalty<public>:float = 0.0       # 生命值惩罚（百分比）
        DamagePenalty<public>:float = 0.0       # 伤害惩罚（百分比）
        DefensePenalty<public>:float = 0.0      # 防御惩罚（百分比）
        MovementPenalty<public>:float = 0.0     # 移动速度惩罚（百分比）
    
    # ========== 常量定义 ==========
    
    # 基础复活时间（秒）
    BASE_RESPAWN_TIME<public>:float = 5.0
    
    # 每次额外死亡增加的时间（秒）
    RESPAWN_TIME_INCREMENT<public>:float = 3.0
    
    # 最大复活时间（秒）
    MAX_RESPAWN_TIME<public>:float = 30.0
    
    # 死亡计数重置时间（秒）
    DEATH_COUNTER_RESET_TIME<public>:float = 300.0  # 5分钟
    
    # 虚弱状态持续时间（秒）
    BASE_WEAKNESS_DURATION<public>:float = 30.0
    
    # 虚弱状态惩罚
    WEAKNESS_HEALTH_PENALTY<public>:float = 0.5   # 最大生命值-50%
    WEAKNESS_DAMAGE_PENALTY<public>:float = 0.3   # 伤害-30%
    WEAKNESS_DEFENSE_PENALTY<public>:float = 0.2  # 防御-20%
    WEAKNESS_MOVEMENT_PENALTY<public>:float = 0.2 # 移动速度-20%
    
    # ========== 复活时间计算 ==========
    
    # 计算复活时间
    CalculateRespawnTime<public>(DeathCount:int)<computes>:float =
        RespawnTime := BASE_RESPAWN_TIME + Floor(DeathCount) * RESPAWN_TIME_INCREMENT
        Min(RespawnTime, MAX_RESPAWN_TIME)
    
    # 根据等级调整复活时间
    CalculateRespawnTimeWithLevel<public>(DeathCount:int, PlayerLevel:int)<computes>:float =
        BaseTime := CalculateRespawnTime(DeathCount)
        # 等级越高，复活时间越长（每10级+1秒）
        LevelPenalty := Floor(PlayerLevel / 10) * 1.0
        Min(BaseTime + LevelPenalty, MAX_RESPAWN_TIME)
    
    # ========== 死亡计数管理 ==========
    
    # 检查是否应该重置死亡计数
    ShouldResetDeathCounter<public>(CurrentTime:float, LastDeathTime:float)<decides><transacts>:void =
        ElapsedTime := CurrentTime - LastDeathTime
        ElapsedTime >= DEATH_COUNTER_RESET_TIME
    
    # 更新复活状态（记录新的死亡）
    RecordDeath<public>(State:resurrection_state, CurrentTime:float)<transacts>:resurrection_state =
        ShouldReset := if (ShouldResetDeathCounter[CurrentTime, State.LastDeathTime]) then true else false
        NewDeathCount := if (ShouldReset) then 1 else State.DeathCount + 1
        
        resurrection_state{
            DeathCount := NewDeathCount
            LastDeathTime := CurrentTime
            TotalDeaths := State.TotalDeaths + 1
            ResurrectionPenalty := CalculateRespawnTime(NewDeathCount)
        }
    
    # ========== 虚弱状态计算 ==========
    
    # 计算虚弱状态强度（基于死亡次数）
    CalculateWeaknessDuration<public>(DeathCount:int)<computes>:float =
        # 连续死亡次数越多，虚弱时间越长
        Duration := BASE_WEAKNESS_DURATION + Floor(DeathCount - 1) * 10.0
        Min(Duration, 120.0)  # 最多2分钟虚弱
    
    # 创建虚弱状态
    CreateWeaknessState<public>(DeathCount:int)<transacts>:weakness_state =
        Duration := CalculateWeaknessDuration(DeathCount)
        # 死亡次数越多，惩罚越重（但有上限）
        IntensityMultiplier := Min(Floor(DeathCount) / 3.0, 1.5)
        
        weakness_state{
            Duration := Duration
            HealthPenalty := WEAKNESS_HEALTH_PENALTY * IntensityMultiplier
            DamagePenalty := WEAKNESS_DAMAGE_PENALTY * IntensityMultiplier
            DefensePenalty := WEAKNESS_DEFENSE_PENALTY * IntensityMultiplier
            MovementPenalty := WEAKNESS_MOVEMENT_PENALTY * IntensityMultiplier
        }
    
    # ========== 惩罚应用 ==========
    
    # 应用虚弱惩罚到最大生命值
    ApplyWeaknessToMaxHealth<public>(BaseMaxHealth:float, Weakness:weakness_state)<computes>:float =
        Penalty := Clamp(Weakness.HealthPenalty, 0.0, 0.75)
        BaseMaxHealth * (1.0 - Penalty)
    
    # 应用虚弱惩罚到伤害
    ApplyWeaknessToDamage<public>(BaseDamage:float, Weakness:weakness_state)<computes>:float =
        Penalty := Clamp(Weakness.DamagePenalty, 0.0, 0.75)
        BaseDamage * (1.0 - Penalty)
    
    # 应用虚弱惩罚到防御
    ApplyWeaknessToDefense<public>(BaseDefense:float, Weakness:weakness_state)<computes>:float =
        Penalty := Clamp(Weakness.DefensePenalty, 0.0, 0.75)
        BaseDefense * (1.0 - Penalty)
    
    # 应用虚弱惩罚到移动速度
    ApplyWeaknessToMovement<public>(BaseSpeed:float, Weakness:weakness_state)<computes>:float =
        Penalty := Clamp(Weakness.MovementPenalty, 0.0, 0.75)
        BaseSpeed * (1.0 - Penalty)
    
    # ========== 复活点计算 ==========
    
    # 计算复活点距离（基于死亡位置和可用复活点）
    # 返回应该使用的复活点索引
    SelectRespawnPoint<public>(DeathCount:int, AvailablePoints:int)<computes>:int =
        if (AvailablePoints <= 0):
            0
        else if (DeathCount <= 1):
            # 首次死亡：最近的复活点
            0
        else:
            # 多次死亡：随机选择（避免复活点守尸）
            # 简单实现：基于死亡次数取模
            Floor(DeathCount) mod AvailablePoints
    
    # ========== 复活惩罚减免 ==========
    
    # 检查是否有复活惩罚减免道具
    ApplyResurrectionReduction<public>(BaseTime:float, ReductionPercent:float)<computes>:float =
        ClampedReduction := Clamp(ReductionPercent, 0.0, 0.9)  # 最多减免90%
        ReducedTime := BaseTime * (1.0 - ClampedReduction)
        Max(ReducedTime, 1.0)  # 最少1秒
    
    # ========== 工具函数 ==========
    
    # 创建初始复活状态
    MakeInitialResurrectionState<public>()<transacts>:resurrection_state =
        resurrection_state{
            DeathCount := 0
            LastDeathTime := 0.0
            TotalDeaths := 0
            ResurrectionPenalty := 0.0
        }
    
    # 检查是否在虚弱状态中
    CheckIsWeakened<public>(Weakness:weakness_state, ElapsedTime:float)<decides><transacts>:void =
        ElapsedTime < Weakness.Duration
