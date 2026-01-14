# UEFN API 约定

## 概述

UEFN（Unreal Editor for Fortnite）为 Verse 提供了丰富的原生 API，涵盖游戏设备、玩家管理、空间运算、UI 系统等多个模块。理解这些 API 的组织结构和命名约定，是高效开发 Verse 游戏的基础。

**API 三大来源**：
1. **Fortnite.com** - Fortnite 专属设备和游戏机制
2. **Verse.org** - Verse 核心语言和仿真框架
3. **UnrealEngine.com** - Unreal Engine 底层功能

## 语法规范

### Using 声明模式

```verse
# Fortnite 设备 API
using { /Fortnite.com/Devices }

# Fortnite 游戏机制
using { /Fortnite.com/Game }

# Fortnite 角色和玩家
using { /Fortnite.com/Characters }

# Verse 仿真核心
using { /Verse.org/Simulation }

# Verse 数学库
using { /Verse.org/SpatialMath }

# Unreal Engine 临时 API
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SceneGraph }
```

### 命名约定

| 约定类型 | 格式 | 示例 |
|---------|------|------|
| 类名 | snake_case | `creative_device`, `button_device` |
| 函数名 | PascalCase | `OnBegin()`, `Enable()`, `GetPlayers()` |
| 变量名 | PascalCase | `MaxHealth`, `Speed` |
| 模块名 | PascalCase | `/Fortnite.com/Devices` |
| 常量 | PascalCase | `DefaultSpeed` |

## 示例代码

### 最小示例 - 使用设备 API

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

simple_barrier_controller := class(creative_device):
    
    @editable
    Barrier:barrier_device = barrier_device{}
    
    OnBegin<override>()<suspends>:void=
        # 控制障碍物设备
        Barrier.Enable()
        Sleep(3.0)
        Barrier.Disable()
```

### 常见用法 - 玩家管理

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

player_manager := class(creative_device):
    
    OnBegin<override>()<suspends>:void=
        # 获取游戏空间
        GameSpace := GetPlayspace()
        
        # 监听玩家添加事件
        GameSpace.PlayerAddedEvent().Subscribe(OnPlayerAdded)
        
        # 获取当前所有玩家
        AllPlayers := GameSpace.GetPlayers()
        Print("当前玩家数: {AllPlayers.Length}")
    
    # 玩家加入时触发
    OnPlayerAdded(Player:player):void=
        Print("玩家 {Player} 已加入游戏")
        
        # 获取玩家角色
        if (FortCharacter := Player.GetFortCharacter[]):
            Print("玩家角色已就绪")
```

### 高级用法 - 空间数学

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }

spatial_calculator := class(creative_device):
    
    OnBegin<override>()<suspends>:void=
        # 创建向量
        Position := vector3{X := 100.0, Y := 200.0, Z := 50.0}
        Direction := vector3{X := 1.0, Y := 0.0, Z := 0.0}
        
        # 向量运算
        NewPosition := Position + Direction * 10.0
        
        # 计算距离
        Distance := Distance(Position, NewPosition)
        Print("移动距离: {Distance}")
        
        # 归一化向量
        NormalizedDir := Normalize(Direction)
        
        # 旋转计算
        Rotation := MakeRotationFromZ(Direction)
```

### 高级用法 - UI 系统

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }

ui_manager := class(creative_device):
    
    OnBegin<override>()<suspends>:void=
        # 创建 UI 控件
        MyCanvas := canvas:
            Slots := array:
                canvas_slot:
                    Widget := text_block:
                        DefaultText := "欢迎来到游戏！"
                        DefaultTextColor := color{R := 1.0, G := 1.0, B := 1.0}
        
        # 显示 UI 给所有玩家
        GameSpace := GetPlayspace()
        AllPlayers := GameSpace.GetPlayers()
        
        for (Player : AllPlayers):
            if (PlayerUI := GetPlayerUI[Player]):
                PlayerUI.AddWidget(MyCanvas)
```

## 常见错误与陷阱

### ❌ 错误 1：使用错误的模块路径

```verse
# ❌ 错误的路径
using { /Fortnite/Devices }
using { /Verse/Simulation }
```

**解决方案**：
```verse
# ✅ 正确的路径
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
```

### ❌ 错误 2：混淆 PascalCase 和 snake_case

```verse
# ❌ 类名使用 PascalCase
MyDevice := class(CreativeDevice):  # CreativeDevice 应为 creative_device

# ❌ 函数名使用 snake_case
on_begin()<suspends>:void=  # 应为 OnBegin
```

**解决方案**：
```verse
# ✅ 类名使用 snake_case
my_device := class(creative_device):

# ✅ 函数名使用 PascalCase
OnBegin<override>()<suspends>:void=
```

### ❌ 错误 3：忘记处理 option 类型

```verse
# ❌ 直接使用可能失败的函数返回值
Player := GetFirstPlayer()  # 返回 ?player，可能失败
Player.Eliminate()  # 编译错误
```

**解决方案**：
```verse
# ✅ 使用 if 语句检查
if (Player := GetFirstPlayer[]):
    Player.Eliminate()
else:
    Print("未找到玩家")
```

