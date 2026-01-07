# Verse.org/Assets 模块深度调研报告

## 1. 模块概述

### 1.1 模块用途和设计理念

`/Verse.org/Assets` 模块是 UEFN Verse API 中专门用于**资源类型定义**的核心模块。与其名称暗示的"资源管理"不同，该模块实际上是一个**类型定义模块**，提供了 Verse 代码中引用 Unreal Engine 资源的类型系统基础设施。

**核心设计理念**：

- **类型安全**：为编辑器中的资源提供强类型化的 Verse 表示
- **资源引用**：作为编辑器资源与 Verse 代码之间的桥梁
- **只读抽象**：这些类型都是不透明的（opaque），开发者无法直接实例化，只能引用编辑器中配置的资源
- **跨模块协作**：为其他模块（如 Fortnite.com、UnrealEngine.com）提供基础资源类型

### 1.2 适用场景说明

该模块适用于以下场景：

1. **视觉资源配置**：
   - 为设备、道具、角色指定网格（mesh）和材质（material）
   - 配置 UI 图标纹理（texture）

2. **动画系统**：
   - 引用动画序列资源（animation_sequence）
   - 在 `play_animation_controller` 中播放动画

3. **特效系统**：
   - 引用粒子系统资源（particle_system）
   - 通过 `UnrealEngine.com/Assets` 生成粒子效果

4. **音频系统**：
   - 引用音频波形资源（sound_wave）
   - 配合音频设备播放声音

5. **输入系统**：
   - 定义输入动作和映射（input_action、input_mapping）

## 2. 核心类/接口清单

### 2.1 资源类型（按功能分类）

#### 视觉资源类

| 类名 | 用途 | 常见用途 |
|------|------|----------|
| `mesh` | 3D 网格模型 | 设置道具、设备的外观模型 |
| `material` | 材质 | 定义网格的表面外观、纹理、着色器 |
| `texture` | 2D 纹理图像 | UI 图标、贴图 |
| `particle_system` | 粒子特效系统 | 爆炸、烟雾、魔法效果等视觉特效 |

#### 动画资源类

| 类名 | 用途 | 常见用途 |
|------|------|----------|
| `animation_sequence` | 动画序列 | 角色动作、设备动画播放 |

#### 音频资源类

| 类名 | 用途 | 常见用途 |
|------|------|----------|
| `sound_wave` | 音频波形 | 背景音乐、音效 |

#### 输入系统资源类

| 类名 | 用途 | 常见用途 |
|------|------|----------|
| `input_action<t>` | 输入动作（参数化类型） | 定义玩家输入行为 |
| `input_mapping` | 输入映射 | 将硬件输入映射到游戏动作 |

### 2.2 接口

| 接口名 | 用途 | 实现类示例 |
|--------|------|-----------|
| `has_icon` | 提供图标的对象接口 | 自定义设备、道具 |

### 2.3 类型特征总结

**所有资源类的共同特征**：

```verse
<native><public> := class<computes><final><epic_internal>
```

- `<native>`：原生实现，底层由 C++ 支持
- `<computes>`：计算效果（非事务性、非读取性）
- `<final>`：不可被继承（除 mesh 外）
- `<epic_internal>`：内部实现，用户无法访问构造函数

**重要含义**：开发者不能在 Verse 代码中通过 `new` 或构造函数创建这些资源实例，只能通过以下方式获取：

1. 在 UEFN 编辑器中配置为 `@editable` 属性
2. 从编辑器资源选择器中引用
3. 通过设备/组件的 API 返回值获取

## 3. 关键 API 详解

### 3.1 资源类定义（类型签名）

#### mesh（网格）

```verse
mesh<native><public> := class<computes><epic_internal>
```

**用途**：表示 3D 网格模型资源

**获取方式**：
- 通过 `@editable` 属性在编辑器中配置
- 从设备/道具中读取

**常见使用**：
- `creative_prop.SetMesh(Mesh:mesh)`
- `carryable_spawner.SetCarryableMesh(Mesh:mesh)`

