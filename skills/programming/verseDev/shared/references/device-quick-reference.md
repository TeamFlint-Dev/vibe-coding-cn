# UEFN 设备快速参考手册

> **快速查找**: 本文档提供设备的快速分类索引，便于开发时快速定位所需设备。
>
> **详细报告**: 参见 [uefn-device-system-research.md](./uefn-device-system-research.md)

## 🎯 按功能快速查找

### 我想实现...

| 功能需求 | 推荐设备 | 分类 |
|---------|---------|------|
| **生成敌人/NPC** | `npc_spawner_device`, `creature_spawner_device`, `guard_spawner_device` | AI |
| **给玩家物品** | `item_granter_device`, `item_spawner_device` | 生成器 |
| **检测玩家进入区域** | `trigger_device`, `perception_trigger_device` | 触发器 |
| **传送玩家** | `teleporter_device` | 控制 |
| **显示消息** | `hud_message_device`, `popup_dialog_device` | UI显示 |
| **计分系统** | `score_manager_device`, `tracker_device` | 游戏玩法 |
| **计时器** | `timer_device` | 游戏玩法 |
| **生成载具** | `vehicle_spawner_*` 系列 (31种) | 载具生成器 |
| **播放音乐** | `audio_player_device`, `radio_device` | 音频 |
| **音乐制作** | `patchwork_*` 系列 (19种) | 音频 |
| **视觉效果** | `vfx_spawner_device`, `post_process_device` | 视觉效果 |
| **阻挡玩家** | `barrier_device` | 控制 |
| **按钮交互** | `button_device`, `conditional_button_device` | 触发器 |
| **任务目标** | `objective_device`, `timed_objective_device` | 游戏玩法 |
| **淘汰管理** | `elimination_manager_device` | 游戏玩法 |
| **回合制** | `round_settings_device` | 游戏玩法 |
| **竞速游戏** | `race_manager_device`, `race_checkpoint_device` | 游戏玩法 |
| **职业系统** | `class_designer_device`, `class_selector_ui_device` | UI显示 |
| **改变区域属性** | `mutator_zone_device`, `damage_volume_device` | 体积区域 |
| **风暴系统** | `storm_controller_device` 系列 | 特殊 |
| **移动道具** | `prop_mover_device`, `prop_manipulator_device` | 物理 |
| **相机控制** | `gameplay_camera_*` 系列 | 其他 |
| **AI巡逻** | `ai_patrol_path_device`, `ai_patrol_path_node_device` | AI |

## 📊 设备分类速查表

### 生成器类 (47个)

#### 常用生成器
- `item_spawner_device` - 物品生成
- `npc_spawner_device` - NPC生成
- `creature_spawner_device` - 生物生成
- `ball_spawner_device` - 球类生成
- `supply_drop_spawner_device` - 空投生成

#### 环境生成器
- `air_vent_device` - 通风口
- `bouncer_device` - 弹跳器
- `crash_pad_device` - 缓冲垫
- `grind_rail_device` - 滑轨
- `zipline_device` - 滑索

### 载具生成器 (31个)

#### 地面载具 (14个)
```
atk, quadcrasher, shopping_cart, driftboard,
sedan, pickup_truck, taxi, sports_car, valet_suv,
big_rig, dirt_bike, sportbike, octane, nitro_drifter_sedan
```

#### 水上载具 (2个)
```
boat, surfboard
```

#### 空中载具 (4个)
```
biplane, helicopter, hammerhead_choppa, ufo
```

#### 战斗载具 (6个)
```
tank, cannon, siege_cannon, armored_transport,
armored_battle_bus, war_bus
```

#### 特殊载具 (5个)
```
baller, getaway, heavy_turret, rocketracing, mod_box
```

### 触发器类 (10个)

```
trigger_device               - 基础触发器 ⭐
button_device               - 按钮 ⭐
conditional_button_device   - 条件按钮
switch_device              - 开关
pulse_trigger_device       - 脉冲触发
perception_trigger_device  - 感知触发
input_trigger_device       - 输入触发
skilled_interaction_device - 技能交互
lock_device               - 锁定设备
```

### UI/显示类 (10个)

```
hud_message_device          - HUD消息 ⭐
hud_controller_device       - HUD控制器
popup_dialog_device         - 弹窗对话
conversation_device         - 对话系统
billboard_device           - 广告牌
holoscreen_device          - 全息屏
video_player_device        - 视频播放
class_selector_ui_device   - 职业选择UI
map_indicator_device       - 地图指示
```

### 控制类 (7个)

```
teleporter_device               - 传送器 ⭐
barrier_device                  - 屏障 ⭐
player_checkpoint_device        - 检查点
mutator_zone_device            - 变异区
lock_device                    - 锁定
movement_modulator_device      - 移动调节
player_movement_settings_device - 移动设置
```

