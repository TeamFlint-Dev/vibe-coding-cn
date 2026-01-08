# create-agentic-workflow Agent 深度分析

> **分析日期**: 2026-01-08  
> **运行编号**: #9  
> **源文件**: `agents/create-agentic-workflow.agent.md` (362 行)  
> **分析者**: workflow-case-study Agent

---

## 🎯 研究问题与发现

### 研究问题 1: 如何在一个 Agent 中优雅地支持双模式？

**发现**: 使用 **Mode Declaration + Conditional Instructions** 模式

**核心设计**:
1. **开头明确声明两种模式**（第 13-46 行）
   - Mode 1: Issue Form Mode（非交互式，批处理）
   - Mode 2: Interactive Mode（对话式，人类引导）

2. **分阶段指令切换**
   - 通用部分（Capabilities & Responsibilities）对两种模式生效
   - 模式特定部分用标题明确标注："(Interactive Mode Only)"

3. **上下文判断依据**
   - Issue Form Mode: 检测 GitHub issue body 中的结构化字段
   - Interactive Mode: 直接对话开始

**为什么这样设计**:
- 避免重复：通用知识（工具、安全规范）只写一次
- 清晰边界：每个模式的职责和流程明确分离
- 灵活扩展：未来可添加 Mode 3 而不破坏现有逻辑

### 研究问题 2: 如何确保生成的工作流遵循安全原则？

**发现**: 使用 **Embedded Security Framework** 模式

**四层安全设计**:

| 层级 | 机制 | 示例 |
|------|------|------|
| **原则层** | 最小权限默认 | `permissions: read-all`（第 234 行） |
| **工具层** | 禁用危险工具 | 明确禁止 `create_issue` 等 GitHub 写操作（第 198 行） |
| **输出层** | 强制 safe-outputs | 所有写操作必须通过 safe-outputs（第 236 行） |
| **网络层** | 显式询问网络需求 | 第 83 行明确提醒询问网络配置 |

**关键约束表达**:
```yaml
⚠️ **IMPORTANT**:
- **Never recommend GitHub mutation tools** like `create_issue`
- **Always use `safe-outputs` instead**
- **DO NOT recommend `mode: remote`**
```

**为什么这样设计**:
- 多层防御：即使 Agent 忘记某一层，其他层仍能兜底
- 显式警告：使用 ⚠️ 和加粗强调危险操作
- 正向引导：不只说"不要做什么"，也说"应该做什么"

### 研究问题 3: 如何平衡自动化和交互性？

**发现**: 使用 **Progressive Disclosure** 模式

**交互设计原则**（第 47-49 行）:
```
"Don't overwhelm the user with too many questions at once"
"Ask the user to express their intent in their own words"
"Do NOT ask all these questions at once"
```

**渐进式信息收集**:
1. **首次接触**: 只问一个问题："What do you want to automate today?"（第 73 行）
2. **二次对话**: 根据回答，映射到工作流触发器、工具
3. **深入探索**: 按需询问（网络访问、浏览器自动化等）

**人性化设计**:
- 使用 Emoji（第 54 行）
- 模仿 GitHub Copilot CLI 风格（第 52 行）
- 等待用户回应，不自作主张

**为什么这样设计**:
- 降低认知负荷：一次一个问题
- 建立信任：让用户感觉在掌控，而非被问卷轰炸
- 提高完成率：渐进式比一次性收集更容易完成

---

## 📊 分析摘要

### 触发方式
- **Agent 文件**，不是工作流，通过 `assign-to-agent` 调用
- `infer: false` - 不自动推断模式，需明确指令

### Frontmatter 配置
```yaml
description: Design agentic workflows with interactive guidance
infer: false
```

**设计意图**: Agent 必须被明确告知进入哪种模式，避免误判

### Prompt 结构
- **362 行**，分为 8 个主要章节
- **双模式设计**：开头 34 行用于模式声明和分流
- **安全优先**：3 处明确的安全警告（⚠️）
- **文档引用**：指向 `github-agentic-workflows.md`（第 60-62 行）

### 复杂度评估
| 维度 | 评分 | 说明 |
|------|------|------|
| Frontmatter | ⭐ | 极简，只有 2 个字段 |
| Prompt 长度 | ⭐⭐⭐ | 362 行，详尽但结构清晰 |
| 逻辑复杂度 | ⭐⭐ | 双模式分支，但边界清晰 |
| 安全考虑 | ⭐⭐⭐ | 多层安全约束，非常严格 |

---

## 🎨 识别的设计模式

### 1. **Dual-Mode Agent Pattern** ⭐⭐⭐⭐ 新发现

