# Fortnite.com/UI 模块 API 参考文档

## 1. 模块概述

### 1.1 模块用途

`/Fortnite.com/UI` 模块提供了 UEFN/Verse 开发中用于创建和管理用户界面的核心 API。该模块专注于两个主要领域：

1. **自定义 UI Widget**: 创建按钮、文本框、滑块等可交互的 UI 组件
2. **HUD 元素控制**: 显示/隐藏 Fortnite 原生的 HUD 元素（如生命值、护盾、小地图等）

### 1.2 设计理念

- **声明式 UI**: Widget 使用声明式配置，在初始化时设置默认值
- **事件驱动**: 通过 `listenable` 事件系统处理用户交互
- **分层控制**: HUD 控制分为全局规则和玩家特定规则，玩家规则优先级更高
- **类型安全**: 利用 Verse 的类型系统确保 API 使用正确性

### 1.3 适用场景

| 场景类型 | 适用场景 | 示例 |
|---------|---------|------|
| **自定义 UI** | 游戏菜单、设置界面、计分板 | 创建游戏模式选择按钮 |
| **HUD 定制** | 修改默认 HUD 显示、创造模式特定界面 | 隐藏建造菜单、只显示生命值 |
| **交互提示** | 按钮点击、滑块调节 | 音量调节滑块、确认/取消按钮 |
| **玩家状态显示** | 自定义文本显示、动态信息更新 | 显示剩余玩家数、倒计时器 |

### 1.4 依赖关系

```verse
using {/Fortnite.com/UI}
using {/UnrealEngine.com/Temporary/UI}  # Widget 基类
using {/Verse.org/Colors}                # 颜色处理
using {/Fortnite.com/Playspaces}         # HUD 控制器访问
```

## 2. 核心类/接口清单

### 2.1 按功能分类

#### A. 按钮类 Widget

| 类名 | 继承关系 | 用途 | 样式特点 |
|-----|---------|------|---------|
| `text_button_base` | `widget` (抽象基类) | 按钮通用功能 | 不可直接实例化 |
| `button_loud` | `text_button_base` | 强调按钮 | 大而醒目的样式 |
| `button_regular` | `text_button_base` | 普通按钮 | 标准样式 |
| `button_quiet` | `text_button_base` | 低调按钮 | 安静的样式 |

#### B. 文本显示 Widget

| 类名 | 继承关系 | 用途 | 特性 |
|-----|---------|------|------|
| `text_block` | `text_base` | 文本显示 | 支持阴影效果 |
| `text_base` | `widget` (抽象基类) | 文本通用功能 | 继承自 UnrealEngine 模块 |

#### C. 输入控件 Widget

| 类名 | 继承关系 | 用途 | 特性 |
|-----|---------|------|------|
| `slider_regular` | `widget` | 数值滑块 | 支持最小/最大值、步进值 |

#### D. HUD 控制系统

| 类名/接口 | 类型 | 用途 |
|----------|------|------|
| `fort_hud_controller` | 接口 | HUD 元素显示/隐藏控制 |
| `hud_element_identifier` | 抽象基类 | HUD 元素标识符 |
| `creative_hud_identifier_*` | 具体类 | Creative 模式 HUD 标识 |
| `player_hud_identifier_*` | 具体类 | 玩家 HUD 标识 |
| `hud_identifier_*` | 具体类 | 其他 HUD 元素标识 |

### 2.2 完整 HUD 标识符清单

#### Creative 模式 HUD 元素 (24个)

| 标识符类名 | 控制的 HUD 元素 |
|-----------|----------------|
| `creative_hud_identifier_all` | 所有 Creative HUD 元素 |
| `creative_hud_identifier_build_menu` | 建造菜单 |
| `creative_hud_identifier_crafting_resources` | 制作资源 |
| `creative_hud_identifier_elimination_counter` | 淘汰计数器 |
| `creative_hud_identifier_equipped_item` | 装备物品显示 |
| `creative_hud_identifier_experience_level` | 经验等级 |
| `creative_hud_identifier_experience_supercharged` | 超级充能经验 |
| `creative_hud_identifier_experience_ui` | 经验 UI |
| `creative_hud_identifier_health` | 生命值 |
| `creative_hud_identifier_health_numbers` | 生命值数字 |
| `creative_hud_identifier_hud_info` | HUD 信息 |
| `creative_hud_identifier_interaction_prompts` | 交互提示 |
| `creative_hud_identifier_map_prompts` | 地图提示 |
| `creative_hud_identifier_minimap` | 小地图 |
| `creative_hud_identifier_pickup_stream` | 拾取流 |
| `creative_hud_identifier_player_count` | 玩家计数 |
| `creative_hud_identifier_player_inventory` | 玩家背包 |
| `creative_hud_identifier_round_info` | 回合信息 |
| `creative_hud_identifier_round_timer` | 回合计时器 |
| `creative_hud_identifier_shield_numbers` | 护盾数字 |
| `creative_hud_identifier_shields` | 护盾 |
| `creative_hud_identifier_storm_notifications` | 风暴通知 |
| `creative_hud_identifier_storm_timer` | 风暴计时器 |
| `creative_hud_identifier_team_info` | 团队信息 |

