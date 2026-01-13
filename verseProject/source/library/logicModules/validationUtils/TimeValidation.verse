# 时间验证模块
# 功能：提供时间和持续时间验证函数，使用 <decides> 效果进行 fail-fast 验证
# 架构：Logic 层 - 无状态纯函数，使用 <decides> 效果
# 
# 设计决策：
# - 时间使用 float 类型（秒），与 Verse 标准一致
# - 时间戳从 0.0 开始（游戏开始时刻）
# - 持续时间可以为 0（表示瞬间），但不能为负

using { /Verse.org/Simulation }

TimeValidation<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 常量定义
    # ═══════════════════════════════════════════════════════════
    
    # 最小有效时间戳（通常为 0.0，表示游戏开始）
    MinValidTimestamp:float = 0.0
    
    # 最大合理时间戳（约 27.7 小时，超过此值可能是错误）
    # 100000 秒 ≈ 1666 分钟 ≈ 27.7 小时
    MaxReasonableTimestamp:float = 100000.0
    
    # 默认 Epsilon - 用于浮点数时间比较的容差
    # 与 MathFloatComparison 保持一致
    DefaultEpsilon:float = 0.0001
    
    # ═══════════════════════════════════════════════════════════
    # 时间戳验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证时间戳是否有效（非负且在合理范围内）
    # @param Timestamp: 要验证的时间戳（秒）
    # @returns: void - 成功时继续执行，失败时触发 rollback
    # 
    # 使用场景：
    # - 验证事件发生时间
    # - 检查计时器设置
    # - 确保时间参数合法性
    # 
    # 验证规则：
    # - 时间戳 >= MinValidTimestamp (0.0)
    # - 时间戳 <= MaxReasonableTimestamp (100000.0)
    ValidateTimestamp<public>(Timestamp:float)<decides><transacts>:void =
        Timestamp >= MinValidTimestamp
        Timestamp <= MaxReasonableTimestamp
    
    # 验证时间戳是否为非负（宽松版本，不检查上限）
    # @param Timestamp: 要验证的时间戳（秒）
    # @returns: void - 成功时继续执行，失败时触发 rollback
    # 
    # 使用场景：
    # - 当不关心上限时使用
    # - 允许任意未来时间
    ValidateTimestampNonNegative<public>(Timestamp:float)<decides><transacts>:void =
        Timestamp >= MinValidTimestamp
    
    # ═══════════════════════════════════════════════════════════
    # 时间比较验证
    # ═══════════════════════════════════════════════════════════
    
    # 判断时间戳是否在当前时间之后（未来）
    # @param Timestamp: 要检查的时间戳
    # @param CurrentTime: 当前时间
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: logic - 如果 Timestamp > CurrentTime + Epsilon 返回 true
    # 
    # 使用场景：
    # - 检查事件是否尚未发生
    # - 判断计时器是否未到时
    # - 验证未来时间预约
    # 
    # 注意：使用 Epsilon 避免浮点精度问题
    IsFuture<public>(Timestamp:float, CurrentTime:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (Timestamp > CurrentTime + Epsilon) then true else false
    
    # 判断时间戳是否在当前时间之前（过去）
    # @param Timestamp: 要检查的时间戳
    # @param CurrentTime: 当前时间
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: logic - 如果 Timestamp < CurrentTime - Epsilon 返回 true
    # 
    # 使用场景：
    # - 检查事件是否已经发生
    # - 判断计时器是否已到时
    # - 验证历史数据
    IsPast<public>(Timestamp:float, CurrentTime:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        if (Timestamp < CurrentTime - Epsilon) then true else false
    
    # 验证时间戳是否在未来（fail-fast 版本）
    # @param Timestamp: 要验证的时间戳
    # @param CurrentTime: 当前时间
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 如果不是未来时间则失败
    ValidateFuture<public>(Timestamp:float, CurrentTime:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Timestamp > CurrentTime + Epsilon
    
    # 验证时间戳是否在过去（fail-fast 版本）
    # @param Timestamp: 要验证的时间戳
    # @param CurrentTime: 当前时间
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 如果不是过去时间则失败
    ValidatePast<public>(Timestamp:float, CurrentTime:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Timestamp < CurrentTime - Epsilon
    
    # ═══════════════════════════════════════════════════════════
    # 持续时间验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证持续时间是否有效（非负）
    # @param Duration: 持续时间（秒）
    # @returns: void - 成功时继续执行，失败时触发 rollback
    # 
    # 使用场景：
    # - 验证冷却时间设置
    # - 检查技能持续时间
    # - 确保时间间隔合法
    # 
    # 验证规则：
    # - Duration >= 0.0（持续时间不能为负）
    # - Duration = 0.0 表示瞬间/无持续时间（合法）
    ValidateDuration<public>(Duration:float)<decides><transacts>:void =
        Duration >= 0.0
    
    # 验证持续时间是否为正数（严格大于零）
    # @param Duration: 持续时间（秒）
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 成功时继续执行，失败时触发 rollback
    # 
    # 使用场景：
    # - 当必须有真实持续时间时（不接受 0）
    # - 验证动画时长、音效长度等
    # 
    # 注意：使用 Epsilon 避免浮点精度问题
    ValidateDurationPositive<public>(Duration:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Duration > Epsilon
    
    # 验证持续时间是否在合理范围内
    # @param Duration: 持续时间（秒）
    # @param MaxDuration: 最大允许持续时间（秒）
    # @returns: void - 成功时继续执行，失败时触发 rollback
    # 
    # 使用场景：
    # - 限制技能冷却时间上限
    # - 防止过长的 buff/debuff 时长
    # - 确保持续时间在游戏设计范围内
    ValidateDurationInRange<public>(Duration:float, MaxDuration:float)<decides><transacts>:void =
        Duration >= 0.0
        Duration <= MaxDuration
    
    # ═══════════════════════════════════════════════════════════
    # 时间范围验证
    # ═══════════════════════════════════════════════════════════
    
    # 判断时间戳是否在指定时间窗口内
    # @param Timestamp: 要检查的时间戳
    # @param StartTime: 时间窗口开始时间（包含）
    # @param EndTime: 时间窗口结束时间（包含）
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: logic - 如果 Timestamp 在 [StartTime, EndTime] 内返回 true
    # 
    # 使用场景：
    # - 检查事件是否在活动期间发生
    # - 判断是否在限时任务时间内
    # - 验证时间段资格
    # 
    # 注意：使用 Epsilon 放宽边界，避免浮点精度问题
    IsWithinTimeframe<public>(Timestamp:float, StartTime:float, EndTime:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        # 直接计算布尔表达式，避免使用可能失败的赋值
        IsAfterOrAtStart := if (Timestamp >= StartTime - Epsilon) then true else false
        IsBeforeOrAtEnd := if (Timestamp <= EndTime + Epsilon) then true else false
        
        if (IsAfterOrAtStart = true):
            if (IsBeforeOrAtEnd = true):
                true
            else:
                false
        else:
            false
    
    # 验证时间戳是否在时间窗口内（fail-fast 版本）
    # @param Timestamp: 要验证的时间戳
    # @param StartTime: 时间窗口开始时间（包含）
    # @param EndTime: 时间窗口结束时间（包含）
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 如果不在时间窗口内则失败
    ValidateWithinTimeframe<public>(Timestamp:float, StartTime:float, EndTime:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        Timestamp >= StartTime - Epsilon
        Timestamp <= EndTime + Epsilon
    
    # ═══════════════════════════════════════════════════════════
    # 辅助验证函数
    # ═══════════════════════════════════════════════════════════
    
    # 验证时间范围的有效性（StartTime < EndTime）
    # @param StartTime: 开始时间
    # @param EndTime: 结束时间
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 如果时间范围无效则失败
    # 
    # 使用场景：
    # - 验证时间窗口配置
    # - 检查事件调度参数
    # - 确保时间逻辑正确
    ValidateTimeRange<public>(StartTime:float, EndTime:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        EndTime > StartTime + Epsilon
    
    # 验证时间戳序列的单调性（递增）
    # @param EarlierTime: 较早的时间戳
    # @param LaterTime: 较晚的时间戳
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: void - 如果时间序列错误则失败
    # 
    # 使用场景：
    # - 验证事件日志的时间顺序
    # - 检查时间线一致性
    # - 确保因果关系正确
    # 
    # 注意：要求 LaterTime > EarlierTime（严格递增）
    ValidateTimeOrder<public>(EarlierTime:float, LaterTime:float, ?Epsilon:float = DefaultEpsilon)<decides><transacts>:void =
        LaterTime > EarlierTime + Epsilon
    
    # 判断两个时间戳是否近似相等
    # @param TimeA: 第一个时间戳
    # @param TimeB: 第二个时间戳
    # @param Epsilon: 容差值（可选，默认 0.0001）
    # @returns: logic - 如果两个时间戳在 Epsilon 范围内返回 true
    # 
    # 使用场景：
    # - 检查事件是否同时发生
    # - 判断时间戳是否匹配
    # - 容忍浮点精度误差的时间比较
    IsTimeNearlyEqual<public>(TimeA:float, TimeB:float, ?Epsilon:float = DefaultEpsilon)<computes>:logic =
        Diff := TimeA - TimeB
        AbsDiff := if (Diff < 0.0) then -Diff else Diff
        if (AbsDiff <= Epsilon) then true else false
