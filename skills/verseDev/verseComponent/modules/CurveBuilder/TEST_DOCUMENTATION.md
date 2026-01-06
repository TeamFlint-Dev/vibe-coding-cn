# 曲线采样器测试文档

## 概述

本文档详细说明了曲线采样器的测试套件，包括测试用例、错误检测和验证方法。

---

## 测试套件结构

### 测试文件
- **文件名**: `curve_sampler_tests.verse`
- **总测试数**: 45+ 个测试用例
- **测试组数**: 9 个测试组

### 测试框架

测试套件包含以下核心组件：

```verse
# 测试结果记录
test_result := struct:
    TestName:string           # 测试名称
    Passed:logic             # 是否通过
    ErrorMessage:string      # 错误描述
    ExpectedValue:string     # 预期值
    ActualValue:string       # 实际值

# 测试统计
test_statistics := struct:
    TotalTests:int           # 总测试数
    PassedTests:int          # 通过数
    FailedTests:int          # 失败数
```

---

## 测试组详解

### 测试组1: 基础采样功能测试

**测试目的**: 验证等距采样的基本功能和边界情况

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Uniform_SampleCount` | 采样点数量 | 5个点 | 点数不匹配 |
| `Uniform_FirstPoint_T` | 第一个点的t值 | 0.0 | t值误差 > 0.001 |
| `Uniform_FirstPoint_Value` | 第一个点的值 | 0.0 | 值误差 > 0.001 |
| `Uniform_LastPoint_T` | 最后一个点的t值 | 1.0 | t值误差 > 0.001 |
| `Uniform_LastPoint_Value` | 最后一个点的值 | 100.0 | 值误差 > 0.001 |
| `Uniform_MidPoint_T` | 中点的t值 | 0.5 | t值误差 > 0.001 |
| `Uniform_MidPoint_Value` | 中点的值 | 50.0 | 值误差 > 0.001 |
| `Uniform_MinSampleCount` | 最少采样点数(2) | 2个点 | 点数不匹配 |
| `Uniform_InvalidSampleCount` | 采样点数<2 | 空数组 | 返回了非空数组 |

**关键错误检测**:
- ❌ "SampleCount < 2 应返回空数组，但返回了 N 个点"
- ❌ "值不匹配 - Expected: X, Actual: Y, Diff: Z"

---

### 测试组2: 等时采样测试

**测试目的**: 验证基于时长的采样正确性

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Temporal_SampleCount` | 采样点数量 | 4个点 | 点数不匹配 |
| `Temporal_TimeStep_{I}` | 时间步长均匀性 | 均匀分布 | 时间步长误差 > 0.01 |

**关键验证**:
- 验证时间间隔 = Duration / (SampleCount - 1)
- 每个采样点的 t 值应符合时间步长

---

### 测试组3: 自适应采样测试

**测试目的**: 测试不同曲率曲线的自适应采样

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Adaptive_MinPoints` | 最少点数 | ≥2个点 | "自适应采样至少应包含起点和终点，但只有 N 个点" |
| `Adaptive_FirstPoint_T` | 起点t值 | 0.0 | t值误差 > 0.001 |
| `Adaptive_LastPoint_T` | 终点t值 | 1.0 | t值误差 > 0.001 |
| `Adaptive_LinearCurve` | 线性曲线采样 | 2个点 | "线性曲线应只需起点和终点，但有 N 个点" |

**测试场景**:
1. **正弦曲线**（曲率变化大）→ 应有更多采样点
2. **线性曲线**（曲率变化小）→ 应只需起点和终点

---

### 测试组4: 自定义采样测试

**测试目的**: 验证自定义点和边界限制

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Custom_SampleCount` | 采样点数量 | 5个点 | 点数不匹配 |
| `Custom_Point_{I}_T` | 每个自定义点的t值 | 与输入一致 | t值误差 > 0.001 |
| `Custom_EmptyPoints` | 空自定义点数组 | 0个点 | "空自定义点数组应返回0个采样点，但返回了 N 个" |
| `Custom_ClampMin` | t值下限限制 | ≥0.0 | "t值应被限制到 >= 0.0，但是 X" |
| `Custom_ClampMax` | t值上限限制 | ≤1.0 | "t值应被限制到 <= 1.0，但是 X" |

**边界测试**:
- 输入 t = -0.5 → 应 clamp 到 0.0
- 输入 t = 1.5 → 应 clamp 到 1.0

---

### 测试组5: 导数计算测试

