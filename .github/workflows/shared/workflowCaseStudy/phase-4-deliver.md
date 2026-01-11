# Phase 4: 交付 (Deliver)

> **职责**：把成果交出去，更新资产状态

---

## 交付的意义

做完了不等于交付了。

交付 = 文件创建 + 推送到 PR 分支 + PR 评论

**如果你没有推送到 PR，你的工作会丢失。**

---

## 交付步骤（必须按顺序完成）

### 4.1 确认产出物已创建

在提交前，先确认文件真的存在。使用工具读取以下文件：

| 产出类型 | 路径 |
|----------|------|
| 案例报告 | `skills/workUnits/workflowCaseStudy/reports/` |
| Skill 更新 | 对应的 Skill 目录 |
| 猜想更新 | `skills/workUnits/workflowCaseStudy/skills/hypothesis/` |
| Journal | `journals/workUnits/workflowCaseStudy/` |
| OVERVIEW.md | `skills/workUnits/workflowCaseStudy/OVERVIEW.md` |

**如果文件不存在，回到 Phase 3 创建它。**

---

### 4.2 推送到 PR（最关键的一步）

**⚠️ 这是最重要的步骤。如果不做这一步，你的所有工作都会丢失。**

#### 如何正确推送

**你需要使用 `push_to_pull_request_branch` 或 `create_pull_request` 工具。**

这些工具的工作原理：
1. 它们会自动创建一个新的分支（或使用现有分支）
2. 把你创建/修改的文件提交到那个分支
3. 创建或更新 PR

#### 情况 A：Phase 1 找到了现有 PR

使用 `push_to_pull_request_branch` 工具。

**你需要提供**：
- `files`: 你要提交的文件列表（完整路径）
- `message`: commit 消息
- `branch`: Phase 1 记录的 PR 分支名

**示例**：
```
工具: push_to_pull_request_branch
参数:
  files:
    - skills/workUnits/workflowCaseStudy/reports/xxx-analysis.md
    - skills/workUnits/workflowCaseStudy/OVERVIEW.md
    - journals/workUnits/workflowCaseStudy/2026-01-11-xxx.md
  message: "feat: 完成 xxx 分析"
  branch: workflow-study/xxx
```

#### 情况 B：Phase 1 没有找到 PR

使用 `create_pull_request` 工具。

**你需要提供**：
- `files`: 你要提交的文件列表（完整路径）
- `title`: PR 标题，必须以 `[workflow-study]` 开头
- `body`: PR 描述
- `labels`: 必须包含 `gh-aw-research`

**示例**：
```
工具: create_pull_request
参数:
  files:
    - skills/workUnits/workflowCaseStudy/reports/xxx-analysis.md
    - skills/workUnits/workflowCaseStudy/OVERVIEW.md
    - journals/workUnits/workflowCaseStudy/2026-01-11-xxx.md
  title: "[workflow-study] xxx 分析报告"
  body: "本次完成了 xxx 的分析..."
  labels:
    - gh-aw-research
```

#### 常见错误

| 错误 | 原因 | 解决方法 |
|------|------|----------|
| 文件没有出现在 PR | 没有把文件路径加到 `files` 参数 | 确保列出所有要提交的文件 |
| PR 创建失败 | 文件路径错误 | 检查文件是否真的存在 |
| 分支冲突 | 使用了错误的分支名 | 使用 Phase 1 记录的分支名 |

---

### 4.3 验证推送成功

推送工具调用后，检查返回结果：

- **成功**：会返回 PR URL
- **失败**：会返回错误信息

**如果失败，分析错误信息，修正后重试。不要跳过这一步。**

---

### 4.4 在 PR 上添加评论

使用 `add_comment` 工具，总结本次工作：

```
工具: add_comment
参数:
  issue_number: [PR 编号]
  body: |
    ## Run #xxx 完成
    
    ### 本次工作
    - [做了什么]
    
    ### 产出文件
    - `path/to/file1.md`
    - `path/to/file2.md`
    
    ### 发现/学习
    - [有什么发现]
```

---

## 交付检查清单

**在说"交付完成"之前，必须逐项确认：**

| # | 检查项 | 如何确认 |
|---|--------|----------|
| 1 | 产出物文件已创建 | 读取文件确认内容存在 |
| 2 | OVERVIEW.md 已更新 | 读取文件确认资产清单 |
| 3 | 推送工具已调用 | 确认调用了 push_to_pull_request_branch 或 create_pull_request |
| 4 | 推送成功 | 工具返回了 PR URL |
| 5 | 评论已添加 | add_comment 调用成功 |

**如果 #3 或 #4 失败，你的工作没有保存。必须修正后重试。**

---

## 最终输出

成功交付后，必须输出：

```
✅ 交付完成

PR 链接：https://github.com/xxx/xxx/pull/N
推送的文件：
- path/to/file1.md
- path/to/file2.md
```

**没有 PR 链接 = 交付失败 = 工作丢失**
