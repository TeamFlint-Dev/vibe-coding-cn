# 范围验证模块
# 功能：提供数值范围验证函数，使用 <decides> 效果进行fail-fast验证
# 架构：Logic 层 - 无状态纯函数，使用 <decides> 效果

using { /Verse.org/Simulation }

RangeValidation<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 整数范围验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证整数是否在范围内（闭区间 [MinVal, MaxVal]）
    # @param Value: 要验证的值
    # @param MinVal: 最小值（包含）
    # @param MaxVal: 最大值（包含）
    # @returns: void - 成功时继续执行，失败时触发 rollback
    # 
    # 使用场景：
    # - 验证配置参数
    # - 检查数组索引范围
    # - 确保游戏数值在有效范围
    ValidateIntInRange<public>(Value:int, MinVal:int, MaxVal:int)<decides><transacts>:void =
        Value >= MinVal
        Value <= MaxVal
    
    # 验证整数是否在范围内（开区间 (MinVal, MaxVal)）
    # @param Value: 要验证的值
    # @param MinVal: 最小值（不包含）
    # @param MaxVal: 最大值（不包含）
    ValidateIntInRangeExclusive<public>(Value:int, MinVal:int, MaxVal:int)<decides><transacts>:void =
        Value > MinVal
        Value < MaxVal
    
    # 验证整数是否为正数（> 0）
    # @param Value: 要验证的值
    # 
    # 使用场景：
    # - 验证生命值、能量值
    # - 检查资源数量
    # - 确保非零除数
    ValidatePositive<public>(Value:int)<decides><transacts>:void =
        Value > 0
    
    # 验证整数是否为非负数（>= 0）
    # @param Value: 要验证的值
    # 
    # 使用场景：
    # - 验证索引值
    # - 检查数量字段
    ValidateNonNegative<public>(Value:int)<decides><transacts>:void =
        Value >= 0
    
    # 验证整数是否为负数（< 0）
    # @param Value: 要验证的值
    ValidateNegative<public>(Value:int)<decides><transacts>:void =
        Value < 0
    
    # 验证整数是否为非正数（<= 0）
    # @param Value: 要验证的值
    ValidateNonPositive<public>(Value:int)<decides><transacts>:void =
        Value <= 0
    
    # ═══════════════════════════════════════════════════════════
    # 浮点数范围验证（带容差）
    # ═══════════════════════════════════════════════════════════
    
    # 默认 Epsilon - 用于浮点数比较的容差
    # 与 MathFloatComparison 保持一致
    DefaultEpsilon:float = 0.0001
    
    # 验证浮点数是否在范围内（闭区间，带容差）
    # @param Value: 要验证的值
    # @param MinVal: 最小值（包含，带容差）
    # @param MaxVal: 最大值（包含，带容差）
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 成功时继续执行，失败时触发 rollback
    # 
    # 注意：使用容差比较，避免浮点精度问题
    # Value >= MinVal - Epsilon 且 Value <= MaxVal + Epsilon 视为在范围内
    # 
    # 使用场景：
    # - 验证百分比（0.0 到 1.0）
    # - 检查角度范围
    # - 确保物理参数有效
    ValidateFloatInRange<public>(Value:float, MinVal:float, MaxVal:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value >= MinVal - Epsilon
        Value <= MaxVal + Epsilon
    
    # 验证浮点数是否在范围内（开区间，带容差）
    # @param Value: 要验证的值
    # @param MinVal: 最小值（不包含，但考虑容差）
    # @param MaxVal: 最大值（不包含，但考虑容差）
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # 
    # 注意：Value > MinVal + Epsilon 且 Value < MaxVal - Epsilon
    ValidateFloatInRangeExclusive<public>(Value:float, MinVal:float, MaxVal:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value > MinVal + Epsilon
        Value < MaxVal - Epsilon
    
    # 验证浮点数是否为正数（明显大于零）
    # @param Value: 要验证的值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # 
    # 注意：Value > Epsilon 才视为正数
    # 
    # 使用场景：
    # - 验证非零除数
    # - 检查速度是否大于零
    # - 确保资源量有效
    ValidateFloatPositive<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value > Epsilon
    
    # 验证浮点数是否为非负数（大于等于零，带容差）
    # @param Value: 要验证的值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # 
    # 注意：Value >= -Epsilon 才视为非负数
    ValidateFloatNonNegative<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value >= -1.0 * Epsilon
    
    # 验证浮点数是否为负数（明显小于零）
    # @param Value: 要验证的值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # 
    # 注意：Value < -Epsilon 才视为负数
    ValidateFloatNegative<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value < -1.0 * Epsilon
    
    # 验证浮点数是否为非正数（小于等于零，带容差）
    # @param Value: 要验证的值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # 
    # 注意：Value <= Epsilon 才视为非正数
    ValidateFloatNonPositive<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value <= Epsilon
    
    # ═══════════════════════════════════════════════════════════
    # 特殊范围验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证百分比值（0.0 到 1.0）
    # @param Value: 要验证的百分比值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # 
    # 使用场景：
    # - 验证插值参数 T
    # - 检查伤害减免百分比
    # - 确保概率值有效
    ValidatePercent<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value >= -1.0 * Epsilon
        Value <= 1.0 + Epsilon
    
    # 验证角度值（0.0 到 360.0）
    # @param Value: 要验证的角度值（度数）
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # 
    # 使用场景：
    # - 验证归一化后的角度
    # - 检查旋转参数
    ValidateAngleDegrees<public>(Value:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value >= -1.0 * Epsilon
        Value <= 360.0 + Epsilon
    
    # 验证索引是否在数组范围内
    # @param Index: 索引值
    # @param ArrayLength: 数组长度
    # 
    # 使用场景：
    # - 访问数组前验证索引
    # - 检查列表边界
    ValidateArrayIndex<public>(Index:int, ArrayLength:int)<decides><transacts>:void =
        Index >= 0
        Index < ArrayLength
    
    # ═══════════════════════════════════════════════════════════
    # 组合验证（多条件）
    # ═══════════════════════════════════════════════════════════
    
    # 验证整数范围且非零
    # @param Value: 要验证的值
    # @param MinVal: 最小值
    # @param MaxVal: 最大值
    # 
    # 使用场景：
    # - 验证非零除数且在合理范围
    ValidateIntRangeNonZero<public>(Value:int, MinVal:int, MaxVal:int)<decides><transacts>:void =
        Value >= MinVal
        Value <= MaxVal
        Value <> 0
    
    # 验证浮点数范围且非零
    # @param Value: 要验证的值
    # @param MinVal: 最小值
    # @param MaxVal: 最大值
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # 
    # 使用场景：
    # - 验证非零除数且在合理范围
    ValidateFloatRangeNonZero<public>(Value:float, MinVal:float, MaxVal:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Value >= MinVal - Epsilon
        Value <= MaxVal + Epsilon
        # 检查是否接近零（需要排除）
        AbsValue := if (Value < 0.0) then -Value else Value
        AbsValue > Epsilon
