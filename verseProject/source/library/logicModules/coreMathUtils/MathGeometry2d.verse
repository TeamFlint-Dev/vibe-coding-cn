# 2D几何检测模块
# 功能：矩形、圆形重叠检测（用于 UI 或小地图）
# 架构：Logic 层 - 纯函数，无状态

MathGeometry2d<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 数据结构定义
    # ═══════════════════════════════════════════════════════════
    
    # 2D 点结构
    Point2D<public> := tuple(float, float)  # (X, Y)
    
    # 2D 矩形结构 (AABB)
    Rect2D<public> := tuple(Point2D, Point2D)  # (MinPoint, MaxPoint)
    
    # 2D 圆形结构
    Circle2D<public> := tuple(Point2D, float)  # (Center, Radius)
    
    # ═══════════════════════════════════════════════════════════
    # 点操作函数
    # ═══════════════════════════════════════════════════════════
    
    # 计算两点之间的距离的平方
    # @param P1: 第一个点
    # @param P2: 第二个点
    # @returns: 距离的平方
    DistanceSquared<public>(P1:Point2D, P2:Point2D)<computes>:float =
        X1 := P1(0)
        Y1 := P1(1)
        X2 := P2(0)
        Y2 := P2(1)
        DX := X2 - X1
        DY := Y2 - Y1
        DX * DX + DY * DY
    
    # ═══════════════════════════════════════════════════════════
    # 矩形操作函数
    # ═══════════════════════════════════════════════════════════
    
    # 创建矩形（从中心点和尺寸）
    # @param CenterX: 矩形中心 X 坐标
    # @param CenterY: 矩形中心 Y 坐标
    # @param Width: 矩形宽度
    # @param Height: 矩形高度
    # @returns: Rect2D 结构
    CreateRectFromCenter<public>(CenterX:float, CenterY:float, Width:float, Height:float)<computes>:Rect2D =
        HalfW := Width * 0.5
        HalfH := Height * 0.5
        MinPoint := (CenterX - HalfW, CenterY - HalfH)
        MaxPoint := (CenterX + HalfW, CenterY + HalfH)
        (MinPoint, MaxPoint)
    
    # 创建矩形（从最小点和尺寸）
    # @param MinX: 矩形左下角 X 坐标
    # @param MinY: 矩形左下角 Y 坐标
    # @param Width: 矩形宽度
    # @param Height: 矩形高度
    # @returns: Rect2D 结构
    CreateRectFromMinPoint<public>(MinX:float, MinY:float, Width:float, Height:float)<computes>:Rect2D =
        MaxPoint := (MinX + Width, MinY + Height)
        MinPoint := (MinX, MinY)
        (MinPoint, MaxPoint)
    
    # 判断点是否在矩形内
    # @param Point: 要检测的点
    # @param Rect: 矩形
    # @returns: 如果点在矩形内返回 true
    PointInRect<public>(Point:Point2D, Rect:Rect2D)<computes>:logic =
        PX := Point(0)
        PY := Point(1)
        MinPoint := Rect(0)
        MaxPoint := Rect(1)
        MinX := MinPoint(0)
        MinY := MinPoint(1)
        MaxX := MaxPoint(0)
        MaxY := MaxPoint(1)
        
        if (PX >= MinX):
            if (PX <= MaxX):
                if (PY >= MinY):
                    if (PY <= MaxY):
                        true
                    else:
                        false
                else:
                    false
            else:
                false
        else:
            false
    
    # 判断两个矩形是否重叠（AABB 碰撞检测）
    # @param Rect1: 第一个矩形
    # @param Rect2: 第二个矩形
    # @returns: 如果矩形重叠返回 true
    RectsOverlap<public>(Rect1:Rect2D, Rect2:Rect2D)<computes>:logic =
        Min1 := Rect1(0)
        Max1 := Rect1(1)
        Min1X := Min1(0)
        Min1Y := Min1(1)
        Max1X := Max1(0)
        Max1Y := Max1(1)
        
        Min2 := Rect2(0)
        Max2 := Rect2(1)
        Min2X := Min2(0)
        Min2Y := Min2(1)
        Max2X := Max2(0)
        Max2Y := Max2(1)
        
        # AABB 碰撞检测
        if (Max1X < Min2X):
            false
        else if (Min1X > Max2X):
            false
        else if (Max1Y < Min2Y):
            false
        else if (Min1Y > Max2Y):
            false
        else:
            true
    
    # ═══════════════════════════════════════════════════════════
    # 圆形操作函数
    # ═══════════════════════════════════════════════════════════
    
    # 判断点是否在圆内
    # @param Point: 要检测的点
    # @param Circle: 圆形
    # @returns: 如果点在圆内返回 true
    PointInCircle<public>(Point:Point2D, Circle:Circle2D)<computes>:logic =
        Center := Circle(0)
        Radius := Circle(1)
        DistSq := DistanceSquared(Point, Center)
        RadiusSq := Radius * Radius
        if (DistSq <= RadiusSq) then true else false
    
    # 判断两个圆是否重叠
    # @param Circle1: 第一个圆
    # @param Circle2: 第二个圆
    # @returns: 如果圆重叠返回 true
    CirclesOverlap<public>(Circle1:Circle2D, Circle2:Circle2D)<computes>:logic =
        Center1 := Circle1(0)
        Radius1 := Circle1(1)
        Center2 := Circle2(0)
        Radius2 := Circle2(1)
        DistSq := DistanceSquared(Center1, Center2)
        RadiusSumSq := (Radius1 + Radius2) * (Radius1 + Radius2)
        if (DistSq <= RadiusSumSq) then true else false
    
    # 判断圆是否与矩形重叠
    # @param Circle: 圆形
    # @param Rect: 矩形
    # @returns: 如果圆与矩形重叠返回 true
    CircleRectOverlap<public>(Circle:Circle2D, Rect:Rect2D)<computes>:logic =
        Center := Circle(0)
        Radius := Circle(1)
        CX := Center(0)
        CY := Center(1)
        
        MinPoint := Rect(0)
        MaxPoint := Rect(1)
        MinX := MinPoint(0)
        MinY := MinPoint(1)
        MaxX := MaxPoint(0)
        MaxY := MaxPoint(1)
        
        # 找到矩形上距离圆心最近的点
        ClosestX := Clamp(CX, MinX, MaxX)
        ClosestY := Clamp(CY, MinY, MaxY)
        ClosestPoint := (ClosestX, ClosestY)
        
        # 判断最近点是否在圆内
        DistSq := DistanceSquared(Center, ClosestPoint)
        RadiusSq := Radius * Radius
        if (DistSq <= RadiusSq) then true else false
