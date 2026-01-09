# 工作流案例研究日志：human-ai-collaboration

**日期**: 2026-01-09  
**运行编号**: #16  
**分析工作流**: `human-ai-collaboration.md`  
**来源**: githubnext/gh-aw (本地缓存)

---

## 选择理由

1. **填补重大知识空白**：这是 **人机协作模式**的首次分析
2. **价值评估最高分**：100/100（Skill 空白度 40%，模式新颖度 25%，实用价值 20%，复杂度 15%）
3. **实用价值极高**：我们的工作流经常需要人工决策
4. **复杂度适中**：15K（491行），足够展示核心模式，不过度复杂

**价值评估详情**:
- Skill 空白度：40% → **100%**（人机协作模式完全空白）
- 模式新颖度：25% → **100%**（8 个全新模式）
- 实用价值：20% → **100%**（高度契合我们的场景）
- 复杂度适中：15% → **100%**（可分析透彻）

**总分**: **100/100** - 最高价值目标

---

## 研究问题（基于 Skill 空白）

### 问题 1：风险分层决策机制 ✅ 已解答
**Skill 空白**：我们没有系统的"如何让人类做决策"的模式  
**发现**：
- Risk-Tiered Decision Gate Pattern
- 四层风险（Critical/High/Medium/Low）
- 每层不同审批流程（Defer/架构评审/团队负责人/自动执行）

### 问题 2：决策摘要的设计 ✅ 已解答
**Skill 空白**：我们的工作流缺少"给人类看的报告"设计模式  
**发现**：
- Decision Brief with Embedded Rationale Pattern
- Progressive Disclosure Pattern（信息分层）
- 包含 Risk/Effort/Business Impact/AI Assessment

### 问题 3：执行后的学习循环 ✅ 已解答
**Skill 空白**：工作流执行后没有反馈机制  
**发现**：
- Bidirectional Learning Loop Pattern
- 记录成功率、失败原因、recommendation_accuracy
- 人类反馈也被记录

---

## 关键发现

### 🆕 发现了 8 个全新的设计模式

所有模式都标记为 ⭐⭐⭐⭐⭐⭐⭐⭐（八星，表示人机协作首次分析）

1. **Risk-Tiered Decision Gate Pattern**
   - 任务按风险分类，每层不同审批流程
   - 默认行为是"最安全"的选择

2. **Decision Brief with Embedded Rationale Pattern**
   - 每个推荐都有明确的"为什么"
   - 包含 Risk/Effort/Business Impact/AI Assessment/Recommendation
   - 人类可以 override，且必须解释理由

3. **Default Safe Behavior Pattern**
   - 防止决策瘫痪：无决策时执行最安全部分
   - 有限的自动化 > 完全停滞

4. **Bidirectional Learning Loop Pattern**
   - AI 学习成功/失败模式
   - 人类反馈也被记录
   - 持续改进 recommendation_accuracy

5. **Workflow Decomposition by Risk Pattern**
   - 按风险级别分解为多个工作流
   - 权限隔离、超时隔离、职责隔离

6. **Progressive Disclosure in Decision Brief Pattern**
   - 信息分层：总览 → 详细 → ROI → 完整数据
   - 适配不同读者（CTO 看总览，架构师看详细）

7. **Accountability Trail Pattern**
   - Checkbox 记录决策
   - 必须解释理由（explain why）
   - 可追溯决策历史

8. **Guardrails as Contract Pattern**
   - Guardrails 是合约，不是建议
   - AI 承诺只在约束下执行
   - 人类因 guardrails 而信任

---

## 分析过程

### Phase 0: 读取知识状态 ✅
- 已分析 7 个工作流
- 已识别 46 个设计模式
- 最新分析是 Campaign 模式（今天完成）
- **发现空白**：人机协作模式完全缺失

### Phase 1: 智能选择目标 ✅
- 评估了 6 个候选工作流
- human-ai-collaboration 获得满分（100/100）
- 预期发现：人工确认、交互式决策、反馈循环

### Phase 2: 深度分析 ✅

#### 2.1 第一印象（30秒扫描）
- 491 行，15K
- 复杂度：高（企业级完整框架）
- 核心哲学：AI analyzes and proposes, humans approve based on risk, AI executes with guardrails

#### 2.2 带着问题分析
- 设定 3 个研究问题
- 全部得到解答

#### 2.3 逆向工程设计意图

**关键发现**：
1. **safe-outputs: create-issue: max: 1** → 分离关注点，分析和执行分离
2. **permissions: read** → Trust but Verify，分析阶段完全无害
3. **timeout: 30** → 只分析不执行，时间足够