#### 玩家 HUD 元素 (1个)

| 标识符类名 | 控制的 HUD 元素 |
|-----------|----------------|
| `player_hud_identifier_all` | 所有玩家 HUD 元素 |

#### 世界资源 HUD 元素 (6个)

| 标识符类名 | 控制的 HUD 元素 |
|-----------|----------------|
| `hud_identifier_world_resource_wood` | 木材资源显示 |
| `hud_identifier_world_resource_stone` | 石材资源显示 |
| `hud_identifier_world_resource_metal` | 金属资源显示 |
| `hud_identifier_world_resource_permanite` | 永久矿石显示 |
| `hud_identifier_world_resource_gold_currency` | 金币显示 |
| `hud_identifier_world_resource_ingredient` | 材料显示 |

#### 视觉音效 HUD 元素 (6个)

| 标识符类名 | 控制的 HUD 元素 |
|-----------|----------------|
| `hud_identifier_visual_sound_effect_weapons` | 武器声音可视化 |
| `hud_identifier_visual_sound_effect_loot` | 战利品声音可视化 |
| `hud_identifier_visual_sound_effect_movement` | 移动声音可视化 |
| `hud_identifier_visual_sound_effect_vehicle` | 载具声音可视化 |
| `hud_identifier_visual_sound_effect_healing` | 治疗声音可视化 |
| `hud_identifier_visual_sound_effect_all` | 所有声音可视化 |

## 3. 关键 API 详解

### 3.1 按钮基类 - `text_button_base`

#### 类定义

```verse
text_button_base<native><public> := class<abstract><epic_internal>(widget)
```

**说明**: 按钮的抽象基类，不能直接实例化，必须使用具体子类。

#### 属性

```verse
DefaultText<localizes><native><public>:message
```

- **用途**: 按钮显示的默认文本
- **特性**: `<localizes>` 表示支持本地化
- **限制**: 仅在初始化时使用，不会被 `SetText` 修改

#### 方法

##### SetText - 设置按钮文本

```verse
SetText<native><public>(InText:message):void
```

- **参数**: `InText` - 要显示的文本（`message` 类型支持本地化）
- **返回值**: 无
- **用途**: 动态更新按钮文本
- **注意**: 这会覆盖 `DefaultText`

##### GetText - 获取当前文本

```verse
GetText<native><public>():string
```

- **参数**: 无
- **返回值**: 当前显示的文本（`string` 类型）
- **用途**: 读取按钮当前文本

#### 事件

##### OnClick - 按钮点击事件

```verse
OnClick<public>():listenable(widget_message)
```

- **类型**: `listenable(widget_message)` - 可订阅事件
- **触发时机**: 玩家点击按钮时
- **事件参数**:
  - `Player:player` - 触发点击的玩家
  - `Source:widget` - 触发事件的 Widget

**使用示例**:

```verse
MyButton.OnClick().Await()  # 等待点击
```

### 3.2 具体按钮类

#### button_loud - 强调按钮

```verse
button_loud<native><public> := class<final>(text_button_base)
```

- **样式**: 大而醒目，适合主要操作（如"开始游戏"）
- **使用场景**: 关键交互、主要 CTA

#### button_regular - 普通按钮

```verse
button_regular<native><public> := class<final>(text_button_base)
```

- **样式**: 标准样式，适合常规操作
- **使用场景**: 次要操作、选项按钮

#### button_quiet - 低调按钮

```verse
button_quiet<native><public> := class<final>(text_button_base)
```

- **样式**: 低调不突出，适合辅助操作
- **使用场景**: 取消按钮、返回按钮

### 3.3 文本显示 - `text_block`

#### 类定义

```verse
text_block<native><public> := class<final>(text_base)
```

#### 阴影相关属性

```verse
DefaultShadowOffset<native><public>:?vector2
DefaultShadowColor<native><public>:color
DefaultShadowOpacity<native><public>:type {_X:float where 0.000000 <= _X, _X <= 1.000000}
```

- **ShadowOffset**: 阴影偏移方向（可选值 `?vector2`）
- **ShadowColor**: 阴影颜色
- **ShadowOpacity**: 阴影不透明度（0.0-1.0）

#### 阴影方法

```verse
SetShadowOffset<native><public>(InShadowOffset:?vector2):void
GetShadowOffset<native><public>():?vector2

SetShadowColor<native><public>(InColor:color):void
GetShadowColor<native><public>():color

SetShadowOpacity<native><public>(InOpacity:type {_X:float where 0.000000 <= _X, _X <= 1.000000}):void
GetShadowOpacity<native><public>():type {_X:float where 0.000000 <= _X, _X <= 1.000000}
```

