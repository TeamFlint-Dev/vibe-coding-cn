---
name: verseWrappers
description: Wrapper 层 - 需求驱动的 UEFN API 封装，按业务域组织所有可用 API
version: 1.0.0
layer: 1.5
---

# Verse Wrappers

> **类型**: Layer 1.5 - Wrapper 层  
> **职责**: 需求驱动的 UEFN API 封装，将 digest 中的原子 API 包装成业务域操作

---

## When to Use This Skill

当需要：
- 封装 UEFN digest API 为统一接口
- 创建新的业务域 Wrapper
- 审计现有 Wrapper 与 digest 一致性
- 处理 digest 更新后的 Wrapper 适配

**输入来源**:
- 需求分析阶段识别的 `wrapper-request`
- `verseDigestSync` 触发的更新通知
- `@wrapper-registry.md` 中的注册信息

---

## 核心原则

### 1. 需求驱动创建【重要】

> ⚠️ Wrapper 不是自动生成的，必须基于真实业务需求创建

```
┌─────────────────────────────────────────────────────────────────┐
│                    Wrapper 创建原则                              │
├─────────────────────────────────────────────────────────────────┤
│ ✅ 需求驱动: 从业务需求出发，发掘所有可用 API                     │
│ ✅ 完整覆盖: 一个 Wrapper 包含该业务域的所有相关 API              │
│ ✅ 统一接口: 处理边界条件、类型转换、错误处理                     │
│ ✅ digest 校验: 必须与 api-digests 定义保持一致                  │
├─────────────────────────────────────────────────────────────────┤
│ ❌ 自动生成: 不根据 digest 自动生成 Wrapper                      │
│ ❌ 1:1 映射: 不是每个 API 一个 Wrapper                           │
│ ❌ 过早创建: 没有需求就不创建 Wrapper                            │
└─────────────────────────────────────────────────────────────────┘
```

### 2. 按业务域划分粒度

Wrapper 粒度**按需求划分**，可能跨多个 digest 模块：

| 业务域 | 对应 Wrapper | 封装的 digest 接口 |
|--------|--------------|-------------------|
| 角色操作 | `CharacterWrapper` | damageable, healable, healthful, shieldable, positional |
| 玩家空间 | `PlayspaceWrapper` | fort_playspace, player 相关 |
| 物理操作 | `PhysicsWrapper` | physics, transform 相关 |
| UI 交互 | `UIWrapper` | player_ui, widgets, hud 相关 |
| 设备操作 | `DeviceWrapper` | creative_device_base 及子类 |

### 3. 与 Helper 层的职责边界

```
┌─────────────────────────────────────────────────────────────────┐
│  Wrapper 层 (L1.5)                Helper 层 (L2)                 │
├─────────────────────────────────────────────────────────────────┤
│  ✅ 直接封装 digest API           ✅ 纯函数计算 (Calculator)     │
│  ✅ 1:1 对应底层方法              ✅ 数据校验 (Validator)        │
│  ✅ 处理类型转换                  ✅ 通用工具 (Utils)            │
│  ✅ 统一错误处理                  ✅ 组合调用 Wrapper            │
│  ✅ 边界条件检查                                                 │
├─────────────────────────────────────────────────────────────────┤
│  ❌ 业务逻辑计算                  ❌ 直接调用 digest API         │
│  ❌ 状态管理                      ❌ 持有状态变量                │
│  ❌ 事件派发                      ❌ 发送事件                    │
└─────────────────────────────────────────────────────────────────┘
```

**调用链**:
```
Component (L3) ──┬──▶ Calculator (L2) ──计算结果──▶ Component
                 │
                 └──▶ Wrapper (L1.5) ──▶ digest API
```

---

## Wrapper 创建流程

### 步骤 1: 需求分析

从业务需求出发，识别需要的 API 能力：

```markdown
需求: 实现角色伤害系统

需要的能力:
- 对角色造成伤害
- 治疗角色
- 获取/设置生命值
- 获取/设置护盾值
- 检查角色存活状态
```

### 步骤 2: API 发掘

在 digest 中搜索所有相关 API：

```bash
# 在 Fortnite.digest.verse 中搜索
grep -n "fort_character\|damageable\|healable\|healthful\|shieldable" Fortnite.digest.verse
```

**发掘清单**:
| 接口 | 方法 | 参数 | 返回值 | digest 行号 |
|------|------|------|--------|-------------|
| damageable | Damage | float | void | L11800 |
| damageable | Damage | damage_args | void | L11805 |
| healable | Heal | float | void | L11810 |
| healthful | GetHealth | - | float | L11815 |
| healthful | SetHealth | float | void | L11820 |
| ... | ... | ... | ... | ... |

### 步骤 3: 设计统一接口

设计 Wrapper 的公共接口：

