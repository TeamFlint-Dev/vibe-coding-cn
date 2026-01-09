# Skills 维护重构指南

> **类型**: Work Unit 子 Skill - 维护技能  
> **职责**: 提供 Skills 重构的方法论和触发机制  
> **维护者**: `workflow-case-study` 工作流自动维护

---

## 📖 索引

| 类别 | 文件 | 说明 |
|------|------|------|
| **触发信号** | [triggers/SIGNALS.md](triggers/SIGNALS.md) | 强信号/弱信号判断标准 |
| **重构策略** | [strategies/](strategies/) | 垂直拆分、知识压缩、归档 |
| **模板** | [templates/](templates/) | PR 模板、效果评估 |

---

## 💡 启发式提示

### 需要重构吗？
- 单文件 > 500 行？→ **强信号，必须重构**
- 相同内容 > 3 处？→ **强信号，必须重构**
- 查找 > 2 分钟？→ **强信号，必须重构**
- 弱信号 >= 3 个？→ **建议重构**

### 选择哪种策略？
- 职责混乱？→ **垂直拆分** (`strategies/VERTICAL-SPLIT.md`)
- 内容冗余？→ **知识压缩** (`strategies/KNOWLEDGE-COMPRESSION.md`)
- 内容过时？→ **归档** (`strategies/ARCHIVE.md`)

---

## 🎯 How To Do

### 检测重构信号

1. 查阅 `triggers/SIGNALS.md` 了解信号标准
2. 运行检测命令：
   ```bash
   wc -l skills/*/SKILL.md
   ```
3. 强信号触发 → 必须重构；弱信号 >= 3 → 建议重构

### 执行重构

1. **选择策略** → 根据问题类型选择对应策略文件
2. **按步骤执行** → 每个策略文件有详细步骤
3. **创建 PR** → 使用 `templates/PR-TEMPLATE.md`
4. **评估效果** → 使用 `templates/EVALUATION.md`

### 重构 vs 调研决策

```
开始运行 → 检查重构信号？
  ├─ 强信号 → 进入重构模式 (Phase R)
  └─ 无强信号 → 进入调研模式 (Phase 0-4)
```

---

## 🔄 进化信号

### 添加新策略的信号
- 发现新的重构模式被多次使用
- 现有策略不适用于某类问题

### 更新触发标准的信号
- 阈值（如 500 行）被证明过高/过低
- 新类型的质量问题被发现

### 归档模板的信号
- 模板长期未使用
- 被更好的模板取代

---

## 📁 目录结构

```
skillsMaintenance/
├── SKILL.md                    # 本文件（骨架）
├── triggers/                   # 触发信号
│   └── SIGNALS.md              # 强信号/弱信号判断标准
├── strategies/                 # 重构策略
│   ├── VERTICAL-SPLIT.md       # 垂直拆分
│   ├── KNOWLEDGE-COMPRESSION.md # 知识压缩
│   └── ARCHIVE.md              # 归档陈旧内容
└── templates/                  # 模板
    ├── PR-TEMPLATE.md          # 重构 PR 模板
    └── EVALUATION.md           # 效果评估模板
```

---

## ✅ 最佳实践速查

### ✅ 应该做
- 渐进式重构：每次一个 Skill
- 保留历史：归档而非删除
- 更新索引：重构后立即更新
- 记录理由：PR 中说明原因

### ❌ 不应该做
- 过度拆分：几十个小文件
- 丢失信息：保留所有有价值内容
- 破坏引用：确保引用不失效
- 频繁重构：给 Skills 时间积累
