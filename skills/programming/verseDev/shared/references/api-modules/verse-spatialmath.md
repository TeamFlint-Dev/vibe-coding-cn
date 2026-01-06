# Verse.org/SpatialMath 模块参考文档

## 1. 模块概述

### 模块用途

`/Verse.org/SpatialMath` 是 Verse 语言中处理**三维空间数学运算**的核心模块。它提供了完整的 3D 数学基础设施，包括向量运算、旋转变换、空间插值等功能，是所有涉及空间位置、方向、缩放的游戏逻辑的基础。

### 设计理念

- **类型安全**: 使用强类型的 `vector3`、`rotation`、`transform` 结构体，避免运行时错误
- **右手坐标系**: 默认采用右手坐标系约定（正向旋转沿轴的右手螺旋方向）
- **不可变性**: 大部分操作返回新实例，而非修改原对象
- **性能优化**: 提供 `<converges>` 和 `<computes>` 标记的高性能纯函数
- **单位约定**: 同时支持弧度和角度，函数名明确标注单位（Radians/Degrees）

### 适用场景

| 场景类别 | 典型用途 | 相关 API |
|---------|---------|---------|
| **空间定位** | 物体位置、玩家坐标、生成点 | `vector3`, `transform.Translation` |
| **方向控制** | 物体朝向、摄像机视角、NPC 面向 | `rotation`, `MakeRotationFromYawPitchRoll*` |
| **移动轨迹** | 平滑移动、插值动画、路径跟随 | `Lerp`, `Slerp` |
| **碰撞检测** | 距离判定、范围检测 | `Distance`, `DistanceSquared` |
| **视觉效果** | 特效方向、粒子轨迹、光照计算 | `ReflectVector`, `CrossProduct` |
| **物理模拟** | 力的方向、速度向量 | `vector3` 的加减乘除运算 |

### 依赖关系

```verse
using {/Verse.org/SpatialMath}  # 导入整个模块
using {/Verse.org/Simulation}   # SpatialMath 内部依赖 Simulation
using {/Verse.org/Native}        # SpatialMath 内部依赖 Native
```

---

## 2. 核心类/接口清单

### 2.1 按功能分类

#### 数据结构（3个）

| 类型 | 说明 | 持久化 | 编辑器支持 |
|-----|------|--------|-----------|
| `vector3` | 三维向量（Left, Up, Forward） | ✅ | ✅ |
| `rotation` | 旋转表示（四元数封装） | ❌ | ❌ |
| `transform` | 组合变换（平移+旋转+缩放） | ❌ | ✅ |

#### 旋转构造函数（7个）

| 函数 | 用途 | 版本要求 |
|-----|------|---------|
| `MakeRotationRadians` | 轴角表示法（弧度） | 3600+ |
| `MakeRotationDegrees` | 轴角表示法（角度） | 3600+ |
| `MakeRotationFromYawPitchRollRadians` | 欧拉角（弧度） | 3600+ |
| `MakeRotationFromYawPitchRollDegrees` | 欧拉角（角度） | - |
| `MakeRotationFromEulerRadians` | 自定义欧拉角（弧度） | 3600+ |
| `MakeRotationFromEulerDegrees` | 自定义欧拉角（角度） | 3600+ |
| `IdentityRotation` | 单位旋转（无旋转） | - |

#### 旋转操作（13个方法）

| 方法/函数 | 功能 | 版本要求 |
|----------|------|---------|
| `Distance(rotation, rotation)` | 旋转距离（0.0-1.0） | - |
| `AngularDistanceRadians` | 角度距离（弧度） | 3600+ |
| `AngularDistanceDegrees` | 角度距离（角度） | 3600+ |
| `operator'*'(rotation, rotation)` | 旋转组合 | 3600+ |
| `operator'*'(vector3, rotation)` | 向量应用旋转 | - |
| `GetYawPitchRollRadians` | 提取欧拉角（弧度） | 3600+ |
| `GetYawPitchRollDegrees` | 提取欧拉角（角度） | 3600+ |
| `GetEulerRadians` | 提取自定义欧拉角（弧度） | 3600+ |
| `GetEulerDegrees` | 提取自定义欧拉角（角度） | 3600+ |
| `GetAxis` | 提取旋转轴 | - |
| `GetAngleRadians` | 提取旋转角度（弧度） | 3600+ |
| `GetAngleDegrees` | 提取旋转角度（角度） | 3600+ |
| `Invert` | 反向旋转 | - |

#### 旋转辅助（5个方法）

| 方法/函数 | 功能 |
|----------|------|
| `MakeShortestRotationBetween` | 计算两向量间最短旋转 |
| `Slerp` | 球面线性插值 |
| `GetForwardAxis` | 获取旋转后的前向单位向量 |
| `GetLeftAxis` | 获取旋转后的左向单位向量 |
| `GetUpAxis` | 获取旋转后的上向单位向量 |