```verse
# 操作结果结构（统一返回格式）
character_op_result<public> := struct<concrete>:
    Success<public>:logic
    ErrorReason<public>:string
    ActualValue<public>:float

# Wrapper 模块
CharacterWrapper<public> := module:
    # 伤害操作
    ApplyDamage<public>(Character:fort_character, Amount:float):character_op_result
    ApplyDamageWithArgs<public>(...):character_op_result
    
    # 治疗操作
    ApplyHeal<public>(Character:fort_character, Amount:float):character_op_result
    
    # 生命值操作
    GetHealth<public>(Character:fort_character):float
    SetHealth<public>(Character:fort_character, Value:float):character_op_result
    ...
```

### 步骤 4: 实现封装

遵循 Wrapper 代码模板实现：

```verse
ApplyDamage<public>(Character:fort_character, Amount:float):character_op_result =
    # 1. 边界检查
    if Amount <= 0.0:
        return character_op_result{Success := false, ErrorReason := "Amount must be positive"}
    
    # 2. 对象有效性检查
    if not IsCharacterValid(Character):
        return character_op_result{Success := false, ErrorReason := "Character invalid"}
    
    # 3. 调用真实 API（直接接口调用，非 getter）
    # digest: Fortnite.digest.verse L11800
    Character.Damage(Amount)
    
    # 4. 返回成功结果
    return character_op_result{Success := true, ActualValue := Amount}
```

### 步骤 5: 注册到 Registry

更新 `@wrapper-registry.md`：

```markdown
| Wrapper | digest 参考 | 封装接口 | 创建原因 |
|---------|-------------|----------|----------|
| CharacterWrapper | Fortnite L11777-12020 | damageable, healable, healthful, shieldable, positional | REQ-001 角色伤害系统 |
```

---

## Wrapper 代码模板

### 文件头规范

```verse
# [WrapperName] - UEFN [业务域] API 封装
# 版本: X.X
# 更新时间: YYYY-MM-DD
# 来源: [创建原因/需求编号]
#
# 设计目的:
# 1. [目的1]
# 2. [目的2]
#
# API 参考:
# - [主要类型] 实现接口: [接口列表]
# - 来源: shared/api-digests/[File].digest.verse L[行号]

using { /Verse.org/Simulation }
using { /Fortnite.com/Characters }  # 按需导入
# ... 其他必要导入
```

### 结果结构定义

```verse
# 操作结果结构（使用 float 与 UEFN API 类型一致）
[domain]_op_result<public> := struct<concrete>:
    Success<public>:logic           # 是否成功
    ErrorReason<public>:string      # 失败原因（成功时为空）
    ActualValue<public>:float       # 实际生效的数值（如适用）
```

### 功能分组规范

```verse
[WrapperName]<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # [功能分组名称]
    # API: [接口名].[方法名]([参数类型]):[返回类型]
    # digest: [文件名] L[行号]
    # ═══════════════════════════════════════════════════════
    
    [MethodName]<public>(Param1:Type1):result_type =
        # 1. 边界检查
        # 2. 对象有效性检查
        # 3. 调用真实 API（附带 digest 行号注释）
        # 4. 返回结果
```

---

## 与 verseDigestSync 联动

### 联动流程

```
verseDigestSync 检测到更新
    ↓
读取 @wrapper-registry.md
    ↓
对每个 Wrapper:
    ├── 获取其 digest 参考行号
    ├── 检查该行号范围的 API 是否变更
    │   ├── 方法签名变化
    │   ├── 参数类型变化
    │   ├── 返回值变化
    │   └── 方法删除
    └── 输出受影响 Wrapper 列表
    ↓
生成更新报告（参考 sync-update-template.md）
    ↓
开发者按需更新 Wrapper
```

### 同步更新模板

参考 [sync-update-template.md](./sync-update-template.md) 生成更新报告。

---

## 现有 Wrapper 清单

| Wrapper | 位置 | 封装接口 | 状态 |
|---------|------|----------|------|
| CharacterWrapper | `shared/code-library/Wrappers/CharacterWrapper.verse` | damageable, healable, healthful, shieldable, positional | ✅ 已实现 |

---

## API 依赖关键词映射

详见 [api-keyword-mapping.md](./api-keyword-mapping.md)。

需求分析阶段使用此映射表：
1. 扫描需求描述中的关键词
2. 映射到 UEFN API 领域
3. 检查对应 Wrapper 是否存在
4. 不存在则生成 `wrapper-request`

---

## Reference Files

- [api-keyword-mapping.md](./api-keyword-mapping.md) - API 依赖关键词映射表
- [sync-update-template.md](./sync-update-template.md) - digest 同步更新报告模板
- [@wrapper-registry.md](../shared/memory-bank-template/@wrapper-registry.md) - Wrapper 注册表模板
- [wrapper-request.md](../shared/request-templates/wrapper-request.md) - Wrapper 请求模板
- [CharacterWrapper.verse](../shared/code-library/Wrappers/CharacterWrapper.verse) - 参考实现

---

*最后更新: 2025-12-28*
