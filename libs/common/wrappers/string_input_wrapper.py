"""
字符串输入包装器 (String Input Wrapper)

专门用于处理字符串类型输入的包装器。
"""

from typing import Any, Optional
from .input_wrapper import InputWrapper, InputValidationError


class StringInputWrapper(InputWrapper):
    """
    字符串输入包装器
    
    提供字符串特定的验证和转换功能，如长度限制、格式检查、大小写转换等。
    
    Attributes:
        min_length: 最小长度限制
        max_length: 最大长度限制
        strip_whitespace: 是否去除首尾空白
        allow_empty: 是否允许空字符串
    """
    
    def __init__(
        self,
        min_length: Optional[int] = None,
        max_length: Optional[int] = None,
        strip_whitespace: bool = True,
        allow_empty: bool = True,
        **kwargs
    ):
        """
        初始化字符串输入包装器
        
        Args:
            min_length: 最小长度限制
            max_length: 最大长度限制
            strip_whitespace: 是否去除首尾空白
            allow_empty: 是否允许空字符串
            **kwargs: 传递给基类的其他参数
        """
        super().__init__(**kwargs)
        self.min_length = min_length
        self.max_length = max_length
        self.strip_whitespace = strip_whitespace
        self.allow_empty = allow_empty
    
    def _custom_validate(self, value: Any) -> bool:
        """
        字符串特定的验证逻辑
        
        Args:
            value: 待验证的输入值
            
        Returns:
            验证是否通过
            
        Raises:
            InputValidationError: 严格模式下验证失败时抛出
        """
        # 检查是否为字符串类型
        if not isinstance(value, str):
            if self.strict_mode:
                raise InputValidationError(
                    f"类型错误: 期望 str 类型，实际为 {type(value).__name__}"
                )
            return False
        
        # 预处理（如果需要去除空白）
        processed_value = value.strip() if self.strip_whitespace else value
        
        # 检查是否允许空字符串
        if not self.allow_empty and len(processed_value) == 0:
            if self.strict_mode:
                raise InputValidationError("不允许空字符串")
            return False
        
        # 检查最小长度
        if self.min_length is not None and len(processed_value) < self.min_length:
            if self.strict_mode:
                raise InputValidationError(
                    f"长度不足: 最小长度为 {self.min_length}，实际长度为 {len(processed_value)}"
                )
            return False
        
        # 检查最大长度
        if self.max_length is not None and len(processed_value) > self.max_length:
            if self.strict_mode:
                raise InputValidationError(
                    f"长度超限: 最大长度为 {self.max_length}，实际长度为 {len(processed_value)}"
                )
            return False
        
        return True
    
    def _custom_transform(self, value: Any) -> str:
        """
        字符串特定的转换逻辑
        
        Args:
            value: 待转换的输入值
            
        Returns:
            转换后的字符串
        """
        result = str(value)
        
        # 去除首尾空白
        if self.strip_whitespace:
            result = result.strip()
        
        return result
    
    def to_upper(self) -> 'StringInputWrapper':
        """
        添加大写转换
        
        Returns:
            self（支持链式调用）
        """
        self.add_transformer(lambda x: x.upper())
        return self
    
    def to_lower(self) -> 'StringInputWrapper':
        """
        添加小写转换
        
        Returns:
            self（支持链式调用）
        """
        self.add_transformer(lambda x: x.lower())
        return self
    
    def to_title(self) -> 'StringInputWrapper':
        """
        添加标题格式转换
        
        Returns:
            self（支持链式调用）
        """
        self.add_transformer(lambda x: x.title())
        return self
