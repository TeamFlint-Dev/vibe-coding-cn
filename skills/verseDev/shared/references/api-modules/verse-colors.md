# Verse.org/Colors API 模块参考文档

## 1. 模块概述

### 1.1 模块路径

`/Verse.org/Colors`

### 1.2 模块用途

`Verse.org/Colors` 模块是 UEFN/Verse 的核心颜色处理系统，提供了在 Verse 中操作颜色的完整能力。该模块基于 **ACES 2065-1 色彩空间**，提供高精度的线性色彩表示，支持多种色彩空间转换、运算和预定义颜色常量。

### 1.3 设计理念

#### 色彩空间选择：ACES 2065-1

- **工业标准**：ACES (Academy Color Encoding System) 是电影和视觉特效行业的标准色彩空间
- **线性光照**：使用线性 RGB (gamma = 1.0)，便于进行物理准确的光照计算
- **高动态范围**：支持超出标准 sRGB 范围的值，适合 HDR 渲染
- **色彩保真度**：在不同显示设备间保持色彩一致性

#### 设计原则

1. **精确性优先**：所有颜色值使用 `float` 存储，保证精度
2. **多空间支持**：提供 sRGB、HSV、黑体辐射等多种色彩空间的转换
3. **便捷性**：140+ 预定义命名颜色，覆盖常见使用场景
4. **可组合性**：支持颜色的加减乘除运算，便于进行颜色混合和调整

### 1.4 适用场景

| 场景 | 具体应用 |
|------|---------|
| **UI 着色** | 按钮颜色、文本颜色、HUD 元素着色 |
| **视觉效果** | 粒子系统颜色、光照颜色、材质颜色调整 |
| **调试可视化** | 使用不同颜色区分不同状态或对象 |
| **游戏逻辑** | 团队颜色、目标标记、状态指示 |
| **动画系统** | 颜色插值动画、渐变效果 |

---

## 2. 核心类型与接口清单

### 2.1 主要类型

#### color (核心结构体)

```verse
color<native><public> := struct<concrete><computes><persistable>:
    @editable
    R<native><public>:float  # 红色分量
    @editable
    G<native><public>:float  # 绿色分量
    @editable
    B<native><public>:float  # 蓝色分量
```

**特性**：

- `<native>`: 原生实现，性能优化
- `<computes>`: 纯计算类型，无副作用
- `<persistable>`: 可序列化保存
- `@editable`: 可在 UEFN 编辑器中直接编辑

#### color_alpha (带透明度的颜色)

```verse
@available {MinUploadedAtFNVersion := 3800}
color_alpha<native><public> := struct<concrete><computes><persistable>:
    @editable
    Color<native><public>:color  # 颜色分量
    @editable
    A<native><public>:float      # 透明度 (0.0=透明, 1.0=不透明)
```

**设计说明**：

- 颜色和透明度分离存储（非预乘 alpha）
- 从 Fortnite 版本 38.00 开始可用
- 适合需要透明度控制的场景

### 2.2 按功能分类的 API

#### 颜色创建函数

| 类别 | 函数名 | 用途 |
|------|--------|------|
| **直接构造** | `color{R, G, B}` | 使用 ACES 分量直接创建 |
| **sRGB 转换** | `MakeColorFromSRGB(Red, Green, Blue)` | 从 sRGB float 创建 (0.0-1.0) |
| **sRGB 整数** | `MakeColorFromSRGBValues(Red, Green, Blue)` | 从 sRGB int 创建 (0-255) |
| **十六进制** | `MakeColorFromHex(hexString)` | 从 CSS 风格十六进制字符串创建 |
| **HSV 模型** | `MakeColorFromHSV(Hue, Saturation, Value)` | 从 HSV 色彩模型创建 |
| **色温** | `MakeColorFromTemperature(Temperature)` | 从黑体辐射温度创建（开尔文） |
| **带透明度** | `MakeColorAlpha(R, G, B, ?A)` | 创建带透明度的颜色 |

#### 颜色转换函数

| 函数名 | 输入 | 输出 | 用途 |
|--------|------|------|------|
| `MakeSRGBFromColor` | `color` | `tuple(float, float, float)` | 转换为 sRGB |
| `MakeHSVFromColor` | `color` | `tuple(float, float, float)` | 转换为 HSV |

#### 颜色运算操作符

| 操作符 | 签名 | 说明 |
|--------|------|------|
| `+` | `color + color` | 分量相加 |
| `-` | `color - color` | 分量相减 |
| `*` | `color * color` | 分量相乘 (颜色混合) |
| `*` | `color * float` | 缩放颜色亮度 |
| `*` | `float * color` | 缩放颜色亮度 (交换律) |
| `/` | `color / float` | 缩小颜色亮度 |

#### 混合函数

| 函数名 | 说明 |
|--------|------|
| `Over(CA1, CA2)` | Alpha 混合（CA1 覆盖在 CA2 之上） |

---

## 3. 关键 API 详解

### 3.1 颜色创建 API

#### MakeColorFromSRGB

```verse
MakeColorFromSRGB<native><public>(
    (local:)Red:float,
    (local:)Green:float,
    (local:)Blue:float
)<converges>:color
```

**参数**：

- `Red`: sRGB 红色分量，通常范围 0.0-1.0
- `Green`: sRGB 绿色分量，通常范围 0.0-1.0
- `Blue`: sRGB 蓝色分量，通常范围 0.0-1.0

