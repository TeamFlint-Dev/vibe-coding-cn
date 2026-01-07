# Reference

本目录存放基础设施实现、部署脚本等参考代码，非 Agent 直接调用的工具。

## 目录结构

```
reference/
├── verseCompiler/       # Verse 远程编译系统实现
│   ├── server/          # 云服务器端（Flask API）
│   ├── client/          # 本地客户端（verse-build.js）
│   └── README.md        # 详细说明
└── scripts/             # 基础设施脚本
    ├── deploy-v2ray.sh  # V2Ray 部署脚本
    └── test-workflow.ps1
```

## 与上层 tools/ 的区别

| 目录 | 用途 | 调用者 |
|------|------|--------|
| `tools/` | Agent 可直接调用的工具 | AI Agent |
| `tools/reference/` | 基础设施实现、部署脚本 | 开发者/运维 |

> **Agent 工具入口**：见 [../AGENT-TOOLS.md](../AGENT-TOOLS.md)