#### 继承自 text_base 的功能

- `SetText(InText:message):void` - 设置文本
- `GetText():string` - 获取文本
- `SetTextColor(InColor:color):void` - 设置文本颜色
- `SetTextSize(InSize:float):void` - 设置文本大小
- `SetTextOpacity(InOpacity:float):void` - 设置文本不透明度
- `SetJustification(InJustification:text_justification):void` - 设置对齐方式
- `SetOverflowPolicy(InOverflowPolicy:text_overflow_policy):void` - 设置溢出策略

### 3.4 滑块控件 - `slider_regular`

#### 类定义

```verse
slider_regular<native><public> := class<final>(widget)
```

#### 属性

```verse
DefaultValue<native><public>:float         # 默认值
DefaultMinValue<native><public>:float      # 最小值
DefaultMaxValue<native><public>:float      # 最大值
DefaultStepSize<native><public>:float      # 步进大小
```

#### 方法

##### 值控制

```verse
SetValue<native><public>(InValue:float):void
GetValue<native><public>():float
```

- **说明**: 设置的值会自动限制在 [MinValue, MaxValue] 范围内

##### 范围控制

```verse
SetMinValue<native><public>(InMinValue:float):void
GetMinValue<native><public>():float

SetMaxValue<native><public>(InMaxValue:float):void
GetMaxValue<native><public>():float
```

- **约束**: MaxValue 必须 >= MinValue，系统会自动保证

##### 步进控制

```verse
SetStepSize<native><public>(InValue:float):void
GetStepSize<native><public>():float
```

- **用途**: 控制使用键盘/手柄时的调整幅度

#### 事件

```verse
OnValueChanged<public>():listenable(widget_message)
```

- **触发时机**: 滑块值改变时
- **用途**: 实时响应数值变化

### 3.5 HUD 控制器 - `fort_hud_controller`

#### 接口定义

```verse
fort_hud_controller<native><public> := interface<epic_internal>
```

#### 获取 HUD 控制器

```verse
(Playspace:fort_playspace).GetHUDController<native><public>():fort_hud_controller
```

- **前置条件**: 需要 `fort_playspace` 对象
- **返回**: HUD 控制器实例

#### 全局 HUD 控制方法

##### ShowElements - 显示 HUD 元素

```verse
ShowElements<public>(HUDElements:[]hud_element_identifier):void
```

- **参数**: HUD 元素标识符数组
- **作用范围**: 所有玩家
- **优先级**: 可被玩家特定规则覆盖

##### HideElements - 隐藏 HUD 元素

```verse
HideElements<public>(HUDElements:[]hud_element_identifier):void
```

- **参数**: HUD 元素标识符数组
- **作用范围**: 所有玩家
- **优先级**: 可被玩家特定规则覆盖

##### ResetElementVisibility - 重置 HUD 元素

```verse
ResetElementVisibility<public>(HUDElements:[]hud_element_identifier):void
```

- **作用**: 重置为默认可见性
- **限制**: 不会清除玩家特定规则（需用 `ResetElementsForPlayer`）

#### 玩家特定 HUD 控制方法

##### ShowElementsForPlayer - 为单个玩家显示

```verse
ShowElementsForPlayer<public>(Player:player, HUDElements:[]hud_element_identifier):void
```

- **优先级**: 覆盖全局规则
- **用途**: 为特定玩家定制 HUD

##### HideElementsForPlayer - 为单个玩家隐藏

```verse
HideElementsForPlayer<public>(Player:player, HUDElements:[]hud_element_identifier):void
```

- **优先级**: 覆盖全局规则

##### ResetElementsForPlayer - 重置玩家特定规则

```verse
ResetElementsForPlayer<public>(Player:player, HUDElements:[]hud_element_identifier):void
```

- **作用**: 清除玩家特定规则，恢复全局规则
- **限制**: 不会影响全局规则

### 3.6 已弃用 API (⚠️ 不要使用)

```verse
@deprecated
(PlayerUI:player_ui).ShowHUDElements<native><public>(HUDElements:[]hud_element_identifier):void

@deprecated
(PlayerUI:player_ui).HideHUDElements<native><public>(HUDElements:[]hud_element_identifier):void

@deprecated
(PlayerUI:player_ui).ResetHUDElementVisibility<native><public>(HUDElements:[]hud_element_identifier):void
```

**替代方案**: 使用 `fort_playspace.GetHUDController()` 获取控制器后调用相应方法。

**弃用原因**: 旧方法影响所有玩家，不符合新架构的精细控制理念。

## 4. 代码示例

### 4.1 示例 1: 创建带点击事件的按钮

