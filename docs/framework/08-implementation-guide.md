# 实施指南 - 自进化编码框架

## 🎯 实施概览

本指南将带您从零开始实施自进化编码框架，分5个阶段完成。

```
阶段1: 前置准备 (2小时)
  ↓
阶段2: 首轮生产 (4小时)
  ↓
阶段3: 首次拼装 (2小时)
  ↓
阶段4: 首次学习 (1小时)
  ↓
阶段5: 规模化运行 (持续)
```

**总时间投入**：初始9小时 + 持续迭代

## 📋 前置准备

### 环境要求

#### 必需资源

```bash
# 1. UEFN开发环境
- UEFN编辑器（最新版本）
- Verse语言支持
- 基础项目模板

# 2. AI服务
- GPT-4 或 Claude 3.5 Sonnet API访问
- 推荐上下文窗口：128K tokens+

# 3. 开发工具
- Git（版本控制）
- Python 3.8+（运行脚本）
- jq（JSON处理）
- 文本编辑器（VSCode推荐）
```

#### UEFN资源准备

```bash
# 1. 复用现有资源
# 如果已有 Core/skills/programming/verseDev/

ln -s ../../Core/skills/programming/verseDev/shared/api-digests \
      knowledge/uefn/api-digests

# 2. 或从Epic文档爬取
cd libs/external/epic-docs-crawler
python3 crawler.py --output ../../knowledge/uefn/api-digests

# 3. 创建能力地图
python3 scripts/generate-capability-map.py \
  --input knowledge/uefn/api-digests \
  --output knowledge/uefn/capability-map.json
```

### 步骤1：创建项目结构

```bash
#!/bin/bash
# scripts/init-framework.sh

echo "🚀 初始化自进化编码框架..."

# 创建目录
mkdir -p docs/framework
mkdir -p skills
mkdir -p .state/indices
mkdir -p knowledge/{uefn/api-digests,patterns,examples/{excellent,average,archived}}
mkdir -p assets/{modules,composed}
mkdir -p data/{experiences,quality-scores,traces,learning-reports}
mkdir -p backups

echo "✓ 目录结构已创建"

# 初始化Git忽略
cat > .gitignore << 'EOF'
# 运行时状态（不提交）
.state/
data/

# 临时文件
*.tmp
*.log

# 备份文件
backups/
EOF

echo "✓ .gitignore已配置"
```

### 步骤2：初始化索引配置

```bash
#!/bin/bash
# scripts/init-indices.sh

echo "📇 初始化索引配置..."

# 特征权重索引
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
    "converged": false,
    "convergence_target": 0.05
  }
}
EOF

# 案例索引
cat > .state/indices/example-index.json << 'EOF'
{
  "version": "1.0.0",
  "last_updated": "2026-01-01T00:00:00Z",
  "by_feature": {},
  "by_scenario": {},
  "metadata": {
    "total_examples": 0,
    "excellent_count": 0,
    "average_count": 0
  }
}
EOF

# 模式索引
cat > .state/indices/pattern-index.json << 'EOF'
{
  "version": "1.0.0",
  "last_updated": "2026-01-01T00:00:00Z",
  "patterns": {},
  "scenario_patterns": {}
}
EOF

echo "✓ 索引配置已初始化"
```

### 步骤3：创建系统状态

```bash
#!/bin/bash
# scripts/init-state.sh

echo "🔧 初始化系统状态..."

# 阶段状态
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

# 覆盖率
cat > .state/coverage.json << 'EOF'
{
  "total_capabilities": 0,
  "covered_capabilities": 0,
  "coverage_rate": 0.00,
  "capabilities": {}
}
EOF

# 质量历史
cat > .state/quality-history.json << 'EOF'
{
  "history": [],
  "trend": "initial",
  "variance": 0
}
EOF

echo "✓ 系统状态已初始化"
```

### 步骤4：准备知识库

#### 4.1 添加设计模式文档

```bash
# 从文档模板创建模式文件
cat > knowledge/patterns/zero-coupling.md << 'EOF'
# 零耦合模式 (Zero-Coupling Pattern)

## 概念

组件间不直接引用，通过消息系统或事件通信。

## 为什么重要

- 提高可维护性
- 组件可独立测试
- 降低系统复杂度

## UEFN实现

使用SceneGraph消息系统：

```verse
# 发送消息
SendMessageToAllPlayers(Message{Text: "Event"})

