using { Helpers }
using { Wrappers }

# health_component - 生命值管理组件 (重构版)
# 版本: 2.3
# 更新: 修复 OnBeginSimulation 签名，修复 Int[] 可失败调用，修复 option 解包
# 重构时间: 2025-12-29
# 来源: CHANGE-004 (Helper/Component 职责重构)
#
# 设计原则:
# - Component 只负责：状态管理 + 事件响应 + 事件派发
# - 逻辑计算委托给 HealthCalculator
# - 真实效果委托给 CharacterWrapper
# - 通过绑定机制与真实游戏对象关联

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Verse.org/Verse }  # Floor, Int 转换
using { /Fortnite.com/Characters }

# ═══════════════════════════════════════════════════════════
# 组件配置
# ═══════════════════════════════════════════════════════════

# 生命值组件配置
health_component_config<public> := struct<concrete>:
    MaxHealth<public>:int = 100
    StartHealthPercent<public>:float = 1.0    # 初始生命百分比
    LowHealthThreshold<public>:float = 0.3    # 低血量阈值
    EnableRealDamage<public>:logic = true     # 是否同步到真实角色

# ═══════════════════════════════════════════════════════════
# 组件事件
# ═══════════════════════════════════════════════════════════

# 生命值变化事件（增强版）
health_changed_event<public> := class<concrete>(scene_event):
    CurrentHealth<public>:int = 0
    MaxHealth<public>:int = 0
    ChangeAmount<public>:int = 0          # 正=治疗，负=伤害
    ChangeSource<public>:string = ""      # 来源标识
    WasBlocked<public>:logic = false      # 是否被阻挡

# 实体死亡事件（增强版）
entity_died_event<public> := class<concrete>(scene_event):
    FinalDamage<public>:int = 0           # 致死伤害
    Overkill<public>:int = 0              # 超额伤害
    DeathSource<public>:string = ""       # 死亡来源

# 低血量警告事件
low_health_event<public> := class<concrete>(scene_event):
    CurrentHealth<public>:int = 0
    MaxHealth<public>:int = 0
    HealthPercent<public>:float = 0.0

# ═══════════════════════════════════════════════════════════
# 生命值组件
# ═══════════════════════════════════════════════════════════

