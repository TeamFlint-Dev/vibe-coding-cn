# Verse Dev 快速开始指南

> 本指南帮助你快速上手 Verse Dev 技能体系

---

## 前置条件

1. 熟悉 UEFN (Unreal Editor for Fortnite) 基本操作
2. 了解 Verse 语言基础语法
3. 理解 SceneGraph 的 Entity-Component-Event 架构（可参考 [shared/references/](shared/references/)）

---

## 🚀 一键启动

### 最简启动（复制即用）

```
请加载 Skill: Core/skills/programming/verseDev/verseOrchestrator/SKILL.md

我需要开发一个 [你的游戏功能描述]
```

### 完整启动模板

```
请加载以下 Skill 体系:
- 编排器: Core/skills/programming/verseDev/verseOrchestrator/SKILL.md
- API参考: Core/skills/programming/verseDev/shared/api-digests/ (Verse/Fortnite/UnrealEngine.digest.verse)
- 框架指南: Core/skills/programming/verseDev/shared/references/scenegraph-framework-guide.md

使用「架构设计模式」帮我设计: [你的需求]
```

---

## 📋 启动案例

### 案例 1: 塔防游戏防御塔系统

```
请加载 Skill: Core/skills/programming/verseDev/verseOrchestrator/SKILL.md

使用「架构设计模式」，我需要实现一个塔防游戏的防御塔系统：

功能需求：
1. 玩家点击地面的建造点，可以选择建造不同类型的防御塔
2. 防御塔建造后自动检测范围内的敌人
3. 检测到敌人后自动攻击最近的目标
4. 支持三种塔类型：箭塔(单体伤害)、炮塔(范围伤害)、减速塔(减速效果)
5. 每种塔可以升级3次，升级后伤害和范围增加

技术约束：
- 最多同时存在20座防御塔
- 每座塔的检测范围最大1500单位
```

**预期响应流程**：
1. 编排器分析需求 → 进入架构设计模式
2. 框架设计层输出 Entity树、Component清单、事件定义
3. 等待用户确认架构 → 进入分层执行
4. 逐层生成代码 (L4→L3→L2→L1)

---

### 案例 2: 快速迭代已有代码

```
请加载 Skill: Core/skills/programming/verseDev/verseOrchestrator/SKILL.md

使用「循环迭代模式」，我有一个 health_component 需要增加护盾功能：

现有代码：
```verse
health_component := class(component):
    @editable var MaxHealth:int = 100
    var CurrentHealth<private>:int = 0
    
    TakeDamage(Amount:int):void =
        set CurrentHealth = Max(0, CurrentHealth - Amount)
```

新需求：
- 增加护盾值，受伤时先扣护盾
- 护盾可以缓慢恢复
- 护盾归零时发送 shield_broken_event
```

**预期响应流程**：
1. 编排器识别为代码迭代任务
2. 直接在组件层处理
3. 输出修改后的代码 + 新增的事件类
4. 询问是否入库到 `@code-library.md`

---

### 案例 3: 从需求到完整实现

```
请加载以下 Skill:
- Core/skills/programming/verseDev/verseOrchestrator/SKILL.md
- Core/skills/programming/verseDev/verseRequirementProposer/SKILL.md

我想做一个"大逃杀"模式的缩圈系统，但我不太确定具体需要什么功能，请帮我梳理需求。
```

**预期响应流程**：
1. 编排器检测到需求模糊 → 调用需求梳理器
2. 需求梳理器通过提问明确功能边界
3. 输出结构化需求文档
4. 询问用户确认后进入架构设计

---

### 案例 4: 恢复上次工作

```
请加载 Skill: Core/skills/programming/verseDev/verseOrchestrator/SKILL.md

继续上次的工作。

[粘贴之前保存的 @checkpoint.md 内容]
```

**预期响应流程**：
1. 编排器解析检查点
2. 恢复任务状态和上下文
3. 从断点处继续执行

---

## 5分钟快速入门

### Step 1: 选择运行模式

根据你的需求选择协调器的运行模式：

