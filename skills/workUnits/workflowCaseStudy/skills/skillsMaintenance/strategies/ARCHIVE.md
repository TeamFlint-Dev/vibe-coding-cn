# 归档陈旧内容策略

> **用途**: 处理过时但有历史价值的内容  
> **来源**: skillsMaintenance Skill

---

## 适用场景

- 内容基于旧版本 API
- 已被新模式取代的旧模式
- 不再推荐的实践

---

## 操作步骤

### Step 1: 识别陈旧内容

- 基于旧版本 API 的模式
- 已被新模式取代的旧模式
- 不再推荐的实践
- 6 个月未被引用的内容

### Step 2: 创建归档目录

```bash
mkdir -p skills/[skill-name]/archived
```

### Step 3: 移动陈旧内容

```
skills/[skill-name]/
├── SKILL.md  (当前版本)
└── archived/
    ├── CHANGELOG.md  (归档原因说明)
    ├── v1.0-SKILL.md  (历史版本快照)
    └── deprecated-patterns.md  (已废弃模式)
```

### Step 4: 更新 SKILL.md

- 删除或移动陈旧章节
- 添加指向归档的链接（如果需要）
- 在 CHANGELOG.md 中说明归档原因

---

## CHANGELOG.md 模板

```markdown
# Skill 归档日志

## [日期] - 归档 [内容描述]

**归档原因**: 
- [原因 1]
- [原因 2]

**归档内容**:
- `deprecated-patterns.md`: [内容说明]
- `v1.0-SKILL.md`: [完整版本快照说明]

**影响**: 
- 当前 SKILL.md 从 X 行减少到 Y 行
- 归档内容仍可查阅，但不会干扰日常使用

---

## [更早日期] - 归档 [其他内容]
...
```

---

## 示例

**归档前**:
```
skills/workflowAnalyzer/
└── SKILL.md  (580 行，包含已废弃的 output-limiter 模式)
```

**归档后**:
```
skills/workflowAnalyzer/
├── SKILL.md  (320 行，移除废弃内容)
└── archived/
    ├── CHANGELOG.md
    └── deprecated-patterns.md  (output-limiter 模式详细说明)
```

---

## 优缺点

### ✅ 优点
- 保留历史内容，可追溯
- 主文件保持简洁
- 明确标注内容状态

### ❌ 缺点
- 增加维护复杂度
- 需要决策哪些内容应该归档
- 归档目录可能膨胀

---

## 归档判断标准

| 标准 | 归档 | 保留 |
|------|------|------|
| API 已废弃 | ✅ | |
| 6 个月未引用 | ✅ | |
| 有新模式替代 | ✅ | |
| 仍有使用价值 | | ✅ |
| 核心概念 | | ✅ |

---

## 检查清单

- [ ] 归档内容完整？
- [ ] CHANGELOG.md 说明清晰？
- [ ] 主文件链接更新？
- [ ] 无误删活跃内容？
