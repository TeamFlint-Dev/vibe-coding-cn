using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary }

# ==========================================
# EventBus - 事件总线概念示例
# ==========================================
# 说明: 这是一个概念性示例，展示如何使用 SceneGraph 的内置事件系统
#       实际使用时，开发者需要根据项目需求定义自己的事件类
# ==========================================

# ==========================================
# 事件定义示例
# ==========================================

# 示例 1: 玩家计分事件
player_scored_event := class<concrete>(scene_event):
    var Player:agent
    var Score:int
    var ScoreTime:float

# 示例 2: 游戏状态变化事件
game_state_changed_event := class<concrete>(scene_event):
    var OldState:game_state
    var NewState:game_state

game_state := enum:
    Waiting
    Playing
    Paused
    GameOver

# 示例 3: 玩家伤害事件
player_damaged_event := class<concrete>(scene_event):
    var Player:agent
    var Damage:int
    var Source:?entity
    var DamageType:damage_type

damage_type := enum:
    Physical
    Fire
    Ice
    Poison

# ==========================================
# 事件发送器示例
# ==========================================

# 示例：分数管理器（事件发送方）
score_manager := class(creative_device):
    
    # 当玩家得分时触发
    OnPlayerScored(Player:agent, Score:int):void =
        if (Owner := GetOwner()):
            # 向上发送事件（子向父报告）
            Owner.SendUp(player_scored_event{
                Player := Player,
                Score := Score,
                ScoreTime := GetSimulationElapsedTime()
            })
            
            Print("Player scored {Score} points")

# ==========================================
# 事件接收器示例
# ==========================================

# 示例 1：UI 管理器（接收计分事件）
ui_manager := class(creative_device):
    
    OnReceive<override>(Event:scene_event):logic =
        # 接收计分事件
        if (ScoreEvent := player_scored_event[Event]):
            UpdateScoreUI(ScoreEvent.Player, ScoreEvent.Score)
            return false  # 不消耗，让其他组件也能收到
        
        # 接收状态变化事件
        if (StateEvent := Event?game_state_changed_event):
            UpdateStateUI(StateEvent.NewState)
            return false
        
        return false
    
    UpdateScoreUI(Player:agent, Score:int):void =
        Print("UI: Player scored {Score}")
        # 更新 UI 显示
    
    UpdateStateUI(NewState:game_state):void =
        Print("UI: Game state changed to {NewState}")
        # 更新游戏状态 UI

# 示例 2：游戏管理器（广播状态变化）
game_manager := class(creative_device):
    var CurrentState:game_state = game_state.Waiting
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 重要：延迟一帧
        
        # 初始化完成后，开始游戏
        ChangeGameState(game_state.Playing)
    
    ChangeGameState(NewState:game_state):void =
        if (Owner := GetOwner()):
            # 向下广播状态变化（父向子广播）
            Owner.SendDown(game_state_changed_event{
                OldState := CurrentState,
                NewState := NewState
            })
            
            set CurrentState = NewState
            Print("Game state changed: {CurrentState} -> {NewState}")
    
    OnReceive<override>(Event:scene_event):logic =
        # 接收计分事件
        if (ScoreEvent := Event?player_scored_event):
            ProcessScore(ScoreEvent)
            return true  # 消耗事件
        
        return false
    
    ProcessScore(ScoreEvent:player_scored_event):void =
        Print("Processing score: {ScoreEvent.Score}")
        # 处理分数逻辑

# ==========================================
# 完整示例：伤害系统
# ==========================================

# 伤害检测器（子组件）
damage_detector := class(creative_device):
    
    OnPlayerHit(Player:agent, Damage:int):void =
        if (Owner := GetOwner()):
            # 向父报告伤害事件
            Owner.SendUp(player_damaged_event{
                Player := Player,
                Damage := Damage,
                Source := option{GetOwner()},
                DamageType := damage_type.Physical
            })

# 伤害处理器（父组件）
damage_processor := class(creative_device):
    
    OnReceive<override>(Event:scene_event):logic =
        if (DamageEvent := Event?player_damaged_event):
            ApplyDamage(DamageEvent)
            return true  # 消耗事件
        
        return false
    
    ApplyDamage(DamageEvent:player_damaged_event):void =
        Print("Player took {DamageEvent.Damage} damage")
        # 应用伤害逻辑
        # 更新血量
        # 触发伤害特效

# ==========================================
# 使用指南
# ==========================================
# 
# 1. 定义事件类
#    - 继承 scene_event
#    - 使用 <concrete> 标记
#    - 定义事件数据字段
#
# 2. 发送事件
#    - SendUp: 子向父报告
#    - SendDown: 父向子广播
#    - SendDirect: 点对点通信
#
# 3. 接收事件
#    - 重写 OnReceive<override>
#    - 使用 ? 操作符进行类型转换
#    - 返回 true 消耗事件，返回 false 继续传播
#
# 4. 生命周期
#    - 在 OnBeginSimulation 中初始化（延迟一帧）
#    - 在 OnSimulate 中检查事件条件
#    - 在 OnEndSimulation 中清理
#
# ==========================================
