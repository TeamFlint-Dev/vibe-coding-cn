# Wrapper 注册表

> 记录所有已创建的 Wrapper 及其 digest 引用，供 verse-digest-sync 联动使用

---

## 注册表

| Wrapper | 位置 | digest 参考 | 封装接口 | 创建原因 | 状态 |
|---------|------|-------------|----------|----------|------|
| CharacterWrapper | `code-library/Wrappers/CharacterWrapper.verse` | Fortnite L11777-12020 | damageable, healable, healthful, shieldable, positional | 角色伤害/治疗系统 | ✅ |
| PetWrapper | `code-library/Wrappers/PetWrapper.verse` | Fortnite (creative_prop, positional) | positional, creative_prop, fort_character | 宠物系统（跟随、行为、交互） | ✅ |
| SidekickWrapper | `code-library/Wrappers/SidekickWrapper.verse` | Fortnite L4247-4279 | equipped_sidekick_component, sidekick_component, showable | Sidekick 心情、反应、交互控制 | ✅ |

---

## 字段说明

| 字段 | 说明 |
|------|------|
| **Wrapper** | Wrapper 模块名称 |
| **位置** | 相对于 `shared/` 的文件路径 |
| **digest 参考** | 主要参考的 digest 文件和行号范围 |
| **封装接口** | 封装的 UEFN 接口列表 |
| **创建原因** | 触发创建的需求或功能描述 |
| **状态** | ✅ 已实现 / 🔄 更新中 / ⚠️ 需审计 |

---

## 状态说明

| 状态 | 含义 | 后续操作 |
|------|------|----------|
| ✅ | 已实现，与当前 digest 一致 | 无需操作 |
| 🔄 | digest 更新后正在适配中 | 等待完成 |
| ⚠️ | digest 更新后需要审计 | 运行 verse-code-auditor |

---

## digest 同步记录

### 最近同步

| 日期 | digest commit | 影响的 Wrapper | 操作 |
|------|---------------|----------------|------|
| 2025-12-30 | N/A | SidekickWrapper | 新增 Sidekick API 封装 |
| 2025-12-29 | N/A | PetWrapper | 新增宠物系统封装 |
| 2025-12-28 | `49242330...` | CharacterWrapper | 类型修正 (int→float) |

### 待处理更新

| Wrapper | 变更类型 | 详情 | 优先级 |
|---------|----------|------|--------|
| (暂无) | - | - | - |

---

## 维护说明

### 新增 Wrapper 时

1. 在注册表中添加新行
2. 填写完整的 digest 参考（文件+行号范围）
3. 标注创建原因（关联的 REQ-XXX 或 WRAP-XXX）
4. 状态设为 ✅

### digest 更新时

1. verse-digest-sync 检测到更新
2. 对照此表检查受影响的 Wrapper
3. 将受影响 Wrapper 状态改为 ⚠️
4. 运行审计，完成适配后改回 ✅
5. 记录到「digest 同步记录」

### 删除 Wrapper 时

1. 确认无依赖此 Wrapper 的 Component
2. 从注册表中移除对应行
3. 更新 api-keyword-mapping.md 中的状态

---

*最后更新: 2025-12-30*
