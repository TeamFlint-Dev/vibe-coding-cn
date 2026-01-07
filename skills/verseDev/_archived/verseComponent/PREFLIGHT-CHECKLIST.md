# verseComponent 前置检查清单

> **用途**: 开始组件层开发前，逐项检查以避免踩坑
>
> **来源**: 本清单从实际踩坑中持续沉淀，每条都有对应的失败案例编号

---

## ⚡ 快速检查（每次必看）

- [ ] 读取 `CAPABILITY-BOUNDARIES.md` 确认任务可行性
- [ ] 确认 `@architecture-blueprint.md` 中已定义该组件
- [ ] 确认依赖的 Helper/Wrapper 模块已实现
- [ ] 确认事件流设计已完成（verseEventFlow）
- [ ] 运行远程编译验证 Verse 语法

> **要求**: 所有组件实现必须先有架构设计

---

## 📋 架构设计检查

### 组件清单

- [ ] 组件已在 `@architecture-blueprint.md` 的 Component 清单中定义
  - 来源: verseFrameworkDesigner 架构规范
  - 验证: 检查架构文档中的组件名称、职责、依赖关系
  
- [ ] 组件职责单一明确
  - 来源: SKILL.md 单一职责原则
  - 验证: 用一句话描述组件功能，如果需要"和"字，考虑拆分

### Entity 层级结构

- [ ] 组件所属 Entity 的层级位置已确定
  - 来源: SceneGraph 框架约束
  - 验证: 绘制 Entity 树，确认父子关系
  
- [ ] 事件传播路径已规划
  - 来源: verseEventFlow 事件设计
  - 验证: 确认用 SendUp/SendDown/SendDirect

---

## 🔍 依赖模块检查

### Helper 层依赖

- [ ] 需要的 Calculator 函数已实现
  - 来源: SKILL.md 设计原则 (CHANGE-004)
  - 位置: `shared/code-library/Helpers/XXXCalculator.verse`
  - 验证: 检查 Helper 函数签名是否匹配需求
  - 示例: `HealthCalculator.CalculateDamageResult()`

- [ ] 需要的 Utils 函数已实现
  - 位置: `shared/code-library/Helpers/XXXUtils.verse`
  - 示例: `MathUtils.Clamp()`, `VectorUtils.Distance()`

### Wrapper 层依赖

- [ ] 需要的 API 封装已实现
  - 来源: SKILL.md 设计原则 (CHANGE-005)
  - 位置: `shared/code-library/Wrappers/XXXWrapper.verse`
  - 验证: 检查 Wrapper 是否覆盖需要的 API
  - 示例: `CharacterWrapper.ApplyDamage()`

- [ ] Wrapper 的 digest 引用已验证
  - 验证方法: 检查 Wrapper 文件是否引用正确的 API
  - 常见问题: API 签名变更、类型不匹配

---

## 🎯 组件设计检查

### 状态管理

- [ ] 运行时状态使用 `var` 标记
  - 来源: Verse 语法约束
  - 验证: `var CurrentHealth<private>:int = 0`
  
- [ ] 设计参数使用 `@editable` 标记
  - 来源: SKILL.md 数据驱动原则
  - 验证: `@editable var MaxHealth:int = 100`
  
- [ ] 私有变量使用 `<private>` 标记
  - 来源: 封装性原则
  - 验证: 外部只能通过公开方法访问

### 真实对象绑定

- [ ] 需要绑定 UEFN 对象时，使用 `?` 可选类型
  - 来源: SKILL.md 绑定层设计 (CHANGE-004)
  - 验证: `var BoundCharacter:?fort_character = false`
  
- [ ] 提供 `BindXxx()` 和 `UnbindXxx()` 方法
  - 来源: 生命周期管理最佳实践
  - 验证: 检查方法签名

### 生命周期

- [ ] 初始化逻辑放在 `OnBeginSimulation`
  - 来源: Verse 无构造函数限制
  - 验证: 不在 class 声明时初始化
  
- [ ] 使用协程时声明 `<suspends>`
  - 来源: Verse 语法要求
  - 验证: `OnBeginSimulation<override>()<suspends>:void`
  
- [ ] `OnSimulate` 中避免复杂计算
  - 来源: 性能优化原则
  - 验证: 每帧调用，只做简单状态检查

---

## 🔄 事件通信检查

### 事件定义

- [ ] 自定义事件继承 `scene_event` 并标记 `<concrete>`
  - 来源: verseEventFlow 事件设计规范
  - 验证: `damage_event := class<concrete>(scene_event):`
  
- [ ] 事件类已在事件流设计中定义
  - 来源: 架构设计规范
  - 位置: `@architecture-blueprint.md` 或事件流文档

### 事件处理

- [ ] 实现 `OnReceive<override>` 处理事件
  - 来源: SceneGraph 事件机制
  - 验证: 包含类型转换和处理逻辑
  
