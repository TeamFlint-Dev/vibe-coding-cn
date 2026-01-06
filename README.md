<!--
-------------------------------------------------------------------------------
  项目头部区域 (HEADER)
-------------------------------------------------------------------------------
-->
<p align="center">
  <img src="https://github.com/tukuaiai.png" alt="UEFN Verse 游戏开发 Agent" width="80px">
</p>

<div align="center">

# UEFN/Verse 游戏开发 Agent 工作站

**一个专注于 UEFN/Verse 游戏开发的 AI Agent 工作流系统**

---

<p>
  <a href="https://github.com/tukuaiai/vibe-coding-cn/actions"><img src="https://img.shields.io/github/actions/workflow/status/tukuaiai/vibe-coding-cn/main.yml?label=%E6%9E%84%E5%BB%BA%E7%8A%B6%E6%80%81&style=for-the-badge" alt="构建状态"></a>
  <a href="https://github.com/tukuaiai/vibe-coding-cn/releases"><img src="https://img.shields.io/github/v/release/tukuaiai/vibe-coding-cn?label=%E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC&style=for-the-badge" alt="最新版本"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/tukuaiai/vibe-coding-cn?label=%E8%AE%B8%E5%8F%AF%E8%AF%81&style=for-the-badge" alt="许可证"></a>
</p>

<p>
  <a href="./resources/prompts/"><img src="https://img.shields.io/badge/提示词-精选-purple?style=for-the-badge" alt="提示词精选"></a>
  <a href="./skills/"><img src="https://img.shields.io/badge/Skills-技能库-forestgreen?style=for-the-badge" alt="技能库"></a>
  <a href="./projects/"><img src="https://img.shields.io/badge/Projects-项目集-blue?style=for-the-badge" alt="游戏项目"></a>
</p>

</div>

---

## 🎮 概览

本仓库是一个专注于 **UEFN (Unreal Editor for Fortnite) / Verse** 游戏开发的 AI Agent 工作流系统。通过结构化的 **Skill（技能）** 和 **项目文档** 协作模式，帮助开发者高效地与 AI 结对编程，将游戏创意变为现实。

### 核心理念

- **Skill 驱动**：所有开发知识、流程、经验都封装为可复用的技能
- **项目上下文隔离**：不同游戏项目拥有独立的设计、架构、进度文档
- **驼峰命名**：目录采用驼峰式命名，避免 UEFN 编译器对特殊字符的敏感问题

## 📁 项目结构

```
.
├── skills/                         # 技能库（双层分类）
│   ├── programming/                # 程序类技能
│   │   ├── verseDev/               # Verse 开发核心技能（17个子技能）
│   │   ├── ghAgenticWorkflows/     # GitHub Agentic Workflows
│   │   ├── controlHub/             # 云服务器与 Webhook
│   │   └── ...                     # 其他编程技能
│   │
│   └── design/                     # 设计类技能
│       ├── gameDev/                # 游戏设计流程（10个子技能）
│       └── ...                     # 其他设计技能
│
├── resources/                      # 资源库
│   ├── documents/                  # 方法论与文档
│   │   ├── Methodology and Principles/   # 编程哲学与原则
│   │   ├── Templates and Resources/      # 模板与资源
│   │   └── Tutorials and Guides/         # 教程与指南
│   │
│   └── prompts/                    # 提示词库
│       ├── coding_prompts/         # 编程任务提示词
│       ├── system_prompts/         # 系统行为提示词
│       ├── user_prompts/           # 用户自定义提示词
│       └── meta_prompts/           # 元提示词
│
├── projects/                       # 游戏项目集合
│   └── trophyFishing/              # Trophy Fishing 项目
│       ├── design/                 # 游戏设计文档
│       ├── architecture/           # 技术架构文档
│       └── progress/               # 进度与日志
│
├── verse/                          # Verse 可复用代码库
│   ├── library/                    # 通用代码库
│   └── modules/                    # 功能模块
│
├── tools/                          # 开发工具
│   ├── verseCompiler/              # Verse 远程编译服务
│   └── scripts/                    # 实用脚本
│
├── external/                       # 第三方工具（不修改）
│
└── pipelines/                      # 流水线定义
```

## 🚀 快速开始

### 1. 了解技能体系

**Verse 开发核心技能** (`skills/verseDev/`):
- `verseOrchestrator` - 开发流程总控
- `verseArchitectureSelector` - 架构选型
- `verseComponent` - 组件开发
- `verseEventFlow` - 事件流设计
- `verseHelpers` - Helper 函数
- `verseProjectInit` - 新项目初始化
- ... 共 17 个子技能

**游戏设计流程技能** (`skills/design/gameDev/`)：
- `gameConceptDesigner` - 概念设计
- `gameMechanicsDesigner` - 机制设计
- `gameSystemDesigner` - 系统设计
- `gameEconomyDesigner` - 经济设计
- ... 共 10 个子技能

### 2. 开始新项目

使用 `verseProjectInit` 技能初始化新游戏项目：

1. 在 `projects/` 下创建项目目录（驼峰命名）
2. 建立标准目录结构（design/architecture/progress）
3. 填写项目基础文档

详见 [verseProjectInit SKILL.md](./skills/verseDev/verseProjectInit/SKILL.md)

### 3. 工作流程

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   读取 Skill    │ ──> │   读取项目文档   │ ──> │   执行开发任务   │
│  (获取能力知识)  │     │  (获取项目上下文) │     │   (生成代码)    │
└─────────────────┘     └─────────────────┘     └─────────────────┘
         │                                               │
         └─────────────────── 更新 ──────────────────────>│
                        项目文档
```

## 📚 核心资源

### 方法论文档

- [胶水编程 (Glue Coding)](./Core/documents/Methodology%20and%20Principles/gluecoding.md) - 核心开发哲学
- [编程之道](./Core/documents/Methodology%20and%20Principles/编程之道.md) - 工程规范
- [系统提示词构建原则](./Core/documents/Methodology%20and%20Principles/系统提示词构建原则.md) - Agent 提示词设计
- [Bot 设计模式](./Core/documents/Templates%20and%20Resources/bot-design-patterns.md) - Agent 行为设计参考

### Verse 开发资源

- [Verse API Digest](./skills/verseDev/shared/api-digests/) - API 摘要文档
- [SceneGraph 架构参考](./skills/verseDev/shared/references/) - 框架设计指南
- [架构合规检查清单](./skills/verseDev/shared/checklists/) - 代码审计工具

## 🔧 命名规范

本项目采用**驼峰式命名**规范（目录名），原因：
- UEFN 编译器对 `-` 等特殊字符敏感
- 避免控制台和构建过程中的潜在问题
- `.md` 文件名可保持原有命名方式

示例：
- ✅ `verseDev/verseComponent/`
- ✅ `gameDev/gameConceptDesigner/`
- ❌ `verse-dev/verse-component/`

## 🤝 参与贡献

欢迎贡献新的 Skill、改进现有文档或分享开发经验！

1. Fork 本仓库
2. 创建功能分支
3. 提交 Pull Request

请确保：
- 目录使用驼峰命名
- 新 Skill 包含完整的 `SKILL.md`
- 运行 `make lint` 验证 Markdown 格式

## 📞 联系方式

- Telegram 群组：[@glue_coding](https://t.me/glue_coding)
- GitHub Issues：[提交问题](https://github.com/tukuaiai/vibe-coding-cn/issues)

## 📄 许可证

本项目采用 [MIT 许可证](LICENSE)。
