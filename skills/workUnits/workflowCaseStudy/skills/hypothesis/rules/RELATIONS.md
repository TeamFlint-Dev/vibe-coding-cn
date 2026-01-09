# 猜想关系类型

> **用途**: 定义猜想之间的关系，构建知识演进图谱

---

## 关系类型定义

### 1. refines (精化)

**含义**: H-B 是 H-A 的更精确版本

```
H-A: Campaign 模式适用于长期任务
  │
  └── refines → H-B: Campaign 模式适用于需要状态追踪的长期任务
```

**触发时机**:
- 发现边界条件后，需要限定适用范围
- 原猜想过于宽泛，需要精确化

**处理方式**:
- H-A 状态改为 `revised`
- H-B 继承 H-A 的证据链（适用的部分）

---

### 2. derives (衍生)

**含义**: H-B 基于 H-A 的结论而产生

```
H-A: Campaign 模式的核心价值是 KPI 追踪
  │
  └── derives → H-B: 没有 KPI 的 Campaign 等于没有方向盘
```

**触发时机**:
- 验证 H-A 过程中产生新的洞察
- H-A 证实后，自然推导出新假设

**处理方式**:
- H-A 和 H-B 独立验证
- H-A 如果被证伪，H-B 需要重新评估

---

### 3. contradicts (矛盾)

**含义**: H-A 和 H-B 不能同时为真

```
H-A: 所有工作流都应该使用 safe-outputs
  │
  └── contradicts → H-B: 内部工具类工作流不需要 safe-outputs
```

**触发时机**:
- 发现两个猜想逻辑上互斥
- 需要二选一

**处理方式**:
- 优先验证哪个更容易证伪
- 一个证实 → 另一个自动证伪
- 可能两个都需要修正（存在第三种情况）

---

### 4. supports (互相支持)

**含义**: H-A 如果成立，增强 H-B 的可信度

```
H-A: Meta-Orchestrator 需要定时运行
  │
  └── supports → H-B: 事件驱动不适合 Meta-Orchestrator
```

**触发时机**:
- 两个猜想指向同一个底层机制
- 验证一个有助于理解另一个

**处理方式**:
- 并行验证
- 共享相关证据

---

### 5. subsumes (包含)

**含义**: H-A 包含 H-B 作为特例

```
H-A: 所有写操作都应该通过 safe-outputs
  │
  └── subsumes → H-B: create-issue 应该通过 safe-outputs
```

**触发时机**:
- H-B 是 H-A 的具体实例
- 验证 H-B 有助于验证 H-A

**处理方式**:
- H-B 的证据可以作为 H-A 的证据
- H-A 证伪不影响 H-B（可能只是范围问题）
- H-B 证伪则 H-A 需要修正

---

## 关系图谱示例

```
[H001] Campaign 适用于长期任务
   │
   ├── refines ──→ [H002] Campaign 适用于需要状态追踪的长期任务
   │                  │
   │                  └── derives ──→ [H005] 无状态长期任务可用简单定时器
   │
   ├── derives ──→ [H003] Campaign 的 KPI 机制是核心价值
   │                  │
   │                  └── derives ──→ [H006] 没有 KPI 的 Campaign 等于没有方向盘
   │
   └── subsumes ─→ [H007] discussion-task-mining 应该使用 Campaign

[H004] Meta-Orchestrator 应该定时运行 (独立)
   │
   └── contradicts → [H008] Meta-Orchestrator 应该事件驱动
```

---

## 关系维护规则

### 添加关系

1. 在两个猜想文件中都记录关系
2. 使用一致的关系类型

### 关系传递

| 关系 | 是否传递 | 说明 |
|------|----------|------|
| refines | 否 | H-C refines H-B, H-B refines H-A ≠ H-C refines H-A |
| derives | 是 | 衍生链可以追溯 |
| contradicts | 否 | 矛盾是成对的 |
| supports | 是 | 支持关系可以传递 |
| subsumes | 是 | 包含关系可以传递 |

### 状态影响

| 关系 | A 证实 | A 证伪 |
|------|--------|--------|
| A refines B | B 标记 revised | 无影响 |
| A derives B | 无直接影响 | A 需重新评估 |
| A contradicts B | B 证伪 | 无直接影响 |
| A supports B | 增强 B 可信度 | 无直接影响 |
| A subsumes B | 无直接影响 | A 需修正 |
