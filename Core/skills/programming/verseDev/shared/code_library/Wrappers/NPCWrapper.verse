# NPCWrapper - UEFN NPC/AI API 封装
# 版本: 1.1
# 创建时间: 2025-12-31
# 更新时间: 2025-12-31
# 来源: API 统一封装 (基于 Fortnite.digest.verse)
#
# 设计目的:
# 1. 统一封装 UEFN NPC/AI 相关 API 调用
# 2. 处理所有边界条件和错误情况
# 3. 提供类型安全的接口
# 4. 让 Component 层无需直接依赖 UEFN API
#
# 覆盖业务域:
# - NPC 行为控制 (npc_behavior, npc_actions_component)
# - NPC 感知系统 (npc_awareness_component)
# - NPC 生成管理 (npc_spawner_device)
# - Guard 高级 AI (guard_actions_component, guard_awareness_component)
# - Guard 生成管理 (guard_spawner_device)
# - Character 基础交互 (character_device)
#
# API 参考:
# - npc_behavior: Fortnite L4517-4533
# - npc_actions_component: Fortnite L4473-4494
# - npc_awareness_component: Fortnite L4498-4515
# - npc_spawner_device: Fortnite L10396-10428
# - guard_actions_component: Fortnite L4338-4372
# - guard_awareness_component: Fortnite L4376-4400
# - guard_spawner_device: Fortnite L9875-10032
# - character_device: Fortnite L8844-8862

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/SpatialMath }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Fortnite.com/AI }
using { /Fortnite.com/Game }

# ═══════════════════════════════════════════════════════════
# 操作结果
# ═══════════════════════════════════════════════════════════

# NPC 操作结果
npc_op_result<public> := struct<concrete>:
    Success<public>:logic = false
    ErrorReason<public>:string = ""
    ActualValue<public>:float = 0.0

# NPC 信息查询结果
npc_info<public> := struct<concrete>:
    IsValid<public>:logic = false
    Agent<public>:?agent = false
    Entity<public>:?entity = false
    DetectedTargetsCount<public>:int = 0
    HasDestination<public>:logic = false

# ═══════════════════════════════════════════════════════════
# NPCWrapper 模块 - UEFN NPC/AI API 封装层
# ═══════════════════════════════════════════════════════════

NPCWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # NPC 行为控制 (npc_behavior)
    # API: npc_behavior - Fortnite L4517-4533
    # ═══════════════════════════════════════════════════════
    
    # 从 NPC Behavior 获取 Agent
    GetAgentFromBehavior<public>(Behavior:npc_behavior):?agent =
        if (BehaviorAgent := Behavior.GetAgent[]):
            option{BehaviorAgent}
        else:
            false
    
    # 从 NPC Behavior 获取 Entity
    GetEntityFromBehavior<public>(Behavior:npc_behavior):?entity =
        if (BehaviorEntity := Behavior.GetEntity[]):
            option{BehaviorEntity}
        else:
            false
    
    # 从 Agent 获取 NPC Behavior
    GetNPCBehaviorFromAgent<public>(Agent:agent):?npc_behavior =
        if (Behavior := Agent.GetNPCBehavior[]):
            option{Behavior}
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # NPC 行动组件 (npc_actions_component)
    # API: npc_actions_component - Fortnite L4473-4494
    # ═══════════════════════════════════════════════════════
    
    # 导航到目标位置
    NavigateToLocation<public>(
        Actions:npc_actions_component,
        Target:(/Verse.org/SpatialMath:)vector3,
        MovementType:movement_type,
        ReachRadius:float
    )<suspends>:npc_op_result =
        NavigationResult := Actions.NavigateTo(
            navigation_target{Target := Target},
            MovementType,
            ReachRadius
        ).Await()
        
        if (NavigationResult.IsSuccess[]):
            npc_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 1.0
            }
        else:
            npc_op_result{
                Success := false,
                ErrorReason := "Navigation failed",
                ActualValue := 0.0
            }
    
    # 导航到实体目标
    NavigateToEntity<public>(
        Actions:npc_actions_component,
        Target:entity,
        MovementType:movement_type,
        ReachRadius:float
    )<suspends>:npc_op_result =
        NavigationResult := Actions.NavigateTo(
            navigation_target{Target := Target},
            MovementType,
            ReachRadius
        ).Await()
        
        if (NavigationResult.IsSuccess[]):
            npc_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 1.0
            }
        else:
            npc_op_result{
                Success := false,
                ErrorReason := "Navigation to entity failed",
                ActualValue := 0.0
            }
    
    # 获取当前目的地
    GetCurrentDestination<public>(Actions:npc_actions_component):?(/Verse.org/SpatialMath:)vector3 =
        if (Destination := Actions.GetCurrentDestination[]):
            option{Destination}
        else:
            false
    
    # 待机指定时长
    IdleForDuration<public>(Actions:npc_actions_component, Duration:float)<suspends>:void =
        Actions.Idle(Duration)
    
    # 无限待机
    IdleIndefinitely<public>(Actions:npc_actions_component)<suspends>:void =
        Actions.Idle()
    
    # 注视位置
    FocusOnLocation<public>(
        Actions:npc_actions_component,
        Location:(/Verse.org/SpatialMath:)vector3,
        LockFocus:logic
    )<suspends>:void =
        Actions.Focus(Location, LockFocus)
    
    # 注视实体
    FocusOnEntity<public>(
        Actions:npc_actions_component,
        Target:entity,
        LockFocus:logic
    )<suspends>:void =
        Actions.Focus(Target, LockFocus)
    
    # ═══════════════════════════════════════════════════════
    # NPC 感知组件 (npc_awareness_component)
    # API: npc_awareness_component - Fortnite L4498-4515
    # ═══════════════════════════════════════════════════════
    
    # 获取所有检测到的目标
    GetDetectedTargets<public>(Awareness:npc_awareness_component):[]npc_target_info =
        Awareness.DetectedTargets
    
    # 获取检测到的目标数量
    GetDetectedTargetsCount<public>(Awareness:npc_awareness_component):int =
        Awareness.DetectedTargets.Length
    
    # 检查是否检测到任何目标
    HasDetectedTargets<public>(Awareness:npc_awareness_component):logic =
        if (Awareness.DetectedTargets.Length > 0):
            true
        else:
            false
    
    # 订阅目标检测事件
    SubscribeToDetectTarget<public>(
        Awareness:npc_awareness_component,
        Handler:(npc_target_info)->void
    ):void =
        Awareness.DetectTargetEvent.Subscribe(Handler)
    
    # 订阅目标遗忘事件
    SubscribeToForgetTarget<public>(
        Awareness:npc_awareness_component,
        Handler:(entity)->void
    ):void =
        Awareness.ForgetTargetEvent.Subscribe(Handler)
    
    # 订阅视觉感知事件
    SubscribeToSeeTarget<public>(
        Awareness:npc_awareness_component,
        Handler:(npc_target_info)->void
    ):void =
        Awareness.SeeTargetEvent.Subscribe(Handler)
    
    # 订阅听觉感知事件
    SubscribeToHearTarget<public>(
        Awareness:npc_awareness_component,
        Handler:(npc_target_info)->void
    ):void =
        Awareness.HearTargetEvent.Subscribe(Handler)
    
    # 订阅触觉感知事件
    SubscribeToTouchTarget<public>(
        Awareness:npc_awareness_component,
        Handler:(npc_target_info)->void
    ):void =
        Awareness.TouchTargetEvent.Subscribe(Handler)
    
    # ═══════════════════════════════════════════════════════
    # NPC 生成器设备 (npc_spawner_device)
    # API: npc_spawner_device - Fortnite L10396-10428
    # ═══════════════════════════════════════════════════════
    
    # 启用 NPC 生成器（允许开始生成 NPC）
    EnableNPCSpawner<public>(Spawner:npc_spawner_device):void =
        Spawner.Enable()
    
    # 禁用 NPC 生成器（如果设置了"禁用时清除 AI"，将清除 NPC）
    DisableNPCSpawner<public>(Spawner:npc_spawner_device):void =
        Spawner.Disable()
    
    # 重置生成计数器（允许生成新一批 NPC）
    ResetNPCSpawner<public>(Spawner:npc_spawner_device):void =
        Spawner.Reset()
    
    # 尝试生成一个 NPC（无返回值版本）
    SpawnNPCVoid<public>(Spawner:npc_spawner_device):void =
        Spawner.Spawn()
    
    # 在指定位置生成 NPC（返回生成的 Agent）
    SpawnNPCAt<public>(
        Spawner:npc_spawner_device,
        Position:(/Verse.org/SpatialMath:)vector3,
        Rotation:?(/Verse.org/SpatialMath:)rotation
    )<suspends>:?agent =
        Spawner.SpawnAt(Position, Rotation)
    
    # 清除所有 NPC
    DespawnAllNPCs<public>(Spawner:npc_spawner_device, Instigator:?agent):void =
        Spawner.DespawnAll(Instigator)
    
    # 获取所有由此设备创建的 Agent
    GetNPCSpawnerAgents<public>(Spawner:npc_spawner_device):[]agent =
        Spawner.GetAgents()
    
    # 获取生成的 NPC 数量
    GetNPCSpawnerCount<public>(Spawner:npc_spawner_device):int =
        Spawner.GetAgents().Length
    
    # 订阅 NPC 生成事件
    SubscribeToNPCSpawned<public>(
        Spawner:npc_spawner_device,
        Handler:(agent)->void
    ):void =
        Spawner.SpawnedEvent.Subscribe(Handler)
    
    # 订阅 NPC 消灭事件
    SubscribeToNPCEliminated<public>(
        Spawner:npc_spawner_device,
        Handler:(device_ai_interaction_result)->void
    ):void =
        Spawner.EliminatedEvent.Subscribe(Handler)
    
    # ═══════════════════════════════════════════════════════
    # Guard 生成器设备 (guard_spawner_device)
    # API: guard_spawner_device - Fortnite L9875-10032
    # ═══════════════════════════════════════════════════════
    
    # 启用 Guard 生成器（Guards 开始生成）
    EnableGuardSpawner<public>(Spawner:guard_spawner_device):void =
        Spawner.Enable()
    
    # 禁用 Guard 生成器（如果设置了"禁用时清除 Guards"，将清除它们）
    DisableGuardSpawner<public>(Spawner:guard_spawner_device):void =
        Spawner.Disable()
    
    # 重置生成计数器（允许生成新一批 Guards）
    ResetGuardSpawner<public>(Spawner:guard_spawner_device):void =
        Spawner.Reset()
    
    # 尝试生成一个 Guard（无返回值版本）
    SpawnGuardVoid<public>(Spawner:guard_spawner_device):void =
        Spawner.Spawn()
    
    # 尝试生成一个 Guard 并指定 Instigator（如果设置了自动雇佣，将雇佣给 Instigator）
    SpawnGuardWithInstigator<public>(Spawner:guard_spawner_device, Instigator:agent):void =
        Spawner.Spawn(Instigator)
    
    # 在指定位置生成 Guard（返回生成的 Agent）
    SpawnGuardAt<public>(
        Spawner:guard_spawner_device,
        Position:(/Verse.org/SpatialMath:)vector3,
        Rotation:?(/Verse.org/SpatialMath:)rotation
    )<suspends>:?agent =
        Spawner.SpawnAt(Position, Rotation)
    
    # 清除 Guards（无 Instigator 版本）
    DespawnGuards<public>(Spawner:guard_spawner_device):void =
        Spawner.Despawn()
    
    # 清除 Guards（Instigator 将被视为消灭者）
    DespawnGuardsWithInstigator<public>(Spawner:guard_spawner_device, Instigator:agent):void =
        Spawner.Despawn(Instigator)
    
    # 雇佣 Guards 到 Instigator 的队伍
    HireGuards<public>(Spawner:guard_spawner_device, Instigator:agent):void =
        Spawner.Hire(Instigator)
    
    # 解雇所有已雇佣的 Guards
    DismissAllHiredGuards<public>(Spawner:guard_spawner_device):void =
        Spawner.DismissAllHiredGuards()
    
    # 解雇由 Instigator 雇佣的所有 Guards
    DismissAgentHiredGuards<public>(Spawner:guard_spawner_device, Instigator:agent):void =
        Spawner.DismissAgentHiredGuards(Instigator)
    
    # 强制 Guards 攻击目标（绕过感知检查）
    # ForgetTime: 0.0-600.0 秒，默认 600.0，目标未找到后多久忽略
    # ForgetDistance: 0.0-100000.0 厘米，默认 100000.0，目标超过此距离后忽略
    ForceGuardAttackTarget<public>(
        Spawner:guard_spawner_device,
        Target:agent,
        ForgetTime:?float,
        ForgetDistance:?float
    ):void =
        Spawner.ForceAttackTarget(Target, ForgetTime, ForgetDistance)
    
    # 允许 Guards 被雇佣
    SetGuardsHireable<public>(Spawner:guard_spawner_device):void =
        Spawner.SetGuardsHireable()
    
    # 禁止 Guards 被雇佣
    SetGuardsNotHireable<public>(Spawner:guard_spawner_device):void =
        Spawner.SetGuardsNotHireable()
    
    # 获取设备的生成限制数量
    GetGuardSpawnLimit<public>(Spawner:guard_spawner_device):int =
        Spawner.GetSpawnLimit()
    
    # 获取所有由此设备创建的 Guard Agent
    GetGuardSpawnerAgents<public>(Spawner:guard_spawner_device):[]agent =
        Spawner.GetAgents()
    
    # 获取生成的 Guard 数量
    GetGuardSpawnerCount<public>(Spawner:guard_spawner_device):int =
        Spawner.GetAgents().Length
    
    # 设置 Guard 名称（用于雇佣对话和消灭反馈）
    SetGuardName<public>(Spawner:guard_spawner_device, Name:message):void =
        Spawner.SetName(Name)
    
    # 获取 Guard 名称
    GetGuardName<public>(Spawner:guard_spawner_device):string =
        Spawner.GetName()
    
    # 订阅 Guard 生成事件
    SubscribeToGuardSpawned<public>(
        Spawner:guard_spawner_device,
        Handler:(agent)->void
    ):void =
        Spawner.SpawnedEvent.Subscribe(Handler)
    
    # 订阅 Guard 识别到敌人事件
    SubscribeToGuardAlerted<public>(
        Spawner:guard_spawner_device,
        Handler:(device_ai_interaction_result)->void
    ):void =
        Spawner.AlertedEvent.Subscribe(Handler)
    
    # 订阅 Guard 失去目标事件
    SubscribeToGuardTargetLost<public>(
        Spawner:guard_spawner_device,
        Handler:(device_ai_interaction_result)->void
    ):void =
        Spawner.TargetLostEvent.Subscribe(Handler)
    
    # 订阅 Guard 变为可疑状态事件
    SubscribeToGuardSuspicious<public>(
        Spawner:guard_spawner_device,
        Handler:(agent)->void
    ):void =
        Spawner.SuspiciousEvent.Subscribe(Handler)
    
    # 订阅 Guard 变为未察觉状态事件
    SubscribeToGuardUnaware<public>(
        Spawner:guard_spawner_device,
        Handler:(agent)->void
    ):void =
        Spawner.UnawareEvent.Subscribe(Handler)
    
    # 订阅 Guard 受到伤害事件
    SubscribeToGuardDamaged<public>(
        Spawner:guard_spawner_device,
        Handler:(device_ai_interaction_result)->void
    ):void =
        Spawner.DamagedEvent.Subscribe(Handler)
    
    # 订阅 Guard 被消灭事件
    SubscribeToGuardEliminated<public>(
        Spawner:guard_spawner_device,
        Handler:(device_ai_interaction_result)->void
    ):void =
        Spawner.EliminatedEvent.Subscribe(Handler)
    
    # 订阅 Guard 消灭其他 Agent 事件
    SubscribeToGuardEliminating<public>(
        Spawner:guard_spawner_device,
        Handler:(device_ai_interaction_result)->void
    ):void =
        Spawner.EliminatingEvent.Subscribe(Handler)
    
    # 订阅 Guard 被雇佣事件
    SubscribeToGuardHired<public>(
        Spawner:guard_spawner_device,
        Handler:(device_ai_interaction_result)->void
    ):void =
        Spawner.HiredEvent.Subscribe(Handler)
    
    # 订阅 Guard 被解雇事件
    SubscribeToGuardDismissed<public>(
        Spawner:guard_spawner_device,
        Handler:(device_ai_interaction_result)->void
    ):void =
        Spawner.DismissedEvent.Subscribe(Handler)
    
    # ═══════════════════════════════════════════════════════
    # Character 设备 (character_device)
    # API: character_device - Fortnite L8844-8862
    # ═══════════════════════════════════════════════════════
    
    # 启用 Character 设备
    EnableCharacterDevice<public>(Device:character_device):void =
        Device.Enable()
    
    # 禁用 Character 设备
    DisableCharacterDevice<public>(Device:character_device):void =
        Device.Disable()
    
    # 显示 Character
    ShowCharacter<public>(Device:character_device):void =
        Device.Show()
    
    # 隐藏 Character
    HideCharacter<public>(Device:character_device):void =
        Device.Hide()
    
    # 播放 Character 表情
    PlayCharacterEmote<public>(Device:character_device):void =
        Device.PlayEmote()
    
    # 订阅 Character 交互事件
    SubscribeToCharacterInteracted<public>(
        Device:character_device,
        Handler:(agent)->void
    ):void =
        Device.InteractedWithEvent.Subscribe(Handler)
    
    # ═══════════════════════════════════════════════════════
    # Guard 行动组件 (guard_actions_component)
    # API: guard_actions_component - Fortnite L4338-4372
    # 注意: guard_actions_component 继承自 npc_actions_component
    # ═══════════════════════════════════════════════════════
    
    # Guard 漫游
    GuardRoamAround<public>(
        Actions:guard_actions_component,
        MovementType:movement_type
    )<suspends>:npc_op_result =
        RoamResult := Actions.RoamAround(MovementType).Await()
        
        if (RoamResult.IsSuccess[]):
            npc_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 1.0
            }
        else:
            npc_op_result{
                Success := false,
                ErrorReason := "Roam failed",
                ActualValue := 0.0
            }
    
    # Guard 移动到攻击范围
    GuardMoveInRangeToAttack<public>(Actions:guard_actions_component)<suspends>:npc_op_result =
        MoveResult := Actions.MoveInRangeToAttack().Await()
        
        if (MoveResult.IsSuccess[]):
            npc_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 1.0
            }
        else:
            npc_op_result{
                Success := false,
                ErrorReason := "Move to attack range failed",
                ActualValue := 0.0
            }
    
    # Guard 攻击目标
    GuardAttack<public>(Actions:guard_actions_component, Target:entity)<suspends>:npc_op_result =
        AttackResult := Actions.Attack(Target).Await()
        
        if (AttackResult.IsSuccess[]):
            npc_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 1.0
            }
        else:
            npc_op_result{
                Success := false,
                ErrorReason := "Attack failed",
                ActualValue := 0.0
            }
    
    # Guard 拴系到位置
    GuardTetherToLocation<public>(
        Actions:guard_actions_component,
        Location:(/Verse.org/SpatialMath:)vector3,
        Radius:float
    ):void =
        Actions.Tether(Location, Radius)
    
    # Guard 拴系到实体
    GuardTetherToEntity<public>(
        Actions:guard_actions_component,
        Target:entity,
        Radius:float
    ):void =
        Actions.Tether(Target, Radius)
    
    # Guard 解除拴系
    GuardUntether<public>(Actions:guard_actions_component):void =
        Actions.Untether()
    
    # ═══════════════════════════════════════════════════════
    # Guard 感知组件 (guard_awareness_component)
    # API: guard_awareness_component - Fortnite L4376-4400
    # 注意: guard_awareness_component 继承自 npc_awareness_component
    # ═══════════════════════════════════════════════════════
    
    # 获取检测到的障碍物
    GetDetectedObstacle<public>(Awareness:guard_awareness_component):?entity =
        Awareness.DetectedObstacle
    
    # 订阅障碍物检测事件
    SubscribeToDetectObstacle<public>(
        Awareness:guard_awareness_component,
        Handler:(entity)->void
    ):void =
        Awareness.DetectObstacleEvent.Subscribe(Handler)
    
    # 订阅障碍物遗忘事件
    SubscribeToForgetObstacle<public>(
        Awareness:guard_awareness_component,
        Handler:(entity)->void
    ):void =
        Awareness.ForgetObstacleEvent.Subscribe(Handler)
    
    # 获取主要威胁
    GetPrimaryThreat<public>(Awareness:guard_awareness_component):?npc_target_info =
        Awareness.PrimaryThreat
    
    # 订阅主要威胁变化事件
    SubscribeToPrimaryThreatChange<public>(
        Awareness:guard_awareness_component,
        Handler:(npc_target_info)->void
    ):void =
        Awareness.PrimaryThreatChangeEvent.Subscribe(Handler)
    
    # 获取警戒级别
    GetAlertLevel<public>(Awareness:guard_awareness_component):guard_alert_level =
        Awareness.AlertLevel
    
    # 订阅警戒级别变化事件
    SubscribeToAlertLevelChange<public>(
        Awareness:guard_awareness_component,
        Handler:(guard_alert_level)->void
    ):void =
        Awareness.AlertLevelChangeEvent.Subscribe(Handler)
    
    # 检查是否在警戒状态
    IsAlerted<public>(Awareness:guard_awareness_component):logic =
        case (Awareness.AlertLevel):
            guard_alert_level.Alerted => true
            guard_alert_level.Combat => true
            _ => false
    
    # ═══════════════════════════════════════════════════════
    # 工具函数
    # ═══════════════════════════════════════════════════════
    
    # 获取 NPC 综合信息
    GetNPCInfo<public>(Behavior:npc_behavior, Actions:?npc_actions_component, Awareness:?npc_awareness_component):npc_info =
        var Info:npc_info = npc_info{}
        
        # 获取 Agent 和 Entity
        if (Agent := Behavior.GetAgent[]):
            set Info.IsValid = true
            set Info.Agent = option{Agent}
        
        if (Entity := Behavior.GetEntity[]):
            set Info.Entity = option{Entity}
        
        # 获取感知信息
        if (AwarenessComp := Awareness?):
            set Info.DetectedTargetsCount = AwarenessComp.DetectedTargets.Length
        
        # 获取行动信息
        if (ActionsComp := Actions?):
            if (ActionsComp.GetCurrentDestination[]):
                set Info.HasDestination = true
        
        Info
    
    # 检查 NPC 是否有有效目标
    HasValidTarget<public>(Awareness:npc_awareness_component):logic =
        DetectedTargets := Awareness.DetectedTargets
        if (DetectedTargets.Length > 0):
            true
        else:
            false
    
    # 从目标信息获取实体
    GetTargetEntity<public>(TargetInfo:npc_target_info):entity =
        TargetInfo.Target
    
    # 从目标信息获取最后已知位置
    GetTargetLastKnownPosition<public>(TargetInfo:npc_target_info):(/Verse.org/SpatialMath:)vector3 =
        TargetInfo.LastKnownLocation
