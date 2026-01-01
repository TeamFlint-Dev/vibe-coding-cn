# 进化机制 - 自进化编码框架

## 🧬 什么在进化？

### 进化的核心：索引配置

```
❌ 不进化
├─ Agent (LLM) - 预训练模型，能力固定
└─ Knowledge - 知识库只增不改

✅ 在进化
├─ 特征权重 (feature-weights.json)
├─ 案例排序 (example-index.json)
└─ 模式优先级 (pattern-index.json)
```

**本质**：我们不改变Agent"会什么"，而是优化"看什么"。

### 什么不进化？

#### Agent层：不可变

```
理由：
1. LLM是预训练模型，我们无法修改其参数
2. 即使微调，成本高且容易过拟合
3. 通用能力已足够，无需特化

类比：
Agent像通用计算器，功能固定
我们优化的是"输入什么数字"，而非"如何计算"
```

#### Knowledge层：只增不减

```
理由：
1. 历史案例是宝贵资产，不应删除
2. 即使是"差案例"也有对比学习价值
3. 知识积累是单向的

类比：
Knowledge像图书馆，书籍只增加，不销毁
即使是老旧的书也可能有历史价值
```

## 📈 进化的三个阶段

### 阶段1：探索期（Cycle 1-15）

**特点**：

- 索引权重随机或均匀分布
- 披露策略不精准
- 质量波动大
- 快速试错

**权重变化**：

```
Cycle 1:  所有特征 0.50（起点）
Cycle 5:  开始分化 0.48-0.63
Cycle 10: 明显分化 0.45-0.70
Cycle 15: 区分度高 0.40-0.75
```

**质量曲线**：

```
质量
0.75 |           ╱●
     |        ╱  ╱
0.70 |     ●╱  ╱
     |   ╱  ● ╱
0.65 | ●╱  ╱  ●
     |╱ ● ╱
0.60 |●  ╱
     |  ●
     └────────────────→ Cycle
      1  3  5  7  9 11 13 15

波动大，整体上升趋势
```

**策略**：

- 大胆尝试不同披露策略
- 快速积累样本数据
- 不必追求单次质量最优

### 阶段2：优化期（Cycle 16-40）

**特点**：

- 高相关特征权重持续上升
- 低相关特征权重下降
- 披露策略逐渐精准
- 质量稳步提升

**权重变化**：

```
Cycle 20: 0.35-0.80（区分明显）
Cycle 30: 0.32-0.88（高低分化）
Cycle 40: 0.30-0.92（接近稳定）
```

**质量曲线**：

```
质量
0.85 |                     ●●
     |                 ●●●●
0.80 |             ●●●●
     |         ●●●●
0.75 |     ●●●●
     | ●●●●
0.70 |●●
     |
     └────────────────────────→ Cycle
      16 20 24 28 32 36 40

波动减小，持续上升
```

**策略**：

- 信任数据，跟随相关性调整
- 每5轮分析一次
- 关注质量趋势而非单点

### 阶段3：稳定期（Cycle 41+）

**特点**：

- 权重收敛到稳定区间
- 披露策略成熟
- 质量高位维持
- 微调优化

**权重稳定状态**：

```
特征             权重    置信度
zero_coupling    0.92    0.95
modularity       0.85    0.90
naming           0.65    0.85
error_handling   0.60    0.82
testability      0.58    0.80
performance      0.45    0.75
comments         0.35    0.70
```

**质量曲线**：

```
质量
0.90 |                 ●●●●●●●
     |             ●●●●
0.85 |         ●●●●
     |     ●●●●
0.80 | ●●●●
     |
     └──────────────────────────→ Cycle
      41 45 49 53 57 61 65

高位稳定，小幅波动
```

**策略**：

- 谨慎调整权重（小步幅）
- 降低学习率（如0.2 → 0.1）
- 关注异常值

## 🔬 特征相关性分析

### 计算方法

#### Pearson相关系数