#### Vector3 运算（20个方法/函数）

| 分类 | 方法/函数 |
|------|----------|
| **距离计算** | `Distance`, `DistanceSquared`, `DistanceForwardLeft`, `DistanceSquaredForwardLeft` |
| **向量运算** | `DotProduct`, `CrossProductLeftHanded`, `CrossProduct`, `ReflectVector` |
| **长度相关** | `Length`, `LengthSquared`, `LengthForwardLeft`, `LengthSquaredForwardLeft`, `MakeUnitVector` |
| **插值** | `Lerp` |
| **运算符** | `+`, `-`, `*`, `/`, `prefix'-'` (一元负号) |
| **验证** | `IsFinite`, `IsAlmostZero`, `IsAlmostEqual` |

#### 变换操作（2个）

| 函数 | 功能 |
|-----|------|
| `operator'*'(vector3, transform)` | 向量应用完整变换 |
| `ToString(transform)` | 变换转字符串 |

#### 工具函数（4个）

| 函数 | 功能 |
|-----|------|
| `DegreesToRadians` | 角度转弧度 |
| `RadiansToDegrees` | 弧度转角度 |
| `ToString(rotation)` | 旋转转字符串 |
| `ToString(vector3)` | 向量转字符串 |

---

## 3. 关键 API 详解

### 3.1 vector3 结构体

#### 定义

```verse
vector3<native><public> := struct<concrete><computes><persistable>:
    @editable Left<public>:float   # 左方向分量（原 -Y）
    @editable Up<public>:float     # 上方向分量（原 Z）
    @editable Forward<public>:float # 前方向分量（原 X）
```

#### 坐标系说明

| 轴名 | 原 UE 坐标 | 游戏语义 | 正方向示例 |
|-----|-----------|---------|-----------|
| `Forward` | +X | 前方 | 角色面向的方向 |
| `Left` | -Y | 左方 | 角色左手侧方向 |
| `Up` | +Z | 上方 | 天空方向 |

#### 常用构造

```verse
# 零向量
ZeroVector := vector3{Forward := 0.0, Left := 0.0, Up := 0.0}

# 单位向量
ForwardUnit := vector3{Forward := 1.0, Left := 0.0, Up := 0.0}
LeftUnit := vector3{Forward := 0.0, Left := 1.0, Up := 0.0}
UpUnit := vector3{Forward := 0.0, Left := 0.0, Up := 1.0}

# 自定义向量
PlayerPosition := vector3{Forward := 100.0, Left := -50.0, Up := 200.0}
```

#### 关键方法

##### `Length()` - 向量长度

```verse
(V:vector3).Length()<reads>:float
```

**用途**: 计算向量的欧几里得长度（模）。

**示例**:

```verse
Velocity := vector3{Forward := 3.0, Left := 4.0, Up := 0.0}
Speed := Velocity.Length()  # 返回 5.0 (sqrt(3²+4²))
```

**性能提示**: 如果只需要比较大小，使用 `LengthSquared()` 可避免开方运算。

##### `MakeUnitVector()` - 归一化

```verse
(V:vector3).MakeUnitVector()<reads>:vector3
```

**用途**: 返回相同方向的单位向量（长度为 1）。

**示例**:

```verse
Direction := vector3{Forward := 3.0, Left := 4.0, Up := 0.0}
NormalizedDir := Direction.MakeUnitVector()
# 返回 vector3{Forward := 0.6, Left := 0.8, Up := 0.0}
```

**注意事项**:
- 如果输入向量长度为 0，行为未定义
- 建议先检查 `Length() > 0.0` 再调用

##### 运算符重载

| 运算符 | 语义 | 示例 |
|-------|------|------|
| `V1 + V2` | 向量加法 | `Position + Velocity` |
| `V1 - V2` | 向量减法 | `TargetPos - CurrentPos` |
| `V * Scalar` | 标量乘法 | `Direction * Speed` |
| `V / Scalar` | 标量除法 | `TotalDistance / StepCount` |
| `V1 * V2` | 分量乘法 | `Scale * BaseSize` |
| `-V` | 取反 | `-Velocity` (反向) |

### 3.2 rotation 结构体

#### 定义

```verse
rotation<native><public> := struct<concrete>:
    # 内部实现为四元数，细节被封装
```

#### 构造方法对比

##### 方法 1: 轴角法 (Axis-Angle)

**适用场景**: 已知旋转轴和角度（如绕 Y 轴旋转 90°）