**返回值**：转换后的 ACES 2065-1 `color` 对象

**特性**：

- `<converges>`: 保证收敛（不会无限循环）
- 支持大于 1.0 的值（HDR 颜色）
- 自动执行 sRGB 到 ACES 的色彩空间转换

**使用场景**：当你有 sRGB 值（如设计师提供的颜色）时使用

---

#### MakeColorFromSRGBValues

```verse
MakeColorFromSRGBValues<native><public>(
    (local:)Red:int,
    (local:)Green:int,
    (local:)Blue:int
)<converges>:color
```

**参数**：

- `Red`: sRGB 红色分量，有效范围 0-255
- `Green`: sRGB 绿色分量，有效范围 0-255
- `Blue`: sRGB 蓝色分量，有效范围 0-255

**返回值**：转换后的 ACES 2065-1 `color` 对象

**使用场景**：

- 使用标准 RGB 整数值（如 #FF5733 = 255, 87, 51）
- 与外部系统交互时（大多数颜色选择器使用 0-255）

**示例**：

```verse
# 创建橙色
OrangeColor := MakeColorFromSRGBValues(255, 165, 0)
```

---

#### MakeColorFromHex

```verse
MakeColorFromHex<native><public>(hexString:string)<converges>:color
```

**参数**：

- `hexString`: CSS 风格的十六进制颜色字符串

**支持的格式**：

- `RGB` - 3 位十六进制（如 "F00" 表示红色）
- `RRGGBB` - 6 位十六进制（如 "FF5733"）
- `RRGGBBAA` - 8 位十六进制（包含 alpha，但 alpha 会被忽略）
- `#RGB` - 带 # 前缀的 3 位
- `#RRGGBB` - 带 # 前缀的 6 位（最常用）
- `#RRGGBBAA` - 带 # 前缀的 8 位

**返回值**：

- 有效输入：转换后的 `color`
- 无效输入：返回黑色 (`NamedColors.Black`)

**注意事项**：

- ⚠️ **无错误提示**：无效的十六进制字符串会默默返回黑色
- ⚠️ **Alpha 分量被忽略**：即使提供了 AA 部分，也不会影响结果

**示例**：

```verse
# 多种格式都有效
Color1 := MakeColorFromHex("#FF5733")  # 推荐格式
Color2 := MakeColorFromHex("FF5733")   # 无 # 也可以
Color3 := MakeColorFromHex("#F00")     # 短格式
Color4 := MakeColorFromHex("BadHex")   # 返回黑色（无警告！）
```

---

#### MakeColorFromHSV

```verse
MakeColorFromHSV<native><public>(
    Hue:float,
    Saturation:float,
    Value:float
)<converges>:color
```

**参数**：

- `Hue`: 色相，预期范围 0.0-360.0（度数）
- `Saturation`: 饱和度，预期范围 0.0-1.0
- `Value`: 明度，预期范围 0.0-1.0

**色相值含义**：

- 0° / 360° = 红色
- 60° = 黄色
- 120° = 绿色
- 180° = 青色
- 240° = 蓝色
- 300° = 品红

**范围处理**：

- 超出预期范围的值会进行范围缩减和转换
- Hue 超过 360 会自动取模（370° = 10°）

**使用场景**：

- 需要调整颜色的饱和度或明度
- 创建渐变色动画（通过插值 Hue）
- 设计师偏好使用 HSV 模型

**示例**：

```verse
# 创建纯红色
PureRed := MakeColorFromHSV(0.0, 1.0, 1.0)

# 创建粉红色（降低饱和度）
Pink := MakeColorFromHSV(0.0, 0.5, 1.0)

# 创建暗红色（降低明度）
DarkRed := MakeColorFromHSV(0.0, 1.0, 0.5)
```

---

#### MakeColorFromTemperature

```verse
MakeColorFromTemperature<native><public>(Temperature:float)<converges>:color
```

**参数**：

- `Temperature`: 黑体辐射温度（开尔文 K），自动钳制到 >= 0

**色温参考表**：

| 温度 (K) | 颜色效果 | 应用场景 |
|---------|---------|---------|
| 1000-2000 | 深橙红色 | 烛光、火焰 |
| 2700-3000 | 暖黄色 | 白炽灯、日出/日落 |
| 4000-5000 | 中性白 | 荧光灯、清晨阳光 |
| 5500-6500 | 冷白色 | 日光、闪光灯 |
| 7000-9000 | 蓝白色 | 阴影区域、阴天 |
| 10000+ | 深蓝色 | 极地天空、科幻灯光 |

**使用场景**：

- 创建真实感的光照效果
- 模拟时间变化（黎明、正午、黄昏）
- 天气系统的色调调整

**示例**：

```verse
# 火焰色
FlameColor := MakeColorFromTemperature(1500.0)

# 日光色
DaylightColor := MakeColorFromTemperature(6500.0)

# 科幻蓝光
SciFiBlue := MakeColorFromTemperature(12000.0)
```

---

### 3.2 颜色转换 API

#### MakeSRGBFromColor

```verse
MakeSRGBFromColor<native><public>(InColor:color)<converges>:tuple(float, float, float)
```

**用途**：将 ACES 颜色转换回 sRGB 色彩空间

**返回值**：三元组 `(Red:float, Green:float, Blue:float)`

**使用场景**：

