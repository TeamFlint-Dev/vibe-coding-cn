# 索引机制详解 - 自进化编码框架

## 🎯 索引机制总览

索引是框架进化的**核心**，它定义了"在什么情况下，应该给Agent看什么"。

```
┌─────────────────────────────────────────┐
│          索引配置文件（进化核心）         │
├─────────────────────────────────────────┤
│  feature-weights.json   特征权重索引    │
│  example-index.json     案例选择索引    │
│  pattern-index.json     模式引用索引    │
└─────────────────────────────────────────┘
         ↓ 驱动
┌─────────────────────────────────────────┐
│          渐进式披露策略                  │
├─────────────────────────────────────────┤
│  根据索引权重，选择性展示上下文给Agent  │
└─────────────────────────────────────────┘
         ↓ 影响
┌─────────────────────────────────────────┐
│          Agent产出质量                   │
└─────────────────────────────────────────┘
         ↓ 反馈
┌─────────────────────────────────────────┐
│          Learner分析并更新索引           │
└─────────────────────────────────────────┘
```

## 📇 feature-weights.json - 特征权重索引

### 文件结构

**位置**：`.state/indices/feature-weights.json`

**格式**：

```json
{
  "version": "1.2.0",
  "last_updated": "2026-01-15T10:30:00Z",
  "learning_rate": 0.20,
  "weights": {
    "zero_coupling": {
      "value": 0.92,
      "history": [0.50, 0.63, 0.75, 0.85, 0.92],
      "correlation": 0.92,
      "confidence": 0.95
    },
    "modularity": {
      "value": 0.85,
      "history": [0.50, 0.57, 0.68, 0.78, 0.85],
      "correlation": 0.85,
      "confidence": 0.90
    },
    "naming": {
      "value": 0.65,
      "history": [0.50, 0.53, 0.58, 0.62, 0.65],
      "correlation": 0.65,
      "confidence": 0.80
    },
    "error_handling": {
      "value": 0.60,
      "history": [0.50, 0.52, 0.55, 0.58, 0.60],
      "correlation": 0.55,
      "confidence": 0.75
    },
    "testability": {
      "value": 0.58,
      "history": [0.50, 0.51, 0.53, 0.56, 0.58],
      "correlation": 0.50,
      "confidence": 0.70
    },
    "performance": {
      "value": 0.45,
      "history": [0.50, 0.48, 0.46, 0.45, 0.45],
      "correlation": 0.20,
      "confidence": 0.60
    },
    "comments": {
      "value": 0.35,
      "history": [0.50, 0.45, 0.40, 0.37, 0.35],
      "correlation": 0.10,
      "confidence": 0.55
    }
  },
  "metadata": {
    "cycles_analyzed": 50,
    "last_significant_change": "2026-01-12T15:00:00Z",
    "converged": false,
    "convergence_target": 0.05
  }
}
```

### 字段说明

| 字段 | 说明 | 范围 | 用途 |
|-----|------|------|------|
| `value` | 当前权重值 | 0.20-0.95 | 决定披露程度 |
| `history` | 历史权重值 | 数组 | 追踪进化轨迹 |
| `correlation` | 与质量的相关系数 | -1 到 1 | 学习依据 |
| `confidence` | 权重置信度 | 0-1 | 权重可信程度 |

### 初始化

**首次创建**（所有权重随机）：

```json
{
  "version": "1.0.0",
  "learning_rate": 0.20,
  "weights": {
    "zero_coupling": {"value": 0.50, "history": [0.50]},
    "modularity": {"value": 0.50, "history": [0.50]},
    "naming": {"value": 0.50, "history": [0.50]},
    "error_handling": {"value": 0.50, "history": [0.50]},
    "testability": {"value": 0.50, "history": [0.50]},
    "performance": {"value": 0.50, "history": [0.50]},
    "comments": {"value": 0.50, "history": [0.50]}
  }
}
```

**使用领域知识初始化**（可选）：

```json
{
  "weights": {
    "zero_coupling": {"value": 0.75, "history": [0.75]},
    "modularity": {"value": 0.70, "history": [0.70]},
    "naming": {"value": 0.60, "history": [0.60]},
    ...
  }
}
```

### 如何从反馈中优化

#### 更新算法

