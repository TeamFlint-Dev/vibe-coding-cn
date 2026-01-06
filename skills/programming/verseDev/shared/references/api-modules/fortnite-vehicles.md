# Fortnite.com/Vehicles API 模块深度调研

## 模块概述

### 基本信息

- **模块路径**: `/Fortnite.com/Vehicles`
- **API 版本**: ++Fortnite+Release-39.11-CL-49242330
- **模块规模**: 39 行代码，1 个核心接口，1 个扩展方法

### 模块用途和设计理念

`/Fortnite.com/Vehicles` 模块是 UEFN 中专门用于**载具系统**的 API 模块。该模块提供了一套精简而强大的接口，用于：

1. **载具状态查询** - 检测载具的环境状态（地面/空中/水中）
2. **载具属性访问** - 获取速度、燃料、加速等运行时数据
3. **乘客管理** - 查询和管理载具上的角色
4. **载具控制** - 传送载具到指定位置和旋转角度

**设计理念**：
- **轻量级接口** - 只定义 1 个核心接口 `fort_vehicle`，避免复杂的继承体系
- **多态集成** - 通过继承多个基础接口（`positional`, `healthful`, `damageable`, `game_action_causer`）实现功能复用
- **安全性优先** - 使用 `<decides>` 修饰符确保操作在失败时能被正确处理
- **只读属性** - 大部分属性为只读（`var<private>`），防止外部直接修改载具状态

### 适用场景说明

本模块适用于以下载具系统开发场景：

| 场景分类 | 具体应用 | 典型示例 |
|---------|---------|---------|
| **载具状态监控** | 检测载具所处环境，触发相应逻辑 | 载具落水时播放溅水特效 |
| **燃料系统** | 管理载具燃料消耗和补给 | 燃料耗尽时禁用加速功能 |
| **乘客交互** | 获取乘客列表，实现多人协作玩法 | 满载时给所有乘客增加移速 buff |
| **载具传送** | 在特定条件下重定位载具 | 比赛开始时将载具传送到起点 |
| **速度反馈** | 根据载具速度触发 UI 或音效 | 速度超过 100 km/h 显示速度警告 |
| **加速系统** | 监控和管理载具的加速能量 | 加速耗尽时显示充能进度条 |

---

## 核心类/接口清单

### 模块依赖

```verse
using {/UnrealEngine.com/Temporary/SpatialMath}  # 空间数学（位置、旋转）
using {/Fortnite.com/Game}                       # 游戏逻辑基础（game_action_causer）
using {/Fortnite.com/Characters}                 # 角色系统（fort_character）
```

### 接口继承关系图

```
fort_vehicle (interface)
    ├─ positional          # 提供位置和旋转相关能力
    ├─ healthful           # 提供生命值相关能力
    ├─ damageable          # 提供受伤害能力
    └─ game_action_causer  # 提供游戏动作追踪能力
```

### 完整接口清单

| 接口/类名 | 类型 | 用途 | 属性 |
|----------|------|------|------|
| `fort_vehicle` | interface | 载具主接口，定义所有载具必须实现的能力 | `<native>`, `<public>`, `<unique>`, `<epic_internal>` |

### 扩展方法清单

| 方法签名 | 返回类型 | 用途 |
|---------|---------|------|
| `(InCharacter:fort_character).GetVehicle()` | `fort_vehicle` | 从角色获取其所在的载具实例 |

---

## 关键 API 详解

### 1. 获取角色的载具实例

```verse
(InCharacter:fort_character).GetVehicle<native><public>()<transacts><decides>:fort_vehicle
```

**功能说明**：
返回指定角色当前所在的载具对象。

**参数**：
- `InCharacter`: 要查询的角色对象

**返回值**：
- 成功：返回角色所在的 `fort_vehicle` 实例
- 失败：如果角色不在任何载具上，方法会 `fail`（由 `<decides>` 保证）

**修饰符解析**：
- `<native>`: 原生实现，由引擎提供
- `<public>`: 公开接口
- `<transacts>`: 可能产生副作用，需在事务上下文中调用
- `<decides>`: 可能失败，需使用 `if` 或 `?` 处理

**使用限制**：
- ⚠️ 角色必须是载具的乘客，否则方法失败
- ⚠️ 必须在 `<suspends>` 或 `<transacts>` 上下文中调用

**注意事项**：
- 该方法不返回 `?fort_vehicle`，而是通过 `<decides>` 表示失败状态
- 调用方需要处理失败情况（通过 `if` 表达式）

---

### 2. fort_vehicle 接口方法详解

#### 2.1 环境状态检测方法

##### IsOnGround - 检测载具是否在地面

```verse
IsOnGround<public>()<transacts><decides>:void
```

**功能说明**：检查载具是否接触地面。

**返回值**：
- 成功（`succeeds`）：载具在地面上
- 失败（`fails`）：载具不在地面上（可能在空中或水中）