- 需要将颜色数据传递给外部系统
- 调试输出颜色值
- 与不支持 ACES 的 API 交互

---

#### MakeHSVFromColor

```verse
MakeHSVFromColor<native><public>(InColor:color):tuple(float, float, float)
```

**用途**：将 ACES 颜色转换为 HSV 表示

**返回值**：三元组 `(Hue:float, Saturation:float, Value:float)`

**使用场景**：

- 需要获取颜色的色相进行动画
- 需要调整饱和度或明度
- UI 中显示 HSV 滑块

---

### 3.3 颜色运算操作符

#### 加法运算 (+)

```verse
operator'+'<native><public>(c0:color, c1:color)<converges>:color
```

**语义**：分量相加，`R = c0.R + c1.R`，对 G、B 同理

**使用场景**：颜色叠加、光照累加

**示例**：

```verse
Red := NamedColors.Red
Yellow := NamedColors.Yellow
# 红色 + 黄色 = 更亮的橙色
Bright := Red + Yellow
```

---

#### 乘法运算 (*)

```verse
# 颜色与颜色相乘
operator'*'<native><public>(c0:color, c1:color)<converges>:color

# 颜色与标量相乘
operator'*'<native><public>(c:color, factor:float)<converges>:color
operator'*'<native><public>(factor:float, c:color)<converges>:color
```

**语义**：

- 颜色相乘：分量相乘，`R = c0.R * c1.R`（颜色混合/过滤）
- 标量相乘：`R = c.R * factor`（亮度调整）

**使用场景**：

- 颜色滤镜效果
- 亮度/强度调整
- 颜色淡入淡出动画

**示例**：

```verse
BaseColor := NamedColors.Red

# 变暗到 50%
DimRed := BaseColor * 0.5

# 变亮到 150%
BrightRed := BaseColor * 1.5

# 应用青色滤镜
FilteredColor := BaseColor * NamedColors.Cyan
```

---

#### 除法运算 (/)

```verse
operator'/'<native><public>(c:color, factor:float)<decides><converges>:color
operator'/'<native><public>(c:color, factor:int)<decides><converges>:color
```

**语义**：每个分量除以 `factor`

**特性**：

- `<decides>`: 除以零会失败（failable）

**注意事项**：

- ⚠️ **必须处理失败**：如果 `factor = 0`，操作会失败
- 使用 `if` 或 `?` 语法处理可能的失败

**示例**：

```verse
BaseColor := NamedColors.White

# 安全的除法
if (DimColor := BaseColor / 2.0):
    # 成功
else:
    # 处理除以零的情况
```

---

### 3.4 Alpha 混合 API

#### Over 函数

```verse
@available {MinUploadedAtFNVersion := 3800}
Over<public>(CA1:color_alpha, CA2:color_alpha)<reads><decides>:color_alpha
```

**用途**：非预乘 alpha 混合，CA1 覆盖在 CA2 之上

**算法**：标准的 "over" 操作（Porter-Duff）

**参数钳制**：

- Alpha 值会被自动钳制到 0.0-1.0
- 如果两个 alpha 都为 0，操作会失败

**使用场景**：

- UI 元素层叠
- 半透明特效合成
- 图层混合

**示例**：

```verse
# 半透明红色覆盖在蓝色上
RedAlpha := MakeColorAlpha(1.0, 0.0, 0.0, 0.5)   # 50% 透明度的红色
BlueAlpha := MakeColorAlpha(0.0, 0.0, 1.0, 1.0)  # 不透明的蓝色

if (Result := Over(RedAlpha, BlueAlpha)):
    # Result 是混合后的紫色，略微偏红
    Print("混合成功")
```

---

## 4. NamedColors 子模块

### 4.1 概述

`/Verse.org/Colors/NamedColors` 提供了 **140+ 预定义颜色常量**，基于 CSS 命名颜色标准。

### 4.2 使用方法

```verse
using {/Verse.org/Colors}

MyFunction():void =
    # 直接使用命名颜色
    RedColor := NamedColors.Red
    BlueColor := NamedColors.Blue
    WhiteColor := NamedColors.White
```

### 4.3 完整颜色清单

#### 基础色系

| 颜色名 | 英文名称 | 用途 |
|--------|---------|------|
| `Black` | 黑色 | 背景、文本 |
| `White` | 白色 | 背景、高亮 |
| `Red` | 红色 | 错误、警告、敌方 |
| `Green` | 绿色 | 成功、友方 |
| `Blue` | 蓝色 | 信息、友军 |
| `Yellow` | 黄色 | 警告、金币 |
| `Cyan` | 青色 | 特效、水 |
| `Magenta` / `Fuchsia` | 品红 | 特殊效果 |

#### 灰度系列

`Gray`, `Grey`, `DarkGray`, `DarkGrey`, `DimGray`, `DimGrey`, `LightGray`, `LightGrey`, `Silver`, `Gainsboro`,
`WhiteSmoke`

#### 红色系列

`DarkRed`, `Crimson`, `Firebrick`, `IndianRed`, `LightCoral`, `Salmon`, `DarkSalmon`, `LightSalmon`, `RosyBrown`,
`Coral`, `Tomato`, `OrangeRed`, `Red`

#### 橙色系列

`Orange`, `DarkOrange`, `Coral`, `Tomato`, `OrangeRed`

#### 黄色系列

