# health_component - 生命值管理组件
# 版本: 1.0
# 来源: 模板预置

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 依赖的事件类（见 Events/HealthEvents.verse）

health_component<public> := class(component):
    @editable 
    var MaxHealth<public>:int = 100
    
    var CurrentHealth<private>:int = 0
    var IsInvincible<private>:logic = false
    
    # 初始化
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        set CurrentHealth = MaxHealth
    
    # 获取当前生命值
    GetCurrentHealth<public>():int = CurrentHealth
    
    # 获取最大生命值
    GetMaxHealth<public>():int = MaxHealth
    
    # 是否存活
    IsAlive<public>():logic = CurrentHealth > 0
    
    # 获取生命值百分比
    GetHealthPercent<public>():float =
        if MaxHealth > 0:
            return CurrentHealth / MaxHealth
        return 0.0
    
    # 受到伤害
    TakeDamage<public>(Amount:int):void =
        if IsInvincible:
            return
        
        set CurrentHealth = Max(0, CurrentHealth - Amount)
        
        if (Owner := GetOwner()):
            Owner.SendUp(health_changed_event{
                CurrentHealth := CurrentHealth,
                MaxHealth := MaxHealth,
                ChangeAmount := -Amount
            })
            
            if CurrentHealth <= 0:
                Owner.SendUp(entity_died_event{})
    
    # 治疗
    Heal<public>(Amount:int):void =
        OldHealth := CurrentHealth
        set CurrentHealth = Min(MaxHealth, CurrentHealth + Amount)
        ActualHeal := CurrentHealth - OldHealth
        
        if ActualHeal > 0:
            if (Owner := GetOwner()):
                Owner.SendUp(health_changed_event{
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
    IsCurrentlyInvincible<public>():logic =
        return IsInvincible
    
    # 设置最大生命值（可选是否同步恢复）
    SetMaxHealth<public>(NewMax:int, HealToFull:logic):void =
        set MaxHealth = NewMax
        if HealToFull:
            set CurrentHealth = MaxHealth
        else:
            set CurrentHealth = Min(CurrentHealth, MaxHealth)

    # 私有工具
    Max<private>(A:int, B:int):int = if A > B then A else B
    Min<private>(A:int, B:int):int = if A < B then A else B
