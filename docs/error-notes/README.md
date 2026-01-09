# 错误修复建议索引

## 错误分类

| 分类 | 错误码范围 | 文件 |
|------|-----------|------|
| Effect | 3512, 3565 | effect-errors.yaml |
| Type | 3509, 3510 | type-errors.yaml |
| Syntax | 3524, 3549, 3625 | syntax-errors.yaml |
| Identifier | 3506, 3588, 3532 | identifier-errors.yaml |
| Call | 3511 | call-errors.yaml |

## 错误码快速索引

| 错误码 | 简述 | 常见修复 |
|--------|------|---------|
| 3506 | Unknown member/identifier | 检查 API 文档，可能成员不存在 |
| 3509 | Parameter type mismatch | 检查函数签名，参数类型 |
| 3510 | Return type mismatch | 函数返回类型与声明不符 |
| 3511 | Wrong bracket type | failable 用 `[]`，普通用 `()` |
| 3512 | Effect mismatch | 添加正确的效果修饰符 |
| 3524 | For loop syntax | 使用 `for (X : Array)` |
| 3532 | Ambiguous definition | 重命名或使用完整路径 |
| 3549 | Cannot define expression | 检查左值是否可赋值 |
| 3565 | `<varies>` removed | 不使用 `<varies>` |
| 3588 | Ambiguous identifier | 使用完整路径引用 |
| 3625 | Default param needs `?` | 使用 `?Param:type = default` |

## 使用方法

1. 根据错误码找到对应分类文件
2. 查看详细的修复建议和示例
3. 如果发现新的修复模式，添加到对应文件