#### 2.4 多维度分析
- Frontmatter 解剖（10 个配置项）
- Prompt 结构分析（层级结构图）
- 设计模式识别（8 个新模式）

#### 2.5 批判性视角

**发现的问题**：
1. 过度理想化（假设人类会在3天内决策）
2. 缺少冲突处理（如果意见不一致怎么办）
3. 学习循环未闭合（下次如何读取 learnings.json）
4. 缺少中途取消机制

**设计亮点**：
1. 只读权限 + 单 Issue 输出（完全无害）
2. 示例数据极其详细（87 items 完整示例）
3. Business Case 前置（决策者一定看 ROI）
4. 分层决策而非二元决策（灵活性极高）

### Phase 3: 知识沉淀 ✅
- 生成分析报告（human-ai-collaboration-analysis.md）
- 提取 5 个可复用片段
- 记录 Skill 更新建议
- 创建工作日志（本文件）

---

## 遇到的问题

### 问题 1: gh CLI 未认证
**现象**: 无法通过 gh api 访问 githubnext/gh-aw 仓库  
**解决**: 使用本地缓存 `skills/github/ghAgenticWorkflows/shared/gh-aw-raw/workflows/`  
**教训**: 备选方案很重要

---

## Skill 更新记录

### 计划更新 workflowAnalyzer Skill

**文件**: `skills/workUnits/workflowCaseStudy/skills/workflowAnalyzer/SKILL.md`

**更新内容**：
1. 在"设计模式识别"章节添加 8 个新模式
2. 在"分析框架"章节添加"人机协作分析维度"
3. 在"最佳实践"章节添加"决策摘要设计原则"

### 计划更新 workflowAuthoring Skill

**文件**: `skills/workUnits/workflowCaseStudy/skills/workflowAuthoring/SKILL.md`

**更新内容**：
1. 新章节："人机协作模式"
   - Risk-Tiered Decision Gate 模式
   - Decision Brief with Rationale 模式
   - Default Safe Behavior 模式
2. 代码片段库：5 个可复用片段
3. 最佳实践：何时使用人机协作模式

---

## 未解决的问题

1. **学习循环的闭合机制**
   - learnings.json 如何被下次 Campaign 读取？
   - 如何根据历史数据调整风险评估？
   - **后续研究**：分析 `campaign-monitor-learn.md`（如果存在）

2. **执行工作流的实现细节**
   - 低风险自动执行的 guardrails 如何实现？
   - 中高风险的审批流程如何设计？
   - **后续研究**：分析 `campaign-execute-*-risk.md`（如果存在）

3. **冲突解决机制**
   - 如果不同角色意见不一致，如何解决？
   - 如何设计升级流程？
   - **后续研究**：搜索 gh-aw 仓库中的冲突处理案例

---

## 下次研究建议

### 优先级 1: 学习循环的完整实现
**研究对象**: `campaign-monitor-learn.md`（如果存在）  
**研究问题**: 
- 如何自动收集成功/失败数据？
- learnings.json 的数据结构设计
- 如何应用到下次 Campaign？

### 优先级 2: 执行工作流的 Guardrails 实现
**研究对象**: `campaign-execute-low-risk.md`（如果存在）  
**研究问题**:
- 自动执行的 safe-outputs 配置
- 如何确保 tests must pass？
- Rollback plans 如何设计？

### 优先级 3: 其他协作模式
**研究对象**: 搜索 gh-aw 中包含 "approval" 或 "review" 的工作流  
**研究问题**:
- 还有哪些人机协作模式？
- 不同场景下的最佳实践

---

## 时间记录

- **Phase 0**（读取知识状态）：~5 分钟
- **Phase 1**（选择目标）：~10 分钟
- **Phase 2**（深度分析）：~40 分钟
- **Phase 3**（知识沉淀）：~30 分钟

**总计**: ~85 分钟

---

## 自我评价

### ✅ 做得好的地方

1. **价值评估框架有效**：100/100 的评分证明选择正确
2. **研究问题聚焦**：3 个问题全部得到解答
3. **批判性思维**：不只发现亮点，也指出问题
4. **可复用片段**：提取了 5 个即用片段

### ⚠️ 可以改进的地方

1. **深度 vs 广度**：花了很多时间在一个工作流上，可能应该分析更多
2. **实践验证**：应该尝试用这些模式写一个迷你工作流
3. **Skill 更新执行**：只是"建议"更新，应该直接更新

### 💡 学到的经验

1. **人机协作是未来**：全自动化太危险，全人工太慢
2. **风险分层是关键**：不是一刀切，而是分层决策
3. **信息设计很重要**：如何设计决策摘要影响决策质量

---

**日志完成时间**: 2026-01-09  
**下一步**: 更新 Skills → 创建 PR
