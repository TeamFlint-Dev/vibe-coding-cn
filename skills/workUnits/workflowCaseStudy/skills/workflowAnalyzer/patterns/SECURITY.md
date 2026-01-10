# 安全设计模式

> **用途**: 权限控制、约束声明、安全边界模式  
> **来源**: workflowAnalyzer Skill

---

## Embedded Security Framework Pattern ⭐⭐⭐⭐

- **识别特征**: 多层安全约束 + 显式警告标记（⚠️、IMPORTANT、NEVER）+ 正反向指导
- **四层防御**: 
  1. 原则层（最小权限）
  2. 工具层（禁用危险工具）
  3. 输出层（强制 safe-outputs）
  4. 网络层（白名单）
- **约束表达**: "**Never recommend** X" + "**Always use** Y"
- **用途**: 确保 AI 生成的配置符合安全最佳实践
- **典型案例**: create-agentic-workflow
- **来源**: create-agentic-workflow 分析

---

## Risk-Tiered Decision Gate Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 任务按风险分类（Critical/High/Medium/Low）+ 每个风险级别有不同的审批流程
- **风险映射**: 
  - Critical → Defer（专项项目）
  - High → Architecture Review
  - Medium → Team Lead Approval
  - Low → Auto-Execute
- **设计意图**: 不是二元决策（批准/拒绝），而是分层决策
- **默认安全**: 无决策时，只执行低风险
- **典型案例**: human-ai-collaboration
- **来源**: human-ai-collaboration 分析

---

## Default Safe Behavior Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: `If no decision: Campaign auto-executes low-risk items only (safest default)`
- **设计意图**: 防止决策瘫痪 + 默认行为是最安全的 + 有限的自动化 > 完全停滞
- **对比传统**: 传统自动化无人批准就不执行，这个模式无人批准就执行最安全部分
- **典型案例**: human-ai-collaboration（3天无决策后自动执行低风险）
- **来源**: human-ai-collaboration 分析

---

## Workflow Decomposition by Risk Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 不是"一个工作流做所有事"，按风险级别分解为多个工作流
- **分解示例**: execute-low-risk, execute-medium-risk, execute-high-risk, monitor-learn
- **设计意图**: 
  - 权限隔离（低风险有 write，高风险只有 read）
  - 超时隔离（低风险快速，高风险慢）
  - 职责隔离（每个工作流单一职责）
- **典型案例**: human-ai-collaboration
- **来源**: human-ai-collaboration 分析

---

## Guardrails as Contract Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: `AI executes with guardrails: Creates PRs with rollback plans + Runs tests automatically`
- **设计意图**: Guardrails 不是建议而是合约
- **Guardrails 清单**: 
  - safe-outputs（权限限制）
  - Tests must pass（质量门）
  - Rollback plans（风险缓解）
  - Monitoring（实时监控）
- **典型案例**: human-ai-collaboration
- **来源**: human-ai-collaboration 分析

---

## Accountability Trail Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: `Your Decision: [ ] Approve / [ ] Reject / [ ] Defer - Explain why: __________`
- **设计意图**: 
  - Checkbox = 明确记录
  - Explain why = 必须说理由
  - 可追溯（6个月后能看到"谁批准的，为什么"）
- **关键价值**: 防止"拍脑袋决策" + 建立决策知识库 + 责任清晰
- **典型案例**: human-ai-collaboration
- **来源**: human-ai-collaboration 分析

---

## MCP-Specialized Tool Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 导入专门 MCP + Prompt 明确指导使用特定工具 + 工具职责边界清晰
- **约束示例**: "**IMPORTANT**: Use `gh-aw_audit` tool [...] Do NOT use GitHub MCP server for workflow run analysis"
- **工具选择决策**: 需要工作流诊断 → gh-aw MCP | 需要仓库操作 → GitHub MCP
- **典型案例**: smoke-detector
- **来源**: smoke-detector 分析

---

## Tool Selection Decision Tree Pattern ⭐⭐⭐⭐

- **识别特征**: Prompt 中明确的 "If X Is Needed" 分支 + 每个分支有专门工具链
- **结构**: 用户请求 → 分类（代码/网页/分析）→ 每类有清晰的工具链
- **示例**: If Code Changes → Serena MCP + edit + create-PR | If Web Automation → Playwright + comment
- **关键约束**: ⚠️ NEVER 约束防止危险操作
- **典型案例**: cloclo（7个工具，3个分支）
- **来源**: cloclo 分析

---

## Exclude Rules Pattern ⭐⭐⭐

- **识别特征**: 明确排除特定目录/文件，在多处重复强调
- **Prompt 表达**: "**DO NOT**...", "**EXCLUDE**...", "**SKIP**..." 等不同表达
- **用途**: 防止批处理工作流误报不需要检查的文件
- **重复策略**: 在概述、职责、执行等不同位置重复，使用不同动词
- **典型案例**: workflow-health-manager（排除 shared/ 目录）
- **来源**: workflow-health-manager 分析

---

## Fail-Safe File Creation Pattern ⭐⭐⭐⭐

- **识别特征**: 创建文件前检查存在性 + 存在时自动修改文件名（`-v2`、时间戳）
- **实现**: 先 view 检查 → 存在则追加后缀 → 创建修改后的文件名
- **用途**: 防止意外覆盖用户已有的工作流
- **典型案例**: create-agentic-workflow
- **来源**: create-agentic-workflow 分析

---

## AWF Sandbox Mode Pattern 🔴⭐ (Run #6)

- **识别特征**: `sandbox: { agent: awf }`
- **设计意图**: 
  - `awf` = Agent With Firewall
  - 允许网络访问但通过防火墙过滤（基于 `network.allowed` 白名单）
  - 替代旧的 `network.firewall` 配置
- **对比其他模式**:
  - `agent: true` = 完全隔离（最安全，无网络）
  - `agent: awf` = 防火墙保护（平衡安全与能力）
  - `agent: false` = 无沙箱（高风险，不推荐）
- **配套配置**: 通常与 `network.allowed` 配合使用
  ```yaml
  network:
    allowed:
      - defaults
      - node
  sandbox:
    agent: awf
  ```
- **适用场景**: 需要外部 API 访问（如 MCP 服务器）但仍需安全边界的工作流
- **典型案例**: research（使用 Tavily 搜索 MCP）
- **来源**: research 分析 (Run #6)
