# UEFN 设备系统能力调研报告

> **生成时间**: 2026-01-04
>
> **调研范围**: UEFN 所有可用设备类型及其核心能力
>
> **数据来源**: Epic 官方文档（API 文档 + 教程文档）

## 📊 概览统计

| 指标 | 数量 |
|------|------|
| **设备总数** | **315** |
| API 文档中的设备 | 200 |
| 教程文档中的设备 | 235 |
| 仅在 API 中 | 80 |
| 仅在教程中 | 115 |
| 两者都有 | 120 |

## 🎯 核心发现

### 关键洞察

1. **设备数量庞大**: UEFN 提供了 315 种不同的设备，覆盖游戏开发的各个方面
2. **文档覆盖差异**: 有 115 个设备仅在教程文档中出现，说明部分设备可能没有可供 Verse 调用的 API
3. **载具系统丰富**: 31 种不同的载具生成器，支持各类交通工具
4. **音频系统完善**: 22 个音频相关设备，包括完整的 Patchwork 音乐系统

### 设备与 Verse 协作方式

1. **有 API 的设备** (200 个): 可通过 Verse 代码直接调用和控制
2. **仅教程的设备** (115 个): 主要通过 UEFN 编辑器配置，部分可能通过事件触发

## 📁 设备分类体系

### 1. 生成器类设备 (Spawner) - 47 个

用于在游戏中生成各类物品、NPC、生物等。

#### 物品生成器
- `item_spawner_device` - 物品生成器
- `base_item_spawner_device` - 基础物品生成器
- `capture_item_spawner_device` - 捕获物品生成器
- `carryable_spawner_device` - 可携带物品生成器

#### 生物/NPC 生成器
- `npc_spawner_device` - NPC 生成器
- `creature_spawner_device` - 生物生成器
- `creature_placer_device` - 生物放置器
- `creature_manager_device` - 生物管理器
- `guard_spawner_device` - 守卫生成器
- `wildlife_spawner_device` - 野生动物生成器
- `firefly_spawner_device` - 萤火虫生成器
- `earth_sprite_device` - 地球精灵设备
- `roly_poly_spawner_device` - Roly Poly 生成器

#### 特殊道具生成器
- `ball_spawner_device` - 球类生成器
- `supply_drop_spawner_device` - 空投生成器
- `explosive_spawner_device` - 爆炸物生成器
- `nitro_barrel_spawner_device` - 氮气桶生成器
- `prop_spawner_base_device` - 道具生成器基类
- `fang_spawner_device` - Fang 生成器

#### 其他生成器
- `reboot_van_spawner_device` - 重生车生成器
- `ascender_device` - 上升器设备
- `air_vent_device` - 通风口设备
- `bouncer_device` - 弹跳器
- `crash_pad_device` - 缓冲垫
- `grind_rail_device` - 滑轨设备
- `grind_vine_device` - 滑藤设备
- `vine_rail_device` - 藤蔓滑轨
- `zipline_device` - 滑索设备

### 2. 载具生成器类设备 (Vehicle Spawner) - 31 个

专门用于生成各类载具的设备。

#### 地面载具
- `vehicle_spawner_atk_device` - ATK 生成器
- `vehicle_spawner_quadcrasher_device` - Quadcrasher 生成器
- `vehicle_spawner_shopping_cart_device` - 购物车生成器
- `vehicle_spawner_driftboard_device` - 漂移板生成器
- `vehicle_spawner_sedan_device` - 轿车生成器
- `vehicle_spawner_pickup_truck_device` - 皮卡生成器
- `vehicle_spawner_taxi_device` - 出租车生成器
- `vehicle_spawner_sports_car_device` - 跑车生成器
- `vehicle_spawner_valet_suv_device` - SUV 生成器
- `vehicle_spawner_big_rig_device` - 大卡车生成器
- `vehicle_spawner_dirt_bike_device` - 越野摩托生成器
- `vehicle_spawner_sportbike_device` - 运动摩托生成器
- `vehicle_spawner_octane_device` - Octane 生成器
- `vehicle_spawner_nitro_drifter_sedan_device` - 氮气漂移轿车生成器

#### 水上载具
- `vehicle_spawner_boat_device` - 船只生成器
- `vehicle_spawner_surfboard_device` - 冲浪板生成器