**识别特征**:
- Agent 文件支持两种运行模式
- 开头明确的 "Two Modes of Operation" 章节
- 条件性指令："(Interactive Mode Only)"

**结构**:
```markdown
## Two Modes of Operation

### Mode 1: [自动化模式]
[批处理逻辑]

### Mode 2: [交互模式]
[对话逻辑]

## [共享章节]
[通用能力]

## [模式特定章节] (Mode X Only)
[特定逻辑]
```

**用途**: 一个 Agent 服务多种使用场景

**与 Workflow 的 Dual-Mode 区别**:
- Workflow Dual-Mode: 多种触发器（issues + workflow_dispatch）
- Agent Dual-Mode: 多种交互方式（批处理 + 对话）

### 2. **Progressive Disclosure Pattern** ⭐⭐⭐⭐ 新发现

**识别特征**:
- "Don't overwhelm the user"
- 首次只问一个问题
- 渐进式收集信息

**实现方式**:
1. 初始问题：极简（What do you want to automate?）
2. 条件追问：根据回答展开
3. 明确指令："Wait for the user to respond"

**心理学原理**: 认知负荷理论 - 一次处理的信息量有限

### 3. **Embedded Security Framework Pattern** ⭐⭐⭐⭐ 新发现

**识别特征**:
- 多层安全约束（原则、工具、输出、网络）
- 显式警告标记（⚠️、IMPORTANT、NEVER）
- 正反向指导（禁止 X + 推荐 Y）

**四层防御**:
```yaml
层级 1: 默认最小权限 (permissions: read-all)
层级 2: 禁用危险工具 (Never recommend GitHub mutation tools)
层级 3: 强制安全输出 (Always use safe-outputs)
层级 4: 网络白名单 (Constrain network to minimum required)
```

**用途**: 确保 AI 生成的配置符合安全最佳实践

### 4. **Fuzzy Scheduling Advocacy Pattern** ⭐⭐⭐ 新发现

**识别特征**:
- 专门的 "Scheduling Best Practices" 章节（第 87-93 行）
- 明确推荐 fuzzy（`schedule: daily`）
- 明确反对 fixed time（`cron: "0 0 * * *"`）

**设计意图**: 避免负载尖峰

**实现**:
```yaml
✨ Recommended: schedule: daily  # 编译器自动散列
⚠️ Avoid: cron: "0 0 * * *"      # 所有工作流同时运行
```

**为什么重要**: 
- 100+ 工作流同时运行 → GitHub Actions 限流
- 散列时间 → 平滑负载曲线

### 5. **Safe Outputs Jobs Pattern** ⭐⭐⭐⭐ 新发现

**识别特征**:
- 专门章节 "Custom Safe Output Jobs"（第 111-182 行）
- 明确区分 `safe-outputs.jobs:` 和 `post-steps:`
- 完整的 email 发送示例（70 行）

**用途**: 自定义 safe outputs（发送邮件、Slack 通知等）

**关键区别**:
```yaml
safe-outputs.jobs:  # 用于自定义写操作（基于 AI 输出）
post-steps:         # 用于清理/日志（不依赖 AI 输出）
```

**示例结构**:
```yaml
safe-outputs:
  jobs:
    email-notify:
      description: "Send email"
      inputs:  # AI agent 提供的参数
        recipient: ...
        subject: ...
        body: ...
      steps:   # 实际执行逻辑
        - name: Send email
          run: |
            # SMTP 配置和发送逻辑
```

### 6. **Documentation-First Pattern** ⭐⭐⭐

**识别特征**:
- 开头即指示阅读完整文档（第 6 行）
- 引用本地和上游文档（第 60-62 行）
- "Read the ENTIRE content carefully"

**文档层级**:
1. Agent 自身指令（本文件）
2. 本地 instructions（@.github/aw/github-agentic-workflows.md）
3. 上游规范（GitHub raw URL）

**用途**: 确保 Agent 基于最新、权威的信息工作

### 7. **Fail-Safe File Creation Pattern** ⭐⭐⭐

**识别特征**:
- 创建文件前检查存在性（第 35 行）
- 存在时自动修改文件名（`-v2`、时间戳）
- 避免覆盖现有工作流

**实现**:
```markdown
Before creating, check if file exists
If it does, append suffix like `-v2` or timestamp
```

**为什么重要**: 防止意外覆盖用户已有的工作流

### 8. **Default Engine Omission Pattern** ⭐⭐

**识别特征**:
- 第 232 行："Copilot is the default engine - do NOT include `engine: copilot`"
- 减少冗余配置

