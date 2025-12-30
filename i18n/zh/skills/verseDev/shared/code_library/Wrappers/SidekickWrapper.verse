# SidekickWrapper - UEFN Sidekick API 封装
# 版本: 1.0
# 更新时间: 2025-12-30
# 来源: REQ-task-20251230-094259-6 Sidekick系统
#
# 设计目的:
# 1. 统一封装 UEFN Sidekick 相关 API 调用
# 2. 提供统一的 Sidekick 操作接口（装备型和NPC型）
# 3. 处理心情（Mood）和反应（Reaction）系统
# 4. 管理 Sidekick 可见性和交互行为
# 5. 支持 Spark Mode（闪耀模式）控制
#
# API 参考:
# - sidekick_component: Sidekick 基础组件
# - equipped_sidekick_component: 装备型 Sidekick（玩家携带）
# - npc_sidekick_component: NPC 型 Sidekick
# - 来源: shared/api-digests/Fortnite.digest.verse L4246-L4628

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }

# ═══════════════════════════════════════════════════════════
# 操作结果
# ═══════════════════════════════════════════════════════════

# Sidekick 操作结果
sidekick_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因（成功时为空）
    Message<public>:string = ""             # 额外信息

# ═══════════════════════════════════════════════════════════
# SidekickWrapper 模块 - UEFN Sidekick API 封装层
# ═══════════════════════════════════════════════════════════

SidekickWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 心情（Mood）操作
    # API: sidekick_component.MoodOverride:?sidekick_mood
    # API: sidekick_component.GetMood():sidekick_mood
    # digest: Fortnite.digest.verse L4565-4567
    # 
    # 可用心情类型:
    # - sidekick_mood.Neutral (中性)
    # - sidekick_mood.Combat (战斗)
    # - sidekick_mood.Worried (担忧)
    # - sidekick_mood.Bored (无聊)
    # ═══════════════════════════════════════════════════════
    
    # 设置心情覆盖（强制 Sidekick 保持特定心情）
    SetMoodOverride<public>(Component:sidekick_component, Mood:sidekick_mood):sidekick_op_result =
        # 设置心情覆盖，禁用自动心情系统
        set Component.MoodOverride = option{Mood}
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Mood override set successfully"
        }
    
    # 清除心情覆盖（恢复自动心情系统）
    ClearMoodOverride<public>(Component:sidekick_component):sidekick_op_result =
        # 设置为 false 恢复自动心情
        set Component.MoodOverride = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "Mood override cleared, automatic mood restored"
        }
    
    # 获取当前心情
    GetCurrentMood<public>(Component:sidekick_component):sidekick_mood =
        Component.GetMood()
    
    # ═══════════════════════════════════════════════════════
    # 反应（Reaction）操作
    # API: sidekick_component.PlayReaction(Reaction:sidekick_reaction)<transacts><decides>:void
    # digest: Fortnite.digest.verse L4595-4598
    #
    # 可用反应类型:
    # - sidekick_reaction.Happy (开心)
    # - sidekick_reaction.Dance (跳舞)
    # - sidekick_reaction.Emote (表情)
    # - sidekick_reaction.Excited (兴奋)
    # - sidekick_reaction.Worried (担忧)
    # ═══════════════════════════════════════════════════════
    
    # 播放反应动画
    PlayReaction<public>(Component:sidekick_component, Reaction:sidekick_reaction):sidekick_op_result =
        # 尝试播放反应（可能失败）
        if:
            Component.PlayReaction[Reaction]
        then:
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "Reaction requested successfully"
            }
        else:
            sidekick_op_result{
                Success := false,
                ErrorReason := "Failed to play reaction - Sidekick may not support this reaction",
                Message := ""
            }
    
    # ═══════════════════════════════════════════════════════
    # 装备型 Sidekick 专属操作
    # API: equipped_sidekick_component (继承自 sidekick_component)
    # digest: Fortnite.digest.verse L4246-L4280
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 的拥有者（Agent）
    GetOwningAgent<public>(Component:equipped_sidekick_component):?agent =
        # 使用 if-succeeds 处理可能失败的获取
        if (Owner := Component.GetOwningAgent[]):
            option{Owner}
        else:
            false
    
    # 设置可见性
    SetVisible<public>(Component:equipped_sidekick_component, Visible:logic):sidekick_op_result =
        set Component.Show = Visible
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := if (Visible) then "Sidekick shown" else "Sidekick hidden"
        }
    
    # 显示 Sidekick
    Show<public>(Component:equipped_sidekick_component):sidekick_op_result =
        SetVisible(Component, true)
    
    # 隐藏 Sidekick
    Hide<public>(Component:equipped_sidekick_component):sidekick_op_result =
        SetVisible(Component, false)
    
    # 启用/禁用自动反应系统
    SetAutomaticReactions<public>(Component:equipped_sidekick_component, Enabled:logic):sidekick_op_result =
        set Component.AutomaticReactionsEnabled = Enabled
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := if (Enabled) then "Automatic reactions enabled" else "Automatic reactions disabled"
        }
    
    # 启用/禁用默认交互
    SetDefaultInteraction<public>(Component:equipped_sidekick_component, Enabled:logic):sidekick_op_result =
        set Component.DefaultInteractionEnabled = Enabled
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := if (Enabled) then "Default interaction enabled" else "Default interaction disabled"
        }
    
    # ═══════════════════════════════════════════════════════
    # Spark Mode（闪耀模式）操作
    # API: equipped_sidekick_component with spark_capable_sidekick_component
    # digest: Fortnite.digest.verse L4281-L4293
    # ═══════════════════════════════════════════════════════
    
    # 设置 Spark Mode 常驻（禁用自动切换）
    SetSparkModeAlwaysActive<public>(Component:equipped_sidekick_component, AlwaysActive:logic):sidekick_op_result =
        # 尝试作为 spark_capable 处理
        if (SparkCapable := Component.As[spark_capable_sidekick_component]):
            set SparkCapable.SparkModeAlwaysActive = AlwaysActive
            
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := if (AlwaysActive) then "Spark mode locked ON" else "Spark mode auto-switching enabled"
            }
        else:
            sidekick_op_result{
                Success := false,
                ErrorReason := "This Sidekick does not support Spark Mode",
                Message := ""
            }
    
    # ═══════════════════════════════════════════════════════
    # 状态查询
    # ═══════════════════════════════════════════════════════
    
    # 检查是否可见
    IsVisible<public>(Component:equipped_sidekick_component):logic =
        Component.Show
    
    # 检查自动反应是否启用
    IsAutomaticReactionsEnabled<public>(Component:equipped_sidekick_component):logic =
        Component.AutomaticReactionsEnabled
    
    # 检查默认交互是否启用
    IsDefaultInteractionEnabled<public>(Component:equipped_sidekick_component):logic =
        Component.DefaultInteractionEnabled
    
    # 检查是否有心情覆盖
    HasMoodOverride<public>(Component:sidekick_component):logic =
        if (Component.MoodOverride?):
            true
        else:
            false
    
    # 检查 Spark Mode 是否常驻
    IsSparkModeAlwaysActive<public>(Component:equipped_sidekick_component):logic =
        if (SparkCapable := Component.As[spark_capable_sidekick_component]):
            SparkCapable.SparkModeAlwaysActive
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # NPC Sidekick 操作
    # API: npc_sidekick_component (继承自 sidekick_component)
    # digest: Fortnite.digest.verse L4607-L4628
    # 
    # 注意: NPC Sidekick 使用相同的 Mood 和 Reaction API
    # 但没有 Owner、Show、AutomaticReactions 等装备型专属功能
    # ═══════════════════════════════════════════════════════
    
    # NPC Sidekick 播放反应（类型安全的重载）
    PlayReactionNPC<public>(Component:npc_sidekick_component, Reaction:sidekick_reaction):sidekick_op_result =
        if:
            Component.PlayReaction[Reaction]
        then:
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                Message := "NPC Sidekick reaction requested successfully"
            }
        else:
            sidekick_op_result{
                Success := false,
                ErrorReason := "Failed to play reaction on NPC Sidekick",
                Message := ""
            }
    
    # NPC Sidekick 设置心情覆盖
    SetMoodOverrideNPC<public>(Component:npc_sidekick_component, Mood:sidekick_mood):sidekick_op_result =
        set Component.MoodOverride = option{Mood}
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "NPC Sidekick mood override set successfully"
        }
    
    # NPC Sidekick 清除心情覆盖
    ClearMoodOverrideNPC<public>(Component:npc_sidekick_component):sidekick_op_result =
        set Component.MoodOverride = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            Message := "NPC Sidekick mood override cleared"
        }
    
    # NPC Sidekick 获取当前心情
    GetCurrentMoodNPC<public>(Component:npc_sidekick_component):sidekick_mood =
        Component.GetMood()