# 接收消息
OnMessage(Msg: message_event):void = {
    # 处理
}
```

## 反例

避免直接引用：

```verse
# ❌ 不好
var Other: other_component = ...
Other.DoSomething()
```

## 适用场景

- 组件设计
- 系统架构
EOF

# TODO: 创建其他模式文件
# - modularity.md
# - naming.md
# - etc.
```

#### 4.2 创建能力地图

```python
# scripts/generate-capability-map.py

import json
from pathlib import Path

def generate_capability_map():
    """
    从API摘要生成能力地图
    """
    capability_map = {
        "version": "1.0.0",
        "categories": {
            "player_management": {
                "description": "玩家相关功能",
                "capabilities": [
                    {
                        "id": "player_health",
                        "name": "玩家健康管理",
                        "apis": [
                            "player<public>.GetHealth()",
                            "player<public>.SetHealth()"
                        ],
                        "difficulty": "easy",
                        "priority": "high"
                    },
                    # ... 更多能力
                ]
            },
            "combat_system": {
                "description": "战斗相关功能",
                "capabilities": [
                    # ...
                ]
            }
        }
    }
    
    output_path = Path("knowledge/uefn/capability-map.json")
    output_path.write_text(json.dumps(capability_map, indent=2))
    print(f"✓ 能力地图已生成：{output_path}")

if __name__ == "__main__":
    generate_capability_map()
```

### 步骤5：创建Skill文件

```bash
# 从文档中提取4个Skill定义
cp docs/framework/04-skill-definitions.md skills/

# 提取各Skill到独立文件
# orchestrator.skill.md
# producer.skill.md
# composer.skill.md
# learner.skill.md
```

### 验证前置准备

```bash
#!/bin/bash
# scripts/verify-setup.sh

echo "🔍 验证框架设置..."

errors=0

# 检查目录
for dir in docs/framework skills .state/indices knowledge assets data; do
    if [ ! -d "$dir" ]; then
        echo "✗ 缺少目录：$dir"
        ((errors++))
    else
        echo "✓ 目录存在：$dir"
    fi
done

# 检查索引文件
for file in .state/indices/feature-weights.json \
            .state/indices/example-index.json \
            .state/indices/pattern-index.json; do
    if [ ! -f "$file" ]; then
        echo "✗ 缺少文件：$file"
        ((errors++))
    elif ! jq . "$file" > /dev/null 2>&1; then
        echo "✗ JSON格式错误：$file"
        ((errors++))
    else
        echo "✓ 文件有效：$file"
    fi
done

# 检查知识库
if [ ! -f "knowledge/uefn/capability-map.json" ]; then
    echo "✗ 缺少能力地图"
    ((errors++))
else
    echo "✓ 能力地图存在"
fi

if [ $errors -eq 0 ]; then
    echo ""
    echo "🎉 框架设置验证通过！"
    echo "可以开始首轮生产循环。"
    exit 0
else
    echo ""
    echo "⚠️ 发现 $errors 个问题，请修复后继续。"
    exit 1
fi
```

## 🏭 阶段2：首轮生产

### 目标

运行第一个完整的Producer循环，生成首个代码积木。

### 步骤1：启动Orchestrator

```python
# scripts/orchestrator.py

import json
from pathlib import Path
from datetime import datetime

class Orchestrator:
    def __init__(self):
        self.state_dir = Path('.state')
        self.phase_file = self.state_dir / 'phase.json'
        
    def run(self):
        """主循环"""
        phase = self.load_phase()
        
        print(f"📊 当前阶段：{phase['current_phase']}")
        print(f"📊 循环计数：{phase['cycle_count']}")
        print(f"📊 覆盖率：{phase['current_coverage']:.2%}")
        
        if phase['current_phase'] == 'production':
            if phase['current_coverage'] < phase['target_coverage']:
                print("✓ 决策：调用Producer")
                self.call_producer()
            else:
                print("✓ 生产阶段完成，切换到拼装阶段")
                self.transition_to('composition')
        
    def call_producer(self):
        """调用Producer"""
        print("\n🏭 启动Producer...")
        # 实际实现见下文
        
    def load_phase(self):
        return json.loads(self.phase_file.read_text())

if __name__ == "__main__":
    orchestrator = Orchestrator()
    orchestrator.run()
```