**典型用法**：
```verse
if (Vehicle.IsOnGround[]) then:
    # 载具在地面上的逻辑
```

---

##### IsInAir - 检测载具是否在空中

```verse
IsInAir<public>()<transacts><decides>:void
```

**功能说明**：检查载具是否在空中（不接触地面或水面）。

**返回值**：
- 成功（`succeeds`）：载具在空中
- 失败（`fails`）：载具不在空中

**注意事项**：
- 载具可能同时满足 `IsOnGround` 和 `IsInAir` 都为 false（例如在水中）
- 三个状态（地面、空中、水中）不是互斥的边界状态

---

##### IsInWater - 检测载具是否在水中

```verse
IsInWater<public>()<transacts><decides>:void
```

**功能说明**：检查载具是否浸入水中。

**返回值**：
- 成功（`succeeds`）：载具在水中
- 失败（`fails`）：载具不在水中

**使用场景**：
- 触发水中特效（水花、水波）
- 调整载具物理参数（如浮力、阻力）
- 限制某些载具能力（如火焰喷射器在水中失效）

---

#### 2.2 乘客管理方法

##### GetPassengers - 获取所有乘客

```verse
GetPassengers<public>()<transacts>:[]fort_character
```

**功能说明**：返回当前载具上所有乘客的数组。

**返回值**：
- 类型：`[]fort_character`（角色数组）
- 空数组：载具无乘客
- 非空数组：包含所有座位上的角色

**参数**：无

**使用限制**：
- ⚠️ 返回的数组是快照，不会实时更新
- ⚠️ 需要定期重新调用以获取最新乘客列表

**典型用法**：
```verse
Passengers := Vehicle.GetPassengers()
for (Passenger : Passengers):
    # 对每个乘客执行操作
```

---

#### 2.3 燃料系统方法

##### GetFuelRemaining - 获取剩余燃料

```verse
GetFuelRemaining<public>()<transacts>:float
```

**功能说明**：返回载具当前剩余燃料量。

**返回值**：
- 使用燃料的载具：返回 `0.0` 到 `GetFuelCapacity()` 之间的值
- 不使用燃料的载具：返回 `-1.0`

**重要提示**：
- ⚠️ 返回 `-1.0` 表示该载具**不使用燃料系统**（例如默认的购物车）
- ⚠️ 不要将 `-1.0` 误认为是"燃料耗尽"

**使用场景**：
- 计算燃料百分比：`(GetFuelRemaining() / GetFuelCapacity()) * 100.0`
- 判断是否需要补给：`if (GetFuelRemaining() < 10.0) then: ...`

---

##### GetFuelCapacity - 获取燃料容量

```verse
GetFuelCapacity<public>()<transacts>:float
```

**功能说明**：返回载具的最大燃料容量。

**返回值**：
- 使用燃料的载具：返回 `1.0` 到 `Inf` 之间的值
- 不使用燃料的载具：返回 `-1.0`

**注意事项**：
- 燃料容量通常是载具的固定属性，不会在运行时改变
- 可以通过 `GetFuelCapacity()` 判断载具是否使用燃料系统

---

#### 2.4 载具控制方法

##### TeleportTo - 传送载具

```verse
TeleportTo<public>(Position:vector3, Rotation:rotation)<transacts><decides>:void
```

**功能说明**：将载具瞬间传送到指定的位置和旋转角度。

**参数**：
- `Position`: 目标位置（`vector3` 类型，来自 `/UnrealEngine.com/Temporary/SpatialMath`）
- `Rotation`: 目标旋转（`rotation` 类型）

**返回值**：
- 成功（`succeeds`）：传送成功
- 失败（`fails`）：传送失败（目标位置可能不可达或被阻挡）

**使用限制**：
- ⚠️ 传送到无效位置（如地图外）会导致方法失败
- ⚠️ 传送可能导致载具卡在物体中，需要验证目标位置的有效性
- ⚠️ 传送不会保留载具的速度和加速度状态

**典型用法**：
```verse
TargetPos := vector3{X := 1000.0, Y := 2000.0, Z := 100.0}
TargetRot := rotation{} # 默认旋转
if (Vehicle.TeleportTo[TargetPos, TargetRot]) then:
    # 传送成功
```

---

#### 2.5 只读属性

##### Speed - 当前速度

```verse
var<private> Speed<public>:float
```

**功能说明**：载具的当前速度（单位：**km/h**）。

**属性特征**：
- 只读属性（`var<private>` 表示不可从外部修改）
- 实时更新的动态值

**单位注意**：
- ⚠️ 单位是 **km/h**（公里/小时），不是 m/s 或 cm/s
- 转换到 m/s: `SpeedInMPS := Vehicle.Speed / 3.6`

**使用场景**：
- 速度检测：`if (Vehicle.Speed > 100.0) then: ...`
- UI 显示：显示速度表
- 音效控制：根据速度调整引擎音量

---

