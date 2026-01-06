# 待实现需求列表

> 自动生成时间: 2025-12-27  
> 生成器: verseOrchestrator (循环迭代模式)  
> 总数: 15 个需求

---

## 优先级排序

| 排序 | 需求 | 分数 | 类型 | 状态 |
|------|------|------|------|------|
| 1 | buff_system_component | 9.25 | Component | ⬜ 待实现 |
| 2 | object_pool_manager | 9.00 | Helper | ⬜ 待实现 |
| 3 | quest_component | 8.75 | Component | ⬜ 待实现 |
| 4 | audio_manager | 8.50 | Helper | ⬜ 待实现 |
| 5 | team_component | 8.50 | Component | ⬜ 待实现 |
| 6 | zone_events | 8.25 | Events | ⬜ 待实现 |
| 7 | ability_component | 8.25 | Component | ⬜ 待实现 |
| 8 | wave_manager_component | 8.00 | Component | ⬜ 待实现 |
| 9 | ui_helper | 8.00 | Helper | ⬜ 待实现 |
| 10 | loot_table_helper | 7.75 | Helper | ⬜ 待实现 |
| 11 | pathfinding_helper | 7.50 | Helper | ⬜ 待实现 |
| 12 | currency_component | 7.50 | Component | ⬜ 待实现 |
| 13 | score_component | 7.25 | Component | ⬜ 待实现 |
| 14 | respawn_component | 7.00 | Component | ⬜ 待实现 |
| 15 | round_manager_entity | 6.75 | Entity | ⬜ 待实现 |

---

## 需求详情

### REQ-013: buff_system_component

**分数**: 9.25  
**类型**: Component  
**状态**: ⬜ 待实现

**描述**:
增益/减益效果管理组件，支持：
- 添加/移除 Buff/Debuff
- Buff 堆叠规则（叠加、刷新、独立）
- Buff 持续时间管理
- Buff 过期自动移除
- Buff 效果类型（属性修改、持续伤害/治疗、状态效果）
- Buff 事件通知（添加、刷新、移除、过期）

**预期接口**:
```verse
buff_effect_type := enum:
    StatModifier      # 属性修改
    DamageOverTime    # 持续伤害
    HealOverTime      # 持续治疗
    StatusEffect      # 状态效果（眩晕、沉默等）

buff_stack_rule := enum:
    Stack             # 叠加（增加层数）
    Refresh           # 刷新（重置时间）
    Independent       # 独立（多个实例）
    Override          # 覆盖（替换旧的）

buff_definition := struct:
    BuffID:string
    DisplayName:string
    Duration:float
    StackRule:buff_stack_rule
    MaxStacks:int
    EffectType:buff_effect_type
    TickInterval:float  # DoT/HoT 间隔

buff_system_component := class<final_super>(component):
    AddBuff(Definition:buff_definition, Source:?entity):logic
    RemoveBuff(BuffID:string):logic
    RemoveAllBuffs():void
    HasBuff(BuffID:string):logic
    GetBuffStacks(BuffID:string):int
    GetBuffRemainingTime(BuffID:string):float
    GetActiveBuffs():[]buff_instance
    
    # 事件
    OnBuffAdded:event(buff_instance) = event(buff_instance){}
    OnBuffRemoved:event(buff_instance) = event(buff_instance){}
    OnBuffStackChanged:event(buff_instance) = event(buff_instance){}
```

**评分详情**:
- 影响范围: 10 (跨系统 - RPG/MOBA/射击游戏核心)
- 复用潜力: 10 (通用 - 几乎所有战斗游戏需要)
- 实现复杂度: 6 (中等 - 需要定时器和状态管理)
- API可行性: 10 (完全可实现)

**依赖**: timer_manager, cooldown_manager, health_component

---

### REQ-014: object_pool_manager

**分数**: 9.00  
**类型**: Helper  
**状态**: ⬜ 待实现

**描述**:
对象池管理器，用于高频创建/销毁对象的性能优化：
- 预分配对象池
- 获取/归还对象
- 池容量动态扩展
- 对象重置机制
- 池使用统计