```verse
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Simulation }

# 简单的按钮控制器
button_controller := class:
    var MyButton:button_loud = button_loud{}
    var ClickCount:int = 0

    # 初始化按钮
    InitButton():void =
        # 设置按钮文本
        MyButton.SetText("Click Me!")
        
        # 订阅点击事件
        spawn { HandleClicks() }

    # 处理点击事件
    HandleClicks()<suspends>:void =
        loop:
            # 等待按钮被点击
            MyButton.OnClick().Await()
            
            # 增加计数
            set ClickCount += 1
            
            # 更新按钮文本
            MyButton.SetText("Clicked {ClickCount} times")
            
            # 如果点击 5 次，禁用按钮
            if (ClickCount >= 5):
                MyButton.SetEnabled(false)
                MyButton.SetText("Max clicks reached!")
                break

    # 将按钮添加到玩家 UI
    ShowButton(Player:player):void =
        if (PlayerUI := GetPlayerUI[Player]):
            PlayerUI.AddWidget(MyButton)
```

**关键点**:

- 使用 `spawn` 创建异步任务处理事件
- `Await()` 会挂起执行直到事件触发
- `loop` 可以持续监听事件

### 4.2 示例 2: 创建带阴影的文本显示

```verse
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }

# 分数显示器
score_display := class:
    var ScoreText:text_block = text_block{}
    var CurrentScore:int = 0

    # 初始化文本样式
    InitDisplay():void =
        # 设置基础文本属性
        ScoreText.SetText("Score: 0")
        ScoreText.SetTextSize(48.0)  # 字体大小
        ScoreText.SetTextColor(NamedColors.White)
        
        # 配置阴影效果，增强可读性
        ScoreText.SetShadowOffset(option{vector2{X := 2.0, Y := 2.0}})
        ScoreText.SetShadowColor(NamedColors.Black)
        ScoreText.SetShadowOpacity(0.8)
        
        # 设置文本对齐
        ScoreText.SetJustification(text_justification.Center)

    # 更新分数
    UpdateScore(NewScore:int):void =
        set CurrentScore = NewScore
        ScoreText.SetText("Score: {CurrentScore}")
        
        # 分数超过 100 时变红色
        if (CurrentScore > 100):
            ScoreText.SetTextColor(NamedColors.Red)

    # 添加到玩家 UI（居中显示）
    ShowDisplay(Player:player):void =
        if (PlayerUI := GetPlayerUI[Player]):
            # 使用自定义槽位配置
            Slot := player_ui_slot:
                ZOrder := 10  # 较高的 Z 轴顺序，显示在前面
                InputMode := ui_input_mode.None  # 不消费输入
            
            PlayerUI.AddWidget(ScoreText, Slot)
```

**关键点**:

- 阴影提高文本可读性，特别是在复杂背景上
- 使用 `vector2{X := ..., Y := ...}` 设置阴影偏移
- `player_ui_slot` 控制 Widget 的层级和输入行为

### 4.3 示例 3: 音量调节滑块

```verse
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Simulation }

# 音量控制器
volume_controller := class:
    var VolumeSlider:slider_regular = slider_regular{}
    var VolumeLabel:text_block = text_block{}

    # 初始化滑块
    InitSlider():void =
        # 配置滑块范围和步进
        VolumeSlider.SetMinValue(0.0)
        VolumeSlider.SetMaxValue(100.0)
        VolumeSlider.SetStepSize(5.0)  # 每次调整 5%
        VolumeSlider.SetValue(50.0)    # 默认 50%
        
        # 初始化标签
        VolumeLabel.SetText("Volume: 50%")
        VolumeLabel.SetTextSize(32.0)
        
        # 启动事件监听
        spawn { MonitorVolumeChanges() }

    # 监听音量变化
    MonitorVolumeChanges()<suspends>:void =
        loop:
            # 等待滑块值改变
            VolumeSlider.OnValueChanged().Await()
            
            # 获取当前值
            CurrentValue := VolumeSlider.GetValue()
            
            # 更新标签显示
            VolumeLabel.SetText("Volume: {Floor(CurrentValue)}%")
            
            # 实际应用音量设置
            ApplyVolumeSettings(CurrentValue)

    # 应用音量设置（示例）
    ApplyVolumeSettings(Volume:float):void =
        # 这里调用实际的音频 API
        Print("Setting volume to {Volume}%")

    # 显示到玩家 UI（使用垂直堆叠布局）
    ShowUI(Player:player):void =
        if (PlayerUI := GetPlayerUI[Player]):
            # 创建垂直堆叠容器
            Container := stack_box:
                Slots := array:
                    # 标签槽位
                    stack_box_slot:
                        Widget := VolumeLabel
                        HorizontalAlignment := horizontal_alignment.Center
                        Padding := margin{Top := 10.0, Bottom := 5.0}
                    # 滑块槽位
                    stack_box_slot:
                        Widget := VolumeSlider
                        HorizontalAlignment := horizontal_alignment.Fill
                        Padding := margin{Left := 20.0, Right := 20.0}
                Orientation := orientation.Vertical
            
            PlayerUI.AddWidget(Container)
```

