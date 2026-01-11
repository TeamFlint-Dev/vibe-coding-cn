# Phase 1: 准备 (Prepare)

> **职责**：建立工作环境，加载所有前置信息
> 
> **时间预算**：3-5 分钟

---

## 你要回答的问题

1. **有没有我应该继续的 PR？**
2. **前人留下了什么信息？**

---

## Step 1.1: 检查现有 PR

搜索满足以下条件的 open PR：
- 标题以 `[workflow-study]` 开头
- 有 `gh-aw-research` 标签

```bash
gh pr list --repo ${{ github.repository }} --state open --label "gh-aw-research" --json number,title,headRefName
```

**记录结果**：
- 如果找到 → 记住 `pr_number` 和 `branch_name`
- 如果没找到 → 后续需要创建新 PR

---

## Step 1.2: 加载知识上下文

并行读取以下文件：

| 文件 | 用途 |
|------|------|
| `${{ env.SKILLS_BASE }}/hypothesis/HYPOTHESES.md` | 待验证的猜想 |
| `skills/workUnits/workflowCaseStudy/reports/case-studies/` | 已分析过的工作流 |
| `skills/workUnits/workflowCaseStudy/RESEARCH-AGENDA.md` | 研究方向优先级 |
| `journals/workUnits/workflowCaseStudy/` 最新 3 个 | 最近的发现 |

---

## Step 1.3: 检查 Skills 健康度

快速评估：
- 有没有 Skill 文件超过 500 行？
- 结构是否混乱？

如果需要重构，在 Phase 2 会切换到重构模式。

---

## Step 1.4: 加载失败案例

读取：
- `${{ env.SKILLS_BASE }}/workflowAnalyzer/FAILURE-CASES.md`
- `${{ env.SKILLS_BASE }}/workflowAuthoring/FAILURE-CASES.md`

前人踩过的坑，你不需要再踩。

---

## 完成 Phase 1 后，你应该知道

1. **PR 状态**：有现有 PR？编号和分支是什么？
2. **猜想状态**：有哪些待验证的猜想？
3. **历史状态**：哪些工作流已经分析过？
4. **议程状态**：当前的研究优先级是什么？
5. **健康状态**：Skills 需要重构吗？

**带着这些信息进入 Phase 2。**
