using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary }

# ==========================================
# LifecycleManager - 生命周期管理器概念示例
# ==========================================
# 说明: 展示如何使用事件系统管理组件初始化顺序
# ==========================================

# ==========================================
# 事件定义
# ==========================================

# 组件就绪事件
component_ready_event := class<concrete>(scene_event):
    var ComponentType:string
    var ReadyTime:float

# 初始化阶段完成事件
initialization_phase_complete_event := class<concrete>(scene_event):
    var Phase:init_phase
    var CompletionTime:float

# 初始化阶段枚举
init_phase := enum:
    Phase1_Core       # 核心系统
    Phase2_Systems    # 游戏系统
    Phase3_UI         # UI系统
    Phase4_Ready      # 完全就绪

# ==========================================
# 子组件示例（发送就绪通知）
# ==========================================

# 示例 1: 血量组件
health_component := class(creative_device):
    var Initialized:logic = false
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # 重要：延迟一帧
        
        InitializeHealth()
        NotifyReady()
    
    InitializeHealth():void =
        Print("[Health] Initializing...")
        # 初始化血量数据
        set Initialized = true
    
    NotifyReady():void =
        if (Owner := GetOwner()):
            Owner.SendUp(component_ready_event{
                ComponentType := "health",
                ReadyTime := GetSimulationElapsedTime()
            })
            Print("[Health] Ready!")

# 示例 2: 物品组件
inventory_component := class(creative_device):
    var Initialized:logic = false
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        InitializeInventory()
        NotifyReady()
    
    InitializeInventory():void =
        Print("[Inventory] Initializing...")
        # 初始化物品数据
        set Initialized = true
    
    NotifyReady():void =
        if (Owner := GetOwner()):
            Owner.SendUp(component_ready_event{
                ComponentType := "inventory",
                ReadyTime := GetSimulationElapsedTime()
            })
            Print("[Inventory] Ready!")

# 示例 3: 移动组件
movement_component := class(creative_device):
    var Initialized:logic = false
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        InitializeMovement()
        NotifyReady()
    
    InitializeMovement():void =
        Print("[Movement] Initializing...")
        # 初始化移动数据
        set Initialized = true
    
    NotifyReady():void =
        if (Owner := GetOwner()):
            Owner.SendUp(component_ready_event{
                ComponentType := "movement",
                ReadyTime := GetSimulationElapsedTime()
            })
            Print("[Movement] Ready!")

# ==========================================
# 管理器组件（等待所有子组件）
# ==========================================

# 基础生命周期管理器
lifecycle_manager := class(creative_device):
    # 已就绪的组件列表
    var ReadyComponents:[]string = array{}
    
    # 必需的组件列表
    var RequiredComponents:[]string = array{
        "health",
        "inventory",
        "movement"
    }
    
    # 游戏是否已启动
    var GameStarted:logic = false
    
    # 初始化开始时间
    var InitializationStartTime:float = 0.0
    
    # 初始化超时（秒）
    var InitializationTimeout:float = 10.0
    
    # 辅助函数：检查组件是否在列表中
    IsComponentReady(ComponentName:string):logic =
        for (ReadyComp : ReadyComponents):
            if (ReadyComp = ComponentName):
                return true
        false
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        set InitializationStartTime = GetSimulationElapsedTime()
        Print("[Manager] Waiting for components to initialize...")
    
    # 每帧检查超时
    OnSimulate<override>():void =
        if (not GameStarted):
            CheckInitializationTimeout()
    
    # 检查初始化超时
    CheckInitializationTimeout():void =
        ElapsedTime := GetSimulationElapsedTime() - InitializationStartTime
        
        if (ElapsedTime > InitializationTimeout):
            Print("[Manager] ⚠️ Initialization timeout! Missing components:")
            
            for (Required in RequiredComponents):
                if (not IsComponentReady(Required)?):
                    Print("  - {Required}")
            
            set GameStarted = true  # 防止重复检查
            OnInitializationFailed()
    
    # 接收组件就绪事件
    OnReceive<override>(Event:scene_event):logic =
        if (ReadyEvent := Event?component_ready_event):
            set ReadyComponents += array{ReadyEvent.ComponentType}
            
            Print("[Manager] Component ready: {ReadyEvent.ComponentType} ({ReadyComponents.Length}/{RequiredComponents.Length})")
            
            # 检查是否所有组件都就绪
            if (AllComponentsReady[] and not GameStarted):
                set GameStarted = true
                OnAllComponentsReady()
            
            return true
        
        return false
    
    # 检查所有组件是否就绪
    AllComponentsReady():logic =
        for (Required in RequiredComponents):
            if not (Required in ReadyComponents):
                return false
        return true
    
    # 所有组件就绪时调用
    OnAllComponentsReady():void =
        ElapsedTime := GetSimulationElapsedTime() - InitializationStartTime
        Print("[Manager] ✅ All components ready in {ElapsedTime}s! Starting game...")
        
        StartGameLogic()
    
    # 初始化失败时调用
    OnInitializationFailed():void =
        Print("[Manager] ❌ Initialization failed! Cannot start game.")
        # 显示错误信息给玩家
    
    # 启动游戏逻辑
    StartGameLogic():void =
        Print("[Manager] Game logic started!")
        # 实际游戏逻辑

