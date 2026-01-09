# human-ai-collaboration 工作流分析报告

**分析日期**: 2026-01-09  
**运行编号**: #16  
**分析对象**: `human-ai-collaboration.md` (491 行)  
**来源**: githubnext/gh-aw  
**分析师**: workflow-case-study Agent

---

## 📋 研究概要

### 研究动机

**Skill 空白度**: **100%** - 人机协作模式完全空白  
**价值评估**: **100/100** - 最高优先级目标

我们已有的模式覆盖：
- ✅ Campaign 编排（campaign-generator, discussion-task-mining-campaign）
- ✅ 验证和教育（ci-coach）
- ✅ MCP 多服务器集成（cloclo）
- ✅ 元编排（workflow-health-manager）

**缺失**：
- ❌ 如何让人类做决策（决策门模式）
- ❌ 如何设计决策摘要（信息设计）
- ❌ 如何从执行中学习（反馈循环）

### 核心发现预览

本次分析发现 **8 个全新设计模式**（⭐⭐⭐⭐⭐⭐⭐⭐），填补了"人机协作"这一重大知识空白。

---

## 🎯 工作流概览

### 基本信息

| 属性 | 值 |
|------|-----|
| **名称** | Human-AI Collaboration Campaign |
| **触发方式** | workflow_dispatch (inputs: initiative, scope) |
| **权限** | contents: read, issues: read（只读！） |
| **引擎** | copilot |
| **超时** | 30 分钟 |
| **输出** | 1 个 Epic Issue（决策摘要） |

### 核心哲学

> **"AI analyzes and proposes, humans approve based on risk, AI executes with guardrails"**

**关键词解读**：
- **AI analyzes** - AI 的强项：快速、全面
- **humans approve** - 人类的价值：判断、风险评估
- **based on risk** - 决策依据：分层，不是一刀切
- **AI executes** - AI 执行：速度、一致性
- **with guardrails** - 安全边界：safe-outputs、测试、监控

### 工作流的"用户"

1. **主要用户**：决策者（CTO、架构师、团队负责人）
2. **次要用户**：执行者（工程师、团队成员）
3. **协作伙伴**：AI Agent（分析、执行、学习）

---

## 🔬 Frontmatter 深度解剖

### 配置分析表

| 配置项 | 值 | 设计意图推测 | 能否复用 |
|-------|-----|------------|---------|
| **name** | Human-AI Collaboration Campaign | 明确身份：这是协作模式，不是纯AI | ✅ 模式名称清晰 |
| **description** | AI analyzes and proposes... | **核心哲学**：AI+人类的分工明确 | ✅ 设计哲学可复用 |
| **timeout-minutes** | 30 | 分析阶段，不执行代码，30分钟足够 | ✅ 合理时间预算 |
| **strict** | true | **关键**：必须完成所有步骤，不能跳过 | ✅ 确保决策摘要完整 |
| **on** | workflow_dispatch (inputs) | 手动触发，适合企业计划性任务 | ✅ Campaign 类任务 |
| **permissions** | contents: read, issues: read | **只读**！分析阶段不修改任何东西 | ✅ 最小权限原则 |
| **engine** | copilot | 稳定引擎，适合企业级任务 | ✅ 生产环境推荐 |
| **safe-outputs** | create-issue: max: 1 | **只创建1个Epic**，后续执行在其他工作流 | ✅⭐ 分离关注点 |
| **tools.github** | toolsets: [repos, issues, search] | 分析需要：搜索代码、读Issue、查仓库 | ✅ 最小工具集 |
| **tools.repo-memory** | branch: memory/campaigns | 持久化分析结果，供执行工作流读取 | ✅⭐ 跨工作流状态 |

### 🔍 设计意图深挖

#### Q: 为什么 `safe-outputs: create-issue: max: 1`？

