# PetWrapper - UEFN Sidekick (宠物) 系统 API 封装
# 版本: 2.0
# 更新时间: 2025-12-29
# 来源: 需求驱动示例 - 宠物系统开发 (基于 Sidekick API)
#
# 设计目的:
# 1. 统一封装 UEFN Sidekick API 调用（equipped_sidekick_component）
# 2. 提供宠物情绪、反应、可见性控制的统一接口
# 3. 处理宠物与玩家的交互逻辑
# 4. 让 Component 层无需直接依赖底层 UEFN API
#
# 业务域范围:
# - Sidekick 情绪管理（Mood）
# - Sidekick 反应播放（Reaction）
# - Sidekick 可见性控制
# - Spark 模式管理
# - 玩家交互启用/禁用
#
# API 参考:
# - equipped_sidekick_component: 玩家装备的 Sidekick 管理组件
# - sidekick_component: 所有 Sidekick 类型的基类组件
# - spark_mode_component: Spark 模式控制组件
# - 来源: shared/api-digests/Fortnite.digest.verse.md L4239-L4310
#
# 注意: Verse 中"宠物"对应的官方 API 是 Sidekick 系统

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /Fortnite.com/Characters }  # agent, fort_character
using { /Fortnite.com/Game }  # equipped_sidekick_component, sidekick_component

# ═══════════════════════════════════════════════════════════
# Sidekick 情绪枚举 (对应 sidekick_mood)
# digest: Fortnite.digest.verse.md L4239
# ═══════════════════════════════════════════════════════════

# Sidekick 情绪状态 (映射自 UEFN sidekick_mood enum)
# 注意: 这是业务层使用的类型,实际 API 调用使用 sidekick_mood
pet_mood<public> := enum:
    Neutral   # 中立状态
    Combat    # 战斗状态
    Worried   # 担忧状态
    Bored     # 无聊状态

# Sidekick 反应动作 (映射自 UEFN sidekick_reaction enum)
# digest: Fortnite.digest.verse.md L4250
pet_reaction<public> := enum:
    Happy     # 开心
    Dance     # 跳舞
    Emote     # 表情
    Angry     # 生气
    Worried   # 担忧

# ═══════════════════════════════════════════════════════════
# 操作结果结构
# ═══════════════════════════════════════════════════════════

# Sidekick 操作结果（统一返回格式）
pet_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因
    ActualValue<public>:float = 0.0         # 实际生效的数值（如适用）

# Sidekick 信息结构
pet_info<public> := struct<concrete>:
    IsVisible<public>:logic = true                  # 是否可见
    CurrentMood<public>:pet_mood = pet_mood.Neutral # 当前情绪
    AutoReactionsEnabled<public>:logic = true       # 自动反应是否启用
    InteractionEnabled<public>:logic = true         # 交互是否启用

# ═══════════════════════════════════════════════════════════
# PetWrapper 模块 - UEFN Sidekick 系统封装层
# ═══════════════════════════════════════════════════════════

PetWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 获取
    # API: agent.GetComponent(equipped_sidekick_component)
    # digest: Fortnite.digest.verse.md L4247
    # ═══════════════════════════════════════════════════════
    
    # 获取玩家装备的 Sidekick 组件
    # 注意: 如果玩家没有装备 Sidekick 则返回 false
    GetEquippedSidekick<public>(Agent:agent):?equipped_sidekick_component =
        # digest: agent.GetComponent 用于获取特定组件
        if (SidekickComp := Agent.GetComponent[equipped_sidekick_component]):
            SidekickComp
        else:
            false
    
    # 获取玩家 agent (用于从 fort_character 获取 agent)
    # digest: Fortnite.digest.verse.md (fort_character 相关)
    GetAgent<public>(Character:fort_character):?agent =
        if (PlayerAgent := agent[Character]):
            PlayerAgent
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 情绪管理
    # API: equipped_sidekick_component.MoodOverride / GetMood()
    # digest: Fortnite.digest.verse.md L4249-L4253
    # ═══════════════════════════════════════════════════════
    
    # 设置 Sidekick 情绪覆盖（锁定到指定情绪）
    SetMoodOverride<public>(
        SidekickComp:equipped_sidekick_component, 
        Mood:sidekick_mood
    ):pet_op_result =
        # digest: L4249 MoodOverride 字段
        set SidekickComp.MoodOverride = option{Mood}
        
        pet_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0.0
        }
    
    # 清除情绪覆盖（恢复自动情绪系统）
    ClearMoodOverride<public>(SidekickComp:equipped_sidekick_component):pet_op_result =
        # digest: L4249 MoodOverride 字段设为 false 清除覆盖
        set SidekickComp.MoodOverride = false
        
        pet_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0.0
        }
    
    # 获取当前情绪
    GetCurrentMood<public>(SidekickComp:equipped_sidekick_component):sidekick_mood =
        # digest: L4252 GetMood() 方法
        SidekickComp.GetMood()
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 反应播放
    # API: equipped_sidekick_component.PlayReaction()
    # digest: Fortnite.digest.verse.md L4260-L4267
    # ═══════════════════════════════════════════════════════
    
    # 播放 Sidekick 反应动作
    # 注意: 不保证立即播放,需监听 StartPlayReactionEvent
    PlayReaction<public>(
        SidekickComp:equipped_sidekick_component,
        Reaction:sidekick_reaction
    ):pet_op_result =
        # digest: L4263 PlayReaction 方法
        # 使用 if 处理 <decides> 返回
        if (SidekickComp.PlayReaction(Reaction)):
            pet_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 0.0
            }
        else:
            pet_op_result{
                Success := false,
                ErrorReason := "Sidekick cannot play this reaction",
                ActualValue := 0.0
            }
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 可见性控制
    # API: equipped_sidekick_component.Show (showable 接口)
    # digest: Fortnite.digest.verse.md L4274
    # ═══════════════════════════════════════════════════════
    
    # 设置 Sidekick 可见性
    SetVisibility<public>(
        SidekickComp:equipped_sidekick_component, 
        Visible:logic
    ):void =
        # digest: L4274 Show 字段 (showable 接口)
        set SidekickComp.Show = Visible
    
    # 显示 Sidekick
    ShowSidekick<public>(SidekickComp:equipped_sidekick_component):void =
        set SidekickComp.Show = true
    
    # 隐藏 Sidekick
    HideSidekick<public>(SidekickComp:equipped_sidekick_component):void =
        set SidekickComp.Show = false
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 交互控制
    # API: equipped_sidekick_component 交互相关字段
    # digest: Fortnite.digest.verse.md L4277-L4280
    # ═══════════════════════════════════════════════════════
    
    # 设置自动反应系统启用状态
    SetAutomaticReactions<public>(
        SidekickComp:equipped_sidekick_component,
        Enabled:logic
    ):void =
        # digest: L4277 AutomaticReactionsEnabled 字段
        set SidekickComp.AutomaticReactionsEnabled = Enabled
    
    # 设置默认交互启用状态
    SetDefaultInteraction<public>(
        SidekickComp:equipped_sidekick_component,
        Enabled:logic
    ):void =
        # digest: L4280 DefaultInteractionEnabled 字段
        set SidekickComp.DefaultInteractionEnabled = Enabled
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 信息查询
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 完整信息（用于 UI 显示或调试）
    GetSidekickInfo<public>(SidekickComp:equipped_sidekick_component):pet_info =
        CurrentMood := SidekickComp.GetMood()
        
        # 转换 sidekick_mood 到 pet_mood
        MappedMood := case (CurrentMood):
            sidekick_mood.Neutral => pet_mood.Neutral
            sidekick_mood.Combat => pet_mood.Combat
            sidekick_mood.Worried => pet_mood.Worried
            sidekick_mood.Bored => pet_mood.Bored
            _ => pet_mood.Neutral
        
        pet_info{
            IsVisible := SidekickComp.Show,
            CurrentMood := MappedMood,
            AutoReactionsEnabled := SidekickComp.AutomaticReactionsEnabled,
            InteractionEnabled := SidekickComp.DefaultInteractionEnabled
        }
