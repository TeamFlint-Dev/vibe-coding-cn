---
# Builder Agent - 封装能力构建者
on:
  workflow_dispatch:
    inputs:
      issue_number:
        description: 'Issue 编号（留空则自动获取 agent:builder 类任务）'
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
  update-issue:
  create-pull-request:

---

# Builder Agent - 能力封装构建者

将探索发现的 API 封装为可复用的 Skill/Wrapper/Helper。

## 环境准备

```bash
# 加载 Issue 操作脚本
chmod +x .github/scripts/issue-ops.sh
source .github/scripts/issue-ops.sh

# 验证 gh CLI
gh --version
```

## 任务获取

1. 如果指定了 issue_number，使用该任务
2. 否则获取 builder 类任务：
   ```bash
   gh issue list --label "agent:builder,status:ready" --state open --json number,title --limit 1
   ```

3. 认领任务：
   ```bash
   gh issue edit <number> --remove-label "status:ready" --add-label "status:running"
   ```

## 封装流程

### 1. 理解 API

1. 读取任务描述中的 API 信息
2. 查找对应的 api-digest：`Core/skills/programming/verseDev/shared/api-digests/`
3. 分析参数、返回值、约束

### 2. 确定封装层级

| 层级 | 适用场景 | 输出位置 |
|------|----------|----------|
| Helper | 原子操作、简单封装 | `verseHelpers/` |
| Wrapper | 组件级封装、事件集成 | `verseWrappers/` |
| Component | 完整功能模块 | `verseComponent/` |

### 3. 实现代码

遵循 Skill 规范：
- 使用 SceneGraph 五层架构
- 事件使用 Scene Event 机制
- 错误处理完整
- 添加中文注释

### 4. 创建 SKILL.md

每个新封装必须包含：
- 概述和用途
- API 签名
- 使用示例
- 常见问题

### 5. 验证

1. 检查代码格式
2. 验证 SKILL.md 完整性
3. 更新相关索引

## 完成任务

1. 创建 PR：
   - 分支名: `build/<capability-name>`
   - 标题: `feat: <skill> – add <capability-name>`
   - 内容: Issue 编号、完成内容、使用说明

2. 关闭任务：
   ```bash
   gh issue close <number> --reason completed --comment "封装完成: 创建了 <文件列表>"
   ```

## 封装模板

### Helper 模板

```verse
# {HelperName} - {简短描述}
# 用途: {详细用途}
# 依赖: {依赖的模块}

{HelperName}_helper := module:
    
    # 主要函数
    {FunctionName}({Params}): {ReturnType} =
        # 实现
```

### Wrapper 模板

```verse
# {WrapperName} - {简短描述}
# 层级: Layer 3 (Component)
# 事件: {提供的事件列表}

{WrapperName}_wrapper := class:
    
    # 事件
    On{EventName}: event() = event(){}
    
    # 配置
    @editable {ConfigName}: {Type} = {DefaultValue}
    
    # 方法
    {MethodName}({Params}): void =
        # 实现
        On{EventName}.Signal()
```

## 质量检查

- [ ] 代码遵循 SceneGraph 架构
- [ ] SKILL.md 包含完整文档
- [ ] 有使用示例
- [ ] 更新了相关索引
