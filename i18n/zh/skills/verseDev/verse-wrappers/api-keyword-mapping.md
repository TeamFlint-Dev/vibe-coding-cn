# API 依赖关键词映射表

> 需求分析阶段使用此表识别 Wrapper 依赖

---

## 使用方法

1. 扫描需求描述中的关键词
2. 在下表中查找匹配的业务域
3. 检查对应 Wrapper 是否存在
4. 不存在则生成 `wrapper-request` 前置需求

---

## 映射表

### 角色操作域 → CharacterWrapper ✅

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| 角色 | fort_character | Fortnite L11777 |
| 玩家角色 | fort_character | Fortnite L11777 |
| 伤害 | damageable.Damage() | Fortnite L11800 |
| 受伤 | damageable.Damage() | Fortnite L11800 |
| 攻击 | damageable.Damage() | Fortnite L11800 |
| 治疗 | healable.Heal() | Fortnite L11810 |
| 回血 | healable.Heal() | Fortnite L11810 |
| 恢复生命 | healable.Heal() | Fortnite L11810 |
| 生命值 | healthful.GetHealth/SetHealth | Fortnite L11815 |
| 血量 | healthful.GetHealth/SetHealth | Fortnite L11815 |
| HP | healthful.GetHealth/SetHealth | Fortnite L11815 |
| 最大生命值 | healthful.GetMaxHealth | Fortnite L11820 |
| 护盾 | shieldable.GetShield/SetShield | Fortnite L11830 |
| 护甲 | shieldable.GetShield/SetShield | Fortnite L11830 |
| 盾值 | shieldable.GetShield/SetShield | Fortnite L11830 |
| 位置 | positional.GetTransform | Fortnite L11850 |
| 传送 | fort_character.TeleportTo | Fortnite L11900 |
| 瞬移 | fort_character.TeleportTo | Fortnite L11900 |
| 隐身 | fort_character.Hide/Show | Fortnite L11920 |
| 显示/隐藏 | fort_character.Hide/Show | Fortnite L11920 |
| 无敌 | fort_character.SetVulnerability | Fortnite L11940 |
| 免疫伤害 | fort_character.SetVulnerability | Fortnite L11940 |
| 定身 | fort_character.PutInStasis | Fortnite L11960 |
| 眩晕 | fort_character.PutInStasis | Fortnite L11960 |
| 速度 | fort_character.GetLinearVelocity | Fortnite L11980 |
| 击退 | fort_character.ApplyLinearImpulse | Fortnite L12000 |
| 击飞 | fort_character.ApplyLinearImpulse | Fortnite L12000 |
| 倒地 | fort_character.IsDownButNotOut | Fortnite L12010 |

**Wrapper 状态**: ✅ 已实现  
**位置**: `shared/code-library/Wrappers/CharacterWrapper.verse`

---

### Sidekicks/宠物域 → PetWrapper ✅

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| Sidekick | sidekick_component | Fortnite L4584 |
| 宠物 | sidekick_component | Fortnite L4584 |
| 情绪 | sidekick_component.GetMood/MoodOverride | Fortnite L4587-4590 |
| 反应 | sidekick_component.PlayReaction | Fortnite L4598 |
| 开心 | sidekick_reaction.Happy | Fortnite L4576 |
| 跳舞 | sidekick_reaction.Dance | Fortnite L4577 |
| 表情 | sidekick_reaction.Emote | Fortnite L4578 |
| 生气 | sidekick_reaction.Angry | Fortnite L4579 |
| 担心 | sidekick_reaction.Worried | Fortnite L4580 |
| 情绪覆盖 | sidekick_component.MoodOverride | Fortnite L4587 |
| 自动反应 | equipped_sidekick_component.AutomaticReactionsEnabled | Fortnite L4276 |
| 宠物可见性 | equipped_sidekick_component.Show | Fortnite L4273 |
| Spark 模式 | spark_mode_component.SparkModeAlwaysActive | Fortnite L4287 |
| 宠物主人 | equipped_sidekick_component.GetOwningAgent | Fortnite L4270 |
| 宠物交互 | equipped_sidekick_component.DefaultInteractionEnabled | Fortnite L4279 |

**Wrapper 状态**: ✅ 已实现 (V2.0 - 基于 Sidekicks API)  
**位置**: `shared/code-library/Wrappers/PetWrapper.verse`

---

### 玩家空间域 → PlayspaceWrapper 🔲

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| 玩家列表 | fort_playspace.GetPlayers() | Fortnite L8500 |
| 所有玩家 | fort_playspace.GetPlayers() | Fortnite L8500 |
| 玩家数量 | fort_playspace.GetPlayers() | Fortnite L8500 |
| 队伍 | fort_team, team_collection | Fortnite L8600 |
| 分组 | fort_team, team_collection | Fortnite L8600 |
| 匹配 | matchmaking 相关 | Fortnite L8700 |
| 游戏空间 | fort_playspace | Fortnite L8450 |
| 游戏实例 | fort_playspace | Fortnite L8450 |

