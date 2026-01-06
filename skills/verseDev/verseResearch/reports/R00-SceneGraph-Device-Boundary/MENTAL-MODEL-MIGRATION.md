# SG/Device 能力边界心智模型迁移指南

> **文档编号**: R00-MIGRATION-001  
> **创建日期**: 2026-01-05  
> **状态**: ✅ 正式发布  
> **适用范围**: 所有 UEFN/Verse 开发项目

---

## 📋 文档目的

本文档用于记录和说明从"SG vs Device 功能分工"到"SG能力边界 = Component化边界"的心智模型迁移。

---

## 🔄 心智模型变更

### ❌ 旧模型（已废弃）

**核心思想**: SG 和 Device 是两种平行的开发方式，根据功能类型选择使用。

**问题**:
1. **分类模糊**: "状态管理用SG，交互用Device" —— 但很多需求既有状态又有交互
2. **决策困难**: 开发者经常纠结"这个功能该用SG还是Device"
3. **混合架构混乱**: 不清楚何时混用、如何混用
4. **与官方定位不符**: SceneGraph 本质是组件化架构，不是"功能分类器"

### ✅ 新模型（正式采用）

**核心思想**: **SG能力边界 = Component化边界**

```
需求功能
    │
    ▼
能否Component化？
    │
    ├─ 能 → 使用 SceneGraph (entity + component)
    │       │
    │       └─ 需要交互/UI/音频？ → 混合 Device
    │
    └─ 不能 → 必须使用 Device
         │
         └─ 原因: 编辑器预置、实例化限制、特殊引擎支持
```

---

## 🎯 Component化判定标准

### ✅ 可以 Component化（优先使用 SceneGraph）

| 判定维度 | 标准 | 示例 |
|---------|------|------|
| **逻辑抽象** | 可抽象为通用组件逻辑 | 状态机、计时器、对象池 |
| **实例化** | 可运行时动态创建多个实例 | 敌人生成器、弹道系统 |
| **数据驱动** | 行为由数据参数控制，非硬编码 | 属性系统、技能系统 |
| **可组合** | 可与其他组件组合形成复杂行为 | 移动+碰撞+生命值组件 |
| **无编辑器依赖** | 不需要编辑器预置资源或配置 | 纯逻辑、纯数据结构 |

**典型场景**:
- ✅ 状态机（StateComponent）
- ✅ 生成器（SpawnerComponent）
- ✅ 属性系统（AttributeComponent）
- ✅ 计时器（TimerComponent）
- ✅ 碰撞检测（CollisionComponent）
- ✅ 事件总线（EventBusComponent）
- ✅ AI行为树（BehaviorTreeComponent）

### ❌ 不能 Component化（必须使用 Device）

| 判定维度 | 标准 | 示例 |
|---------|------|------|
| **编辑器预置** | 需要编辑器预先配置资源/参数 | 音效资源、UI布局 |
| **实例化限制** | 只能放置固定数量，不可动态创建 | 游戏规则、回合管理 |
| **引擎特殊支持** | 依赖引擎底层系统，无法用Verse实现 | 玩家输入、物理引擎 |
| **全局单例** | 必须全局唯一，不可多实例 | ScoreManager、EndGameDevice |
| **资源绑定** | 绑定特定美术/音频资源 | AudioPlayerDevice、MeshRenderer |

**典型场景**:
- ❌ 玩家输入（input_trigger_device）—— 引擎特殊支持
- ❌ UI显示（hud_message_device）—— 编辑器预置 + 引擎渲染
- ❌ 音效播放（audio_player_device）—— 资源绑定
- ❌ 游戏规则（end_game_device）—— 全局单例
- ❌ 得分统计（score_manager_device）—— 全局单例
- ❌ 玩家传送（teleporter_device）—— 编辑器预置位置

---

## 🏗️ 混合架构模式

### 模式：SG管理逻辑 + Device处理交互

**核心思想**: Component 内部包含所有逻辑和状态，通过 Device 事件获取输入/输出外部效果。

```verse
# ✅ 推荐：Component 管理状态，Device 提供交互
fishing_component := class(component):
    # 状态在 Component 中
    var FishingState:fishing_state = fishing_state.Idle
    var CatchProgress:float = 0.0
    
    # 引用 Device（编辑器配置）
    @editable InputDevice:input_trigger_device
    @editable AudioDevice:audio_player_device
    
    OnBeginSimulation<override>()<suspends>:void =
        Sleep(0.0)
        
        # 监听 Device 事件
        InputDevice.InteractedWithEvent.Subscribe(OnPlayerInteract)
        
    # 逻辑在 Component 中
    OnPlayerInteract(Agent:?agent):void =
        if (FishingState = fishing_state.Idle):
            StartFishing()
    
    StartFishing()<suspends>:void =
        set FishingState = fishing_state.Casting
        
        # 通过 Device 播放音效
        AudioDevice.Play()
        
        spawn:
            Sleep(2.0)
            CompleteCatch()
    
    CompleteCatch():void =
        set FishingState = fishing_state.Success
        # 派发事件通知其他 Component
        if (Owner := GetOwner()):
            Owner.SendUp(fishing_completed_event{...})
```

