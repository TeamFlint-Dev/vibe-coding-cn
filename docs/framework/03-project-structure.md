# 项目结构 - 自进化编码框架

## 📁 完整目录结构

```
vibe-coding-cn/
├── docs/
│   └── framework/              # 框架文档（本文档集）
│       ├── README.md
│       ├── 00-overview.md
│       ├── 01-architecture.md
│       ├── 02-core-concepts.md
│       ├── 03-project-structure.md
│       ├── 04-skill-definitions.md
│       ├── 05-index-mechanism.md
│       ├── 06-workflow.md
│       ├── 07-evolution-mechanism.md
│       └── 08-implementation-guide.md
│
├── Core/                       # 现有Core结构（保持不变）
│   ├── skills/                 # 现有技能库
│   │   ├── programming/
│   │   │   ├── verseDev/      # Verse开发技能
│   │   │   └── ...
│   │   └── design/
│   │       ├── gameDev/       # 游戏设计技能
│   │       └── ...
│   ├── prompts/               # 提示词库
│   └── documents/             # 方法论文档
│
├── skills/                     # 框架元Skill（新增）
│   ├── orchestrator.skill.md  # 总调度器
│   ├── producer.skill.md      # 生产引擎
│   ├── composer.skill.md      # 拼装引擎
│   └── learner.skill.md       # 学习引擎
│
├── .state/                     # 系统运行状态（新增）
│   ├── phase.json             # 当前阶段
│   ├── coverage.json          # 能力覆盖情况
│   ├── quality-history.json   # 质量历史趋势
│   └── indices/               # 索引配置（进化核心）
│       ├── feature-weights.json    # 特征权重
│       ├── example-index.json      # 案例索引
│       └── pattern-index.json      # 模式索引
│
├── knowledge/                  # 结构化知识库（新增）
│   ├── uefn/                  # UEFN特定知识
│   │   ├── api-digests/       # API摘要（复用Core）
│   │   │   ├── Fortnite.digest.verse.md
│   │   │   ├── UnrealEngine.digest.verse.md
│   │   │   └── Verse.digest.verse.md
│   │   └── capability-map.json     # 能力地图
│   │
│   ├── patterns/              # 设计模式库
│   │   ├── zero-coupling.md
│   │   ├── event-driven.md
│   │   ├── component-based.md
│   │   ├── singleton.md
│   │   └── observer.md
│   │
│   └── examples/              # 代码案例库
│       ├── excellent/         # 优秀案例
│       │   ├── HealthComponent.verse
│       │   ├── AttackSystem.verse
│       │   └── ...
│       └── average/           # 普通案例（学习对比用）
│           └── ...
│
├── assets/                     # 代码产出（新增）
│   ├── modules/               # 生产的代码积木
│   │   ├── health/
│   │   │   ├── HealthComponent.verse
│   │   │   └── metadata.json
│   │   ├── combat/
│   │   │   ├── AttackSystem.verse
│   │   │   └── metadata.json
│   │   └── ...
│   └── composed/              # 拼装后的完整功能
│       └── PlayerCombatSystem/
│           ├── main.verse
│           ├── components.txt    # 使用的积木清单
│           └── metadata.json
│
├── data/                       # 数据积累（新增）
│   ├── experiences/           # 每次运行的完整经验
│   │   ├── run-001.json
│   │   ├── run-002.json
│   │   └── ...
│   ├── quality-scores/        # 质量评分记录
│   │   └── scores.csv
│   └── traces/                # 执行trace日志
│       ├── producer-trace-001.json
│       └── ...
│
└── agent.md                    # Agent能力说明（新增）
```

## 🔍 目录职责详解

### 1. `docs/framework/` - 框架文档

**职责**：存放框架的设计文档和使用指南

**包含文件**：

- `README.md` - 文档导航入口
- `00-overview.md` - 系统概述
- `01-architecture.md` - 架构设计
- `02-core-concepts.md` - 核心概念
- `03-project-structure.md` - 本文件
- `04-skill-definitions.md` - Skill定义
- `05-index-mechanism.md` - 索引机制
- `06-workflow.md` - 工作流程
- `07-evolution-mechanism.md` - 进化机制
- `08-implementation-guide.md` - 实施指南

**维护规则**：

- 随框架演进更新
- 保持版本注释
- 添加更新日期

### 2. `Core/` - 现有核心资源

**职责**：保持现有项目结构不变

**包含内容**：

- `skills/` - 现有技能库（verseDev, gameDev等）
- `prompts/` - 提示词库
- `documents/` - 方法论文档

**维护规则**：

