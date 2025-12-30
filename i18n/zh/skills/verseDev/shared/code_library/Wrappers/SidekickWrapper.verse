# SidekickWrapper - UEFN Sidekick API 封装
# 版本: 1.0
# 更新时间: 2025-12-30
# 来源: Task - Wrap Sidekick API as Wrapper
#
# 设计目的:
# 1. 统一封装 UEFN equipped_sidekick_component API 调用
# 2. 提供简化的 Sidekick 心情、反应、交互控制接口
# 3. 处理所有边界条件和错误情况
# 4. 隐藏复杂的组件访问逻辑
# 5. 让 Component 层无需直接依赖 UEFN Sidekick API
#
# API 参考:
# - equipped_sidekick_component 实现接口: sidekick_component, showable
# - 来源: shared/api-digests/Fortnite.digest.verse L4247-4279
#
# 核心功能:
# - 心情管理 (Mood): GetMood, SetMood (通过 MoodOverride)
# - 反应控制 (Reaction): PlayReaction
# - 事件监听 (Events): ChangeMoodEvent, StartPlayReactionEvent, StopPlayReactionEvent
# - 行为控制 (Behavior): AutomaticReactionsEnabled, DefaultInteractionEnabled

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }

# ═══════════════════════════════════════════════════════════
# 操作结果
# ═══════════════════════════════════════════════════════════

# Sidekick 操作结果（统一返回格式）
sidekick_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因（成功时为空）
    Message<public>:string = ""             # 额外信息或成功消息

# Sidekick 心情查询结果
sidekick_mood_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    CurrentMood<public>:?sidekick_mood = false  # 当前心情
    IsOverridden<public>:logic = false      # 是否被 MoodOverride 锁定
    ErrorReason<public>:string = ""         # 失败原因

# Sidekick 状态信息
sidekick_info<public> := struct<concrete>:
    IsValid<public>:logic = false           # 组件是否有效
    CurrentMood<public>:?sidekick_mood = false  # 当前心情
    IsMoodOverridden<public>:logic = false  # 心情是否被覆盖
    IsVisible<public>:logic = false         # 是否可见
    AutoReactionsEnabled<public>:logic = false  # 自动反应是否启用
    InteractionEnabled<public>:logic = false    # 玩家交互是否启用

# ═══════════════════════════════════════════════════════════
# SidekickWrapper 模块 - UEFN Sidekick API 封装层
# ═══════════════════════════════════════════════════════════

SidekickWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 心情管理 (Mood Management)
    # API: equipped_sidekick_component.GetMood():sidekick_mood
    # API: equipped_sidekick_component.MoodOverride:?sidekick_mood
    # digest: Fortnite.digest.verse L4247-4256
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 当前心情
    # 返回当前心情，无论是由自动系统控制还是被 MoodOverride 锁定
    GetMood<public>(SidekickComponent:equipped_sidekick_component):sidekick_mood_result =
        # 调用 equipped_sidekick_component.GetMood() 获取当前心情
        # digest: L4253
        CurrentMood := SidekickComponent.GetMood()
        
        # 检查是否有心情覆盖（MoodOverride 不为 false 表示被锁定）
        IsOverridden := if (SidekickComponent.MoodOverride?):
            true
        else:
            false
        
        sidekick_mood_result{
            Success := true,
            CurrentMood := option{CurrentMood},
            IsOverridden := IsOverridden,
            ErrorReason := ""
        }
    
    # 设置 Sidekick 心情（通过 MoodOverride 锁定）
    # 将 Sidekick 锁定到指定心情，覆盖自动心情系统
    # 如果设置为 false，则解除锁定，恢复自动心情系统
    SetMood<public>(
        SidekickComponent:equipped_sidekick_component, 
        Mood:?sidekick_mood
    ):sidekick_op_result =
        # 设置 MoodOverride 变量
        # digest: L4250
        # 当 Mood = false 时，解除心情覆盖，恢复自动系统
        # 当 Mood = option{specific_mood} 时，锁定到该心情
        set SidekickComponent.MoodOverride = Mood
        
        Message := if (Mood?):
            "Mood locked to override"
        else:
            "Mood override cleared, automatic system restored"
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := Message
        }
    
    # 清除心情覆盖，恢复自动心情系统
    ClearMoodOverride<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        set SidekickComponent.MoodOverride = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Mood override cleared, automatic system restored"
        }
    
    # ═══════════════════════════════════════════════════════
    # 反应控制 (Reaction Control)
    # API: equipped_sidekick_component.PlayReaction(Reaction:sidekick_reaction)<transacts><decides>:void
    # digest: Fortnite.digest.verse L4258-4261
    # ═══════════════════════════════════════════════════════
    
    # 播放 Sidekick 反应动画
    # 注意: 反应不保证立即播放，应监听 StartPlayReactionEvent 确认
    # 如果 Sidekick 无法播放该反应，此方法会失败（<decides>）
    PlayReaction<public>(
        SidekickComponent:equipped_sidekick_component,
        Reaction:sidekick_reaction
    ):sidekick_op_result =
        # 尝试播放反应
        # digest: L4261
        # 使用 <decides> 特性：如果成功执行，返回成功；如果失败，返回失败
        if (SidekickComponent.PlayReaction[Reaction]):
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Reaction requested successfully. Monitor StartPlayReactionEvent for confirmation."
            }
        else:
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick cannot play the requested reaction",
                Message := "PlayReaction failed - reaction may not be available or Sidekick is busy"
            }
    
    # ═══════════════════════════════════════════════════════
    # 事件监听 (Event Subscriptions)
    # API: ChangeMoodEvent:listenable(tuple(sidekick_mood, sidekick_mood))
    # API: StartPlayReactionEvent:listenable(sidekick_reaction)
    # API: StopPlayReactionEvent:listenable(sidekick_reaction)
    # digest: Fortnite.digest.verse L4256, L4264, L4267
    # ═══════════════════════════════════════════════════════
    
    # 订阅心情变化事件
    # 返回 (上一个心情, 新心情)
    # 无论心情由自动系统改变还是通过 MoodOverride 改变都会触发
    SubscribeToMoodChange<public>(
        SidekickComponent:equipped_sidekick_component,
        Callback:(tuple(sidekick_mood, sidekick_mood)) -> void
    ):void =
        # digest: L4256
        SidekickComponent.ChangeMoodEvent.Subscribe(Callback)
    
    # 订阅反应开始播放事件
    # 当 Sidekick 开始播放反应时触发，返回正在播放的反应
    SubscribeToReactionStart<public>(
        SidekickComponent:equipped_sidekick_component,
        Callback:(sidekick_reaction) -> void
    ):void =
        # digest: L4264
        SidekickComponent.StartPlayReactionEvent.Subscribe(Callback)
    
    # 订阅反应停止播放事件
    # 当 Sidekick 完成反应播放时触发，返回已完成的反应
    SubscribeToReactionStop<public>(
        SidekickComponent:equipped_sidekick_component,
        Callback:(sidekick_reaction) -> void
    ):void =
        # digest: L4267
        SidekickComponent.StopPlayReactionEvent.Subscribe(Callback)
    
    # ═══════════════════════════════════════════════════════
    # 行为控制 (Behavior Control)
    # API: equipped_sidekick_component.AutomaticReactionsEnabled:logic
    # API: equipped_sidekick_component.DefaultInteractionEnabled:logic
    # digest: Fortnite.digest.verse L4276, L4279
    # ═══════════════════════════════════════════════════════
    
    # 启用或禁用自动反应系统
    # Sidekick 会根据玩家状态自动播放反应动画
    EnableAutomaticReactions<public>(
        SidekickComponent:equipped_sidekick_component,
        Enable:logic
    ):sidekick_op_result =
        # digest: L4276
        set SidekickComponent.AutomaticReactionsEnabled = Enable
        
        Message := if (Enable):
            "Automatic reactions enabled"
        else:
            "Automatic reactions disabled"
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := Message
        }
    
    # 启用或禁用玩家与 Sidekick 的默认交互
    # Sidekick 内置了玩家交互功能，可以通过此方法禁用
    EnablePlayerInteraction<public>(
        SidekickComponent:equipped_sidekick_component,
        Enable:logic
    ):sidekick_op_result =
        # digest: L4279
        set SidekickComponent.DefaultInteractionEnabled = Enable
        
        Message := if (Enable):
            "Player interaction enabled"
        else:
            "Player interaction disabled"
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := Message
        }
    
    # 获取自动反应系统状态
    IsAutomaticReactionsEnabled<public>(SidekickComponent:equipped_sidekick_component):logic =
        SidekickComponent.AutomaticReactionsEnabled
    
    # 获取玩家交互状态
    IsPlayerInteractionEnabled<public>(SidekickComponent:equipped_sidekick_component):logic =
        SidekickComponent.DefaultInteractionEnabled
    
    # ═══════════════════════════════════════════════════════
    # 可见性控制 (Visibility Control)
    # API: equipped_sidekick_component.Show:logic (inherited from showable)
    # digest: Fortnite.digest.verse L4273
    # ═══════════════════════════════════════════════════════
    
    # 显示或隐藏 Sidekick
    SetVisibility<public>(
        SidekickComponent:equipped_sidekick_component,
        Visible:logic
    ):sidekick_op_result =
        # digest: L4273
        set SidekickComponent.Show = Visible
        
        Message := if (Visible):
            "Sidekick is now visible"
        else:
            "Sidekick is now hidden"
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := Message
        }
    
    # 获取 Sidekick 可见性状态
    IsVisible<public>(SidekickComponent:equipped_sidekick_component):logic =
        SidekickComponent.Show
    
    # ═══════════════════════════════════════════════════════
    # 所有者查询 (Owner Query)
    # API: equipped_sidekick_component.GetOwningAgent()<transacts><decides>:agent
    # digest: Fortnite.digest.verse L4270
    # ═══════════════════════════════════════════════════════
    
    # 获取拥有此 Sidekick 的 agent
    # 注意: 此方法使用 <transacts><decides>，可能失败
    GetOwner<public>(SidekickComponent:equipped_sidekick_component):<decides>agent =
        # digest: L4270
        SidekickComponent.GetOwningAgent()
    
    # ═══════════════════════════════════════════════════════
    # 状态查询 (State Information)
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 完整状态信息（用于调试或 UI 显示）
    GetSidekickInfo<public>(SidekickComponent:equipped_sidekick_component):sidekick_info =
        # 获取当前心情
        MoodResult := GetMood(SidekickComponent)
        CurrentMood := if (MoodResult.Success):
            MoodResult.CurrentMood
        else:
            false
        
        # 构建状态信息
        sidekick_info{
            IsValid := true,
            CurrentMood := CurrentMood,
            IsMoodOverridden := MoodResult.IsOverridden,
            IsVisible := IsVisible(SidekickComponent),
            AutoReactionsEnabled := IsAutomaticReactionsEnabled(SidekickComponent),
            InteractionEnabled := IsPlayerInteractionEnabled(SidekickComponent)
        }
    
    # ═══════════════════════════════════════════════════════
    # 便捷方法 (Convenience Methods)
    # ═══════════════════════════════════════════════════════
    
    # 设置 Sidekick 为战斗心情
    SetCombatMood<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        SetMood(SidekickComponent, option{sidekick_mood.Combat})
    
    # 设置 Sidekick 为中立心情
    SetNeutralMood<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        SetMood(SidekickComponent, option{sidekick_mood.Neutral})
    
    # 设置 Sidekick 为担忧心情
    SetWorriedMood<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        SetMood(SidekickComponent, option{sidekick_mood.Worried})
    
    # 设置 Sidekick 为无聊心情
    SetBoredMood<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        SetMood(SidekickComponent, option{sidekick_mood.Bored})
    
    # 播放开心反应
    PlayHappyReaction<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        PlayReaction(SidekickComponent, sidekick_reaction.Happy)
    
    # 播放跳舞反应
    PlayDanceReaction<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        PlayReaction(SidekickComponent, sidekick_reaction.Dance)
    
    # 播放表情反应
    PlayEmoteReaction<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        PlayReaction(SidekickComponent, sidekick_reaction.Emote)
    
    # 播放愤怒反应
    PlayAngryReaction<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        PlayReaction(SidekickComponent, sidekick_reaction.Angry)
    
    # 播放担忧反应
    PlayWorriedReaction<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        PlayReaction(SidekickComponent, sidekick_reaction.Worried)
    
    # ═══════════════════════════════════════════════════════
    # 组合操作 (Composite Operations)
    # ═══════════════════════════════════════════════════════
    
    # 完全禁用 Sidekick（隐藏 + 禁用交互 + 禁用自动反应）
    DisableSidekick<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        set SidekickComponent.Show = false
        set SidekickComponent.DefaultInteractionEnabled = false
        set SidekickComponent.AutomaticReactionsEnabled = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Sidekick fully disabled (hidden, no interaction, no auto reactions)"
        }
    
    # 完全启用 Sidekick（显示 + 启用交互 + 启用自动反应）
    EnableSidekick<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        set SidekickComponent.Show = true
        set SidekickComponent.DefaultInteractionEnabled = true
        set SidekickComponent.AutomaticReactionsEnabled = true
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Sidekick fully enabled (visible, interaction enabled, auto reactions enabled)"
        }
    
    # 重置 Sidekick 到默认状态（清除心情覆盖 + 启用自动反应 + 启用交互 + 显示）
    ResetToDefault<public>(SidekickComponent:equipped_sidekick_component):sidekick_op_result =
        set SidekickComponent.MoodOverride = false
        set SidekickComponent.AutomaticReactionsEnabled = true
        set SidekickComponent.DefaultInteractionEnabled = true
        set SidekickComponent.Show = true
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Sidekick reset to default state"
        }