**注意事项**：
- `mesh` 类未标记 `<final>`，理论上可扩展（但实际无法直接使用）
- 不同设备对 mesh 的支持程度不同（静态网格 vs 骨骼网格）

#### material（材质）

```verse
material<native><public> := class<epic_internal>
```

**用途**：定义网格表面的视觉外观

**特点**：
- 没有 `<computes>` 和 `<final>` 标记
- 仍然是不透明类型，无法直接实例化

**常见使用**：
- `creative_prop.SetMaterial(Material:material, ?Index:int)`
- `carryable_spawner.SetCarryableMaterial(Material:material, ?Index:int)`

**参数说明**：
- `Material`：要应用的材质资源
- `Index`（可选）：材质索引，用于多材质网格（默认为 0）

**使用限制**：
- 材质索引必须与网格的材质插槽匹配
- 超出范围的索引会被忽略或导致错误

#### texture（纹理）

```verse
texture<native><public> := class<computes><final><epic_internal>
```

**用途**：2D 图像资源，主要用于 UI 和材质贴图

**常见使用**：
- 作为 `has_icon` 接口的 `Icon` 属性类型
- UI 组件的图标显示

**典型用法**：
```verse
var Icon<public>:?texture = external {}
```

#### animation_sequence（动画序列）

```verse
animation_sequence<native><public> := class<computes><final><epic_internal>
```

**用途**：骨骼动画序列资源

**常见使用场景**：
- `play_animation_controller.PlayAndAwait(AnimationSequence:animation_sequence, ...)`
- `play_animation_controller.Play(AnimationSequence:animation_sequence, ...)`

**方法签名示例**：
```verse
PlayAndAwait<public>(
    AnimationSequence:animation_sequence, 
    ?PlayRate:float = external {}, 
    ?PlayCount:float = external {}, 
    ?StartPositionSeconds:float = external {}, 
    ?BlendInTime:float = external {}, 
    ?BlendOutTime:float = external {}
)<suspends>:play_animation_result
```

**参数说明**：
- `AnimationSequence`：要播放的动画资源（必需）
- `PlayRate`：播放速率（1.0 = 正常速度）
- `PlayCount`：播放次数（默认播放一次）
- `StartPositionSeconds`：起始位置（秒）
- `BlendInTime`：淡入时间（秒）
- `BlendOutTime`：淡出时间（秒）

**返回值**：
- `<suspends>`：协程挂起，等待动画完成
- 返回 `play_animation_result` 枚举（`Completed`、`Interrupted`、`Error`）

#### particle_system（粒子系统）

```verse
particle_system<native><public> := class<computes><final><epic_internal>
```

**用途**：粒子特效资源（爆炸、烟雾、火焰等）

**主要使用模块**：`UnrealEngine.com/Assets`

**常见 API**：
```verse
# UnrealEngine.com/Assets 模块
SpawnParticleSystem<native><public>(
    Asset:particle_system, 
    Position:vector3, 
    ?Rotation:rotation = external {}, 
    ?StartDelay:float = external {}
)<transacts>:cancelable
```

**参数说明**：
- `Asset`：粒子系统资源
- `Position`：生成位置（世界坐标）
- `Rotation`：生成旋转（可选）
- `StartDelay`：延迟启动时间（秒，可选）

**返回值**：
- `cancelable` 对象，可调用 `Cancel()` 提前终止粒子效果

**注意事项**：
- 支持两种向量类型：`/UnrealEngine.com/Temporary/SpatialMath:vector3` 和 `/Verse.org/SpatialMath:vector3`
- 粒子系统会自动播放并在完成后销毁

#### sound_wave（音频波形）

```verse
sound_wave<native><public> := class<computes><final><epic_internal>
```

**用途**：音频资源（音效、背景音乐）

**获取方式**：
- 通过音频设备的 `@editable` 属性配置
- 从编辑器资源库中引用

**使用上下文**：
- 配合 Fortnite.com 的音频设备使用
- 通过设备 API 播放和控制

