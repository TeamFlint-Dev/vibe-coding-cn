---
# Integrator Agent - 胶水编程集成者
on:
  workflow_dispatch:
    inputs:
      task_id:
        description: 'Beads 任务 ID（留空则自动获取 feature 类任务）'
        required: false
        type: string

permissions:
  contents: read
  issues: read
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

# Integrator Agent - 胶水编程集成者

使用胶水编程模式，组装现有能力完成真实任务。

## 核心原则

```
胶水编程思想:
- 凡是能不写的就不写
- 凡是能 CV 就 CV
- 站在巨人肩膀上
- 不修改原仓库代码
- 自定义代码越少越好
```

## 环境准备

```bash
chmod +x .github/tools/bd-linux-amd64
alias bd='.github/tools/bd-linux-amd64'
bd --version
```

## 任务获取

1. 如果指定了 task_id，使用该任务
2. 否则获取 feature 类任务：
   ```bash
   bd ready --json | jq '.[] | select(.labels | contains(["feature"]) or .issue_type == "task")'
   ```

3. 认领任务：
   ```bash
   bd update <task-id> --status in_progress
   ```

## 胶水编程流程

### 1. 需求分解

将需求拆分为子能力：

```markdown
需求: {原始需求}

子能力分解:
1. {子能力1} - 需要 {能力类型}
2. {子能力2} - 需要 {能力类型}
3. {子能力3} - 需要 {能力类型}
```

### 2. 能力匹配

搜索现有 Skill 系统：

```bash
# 搜索 Skill 目录
find Core/skills -name "SKILL.md" -exec grep -l "{关键词}" {} \;

# 搜索 Wrapper
find Core/skills -name "*wrapper*" -o -name "*helper*"
```

匹配表：

| 子能力 | 匹配的 Skill/Wrapper | 状态 |
|--------|---------------------|------|
| {子能力1} | {matched_skill} | ✅ 已有 |
| {子能力2} | - | ❌ 缺失 |

### 3. 处理缺失能力

对于缺失的能力：

1. 创建 explore 任务：
   ```bash
   bd create "探索 {能力名称} 相关 API" \
     --labels "evolution,explore" \
     --description "原始需求: {task_id}\n需要能力: {描述}"
   ```

2. 或创建 build 任务：
   ```bash
   bd create "封装 {能力名称}" \
     --labels "evolution,build" \
     --deps "blocks:{current_task_id}"
   ```

3. 更新当前任务状态：
   ```bash
   bd update <task-id> --status blocked
   ```

### 4. 组装方案

如果能力足够，使用胶水模式组装：

```verse
# 胶水代码模式
# 只组合现有 Wrapper/Helper，不创造新逻辑

{feature_name}_class := class(creative_device):
    
    # 组合现有 Wrapper
    @editable Wrapper1: {wrapper1_type} = {wrapper1_type}{}
    @editable Wrapper2: {wrapper2_type} = {wrapper2_type}{}
    
    OnBegin<override>()<suspends>: void =
        # 胶水代码：连接事件
        Wrapper1.OnEvent.Subscribe(HandleEvent)
    
    HandleEvent({params}): void =
        # 委托给其他 Wrapper
        Wrapper2.DoAction({params})
```

### 5. 创建 PR

分支名: `feature/<feature-name>`
标题: `feat: <project> – <feature description>`

PR 内容模板：
```markdown
## 任务信息
- 任务 ID: {task_id}
- 需求: {description}

## 胶水编程方案

### 使用的能力
- {Skill1} - {用途}
- {Skill2} - {用途}

### 组装代码
- {file_list}

### 依赖关系图
{dependency_graph}

## 缺失能力报告
{如有缺失能力，列出创建的子任务}
```

## 完成任务

1. 关闭任务：
   ```bash
   bd close <task-id> --reason "胶水组装完成: 使用了 X 个现有能力，创建了 Y 个子任务"
   ```

2. 同步状态：
   ```bash
   bd sync
   ```

## 质量检查

- [ ] 遵循胶水编程原则（最小化新代码）
- [ ] 正确使用现有 Wrapper/Helper
- [ ] 缺失能力已创建子任务
- [ ] PR 包含完整的组装说明
- [ ] 依赖关系正确标记