```python
def calculate_feature_quality_correlation(experiences, feature):
    """
    计算特征与质量的Pearson相关系数
    
    Returns:
        相关系数 (-1 到 1)
        - 接近1：强正相关（特征好 → 质量高）
        - 接近0：无相关
        - 接近-1：负相关（特征好 → 质量低，罕见）
    """
    # 提取特征分数和质量分数
    feature_scores = [
        exp['analysis']['features'][feature]
        for exp in experiences
    ]
    quality_scores = [
        exp['output']['quality_score']
        for exp in experiences
    ]
    
    # 计算相关系数
    n = len(feature_scores)
    mean_f = sum(feature_scores) / n
    mean_q = sum(quality_scores) / n
    
    numerator = sum(
        (feature_scores[i] - mean_f) * (quality_scores[i] - mean_q)
        for i in range(n)
    )
    
    denom_f = sum((f - mean_f) ** 2 for f in feature_scores) ** 0.5
    denom_q = sum((q - mean_q) ** 2 for q in quality_scores) ** 0.5
    
    if denom_f == 0 or denom_q == 0:
        return 0
    
    return numerator / (denom_f * denom_q)
```

#### 示例计算

```python
# 10次运行数据
experiences = [
    {'features': {'zero_coupling': 0.70}, 'quality': 0.65},
    {'features': {'zero_coupling': 0.75}, 'quality': 0.68},
    {'features': {'zero_coupling': 0.80}, 'quality': 0.72},
    {'features': {'zero_coupling': 0.85}, 'quality': 0.75},
    {'features': {'zero_coupling': 0.82}, 'quality': 0.73},
    {'features': {'zero_coupling': 0.88}, 'quality': 0.78},
    {'features': {'zero_coupling': 0.90}, 'quality': 0.80},
    {'features': {'zero_coupling': 0.87}, 'quality': 0.77},
    {'features': {'zero_coupling': 0.92}, 'quality': 0.82},
    {'features': {'zero_coupling': 0.95}, 'quality': 0.85}
]

corr = calculate_correlation(experiences, 'zero_coupling')
# 结果：0.98（强相关！）
```

### 相关性解读

| 相关系数 | 解读 | 权重调整策略 |
|---------|------|-------------|
| 0.90-1.0 | 极强相关 | 大幅提升权重（+0.15） |
| 0.70-0.90 | 强相关 | 提升权重（+0.10） |
| 0.50-0.70 | 中等相关 | 适度提升（+0.05） |
| 0.30-0.50 | 弱相关 | 保持或微降（±0.02） |
| 0.10-0.30 | 极弱相关 | 降低权重（-0.05） |
| 0-0.10 | 无相关 | 大幅降低（-0.10） |

### 多特征联合分析

```python
def analyze_feature_interactions(experiences):
    """
    分析特征之间的交互效应
    
    有时两个特征单独不强，但组合后效果好
    """
    features = ['zero_coupling', 'modularity', 'naming']
    
    # 计算两两组合的相关性
    for f1 in features:
        for f2 in features:
            if f1 >= f2:
                continue
            
            # 计算组合特征分数
            combined_scores = [
                (exp['features'][f1] + exp['features'][f2]) / 2
                for exp in experiences
            ]
            quality_scores = [exp['quality'] for exp in experiences]
            
            corr = pearson_correlation(combined_scores, quality_scores)
            
            if corr > 0.90:
                print(f"发现强交互：{f1} + {f2} → {corr}")
                # 例如：zero_coupling + modularity 组合相关性0.95
```

## ⚙️ 权重更新算法

### 标准更新公式

```python
def update_weight(current_weight, correlation, learning_rate=0.20):
    """
    标准权重更新算法
    
    Args:
        current_weight: 当前权重 (0-1)
        correlation: 相关系数 (-1 到 1)
        learning_rate: 学习率 (0-1)
    
    Returns:
        new_weight: 更新后权重 (0.20-0.95)
    """
    # 将相关系数映射到 [0, 1]
    normalized_corr = (correlation + 1) / 2
    
    # 加权移动平均
    new_weight = (
        current_weight * (1 - learning_rate) +
        normalized_corr * learning_rate
    )
    
    # 限制范围
    MIN_WEIGHT = 0.20  # 不完全忽略任何特征
    MAX_WEIGHT = 0.95  # 不过度依赖单一特征
    new_weight = max(MIN_WEIGHT, min(MAX_WEIGHT, new_weight))
    
    return round(new_weight, 2)
```

