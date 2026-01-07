# Verse 代码库

本目录包含所有 Verse 语言的代码资源，基于 **DLSD 架构**（Data-Logic-Session-Driver）组织。

## 目录结构

```text
verse/
├── library/           # DLSD 代码库
│   ├── data/          # Data Components - 数据管理、CRUD、UEFN API
│   ├── logic/         # Logic Modules - 无状态纯函数、数学计算
│   ├── session/       # Session Classes - 业务上下文、连续流程
│   └── drivers/       # Driver/System Components - 输入监听、调度
├── templates/         # 代码模板（未来扩展）
└── _archived/         # 归档的旧代码（基于 Layer 1-5 架构）
```

## DLSD 架构概述

| 层 | 类型 | 后缀 | 职责 |
|----|------|------|------|
| **Data** | Component | `_data_component` | 数据管理、CRUD、UEFN API 调用 |
| **Logic** | Module | `_logic` | 无状态纯函数、数学/算法计算 |
| **Session** | Class | `_session` | 业务上下文、连续流程、事务安全 |
| **Driver** | Component | `_system_component` | 监听输入、管理 Session、驱动时间片 |

```
Driver ──► Session ──► Data ──► Logic
```

## 使用指南

### Data（数据层）

`library/data/` 存放 Data Component，负责运行时数据管理：

```verse
health_data_component := class(component):
    var CurrentHealth<private>:int = 0
    GetHealth():int = CurrentHealth
    SetHealth(Value:int):void = set CurrentHealth = Value
```

### Logic（逻辑层）

`library/logic/` 存放 Logic Module，无状态纯函数：

```verse
damage_logic := module:
    CalculateDamage(Base:float, Armor:float):float = Max(0.0, Base - Armor)
```

### Session（会话层）

`library/session/` 存放 Session Class，处理业务流程：

```verse
combat_session := class:
    HealthData:health_data_component
    ProcessDamage(Amount:int):void = HealthData.SetHealth(HealthData.GetHealth() - Amount)
```

### Driver（驱动层）

`library/drivers/` 存放 Driver Component，系统入口：

```verse
combat_system_component := class(component):
    HandleInput(Player:player):void = spawn{ combat_session{...}.Run() }
```

## 开发规范

1. **命名约定**：
   - 类型使用 snake_case + DLSD 后缀（`_data_component`, `_logic`, `_session`, `_system_component`）
   - 文件使用 PascalCase（如 `HealthDataComponent.verse`）
   - 避免使用特殊字符（UEFN 编译器敏感）

2. **文档要求**：
   - 每个模块应有对应的 `_module.md` 功能文档（位于 `docs/modules/`）
   - 代码中包含清晰的注释说明

3. **代码验证**：
   - 所有 Verse 代码修改后必须通过远程编译验证
   - 使用 `.\tools\verseCompiler\client\compile.ps1 -Wait` 验证

## 相关文档

- [Verse 开发技能](../skills/verseDev/)
- [模块功能文档](../docs/modules/)