| 你想要... | 选择模式 |
|----------|----------|
| 设计新游戏架构 | 架构设计模式 |
| 实现具体功能 | 分层执行模式 |
| 积累通用代码 | 循环迭代模式 |
| 精细控制每一步 | 对话模式 |
| 优化Skill效果 | 改进模式 |

### Step 2: 启动协调器

```markdown
@verseOrchestrator [模式名]

示例：
@verseOrchestrator 架构设计模式
@verseOrchestrator 分层执行模式
```

### Step 3: 描述你的需求

**示例需求**：
```markdown
我需要实现一个塔防游戏的防御塔系统：
- 玩家可以在指定位置建造防御塔
- 防御塔自动攻击范围内的敌人
- 不同类型的防御塔有不同的攻击方式
- 防御塔可以升级
```

### Step 4: 跟随协调器指引

协调器会：
1. 分析需求并拆解任务
2. 调用框架设计层确定架构
3. 逐层调度实现代码
4. 在关键节点与你对话确认

---

## 常用操作

### 恢复之前的工作

```markdown
# 协调器会自动检测检查点
@verseOrchestrator

# 如果存在检查点，会提示：
"检测到未完成的工作：
1. [2025-12-27] 防御塔系统 - Layer 3 组件层
2. [2025-12-26] 商店系统 - Layer 4 事件流层

是否恢复？输入编号或'新建'开始新任务"
```

### 切换控制粒度

```markdown
# 切换到对话模式（每步确认）
"切换到对话模式"

# 切换到自动模式（默认处理）
"切换到自动模式"
```

### 查看当前进度

```markdown
"显示当前进度"
"当前在哪一层？"
```

### 更新模板

```markdown
# 完成功能后
"更新Memory-Bank模板"
```

---

## 理解分层架构

### 层级职责

```
┌─────────────────────────────────────────┐
│ Layer 5: 框架设计层                      │
│ 输出: @architecture-blueprint.md        │
│ 包含: Entity树、Component清单、事件流图  │
├─────────────────────────────────────────┤
│ Layer 4: 事件流层                        │
│ 输出: 事件定义代码、传播逻辑            │
│ 包含: scene_event 类、SendUp/Down策略   │
├─────────────────────────────────────────┤
│ Layer 3: 组件层                          │
│ 输出: component 类代码                  │
│ 包含: 生命周期实现、组件间接口          │
├─────────────────────────────────────────┤
│ Layer 2: 操作层                          │
│ 输出: Helper函数                        │
│ 包含: API封装、通用工具函数              │
├─────────────────────────────────────────┤
│ Layer 1: 资产层                          │
│ 输出: 资产引用代码、占位接口            │
│ 包含: 资产路径、TODO标记                │
└─────────────────────────────────────────┘
```

### 需求下沉示例

```
用户需求: "防御塔自动攻击敌人"
    │
    ▼
Layer 5 (框架设计): 
    设计 tower_entity, attack_component, target_finder_component
    │
    ▼
Layer 4 (事件流):
    设计 enemy_entered_range_event, attack_triggered_event
    │
    ▼
Layer 3 (组件层):
    实现 attack_component 代码
    发现需要"计算两点距离"函数
    │
    ▼ [下沉请求]
Layer 2 (操作层):
    提供 CalculateDistance(a:vector3, b:vector3):float
    │
    ▼ [返回]
Layer 3:
    使用 CalculateDistance 完成组件实现
```

---

## 处理API缺失

当操作层无法实现某个功能时：

```markdown
# 操作层报告
"当前API不支持：获取所有玩家的实时位置
原因：Verse API 没有提供批量获取玩家位置的方法
建议：使用事件订阅方式，在玩家移动时更新位置缓存"

# 记录到 @api-gaps.md
已记录API缺失，游戏设计时请注意此限制
```

---

## 常见问题

### Q: 如何选择 Entity 类 vs 纯组件？

**A**: 参考以下原则：
- **复杂系统**（玩家、Boss、移动基地）→ 自定义 Entity 类
- **简单对象**（道具、特效、拾取物）→ 纯组件方式

详见 [scenegraph-framework-guide.md](shared/references/scenegraph-framework-guide.md)