### 自适应学习率

```python
def adaptive_learning_rate(cycle, variance):
    """
    根据循环轮数和质量方差动态调整学习率
    
    早期：高学习率，快速探索
    后期：低学习率，精细调优
    """
    if cycle < 10:
        base_rate = 0.30  # 探索期，大步调整
    elif cycle < 30:
        base_rate = 0.20  # 优化期，稳步调整
    else:
        base_rate = 0.10  # 稳定期，小步微调
    
    # 如果质量波动大，降低学习率
    if variance > 0.05:
        return base_rate * 0.5
    
    return base_rate
```

### 动量更新（可选）

```python
def momentum_update(current_weight, correlation, momentum=0.9):
    """
    引入动量，避免权重剧烈震荡
    
    类似深度学习中的SGD+Momentum
    """
    # 保存历史梯度
    if not hasattr(momentum_update, 'velocity'):
        momentum_update.velocity = {}
    
    feature = 'current_feature'  # 示例
    
    # 计算梯度（目标权重 - 当前权重）
    normalized_corr = (correlation + 1) / 2
    gradient = normalized_corr - current_weight
    
    # 更新速度
    if feature not in momentum_update.velocity:
        momentum_update.velocity[feature] = 0
    
    velocity = (
        momentum * momentum_update.velocity[feature] +
        (1 - momentum) * gradient
    )
    momentum_update.velocity[feature] = velocity
    
    # 应用速度
    new_weight = current_weight + 0.20 * velocity
    
    return max(0.20, min(0.95, new_weight))
```

## 📚 案例库管理

### 案例分级

```python
def classify_example(code, quality_score):
    """
    根据质量分数对案例分级
    """
    if quality_score >= 0.85:
        return 'excellent'
    elif quality_score >= 0.70:
        return 'good'
    elif quality_score >= 0.55:
        return 'average'
    else:
        return 'poor'
```

### 案例自动归档

```python
def archive_example(module_file, quality_score):
    """
    将生产的模块归档到案例库
    """
    classification = classify_example(code, quality_score)
    
    if classification in ['excellent', 'good', 'average']:
        # 复制到案例库
        target_dir = f'knowledge/examples/{classification}/'
        shutil.copy(module_file, target_dir)
        
        # 创建元数据
        metadata = {
            'file': os.path.basename(module_file),
            'quality_score': quality_score,
            'features': extract_feature_scores(code),
            'created_at': now(),
            'usage_count': 0,
            'avg_result_quality': quality_score
        }
        write_json(f'{target_dir}/{filename}.meta.json', metadata)
        
        # 更新案例索引
        update_example_index(filename, classification, metadata)
```

### 案例淘汰机制

```python
def cleanup_poor_examples():
    """
    定期清理效果差的案例（可选）
    
    保留规则：
    1. excellent案例：永久保留
    2. average案例：使用次数>10或效果好
    3. poor案例：不归档
    """
    example_index = read_json('.state/indices/example-index.json')
    
    for feature in example_index['by_feature']:
        average_examples = example_index['by_feature'][feature]['average']
        
        # 筛选低效案例
        to_remove = [
            ex for ex in average_examples
            if ex['usage_count'] < 5 and ex['avg_result_quality'] < 0.65
        ]
        
        for ex in to_remove:
            print(f"移除低效案例：{ex['file']}")
            # 移动到归档目录，而非删除
            shutil.move(
                f'knowledge/examples/average/{ex["file"]}',
                f'knowledge/examples/archived/{ex["file"]}'
            )
```

## 📊 如何测量进化

### 关键指标

#### 1. 质量趋势

