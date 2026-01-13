# 字符串工具模块
# 功能：字符串基础操作和检查
# 架构：Logic 层 - 纯函数，无状态

UtilStrings<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 字符串检查函数
    # ═══════════════════════════════════════════════════════════
    
    # 检查字符串是否为空
    # @param Str: 要检查的字符串
    # @returns: 如果字符串长度为0返回 true
    # 
    # 使用场景:
    # - 验证用户输入
    # - 过滤空字符串
    IsEmpty<public>(Str:string)<computes>:logic =
        Length := Str.Length
        if (Length = 0) then true else false
    
    # 检查字符串长度是否在指定范围内
    # @param Str: 要检查的字符串
    # @param MinLen: 最小长度（包含）
    # @param MaxLen: 最大长度（包含）
    # @returns: 如果长度在范围内返回 true
    # 
    # 使用场景:
    # - 用户名长度验证
    # - 输入框字符限制检查
    IsLengthInRange<public>(Str:string, MinLen:int, MaxLen:int)<computes>:logic =
        Length := Str.Length
        if (Length >= MinLen):
            if (Length <= MaxLen):
                true
            else:
                false
        else:
            false
    
    # ═══════════════════════════════════════════════════════════
    # 字符串比较函数
    # ═══════════════════════════════════════════════════════════
    
    # 比较两个字符串是否相等
    # @param Str1: 第一个字符串
    # @param Str2: 第二个字符串
    # @returns: 如果相等返回 true
    # 
    # 注意: 这是对 Verse 内置 = 操作的封装，提供显式的函数形式
    AreEqual<public>(Str1:string, Str2:string)<computes>:logic =
        if (Str1 = Str2) then true else false
    
    # ═══════════════════════════════════════════════════════════
    # 字符串信息函数
    # ═══════════════════════════════════════════════════════════
    
    # 获取字符串长度
    # @param Str: 字符串
    # @returns: 字符串长度
    # 
    # 注意: 这是对 Verse 内置 .Length 的封装
    GetLength<public>(Str:string)<computes>:int =
        Str.Length
    
    # 获取两个字符串长度中的较大值
    # @param Str1: 第一个字符串
    # @param Str2: 第二个字符串
    # @returns: 较大的长度
    MaxLength<public>(Str1:string, Str2:string)<computes>:int =
        Len1 := Str1.Length
        Len2 := Str2.Length
        Max(Len1, Len2)
    
    # 获取两个字符串长度中的较小值
    # @param Str1: 第一个字符串
    # @param Str2: 第二个字符串
    # @returns: 较小的长度
    MinLength<public>(Str1:string, Str2:string)<computes>:int =
        Len1 := Str1.Length
        Len2 := Str2.Length
        Min(Len1, Len2)
    
    # ═══════════════════════════════════════════════════════════
    # 字符串重复和填充
    # ═══════════════════════════════════════════════════════════
    
    # 重复字符串指定次数
    # @param Str: 要重复的字符串
    # @param Count: 重复次数
    # @returns: 重复后的字符串
    # 
    # 使用场景:
    # - 生成分隔线（如 "=" * 50）
    # - 填充字符
    # 
    # 注意: Count <= 0 返回空字符串
    Repeat<public>(Str:string, Count:int)<computes>:string =
        if (Count <= 0):
            ""
        else:
            # 使用递归累加（迭代方式）
            # Verse 不支持直接的字符串拼接循环，使用有限次展开
            RepeatInternal(Str, Count, "")
    
    # 内部辅助函数 - 递归重复字符串
    # @param Str: 要重复的字符串
    # @param Remaining: 剩余重复次数
    # @param Accumulated: 已累加的结果
    # @returns: 重复后的字符串
    RepeatInternal<public>(Str:string, Remaining:int, Accumulated:string)<computes>:string =
        if (Remaining <= 0):
            Accumulated
        else:
            NewAccumulated := "{Accumulated}{Str}"
            RepeatInternal(Str, Remaining - 1, NewAccumulated)
    
    # ═══════════════════════════════════════════════════════════
    # 字符串构建辅助
    # ═══════════════════════════════════════════════════════════
    
    # 连接两个字符串
    # @param Str1: 第一个字符串
    # @param Str2: 第二个字符串
    # @returns: 连接后的字符串
    # 
    # 注意: 这是对 "{Str1}{Str2}" 的封装，提供函数形式
    Concat<public>(Str1:string, Str2:string)<computes>:string =
        "{Str1}{Str2}"
    
    # 连接三个字符串
    # @param Str1: 第一个字符串
    # @param Str2: 第二个字符串
    # @param Str3: 第三个字符串
    # @returns: 连接后的字符串
    Concat3<public>(Str1:string, Str2:string, Str3:string)<computes>:string =
        "{Str1}{Str2}{Str3}"
    
    # 用分隔符连接两个字符串
    # @param Str1: 第一个字符串
    # @param Separator: 分隔符
    # @param Str2: 第二个字符串
    # @returns: 连接后的字符串
    # 
    # 使用场景:
    # - 拼接路径："folder" + "/" + "file.txt"
    # - 拼接名称："FirstName" + " " + "LastName"
    ConcatWithSeparator<public>(Str1:string, Separator:string, Str2:string)<computes>:string =
        "{Str1}{Separator}{Str2}"
    
    # ═══════════════════════════════════════════════════════════
    # 常用字符串常量
    # ═══════════════════════════════════════════════════════════
    
    # 空字符串
    Empty<public>:string = ""
    
    # 空格
    Space<public>:string = " "
    
    # 换行符（根据平台可能不同，这里使用通用形式）
    NewLine<public>:string = "\n"
    
    # 制表符
    Tab<public>:string = "\t"