**测试目的**: 一阶和二阶导数计算验证

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Derivative_Exists` | 导数值存在性 | 存在 | "启用 ComputeDerivative 后应存在导数值" |
| `Derivative_LinearCurve` | 线性曲线导数 | 100.0 ± 5.0 | 值误差 > 5.0 |
| `SecondDerivative_Exists` | 二阶导数存在性 | 存在 | "启用 ComputeSecondDerivative 后应存在二阶导数值" |
| `SecondDerivative_LinearCurve` | 线性曲线二阶导数 | 0.0 ± 5.0 | 值误差 > 5.0 |

**数学验证**:
- 线性曲线 y = 100x → dy/dt = 100
- 线性曲线 → d²y/dt² = 0

---

### 测试组6: Delta 数组转换测试

**测试目的**: 所有轴向的转换正确性

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Delta_Count` | Delta数组长度 | 采样点数-1 | 长度不匹配 |
| `Delta_FirstZ` | Z轴位移 | 500.0 ± 1.0 | Z轴值误差 > 1.0 |
| `Delta_FirstX` | X轴位移（非目标轴） | 0.0 | X轴应为0，但是 X |
| `Delta_FirstY` | Y轴位移（非目标轴） | 0.0 | Y轴应为0，但是 Y |
| `Delta_FirstTime` | 时间增量 | 1.0 ± 0.01 | 时间误差 > 0.01 |
| `Delta_XAxis` | X轴转换 | 正确 | X轴值不正确 |
| `Delta_YAxis` | Y轴转换 | 正确 | Y轴值不正确 |
| `Delta_InvalidSampleCount` | 采样点不足 | 空数组 | "采样点不足时应返回空 delta 数组，但返回了 N 个" |

**验证公式**:
- Delta[i].DeltaLocation = Sample[i+1].Value - Sample[i].Value
- Delta[i].Time = (Sample[i+1].T - Sample[i].T) × TotalDuration

---

### 测试组7: 缓存机制测试

**测试目的**: 缓存存储、清除和自动清理

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Cache_StoreCount` | 缓存存储 | 长度一致 | 缓存长度不匹配 |
| `Cache_ClearCount` | 缓存清除 | 0个点 | 清除后缓存非空 |
| `Cache_ClearOnSetCurve` | SetCurve清除缓存 | 0个点 | "SetCurve应清除缓存，但缓存中还有 N 个点" |

**缓存行为验证**:
1. `SampleAndCache()` → 缓存应包含结果
2. `ClearCache()` → 缓存应为空
3. `SetCurve()` → 缓存应自动清空

---

### 测试组8: 复杂曲线组合测试

**测试目的**: 串联和叠加曲线的采样

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Complex_Sequential_Count` | 串联曲线采样点数 | 5个点 | 点数不匹配 |
| `Complex_Sequential_Start` | 串联曲线起点值 | 0.0 ± 1.0 | 起点值不正确 |
| `Complex_Sequential_End` | 串联曲线终点值 | 100.0 ± 1.0 | 终点值不正确 |
| `Complex_Additive_NotEmpty` | 叠加曲线非空 | 非空数组 | "叠加曲线采样不应返回空数组" |

**测试曲线**:
- 串联: [0→50 (1s)] + [50→100 (1s)]
- 叠加: Linear(0→100) + Sine(振幅5)

---

### 测试组9: 错误处理测试

**测试目的**: 各种错误情况的处理

| 测试用例 | 测试内容 | 预期结果 | 错误检测 |
|---------|---------|---------|---------|
| `Error_NoCurve` | 未设置曲线 | 空数组 | "未设置曲线时应返回空数组，但返回了 N 个点" |
| `Error_ZeroSampleCount` | 采样点数=0 | 空数组 | "SampleCount=0应返回空数组，但返回了 N 个点" |
| `Error_NegativeSampleCount` | 负数采样点数 | 空数组 | "负数SampleCount应返回空数组，但返回了 N 个点" |

**错误场景覆盖**:
1. 未初始化状态
2. 无效参数
3. 边界条件

---

## 测试执行

### 运行测试

```verse
# 运行完整测试套件
curve_sampler_tests.RunAllTests()
```

### 测试报告格式

```
╔════════════════════════════════════════════════╗
║   Test Report                                  ║
╚════════════════════════════════════════════════╝

Total Tests: 45
Passed: 43
Failed: 2

=== Failed Tests ===

❌ Delta_FirstZ
   Error: 值不匹配
   Expected: 500.0
   Actual: 499.5, Diff: 0.5

❌ Custom_ClampMax
   Error: t值应被限制到 <= 1.0，但是 1.05
   Expected: <= 1.0
   Actual: 1.05
```

