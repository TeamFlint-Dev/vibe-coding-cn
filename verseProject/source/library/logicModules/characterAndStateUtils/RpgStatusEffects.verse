# RPG 状态效果模块
# 功能：Buff/Debuff 叠加层数、持续时间衰减逻辑

using { /Verse.org/Simulation }

RpgStatusEffects<public> := module:
    
    # ========== 枚举定义 ==========
    
    # 状态效果类型
    EFFECT_TYPE_BUFF<public>:int = 0       # 增益
    EFFECT_TYPE_DEBUFF<public>:int = 1     # 减益
    EFFECT_TYPE_DOT<public>:int = 2        # 持续伤害
    EFFECT_TYPE_HOT<public>:int = 3        # 持续治疗
    
    # 叠加类型
    STACK_TYPE_NONE<public>:int = 0        # 不可叠加
    STACK_TYPE_DURATION<public>:int = 1    # 刷新持续时间
    STACK_TYPE_INTENSITY<public>:int = 2   # 叠加效果强度
    STACK_TYPE_COUNT<public>:int = 3       # 叠加层数
    
    # ========== 数据结构 ==========
    
    # 状态效果
    status_effect<public> := struct<computes>:
        EffectID<public>:int = 0
        EffectType<public>:int = 0
        Duration<public>:float = 0.0            # 剩余持续时间
        MaxDuration<public>:float = 0.0         # 最大持续时间
        StackCount<public>:int = 1              # 当前层数
        MaxStacks<public>:int = 1               # 最大层数
        Intensity<public>:float = 1.0           # 效果强度
        TickInterval<public>:float = 1.0        # DOT/HOT跳动间隔
        LastTickTime<public>:float = 0.0        # 上次跳动时间
        StackType<public>:int = 0               # 叠加类型
    
    # 效果堆栈信息
    effect_stack_info<public> := struct<computes>:
        CurrentStacks<public>:int = 1
        MaxStacks<public>:int = 1
        PerStackBonus<public>:float = 0.0       # 每层加成
    
    # ========== 常量定义 ==========
    
    # 默认持续时间
    DEFAULT_BUFF_DURATION<public>:float = 30.0
    DEFAULT_DEBUFF_DURATION<public>:float = 10.0
    DEFAULT_DOT_DURATION<public>:float = 15.0
    
    # 默认跳动间隔
    DEFAULT_TICK_INTERVAL<public>:float = 1.0
    
    # 最大叠加层数
    DEFAULT_MAX_STACKS<public>:int = 5
    
    # ========== 持续时间管理 ==========
    
    # 更新状态效果时间
    UpdateEffectDuration<public>(Effect:status_effect, DeltaTime:float)<transacts>:status_effect =
        NewDuration := Max(Effect.Duration - DeltaTime, 0.0)
        status_effect{
            EffectID := Effect.EffectID
            EffectType := Effect.EffectType
            Duration := NewDuration
            MaxDuration := Effect.MaxDuration
            StackCount := Effect.StackCount
            MaxStacks := Effect.MaxStacks
            Intensity := Effect.Intensity
            TickInterval := Effect.TickInterval
            LastTickTime := Effect.LastTickTime
            StackType := Effect.StackType
        }
    
    # 检查效果是否过期
    CheckEffectExpired<public>(Effect:status_effect)<decides><transacts>:void =
        Effect.Duration <= 0.0
    
    # 刷新效果持续时间
    RefreshEffectDuration<public>(Effect:status_effect)<transacts>:status_effect =
        status_effect{
            EffectID := Effect.EffectID
            EffectType := Effect.EffectType
            Duration := Effect.MaxDuration  # 重置为最大时长
            MaxDuration := Effect.MaxDuration
            StackCount := Effect.StackCount
            MaxStacks := Effect.MaxStacks
            Intensity := Effect.Intensity
            TickInterval := Effect.TickInterval
            LastTickTime := Effect.LastTickTime
            StackType := Effect.StackType
        }
    
    # ========== 叠加逻辑 ==========
    
    # 增加效果层数
    AddEffectStack<public>(Effect:status_effect)<transacts>:status_effect =
        NewStackCount := Min(Effect.StackCount + 1, Effect.MaxStacks)
        status_effect{
            EffectID := Effect.EffectID
            EffectType := Effect.EffectType
            Duration := Effect.Duration
            MaxDuration := Effect.MaxDuration
            StackCount := NewStackCount
            MaxStacks := Effect.MaxStacks
            Intensity := Effect.Intensity
            TickInterval := Effect.TickInterval
            LastTickTime := Effect.LastTickTime
            StackType := Effect.StackType
        }
    
    # 减少效果层数
    RemoveEffectStack<public>(Effect:status_effect, Count:int)<transacts>:status_effect =
        NewStackCount := Max(Effect.StackCount - Count, 0)
        status_effect{
            EffectID := Effect.EffectID
            EffectType := Effect.EffectType
            Duration := Effect.Duration
            MaxDuration := Effect.MaxDuration
            StackCount := NewStackCount
            MaxStacks := Effect.MaxStacks
            Intensity := Effect.Intensity
            TickInterval := Effect.TickInterval
            LastTickTime := Effect.LastTickTime
            StackType := Effect.StackType
        }
    
    # 应用新的相同效果（根据叠加类型处理）
    ApplyStackableEffect<public>(CurrentEffect:status_effect, NewEffect:status_effect)<transacts>:status_effect =
        if (CurrentEffect.StackType = STACK_TYPE_DURATION):
            # 刷新时长
            RefreshEffectDuration(CurrentEffect)
        else if (CurrentEffect.StackType = STACK_TYPE_COUNT):
            # 增加层数并刷新时长
            NewEffect := AddEffectStack(CurrentEffect)
            RefreshEffectDuration(NewEffect)
        else if (CurrentEffect.StackType = STACK_TYPE_INTENSITY):
            # 叠加强度
            NewIntensity := Min(CurrentEffect.Intensity + NewEffect.Intensity, 5.0)
            status_effect{
                EffectID := CurrentEffect.EffectID
                EffectType := CurrentEffect.EffectType
                Duration := CurrentEffect.MaxDuration
                MaxDuration := CurrentEffect.MaxDuration
                StackCount := CurrentEffect.StackCount
                MaxStacks := CurrentEffect.MaxStacks
                Intensity := NewIntensity
                TickInterval := CurrentEffect.TickInterval
                LastTickTime := CurrentEffect.LastTickTime
                StackType := CurrentEffect.StackType
            }
        else:
            # 不可叠加，直接刷新时长
            RefreshEffectDuration(CurrentEffect)
    
    # ========== 效果强度计算 ==========
    
    # 计算基于层数的效果强度
    CalculateStackIntensity<public>(BaseIntensity:float, StackCount:int, PerStackBonus:float)<computes>:float =
        BaseIntensity + Floor(StackCount - 1) * PerStackBonus
    
    # 计算叠加后的总效果
    CalculateTotalEffectValue<public>(BaseValue:float, StackInfo:effect_stack_info)<computes>:float =
        TotalBonus := CalculateStackIntensity(0.0, StackInfo.CurrentStacks, StackInfo.PerStackBonus)
        BaseValue + TotalBonus
    
    # ========== DOT/HOT 处理 ==========
    
    # 检查是否应该触发跳动
    ShouldTick<public>(Effect:status_effect, CurrentTime:float)<decides><transacts>:void =
        ElapsedTime := CurrentTime - Effect.LastTickTime
        ElapsedTime >= Effect.TickInterval
    
    # 更新跳动时间
    UpdateTickTime<public>(Effect:status_effect, CurrentTime:float)<transacts>:status_effect =
        status_effect{
            EffectID := Effect.EffectID
            EffectType := Effect.EffectType
            Duration := Effect.Duration
            MaxDuration := Effect.MaxDuration
            StackCount := Effect.StackCount
            MaxStacks := Effect.MaxStacks
            Intensity := Effect.Intensity
            TickInterval := Effect.TickInterval
            LastTickTime := CurrentTime
            StackType := Effect.StackType
        }
    
    # 计算DOT/HOT每跳伤害/治疗
    CalculateTickValue<public>(Effect:status_effect, BaseDamage:float)<computes>:float =
        # 基础值 * 强度 * 层数
        BaseDamage * Effect.Intensity * Floor(Effect.StackCount)
    
    # ========== 效果持续时间衰减 ==========
    
    # 计算衰减后的持续时间（越多相同效果，持续时间越短）
    CalculateDiminishedDuration<public>(BaseDuration:float, ApplicationCount:int)<computes>:float =
        if (ApplicationCount <= 1):
            BaseDuration
        else if (ApplicationCount = 2):
            BaseDuration * 0.75  # 第二次75%时长
        else if (ApplicationCount = 3):
            BaseDuration * 0.5   # 第三次50%时长
        else:
            BaseDuration * 0.25  # 第四次及以后25%时长
    
    # ========== 净化/驱散 ==========
    
    # 检查效果是否可被净化
    CheckCanDispel<public>(Effect:status_effect, DispelType:int)<decides><transacts>:void =
        Effect.EffectType = DispelType
    
    # 净化时减少层数
    DispelEffectStacks<public>(Effect:status_effect, DispelCount:int)<transacts>:status_effect =
        RemoveEffectStack(Effect, DispelCount)
    
    # ========== 工具函数 ==========
    
    # 创建Buff效果
    MakeBuffEffect<public>(EffectID:int, Duration:float, Intensity:float)<transacts>:status_effect =
        status_effect{
            EffectID := EffectID
            EffectType := EFFECT_TYPE_BUFF
            Duration := Duration
            MaxDuration := Duration
            StackCount := 1
            MaxStacks := DEFAULT_MAX_STACKS
            Intensity := Intensity
            TickInterval := DEFAULT_TICK_INTERVAL
            LastTickTime := 0.0
            StackType := STACK_TYPE_DURATION
        }
    
    # 创建DOT效果
    MakeDOTEffect<public>(EffectID:int, Duration:float, TickDamage:float, TickInterval:float)<transacts>:status_effect =
        status_effect{
            EffectID := EffectID
            EffectType := EFFECT_TYPE_DOT
            Duration := Duration
            MaxDuration := Duration
            StackCount := 1
            MaxStacks := DEFAULT_MAX_STACKS
            Intensity := TickDamage
            TickInterval := TickInterval
            LastTickTime := 0.0
            StackType := STACK_TYPE_COUNT
        }
    
    # 创建层数堆栈信息
    MakeStackInfo<public>(Current:int, Max:int, PerStack:float)<transacts>:effect_stack_info =
        effect_stack_info{
            CurrentStacks := Current
            MaxStacks := Max
            PerStackBonus := PerStack
        }
