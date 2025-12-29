# PetWrapper - UEFN Sidekicks 系统 API 封装
# 版本: 2.0
# 更新时间: 2025-12-29
# 来源: 需求驱动 - Sidekicks 宠物系统开发
#
# 设计目的:
# 1. 封装 UEFN Sidekicks 相关 API（equipped_sidekick_component, npc_sidekick_component）
# 2. 提供宠物情绪管理、反应播放、可见性控制的统一接口
# 3. 处理宠物与玩家的交互逻辑
# 4. 让 Component 层无需直接依赖底层 UEFN AI 模块
#
# 业务域范围:
# - 宠物情绪管理（Mood Override 和查询）
# - 宠物反应播放（Happy, Dance, Emote, Angry, Worried）
# - 宠物可见性控制（Show/Hide）
# - 宠物 Spark 模式管理
# - 宠物事件监听（情绪变化、反应播放）
#
# API 参考:
# - equipped_sidekick_component: 装备型 Sidekick 组件
# - npc_sidekick_component: NPC 型 Sidekick 组件
# - sidekick_component: Sidekick 基类组件
# - spark_mode_component: Spark 模式组件
# - 来源: shared/api-digests/Fortnite.digest.verse L4240-4628

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /Fortnite.com/AI }
using { /Fortnite.com/Game }

# ═══════════════════════════════════════════════════════════
# 操作结果结构（与 digest 类型对齐）
# ═══════════════════════════════════════════════════════════

# Sidekick 操作结果（统一返回格式）
sidekick_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因

# Sidekick 信息结构
sidekick_info<public> := struct<concrete>:
    IsValid<public>:logic = false           # Sidekick 是否有效
    CurrentMood<public>:sidekick_mood = sidekick_mood.Neutral
    IsVisible<public>:logic = true          # 是否可见
    HasMoodOverride<public>:logic = false   # 是否启用情绪覆盖

# ═══════════════════════════════════════════════════════════
# PetWrapper 模块 - UEFN Sidekicks 系统封装层
# ═══════════════════════════════════════════════════════════

PetWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 情绪管理
    # API: sidekick_component.GetMood():sidekick_mood
    # API: sidekick_component.MoodOverride:?sidekick_mood
    # digest: Fortnite.digest.verse L4584-4593
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 当前情绪
    # digest: Fortnite.digest.verse L4590
    GetMood<public>(Sidekick:sidekick_component):sidekick_mood =
        Sidekick.GetMood()
    
    # 设置情绪覆盖（锁定 Sidekick 在指定情绪，覆盖自动情绪系统）
    # digest: Fortnite.digest.verse L4587
    SetMoodOverride<public>(Sidekick:sidekick_component, Mood:sidekick_mood):sidekick_op_result =
        set Sidekick.MoodOverride = option{Mood}
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 清除情绪覆盖（恢复自动情绪系统）
    # digest: Fortnite.digest.verse L4587
    ClearMoodOverride<public>(Sidekick:sidekick_component):sidekick_op_result =
        set Sidekick.MoodOverride = false
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 检查是否启用了情绪覆盖
    HasMoodOverride<public>(Sidekick:sidekick_component):logic =
        if (Sidekick.MoodOverride?):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 反应播放
    # API: sidekick_component.PlayReaction(Reaction:sidekick_reaction)<transacts><decides>:void
    # digest: Fortnite.digest.verse L4598
    # ═══════════════════════════════════════════════════════
    
    # 播放指定反应（Happy, Dance, Emote, Angry, Worried）
    # 注意: 反应不保证立即播放，应使用 StartPlayReactionEvent 监听
    # digest: Fortnite.digest.verse L4598
    PlayReaction<public>(Sidekick:sidekick_component, Reaction:sidekick_reaction):sidekick_op_result =
        # 调用 PlayReaction，使用 <decides> 处理可能的失败
        if (Sidekick.PlayReaction[Reaction]):
            sidekick_op_result{
                Success := true,
                ErrorReason := ""
            }
        else:
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick cannot play the given reaction"
            }
    
    # 尝试播放 Happy 反应
    PlayHappyReaction<public>(Sidekick:sidekick_component):sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Happy)
    
    # 尝试播放 Dance 反应
    PlayDanceReaction<public>(Sidekick:sidekick_component):sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Dance)
    
    # 尝试播放 Emote 反应
    PlayEmoteReaction<public>(Sidekick:sidekick_component):sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Emote)
    
    # 尝试播放 Angry 反应
    PlayAngryReaction<public>(Sidekick:sidekick_component):sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Angry)
    
    # 尝试播放 Worried 反应
    PlayWorriedReaction<public>(Sidekick:sidekick_component):sidekick_op_result =
        PlayReaction(Sidekick, sidekick_reaction.Worried)
    
    # ═══════════════════════════════════════════════════════
    # 可见性控制 (仅适用于 equipped_sidekick_component)
    # API: equipped_sidekick_component.Show:logic (implements showable interface)
    # digest: Fortnite.digest.verse L4273
    # ═══════════════════════════════════════════════════════
    
    # 显示装备型 Sidekick
    # digest: Fortnite.digest.verse L4273
    ShowEquippedSidekick<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        set Sidekick.Show = true
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 隐藏装备型 Sidekick
    # digest: Fortnite.digest.verse L4273
    HideEquippedSidekick<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        set Sidekick.Show = false
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 检查装备型 Sidekick 是否可见
    IsEquippedSidekickVisible<public>(Sidekick:equipped_sidekick_component):logic =
        Sidekick.Show
    
    # ═══════════════════════════════════════════════════════
    # 装备型 Sidekick 特有功能
    # API: equipped_sidekick_component.GetOwningAgent()<transacts><decides>:agent
    # API: equipped_sidekick_component.AutomaticReactionsEnabled:logic
    # API: equipped_sidekick_component.DefaultInteractionEnabled:logic
    # digest: Fortnite.digest.verse L4247-4280
    # ═══════════════════════════════════════════════════════
    
    # 获取拥有此 Sidekick 的 agent
    # digest: Fortnite.digest.verse L4270
    GetOwningAgent<public>(Sidekick:equipped_sidekick_component)<transacts>:?agent =
        if (Owner := Sidekick.GetOwningAgent[]):
            option{Owner}
        else:
            false
    
    # 启用自动反应系统（Sidekick 会根据玩家状态自动播放动画）
    # digest: Fortnite.digest.verse L4276
    EnableAutomaticReactions<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        set Sidekick.AutomaticReactionsEnabled = true
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 禁用自动反应系统
    # digest: Fortnite.digest.verse L4276
    DisableAutomaticReactions<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        set Sidekick.AutomaticReactionsEnabled = false
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 启用默认交互（Sidekick 内置的玩家交互功能）
    # digest: Fortnite.digest.verse L4279
    EnableDefaultInteraction<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        set Sidekick.DefaultInteractionEnabled = true
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 禁用默认交互
    # digest: Fortnite.digest.verse L4279
    DisableDefaultInteraction<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        set Sidekick.DefaultInteractionEnabled = false
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # ═══════════════════════════════════════════════════════
    # Spark 模式管理
    # API: spark_mode_component.SparkModeAlwaysActive:logic
    # digest: Fortnite.digest.verse L4285-4293
    # ═══════════════════════════════════════════════════════
    
    # 强制进入 Spark 模式（禁用自动切换）
    # digest: Fortnite.digest.verse L4287
    ForceSparkMode<public>(SparkComponent:spark_mode_component):sidekick_op_result =
        set SparkComponent.SparkModeAlwaysActive = true
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 允许自动切换 Spark 模式（默认行为）
    # digest: Fortnite.digest.verse L4287
    AllowAutoSparkMode<public>(SparkComponent:spark_mode_component):sidekick_op_result =
        set SparkComponent.SparkModeAlwaysActive = false
        sidekick_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 信息查询
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 完整信息（用于 UI 显示或调试）
    GetSidekickInfo<public>(Sidekick:equipped_sidekick_component):sidekick_info =
        CurrentMood := GetMood(Sidekick)
        IsVisible := IsEquippedSidekickVisible(Sidekick)
        HasOverride := HasMoodOverride(Sidekick)
        
        sidekick_info{
            IsValid := true,
            CurrentMood := CurrentMood,
            IsVisible := IsVisible,
            HasMoodOverride := HasOverride
        }
    
    # 获取 NPC Sidekick 完整信息
    GetNPCSidekickInfo<public>(Sidekick:npc_sidekick_component):sidekick_info =
        CurrentMood := GetMood(Sidekick)
        HasOverride := HasMoodOverride(Sidekick)
        
        sidekick_info{
            IsValid := true,
            CurrentMood := CurrentMood,
            IsVisible := true,  # NPC Sidekick 没有 Show 接口
            HasMoodOverride := HasOverride
        }