**Wrapper 状态**: 🔲 待创建  
**触发需求**: 需要批量操作玩家或查询玩家列表时

---

### 物理操作域 → PhysicsWrapper 🔲

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| 物理 | physics 模块 | UE L500 |
| 碰撞 | collision 相关 | UE L550 |
| 重力 | gravity 相关 | UE L600 |
| 刚体 | rigid body | UE L650 |
| 力 | ApplyForce | UE L700 |
| 冲量 | ApplyImpulse | UE L750 |
| 变换 | transform | UE/SpatialMath |
| 旋转 | rotation | UE/SpatialMath |
| 缩放 | scale | UE/SpatialMath |

**Wrapper 状态**: 🔲 待创建  
**触发需求**: 需要自定义物理行为或复杂运动计算时

---

### UI 交互域 → UIWrapper 🔲

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| UI | player_ui | Fortnite L3000 |
| 界面 | player_ui | Fortnite L3000 |
| HUD | fort_hud_controller | Fortnite L3100 |
| 按钮 | button_base | Fortnite L3200 |
| 文本 | text_block | Fortnite L3300 |
| 图片 | image_block | Fortnite L3400 |
| 菜单 | menu 相关 | Fortnite L3500 |
| 弹窗 | popup 相关 | Fortnite L3600 |
| 消息 | message 相关 | Fortnite L3700 |
| 提示 | notification | Fortnite L3800 |

**Wrapper 状态**: 🔲 待创建  
**触发需求**: 需要自定义 UI 显示或交互时

---

### 设备操作域 → DeviceWrapper 🔲

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| 设备 | creative_device_base | Fortnite L5000 |
| 触发器 | trigger_device | Fortnite L5100 |
| 按钮设备 | button_device | Fortnite L5200 |
| 传送设备 | teleporter_device | Fortnite L5300 |
| 生成器 | spawner_device | Fortnite L5400 |
| 计分板 | scoreboard_device | Fortnite L5500 |
| 计时器 | timer_device | Fortnite L5600 |
| 启用/禁用 | enableable.Enable/Disable | Fortnite L5700 |
| 激活 | activatable.Activate | Fortnite L5800 |
| 交互 | interactable | Fortnite L5900 |

**Wrapper 状态**: 🔲 待创建  
**触发需求**: 需要程序化控制 Creative 设备时

---

### 音频操作域 → AudioWrapper 🔲

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| 音效 | audio 模块 | Fortnite L6000 |
| 音乐 | music 相关 | Fortnite L6100 |
| 声音 | sound 相关 | Fortnite L6200 |
| 音量 | volume 相关 | Fortnite L6300 |
| 播放 | Play | Fortnite L6400 |
| 停止播放 | Stop | Fortnite L6500 |

**Wrapper 状态**: 🔲 待创建  
**触发需求**: 需要程序化控制音频播放时

---

### AI 行为域 → AIWrapper 🔲

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| AI | ai 模块 | Fortnite L7000 |
| NPC | npc 相关 | Fortnite L7100 |
| 巡逻 | patrol 相关 | Fortnite L7200 |
| 追击 | chase 相关 | Fortnite L7300 |
| 寻路 | navigation | Fortnite L7400 |
| 行为树 | behavior tree | Fortnite L7500 |
| 敌人 | enemy 相关 | Fortnite L7600 |

**Wrapper 状态**: 🔲 待创建  
**触发需求**: 需要自定义 AI 行为逻辑时

---

### 道具/物品域 → ItemWrapper 🔲

| 关键词 | 关联 API | digest 位置 |
|--------|----------|-------------|
| 道具 | item 相关 | UE/Itemization L100 |
| 物品 | item 相关 | UE/Itemization L100 |
| 背包 | inventory | Fortnite L9000 |
| 拾取 | pickup | Fortnite L9100 |
| 掉落 | drop | Fortnite L9200 |
| 装备 | equip | Fortnite L9300 |
| 武器 | weapon | Fortnite L9400 |
| 消耗品 | consumable | Fortnite L9500 |

**Wrapper 状态**: 🔲 待创建  
**触发需求**: 需要自定义道具行为或背包系统时

---

## 维护说明

### 新增映射规则

当创建新 Wrapper 时：
1. 在此文件中添加对应业务域的映射表
2. 列出所有相关关键词
3. 标注 digest 位置（便于后续校验）
4. 更新 Wrapper 状态

### 状态标记

| 标记 | 含义 |
|------|------|
| ✅ | 已实现，可直接使用 |
| 🔲 | 待创建，需要时生成 wrapper-request |
| 🔄 | 更新中，digest 变更后待适配 |

---

*最后更新: 2025-12-28*
