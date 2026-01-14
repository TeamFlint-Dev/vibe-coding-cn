# creative_device 生命周期

## 概述

`creative_device` 是 Verse 中创建自定义设备的基类。所有自定义 Verse 设备都必须继承自 `creative_device`，并通过重写其生命周期方法来实现自定义逻辑。

设备的生命周期由两个核心方法控制：
- **`OnBegin()`** - 游戏体验开始时调用
- **`OnEnd()`** - 游戏体验结束时调用

## 语法规范

### 基本设备结构

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# 自定义设备类，继承自 creative_device
my_custom_device := class(creative_device):
    
    # 游戏开始时执行
    OnBegin<override>()<suspends>:void=
        # 初始化逻辑
        
    # 游戏结束时执行
    OnEnd<override>()<transacts>:void=
        # 清理逻辑
```

### OnBegin 方法签名

```verse
OnBegin<public><native_callable>()<transacts><suspends><no_rollback>:void
```

**效果说明**：
- `<transacts>` - 可回滚，允许写入 `var` 变量
- `<suspends>` - 异步函数，可以使用 `Sleep()`、`await` 等异步操作
- `<no_rollback>` - 默认效果，表示操作不可撤销

### OnEnd 方法签名

```verse
OnEnd<public><native_callable>()<transacts><no_rollback>:void
```

**效果说明**：
- `<transacts>` - 可回滚，允许写入 `var` 变量
- **不支持 `<suspends>`** - 同步函数，不能使用异步操作
- ⚠️ **警告**：`OnEnd` 内部使用 `spawn{}` 创建的协程可能永远不会执行

## 示例代码

### 最小示例

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

simple_device := class(creative_device):
    
    OnBegin<override>()<suspends>:void=
        Print("设备已启动")
```

### 常见用法

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

game_manager_device := class(creative_device):
    
    var<private> GameStarted:logic = false
    
    # 游戏开始时初始化
    OnBegin<override>()<suspends>:void=
        Print("游戏管理器启动中...")
        
        # 初始化游戏状态
        set GameStarted = true
        
        # 等待 3 秒后开始游戏
        Sleep(3.0)
        Print("游戏开始！")
        
        # 启动游戏循环
        spawn{ GameLoop() }
    
    # 游戏循环（异步执行）
    GameLoop()<suspends>:void=
        loop:
            if (GameStarted):
                # 游戏逻辑
                Sleep(1.0)
            else:
                break
    
    # 游戏结束时清理
    OnEnd<override>()<transacts>:void=
        Print("游戏管理器关闭")
        set GameStarted = false
        # ⚠️ 不要在这里使用 spawn{}，可能不会执行
```

### 高级用法 - 设备间通信

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# 主控制器设备
main_controller := class(creative_device):
    
    @editable
    TargetDevice:barrier_device = barrier_device{}
    
    OnBegin<override>()<suspends>:void=
        Print("主控制器初始化")
        
        # 等待其他设备准备就绪
        Sleep(1.0)
        
        # 控制障碍物设备
        TargetDevice.Enable()
        Sleep(2.0)
        TargetDevice.Disable()
```

## 常见错误与陷阱

### ❌ 错误 1：在 OnEnd 中使用异步操作

```verse
OnEnd<override>()<transacts>:void=
    Sleep(1.0)  # ❌ 编译错误：OnEnd 不支持 <suspends> 效果
```

**解决方案**：
- 不要在 `OnEnd` 中使用 `Sleep()`、`await` 等异步操作
- 只进行同步清理（设置变量、打印日志等）

### ❌ 错误 2：依赖 OnEnd 中的 spawn 协程

```verse
OnEnd<override>()<transacts>:void=
    spawn{ SaveGameData() }  # ⚠️ 可能永远不会执行
```

**解决方案**：
- 在 `OnBegin` 中启动一个监听游戏结束事件的协程
- 使用 `game_state` 等其他机制处理游戏结束逻辑

### ❌ 错误 3：忘记添加 `<override>` 说明符

