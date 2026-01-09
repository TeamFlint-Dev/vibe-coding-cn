# Repository Guidelines

本仓库是 **UEFN/Verse 游戏开发 Agent 工作站**。

## 核心范式

### Skills（研究） → 代码库（模块） → 项目（组装）

- **Skills**：技术选型、调研结论、架构研究。每次调研在前人结论上迭代，形成可追溯的知识链。
- **代码库**：经过验证的模块代码，可直接复用。
- **项目**：基于 Skills 的研究路径 + 代码库的模块，快速组装实现。

## 目录结构

```text
.
├── skills/                     # 技能库（研究/选型/架构）
│   ├── programming/            # 程序类
│   │   └── verseDev/           # Verse 开发（17个子技能）
│   └── design/                 # 设计类
│       └── gameDev/            # 游戏设计（10个子技能）
│
├── resources/
│   ├── documents/              # 方法论与文档
│   └── prompts/                # 提示词库
│
├── projects/                   # 游戏项目集合
├── external/                   # 第三方工具
├── tools/                      # Agent 可用工具（见 tools/AGENT-TOOLS.md）
├── pipelines/                  # 流水线定义
└── verse/                      # Verse 可复用代码库
```

---
---

## Verse 代码验证

**编写或修改 Verse 代码后，必须验证语法和类型正确性。**

### 使用本地分析工具（推荐）

```bash
# Linux/macOS/WSL
cd verseProject
./analyze.sh --format text

# Windows PowerShell
cd verseProject
.\analyze.ps1 -Format text
```

> **工具文档**：详细使用说明见 [verseProject/ANALYSIS-TOOL-REFERENCE.md](verseProject/ANALYSIS-TOOL-REFERENCE.md)

### 工作原理

1. VerseLspCE (Verse Language Server - Community Edition) 执行静态分析
2. 分析所有 `.verse` 文件的语法、类型和效果系统
3. 1-2 秒内返回结果（无需 UEFN 编辑器）
4. 输出格式：`VERSE_ANALYSIS:<文件数>:<错误数>:<警告数>`

### 输出示例

**✅ 成功（无错误）：**
```
VERSE_ANALYSIS:44:0:0
VERSE_ANALYSIS_END
```

**❌ 失败（有错误）：**
```
VERSE_ANALYSIS:44:2:0
path/to/file.verse:10:5:10:20:error:3588:Ambiguous identifier...
VERSE_ANALYSIS_END
```

### 注意事项

- ✅ **无需 UEFN 编辑器** - 纯命令行工具
- ✅ **快速反馈** - 1-2 秒完成分析
- ✅ **完整类型检查** - 包括效果系统验证
- ⚠️ **仅静态分析** - 不包含运行时行为测试

### 远程编译（已弃用）

~~`tools/Invoke-VerseRemoteCompile.ps1`~~ 已被本地分析工具取代。

---

## 项目命名规范

### 目录命名规则

**所有项目目录必须使用驼峰式命名（camelCase）**

- ✅ `uefnResearch`
- ✅ `trophyFishing`
- ❌ `uefn-research`（避免短横线）
- ❌ `uefn研究`（避免中文目录名）

**原因**：

1. UEFN 编译器对特殊字符（如 `-`）敏感
2. 避免跨平台路径问题
3. 符合 JavaScript/TypeScript 变量命名习惯

### 项目显示名称

**每个项目通过 `project.json` 定义友好的显示名称**

项目的显示名称（displayName）可以使用中文或英文，用于文档、Issue 和用户界面。

当前项目列表：

| 目录名 | 显示名称 | 类型 |
|--------|---------|------|
| `uefnResearch` | **uefn基础模块研究** | 研究项目 |
| `trophyFishing` | **Trophy Fishing** | 游戏项目 |

### 项目别名系统

**支持多种别名引用同一个项目**

通过 `projects/PROJECT_MAPPING.json` 映射文件，可以使用多种名称引用项目：

```json
{
  "uefn研究": "uefnResearch",
  "uefn基础模块研究": "uefnResearch",
  "UEFN基础研究": "uefnResearch",
  "uefnResearch": "uefnResearch"
}
```

在 Issue、文档、Workflow 输入中都可以灵活使用。

### 使用指南

**在文档和 Issue 中**：优先使用显示名称以提高可读性

- ✅ 推荐：**uefn基础模块研究** 项目专注于...
- ⭕ 可以：`uefnResearch` 项目专注于...

**在代码和技术场景中**：使用目录名（`id`）

- ✅ `cd projects/uefnResearch`
- ✅ `find projects/uefnResearch -name "*.md"`

**详细说明**：参见 [`projects/README.md`](./projects/README.md)

---

## 思维原则

### 认知谦逊

**你不知道的，比你以为知道的更重要。**

- 假设记忆可能过时或错误
- 先验证，再使用
- 不确定时，明确说"我需要先确认"

### 源头思维

**知识有层级：官方文档 > 代码仓库 > 你的推测。**

- 这个结论的依据是什么？
- 能指向具体的源头吗？
- 找不到源头，是否在凭空创造？

### 代码即真相

**文档中的代码必须引用代码仓库，不能手写。**

- 所有代码示例来自代码仓库的真实文件
- 引用时标注文件路径和版本
- 修改代码先改仓库，再更新文档引用

### 自验证

**写完代码，自己先跑一遍。**

- Verse 代码提交前运行远程编译验证
- 不要假设代码能跑——验证它
- 编译通过 ≠ 逻辑正确，但至少先过编译

### 读者视角

**文档是写给读者的，不是写给自己的。**

- 读者此刻需要知道什么？
- 什么信息是噪音？
- 这份文档能让读者直接行动吗？

### 失败敏感

**第一次反馈指出的问题，往往只是冰山一角。**

- 这个问题是否暴露了更深的误解？
- 其他地方是否有同类问题？
- 是在修补表面，还是在解决根源？

### 迭代意识

**研究是累积的，不是一次性的。**

- 在前人结论上扩展，而非推翻重来
- 标注与已有研究的关系
- 让后人能追溯决策链

### 错误即素材

**困难和错误值得被记录，它们是研究的起点。**

- 遇到困难或犯错时，创建 Issue 记录
- 描述现象、尝试过的路径、卡住的原因
- 错误的价值在于：下次不再踩同一个坑

---

## Commit 规范

格式：`feat|fix|docs|chore: scope – summary`

提交前：

1. Verse 代码运行远程编译验证
2. 新 Skill 包含完整的 `SKILL.md`

---

## Landing the Plane

**会话结束时，必须完成：**

### 1. 生成任务完成报告（强制）

**每次任务结束后必须生成报告**，保存到 `reports/task-completion/YYYY-MM/`：

```
reports/task-completion/YYYY-MM/YYYYMMDD-HHMMSS-{任务简述}.md
```

**核心要求：反思你在任务中犯的错误**

- 诚实列出每一个错误、失误、不符合预期的情况
- 分析为什么会发生
- 思考下次如何避免
- 指出哪些 Skill/文档需要改进

> **模板参考**: `reports/task-completion/TEMPLATE.md`

### 2. 其他必做事项

1. 为未完成工作创建 Issue
2. **为遇到的困难/错误创建 Issue**——它们值得研究
3. **必须推送到远程**：

```bash
git pull --rebase
git push
git status  # 必须显示 "up to date with origin"
```

**规则**：工作未 push 等于未完成。报告未生成等于任务未闭环。
