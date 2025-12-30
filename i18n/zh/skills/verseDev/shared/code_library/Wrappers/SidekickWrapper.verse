# SidekickWrapper - UEFN Sidekick API 封装
# 版本: 1.0
# 更新时间: 2025-12-30
# 来源: REQ-task-20251230-102230-9 - Sidekick 系统开发需求
#
# 设计目的:
# 1. 统一封装 UEFN Sidekick 相关 API 调用
# 2. 提供 Sidekick 心情控制、反应播放、可见性管理的统一接口
# 3. 处理所有边界条件和错误情况
# 4. 让 Component 层无需直接依赖 UEFN Sidekick API
#
# 业务域范围:
# - Sidekick 心情（Mood）管理与切换
# - Sidekick 反应（Reaction）播放与事件监听
# - Sidekick 可见性控制（仅限 equipped_sidekick_component）
# - Sidekick 所有者（Owner）查询
# - Sidekick 自动反应与交互设置
# - Spark 模式管理
#
# API 参考:
# - sidekick_component: 所有 Sidekick 类型的基础组件
# - equipped_sidekick_component: 玩家装备的 Sidekick（实现 showable 接口）
# - npc_sidekick_component: NPC Sidekick
# - spark_mode_component: Spark 模式组件
# - 来源: shared/api-digests/Fortnite.digest.verse.md L4246-4628

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
    ErrorReason<public>:string = ""         # 失败原因（成功时为空）
    ActualValue<public>:float = 0.0         # 实际生效的数值（如适用）

# Sidekick 心情信息
sidekick_mood_info<public> := struct<concrete>:
    CurrentMood<public>:sidekick_mood = sidekick_mood.Neutral
    HasOverride<public>:logic = false       # 是否设置了心情覆盖
    OverrideMood<public>:?sidekick_mood = false  # 覆盖的心情值

# Sidekick 完整状态信息
sidekick_state_info<public> := struct<concrete>:
    IsValid<public>:logic = false           # Sidekick 是否有效
    CurrentMood<public>:sidekick_mood = sidekick_mood.Neutral
    IsVisible<public>:logic = true          # 是否可见（仅适用于 equipped_sidekick）
    AutomaticReactionsEnabled<public>:logic = true
    DefaultInteractionEnabled<public>:logic = true

# ═══════════════════════════════════════════════════════════
# SidekickWrapper 模块 - UEFN Sidekick API 封装层
# ═══════════════════════════════════════════════════════════

SidekickWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 心情（Mood）管理
    # API: sidekick_component.GetMood()<reads>:sidekick_mood
    # API: sidekick_component.MoodOverride:?sidekick_mood
    # digest: Fortnite.digest.verse.md L4584-4604
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 当前心情
    GetMood<public>(Sidekick:sidekick_component):sidekick_mood =
        # 直接调用 sidekick_component.GetMood() 方法
        # digest: L4590
        Sidekick.GetMood()
    
    # 设置心情覆盖（锁定到特定心情，禁用自动心情系统）
    SetMoodOverride<public>(Sidekick:sidekick_component, Mood:sidekick_mood):sidekick_op_result =
        # 设置 MoodOverride 变量覆盖自动心情
        # digest: L4587
        set Sidekick.MoodOverride = option{Mood}
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0.0
        }
    
    # 清除心情覆盖（恢复自动心情系统）
    ClearMoodOverride<public>(Sidekick:sidekick_component):sidekick_op_result =
        # 将 MoodOverride 设置为 false 以恢复自动心情
        # digest: L4587
        set Sidekick.MoodOverride = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0.0
        }
    
    # 获取心情信息（包括是否有覆盖）
    GetMoodInfo<public>(Sidekick:sidekick_component):sidekick_mood_info =
        CurrentMood := Sidekick.GetMood()
        OverrideValue := Sidekick.MoodOverride
        
        if (OverrideMood := OverrideValue?):
            sidekick_mood_info{
                CurrentMood := CurrentMood,
                HasOverride := true,
                OverrideMood := option{OverrideMood}
            }
        else:
            sidekick_mood_info{
                CurrentMood := CurrentMood,
                HasOverride := false,
                OverrideMood := false
            }
    
    # ═══════════════════════════════════════════════════════
    # 反应（Reaction）播放
    # API: sidekick_component.PlayReaction(Reaction:sidekick_reaction)<transacts><decides>:void
    # digest: Fortnite.digest.verse.md L4598
    # ═══════════════════════════════════════════════════════
    
    # 播放指定反应
    # 注意: 此方法使用 <decides> 效果器，可能失败
    # 应该监听 StartPlayReactionEvent 来确认反应是否开始播放
    PlayReaction<public>(Sidekick:sidekick_component, Reaction:sidekick_reaction):sidekick_op_result =
        # 尝试播放反应，如果 Sidekick 无法播放该反应则失败
        # digest: L4598
        if (Sidekick.PlayReaction[Reaction]):
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 0.0
            }
        else:
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick cannot play the specified reaction",
                ActualValue := 0.0
            }
    
    # ═══════════════════════════════════════════════════════
    # 可见性控制（仅限 equipped_sidekick_component）
    # API: equipped_sidekick_component.Show:logic (implements showable)
    # digest: Fortnite.digest.verse.md L4273
    # ═══════════════════════════════════════════════════════
    
    # 显示 Sidekick（仅适用于装备的 Sidekick）
    ShowSidekick<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        # 设置 Show 变量为 true
        # digest: L4273
        set Sidekick.Show = true
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 1.0
        }
    
    # 隐藏 Sidekick（仅适用于装备的 Sidekick）
    HideSidekick<public>(Sidekick:equipped_sidekick_component):sidekick_op_result =
        # 设置 Show 变量为 false
        # digest: L4273
        set Sidekick.Show = false
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0.0
        }
    
    # 检查 Sidekick 是否可见
    IsVisible<public>(Sidekick:equipped_sidekick_component):logic =
        # 读取 Show 变量状态
        # digest: L4273
        if (Sidekick.Show):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 所有者（Owner）查询（仅限 equipped_sidekick_component）
    # API: equipped_sidekick_component.GetOwningAgent()<transacts><decides>:agent
    # digest: Fortnite.digest.verse.md L4270
    # ═══════════════════════════════════════════════════════
    
    # 获取拥有此 Sidekick 的 Agent
    # 注意: 使用 <decides> 效果器，可能失败
    GetOwningAgent<public>(Sidekick:equipped_sidekick_component)<transacts>:?agent =
        # 调用 GetOwningAgent 方法
        # digest: L4270
        if (Owner := Sidekick.GetOwningAgent[]):
            option{Owner}
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 自动反应与交互设置（仅限 equipped_sidekick_component）
    # API: equipped_sidekick_component.AutomaticReactionsEnabled:logic
    # API: equipped_sidekick_component.DefaultInteractionEnabled:logic
    # digest: Fortnite.digest.verse.md L4276, L4279
    # ═══════════════════════════════════════════════════════
    
    # 启用自动反应系统
    EnableAutomaticReactions<public>(Sidekick:equipped_sidekick_component):void =
        # Sidekick 会根据玩家状态运行反应动画
        # digest: L4276
        set Sidekick.AutomaticReactionsEnabled = true
    
    # 禁用自动反应系统
    DisableAutomaticReactions<public>(Sidekick:equipped_sidekick_component):void =
        # digest: L4276
        set Sidekick.AutomaticReactionsEnabled = false
    
    # 启用默认玩家交互
    EnableDefaultInteraction<public>(Sidekick:equipped_sidekick_component):void =
        # Sidekick 的内置玩家交互功能
        # digest: L4279
        set Sidekick.DefaultInteractionEnabled = true
    
    # 禁用默认玩家交互
    DisableDefaultInteraction<public>(Sidekick:equipped_sidekick_component):void =
        # digest: L4279
        set Sidekick.DefaultInteractionEnabled = false
    
    # 检查自动反应是否启用
    IsAutomaticReactionsEnabled<public>(Sidekick:equipped_sidekick_component):logic =
        if (Sidekick.AutomaticReactionsEnabled):
            true
        else:
            false
    
    # 检查默认交互是否启用
    IsDefaultInteractionEnabled<public>(Sidekick:equipped_sidekick_component):logic =
        if (Sidekick.DefaultInteractionEnabled):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # Spark 模式管理（spark_mode_component）
    # API: spark_mode_component.SparkModeAlwaysActive:logic
    # digest: Fortnite.digest.verse.md L4285-4293
    # ═══════════════════════════════════════════════════════
    
    # 启用永久 Spark 模式
    EnableAlwaysSparkMode<public>(SparkComponent:spark_mode_component):void =
        # 强制 Sidekick 始终保持 Spark 模式
        # digest: L4287
        set SparkComponent.SparkModeAlwaysActive = true
    
    # 禁用永久 Spark 模式（恢复自动切换）
    DisableAlwaysSparkMode<public>(SparkComponent:spark_mode_component):void =
        # 允许 Sidekick 根据地形和视觉需求自动切换 Spark 模式
        # digest: L4287
        set SparkComponent.SparkModeAlwaysActive = false
    
    # 检查是否处于永久 Spark 模式
    IsAlwaysSparkModeActive<public>(SparkComponent:spark_mode_component):logic =
        if (SparkComponent.SparkModeAlwaysActive):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 状态查询与信息聚合
    # ═══════════════════════════════════════════════════════
    
    # 获取 equipped_sidekick 的完整状态信息
    GetEquippedSidekickState<public>(Sidekick:equipped_sidekick_component):sidekick_state_info =
        CurrentMood := Sidekick.GetMood()
        Visible := Sidekick.Show
        AutoReactions := Sidekick.AutomaticReactionsEnabled
        DefaultInteraction := Sidekick.DefaultInteractionEnabled
        
        sidekick_state_info{
            IsValid := true,
            CurrentMood := CurrentMood,
            IsVisible := Visible,
            AutomaticReactionsEnabled := AutoReactions,
            DefaultInteractionEnabled := DefaultInteraction
        }
    
    # 获取 npc_sidekick 的基础状态信息
    GetNPCSidekickState<public>(Sidekick:npc_sidekick_component):sidekick_state_info =
        CurrentMood := Sidekick.GetMood()
        
        sidekick_state_info{
            IsValid := true,
            CurrentMood := CurrentMood,
            IsVisible := true,  # NPC Sidekick 没有 Show 属性
            AutomaticReactionsEnabled := true,  # NPC Sidekick 没有这些属性
            DefaultInteractionEnabled := true
        }
    
    # ═══════════════════════════════════════════════════════
    # 工具函数 - 心情和反应枚举检查
    # ═══════════════════════════════════════════════════════
    
    # 验证心情值是否有效（虽然 enum<open> 可扩展，但这里检查核心值）
    IsValidMood<public>(Mood:sidekick_mood):logic =
        # 检查是否为已知的核心心情值
        if (Mood = sidekick_mood.Neutral or
            Mood = sidekick_mood.Combat or
            Mood = sidekick_mood.Worried or
            Mood = sidekick_mood.Bored):
            true
        else:
            # 可能是扩展的心情值，仍然有效
            true
    
    # 验证反应值是否有效
    IsValidReaction<public>(Reaction:sidekick_reaction):logic =
        # 检查是否为已知的核心反应值
        if (Reaction = sidekick_reaction.Happy or
            Reaction = sidekick_reaction.Dance or
            Reaction = sidekick_reaction.Emote or
            Reaction = sidekick_reaction.Angry or
            Reaction = sidekick_reaction.Worried):
            true
        else:
            # 可能是扩展的反应值，仍然有效
            true
    
    # ═══════════════════════════════════════════════════════
    # 事件监听辅助说明
    # ═══════════════════════════════════════════════════════
    
    # 注意: 以下事件需要在 Component 层使用 Verse 的 Subscribe 机制监听:
    # 
    # 1. ChangeMoodEvent: listenable(tuple(sidekick_mood, sidekick_mood))
    #    - 监听心情变化事件，返回 (旧心情, 新心情)
    #    - 示例: Sidekick.ChangeMoodEvent.Subscribe(OnMoodChanged)
    # 
    # 2. StartPlayReactionEvent: listenable(sidekick_reaction)
    #    - 监听反应开始播放事件
    #    - 示例: Sidekick.StartPlayReactionEvent.Subscribe(OnReactionStart)
    # 
    # 3. StopPlayReactionEvent: listenable(sidekick_reaction)
    #    - 监听反应结束播放事件
    #    - 示例: Sidekick.StopPlayReactionEvent.Subscribe(OnReactionStop)
    # 
    # 4. BeginSparkModeEvent: listenable(tuple()) (spark_mode_component)
    #    - 监听进入 Spark 模式事件
    #    - 示例: SparkComponent.BeginSparkModeEvent.Subscribe(OnBeginSpark)
    # 
    # 5. EndSparkModeEvent: listenable(tuple()) (spark_mode_component)
    #    - 监听退出 Spark 模式事件
    #    - 示例: SparkComponent.EndSparkModeEvent.Subscribe(OnEndSpark)
    # 
    # Wrapper 层不封装事件订阅逻辑，由 Component 层根据需求订阅