- 继续按现有规范维护
- 与框架和平共存
- 框架元Skill会引用这些资源

### 3. `skills/` - 框架元Skill

**职责**：存放框架的4个核心Skill定义

**文件列表**：

```
skills/
├── orchestrator.skill.md    # 总调度器
├── producer.skill.md        # 代码积木生产引擎
├── composer.skill.md        # 积木拼装引擎
└── learner.skill.md         # 反馈学习引擎
```

**文件格式**：

```markdown
---
name: skillName
version: 1.0.0
type: meta-skill
requires: [依赖的其他Skill]
---

# Skill名称

## 触发条件

## 输入

## 处理流程

## 输出

## 渐进式披露策略
```

**维护规则**：

- 每个Skill独立文件
- 包含完整的披露策略说明
- 定义清晰的输入输出
- 版本化管理

### 4. `.state/` - 系统运行状态

**职责**：存储系统运行时的动态状态

#### 4.1 `phase.json` - 当前阶段

```json
{
  "current_phase": "production",
  "cycle_count": 15,
  "started_at": "2026-01-01T00:00:00Z",
  "last_updated": "2026-01-15T10:30:00Z",
  "next_action": "produce_component",
  "target_coverage": 0.90,
  "current_coverage": 0.67
}
```

**用途**：Orchestrator读取此文件决定下一步操作

#### 4.2 `coverage.json` - 能力覆盖情况

```json
{
  "total_capabilities": 150,
  "covered_capabilities": 100,
  "coverage_rate": 0.67,
  "capabilities": {
    "player_management": {
      "total": 20,
      "covered": 18,
      "modules": ["HealthComponent", "InventoryManager", ...]
    },
    "combat_system": {
      "total": 25,
      "covered": 15,
      "modules": ["AttackSystem", "DamageCalculator"]
    }
  }
}
```

**用途**：跟踪已生产的代码积木覆盖了哪些能力点

#### 4.3 `quality-history.json` - 质量历史

```json
{
  "history": [
    {
      "cycle": 1,
      "timestamp": "2026-01-01T10:00:00Z",
      "quality_score": 0.65,
      "feature_scores": {
        "zero_coupling": 0.70,
        "modularity": 0.68,
        "naming": 0.60
      }
    },
    {
      "cycle": 2,
      "timestamp": "2026-01-02T10:00:00Z",
      "quality_score": 0.72,
      "feature_scores": {
        "zero_coupling": 0.78,
        "modularity": 0.75,
        "naming": 0.62
      }
    }
  ],
  "trend": "improving",
  "variance": 0.015
}
```

**用途**：Learner分析质量趋势，判断是否收敛

#### 4.4 `.state/indices/` - 索引配置

**核心进化机制所在**，详见 [05-index-mechanism.md](./05-index-mechanism.md)

**维护规则**：

- 所有文件自动生成和更新
- 不直接手动编辑（除非初始化）
- 定期备份（防止意外重置）
- 使用Git忽略（`.gitignore`）

### 5. `knowledge/` - 结构化知识库

**职责**：存储结构化的、可索引的知识资源

#### 5.1 `knowledge/uefn/` - UEFN特定知识

**API摘要** (`api-digests/`)：

- 复用 `Core/skills/programming/verseDev/shared/api-digests/`
- 不重复存储，使用软链接或引用

**能力地图** (`capability-map.json`)：

```json
{
  "version": "1.0.0",
  "categories": {
    "player_management": {
      "description": "玩家相关功能",
      "capabilities": [
        {
          "id": "player_health",
          "name": "玩家健康管理",
          "apis": ["player<public>.GetHealth()", "player<public>.SetHealth()"],
          "difficulty": "easy",
          "priority": "high"
        },
        {
          "id": "player_inventory",
          "name": "玩家库存管理",
          "apis": ["player<public>.GetInventory()", ...],
          "difficulty": "medium",
          "priority": "high"
        }
      ]
    },
    "combat_system": {
      "description": "战斗相关功能",
      "capabilities": [...]
    }
  }
}
```

**用途**：Producer循环时，从能力地图中选择待探索的能力点

#### 5.2 `knowledge/patterns/` - 设计模式库

**文件示例** (`zero-coupling.md`)：

