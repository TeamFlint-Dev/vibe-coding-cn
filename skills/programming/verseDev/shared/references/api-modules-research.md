# UEFN API 模块能力调研报告

## 调研概述

本文档系统性地调研了 UEFN/Verse 开发中涉及的三大 API 命名空间的所有模块，
梳理了各模块的能力分布和覆盖的 UEFN 功能细则。

### 调研范围

- **Fortnite.com**: Fortnite 游戏特有的高级 API
- **Verse.org**: Verse 语言核心 API
- **UnrealEngine.com**: Unreal Engine 底层 API

### 数据来源

- `skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md`
- `skills/programming/verseDev/shared/api-digests/Verse.digest.verse.md`
- `skills/programming/verseDev/shared/api-digests/UnrealEngine.digest.verse.md`

生成版本：++Fortnite+Release-39.11-CL-49242330

## 统计概览

| 命名空间 | 模块数 | 类数量 | 枚举数 |
|---------|-------|--------|-------|
| Fortnite.com | 13 | 1512 | 8 |
| Verse.org | 10 | 3 | 0 |
| UnrealEngine.com | 8 | 5 | 0 |
| **总计** | **31** | **1520** | **8** |

## 模块索引

### Fortnite.com (13 个模块)

- [UI](#ui) - 角色/玩家, 设备系统, 道具/物品, UI/HUD, 空间/坐标
- [Input](#input) - 角色/玩家, 道具/物品, 输入系统, 资源管理
- [Itemization](#itemization) - AI/NPC, 设备系统, 道具/物品, UI/HUD, 游戏逻辑
- [AI](#ai) - AI/NPC, 动画系统, 角色/玩家, 设备系统, UI/HUD
- [Devices](#devices) - AI/NPC, 动画系统, 角色/玩家, 设备系统, 道具/物品
- [Marketplace](#marketplace) - 角色/玩家, 设备系统, 道具/物品, UI/HUD, 游戏逻辑
- [Animation](#animation) - 动画系统, 角色/玩家, 设备系统, 交互系统, 事件系统
- [Characters](#characters) - 角色/玩家, UI/HUD, 空间/坐标, 游戏逻辑, 玩家空间
- [FortPlayerUtilities](#fortplayerutilities) - 角色/玩家, 空间/坐标, 游戏逻辑, 数学计算
- [Game](#game) - 角色/玩家, 道具/物品, 空间/坐标, 游戏逻辑, 载具系统
- [Playspaces](#playspaces) - 角色/玩家, 设备系统, 游戏逻辑, 玩家空间, 团队系统
- [Teams](#teams) - 角色/玩家, 道具/物品, 游戏逻辑, 玩家空间, 团队系统
- [Vehicles](#vehicles) - 角色/玩家, 空间/坐标, 游戏逻辑, 载具系统, 交互系统

### Verse.org (10 个模块)

- [SceneGraph](#scenegraph) - 动画系统, 角色/玩家, 设备系统, 道具/物品, UI/HUD
- [Presentation](#presentation) - UI/HUD
- [Simulation](#simulation) - 角色/玩家, 设备系统, 道具/物品, UI/HUD, 空间/坐标
- [Assets](#assets) - 动画系统, UI/HUD, 输入系统, 音频系统, 视觉效果
- [Verse](#verse) - 动画系统, 角色/玩家, UI/HUD, 游戏逻辑, 交互系统
- [Colors](#colors) - 角色/玩家, 交互系统, 颜色处理
- [SpatialMath](#spatialmath) - UI/HUD, 空间/坐标, 游戏逻辑, 交互系统, 视觉效果
- [Random](#random) - 输入系统, 随机生成
- [Native](#native) - 通用
- [Concurrency](#concurrency) - 事件系统

### UnrealEngine.com (8 个模块)

- [Itemization](#itemization) - 道具/物品, UI/HUD, 空间/坐标, 交互系统, 事件系统
- [WebAPI](#webapi) - 交互系统, Web API
- [SceneGraph](#scenegraph) - 通用
- [Temporary](#temporary) - 角色/玩家, 设备系统, UI/HUD, 空间/坐标, 游戏逻辑
- [JSON](#json) - JSON处理
- [ControlInput](#controlinput) - 角色/玩家, 设备系统, UI/HUD, 交互系统, 事件系统
- [BasicShapes](#basicshapes) - 资源管理
- [Assets](#assets) - 空间/坐标, 视觉效果, 资源管理, 数学计算

---

## Fortnite.com 详细说明

共 **13** 个模块

### UI

**完整路径**: `/Fortnite.com/UI`

**规模统计**:

- 类定义: 39
- 枚举类型: 0
- 代码行数: 220

**涵盖能力**: 角色/玩家, 设备系统, 道具/物品, UI/HUD, 空间/坐标, 游戏逻辑, 玩家空间, 团队系统, 载具系统, 交互系统, 事件系统, 输入系统, 音频系统, 视觉效果, 数学计算, 颜色处理, 物品化

**核心类示例** (共 39 个，展示前 8 个):

- `creative_hud_identifier_all`
- `creative_hud_identifier_build_menu`
- `creative_hud_identifier_crafting_resources`
- `creative_hud_identifier_elimination_counter`
- `creative_hud_identifier_equipped_item`
- `creative_hud_identifier_experience_level`
- `creative_hud_identifier_experience_supercharged`
- `creative_hud_identifier_experience_ui`

### Input

**完整路径**: `/Fortnite.com/Input`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 38

**涵盖能力**: 角色/玩家, 道具/物品, 输入系统, 资源管理

### Itemization

**完整路径**: `/Fortnite.com/Itemization`

**规模统计**:

- 类定义: 1260
- 枚举类型: 0
- 代码行数: 3972

**涵盖能力**: AI/NPC, 设备系统, 道具/物品, UI/HUD, 游戏逻辑, 载具系统, 物品化

**核心类示例** (共 1260 个，展示前 8 个):

- `item_chainsaw`
- `item_dual_micro_smgs_common`
- `item_dual_micro_smgs_epic`
- `item_dual_micro_smgs_legendary`
- `item_dual_micro_smgs_rare`
- `item_dual_micro_smgs_uncommon`
- `item_modular_monarch_pistol_common`
- `item_modular_monarch_pistol_epic`

### AI

**完整路径**: `/Fortnite.com/AI`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 389

**涵盖能力**: AI/NPC, 动画系统, 角色/玩家, 设备系统, UI/HUD, 空间/坐标, 游戏逻辑, 团队系统, 交互系统, 事件系统, 资源管理, 数学计算, 随机生成, Web API

### Devices

**完整路径**: `/Fortnite.com/Devices`

**规模统计**:

- 类定义: 213
- 枚举类型: 8
- 代码行数: 6943

<!-- markdownlint-disable MD013 -->

**涵盖能力**: AI/NPC, 动画系统, 角色/玩家, 设备系统, 道具/物品, UI/HUD, 空间/坐标, 游戏逻辑, 玩家空间,
团队系统, 载具系统, 交互系统, 事件系统, 输入系统, 音频系统, 视觉效果, 资源管理, 数学计算, 随机生成,
并发控制, 颜色处理, Web API, 物品化

**核心类示例** (共 213 个，展示前 8 个):

- `progress_based_mesh_device`: The ThresholdMesh field can be found under the 'Visuals' category on an
  instance of a progress_based_mesh_device in Unreal Editor Fortnite.
- `vote_group_device`: A group can have multiple options, connected via an internal ID.
- `vote_option_device`
- `animated_mesh_device`: Used to select, spawn, and configure a skeletal mesh to play a specific animation.
- `carryable_spawner_device`: Used to spawn a carryable object into the experience.
- `automated_turret_device`: Used to create a customizable turret that can search for nearby targets.
- `post_process_device`: Used to apply Post Process Effects to players through the creative device rather than a
  Post Process Volume.
- `reboot_van_device`: Allow players to bring eliminated teammates back into the game.

<!-- markdownlint-enable MD013 -->

### Marketplace

**完整路径**: `/Fortnite.com/Marketplace`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 127

**涵盖能力**: 角色/玩家, 设备系统, 道具/物品, UI/HUD, 游戏逻辑, 交互系统, 事件系统, 资源管理, 随机生成, Web API

### Animation

**完整路径**: `/Fortnite.com/Animation`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 68

**涵盖能力**: 动画系统, 角色/玩家, 设备系统, 交互系统, 事件系统, 输入系统, 资源管理, Web API

### Characters

**完整路径**: `/Fortnite.com/Characters`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 121

**涵盖能力**: 角色/玩家, UI/HUD, 空间/坐标, 游戏逻辑, 玩家空间, 团队系统, 交互系统, 事件系统, 输入系统, 数学计算

### FortPlayerUtilities

**完整路径**: `/Fortnite.com/FortPlayerUtilities`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 21

**涵盖能力**: 角色/玩家, 空间/坐标, 游戏逻辑, 数学计算

### Game

**完整路径**: `/Fortnite.com/Game`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 157

**涵盖能力**: 角色/玩家, 道具/物品, 空间/坐标, 游戏逻辑, 载具系统, 交互系统, 事件系统, 数学计算

### Playspaces

**完整路径**: `/Fortnite.com/Playspaces`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 32

**涵盖能力**: 角色/玩家, 设备系统, 游戏逻辑, 玩家空间, 团队系统, 交互系统, 事件系统, 输入系统

### Teams

**完整路径**: `/Fortnite.com/Teams`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 47

**涵盖能力**: 角色/玩家, 道具/物品, 游戏逻辑, 玩家空间, 团队系统, 交互系统

### Vehicles

**完整路径**: `/Fortnite.com/Vehicles`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 39

**涵盖能力**: 角色/玩家, 空间/坐标, 游戏逻辑, 载具系统, 交互系统, 数学计算

---

## Verse.org 详细说明

共 **10** 个模块

### SceneGraph

**完整路径**: `/Verse.org/SceneGraph`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 983

**涵盖能力**: 动画系统, 角色/玩家, 设备系统, 道具/物品, UI/HUD, 空间/坐标, 游戏逻辑, 载具系统, 交互系统, 事件系统, 输入系统, 音频系统, 视觉效果, 资源管理, 数学计算, 并发控制, 颜色处理, 物品化

### Presentation

**完整路径**: `/Verse.org/Presentation`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 16

**涵盖能力**: UI/HUD

### Simulation

**完整路径**: `/Verse.org/Simulation`

**规模统计**:

- 类定义: 3
- 枚举类型: 0
- 代码行数: 202

**涵盖能力**: 角色/玩家, 设备系统, 道具/物品, UI/HUD, 空间/坐标, 游戏逻辑, 团队系统, 交互系统, 输入系统, 数学计算, 并发控制, Web API

**核心类示例** (共 3 个，展示前 3 个):

- `editable`
- `editable_text_box`
- `editable_container`

### Assets

**完整路径**: `/Verse.org/Assets`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 24

**涵盖能力**: 动画系统, UI/HUD, 输入系统, 音频系统, 视觉效果, 资源管理

### Verse

**完整路径**: `/Verse.org/Verse`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 435

**涵盖能力**: 动画系统, 角色/玩家, UI/HUD, 游戏逻辑, 交互系统, 事件系统, 输入系统, 视觉效果, 并发控制, 颜色处理

### Colors

**完整路径**: `/Verse.org/Colors`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 402

**涵盖能力**: 角色/玩家, 交互系统, 颜色处理

### SpatialMath

**完整路径**: `/Verse.org/SpatialMath`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 259

**涵盖能力**: UI/HUD, 空间/坐标, 游戏逻辑, 交互系统, 视觉效果, 数学计算

### Random

**完整路径**: `/Verse.org/Random`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 10

**涵盖能力**: 输入系统, 随机生成

### Native

**完整路径**: `/Verse.org/Native`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 10

### Concurrency

**完整路径**: `/Verse.org/Concurrency`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 14

**涵盖能力**: 事件系统

---

## UnrealEngine.com 详细说明

共 **8** 个模块

<!-- markdownlint-disable-next-line MD024 -->
### Itemization

**完整路径**: `/UnrealEngine.com/Itemization`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 296

**涵盖能力**: 道具/物品, UI/HUD, 空间/坐标, 交互系统, 事件系统, 输入系统, 资源管理, 数学计算, 物品化

### WebAPI

**完整路径**: `/UnrealEngine.com/WebAPI`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 24

**涵盖能力**: 交互系统, Web API

<!-- markdownlint-disable-next-line MD024 -->
### SceneGraph

**完整路径**: `/UnrealEngine.com/SceneGraph`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 2

### Temporary

**完整路径**: `/UnrealEngine.com/Temporary`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 957

**涵盖能力**: 角色/玩家, 设备系统, UI/HUD, 空间/坐标, 游戏逻辑, 交互系统, 事件系统, 输入系统, 视觉效果, 资源管理, 数学计算, 颜色处理

### JSON

**完整路径**: `/UnrealEngine.com/JSON`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 23

**涵盖能力**: JSON处理

### ControlInput

**完整路径**: `/UnrealEngine.com/ControlInput`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 59

**涵盖能力**: 角色/玩家, 设备系统, UI/HUD, 交互系统, 事件系统, 输入系统, 资源管理

### BasicShapes

**完整路径**: `/UnrealEngine.com/BasicShapes`

**规模统计**:

- 类定义: 5
- 枚举类型: 0
- 代码行数: 12

**涵盖能力**: 资源管理

**核心类示例** (共 5 个，展示前 5 个):

- `cube`
- `sphere`
- `plane`
- `cone`
- `cylinder`

<!-- markdownlint-disable-next-line MD024 -->
### Assets

**完整路径**: `/UnrealEngine.com/Assets`

**规模统计**:

- 类定义: 0
- 枚举类型: 0
- 代码行数: 7

**涵盖能力**: 空间/坐标, 视觉效果, 资源管理, 数学计算

---

## 能力分布矩阵

<!-- markdownlint-disable MD013 -->

以下表格展示各模块覆盖的主要开发能力：

| 模块 | 能力标签 |
|------|---------|
| UI | `角色/玩家` `设备系统` `道具/物品` `UI/HUD` `空间/坐标` `游戏逻辑` `玩家空间` `团队系统` `载具系统` `交互系统` `事件系统` `输入系统` `音频系统` `视觉效果` `数学计算` `颜色处理` `物品化` |
| Input | `角色/玩家` `道具/物品` `输入系统` `资源管理` |
| Itemization | `AI/NPC` `设备系统` `道具/物品` `UI/HUD` `游戏逻辑` `载具系统` `物品化` |
| AI | `AI/NPC` `动画系统` `角色/玩家` `设备系统` `UI/HUD` `空间/坐标` `游戏逻辑` `团队系统` `交互系统` `事件系统` `资源管理` `数学计算` `随机生成` `Web API` |
| Devices | `AI/NPC` `动画系统` `角色/玩家` `设备系统` `道具/物品` `UI/HUD` `空间/坐标` `游戏逻辑` `玩家空间` `团队系统` `载具系统` `交互系统` `事件系统` `输入系统` `音频系统` `视觉效果` `资源管理` `数学计算` `随机生成` `并发控制` `颜色处理` `Web API` `物品化` |
| Marketplace | `角色/玩家` `设备系统` `道具/物品` `UI/HUD` `游戏逻辑` `交互系统` `事件系统` `资源管理` `随机生成` `Web API` |
| Animation | `动画系统` `角色/玩家` `设备系统` `交互系统` `事件系统` `输入系统` `资源管理` `Web API` |
| Characters | `角色/玩家` `UI/HUD` `空间/坐标` `游戏逻辑` `玩家空间` `团队系统` `交互系统` `事件系统` `输入系统` `数学计算` |
| FortPlayerUtilities | `角色/玩家` `空间/坐标` `游戏逻辑` `数学计算` |
| Game | `角色/玩家` `道具/物品` `空间/坐标` `游戏逻辑` `载具系统` `交互系统` `事件系统` `数学计算` |
| Playspaces | `角色/玩家` `设备系统` `游戏逻辑` `玩家空间` `团队系统` `交互系统` `事件系统` `输入系统` |
| Teams | `角色/玩家` `道具/物品` `游戏逻辑` `玩家空间` `团队系统` `交互系统` |
| Vehicles | `角色/玩家` `空间/坐标` `游戏逻辑` `载具系统` `交互系统` `数学计算` |
| SceneGraph | `动画系统` `角色/玩家` `设备系统` `道具/物品` `UI/HUD` `空间/坐标` `游戏逻辑` `载具系统` `交互系统` `事件系统` `输入系统` `音频系统` `视觉效果` `资源管理` `数学计算` `并发控制` `颜色处理` `物品化` |
| Presentation | `UI/HUD` |
| Simulation | `角色/玩家` `设备系统` `道具/物品` `UI/HUD` `空间/坐标` `游戏逻辑` `团队系统` `交互系统` `输入系统` `数学计算` `并发控制` `Web API` |
| Assets | `动画系统` `UI/HUD` `输入系统` `音频系统` `视觉效果` `资源管理` |
| Verse | `动画系统` `角色/玩家` `UI/HUD` `游戏逻辑` `交互系统` `事件系统` `输入系统` `视觉效果` `并发控制` `颜色处理` |
| Colors | `角色/玩家` `交互系统` `颜色处理` |
| SpatialMath | `UI/HUD` `空间/坐标` `游戏逻辑` `交互系统` `视觉效果` `数学计算` |
| Random | `输入系统` `随机生成` |
| Concurrency | `事件系统` |
| Itemization | `道具/物品` `UI/HUD` `空间/坐标` `交互系统` `事件系统` `输入系统` `资源管理` `数学计算` `物品化` |
| WebAPI | `交互系统` `Web API` |
| Temporary | `角色/玩家` `设备系统` `UI/HUD` `空间/坐标` `游戏逻辑` `交互系统` `事件系统` `输入系统` `视觉效果` `资源管理` `数学计算` `颜色处理` |
| JSON | `JSON处理` |
| ControlInput | `角色/玩家` `设备系统` `UI/HUD` `交互系统` `事件系统` `输入系统` `资源管理` |
| BasicShapes | `资源管理` |
| Assets | `空间/坐标` `视觉效果` `资源管理` `数学计算` |