**表面**：只能创建1个Issue  
**深层意图**：
1. **分离关注点**：这个工作流只负责"分析+决策摘要"
2. **避免权限膨胀**：不需要 contents: write 权限
3. **人类决策门**：执行工作流由人类审批后触发，不在这里

#### Q: 为什么权限只有 `read`？

**设计哲学**：**Trust but Verify**
- AI 可以读取任何东西（全面分析）
- 但不能修改任何东西（安全第一）
- 修改权限只给执行工作流，且有 guardrails

#### Q: 为什么超时 30 分钟？

**任务性质分析**：
- 读取 87 个项目的代码/Issue（假设场景）
- 分析风险、依赖、影响（计算密集）
- 生成决策摘要（文本生成）
- **不包括执行**，所以不需要更长时间

**推测**：实测可能只需 10-15 分钟，30 分钟是安全 buffer

---

## 📊 Prompt 结构分析

### 层级结构图

```
Human-AI Collaboration Campaign Pattern (L0)
├─ Core Insight (L1 - 设计哲学)
├─ The Pattern (L1 - 流程概览)
│
├─ Phase 1: AI Analysis (This Workflow) (L2)
│  ├─ 1. Discovery & Analysis (L3)
│  │  ├─ AI discovers (L4)
│  │  └─ Store analysis (L4)
│  │     └─ analysis.json Schema (代码块)
│  │
│  ├─ 2. Create Decision Brief (L3)
│  │  └─ Epic Issue Body (代码块)
│  │     ├─ What AI Discovered (L5)
│  │     ├─ AI Recommendations with Rationale (L5)
│  │     │  ├─ Critical Risk (L6)
│  │     │  ├─ High Risk (L6)
│  │     │  ├─ Medium Risk (L6)
│  │     │  └─ Low Risk (L6)
│  │     ├─ Business Case (L5)
│  │     ├─ Next Steps (L5)
│  │     └─ Decision Deadline (L5)
│  │
│  └─ 3. Wait for Human Decisions (L3)
│
├─ Phase 2: Risk-Tiered Execution (Separate Workflows) (L2)
│  ├─ Low-Risk Auto-Execute Worker (L3)
│  ├─ Medium-Risk Approval Worker (L3)
│  └─ High-Risk Review Worker (L3)
│
├─ Phase 3: Learning & Feedback (L2)
│  └─ learnings.json Schema (代码块)
│
└─ Key Principles (L2)
   ├─ 1. AI Proposes, Humans Dispose (L3)
   ├─ 2. Risk-Based Approval Chains (L3)
   ├─ 3. Guardrails Always Active (L3)
   ├─ 4. Transparency & Explainability (L3)
   └─ 5. Continuous Learning (L3)
```

### 结构评价

#### ✅ 优点

1. **清晰的边界**：Phase 1 = 这个工作流，Phase 2/3 = 其他工作流
2. **渐进式信息披露**：哲学 → 流程 → 详细步骤 → 原则
3. **大量示例数据**：JSON Schema、Issue 模板、学习数据全部完整

#### ⚠️ 可改进之处

1. **过度细节**：492 行太长，Agent 可能记不住全部
2. **重复说明**：风险审批链在多处重复
3. **缺少失败处理**：如果人类3天不决策，如果 JSON 存储失败？

---

## 🎨 设计模式识别

### 已知模式（本工作流中的体现）

- ✅ **Phased Execution** - Phase 1/2/3 清晰分离
- ✅ **Memory** - repo-memory 持久化分析结果
- ✅ **Multi-Context** - 适配 initiative 和 scope 输入

---

## ⭐ 新模式发现（8个全新模式）

### 1. Risk-Tiered Decision Gate Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- 任务按风险分类（Critical/High/Medium/Low）
- 每个风险级别有不同的审批流程
- 默认行为是"最安全"的选择（低风险自动执行）

**设计意图**：
- **不是二元决策**（批准/拒绝），而是**分层决策**
- **风险越高，审批越严格**
- **默认安全**：无决策时，只执行低风险

