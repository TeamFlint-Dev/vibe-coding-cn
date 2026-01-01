# 完整工作流 - 自进化编码框架

## 🔄 工作流总览

框架有三个主要流程：

1. **初始化流程** - 系统首次启动
2. **生产循环（Producer）** - 探索能力，生产积木
3. **拼装流程（Composer）** - 真实需求，拼装积木
4. **学习流程（Learner）** - 分析反馈，优化索引

```
┌──────────────────┐
│  初始化流程       │
│  (一次性)         │
└────────┬─────────┘
         ↓
┌──────────────────┐       ┌──────────────────┐
│  生产循环         │←──────│  学习流程         │
│  (重复执行)       │       │  (持续优化)       │
└────────┬─────────┘       └──────────────────┘
         ↓
┌──────────────────┐
│  能力覆盖90%+    │
└────────┬─────────┘
         ↓
┌──────────────────┐
│  拼装流程         │
│  (按需执行)       │
└──────────────────┘
```

## 🎬 初始化流程

### 目标

建立框架运行所需的基础结构和配置。

### 步骤详解

#### 步骤1：创建目录结构

```bash
# 创建所有必需目录
mkdir -p docs/framework
mkdir -p skills
mkdir -p .state/indices
mkdir -p knowledge/{uefn/api-digests,patterns,examples/excellent,examples/average}
mkdir -p assets/{modules,composed}
mkdir -p data/{experiences,quality-scores,traces,learning-reports}
```

#### 步骤2：初始化索引配置

**创建特征权重索引**：

```bash
cat > .state/indices/feature-weights.json << 'EOF'
{
  "version": "1.0.0",
  "last_updated": "2026-01-01T00:00:00Z",
  "learning_rate": 0.20,
  "weights": {
    "zero_coupling": {"value": 0.50, "history": [0.50], "correlation": 0, "confidence": 0.50},
    "modularity": {"value": 0.50, "history": [0.50], "correlation": 0, "confidence": 0.50},
    "naming": {"value": 0.50, "history": [0.50], "correlation": 0, "confidence": 0.50},
    "error_handling": {"value": 0.50, "history": [0.50], "correlation": 0, "confidence": 0.50},
    "testability": {"value": 0.50, "history": [0.50], "correlation": 0, "confidence": 0.50},
    "performance": {"value": 0.50, "history": [0.50], "correlation": 0, "confidence": 0.50},
    "comments": {"value": 0.50, "history": [0.50], "correlation": 0, "confidence": 0.50}
  },
  "metadata": {
    "cycles_analyzed": 0,
    "converged": false
  }
}
EOF
```

**创建案例索引**：

```bash
cat > .state/indices/example-index.json << 'EOF'
{
  "version": "1.0.0",
  "by_feature": {},
  "by_scenario": {},
  "metadata": {
    "total_examples": 0,
    "excellent_count": 0,
    "average_count": 0
  }
}
EOF
```

**创建模式索引**：

```bash
cat > .state/indices/pattern-index.json << 'EOF'
{
  "version": "1.0.0",
  "patterns": {},
  "scenario_patterns": {}
}
EOF
```

#### 步骤3：准备知识库

**复制UEFN API摘要**（从Core复用）：

```bash
# 如果已有Core/skills/programming/verseDev/shared/api-digests
ln -s ../../../Core/skills/programming/verseDev/shared/api-digests \
      knowledge/uefn/api-digests
```

**创建能力地图**：

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
        }
      ]
    }
  }
}
```

**添加初始模式文档**：

从现有`Core/documents/`或手动创建关键模式（zero-coupling, modularity等）。

#### 步骤4：初始化系统状态

```bash
cat > .state/phase.json << 'EOF'
{
  "current_phase": "production",
  "cycle_count": 0,
  "started_at": "2026-01-01T00:00:00Z",
  "last_updated": "2026-01-01T00:00:00Z",
  "target_coverage": 0.90,
  "current_coverage": 0.00
}
EOF
```

```bash
cat > .state/coverage.json << 'EOF'
{
  "total_capabilities": 150,
  "covered_capabilities": 0,
  "coverage_rate": 0.00,
  "capabilities": {}
}
EOF
```

#### 步骤5：创建Skill文件

将4个元Skill定义保存到 `skills/`：

```bash
# 从文档中提取Skill定义
# orchestrator.skill.md
# producer.skill.md
# composer.skill.md
# learner.skill.md
```

### 验证初始化

```bash
# 检查目录结构
ls -R docs skills .state knowledge assets data

