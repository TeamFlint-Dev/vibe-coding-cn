# 安全数学运算库
# 功能：防溢出、防除零的安全数学运算
# 架构：Logic 层 - 纯函数，使用 <decides> 效果处理错误
# 验证：CONJ-002 (效果系统层次关系)
# 
# 官方文档说明：
# - int 是 64位有符号整数，范围 [-2^63, 2^63-1]
# - 整数运算溢出会导致 runtime error（不是环绕）
# - 因此必须提供安全版本以避免运行时崩溃
#
# 参考：
# - RESEARCH-006: 数值类型转换与精度
# - ADR-001: Epsilon 值选择
# - external/epic-docs-crawler/uefn_docs_organized/Verse-Language/int-in-verse/index.md

MathSafe<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 常量定义 - 数值边界
    # ═══════════════════════════════════════════════════════════
    
    # 整数边界（64位有符号整数）
    # 注意：Verse 中整数溢出会导致 runtime error
    MaxSafeInt:int = 9223372036854775807  # 2^63 - 1
    MinSafeInt:int = -9223372036854775808  # -2^63
    
    # 用于溢出检测的保守边界
    # 选择 MaxSafeInt / 2 确保加法不会溢出
    SafeIntThreshold:int = 4611686018427387903  # (2^63 - 1) / 2
    
    # 浮点数安全边界（避免溢出）
    MaxSafeFloat:float = 1.0e+30
    MinSafeFloat:float = -1.0e+30
    EpsilonFloat:float = 1.0e-6
    
    # ═══════════════════════════════════════════════════════════
    # 整数安全运算 - 防止溢出
    # ═══════════════════════════════════════════════════════════
    
    # 安全整数加法 - 防止溢出
    # @param A: 第一个加数
    # @param B: 第二个加数
    # @returns: A + B 的结果，如果会溢出则失败
    # 
    # 溢出检测逻辑：
    # - 如果 A > 0 且 B > 0，检查 A + B > MaxSafeInt
    # - 如果 A < 0 且 B < 0，检查 A + B < MinSafeInt
    # - 其他情况不会溢出
    SafeAddInt<public>(A:int, B:int)<transacts><decides>:int =
        if (A > 0):
            if (B > 0):
                # 两个正数相加，检查是否超过最大值
                # 等价于 A + B > MaxSafeInt，但避免计算 A + B
                if (A > MaxSafeInt - B):
                    false  # 会溢出
                A + B
            else:
                # A > 0, B <= 0，不会溢出
                A + B
        else if (A < 0):
            if (B < 0):
                # 两个负数相加，检查是否低于最小值
                # 等价于 A + B < MinSafeInt
                if (A < MinSafeInt - B):
                    false  # 会溢出
                A + B
            else:
                # A < 0, B >= 0，不会溢出
                A + B
        else:
            # A = 0，不会溢出
            A + B
    
    # 安全整数减法 - 防止溢出
    # @param A: 被减数
    # @param B: 减数
    # @returns: A - B 的结果，如果会溢出则失败
    # 
    # 溢出检测逻辑：
    # - 如果 A > 0 且 B < 0，相当于加法，检查 A - B > MaxSafeInt
    # - 如果 A < 0 且 B > 0，相当于加法，检查 A - B < MinSafeInt
    SafeSubtractInt<public>(A:int, B:int)<transacts><decides>:int =
        if (A > 0):
            if (B < 0):
                # A - (-B) = A + B，检查正溢出
                if (A > MaxSafeInt + B):  # 等价于 A - B > MaxSafeInt
                    false
                A - B
            else:
                # A > 0, B >= 0，不会溢出
                A - B
        else if (A < 0):
            if (B > 0):
                # A - B，检查负溢出
                if (A < MinSafeInt + B):  # 等价于 A - B < MinSafeInt
                    false
                A - B
            else:
                # A < 0, B <= 0，不会溢出
                A - B
        else:
            # A = 0，不会溢出
            A - B
    
    # 安全整数乘法 - 防止溢出
    # @param A: 第一个乘数
    # @param B: 第二个乘数
    # @returns: A * B 的结果，如果会溢出则失败
    # 
    # 简化策略：检查绝对值是否在安全范围内
    # 如果 |A| 和 |B| 都在 sqrt(MaxSafeInt) 内，则乘积不会溢出
    SafeMultiplyInt<public>(A:int, B:int)<transacts><decides>:int =
        # 处理零的情况
        if (A = 0):
            0
        else if (B = 0):
            0
        else:
            # 检查是否会溢出
            # 使用 MaxSafeInt / |A| >= |B| 来避免溢出检测本身溢出
            AbsA := if (A < 0) then -A else A
            AbsB := if (B < 0) then -B else B
            
            # 检查 AbsA * AbsB 是否会超过 MaxSafeInt
            # 使用 Quotient 进行整数除法
            Threshold := Quotient[MaxSafeInt, AbsB]
            if (AbsA > Threshold):
                false  # 会溢出
            
            A * B
    
    # 安全整数除法 - 防止除零
    # @param A: 被除数
    # @param B: 除数
    # @returns: A / B 的结果（向零截断），如果 B = 0 则失败
    # 
    # 注意：使用 Quotient[] 进行整数除法（向零截断）
    SafeDivideInt<public>(A:int, B:int)<transacts><decides>:int =
        if (B = 0):
            false  # 除零错误
        Quotient[A, B]
    
    # ═══════════════════════════════════════════════════════════
    # 浮点数安全运算
    # ═══════════════════════════════════════════════════════════
    
    # 安全浮点除法 - 防止除零
    # @param A: 被除数
    # @param B: 除数
    # @returns: A / B 的结果，如果 B ≈ 0 则失败
    # 
    # 注意：使用 Epsilon 容差判断除零
    SafeDivideFloat<public>(A:float, B:float)<transacts><decides>:float =
        AbsB := if (B < 0.0) then -B else B
        # 除零检查（使用 Epsilon 容差）
        if (AbsB < EpsilonFloat):
            false  # B ≈ 0，除零错误
        A / B
    
    # 安全浮点数乘法 - 防止溢出到 Infinity
    # @param A: 第一个乘数
    # @param B: 第二个乘数
    # @returns: A * B 的结果，如果会溢出则失败
    SafeMultiplyFloat<public>(A:float, B:float)<transacts><decides>:float =
        # 检查是否会溢出
        AbsA := if (A < 0.0) then -A else A
        AbsB := if (B < 0.0) then -B else B
        
        # 零的情况
        if (AbsA < EpsilonFloat):
            0.0
        else if (AbsB < EpsilonFloat):
            0.0
        else:
            # 检查 |A| * |B| 是否会超过安全范围
            if (AbsA > MaxSafeFloat / AbsB):
                false  # 会溢出
            
            A * B
    
    # 安全浮点数加法 - 防止溢出到 Infinity
    # @param A: 第一个加数
    # @param B: 第二个加数
    # @returns: A + B 的结果，如果会溢出则失败
    SafeAddFloat<public>(A:float, B:float)<transacts><decides>:float =
        if (A > 0.0):
            if (B > 0.0):
                # 两个正数，检查溢出
                if (A > MaxSafeFloat - B):
                    false
                A + B
            else:
                A + B
        else if (A < 0.0):
            if (B < 0.0):
                # 两个负数，检查溢出
                if (A < MinSafeFloat - B):
                    false
                A + B
            else:
                A + B
        else:
            A + B
    
    # 安全浮点数减法 - 防止溢出到 Infinity
    # @param A: 被减数
    # @param B: 减数
    # @returns: A - B 的结果，如果会溢出则失败
    SafeSubtractFloat<public>(A:float, B:float)<transacts><decides>:float =
        if (A > 0.0):
            if (B < 0.0):
                # A - (-B) = A + B
                if (A > MaxSafeFloat + B):
                    false
                A - B
            else:
                A - B
        else if (A < 0.0):
            if (B > 0.0):
                # A - B，检查负溢出
                if (A < MinSafeFloat + B):
                    false
                A - B
            else:
                A - B
        else:
            A - B
    
    # ═══════════════════════════════════════════════════════════
    # 整数幂运算 - 防止溢出
    # ═══════════════════════════════════════════════════════════
    
    # 安全整数幂运算 - 防止溢出
    # @param Base: 底数
    # @param Exponent: 指数（必须非负）
    # @returns: Base ^ Exponent 的结果，如果会溢出或指数为负则失败
    # 
    # 限制：
    # - Exponent 必须 >= 0（负数指数会产生分数，不支持）
    # - 使用迭代乘法，每次乘法都检查溢出
    # - 最大迭代次数限制为 100 次，防止过大的指数
    SafePowerInt<public>(Base:int, Exponent:int)<transacts><decides>:int =
        # 负数指数不支持
        if (Exponent < 0):
            false
        
        # 特殊情况
        if (Exponent = 0):
            1  # 任何数的 0 次方都是 1
        else if (Base = 0):
            0  # 0 的任何正数次方都是 0
        else if (Base = 1):
            1  # 1 的任何次方都是 1
        else if (Base = -1):
            # -1 的偶数次方是 1，奇数次方是 -1
            Remainder := Mod[Exponent, 2]
            if (Remainder = 0) then 1 else -1
        else if (Exponent = 1):
            Base
        else:
            # 迭代计算 Base ^ Exponent
            # 使用快速幂算法会更高效，但这里使用简单迭代
            # 为了安全，限制最大迭代次数
            if (Exponent > 100):
                false  # 指数过大，避免过长计算
            
            # 逐步乘法，每次检查溢出
            var Result:int = 1
            for (I := 0..Exponent - 1):
                # 使用 SafeMultiplyInt 检查溢出
                NewResult := SafeMultiplyInt[Result, Base]
                set Result = NewResult
            Result
    
    # ═══════════════════════════════════════════════════════════
    # 类型转换
    # ═══════════════════════════════════════════════════════════
    
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
