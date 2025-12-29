---
name: verse-assets
description: 资产层 - Assets.digest解析、资产路径硬编码、占位接口函数机制
version: 1.0.0
layer: 1
---

# Verse Assets

> **类型**: Layer 1 - 资产层  
> **职责**: Assets.digest.verse解析、资产路径生成、占位接口函数（TODO+前置条件）

---

## When to Use This Skill

当需要：
- 解析项目中的 `Assets.digest.verse` 文件
- 生成资产路径的硬编码引用
- 创建占位接口函数（标记TODO）
- 处理美术资产与代码的关联

**输入来源**:
- 上层的 `asset-request` 请求
- 项目的 `Assets.digest.verse` 文件

---

## Assets.digest.verse 说明

### 文件来源

`Assets.digest.verse` 是 UEFN 项目中**自动生成**的文件，包含：
- 项目中所有可用美术资产的反射接口
- 资产的硬编码路径
- 资产类型信息

**位置**: 每个 UEFN 项目的 `Content/` 目录下

### 文件结构示例

```verse
# 自动生成，请勿手动编辑
# 版本: ++Fortnite+Release-39.11

# Mesh资产
MyProject_Mesh_Tree := class<concrete>(mesh_asset):
    # Path: /Game/Assets/Environment/Tree.Tree

MyProject_Mesh_Rock := class<concrete>(mesh_asset):
    # Path: /Game/Assets/Environment/Rock.Rock

# Material资产
MyProject_Material_Wood := class<concrete>(material_asset):
    # Path: /Game/Assets/Materials/Wood.Wood

# 粒子系统
MyProject_Particle_Explosion := class<concrete>(particle_system_asset):
    # Path: /Game/Assets/VFX/Explosion.Explosion

# 音频
MyProject_Audio_Footstep := class<concrete>(audio_asset):
    # Path: /Game/Assets/Audio/Footstep.Footstep
```

### 特点

1. **项目特定**: 每个项目的 Assets.digest 不同
2. **自动更新**: 导入新资产后自动更新
3. **硬编码路径**: 提供编译时检查的资产引用
4. **类型安全**: 每种资产类型有对应的类

---

## 核心职责

### 1. 资产解析

从 `Assets.digest.verse` 中提取可用资产信息：

```verse
# 解析结果结构
asset_info := struct:
    Name:string
    Type:asset_type
    Path:string
    ClassName:string

asset_type := enum:
    Mesh
    Material
    Particle
    Audio
    Texture
    Blueprint
```

### 2. 资产引用生成

为上层提供类型安全的资产引用：

```verse
# 使用 Assets.digest 中的类
SetupTreeMesh(MeshComponent:mesh_component):void =
    # 直接使用生成的类
    MeshComponent.SetMesh(MyProject_Mesh_Tree{})

# 封装为Helper函数
GetTreeMesh():mesh_asset =
    return MyProject_Mesh_Tree{}

GetRockMesh():mesh_asset =
    return MyProject_Mesh_Rock{}
```

### 3. 占位接口函数

当资产尚未导入或路径未确定时，生成占位接口：

```verse
# 占位接口函数
# TODO: 需要先在UEFN编辑器中导入Boss模型资产
# 前置条件: ASSET_REQUIRED
# 预期资产: /Game/Assets/Characters/Boss.Boss
GetBossMesh():mesh_asset =
    # 占位实现，编译会报错提醒
    return placeholder_mesh_asset{}
```

---

## 占位接口机制

### 前置条件标签

| 标签 | 含义 | 处理方式 |
|------|------|----------|
| `ASSET_REQUIRED` | 需要导入美术资产 | 在UEFN编辑器中导入 |
| `API_PENDING` | 等待API更新支持 | 关注版本更新 |
| `EDITOR_CONFIG` | 需要编辑器配置 | 在编辑器中设置 |

### 占位函数模板

```verse
# ============================================
# 占位接口函数
# ============================================

# TODO: [功能描述]
# 前置条件: [标签]
# 预期资产/API: [具体说明]
# 关联Issue: [如有]
# ============================================
FunctionName():ReturnType =
    # 占位实现
    # 实际使用时会编译报错，提醒需要完成前置条件
    return placeholder_value{}
```

### 占位追踪文件

所有占位接口记录到 `@todo-placeholders.md`:

```markdown
# 占位接口追踪

## 待处理占位接口

| ID | 函数名 | 前置条件 | 状态 | 负责人 |
|----|--------|----------|------|--------|
| PH-001 | GetBossMesh | ASSET_REQUIRED | ⬜ 待处理 | - |
| PH-002 | GetPlayerVoice | ASSET_REQUIRED | ⬜ 待处理 | - |
| PH-003 | GetAdvancedAI | API_PENDING | 🔄 等待v40 | - |

## 详细说明

### PH-001: GetBossMesh

**前置条件**: ASSET_REQUIRED
**预期资产**: /Game/Assets/Characters/Boss.Boss
**处理步骤**:
1. 在3D软件中创建Boss模型
2. 导出为FBX格式
3. 在UEFN编辑器中导入
4. 更新 Assets.digest.verse
5. 替换占位实现

**完成后**:
```verse
GetBossMesh():mesh_asset =
    return MyProject_Mesh_Boss{}
```
```

---

## 资产类型映射

### 常用资产类型