### 步骤2：实现Producer

```python
# scripts/producer.py

import json
from pathlib import Path

class Producer:
    def __init__(self):
        self.indices_dir = Path('.state/indices')
        self.knowledge_dir = Path('knowledge')
        
    def run(self, task):
        """运行生产循环"""
        print(f"📝 任务：{task['name']}")
        
        # 1. 读取索引
        weights = self.load_weights()
        print(f"📇 索引权重：{weights}")
        
        # 2. 渐进式披露
        context = self.disclose_context(task, weights)
        print(f"📄 披露上下文：{len(context['patterns'])} 模式, "
              f"{len(context['examples'])} 案例")
        
        # 3. 调用Agent（实际调用LLM API）
        code = self.call_agent(task, context)
        
        # 4. 保存代码
        output_path = self.save_code(task, code)
        print(f"✅ 代码已生成：{output_path}")
        
        # 5. 评估质量
        quality = self.evaluate_quality(code, weights)
        print(f"📊 质量评分：{quality['overall']:.2f}")
        
        # 6. 记录经验
        self.record_experience(task, context, code, quality)
        
        return {
            'output_path': output_path,
            'quality': quality
        }
    
    def load_weights(self):
        """读取特征权重"""
        weights_file = self.indices_dir / 'feature-weights.json'
        data = json.loads(weights_file.read_text())
        return {
            k: v['value']
            for k, v in data['weights'].items()
        }
    
    def disclose_context(self, task, weights):
        """渐进式披露上下文"""
        context = {
            'patterns': [],
            'examples': [],
            'apis': []
        }
        
        # 按权重降序披露
        sorted_features = sorted(
            weights.items(),
            key=lambda x: x[1],
            reverse=True
        )
        
        for feature, weight in sorted_features:
            if weight >= 0.85:
                # 完整披露
                pattern_file = self.knowledge_dir / 'patterns' / f'{feature}.md'
                if pattern_file.exists():
                    context['patterns'].append({
                        'feature': feature,
                        'level': 'full',
                        'content': pattern_file.read_text()
                    })
            elif weight >= 0.50:
                # 摘要披露
                pattern_file = self.knowledge_dir / 'patterns' / f'{feature}.md'
                if pattern_file.exists():
                    content = pattern_file.read_text()
                    summary = self.extract_summary(content)
                    context['patterns'].append({
                        'feature': feature,
                        'level': 'summary',
                        'content': summary
                    })
        
        return context
    
    def call_agent(self, task, context):
        """调用LLM API生成代码"""
        # 实际实现需要调用OpenAI/Anthropic API
        prompt = self.build_prompt(task, context)
        
        # 示例（需替换为真实API调用）
        print("🤖 调用Agent生成代码...")
        # code = openai.ChatCompletion.create(...)
        
        # 临时：返回模拟代码
        code = f"""
# {task['name']}Component.verse
# Auto-generated by Producer

using {{ /Fortnite.com/Devices }}

{task['name']}_component := class(creative_device):
    # Implementation
    pass
"""
        return code
    
    def build_prompt(self, task, context):
        """构建Agent提示词"""
        prompt = f"""
基于以下上下文，生成一个实现"{task['name']}"的Verse组件。

要求：
- 架构：SceneGraph L3 Component Layer
- 遵循以下设计模式（按重要性排序）：

"""
        for pattern in context['patterns']:
            prompt += f"\n### {pattern['feature']} ({pattern['level']})\n"
            prompt += pattern['content']
        
        prompt += f"\n\n生成：{task['name']}Component.verse"
        
        return prompt
    
    def save_code(self, task, code):
        """保存生成的代码"""
        category = task.get('category', 'misc')
        output_dir = Path('assets/modules') / category
        output_dir.mkdir(parents=True, exist_ok=True)
        
        filename = f"{task['name']}Component.verse"
        output_path = output_dir / filename
        output_path.write_text(code)
        
        # 保存元数据
        metadata = {
            'module': task['name'],
            'category': category,
            'generated_at': datetime.now().isoformat(),
            'cycle': self.get_current_cycle()
        }
        metadata_path = output_dir / f"{filename}.metadata.json"
        metadata_path.write_text(json.dumps(metadata, indent=2))
        
        return output_path
    
    def evaluate_quality(self, code, weights):
        """评估代码质量"""
        # 简化版评估（实际可用静态分析工具）
        quality = {
            'overall': 0.65,  # 基准分
            'features': {}
        }
        
        for feature in weights.keys():
            # 实际应分析代码是否符合特征
            quality['features'][feature] = 0.65 + (weights[feature] - 0.5) * 0.2
        
        quality['overall'] = sum(quality['features'].values()) / len(quality['features'])
        
        return quality
    
    def record_experience(self, task, context, code, quality):
        """记录运行经验"""
        cycle = self.get_current_cycle()
        
        experience = {
            'cycle': cycle,
            'timestamp': datetime.now().isoformat(),
            'task': task,
            'disclosed_context': {
                'patterns': [p['feature'] for p in context['patterns']],
                'examples': len(context['examples']),
                'total_tokens': self.count_tokens(context)
            },
            'output': {
                'lines': len(code.split('\n')),
                'quality_score': quality['overall']
            },
            'analysis': {
                'features': quality['features']
            }
        }
        
        exp_file = Path('data/experiences') / f'run-{cycle:03d}.json'
        exp_file.write_text(json.dumps(experience, indent=2))
        
        print(f"📝 经验已记录：{exp_file}")
    
    def get_current_cycle(self):
        phase_file = Path('.state/phase.json')
        phase = json.loads(phase_file.read_text())
        return phase['cycle_count'] + 1
    
    def extract_summary(self, content, max_lines=10):
        """提取文档摘要"""
        lines = content.split('\n')
        return '\n'.join(lines[:max_lines])
    
    def count_tokens(self, context):
        """估算token数"""
        total = 0
        for pattern in context['patterns']:
            total += len(pattern['content']) // 4  # 粗略估算
        return total

if __name__ == "__main__":
    producer = Producer()
    
    # 测试任务
    task = {
        'name': 'Health',
        'category': 'player',
        'capability_id': 'player_health'
    }
    
    result = producer.run(task)
    print(f"\n✅ Producer运行完成")
    print(f"输出：{result['output_path']}")
    print(f"质量：{result['quality']['overall']:.2f}")
```