##### BoostRemaining - 剩余加速能量

```verse
var<private> BoostRemaining<public>:?float
```

**功能说明**：载具的当前剩余加速能量。

**返回值类型**：`?float`（可选的浮点数）
- 使用加速系统的载具：`option{Value}` 其中 `Value` 在 `0.0` 到 `BoostCapacity` 之间
- 不使用加速系统的载具：`false`（空值）

**重要提示**：
- ⚠️ 使用前必须先解包（unwrap）可选值
- ⚠️ `false` 表示载具**不支持加速功能**，不是"加速耗尽"

**典型用法**：
```verse
if (MaybeBoost := Vehicle.BoostRemaining?):
    Boost := MaybeBoost
    Print("Boost: {Boost}")
```

---

##### BoostCapacity - 最大加速容量

```verse
var<private> BoostCapacity<public>:?float
```

**功能说明**：载具的最大加速能量容量。

**返回值类型**：`?float`（可选的浮点数）
- 使用加速系统的载具：`option{Value}` 其中 `Value` 在 `1.0` 到 `Inf` 之间
- 不使用加速系统的载具：`false`（空值）

**使用场景**：
- 计算加速百分比：`(BoostRemaining / BoostCapacity) * 100.0`
- 判断载具是否支持加速：`if (Vehicle.BoostCapacity?) then: ...`

---

## 代码示例

### 示例 1: 检测玩家是否在载具上并获取载具状态

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Vehicles }
using { /Verse.org/Simulation }

CheckPlayerVehicle(Player:player):void=
    # 获取玩家的角色
    if (PlayerChar := Player.GetFortCharacter[]):
        # 尝试获取角色所在的载具
        if (Vehicle := PlayerChar.GetVehicle[]):
            # 成功获取载具，检查其状态
            
            # 检查环境状态
            if (Vehicle.IsOnGround[]):
                Print("载具在地面上")
            
            if (Vehicle.IsInAir[]):
                Print("载具在空中")
            
            if (Vehicle.IsInWater[]):
                Print("载具在水中")
            
            # 获取速度
            CurrentSpeed := Vehicle.Speed
            Print("当前速度: {CurrentSpeed} km/h")
            
            # 检查燃料（如果有）
            FuelRemaining := Vehicle.GetFuelRemaining()
            if (FuelRemaining >= 0.0):
                FuelCapacity := Vehicle.GetFuelCapacity()
                FuelPercent := (FuelRemaining / FuelCapacity) * 100.0
                Print("燃料剩余: {FuelPercent}%")
            else:
                Print("此载具不使用燃料系统")
        else:
            Print("玩家不在载具上")
    else:
        Print("无法获取玩家角色")
```

**示例说明**：
- 展示了完整的错误处理流程（多层 `if` 表达式）
- 演示了如何正确处理燃料系统的特殊值 `-1.0`
- 涵盖了载具状态检测的所有主要方法

---

### 示例 2: 监控载具燃料并在低燃料时传送到加油站

```verse
using { /Fortnite.com/Vehicles }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Simulation }

# 加油站位置（假设）
GasStationPos<private>:vector3 = vector3{X := 5000.0, Y := 5000.0, Z := 100.0}
GasStationRot<private>:rotation = rotation{} # 默认旋转

MonitorVehicleFuel<suspends>(Vehicle:fort_vehicle):void=
    loop:
        # 获取燃料信息
        FuelRemaining := Vehicle.GetFuelRemaining()
        
        # 检查是否使用燃料系统
        if (FuelRemaining >= 0.0):
            FuelCapacity := Vehicle.GetFuelCapacity()
            FuelPercent := (FuelRemaining / FuelCapacity) * 100.0
            
            # 燃料低于 20% 时传送到加油站
            if (FuelPercent < 20.0):
                Print("⚠️ 燃料不足！正在传送到加油站...")
                
                if (Vehicle.TeleportTo[GasStationPos, GasStationRot]):
                    Print("✅ 传送成功！请加油")
                    # 成功传送后退出监控
                    break
                else:
                    Print("❌ 传送失败，请手动前往加油站")
        
        # 每秒检查一次
        Sleep(1.0)
```

**示例说明**：
- 展示了如何使用 `loop` 和 `Sleep` 实现持续监控
- 演示了 `TeleportTo` 的错误处理
- 说明了如何计算燃料百分比并触发条件动作

---

### 示例 3: 给满载载具的所有乘客增加移速 buff

```verse
using { /Fortnite.com/Vehicles }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /Verse.org/Simulation }

# 假设载具满载人数为 4
MaxPassengers<private>:int = 4