- [ ] 事件处理后返回 `true` 消耗事件（如需）
  - 来源: 事件传播机制
  - 验证: `return true` 阻止事件继续传播

### 事件发送

- [ ] 选择正确的传播策略
  - 来源: verseEventFlow 传播策略
  - 验证:
    - `SendUp` - 子向父报告
    - `SendDown` - 父向子广播
    - `SendDirect` - 点对点通信

---

## 📐 职责边界检查

### ✅ Component 应该做的

- [ ] 持有运行时状态变量
- [ ] 提供事件处理器方法
- [ ] 绑定真实游戏对象（如需）
- [ ] 发送事件通知
- [ ] 调用 Helper 获取计算结果
- [ ] 通过 Wrapper 同步到游戏对象

### ❌ Component 不应该做的

- [ ] **不含** 复杂计算逻辑（应委托给 Helper）
  - 来源: SKILL.md 设计原则 (CHANGE-004)
  - 检查: 计算逻辑是否在 Helper 层
  
- [ ] **不直接调用** UEFN digest API（应通过 Wrapper）
  - 来源: SKILL.md 设计原则 (CHANGE-005)
  - 检查: 是否通过 `XXXWrapper` 调用 API
  
- [ ] **不硬编码** 数值（应使用 @editable 配置）
  - 来源: 数据驱动原则
  - 检查: 魔法数字是否已提取为配置
  
- [ ] **不直接引用** 其他 Component（应通过事件）
  - 来源: 松耦合原则
  - 检查: 是否避免了组件间硬依赖

---

## 🧪 代码质量检查

### 命名规范

- [ ] 组件类名使用 `xxx_component` 格式
  - 来源: Verse 命名约定
  - 示例: `health_component`, `attack_component`
  
- [ ] 事件处理方法以 `On` 开头
  - 来源: 语义化命名
  - 示例: `OnReceiveDamage()`, `OnBeginSimulation()`
  
- [ ] 私有方法在方法末尾标记 `<private>`
  - 来源: Verse 语法
  - 示例: `HandleDeath<private>():void`

### 类型安全

- [ ] 可选类型使用 `?` 并正确解包
  - 来源: Verse 类型系统
  - 验证: `if (Character := BoundCharacter?):`
  
- [ ] 避免类型转换错误
  - 来源: 编译时类型检查
  - 验证: int/float 转换使用显式语法

### 错误处理

- [ ] 检查 `GetComponent<T>()` 返回值
  - 来源: 组件可能不存在
  - 验证: `if (HC := GetComponent<health_component>()):`
  
- [ ] 检查事件类型转换结果
  - 来源: 事件可能是其他类型
  - 验证: `if (DamageEvent := Event?damage_event):`

---

## 🔐 合规性检查

### 架构约束

- [ ] 符合 SceneGraph 架构约束
  - 来源: `shared/checklists/scenegraph-compliance.md`
  - 验证: 使用架构检查清单
  
- [ ] 遵循 Helper/Component 职责分离
  - 来源: CHANGE-004 架构更新
  - 验证: 计算逻辑在 Helper，状态管理在 Component

### 性能约束

- [ ] `OnSimulate` 方法足够轻量
  - 来源: 每帧调用，性能敏感
  - 验证: 避免循环、递归、复杂计算
  
- [ ] 避免在高频方法中创建大量对象
  - 来源: GC 压力
  - 验证: 复用对象，使用对象池

---

## 🔨 编译验证

- [ ] 本地语法检查通过
  - 验证: IDE 无错误提示
  
- [ ] 远程编译验证通过
  - 来源: UEFN 编译器真实验证
  - 验证: `.\tools\verseCompiler\client\compile.ps1 -Wait`
  - 要求: 代码必须已 commit
  
- [ ] 编译警告已处理
  - 来源: 警告可能导致运行时问题
  - 验证: 无 warning 信息

---

## 📝 文档检查

- [ ] 组件类有注释说明职责
  - 来源: 代码可读性
  - 格式: `# health_component - 生命值管理`
  
- [ ] 公开方法有注释说明用途
  - 来源: API 文档
  - 格式: `# 接收伤害事件`
  
- [ ] 复杂逻辑有注释解释
  - 来源: 维护性
  - 验证: 非显而易见的逻辑有说明

---

## 更新记录

| 日期 | 更新内容 | 关联案例 |
|------|----------|----------|
| 2026-01-06 | 初始版本，基于 SKILL.md (CHANGE-004, CHANGE-005) | - |

---

## 如何使用本清单

1. **任务开始前**: 从上到下逐项检查
2. **发现问题**: 停止任务，先解决问题
3. **踩坑后**: 立即更新清单，添加新检查项
4. **定期回顾**: 每月检查清单是否仍然有效
