# smoke-detector 工作流深度分析

**分析日期**: 2026-01-08  
**运行编号**: #11  
**分析对象**: `smoke-detector.md` (314 行)  
**来源**: githubnext/gh-aw

---

## 📊 研究问题与发现

基于当前 Skills 空白分析，本次研究重点关注以下问题：

### 问题 1: workflow_call 触发器的设计模式是什么？

**发现**: `workflow_call` 是一种**可重用工作流模式**，完全不同于已分析的触发器类型。

**核心特征**:
- **被调用而非主动触发**: 由其他工作流通过 `uses:` 调用
- **参数化设计**: 通过 `inputs` 接收调用方传递的参数
- **单一职责**: 专注于一个特定任务（失败分析）

**对比已知模式**:
| 触发器类型 | 工作方式 | 使用场景 |
|-----------|---------|----------|
| `issues/pull_request` | 响应事件 | 自动化处理 |
| `workflow_dispatch` | 手动触发 | 一次性任务 |
| `schedule` | 定时执行 | 周期性任务 |
| **`workflow_call`** | 被其他工作流调用 | 可重用组件 |

**设计智慧**:
```yaml
on:
  workflow_call:
    inputs:
      workflow_name:    # 调用方必须提供
        required: true
        type: string
      run_id:          # 运行时上下文
        required: true
        type: string
```

这种设计实现了**工作流的组合性** - 将诊断逻辑封装为可复用的"函数"。

---

### 问题 2: gh-aw MCP 的工具能力边界在哪里？

**发现**: `gh-aw` MCP 提供了**工作流元编程**能力，是工作流的"X光机"。

**核心工具**（从 Prompt 提取）:
| 工具 | 功能 | 典型用途 |
|------|------|----------|
| `gh-aw_audit` | 诊断工作流运行 | 失败分析、根因定位 |
| `gh-aw_logs` | 下载和分析日志 | 深度错误追踪 |
| `gh-aw_status` | 查询工作流状态 | 健康监控 |
| `gh-aw_compile` | 编译检查 | 语法验证 |

**关键约束**（Prompt 第 65 行）:
```markdown
**IMPORTANT**: Use the `gh-aw_audit` tool [...] 
Do NOT use the GitHub MCP server for workflow run analysis
```

**设计意图**: 
- gh-aw MCP 专注于工作流诊断
- GitHub MCP 专注于仓库操作
- 明确工具边界，防止误用

**价值**: 这是**首次在 Skills 中系统记录 gh-aw MCP 的完整工具集**。

---

### 问题 3: cache-memory 的知识积累模式是什么？

**发现**: smoke-detector 实现了**文件系统知识库**模式，不只是简单缓存。

**三层知识架构**（从 Phase 5 和 Phase 3 提取）:
```
/tmp/gh-aw/cache-memory/
├── investigations/        # 调查报告存档
│   └── <timestamp>-<run-id>.json
├── patterns/             # 错误模式库
│   └── [pattern files]
└── logs/                # 详细日志缓存
    └── [log artifacts]
```

**知识流动**:
1. **Phase 2**: 分析日志 → 提取错误模式
2. **Phase 3**: 搜索历史 → `/tmp/gh-aw/cache-memory/` 中查找相似失败
3. **Phase 5**: 存储结构化数据 → 为未来调查建立索引
4. **Phase 6**: 去重判断 → 避免创建重复 Issue

**核心价值**:
- **跨运行学习**: 每次失败都丰富知识库
- **模式识别**: 自动识别重复失败
- **快速检索**: 文件系统索引支持快速搜索

**对比 cloclo 的 cache-memory**:
| 工作流 | cache-memory 用途 |
|--------|------------------|
| cloclo | 存储对话上下文（短期） |
| smoke-detector | 构建知识库（长期） |

---

### 问题 4: 如何处理"Issue vs PR Comment"的输出路由？

**发现**: **动态输出路由模式** - 基于运行时上下文智能选择输出位置。

**路由逻辑**（Phase 7）:
```
失败工作流运行
    │
    ▼
查询 PR（使用 head_sha）
    │
    ├─ 找到 PR → add_comment（评论到 PR）
    │
    └─ 未找到 PR → create_issue（创建 Issue）
```

