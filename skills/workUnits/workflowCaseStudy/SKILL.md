# Workflow Case Study 工作单元

> **类型**: Work Unit  
> **职责**: 深度分析 GitHub Agentic Workflows 官方案例，沉淀知识  
> **工作流**: `.github/workflows/workflow-case-study.md`

---

## 📚 简介

本工作单元专注于通过分析真实的工作流案例来积累知识。每次运行会：

1. 随机选取一个官方工作流
2. 进行深度分析
3. 生成分析报告
4. 更新相关 Skills

---

## 📁 目录结构

```
skills/workUnits/workflowCaseStudy/
├── SKILL.md                    # 本文件
├── skills/                     # 子 Skills
│   ├── workflowAnalyzer/       # 如何分析工作流
│   └── workflowAuthoring/      # 如何编写工作流
└── reports/                    # 分析报告
    └── case-studies/           # 案例分析报告
```

---

## 🔗 子 Skills

| Skill | 职责 | 自动更新内容 |
|-------|------|-------------|
| [workflowAnalyzer](skills/workflowAnalyzer/SKILL.md) | 如何分析工作流 | 分析框架、质量标准 |
| [workflowAuthoring](skills/workflowAuthoring/SKILL.md) | 如何编写工作流 | 设计模式、代码片段 |

---

## 📊 产出物

| 产出类型 | 存放路径 |
|---------|---------|
| **分析报告** | `reports/case-studies/` |
| **工作日志** | `../../journals/workUnits/workflowCaseStudy/` |

---

## 🚀 使用方式

```bash
# 手动触发（随机选择工作流）
gh workflow run workflow-case-study.md

# 手动触发（指定工作流）
gh workflow run workflow-case-study.md -f workflow_name=cloclo
```

---

## 📈 统计

| 指标 | 值 |
|------|-----|
| 已分析工作流数 | _(待统计)_ |
| 识别的设计模式 | _(待统计)_ |
| 提取的代码片段 | _(待统计)_ |
