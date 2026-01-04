# UEFN API 模块清单

本文档提供所有 API 模块的快速索引，用于指导后续调研任务。

## 完整模块列表 (按命名空间分类)

### Fortnite.com (13 个模块)

| 序号 | 模块名 | 导入路径 | 主要功能领域 |
|------|--------|----------|-------------|
| 1 | UI | `/Fortnite.com/UI` | UI界面、HUD元素控制 |
| 2 | Input | `/Fortnite.com/Input` | 输入系统 |
| 3 | Itemization | `/Fortnite.com/Itemization` | 物品化系统（1260+类） |
| 4 | AI | `/Fortnite.com/AI` | AI/NPC控制 |
| 5 | Devices | `/Fortnite.com/Devices` | 设备系统（213+类） |
| 6 | Marketplace | `/Fortnite.com/Marketplace` | 市场系统 |
| 7 | Animation | `/Fortnite.com/Animation` | 动画系统 |
| 8 | Characters | `/Fortnite.com/Characters` | 角色系统 |
| 9 | FortPlayerUtilities | `/Fortnite.com/FortPlayerUtilities` | 玩家工具函数 |
| 10 | Game | `/Fortnite.com/Game` | 游戏逻辑 |
| 11 | Playspaces | `/Fortnite.com/Playspaces` | 玩家空间 |
| 12 | Teams | `/Fortnite.com/Teams` | 团队系统 |
| 13 | Vehicles | `/Fortnite.com/Vehicles` | 载具系统 |

### Verse.org (10 个模块)

| 序号 | 模块名 | 导入路径 | 主要功能领域 |
|------|--------|----------|-------------|
| 1 | SceneGraph | `/Verse.org/SceneGraph` | 场景图、组件系统 |
| 2 | Presentation | `/Verse.org/Presentation` | 展示层 |
| 3 | Simulation | `/Verse.org/Simulation` | 模拟系统 |
| 4 | Assets | `/Verse.org/Assets` | 资源管理 |
| 5 | Verse | `/Verse.org/Verse` | Verse核心 |
| 6 | Colors | `/Verse.org/Colors` | 颜色处理 |
| 7 | SpatialMath | `/Verse.org/SpatialMath` | 空间数学 |
| 8 | Random | `/Verse.org/Random` | 随机数生成 |
| 9 | Native | `/Verse.org/Native` | 原生功能 |
| 10 | Concurrency | `/Verse.org/Concurrency` | 并发控制 |

### UnrealEngine.com (8 个模块)

| 序号 | 模块名 | 导入路径 | 主要功能领域 |
|------|--------|----------|-------------|
| 1 | Itemization | `/UnrealEngine.com/Itemization` | 物品化系统 |
| 2 | WebAPI | `/UnrealEngine.com/WebAPI` | Web API |
| 3 | SceneGraph | `/UnrealEngine.com/SceneGraph` | 场景图 |
| 4 | Temporary | `/UnrealEngine.com/Temporary` | 临时/过渡API |
| 5 | JSON | `/UnrealEngine.com/JSON` | JSON处理 |
| 6 | ControlInput | `/UnrealEngine.com/ControlInput` | 控制输入 |
| 7 | BasicShapes | `/UnrealEngine.com/BasicShapes` | 基础形状 |
| 8 | Assets | `/UnrealEngine.com/Assets` | 资源管理 |

## 统计总览

- **总模块数**: 31
- **总类数量**: 1520+
- **总枚举数**: 8

## 按功能分类的模块映射

### AI 与 NPC

- Fortnite.com/AI
- Fortnite.com/Devices (部分)

### 角色与玩家

- Fortnite.com/Characters
- Fortnite.com/FortPlayerUtilities

### UI 与界面

- Fortnite.com/UI
- Verse.org/Presentation

### 物品与装备

- Fortnite.com/Itemization
- UnrealEngine.com/Itemization

### 设备与交互

- Fortnite.com/Devices

### 动画系统

- Fortnite.com/Animation

### 游戏逻辑

- Fortnite.com/Game
- Fortnite.com/Playspaces
- Fortnite.com/Teams

### 空间与数学

- Verse.org/SpatialMath
- Verse.org/SceneGraph
- UnrealEngine.com/SceneGraph

### 输入系统

- Fortnite.com/Input
- UnrealEngine.com/ControlInput

### 资源管理

- Verse.org/Assets
- UnrealEngine.com/Assets
- UnrealEngine.com/BasicShapes

### 工具类

- Verse.org/Colors
- Verse.org/Random
- Verse.org/Concurrency
- UnrealEngine.com/JSON
- UnrealEngine.com/WebAPI

## 使用说明

1. **后续深度调研**: 针对每个模块，可进一步调研其详细API、使用示例和最佳实践
2. **能力索引**: 参考 `api-modules-research.md` 获取每个模块的详细能力分析
3. **代码参考**: 查看 `Core/skills/programming/verseDev/shared/api-digests/` 下的完整 API digest 文件

## 相关文档

- [API 模块能力调研报告](./api-modules-research.md) - 完整的能力分析报告
- [SceneGraph API 参考](./scenegraph-api-reference.md) - SceneGraph 框架详细说明
- [SceneGraph 框架指南](./scenegraph-framework-guide.md) - SceneGraph 使用指南