ApplyFullLoadBonus<suspends>(Vehicle:fort_vehicle):void=
    loop:
        # 获取当前乘客列表
        Passengers := Vehicle.GetPassengers()
        
        # 检查是否满载
        if (Passengers.Length = MaxPassengers):
            Print("🚗 载具满载！为所有乘客增加移速 buff")
            
            # 对每个乘客应用 buff
            for (Passenger : Passengers):
                # 在这里调用角色的移速增益方法
                # 例如：Passenger.ApplySpeedBoost(1.2) # 假设方法
                Print("为乘客应用移速 buff")
        else:
            PassengerCount := Passengers.Length
            Print("当前乘客数: {PassengerCount}/{MaxPassengers}")
        
        # 每 2 秒检查一次
        Sleep(2.0)
```

**示例说明**：
- 展示了如何使用 `GetPassengers()` 获取乘客列表
- 演示了数组遍历和长度检查
- 说明了实时监控乘客变化的模式

---

### 示例 4: 根据载具速度动态调整 UI 显示

```verse
using { /Fortnite.com/Vehicles }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation }

# 速度阈值配置
SpeedWarningThreshold<private>:float = 100.0  # km/h
SpeedDangerThreshold<private>:float = 150.0   # km/h

ShowSpeedFeedback<suspends>(Vehicle:fort_vehicle, Player:player):void=
    loop:
        CurrentSpeed := Vehicle.Speed
        
        if (CurrentSpeed >= SpeedDangerThreshold):
            # 危险速度 - 显示红色警告
            Print("🔴 危险速度: {CurrentSpeed} km/h")
            # 这里可以调用 UI 接口显示红色速度表
            
        else if (CurrentSpeed >= SpeedWarningThreshold):
            # 警告速度 - 显示黄色提示
            Print("🟡 高速行驶: {CurrentSpeed} km/h")
            # 这里可以调用 UI 接口显示黄色速度表
            
        else:
            # 正常速度 - 显示绿色或白色
            Print("🟢 正常速度: {CurrentSpeed} km/h")
        
        # 每 0.5 秒更新一次 UI
        Sleep(0.5)
```

**示例说明**：
- 展示了如何读取实时速度数据
- 演示了基于速度阈值的条件判断
- 说明了高频率 UI 更新的模式（0.5 秒刷新）

---

### 示例 5: 综合示例 - 载具管理器

```verse
using { /Fortnite.com/Vehicles }
using { /Fortnite.com/Characters }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Simulation }

VehicleManager := class:
    Vehicle:fort_vehicle
    
    # 构造函数
    Init(InVehicle:fort_vehicle):VehicleManager=
        VehicleManager{Vehicle := InVehicle}
    
    # 获取载具状态摘要
    GetStatusSummary():string=
        var Status:string = "载具状态:\n"
        
        # 环境状态
        if (Vehicle.IsOnGround[]):
            set Status += "- 位置: 地面\n"
        else if (Vehicle.IsInAir[]):
            set Status += "- 位置: 空中\n"
        else if (Vehicle.IsInWater[]):
            set Status += "- 位置: 水中\n"
        
        # 速度
        set Status += "- 速度: {Vehicle.Speed} km/h\n"
        
        # 燃料
        FuelRemaining := Vehicle.GetFuelRemaining()
        if (FuelRemaining >= 0.0):
            FuelCapacity := Vehicle.GetFuelCapacity()
            FuelPercent := (FuelRemaining / FuelCapacity) * 100.0
            set Status += "- 燃料: {FuelPercent}%\n"
        else:
            set Status += "- 燃料: 无需燃料\n"
        
        # 乘客
        Passengers := Vehicle.GetPassengers()
        PassengerCount := Passengers.Length
        set Status += "- 乘客数: {PassengerCount}\n"
        
        # 加速
        if (MaybeBoost := Vehicle.BoostRemaining?):
            if (MaybeCapacity := Vehicle.BoostCapacity?):
                BoostPercent := (MaybeBoost / MaybeCapacity) * 100.0
                set Status += "- 加速: {BoostPercent}%\n"
        else:
            set Status += "- 加速: 无加速系统\n"
        
        Status
    
    # 检查是否需要维护（燃料或加速不足）
    NeedsMaintenance():logic=
        # 检查燃料
        FuelRemaining := Vehicle.GetFuelRemaining()
        if (FuelRemaining >= 0.0):
            FuelCapacity := Vehicle.GetFuelCapacity()
            if ((FuelRemaining / FuelCapacity) < 0.2):
                return true
        
        # 检查加速
        if (MaybeBoost := Vehicle.BoostRemaining?):
            if (MaybeCapacity := Vehicle.BoostCapacity?):
                if ((MaybeBoost / MaybeCapacity) < 0.3):
                    return true
        
        false
    
    # 传送到目标位置
    TeleportToLocation(TargetPos:vector3, TargetRot:rotation):logic=
        if (Vehicle.TeleportTo[TargetPos, TargetRot]):
            true
        else:
            false

