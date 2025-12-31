"""
输入包装器基类 (Base Input Wrapper)

提供输入验证、转换和错误处理的统一接口。
"""

from abc import ABC, abstractmethod
from typing import Any, Optional, Callable, List


class InputValidationError(Exception):
    """输入验证错误异常"""
    pass


class InputWrapper(ABC):
    """
    输入包装器基类
    
    用于包装和处理各种类型的输入，提供统一的验证、转换和错误处理接口。
    
    Attributes:
        validators: 验证函数列表
        transformers: 转换函数列表
        default_value: 默认值（验证失败时使用）
        strict_mode: 严格模式（True时验证失败抛出异常，False时返回默认值）
    """
    
    def __init__(
        self,
        validators: Optional[List[Callable[[Any], bool]]] = None,
        transformers: Optional[List[Callable[[Any], Any]]] = None,
        default_value: Any = None,
        strict_mode: bool = True
    ):
        """
        初始化输入包装器
        
        Args:
            validators: 验证函数列表，每个函数接收输入值并返回布尔值
            transformers: 转换函数列表，每个函数接收输入值并返回转换后的值
            default_value: 默认值，验证失败时使用
            strict_mode: 严格模式，True时验证失败抛出异常，False时返回默认值
        """
        self.validators = validators or []
        self.transformers = transformers or []
        self.default_value = default_value
        self.strict_mode = strict_mode
    
    def validate(self, value: Any) -> bool:
        """
        验证输入值
        
        Args:
            value: 待验证的输入值
            
        Returns:
            验证是否通过
            
        Raises:
            InputValidationError: 严格模式下验证失败时抛出
        """
        for validator in self.validators:
            if not validator(value):
                if self.strict_mode:
                    raise InputValidationError(
                        f"验证失败: 值 '{value}' 未通过验证函数 {validator.__name__}"
                    )
                return False
        
        # 调用子类的自定义验证
        return self._custom_validate(value)
    
    @abstractmethod
    def _custom_validate(self, value: Any) -> bool:
        """
        自定义验证逻辑（子类实现）
        
        Args:
            value: 待验证的输入值
            
        Returns:
            验证是否通过
        """
        pass
    
    def transform(self, value: Any) -> Any:
        """
        转换输入值
        
        Args:
            value: 待转换的输入值
            
        Returns:
            转换后的值
        """
        # 先应用自定义转换（类型转换）
        result = self._custom_transform(value)
        
        # 再应用所有转换函数
        for transformer in self.transformers:
            result = transformer(result)
        
        return result
    
    @abstractmethod
    def _custom_transform(self, value: Any) -> Any:
        """
        自定义转换逻辑（子类实现）
        
        Args:
            value: 待转换的输入值
            
        Returns:
            转换后的值
        """
        pass
    
    def wrap(self, value: Any) -> Any:
        """
        包装输入值（验证 + 转换）
        
        Args:
            value: 待处理的输入值
            
        Returns:
            处理后的值，验证失败时返回默认值（非严格模式）
            
        Raises:
            InputValidationError: 严格模式下验证失败时抛出
        """
        try:
            # 验证
            if not self.validate(value):
                return self.default_value
            
            # 转换
            return self.transform(value)
            
        except InputValidationError:
            if self.strict_mode:
                raise
            return self.default_value
        except Exception as e:
            if self.strict_mode:
                raise InputValidationError(f"处理输入时发生错误: {str(e)}") from e
            return self.default_value
    
    def add_validator(self, validator: Callable[[Any], bool]) -> 'InputWrapper':
        """
        添加验证函数
        
        Args:
            validator: 验证函数
            
        Returns:
            self（支持链式调用）
        """
        self.validators.append(validator)
        return self
    
    def add_transformer(self, transformer: Callable[[Any], Any]) -> 'InputWrapper':
        """
        添加转换函数
        
        Args:
            transformer: 转换函数
            
        Returns:
            self（支持链式调用）
        """
        self.transformers.append(transformer)
        return self
