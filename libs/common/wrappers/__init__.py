"""
输入包装器模块 (Input Wrappers Module)

提供统一的输入处理、验证和转换接口。
"""

from .input_wrapper import InputWrapper, InputValidationError
from .string_input_wrapper import StringInputWrapper
from .numeric_input_wrapper import NumericInputWrapper

__all__ = [
    'InputWrapper',
    'InputValidationError',
    'StringInputWrapper',
    'NumericInputWrapper',
]
