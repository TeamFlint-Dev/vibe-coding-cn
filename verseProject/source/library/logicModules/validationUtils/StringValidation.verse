# 字符串验证模块
# 功能：提供字符串格式和内容验证函数，使用 <decides> 效果进行fail-fast验证
# 架构：Logic 层 - 无状态纯函数，使用 <decides> 效果

using { /Verse.org/Simulation }

StringValidation<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 基础字符串验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证字符串是否为空
    # @param Value: 要验证的字符串
    # @returns: void - 字符串为空时成功，非空时失败
    # 
    # 使用场景：
    # - 检查可选字段是否未填写
    # - 验证清空操作是否成功
    ValidateEmpty<public>(Value:string)<decides><transacts>:void =
        Value.Length = 0
    
    # 验证字符串是否非空
    # @param Value: 要验证的字符串
    # @returns: void - 字符串非空时成功，为空时失败
    # 
    # 使用场景：
    # - 验证必填字段
    # - 确保输入有效
    # - 检查用户名、密码等不为空
    ValidateNotEmpty<public>(Value:string)<decides><transacts>:void =
        Value.Length > 0
    
    # 验证字符串长度是否在范围内
    # @param Value: 要验证的字符串
    # @param MinLength: 最小长度（包含）
    # @param MaxLength: 最大长度（包含）
    # @returns: void - 长度在范围内时成功
    # 
    # 使用场景：
    # - 验证用户名长度（如 3-20 字符）
    # - 检查密码长度要求
    # - 限制输入框字符数
    ValidateLengthInRange<public>(Value:string, MinLength:int, MaxLength:int)<decides><transacts>:void =
        Len := Value.Length
        Len >= MinLength
        Len <= MaxLength
    
    # 验证字符串长度至少为指定值
    # @param Value: 要验证的字符串
    # @param MinLength: 最小长度（包含）
    # @returns: void - 长度 >= MinLength 时成功
    # 
    # 使用场景：
    # - 验证密码最小长度
    # - 确保输入足够详细
    ValidateMinLength<public>(Value:string, MinLength:int)<decides><transacts>:void =
        Value.Length >= MinLength
    
    # 验证字符串长度不超过指定值
    # @param Value: 要验证的字符串
    # @param MaxLength: 最大长度（包含）
    # @returns: void - 长度 <= MaxLength 时成功
    # 
    # 使用场景：
    # - 限制显示文本长度
    # - 防止过长输入
    # - 数据库字段长度限制
    ValidateMaxLength<public>(Value:string, MaxLength:int)<decides><transacts>:void =
        Value.Length <= MaxLength
    
    # 验证字符串长度精确匹配
    # @param Value: 要验证的字符串
    # @param ExactLength: 精确长度
    # @returns: void - 长度 = ExactLength 时成功
    # 
    # 使用场景：
    # - 验证固定长度代码（如邀请码、验证码）
    # - 检查格式化字符串长度
    ValidateExactLength<public>(Value:string, ExactLength:int)<decides><transacts>:void =
        Value.Length = ExactLength
    
    # ═══════════════════════════════════════════════════════════
    # 组合验证
    # ═══════════════════════════════════════════════════════════
    
    # 验证字符串为有效的显示名称
    # 规则：1-50字符，非空
    # @param Value: 要验证的显示名称
    # @returns: void - 符合显示名称规则时成功
    # 
    # 使用场景：
    # - 验证物品名称
    # - 检查房间标题
    # - 验证自定义标签
    ValidateDisplayName<public>(Value:string)<decides><transacts>:void =
        # 长度检查：1-50字符
        Len := Value.Length
        Len >= 1
        Len <= 50
    
    # 验证字符串非空且长度合理
    # 规则：1-1000字符
    # @param Value: 要验证的字符串
    # @returns: void - 非空且不超过1000字符时成功
    # 
    # 使用场景：
    # - 通用文本输入验证
    # - 防止过长输入导致性能问题
    ValidateReasonableLength<public>(Value:string)<decides><transacts>:void =
        Len := Value.Length
        Len >= 1
        Len <= 1000
