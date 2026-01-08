# Failure Case Miner — 决策记录

## 2026-01-08：将单个 Workflow 视为 Work Unit

**决策**：把 `Failure Case Miner` 定义为最小工作单元（Work Unit），并为其创建自维护的 Skill 知识包目录。

**原因**：

- 让每个工作单元拥有自己的方法论与踩坑积累，避免知识只停留在“某次 Issue/PR”里。
- Work Unit 能逐步探索出最适合自身的实现路径（命令、搜索策略、输出格式），并在重复任务中复用。

**影响**：

- 工作流默认沉淀到 `skills/github/ghAgenticWorkflows/workUnits/failureCaseMiner/`
- 如需沉淀到其他领域 Skill，通过 `skill_path` 覆盖