# 检查索引文件格式
jq . .state/indices/feature-weights.json
jq . .state/indices/example-index.json
jq . .state/indices/pattern-index.json

# 检查状态文件
jq . .state/phase.json
jq . .state/coverage.json
```

## 🏭 生产循环（Producer）

### 目标

系统化探索UEFN能力边界，生产代码积木。

### 完整对话示例

```
=== Cycle 1: 生产HealthComponent ===

[User]
开始生产循环

[Orchestrator]
📊 系统状态检查：
- 当前阶段：production
- 循环计数：0
- 覆盖率：0.00/0.90

✓ 决策：调用Producer
✓ 目标：从能力地图选择首个能力

[Producer]
📝 任务准备：
1. 读取能力地图
   → 选中：player_health（高优先级，简单）

2. 读取索引配置
   feature-weights.json:
   {
     "zero_coupling": 0.50,
     "modularity": 0.50,
     "naming": 0.50,
     ...
   }
   
   (首轮：所有权重0.50，随机状态)

3. 渐进式披露策略
   ├─ zero_coupling (0.50)
   │   → 披露：patterns/zero-coupling.md (摘要，400字)
   │   → 披露：1个参考案例
   ├─ modularity (0.50)
   │   → 披露：patterns/modularity.md (摘要，400字)
   │   → 披露：1个参考案例
   └─ naming (0.50)
       → 披露：命名规范(简要，100字)
   
   总上下文：~1500字

4. 调用Agent生成代码

[Agent]
基于以下上下文生成HealthComponent...

(生成代码，120行)

[Producer]
✅ 代码生成完成：
- 文件：assets/modules/health/HealthComponent.verse
- 行数：120
- 时间：45秒

5. 质量评估
   运行评估工具...
   
   结果：
   - 总质量：0.65
   - zero_coupling：0.70 ✓
   - modularity：0.68 ✓
   - naming：0.60 ⚠️
   - error_handling：0.55 ⚠️

[Learner]
🎓 立即学习：
1. 记录经验数据
   data/experiences/run-001.json:
   {
     "cycle": 1,
     "quality": 0.65,
     "features": {
       "zero_coupling": 0.70,
       "modularity": 0.68,
       "naming": 0.60
     }
   }

2. 相关性分析
   (数据不足，至少需要5个样本)
   → 跳过权重更新

[Orchestrator]
📈 更新系统状态：
- cycle_count: 0 → 1
- coverage: 0.00 → 0.01 (1/150)
- last_updated: 2026-01-01T10:30:00Z

✓ 决策：继续生产循环（coverage < 0.90）

=== Cycle 2-9: 继续生产其他组件 ===

(省略中间过程，每轮类似)

=== Cycle 10: 首次权重更新 ===

[Learner]
🎓 批量学习（分析前10轮）：

1. 收集数据
   10个产出样本已积累

2. 相关性分析
   计算：特征分数 ↔ 质量分数
   
   结果：
   - zero_coupling: 相关系数 0.88 (强相关)
   - modularity: 相关系数 0.82
   - naming: 相关系数 0.60
   - error_handling: 相关系数 0.55
   - comments: 相关系数 0.25 (弱相关)

3. 权重更新
   zero_coupling: 0.50 → 0.63 (↑)
   modularity: 0.50 → 0.57 (↑)
   naming: 0.50 → 0.52 (↑)
   comments: 0.50 → 0.45 (↓)

4. 更新索引配置
   ✓ .state/indices/feature-weights.json 已更新

📊 学习报告：
data/learning-reports/report-010.json

[Orchestrator]
📢 索引已优化，下一轮披露策略将改进

=== Cycle 11: 使用新索引 ===

[Producer]
📝 任务准备：
1. 选择能力：player_inventory

2. 读取索引配置（已更新）
   {
     "zero_coupling": 0.63,  ← 提升
     "modularity": 0.57,
     "naming": 0.52,
     "comments": 0.45       ← 降低
   }

3. 渐进式披露策略（已改进）
   ├─ zero_coupling (0.63)
   │   → 披露：patterns/zero-coupling.md (详细摘要，600字) ← 升级
   │   → 披露：2个优秀案例 ← 增加
   ├─ modularity (0.57)
   │   → 披露：patterns/modularity.md (摘要，400字)
   │   → 披露：1个案例
   └─ naming (0.52)
       → 披露：命名规范(简要，100字)
   
   总上下文：~2000字（比首轮多500字，更聚焦）