**风险 → 审批流程映射**：
```
Critical  → Defer（专项项目）
High      → Architecture Review（架构师审批）
Medium    → Team Lead Approval（团队负责人审批）
Low       → Auto-Execute（自动执行）
```

**可复用场景**：
- 代码重构 Campaign
- 依赖升级 Campaign
- 技术债清理 Campaign
- 安全漏洞修复 Campaign

**代码片段**：
```markdown
### Breakdown by Risk Level
| Risk | Count | AI Recommendation | Your Decision Needed |
|------|-------|-------------------|---------------------|
| **Critical** | X | ⏸️ Defer to dedicated project | ✅ Approve defer / ❌ Include anyway |
| **High** | X | 🔍 Requires architecture review | ✅ Approve / ❌ Reject / ⏸️ Defer |
| **Medium** | X | ⚠️ Needs team lead approval | ✅ Approve / ❌ Reject |
| **Low** | X | ✅ Safe to auto-execute | ✅ Approve / ❌ Review first |
```

---

### 2. Decision Brief with Embedded Rationale Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- 每个推荐都有明确的"为什么"
- 包含：Risk + Effort + Business Impact + AI Assessment + Recommendation
- 提供多个选择（Approve/Reject/Defer）+ 解释空间

**设计意图**：
- **不只是"做/不做"**，而是"为什么要做/不做"
- **AI 展示思考过程**，建立信任
- **人类可以 override**，且必须解释理由（accountability）

**关键要素**：
1. **Risk** - 技术风险
2. **Effort** - 工作量估计
3. **Business Impact** - 业务影响范围
4. **AI Assessment** - AI 的判断
5. **Recommendation** - AI 的推荐动作
6. **Your Decision** - 人类的决策空间（含解释）

**示例**：
```markdown
**Item 1**: Migrate auth service from JWT to OAuth2
- **Risk**: High - impacts all users, security-critical
- **Effort**: 3 months, dedicated team needed
- **Business Impact**: Critical service, 24/7 uptime requirement
- **AI Assessment**: Too risky for campaign automation
- **Recommendation**: ⏸️ **DEFER** - Create separate project
- **Your Decision**: 
  - [ ] ✅ Agree - defer this item
  - [ ] ❌ No - include in campaign (explain why: _________)
```

**可复用场景**：
- 任何需要详细审批的 Campaign
- PR 评审（需要人工决策）
- 架构变更提案

---

### 3. Default Safe Behavior Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
```markdown
## 🚨 Decision Deadline
**If no decision**: Campaign auto-executes low-risk items only (safest default)
```

**设计意图**：
- **防止决策瘫痪**：如果人类不决策，系统仍能推进
- **默认行为是最安全的**：只执行低风险项
- **有限的自动化 > 完全停滞**

**对比传统模式**：
- ❌ 传统自动化：无人批准就不执行（可能永远等待）
- ✅ 这个模式：无人批准就执行最安全的部分

**可复用场景**：
- 定时 Campaign（如每月依赖更新）
- 无人值守的自动化任务
- 防止人类决策延迟导致的项目停滞

---

### 4. Bidirectional Learning Loop Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- Phase 3 专门用于学习
- 记录成功率、失败原因、recommendation_accuracy
- **人类反馈也被记录**
- 学习结果用于改进下次推荐

**数据结构**：
```json
{
  "ai_learnings": {
    "patterns_that_worked": [...],
    "patterns_that_failed": [...],
    "recommendation_accuracy": {
      "low_risk": "97.8% accurate",
      "medium_risk": "93.3% accurate"
    },
    "improvements_for_next_time": [...]
  },
  "human_feedback": {
    "satisfaction": "85%",
    "comments": [...]
  }
}
```

**设计意图**：
- **AI 不是静态的**：每次 Campaign 都改进
- **人类反馈 = 训练数据**：AI 学习人类偏好
- **持续优化**：跟踪准确性，调整风险模型