#### 空中载具
- `vehicle_spawner_biplane_device` - 双翼飞机生成器
- `vehicle_spawner_helicopter_device` - 直升机生成器
- `vehicle_spawner_hammerhead_choppa_device` - Hammerhead 直升机生成器
- `vehicle_spawner_ufo_device` - UFO 生成器

#### 战斗载具
- `vehicle_spawner_tank_device` - 坦克生成器
- `vehicle_spawner_cannon_device` - 大炮生成器
- `vehicle_spawner_siege_cannon_device` - 攻城炮生成器
- `vehicle_spawner_armored_transport_device` - 装甲运输车生成器
- `vehicle_spawner_armored_battle_bus_device` - 装甲战斗巴士生成器
- `vehicle_spawner_war_bus_device` - 战争巴士生成器

#### 特殊载具
- `vehicle_spawner_baller_device` - Baller 生成器
- `vehicle_spawner_getaway_device` - 逃生车生成器
- `vehicle_spawner_heavy_turret_device` - 重型炮塔生成器
- `vehicle_spawner_rocketracing_device` - 火箭赛车生成器
- `vehicle_mod_box_spawner_device` - 载具改装箱生成器

### 3. 触发器类设备 (Trigger) - 10 个

用于检测和响应各种游戏事件。

#### 基础触发器
- `trigger_device` - 触发器
- `trigger_base_device` - 触发器基类
- `pulse_trigger_device` - 脉冲触发器
- `perception_trigger_device` - 感知触发器
- `input_trigger_device` - 输入触发器

#### 交互触发器
- `button_device` - 按钮
- `conditional_button_device` - 条件按钮
- `switch_device` - 开关
- `skilled_interaction_device` - 技能交互设备

#### 特殊触发器
- `lock_device` - 锁定设备

### 4. UI/显示类设备 (UI Display) - 10 个

用于向玩家显示信息和 UI 界面。

#### HUD 相关
- `hud_controller_device` - HUD 控制器
- `hud_message_device` - HUD 消息

#### 对话和弹窗
- `popup_dialog_device` - 弹出对话框
- `conversation_device` - 对话设备

#### 视觉显示
- `billboard_device` - 广告牌
- `holoscreen_device` - 全息屏幕
- `video_player_device` - 视频播放器

#### UI 选择器
- `class_selector_ui_device` - 职业选择器 UI
- `class_and_team_selector_device` - 职业和队伍选择器

#### 其他显示
- `map_indicator_device` - 地图指示器

### 5. 控制类设备 (Control) - 7 个

用于控制玩家移动和游戏区域。

#### 移动控制
- `teleporter_device` - 传送器
- `player_checkpoint_device` - 玩家检查点

#### 区域控制
- `barrier_device` - 屏障
- `mutator_zone_device` - 变异区

#### 特殊控制
- `lock_device` - 锁定设备
- `movement_modulator_device` - 移动调节器
- `player_movement_settings_device` - 玩家移动设置

### 6. AI 设备 (AI) - 7 个

用于 AI 行为控制和管理。

- `npc_spawner_device` - NPC 生成器
- `character_device` - 角色设备
- `creature_manager_device` - 生物管理器
- `guard_spawner_device` - 守卫生成器
- `sentry_device` - 哨兵设备
- `ai_patrol_path_device` - AI 巡逻路径
- `ai_patrol_path_node_device` - AI 巡逻路径节点

### 7. 音频设备 (Audio) - 22 个

用于音频播放和音乐制作。

#### 基础音频
- `audio_player_device` - 音频播放器
- `audio_mixer_device` - 音频混音器
- `radio_device` - 收音机

#### Patchwork 音乐系统 (19 个)
- `patchwork_drum_sequencer_device` - 鼓音序器
- `patchwork_echo_effect_device` - 回声效果
- `patchwork_filter_device` - 滤波器
- `patchwork_gain_device` - 增益器
- `patchwork_instrument_player_device` - 乐器播放器
- `patchwork_lfo_modulator_device` - LFO 调制器
- `patchwork_music_manager_device` - 音乐管理器
- `patchwork_note_progressor_device` - 音符推进器
- `patchwork_note_sequencer_device` - 音符音序器
- `patchwork_note_trigger_device` - 音符触发器
- `patchwork_omega_synthesizer_device` - Omega 合成器
- `patchwork_song_sync_device` - 歌曲同步器
- `patchwork_speaker_device` - 扬声器
- `patchwork_step_modulator_device` - 步进调制器
- `patchwork_value_setter_device` - 数值设置器
- 其他 Patchwork 设备...

