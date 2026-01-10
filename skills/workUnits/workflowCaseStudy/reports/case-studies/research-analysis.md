# research 工作流分析报告

> **分析日期**: 2026-01-10  
> **运行编号**: #6  
> **分析者**: workflow-case-study Agent

---

## 📌 核心发现

1. **Discussion-as-Research-Output 模式**：这是首个观察到使用 GitHub Discussion 作为研究输出渠道的工作流，区别于 Issue（任务跟踪）和 PR（代码变更），Discussion 适合知识分享场景。

2. **极简 Prompt 设计**：整个 Prompt 不到 20 行，展示了「少即是多」的设计哲学——Agent 被充分信任，无需过度约束。

3. **MCP 服务器集成的复用模式**：通过 `imports: shared/mcp/tavily.md` 实现外部搜索能力的模块化复用，进一步验证了 H003 关于 `shared/` 目录作为知识沉淀体系的猜想。

4. **sandbox.agent: awf 模式**：首次观察到 `awf` 值（Agent With Firewall），这是一种新的安全配置，替代了旧的 `network.firewall`。

---

## 🎯 研究动机

**选择理由**: 
- 从工作流名称推测可能涉及信息收集和研究流程
- 之前分析的工作流多聚焦于代码/Issue 操作，研究类工作流是新视角
- 可能为我们的研究自动化提供参考

**研究问题**:
- 外部搜索服务如何集成到 gh-aw？
- 研究结果如何呈现给用户？

---

## 📊 分析摘要

| 维度 | 配置 | 评估 |
|------|------|------|
| 触发方式 | `workflow_dispatch` + 输入参数 | ⭐⭐⭐ 用户主动触发，适合交互式研究 |
| 权限设计 | `contents: read`, `issues: read`, `pull-requests: read` | ⭐⭐⭐ 最小权限原则，只读权限 |
| 工具组合 | Tavily MCP (外部搜索) | ⭐⭐⭐ 单一职责，专注搜索 |
| 超时设置 | 10 分钟 | ⭐⭐⭐ 匹配简单研究任务 |
| 输出配置 | `create-discussion: { category: "research", max: 1 }` | ⭐⭐⭐ Discussion 作为研究输出 |

---

## 🎨 识别的设计模式

### 已知模式

| 模式名称 | 应用方式 | 特别之处 |
|---------|---------|---------|
| Workflow Dispatch | 用户手动触发 + `topic` 参数输入 | 研究主题作为必填参数 |
| Safe-Output | `max: 1` 限制输出数量 | 使用 Discussion 而非 Issue |
| Import Reuse | `imports: shared/mcp/tavily.md` | MCP 配置模块化 |
| Shared Reporting | `imports: shared/reporting.md` | 报告格式规范复用 |

### 🆕 新发现模式

#### Discussion-as-Research-Output Pattern

- **识别特征**: 
  - `safe-outputs.create-discussion` 而非 `create-issue`
  - `category: "research"` 专门的 Discussion 分类
  - 研究性质的输出，非任务跟踪
- **设计意图**: 
  - Discussion 适合知识分享和讨论，Issue 适合任务跟踪
  - 研究结果可被评论和扩展，形成知识积累
  - 分类系统帮助组织不同类型的研究
- **可复用价值**: 
  - 任何需要输出研究报告、分析结果的工作流
  - 适合 weekly-digest、landscape-analysis 等场景

#### Minimalist Prompt Design Pattern

- **识别特征**:
  - Prompt 正文 < 20 行
  - 无显式 Phase 划分
  - 无 ⚠️/❌ 约束声明
  - 依赖 Agent 的通用能力
- **设计意图**:
  - 简单任务无需复杂指令
  - 信任 Agent 的默认行为
  - 降低维护成本
- **适用场景**:
  - 单一职责的工作流
  - Agent 能力边界清晰的任务
- **⚠️ 风险**:
  - 复杂场景可能导致行为不一致
  - 缺乏约束可能产生意外输出

#### AWF Sandbox Mode Pattern

- **识别特征**: `sandbox: { agent: awf }`
- **设计意图**: 
  - `awf` = Agent With Firewall
  - 允许网络访问但通过防火墙过滤
  - 替代旧的 `network.firewall` 配置
- **对比**:
  - `agent: true` = 完全隔离
  - `agent: awf` = 防火墙保护
  - `agent: false` = 无沙箱（高风险）

---

## 💻 可复用片段

### MCP 服务器配置（Tavily 搜索）

```yaml
# 来源: shared/mcp/tavily.md
# 用途: 集成 Tavily 搜索 API 进行网络研究
mcp-servers:
  tavily:
    type: http
    url: "https://mcp.tavily.com/mcp/"
    headers:
      Authorization: "Bearer ${{ secrets.TAVILY_API_KEY }}"
    allowed: ["*"]
```

### Discussion 输出配置

```yaml
# 用途: 将研究结果输出到 GitHub Discussion
safe-outputs:
  create-discussion:
    category: "research"  # Discussion 分类
    max: 1
```

---

## 🤔 批判性分析

### 设计亮点

1. **极简美学**：证明简单任务可以用简单配置完成，过度设计是反模式
2. **输出渠道选择**：Discussion 用于研究是正确的选择，区别于任务跟踪（Issue）和代码变更（PR）
3. **模块化复用**：`shared/` 目录的 MCP 配置和报告模板复用降低了重复

### 改进建议

1. **缺少错误处理**：如果 Tavily API 不可用怎么办？可以添加 fallback 机制
2. **缺少质量控制**：研究结果的质量如何保证？可以添加验证步骤
3. **缺少历史管理**：多次研究同一主题如何关联？可以考虑 `close-older-discussions` 或引用机制

---

## 📝 Skill 更新建议

- [x] workflowAnalyzer/patterns/BASIC.md: 添加 "Discussion-as-Research-Output Pattern"
- [x] workflowAnalyzer/patterns/BASIC.md: 添加 "Minimalist Prompt Design Pattern"
- [x] workflowAnalyzer/patterns/SECURITY.md: 添加 "AWF Sandbox Mode Pattern"
- [ ] hypothesis/HYPOTHESES.md: 为 H003 添加新证据（shared/mcp/ 复用）

---

## 🔗 猜想库更新

### H003 新证据

`research.md` 通过 `imports: shared/mcp/tavily.md` 实现 MCP 配置的模块化复用，进一步证明 `shared/` 目录不仅用于 patterns/，也是工具配置的知识沉淀体系。

**证据强度**: 中（继 mcp-inspector 之后的第二个确认案例）

---

## 🔮 后续研究方向

1. **Discussion 生态调研**：有多少工作流使用 Discussion 作为输出？是否有 Discussion-specific 的模式？
2. **MCP 服务器全景**：`shared/mcp/` 目录下有哪些服务器配置？各自的使用场景？
3. **sandbox.agent 模式对比**：`true` vs `awf` vs `false` 的详细对比和适用场景
4. **极简 vs 详细 Prompt**：什么情况下应该选择极简设计？临界点在哪里？