```markdown
# 零耦合模式 (Zero-Coupling Pattern)

## 概念

组件间不直接引用，通过事件系统或消息传递通信。

## 为什么重要

- 提高可维护性
- 支持组件独立测试
- 降低系统复杂度

## UEFN实现方式

使用SceneGraph的消息系统：

\`\`\`verse
# 发送消息
SendMessageToAllPlayers(Message {
    Text: "Player took damage"
})

# 接收消息
OnMessage(Msg: message_event) : void = {
    # 处理消息
}
\`\`\`

## 反例

避免直接引用其他组件：

\`\`\`verse
# ❌ 不好的做法
var OtherComponent: other_component = ...
OtherComponent.DoSomething()
\`\`\`

## 适用场景

- 组件设计
- 系统架构
- 跨层通信
```

**维护规则**：

- 每个模式一个独立Markdown文件
- 包含概念、实现、示例、反例
- 标注适用场景

#### 5.3 `knowledge/examples/` - 代码案例库

**目录结构**：

```
examples/
├── excellent/              # 高质量案例（0.85+）
│   ├── HealthComponent.verse
│   ├── AttackSystem.verse
│   └── InventoryManager.verse
└── average/                # 中等质量案例（0.60-0.75）
    └── OldHealthScript.verse
```

**案例元数据** (同名`.json`文件)：

```json
{
  "file": "HealthComponent.verse",
  "quality_score": 0.87,
  "features": {
    "zero_coupling": 0.95,
    "modularity": 0.90,
    "naming": 0.80
  },
  "scenarios": ["player_management", "combat_system"],
  "created_at": "2026-01-05T10:00:00Z",
  "references": 12
}
```

**维护规则**：

- 只增不删（保留历史）
- 质量评分必须附带
- 定期review优秀案例

### 6. `assets/` - 代码产出

**职责**：存储框架生产的代码积木和拼装后的完整功能

#### 6.1 `assets/modules/` - 代码积木

**目录组织**：按功能分类

```
modules/
├── health/
│   ├── HealthComponent.verse
│   ├── metadata.json
│   └── test.verse
├── combat/
│   ├── AttackSystem.verse
│   ├── DamageCalculator.verse
│   └── metadata.json
└── inventory/
    └── ...
```

**元数据示例** (`metadata.json`)：

```json
{
  "module": "HealthComponent",
  "version": "1.0.0",
  "quality_score": 0.87,
  "cycle_produced": 5,
  "dependencies": [],
  "apis_used": [
    "player<public>.GetHealth()",
    "player<public>.SetHealth()"
  ],
  "test_coverage": 0.85,
  "reusable": true
}
```

#### 6.2 `assets/composed/` - 拼装后的功能

**示例**：

```
composed/
└── PlayerCombatSystem/
    ├── main.verse           # 主入口
    ├── components.txt       # 使用的积木清单
    ├── glue-code.verse      # 胶水代码（拼装逻辑）
    └── metadata.json        # 元数据
```

**components.txt 示例**：

```
# 使用的代码积木
assets/modules/health/HealthComponent.verse
assets/modules/combat/AttackSystem.verse
assets/modules/combat/DamageCalculator.verse
assets/modules/ui/CombatUI.verse

# 新编写的胶水代码
glue-code.verse (150 lines)

# 拼装比例
reused: 80%
new: 20%
```

**维护规则**：

- 每个拼装功能独立目录
- 记录使用的积木清单
- 标注复用比例

### 7. `data/` - 数据积累

**职责**：存储运行过程中产生的数据，用于分析和学习

#### 7.1 `data/experiences/` - 运行经验

**单次运行完整记录**：

```json
{
  "run_id": "run-001",
  "timestamp": "2026-01-01T10:00:00Z",
  "phase": "production",
  "cycle": 1,
  
  "input": {
    "task": "Generate HealthComponent",
    "indices": {
      "feature_weights": {
        "zero_coupling": 0.50,
        "modularity": 0.50
      }
    }
  },
  
  "disclosed_context": {
    "patterns": ["zero-coupling.md"],
    "examples": ["AttackSystem.verse"],
    "total_tokens": 2500
  },
  
  "output": {
    "file": "assets/modules/health/HealthComponent.verse",
    "lines": 120,
    "quality_score": 0.65
  },
  
  "analysis": {
    "features": {
      "zero_coupling": 0.70,
      "modularity": 0.68
    },
    "issues": ["naming不规范", "缺少错误处理"]
  }
}
```

**用途**：Learner读取这些数据进行相关性分析

#### 7.2 `data/quality-scores/` - 质量评分

**CSV格式便于分析**：

```csv
cycle,timestamp,quality_score,zero_coupling,modularity,naming,comments
1,2026-01-01T10:00:00Z,0.65,0.70,0.68,0.60,0.50
2,2026-01-02T10:00:00Z,0.72,0.78,0.75,0.62,0.55
3,2026-01-03T10:00:00Z,0.78,0.85,0.80,0.65,0.60
```

