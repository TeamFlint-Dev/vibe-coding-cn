# Driver/System Components

> DLSD 架构 - Driver 层

此目录存放 Driver/System Component，负责：
- 监听输入事件
- 管理 Session 生命周期
- 驱动时间片

## 命名规范

- 类名：`xxx_system_component` 或 `xxx_driver_component` (snake_case + 后缀)
- 文件名：`XxxSystemComponent.verse` 或 `XxxDriverComponent.verse` (PascalCase)

## 示例

```verse
fishing_system := class(component):
    var ActiveSession:?fishing_session = false
    
    OnBegin<override>()<suspends>:void =
        InputSystem.OnFishingKeyPressed.Subscribe(HandleInput)
    
    HandleInput(Player:player):void =
        if (not ActiveSession?):
            Session := fishing_session{...}
            set ActiveSession = option{Session}
            spawn{ Session.Run() }
```

## 规则

- ✅ 监听和分发输入事件
- ✅ 创建和销毁 Session
- ✅ 持有对 Data Component 的引用
- ❌ 禁止包含具体业务逻辑
- ❌ 禁止直接操作数据