**实现细节**:
```markdown
**First, check for associated pull request**: 
Use the GitHub API to search for pull requests associated with 
the branch from the failed workflow run (commit SHA: ${{ inputs.head_sha }})

Query: `repo:${{ github.repository }} is:pr ${{ inputs.head_sha }}`
```

**设计优雅之处**:
- **上下文感知**: 根据失败来源选择通知方式
- **减少噪音**: PR 相关失败评论到 PR，不创建独立 Issue
- **用户体验**: 开发者在相关上下文中看到错误

**safe-outputs 配置**:
```yaml
safe-outputs:
  add-comment:
    target: "*"              # 可以评论任何地方
    hide-older-comments: true  # 折叠旧评论，保持清洁
  create-issue:
    expires: 2h              # 短期 Issue，自动过期
```

---

### 问题 5: 7 个 Phase 的时间分配和边界是什么？

**发现**: **漏斗式调查流程** - 从快速分类到深度分析再到行动。

**Phase 时间预算分析**（总 20 分钟）:
| Phase | 任务 | 预估时间 | 占比 | 关键产出 |
|-------|------|---------|------|---------|
| Phase 1 | 初步分类 | 2 分钟 | 10% | gh-aw_audit 报告 |
| Phase 2 | 深度日志分析 | 5 分钟 | 25% | 错误模式、堆栈追踪 |
| Phase 3 | 历史上下文 | 3 分钟 | 15% | 相似失败记录 |
| Phase 4 | 根因调查 | 5 分钟 | 25% | 失败分类、深度分析 |
| Phase 5 | 知识存储 | 2 分钟 | 10% | 结构化数据持久化 |
| Phase 6 | 去重判断 | 1 分钟 | 5% | 是否已有相同 Issue |
| Phase 7 | 报告生成 | 2 分钟 | 10% | 格式化的调查报告 |

**漏斗设计**:
```
Phase 1-2: 收集数据（35%）
    ↓
Phase 3-4: 分析理解（40%）
    ↓
Phase 5-6: 知识管理（15%）
    ↓
Phase 7: 行动输出（10%）
```

**设计智慧**:
1. **快速失败**: Phase 1 用 gh-aw_audit 快速判断是否需要深入
2. **渐进式深入**: 只有必要时才深入分析日志
3. **知识优先**: Phase 5 在输出前保存知识
4. **去重保护**: Phase 6 防止 Issue 洪水

---

## 🎨 识别的设计模式

### 1. Reusable Workflow Pattern ⭐⭐⭐⭐⭐

**识别特征**: `on: workflow_call` + 参数化 `inputs` + 单一职责设计

**适用场景**: 
- 需要在多个工作流中复用的逻辑
- 将复杂工作流分解为可组合的单元
- 集中管理通用功能（如失败诊断、部署、通知）

**配置示例**:
```yaml
on:
  workflow_call:
    inputs:
      workflow_name:
        description: 'Name of the workflow that failed'
        required: true
        type: string
```

**调用方式**（推测）:
```yaml
jobs:
  investigate:
    uses: ./.github/workflows/smoke-detector.md
    with:
      workflow_name: ${{ github.workflow }}
      run_id: ${{ github.run_id }}
```

**价值**: 
- **DRY 原则**: 诊断逻辑只写一次
- **一致性**: 所有工作流使用相同的诊断流程
- **可维护性**: 修改一处，所有调用者受益

**与 Agent 委托的区别**:
| 模式 | 执行方式 | 状态隔离 | 用途 |
|------|---------|---------|------|
| Reusable Workflow | 同一 Runner 不同 Job | 共享工作区 | 工作流组合 |
| assign-to-agent | 新的工作流运行 | 完全隔离 | 复杂任务委托 |

---

### 2. MCP-Specialized Tool Pattern ⭐⭐⭐⭐⭐

**识别特征**: 
- 导入专门的 MCP 服务器（`gh-aw.md`）
- Prompt 中明确指导使用特定 MCP 工具
- 工具职责边界清晰（gh-aw vs GitHub MCP）