4. Agent生成代码

[Agent]
基于改进的上下文生成InventoryManager...

(生成代码，质量0.72，比首轮提升)

=== Cycle 50: 系统稳定 ===

[Learner]
🎓 分析Cycle 46-50：

1. 质量趋势
   Cycle 46: 0.85
   Cycle 47: 0.87
   Cycle 48: 0.86
   Cycle 49: 0.87
   Cycle 50: 0.88
   
   平均：0.866
   方差：0.011 (< 0.02阈值) ✓

2. 权重变化
   所有特征权重变化 < 0.05 ✓
   
   稳定权重：
   {
     "zero_coupling": 0.92,
     "modularity": 0.85,
     "naming": 0.65,
     "error_handling": 0.60,
     "testability": 0.58,
     "performance": 0.45,
     "comments": 0.35
   }

3. 收敛判断
   ✅ 系统已收敛！

[Orchestrator]
📊 更新系统状态：
- current_phase: production → stable
- converged: true
- coverage: 0.92 (> 0.90目标) ✓

🎉 生产阶段完成！
- 总循环：50轮
- 总积木：138个
- 覆盖率：92%
- 平均质量：0.87

✓ 准备进入拼装阶段
```

## 🧩 拼装流程（Composer）

### 目标

根据真实需求，快速拼装已有积木，实现完整功能。

### 完整对话示例

```
=== 真实需求到来 ===

[User]
需求：实现玩家战斗系统
包括：
- 健康管理
- 伤害计算
- 技能释放
- 战斗UI反馈

[Orchestrator]
📊 系统状态检查：
- 当前阶段：composition
- 积木库规模：138个模块
- 索引状态：已收敛

✓ 决策：调用Composer

[Composer]
📝 需求分析：

1. 分解子需求
   ├─ 健康管理 (health_management)
   ├─ 伤害计算 (damage_calculation)
   ├─ 技能释放 (skill_system)
   └─ 战斗UI (combat_ui)

2. 检索积木库
   
   健康管理：
   ✓ 找到：assets/modules/health/HealthComponent.verse
   质量：0.87，完美匹配
   
   伤害计算：
   ✓ 找到：assets/modules/combat/DamageCalculator.verse
   质量：0.85，完美匹配
   
   技能释放：
   ✗ 未找到匹配的积木
   
   战斗UI：
   ✓ 找到：assets/modules/ui/CombatUI.verse
   质量：0.82，完美匹配

3. 统计复用情况
   - 已有积木：3/4 (75%)
   - 需新写：1/4 (25%)

4. 渐进式披露

   [已有积木]
   
   (1) HealthComponent.verse (完整代码)
   ```verse
   # 健康管理组件
   using { /Fortnite.com/Devices }
   
   health_component := class(creative_device):
       ...
   ```
   
   (2) DamageCalculator.verse (完整代码)
   ```verse
   # 伤害计算器
   ...
   ```
   
   (3) CombatUI.verse (完整代码)
   ```verse
   # 战斗UI组件
   ...
   ```
   
   [集成模式]
   
   knowledge/patterns/component-integration.md:
   ```markdown
   # 组件集成模式
   
   使用消息系统连接组件：
   - HealthComponent 发送 "health_changed" 消息
   - DamageCalculator 监听 "attack_occurred" 消息
   - CombatUI 监听 "health_changed" 消息
   ...
   ```
   
   [缺失功能参考]
   
   查询案例索引：by_scenario["skill_system"]
   → 找到2个相关案例：
   
   (1) MagicSkillSystem.verse (参考)
   (2) WeaponSkillSystem.verse (参考)

5. 调用Agent拼装

[Agent]
基于以下内容组装PlayerCombatSystem：

已有积木（直接复用）：
1. HealthComponent.verse
2. DamageCalculator.verse
3. CombatUI.verse

需生成（参考案例）：
1. SkillSystem.verse (参考MagicSkillSystem)

集成要求：
- 使用消息系统连接组件
- 遵循零耦合原则

(开始组装...)

生成结果：

1. 主入口文件 (main.verse)
```verse
# PlayerCombatSystem 主入口
using { /Fortnite.com/Devices }

# 复用已有组件
var HealthComp: health_component = health_component{}
var DamageCalc: damage_calculator = damage_calculator{}
var CombatUIComp: combat_ui = combat_ui{}

# 新生成的技能系统
var SkillSys: skill_system = skill_system{}

# 胶水代码：连接组件
OnAttack():void = {
    DamageCalc.CalculateDamage(...)
    HealthComp.TakeDamage(...)
    CombatUIComp.UpdateDisplay(...)
}
```

