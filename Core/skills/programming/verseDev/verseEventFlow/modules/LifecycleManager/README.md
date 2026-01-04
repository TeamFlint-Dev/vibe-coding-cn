# LifecycleManager - 生命周期管理器

> **版本**: 1.0.0  
> **状态**: 🟢 stable  
> **分类**: 核心模块

---

## 概述

LifecycleManager 是一个生命周期管理模块，用于确保组件按正确顺序初始化，解决复杂系统中的依赖问题。

### 核心能力

- ✅ 基于事件的初始化完成通知
- ✅ 支持等待多个组件就绪
- ✅ 提供启动顺序保证
- ✅ 自动追踪组件状态

---

## 快速开始

### 1. 定义组件就绪事件

```verse
component_ready_event := class<concrete>(scene_event):
    var ComponentType:string
    var ReadyTime:float
```

### 2. 子组件发送就绪通知

```verse
health_component := class(creative_device):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)  # ⚠️ 延迟一帧
        
        # 初始化逻辑
        InitializeHealth()
        
        # 通知管理器：我已就绪
        if (Owner := GetOwner()):
            Owner.SendUp(component_ready_event{
                ComponentType := "health",
                ReadyTime := GetSimulationElapsedTime()
            })
    
    InitializeHealth():void =
        Print("Health component initialized")
```

### 3. 管理器等待所有组件

```verse
game_manager := class(creative_device):
    var ReadyComponents:[]string = array{}
    var RequiredComponents:[]string = array{"health", "inventory", "movement"}
    
    OnReceive<override>(Event:scene_event):logic =
        if (ReadyEvent := Event?component_ready_event):
            set ReadyComponents += array{ReadyEvent.ComponentType}
            
            Print("Component ready: {ReadyEvent.ComponentType} ({ReadyComponents.Length}/{RequiredComponents.Length})")
            
            if AllComponentsReady():
                Print("All components ready! Starting game...")
                StartGame()
            
            return true
        return false
    
    AllComponentsReady():logic =
        for (Required in RequiredComponents):
            if not (Required in ReadyComponents):
                return false
        return true
    
    StartGame():void =
        Print("Game started!")
        # 启动游戏逻辑
```

---

## 使用场景

### 场景 1: 等待多个组件就绪

**适用情况**: 系统依赖多个子系统，需要所有子系统初始化完成后再启动

```verse
# 定义就绪事件
component_ready_event := class<concrete>(scene_event):
    var ComponentType:string
    var ReadyTime:float

# 子组件 1: 血量系统
health_component := class(creative_device):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        InitializeHealth()
        NotifyReady("health")
    
    InitializeHealth():void =
        Print("[Health] Initializing...")
        # 初始化血量数据
    
    NotifyReady(ComponentType:string):void =
        if (Owner := GetOwner()):
            Owner.SendUp(component_ready_event{
                ComponentType := ComponentType,
                ReadyTime := GetSimulationElapsedTime()
            })

# 子组件 2: 物品系统
inventory_component := class(creative_device):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        InitializeInventory()
        NotifyReady("inventory")
    
    InitializeInventory():void =
        Print("[Inventory] Initializing...")
        # 初始化物品数据

# 子组件 3: 移动系统
movement_component := class(creative_device):
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        InitializeMovement()
        NotifyReady("movement")
    
    InitializeMovement():void =
        Print("[Movement] Initializing...")
        # 初始化移动数据

# 管理器：等待所有组件
game_manager := class(creative_device):
    var ReadyComponents:[]string = array{}
    var RequiredComponents:[]string = array{
        "health",
        "inventory",
        "movement"
    }
    var GameStarted:logic = false
    
    OnReceive<override>(Event:scene_event):logic =
        if (ReadyEvent := Event?component_ready_event):
            set ReadyComponents += array{ReadyEvent.ComponentType}
            
            Print("[Manager] Component ready: {ReadyEvent.ComponentType} ({ReadyComponents.Length}/{RequiredComponents.Length})")
            
            if (AllComponentsReady[] and not GameStarted):
                set GameStarted = true
                StartGameLogic()
            
            return true
        return false
    
    AllComponentsReady():logic =
        for (Required in RequiredComponents):
            if not (Required in ReadyComponents):
                return false
        return true
    
    StartGameLogic():void =
        Print("[Manager] All components ready! Starting game logic...")
        # 开始游戏逻辑
```

### 场景 2: 阶段性初始化

**适用情况**: 初始化过程分多个阶段，每个阶段依赖上一阶段完成

```verse
# 定义阶段事件
initialization_phase_complete_event := class<concrete>(scene_event):
    var Phase:init_phase
    var CompletionTime:float

# 初始化阶段枚举
init_phase := enum:
    Phase1_Core       # 阶段1: 核心系统
    Phase2_Systems    # 阶段2: 游戏系统
    Phase3_UI         # 阶段3: UI系统
    Phase4_Ready      # 阶段4: 完全就绪

# 阶段管理器
phase_manager := class(creative_device):
    var CurrentPhase:init_phase = init_phase.Phase1_Core
    var PhaseStartTime:float = 0.0
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        Print("[PhaseManager] Starting initialization...")
        StartPhase1()
    
    # 阶段1: 核心系统初始化
    StartPhase1():void =
        Print("[PhaseManager] Phase 1: Core Systems")
        set PhaseStartTime = GetSimulationElapsedTime()
        
        # 初始化核心系统
        # ...
        
        # 通知阶段1完成
        CompletePhase(init_phase.Phase1_Core)
    
    # 阶段2: 游戏系统初始化
    StartPhase2():void =
        Print("[PhaseManager] Phase 2: Game Systems")
        
        # 初始化游戏系统
        # ...
        
        CompletePhase(init_phase.Phase2_Systems)
    
    # 阶段3: UI系统初始化
    StartPhase3():void =
        Print("[PhaseManager] Phase 3: UI Systems")
        
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
    
    # 接收阶段完成事件，推进到下一阶段
    OnReceive<override>(Event:scene_event):logic =
        if (PhaseEvent := Event?initialization_phase_complete_event):
            AdvancePhase(PhaseEvent.Phase)
            return true
        return false
    
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
    
    OnAllPhasesComplete():void =
        Print("[PhaseManager] All initialization phases complete!")
        # 开始游戏
```

