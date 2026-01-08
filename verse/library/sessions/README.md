# Session Classes

> DLSD 架构 - Session 层

此目录存放 Session Class，负责：

- 持有业务上下文
- 调用 Data Component 接口
- 封装连续业务流程

## 命名规范

- 类名：`xxx_session` (snake_case + `_session` 后缀)
- 文件名：`XxxSession.verse` (PascalCase)

## 示例

```verse
fishing_session := class:
    PlayerData:player_data
    InventoryData:inventory_data
    
    StartFishing()<suspends>:fishing_result =
        PlayerData.SetState(player_state.Fishing)
        # 业务流程...
```

## 规则

- ✅ 可以持有临时状态
- ✅ 调用 Data Component 接口
- ✅ 调用 Logic Module
- ✅ 实现 `<suspends>` 异步流程
- ❌ 禁止直接调用 UEFN API
- ❌ 禁止作为 Component
