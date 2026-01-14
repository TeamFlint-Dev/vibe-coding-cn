# Editable 属性

## 概述

Editable 属性允许开发者在 UEFN 编辑器中直接修改 Verse 设备的参数，无需重新编译代码。这极大提高了迭代速度，使同一个设备可以通过不同的配置实现不同的行为。

**核心优势**：
- **快速迭代** - 无需修改代码即可测试不同配置
- **可复用性** - 同一设备可通过不同属性值实现不同功能
- **简化协作** - 设计师可直接在编辑器中调整参数

## 语法规范

### 基本语法

使用 `@editable` 属性装饰器将变量暴露给编辑器：

```verse
@editable
PropertyName:Type = DefaultValue
```

### 基础示例

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

my_device := class(creative_device):
    
    # 基础整数属性
    @editable
    MaxPlayers:int = 4
    
    # 浮点数属性
    @editable
    RespawnTime:float = 3.0
    
    # 布尔属性
    @editable
    EnablePowerups:logic = true
    
    # 字符串属性
    @editable
    WelcomeMessage:string = "欢迎来到游戏！"
```

## 示例代码

### 最小示例

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

simple_editable_device := class(creative_device):
    
    @editable
    CountdownTime:int = 10
    
    OnBegin<override>()<suspends>:void=
        Print("倒计时时间: {CountdownTime} 秒")
```

### 常见用法 - 设备引用

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

barrier_controller := class(creative_device):
    
    # 引用场景中的障碍物设备
    @editable
    Barrier:barrier_device = barrier_device{}
    
    # 障碍物开关间隔
    @editable
    ToggleInterval:float = 3.0
    
    OnBegin<override>()<suspends>:void=
        loop:
            Barrier.Disable()
            Sleep(ToggleInterval)
            Barrier.Enable()
            Sleep(ToggleInterval)
```

### 高级用法 - 设备数组

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

multi_barrier_controller := class(creative_device):
    
    # 障碍物数组
    @editable
    Barriers:[]barrier_device = array{}
    
    # 每个障碍物的等待时间
    @editable
    WaitTime:float = 2.0
    
    OnBegin<override>()<suspends>:void=
        loop:
            # 依次关闭所有障碍物
            for (Barrier : Barriers):
                Barrier.Disable()
                Sleep(WaitTime)
            
            # 依次开启所有障碍物
            for (Barrier : Barriers):
                Barrier.Enable()
                Sleep(WaitTime)
```

### 高级用法 - 自定义类型

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# 自定义配置类（必须使用 <concrete> 说明符）
barrier_config := class<concrete>():
    
    @editable
    Barriers:[]barrier_device = array{}
    
    @editable
    ToggleSpeed:float = 1.5
    
    # 切换障碍物的方法
    ToggleBarriers()<suspends>:void=
        loop:
            for (Barrier : Barriers):
                Barrier.Disable()
                Sleep(ToggleSpeed)
            for (Barrier : Barriers):
                Barrier.Enable()
                Sleep(ToggleSpeed)

# 使用自定义配置的设备
advanced_barrier_device := class(creative_device):
    
    # 配置数组，每个配置控制一组障碍物
    @editable
    BarrierGroups:[]barrier_config = array{}
    
    OnBegin<override>()<suspends>:void=
        # 为每个配置启动独立的切换任务
        for (Config : BarrierGroups):
            spawn{ Config.ToggleBarriers() }
```

## 常见错误与陷阱

### ❌ 错误 1：忘记初始化默认值

```verse
# ❌ 编译错误：必须提供默认值
@editable
Speed:float
```

**解决方案**：
```verse
# ✅ 正确
@editable
Speed:float = 10.0
```

### ❌ 错误 2：自定义类型缺少 `<concrete>` 说明符

```verse
# ❌ 不会在编辑器中显示
my_config := class():
    @editable
    Value:int = 0
```

**解决方案**：
```verse
# ✅ 正确
my_config := class<concrete>():
    @editable
    Value:int = 0
```

### ❌ 错误 3：在构造时访问编辑器设置的值

```verse
my_device := class(creative_device):
    @editable
    Speed:float = 10.0
    
    # ❌ 此时 Speed 是默认值 10.0，不是编辑器中设置的值
    DoubleSpeed:float = Speed * 2.0
