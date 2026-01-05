# 曲线构造器架构图

## 整体架构

```
┌─────────────────────────────────────────────────────────────────┐
│                    Curve Builder System                         │
│                    曲线构造器系统                                 │
└─────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌───────────────┐    ┌────────────────┐    ┌──────────────┐
│  应用层        │    │  组合层         │    │  实现层       │
│  Application  │    │  Composition   │    │ Implementation│
└───────────────┘    └────────────────┘    └──────────────┘
        │                     │                     │
        │                     │                     │
        ▼                     ▼                     ▼
┌───────────────┐    ┌────────────────┐    ┌──────────────┐
│curve_player   │    │sequential_curve│    │curve_1d      │
│curve_library  │    │blended_curve   │    │curve_3d      │
│motion_templates│   │additive_curve  │    │curve_nd      │
└───────────────┘    │composite_curve │    └──────────────┘
                     └────────────────┘            │
                                                   │
                                                   ▼
                                          ┌──────────────┐
                                          │  具体曲线类型  │
                                          ├──────────────┤
                                          │Linear        │
                                          │CubicBezier   │
                                          │BSpline       │
                                          │Parabolic     │
                                          │Sinusoidal    │
                                          │Sampled       │
                                          └──────────────┘
```

## 接口层次

```
                    curve_value<T>
                         ▲
                         │ implements
                         │
        ┌────────────────┼────────────────┐
        │                │                │
   float_value     vector3_value     color_value
        │                │                │
        │                │                │
        └────────────────┼────────────────┘
                         │
                         ▼
                    curve<T>
                         ▲
                         │ extends
                         │
        ┌────────────────┼────────────────┐
        │                │                │
    curve_1d        curve_3d          curve_nd<N>
        │                │                │
        │                │                │
        ▼                ▼                ▼
  [具体1D曲线]     [具体3D曲线]      [具体ND曲线]
```

## 曲线组合模式

### 串联组合（Sequential）

```
Curve A (2s)  →  Curve B (3s)  →  Curve C (1s)
    │                │                │
    └────────────────┴────────────────┘
                     │
                     ▼
           sequential_curve (6s total)
```

### 并联组合（Blended）

```
Curve A (weight: 0.7)  ┐
                       ├─→  blended_curve
Curve B (weight: 0.3)  ┘
```

### 叠加组合（Additive）

```
Base Curve     ┐
               │
Float Curve    ├─→  additive_curve
               │
Jitter Curve   ┘
```

### 嵌套组合（Nested）

```
Inner Curve (time warp)
       │
       ▼
   parameter t
       │
       ▼
Outer Curve (path)
       │
       ▼
   final position
```

## 构造方式层次

```
┌─────────────────────────────────────────────────────────┐
│  L3: 预设模板层（Preset Templates）                      │
│  - motion_templates.ElevatorMotion()                    │
│  - motion_templates.ItemCollectArc()                    │
│  - motion_templates.FloatingDisplay()                   │
└─────────────────────────────────────────────────────────┘
                         │ 使用
                         ▼
┌─────────────────────────────────────────────────────────┐
│  L2: 语义参数层（Semantic Parameters）                   │
│  - curve_builder.EasingCurve(start, end, type)         │
│  - curve_builder.ThrowPath(from, to, height)           │
│  - curve_builder.LinearMotion(from, to, duration)      │
└─────────────────────────────────────────────────────────┘
                         │ 使用
                         ▼
┌─────────────────────────────────────────────────────────┐
│  L1: 数学参数层（Mathematical Parameters）               │
│  - cubic_bezier_curve_1d{P0, P1, P2, P3}              │
│  - bspline_curve_3d{ControlPoints, Degree, Knots}     │
│  - parabolic_curve_3d{Start, Velocity, Gravity}       │
└─────────────────────────────────────────────────────────┘
```

## 数据流

```
用户需求
   │
   ▼
构造器（curve_builder）
   │
   ├─→ L3: 选择预设模板
   │      │
   │      ▼
   ├─→ L2: 指定语义参数
   │      │
   │      ▼
   └─→ L1: 设置数学参数
          │
          ▼
      curve<T> 实例
          │
          ▼
    组合器（可选）
    - sequential
    - blended
    - additive
    - nested
          │
          ▼
    curve_player
          │
          ▼
    每帧 Update
          │
          ▼
    Evaluate(t) → 值
          │
          ▼
  应用到 movement_component
```

## 与 Verse API 集成

```
┌────────────────────────────────────────────────────────┐
│           Curve Builder System                         │
│                                                        │
│  curve<T>                                              │
│    │                                                   │
│    ├─→ verse_easing_curve_adapter                     │
│    │      │                                            │
│    │      └─→ cubic_bezier_easing_function (Verse)    │
│    │                                                   │
│    └─→ CreateKeyframeSequenceFromCurve()              │
│           │                                            │
│           └─→ []keyframe_delta (Verse)                │
│                  │                                     │
│                  └─→ keyframed_movement_component     │
└────────────────────────────────────────────────────────┘
```

## 典型使用场景流程

### 场景1：电梯运动

```
需求: 3层电梯，缓入缓出
         │
         ▼
curve_builder.Sequential([
   Segment1: EaseInOut(0→300, 3s),
   Segment2: Linear(300→300, 2s),  ← 停靠
   Segment3: EaseInOut(300→600, 3s),
   Segment4: Linear(600→600, 2s)   ← 停靠
])
         │
         ▼
   curve_player
         │
         ▼
每帧 Update → 高度值
         │
         ▼
应用到电梯 Entity
```

### 场景2：浮动宝箱

```
需求: 上下浮动 + 旋转
         │
         ▼
curve_builder.Additive([
   constant_curve_3d(base_position),
   sinusoidal_curve_3d(vertical, freq=0.8),
   sinusoidal_curve_3d(horizontal, freq=1.2)
])
         │
         ▼
   curve_player (Loop mode)
         │
         ▼
每帧 Update → 位置向量
         │
         ▼
应用到宝箱 Entity
```

## 性能优化架构

```
原始曲线 (curve<T>)
      │
      ▼
  是否需要优化？
      │
      ├─ YES ─→ cached_curve<T>
      │            │
      │            ├─→ 预采样（100点）
      │            └─→ 线性插值查表
      │
      └─ NO ──→ 直接计算
```

## 扩展点

```
┌─────────────────────────────────────────┐
│  扩展点1: 自定义曲线类型                  │
│  - 实现 curve<T> 接口                   │
│  - 注册到 curve_library                 │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  扩展点2: 自定义组合方式                  │
│  - 继承 curve<T>                        │
│  - 组合多个子曲线                         │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  扩展点3: 自定义预设模板                  │
│  - 实现 curve_preset 接口               │
│  - 注册到 curve_library                 │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  扩展点4: 可视化编辑器                    │
│  - 实现 curve_editor_interface          │
│  - JSON 序列化/反序列化                  │
│  - 控制点编辑                            │
└─────────────────────────────────────────┘
```

---

**创建日期**: 2026-01-05  
**关联文档**: curve-builder-system.md  
**状态**: ✅ 架构设计完成

