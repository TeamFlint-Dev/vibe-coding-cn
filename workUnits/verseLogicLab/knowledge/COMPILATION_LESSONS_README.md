# 编译错误教训记录说明
# Compilation Lessons Documentation

> **目的**: 忠实记录实际发生的编译错误、错误信息、上下文和解决方法。

## 三大文档的区别

| 文档 | 用途 | 内容性质 | 收录标准 |
|------|------|---------|----------|
| **COMPILATION_LESSONS.json** | 错误记录 ← **当前** | **客观事实** - 实际发生的错误 | ✅ 真实的编译错误<br>✅ 忠实记录错误信息<br>❌ 不添加推测性解释 |
| **CONJECTURES.md** | 猜想记录 | **待验证假设** - 基于推理的猜测 | ✅ 未验证的推测<br>✅ 单一信息源<br>❌ 不是已验证的事实 |
| **RISK-POINTS.md** | 风险点记录 | **已验证风险** - 真实存在的限制 | ✅ 有官方文档证据<br>✅ 可重现的风险<br>❌ 不是猜想或推测 |

## COMPILATION_LESSONS.json 记录原则

### ✅ 应该记录什么

1. **客观错误信息**: 编译器输出的准确错误文本
2. **错误上下文**: 什么代码导致了这个错误
3. **解决步骤**: 如何修复这个错误（事实性描述）
4. **预防建议**: 如何避免再次犯同样的错误

### ❌ 不应该记录什么

1. **推测性解释**: "可能是因为..." "这表示..." （除非有官方文档佐证）
2. **未验证的理论**: 关于效果系统、类型系统的猜测
3. **个人观点**: "我认为..." "应该是..." 

### 如果有推测怎么办？

**正确做法**: 
- 在 COMPILATION_LESSONS.json 中忠实记录错误和解决方法
- 在 `note` 字段中引用相关猜想：`"note": "关于效果系统的具体行为，参见 CONJECTURES.md 的 CONJ-002"`
- 在 CONJECTURES.md 中记录你的推测和假设

**错误做法**:
- ❌ 在 COMPILATION_LESSONS.json 中添加未验证的理论解释
- ❌ 将猜想当作事实写入 `context` 或 `solution`

## 记录格式

```json
{
  "id": "LESSON-XXX",
  "error": "编译器原始错误信息（准确复制）",
  "context": "什么代码导致错误（客观描述）",
  "solution": "如何修复（步骤化描述）",
  "prevention": "如何预防（建议）",
  "date": "YYYY-MM-DD",
  "tags": ["标签1", "标签2"],
  "note": "（可选）引用相关猜想或补充信息"
}
```

### 字段说明

- **error**: 完整的编译器错误文本，不修改不美化
- **context**: 什么情况下出现这个错误（代码片段、操作）
- **solution**: 实际执行的修复步骤（不是理论，是做了什么）
- **prevention**: 提醒未来如何避免（实用建议）
- **note**: 如果涉及理论或猜想，引用 CONJECTURES.md 或 ADR

## 示例对比

### ✅ 好的记录（客观）

```json
{
  "id": "LESSON-003",
  "error": "error:3512:This invocation calls a function that has the 'decides' effect, which is not allowed by its context",
  "context": "在 <computes> 函数中使用数组索引 Array[0]",
  "solution": "使用 if-then-else 结构：if: P0 := Array[0] then: UseP0 else: DefaultValue",
  "prevention": "访问数组元素时，使用 if 结构提供 failure context",
  "note": "关于 <decides> 与 <transacts> 的关系，参见 CONJECTURES.md 的 CONJ-002"
}
```

**好在哪里**:
- ✅ 错误信息准确
- ✅ 上下文清晰具体
- ✅ 解决方法可操作
- ✅ 理论部分引用猜想，不混入事实

### ❌ 不好的记录（混入推测）

```json
{
  "id": "LESSON-BAD",
  "error": "error:3512:...",
  "context": "因为 decides 效果需要 transacts 包装，所以在 computes 中失败了",
  "solution": "添加 transacts 效果，因为 Verse 设计上 decides 总是需要 transacts"
}
```

**问题在哪**:
- ❌ context 中包含未验证的理论（"需要 transacts 包装"）
- ❌ solution 中包含推测（"总是需要"）
- ❌ 没有区分事实和理论

## 与其他文档的协作

### 从错误到猜想

```
遇到错误 → COMPILATION_LESSONS.json 记录错误
         ↓
产生疑问 → CONJECTURES.md 记录猜想
         ↓
查阅文档/验证 → 更新猜想状态
         ↓
发现真实风险 → RISK-POINTS.md 记录风险
```

### 交叉引用

- COMPILATION_LESSONS.json 可以在 `note` 字段引用 CONJECTURES.md
- CONJECTURES.md 可以引用 COMPILATION_LESSONS 作为猜想的触发原因
- RISK-POINTS.md 可以引用 COMPILATION_LESSONS 作为风险证据

## 维护指南

### 添加新 Lesson

1. 遇到编译错误时，**立即**记录
2. 复制完整的错误信息（不要美化）
3. 描述导致错误的具体代码
4. 记录实际执行的修复步骤
5. 如果有理论推测，放入 CONJECTURES.md 并在 note 中引用

### 更新现有 Lesson

1. 如果发现更好的解决方法，更新 `solution`
2. 如果错误原因被官方文档确认，可以在 `note` 中添加文档引用
3. 保持 `error` 字段不变（历史记录）

### 清理和归档

- **不要删除**已有的 lessons，即使问题已解决
- 可以添加 `"status": "resolved"` 或 `"deprecated": true` 标记
- 旧的 lessons 是学习历史，有参考价值

---

**核心原则**: 忠实记录，不加推测。让事实说话，让猜想归位。