```verse
# 绕上方向轴旋转 90 度（右手法则：逆时针）
UpAxis := vector3{Forward := 0.0, Left := 0.0, Up := 1.0}
Rot90Deg := MakeRotationDegrees(UpAxis, 90.0)
```

**右手法则说明**: 右手大拇指指向轴正方向，四指弯曲方向即为正旋转方向。

##### 方法 2: 欧拉角法 (Yaw-Pitch-Roll)

**适用场景**: 描述角色/摄像机朝向（航向-俯仰-翻滚）

```verse
# Yaw（偏航）: 绕 Down 轴旋转，控制水平朝向
# Pitch（俯仰）: 绕 Right 轴旋转，控制上下仰角
# Roll（翻滚）: 绕 Forward 轴旋转，控制倾斜角度
CharacterRotation := MakeRotationFromYawPitchRollDegrees(
    45.0,   # Yaw: 向左旋转 45°
    -10.0,  # Pitch: 向下俯视 10°
    0.0     # Roll: 无翻滚
)
```

**旋转顺序**: Yaw → Pitch → Roll（先后应用）

##### 方法 3: 自定义欧拉角

**适用场景**: 需要特定旋转顺序

```verse
# Left → Up → Forward 顺序旋转
CustomRot := MakeRotationFromEulerRadians(
    DegreesToRadians(30.0),   # Left 轴旋转
    DegreesToRadians(45.0),   # Up 轴旋转
    DegreesToRadians(60.0)    # Forward 轴旋转
)
```

**注意**: 此方法与 YawPitchRoll 旋转顺序**不同**，不可混用。

#### 旋转组合

```verse
# 先应用旋转 A，再应用旋转 B
CombinedRotation := RotationA * RotationB

# 示例：先向左转 90°，再向上抬头 30°
YawRot := MakeRotationDegrees(vector3{Up := 1.0}, 90.0)
PitchRot := MakeRotationDegrees(vector3{Left := 1.0}, 30.0)
FinalRot := YawRot * PitchRot
```

**数学原理**: 四元数乘法，非交换（`A * B ≠ B * A`）。

#### 向量应用旋转

```verse
# 将向量旋转
ForwardVec := vector3{Forward := 1.0, Left := 0.0, Up := 0.0}
Rotation90 := MakeRotationDegrees(vector3{Up := 1.0}, 90.0)
RotatedVec := ForwardVec * Rotation90
# 结果：vector3{Forward := 0.0, Left := 1.0, Up := 0.0}
```

#### 旋转插值 (Slerp)

**用途**: 平滑旋转动画

```verse
Slerp<native><public>(
    InitialRotation:rotation,
    FinalRotation:rotation,
    Ratio:float  # 0.0-1.0，0为初始，1为最终
)<reads><converges>:rotation
```

**示例**:

```verse
# 从面向前方平滑转向左侧（5 帧动画）
StartRot := IdentityRotation()
EndRot := MakeRotationDegrees(vector3{Up := 1.0}, 90.0)

# 第 3 帧的旋转
Frame3Rot := Slerp(StartRot, EndRot, 3.0 / 5.0)  # 60% 完成
```

**优势**: 比线性插值更自然，保持恒定角速度。

### 3.3 transform 结构体

#### 定义

```verse
transform<native><public> := struct<concrete><computes>:
    @editable Translation<public>:vector3  # 平移
    @editable Rotation<public>:rotation    # 旋转
    @editable Scale<public>:vector3        # 缩放（每轴独立）
```

#### 变换顺序

**关键**: 变换按 **缩放 → 旋转 → 平移** 顺序应用。

```verse
# 构造完整变换
MyTransform := transform{
    Translation := vector3{Forward := 100.0, Left := 0.0, Up := 50.0},
    Rotation := MakeRotationDegrees(vector3{Up := 1.0}, 45.0),
    Scale := vector3{Forward := 2.0, Left := 1.0, Up := 1.0}
}

# 应用到向量
LocalPoint := vector3{Forward := 10.0, Left := 0.0, Up := 0.0}
WorldPoint := LocalPoint * MyTransform
# 等价于: (LocalPoint * Scale) * Rotation + Translation
```

#### 典型用途

```verse
# 物体相对父物体的局部变换
ChildTransform := transform{
    Translation := vector3{Forward := 5.0},  # 父物体前方 5 米
    Rotation := MakeRotationDegrees(vector3{Up := 1.0}, 90.0),
    Scale := vector3{Forward := 1.0, Left := 1.0, Up := 1.0}
}
```

### 3.4 距离计算函数

#### `Distance(V1, V2)` - 欧几里得距离

```verse
Distance<public>(V1:vector3, V2:vector3)<reads>:float
```

**公式**: `sqrt((V2.Forward - V1.Forward)² + (V2.Left - V1.Left)² + (V2.Up - V1.Up)²)`

