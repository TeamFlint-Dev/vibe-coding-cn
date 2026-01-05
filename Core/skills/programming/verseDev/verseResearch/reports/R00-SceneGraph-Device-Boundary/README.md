# SceneGraph 独立能力调研报告

> **调研编号**: R00-1
>
> **调研日期**: 2026-01-05
>
> **最新更新**: 2026-01-05 (v2.0 - 采用新心智模型)
>
> **调研目标**: 梳理并验证 SceneGraph 在 UEFN 环境下的能力边界
>
> **核心定义**: **SG能力边界 = Component化边界** 🆕

---

## 🎯 v2.0 重要更新

### 新心智模型

从"SG vs Device 功能分工"转变为"**SG能力边界 = Component化边界**"

**核心判定标准**:
- ✅ **可 Component化** → 优先使用 SceneGraph
- ❌ **不可 Component化** → 必须使用 Device
- ⚙️ **混合架构** → Component 管理逻辑 + Device 提供能力

> 详见 [心智模型迁移指南](./MENTAL-MODEL-MIGRATION.md) 📘

---

## 📚 调研文档索引

### 🆕 核心文档

| 文档 | 说明 | 链接 |
|------|------|------|
| **⭐ 心智模型迁移指南** | v2.0 新模型完整说明 | [MENTAL-MODEL-MIGRATION.md](./MENTAL-MODEL-MIGRATION.md) |
| **能力边界文档 (v2.0)** | Component化判定标准、决策流程 | [CAPABILITY-BOUNDARIES.md](./CAPABILITY-BOUNDARIES.md) |

### 技术详解文档

| 文档 | 说明 | 链接 |
|------|------|------|
| **实体与组件系统** | 实体/组件的创建、管理、生命周期 | [01-entity-component.md](./01-entity-component.md) |
| **事件系统** | 事件定义、传播、接收机制 | [02-event-system.md](./02-event-system.md) |
| **异步机制** | spawn、Sleep、race、sync 用法 | [03-async-mechanisms.md](./03-async-mechanisms.md) |
| **数据结构与追踪** | 数据结构支持、玩家追踪方案 | [04-data-structures.md](./04-data-structures.md) |
| **典型用例** | Component化场景与混合架构案例 | [05-use-cases.md](./05-use-cases.md) |
| **限制与 FAQ** | 已知限制、常见坑点、绕过方案 | [06-limitations-faq.md](./06-limitations-faq.md) |
| **原生 Component 清单** | 所有官方 Component 类型、分类、用途 | [07-native-components.md](./07-native-components.md) |

---

## 🎯 调研要点总结 (v2.0)

### 1. 核心能力边界

**新定义**: **SG能力边界 = Component化边界**

**Component化判定标准** (5项检查):
1. ✅ **可抽象**: 能抽象为通用组件逻辑
2. ✅ **可实例化**: 可运行时动态创建多个实例
3. ✅ **数据驱动**: 行为由参数控制，非硬编码
4. ✅ **可组合**: 可与其他组件组合
5. ✅ **无编辑器依赖**: 不需要编辑器预置资源

**满足 3 项以上** → ✅ 可 Component化（优先使用 SceneGraph）

---

### 2. 典型分类

**✅ 可 Component化（SceneGraph）**:
- 实体与组件管理（创建、销毁、层级化）
- 事件系统（SendUp/Down/Direct）
- 异步流程（spawn、Sleep、race、sync）
- 空间查询（碰撞检测、Overlap）
- 数据结构（array、map、option）
- 状态机、计时器、对象池、事件总线

**❌ 不可 Component化（Device）**:
- 玩家输入（引擎特殊支持）
- UI 显示（编辑器预置 + 引擎渲染）
- 音频播放（资源绑定）
- 游戏规则（全局单例 + 引擎支持）
- 资源动态加载（编辑器预置）

**⚙️ 混合架构**:
- Component 管理状态和逻辑
- Device 提供输入/输出/资源能力
- 事件驱动，编辑器配置

---

### 3. 关键限制

**🔴 发布限制（最重要）**:

- SceneGraph 是 Beta 功能
- **使用 SceneGraph 的项目无法发布到 Fortnite**
- 需等待 Epic 解除限制或发布前禁用

**⚠️ 其他限制**:

- 无法直接获取玩家列表（需通过 Device 事件）
- 无 UI、音频、输入 API
- 无数据持久化（跨会话）
- 性能需注意（OnSimulate 开销、深层嵌套）

### 3. 典型 UseCase (v2.0 视角)