### ❌ 错误 4：使用已弃用的 API

```verse
# ❌ 使用 Temporary 命名空间的 API 可能在未来版本中移除
using { /UnrealEngine.com/Temporary/Diagnostics }
```

**解决方案**：
- 关注官方文档的更新
- 准备好迁移到稳定 API
- 在注释中标注使用临时 API 的原因

## 与其他语言对比

| 概念 | Verse | C++ (Unreal) | C# (Unity) |
|------|-------|--------------|------------|
| 命名空间 | `using { /Module }` | `#include "Header.h"` | `using Namespace;` |
| 类继承 | `class(base_class)` | `class : public Base` | `class : Base` |
| 函数重写 | `<override>` | `override` | `override` |
| 空值处理 | `?type`, `if (X := F[])` | `TOptional<T>` | `T?`, `if (x != null)` |
| 异步 | `<suspends>` | `async`, `FAsyncTask` | `async`, `Coroutine` |

## 核心 API 模块导航

### Fortnite.com/Devices

提供所有 UEFN 设备的 Verse 接口。

**常用设备**：
```verse
using { /Fortnite.com/Devices }

# 基础设备
creative_device          # 自定义设备基类
creative_prop            # 场景道具

# 交互设备
button_device            # 按钮
switch_device            # 开关
trigger_device           # 触发器

# 障碍和区域
barrier_device           # 障碍物
damage_volume_device     # 伤害区域
mutator_zone_device      # 突变区

# 生成器
item_spawner_device      # 物品生成器
player_spawner_device    # 玩家出生点
npc_spawner_device       # NPC 生成器

# 游戏逻辑
score_manager_device     # 分数管理
timer_device             # 计时器
end_game_device          # 游戏结束

# UI 和通知
hud_message_device       # HUD 消息
popup_dialog_device      # 弹窗对话框
```

**示例 - 按钮控制障碍物**：
```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

button_barrier_controller := class(creative_device):
    
    @editable
    Button:button_device = button_device{}
    
    @editable
    Barrier:barrier_device = barrier_device{}
    
    OnBegin<override>()<suspends>:void=
        Button.InteractedWithEvent.Subscribe(OnButtonPressed)
    
    OnButtonPressed(Agent:agent):void=
        Barrier.Toggle()
```

### Fortnite.com/Game

游戏核心机制和玩家管理。

**核心 API**：
```verse
using { /Fortnite.com/Game }

# 获取游戏空间
GetPlayspace():playspace

# playspace 接口
playspace.GetPlayers():[]player                    # 获取所有玩家
playspace.PlayerAddedEvent():subscribable(player)  # 玩家加入事件
playspace.PlayerRemovedEvent():subscribable(player)# 玩家离开事件
```

**示例 - 监听玩家事件**：
```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

player_monitor := class(creative_device):
    
    OnBegin<override>()<suspends>:void=
        GameSpace := GetPlayspace()
        GameSpace.PlayerAddedEvent().Subscribe(OnPlayerJoined)
        GameSpace.PlayerRemovedEvent().Subscribe(OnPlayerLeft)
    
    OnPlayerJoined(Player:player):void=
        Print("玩家加入")
    
    OnPlayerLeft(Player:player):void=
        Print("玩家离开")
```

### Fortnite.com/Characters

角色控制和状态管理。

**核心 API**：
```verse
using { /Fortnite.com/Characters }

# player 接口
player.GetFortCharacter():?fort_character       # 获取角色
player.Eliminate():void                         # 淘汰玩家

# fort_character 接口
fort_character.GetAgent():agent                 # 获取代理
fort_character.EliminatedEvent():subscribable(elimination_result)
```

**示例 - 角色操作**：
```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }

character_controller := class(creative_device):
    
    OnBegin<override>()<suspends>:void=
        GameSpace := GetPlayspace()
        AllPlayers := GameSpace.GetPlayers()
        
        for (Player : AllPlayers):
            if (FortChar := Player.GetFortCharacter[]):
                # 监听角色淘汰事件
                FortChar.EliminatedEvent().Subscribe(OnCharacterEliminated)
    
    OnCharacterEliminated(Result:elimination_result):void=
        # 处理淘汰逻辑
        Print("角色被淘汰")
```

### Verse.org/Simulation

Verse 仿真框架核心。

**核心 API**：
```verse
using { /Verse.org/Simulation }

# 时间控制
Sleep(Seconds:float):void                       # 异步等待
GetSimulationTime():float                       # 获取仿真时间

# 并发
spawn{ Expression }                             # 启动协程
race{ Branch1 | Branch2 }                       # 竞态执行
sync{ Task1, Task2 }                            # 同步等待

# 事件
subscribable(T).Subscribe(Handler:T->void):void # 订阅事件
```

**示例 - 时间和并发**：
```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

timer_example := class(creative_device):
    
    OnBegin<override>()<suspends>:void=
        # 启动多个并发任务
        spawn{ Task1() }
        spawn{ Task2() }
        
        # 等待一段时间
        Sleep(5.0)
        Print("5 秒已过")
    
    Task1()<suspends>:void=
        loop:
            Print("任务 1 运行中")
            Sleep(1.0)
    
    Task2()<suspends>:void=
        loop:
            Print("任务 2 运行中")
            Sleep(2.0)
```

