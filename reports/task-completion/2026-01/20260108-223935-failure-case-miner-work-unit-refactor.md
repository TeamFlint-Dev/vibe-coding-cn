# 任务完成报告

**日期**: 2026-01-08  
**任务**: Failure Case Miner 示范性重构为 Work Unit + 自维护 Skills，并完成局部质量校验  

---

## 任务结果

- 为 `Failure Case Miner` 建立了独立的 Work Unit 知识包目录：`skills/github/ghAgenticWorkflows/workUnits/failureCaseMiner/`，包含 `SKILL.md`、`PREFLIGHT-CHECKLIST.md`、`CAPABILITY-BOUNDARIES.md`、`FAILURE-CASES.md`、`DECISION-LOG.md`。
- 重构了工作流 `.github/workflows/failure-case-miner.md`：默认 `skill_path` 指向本 Work Unit；新增 `safe-outputs.create-pull-request` 用于形成“写回文件→提交 PR”的闭环；运行时读取 Work Unit 文档用于对齐格式要求。
- 在 Windows 环境下建立了“局部 markdownlint”验证方式，并修复了本次新增/修改文件的 markdownlint 报错；随后重新 `gh aw compile .github/workflows/failure-case-miner.md` 生成最新 lock 文件。

---

## 反思：我在这次任务中犯了哪些错误？

> 回顾整个任务过程，诚实地列出每一个错误、失误、不符合预期的情况。

### 错误 1: 试图依赖 `make lint`，忽略 Windows 环境差异

- **发生了什么**: 直接尝试运行 `make lint`，在 Windows 上不可用导致中断。
- **为什么会发生**: 没有在行动前先确认仓库在 Windows 的等价校验命令/替代路径。
- **下次如何避免**: 优先提供跨平台命令（例如 `npx markdownlint-cli2 ...`），并在任务开始时明确“全仓 lint vs 局部 lint”的验收口径。

### 错误 2: 一开始跑了全仓 Markdown lint，导致被存量问题淹没

- **发生了什么**: 使用 markdownlint 扫描 `**/*.md`，输出大量存量报错，无法作为本次改动的有效验收信号。
- **为什么会发生**: 没有先用 `git diff --name-only`（或等价方式）把校验范围收敛到本次新增/修改文件。
- **下次如何避免**: 默认采用“变更集校验”，只对本次修改文件/目录执行 lint；必要时再提供“全仓状态说明”。

### 错误 3: 在 `.github/workflows/failure-case-miner.md` 里写了会触发 lint 的 Markdown 结构

- **发生了什么**: 列表前缺空行（MD032）、代码围栏前后缺空行（MD031）、以及嵌套三反引号导致 MD040/MD031 组合报错。
- **为什么会发生**: 写 prompt/模板内容时没有同步遵守仓库 markdownlint 约束（尤其是“嵌套 fenced code block”这种细节）。
- **下次如何避免**: 形成写作习惯：列表/代码块前后强制空行；包含“代码块里的代码块”时一律用外层 4 反引号或 `~~~`。

### 错误 4: 过早假设 `imports:` 可以直接引用 `skills/...` 本地路径

- **发生了什么**: 尝试在 workflow frontmatter 里加入 `imports: - skills/...`，编译时报 “failed to download import file”。
- **为什么会发生**: 没有先验证 gh-aw 在本仓库配置下对 imports 的根路径/可访问范围。
- **下次如何避免**: 先用一个最小 imports 示例在本仓库编译验证；不确定时优先使用“运行时读取文件（bash cat）”或把可复用片段放到已知可 import 的 shared 目录。

---

## 如果重来一次，我会怎么做？

- 先明确验收策略：本次示范只要求 Work Unit 自身（workflow + workUnits 文档）能编译且局部 lint 通过；全仓 lint 不作为门槛。
- 先收集变更集，再一次性跑“局部 markdownlint + 单工作流编译”，最后再补充结构性文档（DECISION-LOG/FAILURE-CASES）。

---

## 这次任务暴露了哪些 Skill/文档需要改进？

- `skills/github/ghAgenticWorkflows/SKILL.md` 或相关 runbook 可以补充一段：Windows 下的标准校验命令（替代 `make lint`）以及推荐的“局部 lint”方式。
- 可以新增一条 Work Unit 写作规范：如何在 Markdown 中嵌套 code fence（推荐使用 4 反引号或 `~~~`），避免 MD031/MD040。
- 需要在 gh-aw 工作流模板/说明里明确：`imports` 的可用路径边界与推荐组织方式（例如仅允许 `shared/...`）。