**可复用场景**：
- 任何长期运行的 Campaign 系统
- 需要持续改进的自动化任务
- A/B 测试不同策略

**⚠️ 当前缺失**：
- 下次运行时如何读取 learnings.json？
- 如何根据历史调整风险评估？

---

### 5. Workflow Decomposition by Risk Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- 不是"一个工作流做所有事"
- 按风险级别分解为多个工作流：
  - `campaign-execute-low-risk.md`
  - `campaign-execute-medium-risk.md`
  - `campaign-execute-high-risk.md`
  - `campaign-monitor-learn.md`

**设计意图**：
1. **权限隔离**：低风险有 write 权限，高风险只有 read
2. **超时隔离**：低风险快速执行，高风险慢慢评审
3. **职责隔离**：每个工作流职责单一

**关键好处**：
- **安全性**：高风险任务不会意外获得自动执行权限
- **可维护性**：每个工作流简单
- **可审计性**：不同风险级别的执行日志分离

**工作流分解表**：
| 工作流 | 权限 | 触发条件 | 职责 |
|--------|------|---------|------|
| human-ai-collaboration | read | manual | 分析 + 决策摘要 |
| execute-low-risk | write | label: approved:low-risk | 自动执行 |
| execute-medium-risk | read | label: approved:medium-risk | 创建审批 Issue |
| execute-high-risk | read | label: approved:high-risk | 创建评审 Issue |
| monitor-learn | read | daily | 收集结果 + 学习 |

**可复用场景**：
- 任何多阶段、多风险级别的 Campaign
- 需要不同权限的任务链

---

### 6. Progressive Disclosure in Decision Brief Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
- 先给总览（87 items, 按风险分类）
- 再给详细（每个 item 的 Risk/Effort/Impact）
- 然后给业务价值（ROI）
- 最后给流程说明（Next Steps）

**信息层级**：
```
Level 1: 总览表格（扫一眼知道全局）
Level 2: 风险分层（Critical/High/Medium/Low）
Level 3: 每个 item 的详细（Risk/Effort/Impact/Recommendation）
Level 4: 完整数据（analysis.json）
```

**设计意图**：
- **不 overwhelm 决策者**：一次只展示必要信息
- **支持深入挖掘**：想看细节的人可以查 JSON
- **适配不同读者**：CTO 看总览，架构师看详细

**可复用场景**：
- 任何需要人类决策的复杂报告
- Dashboard 设计
- 技术方案评审文档

---

### 7. Accountability Trail Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
```markdown
- **Your Decision**: 
  - [ ] ✅ Agree - defer this item
  - [ ] ❌ No - include in campaign (explain why: _________)
```

**设计意图**：
- **Checkbox = 明确记录**
- **Explain why = 必须说理由**
- **可追溯**：6个月后能看到"谁批准的，为什么"

**关键价值**：
- 防止"拍脑袋决策"
- 建立决策知识库
- 责任清晰（blame-free，但 traceable）

**可复用场景**：
- 重大架构决策
- 预算审批
- 风险评估

---

### 8. Guardrails as Contract Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

**识别特征**：
```markdown
4. **AI executes with guardrails**:
   - Creates PRs with rollback plans
   - Runs tests automatically
   - Monitors for issues
   - Alerts on failures
```

**设计意图**：
- **Guardrails 不是建议，是合约**
- AI 承诺：我只在这些约束下执行
- 人类信任：因为有 guardrails，我敢批准

**Guardrails 清单**：
1. safe-outputs（权限限制）
2. Tests must pass（质量门）
3. Rollback plans（风险缓解）
4. Monitoring（实时监控）

**可复用场景**：
- 任何有执行权限的工作流
- 生产环境变更
- 数据库迁移

---

## 💡 可复用片段库

### 片段 1: 风险分层表格模板