# 使用示例
UseVehicleManager<suspends>(SomeVehicle:fort_vehicle):void=
    Manager := VehicleManager.Init(SomeVehicle)
    
    loop:
        # 打印状态摘要
        StatusText := Manager.GetStatusSummary()
        Print(StatusText)
        
        # 检查是否需要维护
        if (Manager.NeedsMaintenance[]):
            Print("⚠️ 载具需要维护！")
            # 这里可以传送到维修站
        
        Sleep(5.0)
```

**示例说明**：
- 展示了如何封装载具操作到一个管理类中
- 演示了所有主要 API 的综合使用
- 说明了如何构建可复用的载具管理组件

---

## 常见误区澄清

### 误区 1: 认为燃料值 -1.0 表示"燃料耗尽"

❌ **错误理解**：
```verse
if (Vehicle.GetFuelRemaining() = -1.0):
    Print("燃料耗尽，请加油！")
```

✅ **正确理解**：
```verse
FuelRemaining := Vehicle.GetFuelRemaining()
if (FuelRemaining = -1.0):
    Print("此载具不使用燃料系统")
else if (FuelRemaining = 0.0):
    Print("燃料耗尽，请加油！")
```

**说明**：
- `-1.0` 是一个特殊标记值，表示载具**不使用燃料系统**
- 真正的燃料耗尽是 `0.0`
- 这种设计允许同一接口兼容有燃料和无燃料的载具

---

### 误区 2: 认为 IsOnGround、IsInAir、IsInWater 是互斥的

❌ **错误理解**：
```verse
# 错误：假设载具只能处于三种状态之一
if (Vehicle.IsOnGround[]):
    Print("在地面")
else if (Vehicle.IsInAir[]):
    Print("在空中")
else:
    Print("在水中") # 可能不准确
```

✅ **正确理解**：
```verse
# 正确：分别检查每个状态
var State:string = "载具状态: "

if (Vehicle.IsOnGround[]):
    set State += "接触地面 "

if (Vehicle.IsInAir[]):
    set State += "在空中 "

if (Vehicle.IsInWater[]):
    set State += "浸入水中 "

Print(State)
```

**说明**：
- 三个状态检测不是互斥的
- 载具可能同时满足多个条件（如部分浸入水中但仍接触水底）
- 也可能三个条件都不满足（如在特殊区域）

---

### 误区 3: 直接修改 Speed、BoostRemaining 等属性

❌ **错误理解**：
```verse
# 编译错误！属性是只读的
set Vehicle.Speed = 100.0
```

✅ **正确理解**：
```verse
# 这些属性是只读的，只能读取
CurrentSpeed := Vehicle.Speed
Print("当前速度: {CurrentSpeed}")

# 如果需要控制载具速度，需要通过其他方式：
# - 使用载具设备（如 Vehicle Spawner）的配置
# - 通过物理模拟影响（如施加力）
# - 使用游戏逻辑设备（如 Mutator Zone）
```

**说明**：
- `var<private>` 修饰符表示属性是只读的
- 无法从外部直接修改载具的速度、燃料、加速等属性
- 这是为了保持载具状态的一致性和安全性

---

### 误区 4: 忘记处理 TeleportTo 的失败情况

❌ **错误理解**：
```verse
# 危险：没有检查传送是否成功
Vehicle.TeleportTo[TargetPos, TargetRot]
Print("传送完成") # 可能实际上传送失败了
```

✅ **正确理解**：
```verse
if (Vehicle.TeleportTo[TargetPos, TargetRot]):
    Print("✅ 传送成功")
    # 继续后续逻辑
else:
    Print("❌ 传送失败，目标位置可能不可达")
    # 错误处理逻辑
```

**说明**：
- `TeleportTo` 带有 `<decides>` 修饰符，可能失败
- 目标位置在地图外、被阻挡、或无效时会失败
- 必须使用 `if` 表达式检查返回结果

---

### 误区 5: 误用 BoostRemaining 和 BoostCapacity 的可选类型

❌ **错误理解**：
```verse
# 错误：直接使用可选值会导致类型错误
BoostPercent := (Vehicle.BoostRemaining / Vehicle.BoostCapacity) * 100.0
```

✅ **正确理解**：
```verse
# 方法 1: 使用 if-let 解包
if (Boost := Vehicle.BoostRemaining?, Capacity := Vehicle.BoostCapacity?):
    BoostPercent := (Boost / Capacity) * 100.0
    Print("加速剩余: {BoostPercent}%")
else:
    Print("此载具无加速系统")

# 方法 2: 使用 ? 操作符
if (MaybeBoost := Vehicle.BoostRemaining?):
    if (MaybeCapacity := Vehicle.BoostCapacity?):
        BoostPercent := (MaybeBoost / MaybeCapacity) * 100.0
        Print("加速剩余: {BoostPercent}%")
```

**说明**：
- `?float` 是可选类型，不能直接进行算术运算
- 必须先解包（unwrap）才能使用
- `false` 值表示载具不支持加速系统

---

### 误区 6: 认为 GetPassengers() 返回的数组会实时更新

❌ **错误理解**：
```verse
Passengers := Vehicle.GetPassengers()
# ... 过了一段时间 ...
# 错误：假设 Passengers 变量会自动更新
for (Passenger : Passengers):
    # 这里的 Passengers 是旧数据