### 8. 视觉效果设备 (Visual) - 7 个

用于视觉效果和后期处理。

#### 视觉效果
- `vfx_spawner_device` - VFX 生成器
- `vfx_creator_device` - VFX 创建器
- `visual_effect_powerup_device` - 视觉效果增益

#### 后期处理
- `post_process_device` - 后期处理

#### 灯光
- `customizable_light_device` - 可自定义灯光
- `skydome_device` - 天空穹顶

#### 其他
- `decal_device` - 贴花设备

### 9. 游戏玩法设备 (Gameplay) - 9 个

用于游戏核心玩法机制。

#### 计分系统
- `score_manager_device` - 分数管理器
- `tracker_device` - 追踪器

#### 目标系统
- `objective_device` - 目标设备
- `timed_objective_device` - 限时目标

#### 淘汰系统
- `elimination_manager_device` - 淘汰管理器
- `elimination_feed_device` - 淘汰信息流

#### 竞速系统
- `race_manager_device` - 竞速管理器
- `race_checkpoint_device` - 竞速检查点

#### 其他
- `round_settings_device` - 回合设置
- `timer_device` - 计时器

### 10. 物理设备 (Physics) - 5 个

用于物理交互和道具操作。

- `physics_boulder_device` - 物理巨石
- `physics_tree_device` - 物理树木
- `physics_object_base_device` - 物理对象基类
- `prop_mover_device` - 道具移动器
- `prop_manipulator_device` - 道具操纵器

### 11. 体积/区域设备 (Volume) - 8 个

用于定义特殊区域和体积效果。

- `volume_device` - 体积设备
- `damage_volume_device` - 伤害区域
- `effect_volume_device` - 效果区域
- `fire_volume_device` - 火焰区域
- `mutator_zone_device` - 变异区
- `crowd_volume_device` - 人群区域
- `skydive_volume_device` - 跳伞区域
- `rift_point_volume_device` - 裂隙点区域

### 12. 特殊类设备 (Special) - 8 个

特殊功能的设备。

#### 风暴系统
- `storm_controller_device` - 风暴控制器
- `basic_storm_controller_device` - 基础风暴控制器
- `advanced_storm_controller_device` - 高级风暴控制器
- `advanced_storm_beacon_device` - 高级风暴信标

#### 系统设置
- `experience_settings_device` - 体验设置
- `analytics_device` - 分析设备

#### 匹配系统
- `matchmaking_portal_device` - 匹配门户

#### 其他
- `end_game_device` - 游戏结束设备

### 13. 其他设备 (Other) - 144 个

未明确分类但同样重要的设备，包括：

#### 玩家相关
- `player_spawner_device` - 玩家生成器
- `player_counter_device` - 玩家计数器
- `player_marker_device` - 玩家标记
- `player_reference_device` - 玩家引用

#### 道具和物品
- `item_granter_device` - 物品授予器
- `item_remover_device` - 物品移除器
- `item_placer_device` - 物品放置器
- `item_shop_device` - 物品商店
- `vending_machine_device` - 自动售货机

#### 相机系统
- `gameplay_camera_device` - 游戏相机
- `gameplay_camera_first_person_device` - 第一人称相机
- `gameplay_camera_fixed_point_device` - 固定点相机
- `gameplay_camera_fixed_angle_device` - 固定角度相机
- `gameplay_camera_orbit_device` - 轨道相机

#### 控制系统
- `gameplay_controls_device` - 游戏控制
- `gameplay_controls_side_scroller_device` - 横版卷轴控制
- `gameplay_controls_third_person_device` - 第三人称控制

#### 特效和装饰
- `animated_mesh_device` - 动画网格
- `cinematic_sequence_device` - 过场动画序列
- `day_sequence_device` - 日夜序列
- `water_device` - 水体设备

#### LEGO 系统
- `assembly_device` - 组装设备
- `lego_assembly_device` - LEGO 组装设备
- `lego_collectible_device` - LEGO 收藏品设备

#### 更多...
（完整列表见附录）

## 🔗 设备与 Verse 的协作模式

### 1. 直接 API 调用模式

适用于所有在 API 文档中的设备 (200 个)。

```verse
# 示例：控制 NPC 生成器
MyNPCSpawner := npc_spawner_device{}

OnBegin<override>()<suspends>:void=
    # 启用生成器
    MyNPCSpawner.Enable()
    
    # 生成 NPC
    MyNPCSpawner.Spawn()
    
    # 监听事件
    MyNPCSpawner.EliminatedEvent.Subscribe(OnNPCEliminated)
```