**关键点**:

- `SetStepSize` 控制调整的精细度
- `OnValueChanged()` 提供实时反馈
- 使用 `stack_box` 容器组织多个 Widget

### 4.4 示例 4: 控制 HUD 元素显示

```verse
using { /Fortnite.com/UI }
using { /Fortnite.com/Playspaces }

# HUD 管理器
hud_manager := class:
    var Playspace:fort_playspace

    # 构造函数
    Init(InPlayspace:fort_playspace):void =
        set Playspace = InPlayspace

    # 设置极简 HUD 模式（只显示生命值和护盾）
    SetMinimalHUD():void =
        HUDController := Playspace.GetHUDController()
        
        # 隐藏所有元素
        HUDController.HideElements(array:
            creative_hud_identifier_all{}
        )
        
        # 只显示生命值和护盾
        HUDController.ShowElements(array:
            creative_hud_identifier_health{},
            creative_hud_identifier_shields{}
        )

    # 为观察者玩家设置特殊 HUD（隐藏交互元素）
    SetSpectatorHUD(Player:player):void =
        HUDController := Playspace.GetHUDController()
        
        # 为此玩家隐藏交互相关元素
        HUDController.HideElementsForPlayer(Player, array:
            creative_hud_identifier_interaction_prompts{},
            creative_hud_identifier_equipped_item{},
            creative_hud_identifier_player_inventory{}
        )
        
        # 但显示信息元素
        HUDController.ShowElementsForPlayer(Player, array:
            creative_hud_identifier_player_count{},
            creative_hud_identifier_team_info{}
        )

    # 重置某个玩家的 HUD 到默认状态
    ResetPlayerHUD(Player:player):void =
        HUDController := Playspace.GetHUDController()
        
        # 清除玩家特定规则
        HUDController.ResetElementsForPlayer(Player, array:
            creative_hud_identifier_all{}
        )

    # 隐藏所有建造相关元素（适合非建造模式）
    HideBuildingElements():void =
        HUDController := Playspace.GetHUDController()
        
        HUDController.HideElements(array:
            creative_hud_identifier_build_menu{},
            hud_identifier_world_resource_wood{},
            hud_identifier_world_resource_stone{},
            hud_identifier_world_resource_metal{}
        )
```

**关键点**:

- 使用 `creative_hud_identifier_all{}` 可以批量操作
- 玩家特定规则优先于全局规则
- `ResetElementsForPlayer` 清除玩家特定规则，恢复全局设置

### 4.5 示例 5: 复杂 UI 组合 - 游戏菜单

```verse
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }

# 游戏菜单控制器
game_menu := class:
    var MenuCanvas:canvas = canvas{}
    var TitleText:text_block = text_block{}
    var StartButton:button_loud = button_loud{}
    var SettingsButton:button_regular = button_regular{}
    var QuitButton:button_quiet = button_quiet{}
    var IsMenuVisible:logic = false

    # 初始化菜单
    InitMenu():void =
        # 设置标题
        TitleText.SetText("Game Menu")
        TitleText.SetTextSize(64.0)
        TitleText.SetTextColor(NamedColors.Yellow)
        
        # 设置按钮文本
        StartButton.SetText("Start Game")
        SettingsButton.SetText("Settings")
        QuitButton.SetText("Quit")
        
        # 构建布局
        BuildMenuLayout()
        
        # 启动事件处理
        spawn { HandleMenuEvents() }

    # 构建菜单布局
    BuildMenuLayout():void =
        # 使用 canvas 实现绝对定位
        
        # 标题位置（居中顶部）
        TitleSlot := MakeCanvasSlot(
            TitleText,
            vector2{X := 540.0, Y := 100.0},  # 1080p 屏幕居中
            option{vector2{X := 400.0, Y := 80.0}},
            ZOrder := 10
        )
        
        # 开始按钮（居中）
        StartSlot := MakeCanvasSlot(
            StartButton,
            vector2{X := 540.0, Y := 300.0},
            option{vector2{X := 300.0, Y := 60.0}},
            ZOrder := 10
        )
        
        # 设置按钮（居中偏下）
        SettingsSlot := MakeCanvasSlot(
            SettingsButton,
            vector2{X := 540.0, Y := 380.0},
            option{vector2{X := 300.0, Y := 60.0}},
            ZOrder := 10
        )
        
        # 退出按钮（居中底部）
        QuitSlot := MakeCanvasSlot(
            QuitButton,
            vector2{X := 540.0, Y := 460.0},
            option{vector2{X := 300.0, Y := 60.0}},
            ZOrder := 10
        )
        
        # 添加所有元素到 canvas
        MenuCanvas.AddWidget(TitleSlot)
        MenuCanvas.AddWidget(StartSlot)
        MenuCanvas.AddWidget(SettingsSlot)
        MenuCanvas.AddWidget(QuitSlot)

    # 处理菜单事件
    HandleMenuEvents()<suspends>:void =
        race:
            # 监听开始按钮
            block:
                loop:
                    StartButton.OnClick().Await()
                    HandleStartGame()
            # 监听设置按钮
            block:
                loop:
                    SettingsButton.OnClick().Await()
                    HandleSettings()
            # 监听退出按钮
            block:
                loop:
                    QuitButton.OnClick().Await()
                    HandleQuit()

    # 显示菜单
    ShowMenu(Player:player):void =
        if (PlayerUI := GetPlayerUI[Player]):
            if (not IsMenuVisible):
                # 添加菜单到 UI
                Slot := player_ui_slot:
                    ZOrder := 100  # 高优先级，显示在最前面
                    InputMode := ui_input_mode.All  # 消费所有输入
                
                PlayerUI.AddWidget(MenuCanvas, Slot)
                set IsMenuVisible = true

    # 隐藏菜单
    HideMenu(Player:player):void =
        if (PlayerUI := GetPlayerUI[Player]):
            if (IsMenuVisible):
                PlayerUI.RemoveWidget(MenuCanvas)
                set IsMenuVisible = false

    # 处理开始游戏
    HandleStartGame():void =
        Print("Starting game...")
        # 实际游戏启动逻辑

    # 处理设置
    HandleSettings():void =
        Print("Opening settings...")
        # 打开设置界面逻辑

    # 处理退出
    HandleQuit():void =
        Print("Quitting game...")
        # 退出游戏逻辑
```