| 场景 | Component化判定 | 架构方案 |
|------|----------------|----------|
| 对象生成系统 | ✅ 可抽象、可实例化 | 纯 SceneGraph (spawner_component) |
| 碰撞检测 | ✅ 可抽象、可组合 | 纯 SceneGraph (collision_component) |
| 状态机 | ✅ 可抽象、数据驱动 | 纯 SceneGraph (state_component) |
| 计时器 | ✅ 可抽象、可组合 | 纯 SceneGraph (timer_component) |
| 事件总线 | ✅ 可抽象、可组合 | 纯 SceneGraph (event_bus_component) |
| **钓鱼系统** | 部分可 Component化 | 混合架构（fishing_component + input/audio/ui_device） |
| **波次生成** | 部分可 Component化 | 混合架构（wave_component + audio/ui_device） |
| 玩家输入 | ❌ 引擎特殊支持 | 纯 Device (input_trigger_device) |
| UI 显示 | ❌ 编辑器预置 | 纯 Device (canvas_device) |
| 音效播放 | ❌ 资源绑定 | 纯 Device (audio_player_device) |

### 4. 最佳实践 (v2.0)

1. **优先 Component化** - 符合标准的功能优先用 SceneGraph
2. **混合架构模式** - Component 持有状态，Device 提供能力
3. **事件驱动** - Component 与 Device 通过事件协作
4. **编辑器配置** - Device 在编辑器中配置，代码中 `@editable` 引用
5. **单一职责** - 每个 Component 只做一件事
6. **Sleep(0.0) 必须** - OnBeginSimulation 第一行必须延迟一帧

---

## 📊 能力矩阵速查

### 能做的事（绿灯区）

| 类别 | 具体能力 | API 支持 |
|------|----------|----------|
| **实体管理** | 创建、销毁、层级化组织 | `entity`, `AddEntities()`, `RemoveFromParent()` |
| **组件系统** | 自定义组件、挂载/卸载、生命周期 | `component`, `AddComponents()`, `GetComponent<T>()` |
| **事件通信** | SendUp/Down/Direct 三种传播 | `SendUp()`, `SendDown()`, `SendDirect()`, `OnReceive()` |
| **异步流程** | spawn、Sleep、race、sync | Verse 语言特性 |
| **空间查询** | 碰撞检测、Overlap、Sweep | `FindOverlapHits()`, `FindSweepHits()` |
| **数据容器** | array、map、option、tuple | Verse 标准库 |

### 不能做的事（红灯区）

| 类别 | 限制说明 | 替代方案 |
|------|----------|----------|
| **发布限制** | ⚠️ 使用 SG 的项目无法发布 | 等待 Epic 解除或发布前禁用 |
| **玩家输入** | 无输入 API | `input_trigger_device` |
| **UI 显示** | 无 UI API | `hud_message_device`, `canvas_device` |
| **音频播放** | 无音频 API | `audio_player_device` |
| **游戏规则** | 无规则 API | `end_game_device`, `score_manager_device` |
| **资源加载** | 无动态加载 | 编辑器预配置或 Device |

---

## 🔍 深度主题

### 实体与组件系统

**关键发现**:

- 实体本质是容器，逻辑应在组件中
- 支持自定义 Entity 类（复杂系统）或纯组件方式（简单对象）
- 生命周期：OnAddedToScene → OnBeginSimulation → OnSimulate → OnDestroy
- RemoveFromParent 会递归销毁所有子实体和组件

**详见**: [01-entity-component.md](./01-entity-component.md)

---

### 事件系统

**关键发现**:

- 三种传播方式：SendUp（子→父）、SendDown（父→子）、SendDirect（点对点）
- 事件消耗机制：同实体内所有组件都收到，跨实体可被消耗
- 自定义事件继承 `scene_event` 并使用 `<concrete>` 标记
- 事件命名规范：动词过去时 + `_event`

**详见**: [02-event-system.md](./02-event-system.md)

---

### 异步机制

**关键发现**:

- Verse 是单线程协程模型，非多线程
- spawn 创建协程，Sleep 延迟执行
- race 竞态执行（首个完成即返回），sync 同步等待（所有完成后返回）
- OnBeginSimulation 第一行必须 `Sleep(0.0)`

**详见**: [03-async-mechanisms.md](./03-async-mechanisms.md)

---

### 数据结构与追踪

**关键发现**:

- 原生支持：array、map、option、tuple
- 不支持：Set（用 map 模拟）、Queue（用 array 模拟）
- 无法直接获取玩家列表，需通过 Device 事件或碰撞检测
- 无数据持久化（跨会话），只支持运行时数据

**详见**: [04-data-structures.md](./04-data-structures.md)

---

### 典型用例

**完全独立实现**:

1. 对象生成系统（Spawner）
2. 碰撞检测系统
3. 状态机系统
4. 计时器系统
5. 事件总线系统

**需要 Device 辅助**:

1. 玩家输入响应
2. UI 显示
3. 音效播放
4. 游戏规则管理

**详见**: [05-use-cases.md](./05-use-cases.md)

---

### 限制与 FAQ

**核心限制**:

1. **发布限制**（最重要）- 无法发布到 Fortnite
2. **玩家管理限制** - 无 `GetPlayers()` API
3. **UI/音频/输入限制** - 需 Device 支持

**常见陷阱**:

1. 忘记 Sleep(0.0)
2. 组件引用失效
3. 协程闭包陷阱
4. 无法停止协程

**详见**: [06-limitations-faq.md](./06-limitations-faq.md)

---

### 原生 Component 类型清单

**完整梳理**:

- **32 个原生组件**分布在 Verse.org、UnrealEngine、Fortnite 三个模块
- **基础组件**：transform、tag、interactable（3 个）
- **渲染组件**：光照、网格、粒子、音效（9 个）
- **物品系统**：库存、物品、拾取（18 个）
- **AI 系统**：NPC、守卫、伙伴（5 个）

**关键发现**:

- ✅ 约 62% 的组件稳定可用
- ⚠️ 12 个组件标记为实验性（`@experimental`）
- 🔒 13 个组件标记为内部使用（`<epic_internal>`）
- 🏗️ 3 个抽象基类组件不可直接实例化

**详见**: [07-native-components.md](./07-native-components.md)

---

## 🚀 推荐开发流程

### 阶段 1: 原型开发

- ✅ 使用 SceneGraph 快速实现核心逻辑
- ✅ 验证游戏玩法和机制
- ✅ 使用 Device 处理玩家交互

### 阶段 2: 测试优化

- ✅ 性能测试（OnSimulate 开销、事件传播）
- ✅ 调试和修复（使用 Print 日志）
- ✅ 优化数据结构和算法

### 阶段 3: 发布准备

#### 选项 A: 迁移到 Device

- 将 SceneGraph 逻辑改为 Device 实现
- 适合需要立即发布的项目

#### 选项 B: 等待 Epic 解除限制

- 保持 SceneGraph 实现
- 关注官方公告

### 阶段 4: 发布后

- 根据玩家反馈优化
- 监控性能和稳定性

---

## 📖 参考文档

### 官方文档

- [SceneGraph 概述](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [SceneGraph 入门指南](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-in-scene-graph-in-fortnite)
- [Scene Events 详解](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [Verse API 主页](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [entity 类 API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)
- [component 类 API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component)

### 内部参考

- [SceneGraph 框架详解](../../shared/references/scenegraph-framework-guide.md)
- [SceneGraph API 参考](../../shared/references/scenegraph-api-reference.md)
- [UEFN 设备系统调研](../../shared/references/uefn-device-system-research.md)

### 社区资源

- [Awesome Verse (GitHub)](https://github.com/spilth/awesome-verse)
- [UEFN Tools](https://uefntools.com/resources)
- [GDC Vault: Inside UEFN SceneGraph](<https://www.gdcvault.com/play/1034900/Inside-UEFN-SceneGraph-(Presented-by>)

---

## 🔄 更新日志

- **2026-01-05 (v2.0)**: 心智模型迁移
  - ⭐ 采用新模型："**SG能力边界 = Component化边界**"
  - 新增: [心智模型迁移指南](./MENTAL-MODEL-MIGRATION.md)
  - 更新: [CAPABILITY-BOUNDARIES.md](./CAPABILITY-BOUNDARIES.md) (v2.0)
    - Component化判定标准（5项检查）
    - 决策流程图
    - 典型案例分析（基于新模型）
    - 混合架构模式详解
  - 更新: 本 README.md 调研要点总结
  - 理由: 对齐 #171 issue 纠偏结论，提供更清晰的决策框架
- **2026-01-05 (v1.0)**: 初始版本发布
  - 完成 7 个核心调研文档
  - 覆盖实体、组件、事件、异步、数据结构、用例、限制
  - 基于官方文档和现有参考资料
  - **补充**: 完成原生 Component 类型完整清单（07-native-components.md）
    - 梳理 32 个官方原生组件
    - 分类：基础（3）、渲染（9）、物品（18）、AI（5）、动画（1）
    - 标注实验性和内部使用状态
    - 提供详细用法和代码示例

---

## 📝 调研方法

1. **官方文档梳理**: 系统阅读 Epic 官方文档
2. **API 分析**: 研究 Verse API 定义和功能
3. **代码示例**: 编写完整的示例代码验证
4. **限制发现**: 通过对比 Device 系统识别边界
5. **最佳实践**: 总结官方推荐和社区经验

---

## ✅ 调研结论

1. **SceneGraph 是强大的逻辑框架**
   - 可独立实现大量游戏逻辑
   - 事件系统和组件化设计优秀

2. **需要 Device 辅助**
   - 玩家交互（输入、UI、音频）必须用 Device
   - 推荐混合架构

3. **发布限制是最大阻碍**
   - 目前无法发布到 Fortnite
   - 适合学习、原型、内部测试

4. **性能需要注意**
   - OnSimulate 每帧调用，避免复杂逻辑
   - SendDown 递归所有子实体，避免频繁使用

5. **最佳实践明确**
   - Sleep(0.0) 必须
   - 组件单一职责
   - 事件解耦通信

---

**调研负责人**: GitHub Copilot Agent
**调研日期**: 2026-01-05
**文档版本**: 1.0