**核心约束**（第 65-66 行）:
```markdown
**IMPORTANT**: Use the `gh-aw_audit` tool [...] 
Do NOT use the GitHub MCP server for workflow run analysis
```

**工具选择决策树**:
```
需要工作流诊断？
├─ Yes → gh-aw MCP（audit, logs, status, compile）
└─ No → GitHub MCP（repos, issues, PRs）
```

**设计意图**:
- **专业化**: 每个 MCP 专注特定领域
- **防止误用**: 明确约束防止 Agent 选错工具
- **性能优化**: 专业工具提供更好的诊断能力

**对比 cloclo 的多 MCP 模式**:
| 工作流 | MCP 策略 | 设计目标 |
|--------|---------|---------|
| cloclo | 3 个 MCP 平等协作 | 多领域能力整合 |
| smoke-detector | 1 个主 MCP + 明确优先级 | 专业化诊断 |

---

### 3. File-Based Knowledge Accumulation Pattern ⭐⭐⭐⭐⭐

**识别特征**:
- cache-memory 用于持久化知识
- 结构化文件组织（investigations/, patterns/, logs/）
- 跨运行学习（Phase 3 查询历史，Phase 5 存储新知识）

**知识生命周期**:
```
1. 失败发生 → gh-aw_logs 提取数据
2. Phase 4 分析 → 提取错误模式
3. Phase 5 存储 → 写入结构化 JSON
4. 未来调查 → Phase 3 查询历史
5. 模式识别 → 自动去重（Phase 6）
```

**存储格式**（推测）:
```json
// investigations/<timestamp>-<run-id>.json
{
  "timestamp": "2026-01-08T12:00:00Z",
  "run_id": "12345",
  "workflow_name": "smoke-copilot",
  "root_cause": "AI engine timeout",
  "error_signature": "claude_timeout_30s",
  "resolution": "Increased timeout to 60s"
}
```

**检索策略**（第 111-118 行）:
```markdown
1. **Search Investigation History**: 
   - Read from cached investigation files in `/tmp/gh-aw/cache-memory/`
   - Parse previous failure patterns and solutions
   - Look for recurring error signatures
```

**价值**:
- **机器学习基础**: 积累数据支持未来模式识别
- **快速诊断**: 相似失败直接参考历史解决方案
- **知识复利**: 每次调查让系统更智能

**新颖性**: 之前分析的工作流中，cache-memory 主要用于对话上下文，这是**首次发现用于构建长期知识库**的模式。

---

### 4. Dynamic Output Routing Pattern ⭐⭐⭐⭐

**识别特征**:
- 运行时查询上下文（搜索关联 PR）
- 基于查询结果动态选择输出方式
- 双输出配置（add-comment + create-issue）

**路由决策逻辑**（Phase 7，第 184-187 行）:
```markdown
**First, check for associated pull request**: 
Use the GitHub API to search for pull requests...

**If a pull request is found**: Post the investigation report as a comment
**If no pull request is found**: Create a new issue
```

**实现细节**:
```markdown
Query: `repo:${{ github.repository }} is:pr ${{ inputs.head_sha }}`
```

**safe-outputs 配置支持**:
```yaml
add-comment:
  target: "*"              # 可评论到任意 PR/Issue
create-issue:
  expires: 2h              # Issue 自动过期
```

**设计优雅之处**:
- **上下文感知**: 失败信息出现在最相关的地方
- **减少噪音**: PR 失败不会创建独立 Issue
- **用户体验**: 开发者在工作的地方看到反馈

**通用性**: 这个模式可应用于任何需要"智能选择输出位置"的工作流。

---

### 5. Phased Investigation Framework Pattern ⭐⭐⭐⭐

**识别特征**:
- 7 个明确的 Phase，每个有专门职责
- 漏斗式流程（收集 → 分析 → 行动）
- 每个 Phase 有明确的输入和输出