**关键点**:

- `canvas` 用于绝对定位布局
- `MakeCanvasSlot` 创建固定位置的 Widget 槽位
- `race` 同时监听多个事件源
- `InputMode := ui_input_mode.All` 使菜单阻止游戏输入

## 5. 常见误区澄清

### 5.1 误区 1: 使用已弃用的 player_ui HUD 方法

**❌ 错误做法**:

```verse
PlayerUI := GetPlayerUI[Player]
PlayerUI.ShowHUDElements(array{creative_hud_identifier_health{}})
```

**✅ 正确做法**:

```verse
HUDController := Playspace.GetHUDController()
HUDController.ShowElements(array{creative_hud_identifier_health{}})
```

**原因**: 旧方法已标记为 `@deprecated`，缺乏玩家特定控制的灵活性。

### 5.2 误区 2: 混淆 Widget 默认属性和 Setter 方法

**❌ 错误理解**:

```verse
MyButton := button_regular:
    DefaultText := "Click"  # 设置后期望能修改

# 后续调用...
MyButton.DefaultText := "New Text"  # ❌ 不起作用！
```

**✅ 正确做法**:

```verse
MyButton := button_regular:
    DefaultText := "Click"  # 仅用于初始化

# 动态修改使用 Setter
MyButton.SetText("New Text")  # ✅ 正确
```

**说明**: `Default*` 属性只在 Widget 创建时读取一次，之后必须使用 `Set*` 方法。

### 5.3 误区 3: 不理解 HUD 规则优先级

**❌ 错误理解**:

```verse
# 全局隐藏生命值
HUDController.HideElements(array{creative_hud_identifier_health{}})

# 期望此玩家能看到生命值，但实际不会显示
# 因为理解错了优先级
```

**✅ 正确理解**:

```verse
# 全局隐藏生命值
HUDController.HideElements(array{creative_hud_identifier_health{}})

# 为特定玩家显示（玩家规则覆盖全局规则）
HUDController.ShowElementsForPlayer(Player, array{creative_hud_identifier_health{}})
# ✅ 现在此玩家能看到生命值
```

**规则**: 玩家特定规则 > 全局规则

### 5.4 误区 4: 忘记使用 spawn 处理异步事件

**❌ 错误做法**:

```verse
InitButton():void =
    MyButton.OnClick().Await()  # ❌ 编译错误！void 函数不能挂起
    Print("Clicked")
```

**✅ 正确做法**:

```verse
InitButton():void =
    spawn:  # ✅ 创建异步上下文
        MyButton.OnClick().Await()
        Print("Clicked")
```

**说明**: `Await()` 是挂起操作，必须在 `<suspends>` 函数或 `spawn` 块中使用。

### 5.5 误区 5: 滥用 creative_hud_identifier_all

**❌ 不推荐**:

```verse
# 想隐藏小地图
HUDController.HideElements(array{creative_hud_identifier_all{}})
HUDController.ShowElements(array{
    creative_hud_identifier_health{},
    creative_hud_identifier_shields{},
    # ... 手动显示其他 20+ 个元素
})
```