```python
def update_feature_weights(current_weights, correlations, learning_rate=0.20):
    """
    根据相关性更新特征权重
    
    Args:
        current_weights: 当前权重字典
        correlations: 特征与质量的相关系数
        learning_rate: 学习率 (0-1)
    
    Returns:
        更新后的权重字典
    """
    new_weights = {}
    
    for feature, data in current_weights['weights'].items():
        current_value = data['value']
        correlation = correlations[feature]
        
        # 将相关系数 [-1, 1] 映射到 [0, 1]
        normalized_corr = (correlation + 1) / 2
        
        # 加权移动平均
        new_value = (
            current_value * (1 - learning_rate) +
            normalized_corr * learning_rate
        )
        
        # 限制范围
        MIN_WEIGHT = 0.20  # 不完全忽略
        MAX_WEIGHT = 0.95  # 不过度依赖
        new_value = max(MIN_WEIGHT, min(MAX_WEIGHT, new_value))
        
        # 更新历史
        history = data['history'] + [new_value]
        if len(history) > 10:  # 只保留最近10次
            history = history[-10:]
        
        new_weights[feature] = {
            'value': round(new_value, 2),
            'history': history,
            'correlation': correlation,
            'confidence': calculate_confidence(history)
        }
    
    return new_weights

def calculate_confidence(history):
    """
    根据历史稳定性计算置信度
    历史越稳定，置信度越高
    """
    if len(history) < 3:
        return 0.50  # 数据不足
    
    variance = calculate_variance(history[-5:])
    
    # 方差小 → 置信度高
    confidence = 1.0 - min(1.0, variance * 10)
    return round(confidence, 2)
```

#### 相关性计算

```python
def calculate_correlations(experiences):
    """
    计算每个特征与质量分数的相关性
    
    Args:
        experiences: 历史运行数据列表
    
    Returns:
        特征相关系数字典
    """
    features = ['zero_coupling', 'modularity', 'naming', ...]
    correlations = {}
    
    for feature in features:
        # 提取特征分数和质量分数
        feature_scores = [
            exp['analysis']['features'][feature]
            for exp in experiences
        ]
        quality_scores = [
            exp['output']['quality_score']
            for exp in experiences
        ]
        
        # 计算Pearson相关系数
        corr = pearson_correlation(feature_scores, quality_scores)
        correlations[feature] = corr
    
    return correlations

def pearson_correlation(x, y):
    """计算Pearson相关系数"""
    n = len(x)
    mean_x = sum(x) / n
    mean_y = sum(y) / n
    
    numerator = sum((x[i] - mean_x) * (y[i] - mean_y) for i in range(n))
    denominator_x = sum((x[i] - mean_x) ** 2 for i in range(n)) ** 0.5
    denominator_y = sum((y[i] - mean_y) ** 2 for i in range(n)) ** 0.5
    
    if denominator_x == 0 or denominator_y == 0:
        return 0
    
    return numerator / (denominator_x * denominator_y)
```

#### 更新示例

```python
# 初始状态
current = {
    "weights": {
        "zero_coupling": {"value": 0.50, "history": [0.50]},
        "naming": {"value": 0.50, "history": [0.50]}
    }
}

# 分析5轮循环后的相关性
correlations = {
    "zero_coupling": 0.92,  # 强相关
    "naming": 0.30          # 弱相关
}

# 更新权重（learning_rate = 0.20）
new_weights = update_feature_weights(current, correlations, 0.20)

# 结果
# {
#   "zero_coupling": {
#     "value": 0.63,  # 0.50 * 0.8 + 0.96 * 0.2 = 0.59
#     "history": [0.50, 0.63],
#     "correlation": 0.92
#   },
#   "naming": {
#     "value": 0.48,  # 0.50 * 0.8 + 0.65 * 0.2 = 0.53
#     "history": [0.50, 0.48],
#     "correlation": 0.30
#   }
# }
```

### 如何影响披露

**Producer读取权重，决定披露策略**：

```python
def disclose_context(feature_weights, knowledge_base):
    """
    根据特征权重渐进式披露上下文
    """
    context = []
    
    # 按权重降序排序特征
    sorted_features = sorted(
        feature_weights['weights'].items(),
        key=lambda x: x[1]['value'],
        reverse=True
    )
    
    for feature, data in sorted_features:
        weight = data['value']
        
        if weight >= 0.85:
            # 完整披露
            pattern = knowledge_base.get_pattern(feature, level='full')
            examples = knowledge_base.get_examples(feature, count=3, quality='excellent')
            context.append({
                'feature': feature,
                'pattern': pattern,
                'examples': examples,
                'tokens': len(pattern) + sum(len(ex) for ex in examples)
            })
            
        elif weight >= 0.70:
            # 详细摘要
            pattern = knowledge_base.get_pattern(feature, level='summary')
            examples = knowledge_base.get_examples(feature, count=2, quality='excellent')
            context.append({
                'feature': feature,
                'pattern': pattern,
                'examples': examples
            })
            
        elif weight >= 0.50:
            # 简要提及
            pattern = knowledge_base.get_pattern(feature, level='brief')
            context.append({
                'feature': feature,
                'pattern': pattern
            })
        
        # weight < 0.50: 不披露
    
    return context
```

