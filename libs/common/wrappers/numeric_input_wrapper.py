"""
数值输入包装器 (Numeric Input Wrapper)

专门用于处理数值类型输入的包装器。
"""

from typing import Any, Optional, Union
from .input_wrapper import InputWrapper, InputValidationError


class NumericInputWrapper(InputWrapper):
    """
    数值输入包装器
    
    提供数值特定的验证和转换功能，如范围限制、类型转换等。
    
    Attributes:
        min_value: 最小值限制
        max_value: 最大值限制
        allow_float: 是否允许浮点数
        allow_negative: 是否允许负数
    """
    
    def __init__(
        self,
        min_value: Optional[Union[int, float]] = None,
        max_value: Optional[Union[int, float]] = None,
        allow_float: bool = True,
        allow_negative: bool = True,
        **kwargs
    ):
        """
        初始化数值输入包装器
        
        Args:
            min_value: 最小值限制
            max_value: 最大值限制
            allow_float: 是否允许浮点数
            allow_negative: 是否允许负数
            **kwargs: 传递给基类的其他参数
        """
        super().__init__(**kwargs)
        self.min_value = min_value
        self.max_value = max_value
        self.allow_float = allow_float
        self.allow_negative = allow_negative
    
    def _custom_validate(self, value: Any) -> bool:
        """
        数值特定的验证逻辑
        
        Args:
            value: 待验证的输入值
            
        Returns:
            验证是否通过
            
        Raises:
            InputValidationError: 严格模式下验证失败时抛出
        """
        # 尝试转换为数值
        try:
            if isinstance(value, str):
                numeric_value = float(value) if '.' in value else int(value)
            elif isinstance(value, (int, float)):
                numeric_value = value
            else:
                if self.strict_mode:
                    raise InputValidationError(
                        f"类型错误: 无法将 {type(value).__name__} 转换为数值"
                    )
                return False
        except (ValueError, TypeError) as e:
            if self.strict_mode:
                raise InputValidationError(f"转换错误: {str(e)}") from e
            return False
        
        # 检查是否允许浮点数
        if not self.allow_float and isinstance(numeric_value, float) and not numeric_value.is_integer():
            if self.strict_mode:
                raise InputValidationError("不允许浮点数")
            return False
        
        # 检查是否允许负数
        if not self.allow_negative and numeric_value < 0:
            if self.strict_mode:
                raise InputValidationError("不允许负数")
            return False
        
        # 检查最小值
        if self.min_value is not None and numeric_value < self.min_value:
            if self.strict_mode:
                raise InputValidationError(
                    f"值过小: 最小值为 {self.min_value}，实际值为 {numeric_value}"
                )
            return False
        
        # 检查最大值
        if self.max_value is not None and numeric_value > self.max_value:
            if self.strict_mode:
                raise InputValidationError(
                    f"值过大: 最大值为 {self.max_value}，实际值为 {numeric_value}"
                )
            return False
        
        return True
    
    def _custom_transform(self, value: Any) -> Union[int, float]:
        """
        数值特定的转换逻辑
        
        Args:
            value: 待转换的输入值
            
        Returns:
            转换后的数值
        """
        # 转换为数值
        if isinstance(value, str):
            result = float(value) if '.' in value else int(value)
        elif isinstance(value, (int, float)):
            result = value
        else:
            result = float(value)
        
        # 如果不允许浮点数，转换为整数
        if not self.allow_float and isinstance(result, float):
            result = int(result)
        
        return result
    
    def round_to(self, decimals: int) -> 'NumericInputWrapper':
        """
        添加四舍五入转换
        
        Args:
            decimals: 保留的小数位数
            
        Returns:
            self（支持链式调用）
        """
        self.add_transformer(lambda x: round(x, decimals))
        return self
    
    def abs(self) -> 'NumericInputWrapper':
        """
        添加绝对值转换
        
        Returns:
            self（支持链式调用）
        """
        self.add_transformer(lambda x: abs(x))
        return self