```

**解决方案**：
```verse
my_device := class(creative_device):
    @editable
    Speed:float = 10.0
    
    var<private> DoubleSpeed:float = 0.0
    
    # ✅ 在 OnBegin 中计算，此时编辑器值已加载
    OnBegin<override>()<suspends>:void=
        set DoubleSpeed = Speed * 2.0
```

### ❌ 错误 4：使用不支持的类型

```verse
# ❌ tuple 类型不支持 @editable
@editable
Position:(float, float) = (0.0, 0.0)
```

**解决方案**：使用 `vector2` 或自定义 `struct`：
```verse
# ✅ 使用 vector2
@editable
Position:vector2 = vector2{X := 0.0, Y := 0.0}
```

## 与其他语言对比

| 特性 | Verse @editable | Unity SerializeField | Unreal UPROPERTY |
|------|----------------|---------------------|------------------|
| 语法 | `@editable` | `[SerializeField]` | `UPROPERTY(EditAnywhere)` |
| 数组支持 | ✅ `[]Type` | ✅ `List<T>` | ✅ `TArray<T>` |
| 自定义类 | ✅ `class<concrete>` | ✅ `[System.Serializable]` | ✅ `USTRUCT()` |
| 工具提示 | `ToolTip := Message` | `[Tooltip("...")]` | `UPROPERTY(meta=(ToolTip="..."))` |
| 分类 | `Categories := array{...}` | `[Header("...")]` | `UPROPERTY(Category="...")` |

## 支持的类型列表

### 基础类型

| Verse 类型 | 说明 | 默认值示例 |
|-----------|------|-----------|
| `logic` | 布尔值 | `true` / `false` |
| `int` | 整数 | `0`, `100`, `-5` |
| `float` | 浮点数 | `0.0`, `3.14`, `-1.5` |
| `string` | 字符串 | `"Hello"` |
| `enum` | 枚举 | 枚举成员 |

### 容器类型

| Verse 类型 | 说明 | 默认值示例 |
|-----------|------|-----------|
| `[]T` | 数组 | `array{}` |
| `[K]V` | 映射 | `map{}` |

### 复合类型

| Verse 类型 | 说明 | 要求 |
|-----------|------|------|
| `struct` | 结构体 | 所有字段必须是可编辑类型 |
| `class` | 类实例 | 必须使用 `<concrete>` 说明符 |

### 设备和对象类型

| Verse 类型 | 说明 | 默认值示例 |
|-----------|------|-----------|
| `barrier_device` | 障碍物设备 | `barrier_device{}` |
| `button_device` | 按钮设备 | `button_device{}` |
| `creative_prop` | 场景道具 | `creative_prop{}` |
| 其他设备类型 | 任何 UEFN 设备 | `device_type{}` |

### 特殊编辑器类型

| 装饰器 | 说明 | 适用类型 |
|-------|------|---------|
| `@editable_text_box` | 多行文本框 | `string` |
| `@editable_slider` | 滑块控件 | `int`, `float` |
| `@editable_number` | 数值输入（带范围） | `int`, `float` |
| `@editable_vector_slider` | 向量滑块 | `vector2`, `vector3` |
| `@editable_vector_number` | 向量数值输入 | `vector2`, `vector3` |
| `@editable_container` | 容器配置 | `[]T` |

## 高级特性

### 工具提示和分类

```verse
using { /Verse.org/Simulation }

# 定义可本地化的消息
SpeedCategory<public><localizes>:message = "运动参数"
SpeedTooltip<public><localizes>:message = "控制移动速度（单位：米/秒）"

my_device := class(creative_device):
    
    # 带工具提示和分类的属性
    @editable:
        ToolTip := SpeedTooltip
        Categories := array{SpeedCategory}
    MovementSpeed:float = 5.0
```

**编辑器效果**：
- 鼠标悬停显示工具提示
- 属性按分类组织显示

### 文本框控件

```verse
# 多行文本输入
@editable_text_box:
    MultiLine := true
    MaxLength := 500
Description:string = "在此输入描述..."
```

### 滑块控件

```verse
# 整数滑块（范围 0-100）
@editable_slider(int):
    MinValue := option{0}
    MaxValue := option{100}
    SliderDelta := option{5}