# ==========================================
# 阶段管理器（分阶段初始化）
# ==========================================

phase_manager := class(creative_device):
    var CurrentPhase:init_phase = init_phase.Phase1_Core
    var PhaseStartTime:float = 0.0
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        Print("[PhaseManager] Starting phased initialization...")
        StartPhase1()
    
    # 阶段1: 核心系统
    StartPhase1():void =
        Print("[PhaseManager] Phase 1: Core Systems")
        set PhaseStartTime = GetSimulationElapsedTime()
        
        # 初始化核心系统
        # ...
        
        # 模拟初始化完成
        CompletePhase(init_phase.Phase1_Core)
    
    # 阶段2: 游戏系统
    StartPhase2():void =
        Print("[PhaseManager] Phase 2: Game Systems")
        set PhaseStartTime = GetSimulationElapsedTime()
        
        # 初始化游戏系统
        # ...
        
        CompletePhase(init_phase.Phase2_Systems)
    
    # 阶段3: UI系统
    StartPhase3():void =
        Print("[PhaseManager] Phase 3: UI Systems")
        set PhaseStartTime = GetSimulationElapsedTime()
        
        # 初始化UI
        # ...
        
        CompletePhase(init_phase.Phase3_UI)
    
    # 完成阶段
    CompletePhase(Phase:init_phase):void =
        ElapsedTime := GetSimulationElapsedTime() - PhaseStartTime
        Print("[PhaseManager] Phase {Phase} complete in {ElapsedTime}s")
        
        if (Owner := GetOwner()):
            Owner.SendUp(initialization_phase_complete_event{
                Phase := Phase,
                CompletionTime := ElapsedTime
            })
    
    # 接收阶段完成事件
    OnReceive<override>(Event:scene_event):logic =
        if (PhaseEvent := Event?initialization_phase_complete_event):
            AdvancePhase(PhaseEvent.Phase)
            return true
        return false
    
    # 推进到下一阶段
    AdvancePhase(CompletedPhase:init_phase):void =
        if (CompletedPhase = init_phase.Phase1_Core):
            set CurrentPhase = init_phase.Phase2_Systems
            StartPhase2()
        else if (CompletedPhase = init_phase.Phase2_Systems):
            set CurrentPhase = init_phase.Phase3_UI
            StartPhase3()
        else if (CompletedPhase = init_phase.Phase3_UI):
            set CurrentPhase = init_phase.Phase4_Ready
            OnAllPhasesComplete()
    
    # 所有阶段完成
    OnAllPhasesComplete():void =
        Print("[PhaseManager] ✅ All phases complete! System ready.")
        # 开始游戏

# ==========================================
# 使用指南
# ==========================================
#
# 1. 定义就绪事件
#    component_ready_event := class<concrete>(scene_event):
#        var ComponentType:string
#
# 2. 子组件发送就绪通知
#    OnBeginSimulation<override>()<suspends>:void =
#        Sleep(0.0)
#        Initialize()
#        Owner.SendUp(component_ready_event{ComponentType := "myComponent"})
#
# 3. 管理器等待所有组件
#    var RequiredComponents:[]string = array{"comp1", "comp2"}
#    OnReceive<override>(Event:scene_event):logic =
#        if (ReadyEvent := Event?component_ready_event):
#            set ReadyComponents += array{ReadyEvent.ComponentType}
#            if AllComponentsReady():
#                StartGame()
#
# 4. 可选：设置超时
#    var InitializationTimeout:float = 10.0
#    if (ElapsedTime > InitializationTimeout):
#        HandleTimeout()
#
# ==========================================
