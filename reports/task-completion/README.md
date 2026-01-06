# 任务完成报告库

本目录存储 AI Agent 完成任务后的反思报告，用于持续改进。

## 目录结构

```
reports/task-completion/
├── README.md           # 本文件
├── TEMPLATE.md         # 报告模板
└── YYYY-MM/            # 按月份归档
    └── YYYYMMDD-HHMMSS-{任务简述}.md
```

## 核心要求

**每次任务结束后必须生成报告**，核心是反思：

1. **我在这次任务中犯了哪些错误？**
   - 发生了什么
   - 为什么会发生
   - 下次如何避免

2. **如果重来一次，我会怎么做？**

3. **哪些 Skill/文档需要改进？**

## 报告命名规范

```
YYYYMMDD-HHMMSS-{任务简述}.md

示例：
20260107-143052-更新copilot-instructions.md
20260107-155023-创建Verse组件模块.md
```

## 如何使用报告

1. **定期回顾**：识别重复问题
2. **更新 Skill**：将改进建议转化为 Skill 更新
3. **完善检查清单**：将踩坑经验添加到 PREFLIGHT-CHECKLIST.md
