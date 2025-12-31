# StateMachineComponent - 状态机组件
# 版本: 1.2
# 添加时间: 2025-12-27
# 更新: 修复 Verse 语法错误
# 来源: REQ-012 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 状态改变事件
state_changed_event<public> := class<concrete>(scene_event):
    Owner<public>:?entity = false
    PreviousState<public>:string = ""
    NewState<public>:string = ""
    TimeInPreviousState<public>:float = 0.0

# 状态进入事件
state_enter_event<public> := class<concrete>(scene_event):
    Owner<public>:?entity = false
    State<public>:string = ""
    FromState<public>:string = ""

# 状态退出事件
state_exit_event<public> := class<concrete>(scene_event):
    Owner<public>:?entity = false
    State<public>:string = ""
    ToState<public>:string = ""
    TimeInState<public>:float = 0.0

# 状态更新事件（可选，用于tick）
state_update_event<public> := class<concrete>(scene_event):
    Owner<public>:?entity = false
    State<public>:string = ""
    TimeInState<public>:float = 0.0
    DeltaTime<public>:float = 0.0

# 状态定义
state_definition<public> := struct:
    Name<public>:string
    AllowedTransitions<public>:[]string  # 可转换到的状态列表
    AutoTransitionTo<public>:string      # 自动转换目标（空表示不自动转换）
    AutoTransitionDelay<public>:float    # 自动转换延迟

