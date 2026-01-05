# CurveBuilder 模块

## 概述

CurveBuilder 是一个完整的曲线构造和组合系统，用于 `movement_manager_component` 体系中的路径控制、数值控制和旋转控制。

## 模块结构

```
CurveBuilder/
├── README.md                    # 本文档
├── curve_base.verse             # 核心接口和基础曲线类型
├── curve_composition.verse      # 曲线组合机制
├── curve_builder.verse          # 曲线构造器工厂
└── curve_builder_demo.verse     # 使用演示
```

## 已实现的曲线类型

### 1. 基础曲线

- **linear_curve_1d** - 线性曲线
  - 用途：匀速运动、简单插值
  - 参数：`Start`, `End`

- **cubic_bezier_curve_1d** - 三次贝塞尔曲线
  - 用途：缓动动画、平滑过渡
  - 参数：`P0`（起点）, `P1`, `P2`（控制点）, `P3`（终点）

- **sinusoidal_curve_1d** - 正弦曲线
  - 用途：周期运动、波浪效果、呼吸动画
  - 参数：`Amplitude`（振幅）, `Frequency`（频率）, `Phase`（相位）, `Offset`（偏移）

### 2. 组合曲线

- **sequential_curve** - 串联曲线
  - 用途：多段运动首尾相接
  - 参数：`Segments`（曲线段数组）

- **blended_curve** - 加权混合曲线
  - 用途：多条曲线按权重融合
  - 参数：`Curves`（带权重的曲线数组）

- **additive_curve** - 叠加曲线
  - 用途：多条曲线值相加
  - 参数：`Curves`（曲线数组）

## 构造方式

### L1: 直接构造（数学参数）

```verse
# 直接创建线性曲线
LinearCurve := linear_curve_1d{Start := 0.0, End := 100.0}

# 直接创建贝塞尔曲线
BezierCurve := cubic_bezier_curve_1d{
    P0 := 0.0, 
    P1 := 25.0, 
    P2 := 75.0, 
    P3 := 100.0
}
```

### L2: 工厂方法（简化构造）

```verse
# 使用 curve_builder 模块
LinearCurve := curve_builder.Linear(0.0, 100.0)
BezierCurve := curve_builder.CubicBezier(0.0, 25.0, 75.0, 100.0)
SineCurve := curve_builder.Sine(10.0, 1.0, 0.0, 50.0)
```

### L3: 语义构造（业务友好）

```verse
# 创建缓动曲线
EasingCurve := curve_builder.EasingCurve(0.0, 100.0, easing_type.EaseInOut)

# 使用预设
EaseCurve := easing_presets.EaseInOut()
```

## 组合示例

### 串联组合（Sequential）

```verse
# 创建3段运动：加速 → 匀速 → 减速
Segment1 := curve_segment{
    Curve := curve_builder.EasingCurve(0.0, 50.0, easing_type.EaseIn),
    Duration := 1.0
}

Segment2 := curve_segment{
    Curve := curve_builder.Linear(50.0, 80.0),
    Duration := 2.0
}

Segment3 := curve_segment{
    Curve := curve_builder.EasingCurve(80.0, 100.0, easing_type.EaseOut),
    Duration := 1.0
}

SeqCurve := curve_builder.Sequential(array{Segment1, Segment2, Segment3})
```

### 加权混合（Blended）

```verse
# 主路径（80%）+ 抖动路径（20%）
MainPath := curve_builder.Linear(0.0, 100.0)
JitterPath := curve_builder.Sine(5.0, 10.0, 0.0, 50.0)

BlendedCurve := curve_builder.Blended(array{
    weighted_curve{Curve := MainPath, Weight := 0.8},
    weighted_curve{Curve := JitterPath, Weight := 0.2}
})
```

### 叠加组合（Additive）

```verse
# 基础运动 + 振荡效果
BaseMotion := curve_builder.Linear(0.0, 100.0)
Oscillation := curve_builder.Sine(3.0, 5.0, 0.0, 0.0)

AdditiveCurve := curve_builder.Additive(array{BaseMotion, Oscillation})
```

## 使用演示

运行 `curve_builder_demo.RunAllDemos()` 可以看到所有功能的演示：

1. **基础曲线类型** - 展示 Linear, Bezier, Sine 三种基础曲线
2. **工厂方法** - 展示使用 curve_builder 模块构造曲线
3. **语义构造** - 展示使用缓动类型构造曲线
4. **串联组合** - 展示多段曲线首尾相接
5. **加权混合** - 展示多曲线按权重融合
6. **叠加组合** - 展示多曲线值相加
7. **复杂组合** - 展示组合方式的嵌套使用

## 核心接口

### curve_1d (抽象基类)

所有1D曲线的基类，定义核心接口：

```verse
curve_1d := class<abstract>:
    Evaluate(T:float)<computes>:float           # 计算曲线值
    GetDuration()<computes>:float                # 获取时长
    GetTangent(T:float)<computes>:float         # 获取切线
```

### curve_builder (工厂模块)

提供便捷的曲线构造方法：

```verse
curve_builder := module:
    Linear(Start, End)
    CubicBezier(P0, P1, P2, P3)
    Sine(Amplitude, Frequency, Phase, Offset)
    EasingCurve(Start, End, Type)
    Sequential(Segments)
    Blended(Curves)
    Additive(Curves)
```

## 验证完成情况

✅ **问题1：曲线类型是否全部实现？**
- ✅ linear_curve_1d（线性）
- ✅ cubic_bezier_curve_1d（贝塞尔）
- ✅ sinusoidal_curve_1d（正弦）

✅ **问题2：组合方式是否全部实现？**
- ✅ sequential_curve（串联）
- ✅ blended_curve（加权混合）
- ✅ additive_curve（叠加）

✅ **问题3：构造方法是否全部实现？**
- ✅ 直接构造（L1）
- ✅ 工厂方法（L2）
- ✅ 语义构造（L3）

✅ **问题4：是否有完整演示？**
- ✅ curve_builder_demo 包含所有功能演示
- ✅ 展示基础曲线、组合方式、构造方法

## 下一步扩展

- [ ] 3D曲线支持（curve_3d）
- [ ] 抛物线曲线（parabolic_curve）
- [ ] B样条曲线（bspline_curve）
- [ ] 曲线播放器（curve_player）
- [ ] 性能优化（缓存、预计算）

---

**版本**: 1.0  
**状态**: P0 核心功能完成  
**最后更新**: 2026-01-05