**预期接口**:
```verse
poolable := interface:
    Reset():void
    IsActive():logic
    SetActive(Active:logic):void

object_pool<T:poolable> := class:
    var PoolSize<private>:int
    var ActiveCount<private>:int = 0
    
    Initialize(InitialSize:int):void
    Acquire():?T
    Release(Object:T):void
    ReleaseAll():void
    GetActiveCount():int
    GetPoolSize():int
    Expand(AdditionalSize:int):void
    Shrink(TargetSize:int):void

# 预定义的常用池
ProjectilePool := object_pool(projectile_component)
EffectPool := object_pool(particle_effect)
```

**评分详情**:
- 影响范围: 10 (跨系统 - 弹幕、粒子、敌人生成)
- 复用潜力: 10 (通用 - 性能关键场景必需)
- 实现复杂度: 6 (中等)
- API可行性: 10 (纯逻辑实现)

**依赖**: 无

---

### REQ-015: quest_component

**分数**: 8.75  
**类型**: Component  
**状态**: ⬜ 待实现

**描述**:
任务/成就系统组件，支持：
- 任务定义（目标、条件、奖励）
- 任务进度追踪
- 多目标任务
- 任务链/前置条件
- 任务事件（开始、进度、完成、失败）

**预期接口**:
```verse
quest_objective_type := enum:
    Kill          # 击杀目标
    Collect       # 收集物品
    Reach         # 到达位置
    Interact      # 交互
    Survive       # 存活时间
    Custom        # 自定义条件

quest_objective := struct:
    ObjectiveID:string
    Type:quest_objective_type
    TargetCount:int
    CurrentCount:int
    Description:string

quest_definition := struct:
    QuestID:string
    Title:string
    Description:string
    Objectives:[]quest_objective
    Prerequisites:[]string  # 前置任务ID
    Rewards:[]quest_reward

quest_component := class<final_super>(component):
    # 任务管理
    AcceptQuest(QuestID:string):logic
    AbandonQuest(QuestID:string):logic
    GetActiveQuests():[]quest_instance
    GetCompletedQuests():[]string
    
    # 进度更新
    UpdateProgress(QuestID:string, ObjectiveID:string, Amount:int):void
    CheckCompletion(QuestID:string):logic
    CompleteQuest(QuestID:string):void
    
    # 查询
    HasQuest(QuestID:string):logic
    GetQuestProgress(QuestID:string):?quest_instance
    CanAcceptQuest(QuestID:string):logic
    
    # 事件
    OnQuestAccepted:event(quest_instance) = event(quest_instance){}
    OnQuestProgress:event(quest_instance) = event(quest_instance){}
    OnQuestCompleted:event(quest_instance) = event(quest_instance){}
    OnQuestFailed:event(quest_instance) = event(quest_instance){}
```

**评分详情**:
- 影响范围: 10 (跨系统)
- 复用潜力: 10 (通用 - RPG/开放世界/任务驱动游戏)
- 实现复杂度: 6 (中等)
- API可行性: 6 (主要是逻辑实现)

**依赖**: inventory_component (奖励发放)

---

### REQ-016: audio_manager

**分数**: 8.50  
**类型**: Helper  
**状态**: ⬜ 待实现

**描述**:
音频管理工具，封装 UEFN 音频 API：
- 播放/停止音效
- 音量控制
- 3D 空间音效
- 音频分组（BGM/SFX/Voice）
- 音效池（防止同一音效重复播放）

**预期接口**:
```verse
audio_category := enum:
    Music      # 背景音乐
    SFX        # 音效
    Voice      # 语音
    Ambient    # 环境音

AudioManager := module:
    # 基础播放
    PlaySound(SoundAsset:sound_asset):void
    PlaySoundAtLocation(SoundAsset:sound_asset, Location:vector3):void
    PlaySound3D(SoundAsset:sound_asset, Attachment:entity):void
    StopSound(SoundID:int):void
    StopAllSounds():void
    
    # 音量控制
    SetCategoryVolume(Category:audio_category, Volume:float):void
    GetCategoryVolume(Category:audio_category):float
    SetMasterVolume(Volume:float):void
    MuteCategory(Category:audio_category):void
    UnmuteCategory(Category:audio_category):void
    
    # 高级功能
    FadeIn(SoundID:int, Duration:float):void
    FadeOut(SoundID:int, Duration:float):void
    CrossFade(FromID:int, ToID:int, Duration:float):void
```

