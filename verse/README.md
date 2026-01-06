# Verse 代码库

本目录包含所有 Verse 语言的代码资源，以模块化、可复用的方式组织。

## 目录结构

```text
verse/
├── library/           # 可复用代码库（按功能域组织）
│   ├── math/          # 数学工具：向量、随机数、数学计算
│   ├── probability/   # 概率系统：随机分布、抽卡、掉落
│   ├── combat/        # 战斗计算：伤害、生命值计算
│   ├── events/        # 事件系统：交互、生命值、状态事件
│   ├── wrappers/      # 包装器：角色、NPC、宠物等包装类
│   └── data/          # 数据结构：管理器、实体、组件
│       ├── managers/  # 管理器：冷却、计时器
│       ├── entities/  # 游戏实体
│       └── components/# 组件：状态机、移动、攻击等
├── modules/           # 独立功能模块（按业务组织）
│   └── curve/         # 曲线构建模块
├── frameworks/        # 架构框架（未来扩展）
└── examples/          # 示例代码（未来扩展）
```

## 使用指南

### Library（可复用库）

`library/` 下的代码是通用的、可复用的功能实现，可以在任何项目中使用：

- **math/** - 基础数学工具，包含向量运算、随机数生成等
- **probability/** - 完整的概率系统，支持各种随机分布、抽卡系统、掉落表等
- **combat/** - 战斗相关计算，伤害计算、生命值管理等
- **events/** - 事件系统，定义各类游戏事件
- **wrappers/** - 对 UEFN 对象的封装，提供更易用的接口
- **data/** - 数据结构，包含管理器、实体和组件

### Modules（业务模块）

`modules/` 下是独立的功能模块，每个模块实现特定的游戏功能：

- **curve/** - 曲线构建系统，支持曲线采样、组合等

## 开发规范

1. **命名约定**：
   - 目录使用 camelCase（如 `probability`）
   - Verse 文件使用 PascalCase（如 `MathUtils.verse`）
   - 避免使用特殊字符（UEFN 编译器敏感）

2. **文档要求**：
   - 每个模块应有对应的 `_module.md` 功能文档（位于 `docs/modules/`）
   - 代码中包含清晰的注释说明

3. **代码验证**：
   - 所有 Verse 代码修改后必须通过远程编译验证
   - 使用 `.\tools\verseCompiler\client\compile.ps1 -Wait` 验证

## 相关文档

- [Verse 开发技能](../skills/programming/verseDev/)
- [模块功能文档](../docs/modules/)
