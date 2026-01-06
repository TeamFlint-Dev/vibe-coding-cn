# project-docs 通用模板

本目录包含 project-docs 的通用模板文件，可直接复制到任何项目中使用。

## 模板列表

| 文件 | 用途 | 必需 |
|------|------|------|
| [@game-design-document.md](@game-design-document.md) | 游戏/产品设计文档 | ✅ |
| [@tech-stack.md](@tech-stack.md) | 技术栈和约束 | ✅ |
| [@implementation-plan.md](@implementation-plan.md) | 实施计划（分步指令） | ✅ |
| [@architecture.md](@architecture.md) | 架构说明（文件职责） | ✅ |
| [@progress.md](@progress.md) | 进度追踪 | ✅ |

## 快速开始

### 1. 复制模板到项目

```bash
# 在你的项目根目录
mkdir project-docs
cp -r /path/to/templates/* project-docs/
```

### 2. 填充内容

按以下顺序填充：

1. **@game-design-document.md** - 先明确做什么
2. **@tech-stack.md** - 再确定用什么技术
3. **@implementation-plan.md** - 然后规划怎么做
4. **@architecture.md** - 随开发逐步填充
5. **@progress.md** - 随开发逐步记录

### 3. 设置 AI 规则

在项目根目录创建 `CLAUDE.md` 或 `AGENTS.md`，添加 Always 规则：

```markdown
# 重要提示（Always）：
# 写任何代码前必须完整阅读 project-docs/@architecture.md
# 写任何代码前必须完整阅读 project-docs/@game-design-document.md
# 每完成一个任务后，必须更新 project-docs/@architecture.md 和 @progress.md
```

## 命名约定

- 使用 `@` 前缀表示 project-docs 核心文件
- 功能扩展文件使用 `feature-*.md` 命名
- 保持小写字母和连字符

## 参考实例

- [UEFN 岛屿养成游戏 project-docs](../../../skills/uefn-island-game/project-docs/)