`Gold`, `Yellow`, `LightYellow`, `LemonChiffon`, `PapayaWhip`, `Moccasin`, `PeachPuff`, `PaleGoldenrod`, `Khaki`,
`DarkKhaki`, `Goldenrod`, `DarkGoldenrod`

#### 绿色系列

`GreenYellow`, `Chartreuse`, `LawnGreen`, `Lime`, `LimeGreen`, `PaleGreen`, `LightGreen`, `MediumSpringGreen`,
`SpringGreen`, `MediumSeaGreen`, `SeaGreen`, `ForestGreen`, `Green`, `DarkGreen`, `YellowGreen`, `OliveDrab`,
`Olive`, `DarkOliveGreen`, `MediumAquamarine`, `DarkSeaGreen`, `LightSeaGreen`, `DarkCyan`, `Teal`

#### 蓝色系列

`Aqua`, `Cyan`, `LightCyan`, `PaleTurquoise`, `Aquamarine`, `Turquoise`, `MediumTurquoise`, `DarkTurquoise`,
`CadetBlue`, `SteelBlue`, `LightSteelBlue`, `PowderBlue`, `LightBlue`, `SkyBlue`, `LightSkyBlue`, `DeepSkyBlue`,
`DodgerBlue`, `CornflowerBlue`, `RoyalBlue`, `Blue`, `MediumBlue`, `DarkBlue`, `Navy`, `MidnightBlue`

#### 紫色系列

`Lavender`, `Thistle`, `Plum`, `Violet`, `Orchid`, `Fuchsia`, `Magenta`, `MediumOrchid`, `MediumPurple`,
`BlueViolet`, `DarkViolet`, `DarkOrchid`, `DarkMagenta`, `Purple`, `Indigo`, `SlateBlue`, `DarkSlateBlue`,
`MediumSlateBlue`

#### 粉色系列

`Pink`, `LightPink`, `Hotpink`, `DeepPink`, `PaleVioletred`, `MediumVioletRed`

#### 棕色系列

`Brown`, `Maroon`, `SaddleBrown`, `Sienna`, `Chocolate`, `Peru`, `SandyBrown`, `Burlywood`, `Tan`, `RosyBrown`

#### 白色/米色系列

`Snow`, `Honeydew`, `MintCream`, `Azure`, `AliceBlue`, `GhostWhite`, `Seashell`, `Beige`, `OldLace`, `FloralWhite`,
`Ivory`, `AntiqueWhite`, `Linen`, `LavenderBlush`, `MistyRose`, `Cornsilk`, `BlanchedAlmond`, `Bisque`,
`NavajoWhite`, `Wheat`

### 4.4 使用建议

#### 按用途选择颜色

| 用途 | 推荐颜色 |
|------|---------|
| **错误/危险** | `Red`, `Crimson`, `DarkRed` |
| **成功/确认** | `Green`, `LimeGreen`, `ForestGreen` |
| **警告/注意** | `Yellow`, `Gold`, `Orange` |
| **信息/提示** | `Blue`, `CornflowerBlue`, `SkyBlue` |
| **友军/玩家** | `Green`, `Cyan`, `Blue` |
| **敌军/对手** | `Red`, `Orange`, `Crimson` |
| **中性/禁用** | `Gray`, `DimGray`, `Silver` |
| **高亮/选中** | `Yellow`, `Gold`, `White` |

---

## 5. 代码示例

### 5.1 示例 1：UI 按钮状态颜色

```verse
using {/Verse.org/Colors}
using {/Fortnite.com/UI}

button_manager := class:
    # 按钮的不同状态颜色
    NormalColor:color = NamedColors.Gray
    HoverColor:color = NamedColors.LightBlue
    PressedColor:color = NamedColors.Blue
    DisabledColor:color = NamedColors.DarkGray

    # 根据状态获取颜色
    GetButtonColor(IsEnabled:logic, IsPressed:logic, IsHovered:logic):color =
        if (not IsEnabled):
            DisabledColor
        else if (IsPressed):
            PressedColor
        else if (IsHovered):
            HoverColor
        else:
            NormalColor

    # 使用示例
    UpdateButton(Button:button_device, State:button_state)<transacts>:void =
        CurrentColor := GetButtonColor(State.Enabled, State.Pressed, State.Hovered)
        # 应用颜色到 UI 元素
        Button.SetColor(CurrentColor)
```

---

### 5.2 示例 2：团队颜色系统

```verse
using {/Verse.org/Colors}
using {/Fortnite.com/Teams}

team_color_manager := class:
    # 为不同团队定义颜色
    TeamColors:[]color = array:
        NamedColors.Red      # Team 1: 红队
        NamedColors.Blue     # Team 2: 蓝队
        NamedColors.Green    # Team 3: 绿队
        NamedColors.Yellow   # Team 4: 黄队
        NamedColors.Purple   # Team 5: 紫队
        NamedColors.Orange   # Team 6: 橙队

    # 根据团队索引获取颜色
    GetTeamColor(TeamIndex:int)<decides>:color =
        if (TeamIndex >= 0, TeamIndex < TeamColors.Length):
            TeamColors[TeamIndex]
        else:
            NamedColors.White  # 默认颜色

    # 获取带透明度的团队颜色（用于高亮效果）
    GetTeamColorHighlight(TeamIndex:int, Alpha:float)<decides>:color_alpha =
        BaseColor := GetTeamColor(TeamIndex)
        MakeColorAlpha(BaseColor.R, BaseColor.G, BaseColor.B, Alpha)
```