```

✅ **正确理解**：
```verse
# 方法 1: 每次需要时重新获取
loop:
    Passengers := Vehicle.GetPassengers() # 每次循环都重新获取
    for (Passenger : Passengers):
        # 处理当前乘客
    Sleep(1.0)

# 方法 2: 缓存后显式刷新
var CachedPassengers:[]fort_character = Vehicle.GetPassengers()
# ... 执行一些操作 ...
set CachedPassengers = Vehicle.GetPassengers() # 手动刷新
```

**说明**：
- `GetPassengers()` 返回的是快照，不是引用
- 乘客上下车后，之前获取的数组不会自动更新
- 需要定期重新调用 `GetPassengers()` 以获取最新状态

---

## 最佳实践

### 1. 燃料和加速系统的统一处理模式

**推荐模式**：使用辅助函数封装特殊值检查

```verse
# 检查载具是否使用燃料系统
HasFuelSystem(Vehicle:fort_vehicle):logic=
    Vehicle.GetFuelRemaining() >= 0.0

# 获取燃料百分比（返回可选值）
GetFuelPercentage(Vehicle:fort_vehicle):?float=
    if (HasFuelSystem[Vehicle]):
        FuelRemaining := Vehicle.GetFuelRemaining()
        FuelCapacity := Vehicle.GetFuelCapacity()
        option{(FuelRemaining / FuelCapacity) * 100.0}
    else:
        false

# 检查载具是否使用加速系统
HasBoostSystem(Vehicle:fort_vehicle):logic=
    if (Vehicle.BoostCapacity?):
        true
    else:
        false

# 获取加速百分比（返回可选值）
GetBoostPercentage(Vehicle:fort_vehicle):?float=
    if (Boost := Vehicle.BoostRemaining?, Capacity := Vehicle.BoostCapacity?):
        option{(Boost / Capacity) * 100.0}
    else:
        false
```

**优点**：
- 统一的接口风格
- 避免重复的特殊值检查
- 提高代码可读性和可维护性

---

### 2. 载具状态监控的防抖动模式

**问题**：频繁检查载具状态可能导致性能问题

**推荐模式**：使用事件驱动 + 定时轮询的混合策略

```verse
VehicleStateMonitor := class:
    Vehicle:fort_vehicle
    LastSpeed:float = 0.0
    LastFuelPercent:float = 100.0
    
    # 仅在状态显著变化时触发回调
    MonitorChanges<suspends>(OnSpeedChange:(float)->void, OnFuelChange:(float)->void):void=
        loop:
            # 检查速度变化（变化超过 5 km/h 才触发）
            CurrentSpeed := Vehicle.Speed
            if (Abs[CurrentSpeed - LastSpeed] > 5.0):
                OnSpeedChange(CurrentSpeed)
                set LastSpeed = CurrentSpeed
            
            # 检查燃料变化（变化超过 5% 才触发）
            if (FuelPercent := GetFuelPercentage[Vehicle]?):
                if (Abs[FuelPercent - LastFuelPercent] > 5.0):
                    OnFuelChange(FuelPercent)
                    set LastFuelPercent = FuelPercent
            
            Sleep(0.5)

# 辅助函数：计算绝对值
Abs<private>(Value:float):float=
    if (Value < 0.0) then -Value else Value
```

**优点**：
- 减少不必要的回调触发
- 避免 UI 频繁闪烁
- 提升整体性能

---

### 3. 安全的载具传送模式

**问题**：直接传送可能导致载具卡在物体中或掉出地图

**推荐模式**：验证目标位置 + 失败重试

```verse
SafeTeleport<suspends>(Vehicle:fort_vehicle, TargetPos:vector3, TargetRot:rotation, MaxRetries:int):logic=
    var Retries:int = 0
    
    loop:
        if (Retries >= MaxRetries):
            Print("❌ 传送失败，已达到最大重试次数")
            return false
        
        if (Vehicle.TeleportTo[TargetPos, TargetRot]):
            Print("✅ 传送成功")
            return true
        else:
            Print("⚠️ 传送失败，{MaxRetries - Retries} 次重试机会")
            set Retries += 1
            
            # 等待一段时间后重试（给载具时间稳定）
            Sleep(0.5)
    
    false # 理论上不会到达这里

# 使用示例
UseSafeTeleport<suspends>(Vehicle:fort_vehicle):void=
    TargetPos := vector3{X := 1000.0, Y := 2000.0, Z := 100.0}
    TargetRot := rotation{}
    
    if (SafeTeleport[Vehicle, TargetPos, TargetRot, 3]):
        Print("传送操作完成")
    else:
        Print("传送操作失败，请检查目标位置")