**示例**:

```verse
PlayerPos := vector3{Forward := 0.0, Left := 0.0, Up := 0.0}
ItemPos := vector3{Forward := 3.0, Left := 4.0, Up := 0.0}
Dist := Distance(PlayerPos, ItemPos)  # 返回 5.0
```

#### `DistanceSquared(V1, V2)` - 平方距离

**优势**: 避免开方运算，性能更高。

**适用场景**: 距离比较（无需知道精确值）

```verse
# 检查玩家是否在 10 米范围内
MaxRange := 10.0
if DistanceSquared(PlayerPos, TargetPos) < MaxRange * MaxRange:
    # 在范围内
```

#### `DistanceForwardLeft(V1, V2)` - 2D 水平距离

**用途**: 忽略高度差异，只计算水平面距离。

```verse
GroundA := vector3{Forward := 0.0, Left := 0.0, Up := 0.0}
GroundB := vector3{Forward := 3.0, Left := 4.0, Up := 100.0}  # 高度差 100
HorizontalDist := DistanceForwardLeft(GroundA, GroundB)  # 返回 5.0
```

### 3.5 向量运算

#### `DotProduct(V1, V2)` - 点积

**数学定义**: `V1.Forward * V2.Forward + V1.Left * V2.Left + V1.Up * V2.Up`

**几何意义**: 
- `> 0`: 夹角 < 90°（方向大致相同）
- `= 0`: 垂直
- `< 0`: 夹角 > 90°（方向相反）

**示例 1: 判断物体是否在视野内**

```verse
# 计算物体相对方向
ToTarget := (TargetPos - CameraPos).MakeUnitVector()
CameraForward := camera.GetForwardAxis()

# 点积 > 0 表示在前方
if DotProduct(ToTarget, CameraForward) > 0.0:
    # 在视野前半球
```

**示例 2: 计算投影长度**

```verse
# 向量 A 在向量 B 上的投影长度
ProjectionLength := DotProduct(A, B.MakeUnitVector())
```

#### `CrossProduct(V1, V2)` - 叉积（右手）

**几何意义**: 返回同时垂直于 V1 和 V2 的向量。

**应用场景**:
1. 计算法向量
2. 判断左右侧
3. 计算旋转轴

**示例 1: 计算平面法向量**

```verse
# 三角形三个顶点
P1 := vector3{Forward := 0.0, Left := 0.0, Up := 0.0}
P2 := vector3{Forward := 1.0, Left := 0.0, Up := 0.0}
P3 := vector3{Forward := 0.0, Left := 1.0, Up := 0.0}

Edge1 := P2 - P1
Edge2 := P3 - P1
Normal := CrossProduct(Edge1, Edge2).MakeUnitVector()
```

**示例 2: 判断目标在左侧还是右侧**

```verse
Forward := character.GetForwardAxis()
ToTarget := (TargetPos - CharPos).MakeUnitVector()
CrossResult := CrossProduct(Forward, ToTarget)

if CrossResult.Up > 0.0:
    # 目标在左侧
else:
    # 目标在右侧
```

**注意**: 版本 3600+ 使用右手叉积，旧版本使用 `CrossProductLeftHanded`。

#### `ReflectVector(Direction, SurfaceNormal)` - 反射

**用途**: 计算光线/子弹在表面的反射方向。

```verse
# 子弹击中墙壁的反射
IncomingDir := vector3{Forward := 1.0, Left := 1.0, Up := 0.0}.MakeUnitVector()
WallNormal := vector3{Forward := -1.0, Left := 0.0, Up := 0.0}  # 墙面朝左
ReflectedDir := ReflectVector(IncomingDir, WallNormal)
```

**数学公式**: `Reflected = Direction - 2 * DotProduct(Direction, Normal) * Normal`

### 3.6 插值函数

#### `Lerp(From, To, Parameter)` - 线性插值

```verse
Lerp<public>(From:vector3, To:vector3, Parameter:float)<reads>:vector3
```

**公式**: `From * (1 - Parameter) + To * Parameter`

**示例 1: 平滑移动**

```verse
# 每帧向目标移动 10%
CurrentPos := Lerp(CurrentPos, TargetPos, 0.1)
```

**示例 2: 路径动画**

```verse
# 沿直线移动（0-1 参数控制进度）
StartPos := vector3{Forward := 0.0}
EndPos := vector3{Forward := 100.0}
HalfwayPos := Lerp(StartPos, EndPos, 0.5)  # Forward = 50.0
```

**注意**: `Parameter` 超出 0-1 会进行外插。

---

## 4. 代码示例

### 示例 1: 角色朝向目标点

**场景**: NPC 转向并面对玩家