### 3.2 input_action<t>（参数化类型）

```verse
input_action<native><public>(t:type) := class<computes><epic_internal>:
    (/Verse.org/Assets/input_action:)Assets_input_action_Variance<private>:?type {_():tuple(t)} = external {}
```

**特点**：
- **参数化泛型**：`t:type` 表示输入动作可携带特定类型的数据
- **协变类型**：内部包含协变性约束机制

**用途**：
- 定义玩家输入行为的类型化表示
- 与输入系统集成，传递输入数据

**典型使用场景**：
```verse
# 定义一个携带 float 数据的输入动作（如摇杆偏移量）
MyInputAction:input_action(float)

# 定义一个无参数的输入动作（如按钮按下）
ButtonPress:input_action(tuple())
```

### 3.3 input_mapping（输入映射）

```verse
input_mapping<native><public> := class<computes><epic_internal>
```

**用途**：
- 将硬件输入（键盘、手柄、鼠标）映射到游戏内的输入动作
- 配置输入绑定关系

**获取方式**：
- 主要在编辑器中配置
- 通过 Verse 代码引用预定义的映射

### 3.4 has_icon 接口

```verse
has_icon<public> := interface:
    @editable
    var<protected> Icon<public>:texture
```

**用途**：
- 为可视化对象提供图标显示能力
- 常用于设备、道具、UI 元素

**接口要求**：
- 必须提供 `Icon` 属性（可编辑）
- 属性类型为 `texture`

**实现示例**：
```verse
my_custom_device := class(creative_device, has_icon):
    @editable
    var Icon<override>:texture = DefaultIconTexture
```

**访问限制**：
- `Icon` 属性标记为 `<protected>`，外部代码可能无法直接读取
- 主要用于编辑器 UI 显示

## 4. 代码示例

### 示例 1：动态更换道具外观（mesh + material）

**场景**：玩家触发事件后，改变场景中道具的网格和材质

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Assets }

my_prop_changer := class(creative_device):
    # 在编辑器中配置的道具引用
    @editable
    MyProp:creative_prop = creative_prop{}
    
    # 在编辑器中配置的资源
    @editable
    NewMesh:mesh = mesh{}
    
    @editable
    NewMaterial:material = material{}
    
    OnBegin<override>()<suspends>:void =
        # 等待 5 秒后更换外观
        Sleep(5.0)
        
        # 设置新网格
        MyProp.SetMesh(NewMesh)
        
        # 设置新材质（应用到材质插槽 0）
        MyProp.SetMaterial(NewMaterial, Index := 0)
        
        Print("道具外观已更新")
```

**关键点**：
- 资源通过 `@editable` 在编辑器中配置，代码中直接引用
- `SetMesh` 和 `SetMaterial` 会立即更新道具外观
- `Index` 参数用于多材质网格，默认为 0

### 示例 2：播放角色动画序列

**场景**：让 NPC 角色播放特定动画，并在动画完成后执行后续逻辑

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Animation/PlayAnimation }
using { /Verse.org/Assets }
using { /Verse.org/Simulation }

my_animator := class(creative_device):
    @editable
    WaveAnimation:animation_sequence = animation_sequence{}
    
    # 播放挥手动画
    PlayWaveAnimation<public>(Character:fort_character)<suspends>:void =
        # 获取动画控制器
        if (AnimController := Character.GetPlayAnimationController[]):
            # 播放动画并等待完成
            Result := AnimController.PlayAndAwait(
                WaveAnimation,
                PlayRate := 1.0,           # 正常速度
                PlayCount := 1.0,          # 播放一次
                BlendInTime := 0.2,        # 0.2秒淡入
                BlendOutTime := 0.2        # 0.2秒淡出
            )
            
            # 根据结果执行不同逻辑
            case (Result):
                play_animation_result.Completed =>
                    Print("动画播放完成")
                play_animation_result.Interrupted =>
                    Print("动画被打断")
                play_animation_result.Error =>
                    Print("动画播放出错")
```

