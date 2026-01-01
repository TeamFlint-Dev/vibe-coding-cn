# Skill定义规范 - 自进化编码框架

## 🎯 4个元Skill总览

本框架定义4个元Skill（Meta-Skills），它们协同工作实现自进化循环：

```
┌─────────────────────────────────────────────┐
│           orchestrator.skill.md             │
│              (总调度器)                      │
│    决定何时调用哪个Skill，管理整体流程      │
└─────────────────────────────────────────────┘
         ↓               ↓               ↓
    ┌────────┐     ┌────────┐     ┌────────┐
    │Producer│     │Composer│     │Learner │
    │生产引擎│     │拼装引擎│     │学习引擎│
    └────────┘     └────────┘     └────────┘
```

## 📋 Skill定义通用模板

每个Skill文件遵循统一结构：

```markdown
---
name: skillName
version: 1.0.0
type: meta-skill
created: 2026-01-01
last_updated: 2026-01-15
requires: 
  - 依赖的其他Skill
  - Core/skills中的Skill
---

# Skill名称

> 一句话描述：这个Skill做什么

## 何时触发

[触发条件]

## 输入

- 输入1：描述
- 输入2：描述

## 输出

- 输出1：描述
- 输出2：描述

## 工作流程

### 步骤1：[步骤名]
[详细描述]

### 步骤2：[步骤名]
[详细描述]

## 渐进式披露策略

### 读取索引配置
[如何读取和解析索引]

### 披露决策
[根据权重决定披露什么]

### 披露内容
[具体披露的上下文]

## 与其他Skill的关系

- 调用：[被谁调用]
- 依赖：[依赖哪些Skill]
- 输出给：[输出给谁]

## 成功标准

[如何判断执行成功]

## 示例执行

[完整的执行示例]
```

## 🎼 orchestrator.skill.md - 总调度器

### 完整定义

```markdown
---
name: orchestrator
version: 1.0.0
type: meta-skill
created: 2026-01-01
requires: []
---

# Orchestrator - 总调度器

> 系统的大脑，决定在什么阶段调用哪个Skill

## 何时触发

- 系统启动时
- 用户发起新需求时
- 每个Skill执行完毕后

## 输入

- **用户需求**：明确的任务描述
- **系统状态**：`.state/phase.json`
- **覆盖情况**：`.state/coverage.json`

## 输出

- **执行计划**：Skill调用序列
- **阶段更新**：更新`.state/phase.json`

## 工作流程

### 步骤1：读取系统状态

\`\`\`python
state = read_json('.state/phase.json')
coverage = read_json('.state/coverage.json')

current_phase = state['current_phase']
# "production" | "composition" | "learning"
\`\`\`

### 步骤2：判断当前阶段

\`\`\`python
if current_phase == "production":
    if coverage['coverage_rate'] < 0.90:
        # 继续生产循环
        return call_producer()
    else:
        # 切换到拼装阶段
        return transition_to('composition')

elif current_phase == "composition":
    if user_has_new_requirement():
        return call_composer()
    else:
        return wait_for_requirement()

elif current_phase == "learning":
    return call_learner()
\`\`\`

### 步骤3：调用相应Skill

\`\`\`python
if action == 'produce':
    result = producer.run(task)
    learner.analyze(result)  # 每次产出后立即学习
    
elif action == 'compose':
    result = composer.run(requirement)
    
elif action == 'learn':
    result = learner.run(history)
\`\`\`

### 步骤4：更新系统状态

\`\`\`python
update_state({
    'cycle_count': state['cycle_count'] + 1,
    'last_action': action,
    'last_updated': now()
})
\`\`\`

## 渐进式披露策略

Orchestrator本身**不直接披露上下文**，而是：

1. 读取索引配置
2. 将索引传递给Producer/Composer/Learner
3. 由各Skill执行具体的披露策略

## 与其他Skill的关系

- **调用者**：用户、系统定时器
- **被调用者**：Producer、Composer、Learner
- **数据流**：状态管理 → 决策 → 调用子Skill

## 成功标准

- 能根据状态正确决策
- 阶段转换逻辑清晰
- 循环计数准确

## 示例执行

\`\`\`
用户：开始生产循环

Orchestrator:
  1. 读取 .state/phase.json
     current_phase = "production"
     cycle_count = 0
     coverage = 0.00
     
  2. 判断：coverage < 0.90，继续生产
  
  3. 调用 Producer:
     task = "Generate HealthComponent"
     
  4. Producer返回：
     output = "HealthComponent.verse"
     quality = 0.65
     
  5. 立即调用 Learner:
     分析产出，更新索引
     
  6. 更新状态：
     cycle_count = 1
     coverage = 0.01 (1/150能力点)
     
  7. 返回：成功，准备下一轮
\`\`\`
```

