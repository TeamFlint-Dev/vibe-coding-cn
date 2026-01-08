# 工作日志：create-agentic-workflow Agent 分析

**日期**: 2026-01-08  
**运行编号**: #9  
**分析对象**: `agents/create-agentic-workflow.agent.md` (362 行)

---

## 选择理由

基于价值评估框架的评分：

| 维度 | 权重 | 评分 | 说明 |
|------|------|------|------|
| **Skill 空白度** | 40% | ⭐⭐⭐⭐⭐ | 之前未分析过 Agent 文件（vs Workflow），且该 Agent 最近有更新（minimal frontmatter 优化） |
| **模式新颖度** | 25% | ⭐⭐⭐⭐⭐ | Agent 双模式设计（Issue Form + Interactive）为全新发现 |
| **实用价值** | 20% | ⭐⭐⭐⭐ | 我们项目也需要创建工作流，可直接复用双模式设计 |
| **复杂度适中** | 15% | ⭐⭐⭐⭐ | 362 行，结构清晰，适合深度分析 |

**综合评分**: ⭐⭐⭐⭐⭐ (满分)

**决策**: 分析 `create-agentic-workflow.agent.md`，这是首次研究 Agent 文件（.agent.md）而非 Workflow 文件（.md）。

---

## 关键发现

### 1. Agent vs Workflow 的本质区别

- **Agent**: 可复用的"能力单元"，通过 `assign-to-agent` 调用
- **Workflow**: 任务编排，响应特定事件
- **类比**: Agent = 函数库，Workflow = 主程序

### 2. 双模式设计（Dual-Mode Agent Pattern）⭐⭐⭐⭐

**核心价值**: 一个 Agent 同时支持：
- **Mode 1 (Issue Form)**: 批处理，自动化，无人工干预
- **Mode 2 (Interactive)**: 对话式，人类引导，渐进式收集

**实现方式**:
- 开头明确声明两种模式
- 共享部分（通用能力）写一次
- 模式特定部分用 "(Mode Only)" 标注

**解决的问题**: "灵活性悖论"
- 简单任务需要自动化（快速、批量）
- 复杂任务需要交互（准确、定制）

### 3. Progressive Disclosure（渐进式披露）⭐⭐⭐⭐

**设计原则**:
```
"Don't overwhelm the user with too many questions at once"
"Wait for the user to respond"
```

**实现**:
1. 首次只问一个问题："What do you want to automate?"
2. 根据回答，逐步展开后续问题
3. 避免"问卷式"体验

**心理学基础**: 认知负荷理论 - 人脑一次只能处理有限信息量

### 4. Embedded Security Framework（嵌入式安全框架）⭐⭐⭐⭐

**四层防御**:
1. **原则层**: 默认最小权限（`permissions: read-all`）
2. **工具层**: 禁用危险工具（禁止 GitHub mutation tools）
3. **输出层**: 强制 safe-outputs（所有写操作必须通过）
4. **网络层**: 显式询问网络需求（白名单）

**关键设计**: 多层防御 + 显式警告（⚠️）+ 正向引导

**价值**: AI 生成的配置天然符合安全规范

### 5. Safe Outputs Jobs（自定义安全输出作业）⭐⭐⭐⭐

**新概念**: 
```yaml
safe-outputs.jobs:  # 自定义写操作（基于 AI 输出）
post-steps:         # 清理/日志（不依赖 AI 输出）
```

**用途**: 发送邮件、Slack 通知、调用 Webhook

**示例**: 70 行完整的 email 发送 safe output job

### 6. Fuzzy Scheduling Advocacy（模糊调度倡导）⭐⭐⭐

**推荐**: `schedule: daily`（编译器自动散列时间）
**避免**: `cron: "0 0 * * *"`（固定时间，导致负载尖峰）

**原因**: 100+ 工作流同时运行 → GitHub Actions 限流

---

## 发现的新模式（6 个）

1. **Dual-Mode Agent Pattern** ⭐⭐⭐⭐ - 一个 Agent 支持双模式
2. **Progressive Disclosure Pattern** ⭐⭐⭐⭐ - 渐进式信息收集
3. **Embedded Security Framework Pattern** ⭐⭐⭐⭐ - 四层安全防御
4. **Fuzzy Scheduling Advocacy Pattern** ⭐⭐⭐ - 推荐模糊调度
5. **Safe Outputs Jobs Pattern** ⭐⭐⭐⭐ - 自定义安全输出作业
6. **Fail-Safe File Creation Pattern** ⭐⭐⭐ - 防止覆盖现有文件

---

## 可复用片段（6 个）