**关键点**：
- `PlayAndAwait` 是挂起函数（`<suspends>`），会阻塞直到动画完成
- 动画淡入淡出避免突兀切换
- 返回值区分正常完成、被打断、错误三种情况

### 示例 3：生成粒子特效

**场景**：在指定位置生成爆炸粒子效果

```verse
using { /UnrealEngine.com/Assets }
using { /Verse.org/Assets }
using { /Verse.org/SpatialMath }
using { /Verse.org/Simulation }

my_fx_spawner := class(creative_device):
    @editable
    ExplosionEffect:particle_system = particle_system{}
    
    # 生成爆炸特效
    SpawnExplosion<public>(Location:vector3)<transacts>:void =
        # 生成粒子系统（自动播放并销毁）
        ParticleCanceler := SpawnParticleSystem(
            ExplosionEffect,
            Location,
            Rotation := MakeRotationFromYawPitchRoll(0.0, 0.0, 0.0),
            StartDelay := 0.0
        )
        
        # 如果需要提前终止粒子效果：
        # ParticleCanceler.Cancel()
```

**关键点**：
- `SpawnParticleSystem` 来自 `UnrealEngine.com/Assets` 模块
- 粒子系统会自动播放，无需手动启动
- 返回 `cancelable` 对象，可通过 `Cancel()` 提前终止

### 示例 4：设置可携带物的外观

**场景**：配置可拾取物品的网格和材质

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Assets }

my_item_spawner := class(creative_device):
    @editable
    CarryableSpawner:carryable_spawner = carryable_spawner{}
    
    @editable
    CrateMesh:mesh = mesh{}
    
    @editable
    WoodMaterial:material = material{}
    
    @editable
    MetalMaterial:material = material{}
    
    OnBegin<override>()<suspends>:void =
        # 设置可携带物的网格
        CarryableSpawner.SetCarryableMesh(CrateMesh)
        
        # 为不同材质插槽设置材质
        CarryableSpawner.SetCarryableMaterial(WoodMaterial, Index := 0)
        CarryableSpawner.SetCarryableMaterial(MetalMaterial, Index := 1)
        
        Print("可携带物外观已配置")
```

**关键点**：
- `SetCarryableMesh/Material` 会影响未来生成的所有可携带物
- 支持多材质插槽（通过 `Index` 参数）
- 已生成的物品也会立即更新外观

### 示例 5：自定义设备的图标配置

**场景**：为自定义设备提供图标显示

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Assets }

my_custom_device := class(creative_device, has_icon):
    # 实现 has_icon 接口
    @editable
    var Icon<override>:texture = texture{}
    
    # 注意：Icon 主要用于编辑器 UI 显示
    # Verse 代码中通常不直接访问
```

**关键点**：
- `has_icon` 接口要求提供 `Icon` 属性
- 图标主要在编辑器中使用，增强可视化配置体验
- Verse 代码中一般不读取此属性

## 5. 常见误区澄清

### 误区 1：认为 Assets 模块提供资源加载和管理功能

**错误认知**：
"Verse.org/Assets 模块提供了类似 Unity `Resources.Load()` 或 UE4 `LoadObject()` 的动态资源加载能力。"

**正确理解**：
- **Assets 模块只提供类型定义**，不提供资源加载 API
- 所有资源必须在编辑器中预先配置为 `@editable` 属性
- Verse 运行时无法动态加载路径字符串指定的资源

**正确用法**：
```verse
# ✅ 正确：在编辑器中配置资源引用
@editable
MyMesh:mesh = mesh{}

# ❌ 错误：尝试通过路径加载资源（不存在此类 API）
# MyMesh := LoadMesh("/Game/Meshes/MyMesh.uasset")  # 没有这个函数！
```

### 误区 2：认为可以在 Verse 代码中实例化资源类

**错误认知**：
"可以通过构造函数或 `new` 关键字创建 mesh、material 等资源实例。"