## 📚 example-index.json - 案例选择索引

### 文件结构

**位置**：`.state/indices/example-index.json`

**格式**：

```json
{
  "version": "1.0.0",
  "last_updated": "2026-01-15T10:30:00Z",
  "by_feature": {
    "zero_coupling": {
      "excellent": [
        {
          "file": "HealthComponent.verse",
          "quality": 0.87,
          "usage_count": 12,
          "avg_result_quality": 0.85,
          "last_used": "2026-01-14T10:00:00Z"
        },
        {
          "file": "AttackSystem.verse",
          "quality": 0.85,
          "usage_count": 10,
          "avg_result_quality": 0.83
        },
        {
          "file": "InventoryManager.verse",
          "quality": 0.82,
          "usage_count": 8,
          "avg_result_quality": 0.80
        }
      ],
      "average": [
        {
          "file": "OldHealthScript.verse",
          "quality": 0.65,
          "usage_count": 2,
          "avg_result_quality": 0.63
        }
      ]
    },
    "modularity": {
      "excellent": [...]
    }
  },
  "by_scenario": {
    "player_management": [
      {
        "file": "HealthComponent.verse",
        "relevance": 0.95,
        "usage_count": 15
      },
      {
        "file": "InventoryManager.verse",
        "relevance": 0.90,
        "usage_count": 12
      }
    ],
    "combat_system": [...]
  },
  "metadata": {
    "total_examples": 45,
    "excellent_count": 28,
    "average_count": 17
  }
}
```

### 字段说明

| 字段 | 说明 | 用途 |
|-----|------|------|
| `by_feature` | 按特征分类的案例 | Producer根据高权重特征查找案例 |
| `by_scenario` | 按场景分类的案例 | Composer根据需求场景查找案例 |
| `usage_count` | 使用次数 | 统计案例受欢迎程度 |
| `avg_result_quality` | 使用此案例后的平均产出质量 | 优化案例排序 |

### 如何从反馈中优化

#### 案例效果追踪

```python
def track_example_usage(run_data):
    """
    追踪案例使用效果
    """
    example_index = read_json('.state/indices/example-index.json')
    
    # 获取本次使用的案例
    disclosed_examples = run_data['disclosed_context']['examples']
    result_quality = run_data['output']['quality_score']
    
    # 更新每个案例的效果统计
    for example_file in disclosed_examples:
        # 在索引中找到此案例
        for feature, data in example_index['by_feature'].items():
            for quality_level in ['excellent', 'average']:
                for ex in data[quality_level]:
                    if ex['file'] == example_file:
                        # 更新使用计数
                        ex['usage_count'] += 1
                        
                        # 更新平均产出质量（移动平均）
                        old_avg = ex.get('avg_result_quality', result_quality)
                        count = ex['usage_count']
                        new_avg = (old_avg * (count - 1) + result_quality) / count
                        ex['avg_result_quality'] = round(new_avg, 2)
                        
                        # 更新最后使用时间
                        ex['last_used'] = now()
    
    # 保存更新后的索引
    write_json('.state/indices/example-index.json', example_index)
```

#### 案例排序优化

```python
def optimize_example_order(example_index):
    """
    根据效果重新排序案例
    """
    for feature, data in example_index['by_feature'].items():
        for quality_level in ['excellent', 'average']:
            examples = data[quality_level]
            
            # 按平均产出质量降序排序
            examples.sort(
                key=lambda ex: (
                    ex.get('avg_result_quality', 0),
                    ex.get('usage_count', 0)
                ),
                reverse=True
            )
            
            data[quality_level] = examples
    
    return example_index
```

### 如何影响披露

**Producer根据特征权重和案例索引披露案例**：

```python
def disclose_examples(feature_weights, example_index):
    """
    根据特征权重披露相关案例
    """
    disclosed = []
    
    for feature, data in feature_weights['weights'].items():
        weight = data['value']
        
        if weight >= 0.80:
            # 披露3个优秀案例
            examples = example_index['by_feature'][feature]['excellent'][:3]
            disclosed.extend([ex['file'] for ex in examples])
            
        elif weight >= 0.65:
            # 披露2个优秀案例
            examples = example_index['by_feature'][feature]['excellent'][:2]
            disclosed.extend([ex['file'] for ex in examples])
            
        elif weight >= 0.50:
            # 披露1个优秀案例
            examples = example_index['by_feature'][feature]['excellent'][:1]
            disclosed.extend([ex['file'] for ex in examples])
    
    # 去重
    disclosed = list(set(disclosed))
    
    # 加载案例内容
    example_contents = [
        read_file(f'knowledge/examples/excellent/{file}')
        for file in disclosed
    ]
    
    return example_contents
```