**Phase 流水线**:
```
Phase 1: 初步分类（gh-aw_audit）
    ↓ [audit report]
Phase 2: 日志分析（gh-aw_logs）
    ↓ [error patterns, stack traces]
Phase 3: 历史搜索（cache-memory）
    ↓ [similar failures]
Phase 4: 根因分析（分类 + 深度分析）
    ↓ [root cause, category]
Phase 5: 知识存储（写入 cache）
    ↓ [persisted knowledge]
Phase 6: 去重判断（搜索现有 Issue）
    ↓ [duplicate decision]
Phase 7: 报告输出（动态路由）
    ↓ [PR comment OR Issue]
```

**Phase 边界清晰性**:
- **输入明确**: 每个 Phase 知道需要什么数据
- **输出明确**: 每个 Phase 产出什么结果
- **可跳过**: 如 Phase 6 发现重复，跳过 Phase 7 创建

**时间分配哲学**:
- **快速分类**: Phase 1-2 占 35%，快速决定是否深入
- **深度分析**: Phase 3-4 占 40%，核心价值所在
- **输出轻量**: Phase 7 仅 10%，因为大部分工作已完成

**价值**: 这是一个**可复用的调查框架**，不仅适用于工作流失败，也适用于任何需要系统化调查的场景。

---

### 6. Expiring Issue Pattern ⭐⭐⭐

**识别特征**: `create-issue` 配置 `expires: 2h`

**设计意图**:
```yaml
create-issue:
  expires: 2h              # 2小时后自动关闭
  title-prefix: "[smoke-detector] "
  labels: [smoke-test, investigation]
```

**适用场景**:
- **临时通知**: 失败已调查，Issue 仅作为通知
- **防止堆积**: 不需要长期跟踪的 Issue
- **快速反馈**: 强制开发者快速响应

**对比 workflow-health-manager**:
| 工作流 | expires 配置 | 用途 |
|--------|-------------|------|
| workflow-health-manager | 1d | 每日健康报告 |
| smoke-detector | 2h | 失败调查通知 |

**风险考虑**:
- ⚠️ 如果 2 小时内未处理，Issue 自动关闭，可能丢失重要信息
- ✅ 但结合 Phase 5 知识存储，信息已持久化到 cache-memory

**价值**: 实现了**"通知即焚"**模式，保持 Issue 列表清洁。

---

### 7. Themed Messages Pattern（复用） ⭐⭐⭐

**识别特征**: 定制化的 messages，带有"火警"主题

```yaml
messages:
  run-started: "🔥 BEEP BEEP! [...] detected smoke on this {event_type}! Investigating..."
  run-success: "🚨 All clear! [...] Fire report filed! 📋"
  run-failure: "🔥 Alarm malfunction! [...] Manual inspection required..."
```

**主题一致性**:
- 名称: Smoke Detector（烟雾探测器）
- Emoji: 🔥 🚨 📋
- 语言风格: "BEEP BEEP", "detected smoke", "alarm malfunction"

**功能性分析**:
| 维度 | 人格化的影响 |
|------|-------------|
| 可识别性 | ✅ "BEEP BEEP" 立即识别是 smoke-detector |
| 紧迫感 | ✅ 火警隐喻传达失败的严重性 |
| 专业性 | ✅ 隐喻恰当，不影响严肃性 |

**对比 cloclo**:
- cloclo: 娱乐性主题（Claude François）
- smoke-detector: 功能性主题（火警系统）

---

## 📦 可复用代码片段

### 1. Reusable Workflow 基础模板

```yaml
---
on:
  workflow_call:
    inputs:
      param1:
        description: '参数说明'
        required: true
        type: string
      param2:
        description: '可选参数'
        required: false
        type: string
        default: 'default-value'
permissions:
  contents: read
  # 最小权限...
---

# 可重用工作流名称

你的任务描述...

## 输入参数

- **param1**: ${{ inputs.param1 }}
- **param2**: ${{ inputs.param2 }}
```

**调用示例**:
```yaml
# 在另一个工作流中
jobs:
  call-reusable:
    uses: ./.github/workflows/my-reusable.md
    with:
      param1: "value"
```

---

### 2. MCP 工具选择约束模板