### Q: 事件应该用 SendUp 还是 SendDown？

**A**: 
- **子向父报告** → SendUp（如：玩家受伤 → 游戏管理器）
- **父向子广播** → SendDown（如：游戏状态变化 → 所有子系统）
- **点对点通信** → SendDirect（如：直接通知特定玩家）

### Q: OnBeginSimulation 为什么要加 Sleep(0.0)？

**A**: 这是 Epic 官方推荐的最佳实践，用于延迟一帧确保引擎内部初始化完成。

```verse
OnBeginSimulation<override>()<suspends>:void =
    Sleep(0.0)  # 必须！
    # 后续初始化代码
```

---

## 下一步

1. 阅读 [Index.md](Index.md) 了解完整架构
2. 查看 [shared/references/](shared/references/) 中的框架指南
3. 浏览 [shared/api-digests/](shared/api-digests/) 了解可用 API
4. 复制上面的启动案例，开始你的第一个 Verse 项目！

---

## 💡 小贴士

- **新手推荐**: 从「案例 3」开始，让需求梳理器帮你理清思路
- **有明确需求**: 直接用「案例 1」的架构设计模式
- **改现有代码**: 用「案例 2」的循环迭代模式最快
- **跨会话开发**: 每次结束前让编排器生成检查点，下次用「案例 4」恢复

---

## 🔄 全自动循环模式

> **新功能**: 使用脚本驱动的全自动编码-评审-改进循环

### 什么是全自动循环？

不同于传统的人机交互模式，全自动循环使用 Python 脚本作为控制器，自动调度多个 Agent：
- **编码 Agent**: 根据需求编写 Verse 代码
- **评审 Agents**: 三个独立评审员（实用性/框架/质量）
- **战术师 Agent**: 维护战术手册，沉淀经验

### 快速启动

```bash
# 1. 进入脚本目录
cd Core/skills/programming/verseDev/verseAgentLoop/scripts

# 2. 安装依赖（可选，仅 OpenAI 模式需要）
pip install -r requirements.txt

# 3. 启动校准模式（推荐新用户）
python main.py --mode calibration

# 4. 或启动全自动模式
python main.py --mode auto --max-tasks 10
```

### 运行模式

| 模式 | 说明 | 适用场景 |
|------|------|----------|
| `calibration` | 前3个任务需人工确认 | 首次使用、调试配置 |
| `auto` | 完全自动，仅超时/升级时暂停 | 批量生成、夜间跑批 |

### 命令行选项

```bash
python main.py [选项]

选项:
  --mode MODE          运行模式: calibration, auto (默认: calibration)
  --max-tasks N        完成N个任务后停止 (默认: 5)
  --config PATH        自定义配置文件
  --verbose            详细日志输出
```

### 配置文件

编辑 `config/default.json` 自定义运行参数：

```json
{
  "review": {
    "weights": {
      "utility": 0.4,      // 实用性权重
      "framework": 0.4,    // 框架符合性权重  
      "quality": 0.2       // 代码质量权重
    },
    "pass_threshold": 7.0  // 通过分数阈值
  },
  "compile": {
    "max_attempts": 3      // 编译最大尝试次数
  },
  "loop": {
    "escalation_threshold": 3  // 连续否决后升级到人工
  }
}
```

### 工作流程

```
需求队列 → 编码Agent → verseCli编译 → 评审Agents投票
    ↑                                        ↓
    └──────── 战术师更新手册 ←── 通过/升级/改进 ───┘
```

### 日志与调试

```bash
# 查看最近日志
python search_logs.py --last 5

# 搜索特定关键词
python search_logs.py --keyword "编译失败"

# 按任务ID查看
python search_logs.py --task TASK-20251227-001
```

### 相关资源

- **完整文档**: [verseAgentLoop/SKILL.md](verseAgentLoop/SKILL.md)
- **战术手册**: [shared/tactical-schema.md](shared/tactical-schema.md)
- **战术师**: [verseTactician/SKILL.md](verseTactician/SKILL.md)

---

*最后更新: 2025-12-27*