### 场景 3: 带超时的初始化

**适用情况**: 需要设置初始化超时，避免无限等待

```verse
# 管理器（带超时）
timeout_manager := class(creative_device):
    var ReadyComponents:[]string = array{}
    var RequiredComponents:[]string = array{"health", "inventory"}
    var InitializationStartTime:float = 0.0
    var InitializationTimeout:float = 10.0  # 10秒超时
    var CheckComplete:logic = false
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        set InitializationStartTime = GetSimulationElapsedTime()
    
    OnSimulate<override>():void =
        if (not CheckComplete):
            CheckInitializationTimeout()
    
    CheckInitializationTimeout():void =
        ElapsedTime := GetSimulationElapsedTime() - InitializationStartTime
        
        if (ElapsedTime > InitializationTimeout):
            Print("[Manager] Initialization timeout! Missing components:")
            
            for (Required in RequiredComponents):
                if not (Required in ReadyComponents):
                    Print("  - {Required}")
            
            set CheckComplete = true
            OnInitializationFailed()
    
    OnReceive<override>(Event:scene_event):logic =
        if (ReadyEvent := Event?component_ready_event):
            set ReadyComponents += array{ReadyEvent.ComponentType}
            
            if (AllComponentsReady[] and not CheckComplete):
                set CheckComplete = true
                OnInitializationSuccess()
            
            return true
        return false
    
    AllComponentsReady():logic =
        for (Required in RequiredComponents):
            if not (Required in ReadyComponents):
                return false
        return true
    
    OnInitializationSuccess():void =
        Print("[Manager] Initialization successful!")
        # 开始游戏
    
    OnInitializationFailed():void =
        Print("[Manager] Initialization failed!")
        # 显示错误信息
```

---

## 最佳实践

### 1. 始终延迟一帧

```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # ⚠️ 必须延迟一帧！
    
    # 初始化逻辑
    Initialize()
```

**原因**: 确保所有组件都已添加到场景，避免初始化顺序问题。

### 2. 使用有意义的组件类型名

```verse
# ✅ 好的命名
component_ready_event{ComponentType := "health_system"}
component_ready_event{ComponentType := "player_inventory"}

# ❌ 不好的命名
component_ready_event{ComponentType := "comp1"}
component_ready_event{ComponentType := "thing"}
```

### 3. 记录初始化进度

```verse
Print("Component ready: {ComponentType} ({ReadyCount}/{TotalCount})")
```

### 4. 处理初始化失败

```verse
# 设置超时
var InitializationTimeout:float = 10.0

# 检查超时
if (ElapsedTime > InitializationTimeout):
    HandleInitializationTimeout()
```

---

## 故障排除

### 问题 1: 组件永远不就绪

**症状**: 管理器一直等待某个组件

**可能原因**:
- 组件未发送就绪事件
- 组件类型名称不匹配
- 组件未延迟一帧

**解决方案**:
```verse
# 1. 检查组件是否发送了就绪事件
NotifyReady("health")  # 确保调用

# 2. 检查类型名称是否一致
# 发送: ComponentType := "health"
# 接收: RequiredComponents := array{"health"}  # 必须完全一致

# 3. 确保延迟一帧
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # 必须！
```

### 问题 2: 初始化顺序不对

**症状**: 组件B依赖组件A，但B先初始化

**解决方案**: 使用阶段性初始化

```verse
# 将组件分组到不同阶段
# Phase1: 核心组件（A）
# Phase2: 依赖组件（B）
```

### 问题 3: 重复的就绪通知

**症状**: 同一组件发送多次就绪事件

**解决方案**: 添加标志防止重复

```verse
var HasNotified:logic = false

NotifyReady():void =
    if (not HasNotified):
        set HasNotified = true
        # 发送就绪事件
```

---

## 性能考虑

- **内存占用**: < 50KB（追踪数据轻量）
- **CPU 占用**: 仅在初始化时运行（不影响游戏帧率）
- **建议**: 初始化完成后停止检查

---

## 依赖项

### Verse 模块

- `Fortnite.Devices` - 必需
- `UnrealEngine` - 必需

### 内部模块

- 无（推荐配合 EventBus 使用）

---

## 相关资源

- [MODULE.yaml](MODULE.yaml) - 模块元数据
- [../../SKILL.md](../../SKILL.md) - verseEventFlow 期刊主页
- [../EventBus/](../EventBus/) - 配合使用推荐

---

## 贡献

发现问题或有改进建议？请提交 Issue 或 Pull Request。

---

*最后更新: 2026-01-04*  
*模块版本: 1.0.0*