2. 新生成的SkillSystem (300行)
```verse
# 技能系统（基于参考案例生成）
skill_system := class(creative_device):
    ...
```

3. 胶水代码 (50行)
```verse
# 组件连接逻辑
...
```

[Composer]
✅ 拼装完成：

保存结果：
- assets/composed/PlayerCombatSystem/main.verse
- assets/composed/PlayerCombatSystem/glue-code.verse
- assets/composed/PlayerCombatSystem/components.txt

统计：
- 总代码：1550行
- 复用代码：1200行 (77%)
- 新写代码：300行 (19%)
- 胶水代码：50行 (3%)

📊 复用报告：
{
  "reuse_ratio": 0.77,
  "reused_modules": ["HealthComponent", "DamageCalculator", "CombatUI"],
  "new_modules": ["SkillSystem"],
  "glue_code_lines": 50
}

[Orchestrator]
🎉 拼装成功！
可交付文件：assets/composed/PlayerCombatSystem/

预计时间节省：
- 传统开发：14小时
- 框架拼装：4小时
- 节省：71%
```

## 🎓 学习流程（Learner）

### 目标

持续分析反馈，优化索引配置，驱动质量螺旋上升。

### 工作节奏

```
每次Producer产出后：
  → 立即记录经验数据

每5轮循环：
  → 尝试相关性分析
  → 如果数据足够，更新权重

每10轮循环：
  → 生成学习报告
  → 检查收敛情况

质量波动时：
  → 触发深度分析
  → 检查是否有异常
```

### 学习报告示例

```json
{
  "cycle": 10,
  "timestamp": "2026-01-05T10:00:00Z",
  "analysis_period": {
    "from_cycle": 1,
    "to_cycle": 10,
    "samples": 10
  },
  "correlations": {
    "zero_coupling": 0.88,
    "modularity": 0.82,
    "naming": 0.60,
    "error_handling": 0.55,
    "testability": 0.48,
    "performance": 0.30,
    "comments": 0.25
  },
  "weight_changes": {
    "zero_coupling": {
      "old": 0.50,
      "new": 0.63,
      "delta": 0.13,
      "reason": "强相关，权重上升"
    },
    "comments": {
      "old": 0.50,
      "new": 0.45,
      "delta": -0.05,
      "reason": "弱相关，权重下降"
    }
  },
  "quality_trend": {
    "average": 0.68,
    "variance": 0.035,
    "trend": "improving",
    "first_5_avg": 0.65,
    "last_5_avg": 0.71,
    "improvement": 0.06
  },
  "convergence_status": {
    "is_converged": false,
    "variance_threshold": 0.02,
    "current_variance": 0.035,
    "weight_change_threshold": 0.05,
    "current_weight_change": 0.08
  },
  "recommendations": [
    "继续循环，尚未收敛",
    "zero_coupling和modularity是关键特征",
    "comments权重可进一步降低"
  ]
}
```

## 📊 完整循环示例（端到端）

```
Day 1: 初始化
  → 创建目录结构
  → 初始化索引配置
  → 准备知识库
  → 时间：2小时

Day 2-3: 生产循环 (Cycle 1-20)
  → 每天10个积木
  → 质量从0.65提升到0.75
  → 时间：16小时

Day 4-5: 生产循环 (Cycle 21-40)
  → 每天10个积木
  → 质量从0.75提升到0.83
  → 索引逐渐优化
  → 时间：16小时

Day 6-7: 生产循环 (Cycle 41-50)
  → 每天5个积木（剩余高难度能力）
  → 质量稳定在0.85-0.88
  → 系统收敛
  → 时间：8小时

Day 8: 真实需求拼装
  → 需求1：玩家战斗系统（4小时）
  → 需求2：道具管理系统（3小时）
  → 需求3：多人匹配系统（5小时）
  → 复用率：70-80%
  → 时间：12小时

总计：54小时（传统方式需要150小时+）
节省：64%
```

## 📖 下一步

- **学习进化机制** → [07-evolution-mechanism.md](./07-evolution-mechanism.md)
- **开始实施** → [08-implementation-guide.md](./08-implementation-guide.md)

---

**返回** → [框架文档首页](./README.md)