**评分详情**:
- 影响范围: 10 (跨系统 - 所有游戏需要音频)
- 复用潜力: 10 (通用)
- 实现复杂度: 6 (中等 - 需要封装 UEFN API)
- API可行性: 6 (依赖 sound_component 能力)

**依赖**: UEFN sound_component API

---

### REQ-017: team_component

**分数**: 8.50  
**类型**: Component  
**状态**: ⬜ 待实现

**描述**:
团队/阵营管理组件，支持：
- 团队分配
- 团队关系（友军/敌军/中立）
- 团队成员查询
- 团队事件（加入、离开、切换）
- 与 Fortnite 原生团队系统集成

**预期接口**:
```verse
team_relation := enum:
    Friendly    # 友军
    Hostile     # 敌军
    Neutral     # 中立

team_component := class<final_super>(component):
    @editable var TeamID:int = 0
    @editable var TeamName:string = "Default"
    
    # 团队操作
    SetTeam(NewTeamID:int):void
    GetTeam():int
    
    # 关系查询
    GetRelationTo(Other:team_component):team_relation
    IsAllied(Other:team_component):logic
    IsEnemy(Other:team_component):logic
    
    # 团队成员
    GetTeammates():[]entity
    GetTeamSize():int
    
    # 事件
    OnTeamChanged:event(int, int) = event(int, int){}  # (OldTeam, NewTeam)
```

**评分详情**:
- 影响范围: 10 (跨系统 - PvP/团队竞技核心)
- 复用潜力: 10 (通用)
- 实现复杂度: 6 (中等)
- API可行性: 10 (可与 Fortnite team API 集成)

**依赖**: 无

---

### REQ-018: zone_events

**分数**: 8.25  
**类型**: Events  
**状态**: ⬜ 待实现

**描述**:
区域相关事件定义，与 trigger_zone_component 配合：
- 区域进入/离开事件
- 区域停留事件
- 区域状态变化事件
- 缩圈事件（大逃杀模式）

**预期接口**:
```verse
# 基础区域事件
zone_entered_event := class<concrete>(scene_event):
    Zone:trigger_zone_component
    Entity:entity
    Timestamp:float

zone_exited_event := class<concrete>(scene_event):
    Zone:trigger_zone_component
    Entity:entity
    Duration:float  # 停留时长

zone_stay_event := class<concrete>(scene_event):
    Zone:trigger_zone_component
    Entity:entity
    StayDuration:float

# 缩圈专用事件
storm_phase_started_event := class<concrete>(scene_event):
    Phase:int
    ShrinkDuration:float
    TargetRadius:float
    TargetCenter:vector3

storm_phase_ended_event := class<concrete>(scene_event):
    Phase:int
    FinalRadius:float
    FinalCenter:vector3

storm_damage_event := class<concrete>(scene_event):
    Entity:entity
    Damage:int
    IsInStorm:logic
```

**评分详情**:
- 影响范围: 10 (跨系统)
- 复用潜力: 10 (通用 - 区域检测是基础功能)
- 实现复杂度: 10 (简单 - 仅事件定义)
- API可行性: 10 (纯数据结构)

**依赖**: trigger_zone_component

---

### REQ-019: ability_component

**分数**: 8.25  
**类型**: Component  
**状态**: ⬜ 待实现

**描述**:
技能系统组件，支持：
- 技能注册/解锁
- 技能施放（条件检查、消耗、冷却）
- 技能等级/升级
- 技能组合/连招
- 技能打断/取消

