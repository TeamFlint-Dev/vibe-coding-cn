# Phase 3: 执行 (Execute)

> **职责**：执行决定的工作，产出知识资产
> 
> **时间预算**：15-18 分钟（主要工作阶段）

---

## 根据 Phase 2 的决定，选择执行模式

- **研究模式** → 3A
- **重构模式** → 3B
- **跳过模式** → 直接进入 Phase 4

---

# 3A: 研究模式

## Step 3A.1: 获取目标内容

```bash
# 从 gh-aw 仓库获取工作流内容
gh api repos/githubnext/gh-aw/contents/.github/workflows/{target}.md --jq '.content' | base64 -d
```

或读取本地缓存。

---

## Step 3A.2: 带着猜想分析

分析时始终问自己：

1. **设计者的意图**：他为什么这样写？考虑过什么替代方案？
2. **猜想关联**：这能验证或推翻我的哪个猜想？
3. **模式识别**：有什么可复用的设计模式？
4. **边界发现**：有什么能力限制是我之前不知道的？

---

## Step 3A.3: 产出知识资产

### 分析报告

创建：`skills/workUnits/workflowCaseStudy/reports/case-studies/{target}-analysis.md`

报告必须包含：
- 工作流解决什么问题
- 关键设计选择及其权衡
- 可复用的模式
- 与猜想的关系

### 工作日志

创建：`journals/workUnits/workflowCaseStudy/{date}-{target}.md`

日志记录：
- 选择这个目标的理由
- 分析过程中的发现
- 未解决的问题
- 对下次运行的建议

### 猜想更新

更新：`${{ env.SKILLS_BASE }}/hypothesis/HYPOTHESES.md`

- 发现支持证据 → 添加证据引用
- 发现反驳证据 → 更新状态为 refuted
- 产生新问题 → 提出新猜想

### 能力边界更新（如有新发现）

更新：`${{ env.SKILLS_BASE }}/workflowAuthoring/CAPABILITY-BOUNDARIES.md`

标注来源：`(来源: {target} 分析 #${{ github.run_number }})`

---

# 3B: 重构模式

## Step 3B.1: 确认问题

明确要解决的问题：
- 哪个文件太大？
- 哪里结构混乱？
- 什么交叉引用失效？

---

## Step 3B.2: 选择策略

| 问题 | 策略 |
|------|------|
| 文件太大 | 垂直拆分（按功能模块） |
| 内容过时 | 知识压缩（删除冗余） |
| 历史堆积 | 归档（移动到 archive/） |

---

## Step 3B.3: 执行重构

1. 拆分/压缩/归档
2. 更新索引和交叉引用
3. 确保引用完整性

---

## Step 3B.4: 记录变更

创建：`journals/workUnits/workflowCaseStudy/{date}-skills-refactor.md`

记录：
- 重构了什么
- 为什么这样重构
- 变更的文件列表

---

## 完成 Phase 3 后，你应该有

| 模式 | 产出 |
|------|------|
| 研究 | 分析报告 + 工作日志 + 猜想更新 + (可选)边界更新 |
| 重构 | 重构后的文件 + 重构日志 |

**记录所有变更的文件列表，进入 Phase 4。**
