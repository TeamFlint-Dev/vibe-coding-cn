# Pipeline 操作技能

> 封装流水线相关的所有 CLI 工具和操作知识

## 概述

本技能包含流水线生命周期管理的所有工具。Agent 只需将脚本放入 `tools/` 目录，CI 会自动同步到 `.github/tools/`。

## 可用工具

| 工具 | 用途 | 状态 |
|------|------|------|
| `pipeline-notify` | 通知调度器（ready/status/cancel） | ✅ 可用 |
| `pipeline-init` | 初始化流水线任务链 | 🚧 规划中 |
| `pipeline-advance` | 推进流水线阶段 | 🚧 规划中 |

## 快速使用

### 1. 通知调度器启动流水线

```bash
pipeline-notify ready \
  --pipeline-id p001 \
  --type skills-distill \
  --stages "ingest,classify,extract,assemble,validate"
```

### 2. 查询流水线状态

```bash
pipeline-notify status --pipeline-id p001
```

### 3. 取消流水线

```bash
pipeline-notify cancel --pipeline-id p001
```

## 环境变量

| 变量 | 用途 | 默认值 |
|------|------|--------|
| `PIPELINE_SERVER_URL` | 调度服务器地址 | `http://193.112.183.143:19527` |
| `PIPELINE_SECRET` | 签名密钥 | (必需) |

## 工具开发规范

### 添加新工具

1. **放对位置**：将 `.py` 文件放入 `skills/programming/pipelineOps/tools/`
2. **文件头注释**：包含用法、环境变量、依赖说明
3. **自动同步**：CI 会自动收集到 `.github/tools/`

### 文件头模板

```python
#!/usr/bin/env python3
"""
<tool-name> - 简短描述

用途：
  详细说明工具的用途

用法：
  <tool-name> <command> [options]
  
示例：
  <tool-name> do-something --option value

环境变量：
  VAR_NAME  - 说明 (默认: xxx)

依赖：
  - 外部依赖说明
"""
```

### 输出规范

- 成功返回 0，失败返回非 0
- 支持 `--json` 标志输出 JSON 格式
- 错误信息输出到 stderr

## 相关资源

- **调度器源码**: `scripts/webhook-server/pipeline_scheduler.py`
- **流水线定义**: `pipelines/skills-distill.yaml`
- **Beads CLI**: `skills/programming/beadsCLI/SKILL.md`

## 阅读顺序

1. **本文档** - 了解工具用法（90% 场景够用）
2. **tools/ 源码** - 需要调试或扩展时
3. **webhook-server/** - 了解服务端实现
