# UnrealEngine.com/Diagnostics 模块完整参考

> **文档类型**：API 模块调研报告  
> **模块路径**：`/UnrealEngine.com/Temporary/Diagnostics`  
> **最后更新**：2026-01-04  
> **API 版本**：++Fortnite+Release-39.11-CL-49242330

---

## 文档说明

本文档深度调研了 UEFN Diagnostics 模块，旨在消除开发者对该模块的错误认知，建立准确的 API 能力参考。

**重要提示**：
- ✅ 该模块位于 `/UnrealEngine.com/Temporary/Diagnostics` 路径下
- ⚠️ 该模块标记为 `Temporary`，意味着 API 可能在未来版本中变化
- ✅ 所有 API 信息来自官方 digest 文件
- 🎯 主要用途：调试可视化和日志输出

---

## 目录

1. [模块概述](#模块概述)
2. [核心类/接口清单](#核心类接口清单)
3. [关键API详解](#关键api详解)
   - [Debug Draw API](#debug-draw-api)
   - [Log API](#log-api)
4. [代码示例](#代码示例)
5. [常见误区澄清](#常见误区澄清)
6. [最佳实践](#最佳实践)
7. [参考资源](#参考资源)

---

## 模块概述

### 模块用途

`/UnrealEngine.com/Temporary/Diagnostics` 模块提供了两大核心功能：

1. **Debug Draw（调试绘制）**：在游戏世界中绘制调试图形（球体、线条、文本等）
2. **Logging（日志记录）**：输出调试信息到日志系统

### 设计理念

该模块遵循以下设计原则：

- **可视化优先**：通过在3D空间直接绘制图形帮助开发者理解空间关系
- **分级日志**：支持多级别日志（Debug、Verbose、Normal、Warning、Error）
- **通道隔离**：使用 channel 机制实现不同调试信息的分类管理
- **临时性质**：作为 Temporary 模块，仅用于开发调试，不应在生产代码中大量使用

### 适用场景

#### Debug Draw 适用场景
- 调试 AI 寻路路径
- 可视化碰撞检测范围
- 显示玩家视野范围
- 标记关键位置点
- 可视化射线检测
- 调试物理模拟

#### Logging 适用场景
- 追踪代码执行流程
- 输出变量值进行调试
- 记录错误和警告
- 性能分析辅助
- 打印调用堆栈

---

## 核心类/接口清单

### 按功能分类

#### 1. Debug Draw 相关类

| 类名 | 类型 | 用途 |
|------|------|------|
| `debug_draw` | 类 | 调试绘制的主类，提供所有绘制方法 |
| `debug_draw_channel` | 抽象类 | 调试绘制通道的基类，用于分类管理 |
| `debug_draw_duration_policy` | 枚举 | 绘制持续时间策略 |

#### 2. Logging 相关类

| 类名 | 类型 | 用途 |
|------|------|------|
| `log` | 类 | 日志记录的主类，提供日志输出方法 |
| `log_channel` | 抽象类 | 日志通道的基类，用于日志分类 |
| `log_level` | 枚举 | 日志级别枚举 |

### 完整类型列表

```verse
# 枚举类型
debug_draw_duration_policy<native><public> := enum
log_level<native><public> := enum

# 抽象基类
debug_draw_channel<native><public> := class<abstract>
log_channel<native><public> := class<abstract>

# 功能类
debug_draw<native><public> := class
log<native><public> := class
```

---

## 关键API详解

### Debug Draw API

#### debug_draw_duration_policy 枚举

定义调试绘制的持续时间策略。

```verse
debug_draw_duration_policy<native><public> := enum:
    SingleFrame      # 单帧显示
    FiniteDuration   # 有限时长显示
    Persistent       # 持久显示（直到手动清除）
```

**枚举值说明**：

| 值 | 说明 | 使用场景 |
|---|------|----------|
| `SingleFrame` | 仅显示一帧 | 需要每帧更新的动态调试信息 |
| `FiniteDuration` | 显示指定时长 | 临时标记，需要配合 `Duration` 参数 |
| `Persistent` | 持久显示 | 需要长期显示的标记，直到手动清除 |

---

#### debug_draw_channel 类

```verse
debug_draw_channel<native><public> := class<abstract>:
```

**用途**：调试绘制通道的抽象基类

**使用方式**：
- 通过继承创建自定义通道
- 用于分类管理不同的调试绘制内容
- 可以按通道显示/隐藏/清除调试图形

**示例**：
```verse
# 定义自定义通道
my_debug_channel := class(debug_draw_channel):

# 使用时指定通道
MyDebugDraw := debug_draw{Channel := my_debug_channel}
```

---

#### debug_draw 类

调试绘制的核心类，提供所有绘制功能。

##### 属性

```verse
# Channel 属性
Channel<native><public>:subtype(debug_draw_channel) = external {}
```

**说明**：指定该 debug_draw 实例使用的通道，用于分类管理。

##### 通道管理方法

```verse
# 显示通道（对所有用户）
ShowChannel<native><public>()<transacts>:void

# 隐藏通道（对所有用户）
HideChannel<native><public>()<transacts>:void

# 清除通道的所有绘制内容
ClearChannel<native><public>()<transacts>:void

# 清除当前实例的所有绘制内容
Clear<native><public>()<transacts>:void
```

**方法说明**：

| 方法 | 功能 | 影响范围 |
|------|------|----------|
| `ShowChannel()` | 显示通道 | 该通道的所有用户 |
| `HideChannel()` | 隐藏通道 | 该通道的所有用户 |
| `ClearChannel()` | 清除通道内容 | 该通道的所有绘制 |
| `Clear()` | 清除实例内容 | 当前 debug_draw 实例 |

##### 绘制方法

所有绘制方法都提供两个重载版本：
- 使用 `Verse.org/SpatialMath` 的 vector3/rotation
- 使用 `UnrealEngine.com/Temporary/SpatialMath` 的 vector3/rotation

**1. DrawSphere - 绘制球体**

```verse
DrawSphere<native><public>(
    Center:vector3,                                    # 球心位置
    ?Radius:float = external {},                       # 半径（可选）
    ?Color:color = external {},                        # 颜色（可选）
    ?NumSegments:int = external {},                    # 分段数（可选）
    ?Thickness:float = external {},                    # 线条粗细（可选）
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},  # 持续策略（可选）
    ?Duration:float = external {}                      # 持续时间（可选）
)<transacts>:void
```

**参数说明**：
- `Center`：球心的世界坐标位置（**必需**）
- `Radius`：球体半径，默认值由引擎决定
- `Color`：球体颜色，使用 `Verse.org/Colors` 的 color 类型
- `NumSegments`：球体的分段数，影响圆滑度
- `Thickness`：线条粗细
- `DrawDurationPolicy`：持续时间策略
- `Duration`：当策略为 `FiniteDuration` 时的持续秒数

---

**2. DrawBox - 绘制盒子**

```verse
DrawBox<native><public>(
    Center:vector3,                                    # 盒子中心
    Rotation:rotation,                                 # 盒子旋转
    ?Extent:vector3 = external {},                     # 盒子范围（可选）
    ?Color:color = external {},                        # 颜色（可选）
    ?Thickness:float = external {},                    # 线条粗细（可选）
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},
    ?Duration:float = external {}
)<transacts>:void
```

**参数说明**：
- `Center`：盒子中心位置（**必需**）
- `Rotation`：盒子的旋转角度（**必需**）
- `Extent`：盒子的半范围（从中心到边的距离）
- 其他参数同 DrawSphere

---

**3. DrawCapsule - 绘制胶囊体**

```verse
DrawCapsule<native><public>(
    Center:vector3,                                    # 胶囊体中心
    Rotation:rotation,                                 # 胶囊体旋转
    ?Height:float = external {},                       # 高度（可选）
    ?Radius:float = external {},                       # 半径（可选）
    ?Color:color = external {},
    ?Thickness:float = external {},
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},
    ?Duration:float = external {}
)<transacts>:void
```

**参数说明**：
- `Center`：胶囊体中心位置（**必需**）
- `Rotation`：胶囊体旋转角度（**必需**）
- `Height`：胶囊体总高度
- `Radius`：胶囊体半径
- 其他参数同上

---

**4. DrawCone - 绘制圆锥**

```verse
DrawCone<native><public>(
    Origin:vector3,                                    # 圆锥顶点
    Direction:vector3,                                 # 圆锥方向
    ?Height:float = external {},                       # 高度（可选）
    ?NumSides:int = external {},                       # 边数（可选）
    ?AngleWidthRadians:float = external {},            # 宽度角（弧度）（可选）
    ?AngleHeightRadians:float = external {},           # 高度角（弧度）（可选）
    ?Color:color = external {},
    ?Thickness:float = external {},
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},
    ?Duration:float = external {}
)<transacts>:void
```

**参数说明**：
- `Origin`：圆锥的顶点位置（**必需**）
- `Direction`：圆锥指向的方向向量（**必需**）
- `Height`：圆锥的高度
- `NumSides`：圆锥底面的边数
- `AngleWidthRadians`：宽度角度（弧度制）
- `AngleHeightRadians`：高度角度（弧度制）
- 其他参数同上

---

**5. DrawCylinder - 绘制圆柱**

```verse
DrawCylinder<native><public>(
    Start:vector3,                                     # 起点
    End:vector3,                                       # 终点
    ?NumSegments:int = external {},                    # 分段数（可选）
    ?Radius:float = external {},                       # 半径（可选）
    ?Color:color = external {},
    ?Thickness:float = external {},
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},
    ?Duration:float = external {}
)<transacts>:void
```

**参数说明**：
- `Start`：圆柱起点位置（**必需**）
- `End`：圆柱终点位置（**必需**）
- `NumSegments`：圆柱的分段数
- `Radius`：圆柱半径
- 其他参数同上

---

**6. DrawLine - 绘制线条**

```verse
DrawLine<native><public>(
    Start:vector3,                                     # 起点
    End:vector3,                                       # 终点
    ?Color:color = external {},
    ?Thickness:float = external {},
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},
    ?Duration:float = external {}
)<transacts>:void
```

**参数说明**：
- `Start`：线条起点（**必需**）
- `End`：线条终点（**必需**）
- 其他参数同上

**使用场景**：绘制简单的连接线、路径、方向指示等。

---

**7. DrawPoint - 绘制点**

```verse
DrawPoint<native><public>(
    Position:vector3,                                  # 点位置
    ?Color:color = external {},
    ?Thickness:float = external {},
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},
    ?Duration:float = external {}
)<transacts>:void
```

**参数说明**：
- `Position`：点的位置（**必需**）
- 其他参数同上

**使用场景**：标记关键位置、碰撞点、生成点等。

---

**8. DrawArrow - 绘制箭头**

```verse
DrawArrow<native><public>(
    Start:vector3,                                     # 起点
    End:vector3,                                       # 终点（箭头指向）
    ?ArrowSize:float = external {},                    # 箭头大小（可选）
    ?Color:color = external {},
    ?Thickness:float = external {},
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},
    ?Duration:float = external {}
)<transacts>:void
```

**参数说明**：
- `Start`：箭头起点（**必需**）
- `End`：箭头终点（箭头指向此处）（**必需**）
- `ArrowSize`：箭头头部的大小
- 其他参数同上

**使用场景**：显示方向、速度向量、力的方向等。

---

**9. DrawText - 绘制3D文本**

```verse
DrawText<native><public>(
    Text:string,                                       # 文本内容
    Position:vector3,                                  # 文本位置
    ?Color:color = external {},
    ?DrawDurationPolicy:debug_draw_duration_policy = external {},
    ?Duration:float = external {},
    ?FontScale:float = external {},                    # 字体缩放（可选）
    ?DrawDropShadow:logic = external {}                # 是否绘制阴影（可选）
)<transacts>:void
```

**参数说明**：
- `Text`：要显示的文本内容（**必需**）
- `Position`：文本在世界空间的位置（**必需**）
- `Color`：文本颜色
- `FontScale`：字体大小缩放比例
- `DrawDropShadow`：是否绘制文本阴影，提高可读性
- 其他参数同上

**使用场景**：显示调试信息、标记对象名称、显示状态值等。

---

### Log API

#### log_level 枚举

定义日志级别。

```verse
log_level<native><public> := enum:
    Debug      # 调试信息
    Verbose    # 详细信息
    Normal     # 正常信息
    Warning    # 警告
    Error      # 错误
```

**日志级别说明**：

| 级别 | 用途 | 显示条件 |
|------|------|----------|
| `Debug` | 调试期间的详细信息 | 开发调试模式 |
| `Verbose` | 详细的运行时信息 | 需要详细日志时 |
| `Normal` | 正常的运行时信息 | 默认级别 |
| `Warning` | 警告信息（可能存在问题） | 始终显示 |
| `Error` | 错误信息（确实存在问题） | 始终显示 |

---

#### log_channel 类

```verse
log_channel<native><public> := class<abstract>:
```

**用途**：日志通道的抽象基类

**使用方式**：
- 通过继承创建自定义日志通道
- 通道类名会作为前缀添加到日志消息中
- 用于分类管理不同模块的日志

**示例**：
```verse
# 定义自定义日志通道
my_log_channel := class(log_channel):

# 使用时指定通道
MyLog := log{Channel := my_log_channel}
# 输出格式：[my_log_channel]: Your message
```

---

#### log 类

日志记录的核心类。

##### 属性

```verse
# 日志通道
Channel<native><public>:subtype(log_channel)

# 默认日志级别
DefaultLevel<native><public>:log_level = external {}
```

**属性说明**：
- `Channel`：指定日志通道，通道名会作为前缀
- `DefaultLevel`：设置默认日志级别，默认为 `log_level.Normal`

##### 方法

**1. Print (string 版本)**

```verse
Print<public>(
    Message:string,                                    # 日志消息
    ?Level:log_level = external {}                     # 日志级别（可选）
)<computes>:void
```

**参数说明**：
- `Message`：要输出的日志消息（**必需**）
- `Level`：日志级别，不指定则使用 `DefaultLevel`

**注意事项**：
- 标记为 `<computes>`，可以在任何上下文调用
- 输出格式：`[Channel类名]: Message`

---

**2. Print (diagnostic 版本)**

```verse
Print<public>(
    Message:diagnostic,                                # 诊断消息
    ?Level:log_level = external {}                     # 日志级别（可选）
)<computes>:void
```

**参数说明**：
- `Message`：诊断类型的消息（**必需**）
- `Level`：日志级别，不指定则使用 `DefaultLevel`

**说明**：
- `diagnostic` 是 Verse 语言的内置诊断类型
- 用于输出更结构化的诊断信息

---

**3. PrintCallStack**

```verse
PrintCallStack<native><public>(
    ?Level:log_level = external {}                     # 日志级别（可选）
)<computes>:void
```

**功能**：打印当前脚本的调用堆栈

**参数说明**：
- `Level`：日志级别，不指定则使用 `DefaultLevel`

**使用场景**：
- 调试复杂的函数调用链
- 追踪代码执行路径
- 定位错误发生的位置

---

## 代码示例

### 示例 1：基础 Debug Draw - 标记玩家位置

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 定义自定义调试通道
player_debug_channel := class(debug_draw_channel):

# 玩家追踪器组件
player_tracker := class(component):
    # 创建 debug_draw 实例
    DebugDraw:debug_draw = debug_draw{Channel := player_debug_channel}
    
    OnBegin<override>()<suspends>:void =
        # 显示调试通道
        DebugDraw.ShowChannel()
        
        # 每秒绘制一次玩家位置
        loop:
            if (Owner := GetOwner[entity]()):
                if (Transform := Owner.GetComponent[transform_component]()):
                    PlayerPos := Transform.GetWorldTranslation()
                    
                    # 在玩家脚下绘制绿色球体（持续1秒）
                    DebugDraw.DrawSphere(
                        PlayerPos,
                        Radius := 50.0,
                        Color := Colors.Green,
                        DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                        Duration := 1.0
                    )
                    
                    # 绘制向上的箭头指示方向
                    DebugDraw.DrawArrow(
                        PlayerPos,
                        PlayerPos + vector3{X := 0.0, Y := 0.0, Z := 200.0},
                        ArrowSize := 30.0,
                        Color := Colors.Yellow,
                        Thickness := 3.0,
                        DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                        Duration := 1.0
                    )
            
            Sleep(1.0)
```

**说明**：
- 使用自定义通道 `player_debug_channel` 隔离调试绘制
- 每秒更新一次，绘制持续1秒（无闪烁）
- 球体标记位置，箭头指示方向

---

### 示例 2：可视化射线检测

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 射线检测调试通道
raycast_debug_channel := class(debug_draw_channel):

# 射线检测可视化器
raycast_visualizer := class:
    DebugDraw:debug_draw = debug_draw{Channel := raycast_debug_channel}
    
    # 可视化射线检测结果
    VisualizeRaycast(Start:vector3, End:vector3, Hit:logic):void =
        if (Hit?):
            # 命中：绘制红色线条和命中点
            DebugDraw.DrawLine(
                Start, End,
                Color := Colors.Red,
                Thickness := 2.0,
                DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                Duration := 2.0
            )
            
            # 在命中点绘制小球体
            DebugDraw.DrawSphere(
                End,
                Radius := 20.0,
                Color := Colors.Red,
                DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                Duration := 2.0
            )
            
            # 显示"HIT"文本
            DebugDraw.DrawText(
                "HIT",
                End + vector3{X := 0.0, Y := 0.0, Z := 50.0},
                Color := Colors.Red,
                FontScale := 2.0,
                DrawDropShadow := true,
                DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                Duration := 2.0
            )
        else:
            # 未命中：绘制绿色线条
            DebugDraw.DrawLine(
                Start, End,
                Color := Colors.Green,
                Thickness := 2.0,
                DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                Duration := 2.0
            )
```

**说明**：
- 根据射线是否命中使用不同颜色
- 在命中点显示球体和文本标记
- 持续显示2秒便于观察

---

### 示例 3：日志系统使用

```verse
using { /UnrealEngine.com/Temporary/Diagnostics }

# 定义游戏逻辑日志通道
game_logic_log_channel := class(log_channel):

# 游戏管理器
game_manager := class:
    # 创建日志实例
    GameLog:log = log{
        Channel := game_logic_log_channel,
        DefaultLevel := log_level.Normal
    }
    
    # 初始化游戏
    InitializeGame():void =
        # 输出正常级别日志
        GameLog.Print("Game initialization started", Level := log_level.Normal)
        
        # 模拟游戏初始化
        if (LoadGameData[]):
            GameLog.Print("Game data loaded successfully", Level := log_level.Verbose)
        else:
            GameLog.Print("Failed to load game data", Level := log_level.Error)
            GameLog.PrintCallStack(Level := log_level.Error)
            return
        
        if (InitializePlayers[]):
            GameLog.Print("Players initialized", Level := log_level.Normal)
        else:
            GameLog.Print("Player initialization failed", Level := log_level.Warning)
        
        GameLog.Print("Game initialization completed", Level := log_level.Normal)
    
    # 模拟函数
    LoadGameData()<decides>:void =
        # 实际逻辑
        true
    
    InitializePlayers()<decides>:void =
        # 实际逻辑
        true
```

**输出示例**：
```
[game_logic_log_channel]: Game initialization started
[game_logic_log_channel]: Game data loaded successfully
[game_logic_log_channel]: Players initialized
[game_logic_log_channel]: Game initialization completed
```

**说明**：
- 使用自定义通道便于过滤日志
- 不同操作使用不同日志级别
- 错误时打印调用堆栈便于调试

---

### 示例 4：AI 寻路可视化

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/Diagnostics }

# AI 调试通道
ai_debug_channel := class(debug_draw_channel):

# AI 寻路可视化器
ai_pathfinding_debugger := class:
    DebugDraw:debug_draw = debug_draw{Channel := ai_debug_channel}
    
    # 可视化路径点
    VisualizePath(PathPoints:[]vector3):void =
        # 清除之前的绘制
        DebugDraw.ClearChannel()
        
        # 绘制路径点
        for (I -> Point : PathPoints):
            # 绘制路径点球体
            DebugDraw.DrawSphere(
                Point,
                Radius := 30.0,
                Color := Colors.Blue,
                DrawDurationPolicy := debug_draw_duration_policy.Persistent
            )
            
            # 绘制点的序号
            DebugDraw.DrawText(
                "{I}",
                Point + vector3{X := 0.0, Y := 0.0, Z := 80.0},
                Color := Colors.White,
                FontScale := 1.5,
                DrawDropShadow := true,
                DrawDurationPolicy := debug_draw_duration_policy.Persistent
            )
            
            # 绘制连接线（除了最后一个点）
            if (I < PathPoints.Length - 1):
                if (NextPoint := PathPoints[I + 1]):
                    DebugDraw.DrawArrow(
                        Point,
                        NextPoint,
                        ArrowSize := 25.0,
                        Color := Colors.Cyan,
                        Thickness := 3.0,
                        DrawDurationPolicy := debug_draw_duration_policy.Persistent
                    )
    
    # 可视化 AI 视野范围
    VisualizeVisionCone(Position:vector3, Direction:vector3, Rotation:rotation):void =
        # 绘制视野锥形
        DebugDraw.DrawCone(
            Position,
            Direction,
            Height := 500.0,
            NumSides := 16,
            AngleWidthRadians := 0.785,  # 45度（π/4）
            AngleHeightRadians := 0.785,
            Color := Colors.Yellow,
            Thickness := 2.0,
            DrawDurationPolicy := debug_draw_duration_policy.SingleFrame
        )
```

**说明**：
- 使用 `Persistent` 策略保持路径显示
- 使用 `SingleFrame` 策略动态更新视野
- 结合多种绘制方法（球体、箭头、文本、锥形）
- 使用 `ClearChannel()` 在更新前清除旧内容

---

### 示例 5：碰撞检测可视化

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 物理调试通道
physics_debug_channel := class(debug_draw_channel):

# 碰撞检测可视化器
collision_debugger := class:
    DebugDraw:debug_draw = debug_draw{Channel := physics_debug_channel}
    PhysicsLog:log = log{Channel := physics_log_channel}
    
    # 可视化胶囊体碰撞器
    VisualizeCapsuleCollider(Center:vector3, Rotation:rotation, Height:float, Radius:float):void =
        DebugDraw.DrawCapsule(
            Center,
            Rotation,
            Height := Height,
            Radius := Radius,
            Color := Colors.Green,
            Thickness := 2.0,
            DrawDurationPolicy := debug_draw_duration_policy.SingleFrame
        )
    
    # 可视化盒子碰撞器
    VisualizeBoxCollider(Center:vector3, Rotation:rotation, Extent:vector3, IsColliding:logic):void =
        # 根据是否碰撞选择颜色
        BoxColor := if (IsColliding?) Colors.Red else Colors.Green
        
        DebugDraw.DrawBox(
            Center,
            Rotation,
            Extent := Extent,
            Color := BoxColor,
            Thickness := 2.0,
            DrawDurationPolicy := debug_draw_duration_policy.SingleFrame
        )
        
        # 如果发生碰撞，输出日志
        if (IsColliding?):
            PhysicsLog.Print(
                "Collision detected at {Center}",
                Level := log_level.Warning
            )
    
    # 可视化圆柱体区域
    VisualizeCylinderZone(Start:vector3, End:vector3, Radius:float):void =
        DebugDraw.DrawCylinder(
            Start,
            End,
            Radius := Radius,
            NumSegments := 16,
            Color := Colors.Cyan,
            Thickness := 2.0,
            DrawDurationPolicy := debug_draw_duration_policy.Persistent
        )

# 物理日志通道
physics_log_channel := class(log_channel):
```

**说明**：
- 根据碰撞状态动态改变颜色
- 结合日志输出和可视化
- 使用不同的持续策略（SingleFrame 用于动态更新，Persistent 用于区域标记）

---

## 常见误区澄清

### 误区 1：Diagnostics 模块可以用于生产环境

**错误认知**：
> "可以使用 Diagnostics 模块在正式游戏中显示信息给玩家。"

**正确理解**：
- ❌ Diagnostics 模块位于 `Temporary` 命名空间，是**临时/过渡性质**的 API
- ❌ 该模块**仅用于开发调试**，不应在生产代码中大量使用
- ✅ 生产环境应使用 `Fortnite.com/UI` 模块构建正式的UI界面
- ✅ Debug Draw 可能在发布版本中被禁用或移除

**建议**：
- 仅在开发和测试阶段使用 Diagnostics
- 正式功能使用 UI 模块或其他稳定 API

---

### 误区 2：DrawText 可以显示复杂的 UI

**错误认知**：
> "可以用 DrawText 构建游戏的 HUD 界面。"

**正确理解**：
- ❌ DrawText 是 3D 空间文本，不是 UI 文本
- ❌ 没有布局、对齐、交互等 UI 功能
- ❌ 性能不适合大量文本显示
- ✅ DrawText 仅用于调试时标记 3D 对象
- ✅ 正式 UI 应使用 `Fortnite.com/UI` 模块

**对比**：

| 特性 | DrawText (Diagnostics) | UI 模块 |
|------|------------------------|---------|
| 用途 | 调试标记 | 正式UI界面 |
| 位置 | 3D世界空间 | 2D屏幕空间 |
| 功能 | 基础文本显示 | 布局、交互、动画 |
| 性能 | 调试级别 | 生产级别 |
| 稳定性 | Temporary | Stable |

---

### 误区 3：日志会自动分类和过滤

**错误认知**：
> "设置了 log_level 就能自动过滤不同级别的日志。"

**正确理解**：
- ❌ log_level 主要影响日志的**显示优先级**，不是自动过滤
- ❌ 所有日志都会被输出，级别只影响显示方式
- ✅ 需要在引擎/编辑器中配置日志过滤规则
- ✅ 使用不同的 log_channel 进行分类管理

**最佳实践**：
```verse
# 为不同模块创建不同的日志通道
gameplay_log_channel := class(log_channel):
ai_log_channel := class(log_channel):
network_log_channel := class(log_channel):

# 这样可以在编辑器中单独控制每个通道的显示
```

---

### 误区 4：Debug Draw 的性能影响可以忽略

**错误认知**：
> "Debug Draw 很轻量，可以随意绘制大量图形。"

**正确理解**：
- ❌ Debug Draw 也有性能开销，特别是复杂图形（高分段数的球体、圆柱等）
- ❌ 大量持久绘制会累积内存占用
- ✅ 应当适度使用，及时清理不需要的绘制
- ✅ 使用 `SingleFrame` 策略自动清理，避免累积

**性能建议**：
```verse
# 好的做法：单帧更新，自动清理
DebugDraw.DrawSphere(
    Position,
    DrawDurationPolicy := debug_draw_duration_policy.SingleFrame  # 自动清理
)

# 需要注意：持久绘制需要手动管理
DebugDraw.DrawSphere(
    Position,
    DrawDurationPolicy := debug_draw_duration_policy.Persistent  # 需要手动清理
)
# 使用后记得：
DebugDraw.ClearChannel()  # 清理持久绘制
```

---

### 误区 5：所有 Draw 方法都需要所有参数

**错误认知**：
> "必须为每个 Draw 方法提供所有参数。"

**正确理解**：
- ❌ 大部分参数都是**可选的**（标记为 `?` 前缀）
- ✅ 只有少数核心参数是必需的（如位置、方向）
- ✅ 可选参数会使用引擎默认值
- ✅ 建议只指定需要自定义的参数

**示例对比**：
```verse
# 繁琐的写法（不推荐）
DebugDraw.DrawSphere(
    Center := Position,
    Radius := 50.0,
    Color := Colors.Green,
    NumSegments := 16,
    Thickness := 1.0,
    DrawDurationPolicy := debug_draw_duration_policy.SingleFrame,
    Duration := 0.0
)

# 简洁的写法（推荐）
DebugDraw.DrawSphere(Position)  # 使用所有默认值

# 按需自定义（推荐）
DebugDraw.DrawSphere(
    Position,
    Radius := 50.0,
    Color := Colors.Green
)
```

---

### 误区 6：通道管理方法只影响当前实例

**错误认知**：
> "ShowChannel() 和 HideChannel() 只影响当前 debug_draw 实例。"

**正确理解**：
- ❌ 通道管理方法影响**所有用户**
- ✅ `ShowChannel()` / `HideChannel()` 是全局操作
- ✅ 使用同一通道的所有 debug_draw 实例都会受影响
- ✅ `Clear()` 只清理当前实例，`ClearChannel()` 清理整个通道

**示例**：
```verse
my_channel := class(debug_draw_channel):

# 实例 A
DebugDrawA := debug_draw{Channel := my_channel}
DebugDrawA.DrawSphere(PositionA)

# 实例 B（使用同一通道）
DebugDrawB := debug_draw{Channel := my_channel}
DebugDrawB.DrawSphere(PositionB)

# 隐藏通道 - 两个实例的绘制都会被隐藏
DebugDrawA.HideChannel()  # 影响 A 和 B

# 清除实例 - 只清除 A 的绘制
DebugDrawA.Clear()  # 只影响 A

# 清除通道 - 清除 A 和 B 的绘制
DebugDrawA.ClearChannel()  # 影响 A 和 B
```

---

## 最佳实践

### 1. 通道管理最佳实践

#### 使用语义化的通道名称

```verse
# 好的做法：语义化命名
player_movement_debug := class(debug_draw_channel):
ai_pathfinding_debug := class(debug_draw_channel):
physics_collision_debug := class(debug_draw_channel):
network_sync_debug := class(debug_draw_channel):

# 避免：泛化命名
debug_channel_1 := class(debug_draw_channel):
debug_channel_2 := class(debug_draw_channel):
```

#### 按功能模块分离通道

```verse
# 为每个主要功能创建独立通道
combat_system := class:
    CombatDebug:debug_draw = debug_draw{Channel := combat_debug_channel}

inventory_system := class:
    InventoryDebug:debug_draw = debug_draw{Channel := inventory_debug_channel}

# 这样可以独立控制每个系统的调试显示
```

#### 提供通道开关控制

```verse
debug_manager := class:
    # 各系统的 debug_draw 实例
    PlayerDebug:debug_draw = debug_draw{Channel := player_debug_channel}
    AIDebug:debug_draw = debug_draw{Channel := ai_debug_channel}
    PhysicsDebug:debug_draw = debug_draw{Channel := physics_debug_channel}
    
    # 统一的调试开关
    EnablePlayerDebug():void = PlayerDebug.ShowChannel()
    DisablePlayerDebug():void = PlayerDebug.HideChannel()
    
    EnableAIDebug():void = AIDebug.ShowChannel()
    DisableAIDebug():void = AIDebug.HideChannel()
    
    # 全局开关
    EnableAllDebug():void =
        PlayerDebug.ShowChannel()
        AIDebug.ShowChannel()
        PhysicsDebug.ShowChannel()
    
    DisableAllDebug():void =
        PlayerDebug.HideChannel()
        AIDebug.HideChannel()
        PhysicsDebug.HideChannel()
```

---

### 2. 绘制持续时间策略选择

#### SingleFrame - 动态更新的内容

```verse
# 适用场景：需要每帧更新的信息
OnTick():void =
    # 玩家当前速度（每帧变化）
    DebugDraw.DrawText(
        "Speed: {CurrentSpeed}",
        PlayerPosition,
        DrawDurationPolicy := debug_draw_duration_policy.SingleFrame
    )
    
    # 实时碰撞检测框
    DebugDraw.DrawBox(
        ColliderCenter,
        ColliderRotation,
        Extent := ColliderExtent,
        DrawDurationPolicy := debug_draw_duration_policy.SingleFrame
    )
```

#### FiniteDuration - 临时标记

```verse
# 适用场景：需要短暂显示的标记
OnPlayerHit(HitLocation:vector3):void =
    # 显示命中点3秒
    DebugDraw.DrawSphere(
        HitLocation,
        Color := Colors.Red,
        DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
        Duration := 3.0
    )
    
    DebugDraw.DrawText(
        "HIT!",
        HitLocation,
        DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
        Duration := 3.0
    )
```

#### Persistent - 长期参考

```verse
# 适用场景：需要持续显示的参考标记
InitializeLevel():void =
    # 标记关键位置点
    for (SpawnPoint : SpawnPoints):
        DebugDraw.DrawSphere(
            SpawnPoint.Position,
            Color := Colors.Blue,
            DrawDurationPolicy := debug_draw_duration_policy.Persistent
        )
        
        DebugDraw.DrawText(
            SpawnPoint.Name,
            SpawnPoint.Position,
            DrawDurationPolicy := debug_draw_duration_policy.Persistent
        )
    
    # 记得在适当时机清理
    CleanupDebugDraw():void =
        DebugDraw.ClearChannel()
```

---

### 3. 日志使用最佳实践

#### 为不同模块创建日志通道

```verse
# 每个主要模块有自己的日志通道
gameplay_log := class(log_channel):
network_log := class(log_channel):
ui_log := class(log_channel):
audio_log := class(log_channel):

# 使用示例
game_manager := class:
    GameLog:log = log{
        Channel := gameplay_log,
        DefaultLevel := log_level.Normal
    }
```

#### 合理使用日志级别

```verse
game_system := class:
    SystemLog:log = log{Channel := system_log_channel}
    
    ProcessData(Data:[]int):void =
        # Debug: 详细的调试信息（开发时有用）
        SystemLog.Print(
            "Processing {Data.Length} items",
            Level := log_level.Debug
        )
        
        # Verbose: 详细的运行时信息
        for (I -> Item : Data):
            SystemLog.Print(
                "Item {I}: {Item}",
                Level := log_level.Verbose
            )
        
        # Normal: 正常的运行时信息
        SystemLog.Print(
            "Data processing started",
            Level := log_level.Normal
        )
        
        # Warning: 可能的问题
        if (Data.Length > 1000):
            SystemLog.Print(
                "Large data set detected ({Data.Length} items), may impact performance",
                Level := log_level.Warning
            )
        
        # Error: 确实的错误
        if (Data.Length = 0):
            SystemLog.Print(
                "No data to process",
                Level := log_level.Error
            )
            SystemLog.PrintCallStack(Level := log_level.Error)
            return
```

#### 结构化日志信息

```verse
# 好的做法：结构化、易读的日志
player_manager := class:
    PlayerLog:log = log{Channel := player_log_channel}
    
    OnPlayerJoin(PlayerID:int, PlayerName:string):void =
        PlayerLog.Print(
            "Player joined - ID: {PlayerID}, Name: {PlayerName}",
            Level := log_level.Normal
        )
    
    OnPlayerLeave(PlayerID:int, Reason:string):void =
        PlayerLog.Print(
            "Player left - ID: {PlayerID}, Reason: {Reason}",
            Level := log_level.Normal
        )

# 避免：不清晰的日志
OnEvent():void =
    Log.Print("Event happened")  # 缺少上下文信息
```

---

### 4. 性能优化建议

#### 条件化调试绘制

```verse
# 使用配置控制调试开关
debug_config := class:
    var EnableDebugDraw:logic = false
    var EnableDebugLog:logic = false

game_system := class:
    Config:debug_config = debug_config{}
    DebugDraw:debug_draw = debug_draw{Channel := system_debug_channel}
    
    Update():void =
        # 只在启用时绘制
        if (Config.EnableDebugDraw?):
            DebugDraw.DrawSphere(CurrentPosition)
        
        # 只在启用时记录详细日志
        if (Config.EnableDebugLog?):
            SystemLog.Print(
                "Position: {CurrentPosition}",
                Level := log_level.Debug
            )
```

#### 控制绘制复杂度

```verse
# 避免：过高的分段数
DebugDraw.DrawSphere(
    Position,
    NumSegments := 64  # 太高，影响性能
)

# 推荐：适中的分段数
DebugDraw.DrawSphere(
    Position,
    NumSegments := 16  # 足够清晰，性能较好
)

# 或使用默认值
DebugDraw.DrawSphere(Position)  # 引擎会选择合适的默认值
```

#### 及时清理

```verse
# 定期清理不需要的调试绘制
debug_manager := class:
    DebugDraw:debug_draw = debug_draw{Channel := manager_debug_channel}
    var DrawCount:int = 0
    
    DrawDebugInfo():void =
        DebugDraw.DrawSphere(SomePosition)
        set DrawCount = DrawCount + 1
        
        # 每100次绘制后清理一次
        if (DrawCount mod 100 = 0):
            DebugDraw.ClearChannel()
```

---

### 5. 与其他模块的配合使用

#### 与 SceneGraph 配合

```verse
using { /Verse.org/SceneGraph }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 可视化 Entity 层级结构
entity_debugger := class(component):
    DebugDraw:debug_draw = debug_draw{Channel := entity_debug_channel}
    
    OnBegin<override>()<suspends>:void =
        if (Owner := GetOwner[entity]()):
            VisualizeEntityHierarchy(Owner, 0)
    
    VisualizeEntityHierarchy(Entity:entity, Depth:int):void =
        # 获取 transform
        if (Transform := Entity.GetComponent[transform_component]()):
            Position := Transform.GetWorldTranslation()
            
            # 绘制当前 entity
            DebugDraw.DrawSphere(
                Position,
                Radius := 30.0,
                Color := GetColorByDepth(Depth),
                DrawDurationPolicy := debug_draw_duration_policy.Persistent
            )
            
            DebugDraw.DrawText(
                "Depth: {Depth}",
                Position,
                DrawDurationPolicy := debug_draw_duration_policy.Persistent
            )
            
            # 递归绘制子 entities
            Children := Entity.GetEntities()
            for (Child : Children):
                if (ChildTransform := Child.GetComponent[transform_component]()):
                    ChildPosition := ChildTransform.GetWorldTranslation()
                    
                    # 绘制连线
                    DebugDraw.DrawLine(
                        Position,
                        ChildPosition,
                        Color := Colors.White,
                        DrawDurationPolicy := debug_draw_duration_policy.Persistent
                    )
                
                # 递归
                VisualizeEntityHierarchy(Child, Depth + 1)
    
    GetColorByDepth(Depth:int):color =
        if (Depth = 0) then Colors.Red
        else if (Depth = 1) then Colors.Green
        else if (Depth = 2) then Colors.Blue
        else Colors.Yellow
```

#### 与 SpatialMath 配合

```verse
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 可视化向量运算
vector_debugger := class:
    DebugDraw:debug_draw = debug_draw{Channel := vector_debug_channel}
    
    # 可视化向量加法
    VisualizeVectorAddition(Origin:vector3, VecA:vector3, VecB:vector3):void =
        # 绘制原点
        DebugDraw.DrawPoint(Origin, Color := Colors.White)
        
        # 绘制向量 A（红色）
        EndA := Origin + VecA
        DebugDraw.DrawArrow(
            Origin, EndA,
            Color := Colors.Red,
            Thickness := 2.0
        )
        DebugDraw.DrawText("A", EndA, Color := Colors.Red)
        
        # 绘制向量 B（绿色）
        EndB := Origin + VecB
        DebugDraw.DrawArrow(
            Origin, EndB,
            Color := Colors.Green,
            Thickness := 2.0
        )
        DebugDraw.DrawText("B", EndB, Color := Colors.Green)
        
        # 绘制结果向量 A+B（蓝色）
        ResultVec := VecA + VecB
        EndResult := Origin + ResultVec
        DebugDraw.DrawArrow(
            Origin, EndResult,
            Color := Colors.Blue,
            Thickness := 3.0
        )
        DebugDraw.DrawText("A+B", EndResult, Color := Colors.Blue)
```

#### 与 Simulation 配合

```verse
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 可视化模拟时间和事件
simulation_debugger := class(component):
    SimLog:log = log{Channel := simulation_log_channel}
    
    OnBegin<override>()<suspends>:void =
        SimLog.Print(
            "Component started at simulation time",
            Level := log_level.Normal
        )
        
        # 每秒记录一次
        loop:
            SimLog.Print(
                "Simulation tick",
                Level := log_level.Debug
            )
            Sleep(1.0)
```

---

### 6. 调试工作流建议

#### 开发阶段工作流

```verse
# 1. 开发初期：启用所有调试
development_config := class:
    var EnableAllDebug:logic = true
    
    InitDebug():void =
        if (EnableAllDebug?):
            # 显示所有调试通道
            PlayerDebug.ShowChannel()
            AIDebug.ShowChannel()
            PhysicsDebug.ShowChannel()
            
            # 设置详细日志级别
            set GameLog.DefaultLevel = log_level.Verbose

# 2. 测试阶段：选择性启用
testing_config := class:
    var EnablePlayerDebug:logic = true
    var EnableAIDebug:logic = false
    var EnablePhysicsDebug:logic = true

# 3. 发布前：禁用所有调试
release_config := class:
    DisableAllDebug():void =
        PlayerDebug.HideChannel()
        AIDebug.HideChannel()
        PhysicsDebug.HideChannel()
        
        # 只保留 Warning 和 Error
        set GameLog.DefaultLevel = log_level.Warning
```

#### 性能分析工作流

```verse
performance_debugger := class:
    PerfLog:log = log{Channel := perf_log_channel}
    DebugDraw:debug_draw = debug_draw{Channel := perf_debug_channel}
    
    # 分析函数性能
    AnalyzePerformance<public>(FunctionName:string, StartTime:float, EndTime:float):void =
        Duration := EndTime - StartTime
        
        # 记录性能数据
        PerfLog.Print(
            "{FunctionName} took {Duration}ms",
            Level := log_level.Verbose
        )
        
        # 如果超过阈值，发出警告
        if (Duration > 16.0):  # 超过一帧（60fps）
            PerfLog.Print(
                "Performance warning: {FunctionName} exceeded frame time ({Duration}ms)",
                Level := log_level.Warning
            )
```

---

## 参考资源

### 官方文档

- [UEFN Verse API 文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference)

### 相关 API 模块

本模块依赖以下模块：

- `/UnrealEngine.com/Temporary/SpatialMath` - 空间数学（vector3, rotation）
- `/Verse.org/Colors` - 颜色定义
- `/Verse.org/SpatialMath` - Verse 标准空间数学

配合使用的模块：

- `/Verse.org/SceneGraph` - 场景图系统（获取 entity 位置）
- `/Verse.org/Simulation` - 模拟系统（时间相关）
- `/Fortnite.com/Characters` - 角色系统（调试角色相关）

### 内部文档索引

- [API 模块清单](../api-modules-list.md) - 所有 API 模块索引
- [API 模块能力调研](../api-modules-research.md) - 模块能力详细分析
- [SceneGraph API 参考](../scenegraph-api-reference.md) - SceneGraph 详细文档
- [Verse 失败机制](../verse-failure-mechanisms.md) - Verse `<decides>` 和错误处理

### Digest 源文件

本文档基于以下 digest 文件：

- `skills/programming/verseDev/shared/api-digests/UnrealEngine.digest.verse.md` (行 786-898)

---

## 版本历史

| 日期 | 版本 | 变更说明 |
|------|------|----------|
| 2026-01-04 | 1.0 | 初始版本，完整调研 Diagnostics 模块 |

---

**文档维护者**：UEFN Verse Development Team  
**最后审核**：2026-01-04