**关键原则**:
1. **Component持有状态** - 所有游戏状态在Component中
2. **Device提供能力** - 输入/输出/资源由Device提供
3. **事件驱动** - Device事件触发Component逻辑
4. **编辑器配置** - Device在编辑器中配置并引用

---

## 📊 典型案例对比

### 案例1: 钓鱼系统

| 功能模块 | 实现方式 | 理由 |
|---------|---------|------|
| **钓鱼状态机** | ✅ Component | 可抽象为状态组件，可复用 |
| **进度计算** | ✅ Component | 纯逻辑，可Component化 |
| **玩家输入检测** | ❌ Device (input_trigger) | 引擎输入系统 |
| **UI进度条** | ❌ Device (canvas_device) | 编辑器UI布局 |
| **音效播放** | ❌ Device (audio_player) | 资源绑定 |

**架构**: `fishing_component` + `input_trigger_device` + `canvas_device` + `audio_player_device`

---

### 案例2: 敌人波次生成

| 功能模块 | 实现方式 | 理由 |
|---------|---------|------|
| **波次管理** | ✅ Component | 状态+逻辑，可Component化 |
| **敌人生成** | ✅ Component | 动态创建实体，SceneGraph特性 |
| **路径规划** | ✅ Component | AI逻辑，可Component化 |
| **敌人死亡音效** | ❌ Device (audio_player) | 资源绑定 |
| **波次完成UI** | ❌ Device (hud_message) | UI显示 |

**架构**: `wave_manager_component` + `enemy_spawner_component` + `audio_player_device` + `hud_message_device`

---

### 案例3: 技能系统

| 功能模块 | 实现方式 | 理由 |
|---------|---------|------|
| **技能冷却管理** | ✅ Component | 时间+状态，可Component化 |
| **技能效果计算** | ✅ Component (+ Helper) | 纯逻辑，可Component化 |
| **技能释放检测** | ❌ Device (input_trigger) | 玩家输入 |
| **技能特效** | ⚠️ 混合 | 粒子Component + AudioDevice |
| **技能冷却UI** | ❌ Device (canvas_device) | UI显示 |

**架构**: `skill_component` + `cooldown_component` + `input_trigger_device` + `canvas_device`

---

## 🔍 决策流程图

```
收到开发需求
    │
    ▼
提取核心功能点
    │
    ▼
┌─────────────────────────────────────┐
│ 对每个功能点进行 Component化判定     │
└─────────────────────────────────────┘
    │
    ▼
功能是否可抽象为通用组件逻辑？
    │
    ├─ 是 → 可以Component化
    │       │
    │       ▼
    │   是否需要运行时动态创建多个实例？
    │       │
    │       ├─ 是 → ✅ SceneGraph (entity + component)
    │       │
    │       └─ 否 → 检查是否有其他限制
    │               │
    │               ├─ 无 → ✅ SceneGraph (单例 component)
    │               │
    │               └─ 有 → ❌ Device
    │
    └─ 否 → 检查原因
            │
            ├─ 编辑器预置 → ❌ Device
            ├─ 实例化限制 → ❌ Device
            ├─ 引擎特殊支持 → ❌ Device
            └─ 资源绑定 → ❌ Device
    
最终方案
    │
    ├─ 纯 SceneGraph
    ├─ 纯 Device
    └─ 混合架构（SG逻辑 + Device能力）
```

---

## 📝 架构评审检查清单

在设计阶段，使用以下清单验证架构决策：

### Component化判定检查

- [ ] **逻辑抽象性**: 功能是否可抽象为通用组件？
- [ ] **实例化能力**: 是否需要运行时动态创建多个实例？
- [ ] **数据驱动性**: 行为是否由参数控制而非硬编码？
- [ ] **可组合性**: 是否可与其他组件组合？
- [ ] **编辑器依赖**: 是否需要编辑器预置资源？

### Device必要性检查

- [ ] **引擎依赖**: 是否依赖引擎底层系统（输入/物理/渲染）？
- [ ] **资源绑定**: 是否绑定特定美术/音频资源？
- [ ] **全局单例**: 是否必须全局唯一？
- [ ] **编辑器配置**: 是否需要编辑器预先配置？

### 混合架构验证

- [ ] **职责清晰**: Component管理状态，Device提供能力
- [ ] **事件驱动**: Device事件触发Component逻辑
- [ ] **编辑器引用**: Device在编辑器中配置并通过`@editable`引用
- [ ] **可测试性**: Component逻辑可独立测试（Mock Device事件）

