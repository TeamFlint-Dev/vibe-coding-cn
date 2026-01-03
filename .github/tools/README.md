# CLI Tools

> 此目录由 CI 自动同步，源文件位于各 Skill 的 `tools/` 子目录

## 工具来源

工具脚本的真正位置在 `Core/skills/<skill>/tools/` 目录下。
当这些目录中的文件变更时，CI 会自动同步到此目录。

## 约定

1. **添加工具**：将 `.py` 或 `.sh` 放入对应 Skill 的 `tools/` 目录
2. **自动同步**：推送后 CI 自动收集到此目录
3. **命名规则**：文件名即命令名

## 当前工具

| 工具 | 说明 |
|------|------|
| `pipeline-notify` | 流水线事件通知 |
| `bd-linux-amd64` | Beads CLI (预编译二进制) |

## 使用方式

```bash
# 在 GitHub Actions 中
python .github/tools/pipeline-notify.py ready --pipeline-id xxx

# 或添加到 PATH 后直接调用
pipeline-notify ready --pipeline-id xxx
```

## 相关 Skill

- [pipelineOps](../../Core/skills/programming/pipelineOps/SKILL.md) - 流水线操作
- [beadsCLI](../../Core/skills/programming/beadsCLI/SKILL.md) - Beads 任务管理