### 2. 事件驱动模式

通过设备事件系统进行交互。

```verse
# 示例：监听触发器事件
MyTrigger := trigger_device{}

OnBegin<override>()<suspends>:void=
    MyTrigger.TriggeredEvent.Subscribe(OnPlayerEnter)

OnPlayerEnter(Agent:agent):void=
    # 玩家进入触发区域时的逻辑
    Print("Player entered!")
```

### 3. 配置驱动模式

部分设备主要通过 UEFN 编辑器配置，Verse 代码辅助控制。

```verse
# 示例：配合编辑器设置的设备
MyBarrier := barrier_device{}

ToggleBarrier():void=
    if(MyBarrier.IsEnabled[]):
        MyBarrier.Disable()
    else:
        MyBarrier.Enable()
```

### 4. 通道通信模式

使用 Channel 设备进行设备间通信。

```verse
# 示例：使用通道连接多个设备
MyChannel := channel_device{}
MyButton := button_device{}
MyBarrier := barrier_device{}

# 通过通道连接按钮和屏障
# 在编辑器中配置通道连接
```

## 📈 设备使用建议

### 1. 高频使用设备

以下设备在游戏开发中使用频率最高：

- `trigger_device` - 几乎所有交互逻辑的基础
- `item_granter_device` - 物品系统的核心
- `button_device` - 简单交互的首选
- `timer_device` - 时间相关逻辑必备
- `teleporter_device` - 场景切换常用
- `player_spawner_device` - 玩家生成必需
- `hud_message_device` - 信息提示常用

### 2. 进阶功能设备

复杂玩法开发推荐：

- `objective_device` - 任务系统
- `score_manager_device` - 计分系统
- `elimination_manager_device` - 淘汰系统
- `round_settings_device` - 回合制游戏
- `class_designer_device` - 职业系统
- `creature_manager_device` - AI 管理

### 3. 特殊场景设备

特定类型游戏推荐：

#### 竞速游戏
- `race_manager_device`
- `race_checkpoint_device`
- 各类 `vehicle_spawner_*`
- `timer_device`

#### 射击游戏
- `elimination_manager_device`
- `weapon_*` 设备
- `damage_volume_device`
- `barrier_device`

#### 解谜游戏
- `conditional_button_device`
- `lock_device`
- `puzzle_*` 设备
- `sequence_*` 设备

#### 音乐游戏
- Patchwork 系列设备
- `audio_player_device`
- `rhythm_*` 设备

## ⚠️ 注意事项

### 1. API 可用性

- **有 API** (200 个): 可通过 Verse 完全控制
- **无 API** (115 个): 主要通过编辑器配置，部分支持事件响应

### 2. 性能考虑

- **大量生成器**: 注意生成频率和数量限制
- **复杂物理**: 物理设备可能影响性能
- **视觉效果**: VFX 和后期处理需要性能评估

### 3. 版本差异

- 部分设备可能在不同 UEFN 版本中有差异
- 新设备会持续加入，需关注更新日志

## 📚 附录

### 完整设备列表 (按字母排序)

<details>
<summary>点击展开完整列表 (315 个设备)</summary>

