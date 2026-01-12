# OpenCode Local Action

本地版本的 OpenCode GitHub Action，提供完全的自定义控制。

## 与官方 Action 的区别

| 功能 | 官方 Action | 本地 Action |
|------|-------------|-------------|
| 版本控制 | 始终使用 latest | 可指定版本 |
| 缓存控制 | 强制缓存 | 可跳过缓存 |
| 输出保存 | 不支持 | **自动保存为 Artifact** |
| 自定义扩展 | 不支持 | 完全可控 |
| 调试能力 | 有限 | 完全可控 |

## 使用方法

### 基础用法

```yaml
- uses: ./.github/actions/opencode
  env:
    DEEPSEEK_API_KEY: ${{ secrets.DEEPSEEK_API_KEY }}
  with:
    model: deepseek/deepseek-reasoner
```

### 自定义 Prompt

```yaml
- uses: ./.github/actions/opencode
  env:
    DEEPSEEK_API_KEY: ${{ secrets.DEEPSEEK_API_KEY }}
  with:
    model: deepseek/deepseek-reasoner
    prompt: |
      你是一个专业的代码审查助手。
      请分析这个 PR 的变更...
```

### 指定版本

```yaml
- uses: ./.github/actions/opencode
  with:
    model: deepseek/deepseek-reasoner
    version: v1.1.14
```

## 输入参数

| 参数 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | ✅ | - | 模型 (格式: provider/model) |
| `agent` | ❌ | `build` | 使用的 Agent |
| `share` | ❌ | `true` | 是否分享会话 |
| `prompt` | ❌ | - | 自定义 prompt |
| `use_github_token` | ❌ | `false` | 使用 GITHUB_TOKEN 而非 OIDC |
| `mentions` | ❌ | `/opencode,/oc` | 触发短语 |
| `version` | ❌ | latest | 指定 opencode 版本 |
| `skip_cache` | ❌ | `false` | 跳过缓存 |
| `save_output` | ❌ | `true` | 保存 LLM 输出为 Artifact |
| `output_retention_days` | ❌ | `30` | Artifact 保留天数 |

## LLM 输出保存

默认情况下，所有 LLM 会话输出会自动保存为 GitHub Actions Artifact。

### 保存内容

每次运行后会保存以下内容到 `opencode-session-{run_id}-{attempt}` artifact：

```
opencode-output/
├── session.log          # 完整的终端输出日志
├── metadata.txt         # 运行元数据（时间、模型、仓库等）
└── sessions/            # OpenCode 会话数据（如果存在）
```

### 查看输出

1. 进入 GitHub Actions 运行页面
2. 在 "Artifacts" 部分下载 `opencode-session-*`
3. 解压查看 `session.log` 获取完整对话记录

### 禁用保存

```yaml
- uses: ./.github/actions/opencode
  with:
    model: deepseek/deepseek-reasoner
    save_output: "false"  # 禁用输出保存
```

### 自定义保留时间

```yaml
- uses: ./.github/actions/opencode
  with:
    model: deepseek/deepseek-reasoner
    output_retention_days: "7"  # 保留 7 天
```

## 环境变量

根据使用的模型提供商，需要设置对应的 API Key：

- `DEEPSEEK_API_KEY` - DeepSeek
- `ANTHROPIC_API_KEY` - Anthropic (Claude)
- `OPENAI_API_KEY` - OpenAI

## 扩展本地 Action

你可以修改 `action.yml` 来添加自定义逻辑，例如：

1. 在运行前执行预处理脚本
2. 添加自定义环境变量
3. 集成其他工具
4. 修改安装流程

## 调试

设置 `ACTIONS_STEP_DEBUG=true` 启用详细日志。