```

**优点**：
- 提供重试机制，提高成功率
- 记录失败日志，便于调试
- 避免一次性失败导致游戏逻辑中断

---

### 4. 乘客管理的事件化模式

**问题**：频繁调用 `GetPassengers()` 检查乘客变化效率低

**推荐模式**：定期检查 + 差异对比

```verse
PassengerChangeTracker := class:
    Vehicle:fort_vehicle
    LastPassengerCount:int = 0
    
    # 检测乘客变化并触发回调
    TrackChanges<suspends>(OnPassengerJoin:(fort_character)->void, OnPassengerLeave:()->void):void=
        loop:
            CurrentPassengers := Vehicle.GetPassengers()
            CurrentCount := CurrentPassengers.Length
            
            if (CurrentCount > LastPassengerCount):
                # 有乘客加入
                Print("🚗 新乘客加入，当前乘客数: {CurrentCount}")
                # 找到新加入的乘客（简化处理：只通知有变化）
                if (CurrentCount > 0):
                    NewPassenger := CurrentPassengers[CurrentCount - 1]
                    OnPassengerJoin(NewPassenger)
            
            else if (CurrentCount < LastPassengerCount):
                # 有乘客离开
                Print("🚪 乘客离开，当前乘客数: {CurrentCount}")
                OnPassengerLeave()
            
            set LastPassengerCount = CurrentCount
            Sleep(0.5)
```

**优点**：
- 将轮询逻辑封装到独立组件
- 使用回调函数解耦业务逻辑
- 减少不必要的数组对比

---

### 5. 载具多态能力的利用

**利用继承接口**：`fort_vehicle` 继承了多个基础接口

```verse
using { /Fortnite.com/Vehicles }
using { /Fortnite.com/Game }

# 利用 positional 接口
GetVehiclePosition(Vehicle:fort_vehicle):vector3=
    # fort_vehicle 继承 positional，可以调用位置相关方法
    Vehicle.GetTransform().Translation

# 利用 healthful 接口
GetVehicleHealth(Vehicle:fort_vehicle):float=
    # fort_vehicle 继承 healthful，可以访问生命值
    Vehicle.GetHealth()

# 利用 damageable 接口
DamageVehicle(Vehicle:fort_vehicle, DamageAmount:float):void=
    # fort_vehicle 继承 damageable，可以造成伤害
    Vehicle.Damage(DamageAmount)

# 利用 game_action_causer 接口
TrackVehicleAction(Vehicle:fort_vehicle):void=
    # fort_vehicle 继承 game_action_causer，可以追踪游戏动作
    # 例如：记录载具摧毁、碰撞等事件
```

**优点**：
- 充分利用接口继承的能力
- 统一处理载具和其他游戏对象
- 避免重复实现通用功能

---

### 6. 性能优化建议

#### 6.1 减少不必要的方法调用

❌ **低效代码**：
```verse
loop:
    if (Vehicle.GetFuelRemaining() >= 0.0):
        FuelPercent := (Vehicle.GetFuelRemaining() / Vehicle.GetFuelCapacity()) * 100.0
        # GetFuelRemaining() 被调用了 2 次，GetFuelCapacity() 被调用了 1 次
    Sleep(1.0)
```

✅ **优化代码**：
```verse
loop:
    FuelRemaining := Vehicle.GetFuelRemaining()
    if (FuelRemaining >= 0.0):
        FuelCapacity := Vehicle.GetFuelCapacity()
        FuelPercent := (FuelRemaining / FuelCapacity) * 100.0
        # 每个方法只调用 1 次
    Sleep(1.0)
```

#### 6.2 批量处理乘客操作

❌ **低效代码**：
```verse
loop:
    for (I := 0..10):
        Passengers := Vehicle.GetPassengers() # 每次循环都调用
        # ...
    Sleep(1.0)
```

✅ **优化代码**：
```verse
loop:
    Passengers := Vehicle.GetPassengers() # 只调用一次
    for (I := 0..10):
        # 使用缓存的 Passengers
    Sleep(1.0)
```

#### 6.3 合理设置 Sleep 间隔

```verse
# 根据需求选择合适的更新频率：
# - UI 更新：0.1 - 0.5 秒
# - 燃料检查：1.0 - 2.0 秒
# - 乘客检查：0.5 - 1.0 秒
# - 状态日志：5.0 - 10.0 秒
```

---

### 7. 与其他模块的配合使用

#### 7.1 与 Characters 模块集成

```verse
using { /Fortnite.com/Vehicles }
using { /Fortnite.com/Characters }

# 从玩家到载具的完整链路
GetPlayerVehicle(Player:player):?fort_vehicle=
    if (Character := Player.GetFortCharacter[]):
        if (Vehicle := Character.GetVehicle[]):
            option{Vehicle}
        else:
            false
    else:
        false
```

#### 7.2 与 SpatialMath 模块集成

```verse
using { /Fortnite.com/Vehicles }
using { /UnrealEngine.com/Temporary/SpatialMath }