---

### 5.3 示例 3：从设计师提供的颜色值创建

```verse
using {/Verse.org/Colors}

color_palette := class:
    # 场景 1: 使用十六进制值（从设计文档复制）
    BrandPrimary:color = MakeColorFromHex("#FF5733")    # 品牌主色
    BrandSecondary:color = MakeColorFromHex("#33C1FF")  # 品牌辅色

    # 场景 2: 使用 RGB 整数值
    CustomRed:color = MakeColorFromSRGBValues(220, 20, 60)  # RGB(220, 20, 60)

    # 场景 3: 使用 sRGB 浮点值（来自归一化的设计工具）
    CustomBlue:color = MakeColorFromSRGB(0.2, 0.4, 0.8)

    # 场景 4: 使用 HSV 创建渐变
    CreateHueGradient(Steps:int)<computes>:[]color =
        var Result:[]color = array{}
        for (I := 0..Steps-1):
            Hue := Float(I) * 360.0 / Float(Steps)
            Color := MakeColorFromHSV(Hue, 1.0, 1.0)
            set Result += array{Color}
        Result
```

---

### 5.4 示例 4：动态光照色温

```verse
using {/Verse.org/Colors}
using {/UnrealEngine.com/Temporary}

day_night_system := class:
    # 时间到色温的映射
    GetLightColorByTime(HourOfDay:float)<computes>:color =
        if (HourOfDay >= 6.0 and HourOfDay < 8.0):
            # 日出：暖橙色 (2500K)
            MakeColorFromTemperature(2500.0)
        else if (HourOfDay >= 8.0 and HourOfDay < 18.0):
            # 白天：日光 (6500K)
            MakeColorFromTemperature(6500.0)
        else if (HourOfDay >= 18.0 and HourOfDay < 20.0):
            # 日落：暖橙色 (3000K)
            MakeColorFromTemperature(3000.0)
        else:
            # 夜晚：蓝色月光 (8000K)
            MakeColorFromTemperature(8000.0)

    # 平滑过渡色温
    SmoothColorTransition(FromColor:color, ToColor:color, T:float)<computes>:color =
        # T 从 0.0 到 1.0，线性插值
        FromColor * (1.0 - T) + ToColor * T
```

---

### 5.5 示例 5：颜色运算与特效

```verse
using {/Verse.org/Colors}

visual_effects := class:
    # 创建闪烁效果
    CreatePulseColor(BaseColor:color, PulseIntensity:float, Time:float)<computes>:color =
        # 使用正弦波创建脉冲
        Pulse := 0.5 + 0.5 * Sin(Time * 3.14159)
        Intensity := 1.0 + PulseIntensity * Pulse
        BaseColor * Intensity

    # 创建火焰颜色效果（红-橙-黄渐变）
    CreateFlameColor(IntensityFactor:float)<computes>:color =
        # 低强度 = 深红，高强度 = 黄白
        BaseRed := NamedColors.DarkRed
        BrightYellow := NamedColors.Yellow

        # 混合两种颜色
        BlendedColor := BaseRed * (1.0 - IntensityFactor) + BrightYellow * IntensityFactor
        BlendedColor

    # 应用颜色滤镜
    ApplyColorFilter(OriginalColor:color, FilterColor:color, FilterStrength:float)<computes>:color =
        # 线性插值在原始颜色和滤镜效果之间
        FilteredColor := OriginalColor * FilterColor
        OriginalColor * (1.0 - FilterStrength) + FilteredColor * FilterStrength

    # 创建伤害指示器颜色（健康度到颜色）
    GetHealthColor(HealthPercent:float)<computes>:color =
        if (HealthPercent > 0.75):
            NamedColors.Green      # 健康
        else if (HealthPercent > 0.5):
            NamedColors.Yellow     # 注意
        else if (HealthPercent > 0.25):
            NamedColors.Orange     # 警告
        else:
            NamedColors.Red        # 危险
```

---

## 6. 常见误区澄清

### 6.1 误区：颜色值应该在 0-1 范围内

**❌ 错误理解**：
"ACES 颜色的 R、G、B 分量必须在 0.0 到 1.0 之间"

**✅ 正确理解**：

- ACES 2065-1 支持 **任意浮点值**，包括负数和大于 1.0 的值
- 这是 HDR（高动态范围）的核心特性
- 大于 1.0 的值用于表示非常明亮的光源（如太阳、火焰、爆炸）

**示例**：

```verse
# 完全合法的 HDR 颜色
BrightSunlight := color{R := 2.5, G := 2.5, B := 2.3}

# 标准颜色
NormalRed := color{R := 1.0, G := 0.0, B := 0.0}
```

**何时使用 HDR 值**：

- 光源强度（太阳、灯光、魔法效果）
- 粒子系统的发光效果
- Bloom 后处理需要的高亮区域

---

### 6.2 误区：MakeColorFromHex 会报错无效输入

**❌ 错误理解**：
"如果传入无效的十六进制字符串，函数会失败或抛出错误"

**✅ 正确理解**：

- `MakeColorFromHex` **永远不会失败**
- 无效输入会静默返回 **黑色** (`NamedColors.Black`)
- 没有错误消息或警告

**建议**：