```verse
using { /Verse.org/SpatialMath }

TurnTowardsTarget(NPCPosition:vector3, TargetPosition:vector3):rotation =
    # 1. 计算从 NPC 到目标的方向向量
    DirectionToTarget := (TargetPosition - NPCPosition).MakeUnitVector()
    
    # 2. 获取默认前向向量
    DefaultForward := vector3{Forward := 1.0, Left := 0.0, Up := 0.0}
    
    # 3. 计算从默认朝向到目标方向的最短旋转
    RequiredRotation := MakeShortestRotationBetween(DefaultForward, DirectionToTarget)
    
    RequiredRotation

# 使用示例
NPCPos := vector3{Forward := 0.0, Left := 0.0, Up := 0.0}
PlayerPos := vector3{Forward := 10.0, Left := 10.0, Up := 0.0}
NewNPCRotation := TurnTowardsTarget(NPCPos, PlayerPos)
```

**关键点**:
- `MakeShortestRotationBetween` 自动计算最短路径旋转
- 返回的旋转可直接应用到 NPC 的 transform

### 示例 2: 平滑旋转动画

**场景**: 炮塔缓慢转向目标

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Simulation }

# 每帧更新的平滑旋转
SmoothRotateTowards(
    CurrentRotation:rotation,
    TargetRotation:rotation,
    RotationSpeed:float  # 0.0-1.0，每帧旋转进度
):rotation =
    Slerp(CurrentRotation, TargetRotation, RotationSpeed)

# 使用示例（假设在每帧更新的函数中）
TurretRotation:rotation = IdentityRotation()
TargetDirection:rotation = MakeRotationFromYawPitchRollDegrees(90.0, 0.0, 0.0)

UpdateTurret():void =
    # 每帧旋转 5%（约 20 帧完成 90 度转向）
    set TurretRotation = SmoothRotateTowards(TurretRotation, TargetDirection, 0.05)
```

**优势**: 使用 Slerp 保证匀速旋转，避免突然停止。

### 示例 3: 发射抛物线投射物

**场景**: 手榴弹抛物线轨迹计算

```verse
using { /Verse.org/SpatialMath }

CalculateProjectileVelocity(
    StartPos:vector3,
    TargetPos:vector3,
    LaunchAngleDegrees:float,  # 发射角度（0-90）
    Gravity:float  # 重力加速度（如 -9.8）
):vector3 =
    # 1. 计算水平方向
    HorizontalDir := (TargetPos - StartPos)
    set HorizontalDir = vector3{
        Forward := HorizontalDir.Forward,
        Left := HorizontalDir.Left,
        Up := 0.0
    }
    HorizontalDist := HorizontalDir.Length()
    HorizontalUnitDir := HorizontalDir.MakeUnitVector()
    
    # 2. 计算高度差
    HeightDiff := TargetPos.Up - StartPos.Up
    
    # 3. 计算初速度（简化公式）
    AngleRad := DegreesToRadians(LaunchAngleDegrees)
    # 此处省略完整的抛物线公式，示例简化
    HorizontalSpeed := 20.0  # 假设固定水平速度
    VerticalSpeed := HorizontalSpeed * Tan(AngleRad)  # 简化示例
    
    # 4. 组合速度向量
    Velocity := HorizontalUnitDir * HorizontalSpeed + 
                vector3{Up := VerticalSpeed}
    
    Velocity

# 使用示例
ThrowPos := vector3{Forward := 0.0, Left := 0.0, Up := 2.0}
LandingPos := vector3{Forward := 10.0, Left := 0.0, Up := 0.0}
InitialVelocity := CalculateProjectileVelocity(ThrowPos, LandingPos, 45.0, -9.8)
```

**注意**: 实际物理模拟需要更复杂的运动学方程。

### 示例 4: 圆形路径移动

**场景**: 物体绕中心点做圆周运动

```verse
using { /Verse.org/SpatialMath }

CircularMotion(
    CenterPos:vector3,
    Radius:float,
    AngleDegrees:float,  # 当前角度（0-360）
    Height:float  # 圆周平面高度
):vector3 =
    # 1. 转换为弧度
    AngleRad := DegreesToRadians(AngleDegrees)
    
    # 2. 计算圆周上的偏移（使用 Forward 和 Left 构成水平面）
    OffsetForward := Radius * Cos(AngleRad)
    OffsetLeft := Radius * Sin(AngleRad)
    
    # 3. 叠加中心位置
    CurrentPos := CenterPos + vector3{
        Forward := OffsetForward,
        Left := OffsetLeft,
        Up := Height
    }
    
    CurrentPos

# 使用示例：环绕飞行的无人机
DroneCenter := vector3{Forward := 50.0, Left := 50.0, Up := 20.0}
CurrentAngle:float = 0.0

