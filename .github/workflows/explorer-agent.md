---
# Explorer Agent - 探索 UEFN 能力边界
on:
  workflow_dispatch:
    inputs:
      explore_direction:
        description: '探索方向 (留空则自动选择)'
        required: false
        type: string
  schedule:
    - cron: "0 8 * * *"  # 每天早上 8 点

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
    - "dev.epicgames.com"

safe-outputs:
  create-issue:
  add-comment:
  create-pull-request:

---

# Explorer Agent - API 边界探索者

自动探索 UEFN/Verse 的能力边界，发现未封装的 API。

## 环境准备

```bash
chmod +x .github/tools/bd-linux-amd64
alias bd='.github/tools/bd-linux-amd64'
bd --version
```

## 任务获取

1. 查看探索类任务：
   ```bash
   bd ready --json | jq '.[] | select(.labels | contains(["explore"]))'
   ```

2. 如果有探索任务则认领，否则进入自主探索模式

## 探索策略

### 1. 文档驱动探索

1. 读取 `Core/skills/programming/verseDev/shared/api-digests/` 目录
2. 统计已覆盖的 API 模块
3. 识别未覆盖或覆盖不完整的模块

### 2. 代码驱动探索

1. 扫描现有 Wrapper 代码
2. 分析依赖的 API
3. 寻找相关但未封装的 API

### 3. 错误驱动探索

1. 读取 `verseTactician` 错误手册
2. 分析常见编译错误
3. 识别 API 使用边界

## 探索输出

对于每个发现的新 API 或能力：

1. 创建 Beads 任务：
   ```bash
   bd create "封装 {API名称} 能力" \
     --labels "evolution,build,skill:verseHelpers" \
     --description "发现的 API: {描述}\n预期用途: {用途}\n参考文档: {链接}"
   ```

2. 更新探索报告：
   - 新发现的 API 列表
   - 能力覆盖率变化
   - 优先级建议

## 完成任务

1. 如果认领了任务：
   ```bash
   bd close <task-id> --reason "探索完成: 发现 N 个新 API，创建了 M 个封装任务"
   ```

2. 同步状态：
   ```bash
   bd sync
   ```

3. 通过 `add-comment` 报告探索结果

## 探索方向优先级

1. **高优先级**: 游戏核心机制相关 (Player, Character, Weapon)
2. **中优先级**: UI 和反馈系统 (HUD, Message, Audio)
3. **低优先级**: 高级功能 (AI, Networking, Persistence)

如果指定了 explore_direction 输入，优先探索该方向。