## 🎨 pattern-index.json - 模式引用索引

### 文件结构

**位置**：`.state/indices/pattern-index.json`

**格式**：

```json
{
  "version": "1.0.0",
  "last_updated": "2026-01-15T10:30:00Z",
  "patterns": {
    "zero_coupling": {
      "file": "zero-coupling.md",
      "priority": 0.92,
      "applicable_scenarios": [
        "component_design",
        "system_architecture"
      ],
      "reference_count": 15,
      "success_rate": 0.88,
      "avg_quality_improvement": 0.15,
      "last_referenced": "2026-01-14T10:00:00Z"
    },
    "event_driven": {
      "file": "event-driven.md",
      "priority": 0.85,
      "applicable_scenarios": [
        "game_flow",
        "ui_interaction"
      ],
      "reference_count": 12,
      "success_rate": 0.82,
      "avg_quality_improvement": 0.12
    },
    "component_based": {
      "file": "component-based.md",
      "priority": 0.80,
      "applicable_scenarios": [
        "component_design",
        "modularity"
      ],
      "reference_count": 10,
      "success_rate": 0.79,
      "avg_quality_improvement": 0.10
    }
  },
  "scenario_patterns": {
    "component_design": [
      "zero_coupling",
      "component_based",
      "single_responsibility"
    ],
    "system_architecture": [
      "zero_coupling",
      "layered_architecture",
      "dependency_injection"
    ]
  }
}
```

### 字段说明

| 字段 | 说明 | 用途 |
|-----|------|------|
| `priority` | 模式优先级 | 与特征权重同步 |
| `applicable_scenarios` | 适用场景 | 场景匹配 |
| `reference_count` | 被引用次数 | 统计受欢迎度 |
| `success_rate` | 成功率（产出质量>=0.80的比例） | 评估模式有效性 |
| `avg_quality_improvement` | 平均质量提升 | 模式带来的质量增益 |

### 如何从反馈中优化

#### 模式效果追踪

```python
def track_pattern_effectiveness(run_data):
    """
    追踪模式使用效果
    """
    pattern_index = read_json('.state/indices/pattern-index.json')
    
    disclosed_patterns = run_data['disclosed_context']['patterns']
    result_quality = run_data['output']['quality_score']
    
    for pattern_name in disclosed_patterns:
        pattern = pattern_index['patterns'][pattern_name]
        
        # 更新引用计数
        pattern['reference_count'] += 1
        
        # 更新成功率
        is_success = result_quality >= 0.80
        old_success_rate = pattern['success_rate']
        count = pattern['reference_count']
        new_success_rate = (
            old_success_rate * (count - 1) + (1 if is_success else 0)
        ) / count
        pattern['success_rate'] = round(new_success_rate, 2)
        
        # 更新最后引用时间
        pattern['last_referenced'] = now()
    
    write_json('.state/indices/pattern-index.json', pattern_index)
```

#### 模式优先级同步

```python
def sync_pattern_priority(feature_weights, pattern_index):
    """
    将特征权重同步到模式优先级
    """
    for pattern_name, pattern in pattern_index['patterns'].items():
        # 假设模式名与特征名一致
        if pattern_name in feature_weights['weights']:
            feature_data = feature_weights['weights'][pattern_name]
            pattern['priority'] = feature_data['value']
    
    write_json('.state/indices/pattern-index.json', pattern_index)
```

### 如何影响披露

**Producer根据权重和场景披露模式**：

```python
def disclose_patterns(feature_weights, pattern_index, scenario):
    """
    根据特征权重和场景披露模式文档
    """
    disclosed = []
    
    # 1. 根据场景获取推荐模式
    if scenario in pattern_index['scenario_patterns']:
        recommended = pattern_index['scenario_patterns'][scenario]
    else:
        recommended = []
    
    # 2. 按特征权重披露
    for feature, data in feature_weights['weights'].items():
        weight = data['value']
        
        if feature not in pattern_index['patterns']:
            continue
        
        pattern = pattern_index['patterns'][feature]
        
        if weight >= 0.85:
            # 完整披露
            content = read_file(f'knowledge/patterns/{pattern["file"]}')
            disclosed.append({
                'pattern': feature,
                'level': 'full',
                'content': content,
                'recommended': feature in recommended
            })
            
        elif weight >= 0.70:
            # 摘要披露
            content = extract_summary(
                read_file(f'knowledge/patterns/{pattern["file"]}')
            )
            disclosed.append({
                'pattern': feature,
                'level': 'summary',
                'content': content
            })
            
        elif weight >= 0.50:
            # 简要提及
            disclosed.append({
                'pattern': feature,
                'level': 'brief',
                'content': pattern['file']
            })
    
    return disclosed
```