```verse
OnBegin()<suspends>:void=  # ❌ 不会被调用
    Print("这不会执行")
```

**解决方案**：
```verse
OnBegin<override>()<suspends>:void=  # ✅ 正确
    Print("这会执行")
```

### ❌ 错误 4：在设备实例化后立即访问编辑器属性

```verse
my_device := class(creative_device):
    @editable
    Speed:float = 10.0
    
    # ❌ 构造函数中无法访问编辑器设置的值
    InitialSpeed:float = Speed  # 这里的 Speed 是默认值 10.0，不是编辑器中设置的值
```

**解决方案**：
- 在 `OnBegin()` 中访问 `@editable` 属性，此时编辑器的值已加载

## 与其他语言对比

| 特性 | Verse creative_device | Unity MonoBehaviour | Unreal C++ Actor |
|------|----------------------|---------------------|------------------|
| 初始化方法 | `OnBegin()` | `Start()` | `BeginPlay()` |
| 清理方法 | `OnEnd()` | `OnDestroy()` | `EndPlay()` |
| 异步支持 | `<suspends>` 效果 | Coroutine | AsyncTask |
| 编辑器属性 | `@editable` | `[SerializeField]` | `UPROPERTY(EditAnywhere)` |
| 生命周期控制 | 游戏体验开始/结束 | 对象创建/销毁 | Actor 生成/销毁 |

## 编程 Agent 使用指南

### 创建设备的标准流程

1. **继承 creative_device**
   ```verse
   my_device := class(creative_device):
   ```

2. **定义编辑器属性（如需要）**
   ```verse
   @editable
   Property:int = 0
   ```

3. **重写 OnBegin 进行初始化**
   ```verse
   OnBegin<override>()<suspends>:void=
       # 初始化代码
   ```

4. **重写 OnEnd 进行清理（可选）**
   ```verse
   OnEnd<override>()<transacts>:void=
       # 同步清理代码
   ```

### 生命周期时序图

```
游戏启动
    ↓
所有设备实例化
    ↓
编辑器属性注入
    ↓
OnBegin() 调用（可异步）
    ↓
游戏运行中
    ↓
游戏结束信号
    ↓
OnEnd() 调用（同步，协程可能不执行）
    ↓
设备销毁
```

### 最佳实践

1. **初始化顺序依赖**：如果设备 A 依赖设备 B，在 `OnBegin` 中使用 `Sleep()` 延迟初始化

2. **异步任务管理**：在 `OnBegin` 中使用 `spawn{}` 启动长期运行的任务
   ```verse
   OnBegin<override>()<suspends>:void=
       spawn{ GameLoop() }
       spawn{ MonitorPlayers() }
   ```

3. **状态管理**：使用 `var` 变量跟踪设备状态，在 `OnEnd` 中重置
   ```verse
   var<private> IsActive:logic = false
   
   OnBegin<override>()<suspends>:void=
       set IsActive = true
   
   OnEnd<override>()<transacts>:void=
       set IsActive = false
   ```

4. **错误处理**：使用 `if` 语句检查 `option` 类型，避免运行时失败
   ```verse
   OnBegin<override>()<suspends>:void=
       if (Player := GetFirstPlayer[]):
           # 安全操作
       else:
           Print("未找到玩家")
   ```

### 调试技巧

1. **打印生命周期事件**
   ```verse
   OnBegin<override>()<suspends>:void=
       Print("设备 {GetType()} 已启动")
   
   OnEnd<override>()<transacts>:void=
       Print("设备 {GetType()} 已关闭")
   ```

2. **验证属性注入**
   ```verse
   OnBegin<override>()<suspends>:void=
       Print("编辑器属性值: {EditableProperty}")
   ```

3. **追踪异步任务**
   ```verse
   OnBegin<override>()<suspends>:void=
       spawn:
           Print("异步任务启动")
           AsyncWork()
           Print("异步任务完成")
   ```

## 参考资源

- [creative_device API 文档](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device)
- [创建自定义设备教程](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-in-verse)
- [Verse 效果系统参考](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse)
