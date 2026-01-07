# Logic Modules

> DLSD 架构 - Logic 层

此目录存放 Logic Module，负责：
- 无状态纯函数
- 数学和算法计算
- 数据验证

## 命名规范

- 模块名：`xxx_logic` (snake_case + `_logic` 后缀)
- 文件名：`XxxLogic.verse` (PascalCase)

## 示例

```verse
damage_logic := module:
    CalculateDamage(BaseDamage:float, Armor:float):float =
        Max(0.0, BaseDamage - Armor)
```

## 规则

- ✅ 只包含纯函数
- ✅ 可被任何层调用
- ❌ 禁止持有 `var` 状态变量
- ❌ 禁止调用 UEFN API
- ❌ 禁止产生副作用
