#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
输入包装器示例脚本 (Input Wrappers Example)

演示如何使用 libs/common/wrappers/ 模块中的各种输入包装器。
"""

import sys
import os

# 添加项目根目录到路径
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..', '..'))

from libs.common.wrappers import (
    InputWrapper,
    InputValidationError,
    StringInputWrapper,
    NumericInputWrapper
)


def demo_string_wrapper():
    """演示字符串包装器"""
    print("=" * 60)
    print("字符串包装器示例 (StringInputWrapper Demo)")
    print("=" * 60)
    
    # 示例1: 基础字符串验证
    print("\n1. 基础字符串验证（长度限制）")
    wrapper = StringInputWrapper(
        min_length=3,
        max_length=20,
        strip_whitespace=True,
        allow_empty=False
    )
    
    test_inputs = ["  hello  ", "hi", "this is a very long string that exceeds limit"]
    for input_str in test_inputs:
        try:
            result = wrapper.wrap(input_str)
            print(f"  输入: '{input_str}' -> 输出: '{result}' ✓")
        except InputValidationError as e:
            print(f"  输入: '{input_str}' -> 错误: {e} ✗")
    
    # 示例2: 链式调用 - 转换为大写
    print("\n2. 链式调用 - 转换为大写")
    wrapper = StringInputWrapper(min_length=2, max_length=10).to_upper()
    
    test_inputs = ["hello", "world", "python"]
    for input_str in test_inputs:
        result = wrapper.wrap(input_str)
        print(f"  输入: '{input_str}' -> 输出: '{result}'")
    
    # 示例3: 自定义验证 - 必须包含 @
    print("\n3. 自定义验证 - 邮箱格式（必须包含@）")
    wrapper = StringInputWrapper(min_length=5, strict_mode=False, default_value="invalid@email.com")
    wrapper.add_validator(lambda x: '@' in x)
    
    test_inputs = ["user@example.com", "invalid-email", "test@test.com"]
    for input_str in test_inputs:
        result = wrapper.wrap(input_str)
        print(f"  输入: '{input_str}' -> 输出: '{result}'")


def demo_numeric_wrapper():
    """演示数值包装器"""
    print("\n" + "=" * 60)
    print("数值包装器示例 (NumericInputWrapper Demo)")
    print("=" * 60)
    
    # 示例1: 基础数值验证（范围限制）
    print("\n1. 基础数值验证（0-100范围）")
    wrapper = NumericInputWrapper(
        min_value=0,
        max_value=100,
        allow_float=True,
        allow_negative=False
    )
    
    test_inputs = ["42", "150", "-5", "75.5"]
    for input_str in test_inputs:
        try:
            result = wrapper.wrap(input_str)
            print(f"  输入: '{input_str}' -> 输出: {result} ✓")
        except InputValidationError as e:
            print(f"  输入: '{input_str}' -> 错误: {e} ✗")
    
    # 示例2: 整数验证（不允许浮点数）
    print("\n2. 整数验证（不允许浮点数）")
    wrapper = NumericInputWrapper(
        min_value=0,
        max_value=150,
        allow_float=False,
        allow_negative=False
    )
    
    test_inputs = ["42", "100", "42.5"]
    for input_str in test_inputs:
        try:
            result = wrapper.wrap(input_str)
            print(f"  输入: '{input_str}' -> 输出: {result} (类型: {type(result).__name__}) ✓")
        except InputValidationError as e:
            print(f"  输入: '{input_str}' -> 错误: {e} ✗")
    
    # 示例3: 链式调用 - 四舍五入
    print("\n3. 链式调用 - 四舍五入到2位小数")
    wrapper = NumericInputWrapper(min_value=0).round_to(2)
    
    test_inputs = ["3.14159", "2.71828", "1.41421356"]
    for input_str in test_inputs:
        result = wrapper.wrap(input_str)
        print(f"  输入: '{input_str}' -> 输出: {result}")
    
    # 示例4: 绝对值转换
    print("\n4. 绝对值转换")
    wrapper = NumericInputWrapper().abs()
    
    test_inputs = ["-42", "42", "-3.14"]
    for input_str in test_inputs:
        result = wrapper.wrap(input_str)
        print(f"  输入: '{input_str}' -> 输出: {result}")


def demo_strict_vs_lenient():
    """演示严格模式 vs 宽松模式"""
    print("\n" + "=" * 60)
    print("严格模式 vs 宽松模式 (Strict vs Lenient Mode)")
    print("=" * 60)
    
    # 严格模式
    print("\n1. 严格模式（验证失败抛出异常）")
    strict_wrapper = StringInputWrapper(min_length=5, strict_mode=True)
    
    try:
        result = strict_wrapper.wrap("hi")
        print(f"  输入: 'hi' -> 输出: '{result}'")
    except InputValidationError as e:
        print(f"  输入: 'hi' -> 异常: {e}")
    
    # 宽松模式
    print("\n2. 宽松模式（验证失败返回默认值）")
    lenient_wrapper = StringInputWrapper(
        min_length=5,
        strict_mode=False,
        default_value="默认值"
    )
    
    result = lenient_wrapper.wrap("hi")
    print(f"  输入: 'hi' -> 输出: '{result}'")
    
    result = lenient_wrapper.wrap("hello")
    print(f"  输入: 'hello' -> 输出: '{result}'")


def demo_real_world_scenarios():
    """演示实际应用场景"""
    print("\n" + "=" * 60)
    print("实际应用场景 (Real-World Scenarios)")
    print("=" * 60)
    
    # 用户名验证
    print("\n1. 用户名验证（3-20字符，仅字母数字）")
    username_wrapper = StringInputWrapper(
        min_length=3,
        max_length=20,
        strip_whitespace=True,
        allow_empty=False,
        strict_mode=False,
        default_value="anonymous"
    )
    username_wrapper.add_validator(lambda x: x.isalnum())
    
    test_inputs = ["john_doe", "alice123", "bob", "a"]
    for input_str in test_inputs:
        result = username_wrapper.wrap(input_str)
        print(f"  用户名: '{input_str}' -> 结果: '{result}'")
    
    # 年龄验证
    print("\n2. 年龄验证（0-150岁，整数）")
    age_wrapper = NumericInputWrapper(
        min_value=0,
        max_value=150,
        allow_float=False,
        allow_negative=False,
        strict_mode=False,
        default_value=18
    )
    
    test_inputs = ["25", "200", "-5", "30.5"]
    for input_str in test_inputs:
        result = age_wrapper.wrap(input_str)
        print(f"  年龄: '{input_str}' -> 结果: {result}")
    
    # 价格处理
    print("\n3. 价格处理（非负数，保留2位小数）")
    price_wrapper = NumericInputWrapper(
        min_value=0,
        allow_negative=False
    ).round_to(2)
    
    test_inputs = ["19.99", "100", "49.999", "0.1"]
    for input_str in test_inputs:
        result = price_wrapper.wrap(input_str)
        print(f"  价格: '{input_str}' -> 结果: {result}")


def main():
    """主函数"""
    print("\n" + "=" * 60)
    print("输入包装器模块演示")
    print("libs/common/wrappers/ - Input Wrappers Module Demo")
    print("=" * 60)
    
    # 运行各种演示
    demo_string_wrapper()
    demo_numeric_wrapper()
    demo_strict_vs_lenient()
    demo_real_world_scenarios()
    
    print("\n" + "=" * 60)
    print("演示完成！")
    print("=" * 60)
    print("\n更多信息请参考: libs/common/wrappers/README.md")


if __name__ == "__main__":
    main()
