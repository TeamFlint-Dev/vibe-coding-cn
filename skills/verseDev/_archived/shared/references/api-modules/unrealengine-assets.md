# UnrealEngine.com/Assets API 模块参考文档

> **文档类型**：API 模块深度调研  
> **模块路径**：`/UnrealEngine.com/Assets`  
> **最后更新**：2026-01-04  
> **API 版本**：++Fortnite+Release-39.11-CL-49242330

---

## 文档说明

本文档深度调研 `/UnrealEngine.com/Assets` 模块，澄清常见误区，为开发者提供准确的 API 能力参考。

**重要提示**：
- ✅ 基于官方 API Digest 文件
- ✅ 提供完整的代码示例和使用场景
- ⚠️ 该模块功能极其精简，仅包含粒子系统相关 API
- ⚠️ 不要与 `/Verse.org/Assets` 混淆

---

## 目录

1. [模块概述](#模块概述)
2. [核心类/接口清单](#核心类接口清单)
3. [关键 API 详解](#关键-api-详解)
4. [代码示例](#代码示例)
5. [常见误区澄清](#常见误区澄清)
6. [最佳实践](#最佳实践)
7. [参考资源](#参考资源)

---

## 模块概述

### 模块用途

`/UnrealEngine.com/Assets` 是一个**非常精简**的模块，专注于提供 Unreal Engine 级别的资源操作 API。目前该模块仅包含粒子系统（Particle System）的生成功能。

### 设计理念

- **底层封装**：提供 Unreal Engine 原生功能的 Verse 封装
- **最小化接口**：仅暴露必要的资源操作 API
- **空间数学集成**：支持新旧两种空间数学 API（Verse.org 和 Temporary）

### 适用场景

1. **视觉效果生成**：
   - 在游戏世界中生成粒子特效
   - 创建环境效果（爆炸、火焰、魔法等）
   - 实现动态视觉反馈

2. **资源管理**：
   - 管理粒子系统资源的生成和生命周期
   - 控制特效的位置和旋转

### 模块依赖

```verse
using {/Verse.org/SpatialMath}
using {/UnrealEngine.com/Temporary/SpatialMath}
using {/Verse.org/Assets}
```

**依赖说明**：
- `/Verse.org/SpatialMath` - 提供现代化的空间数学类型（推荐使用）
- `/UnrealEngine.com/Temporary/SpatialMath` - 提供临时/过渡期的空间数学类型
- `/Verse.org/Assets` - 提供资源类型定义（如 `particle_system`）

---

## 核心类/接口清单

### 类型分类

#### 资源类型（继承自 /Verse.org/Assets）

该模块**不定义**资源类型，而是**使用**来自 `/Verse.org/Assets` 的类型：

| 类型名称 | 定义位置 | 用途 | 特性 |
|---------|---------|------|------|
| `particle_system` | `/Verse.org/Assets` | 粒子系统资源 | `<native><public><computes><final><epic_internal>` |

#### 函数接口

| 函数名称 | 返回类型 | 用途 | 特性 |
|---------|---------|------|------|
| `SpawnParticleSystem` (Temporary) | `cancelable` | 生成粒子系统（旧 API） | `<native><public><transacts>` |
| `SpawnParticleSystem` (Verse) | `cancelable` | 生成粒子系统（新 API） | `<native><public><transacts>` |

---

## 关键 API 详解

### SpawnParticleSystem (使用 Verse.org/SpatialMath)

**功能**：在指定位置和旋转生成粒子系统特效（推荐使用的新 API）

**完整签名**：
```verse
SpawnParticleSystem<native><public>(
    Asset:particle_system, 
    Position:(/Verse.org/SpatialMath:)vector3, 
    ?Rotation:(/Verse.org/SpatialMath:)rotation = external {}, 
    ?StartDelay:float = external {}
)<transacts>:cancelable
```

**参数说明**：

| 参数名 | 类型 | 必需性 | 默认值 | 说明 |
|-------|------|-------|--------|------|
| `Asset` | `particle_system` | ✅ 必需 | - | 要生成的粒子系统资源 |
| `Position` | `vector3` (Verse.org) | ✅ 必需 | - | 世界空间中的生成位置 |
| `Rotation` | `rotation` (Verse.org) | ❌ 可选 | `rotation{}` | 粒子系统的旋转 |
| `StartDelay` | `float` | ❌ 可选 | `0.0` | 延迟启动时间（秒） |

**返回值**：
- **类型**：`cancelable`
- **说明**：可取消的句柄，用于控制粒子效果的生命周期

**使用场景**：
- ✅ 创建新的视觉效果项目（推荐使用）
- ✅ 需要精确控制特效位置和方向
- ✅ 需要延迟播放特效
- ✅ 需要在运行时取消特效

**注意事项**：
- ⚠️ `<transacts>` 特性表示该函数有副作用（修改游戏状态）
- ⚠️ 必须在 `<transacts>` 上下文中调用
- ⚠️ 粒子系统资源必须是有效的 UEFN 资源引用
- ✅ 返回的 `cancelable` 可用于提前终止特效

---

### SpawnParticleSystem (使用 UnrealEngine.com/Temporary/SpatialMath)

**功能**：在指定位置和旋转生成粒子系统特效（旧版/过渡期 API）

**完整签名**：
```verse
SpawnParticleSystem<native><public>(
    Asset:particle_system, 
    Position:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
    ?Rotation:(/UnrealEngine.com/Temporary/SpatialMath:)rotation = external {}, 
    ?StartDelay:float = external {}
)<transacts>:cancelable
```

**参数说明**：

| 参数名 | 类型 | 必需性 | 默认值 | 说明 |
|-------|------|-------|--------|------|
| `Asset` | `particle_system` | ✅ 必需 | - | 要生成的粒子系统资源 |
| `Position` | `vector3` (Temporary) | ✅ 必需 | - | 世界空间中的生成位置 |
| `Rotation` | `rotation` (Temporary) | ❌ 可选 | `rotation{}` | 粒子系统的旋转 |
| `StartDelay` | `float` | ❌ 可选 | `0.0` | 延迟启动时间（秒） |

**返回值**：
- **类型**：`cancelable`
- **说明**：可取消的句柄

**使用场景**：
- ⚠️ 维护旧有代码
- ⚠️ 与使用 Temporary API 的遗留系统集成

**注意事项**：
- ⚠️ **不推荐用于新项目**，应使用 Verse.org/SpatialMath 版本
- ⚠️ Temporary 命名空间表明该 API 可能在未来版本中废弃

---

### cancelable 类型

**定义**：粒子系统生成函数返回的可取消句柄

**用途**：
- 控制特效的生命周期
- 提前终止长时间播放的特效
- 管理资源和性能

**使用方法**：
```verse
# 生成后保存句柄
EffectHandle := SpawnParticleSystem(MyParticle, vector3{X:=0.0, Y:=0.0, Z:=100.0})

# 在需要时取消
EffectHandle.Cancel()
```

---

## 代码示例

### 示例 1：基础粒子特效生成

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Assets }

basic_particle_spawner := class(creative_device):
    # 编辑器中配置的粒子资源
    @editable
    ExplosionParticle:particle_system = particle_system{}
    
    OnBegin<override>()<suspends>:void =
        # 在设备位置生成爆炸特效
        if (Transform := GetTransform[]):
            SpawnParticleSystem(
                ExplosionParticle,
                Transform.Translation
            )
```

**说明**：
- ✅ 使用推荐的 Verse.org 空间数学 API
- ✅ 在设备位置生成单次特效
- ✅ 使用 `@editable` 允许在编辑器中配置资源

---

### 示例 2：带旋转的粒子特效

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Assets }

rotated_particle_spawner := class(creative_device):
    @editable
    DirectionalEffect:particle_system = particle_system{}
    
    SpawnDirectionalEffect(Position:vector3, Direction:vector3):void =
        # 计算朝向目标方向的旋转
        if (TargetRotation := MakeRotationFromXVector(Direction)):
            SpawnParticleSystem(
                DirectionalEffect,
                Position,
                Rotation := TargetRotation
            )
```

**说明**：
- ✅ 使用旋转参数控制特效方向
- ✅ 适用于方向性特效（如喷射、激光等）
- ✅ 展示了可选参数的命名传参方式

---

### 示例 3：延迟播放的粒子特效

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Assets }
using { /Verse.org/Simulation }

delayed_particle_spawner := class(creative_device):
    @editable
    DelayedEffect:particle_system = particle_system{}
    
    @editable
    DelaySeconds:float = 3.0
    
    TriggerDelayedEffect(Position:vector3)<suspends>:void =
        # 生成带延迟的特效
        SpawnParticleSystem(
            DelayedEffect,
            Position,
            StartDelay := DelaySeconds
        )
```

**说明**：
- ✅ 使用 `StartDelay` 参数实现延迟播放
- ✅ 适用于定时触发的视觉效果
- ✅ 延迟在引擎层面实现，无需 Sleep

---

### 示例 4：可取消的持续性特效

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Assets }

cancelable_effect_manager := class(creative_device):
    @editable
    ContinuousEffect:particle_system = particle_system{}
    
    var ActiveEffect:?cancelable = false
    
    StartEffect(Position:vector3):void =
        # 停止旧特效（如果存在）
        if (OldEffect := ActiveEffect?):
            OldEffect.Cancel()
        
        # 启动新特效并保存句柄
        set ActiveEffect = option{SpawnParticleSystem(ContinuousEffect, Position)}
    
    StopEffect():void =
        # 取消当前特效
        if (Effect := ActiveEffect?):
            Effect.Cancel()
            set ActiveEffect = false
```

**说明**：
- ✅ 展示了 `cancelable` 句柄的使用
- ✅ 实现了特效的启动/停止控制
- ✅ 使用 `option` 类型管理可能不存在的句柄
- ✅ 避免内存泄漏（取消旧特效）

---

### 示例 5：多点粒子特效生成

```verse
using { /Verse.org/SpatialMath }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Assets }

multi_point_particle_spawner := class(creative_device):
    @editable
    TrailEffect:particle_system = particle_system{}
    
    SpawnTrailEffect(Points:[]vector3):void =
        # 在多个位置生成粒子轨迹
        for (Point : Points):
            SpawnParticleSystem(
                TrailEffect,
                Point,
                Rotation := rotation{},
                StartDelay := 0.0
            )
    
    # 使用示例
    CreateCircleTrail(Center:vector3, Radius:float, PointCount:int):void =
        var Points:[]vector3 = array{}
        
        for (I := 0..PointCount-1):
            Angle := (I * 360.0 / PointCount) * Pi / 180.0
            X := Center.X + Radius * Cos(Angle)
            Y := Center.Y + Radius * Sin(Angle)
            Z := Center.Z
            
            set Points += array{vector3{X:=X, Y:=Y, Z:=Z}}
        
        SpawnTrailEffect(Points)
```

**说明**：
- ✅ 展示了批量生成粒子特效
- ✅ 实现了圆形轨迹特效
- ✅ 适用于路径追踪、装饰效果等场景

---

## 常见误区澄清

### ❌ 误区 1：该模块包含所有资源管理功能

**错误认知**：
> "UnrealEngine.com/Assets 提供了纹理、网格、音频等所有资源的加载和管理 API"

**正确理解**：
- ✅ 该模块**仅包含粒子系统生成功能**
- ✅ 资源类型定义在 `/Verse.org/Assets` 中
- ✅ 其他资源操作分散在不同模块中

**资源类型实际位置**：

| 资源类型 | 定义位置 | 说明 |
|---------|---------|------|
| `particle_system` | `/Verse.org/Assets` | 粒子系统 |
| `mesh` | `/Verse.org/Assets` | 3D 网格 |
| `material` | `/Verse.org/Assets` | 材质 |
| `texture` | `/Verse.org/Assets` | 纹理 |
| `sound_wave` | `/Verse.org/Assets` | 音频 |
| `animation_sequence` | `/Verse.org/Assets` | 动画序列 |
| `input_action` | `/Verse.org/Assets` | 输入动作 |
| `input_mapping` | `/Verse.org/Assets` | 输入映射 |

---

### ❌ 误区 2：可以动态加载任意资源路径

**错误认知**：
> "可以使用字符串路径动态加载资源：`LoadAsset('/Game/MyParticle')`"

**正确理解**：
- ❌ Verse **不支持**运行时动态资源加载
- ✅ 所有资源必须通过 `@editable` 在编辑器中配置
- ✅ 资源引用在编译时确定

**正确做法**：
```verse
my_device := class(creative_device):
    # ✅ 正确：编辑器中配置
    @editable
    MyParticle:particle_system = particle_system{}
    
    # ❌ 错误：无法动态加载
    # LoadParticleFromPath(Path:string):particle_system = ...
```

---

### ❌ 误区 3：SpawnParticleSystem 返回粒子系统对象

**错误认知**：
> "可以通过返回值访问粒子系统的属性和方法"

**正确理解**：
- ❌ 返回值是 `cancelable`，不是粒子系统对象
- ✅ `cancelable` 仅用于取消操作
- ❌ 无法获取粒子系统的播放状态、位置等信息

**限制说明**：
```verse
# ✅ 正确用法
ParticleHandle := SpawnParticleSystem(MyParticle, Position)
ParticleHandle.Cancel()  # 取消特效

# ❌ 错误用法（不存在的 API）
# ParticleHandle.GetPosition()
# ParticleHandle.IsPlaying()
# ParticleHandle.SetColor(Red)
```

---

### ❌ 误区 4：两个 SpawnParticleSystem 重载功能不同

**错误认知**：
> "Temporary 版本是旧功能，Verse 版本有新增能力"

**正确理解**：
- ✅ 两个版本**功能完全相同**
- ✅ 唯一区别是空间数学类型的命名空间
- ✅ 推荐使用 Verse.org 版本（未来标准）

**对比**：

| 特性 | Temporary 版本 | Verse 版本 |
|------|---------------|-----------|
| 功能 | ✅ 完全相同 | ✅ 完全相同 |
| 参数 | ✅ 完全相同 | ✅ 完全相同 |
| 返回值 | ✅ 完全相同 | ✅ 完全相同 |
| 空间类型 | `Temporary/SpatialMath` | `Verse.org/SpatialMath` |
| 推荐度 | ⚠️ 过渡期使用 | ✅ 推荐使用 |

---

### ❌ 误区 5：可以修改已生成粒子系统的属性

**错误认知**：
> "生成后可以修改粒子系统的位置、缩放、颜色等"

**正确理解**：
- ❌ 一旦生成，**无法修改**粒子系统属性
- ✅ 只能通过 `Cancel()` 取消
- ✅ 需要改变效果时，必须取消旧的，生成新的

**实现动态效果的正确方式**：
```verse
# ❌ 错误：试图修改已有特效
var MyEffect:cancelable = SpawnParticleSystem(Particle, Pos1)
# MyEffect.SetPosition(Pos2)  # 不存在的 API

# ✅ 正确：取消并重新生成
var MyEffect:?cancelable = option{SpawnParticleSystem(Particle, Pos1)}

# 需要改变位置时
if (OldEffect := MyEffect?):
    OldEffect.Cancel()
set MyEffect = option{SpawnParticleSystem(Particle, Pos2)}
```

---

## 最佳实践

### 1. 资源配置

**推荐做法**：
```verse
particle_spawner := class(creative_device):
    # ✅ 使用 @editable 允许设计师配置
    @editable
    ExplosionEffect:particle_system = particle_system{}
    
    @editable
    HitEffect:particle_system = particle_system{}
    
    # ✅ 提供清晰的资源分类
    @editable
    EnvironmentalEffects:[]particle_system = array{}
```

**避免**：
- ❌ 硬编码资源引用（Verse 不支持）
- ❌ 使用模糊的变量名（如 `Particle1`, `Particle2`）

---

### 2. 生命周期管理

**推荐做法**：
```verse
effect_manager := class(creative_device):
    var ActiveEffects:[]cancelable = array{}
    
    SpawnManagedEffect(Particle:particle_system, Position:vector3):void =
        # ✅ 保存句柄以便后续管理
        NewEffect := SpawnParticleSystem(Particle, Position)
        set ActiveEffects += array{NewEffect}
    
    CleanupAllEffects():void =
        # ✅ 清理所有特效
        for (Effect : ActiveEffects):
            Effect.Cancel()
        set ActiveEffects = array{}
```

**避免**：
- ❌ 忽略返回的 `cancelable` 句柄
- ❌ 不清理长时间运行的特效（可能影响性能）

---

### 3. 空间数学 API 选择

**推荐做法**：
```verse
# ✅ 使用 Verse.org/SpatialMath（推荐）
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Assets }

modern_spawner := class(creative_device):
    SpawnEffect(Position:vector3):void =
        SpawnParticleSystem(MyParticle, Position)
```

**避免**：
```verse
# ⚠️ 避免使用 Temporary API（除非维护旧代码）
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Assets }
```

---

### 4. 性能优化

**推荐做法**：
```verse
optimized_spawner := class(creative_device):
    var LastSpawnTime:float = 0.0
    MinSpawnInterval:float = 0.1  # 最小生成间隔
    
    SpawnWithThrottle(Particle:particle_system, Position:vector3)<suspends>:void =
        CurrentTime := GetSimulationElapsedTime()
        
        # ✅ 限制生成频率
        if (CurrentTime - LastSpawnTime >= MinSpawnInterval):
            SpawnParticleSystem(Particle, Position)
            set LastSpawnTime = CurrentTime
```

**性能建议**：
- ✅ 限制同时存在的粒子系统数量
- ✅ 及时取消不再需要的特效
- ✅ 避免在高频循环中生成特效
- ✅ 使用 `StartDelay` 分散生成时机

---

### 5. 错误处理

**推荐做法**：
```verse
safe_spawner := class(creative_device):
    @editable
    SafeParticle:particle_system = particle_system{}
    
    TrySpawnEffect(Position:vector3):void =
        # ✅ 验证资源有效性（通过类型系统保证）
        # particle_system 类型已确保资源存在
        
        # ✅ 在 transacts 上下文中调用
        SpawnParticleSystem(SafeParticle, Position)
```

**注意**：
- ⚠️ `SpawnParticleSystem` 不会失败（没有 `<decides>`）
- ⚠️ 必须在 `<transacts>` 上下文中调用
- ✅ 资源有效性由编辑器和类型系统保证

---

### 6. 与其他模块配合

**示例：与 SceneGraph 配合**：
```verse
using { /Verse.org/SceneGraph }
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Assets }

scenegraph_particle_spawner := class(component):
    @editable
    AttachedEffect:particle_system = particle_system{}
    
    OnAddedToScene<override>()<suspends>:void =
        # ✅ 在实体位置生成特效
        if (Owner := GetOwner[]):
            if (Transform := Owner.GetComponent[transform_component]()):
                if (WorldTransform := Transform.GetWorldTransform()):
                    SpawnParticleSystem(
                        AttachedEffect,
                        WorldTransform.Translation,
                        Rotation := WorldTransform.Rotation
                    )
```

**示例：与设备事件配合**：
```verse
event_driven_spawner := class(creative_device):
    @editable
    TriggerEffect:particle_system = particle_system{}
    
    OnBegin<override>()<suspends>:void =
        # ✅ 监听游戏事件并生成特效
        PlayerEliminatedEvent.Subscribe(OnPlayerEliminated)
    
    OnPlayerEliminated(Result:elimination_result):void =
        if (EliminatedChar := Result.EliminatedCharacter):
            if (Transform := EliminatedChar.GetTransform[]):
                SpawnParticleSystem(
                    TriggerEffect,
                    Transform.Translation
                )
```

---

## 参考资源

### 官方文档

| 资源 | 链接 | 说明 |
|------|------|------|
| Verse API Reference | [Epic Developer Portal](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api) | 官方 API 文档 |
| UnrealEngine.com/Assets | API Digest 文件 | 本地：`skills/verseDev/shared/api-digests/UnrealEngine.digest.verse.md` (行 1384-1391) |
| Verse.org/Assets | API Digest 文件 | 本地：`skills/verseDev/shared/api-digests/Verse.digest.verse.md` (行 1209-1233) |

### 相关 API 模块

| 模块 | 路径 | 关系 |
|------|------|------|
| Verse.org/Assets | `/Verse.org/Assets` | 提供资源类型定义（`particle_system`, `mesh`, `texture` 等） |
| Verse.org/SpatialMath | `/Verse.org/SpatialMath` | 提供现代空间数学类型（推荐） |
| UnrealEngine.com/Temporary/SpatialMath | `/UnrealEngine.com/Temporary/SpatialMath` | 提供过渡期空间数学类型 |
| Verse.org/SceneGraph | `/Verse.org/SceneGraph` | 场景图系统，常与粒子特效配合使用 |

### 内部文档

| 文档 | 路径 | 说明 |
|------|------|------|
| API 模块清单 | `skills/verseDev/shared/references/api-modules-list.md` | 所有模块索引 |
| API 模块能力调研 | `skills/verseDev/shared/references/api-modules-research.md` | 模块能力矩阵 |
| SceneGraph API 参考 | `skills/verseDev/shared/references/scenegraph-api-reference.md` | SceneGraph 详细文档 |

---

## 总结

### 核心要点

1. **极简模块**：`/UnrealEngine.com/Assets` 仅包含粒子系统生成功能
2. **双版本 API**：提供 Temporary 和 Verse 两个空间数学版本，推荐使用后者
3. **有限控制**：只能生成和取消，无法修改已生成特效的属性
4. **编辑器配置**：资源必须通过 `@editable` 在编辑器中配置，不支持动态加载
5. **依赖关系**：资源类型定义在 `/Verse.org/Assets`，本模块仅提供操作 API

### 适用场景总结

| 场景 | 适用性 | 说明 |
|------|-------|------|
| 视觉特效生成 | ✅ 完全适用 | 核心功能 |
| 资源加载管理 | ❌ 不适用 | 资源必须预配置 |
| 特效属性修改 | ❌ 不适用 | 只能取消重建 |
| 网格/纹理/音频 | ❌ 不适用 | 无相关 API |

### 未来展望

- 该模块可能会添加更多资源操作 API
- `Temporary` 命名空间的 API 可能在未来版本中移除
- 建议持续关注官方文档更新

---

**文档版本**：v1.0  
**贡献者**：GitHub Copilot  
**审核状态**：待审核
