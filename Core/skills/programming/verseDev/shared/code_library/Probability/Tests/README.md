# 概率系统测试文档

## 概述

本目录包含概率系统的完整测试套件，用于验证各模块的功能正确性和帮助定位问题。

## 测试文件

### ProbabilityTests.verse

完整的测试套件，包含12个测试用例，覆盖：

1. **基础功能测试** (3个)
   - 随机整数范围验证
   - 随机浮点数范围验证
   - 概率分布验证

2. **加权选择测试** (1个)
   - 加权选择分布验证

3. **PRD机制测试** (2个)
   - PRD概率递增验证
   - PRD成功后重置验证

4. **保底机制测试** (2个)
   - 硬保底触发验证
   - 软保底概率递增验证

5. **边界条件测试** (2个)
   - 空数组处理
   - 极端概率值处理

6. **性能测试** (1个)
   - 大量操作性能测试

7. **集成测试** (1个)
   - 完整抽卡流程测试

## 使用方法

### 方法1: 在UEFN中运行

1. 将测试文件添加到你的UEFN项目
2. 创建一个测试设备（creative_device）
3. 在 `OnBegin` 中调用测试：

```verse
using { /YourProject/Probability/Tests/ProbabilityTests }

test_device := class(creative_device):
    OnBegin<override>()<suspends>:void =
        # 运行所有测试
        ProbabilityTests.RunAllTests()
```

### 方法2: 单独运行测试

```verse
# 运行单个测试
TestResult := ProbabilityTests.TestRandomIntRange()
if (TestResult):
    Print("测试通过")
```

### 方法3: 使用测试运行器

```verse
Runner := ProbabilityTests.test_runner{}

# 添加自定义测试
Runner.RunTest("我的测试", MyTestFunction)

# 查看结果
Runner.PrintSummary()
```

## 测试结果解读

### 成功输出示例

```
==========================================
开始运行概率系统测试
==========================================
[✓] 随机整数范围测试
[✓] 随机浮点数范围测试
期望概率: 0.5, 实际概率: 0.498, 偏差: 0.002
[✓] 概率分布测试
选项0: 期望 0.5, 实际 0.501, 偏差 0.001
选项1: 期望 0.3, 实际 0.299, 偏差 0.001
选项2: 期望 0.2, 实际 0.200, 偏差 0.000
[✓] 加权选择分布测试
...
==========================================
测试汇总
==========================================
总测试数: 12
通过: 12
失败: 0
成功率: 100.0%
```

### 失败输出示例

```
[✗] 概率分布测试
断言失败: 概率分布应接近目标值 - 期望 0.5, 实际 0.65, 偏差 0.15
```

## 问题定位指南

### 问题类型1: 概率分布异常

**症状**: 概率分布测试失败，偏差超过容忍范围

**可能原因**:
- 样本量不足
- 随机数生成器问题
- 概率计算错误

**定位步骤**:
1. 检查样本量（默认10000）
2. 增加样本量重新测试
3. 查看实际概率和期望概率的偏差
4. 检查相关模块的概率计算逻辑

### 问题类型2: 加权选择不均匀

**症状**: 加权选择测试失败

**可能原因**:
- 权重计算错误
- 累积权重逻辑问题
- 浮点数精度问题

**定位步骤**:
1. 检查权重总和是否正确
2. 验证累积权重计算
3. 检查随机数范围是否匹配权重范围
4. 查看 `WeightedSelector.verse` 的实现

### 问题类型3: PRD机制异常

**症状**: PRD测试失败

**可能原因**:
- 概率增量计算错误
- 重置逻辑问题
- 状态管理错误

**定位步骤**:
1. 验证增量公式: `C = P / (1 + P)`
2. 检查失败时是否正确增加概率
3. 检查成功时是否正确重置
4. 查看 `PseudoRandomDistribution.verse` 的实现

### 问题类型4: 保底机制问题

**症状**: 保底测试失败

**可能原因**:
- 计数器逻辑错误
- 阈值判断问题
- 软保底增量计算错误