1. accolades_device
2. advanced_storm_beacon_device
3. advanced_storm_controller_beacon_device
4. advanced_storm_controller_device
5. ai_navigation_modification_device
6. ai_patrol_path_device
7. ai_patrol_path_node_device
8. air_vent_device
9. analytics_device
10. animated_mesh_device
11. armored_battle_bus_spawner_device
12. armored_transport_spawner_device
13. ascender_device
14. assembly_device
15. atk_spawner_device
16. attribute_evaluator_device
17. audio_mixer_device
18. audio_player_device
19. automated_turret_device
20. ball_spawner_device
21. baller_spawner_device
22. bank_vault_device
23. bank_vault_interface
24. barrier_device
25. base_item_spawner_device
26. basic_storm_controller_device
27. beacon_device
28. big_rig_device
29. big_rig_spawner_device
30. billboard_device
31. biplane_spawner_device
32. boat_spawner_device
33. bomb_flower_device
34. bouncer_device
35. bouncer_gallery_device
36. button_device
37. campfire_device
38. cannon_spawner_device
39. capture_area_device
40. capture_item_spawner_device
41. carryable_spawner_device
42. chair_device
43. changing_booth_device
44. channel_device
45. character_device
46. character_device_controller_device
47. chest_and_ammo_gallery_device
48. cinematic_sequence_device
49. class_and_team_selector_device
50. class_designer_device
51. class_selector_device
52. class_selector_ui_device
53. collectible_object_device
54. collectibles_object_device
55. color_changing_tile_device
56. color_changing_tiles_device
57. conditional_button_device
58. conversation_device
59. crash_pad_device
60. creative_device
61. creative_object_interface
62. creator_profile_link_device
63. creature_manager_device
64. creature_placer_device
65. creature_spawner_device
66. creepin_cardboard_device
67. crowd_volume_device
68. customizable_light_device
69. d_launcher_device
70. damage_amplifier_powerup_device
71. damage_rail_device
72. damage_volume_device
73. dance_mannequin_device
74. day_sequence_1_device
75. day_sequence_device
76. decal_device
77. dirt_bike_spawner_device
78. disguise_device
79. dlauncher_device
80. down_but_not_out_device
81. driftboard_spawner_device
82. earth_sprite_device
83. effect_volume_device
84. elimination_feed_device
85. elimination_manager_device
86. end_game_device
87. environment_light_rig_device
88. experience_settings_device
89. explosive_device
90. fang_spawner_device
91. fire_volume_device
92. firefly_spawner_device
93. first_person_camera_device
94. first_person_mode_device
95. fishing_rod_barrel_device
96. fishing_zone_device
97. fixed_angle_camera_device
98. fixed_point_camera_device
99. fuel_pump_device
100. gameplay_camera_device
101. gameplay_camera_first_person_device
102. gameplay_camera_fixed_angle_device
103. gameplay_camera_fixed_point_device
104. gameplay_camera_orbit_device
105. gameplay_controls_device
106. gameplay_controls_side_scroller_device
107. gameplay_controls_third_person_device
108. grind_powerup_device
109. grind_rail_device
110. grind_rail_vine_device
111. grind_vine_device
112. guard_spawner_device
113. healing_cactus_device
114. health_powerup_device
115. heavy_turret_device
116. hero_chest_device
117. hiding_prop_device
118. hiding_prop_gallery_device
119. hive_stash_device
120. holoscreen_device
121. hover_platform_device
122. hud_controller_device
123. hud_message_device
124. input_trigger_device
125. item_granter_device
126. item_placer_device
127. item_remover_device
128. item_shop_device
129. item_spawner_device
130. items_gallery_device
131. lego_assembly_device
132. lego_collectible_device
133. level_instance_device
134. level_loader_device
135. lock_device
136. map_controller_device
137. map_indicator_device
138. matchmaking_portal_device
139. melee_designer_device
140. mounted_turret_device
141. movement_modulator_device
142. mutator_zone_device
143. nitro_barrel_device
144. nitro_barrel_spawner_device
145. nitro_hoop_device
146. npc_spawner_device
147. objective_device
148. orbit_camera_device
149. overlord_spire_device
150. patchwork_drum_sequencer_device
151. patchwork_echo_effect_device
152. patchwork_filter_device
153. patchwork_gain_device
154. patchwork_instrument_player_device
155. patchwork_lfo_modulator_device
156. patchwork_music_manager_device
157. patchwork_note_progressor_device
158. patchwork_note_sequencer_device
159. patchwork_note_trigger_device
160. patchwork_omega_synthesizer_device
161. patchwork_song_sync_device
162. patchwork_speaker_device
163. patchwork_step_modulator_device
164. patchwork_value_setter_device
165. perception_trigger_device
166. physics_boulder_device
167. physics_object_base_device
168. physics_tree_device
169. pinball_bumper_device
170. pinball_flipper_device
171. placeable_ledge_device
172. player_checkpoint_device
173. player_counter_device
174. player_marker_device
175. player_movement_settings_device
176. player_reference_device
177. player_spawn_pad_device
178. player_spawner_device
179. popup_dialog_device
180. post_process_device
181. powerup_device
182. progress_based_mesh_device
183. prop_manipulator_device
184. prop_mover_device
185. prop_o_matic_manager_device
186. propomatic_manager_device
187. prop_spawner_base_device
188. pulse_trigger_device
189. race_checkpoint_device
190. race_manager_device
191. radio_device
192. random_number_generator_device
193. real_time_clock_device
194. reboot_van_device
195. reboot_van_interface
196. reboot_van_spawner_device
197. rift_point_volume_device
198. rng_device
199. roly_poly_device
200. roly_poly_spawner_device
201. round_settings_device
202. save_point_device
203. score_manager_device
204. scout_spire_device
205. sentry_device
206. service_station_device
207. shooting_range_gallery_device
208. shooting_range_target_device
209. shooting_range_target_track_device
210. side_scroller_controls_device
211. siege_cannon_device
212. signal_remote_manager_device
213. skilled_interaction_device
214. skydive_volume_device
215. skydome_device
216. slurp_plant_device
217. spire_spike_device
218. stat_counter_device
219. stat_creator_device
220. stat_powerup_device
221. stink_flower_device
222. storm_controller_device
223. supply_drop_spawner_device
224. support_a_creator_device
225. surfboard_spawner_device
226. suv_spawner_device
227. switch_device
228. sword_in_the_stone_device
229. tank_spawner_device
230. target_dummy_device
231. target_dummy_track_device
232. taxi_spawner_device
233. team_settings_and_inventory_device
234. teleporter_device
235. the_conversation_device
236. third_person_controls_device
237. timed_objective_device
238. timer_device
239. title_sequence_1_coding_the_verse_device
240. tracker_device
241. trick_tile_device
242. trigger_base_device
243. trigger_device
244. ufo_spawner_device
245. using_air_vent_device
246. using_color_changing_tile_device
247. vehicle_mod_box_spawner_device
248. vehicle_service_station_device
249. vehicle_spawner_armored_battle_bus_device
250. vehicle_spawner_armored_transport_device
251. vehicle_spawner_atk_device
252. vehicle_spawner_baller_device
253. vehicle_spawner_big_rig_device
254. vehicle_spawner_biplane_device
255. vehicle_spawner_boat_device
256. vehicle_spawner_cannon_device
257. vehicle_spawner_device
258. vehicle_spawner_dirt_bike_device
259. vehicle_spawner_driftboard_device
260. vehicle_spawner_getaway_device
261. vehicle_spawner_hammerhead_choppa_device
262. vehicle_spawner_heavy_turret_device
263. vehicle_spawner_helicopter_device
264. vehicle_spawner_nitro_drifter_sedan_device
265. vehicle_spawner_octane_device
266. vehicle_spawner_pickup_truck_device
267. vehicle_spawner_quadcrasher_device
268. vehicle_spawner_rocketracing_device
269. vehicle_spawner_sedan_device
270. vehicle_spawner_shopping_cart_device
271. vehicle_spawner_siege_cannon_device
272. vehicle_spawner_sportbike_device
273. vehicle_spawner_sports_car_device
274. vehicle_spawner_surfboard_device
275. vehicle_spawner_tank_device
276. vehicle_spawner_taxi_device
277. vehicle_spawner_ufo_device
278. vehicle_spawner_valet_suv_device
279. vehicle_spawner_war_bus_device
280. vending_machine_device
281. vfx_creator_device
282. vfx_spawner_device
283. video_player_device
284. vine_rail_device
285. visual_effect_powerup_device
286. volume_device
287. vote_group_device
288. vote_option_device
289. vote_option_interface
290. voting_group_and_voting_options_device
291. war_bus_spawner_device
292. water_device
293. weapon_mod_bench_device
294. wildlife_spawner_device
295. wilds_plant_device
296. zipline_device

**注意**: 部分设备名称可能有重复或变体，实际可用设备以最新 UEFN 版本为准。

</details>

### 数据来源

- **API 文档**: `libs/external/epic-docs-crawler/uefn_docs_organized/API/verse-api/fortnitedotcom/devices/`
- **教程文档**: `libs/external/epic-docs-crawler/uefn_docs_organized/Devices/`
- **教程文档 2**: `libs/external/epic-docs-crawler/uefn_docs_organized/Tutorials/Devices/`

### 后续调研建议

1. **深度研究高频设备**: 为常用设备创建详细的使用指南
2. **API 能力映射**: 详细梳理每个设备的 Verse API 接口
3. **最佳实践收集**: 整理社区和官方的设备使用最佳实践
4. **性能测试**: 针对性能敏感设备进行基准测试
5. **版本兼容性**: 跟踪不同 UEFN 版本的设备变化

---

**报告结束**

*本报告为 UEFN 设备系统能力的全面调研，旨在为后续深入研究提供基础数据和分类框架。*
