# 技术栈

> **项目名称**：岛屿养成游戏  
> **最后更新**：2025-12-25

---

## 开发平台

| 属性 | 选择 | 理由 |
|------|------|------|
| **引擎/平台** | UEFN (Unreal Editor for Fortnite) | 目标发布到 Fortnite Creative |
| **编程语言** | Verse | UEFN 原生语言，功能表达式编程 |
| **目标平台** | Fortnite Creative | 跨平台支持，玩家基础大 |

---

## 架构模式

### 核心架构

| 模式 | 说明 |
|------|------|
| **架构类型** | SceneGraph（实体-组件-事件） |
| **通信方式** | Scene Events（SendUp/SendDown/SendDirect） |
| **数据流向** | 单向数据流，事件驱动状态变更 |

### ⚠️ 重要约束

> **优先使用 SceneGraph，CreativeDevice 仅作兜底**
> 
> SceneGraph 是 UEFN 推荐的新架构，CreativeDevice 正在被逐步取代。
> 仅在 SceneGraph 无法实现的功能时使用 CreativeDevice。

### 架构图

```
simulation_entity (根)
│
├── game_manager_entity              # 全局管理器
│   ├── economy_component            # 经济系统（货币管理）
│   ├── save_manager_component       # 存档系统
│   └── game_state_component         # 游戏状态
│
├── player_manager_entity            # 玩家管理
│   └── (管理所有玩家基地实体)
│
├── player_base_entity (每玩家)      # 玩家基地
│   ├── display_system_component     # 展示系统
│   ├── income_generator_component   # 收入生成器
│   ├── inventory_component          # 背包
│   └── display_slot_entity[12]      # 展示槽位
│       └── slot_component
│
├── main_island_entity               # 主岛
│   ├── fishing_zone_entity          # 钓鱼区域
│   │   └── fishing_component
│   └── portal_hub_entity            # 传送门中心
│       └── portal_entity[]
│
└── theme_island_entity[]            # 主题岛（后续扩展）
    └── forest_island_entity
        ├── mining_zone_component
        └── random_spawn_component
```

---

## 技术选型

### SceneGraph 核心 API

| API | 用途 | 文档 |
|-----|------|------|
| `entity` | 场景节点容器 | [entity API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity) |
| `component` | 行为和数据封装 | [component API](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-verse-component-in-unreal-editor-for-fortnite) |
| `scene_event` | 组件间通信 | [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite) |

### 数据存储

| 方案 | 用途 |
|------|------|
| Player Persistent Data | 玩家存档（货币、背包、进度） |
| 运行时变量 | 临时状态 |

---

## 技术约束

### 平台限制

- **SceneGraph Beta**：SceneGraph 目前为 Beta 功能，发布前需检查兼容性
- **Verse 限制**：不支持某些复杂数据结构，需使用 Verse 原生类型
- **网络同步**：多人场景需考虑数据同步

### 性能目标

| 指标 | 目标值 | 说明 |
|------|--------|------|
| 帧率 | 60 FPS | 保持流畅体验 |
| 收益计算 | < 1ms | 每秒收益计算不能阻塞主线程 |

---

## 开发规范

### 代码风格

- **命名约定**：
  - 类/Entity：`snake_case_entity`
  - Component：`snake_case_component`
  - 事件：`snake_case_event`
  - 变量：`PascalCase`
  - 常量：`UPPER_SNAKE_CASE`

- **文件组织**：
  ```
  Verse/
  ├── Entities/           # 实体定义
  ├── Components/         # 组件定义
  ├── Events/             # 事件定义
  ├── Data/               # 数据结构
  └── Utils/              # 工具函数
  ```

### 模块化原则

- 每个 Component 负责单一职责
- Component 间通过 Scene Events 通信，**不直接引用**
- 数据存储在 Component 中，逻辑通过事件触发

### 禁止事项

- ❌ 单个文件超过 300 行（需拆分）
- ❌ Component 间直接调用方法
- ❌ 在 Entity 中写业务逻辑（逻辑在 Component）
- ❌ 硬编码数值（使用常量或配置）
- ❌ 优先使用 CreativeDevice（SceneGraph 优先）

---

## 核心事件定义

```verse
# 物品收集事件
item_collected_event := class<concrete>(scene_event):
    Player:player
    ItemType:item_type
    Quantity:int

# 展示槽位更新事件
display_slot_updated_event := class<concrete>(scene_event):
    SlotIndex:int
    NewItem:?item_type
    IncomeRate:float

# 收入结算事件
income_tick_event := class<concrete>(scene_event):
    TotalIncome:int
    Source:string

# 货币变更事件
currency_changed_event := class<concrete>(scene_event):
    Player:player
    NewAmount:int
    Delta:int
```

---

## 参考资料

### 项目内文档

- [SceneGraph 框架详解](../../uefn-dev/references/scenegraph-framework-guide.md)
- [SceneGraph API 参考](../../uefn-dev/references/scenegraph-api-reference.md)
- [UEFN 开发技能](../../uefn-dev/SKILL.md)

### 官方文档

- [Scene Graph in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-in-unreal-editor-for-fortnite)
- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api)
- [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