```markdown
## 工具使用指南

**IMPORTANT**: 使用正确的工具完成任务

### 工作流诊断
- ✅ **使用**: `gh-aw_audit` 工具获取诊断信息
- ✅ **使用**: `gh-aw_logs` 工具下载日志
- ❌ **禁止**: 使用 GitHub MCP 查询工作流运行

### 仓库操作
- ✅ **使用**: GitHub MCP 查询 issues, PRs, commits
- ❌ **禁止**: 使用 gh-aw 工具操作仓库

**原因**: 每个 MCP 服务器专注于特定领域，使用专业工具获得更好结果。
```

---

### 3. 文件系统知识库模板

```markdown
## 知识持久化策略

### 存储结构

将调查结果保存到以下目录：

```bash
/tmp/gh-aw/cache-memory/
├── investigations/       # 调查报告
│   └── YYYYMMDD-HHMMSS-<context-id>.json
├── patterns/            # 错误模式库
│   └── <pattern-name>.json
└── index.json          # 快速检索索引
```

### 存储格式

```json
{
  "timestamp": "2026-01-08T12:00:00Z",
  "context_id": "run-12345",
  "category": "failure-type",
  "signature": "error-pattern-hash",
  "findings": {
    "root_cause": "具体原因",
    "resolution": "解决方案"
  }
}
```

### 检索逻辑

1. **查询历史**: 读取 `index.json` 快速定位
2. **模式匹配**: 比较 `signature` 识别相似问题
3. **提取经验**: 从历史 `resolution` 学习解决方案
```

---

### 4. 动态输出路由模板

