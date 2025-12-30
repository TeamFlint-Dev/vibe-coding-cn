# GameFlowWrapper - UEFN 游戏流程与生命周期 API 封装
# 版本: 1.0
# 更新时间: 2025-12-30
# 来源: REQ - 游戏流程生命周期功能开发
#
# 设计目的:
# 1. 统一封装 UEFN 游戏生命周期、回合管理、玩家管理等 API 调用
# 2. 处理游戏开始/结束、回合管理、玩家加入/离开、分数管理等核心流程
# 3. 提供类型安全的接口和统一错误处理
# 4. 让 Component 层无需直接依赖底层 UEFN 游戏流程 API
#
# 业务域范围:
# - 游戏生命周期管理（OnBegin/OnEnd 包装）
# - 回合管理（回合开始/结束控制）
# - 玩家生命周期（加入/离开/重生/淘汰）
# - 游戏状态控制（结束游戏、胜利/失败条件）
# - 出生点管理（玩家/检查点出生）
# - 分数与计时器管理
# - 团队管理
#
# API 参考:
# - fort_playspace: 游戏空间接口（玩家管理、团队管理）
# - round_settings_device: 回合设置设备
# - end_game_device: 游戏结束设备
# - player_spawner_device: 玩家出生点设备
# - player_checkpoint_device: 玩家检查点设备
# - score_manager_device: 分数管理设备
# - creative_device: 自定义设备基类（OnBegin/OnEnd）
# - 来源: shared/api-digests/Fortnite.digest.verse.md

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Teams }
using { /Fortnite.com/Playspaces }

# ═══════════════════════════════════════════════════════════
# 操作结果结构
# ═══════════════════════════════════════════════════════════

# 游戏流程操作结果（统一返回格式）
game_flow_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因（成功时为空）
    ActualValue<public>:int = 0             # 实际生效的数值（如玩家数量等）

# 玩家信息结构
player_info<public> := struct<concrete>:
    PlayerAgent<public>:?agent = false      # 玩家 agent（可能为空）
    IsValid<public>:logic = false           # 玩家是否有效
    TeamIndex<public>:int = -1              # 所属队伍索引（-1 表示无队伍）

# 游戏状态信息结构
game_state_info<public> := struct<concrete>:
    PlayerCount<public>:int = 0             # 当前玩家数量
    ParticipantCount<public>:int = 0        # 参与者数量（包括AI）
    IsGameActive<public>:logic = false      # 游戏是否进行中

# ═══════════════════════════════════════════════════════════
# GameFlowWrapper 模块 - UEFN 游戏流程 API 封装层
# ═══════════════════════════════════════════════════════════

GameFlowWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 游戏空间操作（fort_playspace）
    # API: fort_playspace.GetPlayers():[]player
    # API: fort_playspace.PlayerAddedEvent():listenable(player)
    # API: fort_playspace.PlayerRemovedEvent():listenable(player)
    # digest: Fortnite.digest.verse.md L12076-12101
    # ═══════════════════════════════════════════════════════
    
    # 获取游戏空间中所有人类玩家
    # 返回当前游戏空间中的所有人类玩家列表
    GetAllPlayers<public>(Playspace:fort_playspace)<transacts>:[]player =
        # digest: fort_playspace.GetPlayers()<transacts>:[]player
        Playspace.GetPlayers()
    
    # 获取游戏空间中所有参与者（包括AI）
    # 返回所有参与者 agent 列表（人类玩家 + AI 角色）
    GetAllParticipants<public>(Playspace:fort_playspace)<transacts>:[]agent =
        # digest: fort_playspace.GetParticipants()<transacts>:[]agent
        Playspace.GetParticipants()
    
    # 获取玩家加入事件监听器
    # 当人类玩家加入游戏空间时触发
    GetPlayerAddedEvent<public>(Playspace:fort_playspace):listenable(player) =
        # digest: fort_playspace.PlayerAddedEvent():listenable(player)
        Playspace.PlayerAddedEvent()
    
    # 获取玩家离开事件监听器
    # 当人类玩家离开游戏空间时触发
    GetPlayerRemovedEvent<public>(Playspace:fort_playspace):listenable(player) =
        # digest: fort_playspace.PlayerRemovedEvent():listenable(player)
        Playspace.PlayerRemovedEvent()
    
    # 获取参与者加入事件监听器
    # 当参与者（人类玩家或AI）加入游戏空间时触发
    GetParticipantAddedEvent<public>(Playspace:fort_playspace):listenable(agent) =
        # digest: fort_playspace.ParticipantAddedEvent():listenable(agent)
        Playspace.ParticipantAddedEvent()
    
    # 获取参与者离开事件监听器
    # 当参与者（人类玩家或AI）离开游戏空间时触发
    GetParticipantRemovedEvent<public>(Playspace:fort_playspace):listenable(agent) =
        # digest: fort_playspace.ParticipantRemovedEvent():listenable(agent)
        Playspace.ParticipantRemovedEvent()
    
    # 获取游戏空间的团队集合
    # 用于访问和管理团队信息
    GetTeamCollection<public>(Playspace:fort_playspace)<transacts>:fort_team_collection =
        # digest: fort_playspace.GetTeamCollection()<transacts>:fort_team_collection
        Playspace.GetTeamCollection()
    
    # ═══════════════════════════════════════════════════════
    # 回合管理（round_settings_device）
    # API: round_settings_device.RoundBeginEvent:listenable(tuple())
    # API: round_settings_device.Enable/Disable
    # digest: Fortnite.digest.verse.md L8145+
    # ═══════════════════════════════════════════════════════
    
    # 获取回合开始事件监听器
    # 当游戏回合开始时触发
    GetRoundBeginEvent<public>(RoundDevice:round_settings_device):listenable(tuple()) =
        # digest: round_settings_device.RoundBeginEvent:listenable(tuple())
        RoundDevice.RoundBeginEvent
    
    # 启用回合设置设备
    # 激活回合管理功能
    EnableRoundSettings<public>(RoundDevice:round_settings_device):game_flow_op_result =
        # digest: round_settings_device.Enable():void
        RoundDevice.Enable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 1
        }
    
    # 禁用回合设置设备
    # 停用回合管理功能
    DisableRoundSettings<public>(RoundDevice:round_settings_device):game_flow_op_result =
        # digest: round_settings_device.Disable():void
        RoundDevice.Disable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0
        }
    
    # ═══════════════════════════════════════════════════════
    # 游戏结束控制（end_game_device）
    # API: end_game_device.Activate(Agent:agent):void
    # API: end_game_device.Enable/Disable
    # digest: Fortnite.digest.verse.md end_game_device
    # ═══════════════════════════════════════════════════════
    
    # 结束回合或游戏
    # 使用指定 agent 的队伍信息来判定结束条件
    # 如果设备启用了"激活队伍"选项，会根据 agent 的队伍决定结束逻辑
    EndGame<public>(EndGameDevice:end_game_device, TriggerAgent:agent):game_flow_op_result =
        # digest: end_game_device.Activate(Agent:agent):void
        EndGameDevice.Activate(TriggerAgent)
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 1
        }
    
    # 启用游戏结束设备
    # 激活游戏结束检测功能
    EnableEndGame<public>(EndGameDevice:end_game_device):game_flow_op_result =
        # digest: end_game_device.Enable():void
        EndGameDevice.Enable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 1
        }
    
    # 禁用游戏结束设备
    # 停用游戏结束检测功能
    DisableEndGame<public>(EndGameDevice:end_game_device):game_flow_op_result =
        # digest: end_game_device.Disable():void
        EndGameDevice.Disable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0
        }
    
    # ═══════════════════════════════════════════════════════
    # 出生点管理（player_spawner_device）
    # API: player_spawner_device.SpawnedEvent:listenable(agent)
    # API: player_spawner_device.Enable/Disable
    # digest: Fortnite.digest.verse.md player_spawner_device
    # ═══════════════════════════════════════════════════════
    
    # 获取玩家出生事件监听器
    # 当 agent 从出生点设备出生时触发
    GetPlayerSpawnedEvent<public>(SpawnerDevice:player_spawner_device):listenable(agent) =
        # digest: player_spawner_device.SpawnedEvent:listenable(agent)
        SpawnerDevice.SpawnedEvent
    
    # 启用玩家出生点
    # 激活出生点功能
    EnablePlayerSpawner<public>(SpawnerDevice:player_spawner_device):game_flow_op_result =
        # digest: player_spawner_device.Enable():void
        SpawnerDevice.Enable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 1
        }
    
    # 禁用玩家出生点
    # 停用出生点功能
    DisablePlayerSpawner<public>(SpawnerDevice:player_spawner_device):game_flow_op_result =
        # digest: player_spawner_device.Disable():void
        SpawnerDevice.Disable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0
        }
    
    # ═══════════════════════════════════════════════════════
    # 检查点管理（player_checkpoint_device）
    # API: player_checkpoint_device.FirstActivationEvent:listenable(agent)
    # API: player_checkpoint_device.Enable/Disable
    # digest: Fortnite.digest.verse.md player_checkpoint_device
    # ═══════════════════════════════════════════════════════
    
    # 获取检查点首次激活事件监听器
    # 当检查点首次被任何 agent 激活时触发
    GetCheckpointFirstActivationEvent<public>(CheckpointDevice:player_checkpoint_device):listenable(agent) =
        # digest: player_checkpoint_device.FirstActivationEvent:listenable(agent)
        CheckpointDevice.FirstActivationEvent
    
    # 启用检查点
    # 激活检查点功能
    EnableCheckpoint<public>(CheckpointDevice:player_checkpoint_device):game_flow_op_result =
        # digest: player_checkpoint_device.Enable():void
        CheckpointDevice.Enable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 1
        }
    
    # 禁用检查点
    # 停用检查点功能
    DisableCheckpoint<public>(CheckpointDevice:player_checkpoint_device):game_flow_op_result =
        # digest: player_checkpoint_device.Disable():void
        CheckpointDevice.Disable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0
        }
    
    # ═══════════════════════════════════════════════════════
    # 分数管理（score_manager_device）
    # API: score_manager_device.MaxTriggersEvent:listenable(agent)
    # API: score_manager_device.ScoreOutputEvent:listenable(agent)
    # API: score_manager_device.Enable/Disable
    # digest: Fortnite.digest.verse.md score_manager_device
    # ═══════════════════════════════════════════════════════
    
    # 获取分数管理器达到最大触发次数事件监听器
    # 当设备达到"可触发次数"定义的最大次数时触发
    # 返回最后触发设备的 agent
    GetScoreMaxTriggersEvent<public>(ScoreDevice:score_manager_device):listenable(agent) =
        # digest: score_manager_device.MaxTriggersEvent:listenable(agent)
        ScoreDevice.MaxTriggersEvent
    
    # 获取分数输出事件监听器
    # 当设备向 agent 授予分数时触发
    # 返回获得分数的 agent
    GetScoreOutputEvent<public>(ScoreDevice:score_manager_device):listenable(agent) =
        # digest: score_manager_device.ScoreOutputEvent:listenable(agent)
        ScoreDevice.ScoreOutputEvent
    
    # 启用分数管理器（带 agent 参数）
    # 如果设备设置了"激活队伍"，会根据 agent 的队伍判定是否允许操作
    EnableScoreManagerWithAgent<public>(ScoreDevice:score_manager_device, TriggerAgent:agent):game_flow_op_result =
        # digest: score_manager_device.Enable(Agent:agent):void
        ScoreDevice.Enable(TriggerAgent)
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 1
        }
    
    # 启用分数管理器（无 agent 参数）
    # 无条件启用分数管理器
    EnableScoreManager<public>(ScoreDevice:score_manager_device):game_flow_op_result =
        # digest: score_manager_device.Enable():void
        ScoreDevice.Enable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 1
        }
    
    # 禁用分数管理器（带 agent 参数）
    # 如果设备设置了"激活队伍"，会根据 agent 的队伍判定是否允许操作
    DisableScoreManagerWithAgent<public>(ScoreDevice:score_manager_device, TriggerAgent:agent):game_flow_op_result =
        # digest: score_manager_device.Disable(Agent:agent):void
        ScoreDevice.Disable(TriggerAgent)
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0
        }
    
    # 禁用分数管理器（无 agent 参数）
    # 无条件禁用分数管理器
    DisableScoreManager<public>(ScoreDevice:score_manager_device):game_flow_op_result =
        # digest: score_manager_device.Disable():void
        ScoreDevice.Disable()
        
        game_flow_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0
        }
    
    # ═══════════════════════════════════════════════════════
    # 玩家信息查询
    # ═══════════════════════════════════════════════════════
    
    # 获取玩家数量
    # 返回游戏空间中当前人类玩家数量
    GetPlayerCount<public>(Playspace:fort_playspace)<transacts>:int =
        Players := Playspace.GetPlayers()
        Players.Length
    
    # 获取参与者数量
    # 返回游戏空间中所有参与者（人类玩家 + AI）数量
    GetParticipantCount<public>(Playspace:fort_playspace)<transacts>:int =
        Participants := Playspace.GetParticipants()
        Participants.Length
    
    # 获取游戏状态信息
    # 返回包含玩家数量、参与者数量等的游戏状态结构
    GetGameStateInfo<public>(Playspace:fort_playspace)<transacts>:game_state_info =
        Players := Playspace.GetPlayers()
        Participants := Playspace.GetParticipants()
        IsActive := Participants.Length > 0
        
        game_state_info{
            PlayerCount := Players.Length,
            ParticipantCount := Participants.Length,
            IsGameActive := IsActive
        }
    
    # 检查游戏空间是否有玩家
    # 如果至少有一个人类玩家，返回 true
    HasPlayers<public>(Playspace:fort_playspace)<transacts>:logic =
        Players := Playspace.GetPlayers()
        Players.Length > 0
    
    # 检查游戏空间是否有参与者
    # 如果至少有一个参与者（人类玩家或AI），返回 true
    HasParticipants<public>(Playspace:fort_playspace)<transacts>:logic =
        Participants := Playspace.GetParticipants()
        Participants.Length > 0
    
    # ═══════════════════════════════════════════════════════
    # 团队管理辅助函数
    # ═══════════════════════════════════════════════════════
    
    # 获取玩家所属队伍
    # 尝试获取 player 对应的 agent 并返回其队伍
    # 如果无法获取，返回 false
    GetPlayerTeam<public>(TeamCollection:fort_team_collection, PlayerAgent:agent)<transacts>:?team =
        # 使用 fort_team_collection 获取 agent 的队伍
        if (AgentTeam := TeamCollection.GetTeam[PlayerAgent]):
            option{AgentTeam}
        else:
            false
    
    # 获取队伍中的所有 agent
    # 返回指定队伍中的所有 agent 列表
    GetTeamAgents<public>(TeamCollection:fort_team_collection, TargetTeam:team)<transacts>:?[]agent =
        # fort_team_collection 提供 GetAgents 方法
        if (Agents := TeamCollection.GetAgents[TargetTeam]):
            option{Agents}
        else:
            false
    
    # 检查两个 agent 是否在同一队伍
    # 如果两个 agent 属于同一队伍，返回 true
    AreAgentsOnSameTeam<public>(TeamCollection:fort_team_collection, Agent1:agent, Agent2:agent)<transacts>:logic =
        if (Team1 := TeamCollection.GetTeam[Agent1]):
            if (Team2 := TeamCollection.GetTeam[Agent2]):
                if (Team1 = Team2):
                    true
                else:
                    false
            else:
                false
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 综合状态查询
    # ═══════════════════════════════════════════════════════
    
    # 检查游戏是否处于活动状态
    # 根据参与者数量判断游戏是否在进行中
    IsGameActive<public>(Playspace:fort_playspace)<transacts>:logic =
        Participants := Playspace.GetParticipants()
        Participants.Length > 0
    
    # 检查是否达到最小玩家数量
    # 用于判断游戏是否可以开始
    HasMinimumPlayers<public>(Playspace:fort_playspace, MinPlayers:int)<transacts>:logic =
        Players := Playspace.GetPlayers()
        Players.Length >= MinPlayers