**预期接口**:
```verse
ability_state := enum:
    Ready       # 就绪
    Casting     # 施放中
    Cooldown    # 冷却中
    Disabled    # 禁用

ability_definition := struct:
    AbilityID:string
    DisplayName:string
    Cooldown:float
    CastTime:float
    ManaCost:int
    MaxLevel:int

ability_component := class<final_super>(component):
    # 技能管理
    RegisterAbility(Definition:ability_definition):void
    UnlockAbility(AbilityID:string):logic
    LockAbility(AbilityID:string):void
    UpgradeAbility(AbilityID:string):logic
    
    # 技能施放
    TryUseAbility(AbilityID:string, Target:?entity):logic
    CancelAbility(AbilityID:string):void
    InterruptAllAbilities():void
    
    # 查询
    GetAbilityState(AbilityID:string):ability_state
    GetAbilityLevel(AbilityID:string):int
    GetAbilityCooldown(AbilityID:string):float
    GetUnlockedAbilities():[]string
    CanUseAbility(AbilityID:string):logic
    
    # 事件
    OnAbilityUsed:event(string) = event(string){}
    OnAbilityCancelled:event(string) = event(string){}
    OnAbilityUnlocked:event(string) = event(string){}
```

**评分详情**:
- 影响范围: 10 (跨系统)
- 复用潜力: 6 (MOBA/RPG/动作游戏)
- 实现复杂度: 6 (中等)
- API可行性: 10 (逻辑实现)

**依赖**: cooldown_manager, timer_manager

---

### REQ-020: wave_manager_component

**分数**: 8.00  
**类型**: Component  
**状态**: ⬜ 待实现

**描述**:
波次管理器（塔防/生存模式），支持：
- 波次配置（敌人类型、数量、间隔）
- 波次进度追踪
- 波次间休息时间
- 无尽模式（动态难度）
- 波次事件

**预期接口**:
```verse
wave_enemy_config := struct:
    EnemyType:string
    Count:int
    SpawnInterval:float
    SpawnDelay:float

wave_config := struct:
    WaveNumber:int
    Enemies:[]wave_enemy_config
    RestDuration:float
    BonusObjectives:[]string

wave_manager_component := class<final_super>(component):
    @editable var Waves:[]wave_config = array{}
    @editable var EndlessMode:logic = false
    @editable var DifficultyScaling:float = 1.1
    
    # 控制
    StartWaves():void
    PauseWaves():void
    ResumeWaves():void
    SkipToWave(WaveNumber:int):void
    
    # 查询
    GetCurrentWave():int
    GetTotalWaves():int
    GetRemainingEnemies():int
    GetWaveProgress():float  # 0.0 - 1.0
    IsWaveActive():logic
    IsInRestPeriod():logic
    GetRestTimeRemaining():float
    
    # 事件
    OnWaveStarted:event(int) = event(int){}
    OnWaveCompleted:event(int) = event(int){}
    OnAllWavesCompleted:event() = event(){}
    OnEnemySpawned:event(entity) = event(entity){}
```

**评分详情**:
- 影响范围: 6 (单系统 - 塔防/生存模式)
- 复用潜力: 10 (通用波次管理)
- 实现复杂度: 6 (中等)
- API可行性: 10 (逻辑实现)

**依赖**: spawner_component, timer_manager

---

### REQ-021: ui_helper

**分数**: 8.00  
**类型**: Helper  
**状态**: ⬜ 待实现

**描述**:
UI 工具函数集，封装 Fortnite UI API：
- HUD 元素显示/隐藏
- 屏幕消息显示
- 进度条/血条 UI
- 伤害数字显示
- 倒计时显示

**预期接口**:
```verse
UIHelper := module:
    # HUD 控制
    ShowHUDElement(Player:player, Element:hud_element_identifier):void
    HideHUDElement(Player:player, Element:hud_element_identifier):void
    ShowAllHUD(Player:player):void
    HideAllHUD(Player:player):void
    
    # 消息显示
    ShowMessage(Player:player, Text:string, Duration:float):void
    ShowMessageToAll(Text:string, Duration:float):void
    ShowWarning(Player:player, Text:string):void
    
    # 数值显示
    ShowDamageNumber(Position:vector3, Amount:int, IsCritical:logic):void
    ShowHealNumber(Position:vector3, Amount:int):void
    ShowFloatingText(Position:vector3, Text:string, Color:color):void
    
    # 进度显示
    ShowProgressBar(Player:player, Progress:float, Text:string):void
    HideProgressBar(Player:player):void
    ShowCountdown(Player:player, Seconds:int):void
```