```markdown
### Breakdown by Risk Level
| Risk | Count | AI Recommendation | Your Decision Needed |
|------|-------|-------------------|---------------------|
| **Critical** | X | ⏸️ Defer to dedicated project | ✅ Approve defer / ❌ Include anyway |
| **High** | X | 🔍 Requires architecture review | ✅ Approve / ❌ Reject / ⏸️ Defer |
| **Medium** | X | ⚠️ Needs team lead approval | ✅ Approve / ❌ Reject |
| **Low** | X | ✅ Safe to auto-execute | ✅ Approve / ❌ Review first |
```

**使用场景**：任何需要人类决策的 Campaign

---

### 片段 2: 决策 Item 模板（带 Rationale）

```markdown
**Item N**: [任务描述]
- **Risk**: [Low/Medium/High/Critical] - [风险说明]
- **Effort**: [时间估计] - [工作量说明]
- **Business Impact**: [影响范围]
- **AI Assessment**: [AI的判断]
- **Recommendation**: [推荐动作]
- **Your Decision**:
  - [ ] ✅ Approve - [批准理由]
  - [ ] ❌ Reject - [拒绝理由]
  - [ ] ⏸️ Defer - [延迟理由]
  - Explain why: __________
```

**使用场景**：需要详细审批的任务

---

### 片段 3: 默认安全行为声明

```markdown
## 🚨 Decision Deadline

**Please make decisions within**: [时间期限]
**If no decision**: [默认安全行为]
```

**使用场景**：防止决策瘫痪的工作流

---

### 片段 4: 学习数据结构

```json
{
  "campaign_id": "...",
  "outcomes": {
    "low_risk": {
      "attempted": N,
      "successful": M,
      "failed": K,
      "success_rate": "X%"
    }
  },
  "ai_learnings": {
    "patterns_that_worked": [],
    "patterns_that_failed": [],
    "improvements_for_next_time": []
  },
  "human_feedback": {
    "satisfaction": "X%",
    "comments": []
  }
}
```

**使用场景**：需要持续改进的工作流

---

### 片段 5: Guardrails 声明

```markdown
## Guardrails Always Active

- safe-outputs prevent dangerous operations
- Tests must pass before merge
- Rollback plans required
- Monitoring for issues
```

**使用场景**：有执行权限的工作流

---

## 🔍 批判性分析

### ⚠️ 可能的问题

#### 1. 过度理想化

**现象**：假设"人类会在3天内决策"  
**现实**：人类可能忙、可能忘记、可能无法决策  
**改进建议**：
- 增加"提醒机制"（2天后提醒）
- 增加"升级机制"（3天后升级到上级）

#### 2. 缺少冲突处理

**现象**：没有说明"如果人类意见不一致"怎么办  
**场景**：Team Lead 批准，Architect 拒绝  
**改进建议**：
- 增加"冲突解决流程"
- 明确"最终决策者"

#### 3. 学习循环未闭合

**现象**：Phase 3 记录了 learnings.json，但没说"如何应用到下次"  
**缺失**：下次运行时，AI 如何读取 learnings.json？  
**改进建议**：
- Phase 1 开头增加："读取历史 learnings"
- 根据历史调整风险评估

#### 4. 缺少中途取消机制

**现象**：Campaign 启动后，如果发现问题，怎么停止？  
**风险**：低风险 items 已经自动执行了  
**改进建议**：
- 增加"Emergency Stop"按钮（特定 label）
- 增加"Pause Campaign"功能

---

### ✅ 设计亮点

#### 1. 只读权限 + 单 Issue 输出

**设计智慧**：分析阶段完全无害
- 即使 AI 判断错误，也不会破坏任何东西
- 人类有完整的 veto 权

#### 2. 示例数据极其详细

**设计智慧**：87 items 的完整示例
- Agent 不需要"猜"数据结构
- 直接 copy 示例，修改数值即可

#### 3. Business Case 前置

**设计智慧**：在"详细分析"之前给 ROI
- 决策者可能不看技术细节
- 但一定看 ROI

#### 4. 分层决策而非二元决策