1. 双模式 Agent 骨架
2. 渐进式问题模板
3. 安全框架模板
4. Fuzzy Scheduling 推荐模板
5. Custom Safe Output Job 模板
6. Fail-Safe 文件创建模板

---

## Skill 更新记录

### workflowAnalyzer Skill

**更新内容**: 新增 6 个设计模式到 "设计模式识别" 章节

**更新位置**: `skills/workUnits/workflowCaseStudy/skills/workflowAnalyzer/SKILL.md`

**影响**: 
- 扩展了模式库（从 18 个增加到 24 个）
- 首次覆盖 Agent 文件模式（之前只有 Workflow 模式）

### workflowAuthoring Skill

**更新内容**: 新增 6 个可复用片段到代码片段库

**更新位置**: `skills/workUnits/workflowCaseStudy/skills/workflowAuthoring/SKILL.md`

**影响**:
- 丰富了片段库（从 10 个增加到 16 个）
- 首次提供 Agent 创作模板

---

## 批判性反思

### 做得好的地方 ✅

1. **选择目标科学**：基于价值评估框架，选择了高价值的分析对象
2. **研究问题明确**：提前设定了 3 个研究问题，分析有方向
3. **深度挖掘**：不只是描述表面，追问"为什么这样设计"
4. **批判性视角**：诚实指出了 5 个可改进之处和 3 个潜在风险
5. **可复用片段**：提供了 6 个即插即用的代码模板

### 可以改进的地方 ⚠️

1. **缺少对比研究**：
   - 应该同时分析 `agentic-campaign-designer.agent.md`，对比两个 Agent 的设计差异
   - 这样能更好地理解 Agent 的通用模式 vs 特定模式

2. **没有验证假设**：
   - 报告中多处提到"假设"（如模式判断逻辑），但没有验证
   - 应该查看调用该 Agent 的 Workflow，了解实际使用方式

3. **缺少量化分析**：
   - 没有统计安全警告的数量、分布
   - 没有分析 362 行中各部分的比重

### 下次改进措施 📝

1. **对比分析**：选择 2-3 个相似工作流同时分析，进行横向对比
2. **验证驱动**：对每个"假设"，尝试找到验证证据
3. **量化优先**：用数据说话（行数、关键词频率、结构比例）

---

## 未解决的问题 ❓

1. **Agent 的调用机制**：
   - `assign-to-agent` 如何传递上下文？
   - Agent 如何知道自己在 Mode 1 还是 Mode 2？
   - Agent 的返回值是什么格式？

2. **模式判断的具体实现**：
   - 是否有内置的上下文检测？
   - 还是完全依赖 Prompt 中的条件逻辑？

3. **Safe Outputs Jobs 的执行时机**：
   - Jobs 何时执行？Agent 完成后立即？还是异步？
   - Jobs 失败了会怎样？

4. **Fuzzy Scheduling 的算法**：
   - 编译器如何散列时间？
   - 是基于 workflow name 的哈希？还是随机？

**建议**: 创建 Issue 追踪这些问题，标记为 "research questions"

---

## 下次研究建议

### 方向 1: Agent 对比研究
分析 `agentic-campaign-designer.agent.md`，对比：
- Frontmatter 配置差异
- Prompt 结构差异
- 双模式实现差异

### 方向 2: Agent 调用链研究
找到调用 `create-agentic-workflow` 的 Workflow（可能是 `campaign-generator`），分析：
- 如何触发 Agent
- 如何传递参数
- 如何接收返回值

### 方向 3: Safe Outputs 生态研究
搜索所有使用 `safe-outputs.jobs` 的工作流，总结：
- 常见的 custom safe output 类型
- Jobs 配置的最佳实践
- 错误处理模式

---

## 时间统计

- **分析时长**: ~35 分钟
- **报告撰写**: ~25 分钟
- **Skill 更新**: 预计 ~20 分钟
- **总计**: ~80 分钟

---

## 心得体会 💭

1. **Agent 文件是 gh-aw 的"隐藏宝藏"**
   - 之前只关注 Workflow，忽略了 Agent
   - Agent 的设计模式更抽象、更可复用

2. **双模式设计是优雅的解决方案**
   - 解决了"自动化 vs 交互性"的两难
   - 通过清晰的边界划分，避免了逻辑混乱

3. **安全框架的设计智慧**
   - 不是事后打补丁，而是从 Prompt 层面嵌入
   - 多层防御确保即使 AI 犯错也安全

4. **用户体验细节值得学习**
   - 渐进式信息收集降低认知负荷
   - Emoji 和风格模仿建立亲和力
   - "等待用户回应"体现了对用户的尊重

---

**下次见！** 🚀