### AI设备 (7个)

```
npc_spawner_device         - NPC生成器 ⭐
character_device           - 角色设备
creature_manager_device    - 生物管理
guard_spawner_device       - 守卫生成
sentry_device             - 哨兵
ai_patrol_path_device     - AI巡逻路径
ai_patrol_path_node_device - 巡逻节点
```

### 音频设备 (22个)

#### 基础音频 (3个)
```
audio_player_device - 音频播放器 ⭐
audio_mixer_device  - 混音器
radio_device       - 收音机
```

#### Patchwork音乐系统 (19个)
```
drum_sequencer      - 鼓音序器
echo_effect         - 回声效果
filter              - 滤波器
gain                - 增益器
instrument_player   - 乐器播放器
lfo_modulator       - LFO调制器
music_manager       - 音乐管理器
note_progressor     - 音符推进器
note_sequencer      - 音符音序器
note_trigger        - 音符触发器
omega_synthesizer   - Omega合成器
song_sync           - 歌曲同步
speaker             - 扬声器
step_modulator      - 步进调制器
value_setter        - 数值设置
... (更多)
```

### 视觉效果 (7个)

```
vfx_spawner_device          - VFX生成器
vfx_creator_device          - VFX创建器
post_process_device         - 后期处理
visual_effect_powerup_device - 视效增益
customizable_light_device   - 自定义灯光
skydome_device             - 天空穹顶
decal_device               - 贴花
```

### 游戏玩法 (9个)

```
score_manager_device      - 分数管理 ⭐
tracker_device           - 追踪器 ⭐
timer_device            - 计时器 ⭐
objective_device        - 目标系统
timed_objective_device  - 限时目标
elimination_manager_device - 淘汰管理
race_manager_device     - 竞速管理
race_checkpoint_device  - 竞速检查点
round_settings_device   - 回合设置
```

### 物理设备 (5个)

```
physics_boulder_device      - 物理巨石
physics_tree_device        - 物理树木
prop_mover_device         - 道具移动器
prop_manipulator_device   - 道具操纵器
physics_object_base_device - 物理对象基类
```

### 体积/区域 (8个)

```
volume_device           - 体积设备
damage_volume_device    - 伤害区域
effect_volume_device    - 效果区域
fire_volume_device      - 火焰区域
mutator_zone_device     - 变异区
crowd_volume_device     - 人群区域
skydive_volume_device   - 跳伞区域
rift_point_volume_device - 裂隙区域
```

### 特殊设备 (8个)

```
storm_controller_device          - 风暴控制器
basic_storm_controller_device    - 基础风暴控制
advanced_storm_controller_device - 高级风暴控制
advanced_storm_beacon_device     - 风暴信标
experience_settings_device       - 体验设置
analytics_device                - 分析设备
matchmaking_portal_device       - 匹配门户
end_game_device                 - 游戏结束
```

## 🎮 常见游戏类型推荐设备

### 射击游戏

**核心设备**:
- `elimination_manager_device` - 淘汰管理
- `item_granter_device` - 武器发放
- `player_spawner_device` - 玩家生成
- `barrier_device` - 地图边界
- `damage_volume_device` - 伤害区域

**进阶设备**:
- `team_settings_and_inventory_device` - 队伍设置
- `score_manager_device` - 计分系统
- `round_settings_device` - 回合制
- `storm_controller_device` - 缩圈机制

### 竞速游戏

**核心设备**:
- `race_manager_device` - 竞速管理
- `race_checkpoint_device` - 检查点
- `vehicle_spawner_*` - 载具生成
- `timer_device` - 计时器
- `teleporter_device` - 起点传送

**进阶设备**:
- `grind_rail_device` - 滑轨加速
- `bouncer_device` - 弹跳加速
- `powerup_device` - 道具增益
- `barrier_device` - 赛道边界

### 解谜游戏

**核心设备**:
- `button_device` - 按钮机关
- `conditional_button_device` - 条件按钮
- `lock_device` - 锁定机制
- `trigger_device` - 触发器
- `switch_device` - 开关

**进阶设备**:
- `prop_mover_device` - 移动道具
- `teleporter_device` - 传送谜题
- `timer_device` - 限时挑战
- `objective_device` - 任务提示

### RPG/冒险游戏

**核心设备**:
- `npc_spawner_device` - NPC对话
- `creature_spawner_device` - 敌人生成
- `item_granter_device` - 物品奖励
- `objective_device` - 任务系统
- `conversation_device` - 对话系统

**进阶设备**:
- `class_designer_device` - 职业系统
- `experience_settings_device` - 经验设置
- `creature_manager_device` - 敌人管理
- `popup_dialog_device` - 剧情对话

