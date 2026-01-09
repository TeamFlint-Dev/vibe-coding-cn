# Workflow Analyzer Skill

> **用途**: 分析 GitHub Agentic Workflows 的方法论和设计模式识别  
> **阅读时机**: Phase 2（分析）开始时  
> **行数目标**: 骨架文件，详细内容在子目录

---

## 📖 索引

### 分析框架

| 文件 | 说明 |
|------|------|
| [framework/FRONTMATTER-ANALYSIS.md](./framework/FRONTMATTER-ANALYSIS.md) | Frontmatter 配置分析指南 |
| [framework/PROMPT-ANALYSIS.md](./framework/PROMPT-ANALYSIS.md) | Prompt 设计分析指南 |
| [framework/TOOLS.md](./framework/TOOLS.md) | 分析工具箱（命令、检查清单） |

### 设计模式库

| 分类 | 文件 | 说明 |
|------|------|------|
| 基础模式 | [patterns/BASIC.md](./patterns/BASIC.md) | 触发器、权限、输出等基础模式 |
| 协调模式 | [patterns/COORDINATION.md](./patterns/COORDINATION.md) | 工作流间协调、编排模式 |
| 安全模式 | [patterns/SECURITY.md](./patterns/SECURITY.md) | 权限、约束、安全边界 |
| 用户体验 | [patterns/UX.md](./patterns/UX.md) | 交互、反馈、期望管理 |
| 数据管理 | [patterns/DATA.md](./patterns/DATA.md) | 状态、记忆、知识积累 |
| 元编程 | [patterns/META.md](./patterns/META.md) | 监控工作流、Campaign 管理 |

**模式索引**: [patterns/INDEX.md](./patterns/INDEX.md) - 按场景、复杂度查找模式

### 辅助文档

| 文件 | 说明 |
|------|------|
| [CAPABILITY-BOUNDARIES.md](./CAPABILITY-BOUNDARIES.md) | 分析能力边界 |
| [FAILURE-CASES.md](./FAILURE-CASES.md) | 分析中遇到的困难 |
| [PREFLIGHT-CHECKLIST.md](./PREFLIGHT-CHECKLIST.md) | 分析前检查清单 |

---

## 💡 启发式提示

分析工作流时，问自己这些问题：

### 配置层面
1. **权限够小吗？** 只请求实际需要的权限了吗？
2. **超时合理吗？** 匹配任务复杂度吗？
3. **输出受控吗？** safe-outputs 有 max 限制吗？

### 设计层面
1. **我见过这个模式吗？** 查阅模式库确认
2. **这是新模式吗？** 如果是，记录到模式库
3. **为什么这样设计？** 理解设计意图

### 质量层面
1. **Prompt 清晰吗？** 角色定义、Phase 划分、约束声明
2. **可维护吗？** 行数 < 300？上下文分支 ≤ 2？
3. **可复用吗？** 有哪些模式可以提取？

---

## 🎯 How To Do

### 分析一个工作流

1. **读取配置** → 参考 [FRONTMATTER-ANALYSIS.md](./framework/FRONTMATTER-ANALYSIS.md)
   - 检查触发器、权限、超时、safe-outputs
   - 评估配置质量（⭐/⭐⭐/⭐⭐⭐）

2. **分析 Prompt** → 参考 [PROMPT-ANALYSIS.md](./framework/PROMPT-ANALYSIS.md)
   - 识别角色定义、Phase 划分、约束声明
   - 评估 Prompt 质量

3. **识别模式** → 参考 [patterns/INDEX.md](./patterns/INDEX.md)
   - 对照模式库识别已知模式
   - 发现新模式时记录特征

4. **形成洞察**
   - 总结设计亮点和问题
   - 提出改进建议

### 发现新模式

1. 识别重复出现的设计决策
2. 提取识别特征、设计意图、典型案例
3. 归类到合适的模式文件（BASIC/COORDINATION/SECURITY/UX/DATA/META）
4. 更新 INDEX.md 的快速查找表

---

## 🔄 进化信号

| 观察到的信号 | 行动 |
|-------------|------|
| 发现新的设计模式 | 添加到对应的 patterns/*.md 文件 |
| 分析框架不够用 | 扩展 framework/*.md 文件 |
| 分析命令缺失 | 添加到 TOOLS.md |
| 遇到分析困难 | 记录到 FAILURE-CASES.md |

---

## 📚 相关文档

- [workflowAuthoring Skill](../workflowAuthoring/SKILL.md) - 如何编写工作流
- [父级 SKILL](../../SKILL.md) - 工作单元概览
