# MovementComponent - 移动控制组件
# 版本: 1.3
# 添加时间: 2025-12-27
# 更新: 添加 final_super，删除冲突函数，重命名 Mod 变量
# 来源: REQ-006 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Verse.org/Verse }  # Sqrt 标准数学函数
using { /UnrealEngine.com/Temporary/SpatialMath }

# 移动状态
movement_state<public> := enum:
    Idle        # 静止
    Walking     # 行走
    Running     # 奔跑
    Jumping     # 跳跃中
    Falling     # 下落中
    Disabled    # 禁用移动

# 移动状态变化事件
movement_state_changed_event<public> := class<concrete>(scene_event):
    OldState<public>:movement_state = movement_state.Idle
    NewState<public>:movement_state = movement_state.Idle

# 移动组件
movement_component<public> := class<final_super>(component):
    # 可编辑属性
    @editable 
    var BaseSpeed<public>:float = 300.0
    @editable 
    var RunSpeedMultiplier<public>:float = 1.5
    @editable 
    var JumpForce<public>:float = 500.0
    @editable 
    var Acceleration<public>:float = 1000.0
    @editable 
    var Deceleration<public>:float = 2000.0
    
    # 运行时状态
    var CurrentState<private>:movement_state = movement_state.Idle
    var CurrentVelocity<private>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    var SpeedModifiers<private>:[]float = array{}
    var CanMove<private>:logic = true
    var IsRunning<private>:logic = false
    
    # ==========================================
    # 移动控制
    # ==========================================
    
    # 朝方向移动
    Move<public>(Direction:vector3):void =
        if (not CanMove?):
            # 不能移动
        else if (CurrentState = movement_state.Disabled):
            # 已禁用
        else:
            # 归一化方向
            NormalizedDir := NormalizeVector(Direction)
            
            # 计算目标速度
            TargetSpeed := GetCurrentSpeed()
            TargetVelocity := vector3{
                X := NormalizedDir.X * TargetSpeed,
                Y := NormalizedDir.Y * TargetSpeed,
                Z := CurrentVelocity.Z  # 保持垂直速度
            }
            
            # 更新速度（带加速度）
            set CurrentVelocity = TargetVelocity
            
            # 更新状态
            if (IsRunning?):
                SetState(movement_state.Running)
            else:
                SetState(movement_state.Walking)
    
    # 停止移动
    Stop<public>():void =
        set CurrentVelocity = vector3{X := 0.0, Y := 0.0, Z := CurrentVelocity.Z}
        if (CurrentState = movement_state.Walking):
            SetState(movement_state.Idle)
        else if (CurrentState = movement_state.Running):
            SetState(movement_state.Idle)
    
    # 跳跃
    Jump<public>():logic =
        if (not CanMove?):
            false
        else if (CurrentState = movement_state.Disabled):
            false
        else if (CurrentState = movement_state.Jumping):
            false  # 空中不能跳
        else if (CurrentState = movement_state.Falling):
            false
        else:
            set CurrentVelocity = vector3{
                X := CurrentVelocity.X,
                Y := CurrentVelocity.Y,
                Z := JumpForce
            }
            SetState(movement_state.Jumping)
            true
    
    # ==========================================
    # 奔跑控制
    # ==========================================
    
    # 开始奔跑
    StartRunning<public>():void =
        set IsRunning = true
        if (CurrentState = movement_state.Walking):
            SetState(movement_state.Running)
    
    # 停止奔跑
    StopRunning<public>():void =
        set IsRunning = false
        if (CurrentState = movement_state.Running):
            SetState(movement_state.Walking)
    
    # 是否正在奔跑
    IsCurrentlyRunning<public>():logic = IsRunning
    
    # ==========================================
    # 速度修饰符
    # ==========================================
    
    # 添加速度修饰符（乘法）
    AddSpeedModifier<public>(Modifier:float):int =
        set SpeedModifiers += array{Modifier}
        SpeedModifiers.Length - 1
    
    # 移除速度修饰符（按索引）
    RemoveSpeedModifier<public>(Index:int):void =
        if (Index >= 0, Index < SpeedModifiers.Length):
            var NewModifiers:[]float = array{}
            for (I -> Modifier : SpeedModifiers):
                if (I <> Index):
                    set NewModifiers += array{Modifier}
            set SpeedModifiers = NewModifiers
    
    # 清除所有速度修饰符
    ClearSpeedModifiers<public>():void =
        set SpeedModifiers = array{}
    
    # 临时速度修饰符（带持续时间）
    AddTemporarySpeedModifier<public>(Modifier:float, Duration:float)<suspends>:void =
        Index := AddSpeedModifier(Modifier)
        Sleep(Duration)
        RemoveSpeedModifier(Index)
    
    # ==========================================
    # 移动禁用
    # ==========================================
    
    # 禁用移动
    DisableMovement<public>():void =
        set CanMove = false
        SetState(movement_state.Disabled)
        Stop()
    
    # 启用移动
    EnableMovement<public>():void =
        set CanMove = true
        SetState(movement_state.Idle)
    
    # 临时禁用
    DisableMovementFor<public>(Duration:float)<suspends>:void =
        DisableMovement()
        Sleep(Duration)
        EnableMovement()
    
    # ==========================================
    # 查询
    # ==========================================
    
    # 获取当前速度（考虑修饰符）
    GetCurrentSpeed<public>():float =
        var Speed:float = BaseSpeed
        if (IsRunning?):
            set Speed *= RunSpeedMultiplier
        
        # 应用所有修饰符
        for (Modifier : SpeedModifiers):
            set Speed *= Modifier
        
        Speed
    
    # 获取当前速度向量
    GetVelocity<public>():vector3 = CurrentVelocity
    
    # 获取当前状态
    GetState<public>():movement_state = CurrentState
    
    # 是否可以移动
    CanCurrentlyMove<public>():logic =
        if (CanMove?, CurrentState <> movement_state.Disabled):
            true
        else:
            false
    
    # 是否在地面
    IsGrounded<public>():logic =
        if (CurrentState <> movement_state.Jumping, CurrentState <> movement_state.Falling):
            true
        else:
            false
    
    # ==========================================
    # 内部方法
    # ==========================================
    
    SetState<private>(NewState:movement_state):void =
        if (CurrentState <> NewState):
            OldState := CurrentState
            set CurrentState = NewState
            
            Self.Entity.SendUp(movement_state_changed_event{
                OldState := OldState,
                NewState := NewState
            })
    
    NormalizeVector<private>(V:vector3):vector3 =
        Len := Sqrt(V.X * V.X + V.Y * V.Y + V.Z * V.Z)
        if (Len > 0.0001):
            vector3{X := V.X / Len, Y := V.Y / Len, Z := V.Z / Len}
        else:
            vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    # 注意: Sqrt 请直接使用 /Verse.org/Verse 标准库