**✅ 推荐**:

```verse
# 只隐藏需要隐藏的元素
HUDController.HideElements(array{creative_hud_identifier_minimap{}})
```

**原因**: 使用 `*_all` 后需要重新显示大量元素，容易遗漏且维护困难。

### 5.6 误区 6: 不理解 Widget 的生命周期

**❌ 错误做法**:

```verse
ShowButton(Player:player):void =
    MyButton := button_regular{}  # 局部变量
    MyButton.SetText("Click")
    
    if (PlayerUI := GetPlayerUI[Player]):
        PlayerUI.AddWidget(MyButton)
    # MyButton 离开作用域，但 Widget 仍在 UI 中！
    # 后续无法修改此按钮

RemoveButton(Player:player):void =
    # ❌ 无法访问 MyButton 来移除
```

**✅ 正确做法**:

```verse
# 将 Widget 存储为类成员变量
button_manager := class:
    var MyButton:button_regular = button_regular{}
    
    ShowButton(Player:player):void =
        MyButton.SetText("Click")
        if (PlayerUI := GetPlayerUI[Player]):
            PlayerUI.AddWidget(MyButton)
    
    RemoveButton(Player:player):void =
        if (PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(MyButton)  # ✅ 能访问到
```

**说明**: Widget 添加到 UI 后不会自动销毁，需要保持引用以便管理。

## 6. 最佳实践

### 6.1 UI 组织

#### 使用类封装 UI 逻辑

```verse
# ✅ 推荐：UI 作为独立类
player_ui_manager := class:
    var Player:player
    var ScoreText:text_block = text_block{}
    var HealthBar:slider_regular = slider_regular{}
    
    Init(InPlayer:player):void = ...
    UpdateScore(Score:int):void = ...
    UpdateHealth(Health:float):void = ...

# ❌ 不推荐：UI 逻辑散落在游戏逻辑中
```

**优点**: 关注点分离、易于维护、可复用

#### 使用容器组织布局

```verse
# ✅ 使用 stack_box、canvas、overlay 等容器
Container := stack_box:
    Slots := array{...}
    Orientation := orientation.Vertical

# ❌ 避免手动管理大量独立 Widget
```

### 6.2 事件处理

#### 使用 race 处理多个事件

```verse
# ✅ 同时监听多个按钮
race:
    block:
        Button1.OnClick().Await()
        Handle1()
    block:
        Button2.OnClick().Await()
        Handle2()
```

#### 使用 loop 持续监听

```verse
# ✅ 持续监听事件
loop:
    MyButton.OnClick().Await()
    HandleClick()
```

### 6.3 HUD 管理

#### 集中管理 HUD 规则

```verse
# ✅ 创建 HUD 配置文件
hud_preset := struct:
    MinimalMode:[]hud_element_identifier = array{
        creative_hud_identifier_health{},
        creative_hud_identifier_shields{}
    }
    SpectatorMode:[]hud_element_identifier = array{...}

# 应用预设
ApplyHUDPreset(Preset:[]hud_element_identifier):void =
    HUDController.HideElements(array{creative_hud_identifier_all{}})
    HUDController.ShowElements(Preset)
```

#### 清晰区分全局和玩家规则

```verse
# ✅ 明确注释规则范围
# 全局规则：所有玩家默认行为
SetupGlobalHUD():void = ...

# 玩家规则：特定玩家的覆盖行为
SetupPlayerHUD(Player:player):void = ...
```

### 6.4 性能优化

#### 避免频繁更新 UI

```verse
# ❌ 每帧更新文本
loop:
    ScoreText.SetText("Score: {CurrentScore}")
    Sleep(0.0)

# ✅ 仅在值变化时更新
UpdateScore(NewScore:int):void =
    if (NewScore <> CurrentScore):
        set CurrentScore = NewScore
        ScoreText.SetText("Score: {CurrentScore}")
```

#### 复用 Widget 而非重建

```verse
# ❌ 频繁创建/销毁
ShowMessage(Text:string):void =
    NewText := text_block{}
    NewText.SetText(Text)
    PlayerUI.AddWidget(NewText)

# ✅ 复用已有 Widget
ShowMessage(Text:string):void =
    MessageText.SetText(Text)
    MessageText.SetVisibility(widget_visibility.Visible)
```

### 6.5 本地化支持

#### 使用 message 类型支持多语言

```verse
# ✅ 使用 message 类型（支持本地化）
MyButton := button_regular:
    DefaultText := "start_game"  # 引用本地化键

# ❌ 硬编码字符串
MyButton.SetText("Start Game")  # 无法本地化
```

### 6.6 错误处理

#### 使用 Verse 的 failure 机制