**定位步骤**:
1. 验证计数器是否正确递增
2. 检查阈值判断条件
3. 验证软保底区间的概率计算
4. 查看 `PitySystem.verse` 的实现

### 问题类型5: 性能问题

**症状**: 性能测试超时或崩溃

**可能原因**:
- 无限循环
- 内存泄漏
- 历史记录未限制

**定位步骤**:
1. 检查是否有无限循环
2. 验证历史记录大小限制
3. 检查内存分配
4. 使用性能分析工具

## 测试数据说明

### 默认参数

- **样本量**: 10000（概率分布测试）
- **容忍度**: 5%（概率偏差）
- **PRD目标概率**: 0.25
- **保底阈值**: 10（硬保底测试）
- **保底阈值**: 90（抽卡测试）
- **性能测试迭代**: 100000

### 调整参数

如需调整测试参数，修改测试函数中的常量：

```verse
# 示例：增加样本量提高精度
TestProbabilityDistribution<public>()<transacts>:logic =
    TargetProbability:float = 0.5
    SampleSize:int = 50000  # 从10000增加到50000
    Tolerance:float = 0.02   # 从0.05减少到0.02
    ...
```

## 断言工具

测试套件提供了多个断言函数：

| 函数 | 用途 | 示例 |
|------|------|------|
| `AssertTrue` | 验证条件为真 | `AssertTrue(Value > 0, "值应大于0")` |
| `AssertEqual` | 验证整数相等 | `AssertEqual(Actual, Expected, "值应相等")` |
| `AssertFloatEqual` | 验证浮点数相等（带容忍度） | `AssertFloatEqual(Actual, Expected, 0.01, "值应接近")` |
| `AssertInRange` | 验证值在范围内 | `AssertInRange(Value, 0.0, 1.0, "值应在[0,1]")` |

## 扩展测试

### 添加新测试

1. 创建测试函数：

```verse
TestMyFeature<public>()<transacts>:logic =
    # 测试逻辑
    Result := MyFunction()
    
    # 验证结果
    AssertTrue(Result, "我的功能应正常工作")
```

2. 在 `RunAllTests` 中注册：

```verse
Runner.RunTest("我的功能测试", TestMyFeature)
```

### 创建测试套件

```verse
MyTestSuite<public> := module:
    RunMyTests<public>()<transacts>:void =
        Runner := ProbabilityTests.test_runner{}
        
        Runner.RunTest("测试A", TestA)
        Runner.RunTest("测试B", TestB)
        
        Runner.PrintSummary()
```

## 持续集成

### 自动化测试脚本

创建测试脚本用于CI/CD:

```bash
#!/bin/bash
# run-tests.sh

# 编译测试
python3 scripts/verse-lsp/check-verse.py \
    Core/skills/programming/verseDev/shared/code_library/Probability/Tests/

# 检查编译结果
if [ $? -ne 0 ]; then
    echo "测试编译失败"
    exit 1
fi

echo "测试编译通过"
```

### GitHub Actions 集成

```yaml
name: Probability Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Verse LSP
        run: ./scripts/verse-lsp/setup-verse-env.sh
      - name: Run Tests
        run: ./run-tests.sh
```

## 最佳实践

1. **每次修改后运行测试** - 确保改动没有破坏现有功能
2. **添加新功能时添加测试** - 为新功能创建对应测试
3. **保持测试独立** - 每个测试应该独立运行
4. **使用描述性测试名称** - 测试名称应清楚说明测试内容
5. **记录失败原因** - 测试失败时应提供详细错误信息

## 已知限制

1. **Verse LSP限制** - 测试只能验证编译，不能在CI中执行
2. **随机性** - 概率测试有小概率失败（使用大样本量减少）
3. **性能测试** - 性能数据依赖于硬件和UEFN版本

## 版本历史

| 日期 | 版本 | 变更 |
|------|------|------|
| 2026-01-05 | 1.0 | 初始版本，12个测试用例 |

## 支持

如果遇到测试问题：

1. 检查本文档的"问题定位指南"
2. 查看测试输出的详细错误信息
3. 参考 `EXAMPLES.md` 中的使用示例
4. 检查相关模块的实现代码