UpdateDronePosition():vector3 =
    set CurrentAngle = (CurrentAngle + 2.0) Mod 360.0  # 每帧旋转 2 度
    CircularMotion(DroneCenter, 10.0, CurrentAngle, 0.0)
```

**扩展**: 结合旋转可实现椭圆轨迹。

### 示例 5: 局部坐标到世界坐标转换

**场景**: 物体挂载系统（如武器挂在角色手上）

```verse
using { /Verse.org/SpatialMath }

LocalToWorld(
    ParentTransform:transform,
    LocalOffset:vector3
):vector3 =
    # 应用父物体的完整变换到局部偏移
    WorldPosition := LocalOffset * ParentTransform
    WorldPosition

# 使用示例：角色手持武器
CharacterTransform := transform{
    Translation := vector3{Forward := 10.0, Left := 5.0, Up := 0.0},
    Rotation := MakeRotationFromYawPitchRollDegrees(45.0, 0.0, 0.0),
    Scale := vector3{Forward := 1.0, Left := 1.0, Up := 1.0}
}

# 武器在角色局部坐标系中的位置（右手前方）
WeaponLocalOffset := vector3{Forward := 1.0, Left := -0.5, Up := 1.5}

# 计算武器的世界坐标
WeaponWorldPos := LocalToWorld(CharacterTransform, WeaponLocalOffset)
```

**关键**: `transform` 的乘法运算自动处理缩放-旋转-平移顺序。

---

## 5. 常见误区澄清

### 误区 1: 混淆左手与右手坐标系

**错误认知**: "Verse 使用左手坐标系，像 Unity"

**正确理解**: 
- Verse 使用**右手坐标系**
- `CrossProduct` 从 3600 版本起明确为右手叉积
- 旧代码使用 `CrossProductLeftHanded` 需要迁移

**验证方法**:

```verse
# 右手法则：Forward × Left = Up
Forward := vector3{Forward := 1.0, Left := 0.0, Up := 0.0}
Left := vector3{Forward := 0.0, Left := 1.0, Up := 0.0}
Result := CrossProduct(Forward, Left)
# Result.Up 应该为正（右手坐标系）
```

### 误区 2: 旋转顺序不敏感

**错误认知**: "旋转 A 再旋转 B，跟旋转 B 再旋转 A 一样"

**正确理解**: 旋转组合**不满足交换律**（`A * B ≠ B * A`）

**示例验证**:

```verse
# 顺序 1: 先 Yaw 再 Pitch
Rot1 := MakeRotationFromYawPitchRollDegrees(90.0, 0.0, 0.0) *
        MakeRotationFromYawPitchRollDegrees(0.0, 45.0, 0.0)

# 顺序 2: 先 Pitch 再 Yaw
Rot2 := MakeRotationFromYawPitchRollDegrees(0.0, 45.0, 0.0) *
        MakeRotationFromYawPitchRollDegrees(90.0, 0.0, 0.0)

# Rot1 和 Rot2 结果不同！
```

**最佳实践**: 明确文档化旋转应用顺序。

### 误区 3: Lerp 自动限制参数范围

**错误认知**: "`Lerp` 的 `Parameter` 会自动截断到 0-1"

**正确理解**: `Lerp` 允许**外插**，`Parameter` 可以 < 0 或 > 1

**示例**:

```verse
Start := vector3{Forward := 0.0}
End := vector3{Forward := 100.0}

# Parameter = 1.5 时进行外插
Extrapolated := Lerp(Start, End, 1.5)
# Extrapolated.Forward = 150.0（超出终点 50%）
```

**正确用法**: 手动截断参数

```verse
SafeParameter := Clamp(RawParameter, 0.0, 1.0)  # 需自行实现 Clamp
SafeLerp := Lerp(Start, End, SafeParameter)
```

### 误区 4: 欧拉角万向锁问题

**错误认知**: "使用欧拉角表示旋转总是安全的"

**正确理解**: 欧拉角存在**万向锁（Gimbal Lock）**问题

**何时发生**: 
- Pitch 接近 ±90° 时，Yaw 和 Roll 轴重合
- 导致一个自由度丢失

**规避方法**:
1. 内部计算使用 `rotation`（四元数封装）
2. 仅在输入/输出时转换为欧拉角
3. 旋转插值使用 `Slerp` 而非欧拉角线性插值

### 误区 5: Transform 变换顺序可控

**错误认知**: "我可以自定义 `transform` 的缩放-旋转-平移顺序"

**正确理解**: `transform` 的顺序**固定**为：缩放 → 旋转 → 平移

**影响**:

```verse
# 先平移再缩放（需手动组合）
Step1 := LocalPos + Translation  # 先平移
Step2 := Step1 * Scale           # 再缩放（分量乘法）

