# Data Components

> DLSD 架构 - Data 层

此目录存放 Data Component，负责：
- 数据管理和 CRUD 操作
- 调用 UEFN API
- 生命周期围绕数据维护

## 命名规范

- 类名：`xxx_data` (snake_case + `_data` 后缀)
- 文件名：`XxxData.verse` (PascalCase)

## 示例

```verse
health_data := class(component):
    var CurrentHealth<private>:int = 0
    @editable var MaxHealth:int = 100
    
    GetHealth():int = CurrentHealth
    SetHealth(Value:int):void = set CurrentHealth = Clamp(Value, 0, MaxHealth)
```

## 规则

- ✅ 可以持有 `var` 状态变量
- ✅ 可以调用 UEFN API
- ✅ 可以调用 Logic 模块
- ❌ 禁止包含业务流程逻辑
- ❌ 禁止直接调用其他 Data Component