# 计算载具前方的位置（用于传送到前方）
CalculateForwardPosition(Vehicle:fort_vehicle, Distance:float):vector3=
    Transform := Vehicle.GetTransform()
    Forward := Transform.Rotation.GetLocalRight() # 获取前方向量
    CurrentPos := Transform.Translation
    # 计算前方位置
    vector3{
        X := CurrentPos.X + Forward.X * Distance,
        Y := CurrentPos.Y + Forward.Y * Distance,
        Z := CurrentPos.Z
    }
```

#### 7.3 与 Game 模块集成

```verse
using { /Fortnite.com/Vehicles }
using { /Fortnite.com/Game }

# 追踪载具造成的伤害（利用 game_action_causer 接口）
TrackVehicleDamage(Vehicle:fort_vehicle):void=
    # fort_vehicle 实现 game_action_causer 接口
    # 可以追踪载具撞击、碾压等造成的伤害
    # 具体实现取决于 Game 模块的 API
```

---

## 常见误区澄清（补充）

### 误区 7: 认为所有载具都有相同的属性

**说明**：
- 不同载具的燃料系统、加速系统支持情况不同
- 某些载具可能有特殊属性（如飞行高度限制）
- 应始终检查可选属性和特殊值

### 误区 8: 忽略 `<transacts>` 修饰符

**说明**：
- 所有 `fort_vehicle` 的方法都标记了 `<transacts>`
- 必须在 `<suspends>` 或 `<transacts>` 上下文中调用
- 不能在纯函数中调用这些方法

---

## 参考资源

### 官方文档

- [UEFN 官方文档 - Vehicles](https://dev.epicgames.com/documentation/en-us/uefn/vehicles-in-uefn)
- [Verse API Reference - Fortnite.com/Vehicles](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference)

### 相关 API 模块

| 模块 | 关联说明 |
|------|----------|
| `/Fortnite.com/Characters` | 提供 `fort_character` 类型，用于 `GetVehicle()` 和 `GetPassengers()` |
| `/UnrealEngine.com/Temporary/SpatialMath` | 提供 `vector3` 和 `rotation` 类型，用于 `TeleportTo()` |
| `/Fortnite.com/Game` | 提供 `game_action_causer` 接口，`fort_vehicle` 继承此接口 |
| `/Verse.org/Simulation` | 提供 `positional` 接口，`fort_vehicle` 继承此接口 |

### 本地参考文件

- `skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md` - 完整的 Fortnite API digest
- `skills/programming/verseDev/shared/references/api-modules-list.md` - API 模块清单
- `skills/programming/verseDev/shared/references/api-modules-research.md` - API 模块能力调研

### 接口继承的基础模块

需要查阅以下接口的详细文档以充分利用 `fort_vehicle` 的能力：

- `positional` - 位置和变换相关方法
- `healthful` - 生命值相关方法
- `damageable` - 伤害系统相关方法
- `game_action_causer` - 游戏动作追踪相关方法

---

## 版本信息

- **文档版本**: 1.0.0
- **API 版本**: ++Fortnite+Release-39.11-CL-49242330
- **创建日期**: 2026-01-04
- **最后更新**: 2026-01-04

---

## 附录：快速参考卡

### 关键方法速查表

| 方法 | 功能 | 返回类型 | 修饰符 |
|------|------|---------|--------|
| `GetVehicle()` | 获取角色的载具 | `fort_vehicle` | `<decides>` |
| `IsOnGround()` | 检测是否在地面 | `void` | `<decides>` |
| `IsInAir()` | 检测是否在空中 | `void` | `<decides>` |
| `IsInWater()` | 检测是否在水中 | `void` | `<decides>` |
| `GetPassengers()` | 获取乘客列表 | `[]fort_character` | - |
| `GetFuelRemaining()` | 获取剩余燃料 | `float` | - |
| `GetFuelCapacity()` | 获取燃料容量 | `float` | - |
| `TeleportTo()` | 传送载具 | `void` | `<decides>` |

### 属性速查表

| 属性 | 类型 | 说明 | 特殊值 |
|------|------|------|--------|
| `Speed` | `float` | 当前速度（km/h） | - |
| `BoostRemaining` | `?float` | 剩余加速能量 | `false` = 无加速系统 |
| `BoostCapacity` | `?float` | 最大加速容量 | `false` = 无加速系统 |

### 特殊值速查表

| 值 | 含义 | 适用属性 |
|----|------|---------|
| `-1.0` | 不使用该系统 | `GetFuelRemaining()`, `GetFuelCapacity()` |
| `false` | 不使用该系统 | `BoostRemaining`, `BoostCapacity` |
| `0.0` | 系统值为空/耗尽 | 燃料、加速能量 |

---

**📝 文档贡献**: 如发现错误或需要补充内容，请提交 Issue 或 PR。
