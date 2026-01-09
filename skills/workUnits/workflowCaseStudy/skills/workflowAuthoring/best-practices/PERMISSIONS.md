# 权限配置最佳实践

> **用途**: 工作流权限配置指南  
> **来源**: workflowAuthoring Skill

---

## 核心原则

### 最小权限原则

**默认只读，按需授权**

```yaml
# ✅ 推荐：默认只读
permissions:
  contents: read
  issues: read
```

```yaml
# ⚠️ 谨慎：需要写权限时
permissions:
  contents: write  # 明确说明为什么需要
```

---

## 常见场景权限配置

### 1. 纯分析工作流

```yaml
permissions:
  contents: read
  issues: read
  pull-requests: read
```

**场景**: 代码分析、质量检查、报告生成

### 2. Issue 管理工作流

```yaml
permissions:
  contents: read
  issues: write  # 创建/更新 Issue
```

**场景**: 任务分解、Bug 追踪、自动分类

### 3. PR 工作流

```yaml
permissions:
  contents: write      # 创建分支
  pull-requests: write # 创建 PR
```

**场景**: 自动修复、代码生成

### 4. Meta-Orchestrator

```yaml
permissions:
  contents: read
  issues: read
  actions: read  # 查询工作流运行状态
```

**场景**: 监控其他工作流健康状况

---

## 权限 vs Safe Outputs

### 理解区别

| 特性 | permissions | safe-outputs |
|------|-------------|--------------|
| 控制粒度 | 仓库级别 | 操作级别 |
| 数量限制 | 无 | 有 (max) |
| 自动过期 | 无 | 有 (expires) |
| 标签/前缀 | 无 | 有 |

### 推荐组合

```yaml
permissions:
  contents: read
  issues: read  # 只读权限

safe-outputs:
  create-issue:  # 通过 safe-outputs 控制写操作
    max: 5
    title-prefix: "[auto] "
```

**设计思路**: permissions 给只读，写操作通过 safe-outputs 严格控制

---

## 危险信号

### ❌ 避免的配置

```yaml
# 过于宽泛
permissions: write-all

# 不必要的 admin 权限
permissions:
  admin: write

# 未使用的写权限
permissions:
  packages: write  # 如果不发布 package
```

### ✅ 正确做法

```yaml
# 精确声明需要的权限
permissions:
  contents: read
  issues: write  # 只有真正需要时才给
```

---

## 权限审查清单

在配置权限前问自己：

- [ ] 这个工作流需要读取什么？
- [ ] 这个工作流需要写入什么？
- [ ] 能否用 safe-outputs 替代直接写权限？
- [ ] 是否有不需要的权限？
