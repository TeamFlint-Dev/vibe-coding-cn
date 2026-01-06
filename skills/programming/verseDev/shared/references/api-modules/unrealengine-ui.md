# UnrealEngine.com/UI 模块完整参考手册

> **文档类型**：API 参考文档  
> **模块路径**：`/UnrealEngine.com/Temporary/UI`  
> **目标平台**：UEFN (Unreal Editor for Fortnite)  
> **最后更新**：2026-01-04

---

## 文档说明

本文档深度调研了 UnrealEngine.com/UI 模块的所有 API，旨在消除开发者对该模块的错误认知，建立准确的 API 能力参考。

**重要提示**：
- ✅ 所有 API 均来自 Epic Games 官方 Verse API Digest
- ✅ 模块当前位于 `/UnrealEngine.com/Temporary/UI` 路径下
- ⚠️ 该模块标记为 `Temporary`，未来可能会有 API 变化
- ✅ 本文档基于 `++Fortnite+Release-39.11-CL-49242330` 版本

---

## 目录

1. [模块概述](#模块概述)
2. [核心类/接口清单](#核心类接口清单)
3. [关键 API 详解](#关键-api-详解)
4. [代码示例](#代码示例)
5. [常见误区澄清](#常见误区澄清)
6. [最佳实践](#最佳实践)
7. [参考资源](#参考资源)

---

## 模块概述

### 模块用途

`/UnrealEngine.com/Temporary/UI` 模块提供了在 UEFN 中创建和管理**用户界面 (UI)**的核心功能。该模块允许开发者：

- 为玩家创建自定义 UI 界面
- 管理 Widget（UI 控件）的生命周期
- 处理用户交互事件
- 控制 UI 元素的布局和样式

### 设计理念

该模块采用以下设计理念：

1.**Widget 体系架构**：所有 UI 元素都继承自基类 `widget`
2. **Slot 布局系统**：使用 Slot 结构体来配置 Widget 的布局参数
3. **事件驱动交互**：通过 `listenable` 事件处理用户交互
4. **玩家独立 UI**：每个玩家拥有独立的 `player_ui` 实例

### 适用场景

- **游戏 HUD**：显示分数、计时器、玩家状态等信息
- **交互式菜单**：创建按钮、选项菜单等交互界面
- **信息展示**：显示文本、图片、颜色块等视觉元素
- **动态 UI**：运行时创建、修改和移除 UI 元素

### 依赖模块

```verse
using {/Verse.org/Assets}
using {/Verse.org/Colors}
using {/UnrealEngine.com/Temporary/SpatialMath}
using {/Verse.org/Simulation}

```

---

## 核心类/接口清单

### 按功能分类组织

#### 1. UI 管理类

| 类名 | 用途 | 类型 |
|------|------|------|
| `player_ui` | 玩家 UI 的主接口，管理 Widget 的添加/移除 | class (final) |
| `GetPlayerUI()` | 获取玩家的 UI 实例 | function |

#### 2. 基础 Widget 类

| 类名 | 用途 | 类型 |
|------|------|------|
| `widget` | 所有 UI 元素的抽象基类 | class (abstract) |

#### 3. 容器 Widget 类

| 类名 | 用途 | 类型 |
|------|------|------|
| `canvas` | 绝对定位容器，支持自由布局 | class (final) |
| `overlay` | 堆叠容器，Widget 层层叠加 | class (final) |
| `stack_box` | 线性布局容器，水平或垂直排列 | class (final) |

#### 4. 内容 Widget 类

| 类名 | 用途 | 类型 |
|------|------|------|
| `button` | 可点击按钮，支持事件监听 | class (final) |
| `color_block` | 纯色块，用于背景或分隔 | class (final) |
| `texture_block` | 纹理/图片显示 | class |
| `material_block` | 材质显示 | class |
| `text_base` | 文本显示基类 | class (abstract) |

#### 5. 配置结构体

| 结构体名 | 用途 |
|| 状态 | 可见性 | 占用布局空间 | 使用场景 |
|------|--------|-------------|----------|-|------|
| `player_ui_slot` | Widget 添加到 player_ui 时的配置 |
| `canvas_slot` | Canvas 子 Widget 的布局配置 |
| `overlay_slot` | Overlay 子 Widget 的布局配置 |
| `stack_box_slot` | Stack Box 子 Widget 的布局配置 |
| `button_slot` | Button 子 Widget 的配置 |
| `anchors` | 锚点配置，控制相对定位 |
| `margin` | 边距配置 |
| `widget_message` | Widget 事件参数 |

#### 6. 枚举类型

| 枚举名 | 用途 | 值 |
|| 状态 | 可见性 | 占用布局空间 | 使用场景 |
|------|--------|-------------|----------||------|-----|
| `widget_visibility` | Widget 可见性状态 | Visible, Collapsed, Hidden |
| `ui_input_mode` | 输入消费模式 | None, All |
| `orientation` | 布局方向 | Horizontal, Vertical |
| `horizontal_alignment` | 水平对齐 | Center, Left, Right, Fill |
| `vertical_alignment` | 垂直对齐 | Center, Top, Bottom, Fill |
| `image_tiling` | 图片平铺模式 | Stretch, Repeat |
| `text_justification` | 文本对齐 | Left, Center, Right, InvariantLeft, InvariantRight |
| `text_overflow_policy` | 文本溢出策略 | Clip, Ellipsis |

---

## 关键 API 详解

### 1. GetPlayerUI() - 获取玩家 UI

**功能**：获取与指定玩家关联的 `player_ui` 实例。

**签名**：

```verse
GetPlayerUI<native><public>(Player:player)<transacts><decides>:player_ui

```

**参数**：
- `Player:player` - 目标玩家对象

**返回值**：
- **类型**：`player_ui`
- **说明**：该玩家的 UI 管理器实例
- **失败条件**：如果玩家没有关联的 player_ui，则失败 (`<decides>`)

**使用限制**：
- 需要在 `<transacts>` 上下文中调用
- 必须处理失败情况（使用 `if` 或 `?` 操作符）

---

### 2. player_ui 类

**功能**：管理玩家 UI，添加、移除 Widget 和设置焦点。

#### 2.1 AddWidget() - 添加 Widget

**签名**：

```verse
# 默认配置
AddWidget<native><public>(Widget:widget):void

# 自定义配置
AddWidget<native><public>(Widget:widget, Slot:player_ui_slot):void

```

**参数**：
- `Widget:widget` - 要添加的 Widget
- `Slot:player_ui_slot` (可选) - 布局配置，包括 ZOrder 和 InputMode

**返回值**：无

**注意事项**：
- 同一个 Widget 不能添加多次
- Widget 会在调用后立即显示（除非设置为 Collapsed/Hidden）

#### 2.2 RemoveWidget() - 移除 Widget

**签名**：

```verse
RemoveWidget<native><public>(Widget:widget):void

```

**参数**：
- `Widget:widget` - 要移除的 Widget

**返回值**：无

**注意事项**：
- 移除不存在的 Widget 不会报错
- Widget 被移除后可以重新添加

#### 2.3 SetFocus() - 设置焦点

**签名**：

```verse
SetFocus<native><public>(Widget:widget):void

```

**参数**：
- `Widget:widget` - 要获得焦点的 Widget

**返回值**：无

**特殊行为**：
- 如果在 `AddWidget` 之前调用，Widget 会在添加后获得焦点
- 如果 Widget 不可聚焦，则无效果
- 多次调用会覆盖之前的焦点设置

---

### 3. widget 基类

**功能**：所有 UI 元素的基类，提供通用的显示和交互控制。

#### 3.1 SetVisibility() - 设置可见性

**签名**：

```verse
SetVisibility<native><public>(InVisibility:widget_visibility):void

```

**参数**：
- `InVisibility:widget_visibility` - 可见性状态
  - `widget_visibility.Visible` - 可见并占用布局空间
  - `widget_visibility.Collapsed` - 不可见且不占用布局空间
  - `widget_visibility.Hidden` - 不可见但占用布局空间

#### 3.2 SetEnabled() - 设置启用状态

**签名**：

```verse
SetEnabled<native><public>(InIsEnabled:logic):void

```

**参数**：
- `InIsEnabled:logic` - `true` 启用，`false` 禁用

**说明**：
- 禁用的 Widget 不能交互，但仍然可见

#### 3.3 GetParentWidget() - 获取父 Widget

**签名**：

```verse
GetParentWidget<native><public>()<transacts><decides>:widget

```

**返回值**：父 Widget，如果没有父 Widget 则失败

**失败情况**：
- Widget 不在 player_ui 中
- Widget 是根 Widget

#### 3.4 GetRootWidget() - 获取根 Widget

**签名**：

```verse
GetRootWidget<native><public>()<transacts><decides>:widget

```

**返回值**：
- 添加到 player_ui 的根 Widget
- 根 Widget 会返回自身

**失败情况**：
- Widget 不在 player_ui 中

---

### 4. canvas 类 - 绝对定位容器

**功能**：允许精确控制子 Widget 的位置和大小。

#### 4.1 初始化

**签名**：

```verse
canvas<native><public> := class<final>(widget):
    Slots<native><public>:[]canvas_slot = external {}

```

**属性**：
- `Slots` - 初始子 Widget 列表（仅用于初始化）

#### 4.2 AddWidget() - 添加子 Widget

**签名**：

```verse
AddWidget<native><public>(Slot:canvas_slot):void

```

**参数**：
- `Slot:canvas_slot` - 包含 Widget 和布局配置

#### 4.3 MakeCanvasSlot() - 创建 Canvas Slot

**签名**：

```verse
MakeCanvasSlot<native><public>(
    Widget:widget,
    Position:vector2,
    ?Size:vector2 = external {},
    ?ZOrder:type {_X:int where 0 <= _X, _X <= 2147483647} = external {},
    ?Alignment:vector2 = external {}
)<computes>:canvas_slot

```

**参数**：
- `Widget` - 子 Widget
- `Position` - 位置（像素，1080p 基准）
- `Size` (可选) - 大小。如果不设置，使用 Widget 的期望大小
- `ZOrder` (可选) - Z 顺序，值越大越靠前
- `Alignment` (可选) - 对齐点/枢轴点，范围 (0.0, 0.0) 到 (1.0, 1.0)

**注意事项**：
- 不设置 Size 时，`SizeToContent` 自动设为 `true`
- Widget 不会随父容器缩放而移动

---

### 5. button 类 - 按钮

**功能**：可点击的按钮，支持事件监听。

#### 5.1 OnClick 事件

**签名**：

```verse
OnClick<public>():listenable(widget_message) = external {}

```

**事件参数**：
- `widget_message` 包含：
  - `Player:player` - 触发事件的玩家
  - `Source:widget` - 事件源 Widget（即该按钮）

**使用示例**：

```verse
MyButton.OnClick().Subscribe(OnButtonClicked)

OnButtonClicked(Msg:widget_message):void =
    Print("Player {Msg.Player} clicked the button")

```

#### 5.2 其他事件

- `HighlightEvent()` - 按钮被高亮时触发
- `UnhighlightEvent()` - 按钮失去高亮时触发

---

### 6. overlay 类 - 堆叠容器

**功能**：Widget 从下到上堆叠，后添加的在上层。

**特点**：
- 子 Widget 按添加顺序堆叠
- 所有子 Widget 共享相同的空间
- 适合创建背景+内容的组合

---

### 7. stack_box 类 - 线性布局容器

**功能**：水平或垂直排列子 Widget。

**属性**：
- `Orientation:orientation` - 必须设置，决定排列方向

**Slot 配置**：
- `Distribution:?float` - 空间分配比例
  - 不设置：使用 Widget 期望大小
  - 设置值：按比例分配可用空间

---

### 8. color_block 类 - 颜色块

**功能**：显示纯色矩形。

**主要方法**：
- `SetColor(InColor:color)` - 设置颜色
- `SetOpacity(InOpacity:float)` - 设置不透明度 (0.0-1.0)
- `SetDesiredSize(InDesiredSize:vector2)` - 设置期望大小

**注意事项**：
- `Default*` 属性仅用于初始化，运行时修改无效
- 使用 `Set*` 方法动态修改属性

---

### 9. text_base 类 - 文本基类

**功能**：显示文本内容。

**主要方法**：
- `SetText(InText:message)` - 设置文本内容
- `SetTextColor(InColor:color)` - 设置文本颜色
- `SetTextSize(InSize:float)` - 设置文本大小
- `SetTextOpacity(InOpacity:float)` - 设置文本不透明度
- `SetJustification(InJustification:text_justification)` - 设置对齐方式
- `SetOverflowPolicy(InOverflowPolicy:text_overflow_policy)` - 设置溢出策略

**本地化支持**：
- `DefaultText` 属性标记为 `<localizes>`，支持多语言

---

### 10. player_ui_slot 结构体

**功能**：配置 Widget 添加到 player_ui 时的行为。

**字段**：

```verse
player_ui_slot<native><public> := struct:
    ZOrder<native><public>:type {_X:int where 0 <= _X, _X <= 2147483647} = external {}
    InputMode<native><public>:ui_input_mode = external {}

```

**说明**：
- `ZOrder` - 渲染顺序，值越大越靠前（默认值可能为 0）
- `InputMode` - 输入消费模式：
  - `ui_input_mode.None` - 不消费输入
  - `ui_input_mode.All` - 消费所有输入

---

### 11. margin 结构体

**功能**：定义 Widget 四边的间距。

**字段**：

```verse
margin<native><public> := struct:
    Left<native><public>:float = external {}
    Top<native><public>:float = external {}
    Right<native><public>:float = external {}
    Bottom<native><public>:float = external {}

```

**单位**：
- 像素（基于 1080p 分辨率）
- `1.0` = 1 像素 @ 1080p

---

### 12. anchors 结构体

**功能**：定义 Widget 相对于父容器的锚点。

**字段**：

```verse
anchors<native><public> := struct:
    Minimum<native><public>:vector2 = external {}  # (left, top)
    Maximum<native><public>:vector2 = external {}  # (right, bottom)

```

**值范围**：
- `0.0` 到 `1.0`
- `(0.0, 0.0)` 对应左上角
- `(1.0, 1.0)` 对应右下角

**典型用法**：
- 固定大小：`Minimum == Maximum`
- 拉伸填充：`Minimum != Maximum`

---

## 代码示例

### 示例 1：创建简单的分数显示 HUD

```verse
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }

score_hud := class(creative_device):
    var ScoreText:text_base = text_base{
        DefaultText := "Score: 0"
        DefaultTextColor := NamedColors.White
        DefaultTextSize := 32.0
    }

    var CurrentScore:int = 0

    OnBegin<override>()<suspends>:void =
        # 等待玩家加入
        AllPlayers := GetPlayspace().GetPlayers()
        if (Player := AllPlayers[0]):
            ShowScoreUI(Player)

    ShowScoreUI(Player:player):void =
        if (PlayerUI := GetPlayerUI(Player)):
            # 创建容器
            Container := canvas{
                Slots := array{}
            }
            
            # 添加分数文本到画布
            Container.AddWidget(
                MakeCanvasSlot(
                    ScoreText,
                    vector2{X := 50.0, Y := 50.0},  # 左上角位置
                    Size := vector2{X := 300.0, Y := 60.0}
                )
            )
            
            # 添加到玩家 UI
            PlayerUI.AddWidget(
                Container,
                player_ui_slot{
                    ZOrder := 100,
                    InputMode := ui_input_mode.None  # 不拦截输入
                }
            )

    UpdateScore(NewScore:int):void =
        set CurrentScore = NewScore
        ScoreText.SetText("Score: {NewScore}")

```

**示例说明**：
- 创建了一个显示分数的文本 Widget
- 使用 Canvas 进行绝对定位
- 设置 ZOrder 确保显示在其他 UI 之上
- 使用 `ui_input_mode.None` 确保不阻止游戏输入

---

### 示例 2：交互式按钮菜单

```verse
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }

button_menu := class(creative_device):
    var StartButton:button = button{}
    var OptionsButton:button = button{}

    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        if (Player := AllPlayers[0]):
            ShowMenu(Player)

    ShowMenu(Player:player):void =
        if (PlayerUI := GetPlayerUI(Player)):
            # 创建按钮内容
            StartText := text_base{
                DefaultText := "Start Game"
                DefaultTextColor := NamedColors.White
                DefaultTextSize := 24.0
            }
            
            OptionsText := text_base{
                DefaultText := "Options"
                DefaultTextColor := NamedColors.White
                DefaultTextSize := 24.0
            }
            
            # 设置按钮内容
            set StartButton = button{
                Slot := button_slot{
                    Widget := StartText,
                    HorizontalAlignment := horizontal_alignment.Center,
                    VerticalAlignment := vertical_alignment.Center,
                    Padding := margin{Left := 10.0, Top := 10.0, Right := 10.0, Bottom := 10.0}
                }
            }
            
            set OptionsButton = button{
                Slot := button_slot{
                    Widget := OptionsText,
                    HorizontalAlignment := horizontal_alignment.Center,
                    VerticalAlignment := vertical_alignment.Center,
                    Padding := margin{Left := 10.0, Top := 10.0, Right := 10.0, Bottom := 10.0}
                }
            }
            
            # 订阅点击事件
            StartButton.OnClick().Subscribe(OnStartClicked)
            OptionsButton.OnClick().Subscribe(OnOptionsClicked)
            
            # 创建垂直布局
            MenuBox := stack_box{
                Orientation := orientation.Vertical,
                Slots := array{}
            }
            
            # 添加按钮
            MenuBox.AddWidget(stack_box_slot{
                Widget := StartButton,
                HorizontalAlignment := horizontal_alignment.Center,
                Padding := margin{Top := 10.0, Bottom := 10.0}
            })
            
            MenuBox.AddWidget(stack_box_slot{
                Widget := OptionsButton,
                HorizontalAlignment := horizontal_alignment.Center,
                Padding := margin{Top := 10.0, Bottom := 10.0}
            })
            
            # 添加到玩家 UI（居中）
            RootCanvas := canvas{Slots := array{}}
            RootCanvas.AddWidget(
                canvas_slot{
                    Widget := MenuBox,
                    Anchors := anchors{
                        Minimum := vector2{X := 0.5, Y := 0.5},
                        Maximum := vector2{X := 0.5, Y := 0.5}
                    },
                    Alignment := vector2{X := 0.5, Y := 0.5},
                    SizeToContent := true
                }
            )
            
            PlayerUI.AddWidget(RootCanvas, player_ui_slot{
                ZOrder := 200,
                InputMode := ui_input_mode.All  # 消费所有输入
            })

    OnStartClicked(Msg:widget_message):void =
        Print("Start button clicked by {Msg.Player}")
        # 移除菜单
        if (PlayerUI := GetPlayerUI(Msg.Player)):
            PlayerUI.RemoveWidget(StartButton)
            PlayerUI.RemoveWidget(OptionsButton)

    OnOptionsClicked(Msg:widget_message):void =
        Print("Options button clicked by {Msg.Player}")

```

**示例说明**：
- 使用 `stack_box` 创建垂直菜单
- 使用 `button` 和事件监听处理交互
- 使用锚点和对齐实现居中布局
- 设置 `InputMode := ui_input_mode.All` 阻止游戏输入

---

### 示例 3：动态血量条

```verse
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }

health_bar := class(creative_device):
    var HealthBarFill:color_block = color_block{}
    var MaxHealthWidth:float = 200.0

    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        if (Player := AllPlayers[0]):
            ShowHealthBar(Player)

    ShowHealthBar(Player:player):void =
        if (PlayerUI := GetPlayerUI(Player)):
            # 背景条（黑色）
            Background := color_block{
                DefaultColor := NamedColors.Black,
                DefaultOpacity := 0.7,
                DefaultDesiredSize := vector2{X := MaxHealthWidth, Y := 20.0}
            }
            
            # 血量条（红色）
            set HealthBarFill = color_block{
                DefaultColor := NamedColors.Red,
                DefaultOpacity := 1.0,
                DefaultDesiredSize := vector2{X := MaxHealthWidth, Y := 20.0}
            }
            
            # 使用 Overlay 叠加背景和前景
            HealthOverlay := overlay{
                Slots := array{
                    overlay_slot{Widget := Background},
                    overlay_slot{Widget := HealthBarFill}
                }
            }
            
            # 添加到画布
            RootCanvas := canvas{Slots := array{}}
            RootCanvas.AddWidget(
                MakeCanvasSlot(
                    HealthOverlay,
                    vector2{X := 50.0, Y := 100.0}
                )
            )
            
            PlayerUI.AddWidget(RootCanvas, player_ui_slot{
                ZOrder := 100,
                InputMode := ui_input_mode.None
            })

    UpdateHealth(HealthPercent:float):void =
        # HealthPercent 范围 0.0 - 1.0
        NewWidth := MaxHealthWidth *HealthPercent
        HealthBarFill.SetDesiredSize(vector2{X := NewWidth, Y := 20.0})
        
        # 根据血量改变颜色
        if (HealthPercent > 0.5):
            HealthBarFill.SetColor(NamedColors.Green)
        else if (HealthPercent > 0.25):
            HealthBarFill.SetColor(NamedColors.Yellow)
        else:
            HealthBarFill.SetColor(NamedColors.Red)

```**示例说明**：
- 使用 `overlay` 实现背景和前景叠加
- 使用 `color_block` 和动态大小实现血量条
- 根据血量百分比改变颜色
- 演示了如何动态更新 UI 元素

---

### 示例 4：图片展示板

```verse
using { /Verse.org/Simulation }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/UI }

image_display := class(creative_device):
    @editable
    MyTexture:texture = DefaultAsset  # 在编辑器中设置

    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        if (Player := AllPlayers[0]):
            ShowImage(Player)

    ShowImage(Player:player):void =
        if (PlayerUI := GetPlayerUI(Player)):
            # 创建纹理块
            ImageWidget := texture_block{
                DefaultImage := MyTexture,
                DefaultDesiredSize := vector2{X := 400.0, Y := 300.0},
                DefaultTint := NamedColors.White,
                DefaultHorizontalTiling := image_tiling.Stretch,
                DefaultVerticalTiling := image_tiling.Stretch
            }
            
            # 居中显示
            RootCanvas := canvas{Slots := array{}}
            RootCanvas.AddWidget(
                canvas_slot{
                    Widget := ImageWidget,
                    Anchors := anchors{
                        Minimum := vector2{X := 0.5, Y := 0.5},
                        Maximum := vector2{X := 0.5, Y := 0.5}
                    },
                    Alignment := vector2{X := 0.5, Y := 0.5},
                    Offsets := margin{
                        Left := -200.0,  # 宽度的一半
                        Top := -150.0,   # 高度的一半
                        Right := 200.0,
                        Bottom := 150.0
                    },
                    SizeToContent := false
                }
            )
            
            PlayerUI.AddWidget(RootCanvas)

```

**示例说明**：
- 使用 `texture_block` 显示图片
- 使用锚点实现居中
- 使用 `Offsets` 精确控制位置
- 演示了平铺模式的设置

---

### 示例 5：复杂布局组合

```verse
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }

complex_ui := class(creative_device):
    OnBegin<override>()<suspends>:void =
        AllPlayers := GetPlayspace().GetPlayers()
        if (Player := AllPlayers[0]):
            BuildComplexUI(Player)

    BuildComplexUI(Player:player):void =
        if (PlayerUI := GetPlayerUI(Player)):
            # === 顶部标题栏 ===
            TitleText := text_base{
                DefaultText := "Game Title"
                DefaultTextColor := NamedColors.White
                DefaultTextSize := 36.0
                DefaultJustification := text_justification.Center
            }
            
            TitleBackground := color_block{
                DefaultColor := NamedColors.Black,
                DefaultOpacity := 0.8,
                DefaultDesiredSize := vector2{X := 1920.0, Y := 80.0}
            }
            
            TitleBar := overlay{
                Slots := array{
                    overlay_slot{Widget := TitleBackground},
                    overlay_slot{
                        Widget := TitleText,
                        VerticalAlignment := vertical_alignment.Center
                    }
                }
            }
            
            # === 左侧面板 ===
            LeftPanel := stack_box{
                Orientation := orientation.Vertical,
                Slots := array{}
            }
            
            # 添加几个信息项
            for (I := 0..4):
                InfoText := text_base{
                    DefaultText := "Info {I + 1}"
                    DefaultTextColor := NamedColors.Yellow
                    DefaultTextSize := 20.0
                }
                LeftPanel.AddWidget(stack_box_slot{
                    Widget := InfoText,
                    Padding := margin{Left := 10.0, Top := 5.0, Right := 10.0, Bottom := 5.0}
                })
            
            # === 主画布布局 ===
            RootCanvas := canvas{Slots := array{}}
            
            # 添加标题栏（顶部，拉伸）
            RootCanvas.AddWidget(
                canvas_slot{
                    Widget := TitleBar,
                    Anchors := anchors{
                        Minimum := vector2{X := 0.0, Y := 0.0},
                        Maximum := vector2{X := 1.0, Y := 0.0}
                    },
                    Offsets := margin{
                        Left := 0.0,
                        Top := 0.0,
                        Right := 0.0,
                        Bottom := 80.0
                    },
                    SizeToContent := false
                }
            )
            
            # 添加左侧面板（固定宽度）
            RootCanvas.AddWidget(
                canvas_slot{
                    Widget := LeftPanel,
                    Anchors := anchors{
                        Minimum := vector2{X := 0.0, Y := 0.0},
                        Maximum := vector2{X := 0.0, Y := 1.0}
                    },
                    Offsets := margin{
                        Left := 0.0,
                        Top := 80.0,  # 标题栏高度
                        Right := 200.0,
                        Bottom := 0.0
                    },
                    SizeToContent := false
                }
            )
            
            PlayerUI.AddWidget(RootCanvas, player_ui_slot{
                InputMode := ui_input_mode.None
            })

```

**示例说明**：
- 组合多个容器实现复杂布局
- 使用锚点实现响应式布局
- 标题栏拉伸填充宽度
- 左侧面板固定宽度，高度自适应
- 演示了真实游戏 UI 的构建方式

---

## 常见误区澄清

### 误区 1：认为可以直接创建 `widget` 实例

**错误认知**：

```verse
# ❌ 错误！widget 是抽象类
MyWidget := widget{}

```

**正确理解**：
- `widget` 是抽象基类 (`<abstract>`)，不能直接实例化
- 必须使用具体的子类，如 `button`、`canvas`、`text_base` 等

**正确做法**：

```verse
# ✅ 正确
MyButton := button{}
MyCanvas := canvas{}

```

---

### 误区 2：混淆 `Slots` 属性和 `AddWidget()` 方法

**错误认知**：

认为修改 `Slots` 属性可以添加子 Widget

**正确理解**：
- `Slots` 属性仅用于初始化时设置子 Widget
- 初始化后，修改 `Slots` **不会**影响实际的子 Widget
- 运行时必须使用 `AddWidget()` 和 `RemoveWidget()` 方法

**示例对比**：

```verse
# ✅ 初始化时设置
MyCanvas := canvas{
    Slots := array{
        canvas_slot{Widget := ChildWidget1},
        canvas_slot{Widget := ChildWidget2}
    }
}

# ✅ 运行时添加
MyCanvas.AddWidget(canvas_slot{Widget := NewWidget})

# ❌ 错误！运行时修改 Slots 无效
set MyCanvas.Slots = array{...}  # 这不会生效

```

---

### 误区 3：不理解 `Default*` 属性的作用时机

**错误认知**：

认为 `Default*` 属性可以在运行时修改以更新 UI

**正确理解**：
- 所有 `Default*` 属性（如 `DefaultColor`、`DefaultText`）**仅在初始化时有效**
- 运行时修改这些属性**不会**改变 Widget 的显示
- 必须使用对应的 `Set*` 方法动态修改

**示例对比**：

```verse
# ✅ 初始化时设置
MyText := text_base{
    DefaultText := "Hello",
    DefaultTextColor := NamedColors.White
}

# ❌ 错误！运行时修改 Default*无效
set MyText.DefaultText = "World"  # 不会改变显示

# ✅ 正确！使用 Set 方法
MyText.SetText("World")
MyText.SetTextColor(NamedColors.Red)

```

---

### 误区 4 - 误解 widget_visibility 的三种状态**错误认知**：

认为 `Hidden` 和 `Collapsed` 是相同的

**正确理解**：

| 状态 | 可见性 | 占用布局空间 | 使用场景 |
|------|--------|-------------|----------||| 状态 | 可见性 | 占用布局空间 | 使用场景 |
|------|--------|-------------|----------||| 状态 | 可见性 | 占用布局空间 | 使用场景 |
|------|--------|-------------|----------|-----|| 状态 | 可见性 | 占用布局空间 | 使用场景 |
|------|--------|-------------|----------|--|
| `Visible` | 可见 | 是 | 正常显示 |
| `Hidden` | 不可见 | **是**| 临时隐藏但保留布局位置 |
| `Collapsed` | 不可见 |**否**| 完全移除，不影响其他元素布局 |**示例**：

```verse
# 临时隐藏但保留空间（比如加载中）
Widget.SetVisibility(widget_visibility.Hidden)

# 完全折叠，让其他元素填充空间
Widget.SetVisibility(widget_visibility.Collapsed)

```

---

### 误区 5：不理解锚点 (anchors) 的工作原理

**错误认知**：

认为锚点只是简单的位置参数

**正确理解**：
- 锚点定义 Widget **相对于父容器**的附着点
- `Minimum` 和 `Maximum` 相同时：固定大小，位置相对于锚点
- `Minimum` 和 `Maximum` 不同时：Widget 拉伸，大小根据 `Offsets` 调整

**示例**：

```verse
# 固定大小，位于左上角
canvas_slot{
    Anchors := anchors{
        Minimum := vector2{X := 0.0, Y := 0.0},
        Maximum := vector2{X := 0.0, Y := 0.0}
    },
    Offsets := margin{
        Left := 10.0,   # 距离左边 10px
        Top := 10.0,    # 距离上边 10px
        Right := 110.0, # 宽度 100px (110-10)
        Bottom := 60.0  # 高度 50px (60-10)
    }
}

# 拉伸填充整个父容器
canvas_slot{
    Anchors := anchors{
        Minimum := vector2{X := 0.0, Y := 0.0},
        Maximum := vector2{X := 1.0, Y := 1.0}
    },
    Offsets := margin{
        Left := 10.0,   # 距离左边 10px
        Top := 10.0,    # 距离上边 10px
        Right := 10.0,  # 距离右边 10px
        Bottom := 10.0  # 距离下边 10px
    }
}

# 居中，固定大小
canvas_slot{
    Anchors := anchors{
        Minimum := vector2{X := 0.5, Y := 0.5},
        Maximum := vector2{X := 0.5, Y := 0.5}
    },
    Alignment := vector2{X := 0.5, Y := 0.5},
    Offsets := margin{
        Left := -50.0,  # 宽度的一半
        Top := -25.0,   # 高度的一半
        Right := 50.0,
        Bottom := 25.0
    }
}

```

---

### 误区 6：误解 `InputMode` 的影响范围

**错误认知**：

认为 `InputMode` 只影响该 Widget 本身

**正确理解**：
- `ui_input_mode.All` 会消费**所有**输入，包括游戏输入
- 当 UI 显示时，玩家可能无法移动、射击等
- 应该谨慎使用，通常只在暂停菜单、开始菜单等场景使用

**最佳实践**：

```verse
# ✅ HUD 元素，不阻止游戏输入
PlayerUI.AddWidget(HudWidget, player_ui_slot{
    InputMode := ui_input_mode.None
})

# ✅ 暂停菜单，阻止游戏输入
PlayerUI.AddWidget(PauseMenu, player_ui_slot{
    InputMode := ui_input_mode.All,
    ZOrder := 1000  # 确保在最上层
})

```

---

### 误区 7：不理解 ZOrder 的作用

**错误认知**：

认为 ZOrder 对所有容器类型都有效

**正确理解**：
- `player_ui_slot` 的 `ZOrder` 控制顶层 Widget 之间的层级
- `canvas_slot` 的 `ZOrder` 控制 Canvas 内部子 Widget 的层级
- `overlay` 和 `stack_box` 不使用 ZOrder，按添加顺序决定层级

**示例**：

```verse
# Canvas 内的 Z 顺序
MyCanvas.AddWidget(canvas_slot{
    Widget := BackgroundWidget,
    ZOrder := 1  # 在后面
})

MyCanvas.AddWidget(canvas_slot{
    Widget := ForegroundWidget,
    ZOrder := 10  # 在前面
})

# Overlay 的顺序（无 ZOrder）
MyOverlay := overlay{
    Slots := array{
        overlay_slot{Widget := Bottom},    # 最底层
        overlay_slot{Widget := Middle},    # 中间层
        overlay_slot{Widget := Top}        # 最顶层
    }
}

```

---

## 最佳实践

### 1. UI 初始化模式

**推荐做法**：在 `OnBegin` 中延迟初始化 UI，确保玩家已加入游戏

```verse
OnBegin<override>()<suspends>:void =
    Sleep(0.1)  # 短暂延迟确保玩家加载完成
    AllPlayers := GetPlayspace().GetPlayers()
    for (Player : AllPlayers):
        InitializePlayerUI(Player)

```

**原因**：
- 玩家可能在游戏开始时尚未完全加载
- `GetPlayerUI()` 可能失败，需要适当延迟

---

### 2. Widget 生命周期管理

**推荐模式**：使用类成员变量存储 Widget 引用，便于后续操作

```verse
my_ui_manager := class(creative_device):
    var TitleText:?text_base = false
    var ScorePanel:?canvas = false
    
    CreateUI(Player:player):void =
        if (PlayerUI := GetPlayerUI(Player)):
            # 创建并保存引用
            set TitleText = option{text_base{...}}
            set ScorePanel = option{canvas{...}}
            
            if (Title := TitleText?, Panel := ScorePanel?):
                PlayerUI.AddWidget(Panel)
    
    UpdateUI():void =
        if (Title := TitleText?):
            Title.SetText("New Title")
    
    DestroyUI(Player:player):void =
        if (PlayerUI := GetPlayerUI(Player), Panel := ScorePanel?):
            PlayerUI.RemoveWidget(Panel)
            set TitleText = false
            set ScorePanel = false

```

**优点**：
- 便于更新和移除 Widget
- 避免重复创建
- 清晰的生命周期管理

---

### 3. 响应式布局设计

**推荐做法**：使用锚点和相对布局，适应不同屏幕尺寸

```verse
# ✅ 响应式：四角显示信息
CreateCornerUI():void =
    # 左上角
    TopLeftSlot := canvas_slot{
        Anchors := anchors{
            Minimum := vector2{X := 0.0, Y := 0.0},
            Maximum := vector2{X := 0.0, Y := 0.0}
        },
        Offsets := margin{Left := 10.0, Top := 10.0, Right := 210.0, Bottom := 60.0}
    }
    
    # 右上角
    TopRightSlot := canvas_slot{
        Anchors := anchors{
            Minimum := vector2{X := 1.0, Y := 0.0},
            Maximum := vector2{X := 1.0, Y := 0.0}
        },
        Offsets := margin{Left := -210.0, Top := 10.0, Right := -10.0, Bottom := 60.0}
    }
    
    # 底部居中
    BottomCenterSlot := canvas_slot{
        Anchors := anchors{
            Minimum := vector2{X := 0.5, Y := 1.0},
            Maximum := vector2{X := 0.5, Y := 1.0}
        },
        Alignment := vector2{X := 0.5, Y := 1.0},
        Offsets := margin{Left := -200.0, Top := -60.0, Right := 200.0, Bottom := -10.0}
    }

```

**避免**：硬编码绝对位置

---

### 4. 性能优化建议

#### 4.1 减少 Widget 数量

- 使用容器组合而不是大量独立 Widget
- 复用 Widget 而不是频繁创建/销毁
- 使用 `SetVisibility(Collapsed)` 隐藏而不是移除

#### 4.2 事件订阅管理

```verse
# ✅ 在适当时机取消订阅
var Subscription:?cancelable = false

EnableButton():void =
    set Subscription = option{MyButton.OnClick().Subscribe(Handler)}

DisableButton():void =
    if (Sub := Subscription?):
        Sub.Cancel()
        set Subscription = false

```

#### 4.3 避免频繁更新

```verse
# ❌ 避免每帧更新
loop:
    MyText.SetText("{Time}")  # 性能问题
    Sleep(0.0)

# ✅ 使用合理的更新频率
loop:
    MyText.SetText("{Time}")
    Sleep(0.1)  # 10 FPS 更新足够

```

---

### 5. 输入处理最佳实践

#### 5.1 分层管理输入

```verse
# HUD 层：不消费输入
PlayerUI.AddWidget(HudCanvas, player_ui_slot{
    ZOrder := 0,
    InputMode := ui_input_mode.None
})

# 菜单层：消费所有输入
PlayerUI.AddWidget(MenuCanvas, player_ui_slot{
    ZOrder := 100,
    InputMode := ui_input_mode.All
})

```

#### 5.2 提供关闭机制

```verse
# 始终提供关闭菜单的方式
CloseButton := button{...}
CloseButton.OnClick().Subscribe(OnCloseMenu)

OnCloseMenu(Msg:widget_message):void =
    if (PlayerUI := GetPlayerUI(Msg.Player)):
        PlayerUI.RemoveWidget(MenuCanvas)

```

---

### 6. 样式一致性

**建议**：使用常量定义通用样式

```verse
# 定义样式常量
UI_FONT_SIZE_LARGE<public>:float = 36.0
UI_FONT_SIZE_NORMAL<public>:float = 24.0
UI_FONT_SIZE_SMALL<public>:float = 18.0

UI_COLOR_PRIMARY<public>:color = NamedColors.White
UI_COLOR_SECONDARY<public>:color = NamedColors.Yellow
UI_COLOR_ACCENT<public>:color = NamedColors.Red

UI_PADDING_STANDARD<public>:margin = margin{
    Left := 10.0,
    Top := 10.0,
    Right := 10.0,
    Bottom := 10.0
}

# 使用样式
CreateText():text_base =
    text_base{
        DefaultTextSize := UI_FONT_SIZE_NORMAL,
        DefaultTextColor := UI_COLOR_PRIMARY
    }

```

---

### 7. 调试技巧

#### 7.1 可视化边界

```verse
# 添加带边框的调试容器
DebugBorder := color_block{
    DefaultColor := NamedColors.Red,
    DefaultOpacity := 0.3
}

DebugContainer := overlay{
    Slots := array{
        overlay_slot{Widget := DebugBorder},
        overlay_slot{Widget := ActualContent}
    }
}

```

#### 7.2 日志输出

```verse
CreateUI(Player:player):void =
    Print("Creating UI for player {Player}")
    
    if (PlayerUI := GetPlayerUI(Player)):
        Print("PlayerUI obtained successfully")
        PlayerUI.AddWidget(MyWidget)
        Print("Widget added to PlayerUI")
    else:
        Print("Failed to get PlayerUI - player may not be ready")

```

---

### 8. 模块化 UI 组件

**推荐模式**：创建可复用的 UI 组件类

```verse
# 可复用的信息面板组件
info_panel := class:
    var TitleText:text_base
    var ContentText:text_base
    var RootWidget:overlay
    
    Init(Title:string, Content:string):info_panel =
        set TitleText = text_base{
            DefaultText := Title,
            DefaultTextColor := NamedColors.Yellow,
            DefaultTextSize := 28.0
        }
        
        set ContentText = text_base{
            DefaultText := Content,
            DefaultTextColor := NamedColors.White,
            DefaultTextSize := 20.0
        }
        
        PanelBox := stack_box{
            Orientation := orientation.Vertical,
            Slots := array{
                stack_box_slot{Widget := TitleText},
                stack_box_slot{Widget := ContentText}
            }
        }
        
        Background := color_block{
            DefaultColor := NamedColors.Black,
            DefaultOpacity := 0.7
        }
        
        set RootWidget = overlay{
            Slots := array{
                overlay_slot{Widget := Background},
                overlay_slot{Widget := PanelBox}
            }
        }
        
        return Self
    
    GetWidget():widget = RootWidget
    
    UpdateContent(NewContent:string):void =
        ContentText.SetText(NewContent)

# 使用可复用组件
MyPanel := info_panel{}.Init("Score", "0")
PlayerUI.AddWidget(MyPanel.GetWidget())
MyPanel.UpdateContent("100")

```

---

## 参考资源

### 官方文档链接

1. **UEFN Verse API 文档**- 主页：<https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference>
  - UI 模块（注意路径可能变化）

2.**相关 API Digest 文件**- 位置：`skills/programming/verseDev/shared/api-digests/UnrealEngine.digest.verse.md`
  - 包含完整的 API 定义和注释

3.**模块关系参考**- `skills/programming/verseDev/shared/references/api-modules-list.md`
  - `skills/programming/verseDev/shared/references/api-modules-research.md`

### 相关 API 模块

#### 相关依赖模块

-**`/Verse.org/Simulation`**- 提供 `player` 类型
  - 提供游戏仿真基础设施

-**`/Verse.org/Colors`**- 提供 `color` 类型
  - 提供 `NamedColors` 常量

-**`/UnrealEngine.com/Temporary/SpatialMath`**- 提供 `vector2` 类型
  - 用于位置和大小计算

-**`/Verse.org/Assets`**- 提供 `texture`、`material` 等资源类型
  - 用于图片和材质 Widget

#### 补充模块

-**`/Fortnite.com/UI`**- Fortnite 特定的 HUD 元素
  - 提供 `creative_hud_identifier` 等

-**`/Verse.org/Presentation`**- 更高级的展示层 API
  - 可能包含额外的 UI 功能

### 版本信息

-**Digest 版本**：`++Fortnite+Release-39.11-CL-49242330`
- **模块状态**：Temporary（临时/过渡 API）
- **稳定性**：Beta/Experimental

### 注意事项

1. **模块路径可能变化**- 当前路径为 `/UnrealEngine.com/Temporary/UI`
  - 未来可能迁移到非 `Temporary` 路径
  - 建议使用模块别名，便于后续更新

2.**API 可能变化**- 标记为 `Temporary` 的 API 可能会调整
  - 关注 Epic Games 的更新日志
  - 测试新版本时验证 API 兼容性

3.**浏览器兼容性**- UI 系统基于 UMG（Unreal Motion Graphics）
  - 不同平台可能有渲染差异
  - 建议在目标平台上测试

---

## 总结

本文档全面调研了 `/UnrealEngine.com/Temporary/UI` 模块，涵盖了：

- ✅**13 个核心类**：从基础 Widget 到复杂容器
- ✅ **8 个枚举类型**：控制布局、对齐、可见性等
- ✅ **7 个配置结构体**：精确控制 UI 行为
- ✅ **5 个完整示例**：从简单 HUD 到复杂布局
- ✅ **7 个常见误区**：避免开发陷阱
- ✅ **8 个最佳实践**：提升代码质量和性能

该模块是 UEFN 中创建用户界面的核心工具，掌握其正确用法对于开发高质量游戏至关重要。

**关键要点**：
- Widget 是层级化的，使用容器组织
- Default* 属性仅用于初始化，运行时用 Set*方法
- 锚点和对齐实现响应式布局
- 谨慎使用 InputMode，避免阻塞游戏输入
- 复用 Widget 和组件，提升性能和可维护性

---**文档维护**：本文档应随 Epic Games 官方 API 更新而更新。如发现不一致，请以官方文档为准。