**评分详情**:
- 影响范围: 10 (跨系统)
- 复用潜力: 10 (通用)
- 实现复杂度: 6 (中等 - 封装 Fortnite UI API)
- API可行性: 6 (依赖 Fortnite UI 能力)

**依赖**: Fortnite UI API (player_ui, fort_hud_controller)

---

### REQ-022: loot_table_helper

**分数**: 7.75  
**类型**: Helper  
**状态**: ⬜ 待实现

**描述**:
战利品/掉落表工具，支持：
- 掉落表定义
- 权重随机选择
- 保底机制
- 稀有度系统
- 条件掉落

**预期接口**:
```verse
loot_rarity := enum:
    Common      # 普通
    Uncommon    # 罕见
    Rare        # 稀有
    Epic        # 史诗
    Legendary   # 传说

loot_entry := struct:
    ItemID:string
    Weight:float
    MinCount:int
    MaxCount:int
    Rarity:loot_rarity

loot_table := struct:
    TableID:string
    Entries:[]loot_entry
    GuaranteedDrops:[]string
    DropChance:float  # 整体掉落概率

LootTableHelper := module:
    # 掉落计算
    RollLoot(Table:loot_table):[]loot_result
    RollSingleItem(Table:loot_table):?loot_result
    RollWithPity(Table:loot_table, PityCounter:int):loot_result
    
    # 稀有度工具
    GetRarityWeight(Rarity:loot_rarity):float
    FilterByRarity(Table:loot_table, MinRarity:loot_rarity):loot_table
    
    # 验证
    ValidateLootTable(Table:loot_table):logic
    GetTotalWeight(Table:loot_table):float
```

**评分详情**:
- 影响范围: 6 (掉落系统)
- 复用潜力: 10 (通用 - RPG/射击/生存游戏)
- 实现复杂度: 10 (简单 - 纯计算)
- API可行性: 10 (纯逻辑)

**依赖**: random_utils

---

### REQ-023: pathfinding_helper

**分数**: 7.50  
**类型**: Helper  
**状态**: ⬜ 待实现

**描述**:
路径查找工具（封装 UEFN 导航能力）：
- 点到点路径查询
- 路径有效性检查
- 最近可达点查询
- 简单避障

**预期接口**:
```verse
PathfindingHelper := module:
    # 路径查询
    FindPath(Start:vector3, End:vector3):?[]vector3
    IsPathValid(Start:vector3, End:vector3):logic
    GetPathLength(Path:[]vector3):float
    
    # 位置查询
    GetNearestReachablePoint(From:vector3, Target:vector3):?vector3
    IsPointReachable(From:vector3, Target:vector3):logic
    
    # 简化移动
    GetDirectionToTarget(From:vector3, To:vector3):vector3
    GetNextWaypoint(CurrentPos:vector3, Path:[]vector3):?vector3
```

**评分详情**:
- 影响范围: 6 (AI/NPC系统)
- 复用潜力: 10 (通用)
- 实现复杂度: 3 (复杂 - 依赖引擎能力)
- API可行性: 3 (UEFN 路径查找 API 有限)

**依赖**: UEFN Navigation API (如有)

**备注**: ⚠️ 需要确认 UEFN 是否暴露导航查询 API，可能需要降级为基于射线检测的简单实现

---

### REQ-024: currency_component

**分数**: 7.50  
**类型**: Component  
**状态**: ⬜ 待实现

**描述**:
货币系统组件，支持：
- 多种货币类型
- 货币增减
- 货币上限
- 交易验证
- 货币事件

