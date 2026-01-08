# 项目目录说明

本目录包含 UEFN/Verse 游戏开发的所有项目，每个项目都有独立的设计、架构和进度文档。

## 项目命名规范

### 目录命名

**所有项目目录必须使用驼峰式命名（camelCase）**

- ✅ `uefnResearch`
- ✅ `trophyFishing`
- ❌ `uefn-research`（避免短横线）
- ❌ `uefn研究`（避免中文目录名）

**原因**：

1. UEFN 编译器对特殊字符（如 `-`）敏感
2. 避免跨平台路径问题
3. 符合 JavaScript/TypeScript 变量命名习惯

### 显示名称

**每个项目通过 `project.json` 定义友好的显示名称**

项目的显示名称（displayName）可以使用中文或英文，用于文档、Issue 和用户界面。

示例：

- 目录名：`uefnResearch`
- 显示名：`uefn基础模块研究`

### 别名系统

**支持多种别名引用同一个项目**

通过 `PROJECT_MAPPING.json` 映射文件，可以使用多种名称引用项目：

```json
{
  "uefn研究": "uefnResearch",
  "uefn基础模块研究": "uefnResearch",
  "UEFN基础研究": "uefnResearch",
  "uefnResearch": "uefnResearch"
}
```

这样在 Issue、文档、Workflow 输入中都可以灵活使用。

## 项目元数据格式

每个项目目录下必须包含 `project.json` 文件：

```json
{
  "id": "projectId",
  "displayName": "项目显示名称",
  "aliases": ["别名1", "别名2"],
  "description": "项目简短描述",
  "status": "active|archived|planning",
  "tags": ["标签1", "标签2"],
  "created": "创建日期",
  "type": "game|research|tool"
}
```

### 字段说明

| 字段 | 必填 | 说明 |
|------|------|------|
| `id` | ✅ | 项目唯一标识符，必须与目录名一致 |
| `displayName` | ✅ | 用户友好的显示名称（可以是中文） |
| `aliases` | ✅ | 项目别名列表，支持多种引用方式 |
| `description` | ✅ | 简短描述（1-2 句话） |
| `status` | ✅ | 项目状态：`active`/`archived`/`planning` |
| `tags` | ⭕ | 标签列表，用于分类和搜索 |
| `created` | ⭕ | 创建日期 |
| `type` | ✅ | 项目类型：`game`/`research`/`tool` |

## 当前项目列表

| 目录名 | 显示名称 | 类型 | 状态 | 说明 |
|--------|---------|------|------|------|
| `uefnResearch` | **uefn基础模块研究** | 研究项目 | 🟢 Active | UEFN/Verse 基础技术研究 |
| `trophyFishing` | **Trophy Fishing** | 游戏项目 | 🟢 Active | 放置类钓鱼游戏 |

## 项目结构标准

每个项目目录必须包含以下标准结构：

```
projectName/
├── project.json              # 项目元数据（必需）
├── README.md                 # 项目概览（必需）
├── design/                   # 设计文档
│   ├── concept.md           # 概念设计
│   ├── systems.md           # 系统设计
│   ├── mechanics/           # 机制设计
│   └── ...
├── architecture/             # 技术架构
│   ├── tech-stack.md        # 技术栈
│   ├── implementation-plan.md  # 实施计划
│   └── ...
└── progress/                 # 进度管理
    └── status.md            # 当前状态
```

## 使用项目别名的场景

### 1. GitHub Issue

在 Issue 中可以使用任何别名引用项目：

```markdown
## 项目

uefn基础模块研究
```

或

```markdown
## 项目

uefnResearch
```

### 2. Workflow 输入

在 GitHub Actions Workflow 的输入参数中：

```yaml
project_name: "uefn基础模块研究"
```

或

```yaml
project_name: "uefnResearch"
```

都会正确映射到 `projects/uefnResearch/` 目录。

### 3. 文档引用

在文档中建议使用显示名称以提高可读性：

- ✅ 推荐：**uefn基础模块研究** 项目专注于...
- ⭕ 可以：`uefnResearch` 项目专注于...
- ❌ 避免：混用多种命名方式

## 创建新项目

### 步骤

1. **选择项目名称**
   - 选择一个驼峰式英文目录名（如 `myAwesomeGame`）
   - 确定一个友好的显示名称（如 "我的超棒游戏"）

2. **创建项目目录结构**

   ```bash
   mkdir -p projects/myAwesomeGame/{design,architecture,progress}
   ```

3. **创建 `project.json`**

   ```json
   {
     "id": "myAwesomeGame",
     "displayName": "我的超棒游戏",
     "aliases": ["myAwesomeGame", "my-awesome-game"],
     "description": "一个超棒的游戏",
     "status": "planning",
     "tags": ["game"],
     "created": "YYYY-MM-DD",
     "type": "game"
   }
   ```

4. **更新 `PROJECT_MAPPING.json`**

   添加新项目的映射关系。

5. **创建 README.md**

   参考现有项目的 README 格式。

6. **创建标准文档**
   - `design/concept.md`
   - `architecture/tech-stack.md`
   - `progress/status.md`

### 使用技能

建议使用 `skills/verseDev/verseProjectInit/` 技能自动化项目初始化流程。

## 项目状态定义

| 状态 | 说明 |
|------|------|
| `planning` | 规划阶段，正在进行需求和设计 |
| `active` | 活跃开发中 |
| `paused` | 暂停开发，但未归档 |
| `archived` | 已归档，不再活跃维护 |

## 项目类型定义

| 类型 | 说明 | 示例 |
|------|------|------|
| `game` | 游戏项目 | Trophy Fishing |
| `research` | 研究项目 | uefn基础模块研究 |
| `tool` | 工具项目 | 开发辅助工具 |
| `demo` | 演示项目 | 技术演示 |

## 相关文档

- [AGENTS.md](../AGENTS.md) - Agent 工作指南，包含项目命名章节
- [skills/verseDev/verseProjectInit/](../skills/verseDev/verseProjectInit/) - 项目初始化技能
- [根目录 README.md](../README.md) - 仓库整体说明

## 注意事项

### ⚠️ 不要重命名现有项目目录

一旦项目目录创建，**不要轻易重命名**，因为：

1. Git 历史记录会丢失上下文
2. 现有 Issue 和 PR 中的引用会失效
3. 可能有外部工具依赖该路径

如果必须重命名，请：

1. 创建一个 Issue 说明理由
2. 更新所有相关文档和映射
3. 通知团队成员

### 💡 优先使用显示名称

在面向用户的场景（Issue、文档、UI）中，优先使用 `displayName`：

- ✅ "uefn基础模块研究项目已完成第一阶段"
- ❌ "uefnResearch 项目已完成第一阶段"

在代码和技术场景中，使用目录名（`id`）：

- ✅ `cd projects/uefnResearch`
- ✅ `find projects/uefnResearch -name "*.md"`

---

*最后更新：2026-01-06*