**设计哲学**: 默认值不写，减少噪音

---

## 🔍 批判性分析

### 优点

1. **模式分离清晰** ✅
   - 双模式边界明确，没有混淆
   - 共享部分和特定部分区分清楚

2. **安全性极强** ✅
   - 四层防御，覆盖权限、工具、输出、网络
   - 多处警告，难以忽略

3. **用户体验优秀** ✅
   - 渐进式问题，不会overwhelm
   - 人性化表达（Emoji、Copilot CLI 风格）

4. **文档完整** ✅
   - 包含完整的 email safe output 示例
   - 正反向示例（推荐 vs 避免）

### 可改进之处

1. **模式判断逻辑不够明确** ⚠️
   - 没有明确说明如何检测当前是哪种模式
   - 假设：Issue Form Mode 通过 issue body 结构判断，但未明确说明 fallback 策略

   **改进建议**: 添加明确的模式判断流程图或伪代码

2. **Issue Form 数据提取脆弱** ⚠️
   - 依赖特定的 Markdown 标题格式（`### Workflow Name`）
   - 如果用户修改 issue body，可能解析失败

   **改进建议**: 
   - 使用更鲁棒的解析（正则表达式 + fallback）
   - 提供数据提取失败的错误处理

3. **Interactive Mode 缺少终止条件** ⚠️
   - 没有明确说明对话何时结束
   - 用户可能不知道何时 Agent 会开始创建文件

   **改进建议**: 添加明确的"确认"步骤：
   ```markdown
   ### Before Creating the Workflow
   Present a summary of the configuration and ask:
   "Does this look correct? (yes to proceed, or provide feedback)"
   ```

4. **Fuzzy Scheduling 缺少 tradeoff 说明** ⚠️
   - 只说了 fuzzy 的好处，没说潜在问题
   - 问题：调试困难（时间不确定），定时任务可能不满足需求

   **改进建议**: 说明适用场景：
   ```markdown
   Use fuzzy scheduling for:
   - Daily reports (exact time not critical)
   - Maintenance tasks (can run anytime in the day)
   
   Use fixed time for:
   - Integration with external systems (must run at specific time)
   - Coordination with other workflows
   ```

5. **缺少示例工作流** ⚠️
   - 没有提供完整的端到端示例
   - 新用户可能不知道最终生成的文件长什么样

   **改进建议**: 添加一个简单的示例：
   ```markdown
   ## Example: Simple Issue Labeler
   
   [完整的 .md 文件内容]
   ```

### 潜在风险

1. **模式混淆风险** 🚨
   - 如果 Agent 误判模式，可能自动创建不符合预期的工作流
   - **缓解**: 添加模式确认步骤

2. **过度自动化风险** 🚨
   - Issue Form Mode 完全自动，没有人类确认
   - **缓解**: 创建 PR 而非直接 merge

3. **文档同步风险** 🚨
   - 引用的 `github-agentic-workflows.md` 可能过时
   - **缓解**: 添加版本检查或日期戳

---

## 📦 可复用代码片段

### 1. 双模式 Agent 骨架

```markdown
---
description: [Agent description]
infer: false
---

# [Agent Name]

## Two Modes of Operation

### Mode 1: Automated Mode
When triggered by [specific condition]:
1. Parse input
2. Execute automatically
3. Create output

### Mode 2: Interactive Mode
When working directly with user:
- Engage in conversation
- Gather requirements iteratively
- Build solution collaboratively

## Capabilities (Both Modes)
[Shared capabilities]

## [Mode 1 Specific Section] (Automated Mode Only)
[Mode 1 logic]

## [Mode 2 Specific Section] (Interactive Mode Only)
[Mode 2 logic]

## Guidelines (Both Modes)
[Common guidelines]
```

### 2. 渐进式问题模板

```markdown
## Starting the Conversation (Interactive Mode Only)

1. **Initial Question**
   Ask one simple question:
   - [Your initial question]

   That's it, no more text. Wait for the user to respond.

2. **Follow-up Questions**
   Based on the response, ask clarifying questions:
   - [Question 1]
   - [Question 2]
   
   DO NOT ask all questions at once; engage in back-and-forth.
```

### 3. 安全框架模板

```markdown
## Security Best Practices

Apply these security layers:

1. **Permissions**: Default to `permissions: read-all`
2. **Tools**: 
   - ⚠️ **NEVER** use [dangerous tools]
   - ✅ **ALWAYS** use [safe alternatives]
3. **Outputs**: Use `safe-outputs` for all write operations
4. **Network**: Constrain to minimum required domains

**Example**:
```yaml
permissions:
  contents: read
