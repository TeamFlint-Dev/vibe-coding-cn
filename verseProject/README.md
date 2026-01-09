# Verse Project - VibeCodingCN

自包含的 Verse 代码编译环境，可用于本地或云端 Agent 进行代码分析。

## 目录结构

```
verseProject/
├── source/                    # Verse 源代码
│   ├── library/              # 可复用模块库
│   │   ├── dataComponents/   # 数据组件
│   │   ├── driverComponents/ # 驱动组件
│   │   ├── logicModules/     # 逻辑模块
│   │   └── sessions/         # 会话管理
│   ├── test/                 # 测试代码
│   └── export.verse          # 导出声明
├── digests/                   # API Digest 文件
│   ├── Verse.digest.verse    # Verse 核心 API
│   ├── UnrealEngine.digest.verse  # UE API
│   └── Fortnite.digest.verse # Fortnite API
├── bin/                       # VerseLspCE 二进制
│   ├── win64/                # Windows x64
│   └── linux/                # Linux x64
├── VibeCodingCN.vproject     # 项目配置
├── analyze.ps1               # Windows 分析脚本
├── analyze.sh                # Linux/macOS 分析脚本
└── README.md                 # 本文件
```

## 使用方法

### Windows

```powershell
cd verseProject
.\analyze.ps1
# 或指定输出格式
.\analyze.ps1 -Format json
```

### Linux/macOS

```bash
cd verseProject
chmod +x analyze.sh
./analyze.sh
# 或指定输出格式
./analyze.sh --format json
```

### 直接调用 VerseLspCE

```bash
# Windows
.\bin\win64\VerseLspCE-Win64-Shipping.exe --analyze VibeCodingCN.vproject --format agent

# Linux
./bin/linux/VerseLspCE-Linux-Shipping --analyze VibeCodingCN.vproject --format agent
```

## 输出格式

| 格式 | 说明 |
|------|------|
| `text` | 人类可读的文本格式 |
| `json` | 结构化 JSON（单个对象） |
| `jsonl` | JSON Lines（每行一个诊断） |
| `markdown` | Markdown 表格格式 |
| `agent` | 为 AI Agent 优化的格式（默认） |

## API 版本

- **Fortnite Version**: 3811
- **Verse Version**: 1

## 源代码模块

### logicModules
- **coreMathUtils**: 数学工具（向量、插值、几何等）
- **characterAndStateUtils**: 角色属性系统（RPG）
- **economyAndTradeUtils**: 经济系统
- **inventoryAndItemsUtils**: 物品和背包系统

## 添加新代码

1. 在 `source/library/` 下对应目录创建 `.verse` 文件
2. 运行分析脚本验证代码
3. 如有错误，根据输出修复

## 注意事项

- 所有路径为相对路径，可在任意位置运行
- Linux 二进制需要执行权限
- 分析只检查语法和类型，不执行代码