**设计智慧**：不是"全批准/全拒绝"
- 可以批准低风险，拒绝高风险
- 灵活性极高

---

## 📝 Skill 更新建议

### 更新 workflowAnalyzer Skill

**位置**：`skills/workUnits/workflowCaseStudy/skills/workflowAnalyzer/SKILL.md`

**建议添加**：
1. 在"设计模式识别"章节添加 8 个新模式
2. 在"分析框架"章节添加"人机协作分析维度"
3. 在"最佳实践"章节添加"决策摘要设计原则"

---

### 更新 workflowAuthoring Skill

**位置**：`skills/workUnits/workflowCaseStudy/skills/workflowAuthoring/SKILL.md`

**建议添加**：
1. 新章节："人机协作模式"
   - Risk-Tiered Decision Gate 模式
   - Decision Brief with Rationale 模式
   - Default Safe Behavior 模式
2. 代码片段库：5 个可复用片段
3. 最佳实践：何时使用人机协作模式

---

## 🔮 后续研究方向

### 1. 执行工作流的实现

**研究对象**：
- `campaign-execute-low-risk.md`（如果存在）
- `campaign-execute-medium-risk.md`（如果存在）

**研究问题**：
- 低风险自动执行的 guardrails 如何实现？
- 中高风险的审批流程如何设计？

---

### 2. Learning Loop 的闭环机制

**研究对象**：
- `campaign-monitor-learn.md`（如果存在）

**研究问题**：
- 如何自动收集成功/失败数据？
- learnings.json 如何被下次 Campaign 读取？
- 如何根据历史数据调整风险评估？

---

### 3. 冲突解决和升级机制

**研究对象**：
- 搜索 gh-aw 仓库中的冲突处理案例

**研究问题**：
- 如果不同角色意见不一致，如何解决？
- 如何设计升级流程？

---

## 📊 分析摘要

### 触发方式

- **类型**: workflow_dispatch（手动触发）
- **输入**: initiative（项目名），scope（分析范围）
- **适用场景**: 企业计划性 Campaign

### 权限设计

- **权限**: contents: read, issues: read（只读）
- **设计原则**: 分析阶段完全无害
- **安全性**: ✅ 优秀（最小权限原则）

### Prompt 结构

- **总行数**: 491 行
- **复杂度**: 高（完整的企业级框架）
- **结构**: Phase 1（分析）→ Phase 2（执行）→ Phase 3（学习）
- **示例质量**: ✅ 极高（完整的 JSON Schema 和 Issue 模板）

### 复杂度评估

- **技术复杂度**: 中（只读 + 分析）
- **业务复杂度**: 高（风险分层、决策摘要、学习循环）
- **创新程度**: ✅ 极高（8 个全新模式）

---

## 🎯 总结

### 核心价值

本工作流展示了**企业级人机协作的黄金标准**：
- AI 提供智能（快速、全面的分析）
- 人类提供判断（基于业务的风险评估）
- 风险分层决策（不是一刀切）
- 持续学习改进（不是静态系统）

### 最大亮点

**Risk-Tiered Decision Gate Pattern**：将任务按风险分层，每层有不同的审批流程，这是解决"全自动化太危险，全人工太慢"问题的最优解。

### 最佳学习点

**Decision Brief 设计**：如何设计一个让人类能快速做出明智决策的报告：
1. 总览表格（快速了解全局）
2. 风险分层（关注重点）
3. 每个 item 的 Rationale（理解 AI 的思考）
4. ROI 分析（业务价值）
5. 详细数据（深入挖掘）

### 对我们项目的启示

我们可以应用这些模式到：
- 代码重构 Campaign（按风险分层审批）
- 依赖升级 Campaign（低风险自动执行）
- 技术债清理 Campaign（人机协作决策）
- Skill 改进 Campaign（学习循环改进）

---

**报告完成时间**: 2026-01-09  
**下一步**: 更新 Skills，创建工作日志，提交 PR