## 🏭 producer.skill.md - 生产引擎

### 完整定义

```markdown
---
name: producer
version: 1.0.0
type: meta-skill
created: 2026-01-01
requires:
  - Core/skills/programming/verseDev/*
---

# Producer - 代码积木生产引擎

> 探索UEFN能力边界，系统化生产代码积木

## 何时触发

- 覆盖率 < 目标（如90%）
- Orchestrator处于production阶段

## 输入

- **能力地图**：`knowledge/uefn/capability-map.json`
- **索引配置**：`.state/indices/*`
- **已覆盖能力**：`.state/coverage.json`

## 输出

- **代码模块**：`assets/modules/[category]/[ModuleName].verse`
- **元数据**：`assets/modules/[category]/metadata.json`
- **质量评分**：供Learner分析

## 工作流程

### 步骤1：选择待探索能力

\`\`\`python
capability_map = read_json('knowledge/uefn/capability-map.json')
coverage = read_json('.state/coverage.json')

# 筛选未覆盖的高优先级能力
uncovered = [
    cap for cap in capability_map['capabilities']
    if cap['id'] not in coverage['covered']
]

# 按优先级和难度排序
sorted_caps = sort_by(uncovered, 
    key=lambda c: (c['priority'], -c['difficulty'])
)

next_capability = sorted_caps[0]
# 例如：{"id": "player_health", "name": "玩家健康管理"}
\`\`\`

### 步骤2：读取索引配置

\`\`\`python
feature_weights = read_json('.state/indices/feature-weights.json')
# {
#   "zero_coupling": 0.92,
#   "modularity": 0.85,
#   "naming": 0.65
# }

example_index = read_json('.state/indices/example-index.json')
pattern_index = read_json('.state/indices/pattern-index.json')
\`\`\`

### 步骤3：渐进式披露上下文

\`\`\`python
context = []

# 3.1 披露模式文档（按权重）
for feature, weight in sorted(feature_weights.items(), 
                               key=lambda x: x[1], 
                               reverse=True):
    if weight >= 0.85:
        # 完整披露
        pattern_file = pattern_index[feature]['file']
        context.append(read_file(f'knowledge/patterns/{pattern_file}'))
        
    elif weight >= 0.70:
        # 详细摘要
        context.append(get_pattern_summary(feature))
        
    elif weight >= 0.50:
        # 简要提及
        context.append(get_pattern_brief(feature))

# 3.2 披露相关案例
for feature, weight in feature_weights.items():
    if weight >= 0.80:
        excellent_examples = example_index['by_feature'][feature]['excellent']
        for ex in excellent_examples[:3]:  # 最多3个
            context.append(read_file(f'knowledge/examples/excellent/{ex}'))

# 3.3 披露API摘要
apis = next_capability['apis']
for api in apis:
    context.append(get_api_doc(api))
\`\`\`

### 步骤4：调用Agent生成代码

\`\`\`python
prompt = f"""
基于以下上下文，生成一个实现"{next_capability['name']}"的Verse组件。

要求：
- 架构：SceneGraph L3 Component Layer
- 遵循以下特征（按重要性排序）：
  {format_features_by_weight(feature_weights)}

上下文：
{join(context)}

生成：{next_capability['name']}Component.verse
"""

code = agent.generate(prompt)
\`\`\`

### 步骤5：保存代码和元数据

\`\`\`python
output_path = f"assets/modules/{next_capability['category']}/{next_capability['name']}Component.verse"
write_file(output_path, code)

metadata = {
    "module": f"{next_capability['name']}Component",
    "capability_id": next_capability['id'],
    "cycle_produced": current_cycle,
    "disclosed_context_tokens": count_tokens(context),
    "feature_weights_used": feature_weights
}
write_json(f"{output_path}.metadata.json", metadata)
\`\`\`

### 步骤6：评估质量

\`\`\`python
quality_score = evaluate_code_quality(code, feature_weights)
# 返回：0.87

feature_scores = {}
for feature in feature_weights.keys():
    feature_scores[feature] = evaluate_feature(code, feature)
    # 例如：{"zero_coupling": 0.95, "modularity": 0.90}
\`\`\`

## 渐进式披露策略

### 披露决策矩阵

| 特征权重 | 模式文档 | 案例数量 | 总tokens |
|---------|---------|---------|---------|
| 0.85-1.0 | 完整文档(1500字) | 3个优秀案例 | ~3000 |
| 0.70-0.85 | 详细摘要(400字) | 2个案例 | ~1500 |
| 0.50-0.70 | 简要说明(100字) | 1个案例 | ~500 |
| < 0.50 | 不披露 | 0个 | 0 |

### 披露顺序

1. **高权重特征的模式** （权重降序）
2. **相关的优秀案例** （按特征匹配度）
3. **API参考文档** （按使用频率）

### 披露上下文示例

\`\`\`
# 索引配置
{
  "zero_coupling": 0.92,
  "modularity": 0.85,
  "naming": 0.65
}

# 实际披露内容
1. patterns/zero-coupling.md (完整, 1500字)
   + 3个优秀案例 (600字)
   
2. patterns/modularity.md (摘要, 400字)
   + 2个案例 (400字)
   
3. 命名规范 (简要, 100字)

总计：~3000字，Agent能充分吸收
\`\`\`

## 与其他Skill的关系

- **被调用**：Orchestrator
- **依赖**：Core/skills/programming/verseDev
- **输出给**：Learner（质量分析）、Composer（积木库）

## 成功标准

- 生成的代码符合Verse语法
- 质量评分 >= 0.60（初期）或 >= 0.85（后期）
- 覆盖了目标能力点

## 示例执行

\`\`\`
任务：生成玩家健康管理组件

Producer:
  1. 选择能力：player_health
  
  2. 读取索引：
     zero_coupling: 0.92
     modularity: 0.85
     naming: 0.65
     
  3. 披露上下文：
     ✓ zero-coupling.md (完整)
     ✓ 3个优秀案例
     ✓ modularity摘要
     ✓ 2个案例
     ✓ 命名规范简要
     → 总计 3000 tokens
     
  4. Agent生成：
     HealthComponent.verse (120行)
     
  5. 保存：
     assets/modules/health/HealthComponent.verse
     + metadata.json
     
  6. 评估质量：
     overall: 0.87
     zero_coupling: 0.95
     modularity: 0.90
     naming: 0.80
     
  7. 返回：成功，质量0.87
\`\`\`
```

## 🧩 composer.skill.md - 拼装引擎

### 完整定义

```markdown
---
name: composer
version: 1.0.0
type: meta-skill
created: 2026-01-01
requires:
  - producer (间接，使用其产出)
---

# Composer - 代码积木拼装引擎

> 根据真实需求，快速拼装已有积木，胶水编程

## 何时触发

- 用户提出实际功能需求
- Orchestrator处于composition阶段

## 输入

- **功能需求**：用户描述的完整功能
- **积木库**：`assets/modules/*`
- **索引配置**：`.state/indices/example-index.json`

## 输出

- **组装代码**：`assets/composed/[FeatureName]/`
  - `main.verse` - 主入口
  - `glue-code.verse` - 胶水代码
  - `components.txt` - 积木清单
- **复用报告**：积木复用比例

## 工作流程

### 步骤1：分析需求

\`\`\`python
requirement = """
实现玩家战斗系统，包括：
- 健康管理
- 伤害计算
- 技能释放
- 战斗UI反馈
"""

# 提取子需求
sub_requirements = analyze_requirement(requirement)
# [
#   "健康管理",
#   "伤害计算",
#   "技能释放",
#   "战斗UI反馈"
# ]
\`\`\`

### 步骤2：检索积木库

\`\`\`python
modules = []
for sub_req in sub_requirements:
    # 查询已有积木
    matches = search_modules(sub_req)
    modules.append({
        'requirement': sub_req,
        'matches': matches,
        'status': 'found' if matches else 'missing'
    })

# 结果：
# [
#   {'requirement': '健康管理', 'matches': ['HealthComponent.verse'], 'status': 'found'},
#   {'requirement': '伤害计算', 'matches': ['DamageCalculator.verse'], 'status': 'found'},
#   {'requirement': '技能释放', 'matches': [], 'status': 'missing'},
#   {'requirement': '战斗UI', 'matches': ['CombatUI.verse'], 'status': 'found'}
# ]
\`\`\`

### 步骤3：渐进式披露上下文

\`\`\`python
context = []

# 3.1 披露找到的积木代码
for module in modules:
    if module['status'] == 'found':
        for match in module['matches']:
            code = read_file(f'assets/modules/{match}')
            context.append({
                'type': 'existing_module',
                'content': code,
                'reusable': True
            })

# 3.2 披露索引中的相关案例（用于生成缺失积木）
example_index = read_json('.state/indices/example-index.json')
for module in modules:
    if module['status'] == 'missing':
        scenario_key = map_requirement_to_scenario(module['requirement'])
        examples = example_index['by_scenario'].get(scenario_key, [])
        for ex in examples[:2]:
            context.append({
                'type': 'reference_example',
                'content': read_file(f'knowledge/examples/excellent/{ex}'),
                'for_generating': module['requirement']
            })

# 3.3 披露集成模式
context.append(read_file('knowledge/patterns/component-integration.md'))
\`\`\`

### 步骤4：拼装或生成

\`\`\`python
prompt = f"""
基于以下已有积木和上下文，组装一个完整的"{requirement}"系统。

已有积木（直接复用）：
{format_existing_modules(context)}

缺失功能（需生成）：
{format_missing_modules(modules)}

参考案例：
{format_reference_examples(context)}

要求：
1. 最大化复用已有积木
2. 只为缺失功能编写新代码
3. 使用胶水代码连接各积木
4. 遵循零耦合原则
"""

result = agent.compose(prompt)
\`\`\`

### 步骤5：保存拼装结果

\`\`\`python
output_dir = f"assets/composed/PlayerCombatSystem/"
os.makedirs(output_dir, exist_ok=True)

# 主入口
write_file(f"{output_dir}/main.verse", result['main'])

# 胶水代码（如有）
if result['glue_code']:
    write_file(f"{output_dir}/glue-code.verse", result['glue_code'])

# 积木清单
components_list = format_components_list(modules)
write_file(f"{output_dir}/components.txt", components_list)

# 元数据
metadata = {
    "feature": "PlayerCombatSystem",
    "requirements": sub_requirements,
    "reused_modules": [m for m in modules if m['status'] == 'found'],
    "new_code_lines": count_lines(result['glue_code']),
    "reuse_ratio": calculate_reuse_ratio(modules, result)
}
write_json(f"{output_dir}/metadata.json", metadata)
\`\`\`

## 渐进式披露策略

### 披露优先级

1. **已有积木代码**（完整披露）
2. **集成模式文档**（如何连接积木）
3. **相关参考案例**（用于生成缺失积木）

### 披露内容

\`\`\`
# 找到3个积木，缺失1个积木

披露内容：
1. HealthComponent.verse (完整代码)
2. DamageCalculator.verse (完整代码)
3. CombatUI.verse (完整代码)
4. component-integration.md (集成模式)
5. 技能系统参考案例 (2个案例，用于生成SkillSystem)

Agent任务：
- 复用已有3个积木（80%代码量）
- 生成SkillSystem（20%代码量）
- 编写胶水代码连接各积木
\`\`\`

## 与其他Skill的关系

- **被调用**：Orchestrator（用户需求到来时）
- **依赖**：Producer的产出（积木库）
- **输出给**：用户（可交付的完整功能）

## 成功标准

- 复用率 >= 70%
- 生成的系统功能完整
- 积木连接符合零耦合原则

## 示例执行

\`\`\`
需求：实现玩家战斗系统

Composer:
  1. 分析需求：
     - 健康管理
     - 伤害计算
     - 技能释放
     - 战斗UI
     
  2. 检索积木：
     ✓ HealthComponent (found)
     ✓ DamageCalculator (found)
     ✗ SkillSystem (missing)
     ✓ CombatUI (found)
     
  3. 披露上下文：
     - 3个已有积木代码（完整）
     - 集成模式文档
     - 2个技能系统参考案例
     
  4. Agent拼装：
     - 复用3个积木（1200行）
     - 生成SkillSystem（300行）
     - 胶水代码（50行）
     
  5. 保存结果：
     assets/composed/PlayerCombatSystem/
     ├─ main.verse
     ├─ glue-code.verse
     └─ components.txt
     
  6. 复用报告：
     复用率：77% (1200/1550行)
     
  7. 返回：成功，可交付
\`\`\`
```

## 🎓 learner.skill.md - 学习引擎

### 完整定义

```markdown
---
name: learner
version: 1.0.0
type: meta-skill
created: 2026-01-01
requires: []
---

# Learner - 反馈学习引擎

> 分析产出质量，优化索引配置，驱动系统进化

## 何时触发

- 每次Producer生成代码后（立即）
- 定期批量分析（如每10个循环）
- 质量评分发生波动时

## 输入

- **历史数据**：`data/experiences/*.json`
- **质量评分**：`data/quality-scores/scores.csv`
- **当前索引**：`.state/indices/*`

## 输出

- **更新的索引**：`.state/indices/feature-weights.json`
- **学习报告**：`data/learning-reports/report-[cycle].json`

## 工作流程

### 步骤1：收集反馈数据

\`\`\`python
# 读取最近N次运行的数据
recent_runs = []
for i in range(1, current_cycle + 1):
    run_data = read_json(f'data/experiences/run-{i:03d}.json')
    recent_runs.append({
        'cycle': i,
        'quality_score': run_data['output']['quality_score'],
        'feature_scores': run_data['analysis']['features'],
        'weights_used': run_data['input']['indices']['feature_weights']
    })
\`\`\`

### 步骤2：特征相关性分析

\`\`\`python
# 计算每个特征与质量分数的相关性
correlations = {}

for feature in ['zero_coupling', 'modularity', 'naming', ...]:
    # 提取特征分数和总质量分数
    feature_scores = [r['feature_scores'][feature] for r in recent_runs]
    quality_scores = [r['quality_score'] for r in recent_runs]
    
    # 计算Pearson相关系数
    corr = pearson_correlation(feature_scores, quality_scores)
    correlations[feature] = corr

# 结果示例：
# {
#   'zero_coupling': 0.92,   # 强正相关
#   'modularity': 0.85,      # 强正相关
#   'naming': 0.65,          # 中等正相关
#   'comments': 0.30         # 弱正相关
# }
\`\`\`

### 步骤3：权重更新算法

\`\`\`python
# 读取当前权重
current_weights = read_json('.state/indices/feature-weights.json')

# 平滑更新
LEARNING_RATE = 0.2
new_weights = {}

for feature, current_weight in current_weights.items():
    correlation = correlations[feature]
    
    # 将相关系数 [-1, 1] 映射到 [0, 1]
    normalized_corr = (correlation + 1) / 2
    
    # 加权平均
    new_weight = (
        current_weight * (1 - LEARNING_RATE) +
        normalized_corr * LEARNING_RATE
    )
    
    # 限制范围 [0.20, 0.95]
    new_weight = max(0.20, min(0.95, new_weight))
    
    new_weights[feature] = round(new_weight, 2)

# 示例：
# 原权重: {'zero_coupling': 0.50, 'naming': 0.50}
# 相关性: {'zero_coupling': 0.92, 'naming': 0.30}
# 新权重: {'zero_coupling': 0.63, 'naming': 0.48}
\`\`\`

### 步骤4：案例索引优化

\`\`\`python
# 统计案例的使用效果
example_performance = {}

for run in recent_runs:
    disclosed_examples = run['disclosed_context']['examples']
    quality = run['quality_score']
    
    for example in disclosed_examples:
        if example not in example_performance:
            example_performance[example] = []
        example_performance[example].append(quality)

# 计算平均质量
example_avg_quality = {
    ex: mean(scores)
    for ex, scores in example_performance.items()
}

# 更新案例索引，提升高质量案例的权重
example_index = read_json('.state/indices/example-index.json')
for feature in example_index['by_feature']:
    examples = example_index['by_feature'][feature]['excellent']
    # 按平均质量重新排序
    examples.sort(key=lambda ex: example_avg_quality.get(ex, 0), reverse=True)
    example_index['by_feature'][feature]['excellent'] = examples

write_json('.state/indices/example-index.json', example_index)
\`\`\`

### 步骤5：判断收敛

\`\`\`python
# 检查质量趋势
last_5_scores = [r['quality_score'] for r in recent_runs[-5:]]
variance = calculate_variance(last_5_scores)

# 检查权重变化
weight_changes = sum([
    abs(new_weights[f] - current_weights[f])
    for f in new_weights
]) / len(new_weights)

is_converged = (
    variance < 0.02 and         # 质量稳定
    weight_changes < 0.05       # 权重稳定
)

if is_converged:
    log("系统已收敛，索引优化完成")
    update_phase("stable")
\`\`\`

### 步骤6：生成学习报告

\`\`\`python
report = {
    "cycle": current_cycle,
    "timestamp": now(),
    "correlations": correlations,
    "weight_changes": {
        feature: {
            "old": current_weights[feature],
            "new": new_weights[feature],
            "delta": new_weights[feature] - current_weights[feature]
        }
        for feature in new_weights
    },
    "quality_trend": {
        "last_5_avg": mean(last_5_scores),
        "variance": variance,
        "trend": "improving" if last_5_scores[-1] > last_5_scores[0] else "declining"
    },
    "is_converged": is_converged
}

write_json(f'data/learning-reports/report-{current_cycle:03d}.json', report)
\`\`\`

## 渐进式披露策略

Learner **不直接披露上下文给Agent**，而是：

1. **分析历史披露效果**
2. **优化索引配置**
3. **影响后续Producer/Composer的披露策略**

**间接披露**：通过调整权重，让Producer/Composer下次披露更精准的内容。

## 与其他Skill的关系

- **被调用**：Orchestrator（每次Producer后）
- **输入来源**：Producer的产出数据
- **输出影响**：下次Producer/Composer的披露策略

## 成功标准

- 权重更新逻辑正确
- 质量趋势向上
- 收敛判断准确

## 示例执行

\`\`\`
任务：分析前5轮循环，优化索引

Learner:
  1. 收集数据：
     Cycle 1: 质量0.65, zero_coupling=0.70, naming=0.60
     Cycle 2: 质量0.72, zero_coupling=0.78, naming=0.62
     ...
     Cycle 5: 质量0.80, zero_coupling=0.85, naming=0.68
     
  2. 相关性分析：
     zero_coupling ↔ 质量: 0.92 (强相关)
     modularity ↔ 质量: 0.85
     naming ↔ 质量: 0.65
     
  3. 更新权重：
     zero_coupling: 0.50 → 0.63 (↑)
     modularity: 0.50 → 0.57 (↑)
     naming: 0.50 → 0.53 (↑)
     
  4. 案例索引优化：
     重新排序案例，提升高质量案例优先级
     
  5. 收敛检查：
     variance = 0.03 (> 0.02)
     weight_changes = 0.08 (> 0.05)
     → 未收敛，继续循环
     
  6. 生成报告：
     data/learning-reports/report-005.json
     
  7. 返回：成功，索引已更新
\`\`\`
```

## 📊 Skill协作流程图

```
用户发起任务
    ↓
┌──────────────────────┐
│   Orchestrator       │
│   (判断阶段)          │
└──────────────────────┘
    ↓
    ├─→ [生产阶段] → Producer
    │                  ├─ 读取索引
    │                  ├─ 渐进式披露
    │                  ├─ Agent生成
    │                  └─ 输出代码
    │                       ↓
    │                   Learner
    │                  ├─ 分析质量
    │                  ├─ 计算相关性
    │                  └─ 更新索引
    │
    ├─→ [拼装阶段] → Composer
    │                  ├─ 检索积木
    │                  ├─ 披露上下文
    │                  ├─ Agent拼装
    │                  └─ 输出系统
    │
    └─→ [学习阶段] → Learner
                       (批量分析)
```

## 🔍 Skill对比总结

| Skill | 主要职责 | 索引使用 | 披露策略 | 输出 |
|-------|---------|---------|---------|------|
| **Orchestrator** | 流程调度 | 读取不使用 | 不披露 | 调用序列 |
| **Producer** | 生产积木 | 读取并依赖 | 完整披露 | 代码模块 |
| **Composer** | 拼装积木 | 读取并依赖 | 选择性披露 | 完整系统 |
| **Learner** | 优化索引 | 分析并更新 | 不披露 | 新索引配置 |

## 📖 下一步

- **理解索引机制** → [05-index-mechanism.md](./05-index-mechanism.md)
- **查看完整工作流** → [06-workflow.md](./06-workflow.md)
- **学习进化机制** → [07-evolution-mechanism.md](./07-evolution-mechanism.md)

---

**返回** → [框架文档首页](./README.md)
