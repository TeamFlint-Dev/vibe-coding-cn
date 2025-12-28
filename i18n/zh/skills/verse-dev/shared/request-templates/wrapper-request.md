# Wrapper 请求模板

> 需求分析阶段识别出需要新 Wrapper 时使用此模板

---

## 请求信息

**请求ID**: WRAP-[序号]  
**请求时间**: [timestamp]  
**触发来源**: REQ-[关联的需求编号] / 需求描述摘要

---

## Wrapper 规格

### 基本信息

| 字段 | 值 |
|------|-----|
| Wrapper 名称 | `XXXWrapper` |
| 业务域 | [业务域描述，如：角色操作、玩家空间、UI交互] |
| 封装目标 | [主要封装的 UEFN 类型/模块] |

### digest 参考

| digest 文件 | 行号范围 | 主要内容 |
|-------------|----------|----------|
| Fortnite.digest.verse | L[起始]-L[结束] | [描述] |
| Verse.digest.verse | L[起始]-L[结束] | [描述] |
| UnrealEngine.digest.verse | L[起始]-L[结束] | [描述] |

---

## 需要封装的接口

### 接口清单

| 接口 | 方法 | 参数类型 | 返回类型 | 用途说明 |
|------|------|----------|----------|----------|
| [interface1] | [method1] | [types] | [return] | [purpose] |
| [interface1] | [method2] | [types] | [return] | [purpose] |
| [interface2] | [method1] | [types] | [return] | [purpose] |

### 接口实现方式说明

```markdown
- [主类型] 直接实现接口: [接口列表]
- 调用方式: 直接调用 / 需要 getter
- 特殊说明: [如有]
```

---

## 使用场景

### 触发此请求的需求

| 需求 ID | 需求名称 | 需要的方法 |
|---------|----------|------------|
| REQ-XXX | [需求名称] | Method1, Method2 |
| REQ-YYY | [需求名称] | Method3 |

### 预期调用示例

```verse
# Component 中的调用示例
Result := XXXWrapper.SomeMethod(param1, param2)
if Result.Success:
    # 处理成功情况
else:
    Log("操作失败: {Result.ErrorReason}")
```

---

## Wrapper 设计建议

### 结果结构

```verse
xxx_op_result<public> := struct<concrete>:
    Success<public>:logic
    ErrorReason<public>:string
    ActualValue<public>:float  # 或其他适当类型
```

### 功能分组

| 分组名称 | 包含方法 | 来源接口 |
|----------|----------|----------|
| [分组1] | Method1, Method2 | interface1 |
| [分组2] | Method3, Method4 | interface2 |

### 边界条件处理

| 条件 | 期望行为 |
|------|----------|
| 参数为空/无效 | 返回 {Success := false, ErrorReason := "..."} |
| 对象已销毁 | 返回 {Success := false, ErrorReason := "..."} |
| [其他边界条件] | [期望行为] |

---

## 验收条件

- [ ] 文件头包含 digest 来源和行号引用
- [ ] 所有类型与 digest 定义完全匹配（特别是 float vs int）
- [ ] 包含完整的边界检查和错误处理
- [ ] 使用正确的接口调用方式（直接调用 vs getter）
- [ ] 功能分组清晰，注释完整
- [ ] 已注册到 `@wrapper-registry.md`
- [ ] 通过 verse-code-auditor API 一致性检查

---

## 关联文件

- **API 映射参考**: [api-keyword-mapping.md](../../verse-wrappers/api-keyword-mapping.md)
- **代码模板参考**: [CharacterWrapper.verse](../code-library/Wrappers/CharacterWrapper.verse)
- **注册目标**: [@wrapper-registry.md](../memory-bank-template/@wrapper-registry.md)

---

*模板版本: 1.0 | 创建时间: 2025-12-28*
