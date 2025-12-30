# SidekickWrapper - UEFN Sidekick API 封装
# 版本: 1.0
# 更新时间: 2025-12-30
# 来源: REQ-Sidekick - Sidekick 系统开发需求
#
# 设计目的:
# 1. 统一封装 UEFN equipped_sidekick_component API 调用
# 2. 提供 Sidekick 心情、反应、事件管理的统一接口
# 3. 处理所有边界条件和错误情况
# 4. 让 Component 层无需直接依赖 UEFN API
#
# 业务域范围:
# - Sidekick 心情管理（自动和手动覆盖）
# - Sidekick 反应播放系统
# - Sidekick 事件监听（心情变化、反应播放）
# - Sidekick 行为配置（自动反应、玩家交互）
# - Sidekick 可见性控制
#
# API 参考:
# - equipped_sidekick_component: 核心组件类
# - sidekick_mood: 心情枚举类型
# - sidekick_reaction: 反应枚举类型
# - 来源: shared/api-digests/Fortnite.digest.verse L4246-4290

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }

# ═══════════════════════════════════════════════════════════
# 操作结果结构
# ═══════════════════════════════════════════════════════════

# Sidekick 操作结果（统一返回格式）
sidekick_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因
    Message<public>:string = ""             # 附加信息

# Sidekick 信息结构
sidekick_info<public> := struct<concrete>:
    IsValid<public>:logic = false                   # Sidekick 是否有效
    CurrentMood<public>:sidekick_mood = sidekick_mood.Neutral    # 当前心情
    HasMoodOverride<public>:logic = false           # 是否有心情覆盖
    IsVisible<public>:logic = true                  # 是否可见
    AutomaticReactionsEnabled<public>:logic = true  # 自动反应是否启用
    DefaultInteractionEnabled<public>:logic = true  # 默认交互是否启用

# ═══════════════════════════════════════════════════════════
# SidekickWrapper 模块 - UEFN Sidekick 系统封装层
# ═══════════════════════════════════════════════════════════

SidekickWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 心情管理
    # API: sidekick_component.GetMood():sidekick_mood
    # API: sidekick_component.MoodOverride:?sidekick_mood
    # digest: Fortnite.digest.verse L4252-4253, L4250
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 当前心情
    # 返回当前生效的心情（可能是自动心情或覆盖心情）
    GetMood<public>(Sidekick:equipped_sidekick_component)<reads>:sidekick_mood =
        # 直接调用 equipped_sidekick_component 接口方法
        # digest: Fortnite.digest.verse L4253
        Sidekick.GetMood()
    
    # 设置 Sidekick 心情覆盖
    # 当设置心情覆盖时，Sidekick 将锁定在指定心情，忽略自动心情系统
    SetMood<public>(Sidekick:equipped_sidekick_component, Mood:sidekick_mood):sidekick_op_result =
        # 设置 MoodOverride 变量
        # digest: Fortnite.digest.verse L4250
        set Sidekick.MoodOverride = option{Mood}
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Mood override set successfully"
        }
    
    # 清除心情覆盖，恢复自动心情系统
    # 清除后 Sidekick 将根据游戏内事件自动改变心情
    ClearMoodOverride<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        # 将 MoodOverride 设置为 false（清除 option）
        # digest: Fortnite.digest.verse L4250
        set Sidekick.MoodOverride = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Mood override cleared, automatic mood system restored"
        }
    
    # 检查是否有心情覆盖
    HasMoodOverride<public>(Sidekick:equipped_sidekick_component)<reads>:logic =
        if (Sidekick.MoodOverride?):
            true
        else:
            false
    
    # 获取心情覆盖值（如果存在）
    GetMoodOverride<public>(Sidekick:equipped_sidekick_component)<reads>:?sidekick_mood =
        Sidekick.MoodOverride
    
    # ═══════════════════════════════════════════════════════
    # 反应播放
    # API: sidekick_component.PlayReaction(Reaction:sidekick_reaction)<transacts><decides>:void
    # digest: Fortnite.digest.verse L4261
    # ═══════════════════════════════════════════════════════
    
    # 请求播放指定反应
    # 注意: 反应不一定立即播放，应监听 StartPlayReactionEvent 确认
    # 如果 Sidekick 无法播放该反应，此方法会失败（failable）
    PlayReaction<public>(Sidekick:equipped_sidekick_component, Reaction:sidekick_reaction)<transacts>:sidekick_op_result =
        # 调用 PlayReaction 方法（failable）
        # digest: Fortnite.digest.verse L4261
        if (Sidekick.PlayReaction[Reaction]):
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Reaction requested successfully"
            }
        else:
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick cannot play the given reaction",
                Message := "PlayReaction failed - reaction may not be available"
            }
    
    # ═══════════════════════════════════════════════════════
    # 事件访问
    # API: sidekick_component.ChangeMoodEvent:listenable(tuple(sidekick_mood, sidekick_mood))
    # API: sidekick_component.StartPlayReactionEvent:listenable(sidekick_reaction)
    # API: sidekick_component.StopPlayReactionEvent:listenable(sidekick_reaction)
    # digest: Fortnite.digest.verse L4256, L4264, L4267
    # ═══════════════════════════════════════════════════════
    
    # 获取心情变化事件
    # 返回: (PreviousMood, NewMood)
    # 当心情改变时触发（无论是自动还是覆盖）
    GetChangeMoodEvent<public>(Sidekick:equipped_sidekick_component):listenable(tuple(sidekick_mood, sidekick_mood)) =
        # 访问 ChangeMoodEvent
        # digest: Fortnite.digest.verse L4256
        Sidekick.ChangeMoodEvent
    
    # 获取开始播放反应事件
    # 返回: 开始播放的反应类型
    GetStartPlayReactionEvent<public>(Sidekick:equipped_sidekick_component):listenable(sidekick_reaction) =
        # 访问 StartPlayReactionEvent
        # digest: Fortnite.digest.verse L4264
        Sidekick.StartPlayReactionEvent
    
    # 获取停止播放反应事件
    # 返回: 停止播放的反应类型
    GetStopPlayReactionEvent<public>(Sidekick:equipped_sidekick_component):listenable(sidekick_reaction) =
        # 访问 StopPlayReactionEvent
        # digest: Fortnite.digest.verse L4267
        Sidekick.StopPlayReactionEvent
    
    # ═══════════════════════════════════════════════════════
    # 行为配置
    # API: equipped_sidekick_component.AutomaticReactionsEnabled:logic
    # API: equipped_sidekick_component.DefaultInteractionEnabled:logic
    # digest: Fortnite.digest.verse L4276, L4279
    # ═══════════════════════════════════════════════════════
    
    # 启用/禁用自动反应系统
    # 自动反应系统会根据玩家状态自动播放动画反应
    EnableAutomaticReactions<public>(Sidekick:equipped_sidekick_component, Enable:logic):sidekick_op_result =
        # 设置 AutomaticReactionsEnabled 变量
        # digest: Fortnite.digest.verse L4276
        set Sidekick.AutomaticReactionsEnabled = Enable
        
        if (Enable):
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Automatic reactions enabled"
            }
        else:
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Automatic reactions disabled"
            }
    
    # 启用/禁用玩家交互
    # Sidekick 有内置的玩家交互功能，可通过此选项禁用
    EnablePlayerInteraction<public>(Sidekick:equipped_sidekick_component, Enable:logic):sidekick_op_result =
        # 设置 DefaultInteractionEnabled 变量
        # digest: Fortnite.digest.verse L4279
        set Sidekick.DefaultInteractionEnabled = Enable
        
        if (Enable):
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Player interaction enabled"
            }
        else:
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Player interaction disabled"
            }
    
    # 获取自动反应启用状态
    IsAutomaticReactionsEnabled<public>(Sidekick:equipped_sidekick_component)<reads>:logic =
        Sidekick.AutomaticReactionsEnabled
    
    # 获取玩家交互启用状态
    IsPlayerInteractionEnabled<public>(Sidekick:equipped_sidekick_component)<reads>:logic =
        Sidekick.DefaultInteractionEnabled
    
    # ═══════════════════════════════════════════════════════
    # 可见性控制
    # API: showable.Show:logic
    # digest: Fortnite.digest.verse L4273 (继承自 showable 接口)
    # ═══════════════════════════════════════════════════════
    
    # 显示 Sidekick
    ShowSidekick<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        # 设置 Show 变量为 true
        # equipped_sidekick_component 继承自 showable 接口
        # digest: Fortnite.digest.verse L4273
        set Sidekick.Show = true
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Sidekick is now visible"
        }
    
    # 隐藏 Sidekick
    HideSidekick<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        # 设置 Show 变量为 false
        # digest: Fortnite.digest.verse L4273
        set Sidekick.Show = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Sidekick is now hidden"
        }
    
    # 检查 Sidekick 是否可见
    IsVisible<public>(Sidekick:equipped_sidekick_component)<reads>:logic =
        Sidekick.Show
    
    # 切换可见性
    ToggleVisibility<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        CurrentState := Sidekick.Show
        set Sidekick.Show = not CurrentState
        
        if (not CurrentState):
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Sidekick visibility toggled to visible"
            }
        else:
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Sidekick visibility toggled to hidden"
            }
    
    # ═══════════════════════════════════════════════════════
    # 辅助功能
    # API: equipped_sidekick_component.GetOwningAgent()<transacts><decides>:agent
    # digest: Fortnite.digest.verse L4270
    # ═══════════════════════════════════════════════════════
    
    # 获取拥有此 Sidekick 的 agent
    # 这是 Sidekick 的主人（通常是玩家）
    GetOwningAgent<public>(Sidekick:equipped_sidekick_component)<transacts>:?agent =
        # 调用 GetOwningAgent 方法（failable）
        # digest: Fortnite.digest.verse L4270
        if (Owner := Sidekick.GetOwningAgent[]):
            option{Owner}
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 信息查询
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 完整信息（用于 UI 显示或调试）
    GetSidekickInfo<public>(Sidekick:equipped_sidekick_component)<reads><transacts>:sidekick_info =
        CurrentMood := Sidekick.GetMood()
        HasOverride := if (Sidekick.MoodOverride?) then true else false
        IsVis := Sidekick.Show
        AutoReact := Sidekick.AutomaticReactionsEnabled
        PlayerInteract := Sidekick.DefaultInteractionEnabled
        
        # 检查是否有效（尝试获取 Owner）
        IsValidSidekick := if (Sidekick.GetOwningAgent[]) then true else false
        
        sidekick_info{
            IsValid := IsValidSidekick,
            CurrentMood := CurrentMood,
            HasMoodOverride := HasOverride,
            IsVisible := IsVis,
            AutomaticReactionsEnabled := AutoReact,
            DefaultInteractionEnabled := PlayerInteract
        }
    
    # ═══════════════════════════════════════════════════════
    # 便捷方法 - 常用心情设置
    # ═══════════════════════════════════════════════════════
    
    # 设置为中性心情
    SetNeutralMood<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        SetMood(Sidekick, sidekick_mood.Neutral)
    
    # 设置为战斗心情
    SetCombatMood<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        SetMood(Sidekick, sidekick_mood.Combat)
    
    # 设置为担忧心情
    SetWorriedMood<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        SetMood(Sidekick, sidekick_mood.Worried)
    
    # 设置为无聊心情
    SetBoredMood<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        SetMood(Sidekick, sidekick_mood.Bored)
    
    # ═══════════════════════════════════════════════════════
    # 便捷方法 - 常用反应播放
    # ═══════════════════════════════════════════════════════
    
    # 播放开心反应
    PlayHappyReaction<public>(Sidekick:equipped_sidekick_component)<transacts>:sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Happy)
    
    # 播放跳舞反应
    PlayDanceReaction<public>(Sidekick:equipped_sidekick_component)<transacts>:sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Dance)
    
    # 播放表情反应
    PlayEmoteReaction<public>(Sidekick:equipped_sidekick_component)<transacts>:sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Emote)
    
    # 播放生气反应
    PlayAngryReaction<public>(Sidekick:equipped_sidekick_component)<transacts>:sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Angry)
    
    # 播放担忧反应
    PlayWorriedReaction<public>(Sidekick:equipped_sidekick_component)<transacts>:sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Worried)
