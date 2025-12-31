# health_component_simple - 简单生命值管理组件
# 版本: 1.3
# 来源: 模板预置
# 更新: 重命名类避免与 v2 版本冲突，删除私有工具函数，修复语法错误
# 说明: 这是简化版本，请优先使用 HealthComponent.v2.verse

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 生命值变化事件（简化版）
health_changed_event_simple<public> := class<concrete>(scene_event):
    CurrentHealth<public>:int = 0
    MaxHealth<public>:int = 0
    ChangeAmount<public>:int = 0

# 实体死亡事件（简化版）
entity_died_event_simple<public> := class<concrete>(scene_event):

health_component_simple<public> := class<final_super>(component):
    @editable 
    var MaxHealth<public>:int = 100
    
    var CurrentHealth<private>:int = 0
    var IsInvincible<private>:logic = false
    
    # 初始化 - 注意：OnBeginSimulation 需要匹配父类签名
    OnSimulationBegin<public>():void =
        set CurrentHealth = MaxHealth
    
    # 获取当前生命值
    GetCurrentHealth<public>():int = CurrentHealth
    
    # 获取最大生命值
    GetMaxHealth<public>():int = MaxHealth
    
    # 是否存活
    IsAlive<public>():logic = 
        if (CurrentHealth > 0):
            true
        else:
            false
    
    # 获取生命值百分比
    GetHealthPercent<public>():float =
        if (MaxHealth > 0):
            (CurrentHealth * 1.0) / (MaxHealth * 1.0)
        else:
            0.0
    
    # 受到伤害
    TakeDamage<public>(Amount:int):void =
        if (IsInvincible?):
            # 无敌状态，不受伤害
        else:
            set CurrentHealth = Max(0, CurrentHealth - Amount)
            
            Self.Entity.SendUp(health_changed_event_simple{
                CurrentHealth := CurrentHealth,
                MaxHealth := MaxHealth,
                ChangeAmount := -Amount
            })
            
            if (CurrentHealth <= 0):
                Self.Entity.SendUp(entity_died_event_simple{})
    
    # 治疗
    Heal<public>(Amount:int):void =
        OldHealth := CurrentHealth
        set CurrentHealth = Min(MaxHealth, CurrentHealth + Amount)
        ActualHeal := CurrentHealth - OldHealth
        
        if (ActualHeal > 0):
            Self.Entity.SendUp(health_changed_event_simple{
                CurrentHealth := CurrentHealth,
                MaxHealth := MaxHealth,
                ChangeAmount := ActualHeal
            })
    
    # 设置无敌状态
    SetInvincible<public>(Duration:float)<suspends>:void =
        set IsInvincible = true
        Sleep(Duration)
        set IsInvincible = false
    
    # 立即设置无敌
    SetInvincibleImmediate<public>(Value:logic):void =
        set IsInvincible = Value
    
    # 是否无敌
    IsCurrentlyInvincible<public>():logic = IsInvincible
    
    # 设置最大生命值（可选是否同步恢复）
    SetMaxHealth<public>(NewMax:int, HealToFull:logic):void =
        set MaxHealth = NewMax
        if (HealToFull?):
            set CurrentHealth = MaxHealth
        else:
            set CurrentHealth = Min(CurrentHealth, MaxHealth)
    
    # 注意: Max, Min 请直接使用 /Verse.org/Verse 标准库
