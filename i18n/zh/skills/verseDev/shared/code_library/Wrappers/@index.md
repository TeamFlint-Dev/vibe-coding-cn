# Wrappers 模块索引

> Wrapper 层 (L1.5) - UEFN API 封装模块

---

## 概述

Wrapper 层负责将 UEFN digest API 封装为统一、安全的接口，供 Helper 层和 Component 层调用。

**设计原则**:
- 需求驱动创建
- 按业务域划分
- 完整边界处理
- digest 一致性校验

---

## 模块清单

| 模块 | 业务域 | 封装接口 | digest 参考 | 状态 |
|------|--------|----------|-------------|------|
| [CharacterWrapper](./CharacterWrapper.verse) | 角色操作 | damageable, healable, healthful, shieldable, positional | Fortnite L11777-12020 | ✅ |
| [PetWrapper](./PetWrapper.verse) | 宠物系统 | positional, creative_prop, fort_character | Fortnite (creative_prop, positional) | ✅ |
| [SidekickWrapper](./SidekickWrapper.verse) | Sidekick 系统 | equipped_sidekick_component, sidekick_component, showable | Fortnite L4247-4279 | ✅ |
| [VectorWrapper](./VectorWrapper.verse) | 向量操作 | Verse.vector3, UnrealEngine.vector3 | Verse/UnrealEngine SpatialMath | ✅ |

---

## 模块详情

### CharacterWrapper

**职责**: 封装 `fort_character` 相关的所有 API 操作

**功能分组**:

| 分组 | 方法 | 来源接口 |
|------|------|----------|
| 伤害操作 | ApplyDamage, ApplyDamageWithArgs | damageable |
| 治疗操作 | ApplyHeal | healable |
| 生命值操作 | GetHealth, SetHealth, GetMaxHealth, GetHealthPercent | healthful |
| 护盾操作 | GetShield, SetShield, GetMaxShield | shieldable |
| 状态判定 | IsCharacterValid, IsAlive, IsFullHealth, HasShield, IsDownButNotOut | 组合查询 |
| 位置移动 | GetPosition, GetRotation, TeleportTo, GetViewRotation, GetViewLocation | positional, fort_character |
| 物理操作 | GetLinearVelocity, SetLinearVelocity, ApplyLinearImpulse, GetMass | 物理接口 |
| 控制状态 | SetVulnerability, IsVulnerable, Show, Hide, PutInStasis, ReleaseFromStasis | 控制接口 |

**调用示例**:
```verse
# 在 Component 中调用
Result := CharacterWrapper.ApplyDamage(TargetCharacter, 50.0)
if Result.Success:
    Log("造成了 {Result.ActualValue} 点伤害")
else:
    Log("伤害失败: {Result.ErrorReason}")
```

### PetWrapper

**职责**: 封装宠物系统相关的所有 API 操作

**功能分组**:

| 分组 | 方法 | 来源接口 |
|------|------|----------|
| 生成管理 | SpawnPetAtLocation, DespawnPet | creative_prop, creative_device |
| 位置跟随 | GetPetPosition, TeleportPetTo, CalculateDistanceToOwner, MoveTowardsPosition | positional |
| 行为控制 | SetPetVisibility, PlayPetAnimation | creative_prop, fort_character |
| 玩家交互 | IsPlayerInInteractionRange, GetRotationTowardsPlayer | 组合查询 |
| 信息查询 | GetPetInfo | 状态聚合 |

**调用示例**:
```verse
# 在 Component 中调用
Result := PetWrapper.SpawnPetAtLocation(SpawnPos, SpawnRot)
if Result.Success:
    Distance := PetWrapper.CalculateDistanceToOwner(PetEntity, OwnerPos)
    Log("宠物已生成，距离主人: {Distance}")
```

### SidekickWrapper

**职责**: 封装 `equipped_sidekick_component` 相关的所有 API 操作

**功能分组**:

| 分组 | 方法 | 来源接口 |
|------|------|----------|
| 心情操作 | GetMood, SetMoodOverride, GetMoodInfo, ClearMoodOverride | sidekick_component |
| 反应播放 | PlayReaction | sidekick_component |
| 事件监听 | GetChangeMoodEvent, GetStartPlayReactionEvent, GetStopPlayReactionEvent | sidekick_component |
| 可见性控制 | SetVisibility, GetVisibility, ShowSidekick, HideSidekick | showable |
| 行为开关 | EnableAutomaticReactions, EnablePlayerInteraction, IsAutomaticReactionsEnabled, IsPlayerInteractionEnabled | equipped_sidekick_component |
| 所有者查询 | GetOwningAgent | equipped_sidekick_component |
| 状态查询 | IsValidAndEquipped, IsVisible, IsInMood | 组合查询 |

