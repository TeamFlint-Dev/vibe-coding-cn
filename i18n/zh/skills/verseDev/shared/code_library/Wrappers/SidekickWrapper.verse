# SidekickWrapper - UEFN Sidekick API 封装
# 版本: 1.0
# 更新时间: 2025-12-30
# 来源: REQ - Sidekick 系统功能开发
#
# 设计目的:
# 1. 统一封装 UEFN equipped_sidekick_component API 调用
# 2. 处理 Sidekick 心情、反应、交互的所有操作
# 3. 提供类型安全的接口和统一错误处理
# 4. 让 Component 层无需直接依赖底层 UEFN API
#
# 业务域范围:
# - Sidekick 心情管理（自动心情与强制覆盖）
# - Sidekick 反应播放（Happy, Dance, Emote, Angry, Worried）
# - Sidekick 事件监听（心情变化、反应开始/结束）
# - Sidekick 可见性控制
# - Sidekick 行为开关（自动反应、玩家交互）
# - Sidekick 所有者查询
#
# API 参考:
# - equipped_sidekick_component: Sidekick 装备组件（继承 sidekick_component, showable）
# - 来源: shared/api-digests/Fortnite.digest.verse L4247-4279
# - 可用版本: MinUploadedAtFNVersion >= 3800

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /Fortnite.com/Characters }
using { /Fortnite.com/AI }

# ═══════════════════════════════════════════════════════════
# 操作结果结构
# ═══════════════════════════════════════════════════════════

# Sidekick 操作结果（统一返回格式）
sidekick_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因（成功时为空）
    ActualValue<public>:int = 0             # 实际生效的数值（如枚举索引）

# Sidekick 心情信息结构
sidekick_mood_info<public> := struct<concrete>:
    CurrentMood<public>:sidekick_mood = sidekick_mood.Neutral
    IsOverridden<public>:logic = false      # 是否被强制覆盖
    OverrideMood<public>:?sidekick_mood = false  # 覆盖的心情（如果有）

# ═══════════════════════════════════════════════════════════
# SidekickWrapper 模块 - UEFN Sidekick API 封装层
# ═══════════════════════════════════════════════════════════

SidekickWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 心情操作
    # API: sidekick_component.GetMood():sidekick_mood
    # API: sidekick_component.MoodOverride:?sidekick_mood
    # digest: Fortnite.digest.verse L4250-4253
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 当前心情
    # 返回当前生效的心情（可能是自动心情或覆盖心情）
    GetMood<public>(Sidekick:equipped_sidekick_component):sidekick_mood =
        # digest: Fortnite.digest.verse L4253
        # GetMood<override><native>()<reads>:sidekick_mood
        Sidekick.GetMood()
    
    # 设置 Sidekick 心情覆盖
    # 设置后，Sidekick 将锁定在指定心情，忽略自动心情系统
    # 传入 false 则取消覆盖，恢复自动心情
    SetMoodOverride<public>(
        Sidekick:equipped_sidekick_component, 
        Mood:?sidekick_mood
    ):sidekick_op_result =
        # 边界检查：Sidekick 对象有效性由调用者保证
        # 设置心情覆盖（可以是具体心情或 false 取消覆盖）
        # digest: Fortnite.digest.verse L4250
        # var MoodOverride<override>:?sidekick_mood = external {}
        set Sidekick.MoodOverride = Mood
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0
        }
    
    # 获取 Sidekick 心情详细信息
    # 包含当前心情、是否被覆盖、覆盖的心情值
    GetMoodInfo<public>(Sidekick:equipped_sidekick_component):sidekick_mood_info =
        CurrentMood := Sidekick.GetMood()
        Override := Sidekick.MoodOverride
        
        if (Override?):
            # 有覆盖心情
            sidekick_mood_info{
                CurrentMood := CurrentMood,
                IsOverridden := true,
                OverrideMood := Override
            }
        else:
            # 使用自动心情
            sidekick_mood_info{
                CurrentMood := CurrentMood,
                IsOverridden := false,
                OverrideMood := false
            }
    
    # 取消心情覆盖，恢复自动心情系统
    ClearMoodOverride<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        set Sidekick.MoodOverride = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0
        }
    
    # ═══════════════════════════════════════════════════════
    # 反应播放
    # API: sidekick_component.PlayReaction(Reaction:sidekick_reaction)<transacts><decides>:void
    # digest: Fortnite.digest.verse L4258-4261
    # ═══════════════════════════════════════════════════════
    
    # 播放 Sidekick 反应
    # 注意：反应不保证立即播放，应通过 StartPlayReactionEvent 监听实际开始
    # 如果 Sidekick 无法播放该反应，此调用会失败（<decides>）
    PlayReaction<public>(
        Sidekick:equipped_sidekick_component,
        Reaction:sidekick_reaction
    ):sidekick_op_result =
        # 尝试播放反应
        # digest: Fortnite.digest.verse L4261
        # PlayReaction<override><native>(Reaction:sidekick_reaction)<transacts><decides>:void
        if (Sidekick.PlayReaction[Reaction]):
            # 成功请求播放
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 0
            }
        else:
            # Sidekick 无法播放该反应
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick cannot play this reaction",
                ActualValue := 0
            }
    
    # ═══════════════════════════════════════════════════════
    # 事件监听
    # API: sidekick_component.ChangeMoodEvent:listenable(tuple(sidekick_mood, sidekick_mood))
    # API: sidekick_component.StartPlayReactionEvent:listenable(sidekick_reaction)
    # API: sidekick_component.StopPlayReactionEvent:listenable(sidekick_reaction)
    # digest: Fortnite.digest.verse L4256, L4264, L4267
    # ═══════════════════════════════════════════════════════
    
    # 获取心情变化事件监听器
    # 返回 (PreviousMood, NewMood) 元组
    GetChangeMoodEvent<public>(
        Sidekick:equipped_sidekick_component
    ):listenable(tuple(sidekick_mood, sidekick_mood)) =
        # digest: Fortnite.digest.verse L4256
        # ChangeMoodEvent<override><native>:listenable(tuple(sidekick_mood, sidekick_mood)) = external {}
        Sidekick.ChangeMoodEvent
    
    # 获取反应开始播放事件监听器
    # 返回开始播放的反应类型
    GetStartPlayReactionEvent<public>(
        Sidekick:equipped_sidekick_component
    ):listenable(sidekick_reaction) =
        # digest: Fortnite.digest.verse L4264
        # StartPlayReactionEvent<override><native>:listenable(sidekick_reaction) = external {}
        Sidekick.StartPlayReactionEvent
    
    # 获取反应结束播放事件监听器
    # 返回结束播放的反应类型
    GetStopPlayReactionEvent<public>(
        Sidekick:equipped_sidekick_component
    ):listenable(sidekick_reaction) =
        # digest: Fortnite.digest.verse L4267
        # StopPlayReactionEvent<override><native>:listenable(sidekick_reaction) = external {}
        Sidekick.StopPlayReactionEvent
    
    # ═══════════════════════════════════════════════════════
    # 可见性控制
    # API: showable.Show:logic (inherited from showable interface)
    # digest: Fortnite.digest.verse L4247 (equipped_sidekick_component inherits showable)
    # ═══════════════════════════════════════════════════════
    
    # 设置 Sidekick 可见性
    # 注意：equipped_sidekick_component 继承 showable 接口
    SetVisibility<public>(Sidekick:equipped_sidekick_component, Visible:logic):sidekick_op_result =
        # digest: equipped_sidekick_component 继承 showable 接口
        # var Show:logic = external {}
        set Sidekick.Show = Visible
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := if Visible then 1 else 0
        }
    
    # 获取 Sidekick 可见性状态
    GetVisibility<public>(Sidekick:equipped_sidekick_component):logic =
        Sidekick.Show
    
    # 显示 Sidekick
    ShowSidekick<public>(Sidekick:equipped_sidekick_component):void =
        set Sidekick.Show = true
    
    # 隐藏 Sidekick
    HideSidekick<public>(Sidekick:equipped_sidekick_component):void =
        set Sidekick.Show = false
    
    # ═══════════════════════════════════════════════════════
    # 行为开关控制
    # API: equipped_sidekick_component.AutomaticReactionsEnabled:logic
    # API: equipped_sidekick_component.DefaultInteractionEnabled:logic
    # digest: Fortnite.digest.verse L4276, L4279
    # ═══════════════════════════════════════════════════════
    
    # 启用/禁用自动反应系统
    # 自动反应系统会让 Sidekick 根据游戏状态自动播放反应动画
    EnableAutomaticReactions<public>(
        Sidekick:equipped_sidekick_component, 
        Enable:logic
    ):sidekick_op_result =
        # digest: Fortnite.digest.verse L4276
        # var AutomaticReactionsEnabled<public>:logic = external {}
        set Sidekick.AutomaticReactionsEnabled = Enable
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := if Enable then 1 else 0
        }
    
    # 启用/禁用玩家交互
    # 玩家交互允许玩家直接与 Sidekick 互动
    EnablePlayerInteraction<public>(
        Sidekick:equipped_sidekick_component, 
        Enable:logic
    ):sidekick_op_result =
        # digest: Fortnite.digest.verse L4279
        # var DefaultInteractionEnabled<public>:logic = external {}
        set Sidekick.DefaultInteractionEnabled = Enable
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := if Enable then 1 else 0
        }
    
    # 获取自动反应系统状态
    IsAutomaticReactionsEnabled<public>(Sidekick:equipped_sidekick_component):logic =
        Sidekick.AutomaticReactionsEnabled
    
    # 获取玩家交互状态
    IsPlayerInteractionEnabled<public>(Sidekick:equipped_sidekick_component):logic =
        Sidekick.DefaultInteractionEnabled
    
    # ═══════════════════════════════════════════════════════
    # 所有者查询
    # API: equipped_sidekick_component.GetOwningAgent()<transacts><decides>:agent
    # digest: Fortnite.digest.verse L4270-4273
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 的所有者 agent
    # 如果无法获取所有者（Sidekick 未装备或无效），返回 false
    GetOwningAgent<public>(Sidekick:equipped_sidekick_component)<transacts>:?agent =
        # digest: Fortnite.digest.verse L4273
        # GetOwningAgent<native><public>()<transacts><decides>:agent
        if (Owner := Sidekick.GetOwningAgent[]):
            option{Owner}
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 综合状态查询
    # ═══════════════════════════════════════════════════════
    
    # 检查 Sidekick 是否有效并已装备
    # 通过尝试获取所有者来判断
    IsValidAndEquipped<public>(Sidekick:equipped_sidekick_component)<transacts>:logic =
        if (Sidekick.GetOwningAgent[]):
            true
        else:
            false
    
    # 检查 Sidekick 是否可见
    IsVisible<public>(Sidekick:equipped_sidekick_component):logic =
        Sidekick.Show
    
    # 检查 Sidekick 是否处于特定心情
    IsInMood<public>(Sidekick:equipped_sidekick_component, TargetMood:sidekick_mood):logic =
        CurrentMood := Sidekick.GetMood()
        if (CurrentMood = TargetMood):
            true
        else:
            false