health_component<public> := class<final_super>(component):
    
    # ═══════════ 配置（可编辑）═══════════
    @editable 
    var Config<public>:health_component_config = health_component_config{}
    
    # ═══════════ 状态变量 ═══════════
    var CurrentHealth<private>:int = 0
    var MaxHealth<private>:int = 100
    var IsInvincible<private>:logic = false
    var IsDead<private>:logic = false
    var WasLowHealth<private>:logic = false   # 用于追踪低血量状态变化
    
    # ═══════════ 绑定对象（可选）═══════════
    # 绑定真实 UEFN 角色，实现双向同步
    var BoundCharacter<public>:?fort_character = false
    
    # ═══════════════════════════════════════════════════════
    # 生命周期
    # ═══════════════════════════════════════════════════════
    
    # 注意: component 的 OnBeginSimulation 签名是 ():void，不是 suspends
    OnBeginSimulation<override>():void =
        # 从配置初始化
        set MaxHealth = Config.MaxHealth
        InitialHealth := FloatToInt(MaxHealth * Config.StartHealthPercent)
        set CurrentHealth = ClampInt(InitialHealth, 0, MaxHealth)
        set IsDead = false
    
    # ═══════════════════════════════════════════════════════
    # 事件处理器（核心：响应外部事件）
    # ═══════════════════════════════════════════════════════
    
    # 响应伤害事件
    OnReceiveDamage<public>(Amount:int, Source:string):void =
        if (IsDead?):
            # 已死亡，不处理
        else:
            # 1. 调用 Calculator 计算结果（纯逻辑，无副作用）
            Result := HealthCalculator.CalculateDamageResult(
                CurrentHealth * 1.0,
                MaxHealth * 1.0,
                Amount * 1.0,
                IsInvincible
            )
            
            # 2. 更新本地状态
            set CurrentHealth = FloatToInt(Result.NewHealth)
            
            # 3. 同步到真实角色（如果绑定）
            if (Config.EnableRealDamage?):
                if (Char := BoundCharacter?):
                    if (not Result.WasBlocked?):
                        CharacterWrapper.ApplyDamage(Char, -Result.ActualChange)
            
            # 4. 派发事件
            DispatchHealthChanged(FloatToInt(Result.ActualChange), Source, Result.WasBlocked)
            
            # 5. 检查死亡
            if (Result.IsDead?):
                HandleDeath(Amount, FloatToInt(Result.Overkill), Source)
            
            # 6. 检查低血量
            CheckLowHealth()
    
    # 响应治疗事件
    OnReceiveHeal<public>(Amount:int, Source:string):void =
        if (IsDead?):
            # 已死亡，不处理
        else:
            # 1. 调用 Calculator 计算
            Result := HealthCalculator.CalculateHealResult(
                CurrentHealth * 1.0,
                MaxHealth * 1.0,
                Amount * 1.0
            )
            
            # 2. 更新状态
            set CurrentHealth = FloatToInt(Result.NewHealth)
            
            # 3. 同步到真实角色
            if (Config.EnableRealDamage?):
                if (Char := BoundCharacter?):
                    if (Result.ActualChange > 0.0):
                        CharacterWrapper.ApplyHeal(Char, Result.ActualChange)
            
            # 4. 派发事件
            if (Result.ActualChange > 0.0):
                DispatchHealthChanged(FloatToInt(Result.ActualChange), Source, false)
            
            # 5. 更新低血量状态
            CheckLowHealth()
    
    # ═══════════════════════════════════════════════════════
    # 公开 API（供外部调用）
    # ═══════════════════════════════════════════════════════
    
    # 造成伤害（简化接口）
    TakeDamage<public>(Amount:int):void =
        OnReceiveDamage(Amount, "unknown")
    
    # 治疗（简化接口）
    Heal<public>(Amount:int):void =
        OnReceiveHeal(Amount, "unknown")
    
    # 设置无敌状态（协程版）
    SetInvincible<public>(Duration:float)<suspends>:void =
        set IsInvincible = true
        Sleep(Duration)
        set IsInvincible = false
    
    # 设置无敌状态（即时版）
    SetInvincibleImmediate<public>(Value:logic):void =
        set IsInvincible = Value
    
    # 设置最大生命值
    SetMaxHealth<public>(NewMax:int, HealToFull:logic):void =
        set MaxHealth = ClampInt(NewMax, 1, 99999)
        if (HealToFull?):
            set CurrentHealth = MaxHealth
        else:
            set CurrentHealth = ClampInt(CurrentHealth, 0, MaxHealth)
    
    # 复活
    Revive<public>(HealthPercent:float):void =
        if (not IsDead?):
            # 未死亡，不需复活
        else:
            set IsDead = false
            ReviveHealth := FloatToInt(MaxHealth * HealthPercent)
            set CurrentHealth = ClampInt(ReviveHealth, 0, MaxHealth)
            
            # 同步到真实角色
            if (Char := BoundCharacter?):
                CharacterWrapper.SetHealth(Char, CurrentHealth * 1.0)
    
    # ═══════════════════════════════════════════════════════
    # 状态查询（只读，委托给 Helper）
    # ═══════════════════════════════════════════════════════
    
    GetCurrentHealth<public>():int = CurrentHealth
    GetMaxHealth<public>():int = MaxHealth
    
    IsAlive<public>():logic = HealthCalculator.IsAlive(CurrentHealth * 1.0)
    IsFullHealth<public>():logic = HealthCalculator.IsFullHealth(CurrentHealth * 1.0, MaxHealth * 1.0)
    IsCurrentlyInvincible<public>():logic = IsInvincible
    
    GetHealthPercent<public>():float = 
        HealthCalculator.GetHealthPercent(CurrentHealth * 1.0, MaxHealth * 1.0)
    
    GetMissingHealth<public>():int = 
        FloatToInt(HealthCalculator.GetMissingHealth(CurrentHealth * 1.0, MaxHealth * 1.0))
    
    IsLowHealth<public>():logic = 
        HealthCalculator.IsLowHealth(CurrentHealth * 1.0, MaxHealth * 1.0, Config.LowHealthThreshold)
    
    # 预测击杀所需次数
    PredictHitsToKill<public>(DamagePerHit:int):int =
        HealthCalculator.HitsToKill(CurrentHealth * 1.0, DamagePerHit * 1.0)
    
    # ═══════════════════════════════════════════════════════
    # 绑定管理
    # ═══════════════════════════════════════════════════════
    
    # 绑定到真实角色
    BindToCharacter<public>(Character:fort_character):void =
        set BoundCharacter = option{Character}
        
        # 同步初始状态
        HP := CharacterWrapper.GetHealth(Character)
        set CurrentHealth = FloatToInt(HP)
        MaxHP := CharacterWrapper.GetMaxHealth(Character)
        set MaxHealth = FloatToInt(MaxHP)
    
    # 解除绑定
    UnbindCharacter<public>():void =
        set BoundCharacter = false
    
    # 检查是否已绑定
    IsBound<public>():logic = 
        if (BoundCharacter?):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 内部方法
    # ═══════════════════════════════════════════════════════
    
    # 派发生命值变化事件
    DispatchHealthChanged<private>(Change:int, Source:string, WasBlocked:logic):void =
        OwnerEntity := Self.Entity
        OwnerEntity.SendUp(health_changed_event{
            CurrentHealth := CurrentHealth,
            MaxHealth := MaxHealth,
            ChangeAmount := Change,
            ChangeSource := Source,
            WasBlocked := WasBlocked
        })
    
    # 处理死亡
    HandleDeath<private>(FinalDamage:int, Overkill:int, Source:string):void =
        set IsDead = true
        
        OwnerEntity := Self.Entity
        OwnerEntity.SendUp(entity_died_event{
            FinalDamage := FinalDamage,
            Overkill := Overkill,
            DeathSource := Source
        })
    
    # 检查并触发低血量事件
    CheckLowHealth<private>():void =
        IsNowLowHealth := IsLowHealth()
        
        # 只在状态变化时触发
        if (IsNowLowHealth?, not WasLowHealth?):
            set WasLowHealth = true
            OwnerEntity := Self.Entity
            OwnerEntity.SendUp(low_health_event{
                CurrentHealth := CurrentHealth,
                MaxHealth := MaxHealth,
                HealthPercent := GetHealthPercent()
            })
        else if (not IsNowLowHealth?):
            set WasLowHealth = false
    
    # ═══════════════════════════════════════════════════════
    # 工具函数
    # ═══════════════════════════════════════════════════════
    
    # float 转 int（安全版，不会失败）
    FloatToInt<private>(Value:float):int =
        if (Result := Floor[Value]):
            Result
        else:
            0
    
    # 钳制 int 到范围
    ClampInt<private>(Value:int, MinVal:int, MaxVal:int):int =
        if (Value < MinVal):
            MinVal
        else if (Value > MaxVal):
            MaxVal
        else:
            Value