Health:int = 100
```

### 向量滑块

```verse
# 3D 向量滑块（带归一化和比例锁定）
@editable_vector_slider(float):
    ShowPreserveRatio := true
    ShowNormalize := true
    MinComponentValue := option{-10.0}
    MaxComponentValue := option{10.0}
Position:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
```

### 容器配置

```verse
# 禁止拖拽重排序的数组
@editable_container:
    AllowReordering := false
SpawnPoints:[]vector3 = array{}
```

## 编程 Agent 使用指南

### 属性设计原则

1. **明确默认值** - 提供合理的默认值，确保即使不修改也能正常工作
2. **使用分类** - 将相关属性归入同一分类，提升可读性
3. **添加工具提示** - 描述属性的作用、单位和有效范围
4. **验证输入** - 在 `OnBegin` 中验证编辑器输入的合法性

### 属性验证模式

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

validated_device := class(creative_device):
    
    @editable
    Speed:float = 10.0
    
    @editable
    MaxHealth:int = 100
    
    OnBegin<override>()<suspends>:void=
        # 验证数值范围
        if (Speed <= 0.0):
            Print("警告：Speed 必须大于 0，使用默认值 10.0")
            set Speed = 10.0
        
        if (MaxHealth <= 0):
            Print("警告：MaxHealth 必须大于 0，使用默认值 100")
            set MaxHealth = 100
        
        # 继续初始化...
```

### 设备引用检查

```verse
barrier_device := class(creative_device):
    
    @editable
    Barriers:[]barrier_device = array{}
    
    OnBegin<override>()<suspends>:void=
        # 检查数组是否为空
        if (Barriers.Length = 0):
            Print("错误：未配置任何障碍物设备")
            return
        
        Print("已配置 {Barriers.Length} 个障碍物")
        # 继续初始化...
```

### 组织属性的最佳实践

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# 定义分类
GameplayCategory<public><localizes>:message = "游戏玩法"
VisualCategory<public><localizes>:message = "视觉效果"
AudioCategory<public><localizes>:message = "音频设置"

well_organized_device := class(creative_device):
    
    # ═══════════════════════════════════════════
    # 游戏玩法分类
    # ═══════════════════════════════════════════
    
    @editable:
        Categories := array{GameplayCategory}
    RoundDuration:float = 300.0
    
    @editable:
        Categories := array{GameplayCategory}
    MaxPlayers:int = 16
    
    # ═══════════════════════════════════════════
    # 视觉效果分类
    # ═══════════════════════════════════════════
    
    @editable:
        Categories := array{VisualCategory}
    EnableParticles:logic = true
    
    # ═══════════════════════════════════════════
    # 音频设置分类
    # ═══════════════════════════════════════════
    
    @editable:
        Categories := array{AudioCategory}
    BackgroundMusic:logic = true
```

## NPC 和组件中的 Editable

### NPC 行为脚本

```verse
using { /Fortnite.com/AI }
using { /Verse.org/Simulation }

npc_behavior_with_editables := class(npc_behavior):
    
    @editable
    PatrolSpeed:float = 3.0
    
    @editable
    DetectionRange:float = 10.0
    
    OnBegin<override>()<suspends>:void=
        Print("NPC 巡逻速度: {PatrolSpeed}")
```

### Scenegraph 组件

```verse
using { /Verse.org }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SceneGraph }

my_component<public> := class(component):
    
    @editable
    CustomValue:int = 42
    
    @editable
    IsEnabled:logic = true
```

## 调试技巧

### 打印所有编辑器属性

```verse
OnBegin<override>()<suspends>:void=
    Print("═══════════════════════════════")
    Print("设备配置:")
    Print("  Speed: {Speed}")
    Print("  MaxHealth: {MaxHealth}")
    Print("  Barriers: {Barriers.Length} 个")
    Print("═══════════════════════════════")
```

### 运行时修改检测

```verse
my_device := class(creative_device):
    
    @editable
    var<public> DynamicValue:int = 0
    
    OnBegin<override>()<suspends>:void=
        var<private> LastValue:int = DynamicValue
        
        loop:
            if (DynamicValue <> LastValue):
                Print("值已改变: {LastValue} -> {DynamicValue}")
                set LastValue = DynamicValue
            Sleep(1.0)
```

## 参考资源

- [Editable Properties 官方文档](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse)
- [Verse 类型系统](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-types-in-verse)
- [自定义设备教程](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-in-verse)