## 🔄 索引之间的协同

三个索引不是独立工作，而是协同影响披露策略：

```python
def comprehensive_disclosure(task, indices):
    """
    综合三个索引进行披露
    """
    feature_weights = indices['feature_weights']
    example_index = indices['example_index']
    pattern_index = indices['pattern_index']
    
    context = {
        'patterns': [],
        'examples': [],
        'total_tokens': 0
    }
    
    # 1. 识别任务场景
    scenario = identify_scenario(task)
    
    # 2. 按特征权重披露模式
    patterns = disclose_patterns(feature_weights, pattern_index, scenario)
    context['patterns'] = patterns
    context['total_tokens'] += sum(count_tokens(p['content']) for p in patterns)
    
    # 3. 按特征权重披露案例
    examples = disclose_examples(feature_weights, example_index)
    context['examples'] = examples
    context['total_tokens'] += sum(count_tokens(ex) for ex in examples)
    
    # 4. 控制总token数（防止超限）
    MAX_TOKENS = 8000
    if context['total_tokens'] > MAX_TOKENS:
        # 优先保留高权重内容
        context = trim_context(context, MAX_TOKENS, feature_weights)
    
    return context
```

## 📊 索引优化效果可视化

### 权重进化趋势

```
特征权重进化（50轮循环）

zero_coupling:  0.50 ████████████████████████ 0.92
modularity:     0.50 ████████████████████     0.85
naming:         0.50 ███████████              0.65
error_handling: 0.50 ████████                 0.60
testability:    0.50 ██████                   0.58
performance:    0.50 ████                     0.45
comments:       0.50 ███                      0.35

→ 明显分化：高相关特征权重上升，低相关特征权重下降
```

### 质量提升曲线

```
产出质量 vs 循环轮数

质量
0.90 |                           ●●●●●
     |                       ●●●●
0.85 |                   ●●●●
     |               ●●●●
0.80 |           ●●●●
     |       ●●●●
0.75 |   ●●●●
     | ●●●
0.70 |●●
     |●
0.65 |●
     +────────────────────────────────────→ 循环
      1  5  10 15 20 25 30 35 40 45 50

阶段1(1-10)：探索期，质量波动
阶段2(11-30)：优化期，稳步上升
阶段3(31-50)：稳定期，高位维持
```

## 🔧 索引管理工具

### 备份索引

```bash
#!/bin/bash
# backup-indices.sh

DATE=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="backups/indices-$DATE"

mkdir -p "$BACKUP_DIR"
cp -r .state/indices/* "$BACKUP_DIR/"

echo "索引已备份到 $BACKUP_DIR"
```

### 重置索引

```bash
#!/bin/bash
# reset-indices.sh

echo "警告：即将重置所有索引到初始状态"
read -p "确认？(yes/no): " confirm

if [ "$confirm" == "yes" ]; then
    # 备份当前索引
    ./backup-indices.sh
    
    # 重置特征权重
    cat > .state/indices/feature-weights.json << EOF
{
  "version": "1.0.0",
  "weights": {
    "zero_coupling": {"value": 0.50, "history": [0.50]},
    "modularity": {"value": 0.50, "history": [0.50]},
    "naming": {"value": 0.50, "history": [0.50]}
  }
}
EOF
    
    echo "索引已重置"
fi
```

### 查看索引状态

```bash
#!/bin/bash
# show-indices-status.sh

echo "=== 特征权重状态 ==="
jq '.weights | to_entries | sort_by(.value.value) | reverse | .[] | "\(.key): \(.value.value)"' \
   .state/indices/feature-weights.json -r

echo ""
echo "=== 案例索引统计 ==="
jq '.metadata' .state/indices/example-index.json

echo ""
echo "=== 模式索引统计 ==="
jq '.patterns | length' .state/indices/pattern-index.json
```

## 📖 下一步

- **查看完整工作流** → [06-workflow.md](./06-workflow.md)
- **学习进化机制** → [07-evolution-mechanism.md](./07-evolution-mechanism.md)
- **开始实施** → [08-implementation-guide.md](./08-implementation-guide.md)

---

**返回** → [框架文档首页](./README.md)