### 步骤3：运行首次生产

```bash
#!/bin/bash
# scripts/run-first-cycle.sh

echo "🚀 开始首轮生产循环..."

# 运行Producer
python3 scripts/producer.py

# 更新系统状态
python3 scripts/update-state.py \
  --cycle-increment 1 \
  --coverage-increment 0.01

echo "✅ 首轮循环完成！"
echo ""
echo "检查输出："
echo "- 代码：assets/modules/"
echo "- 经验：data/experiences/run-001.json"
echo "- 状态：.state/phase.json"
```

### 验证首轮产出

```bash
# 检查生成的代码
cat assets/modules/player/HealthComponent.verse

# 检查经验数据
jq . data/experiences/run-001.json

# 检查系统状态
jq . .state/phase.json
```

## 🧩 阶段3：首次拼装

运行Composer，测试积木拼装流程。

```bash
# 积累至少5-10个积木后
python3 scripts/composer.py \
  --requirement "实现简单的玩家状态系统" \
  --output assets/composed/PlayerState

# 检查拼装结果
ls -la assets/composed/PlayerState/
cat assets/composed/PlayerState/components.txt
```

## 🎓 阶段4：首次学习

当积累10个样本后，运行Learner优化索引。

```bash
# 运行Learner
python3 scripts/learner.py \
  --analyze-last 10 \
  --update-weights

# 查看学习报告
jq . data/learning-reports/report-010.json

# 检查权重更新
jq '.weights' .state/indices/feature-weights.json
```

## 🔄 阶段5：规模化运行

### 自动化循环

```bash
#!/bin/bash
# scripts/auto-loop.sh

TARGET_CYCLES=50
current_cycle=$(jq '.cycle_count' .state/phase.json)

while [ $current_cycle -lt $TARGET_CYCLES ]; do
    echo "=== Cycle $((current_cycle + 1)) / $TARGET_CYCLES ==="
    
    # 运行Producer
    python3 scripts/orchestrator.py
    
    # 每5轮运行Learner
    if [ $((current_cycle % 5)) -eq 0 ]; then
        python3 scripts/learner.py --analyze-last 5
    fi
    
    # 每10轮生成报告
    if [ $((current_cycle % 10)) -eq 0 ]; then
        python3 scripts/generate-report.py
    fi
    
    current_cycle=$(jq '.cycle_count' .state/phase.json)
    
    sleep 2
done

echo "🎉 已完成 $TARGET_CYCLES 轮循环！"
```

