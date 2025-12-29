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

*最后更新: 2025-12-29*