```markdown
## 输出位置决策

### Step 1: 查询关联上下文

使用 GitHub 搜索 API 查找关联的 Pull Request：

```markdown
Query: `repo:${{ github.repository }} is:pr <commit-sha>`
```

### Step 2: 动态路由

```markdown
{{#if pull_request_found}}
## 发现关联 PR: #<pr-number>

使用 `add_comment` 将报告发布到 PR。
{{else}}
## 未找到关联 PR

使用 `create_issue` 创建新 Issue。
{{/if}}
```

**Frontmatter 配置**:
```yaml
safe-outputs:
  add-comment:
    target: "*"           # 支持任意 PR/Issue
  create-issue:
    expires: 2h           # 临时 Issue
```

---

### 5. Phased 调查框架模板

```markdown
## 调查流程

### Phase 1: 快速分类 (2 分钟)
- 使用专业工具获取初步诊断
- 判断是否需要深入分析

### Phase 2: 数据收集 (5 分钟)
- 提取详细日志和错误信息
- 识别错误模式和堆栈追踪

### Phase 3: 历史对比 (3 分钟)
- 查询知识库中的相似案例
- 提取历史解决方案

### Phase 4: 根因分析 (5 分钟)
- 分类失败类型
- 深度分析根本原因

### Phase 5: 知识存储 (2 分钟)
- 持久化调查结果
- 更新模式库

### Phase 6: 去重判断 (1 分钟)
- 搜索现有 Issue
- 决定是否创建新 Issue

### Phase 7: 报告输出 (2 分钟)
- 格式化报告
- 动态路由输出
```

**时间预算原则**:
- 快速阶段优先（Phase 1: 10%）
- 核心分析充足（Phase 4: 25%）
- 输出轻量（Phase 7: 10%）

---

### 6. Expiring Issue 配置模板

```yaml
safe-outputs:
  create-issue:
    expires: 2h              # 2小时后自动关闭
    title-prefix: "[临时通知] "
    labels: [automation, temporary]
```

**使用场景**:
- ✅ 临时通知（失败调查、每日报告）
- ✅ 快速反馈（强制开发者响应）
- ❌ 长期跟踪（功能请求、Bug 修复）

**最佳实践**:
- 结合 cache-memory 持久化重要信息
- 在 Issue 中明确说明"临时性质"
- 提供查询历史的途径（如链接到知识库）

---

### 7. Reporting Format（导入复用）

**导入方式**:
```yaml
imports:
  - shared/reporting.md
```

**遵循格式**（从 Phase 7 提取）:
```markdown
<!-- 1-2 段落概述 -->
调查发现工作流失败的根本原因是 XXX。建议采取以下行动修复。

<details>
<summary><b>完整调查报告 - Run #<run-number></b></summary>

## 失败详情
- **Run**: [§<run-id>](<url>)

## 根因分析
[详细分析...]

## 建议行动
- [ ] [具体步骤]

</details>

---

**References:**
- [§<run-id>](<url>)
```

**关键规范**:
- 1-2 段落概述在前
- `<details>` 折叠详细内容
- 工作流运行 ID 使用 `[§RunID](url)` 格式
- 最多 3 个参考链接

---

## 🔍 批判性分析

### 做得好的地方 ✅

1. **工具职责边界清晰**:
   - 明确约束：使用 gh-aw_audit 而非 GitHub MCP
   - 防止 Agent 误用工具
   - 每个 MCP 有明确的职责范围

2. **知识积累机制完善**:
   - 不只是"分析并遗忘"
   - 结构化存储支持未来检索
   - Phase 3 和 Phase 5 形成学习闭环

3. **输出智能化**:
   - 动态路由减少噪音
   - Expiring Issue 防止堆积
   - 格式规范（reporting.md）保证一致性

4. **调查流程系统化**:
   - 7 个 Phase 覆盖完整生命周期
   - 漏斗式流程高效分配时间
   - 可跳过机制（Phase 6 去重）

5. **可重用性设计**:
   - workflow_call 实现逻辑复用
   - 参数化设计灵活性强
   - 单一职责易于维护

### 可以改进的地方 ⚠️

1. **缺少失败重试机制**:
   - gh-aw_audit 调用失败怎么办？
   - 是否应该有降级策略（如直接读取日志）？
   - **建议**: 添加工具调用失败的处理逻辑

2. **时间预算缺少强制性**:
   - Prompt 中提到"预估时间"，但无硬性约束
   - Agent 可能在某个 Phase 花费过多时间
   - **建议**: 使用"Time-Boxed Phases"模式，明确时间限制

3. **知识库无清理机制**:
   - cache-memory 无限增长会怎样？
   - 旧的调查报告何时清理？
   - **建议**: 定期清理策略或容量限制

4. **去重逻辑可能不准确**:
   - Phase 6 仅通过关键词搜索判断重复
   - 错误签名（error signature）未标准化
   - **建议**: 引入更精确的相似度算法

5. **单一 MCP 依赖风险**:
   - 如果 gh-aw MCP 不可用，整个工作流失败
   - 缺少降级到 GitHub MCP 的逻辑
   - **建议**: 添加 MCP 健康检查和降级路径

6. **报告模板过于详细**:
   - Phase 7 提供了两个几乎相同的模板（PR 和 Issue）
   - DRY 原则违反
   - **建议**: 提取共同部分为子模板

---

## 💡 核心洞见

1. **workflow_call 是工作流的"函数调用"**:
   - 实现了代码复用的核心原则
   - 将工作流从"脚本"提升为"可组合的组件"
   - 是构建复杂工作流系统的基础

2. **MCP 专业化 > MCP 数量**:
   - cloclo 使用 3 个 MCP 提供广泛能力
   - smoke-detector 使用 1 个 MCP 提供深度能力
   - 两种策略都有效，取决于任务性质

3. **知识积累是 AI 工作流的核心价值**:
   - 不只是"自动化任务"，而是"学习和改进"
   - cache-memory 从"临时存储"变成"知识库"
   - 每次运行都让系统更智能

4. **输出路由的智能化很重要**:
   - 盲目创建 Issue 会造成噪音
   - 上下文感知提高用户体验
   - 临时 Issue + 持久化知识 = 最佳实践

5. **调查框架的可迁移性**:
   - Phased 调查模式不只适用于工作流失败
   - 可应用于：性能问题、安全审计、代码质量分析
   - 这是一个通用的"系统化调查"模板

---

## 📈 Skill 更新建议

### workflowAnalyzer Skill

**新增模式**（7 个）:
1. Reusable Workflow Pattern ⭐⭐⭐⭐⭐
2. MCP-Specialized Tool Pattern ⭐⭐⭐⭐⭐
3. File-Based Knowledge Accumulation Pattern ⭐⭐⭐⭐⭐
4. Dynamic Output Routing Pattern ⭐⭐⭐⭐
5. Phased Investigation Framework Pattern ⭐⭐⭐⭐
6. Expiring Issue Pattern ⭐⭐⭐
7. Themed Messages Pattern（复用，smoke-detector 变体）⭐⭐⭐

**更新章节**:
- "设计模式识别" 章节添加上述模式
- "MCP 集成" 章节补充 gh-aw MCP 工具集
- "cache-memory 使用模式" 章节区分"对话上下文"和"知识库"

### workflowAuthoring Skill

**新增片段**（7 个）:
1. Reusable Workflow 基础模板
2. MCP 工具选择约束模板
3. 文件系统知识库模板
4. 动态输出路由模板
5. Phased 调查框架模板
6. Expiring Issue 配置模板
7. Reporting Format 导入复用模板

**更新章节**:
- "设计模式库" 添加 Reusable Workflow 模式
- "代码片段库" 添加上述 7 个模板
- "最佳实践" 添加知识积累和输出路由指南

---

## 🔮 后续研究方向

### 方向 1: workflow_call 生态全景图 ⭐⭐⭐⭐⭐

**目标**: 系统性研究所有可重用工作流

**任务**:
1. 搜索所有使用 `workflow_call` 的工作流
2. 分类可重用工作流（诊断、部署、通知、测试等）
3. 总结参数设计模式
4. 创建"可重用工作流组合指南"

**产出**:
- workflow_call 使用模式库
- 可重用工作流设计最佳实践
- 调用方式参考手册

**价值**: 填补 Skills 中 workflow_call 知识的空白

---

### 方向 2: gh-aw MCP 完整工具集文档

**目标**: 系统化记录 gh-aw MCP 的所有工具和能力

**任务**:
1. 分析 gh-aw MCP 的源代码或文档
2. 列举所有可用工具（audit, logs, status, compile...）
3. 总结每个工具的参数、输出、使用场景
4. 提取工具组合的最佳实践

**产出**:
- gh-aw MCP 工具参考手册
- 工具选择决策树
- 常见诊断场景的工具组合模板

---

### 方向 3: 知识积累模式对比研究

**目标**: 对比不同工作流的知识积累策略

**任务**:
1. 分析使用 cache-memory 的所有工作流
2. 分类知识积累模式（对话上下文 vs 知识库 vs 状态存储）
3. 评估每种模式的优缺点
4. 总结知识积累的设计模式

**产出**:
- 知识积累模式分类
- cache-memory 使用最佳实践
- 知识库设计模板

---

### 方向 4: 输出路由模式库

**目标**: 收集和分析各种智能输出路由的案例

**任务**:
1. 搜索所有使用"条件输出"的工作流
2. 分析路由决策逻辑（基于上下文、基于内容、基于历史）
3. 总结输出位置选择的最佳实践
4. 提取可复用的路由模板

**产出**:
- 输出路由模式库
- 决策逻辑模板
- 用户体验优化指南

---

## 📊 统计数据

### 文件结构分析

- **总行数**: 314 行
- **Frontmatter**: 60 行（19%）
- **Prompt**: 254 行（81%）

### Frontmatter 复杂度

- **触发器**: workflow_call + 6 个 inputs
- **权限**: 4 个（只读 + actions）
- **工具**: 3 个（cache-memory, github, gh-aw MCP）
- **Safe-outputs**: 2 个（add-comment, create-issue）
- **导入**: 2 个（gh-aw.md, reporting.md）

### Prompt 结构

- **Phase 数量**: 7 个
- **Phase 平均长度**: 36 行
- **约束数量**: 2 个 IMPORTANT 标记
- **模板数量**: 2 个（PR 评论 + Issue）

### 关键词频率

- `gh-aw`: 9 次
- `cache-memory`: 6 次
- `Phase`: 7 次
- `IMPORTANT`: 2 次

---

## 时间统计

- **分析时长**: 50 分钟
- **报告撰写**: 60 分钟
- **Skill 更新**: 预计 25 分钟
- **总计**: 预计 135 分钟

---

**下次研究见！** 🔥