### Verse.org/SpatialMath

空间数学和向量运算。

**核心类型**：
```verse
using { /Verse.org/SpatialMath }

# 向量
vector2{X:float, Y:float}
vector3{X:float, Y:float, Z:float}

# 旋转
rotation{...}
transform{...}
```

**常用函数**：
```verse
# 向量运算
Normalize(V:vector3):vector3                    # 归一化
Distance(A:vector3, B:vector3):float            # 距离
DotProduct(A:vector3, B:vector3):float          # 点积
CrossProduct(A:vector3, B:vector3):vector3      # 叉积

# 旋转
MakeRotationFromX(Direction:vector3):rotation
MakeRotationFromY(Direction:vector3):rotation
MakeRotationFromZ(Direction:vector3):rotation
```

**示例 - 位置计算**：
```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }

position_calculator := class(creative_device):
    
    OnBegin<override>()<suspends>:void=
        StartPos := vector3{X := 0.0, Y := 0.0, Z := 0.0}
        EndPos := vector3{X := 100.0, Y := 50.0, Z := 0.0}
        
        # 计算方向和距离
        Direction := EndPos - StartPos
        Dist := Distance(StartPos, EndPos)
        
        Print("距离: {Dist} 厘米")
        
        # 归一化方向
        NormalizedDir := Normalize(Direction)
        Print("归一化方向: X={NormalizedDir.X}, Y={NormalizedDir.Y}")
```

### UnrealEngine.com/Temporary

临时 API，可能在未来版本中变更。

**常用模块**：
```verse
# 诊断输出
using { /UnrealEngine.com/Temporary/Diagnostics }
Print(Message:string):void                      # 打印到日志

# 场景图
using { /UnrealEngine.com/Temporary/SceneGraph }
component                                        # 组件基类

# UI
using { /UnrealEngine.com/Temporary/UI }
canvas, text_block, button, etc.                # UI 控件
```

## 编程 Agent 使用指南

### API 查找策略

1. **按功能分类查找**
   - 设备控制 → `/Fortnite.com/Devices`
   - 玩家管理 → `/Fortnite.com/Game`, `/Fortnite.com/Characters`
   - 数学运算 → `/Verse.org/SpatialMath`
   - 时间和并发 → `/Verse.org/Simulation`

2. **使用 IDE 自动完成**
   - 输入 `using { /` 查看可用模块
   - 输入类型名后按 `.` 查看成员

3. **查阅官方文档**
   - [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
   - [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference)

### 常用代码模式

**模式 1：设备初始化**
```verse
OnBegin<override>()<suspends>:void=
    # 1. 订阅事件
    Device.Event.Subscribe(Handler)
    
    # 2. 初始化状态
    Device.Enable()
    
    # 3. 启动循环任务
    spawn{ UpdateLoop() }
```

**模式 2：玩家事件处理**
```verse
OnBegin<override>()<suspends>:void=
    GameSpace := GetPlayspace()
    GameSpace.PlayerAddedEvent().Subscribe(OnPlayerAdded)
    
    # 处理已存在的玩家
    for (Player : GameSpace.GetPlayers()):
        OnPlayerAdded(Player)
```

**模式 3：设备间通信**
```verse
@editable
TargetDevices:[]barrier_device = array{}

OnBegin<override>()<suspends>:void=
    for (Device : TargetDevices):
        Device.Enable()
```

### 调试和日志

```verse
using { /UnrealEngine.com/Temporary/Diagnostics }

# 基础打印
Print("调试信息")

# 格式化输出
Print("玩家数: {PlayerCount}")

# 变量检查
Print("Position: X={Pos.X}, Y={Pos.Y}, Z={Pos.Z}")

# 条件日志
if (DebugMode):
    Print("调试模式已启用")
```

### 性能优化建议

1. **避免在循环中频繁分配对象**
   ```verse
   # ❌ 不推荐
   loop:
       NewArray := array{1, 2, 3}
       Sleep(0.1)
   
   # ✅ 推荐
   PreAllocatedArray := array{1, 2, 3}
   loop:
       # 使用预分配的数组
       Sleep(0.1)
   ```

2. **使用 spawn 避免阻塞主流程**
   ```verse
   OnBegin<override>()<suspends>:void=
       spawn{ LongRunningTask() }  # 不阻塞 OnBegin
       # 继续其他初始化
   ```

3. **合理使用 Sleep 避免死循环**
   ```verse
   # ❌ 不推荐 - CPU 密集
   loop:
       CheckCondition()
   
   # ✅ 推荐 - 每秒检查一次
   loop:
       CheckCondition()
       Sleep(1.0)
   ```

## 参考资源

- [Verse API 完整文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [Verse 语言参考](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-reference)
- [UEFN 快速入门](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite)
- [Verse 编程学习](https://dev.epicgames.com/documentation/en-us/fortnite/learn-programming-with-verse-in-unreal-editor-for-fortnite)