---

## 🚀 迁移行动

### 对现有项目

1. **审查现有架构**：识别"被误用为Device"的Component化需求
2. **重构优先级**：优先重构核心逻辑模块
3. **保留稳定模块**：已上线且稳定的混合架构可暂不动
4. **新需求严格执行**：所有新需求必须按新模型设计

### 对新项目

1. **需求分析阶段**：直接使用Component化判定标准
2. **架构设计阶段**：使用决策流程图
3. **评审阶段**：使用检查清单验证
4. **实现阶段**：遵循混合架构模式

---

## 📖 相关文档更新

本次迁移涉及以下文档修订：

| 文档 | 修订内容 | 状态 |
|------|---------|------|
| CAPABILITY-BOUNDARIES.md | 更新核心定义和判定标准 | ✅ 已完成 |
| README.md | 更新指引说明和用例分类 | ✅ 已完成 |
| architecture-library.md | 更新设计规范和职责划分 | ✅ 已完成 |
| @ai-rules-templates.md | 更新AI规则示例 | ✅ 已完成 |
| verseArchitectureSelector | 更新决策逻辑 | ✅ 已完成 |
| 其他相关文档 | 术语统一、概念对齐 | ✅ 已完成 |

---

## ❓ FAQ

### Q1: 所有能Component化的都必须用SceneGraph吗？

**A**: 不是"必须"，而是"优先"。如果Device已经提供了成熟的解决方案，且没有性能或灵活性问题，可以继续使用Device。但对于新需求，应优先考虑Component化。

### Q2: 如何判断一个功能"能否Component化"？

**A**: 使用本文档的判定标准：
1. 能否抽象为通用组件逻辑？
2. 能否运行时动态创建多个实例？
3. 行为是否由数据参数控制？
4. 能否与其他组件组合？
5. 是否不依赖编辑器预置？

满足3项以上即可Component化。

### Q3: 混合架构的最佳实践是什么？

**A**: 
1. Component持有所有状态和逻辑
2. Device仅提供输入/输出/资源能力
3. Device事件触发Component逻辑
4. Device在编辑器中配置，通过`@editable`引用

### Q4: SceneGraph发布限制解除前是否应该使用？

**A**: 
- **学习/原型阶段**: 建议使用，熟悉Component化思维
- **生产阶段**: 谨慎使用，需要有迁移到Device的备选方案
- **长期项目**: 建议使用，Epic官方已明确SceneGraph是未来方向

### Q5: 旧模型和新模型的主要区别是什么？

**A**:
- **旧模型**: "SG处理逻辑，Device处理交互" —— 按功能类型分类
- **新模型**: "能Component化就用SG，不能就用Device" —— 按技术可行性分类

新模型更清晰、更易决策、更符合SceneGraph的架构定位。

---

## ✅ 验证案例

### 验证1: 钓鱼系统（已实现）

**旧模型分析**:
- "钓鱼是交互功能 → 用Device" ❌ 决策困难

**新模型分析**:
- 钓鱼状态可Component化 → ✅ Component
- 玩家输入不可Component化 → ❌ Device
- **结论**: 混合架构（fishing_component + input_device）

### 验证2: 波次生成系统

**旧模型分析**:
- "生成是逻辑功能 → 用SG" —— 但缺乏明确指引

**新模型分析**:
- 波次管理可Component化 → ✅ Component
- 敌人生成可Component化 → ✅ Component（SceneGraph动态创建实体）
- 音效播放不可Component化 → ❌ Device
- **结论**: 混合架构（wave_component + spawner_component + audio_device）

### 验证3: UI菜单系统

**旧模型分析**:
- "UI是交互功能 → 用Device" —— 正确但不明确

**新模型分析**:
- UI布局不可Component化（编辑器预置） → ❌ Device
- 菜单状态可Component化 → ✅ Component（可选）
- **结论**: Device主导，可选Component管理复杂菜单状态

---

## 📌 总结

**核心原则**: **SG能力边界 = Component化边界**

**判定标准**:
- ✅ 可抽象、可实例化、数据驱动、可组合、无编辑器依赖 → SceneGraph
- ❌ 编辑器预置、实例化限制、引擎特殊支持、资源绑定 → Device

**混合架构**:
- Component持有状态和逻辑
- Device提供输入/输出/资源能力
- 事件驱动，编辑器配置

**行动指南**:
- 新需求：严格按新模型设计
- 旧项目：识别误用，逐步重构
- 评审：使用检查清单验证

---

**文档负责人**: GitHub Copilot Agent  
**发布日期**: 2026-01-05  
**版本**: 1.0  
**状态**: ✅ 正式发布
