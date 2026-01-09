# RPG 生命值系统模块
# 功能：生命回复、最大生命值上限、治疗溢出逻辑

using { /Verse.org/Simulation }

RpgHealth<public> := module:
    
    # ========== 数据结构 ==========
    
    # 生命值状态
    health_state<public> := struct<computes>:
        Current<public>:float = 100.0
        Maximum<public>:float = 100.0
        Shield<public>:float = 0.0
    
    # ========== 状态查询函数 ==========
    
    # 计算生命值百分比
    GetHealthPercent<public>(State:health_state)<computes>:float =
        if (State.Maximum > 0.0):
            Clamp(State.Current / State.Maximum, 0.0, 1.0)
        else:
            0.0
    
    # 检查是否存活
    CheckAlive<public>(State:health_state)<decides><transacts>:void =
        State.Current > 0.0
    
    # 检查是否满血
    CheckFullHealth<public>(State:health_state)<decides><transacts>:void =
        State.Current >= State.Maximum
    
    # ========== 伤害计算 ==========
    
    # 计算伤害后的生命值
    CalculateDamage<public>(CurrentHP:float, MaxHP:float, Damage:float)<computes>:float =
        NewHP := CurrentHP - Max(Damage, 0.0)
        Clamp(NewHP, 0.0, MaxHP)
    
    # 计算带护盾的伤害
    CalculateDamageWithShield<public>(CurrentHP:float, Shield:float, Damage:float)<computes>:tuple(float, float) =
        ClampedDmg := Max(Damage, 0.0)
        ShieldDmg := Min(Shield, ClampedDmg)
        RemainingDmg := ClampedDmg - ShieldDmg
        NewHP := Max(CurrentHP - RemainingDmg, 0.0)
        NewShield := Shield - ShieldDmg
        (NewHP, NewShield)
    
    # ========== 治疗计算 ==========
    
    # 计算治疗后的生命值
    CalculateHeal<public>(CurrentHP:float, MaxHP:float, HealAmount:float)<computes>:float =
        NewHP := CurrentHP + Max(HealAmount, 0.0)
        Min(NewHP, MaxHP)
    
    # 计算溢出治疗量
    CalculateOverheal<public>(CurrentHP:float, MaxHP:float, HealAmount:float)<computes>:float =
        ClampedHeal := Max(HealAmount, 0.0)
        ActualHeal := Min(ClampedHeal, MaxHP - CurrentHP)
        ClampedHeal - ActualHeal
    
    # ========== 工具函数 ==========
    
    # 创建默认生命值状态
    MakeDefaultHealth<public>(MaxHP:float)<transacts>:health_state =
        health_state{
            Current := MaxHP
            Maximum := MaxHP
            Shield := 0.0
        }
    
    # 创建带护盾的生命值状态
    MakeHealthWithShield<public>(MaxHP:float, ShieldAmount:float)<transacts>:health_state =
        health_state{
            Current := MaxHP
            Maximum := MaxHP
            Shield := ShieldAmount
        }
