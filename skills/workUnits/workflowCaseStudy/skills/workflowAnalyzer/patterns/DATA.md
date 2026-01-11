# 数据管理设计模式

> **用途**: 状态管理、记忆机制、知识积累模式  
> **来源**: workflowAnalyzer Skill

---

## Memory-Based State Management Pattern ⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: memory-paths 定义 + cursor.json (Campaign 进度) + Worker 专属 memory
- **Memory 结构**: 
  - `memory/campaigns/{id}/` (metrics, cursor)
  - `memory/{worker}/` (processed, extracted, latest-run)
- **设计价值**: 去重、审计、恢复能力、分层存储
- **典型案例**: discussion-task-mining
- **来源**: discussion-task-mining.campaign 分析

---

## File-Based Knowledge Accumulation Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: cache-memory 用于持久化知识 + 结构化文件组织 + 跨运行学习
- **知识架构**: `/tmp/gh-aw/cache-memory/` → 
  - `investigations/`（调查报告）
  - `patterns/`（错误模式）
  - `logs/`（日志缓存）
- **存储格式**: 结构化 JSON（timestamp, run_id, root_cause, error_signature, resolution）
- **检索策略**: 文件系统索引 + 错误签名匹配 + 相似度判断
- **典型案例**: smoke-detector
- **来源**: smoke-detector 分析

---

## Bidirectional Learning Loop Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: Phase 专门用于学习 + 记录成功率、失败原因 + 人类反馈也被记录
- **数据结构**: 
  - ai_learnings: patterns_that_worked, patterns_that_failed, improvements_for_next_time
  - human_feedback: satisfaction, comments
- **设计意图**: AI 不是静态的，每次 Campaign 都改进
- **典型案例**: human-ai-collaboration
- **⚠️ 当前缺失**: 下次运行时如何读取 learnings.json
- **来源**: human-ai-collaboration 分析

---

## Shared Memory Coordination Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 多 Meta-Orchestrator 通过共享文件协调
- **文件约定**: 
  - `{agent}-latest.md` - 每个编排器的最新状态
  - `shared-alerts.md` - 共享告警
  - 文件大小限制 < 10KB
- **典型案例**: agent-performance-analyzer
- **来源**: agent-performance-analyzer 分析

---

## Data Pre-Loading Pattern ⭐

- **识别特征**: frontmatter 中使用 `steps:` 预下载数据到 `/tmp/`
- **用途**: Agent 需要大量 API 数据或 artifacts
- **优势**: 避免 API 配额限制，Agent 启动更快
- **示例**: 预下载 CI 运行历史、测试报告、覆盖率数据
- **典型案例**: ci-coach
- **来源**: ci-coach 分析

---

## Metrics-Driven Analysis Pattern ⭐⭐⭐⭐⭐⭐⭐⭐

- **识别特征**: 依赖独立 metrics-collector + latest.json 快速访问 + daily/*.json 趋势分析
- **设计意图**: 避免重复 API 查询
- **典型案例**: agent-performance-analyzer
- **来源**: agent-performance-analyzer 分析

---

## Shared Metrics Infrastructure Pattern ⭐⭐⭐

- **识别特征**: 专门的 Metrics Collector 工作流 + 结构化 JSON 存储 + 分层存储 + 多消费者共享
- **架构**: Metrics Collector 采集 → repo-memory 存储 → 多个编排器读取
- **优势**: 
  - 避免重复 API 调用（120个工作流只查询一次）
  - 提供历史视图（30天趋势）
  - 解耦生产和消费
  - 降低 API 限流风险
- **数据分层**: latest.json（最新）+ daily/*.json（历史）
- **典型案例**: workflow-health-manager
- **来源**: workflow-health-manager 分析

---

## Graceful No-Op Pattern ⭐

- **识别特征**: 无有意义变更时静默退出
- **知识捕获**: 仍将分析结果保存到 cache-memory
- **优势**: 减少噪音，尊重人类注意力
- **典型案例**: ci-coach
- **来源**: ci-coach 分析

---

## Dynamic Output Routing Pattern ⭐⭐⭐⭐⭐⭐

- **识别特征**: 运行时查询上下文 + 基于查询结果选择输出方式 + 双输出配置
- **路由逻辑**: 查询关联 PR → 找到 PR → add_comment | 未找到 → create_issue
- **实现细节**: GitHub 搜索 API `repo:${{ github.repository }} is:pr <commit-sha>`
- **设计优雅**: 上下文感知（失败信息出现在最相关的地方）
- **典型案例**: smoke-detector
- **来源**: smoke-detector 分析

---

## Infrastructure Agent Pattern ⭐⭐⭐

- **识别特征**: 
  - 无 safe-outputs 配置
  - 明确的「消费者列表」（为谁服务）
  - repo-memory 作为唯一输出
  - Prompt 明确声明「DO NOT create issues/PRs/comments」
- **设计意图**: 
  - 将数据收集与数据消费解耦
  - 减少 API 调用（多个工作流只需查询一次）
  - 标准化数据格式
- **典型案例**: metrics-collector
- **可复用场景**: 任何需要共享数据层的多 Agent 系统
- **来源**: metrics-collector 分析 (Run #3)

---

## Shared Memory Branch Pattern ⭐⭐⭐

- **识别特征**:
  - `repo-memory.branch-name` 指定专用分支
  - `file-glob` 限制访问范围
  - 多个工作流共享同一分支
- **配置示例**:
  ```yaml
  repo-memory:
    branch-name: memory/meta-orchestrators
    file-glob: "metrics/**"
  ```
- **设计意图**:
  - 隔离数据与代码
  - 避免主分支污染
  - 实现数据层的版本控制
- **典型案例**: metrics-collector
- **来源**: metrics-collector 分析 (Run #3)

---

## Data Retention Policy Pattern ⭐⭐⭐

- **识别特征**:
  - 明确的保留期（如 30 天）
  - 自动清理命令
  - latest.json 永久保留
- **实现示例**:
  ```bash
  find /tmp/gh-aw/repo-memory/default/metrics/daily/ -name "*.json" -mtime +30 -delete
  ```
- **设计意图**:
  - 控制存储增长
  - 保证历史可查
  - 快速访问最新数据
- **典型案例**: metrics-collector
- **来源**: metrics-collector 分析 (Run #3)

---

## Dual-Track State Pattern ⭐⭐⭐⭐⭐

- **识别特征**:
  - repo-memory 存储结构化数据（JSON）
  - Issue/PR 展示人类可读摘要（Markdown）
  - 两者同步更新，内容一致性
- **数据分工**:
  - repo-memory: 机器读取、精确查询、历史追溯
  - Issue: 人类阅读、决策界面、通知触发
- **典型结构**:
  ```
  repo-memory/
  ├── command-center.json  # 元数据（状态、团队、SLA）
  └── timeline.json        # 事件时间线（事件溯源）
  
  Issue (Command Center)
  ├── Status Summary       # 人类可读状态
  ├── SLA Tracking         # 时间约束
  └── Decision History     # 决策记录
  ```
- **设计意图**:
  - 机器处理需要结构化数据
  - 人类决策需要可读界面
  - 双轨分离，各取所需
- **典型案例**: incident-response
- **来源**: incident-response 分析 (Run #16)