**用途**：

- 绘制质量趋势图
- 计算特征相关性
- 判断收敛情况

#### 7.3 `data/traces/` - 执行trace

**调试和审计用**：

```json
{
  "trace_id": "producer-trace-001",
  "skill": "producer",
  "steps": [
    {
      "step": 1,
      "action": "read_indices",
      "result": "success",
      "data": {...}
    },
    {
      "step": 2,
      "action": "disclose_context",
      "patterns_disclosed": ["zero-coupling"],
      "examples_disclosed": ["AttackSystem"],
      "tokens_used": 2500
    },
    {
      "step": 3,
      "action": "invoke_agent",
      "prompt_tokens": 3000,
      "completion_tokens": 800
    }
  ]
}
```

**用途**：

- 调试披露策略
- 分析性能瓶颈
- 审计决策过程

**维护规则**：

- 自动生成，不手动编辑
- 定期归档（避免过大）
- 敏感信息脱敏

### 8. `agent.md` - Agent能力说明

**职责**：文档化Agent（LLM）的基础能力

**内容示例**：

```markdown
# Agent能力说明

## 基础能力

本框架使用的Agent（LLM）具备以下基础能力：

- 理解自然语言需求
- 生成符合Verse语法的代码
- 识别常见设计模式
- 进行代码推理

## 限制

- 不记忆历史对话（无状态）
- 不会主动学习反馈
- 上下文窗口有限（128K tokens）

## 模型配置

- 模型：GPT-4 / Claude 3.5 Sonnet
- 温度：0.7
- Top-p：0.9

## 不变性

Agent的这些能力是预训练的结果，框架**不改变**Agent本身，
而是通过Skill层的索引机制**引导**Agent。
```

**维护规则**：

- 记录使用的LLM型号
- 更新时注明日期
- 说明为什么不改变Agent

## 📊 文件格式规范

### JSON文件

**规范**：

- 使用2空格缩进
- UTF-8编码
- 包含`version`字段
- 每个顶级对象包含时间戳

**示例**：

```json
{
  "version": "1.0.0",
  "last_updated": "2026-01-15T10:30:00Z",
  "data": {
    ...
  }
}
```

### Markdown文件

**规范**：

- 遵循CommonMark标准
- 使用`make lint`验证
- 包含更新日期
- 使用相对路径链接

**模板**：

```markdown
# 标题

> 最后更新：2026-01-15

## 内容

...

---

**返回** → [框架文档首页](./README.md)
```

### Verse代码文件

**规范**：

- 遵循UEFN官方规范
- 包含文件头注释
- 注明依赖关系

**模板**：

```verse
# HealthComponent.verse
# 
# 功能：玩家健康管理组件
# 架构层级：L3 Component Layer
# 依赖：无
# 生成：Producer Cycle 5
# 质量评分：0.87

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

...
```

## 🔐 状态管理机制

### Git版本控制策略

**跟踪的文件**：

```gitignore
# 跟踪
/docs/
/skills/
/knowledge/
/assets/modules/
/agent.md

# 不跟踪（本地状态）
/.state/
/data/
/assets/composed/
```

**原因**：

- `.state/`和`data/`是运行时状态，每个部署不同
- 积木库(`assets/modules/`)应该版本控制
- 拼装产物(`assets/composed/`)是临时的

### 状态备份

**定期备份**：

```bash
# 备份索引配置
cp -r .state/indices .state/indices.backup.$(date +%Y%m%d)

# 备份质量历史
cp .state/quality-history.json backups/
```

**恢复策略**：

```bash
# 如果索引损坏，从备份恢复
cp -r .state/indices.backup.20260115 .state/indices
```

### 重置机制

**完全重置**（重新学习）：

```bash
# 1. 备份当前状态
tar -czf state-backup-$(date +%Y%m%d).tar.gz .state

# 2. 重置索引为随机
cat > .state/indices/feature-weights.json << EOF
{
  "zero_coupling": 0.50,
  "modularity": 0.50,
  "naming": 0.50,
  "error_handling": 0.50
}
EOF

# 3. 重置阶段
cat > .state/phase.json << EOF
{
  "current_phase": "production",
  "cycle_count": 0
}
EOF

# 4. 保留knowledge和assets（不删除已有积木）
```

## 📖 下一步

- **学习Skill定义** → [04-skill-definitions.md](./04-skill-definitions.md)
- **理解索引机制** → [05-index-mechanism.md](./05-index-mechanism.md)
- **查看完整工作流** → [06-workflow.md](./06-workflow.md)

---

**返回** → [框架文档首页](./README.md)
