# H003: repo-memory 的 patterns/ 目录是知识沉淀的关键

> **状态**: investigating  
> **提出日期**: 2026-01-09  
> **来源**: audit-workflows 分析 (Run #26)

---

## 猜想陈述

在 repo-memory 中使用 `patterns/` 目录存储重复性问题模式（而非仅存储原始数据）能让工作流从失败中学习，避免重复性问题，实现知识的累积和沉淀。

---

## 支持证据

### 证据 1: audit-workflows 使用 patterns/

**来源**: `audit-workflows.md` Prompt

```markdown
- `audits/<date>.json` + `audits/index.json`
- `patterns/{errors,missing-tools,mcp-failures}.json`
- Compare with historical data
```

**分析**：按问题类型分类，便于后续查找和对比。

### 证据 2: metrics-collector 使用 metrics/ (Run #3)

**来源**: `metrics-collector.md` 分析

```yaml
repo-memory:
  branch-name: memory/meta-orchestrators
  file-glob: "metrics/**"
```

**分析**：metrics-collector 不使用 patterns/，而是使用 metrics/ 目录存储性能数据。这揭示了：
- **patterns/** 用于存储**问题模式**（错误类型、失败原因）
- **metrics/** 用于存储**性能数据**（运行次数、成功率、token 消耗）

**结论**：patterns/ 不是唯一的知识沉淀结构，而是「问题知识」的沉淀结构。

### 证据 3: smoke-detector 使用 patterns/ 和 investigations/ 目录

**来源**: `smoke-detector.md` 分析

```
- Store error patterns in `/tmp/gh-aw/cache-memory/patterns/`
- Store investigation database and knowledge patterns in `/tmp/gh-aw/cache-memory/investigations/` and `/tmp/gh-aw/cache-memory/patterns/`
```

**分析**：patterns/ 与 investigations/ 目录结合使用，形成「错误模式」+「调查记录」的双重知识沉淀。investigations/ 存储具体调查案例，patterns/ 存储抽象模式。

### 证据 4: ci-doctor 使用 patterns/ 目录

**来源**: `ci-doctor.md` 分析

```
- Store error patterns in `/tmp/memory/patterns/`
- Store investigation database and knowledge patterns in `/tmp/memory/investigations/` and `/tmp/memory/patterns/`
```

**分析**：与 smoke-detector 类似，验证了 patterns/ + investigations/ 的双目录模式在多个工作流中复用。

### 证据 5: lockfile-stats 的目录结构设计

**来源**: `lockfile-stats.md` 分析

```
├── patterns/
```

**分析**：lockfile-stats 设计了 patterns/ 目录但未明确用途，说明 patterns/ 是通用知识沉淀结构的一部分。

### 综合发现

1. **patterns/ 的普遍性**：至少 4 个工作流使用 patterns/ 目录（audit-workflows, smoke-detector, ci-doctor, lockfile-stats）
2. **与 investigations/ 的配对**：patterns/ 常与 investigations/ 配对，形成「抽象模式 + 具体案例」的知识体系
3. **知识类型分化**：
   - `patterns/`：错误模式、问题类型、通用解决方案
   - `investigations/`：具体调查记录、上下文、决策过程
   - `metrics/`：性能数据、趋势指标
   - `audits/`：审计记录、合规证据

---

## 验证计划

1. ~~扫描其他工作流的 repo-memory 结构~~ ✅ 发现 metrics/ 结构
2. 查看模式文件的读取逻辑
3. 评估实际效果
4. 🆕 探索是否还有其他知识类型目录（investigations/? logs/?）

---

## 相关猜想

- **H005**: repo-memory 目录结构反映知识类型（本猜想的精化版本）

---

*最后更新: 2026-01-12 (Run #19) - 新增证据 3-5*
