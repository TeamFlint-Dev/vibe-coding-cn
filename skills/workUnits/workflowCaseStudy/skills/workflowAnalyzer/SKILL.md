# Workflow Analyzer Skill

> **类型**: Work Unit 子 Skill - 分析技能  
> **职责**: 提供分析 GitHub Agentic Workflows 的方法论和框架  
> **维护者**: `workflow-case-study` 工作流自动维护

---

## 📚 简介

本 Skill 专注于**如何分析**一个 GitHub Agentic Workflow，提供系统化的分析框架和方法论。

**核心理念**: 每次分析都是学习机会，分析的过程本身也需要被优化。

---

## 🔍 分析框架

### 1. Frontmatter 配置分析

| 维度 | 关注点 | 评估标准 |
|------|--------|---------|
| **触发器 (on)** | 触发方式是否合理 | 是否匹配使用场景 |
| **权限 (permissions)** | 最小权限原则 | 只请求必要权限 |
| **引擎 (engine)** | 引擎选择 | copilot 稳定，claude 实验性 |
| **工具 (tools)** | 工具必要性 | 每个工具都有明确用途 |
| **安全输出 (safe-outputs)** | 输出限制 | 有合理的 max 限制 |
| **超时 (timeout-minutes)** | 时间预估 | 匹配任务复杂度 |

### 2. Prompt 设计分析

| 维度 | 关注点 | 好的实践 |
|------|--------|---------|
| **角色定义** | 清晰的身份 | "你是 XXX 专家" |
| **任务分阶段** | Phase 划分 | 每个 Phase 有明确目标 |
| **上下文注入** | GitHub 变量 | 充分利用 `${{ }}` 变量 |
| **约束声明** | 禁止事项 | 用 ⚠️ 或 ❌ 明确标注 |
| **输出格式** | 结构化程度 | 提供模板或示例 |

### 3. 设计模式识别

#### 已识别的模式

| 模式名称 | 识别特征 | 典型案例 |
|---------|---------|---------|
| **Slash Command** | `on: slash_command` | scout, plan, brave |
| **Event-Driven** | `on: issues/pull_request` | issue-classifier |
| **Scheduled** | `on: schedule` | daily-team-status |
| **Multi-Context** | `{{#if github.event.*}}` | plan, cloclo |
| **Memory-Enabled** | `cache-memory: true` | grumpy-reviewer |
| **Multi-Tool** | 多个 MCP 集成 | cloclo |
| **Data Pre-Loading** ⭐ | frontmatter `steps:` 下载数据 | ci-coach |
| **Validate-Before-Propose** ⭐ | 变更前运行 lint+build+test | ci-coach |
| **Coaching/Educational** ⭐ | PR 包含 Why + Rationale | ci-coach |
| **Embedded Decision Framework** ⭐ | 明确的 Impact/Risk/Effort 评分 | ci-coach |
| **Graceful No-Op** ⭐ | 无变更时静默退出 + 记录 | ci-coach |
| **Example-Driven Reasoning** ⭐ | 提供完整示例+计算过程 | ci-coach |

⭐ = 新发现模式 (来源: ci-coach 分析 #3)

---

## 📏 质量评估标准

### 配置质量

| 等级 | 标准 |
|------|------|
| ⭐⭐⭐ | 最小权限、合理超时、完整 safe-outputs |
| ⭐⭐ | 基本正确，有小改进空间 |
| ⭐ | 有明显问题需要修复 |

### Prompt 质量

| 等级 | 标准 |
|------|------|
| ⭐⭐⭐ | 清晰角色、分阶段任务、明确约束 |
| ⭐⭐ | 基本可用，结构较清晰 |
| ⭐ | 混乱或缺失关键信息 |

---

## 🛠️ 分析工具箱

### 快速检查清单

```markdown
## Frontmatter 检查
- [ ] 触发器类型明确
- [ ] 权限最小化
- [ ] 超时设置合理
- [ ] safe-outputs 有 max 限制

## Prompt 检查
- [ ] 有明确的角色定义
- [ ] 有任务分阶段
- [ ] 有成功标准
- [ ] 有约束声明
```

### 分析命令

```bash
# 统计工作流行数
wc -l path/to/workflow.md

# 提取 frontmatter
sed -n '/^---$/,/^---$/p' path/to/workflow.md

# 搜索 Handlebars 条件
grep -n "{{#if" path/to/workflow.md
```

---

## 📖 学习记录

> 以下内容由 `workflow-case-study` 工作流自动更新

### 最近分析的工作流

| 日期 | 工作流 | 主要发现 |
|------|--------|---------|
| 2026-01-08 | ci-coach | 发现 6 个新模式：数据预加载、验证后提议、教练模式等 |

### 新发现的模式

#### Data Pre-Loading Pattern (ci-coach #3)
- **识别特征**: frontmatter 中使用 `steps:` 预下载数据到 `/tmp/`
- **用途**: Agent 需要大量 API 数据或 artifacts
- **优势**: 避免 API 配额限制，Agent 启动更快
- **示例**: 预下载 CI 运行历史、测试报告、覆盖率数据

#### Validate-Before-Propose Pattern (ci-coach #3)
- **识别特征**: 在创建 PR 前运行完整验证套件
- **验证门**: `make lint` + `make build` + `make test`
- **安全性**: 只有验证全部通过才创建 PR
- **用途**: 任何自动化代码变更工作流

#### Coaching/Educational Pattern (ci-coach #3)
- **识别特征**: PR 描述不仅说明"是什么"，更解释"为什么"
- **结构**: Current → Proposed → Benefits → Rationale
- **价值**: 教育人类，建立信任
- **用途**: 向人类提议变更的工作流

#### Embedded Decision Framework Pattern (ci-coach #3)
- **识别特征**: 提供明确的决策评分标准
- **格式**: Impact/Risk/Effort 表格
- **优势**: 消除决策模糊性
- **用途**: 需要在多个选项间权衡的场景

#### Graceful No-Op Pattern (ci-coach #3)
- **识别特征**: 无有意义变更时静默退出
- **知识捕获**: 仍将分析结果保存到 cache-memory
- **优势**: 减少噪音，尊重人类注意力
- **用途**: 定期运行的分析工作流

#### Example-Driven Reasoning Pattern (ci-coach #3)
- **识别特征**: 提供完整工作示例含计算过程
- **格式**: 当前状态 → 优化状态 → 数值计算 → 百分比改进
- **用途**: 教授复杂推理（如并行化优化）
- **示例**: CI 关键路径分析（12.5 min → 7.5 min = 40% 改进）

### 分析中遇到的困难

参见 [FAILURE-CASES.md](FAILURE-CASES.md)

---

## 📚 相关文档

- [workflowAuthoring Skill](../workflowAuthoring/SKILL.md) - 如何编写工作流
- [父级 SKILL](../../SKILL.md) - 工作单元概览
