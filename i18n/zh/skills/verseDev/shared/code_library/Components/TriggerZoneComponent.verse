# TriggerZoneComponent - 触发区域组件
# 版本: 1.4
# 添加时间: 2025-12-27
# 更新: 修复 Entity 字段类型和 ShouldFilter 调用
# 来源: REQ-010 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Verse.org/Verse }  # Sqrt 标准数学函数
using { /UnrealEngine.com/Temporary/SpatialMath }

# 触发类型
trigger_type<public> := enum:
    OnEnter      # 仅进入时触发
    OnExit       # 仅离开时触发
    OnStay       # 停留时持续触发
    OnEnterExit  # 进入和离开都触发

# 区域形状
zone_shape<public> := enum:
    Box
    Sphere
    Cylinder

# 进入区域事件
zone_enter_event<public> := class<concrete>(scene_event):
    Entity<public>:?entity = false
    ZoneOwner<public>:?entity = false
    EnterPosition<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}

# 离开区域事件
zone_exit_event<public> := class<concrete>(scene_event):
    Entity<public>:?entity = false
    ZoneOwner<public>:?entity = false
    ExitPosition<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    TimeInZone<public>:float = 0.0

# 停留区域事件
zone_stay_event<public> := class<concrete>(scene_event):
    Entity<public>:?entity = false
    ZoneOwner<public>:?entity = false
    TimeInZone<public>:float = 0.0

# 实体区域信息
# 注意: 因为 struct<concrete> 需要默认值，我们使用可选类型
#       但在实际使用时我们总是确保 Entity 有值
entity_zone_info<public> := struct<concrete>:
    Entity<public>:?entity = false
    EnterTime<public>:float = 0.0
    LastPosition<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}