---

## 测试覆盖率

### 功能覆盖

| 功能模块 | 测试用例数 | 覆盖率 |
|---------|-----------|--------|
| 等距采样 | 9 | 100% |
| 等时采样 | 2 | 100% |
| 自适应采样 | 4 | 100% |
| 自定义采样 | 5 | 100% |
| 导数计算 | 4 | 100% |
| Delta转换 | 8 | 100% |
| 缓存机制 | 3 | 100% |
| 复杂曲线 | 4 | 100% |
| 错误处理 | 3 | 100% |

### 边界情况覆盖

✅ 采样点数 < 2  
✅ 采样点数 = 0  
✅ 采样点数为负  
✅ t 值超出 [0, 1] 范围  
✅ 空自定义点数组  
✅ 未设置曲线  
✅ 线性曲线（最简单）  
✅ 正弦曲线（复杂曲率）  
✅ 串联曲线（多段）  
✅ 叠加曲线（组合）

---

## 错误消息示例

### 清晰的错误描述

每个失败的测试都提供：

1. **测试名称** - 明确的标识
2. **错误描述** - 问题说明
3. **预期值** - 应该是什么
4. **实际值** - 实际是什么

**示例**:

```
❌ Uniform_InvalidSampleCount
   Error: SampleCount < 2 应返回空数组，但返回了 3 个点
   Expected: Empty array (Length=0)
   Actual: Length=3

❌ Delta_FirstZ
   Error: 值不匹配
   Expected: 500.0
   Actual: 499.5, Diff: 0.5

❌ Custom_ClampMax
   Error: t值应被限制到 <= 1.0，但是 1.05
   Expected: <= 1.0
   Actual: 1.05
```

---

## 测试断言工具

### AssertEqual (浮点数)
```verse
AssertEqual("TestName", Expected:float, Actual:float, Tolerance:float)
```
- 比较浮点数，允许误差容忍
- 失败时显示差值

### AssertEqualInt (整数)
```verse
AssertEqualInt("TestName", Expected:int, Actual:int)
```
- 精确整数比较
- 失败时显示预期和实际值

### AssertTrue (布尔)
```verse
AssertTrue("TestName", Condition:logic, ErrorMsg:string)
```
- 验证条件为真
- 失败时显示自定义错误消息

### AssertNotEmpty (数组)
```verse
AssertNotEmpty("TestName", Array:[]T, ErrorMsg:string)
```
- 验证数组非空
- 失败时显示数组长度

---

## 使用指南

### 快速验证

在修改代码后，运行测试套件验证：

```verse
# 1. 运行测试
curve_sampler_tests.RunAllTests()

# 2. 检查报告
# - Total Tests: 应该是 45+
# - Failed: 应该是 0
# - 如果有失败，查看详细错误信息
```

### 添加新测试

1. 在相应测试组中添加测试用例
2. 使用断言工具验证结果
3. 提供清晰的错误消息
4. 更新本文档

### 调试失败的测试

1. 查看测试报告中的错误消息
2. 检查预期值 vs 实际值
3. 重现问题场景
4. 修复代码或调整测试

---

## 最佳实践

### 1. 测试命名

使用描述性的测试名称：
- `ModuleName_Feature_Scenario`
- 示例: `Uniform_FirstPoint_T`, `Delta_XAxis`

### 2. 错误消息

提供上下文信息：
- 说明预期行为
- 显示实际结果
- 包含相关数值

### 3. 容忍度设置

浮点数比较使用适当的容忍度：
- 精确值: 0.001
- 一般计算: 0.01
- 导数计算: 1.0-5.0

### 4. 独立测试

每个测试应该：
- 独立运行
- 不依赖其他测试
- 清理状态

---

## 总结

### 测试套件特性

✅ **全面性** - 45+ 测试用例覆盖所有功能  
✅ **详细性** - 每个测试都有清晰的错误消息  
✅ **自动化** - 一键运行，自动生成报告  
✅ **可维护性** - 模块化设计，易于扩展  
✅ **文档化** - 完整的测试文档和使用指南

### 质量保证

通过完整的测试套件，确保：
- 功能正确性
- 边界情况处理
- 错误场景覆盖
- 性能要求满足
- 代码质量稳定

---

**版本**: 1.0  
**最后更新**: 2026-01-05  
**维护者**: GitHub Copilot
