# 技术栈

> **项目**：uefn基础模块研究（uefnResearch）  
> **版本**：v1.0  
> **最后更新**：2026-01-06

---

## 开发环境

### 核心平台

| 组件 | 版本 | 说明 |
|------|------|------|
| **UEFN** | Latest | Unreal Editor for Fortnite |
| **Verse** | Latest | Verse 编程语言 |
| **Fortnite** | Latest | 运行时环境 |

### 开发工具

| 工具 | 用途 |
|------|------|
| **远程编译服务** | Verse 代码编译验证 |
| **Git** | 版本控制 |
| **Markdown** | 文档编写 |

---

## 架构模式

### 代码组织模式

遵循仓库的标准架构：

```text
uefn基础模块研究 (研究项目)
    ↓ 产出验证后的代码
verse/
├── library/           # 通用可复用库
│   ├── math/          # 数学工具
│   ├── probability/   # 概率系统
│   └── ...
└── modules/           # 独立功能模块
    ├── curve/         # 曲线系统
    └── ...
```

### 研究 → 代码库流程

```text
1. 在 uefn基础模块研究 项目中进行原型验证
   ↓
2. 代码通过编译和测试
   ↓
3. 整理到 verse/library/ 或 verse/modules/
   ↓
4. 编写使用文档
   ↓
5. 可被游戏项目复用
```

---

## 代码规范

### 文件命名

- **目录**：camelCase（如 `curveSystem`）
- **Verse 文件**：PascalCase（如 `CurveBuilder.verse`）
- **Markdown 文件**：kebab-case（如 `research-topics.md`）

### 代码风格

遵循 `skills/verseDev/` 中的规范：

- 使用英文命名（函数、变量、类型）
- 使用中文注释（说明复杂逻辑）
- 缩进：4 个空格
- 行宽：≤ 120 字符

### 文档要求

每个研究主题完成后，必须包含：

1. **能力边界文档**（`CAPABILITY-BOUNDARIES.md`）
   - 能做什么
   - 不能做什么
   - 限制是什么

2. **使用指南**（`README.md` 或 `_module.md`）
   - 快速开始
   - API 参考
   - 示例代码

3. **决策记录**（`DECISION-LOG.md`）
   - 为什么选择这个方案
   - 放弃了哪些替代方案
   - 踩坑记录

---

## 关键依赖

### Verse API

研究依赖的主要 API 领域：

| API 领域 | 用途 | 来源 |
|---------|------|------|
| **Verse.org/Math** | 数学计算 | 官方 API |
| **Verse.org/Random** | 随机数生成 | 官方 API |
| **UnrealEngine.org** | 引擎功能 | 官方 API |
| **Fortnite.org** | Fortnite 特定功能 | 官方 API |

### API 文档同步

使用 `verseDigestSync` 技能保持 API 摘要最新：

```text
skills/verseDev/shared/api-digests/
├── verse-digest.md
├── fortnite-digest.md
└── unrealengine-digest.md
```

---

## 验证机制

### 编译验证

**所有 Verse 代码必须通过远程编译验证**：

```powershell
# 在修改代码后运行
.\tools\verseCompiler\client\compile.ps1 -Wait
```

工作流程：

1. 代码提交到 Git 分支
2. 脚本发送请求到云端服务器
3. GitHub Actions 触发 Self-hosted Runner
4. Runner 连接本地 UEFN 编辑器编译
5. 结果返回，显示错误/警告

### 质量检查

```bash
# Markdown 文档检查
make lint
```

---

## 架构决策记录（ADR）

### ADR-001: 使用模块化架构

**背景**：研究成果需要被多个游戏项目复用

**决策**：将代码组织为独立的模块，每个模块解决单一领域问题

**影响**：

- ✅ 提高代码复用性
- ✅ 降低耦合度
- ⚠️ 需要维护模块间的依赖关系

---

### ADR-002: 原型优先策略

**背景**：UEFN API 能力边界不明确，需要验证可行性

**决策**：每个研究主题先编写最小化原型验证，再扩展

**影响**：

- ✅ 快速发现不可行方案
- ✅ 降低返工成本
- ⚠️ 原型代码需要重构才能进入代码库

---

### ADR-003: 文档驱动研究

**背景**：研究过程中的决策和踩坑容易被遗忘

**决策**：每个研究主题强制要求能力边界文档和决策记录

**影响**：

- ✅ 知识可追溯
- ✅ 避免重复踩坑
- ⚠️ 增加文档维护成本

---

## 相关技能

- [verseResearch](../../../skills/verseDev/verseResearch/) - 研究方法论
- [verseArchitectureSelector](../../../skills/verseDev/verseArchitectureSelector/) - 架构选型
- [verseCodeAuditor](../../../skills/verseDev/verseCodeAuditor/) - 代码审计
- [verseDigestSync](../../../skills/verseDev/verseDigestSync/) - API 文档同步

---

**最后更新**：2026-01-06
