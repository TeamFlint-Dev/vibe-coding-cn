# Workflow Authoring 能力边界

## ✅ 能做的事（绿灯区）

| 类别 | 具体能力 |
|------|----------|
| **配置** | 编写 Frontmatter 配置 |
| **Prompt** | 设计自然语言指令 |
| **工具集成** | 配置 GitHub/bash/edit/MCP 工具 |
| **安全输出** | 配置 safe-outputs |
| **条件逻辑** | 使用 Handlebars 条件语法 |
| **预处理步骤** | 在 Agent 前执行 shell 命令准备数据（来源: audit-workflows #26） |
| **多格式 repo-memory** | 同一工作流可混用 json/jsonl/csv/md（来源: audit-workflows #26） |
| **自动清理讨论** | `close-older-discussions: true` 自动关闭旧讨论（来源: audit-workflows #26） |
| **MCP 日志解析** | 使用 gh-aw MCP 的 `logs` 工具获取运行日志（来源: audit-workflows #26） |

## ❌ 不能做的事（红灯区）

| 类别 | 限制说明 |
|------|----------|
| **自定义 Action** | 只能使用现有 Actions |
| **复杂编排** | Campaign 复杂编排需要单独学习 |
| **跨仓库** | 需要额外权限配置 |
| **repo-memory 大文件** | 单文件最大 100KB（来源: audit-workflows #26） |
| **MCP 工具超时** | 默认 5 分钟（300 秒）超时（来源: audit-workflows #26） |

## ⚠️ 有条件能做（黄灯区）

| 类别 | 条件 |
|------|------|
| **MCP 集成** | 需要对应 MCP 服务器的配置知识 |
| **Claude 引擎** | 实验性功能，可能不稳定 |
| **网络访问** | 需要配置 `network:` 字段 |