```verse
# ⚠️ 不安全：无法知道是故意要黑色还是输入错误
MyColor := MakeColorFromHex(UserInput)

# ✅ 更好的做法：验证输入
IsValidHex(Hex:string)<computes>:logic =
    # 实现基本的十六进制验证逻辑
    # ...

GetColorFromHex(Hex:string)<decides>:color =
    if (IsValidHex(Hex)):
        MakeColorFromHex(Hex)
    else:
        # 返回失败，让调用者处理
        return false
```

---

### 6.3 误区：可以直接比较两个 color 是否相等

**❌ 错误理解**：

```verse
# 这样的代码无法编译
if (Color1 = Color2):
    # ...
```

**✅ 正确理解**：

- `color` 类型 **不支持** `=` 操作符（相等比较）
- 需要手动比较各个分量

**解决方案**：

```verse
# 精确比较
ColorsEqual(C1:color, C2:color)<computes>:logic =
    C1.R = C2.R and C1.G = C2.G and C1.B = C2.B

# 容差比较（推荐，因为浮点精度问题）
ColorsNearlyEqual(C1:color, C2:color, Epsilon:float)<computes>:logic =
    Abs(C1.R - C2.R) < Epsilon and
    Abs(C1.G - C2.G) < Epsilon and
    Abs(C1.B - C2.B) < Epsilon

# 使用示例
if (ColorsNearlyEqual(MyColor, NamedColors.Red, 0.01)):
    Print("颜色接近红色")
```

---

### 6.4 误区：NamedColors 的值是 sRGB

**❌ 错误理解**：
"NamedColors.Red 返回的是 sRGB 红色，即 `(1.0, 0.0, 0.0)` 在 sRGB 空间"

**✅ 正确理解**：

- NamedColors 的所有值都已经转换为 **ACES 2065-1** 色彩空间
- 它们是 sRGB 命名颜色的 ACES 等价物
- 内部 R、G、B 值与 sRGB 不同（经过伽马校正和色彩空间变换）

**实验**：

```verse
using {/Verse.org/Colors}

TestColorSpace():void =
    # 获取 NamedColors 的红色（已转换为 ACES）
    NamedRed := NamedColors.Red

    # 手动从 sRGB 创建红色
    ManualRed := MakeColorFromSRGB(1.0, 0.0, 0.0)

    # 它们应该非常接近（可能有微小的浮点误差）
    Print("NamedRed.R = {NamedRed.R}")
    Print("ManualRed.R = {ManualRed.R}")
```

---

### 6.5 误区：color_alpha 使用预乘 alpha

**❌ 错误理解**：
"color_alpha 的 RGB 分量已经预乘了 alpha 值"

**✅ 正确理解**：

- `color_alpha` 使用 **非预乘 alpha**（也称为"直通 alpha"）
- 颜色和 alpha 是独立存储的
- `Over` 函数会自动处理正确的混合

**预乘 vs 非预乘**：

```verse
# 非预乘（Verse 使用的方式）
CA := MakeColorAlpha(1.0, 0.0, 0.0, 0.5)  # 半透明红色
# 存储为：Color = (1.0, 0.0, 0.0), A = 0.5

# 如果是预乘（Verse 不使用）
# 会存储为：Color = (0.5, 0.0, 0.0), A = 0.5

# 使用 Over 函数时无需关心这些细节
Result := Over(CA, BackgroundColor)  # 自动正确处理
```

---

### 6.6 误区：颜色除法永远成功

**❌ 错误理解**：

```verse
# 假设这总是有效
NewColor := MyColor / Factor
```

**✅ 正确理解**：

- 除法操作符有 `<decides>` 特性，意味着它可能失败
- 除以零会导致失败
- 必须使用失败处理语法

**安全的除法**：

```verse
# 方式 1：使用 if
if (ScaledColor := MyColor / Factor):
    # 除法成功，使用 ScaledColor
    Print("颜色缩放成功")
else:
    # 除以零或其他错误
    Print("颜色缩放失败")

# 方式 2：使用 ? 操作符（需要在 failable 上下文中）
SafeScaleColor(C:color, Factor:float)<decides>:color =
    C / Factor  # 如果失败，整个函数失败

# 方式 3：使用乘法替代（如果可能）
SafeColor := MyColor * (1.0 / Factor)  # 调用者负责避免除以零
```

---

## 7. 最佳实践

### 7.1 颜色创建

#### ✅ 推荐做法

1. **优先使用 NamedColors**（当适用时）

   ```verse
   # 好：清晰、标准化
   ErrorColor := NamedColors.Red
   SuccessColor := NamedColors.Green
   ```

2. **使用 MakeColorFromHex 用于设计规范**

   ```verse
   # 从设计文档直接复制颜色值
   BrandColor := MakeColorFromHex("#FF5733")  # 品牌色：橙红
   ```

3. **使用 HSV 进行程序化颜色生成**

   ```verse
   # 创建彩虹渐变
   CreateRainbow(Steps:int):[]color =
       for (I := 0..Steps-1):
           Hue := Float(I) * 360.0 / Float(Steps)
           MakeColorFromHSV(Hue, 1.0, 1.0)
   ```

#### ❌ 避免做法

```verse
# 不好：硬编码的魔法数字
MyColor := color{R := 0.7345, G := 0.2156, B := 0.9234}

# 更好：使用命名颜色或转换函数
MyColor := MakeColorFromSRGB(0.8, 0.3, 0.9)
```

---

### 7.2 性能优化

#### 1. 缓存转换结果