```verse
# ✅ 处理可能失败的操作
ShowUI(Player:player):void =
    if (PlayerUI := GetPlayerUI[Player]):
        PlayerUI.AddWidget(MyWidget)
    else:
        Print("Failed to get player UI")
```

### 6.7 调试技巧

#### 使用 Print 调试事件

```verse
HandleClicks()<suspends>:void =
    loop:
        Event := MyButton.OnClick().Await()
        Print("Button clicked by {Event.Player}")  # 调试信息
        HandleClick(Event.Player)
```

#### 使用可见性而非移除

```verse
# ✅ 调试时使用可见性控制
MyWidget.SetVisibility(widget_visibility.Hidden)  # 保留在 UI 树中

# ❌ 移除后无法轻易恢复
PlayerUI.RemoveWidget(MyWidget)
```

## 7. 参考资源

### 7.1 官方文档

- **Epic UEFN 文档**: <https://dev.epicgames.com/documentation/en-us/uefn>
- **Verse 语言参考**: <https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference>
- **UI API 文档**: <https://dev.epicgames.com/documentation/en-us/uefn/ui-in-verse>

### 7.2 相关 API 模块

#### 依赖模块

| 模块 | 导入路径 | 关系 |
|------|---------|------|
| **UnrealEngine UI** | `/UnrealEngine.com/Temporary/UI` | Widget 基类定义 |
| **Colors** | `/Verse.org/Colors` | 颜色处理 |
| **Playspaces** | `/Fortnite.com/Playspaces` | HUD 控制器访问 |
| **Simulation** | `/Verse.org/Simulation` | player 类型定义 |

#### 互补模块

| 模块 | 导入路径 | 用途 |
|------|---------|------|
| **Input** | `/Fortnite.com/Input` | 输入事件处理 |
| **Presentation** | `/Verse.org/Presentation` | 高级展示层 API |
| **Assets** | `/Verse.org/Assets` | UI 资源（纹理、材质） |

### 7.3 本地参考文件

#### API Digest 文件

- `Core/skills/programming/verseDev/shared/api-digests/Fortnite.digest.verse.md` - 完整 Fortnite API
- `Core/skills/programming/verseDev/shared/api-digests/UnrealEngine.digest.verse.md` - UnrealEngine UI 基类

#### 参考文档

- `Core/skills/programming/verseDev/shared/references/api-modules-list.md` - 所有 API 模块索引
- `Core/skills/programming/verseDev/shared/references/api-modules-research.md` - 模块能力分析
- `Core/skills/programming/verseDev/shared/references/verse-classes-and-objects.md` - Verse 类和对象系统

### 7.4 相关技能文档

- `Core/skills/programming/verseDev/verseComponent/SKILL.md` - 组件开发技能
- `Core/skills/programming/verseDev/verseEventFlow/SKILL.md` - 事件流设计技能
- `Core/skills/programming/verseDev/verseHelpers/SKILL.md` - 辅助函数技能

### 7.5 代码示例库

- `Core/skills/programming/verseDev/shared/code_library/` - Verse 代码示例库

---

## 附录 A: 快速参考表

### Widget 类型选择指南

| 需求 | 推荐 Widget | 替代方案 |
|------|------------|---------|
| 可点击按钮 | `button_loud/regular/quiet` | `button`（基础） |
| 静态文本 | `text_block` | - |
| 数值输入 | `slider_regular` | - |
| 图片显示 | `texture_block` | `material_block` |
| 纯色块 | `color_block` | - |
| 布局容器 | `stack_box`, `canvas`, `overlay` | - |

### HUD 元素类别

| 类别 | 标识符前缀 | 示例 |
|------|----------|------|
| Creative 模式 | `creative_hud_identifier_*` | `creative_hud_identifier_health` |
| 玩家通用 | `player_hud_identifier_*` | `player_hud_identifier_all` |
| 世界资源 | `hud_identifier_world_resource_*` | `hud_identifier_world_resource_wood` |
| 视觉音效 | `hud_identifier_visual_sound_effect_*` | `hud_identifier_visual_sound_effect_weapons` |

### 常用方法速查

| 操作 | 方法 | 参数 |
|------|------|------|
| 设置文本 | `SetText(message)` | `message` 类型 |
| 获取文本 | `GetText()` | 无 |
| 设置颜色 | `SetTextColor(color)` | `color` 类型 |
| 显示 Widget | `SetVisibility(Visible)` | `widget_visibility` 枚举 |
| 启用/禁用 | `SetEnabled(logic)` | `true`/`false` |
| 添加到 UI | `AddWidget(widget)` | `widget` 实例 |
| 移除 Widget | `RemoveWidget(widget)` | `widget` 实例 |

---

**文档版本**: 1.0  
**生成日期**: 2026-01-04  
**API 版本**: ++Fortnite+Release-39.11-CL-49242330  
**维护者**: UEFN/Verse 技能团队