### 音乐节奏游戏

**核心设备**:
- Patchwork系列 - 音乐制作
- `audio_player_device` - 音频播放
- `timer_device` - 节奏计时
- `score_manager_device` - 分数统计

**进阶设备**:
- `input_trigger_device` - 输入检测
- `vfx_spawner_device` - 视觉反馈
- `hud_message_device` - 连击提示

### 建造/创造游戏

**核心设备**:
- `item_granter_device` - 材料发放
- `prop_spawner_base_device` - 道具生成
- `prop_manipulator_device` - 道具操作
- `item_shop_device` - 材料商店

**进阶设备**:
- LEGO系列设备 - LEGO建造
- `assembly_device` - 组装系统
- `creative_device` - 创造模式

## 🔍 设备搜索索引

### 按名称关键词

| 关键词 | 相关设备数量 | 主要设备 |
|-------|------------|---------|
| spawner | 47 | 各类生成器 |
| vehicle | 31 | 载具生成器 |
| trigger | 10 | 触发器类 |
| camera | 6 | 相机系统 |
| audio/patchwork | 22 | 音频系统 |
| storm | 4 | 风暴系统 |
| volume | 8 | 区域设备 |
| device | 315 | 所有设备 |

### 按使用频率 (⭐推荐度)

#### ⭐⭐⭐⭐⭐ (必备)
```
trigger_device
item_granter_device
button_device
timer_device
player_spawner_device
hud_message_device
```

#### ⭐⭐⭐⭐ (常用)
```
teleporter_device
barrier_device
score_manager_device
npc_spawner_device
objective_device
elimination_manager_device
```

#### ⭐⭐⭐ (进阶)
```
creature_manager_device
class_designer_device
round_settings_device
race_manager_device
storm_controller_device
```

## 📖 使用示例速查

### 基础交互

```verse
# 触发器 + 传送
MyTrigger := trigger_device{}
MyTeleporter := teleporter_device{}

OnBegin<override>()<suspends>:void=
    MyTrigger.TriggeredEvent.Subscribe(OnEnter)

OnEnter(Agent:agent):void=
    MyTeleporter.Teleport(Agent)
```

### 物品发放

```verse
# 按钮 + 物品授予
MyButton := button_device{}
MyGranter := item_granter_device{}

OnBegin<override>()<suspends>:void=
    MyButton.InteractedWithEvent.Subscribe(OnPress)

OnPress(Agent:agent):void=
    MyGranter.GrantItem(Agent)
```

### 计分系统

```verse
# 淘汰管理 + 分数管理
MyElimManager := elimination_manager_device{}
MyScoreManager := score_manager_device{}

OnBegin<override>()<suspends>:void=
    MyElimManager.EliminationEvent.Subscribe(OnElim)

OnElim(Result:elimination_result):void=
    MyScoreManager.Activate(Result.EliminatingAgent)
```

### 敌人生成

```verse
# NPC生成器 + 生物管理
MySpawner := npc_spawner_device{}
MyManager := creature_manager_device{}

OnBegin<override>()<suspends>:void=
    MySpawner.Enable()
    MySpawner.SpawnedEvent.Subscribe(OnSpawn)
    
OnSpawn(Agent:agent):void=
    # NPC已生成
    Print("NPC spawned!")
```

## 🎓 学习路径建议

### 初学者 (第1-2周)
1. `trigger_device` - 学习事件系统
2. `button_device` - 学习玩家交互
3. `item_granter_device` - 学习物品系统
4. `teleporter_device` - 学习位置控制
5. `hud_message_device` - 学习UI显示

### 进阶 (第3-4周)
1. `timer_device` - 学习时间逻辑
2. `score_manager_device` - 学习计分系统
3. `npc_spawner_device` - 学习AI生成
4. `objective_device` - 学习任务系统
5. `barrier_device` - 学习场景控制

### 高级 (第5-8周)
1. `elimination_manager_device` - 战斗系统
2. `class_designer_device` - 职业系统
3. `round_settings_device` - 回合制游戏
4. `creature_manager_device` - AI管理
5. Patchwork系列 - 音乐系统

## 📚 相关资源

- **详细报告**: [uefn-device-system-research.md](./uefn-device-system-research.md)
- **API文档**: `libs/external/epic-docs-crawler/uefn_docs_organized/API/verse-api/fortnitedotcom/devices/`
- **教程文档**: `libs/external/epic-docs-crawler/uefn_docs_organized/Devices/`
- **官方文档**: [Epic Developer Portal](https://dev.epicgames.com/documentation/en-us/uefn/)

---

**最后更新**: 2026-01-04