| Verse类型 | 资产类型 | 用途 |
|-----------|----------|------|
| `mesh_asset` | 3D模型 | 角色、道具、环境 |
| `material_asset` | 材质 | 表面外观 |
| `particle_system_asset` | 粒子系统 | 特效 |
| `audio_asset` | 音频 | 音效、音乐 |
| `texture_asset` | 纹理 | 贴图 |
| `niagara_system_asset` | Niagara粒子 | 高级特效 |
| `skeletal_mesh_asset` | 骨骼网格 | 动画角色 |
| `animation_asset` | 动画 | 动作序列 |

### 资产获取模式

```verse
# 模式1: 直接使用生成的类
mesh := MyProject_Mesh_Tree{}

# 模式2: 通过封装函数
mesh := AssetManager.GetTreeMesh()

# 模式3: 动态查找（如果支持）
mesh := FindAsset<mesh_asset>("Tree")
```

---

## 资产管理器模式

### 集中管理资产引用

```verse
# 资产管理器组件
asset_manager := class(component):
    # 单例访问
    var Instance<public>:?asset_manager = false
    
    OnAddedToScene<override>()<suspends>:void =
        set Instance = option{Self}
    
    # 环境资产
    GetTreeMesh():mesh_asset = MyProject_Mesh_Tree{}
    GetRockMesh():mesh_asset = MyProject_Mesh_Rock{}
    GetGrassMesh():mesh_asset = MyProject_Mesh_Grass{}
    
    # 角色资产
    GetPlayerMesh():skeletal_mesh_asset = MyProject_Skel_Player{}
    GetEnemyMesh():skeletal_mesh_asset = MyProject_Skel_Enemy{}
    
    # 特效资产
    GetExplosionVFX():particle_system_asset = MyProject_Particle_Explosion{}
    GetHitVFX():particle_system_asset = MyProject_Particle_Hit{}
    
    # 音频资产
    GetFootstepSound():audio_asset = MyProject_Audio_Footstep{}
    GetExplosionSound():audio_asset = MyProject_Audio_Explosion{}

# 使用方式
if (AM := asset_manager.Instance?):
    MeshComp.SetMesh(AM.GetTreeMesh())
```

### 分类管理

```verse
# 按类别拆分资产管理
environment_assets := module:
    GetTree():mesh_asset = MyProject_Mesh_Tree{}
    GetRock():mesh_asset = MyProject_Mesh_Rock{}
    GetWater():material_asset = MyProject_Mat_Water{}

character_assets := module:
    GetPlayer():skeletal_mesh_asset = MyProject_Skel_Player{}
    GetEnemy():skeletal_mesh_asset = MyProject_Skel_Enemy{}

vfx_assets := module:
    GetExplosion():particle_system_asset = MyProject_VFX_Explosion{}
    GetHit():particle_system_asset = MyProject_VFX_Hit{}
```

---

## 与上层交互

### 响应资产请求

```markdown
# 上层请求
verse-helpers → verse-assets: "需要获取Boss模型资产"

# 资产层检查
1. 检查 Assets.digest.verse 中是否存在
2. 存在 → 返回资产引用代码
3. 不存在 → 生成占位接口 + 记录到 @todo-placeholders.md
```

### 返回格式

**资产存在时**:
```verse
# 资产引用: Boss模型
# 路径: /Game/Assets/Characters/Boss.Boss
GetBossMesh():mesh_asset =
    return MyProject_Mesh_Boss{}
```

**资产不存在时**:
```verse
# TODO: 需要导入Boss模型资产
# 前置条件: ASSET_REQUIRED
# 预期路径: /Game/Assets/Characters/Boss.Boss
# 处理步骤: 
#   1. 创建/获取Boss模型
#   2. 在UEFN编辑器中导入
#   3. 更新此函数
GetBossMesh():mesh_asset =
    # 占位 - 编译会提示需要实现
    Print("ERROR: Boss mesh not imported yet!")
    return MyProject_Mesh_Placeholder{}
```

---

## 问题上报模板

```markdown
## Issue Report: AST-001

**Skill**: verse-assets
**层级**: Layer 1
**问题描述**: 资产路径变更后代码需要手动更新
**触发场景**: 美术重命名资产后
**当前处理**: 手动查找并替换
**建议改进**: 在SKILL.md中添加资产重命名处理指南
```

---

## Quick Reference

### 占位标签速查

| 标签 | 何时使用 |
|------|----------|
| `ASSET_REQUIRED` | 美术资产未导入 |
| `API_PENDING` | 等待新版本API |
| `EDITOR_CONFIG` | 需要编辑器配置 |

### 资产类型速查

| 用途 | 类型 |
|------|------|
| 3D模型 | `mesh_asset` |
| 动画模型 | `skeletal_mesh_asset` |
| 材质 | `material_asset` |
| 特效 | `particle_system_asset` |
| 音频 | `audio_asset` |

### 占位接口状态

| 状态 | 图标 | 说明 |
|------|------|------|
| 待处理 | ⬜ | 尚未开始 |
| 进行中 | 🔄 | 正在准备资产 |
| 已完成 | ✅ | 占位已替换 |
| 阻塞 | 🚫 | 需要外部支持 |

---

## Reference Files

- [@todo-placeholders.md](../shared/memory-bank-template/@todo-placeholders.md) - 占位接口追踪
- [Fortnite.digest.verse](../shared/api-digests/Fortnite.digest.verse) - 资产相关API

---

*最后更新: 2025-12-27*