tools:
  github:
    toolsets: [default]  # Read-only
safe-outputs:
  add-comment:
    max: 1
```
```

### 4. Fuzzy Scheduling 推荐模板

```markdown
## Scheduling Best Practices

📅 For scheduled workflows:
- ✨ **Recommended**: `schedule: daily` (fuzzy - time scattered automatically)
- ⚠️ **Avoid**: `cron: "0 0 * * *"` (fixed time - creates load spikes)

**Why fuzzy scheduling?**
- Distributes load across the day
- Reduces API rate limiting
- Improves system reliability
```

### 5. Custom Safe Output Job 模板

```yaml
safe-outputs:
  jobs:
    custom-action:
      description: "Perform custom action"
      runs-on: ubuntu-latest
      output: "Action completed!"
      inputs:
        param1:
          description: "Parameter 1"
          required: true
          type: string
      steps:
        - name: Execute action
          env:
            SECRET: "${{ secrets.MY_SECRET }}"
            PARAM: "${{ inputs.param1 }}"
          run: |
            # Your custom logic here
            echo "Executing with $PARAM"
```

### 6. Fail-Safe 文件创建模板

```markdown
### File Creation Safety

Before creating a file:
1. Check if `.github/workflows/<workflow-id>.md` exists
2. If exists, modify the ID:
   - Append `-v2`, `-v3`, etc.
   - Or use timestamp: `<workflow-id>-20260108`
3. Create the file with the modified name
```

---

## 💡 Skill 更新建议

### workflowAnalyzer Skill

**新增模式**（6个）:

1. **Dual-Mode Agent Pattern** ⭐⭐⭐⭐
2. **Progressive Disclosure Pattern** ⭐⭐⭐⭐
3. **Embedded Security Framework Pattern** ⭐⭐⭐⭐
4. **Fuzzy Scheduling Advocacy Pattern** ⭐⭐⭐
5. **Safe Outputs Jobs Pattern** ⭐⭐⭐⭐
6. **Fail-Safe File Creation Pattern** ⭐⭐⭐

**更新位置**: `SKILL.md` 的 "设计模式识别" 章节

### workflowAuthoring Skill

**新增片段库**:

1. **双模式 Agent 骨架**（设计模式库）
2. **渐进式问题模板**（Prompt 结构模板）
3. **安全框架模板**（代码片段库）
4. **Fuzzy Scheduling 推荐**（最佳实践）
5. **Custom Safe Output Job**（代码片段库）
6. **Fail-Safe 文件创建**（最佳实践）

**更新位置**: `SKILL.md` 的对应章节

---

## 🔮 后续研究方向

1. **Agent vs Workflow 对比研究**
   - Agent 文件（.agent.md）和 Workflow 文件（.md）的架构差异
   - 何时使用 Agent，何时使用 Workflow？
   - `infer: true/false` 的影响

2. **Interactive Agent UX 最佳实践**
   - 如何设计更自然的对话流程？
   - 如何避免"问卷式"体验？
   - 如何在自动化和控制感之间平衡？

3. **安全模式演化研究**
   - gh-aw 的安全机制如何演进？
   - 哪些安全漏洞被修复过？
   - 未来可能的安全增强？

4. **Custom Safe Outputs 生态**
   - 社区有哪些常见的 custom safe outputs？
   - 如何设计可复用的 safe output job？
   - 是否需要 safe output job 市场？

---

## 📝 元数据

- **分析时长**: ~30 分钟
- **发现的新模式**: 6 个
- **可复用片段**: 6 个
- **关键洞见**: 双模式设计是 Agent 文件的杀手级特性

---

## 🎓 学到的教训

1. **Agent 文件不是简化版 Workflow**
   - Agent 是可复用的"能力单元"
   - Workflow 是"任务编排"
   - Agent 可以被多个 Workflow 调用

2. **双模式设计解决的是"灵活性悖论"**
   - 自动化需要批处理（快速、无人工）
   - 复杂任务需要交互（准确、人类引导）
   - 双模式让同一个 Agent 兼顾两者

3. **安全不是事后补丁，是设计约束**
   - 从 Prompt 级别嵌入安全规则
   - AI 生成的配置天然符合安全规范
   - 多层防御确保即使 AI 犯错也安全

4. **用户体验是 Agent 成功的关键**
   - 技术再强，如果用户体验差，不会被采用
   - 渐进式信息收集降低认知负荷
   - Emoji 和风格模仿建立亲和力

---

> **下次分析建议**: 研究 `agentic-campaign-designer.agent.md`，对比两个 Agent 的设计差异
