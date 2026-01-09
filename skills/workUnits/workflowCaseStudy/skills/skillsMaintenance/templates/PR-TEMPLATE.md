# 重构 PR 模板

> **用途**: Skills 重构 PR 的标准模板  
> **来源**: skillsMaintenance Skill

---

## PR 标题格式

```
[skills-refactor] 重构 {Skill名称} - {策略名称}
```

**示例**:
- `[skills-refactor] 重构 workflowAnalyzer - 垂直拆分设计模式库`
- `[skills-refactor] 重构 workflowAuthoring - 知识压缩代码片段`
- `[skills-refactor] 归档 workflowAnalyzer - 废弃 v1.0 模式`

---

## PR 描述模板

```markdown
## 🔧 重构概要

- **重构目标**: skills/workUnits/workflowCaseStudy/skills/{skill-name}
- **重构策略**: {垂直拆分 | 知识压缩 | 归档陈旧内容}
- **触发信号**: {触发重构的具体信号}

## 📊 重构前后对比

| 指标 | 重构前 | 重构后 | 改进 |
|------|--------|--------|------|
| SKILL.md 行数 | {X} | {Y} | ↓{Z}% |
| 文件总数 | {A} | {B} | - |
| 查找时间（估计） | {M} 分钟 | {N} 秒 | ↓{P}% |

## 🗂️ 新结构

```
{skill-name}/
├── SKILL.md  (骨架)
├── {subdirectory-1}/
│   ├── INDEX.md
│   └── ...
├── {subdirectory-2}/
│   └── ...
└── ...
```

## ✅ 验证清单

- [ ] 所有链接已验证
- [ ] 索引文件完整
- [ ] 无内容丢失
- [ ] 文件结构清晰
- [ ] 编译/构建通过

## 📝 重构说明

{详细说明重构过程、移动的内容、新增的索引}

## 🔮 后续建议

{是否需要进一步重构其他 Skills？}
```

---

## 验证清单详细说明

### 所有链接已验证

```bash
# 检查 Markdown 链接
grep -r "\[.*\](.*\.md)" skills/{skill-name}/ | while read line; do
  # 验证链接目标存在
  ...
done
```

### 索引文件完整

确保每个子目录有 INDEX.md，且包含：
- 目录说明
- 文件列表
- 快速导航

### 无内容丢失

对比重构前后：
```bash
# 统计重构前总行数
wc -l SKILL.md.backup

# 统计重构后所有文件总行数
find . -name "*.md" -exec wc -l {} + | tail -1
```

### 文件结构清晰

- 目录命名使用 kebab-case
- 文件命名有意义
- 层级不超过 3 层