**预期接口**:
```verse
currency_type := enum:
    Gold        # 金币
    Gems        # 钻石
    Tokens      # 代币
    Custom      # 自定义

currency_component := class<final_super>(component):
    # 货币操作
    AddCurrency(Type:currency_type, Amount:int):logic
    RemoveCurrency(Type:currency_type, Amount:int):logic
    SetCurrency(Type:currency_type, Amount:int):void
    
    # 查询
    GetCurrency(Type:currency_type):int
    HasEnough(Type:currency_type, Amount:int):logic
    GetMaxCurrency(Type:currency_type):int
    
    # 配置
    SetMaxCurrency(Type:currency_type, Max:int):void
    RegisterCustomCurrency(ID:string, DisplayName:string, Max:int):void
    
    # 事件
    OnCurrencyChanged:event(currency_type, int, int) = event(currency_type, int, int){}  # (Type, OldAmount, NewAmount)
```

**评分详情**:
- 影响范围: 6 (经济系统)
- 复用潜力: 10 (通用)
- 实现复杂度: 10 (简单)
- API可行性: 10 (纯逻辑)

**依赖**: 无

---

### REQ-025: score_component

**分数**: 7.25  
**类型**: Component  
**状态**: ⬜ 待实现

**描述**:
得分/统计组件，支持：
- 多维度分数追踪
- 分数加成/乘数
- 排行榜数据
- 统计数据（击杀、死亡、助攻等）

**预期接口**:
```verse
score_category := enum:
    Total       # 总分
    Kills       # 击杀
    Deaths      # 死亡
    Assists     # 助攻
    Objectives  # 目标分
    Custom      # 自定义

score_component := class<final_super>(component):
    # 分数操作
    AddScore(Category:score_category, Amount:int):void
    SetScore(Category:score_category, Amount:int):void
    ResetScore(Category:score_category):void
    ResetAllScores():void
    
    # 乘数
    SetScoreMultiplier(Multiplier:float, Duration:float):void
    GetCurrentMultiplier():float
    
    # 查询
    GetScore(Category:score_category):int
    GetTotalScore():int
    GetKDA():float  # Kill/Death/Assist ratio
    
    # 统计
    IncrementStat(StatName:string):void
    GetStat(StatName:string):int
    GetAllStats():[]stat_entry
    
    # 事件
    OnScoreChanged:event(score_category, int) = event(score_category, int){}
    OnMilestoneReached:event(int) = event(int){}  # 达到特定分数
```

**评分详情**:
- 影响范围: 6 (得分系统)
- 复用潜力: 10 (通用 - 竞技游戏必需)
- 实现复杂度: 10 (简单)
- API可行性: 10 (纯逻辑)

**依赖**: 无

---

### REQ-026: respawn_component

**分数**: 7.00  
**类型**: Component  
**状态**: ⬜ 待实现

**描述**:
重生系统组件，支持：
- 重生点管理
- 重生延迟
- 重生条件
- 重生保护（无敌时间）
- 与 Fortnite 重生系统集成

**预期接口**:
```verse
respawn_mode := enum:
    Instant     # 立即重生
    Delayed     # 延迟重生
    Manual      # 手动触发
    WaveRespawn # 波次重生

respawn_component := class<final_super>(component):
    @editable var RespawnMode:respawn_mode = respawn_mode.Delayed
    @editable var RespawnDelay:float = 5.0
    @editable var InvincibilityDuration:float = 3.0
    @editable var RespawnLives:int = -1  # -1 = 无限
    
    # 重生控制
    RequestRespawn():logic
    ForceRespawn(Location:?vector3):void
    CancelRespawn():void
    
    # 重生点
    AddSpawnPoint(Location:vector3):void
    RemoveSpawnPoint(Index:int):void
    SetSpawnPoint(Location:vector3):void
    GetRandomSpawnPoint():?vector3
    
    # 查询
    GetRespawnTimeRemaining():float
    GetRemainingLives():int
    IsWaitingToRespawn():logic
    CanRespawn():logic
    
    # 事件
    OnRespawnStarted:event(float) = event(float){}  # 开始等待，参数为等待时间
    OnRespawned:event(vector3) = event(vector3){}   # 完成重生，参数为重生位置
    OnOutOfLives:event() = event(){}                # 生命用尽
```

**评分详情**:
- 影响范围: 6 (重生系统)
- 复用潜力: 10 (通用 - 大部分多人游戏需要)
- 实现复杂度: 6 (中等 - 需要与 Fortnite API 集成)
- API可行性: 6 (需要封装 Fortnite 重生 API)

