# 安全数学运算库
# 功能：防溢出、防除零的安全数学运算
# 架构：Logic 层 - 纯函数，使用 <decides> 效果处理错误
# 验证：CONJ-002 (效果系统层次关系)

MathSafe<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 常量定义 - 数值边界
    # ═══════════════════════════════════════════════════════════
    
    # 浮点数安全边界（避免溢出）
    MaxSafeFloat:float = 1.0e+30
    MinSafeFloat:float = -1.0e+30
    EpsilonFloat:float = 1.0e-6
    
    # ═══════════════════════════════════════════════════════════
    # 浮点数安全运算 (简化版本，仅处理关键情况)
    # ═══════════════════════════════════════════════════════════
    
    # 安全浮点除法 - 防止除零
    # @param A: 被除数
    # @param B: 除数
    # @returns: A / B 的结果，如果 B ≈ 0 则失败
    SafeDivideFloat<public>(A:float, B:float)<transacts><decides>:float =
        AbsB := if (B < 0.0) then -B else B
        # 除零检查（使用 Epsilon 容差）
        if (AbsB < EpsilonFloat):
            false  # B ≈ 0，除零错误
        A / B
    
    # 安全整数转浮点数
    # @param Value: 整数值
    # @returns: 浮点数值
    # 
    # 注意：使用标准方法 Value * 1.0
    # 参考：RESEARCH-006 (数值类型转换)
    SafeIntToFloat<public>(Value:int)<computes>:float =
        Value * 1.0
    
    # 安全浮点数转整数（向下取整）
    # @param Value: 浮点数值
    # @returns: 整数值，如果为无效值则失败
    # 
    # 注意：这个版本不做边界检查，依赖 Floor 的内置行为
    SafeFloatToInt<public>(Value:float)<transacts><decides>:int =
        Floor[Value]
    
    # ═══════════════════════════════════════════════════════════
    # 辅助工具函数
    # ═══════════════════════════════════════════════════════════
    
    # 浮点数绝对值
    # @param Value: 浮点数值
    # @returns: |Value|
    SafeAbsFloat<public>(Value:float)<computes>:float =
        if (Value < 0.0) then -Value else Value
    
    # 整数最大值
    # @param A: 第一个整数
    # @param B: 第二个整数
    # @returns: max(A, B)
    SafeMaxInt<public>(A:int, B:int)<computes>:int =
        if (A > B) then A else B
    
    # 整数最小值
    # @param A: 第一个整数
    # @param B: 第二个整数
    # @returns: min(A, B)
    SafeMinInt<public>(A:int, B:int)<computes>:int =
        if (A < B) then A else B
    
    # 整数值限制在范围内
    # @param Value: 要限制的值
    # @param MinValue: 最小值
    # @param MaxValue: 最大值
    # @returns: Clamp(Value, MinValue, MaxValue)
    SafeClampInt<public>(Value:int, MinValue:int, MaxValue:int)<computes>:int =
        if (Value < MinValue):
            MinValue
        else if (Value > MaxValue):
            MaxValue
        else:
            Value
    
    # 浮点数值限制在范围内
    # @param Value: 要限制的值
    # @param MinValue: 最小值
    # @param MaxValue: 最大值
    # @returns: Clamp(Value, MinValue, MaxValue)
    SafeClampFloat<public>(Value:float, MinValue:float, MaxValue:float)<computes>:float =
        if (Value < MinValue):
            MinValue
        else if (Value > MaxValue):
            MaxValue
        else:
            Value
