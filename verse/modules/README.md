# Verse 功能模块

本目录包含按业务组织的独立功能模块，每个模块实现特定的游戏功能。

## 模块列表

### curve/ - 曲线构建系统
完整的曲线构建和采样系统，支持多种曲线类型和组合方式。

**文件清单**（7个文件）：
- `curve_base.verse` - 曲线基础定义
- `curve_builder.verse` - 曲线构建器
- `curve_composition.verse` - 曲线组合
- `curve_sampler.verse` - 曲线采样器
- `curve_sampler_demo.verse` - 采样器演示
- `curve_builder_demo.verse` - 构建器演示
- `curve_sampler_tests.verse` - 采样器测试

**功能特性**：
- 支持多种曲线类型（线性、二次、三次贝塞尔等）
- 曲线组合和链接
- 高精度采样
- 完整的测试覆盖

**使用场景**：
- 角色移动路径
- 动画曲线
- 数值变化曲线（如伤害衰减）
- UI 动画

**相关文档**：`docs/modules/curve_module.md`（待创建）

## 添加新模块

创建新的功能模块时：

1. **目录结构**：
   ```
   verse/modules/[moduleName]/
   ├── [核心文件].verse
   ├── [子系统].verse
   ├── [demo].verse（可选）
   └── [tests].verse（可选）
   ```

2. **命名规范**：
   - 模块目录使用 camelCase
   - 文件名使用 snake_case 或 PascalCase
   - 保持命名一致性

3. **文档要求**：
   - 在 `docs/modules/` 创建对应的 `[moduleName]_module.md`
   - 包含功能说明、API 文档、使用示例

4. **代码规范**：
   - 模块应该自包含，最小化外部依赖
   - 可以依赖 `verse/library/` 中的工具
   - 提供 demo 和测试文件

## 模块 vs 库的区别

| 特征 | library（库） | modules（模块） |
|------|--------------|----------------|
| 组织方式 | 按功能域 | 按业务功能 |
| 粒度 | 细粒度工具函数 | 完整的功能系统 |
| 复用性 | 通用可复用 | 特定场景复用 |
| 依赖 | 最小依赖 | 可依赖 library |
| 示例 | MathUtils | CurveBuilder |

**选择指南**：
- 通用的、原子化的工具 → `library/`
- 完整的、业务相关的功能 → `modules/`
