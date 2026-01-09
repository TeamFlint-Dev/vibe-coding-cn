# 分析工具箱

> **用途**: 常用的工作流分析命令和检查清单  
> **来源**: workflowAnalyzer Skill

---

## 快速检查清单

```markdown
## Frontmatter 检查
- [ ] 触发器类型明确
- [ ] 权限最小化
- [ ] 超时设置合理
- [ ] safe-outputs 有 max 限制

## Prompt 检查
- [ ] 有明确的角色定义
- [ ] 有任务分阶段
- [ ] 有成功标准
- [ ] 有约束声明
```

---

## 分析命令

### 统计工作流行数

```bash
wc -l path/to/workflow.md
```

### 提取 Frontmatter

```bash
sed -n '/^---$/,/^---$/p' path/to/workflow.md
```

### 搜索 Handlebars 条件

```bash
grep -n "{{#if" path/to/workflow.md
```

### 搜索约束声明

```bash
grep -n "NEVER\|ALWAYS\|IMPORTANT\|MUST" path/to/workflow.md
```

### 统计 Phase 数量

```bash
grep -c "^### Phase" path/to/workflow.md
```

### 查找 safe-outputs 配置

```bash
grep -A 10 "safe-outputs:" path/to/workflow.md
```

---

## 复杂度评估

### 计算上下文分支数

```bash
# 统计主分支数（不计嵌套）
grep -c "^{{#if github\.event\." path/to/workflow.md
```

### 行数阈值

| 行数 | 复杂度 | 建议 |
|------|--------|------|
| < 100 | 简单 | 易于维护 |
| 100-300 | 中等 | 考虑模块化 |
| 300-500 | 复杂 | 建议拆分 |
| > 500 | 过于复杂 | 必须重构 |

---

## 模式识别命令

### 检查是否为 Slash Command

```bash
grep -q "slash_command" workflow.md && echo "是 Slash Command"
```

### 检查是否使用 MCP

```bash
grep -q "imports:" workflow.md && echo "使用 MCP 导入"
```

### 检查是否有 Memory

```bash
grep -q "cache-memory:" workflow.md && echo "启用 Memory"
```

---

## 批量分析

### 分析目录下所有工作流

```bash
for f in .github/workflows/*.md; do
  echo "=== $f ==="
  wc -l "$f"
  grep -c "^### Phase" "$f" || echo "0 Phases"
done
```

### 找出最长的工作流

```bash
wc -l .github/workflows/*.md | sort -rn | head -5
```

### 找出没有 safe-outputs 的工作流

```bash
for f in .github/workflows/*.md; do
  grep -q "safe-outputs:" "$f" || echo "$f 缺少 safe-outputs"
done
```