**正确理解**：
- 所有资源类都标记为 `<epic_internal>`，无公开构造函数
- 资源实例只能来自：
  1. 编辑器配置的 `@editable` 属性
  2. 设备/组件 API 的返回值
  3. 事件回调的参数

**示例**：
```verse
# ❌ 错误：尝试实例化资源（编译失败）
# MyMesh := mesh()  # 构造函数不可访问！

# ✅ 正确：从编辑器配置获取
@editable
MyMesh:mesh = mesh{}  # mesh{} 是占位语法，实际资源在编辑器中选择
```

### 误区 3：混淆 Verse.org/Assets 和 UnrealEngine.com/Assets

**错误认知**：
"两个 Assets 模块功能相同，可以互换使用。"

**正确理解**：
- **Verse.org/Assets**：基础类型定义模块
- **UnrealEngine.com/Assets**：资源操作模块（如 `SpawnParticleSystem`）

**模块职责**：
| 模块 | 职责 | 典型 API |
|------|------|----------|
| `/Verse.org/Assets` | 定义资源类型 | `mesh`、`material`、`texture` 等 |
| `/UnrealEngine.com/Assets` | 操作资源实例 | `SpawnParticleSystem` |

**正确用法**：
```verse
using { /Verse.org/Assets }           # 引入类型定义
using { /UnrealEngine.com/Assets }   # 引入操作函数

MyEffect:particle_system = particle_system{}  # 类型来自 Verse.org
SpawnParticleSystem(MyEffect, Position)       # 函数来自 UnrealEngine.com
```

### 误区 4：认为 input_action 可以直接触发输入事件

**错误认知**：
"`input_action` 类提供了 `Trigger()` 或 `Fire()` 方法来模拟玩家输入。"

**正确理解**：
- `input_action` 是**类型定义**，不是输入系统的控制器
- 实际输入处理由输入设备和输入组件负责
- `input_action` 主要用于类型化输入数据

**正确用法**：
```verse
# input_action 用于定义输入动作的数据类型
# 实际输入监听需要配合输入设备/组件使用
```

### 误区 5：认为 SetMaterial 的 Index 可以超出网格材质插槽数量

**错误认知**：
"可以通过 `SetMaterial(Material, Index := 10)` 为网格添加新的材质插槽。"

**正确理解**：
- `Index` 参数指向网格现有的材质插槽
- 超出范围的索引会被忽略或导致无操作
- 材质插槽数量由网格资源决定，无法在运行时增加

**正确用法**：
```verse
# ✅ 正确：使用网格已有的材质插槽
Prop.SetMaterial(Material, Index := 0)  # 第一个材质插槽
Prop.SetMaterial(Material, Index := 1)  # 第二个材质插槽

# ❌ 错误：超出范围的索引（假设网格只有 2 个材质插槽）
Prop.SetMaterial(Material, Index := 5)  # 无效操作
```

## 6. 最佳实践

### 6.1 资源配置与引用

**推荐做法**：

1. **集中管理资源引用**：
   ```verse
   # 创建专门的资源管理类
   my_asset_library := class(creative_device):
       @editable var ExplosionFX:particle_system = particle_system{}
       @editable var WoodMesh:mesh = mesh{}
       @editable var StoneMaterial:material = material{}
       @editable var IconTexture:texture = texture{}
   ```

2. **使用描述性命名**：
   ```verse
   # ✅ 好的命名
   @editable PlayerWalkAnimation:animation_sequence = animation_sequence{}
   @editable MetalCrateMesh:mesh = mesh{}
   
   # ❌ 差的命名
   @editable Anim1:animation_sequence = animation_sequence{}
   @editable Mesh:mesh = mesh{}
   ```

3. **分组相关资源**：
   ```verse
   # 按功能分组
   @editable WoodCrateMesh:mesh = mesh{}
   @editable WoodCrateMaterial:material = material{}
   
   @editable MetalCrateMesh:mesh = mesh{}
   @editable MetalCrateMaterial:material = material{}
   ```

### 6.2 动画播放优化

**推荐做法**：