# 状态机组件
state_machine_component<public> := class<final_super>(component):
    # 可编辑属性
    @editable 
    var InitialState<public>:string = "idle"
    @editable 
    var ValidateTransitions<public>:logic = true  # 是否检查转换合法性
    @editable 
    var EnableStateHistory<public>:logic = true   # 是否记录状态历史
    @editable 
    var MaxHistorySize<public>:int = 10
    
    # 运行时状态
    var CurrentState<private>:string = ""
    var PreviousState<private>:string = ""
    var StateEnterTime<private>:float = 0.0
    var StateDefinitions<private>:[string]state_definition = map{}
    var StateHistory<private>:[]string = array{}
    var IsStateMachineInitialized<private>:logic = false
    var IsLocked<private>:logic = false  # 锁定状态机，防止转换
    
    # ==========================================
    # 初始化
    # ==========================================
    
    # 初始化状态机
    Initialize<public>():void =
        if (IsStateMachineInitialized?):
            # 已初始化，直接返回
        else:
            set CurrentState = InitialState
            set StateEnterTime = GetSimulationElapsedTime()
            set IsStateMachineInitialized = true
            
            # 发送进入初始状态事件
            Owner := Self.Entity
            Owner.SendUp(state_enter_event{
                Owner := option{Owner},
                State := InitialState,
                FromState := ""
            })
    
    # 注册状态定义
    RegisterState<public>(Def:state_definition):void =
        if (set StateDefinitions[Def.Name] = Def) {}
    
    # 注册简单状态（允许转换到任何状态）
    RegisterSimpleState<public>(Name:string):void =
        RegisterState(state_definition{
            Name := Name,
            AllowedTransitions := array{},
            AutoTransitionTo := "",
            AutoTransitionDelay := 0.0
        })
    
    # 批量注册状态
    RegisterStates<public>(Names:[]string):void =
        for (Name : Names):
            RegisterSimpleState(Name)
    
    # ==========================================
    # 状态转换
    # ==========================================
    
    # 转换到新状态
    TransitionTo<public>(NewState:string):logic =
        if (not IsStateMachineInitialized?):
            Initialize()
        
        if (IsLocked?):
            false
        else if (NewState = CurrentState):
            false
        else:
            # 检查转换合法性
            CanTransition := CanTransitionTo(NewState)
            if (ValidateTransitions?, not CanTransition?):
                false
            else:
                # 执行转换
                PerformTransition(NewState)
                true
    
    # 强制转换（绕过验证）
    ForceTransitionTo<public>(NewState:string):void =
        if (not IsStateMachineInitialized?):
            Initialize()
        
        if (NewState <> CurrentState):
            PerformTransition(NewState)
    
    # 执行状态转换
    PerformTransition<private>(NewState:string):void =
        CurrentTime := GetSimulationElapsedTime()
        TimeInState := CurrentTime - StateEnterTime
        OldState := CurrentState
        Owner := Self.Entity
        
        # 发送退出事件
        Owner.SendUp(state_exit_event{
            Owner := option{Owner},
            State := OldState,
            ToState := NewState,
            TimeInState := TimeInState
        })
        
        # 更新状态
        set PreviousState = CurrentState
        set CurrentState = NewState
        set StateEnterTime = CurrentTime
        
        # 记录历史
        if (EnableStateHistory?):
            AddToHistory(OldState)
        
        # 发送进入事件
        Owner.SendUp(state_enter_event{
            Owner := option{Owner},
            State := NewState,
            FromState := OldState
        })
        
        # 发送状态改变事件
        Owner.SendUp(state_changed_event{
            Owner := option{Owner},
            PreviousState := OldState,
            NewState := NewState,
            TimeInPreviousState := TimeInState
        })
    
    # 检查是否可以转换
    CanTransitionTo<public>(TargetState:string):logic =
        if (not ValidateTransitions?):
            true
        else if (Def := StateDefinitions[CurrentState]):
            # 检查状态定义
            # 如果允许转换列表为空，则允许转换到任何状态
            if (Def.AllowedTransitions.Length = 0):
                true
            else:
                # 检查目标状态是否在允许列表中
                var Found:logic = false
                for (Allowed : Def.AllowedTransitions, Allowed = TargetState):
                    set Found = true
                Found
        else:
            # 没有定义则默认允许
            true
    
    # ==========================================
    # 状态更新（应在tick中调用）
    # ==========================================
    
    # 更新状态机
    Update<public>(DeltaTime:float):void =
        if (IsStateMachineInitialized?):
            CurrentTime := GetSimulationElapsedTime()
            TimeInState := CurrentTime - StateEnterTime
            Owner := Self.Entity
            
            # 发送状态更新事件
            Owner.SendUp(state_update_event{
                Owner := option{Owner},
                State := CurrentState,
                TimeInState := TimeInState,
                DeltaTime := DeltaTime
            })
            
            # 检查自动转换
            if (Def := StateDefinitions[CurrentState]):
                if (Def.AutoTransitionTo <> "" and TimeInState >= Def.AutoTransitionDelay):
                    TransitionTo(Def.AutoTransitionTo)
    
    # ==========================================
    # 状态查询
    # ==========================================
    
    # 获取当前状态
    GetCurrentState<public>():string = CurrentState
    
    # 获取上一个状态
    GetPreviousState<public>():string = PreviousState
    
    # 检查是否处于特定状态
    IsInState<public>(StateName:string):logic =
        if (CurrentState = StateName):
            true
        else:
            false
    
    # 检查是否处于多个状态之一
    IsInAnyState<public>(States:[]string):logic =
        var Found:logic = false
        for (S : States, CurrentState = S):
            set Found = true
        Found
    
    # 获取在当前状态停留的时间
    GetTimeInCurrentState<public>():float =
        GetSimulationElapsedTime() - StateEnterTime
    
    # 获取状态历史
    GetStateHistory<public>():[]string = StateHistory
    
    # 检查状态是否存在于历史中
    WasInState<public>(StateName:string):logic =
        var Found:logic = false
        for (S : StateHistory, S = StateName):
            set Found = true
        Found
    
    # ==========================================
    # 历史管理
    # ==========================================
    
    # 添加到历史
    AddToHistory<private>(StateName:string):void =
        set StateHistory += array{StateName}
        
        # 限制历史大小
        if (StateHistory.Length > MaxHistorySize):
            var NewHistory:[]string = array{}
            for (I := 1..StateHistory.Length - 1):
                if (S := StateHistory[I]):
                    set NewHistory += array{S}
            set StateHistory = NewHistory
    
    # 清除历史
    ClearHistory<public>():void =
        set StateHistory = array{}
    
    # 回退到上一个状态
    RevertToPreviousState<public>():logic =
        if (PreviousState = ""):
            false
        else:
            TransitionTo(PreviousState)
    
    # ==========================================
    # 锁定控制
    # ==========================================
    
    # 锁定状态机
    Lock<public>():void =
        set IsLocked = true
    
    # 解锁状态机
    Unlock<public>():void =
        set IsLocked = false
    
    # 检查是否锁定
    IsStateLocked<public>():logic = IsLocked
    
    # 临时锁定
    LockForDuration<public>(Duration:float)<suspends>:void =
        Lock()
        Sleep(Duration)
        Unlock()
    
    # ==========================================
    # 重置
    # ==========================================
    
    # 重置状态机
    Reset<public>():void =
        set CurrentState = InitialState
        set PreviousState = ""
        set StateEnterTime = GetSimulationElapsedTime()
        set StateHistory = array{}
        set IsLocked = false
    
    # 完全重置（包括定义）
    FullReset<public>():void =
        Reset()
        set StateDefinitions = map{}
        set IsStateMachineInitialized = false
