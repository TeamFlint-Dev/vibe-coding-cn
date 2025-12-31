# 输入包装器 (Input Wrappers)

`libs/common/wrappers/` 提供统一的输入处理、验证和转换接口。

## 概述

输入包装器模块用于标准化各种类型的输入处理流程，提供：

- **输入验证**：类型检查、范围限制、格式验证
- **输入转换**：格式转换、数据清洗、标准化
- **错误处理**：统一的异常处理和默认值机制

## 目录结构

```text
libs/common/wrappers/
├── README.md                      # 本文档
├── __init__.py                    # 模块入口
├── input_wrapper.py               # 基础包装器类
├── string_input_wrapper.py        # 字符串包装器
└── numeric_input_wrapper.py       # 数值包装器
```

## 核心类

### InputWrapper (基类)

抽象基类，定义输入包装器的通用接口。

**主要方法**：

- `validate(value)`: 验证输入值
- `transform(value)`: 转换输入值
- `wrap(value)`: 完整处理流程（验证 + 转换）
- `add_validator(validator)`: 添加自定义验证函数
- `add_transformer(transformer)`: 添加自定义转换函数

**参数**：

- `validators`: 验证函数列表
- `transformers`: 转换函数列表
- `default_value`: 默认值（验证失败时使用）
- `strict_mode`: 严格模式（True 时验证失败抛出异常）

### StringInputWrapper

专门用于处理字符串类型输入。

**特性**：

- 长度限制（`min_length`, `max_length`）
- 空白处理（`strip_whitespace`）
- 空字符串控制（`allow_empty`）
- 大小写转换（`to_upper()`, `to_lower()`, `to_title()`）

### NumericInputWrapper

专门用于处理数值类型输入。

**特性**：

- 范围限制（`min_value`, `max_value`）
- 类型控制（`allow_float`, `allow_negative`）
- 四舍五入（`round_to(decimals)`）
- 绝对值转换（`abs()`）

## 使用示例

### 基础用法

```python
from libs.common.wrappers import StringInputWrapper, NumericInputWrapper

# 字符串包装器
string_wrapper = StringInputWrapper(
    min_length=3,
    max_length=20,
    strip_whitespace=True,
    allow_empty=False
)

result = string_wrapper.wrap("  hello  ")  # 返回 "hello"

# 数值包装器
numeric_wrapper = NumericInputWrapper(
    min_value=0,
    max_value=100,
    allow_float=True,
    allow_negative=False
)

result = numeric_wrapper.wrap("42.5")  # 返回 42.5
```

### 链式调用

```python
# 字符串转大写并验证长度
wrapper = StringInputWrapper(min_length=2, max_length=10).to_upper()
result = wrapper.wrap("hello")  # 返回 "HELLO"

# 数值四舍五入到两位小数
wrapper = NumericInputWrapper(min_value=0).round_to(2)
result = wrapper.wrap("3.14159")  # 返回 3.14
```

### 自定义验证和转换

```python
# 添加自定义验证函数
wrapper = StringInputWrapper()
wrapper.add_validator(lambda x: '@' in x)  # 必须包含 @
wrapper.add_transformer(lambda x: x.replace(' ', '_'))  # 空格替换为下划线

result = wrapper.wrap("user@example.com")  # 验证并转换
```

### 严格模式与非严格模式

```python
# 严格模式（默认）：验证失败抛出异常
strict_wrapper = StringInputWrapper(min_length=5, strict_mode=True)
try:
    result = strict_wrapper.wrap("hi")  # 抛出 InputValidationError
except InputValidationError as e:
    print(f"验证失败: {e}")

# 非严格模式：验证失败返回默认值
lenient_wrapper = StringInputWrapper(
    min_length=5,
    strict_mode=False,
    default_value="default"
)
result = lenient_wrapper.wrap("hi")  # 返回 "default"
```

### 实际应用场景

```python
# 用户名验证
username_wrapper = StringInputWrapper(
    min_length=3,
    max_length=20,
    strip_whitespace=True,
    allow_empty=False
).add_validator(lambda x: x.isalnum())  # 只允许字母和数字

# 年龄验证
age_wrapper = NumericInputWrapper(
    min_value=0,
    max_value=150,
    allow_float=False,
    allow_negative=False
)

# 价格处理
price_wrapper = NumericInputWrapper(
    min_value=0,
    allow_negative=False
).round_to(2)

# 处理用户输入
username = username_wrapper.wrap(input("请输入用户名: "))
age = age_wrapper.wrap(input("请输入年龄: "))
price = price_wrapper.wrap(input("请输入价格: "))
```

## 扩展开发

### 创建自定义包装器

继承 `InputWrapper` 并实现以下抽象方法：

```python
from libs.common.wrappers import InputWrapper

class CustomInputWrapper(InputWrapper):
    def _custom_validate(self, value):
        # 实现自定义验证逻辑
        # 返回 True 或 False
        # 在 strict_mode 下可以抛出 InputValidationError
        return True
    
    def _custom_transform(self, value):
        # 实现自定义转换逻辑
        # 返回转换后的值
        return value
```

### 组合使用

```python
# 可以组合多个包装器
def process_input(value):
    # 第一步：字符串预处理
    step1 = StringInputWrapper(strip_whitespace=True)
    cleaned = step1.wrap(value)
    
    # 第二步：尝试转换为数值
    step2 = NumericInputWrapper(strict_mode=False, default_value=0)
    result = step2.wrap(cleaned)
    
    return result
```

## 设计原则

1. **单一职责**：每个包装器专注于特定类型的输入
2. **可组合性**：支持链式调用和函数组合
3. **灵活性**：提供严格/宽松两种模式
4. **可扩展性**：易于创建自定义包装器
5. **零依赖**：仅依赖 Python 标准库

## 约定与注意事项

1. **类型安全**：优先进行类型检查，避免隐式转换错误
2. **明确默认值**：使用 `None` 表示无限制，而非 `0` 或空字符串
3. **异常处理**：严格模式用于关键输入，非严格模式用于容错场景
4. **性能考虑**：验证和转换函数应保持轻量级
5. **文档完整**：每个方法都应有清晰的 docstring

## 测试

运行单元测试（如果已实现）：

```bash
python -m pytest libs/common/wrappers/tests/
```

## 贡献指南

添加新的包装器类型时：

1. 继承 `InputWrapper` 基类
2. 实现 `_custom_validate` 和 `_custom_transform` 方法
3. 添加类型特定的便捷方法（如 `to_upper()`, `round_to()`）
4. 更新 `__init__.py` 导出新类
5. 在本 README 添加使用示例
6. 编写单元测试

## 相关资源

- [libs/common/README.md](../README.md) - 通用模块概述
- [libs/README.md](../../README.md) - 库总体说明
- Python ABC 文档：<https://docs.python.org/3/library/abc.html>
