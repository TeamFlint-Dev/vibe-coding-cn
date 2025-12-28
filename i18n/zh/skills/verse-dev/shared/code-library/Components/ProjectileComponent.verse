# ProjectileComponent - 投射物组件
# 版本: 1.0
# 添加时间: 2025-12-27
# 来源: REQ-008 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /UnrealEngine.com/Temporary/SpatialMath }

# 投射物状态
projectile_state<public> := enum:
    Idle
    Flying
    Hit
    Expired

# 投射物发射事件
projectile_launched_event<public> := class<concrete>(scene_event):
    var Projectile<public>:?entity = false
    var Origin<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    var Direction<public>:vector3 = vector3{X := 1.0, Y := 0.0, Z := 0.0}
    var Speed<public>:float = 0.0

# 投射物命中事件
projectile_hit_event<public> := class<concrete>(scene_event):
    var Projectile<public>:?entity = false
    var Target<public>:?entity = false
    var HitPosition<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    var Damage<public>:int = 0

# 投射物过期事件
projectile_expired_event<public> := class<concrete>(scene_event):
    var Projectile<public>:?entity = false
    var FinalPosition<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}

# 投射物组件
projectile_component<public> := class(component):
    # 可编辑属性
    @editable 
    var Speed<public>:float = 500.0
    @editable 
    var Damage<public>:int = 20
    @editable 
    var LifeTime<public>:float = 5.0
    @editable 
    var CollisionRadius<public>:float = 10.0
    @editable 
    var GravityScale<public>:float = 0.0       # 0 = 直线飞行
    @editable 
    var HomingStrength<public>:float = 0.0     # 0 = 无追踪
    @editable 
    var PierceCount<public>:int = 0            # 可穿透次数
    
    # 运行时状态
    var CurrentState<private>:projectile_state = projectile_state.Idle
    var Direction<private>:vector3 = vector3{X := 1.0, Y := 0.0, Z := 0.0}
    var CurrentPosition<private>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    var Velocity<private>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    var LaunchTime<private>:float = 0.0
    var Owner<private>:?entity = false
    var HomingTarget<private>:?entity = false
    var RemainingPierces<private>:int = 0
    var HitEntities<private>:[]entity = array{}
    
    # ==========================================
    # 发射与飞行
    # ==========================================
    
    # 发射投射物
    Launch<public>(Origin:vector3, Dir:vector3, OwnerEntity:?entity):void =
        set CurrentPosition = Origin
        set Direction = Normalize(Dir)
        set Velocity = vector3{
            X := Direction.X * Speed,
            Y := Direction.Y * Speed,
            Z := Direction.Z * Speed
        }
        set CurrentState = projectile_state.Flying
        set LaunchTime = GetSimulationTime()
        set Owner = OwnerEntity
        set RemainingPierces = PierceCount
        set HitEntities = array{}
        
        # 发送发射事件
        if (O := GetOwner()):
            O.SendUp(projectile_launched_event{
                Projectile := option{O},
                Origin := Origin,
                Direction := Direction,
                Speed := Speed
            })
    
    # 发射并追踪目标
    LaunchHoming<public>(Origin:vector3, Target:entity, OwnerEntity:?entity):void =
        TargetPos := GetEntityPosition(Target)
        Dir := vector3{
            X := TargetPos.X - Origin.X,
            Y := TargetPos.Y - Origin.Y,
            Z := TargetPos.Z - Origin.Z
        }
        Launch(Origin, Dir, OwnerEntity)
        set HomingTarget = option{Target}
    
    # 每帧更新（应在tick中调用）
    UpdateFlight<public>(DeltaTime:float):void =
        if CurrentState <> projectile_state.Flying:
            return
        
        # 检查生命周期
        if GetSimulationTime() - LaunchTime > LifeTime:
            Expire()
            return
        
        # 应用追踪
        if HomingStrength > 0.0:
            if (Target := HomingTarget):
                UpdateHomingDirection(Target, DeltaTime)
        
        # 应用重力
        if GravityScale > 0.0:
            set Velocity.Z = Velocity.Z - (980.0 * GravityScale * DeltaTime)
        
        # 更新位置
        set CurrentPosition = vector3{
            X := CurrentPosition.X + Velocity.X * DeltaTime,
            Y := CurrentPosition.Y + Velocity.Y * DeltaTime,
            Z := CurrentPosition.Z + Velocity.Z * DeltaTime
        }
        
        # TODO: 碰撞检测应在外部进行
    
    # 更新追踪方向
    UpdateHomingDirection<private>(Target:entity, DeltaTime:float):void =
        TargetPos := GetEntityPosition(Target)
        ToTarget := vector3{
            X := TargetPos.X - CurrentPosition.X,
            Y := TargetPos.Y - CurrentPosition.Y,
            Z := TargetPos.Z - CurrentPosition.Z
        }
        ToTarget = Normalize(ToTarget)
        
        # 插值方向
        LerpFactor := Min(1.0, HomingStrength * DeltaTime)
        set Direction = vector3{
            X := Direction.X + (ToTarget.X - Direction.X) * LerpFactor,
            Y := Direction.Y + (ToTarget.Y - Direction.Y) * LerpFactor,
            Z := Direction.Z + (ToTarget.Z - Direction.Z) * LerpFactor
        }
        set Direction = Normalize(Direction)
        
        # 更新速度方向
        set Velocity = vector3{
            X := Direction.X * Speed,
            Y := Direction.Y * Speed,
            Z := Direction.Z * Speed
        }
    
    # ==========================================
    # 碰撞处理
    # ==========================================
    
    # 处理命中（由外部碰撞系统调用）
    OnHit<public>(Target:entity, HitPos:vector3):logic =
        if CurrentState <> projectile_state.Flying:
            return false
        
        # 检查是否已命中过
        for (E in HitEntities):
            if E = Target:
                return false
        
        # 记录命中
        set HitEntities += array{Target}
        
        # 发送命中事件
        if (O := GetOwner()):
            O.SendUp(projectile_hit_event{
                Projectile := option{O},
                Target := option{Target},
                HitPosition := HitPos,
                Damage := Damage
            })
        
        # 对目标造成伤害
        if (TargetHealth := Target.GetComponent<health_component>()):
            TargetHealth.TakeDamage(Damage)
        
        # 检查穿透
        if RemainingPierces > 0:
            set RemainingPierces -= 1
            return true  # 继续飞行
        else:
            set CurrentState = projectile_state.Hit
            return false  # 销毁
    
    # 投射物过期
    Expire<private>():void =
        set CurrentState = projectile_state.Expired
        
        if (O := GetOwner()):
            O.SendUp(projectile_expired_event{
                Projectile := option{O},
                FinalPosition := CurrentPosition
            })
    
    # ==========================================
    # 状态查询
    # ==========================================
    
    GetState<public>():projectile_state = CurrentState
    GetPosition<public>():vector3 = CurrentPosition
    GetDirection<public>():vector3 = Direction
    GetVelocity<public>():vector3 = Velocity
    GetRemainingLifeTime<public>():float = Max(0.0, LifeTime - (GetSimulationTime() - LaunchTime))
    IsFlying<public>():logic = CurrentState = projectile_state.Flying
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    Normalize<private>(V:vector3):vector3 =
        Len := Sqrt(V.X * V.X + V.Y * V.Y + V.Z * V.Z)
        if Len > 0.001:
            return vector3{X := V.X / Len, Y := V.Y / Len, Z := V.Z / Len}
        return V
    
    GetEntityPosition<private>(E:entity):vector3 =
        # TODO: 实际实现
        return vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    Min<private>(A:float, B:float):float = if A < B then A else B
    Max<private>(A:float, B:float):float = if A > B then A else B
    Sqrt<private>(X:float):float = Pow(X, 0.5)
    Pow<private>(Base:float, Exp:float):float = external {}
