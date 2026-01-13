# RPG 耐力系统模块
# 功能：耐力消耗、跑步/攀爬消耗率、回复延迟逻辑

using { /Verse.org/Simulation }

RpgStamina<public> := module:
    
    # ========== 数据结构 ==========
    
    # 耐力状态
    stamina_state<public> := struct<computes>:
        Current<public>:float = 100.0           # 当前耐力
        Maximum<public>:float = 100.0           # 最大耐力
        RegenRate<public>:float = 10.0          # 回复速率（每秒）
        LastActionTime<public>:float = 0.0      # 上次消耗耐力的时间
        IsRegenerating<public>:logic = true     # 是否正在回复
    
    # 行动类型
    ACTION_TYPE_SPRINT<public>:int = 0      # 冲刺/跑步
    ACTION_TYPE_JUMP<public>:int = 1        # 跳跃
    ACTION_TYPE_DODGE<public>:int = 2       # 闪避
    ACTION_TYPE_CLIMB<public>:int = 3       # 攀爬
    ACTION_TYPE_SWIM<public>:int = 4        # 游泳
    ACTION_TYPE_ATTACK<public>:int = 5      # 攻击
    
    # ========== 常量定义 ==========
    
    # 基础消耗率（每秒）
    SPRINT_DRAIN_RATE<public>:float = 20.0      # 冲刺：20/秒
    CLIMB_DRAIN_RATE<public>:float = 15.0       # 攀爬：15/秒
    SWIM_DRAIN_RATE<public>:float = 10.0        # 游泳：10/秒
    
    # 瞬时消耗
    JUMP_COST<public>:float = 15.0              # 跳跃：15点
    DODGE_COST<public>:float = 25.0             # 闪避：25点
    ATTACK_COST<public>:float = 5.0             # 攻击：5点
    
    # 回复延迟（秒）
    REGEN_DELAY_AFTER_SPRINT<public>:float = 2.0   # 冲刺后2秒开始回复
    REGEN_DELAY_AFTER_ACTION<public>:float = 1.0   # 其他动作后1秒开始回复
    
    # 基础回复速率
    BASE_REGEN_RATE<public>:float = 10.0        # 基础回复：10/秒
    
    # 耐力阈值
    LOW_STAMINA_THRESHOLD<public>:float = 0.25  # 低耐力阈值（25%）
    
    # ========== 耐力消耗 ==========
    
    # 获取行动的耐力消耗（瞬时）
    GetActionCost<public>(ActionType:int)<computes>:float =
        if (ActionType = ACTION_TYPE_JUMP):
            JUMP_COST
        else if (ActionType = ACTION_TYPE_DODGE):
            DODGE_COST
        else if (ActionType = ACTION_TYPE_ATTACK):
            ATTACK_COST
        else:
            0.0
    
    # 获取持续行动的消耗率（每秒）
    GetActionDrainRate<public>(ActionType:int)<computes>:float =
        if (ActionType = ACTION_TYPE_SPRINT):
            SPRINT_DRAIN_RATE
        else if (ActionType = ACTION_TYPE_CLIMB):
            CLIMB_DRAIN_RATE
        else if (ActionType = ACTION_TYPE_SWIM):
            SWIM_DRAIN_RATE
        else:
            0.0
    
    # 计算持续消耗（基于时间）
    CalculateContinuousDrain<public>(ActionType:int, DeltaTime:float)<computes>:float =
        DrainRate := GetActionDrainRate(ActionType)
        DrainRate * DeltaTime
    
    # 检查是否有足够耐力执行行动
    CheckHasStamina<public>(Current:float, ActionType:int)<decides><transacts>:void =
        Cost := GetActionCost(ActionType)
        Current >= Cost
    
    # ========== 耐力回复 ==========
    
    # 计算回复延迟
    GetRegenDelay<public>(ActionType:int)<computes>:float =
        if (ActionType = ACTION_TYPE_SPRINT):
            REGEN_DELAY_AFTER_SPRINT
        else:
            REGEN_DELAY_AFTER_ACTION
    
    # 检查是否应该开始回复
    ShouldStartRegen<public>(CurrentTime:float, LastActionTime:float, ActionType:int)<decides><transacts>:void =
        ElapsedTime := CurrentTime - LastActionTime
        Delay := GetRegenDelay(ActionType)
        ElapsedTime >= Delay
    
    # 计算回复量
    CalculateRegenAmount<public>(RegenRate:float, DeltaTime:float)<computes>:float =
        RegenRate * DeltaTime
    
    # ========== 耐力状态更新 ==========
    
    # 消耗耐力（瞬时行动）
    ConsumeStamina<public>(State:stamina_state, ActionType:int, CurrentTime:float)<transacts>:stamina_state =
        Cost := GetActionCost(ActionType)
        NewCurrent := Max(State.Current - Cost, 0.0)
        
        stamina_state{
            Current := NewCurrent
            Maximum := State.Maximum
            RegenRate := State.RegenRate
            LastActionTime := CurrentTime
            IsRegenerating := false
        }
    
    # 持续消耗耐力（跑步、攀爬等）
    DrainStamina<public>(State:stamina_state, ActionType:int, DeltaTime:float, CurrentTime:float)<transacts>:stamina_state =
        Drain := CalculateContinuousDrain(ActionType, DeltaTime)
        NewCurrent := Max(State.Current - Drain, 0.0)
        
        stamina_state{
            Current := NewCurrent
            Maximum := State.Maximum
            RegenRate := State.RegenRate
            LastActionTime := CurrentTime
            IsRegenerating := false
        }
    
    # 回复耐力
    RegenerateStamina<public>(State:stamina_state, DeltaTime:float, CurrentTime:float, LastActionType:int)<transacts>:stamina_state =
        # 检查是否应该开始回复
        ShouldRegen := if (ShouldStartRegen[CurrentTime, State.LastActionTime, LastActionType]) then true else false
        
        if (ShouldRegen):
            RegenAmount := CalculateRegenAmount(State.RegenRate, DeltaTime)
            NewCurrent := Min(State.Current + RegenAmount, State.Maximum)
            stamina_state{
                Current := NewCurrent
                Maximum := State.Maximum
                RegenRate := State.RegenRate
                LastActionTime := State.LastActionTime
                IsRegenerating := true
            }
        else:
            State
    
    # ========== 耐力查询 ==========
    
    # 计算耐力百分比
    GetStaminaPercent<public>(State:stamina_state)<computes>:float =
        if (State.Maximum > 0.0):
            Clamp(State.Current / State.Maximum, 0.0, 1.0)
        else:
            0.0
    
    # 检查是否耐力不足
    CheckLowStamina<public>(State:stamina_state)<decides><transacts>:void =
        Percent := GetStaminaPercent(State)
        Percent < LOW_STAMINA_THRESHOLD
    
    # 检查是否耐力已耗尽
    CheckStaminaDepleted<public>(State:stamina_state)<decides><transacts>:void =
        State.Current <= 0.0
    
    # 检查是否耐力已满
    CheckStaminaFull<public>(State:stamina_state)<decides><transacts>:void =
        State.Current >= State.Maximum
    
    # ========== 耐力加成 ==========
    
    # 根据属性计算最大耐力
    CalculateMaxStamina<public>(BaseStamina:float, VitalityBonus:float, AgilityBonus:float)<computes>:float =
        # 体力每点+5最大耐力，敏捷每点+2最大耐力
        BaseStamina + VitalityBonus * 5.0 + AgilityBonus * 2.0
    
    # 根据精神计算回复速率
    CalculateRegenRate<public>(BaseRegen:float, SpiritBonus:float)<computes>:float =
        # 精神每点+0.5回复速率
        BaseRegen + SpiritBonus * 0.5
    
    # ========== 工具函数 ==========
    
    # 创建默认耐力状态
    MakeDefaultStaminaState<public>(MaxStamina:float)<transacts>:stamina_state =
        stamina_state{
            Current := MaxStamina
            Maximum := MaxStamina
            RegenRate := BASE_REGEN_RATE
            LastActionTime := 0.0
            IsRegenerating := true
        }
    
    # 重置耐力到满值
    ResetStamina<public>(State:stamina_state)<transacts>:stamina_state =
        stamina_state{
            Current := State.Maximum
            Maximum := State.Maximum
            RegenRate := State.RegenRate
            LastActionTime := 0.0
            IsRegenerating := true
        }
