# Failure Case Miner — 前置检查清单

在运行 `.github/workflows/failure-case-miner.md` 前确认：

## 必备

- [ ] 目标路径存在：`skill_path` 指向的目录存在，且包含 `FAILURE-CASES.md`
- [ ] 已确认回溯窗口：`days_back` 合理（默认 30）

## 权限与密钥（运行时）

- [ ] 仓库已配置 `COPILOT_GITHUB_TOKEN`（Fine-grained PAT，带 Copilot + repo 权限）
- [ ] 如需 remote MCP：已配置 `GH_AW_GITHUB_MCP_SERVER_TOKEN` 或 `GH_AW_GITHUB_TOKEN`

## 输出控制

- [ ] 需要写回文件时：确保工作流启用了 `edit` 与 `safe-outputs.create-pull-request`
- [ ] 如只想创建追踪项：可以只启用 `safe-outputs.create-issue`