```verse
# ❌ 低效：每帧都转换
UpdateUI(Frame:int)<transacts>:void =
    ButtonColor := MakeColorFromHex("#FF5733")  # 重复转换
    ApplyColor(ButtonColor)

# ✅ 高效：转换一次，重复使用
button_renderer := class:
    CachedButtonColor:color = MakeColorFromHex("#FF5733")

    UpdateUI(Frame:int)<transacts>:void =
        ApplyColor(CachedButtonColor)
```

#### 2. 避免不必要的色彩空间转换

```verse
# ❌ 低效：来回转换
MyColor := MakeColorFromSRGB(0.5, 0.5, 0.5)
(R, G, B) := MakeSRGBFromColor(MyColor)  # 不必要的转换
AnotherColor := MakeColorFromSRGB(R, G, B)

# ✅ 高效：直接使用
MyColor := MakeColorFromSRGB(0.5, 0.5, 0.5)
AnotherColor := MyColor  # 结构体复制很快
```

#### 3. 批量操作

```verse
# ❌ 低效：逐个处理
ProcessColors(Colors:[]color):[]color =
    var Result:[]color = array{}
    for (C : Colors):
        NewColor := C * 0.5
        set Result += array{NewColor}
    Result

# ✅ 更高效：使用 for 表达式
ProcessColors(Colors:[]color):[]color =
    for (C : Colors):
        C * 0.5
```

---

### 7.3 可维护性

#### 1. 创建颜色常量库

```verse
# 集中管理游戏的所有颜色
game_colors := class:
    # UI 颜色
    PrimaryButton:color = MakeColorFromHex("#3498db")
    SecondaryButton:color = MakeColorFromHex("#95a5a6")
    DangerButton:color = NamedColors.Red

    # 团队颜色
    Team1:color = NamedColors.Blue
    Team2:color = NamedColors.Red

    # 状态颜色
    HealthHigh:color = NamedColors.Green
    HealthMedium:color = NamedColors.Yellow
    HealthLow:color = NamedColors.Red
    HealthCritical:color = NamedColors.Crimson
```

#### 2. 使用枚举模拟颜色主题

```verse
team_color<native><epic_internal> := enum:
    TeamBlue
    TeamRed
    TeamGreen
    TeamYellow

GetTeamColor(Team:team_color):color =
    case (Team):
        TeamBlue => NamedColors.Blue
        TeamRed => NamedColors.Red
        TeamGreen => NamedColors.Green
        TeamYellow => NamedColors.Yellow
```

#### 3. 文档化颜色选择理由

```verse
# 使用注释说明为什么选择这个颜色
WarningColor:color = NamedColors.Orange  # 符合 WCAG AA 对比度标准
HighlightColor:color = MakeColorFromHex("#FFD700")  # 品牌指南要求
```

---

### 7.4 与其他模块配合

#### 1. 与 UI 模块配合

```verse
using {/Verse.org/Colors}
using {/Fortnite.com/UI}

# 为 UI 文本设置颜色
SetTextColor(TextWidget:text_block, TextColor:color)<transacts>:void =
    TextWidget.SetColor(TextColor)

# 创建渐变文本（通过多个片段）
CreateGradientText(Text:string, Colors:[]color)<transacts>:canvas_slot =
    # 实现将文本分段并应用渐变颜色
    # ...
```

#### 2. 与 SceneGraph/光照配合

```verse
using {/Verse.org/Colors}
using {/Verse.org/SceneGraph}

# 设置光源颜色
ConfigureLight(Light:light_component, LightColor:color, Intensity:float)<transacts>:void =
    set Light.Intensity = Intensity
    # 光源颜色通过滤镜应用
    # set Light.ColorFilter = LightColor
    # （具体 API 取决于 SceneGraph 版本）
```

#### 3. 与 Print 调试配合

```verse
using {/Verse.org/Colors}

# 使用彩色打印区分日志等级
PrintDebug(Message:string):void =
    Print(Message, Color := NamedColors.Gray)

PrintInfo(Message:string):void =
    Print(Message, Color := NamedColors.White)

PrintWarning(Message:string):void =
    Print(Message, Color := NamedColors.Yellow)

PrintError(Message:string):void =
    Print(Message, Color := NamedColors.Red)
```

---

### 7.5 HDR 工作流

#### 何时使用 HDR 颜色

```verse
# ✅ 适合 HDR：光源、发光效果
SunlightColor := color{R := 2.0, G := 2.0, B := 1.8}  # 明亮的阳光
ExplosionGlow := NamedColors.Orange * 3.0             # 爆炸的发光

# ❌ 不适合 HDR：UI 颜色、普通材质
ButtonColor := color{R := 2.0, G := 0.0, B := 0.0}  # UI 不需要这么亮
```

#### HDR 色彩范围指南

| 亮度倍数 | 使用场景 |
|---------|---------|
| 0.0 - 1.0 | 标准色彩（UI、常规材质） |
| 1.0 - 2.0 | 轻微发光（魔法效果、能量护盾） |
| 2.0 - 5.0 | 明显发光（火焰、霓虹灯、激光） |
| 5.0 - 10.0 | 强烈光源（爆炸、闪电、太阳直射） |
| > 10.0 | 极端光源（核爆、恒星、魔法爆发） |

---

## 8. 参考资源

### 8.1 官方文档

- **UEFN 官方文档 - Colors API**
  - <https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference#Colors>

- **Verse 语言参考**
  - <https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference>

