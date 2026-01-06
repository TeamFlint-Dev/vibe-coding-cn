# NPCWrapper - UEFN NPC/AI API 封装
# 版本: 1.0
# 创建时间: 2025-12-31
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
#
# API 参考:
# - npc_behavior: Fortnite L4517-4533
# - npc_actions_component: Fortnite L4473-4494
# - npc_awareness_component: Fortnite L4498-4515
# - guard_actions_component: Fortnite L4338-4372
# - guard_awareness_component: Fortnite L4376-4400
# - npc_spawner_device: Fortnite L10396-10428
# - guard_spawner_device: Fortnite L9875-10032

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
    
    # 生成 NPC
    SpawnNPC<public>(Spawner:npc_spawner_device)<suspends>:?agent =
        Spawner.Spawn()
    
    # 在指定位置生成 NPC
    SpawnNPCAt<public>(
        Spawner:npc_spawner_device,
        Position:(/UnrealEngine.com/Temporary/SpatialMath:)vector3,
        Rotation:?(/UnrealEngine.com/Temporary/SpatialMath:)rotation
    )<suspends>:?agent =
        Spawner.SpawnAt(Position, Rotation)
    
    # 清除单个 NPC
    DespawnNPC<public>(Spawner:npc_spawner_device, Target:agent, Instigator:?agent):void =
        Spawner.Despawn(Target, Instigator)
    
    # 清除所有 NPC
    DespawnAllNPCs<public>(Spawner:npc_spawner_device, Instigator:?agent):void =
        Spawner.DespawnAll(Instigator)
    
    # 获取所有生成的 NPC Agent
    GetAllSpawnedNPCs<public>(Spawner:npc_spawner_device):[]agent =
        Spawner.GetSpawnedAgents()
    
    # 获取生成的 NPC 数量
    GetSpawnedNPCCount<public>(Spawner:npc_spawner_device):int =
        Spawner.GetSpawnedAgents().Length
    
    # 订阅 NPC 生成事件
    SubscribeToNPCSpawned<public>(
        Spawner:npc_spawner_device,
        Handler:(agent)->void
    ):void =
        Spawner.SpawnedEvent.Subscribe(Handler)
    
    # 订阅 NPC 消灭事件
    SubscribeToNPCEliminated<public>(
        Spawner:npc_spawner_device,
        Handler:(elimination_result)->void
    ):void =
        Spawner.EliminatedEvent.Subscribe(Handler)
    
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