# transform 无法直接实现此顺序
```

**最佳实践**: 如需自定义顺序，手动拆分变换步骤。

### 误区 6: 向量长度总是有效

**错误认知**: "任何向量都可以归一化"

**正确理解**: 零向量无法归一化

**安全检查**:

```verse
SafeNormalize(V:vector3):?vector3 =
    if V.LengthSquared() > 0.0001:  # 避免浮点误差
        V.MakeUnitVector()
    else:
        false  # 返回 option 类型失败值
```

---

## 6. 最佳实践

### 6.1 性能优化

#### 优先使用平方距离

**原则**: 距离比较时避免开方运算。

```verse
# ❌ 低效
if Distance(A, B) < 10.0:
    # ...

# ✅ 高效
MaxDistSq := 10.0 * 10.0
if DistanceSquared(A, B) < MaxDistSq:
    # ...
```

**原因**: `sqrt()` 的 CPU 开销远高于乘法。

#### 缓存归一化结果

**原则**: 避免重复归一化相同向量。

```verse
# ❌ 每帧重复计算
UpdateFrame():void =
    Dir := (Target - Current).MakeUnitVector()
    # ... 多次使用 Dir

# ✅ 缓存结果
CachedDirection:vector3 = vector3{Forward := 1.0}

UpdateTarget(NewTarget:vector3):void =
    set CachedDirection = (NewTarget - Current).MakeUnitVector()

UpdateFrame():void =
    # 直接使用缓存的 CachedDirection
```

#### 使用 2D 距离减少计算

**场景**: 地面单位距离检测（忽略高度）

```verse
# ✅ 忽略高度差的水平距离
HorizontalDist := DistanceForwardLeft(PlayerPos, EnemyPos)
```

### 6.2 数值稳定性

#### 检查向量有效性

**原则**: 数学运算前验证输入。

```verse
SafeDivide(V:vector3, Divisor:float):?vector3 =
    if Abs(Divisor) > 0.0001:
        V / Divisor
    else:
        false  # 除数接近零

SafeCrossProduct(V1:vector3, V2:vector3):?vector3 =
    Result := CrossProduct(V1, V2)
    if Result.LengthSquared() > 0.0001:
        Result
    else:
        false  # 向量平行或接近平行
```

#### 使用容差比较

**原则**: 浮点数避免精确相等比较。

```verse
# ❌ 浮点数精确比较
if V.Up = 0.0:
    # 可能永远不成立

# ✅ 使用容差
Tolerance := 0.001
if Abs(V.Up) < Tolerance:
    # 近似为零
```

**API 支持**:

```verse
# 检查向量是否接近零
if V.IsAlmostZero(0.001):
    # ...

# 检查两向量是否相等
if IsAlmostEqual(V1, V2, 0.001):
    # ...
```

### 6.3 与其他模块配合

#### 与 SceneGraph 集成

**场景**: 设置实体位置和旋转

```verse
using { /Verse.org/SceneGraph }
using { /Verse.org/SpatialMath }

SetupEntity(Entity:entity, Pos:vector3, Rot:rotation):void =
    # 假设 Entity 有 transformable_component
    if TransformableComp := Entity.GetComponent(transformable_component):
        NewTransform := transform{
            Translation := Pos,
            Rotation := Rot,
            Scale := vector3{Forward := 1.0, Left := 1.0, Up := 1.0}
        }
        TransformableComp.SetTransform(NewTransform)
```

#### 与 Simulation 集成

**场景**: 基于时间的物理模拟

```verse
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

# 简单的重力模拟
ApplyGravity(CurrentVelocity:vector3, DeltaTime:float, Gravity:float):vector3 =
    GravityAcceleration := vector3{Up := Gravity}  # 如 -9.8
    NewVelocity := CurrentVelocity + GravityAcceleration * DeltaTime
    NewVelocity

# 使用示例（假设 GetDeltaTime 存在）
Velocity:vector3 = vector3{Forward := 10.0, Up := 5.0}

UpdatePhysics():void =
    DeltaTime := GetDeltaTime()  # 从 Simulation 获取
    set Velocity = ApplyGravity(Velocity, DeltaTime, -9.8)
```

#### 与 Fortnite.com/FortPlayerUtilities 配合

**场景**: 玩家相对位置计算

```verse
using { /Fortnite.com/Characters }
using { /Verse.org/SpatialMath }

GetPlayerRelativePosition(Player:fort_character, Offset:vector3):vector3 =
    # 获取玩家当前变换（伪代码）
    PlayerTransform := Player.GetTransform()
    
    # 计算世界坐标
    WorldPos := Offset * PlayerTransform
    WorldPos