## 🐛 调试和验证方法

### 检查披露策略

```python
# scripts/debug-disclosure.py

def debug_disclosure(cycle):
    """检查某轮循环的披露策略"""
    exp_file = Path(f'data/experiences/run-{cycle:03d}.json')
    exp = json.loads(exp_file.read_text())
    
    print(f"=== Cycle {cycle} 披露分析 ===\n")
    
    print("披露的模式：")
    for pattern in exp['disclosed_context']['patterns']:
        print(f"  - {pattern}")
    
    print(f"\n披露的案例数：{exp['disclosed_context']['examples']}")
    print(f"总token数：{exp['disclosed_context']['total_tokens']}")
    
    print(f"\n产出质量：{exp['output']['quality_score']:.2f}")
    
    print("\n特征分数：")
    for feature, score in exp['analysis']['features'].items():
        print(f"  {feature}: {score:.2f}")
```

### 验证质量趋势

```python
# scripts/plot-quality-trend.py

import matplotlib.pyplot as plt
import json
from pathlib import Path

def plot_quality_trend():
    """绘制质量趋势图"""
    experiences = []
    
    for exp_file in sorted(Path('data/experiences').glob('run-*.json')):
        exp = json.loads(exp_file.read_text())
        experiences.append({
            'cycle': exp['cycle'],
            'quality': exp['output']['quality_score']
        })
    
    cycles = [e['cycle'] for e in experiences]
    qualities = [e['quality'] for e in experiences]
    
    plt.figure(figsize=(10, 6))
    plt.plot(cycles, qualities, marker='o')
    plt.xlabel('Cycle')
    plt.ylabel('Quality Score')
    plt.title('Quality Trend')
    plt.grid(True)
    plt.savefig('quality-trend.png')
    print("✓ 质量趋势图已生成：quality-trend.png")
```

### 检查权重进化

```bash
#!/bin/bash
# scripts/show-weight-evolution.sh

echo "=== 权重进化历史 ==="
jq -r '.weights | to_entries[] | "\(.key):\n  历史: \(.value.history)\n  当前: \(.value.value)\n"' \
  .state/indices/feature-weights.json
```

## ✅ 验收标准

### 成功指标

- [ ] 完成至少20轮生产循环
- [ ] 质量分数从0.65提升到0.75+
- [ ] 权重明显分化（最高-最低 > 0.30）
- [ ] 成功拼装至少1个完整功能
- [ ] 复用率 >= 60%

### 质量检查

```bash
#!/bin/bash
# scripts/final-verification.sh

echo "🔍 最终验收检查..."

# 1. 循环数
cycles=$(jq '.cycle_count' .state/phase.json)
echo "循环数：$cycles (要求 >= 20)"

# 2. 质量趋势
latest_quality=$(jq '.history[-1].quality_score' .state/quality-history.json)
echo "最新质量：$latest_quality (要求 >= 0.75)"

# 3. 权重分化
max_weight=$(jq '[.weights[].value] | max' .state/indices/feature-weights.json)
min_weight=$(jq '[.weights[].value] | min' .state/indices/feature-weights.json)
diff=$(echo "$max_weight - $min_weight" | bc)
echo "权重分化：$diff (要求 >= 0.30)"

# 4. 积木数量
module_count=$(find assets/modules -name "*.verse" | wc -l)
echo "积木数量：$module_count"

# 5. 拼装数量
composed_count=$(find assets/composed -type d -mindepth 1 -maxdepth 1 | wc -l)
echo "拼装功能：$composed_count (要求 >= 1)"

echo ""
echo "📊 验收完成"
```

## 📖 下一步

- **深入理解进化** → [07-evolution-mechanism.md](./07-evolution-mechanism.md)
- **查看完整工作流** → [06-workflow.md](./06-workflow.md)
- **回顾架构设计** → [01-architecture.md](./01-architecture.md)

---

**返回** → [框架文档首页](./README.md)