### 8.2 本地参考文档

- **API Digest 文件**
  - `skills/verseDev/shared/api-digests/Verse.digest.verse.md` (第 1669-2030 行)

- **模块关系索引**
  - `skills/verseDev/shared/references/api-modules-list.md`
  - `skills/verseDev/shared/references/api-modules-research.md`

### 8.3 相关 API 模块

| 模块 | 关系 | 用途 |
|------|------|------|
| `/Verse.org/Verse` | 依赖关系 | Colors 被 Verse 核心模块使用 |
| `/Verse.org/SceneGraph` | 配合使用 | 设置场景对象和光源的颜色 |
| `/Fortnite.com/UI` | 配合使用 | UI 元素的颜色设置 |
| `/Verse.org/SpatialMath` | 数学工具 | 颜色插值可能用到向量运算 |

### 8.4 外部参考

- **ACES 色彩空间**
  - [Academy Color Encoding System](https://www.oscars.org/science-technology/sci-tech-projects/aces)

- **sRGB 色彩空间**
  - [sRGB on Wikipedia](https://en.wikipedia.org/wiki/SRGB)

- **HSV 色彩模型**
  - [HSV Color Model Explanation](https://en.wikipedia.org/wiki/HSL_and_HSV)

- **CSS 命名颜色**
  - [CSS Color Keywords](https://www.w3.org/wiki/CSS/Properties/color/keywords)

---

## 附录 A：快速参考卡

### 常用函数速查

```verse
# 创建颜色
NamedColors.Red                                    # 预定义颜色
MakeColorFromHex("#FF5733")                        # 十六进制
MakeColorFromSRGBValues(255, 87, 51)              # RGB 整数
MakeColorFromSRGB(1.0, 0.34, 0.2)                 # RGB 浮点
MakeColorFromHSV(15.0, 0.8, 1.0)                  # HSV
MakeColorFromTemperature(6500.0)                   # 色温

# 颜色运算
Color1 + Color2                                    # 相加
Color1 * 0.5                                       # 变暗
Color1 * Color2                                    # 混合

# 转换
MakeSRGBFromColor(MyColor)                         # 转为 sRGB
MakeHSVFromColor(MyColor)                          # 转为 HSV

# 透明度
MakeColorAlpha(1.0, 0.0, 0.0, 0.5)                # 创建半透明色
Over(ForegroundColor, BackgroundColor)             # Alpha 混合
```

### 常见配色方案

```verse
# 成功/失败提示
SuccessGreen := NamedColors.Green
ErrorRed := NamedColors.Red
WarningOrange := NamedColors.Orange
InfoBlue := NamedColors.CornflowerBlue

# 团队颜色（4 队）
Teams := array{NamedColors.Red, NamedColors.Blue, NamedColors.Green, NamedColors.Yellow}

# 健康度梯度
HealthColors := array{NamedColors.Red, NamedColors.Orange, NamedColors.Yellow, NamedColors.Green}

# 稀有度（类似游戏物品品质）
Common := NamedColors.Gray
Uncommon := NamedColors.Green
Rare := NamedColors.Blue
Epic := NamedColors.Purple
Legendary := NamedColors.Gold
```

---

## 附录 B：颜色空间转换数学

### sRGB 到 ACES 转换

当你使用 `MakeColorFromSRGB` 时，内部执行以下步骤：

1. **去除 Gamma 校正**（sRGB 是非线性的）

   ```text
   如果 C <= 0.04045:
       Linear = C / 12.92
   否则:
       Linear = ((C + 0.055) / 1.055) ^ 2.4
   ```

2. **色彩空间变换**（矩阵乘法，从 sRGB 到 ACES）

   ```text
   ACES = sRGB_to_ACES_Matrix * Linear_sRGB
   ```

### HSV 到 RGB 转换

`MakeColorFromHSV` 使用标准的 HSV 到 RGB 算法（在 sRGB 空间执行后转为 ACES）。

---

## 附录 C：常见问题 FAQ

**Q1: 为什么我的颜色看起来和预期不一样？**

A: 检查以下几点：

1. 确认使用了正确的转换函数（sRGB vs ACES）
2. 检查显示器的色彩配置
3. 确认光照环境没有覆盖颜色
4. 验证是否应用了后处理效果

---

**Q2: 如何在 Verse 中实现颜色动画？**

A: 使用颜色插值：

```verse
LerpColor(From:color, To:color, T:float)<computes>:color =
    From * (1.0 - T) + To * T
```

---

**Q3: color_alpha 什么时候可用？**

A: 从 Fortnite 版本 38.00 开始（`@available {MinUploadedAtFNVersion := 3800}`）。检查你的 UEFN 版本。

---

**Q4: 如何调试颜色值？**

A:

```verse
DebugColor(C:color, Label:string):void =
    (R, G, B) := MakeSRGBFromColor(C)
    Print("{Label}: sRGB({R}, {G}, {B})")
```

---

**Q5: NamedColors 的颜色值可以修改吗？**

A: 不可以，它们是只读常量。如果需要自定义颜色，创建自己的变量：

```verse
MyCustomRed := NamedColors.Red * 0.8  # 稍微暗一点的红色
```

---

**文档版本**: 1.0  
**最后更新**: 2026-01-04  
**适用 UEFN 版本**: 39.11 及更高版本  
**API 版本**: ++Fortnite+Release-39.11-CL-49242330