```

### 6.4 代码组织

#### 封装常用向量

**建议**: 创建常量向量库

```verse
# 文件：MathConstants.verse
using { /Verse.org/SpatialMath }

# 零向量
ZeroVector<public>:vector3 = vector3{Forward := 0.0, Left := 0.0, Up := 0.0}

# 单位向量
ForwardUnit<public>:vector3 = vector3{Forward := 1.0, Left := 0.0, Up := 0.0}
LeftUnit<public>:vector3 = vector3{Forward := 0.0, Left := 1.0, Up := 0.0}
UpUnit<public>:vector3 = vector3{Forward := 0.0, Left := 0.0, Up := 1.0}

# 单位缩放
UnitScale<public>:vector3 = vector3{Forward := 1.0, Left := 1.0, Up := 1.0}

# 单位旋转
NoRotation<public>:rotation = IdentityRotation()
```

#### 辅助函数库

**建议**: 封装常用模式

```verse
# 文件：MathHelpers.verse
using { /Verse.org/SpatialMath }

# 计算 2D 方向（忽略高度）
GetHorizontalDirection<public>(From:vector3, To:vector3):vector3 =
    Offset := To - From
    HorizontalOffset := vector3{
        Forward := Offset.Forward,
        Left := Offset.Left,
        Up := 0.0
    }
    HorizontalOffset.MakeUnitVector()

# 安全的 Lerp（截断参数）
SafeLerp<public>(From:vector3, To:vector3, T:float):vector3 =
    ClampedT := if T < 0.0 then 0.0 else if T > 1.0 then 1.0 else T
    Lerp(From, To, ClampedT)

# 检查向量是否朝向目标
IsFacing<public>(ForwardDir:vector3, ToTarget:vector3, AngleThresholdDeg:float):logic =
    Dot := DotProduct(ForwardDir.MakeUnitVector(), ToTarget.MakeUnitVector())
    ThresholdCos := Cos(DegreesToRadians(AngleThresholdDeg))
    Dot >= ThresholdCos
```

---

## 7. 参考资源

### 官方文档

- **Verse API 参考**: Epic 官方 Verse API 文档（随 UEFN 版本更新）
- **UEFN 文档中心**: [https://dev.epicgames.com/documentation/en-us/uefn](https://dev.epicgames.com/documentation/en-us/uefn)
- **Verse 语言规范**: Verse 编程语言官方规范

### 相关 API 模块

| 模块 | 关系 | 用途 |
|------|------|------|
| `/Verse.org/SceneGraph` | **强关联** | 实体变换管理，使用 `transform` |
| `/Verse.org/Simulation` | **依赖** | 时间系统，物理模拟基础 |
| `/Fortnite.com/Characters` | **常配合** | 角色位置、朝向控制 |
| `/Fortnite.com/FortPlayerUtilities` | **常配合** | 玩家相关空间计算 |
| `/UnrealEngine.com/BasicShapes` | **可配合** | 基础形状的空间操作 |

### 本仓库参考文档

- **API Digest 原始文件**: `skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md`（第 2073-2332 行）
- **模块列表**: `skills/programming/verseDev/shared/references/api-modules-list.md`
- **SceneGraph 框架**: `skills/programming/verseDev/shared/references/scenegraph-framework-guide.md`
- **Verse 类与对象**: `skills/programming/verseDev/shared/references/verse-classes-and-objects.md`

### 数学原理参考

- **四元数旋转**: 了解 `rotation` 内部实现原理
- **欧拉角万向锁**: 理解欧拉角的局限性
- **叉积几何意义**: 深入理解 `CrossProduct` 应用
- **球面插值 (Slerp)**: 旋转插值的数学基础

---

## 附录：版本兼容性说明

### MinUploadedAtFNVersion := 3600

以下 API 需要 Fortnite 版本 **36.00** 或更高：

- `MakeRotationRadians`
- `MakeRotationDegrees`
- `MakeRotationFromEulerRadians`
- `MakeRotationFromEulerDegrees`
- `AngularDistanceRadians`
- `AngularDistanceDegrees`
- `operator'*'(rotation, rotation)`
- `GetYawPitchRollRadians`
- `GetYawPitchRollDegrees`
- `GetEulerRadians`
- `GetEulerDegrees`
- `GetAngleRadians`
- `GetAngleDegrees`
- `CrossProduct` (右手叉积)

### 旧版本迁移

如果需要支持旧版本 UEFN：

1. 使用 `MakeRotationFromYawPitchRollDegrees`（无版本限制）
2. 使用 `CrossProductLeftHanded` 替代 `CrossProduct`
3. 避免使用 `rotation` 乘法运算符

---

**文档版本**: v1.0
**最后更新**: 2026-01-04
**基于 API 版本**: ++Fortnite+Release-39.11-CL-49242330
