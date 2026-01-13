# 3D几何检测模块
# 功能：3D 包围盒和球体碰撞检测
# 架构：Logic 层 - 纯函数，无状态
# 注意：使用 tuple 避免 vector3 分量访问限制 (RISK-003)

MathGeometry3d<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 数据结构定义
    # ═══════════════════════════════════════════════════════════
    
    # 3D 点结构
    Point3D<public> := tuple(float, float, float)  # (X, Y, Z)
    
    # 3D 包围盒结构 (AABB)
    Box3D<public> := tuple(Point3D, Point3D)  # (MinPoint, MaxPoint)
    
    # 3D 球体结构
    Sphere3D<public> := tuple(Point3D, float)  # (Center, Radius)
    
    # ═══════════════════════════════════════════════════════════
    # 点操作函数
    # ═══════════════════════════════════════════════════════════
    
    # 计算两点之间的距离的平方
    # @param P1: 第一个点
    # @param P2: 第二个点
    # @returns: 距离的平方
    # 
    # 使用场景:
    # - 距离比较（避免开方运算）
    # - 范围检测
    DistanceSquared<public>(P1:Point3D, P2:Point3D)<computes>:float =
        X1 := P1(0)
        Y1 := P1(1)
        Z1 := P1(2)
        X2 := P2(0)
        Y2 := P2(1)
        Z2 := P2(2)
        DX := X2 - X1
        DY := Y2 - Y1
        DZ := Z2 - Z1
        DX * DX + DY * DY + DZ * DZ
    
    # ═══════════════════════════════════════════════════════════
    # 包围盒操作函数
    # ═══════════════════════════════════════════════════════════
    
    # 创建包围盒（从中心点和尺寸）
    # @param CenterX: 中心 X 坐标
    # @param CenterY: 中心 Y 坐标
    # @param CenterZ: 中心 Z 坐标
    # @param Width: 宽度（X 方向）
    # @param Height: 高度（Y 方向）
    # @param Depth: 深度（Z 方向）
    # @returns: Box3D 结构
    CreateBoxFromCenter<public>(CenterX:float, CenterY:float, CenterZ:float, Width:float, Height:float, Depth:float)<computes>:Box3D =
        HalfW := Width * 0.5
        HalfH := Height * 0.5
        HalfD := Depth * 0.5
        MinPoint := (CenterX - HalfW, CenterY - HalfH, CenterZ - HalfD)
        MaxPoint := (CenterX + HalfW, CenterY + HalfH, CenterZ + HalfD)
        (MinPoint, MaxPoint)
    
    # 创建包围盒（从最小点和尺寸）
    # @param MinX: 最小点 X 坐标
    # @param MinY: 最小点 Y 坐标
    # @param MinZ: 最小点 Z 坐标
    # @param Width: 宽度
    # @param Height: 高度
    # @param Depth: 深度
    # @returns: Box3D 结构
    CreateBoxFromMinPoint<public>(MinX:float, MinY:float, MinZ:float, Width:float, Height:float, Depth:float)<computes>:Box3D =
        MaxPoint := (MinX + Width, MinY + Height, MinZ + Depth)
        MinPoint := (MinX, MinY, MinZ)
        (MinPoint, MaxPoint)
    
    # 判断点是否在包围盒内
    # @param Point: 要检测的点
    # @param Box: 包围盒
    # @returns: 如果点在包围盒内返回 true
    # 
    # 使用场景:
    # - 区域检测
    # - 触发器判定
    PointInBox<public>(Point:Point3D, Box:Box3D)<computes>:logic =
        PX := Point(0)
        PY := Point(1)
        PZ := Point(2)
        MinPoint := Box(0)
        MaxPoint := Box(1)
        MinX := MinPoint(0)
        MinY := MinPoint(1)
        MinZ := MinPoint(2)
        MaxX := MaxPoint(0)
        MaxY := MaxPoint(1)
        MaxZ := MaxPoint(2)
        
        if (PX >= MinX):
            if (PX <= MaxX):
                if (PY >= MinY):
                    if (PY <= MaxY):
                        if (PZ >= MinZ):
                            if (PZ <= MaxZ):
                                true
                            else:
                                false
                        else:
                            false
                    else:
                        false
                else:
                    false
            else:
                false
        else:
            false
    
    # 判断两个包围盒是否重叠（AABB 碰撞检测）
    # @param Box1: 第一个包围盒
    # @param Box2: 第二个包围盒
    # @returns: 如果包围盒重叠返回 true
    # 
    # 使用场景:
    # - 3D 物体碰撞检测
    # - 空间查询优化
    BoxesOverlap<public>(Box1:Box3D, Box2:Box3D)<computes>:logic =
        Min1 := Box1(0)
        Max1 := Box1(1)
        Min1X := Min1(0)
        Min1Y := Min1(1)
        Min1Z := Min1(2)
        Max1X := Max1(0)
        Max1Y := Max1(1)
        Max1Z := Max1(2)
        
        Min2 := Box2(0)
        Max2 := Box2(1)
        Min2X := Min2(0)
        Min2Y := Min2(1)
        Min2Z := Min2(2)
        Max2X := Max2(0)
        Max2Y := Max2(1)
        Max2Z := Max2(2)
        
        # AABB 碰撞检测（分离轴测试）
        if (Max1X < Min2X):
            false  # Box1 在 Box2 左侧
        else if (Min1X > Max2X):
            false  # Box1 在 Box2 右侧
        else if (Max1Y < Min2Y):
            false  # Box1 在 Box2 下方
        else if (Min1Y > Max2Y):
            false  # Box1 在 Box2 上方
        else if (Max1Z < Min2Z):
            false  # Box1 在 Box2 前方
        else if (Min1Z > Max2Z):
            false  # Box1 在 Box2 后方
        else:
            true  # 在所有轴上都有重叠
    
    # ═══════════════════════════════════════════════════════════
    # 球体操作函数
    # ═══════════════════════════════════════════════════════════
    
    # 判断点是否在球体内
    # @param Point: 要检测的点
    # @param Sphere: 球体
    # @returns: 如果点在球体内返回 true
    # 
    # 使用场景:
    # - 范围检测（技能范围、爆炸范围）
    # - 球形触发器
    PointInSphere<public>(Point:Point3D, Sphere:Sphere3D)<computes>:logic =
        Center := Sphere(0)
        Radius := Sphere(1)
        DistSq := DistanceSquared(Point, Center)
        RadiusSq := Radius * Radius
        if (DistSq <= RadiusSq) then true else false
    
    # 判断两个球体是否重叠
    # @param Sphere1: 第一个球体
    # @param Sphere2: 第二个球体
    # @returns: 如果球体重叠返回 true
    # 
    # 使用场景:
    # - 球形碰撞检测
    # - 范围重叠判断
    SpheresOverlap<public>(Sphere1:Sphere3D, Sphere2:Sphere3D)<computes>:logic =
        Center1 := Sphere1(0)
        Radius1 := Sphere1(1)
        Center2 := Sphere2(0)
        Radius2 := Sphere2(1)
        DistSq := DistanceSquared(Center1, Center2)
        RadiusSumSq := (Radius1 + Radius2) * (Radius1 + Radius2)
        if (DistSq <= RadiusSumSq) then true else false
    
    # 判断球体是否与包围盒重叠
    # @param Sphere: 球体
    # @param Box: 包围盒
    # @returns: 如果球体与包围盒重叠返回 true
    # 
    # 使用场景:
    # - 混合形状碰撞检测
    # - 空间查询
    # 
    # 算法: 找到包围盒上距离球心最近的点，判断该点是否在球内
    SphereBoxOverlap<public>(Sphere:Sphere3D, Box:Box3D)<computes>:logic =
        Center := Sphere(0)
        Radius := Sphere(1)
        CX := Center(0)
        CY := Center(1)
        CZ := Center(2)
        
        MinPoint := Box(0)
        MaxPoint := Box(1)
        MinX := MinPoint(0)
        MinY := MinPoint(1)
        MinZ := MinPoint(2)
        MaxX := MaxPoint(0)
        MaxY := MaxPoint(1)
        MaxZ := MaxPoint(2)
        
        # 找到包围盒上距离球心最近的点
        ClosestX := Clamp(CX, MinX, MaxX)
        ClosestY := Clamp(CY, MinY, MaxY)
        ClosestZ := Clamp(CZ, MinZ, MaxZ)
        ClosestPoint := (ClosestX, ClosestY, ClosestZ)
        
        # 判断最近点是否在球内
        DistSq := DistanceSquared(Center, ClosestPoint)
        RadiusSq := Radius * Radius
        if (DistSq <= RadiusSq) then true else false
    
    # ═══════════════════════════════════════════════════════════
    # 辅助函数
    # ═══════════════════════════════════════════════════════════
    
    # 扩展包围盒（向六个方向扩展指定距离）
    # @param Box: 原始包围盒
    # @param Margin: 扩展边距
    # @returns: 扩展后的包围盒
    # 
    # 使用场景:
    # - 碰撞检测的安全边距
    # - 范围扩大
    ExpandBox<public>(Box:Box3D, Margin:float)<computes>:Box3D =
        MinPoint := Box(0)
        MaxPoint := Box(1)
        MinX := MinPoint(0)
        MinY := MinPoint(1)
        MinZ := MinPoint(2)
        MaxX := MaxPoint(0)
        MaxY := MaxPoint(1)
        MaxZ := MaxPoint(2)
        
        NewMin := (MinX - Margin, MinY - Margin, MinZ - Margin)
        NewMax := (MaxX + Margin, MaxY + Margin, MaxZ + Margin)
        (NewMin, NewMax)
    
    # 合并两个包围盒（获取包含两个包围盒的最小包围盒）
    # @param Box1: 第一个包围盒
    # @param Box2: 第二个包围盒
    # @returns: 合并后的包围盒
    MergeBoxes<public>(Box1:Box3D, Box2:Box3D)<computes>:Box3D =
        Min1 := Box1(0)
        Max1 := Box1(1)
        Min1X := Min1(0)
        Min1Y := Min1(1)
        Min1Z := Min1(2)
        Max1X := Max1(0)
        Max1Y := Max1(1)
        Max1Z := Max1(2)
        
        Min2 := Box2(0)
        Max2 := Box2(1)
        Min2X := Min2(0)
        Min2Y := Min2(1)
        Min2Z := Min2(2)
        Max2X := Max2(0)
        Max2Y := Max2(1)
        Max2Z := Max2(2)
        
        MergedMinX := Min(Min1X, Min2X)
        MergedMinY := Min(Min1Y, Min2Y)
        MergedMinZ := Min(Min1Z, Min2Z)
        MergedMaxX := Max(Max1X, Max2X)
        MergedMaxY := Max(Max1Y, Max2Y)
        MergedMaxZ := Max(Max1Z, Max2Z)
        
        MergedMin := (MergedMinX, MergedMinY, MergedMinZ)
        MergedMax := (MergedMaxX, MergedMaxY, MergedMaxZ)
        (MergedMin, MergedMax)
