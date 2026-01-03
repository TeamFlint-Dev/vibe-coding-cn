---
# Task Agent - 通用任务执行者
on:
  workflow_dispatch:
    inputs:
      issue_number:
        description: 'Issue 编号（可选，留空则自动获取）'
        required: false
        type: string

permissions:
  contents: read
  issues: write
  pull-requests: read

tools:
  bash: [":*"]
  edit:
  github:
    toolsets: [repos, issues, pull_requests]
    mode: remote

network:
  allowed:
    - "raw.githubusercontent.com"

safe-outputs:
  create-issue:
  add-comment:
  create-pull-request:

---

# Task Agent - 通用任务执行者

从 GitHub Issues 获取任务并执行。

## 环境准备

```bash
# 加载 Issue 操作脚本
chmod +x .github/scripts/issue-ops.sh
source .github/scripts/issue-ops.sh

# 验证 gh CLI
gh --version
gh auth status
```

## 获取任务

1. 查看可用任务：
   ```bash
   gh issue list --label "status:ready" --state open --json number,title,labels --limit 5
   ```

2. 如果指定了 issue_number 输入，使用该任务；否则选择第一个可用任务

3. 认领任务：
   ```bash
   source .github/scripts/issue-ops.sh
   issue_start <number>
   ```

## 执行任务

1. 读取任务描述和 labels：
   ```bash
   gh issue view <number> --json title,body,labels
   ```

2. 根据任务类型执行：
   - 如果有 `agent:explorer` label：执行探索任务
   - 如果有 `agent:builder` label：执行构建任务
   - 如果有 `agent:integrator` label：执行集成任务
   - 如果有 `stage:xxx` label：执行流水线阶段任务

3. 使用 `edit` 工具修改文件

## 完成任务

1. 关闭任务：
   ```bash
   source .github/scripts/issue-ops.sh
   
   # 获取阶段和流水线信息（如果有）
   STAGE=$(issue_get_stage <number>)
   PIPELINE=$(issue_get_pipeline <number>)
   
   if [ -n "$PIPELINE" ]; then
     # 流水线任务，使用完整的 complete 函数（会解锁后续阶段）
     issue_complete <number> "$STAGE" "$PIPELINE" "完成描述"
   else
     # 普通任务，直接关闭
     gh issue close <number> --reason completed --comment "✅ 完成描述"
   fi
   ```

2. 通过 `create-pull-request` 提交代码变更（如果有）

3. 通过 `add-comment` 报告执行结果

## 输出格式

在评论中包含：
- Issue 编号和标题
- 执行的步骤摘要
- 创建或修改的文件
- 下一步建议

## 标签体系

| 标签 | 说明 |
|------|------|
| `status:ready` | 可执行 |
| `status:running` | 执行中 |
| `status:blocked` | 等待依赖 |
| `status:failed` | 失败 |
| `agent:explorer` | 探索类任务 |
| `agent:builder` | 构建类任务 |
| `agent:integrator` | 集成类任务 |
| `pipeline:<id>` | 流水线任务 |
| `stage:<name>` | 流水线阶段 |