1. **使用 Play 而非 PlayAndAwait 避免阻塞**（当不需要等待完成时）：
   ```verse
   # 场景 1：需要等待动画完成再继续
   Result := AnimController.PlayAndAwait(Animation)
   if (Result = play_animation_result.Completed):
       # 动画完成后的逻辑
   
   # 场景 2：触发即忘（fire-and-forget）
   AnimInstance := AnimController.Play(Animation)
   # 继续执行其他逻辑，无需等待
   ```

2. **配置合理的 BlendTime 避免动画突兀切换**：
   ```verse
   # ✅ 好的做法：平滑过渡
   AnimController.PlayAndAwait(
       NewAnimation,
       BlendInTime := 0.2,   # 200ms 淡入
       BlendOutTime := 0.2   # 200ms 淡出
   )
   
   # ❌ 差的做法：突兀切换
   AnimController.PlayAndAwait(NewAnimation)  # 默认无淡入淡出
   ```

3. **处理动画中断情况**：
   ```verse
   Result := AnimController.PlayAndAwait(LongAnimation)
   case (Result):
       play_animation_result.Completed =>
           Print("动画正常完成")
       play_animation_result.Interrupted =>
           Print("动画被打断，回退到默认状态")
           # 执行回退逻辑
       play_animation_result.Error =>
           Print("动画错误，检查资源配置")
   ```

### 6.3 粒子特效性能优化

**推荐做法**：

1. **及时取消不必要的粒子效果**：
   ```verse
   # 生成粒子并保存取消器
   ParticleCanceler := SpawnParticleSystem(Effect, Position)
   
   # 在特定条件下提前终止
   if (ShouldStopEffect?):
       ParticleCanceler.Cancel()
   ```

2. **使用 StartDelay 优化多个特效的时序**：
   ```verse
   # 按序生成多个特效
   SpawnParticleSystem(Spark1, Pos1, StartDelay := 0.0)
   SpawnParticleSystem(Spark2, Pos2, StartDelay := 0.1)
   SpawnParticleSystem(Smoke, Pos3, StartDelay := 0.5)
   ```

3. **避免短时间内生成大量粒子系统**：
   ```verse
   # ❌ 性能问题：循环生成大量粒子
   for (i := 0..100):
       SpawnParticleSystem(Effect, RandomPosition())
   
   # ✅ 更好的做法：使用单个复杂粒子系统或限制数量
   if (CanSpawnMore[]):
       SpawnParticleSystem(BurstEffect, Position)
   ```

### 6.4 材质和网格动态切换

**推荐做法**：

1. **批量更新外观时先隐藏再显示**：
   ```verse
   # 避免中间状态被玩家看到
   Prop.Hide()
   Prop.SetMesh(NewMesh)
   Prop.SetMaterial(NewMaterial, Index := 0)
   Prop.Show()
   ```

2. **验证资源有效性**（间接验证）：
   ```verse
   # 虽然无法直接验证资源，但可以通过防御性编程减少错误
   if (NewMesh != mesh{}):  # 检查是否为默认值
       Prop.SetMesh(NewMesh)
   ```

3. **多材质网格的索引管理**：
   ```verse
   # 明确定义材质插槽用途
   const WoodSlotIndex:int = 0
   const MetalSlotIndex:int = 1
   
   Prop.SetMaterial(WoodMaterial, Index := WoodSlotIndex)
   Prop.SetMaterial(MetalMaterial, Index := MetalSlotIndex)
   ```

### 6.5 与其他模块的配合使用

**推荐模式**：

1. **Assets + Devices（设备系统）**：
   ```verse
   using { /Verse.org/Assets }
   using { /Fortnite.com/Devices }
   
   # 通过设备控制资源外观
   my_device := class(creative_device):
       @editable TargetProp:creative_prop = creative_prop{}
       @editable AlternateMesh:mesh = mesh{}
       
       OnInteraction()<transacts>:void =
           TargetProp.SetMesh(AlternateMesh)
   ```

