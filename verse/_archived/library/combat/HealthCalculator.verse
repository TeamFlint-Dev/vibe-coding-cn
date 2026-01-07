using { /Verse.org/SceneGraph }

# HealthCalculator - 生命值计算 Helper
# 版本: 2.3
# 更新时间: 2025-12-29
# 更新: 修复struct成员缺少初始值，删除冲突的私有工具函数，修复logic返回类型
# 来源: API 一致性修复 + Helper 分类重构
#
# 设计目的:
# 1. 提供纯函数的生命值计算逻辑
# 2. 不直接调用 UEFN API（那是 Wrapper 的职责）
# 3. 所有函数无副作用，输入决定输出
# 4. 使用 float 类型与真实 API 保持一致

using { /Verse.org/Simulation }

# ═══════════════════════════════════════════════════════════
# 数据结构
# ═══════════════════════════════════════════════════════════

# 生命值变化结果（纯数据，无副作用）
health_change_result<public> := struct<concrete>:
    NewHealth<public>:float = 0.0           # 变化后的生命值
    ActualChange<public>:float = 0.0        # 实际变化量（正=治疗，负=伤害）
    WasBlocked<public>:logic = false        # 是否被阻挡（无敌等）
    IsDead<public>:logic = false            # 是否死亡
    Overkill<public>:float = 0.0            # 超额伤害（用于溅射等）

# 伤害来源信息
damage_source_info<public> := struct<concrete>:
    SourceType<public>:string = ""          # "melee", "ranged", "ability", "environment", "true"
    SourceEntity<public>:?entity = false    # 来源实体
    CanCrit<public>:logic = false           # 是否可暴击
    IgnoresArmor<public>:logic = false      # 是否无视护甲

# ═══════════════════════════════════════════════════════════
# HealthCalculator 模块 - 纯函数，无状态
# 注意: 此模块不调用 UEFN API，仅进行数学计算
# API 调用请使用 CharacterWrapper
# ═══════════════════════════════════════════════════════════