**依赖**: timer_manager, health_component

---

### REQ-027: round_manager_entity

**分数**: 6.75  
**类型**: Entity  
**状态**: ⬜ 待实现

**描述**:
回合/轮次管理实体，适用于回合制游戏：
- 回合状态管理
- 回合计时
- 回合转换
- 游戏阶段（准备、进行、结算）
- 胜负判定

**预期接口**:
```verse
game_phase := enum:
    Waiting     # 等待玩家
    Preparing   # 准备阶段
    Playing     # 进行中
    Ending      # 结算中
    Finished    # 已结束

round_manager_entity := class(entity):
    @editable var RoundDuration:float = 180.0
    @editable var PreparationTime:float = 10.0
    @editable var RoundsToWin:int = 3
    
    # 轮次状态组件
    var StateComponent:state_machine_component
    var TimerComponent:round_timer_component
    var ScoreComponent:round_score_component
    
    # 控制
    StartMatch():void
    EndMatch():void
    StartRound():void
    EndRound(WinnerTeam:int):void
    PauseRound():void
    ResumeRound():void
    
    # 查询
    GetCurrentRound():int
    GetCurrentPhase():game_phase
    GetRoundTimeRemaining():float
    GetTeamScore(TeamID:int):int
    GetWinner():?int
    IsMatchOver():logic
    
    # 事件
    OnMatchStarted:event() = event(){}
    OnMatchEnded:event(int) = event(int){}          # 参数: 获胜队伍
    OnRoundStarted:event(int) = event(int){}        # 参数: 回合数
    OnRoundEnded:event(int, int) = event(int, int){} # 参数: 回合数, 获胜队伍
    OnPhaseChanged:event(game_phase) = event(game_phase){}
```

**评分详情**:
- 影响范围: 6 (游戏流程管理)
- 复用潜力: 6 (竞技/回合制游戏)
- 实现复杂度: 6 (中等)
- API可行性: 10 (逻辑实现)

**依赖**: state_machine_component, timer_manager, team_component

---

## 评分标准说明

### 影响范围 (1-10)
- 10: 跨系统核心功能
- 6: 单系统关键功能
- 3: 辅助功能

### 复用潜力 (1-10)
- 10: 通用（几乎所有游戏需要）
- 6: 特定类型（某类游戏需要）
- 3: 特定项目（仅特定游戏需要）

### 实现复杂度 (1-10) [越高越简单]
- 10: 简单（纯逻辑/数据结构）
- 6: 中等（需要状态管理/定时器）
- 3: 复杂（需要复杂算法或 API 集成）

### API可行性 (1-10)
- 10: 完全可实现
- 6: 部分依赖 UEFN API
- 3: 受限于 API 能力

### 总分计算
```
总分 = (影响范围 × 0.3) + (复用潜力 × 0.3) + (实现复杂度 × 0.2) + (API可行性 × 0.2)
```

---

## 历史已完成需求

> 以下需求已在代码库中实现，详见 `@code-library-index.md`

| # | 需求 | 完成日期 |
|---|------|----------|
| REQ-001 | damage_calculator | 2025-12-27 |
| REQ-002 | timer_manager | 2025-12-27 |
| REQ-003 | random_selector | 2025-12-27 |
| REQ-004 | interaction_event | 2025-12-27 |
| REQ-005 | cooldown_manager | 2025-12-27 |
| REQ-006 | movement_component | 2025-12-27 |
| REQ-007 | attack_component | 2025-12-27 |
| REQ-008 | projectile_component | 2025-12-27 |
| REQ-009 | spawner_component | 2025-12-27 |
| REQ-010 | trigger_zone_component | 2025-12-27 |
| REQ-011 | inventory_component | 2025-12-27 |
| REQ-012 | state_machine_component | 2025-12-27 |

---

## 更新日志

| 日期 | 操作 | 说明 |
|------|------|------|
| 2025-12-27 | 重新生成 | 清空已完成需求，生成15个新需求 (REQ-013 ~ REQ-027) |

---

*最后更新: 2025-12-27*
