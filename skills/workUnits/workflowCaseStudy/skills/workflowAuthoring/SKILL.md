# Workflow Authoring Skill

> **类型**: Work Unit 子 Skill - 创作技能  
> **职责**: 提供编写 GitHub Agentic Workflows 的最佳实践和可复用模板  
> **维护者**: `workflow-case-study` 工作流自动维护

---

## 📖 索引

| 类别 | 文件 | 说明 |
|------|------|------|
| **设计模式** | [patterns/DESIGN-PATTERNS-INDEX.md](patterns/DESIGN-PATTERNS-INDEX.md) | 26+ 设计模式分类索引 |
| **代码片段** | [snippets/SNIPPETS-INDEX.md](snippets/SNIPPETS-INDEX.md) | Frontmatter、提示词、消息模板 |
| **最佳实践** | [best-practices/BEST-PRACTICES-INDEX.md](best-practices/BEST-PRACTICES-INDEX.md) | 权限、工具、质量保证 |

---

## 💡 启发式提示

### 选择触发方式
- 用户主动触发？→ **Slash Command** (`patterns/BASIC.md`)
- 响应仓库事件？→ **Event-Driven** (`patterns/BASIC.md`)
- 定期执行？→ **Scheduled** (`patterns/BASIC.md`)

### 选择协调模式
- 需要多工作流协作？→ **Coordinator-Executor** (`patterns/COORDINATION.md`)
- 需要串行执行？→ **Queued Execution** (`patterns/COORDINATION.md`)
- 需要状态锁定？→ **Lock-for-Agent** (`patterns/COORDINATION.md`)

### 选择交互模式
- 需要收集用户需求？→ **Progressive Disclosure** (`patterns/INTERACTION.md`)
- 需要双模式支持？→ **Dual-Mode Agent** (`patterns/INTERACTION.md`)

### 选择高级模式
- 监控其他工作流？→ **Meta-Orchestrator** (`patterns/META-ORCHESTRATOR.md`)
- 长期多工作流任务？→ **Campaign** (`patterns/CAMPAIGN.md`)
- 任务分解为子Issue？→ **Parent-Child** (`patterns/TASK-DECOMPOSITION.md`)

---

## 🎯 How To Do

### 创建新工作流

1. **确定触发方式** → 查阅 `patterns/BASIC.md`
2. **选择 Frontmatter 模板** → 复制自 `snippets/FRONTMATTER.md`
3. **设计 Prompt 结构** → 参考 `snippets/PROMPT-STRUCTURE.md`
4. **配置 safe-outputs** → 复制自 `snippets/SAFE-OUTPUTS.md`
5. **应用最佳实践** → 检查 `best-practices/`

### 改进现有工作流

1. **诊断问题** → 用 workflowAnalyzer 分析
2. **匹配设计模式** → 查阅 `patterns/DESIGN-PATTERNS-INDEX.md`
3. **应用模式** → 从对应文件复制代码

### 创建 Campaign

1. **阅读 Campaign 模式** → `patterns/CAMPAIGN.md`
2. **定义 KPI 和 Governance** → 按模板配置
3. **设计 Worker 工作流** → 遵循 Worker-Orchestrator 分离

---

## 🔄 进化信号

### 添加新模式的信号
- 发现 3+ 个工作流使用相同技巧
- 某技术在多个 Issue 分析中被提及

### 拆分子文件的信号
- 某类别模式 > 10 个
- 某文件 > 500 行

### 归档内容的信号
- 模式 6 个月未被引用
- 底层 API 已废弃

---

## 📁 目录结构

```
workflowAuthoring/
├── SKILL.md                      # 本文件（骨架）
├── patterns/                     # 设计模式
│   ├── DESIGN-PATTERNS-INDEX.md  # 模式索引
│   ├── BASIC.md                  # 基础模式
│   ├── COORDINATION.md           # 协调模式
│   ├── META-ORCHESTRATOR.md      # 元编排模式
│   ├── SECURITY.md               # 安全模式
│   ├── INTERACTION.md            # 交互模式
│   ├── CAMPAIGN.md               # Campaign 模式
│   └── TASK-DECOMPOSITION.md     # 任务分解模式
├── snippets/                     # 代码片段
│   ├── SNIPPETS-INDEX.md         # 片段索引
│   ├── FRONTMATTER.md            # Frontmatter 模板
│   ├── PROMPT-STRUCTURE.md       # 提示词结构
│   ├── SAFE-OUTPUTS.md           # Safe Outputs 配置
│   ├── DATA-PATTERNS.md          # 数据模式
│   └── MESSAGES.md               # 消息模板
└── best-practices/               # 最佳实践
    ├── BEST-PRACTICES-INDEX.md   # 实践索引
    ├── PERMISSIONS.md            # 权限配置
    ├── TOOLS.md                  # 工具使用
    ├── PROMPT-DESIGN.md          # 提示词设计
    └── QUALITY.md                # 质量保证
```
