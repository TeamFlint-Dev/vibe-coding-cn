# 流水线定义目录

此目录包含各种流水线的 YAML 定义文件。

## 文件列表

| 文件 | 用途 |
|------|------|
| `skills-distill.yaml` | Skills 知识蒸馏流水线 |
| `game-design.yaml` | 游戏设计流水线（待添加） |
| `system-design.yaml` | 系统设计流水线（待添加） |

## 配置格式

```yaml
name: pipeline-name
description: 流水线描述
version: 1.0.0

stages:
  - id: stage-id
    name: 阶段名称
    description: 阶段描述
    depends_on: [前置阶段ID]
    inputs: [输入文件]
    outputs: [输出文件]
    quality_checks: [质量检查项]
    on_fail: abort|retry|rollback

settings:
  max_retries_per_stage: 3
  stage_timeout_minutes: 30
  parallel_execution: false
```

## 使用方式

```bash
# 启动流水线
gh aw run planner-agent \
  --input pipeline_type=skills-distill \
  --input source_url=https://example.com/docs
```