2. **Assets + Animation（动画系统）**：
   ```verse
   using { /Verse.org/Assets }
   using { /Fortnite.com/Animation/PlayAnimation }
   
   # 结合角色控制和动画
   my_animator := class(creative_device):
       @editable DanceAnimation:animation_sequence = animation_sequence{}
       
       PlayDance<public>(Character:fort_character)<suspends>:void =
           if (Controller := Character.GetPlayAnimationController[]):
               Controller.PlayAndAwait(DanceAnimation)
   ```

3. **Assets + SceneGraph（场景图系统）**：
   ```verse
   using { /Verse.org/Assets }
   using { /Verse.org/SceneGraph }
   
   # 通过组件系统使用资源
   # （SceneGraph 提供更底层的组件访问）
   ```

4. **Verse.org/Assets + UnrealEngine.com/Assets（双模块协作）**：
   ```verse
   using { /Verse.org/Assets }           # 类型定义
   using { /UnrealEngine.com/Assets }   # 操作函数
   
   my_fx_system := class(creative_device):
       @editable Effect:particle_system = particle_system{}
       
       TriggerEffect<public>(Pos:vector3)<transacts>:void =
           # 类型来自 Verse.org，函数来自 UnrealEngine.com
           SpawnParticleSystem(Effect, Pos)
   ```

## 7. 参考资源

### 7.1 官方文档链接

- [UEFN API 参考文档](https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference)
- [Verse 语言规范](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [UEFN 资源管理指南](https://dev.epicgames.com/documentation/en-us/uefn/asset-management-in-uefn)

### 7.2 相关 API 模块引用

#### 直接依赖模块

- `/Verse.org/Simulation` - Assets 模块的依赖（提供基础模拟类型）

#### 常配合使用的模块

- `/Fortnite.com/Devices` - 设备系统（使用 mesh、material）
- `/Fortnite.com/Animation/PlayAnimation` - 动画系统（使用 animation_sequence）
- `/UnrealEngine.com/Assets` - 资源操作（使用 particle_system）
- `/Verse.org/SceneGraph` - 场景图系统（底层组件系统）

### 7.3 本地参考文档

- [API Digest - Verse](../../../api-digests/Verse.digest.verse.md) - 完整 Verse API 摘要
- [API Digest - Fortnite](../../../api-digests/Fortnite.digest.verse.md) - Fortnite API 摘要（设备使用资源的示例）
- [API Digest - UnrealEngine](../../../api-digests/UnrealEngine.digest.verse.md) - UnrealEngine API 摘要（资源操作函数）
- [API 模块列表](../api-modules-list.md) - 所有 API 模块索引
- [API 模块能力调研报告](../api-modules-research.md) - 模块能力分析

### 7.4 相关技能文档

- `skills/verseDev/verseComponent/SKILL.md` - 组件开发（使用资源）
- `skills/verseDev/verseEventFlow/SKILL.md` - 事件流设计（动画触发）
- `skills/verseDev/verseArchitectureSelector/SKILL.md` - 架构选择（资源管理架构）

---

## 附录：完整 API 签名索引

### A.1 资源类型签名

```verse
# 视觉资源
animation_sequence<native><public> := class<computes><final><epic_internal>
material<native><public> := class<epic_internal>
particle_system<native><public> := class<computes><final><epic_internal>
mesh<native><public> := class<computes><epic_internal>
texture<native><public> := class<computes><final><epic_internal>

# 音频资源
sound_wave<native><public> := class<computes><final><epic_internal>

# 输入资源
input_action<native><public>(t:type) := class<computes><epic_internal>
input_mapping<native><public> := class<computes><epic_internal>
```

### A.2 接口签名

```verse
has_icon<public> := interface:
    @editable
    var<protected> Icon<public>:texture
```

### A.3 模块依赖关系

```verse
Assets<public> := module:
    using {/Verse.org/Simulation}
    # ... 类型定义
```

---

**文档版本**：1.0
**最后更新**：2026-01-04
**API 版本**：Fortnite Release-39.11-CL-49242330