```python
def measure_quality_trend(history):
    """
    测量质量改进趋势
    
    Returns:
        - trend: 'improving' | 'declining' | 'stable'
        - rate: 改进速率（分数/轮）
    """
    if len(history) < 10:
        return {'trend': 'insufficient_data', 'rate': 0}
    
    # 计算线性回归斜率
    x = list(range(len(history)))
    y = [h['quality_score'] for h in history]
    
    slope = linear_regression_slope(x, y)
    
    if slope > 0.01:
        return {'trend': 'improving', 'rate': slope}
    elif slope < -0.01:
        return {'trend': 'declining', 'rate': slope}
    else:
        return {'trend': 'stable', 'rate': slope}
```

#### 2. 权重收敛度

```python
def measure_convergence(weight_history):
    """
    测量权重是否收敛
    
    Returns:
        - converged: bool
        - convergence_score: 0-1（越高越收敛）
    """
    if len(weight_history) < 5:
        return {'converged': False, 'score': 0}
    
    # 计算最近5轮的权重方差
    recent_weights = weight_history[-5:]
    variance = calculate_variance(recent_weights)
    
    # 方差小 → 收敛度高
    convergence_score = 1.0 - min(1.0, variance * 20)
    
    converged = variance < 0.05  # 阈值
    
    return {
        'converged': converged,
        'score': convergence_score,
        'variance': variance
    }
```

#### 3. 披露效率

```python
def measure_disclosure_efficiency(traces):
    """
    测量披露的上下文是否精准
    
    披露效率 = 质量提升 / 披露的token数
    """
    efficiencies = []
    
    for trace in traces:
        disclosed_tokens = trace['disclosed_tokens']
        quality = trace['quality_score']
        
        # 假设基准质量0.60（无披露）
        baseline_quality = 0.60
        improvement = quality - baseline_quality
        
        efficiency = improvement / (disclosed_tokens / 1000)
        efficiencies.append(efficiency)
    
    return {
        'avg_efficiency': mean(efficiencies),
        'trend': 'improving' if efficiencies[-1] > efficiencies[0] else 'declining'
    }
```

### 进化仪表盘

```
=== 进化状态仪表盘 (Cycle 50) ===

质量趋势：
  当前：0.88 ████████████████████ ↑ (improving)
  速率：+0.015 / cycle
  稳定性：方差 0.011 (收敛)

权重收敛：
  状态：已收敛 ✓
  收敛分数：0.92
  最大变化：<0.03

特征权重分布：
  zero_coupling:  0.92 ████████████████████████
  modularity:     0.85 ████████████████████
  naming:         0.65 █████████████
  error_handling: 0.60 ████████████
  testability:    0.58 ███████████
  performance:    0.45 █████████
  comments:       0.35 ███████

披露效率：
  平均效率：0.12 质量/1K tokens
  趋势：improving (+15% vs 初期)

案例库：
  总数：138
  优秀：85 (62%)
  良好：40 (29%)
  普通：13 (9%)

推荐行动：
  ✓ 系统已稳定，可投入生产使用
  - 继续维持学习循环（低频，如每20轮）
  - 关注异常质量下降
```

## 🔮 进化的长期展望

### 持续学习

```
即使系统稳定后，也应保持学习：

1. 新API发布时
   → 添加新能力点
   → 生产新积木
   → 权重可能微调

2. 需求模式变化时
   → 某些特征变得更重要
   → 权重自然调整

3. 技术栈升级时
   → 可能需要部分重置
   → 保留核心权重结构
```

### 跨项目迁移

```
权重可在类似项目间迁移：

项目A (UEFN游戏1)：
  权重：{zero_coupling: 0.92, modularity: 0.85, ...}
  
项目B (UEFN游戏2，新项目)：
  初始权重：从项目A复制
  → 快速启动（跳过探索期）
  → 微调适应新项目特点
  
节省时间：~15轮循环（约40%时间）
```

### 集体智慧

```
团队共享权重配置：

团队成员A：
  专注战斗系统，优化combat相关权重

团队成员B：
  专注UI系统，优化ui相关权重

定期合并：
  综合各成员的权重学习成果
  → 团队级最优权重配置
```

## 📖 下一步

- **开始实施** → [08-implementation-guide.md](./08-implementation-guide.md)
- **回顾架构** → [01-architecture.md](./01-architecture.md)

---

**返回** → [框架文档首页](./README.md)