# 触发区域组件
trigger_zone_component<public> := class<final_super>(component):
    # 可编辑属性
    @editable 
    var TriggerType<public>:trigger_type = trigger_type.OnEnterExit
    @editable 
    var Shape<public>:zone_shape = zone_shape.Box
    @editable 
    var Size<public>:vector3 = vector3{X := 100.0, Y := 100.0, Z := 100.0}
    @editable 
    var Radius<public>:float = 50.0  # 用于 Sphere 和 Cylinder
    @editable 
    var Height<public>:float = 100.0 # 用于 Cylinder
    @editable 
    var StayTickInterval<public>:float = 0.5  # OnStay 事件触发间隔
    @editable 
    var IsEnabled<public>:logic = true
    @editable 
    var OneShot<public>:logic = false  # 是否只触发一次
    @editable 
    var FilterTag<public>:string = ""  # 过滤标签（空表示接受所有）
    
    # 运行时状态
    var EntitiesInZone<private>:[]entity_zone_info = array{}
    var HasTriggered<private>:logic = false
    var LastStayTickTime<private>:float = 0.0
    var ZoneCenter<private>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    # ==========================================
    # 区域检测（应每帧调用）
    # ==========================================
    
    # 更新区域检测
    UpdateZone<public>(AllEntities:[]entity, CurrentTime:float):void =
        if (not IsEnabled?):
            # 禁用状态，不执行
        else if (OneShot?, HasTriggered?):
            # 一次性触发且已触发，不执行
        else:
            # 更新区域中心位置
            OwnerEntity := Self.Entity
            set ZoneCenter = GetEntityPosition(OwnerEntity)
            
            # 检测新进入和已离开的实体
            for (E : AllEntities):
                # 跳过被过滤的实体
                ShouldSkip := ShouldFilter(E)
                if (not ShouldSkip?):
                    IsInside := IsEntityInZone(E)
                    WasInside := IsEntityTracked(E)
                    
                    # 检查是否新进入
                    if (IsInside?, not WasInside?):
                        # 新进入
                        OnEntityEnter(E, CurrentTime)
                    
                    # 检查是否已离开 (不能放在同一个 if 的 else if 中因为 no_rollback)
                    if (not IsInside?, WasInside?):
                        # 已离开
                        OnEntityExit(E, CurrentTime)
            
            # 处理停留事件
            if (TriggerType = trigger_type.OnStay):
                if (CurrentTime - LastStayTickTime >= StayTickInterval):
                    set LastStayTickTime = CurrentTime
                    for (Info : EntitiesInZone):
                        OnEntityStay(Info, CurrentTime)
    
    # 检查实体是否在区域内
    IsEntityInZone<public>(E:entity):logic =
        EntityPos := GetEntityPosition(E)
        
        case (Shape):
            zone_shape.Box =>
                IsInBox(EntityPos)
            zone_shape.Sphere =>
                IsInSphere(EntityPos)
            zone_shape.Cylinder =>
                IsInCylinder(EntityPos)
    
    # ==========================================
    # 区域形状检测
    # ==========================================
    
    # 检查是否在盒子内
    IsInBox<private>(Pos:vector3):logic =
        HalfSize := vector3{X := Size.X / 2.0, Y := Size.Y / 2.0, Z := Size.Z / 2.0}
        
        if:
            Pos.X >= ZoneCenter.X - HalfSize.X
            Pos.X <= ZoneCenter.X + HalfSize.X
            Pos.Y >= ZoneCenter.Y - HalfSize.Y
            Pos.Y <= ZoneCenter.Y + HalfSize.Y
            Pos.Z >= ZoneCenter.Z - HalfSize.Z
            Pos.Z <= ZoneCenter.Z + HalfSize.Z
        then:
            true
        else:
            false
    
    # 检查是否在球体内
    IsInSphere<private>(Pos:vector3):logic =
        Dist := VectorDistance(Pos, ZoneCenter)
        if (Dist <= Radius):
            true
        else:
            false
    
    # 检查是否在圆柱体内
    IsInCylinder<private>(Pos:vector3):logic =
        # 水平距离检测
        HorizDistSq := (Pos.X - ZoneCenter.X) * (Pos.X - ZoneCenter.X) +
                       (Pos.Y - ZoneCenter.Y) * (Pos.Y - ZoneCenter.Y)
        HorizDist := Sqrt(HorizDistSq)
        
        # 垂直范围检测
        HalfHeight := Height / 2.0
        
        if:
            HorizDist <= Radius
            Pos.Z >= ZoneCenter.Z - HalfHeight
            Pos.Z <= ZoneCenter.Z + HalfHeight
        then:
            true
        else:
            false
    
    # ==========================================
    # 事件处理
    # ==========================================
    
    # 实体进入
    OnEntityEnter<private>(E:entity, CurrentTime:float):void =
        if (TriggerType <> trigger_type.OnExit):
            OwnerEntity := Self.Entity
            OwnerEntity.SendUp(zone_enter_event{
                Entity := option{E},
                ZoneOwner := option{OwnerEntity},
                EnterPosition := GetEntityPosition(E)
            })
        
        # 添加到追踪列表
        set EntitiesInZone += array{entity_zone_info{
            Entity := option{E},
            EnterTime := CurrentTime,
            LastPosition := GetEntityPosition(E)
        }}
        
        if (OneShot?):
            set HasTriggered = true
    
    # 实体离开
    OnEntityExit<private>(E:entity, CurrentTime:float):void =
        # 查找进入时间
        var FoundEnterTime:float = CurrentTime
        for (Info : EntitiesInZone):
            if (TrackedE := Info.Entity?, TrackedE = E):
                set FoundEnterTime = Info.EnterTime
        
        TimeInZone := CurrentTime - FoundEnterTime
        
        if (TriggerType <> trigger_type.OnEnter):
            OwnerEntity := Self.Entity
            OwnerEntity.SendUp(zone_exit_event{
                Entity := option{E},
                ZoneOwner := option{OwnerEntity},
                ExitPosition := GetEntityPosition(E),
                TimeInZone := TimeInZone
            })
        
        # 从追踪列表移除
        RemoveEntityFromTracking(E)
    
    # 实体停留
    OnEntityStay<private>(Info:entity_zone_info, CurrentTime:float):void =
        TimeInZone := CurrentTime - Info.EnterTime
        
        OwnerEntity := Self.Entity
        OwnerEntity.SendUp(zone_stay_event{
            Entity := Info.Entity,
            ZoneOwner := option{OwnerEntity},
            TimeInZone := TimeInZone
        })
    
    # ==========================================
    # 实体追踪
    # ==========================================
    
    # 检查实体是否被追踪
    IsEntityTracked<private>(E:entity):logic =
        var Found:logic = false
        for (Info : EntitiesInZone):
            if (TrackedE := Info.Entity?, TrackedE = E):
                set Found = true
        Found
    
    # 从追踪中移除
    RemoveEntityFromTracking<private>(E:entity):void =
        var NewList:[]entity_zone_info = array{}
        for (Info : EntitiesInZone):
            # 保留那些不等于 E 的项
            if (TrackedE := Info.Entity?):
                if (TrackedE <> E):
                    set NewList += array{Info}
        set EntitiesInZone = NewList
    
    # 过滤检查
    ShouldFilter<private>(E:entity):logic =
        if (FilterTag = ""):
            false
        else:
            # TODO: 检查实体标签
            false
    
    # ==========================================
    # 查询方法
    # ==========================================
    
    # 获取区域内实体数量
    GetEntityCount<public>():int = EntitiesInZone.Length
    
    # 获取区域内所有实体
    GetEntitiesInZone<public>():[]entity =
        var Result:[]entity = array{}
        for (Info : EntitiesInZone):
            if (E := Info.Entity?):
                set Result += array{E}
        Result
    
    # 检查是否有任何实体在区域内
    HasAnyEntity<public>():logic = 
        if (EntitiesInZone.Length > 0):
            true
        else:
            false
    
    # 检查特定实体是否在区域内
    ContainsEntity<public>(E:entity):logic = IsEntityTracked(E)
    
    # ==========================================
    # 控制方法
    # ==========================================
    
    # 启用区域
    Enable<public>():void =
        set IsEnabled = true
    
    # 禁用区域
    Disable<public>():void =
        set IsEnabled = false
    
    # 重置触发状态
    Reset<public>():void =
        set HasTriggered = false
        set EntitiesInZone = array{}
    
    # 设置区域大小
    SetSize<public>(NewSize:vector3):void =
        set Size = NewSize
    
    # 设置区域半径
    SetRadius<public>(NewRadius:float):void =
        set Radius = NewRadius
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    GetEntityPosition<private>(E:entity):vector3 =
        # TODO: 实际实现 - 需要根据项目具体API获取实体位置
        vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    VectorDistance<private>(A:vector3, B:vector3):float =
        Diff := vector3{X := B.X - A.X, Y := B.Y - A.Y, Z := B.Z - A.Z}
        SqDist := Diff.X * Diff.X + Diff.Y * Diff.Y + Diff.Z * Diff.Z
        Sqrt(SqDist)

    # 注意: Sqrt 请直接使用 /Verse.org/Verse 标准库
