# Control Hub（中控服务器）

中控服务器技能 - GitHub 事件中转、PR 自动构建、Copilot 修复、多账号管理。

## 文档

| 文档 | 说明 |
|------|------|
| [SKILL.md](SKILL.md) | 完整技能文档（架构、模块、配置） |
| [quick-start.md](quick-start.md) | 5 分钟快速部署指南 |

## 代码位置

实现代码位于 `scripts/webhook-server/`：

```
scripts/webhook-server/
├── webhook_server.py     # 主服务
├── state_store.py        # 状态管理
├── account_manager.py    # 账号轮换
├── github_client.py      # GitHub API
├── decision_engine.py    # 决策引擎
└── .env.example          # 配置模板
```

## 核心功能

- ✅ 接收 GitHub Webhook，触发 repository_dispatch
- ✅ 接收 Actions 回调，根据结果决策
- ✅ 构建失败自动 @copilot 请求修复
- ✅ 多账号 PAT 轮换，分摊额度
- ✅ 5 次失败后升级给人类
- ✅ 内存状态管理，追踪任务生命周期