**调用示例**:
```verse
# 在 Component 中调用
# 设置 Sidekick 心情为 Combat
Result := SidekickWrapper.SetMoodOverride(Sidekick, option{sidekick_mood.Combat})
if Result.Success:
    Log("Sidekick 心情已锁定为战斗模式")

# 播放 Happy 反应
ReactionResult := SidekickWrapper.PlayReaction(Sidekick, sidekick_reaction.Happy)
if ReactionResult.Success:
    Log("Sidekick 正在播放 Happy 反应")
```

### VectorWrapper

**职责**: 统一封装 Verse 和 UnrealEngine 两种 vector3 类型，提供一致的向量操作 API

**功能分组**:

| 分组     | 方法                                      | 说明                          |
|----------|------------------------------------------|------------------------------|
| 类型转换 | VerseToUE, UEToVerse                     | Verse/UE vector3 互转         |
| 向量常量 | Zero, One, Forward, Right, Up 等         | 预定义方向向量                 |
| 基础运算 | Add, Subtract, Multiply, Divide 等       | 加减乘除运算                   |
| 高级运算 | Dot, Cross, Normalize, Length 等         | 点积、叉积、归一化、长度       |
| 查询比较 | Distance, IsInRange, Direction 等        | 距离、方向、相等判断           |
| 插值限制 | Lerp, Clamp, ClampLength                 | 线性插值、分量/长度限制        |
| 坐标转换 | WorldToEditor, EditorToWorld             | 世界坐标与编辑器坐标互转       |
| 工具函数 | MaxComponent, MinComponent, Abs, Negate  | 最大/最小分量、绝对值、取反    |

**调用示例**:

```verse
# 在 Component 中调用
# 向量加法
V1 := vector3{X := 1.0, Y := 2.0, Z := 3.0}
V2 := vector3{X := 4.0, Y := 5.0, Z := 6.0}
AddResult := VectorWrapper.Add(V1, V2)
if AddResult.Success:
    Log("结果向量: ({AddResult.ResultVector.X}, {AddResult.ResultVector.Y}, {AddResult.ResultVector.Z})")

# 归一化向量
NormResult := VectorWrapper.Normalize(V1)
if NormResult.Success:
    Log("归一化成功")
else:
    Log("归一化失败: {NormResult.ErrorReason}")

# 计算距离
DistResult := VectorWrapper.Distance(V1, V2)
if DistResult.Success:
    Log("距离: {DistResult.ResultValue}")

# 类型转换
VerseVec := vector3{Forward := 1.0, Left := 0.0, Up := 0.0}
UEVec := VectorWrapper.VerseToUE(VerseVec)
Log("UE向量: ({UEVec.X}, {UEVec.Y}, {UEVec.Z})")
```
---

## 待创建 Wrapper

参考 [api-keyword-mapping.md](../../verse-wrappers/api-keyword-mapping.md) 中标记为 🔲 的业务域：

| 业务域 | Wrapper 名称 | 触发条件 |
|--------|--------------|----------|
| 玩家空间 | PlayspaceWrapper | 需要批量操作玩家或查询玩家列表 |
| 物理操作 | PhysicsWrapper | 需要自定义物理行为或复杂运动 |
| UI 交互 | UIWrapper | 需要自定义 UI 显示或交互 |
| 设备操作 | DeviceWrapper | 需要程序化控制 Creative 设备 |
| 音频操作 | AudioWrapper | 需要程序化控制音频播放 |
| AI 行为 | AIWrapper | 需要自定义 AI 行为逻辑 |
| 道具物品 | ItemWrapper | 需要自定义道具或背包系统 |

---

## 创建新 Wrapper

1. 确认有真实业务需求
2. 提交 [wrapper-request](../../request-templates/wrapper-request.md)
3. 在 digest 中发掘所有相关 API
4. 参考 CharacterWrapper 结构实现
5. 注册到 [@wrapper-registry.md](../../memory-bank-template/@wrapper-registry.md)
6. 更新本索引文件

---

## Reference

- [verse-wrappers SKILL](../../verse-wrappers/SKILL.md) - Wrapper 层 Skill 定义
- [api-keyword-mapping.md](../../verse-wrappers/api-keyword-mapping.md) - API 依赖关键词映射
- [@wrapper-registry.md](../../memory-bank-template/@wrapper-registry.md) - Wrapper 注册表

---

*最后更新: 2025-12-30*