HealthCalculator<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 核心计算函数
    # ═══════════════════════════════════════════════════════
    
    # 计算伤害结果（不修改任何状态）
    # 输入: 当前状态 + 伤害数值 + 条件
    # 输出: 计算结果（供 Component 使用）
    CalculateDamageResult<public>(
        CurrentHealth:float,
        MaxHealth:float,
        IncomingDamage:float,
        IsInvincible:logic
    ):health_change_result =
        
        # 判断是否已死亡
        DeadBefore := if (CurrentHealth <= 0.0) then true else false
        
        # 边界检查：无效输入
        if (IncomingDamage <= 0.0):
            health_change_result{
                NewHealth := CurrentHealth,
                ActualChange := 0.0,
                WasBlocked := false,
                IsDead := DeadBefore,
                Overkill := 0.0
            }
        # 无敌检查
        else if (IsInvincible?):
            health_change_result{
                NewHealth := CurrentHealth,
                ActualChange := 0.0,
                WasBlocked := true,
                IsDead := false,
                Overkill := 0.0
            }
        # 已死亡检查
        else if (DeadBefore?):
            health_change_result{
                NewHealth := 0.0,
                ActualChange := 0.0,
                WasBlocked := true,
                IsDead := true,
                Overkill := IncomingDamage
            }
        else:
            # 计算实际伤害
            ActualDamage := Min(CurrentHealth, IncomingDamage)
            NewHP := CurrentHealth - ActualDamage
            OverkillAmount := Max(0.0, IncomingDamage - CurrentHealth)
            DeadAfter := if (NewHP <= 0.0) then true else false
            
            health_change_result{
                NewHealth := NewHP,
                ActualChange := -ActualDamage,
                WasBlocked := false,
                IsDead := DeadAfter,
                Overkill := OverkillAmount
            }
    
    # 计算治疗结果（不修改任何状态）
    CalculateHealResult<public>(
        CurrentHealth:float,
        MaxHealth:float,
        HealAmount:float
    ):health_change_result =
        
        # 判断是否已死亡
        DeadBefore := if (CurrentHealth <= 0.0) then true else false
        
        # 边界检查
        if (HealAmount <= 0.0):
            health_change_result{
                NewHealth := CurrentHealth,
                ActualChange := 0.0,
                WasBlocked := false,
                IsDead := DeadBefore,
                Overkill := 0.0
            }
        # 已满血检查
        else if (CurrentHealth >= MaxHealth):
            health_change_result{
                NewHealth := MaxHealth,
                ActualChange := 0.0,
                WasBlocked := true,  # 溢出视为"阻挡"
                IsDead := false,
                Overkill := 0.0
            }
        else:
            # 计算实际治疗
            ActualHeal := Min(HealAmount, MaxHealth - CurrentHealth)
            NewHP := CurrentHealth + ActualHeal
            
            health_change_result{
                NewHealth := NewHP,
                ActualChange := ActualHeal,
                WasBlocked := false,
                IsDead := false,
                Overkill := 0.0
            }
    
    # ═══════════════════════════════════════════════════════
    # 判定函数
    # ═══════════════════════════════════════════════════════
    
    # 判定伤害是否致死
    IsLethalDamage<public>(CurrentHealth:float, Damage:float, IsInvincible:logic):logic =
        if (IsInvincible?):
            false
        else if (Damage >= CurrentHealth):
            true
        else:
            false
    
    # 判定是否存活
    IsAlive<public>(CurrentHealth:float):logic =
        if (CurrentHealth > 0.0):
            true
        else:
            false
    
    # 判定是否满血
    IsFullHealth<public>(CurrentHealth:float, MaxHealth:float):logic =
        if (CurrentHealth >= MaxHealth):
            true
        else:
            false
    
    # 判定是否低血量（可配置阈值）
    IsLowHealth<public>(CurrentHealth:float, MaxHealth:float, Threshold:float):logic =
        if (MaxHealth <= 0.0):
            true
        else if ((CurrentHealth / MaxHealth) <= Threshold):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 数值计算
    # ═══════════════════════════════════════════════════════
    
    # 计算生命值百分比
    GetHealthPercent<public>(CurrentHealth:float, MaxHealth:float):float =
        if (MaxHealth <= 0.0):
            0.0
        else:
            Clamp(CurrentHealth / MaxHealth, 0.0, 1.0)
    
    # 计算缺失生命值
    GetMissingHealth<public>(CurrentHealth:float, MaxHealth:float):float =
        Max(0.0, MaxHealth - CurrentHealth)
    
    # 计算缺失生命值百分比
    GetMissingHealthPercent<public>(CurrentHealth:float, MaxHealth:float):float =
        if (MaxHealth <= 0.0):
            1.0
        else:
            1.0 - GetHealthPercent(CurrentHealth, MaxHealth)
    
    # 钳制生命值到有效范围
    ClampHealth<public>(Health:float, MaxHealth:float):float =
        Clamp(Health, 0.0, MaxHealth)
    
    # 计算基于缺失生命的加成（常见机制：血越少伤害越高）
    # MissingHealthRatio: 0.0~1.0 表示每1%缺失生命增加多少加成
    CalculateMissingHealthBonus<public>(
        CurrentHealth:float, 
        MaxHealth:float, 
        BonusPerPercent:float
    ):float =
        MissingPercent := GetMissingHealthPercent(CurrentHealth, MaxHealth)
        MissingPercent * BonusPerPercent * 100.0
    
    # ═══════════════════════════════════════════════════════
    # 生命值变化预测
    # ═══════════════════════════════════════════════════════
    
    # 预测经过N次伤害后的生命值
    PredictHealthAfterHits<public>(CurrentHealth:float, DamagePerHit:float, HitCount:int):float =
        TotalDamage := DamagePerHit * (HitCount * 1.0)
        Max(0.0, CurrentHealth - TotalDamage)
    
    # 计算击杀所需次数
    HitsToKill<public>(CurrentHealth:float, DamagePerHit:float):int =
        if (DamagePerHit <= 0.0):
            -1  # 无法击杀
        else:
            if (Result := Ceil[CurrentHealth / DamagePerHit]) then Result else 1
    
    # 注意: Min, Max, Clamp, Ceil 请直接使用 /Verse.org/Verse 标准库
