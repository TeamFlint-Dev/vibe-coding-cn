# 位运算模拟模块
# 功能：使用整数运算模拟位操作（AND, OR, XOR, NOT, 移位等）
# 架构：Logic 层 - 纯函数，无状态
# 应用场景：标志位管理、权限系统、状态编码、掩码操作
# 
# 注意：这是简化实现，仅支持基本的位操作
# 针对常见的标志位和权限管理场景

MathBitwise<public> := module:
    
    # ═══════════════════════════════════════════════════════════
    # 移位运算 (最常用，最可靠)
    # ═══════════════════════════════════════════════════════════
    
    # 左移 (Left Shift)
    # @param Value: 要移位的值
    # @param Shift: 移位位数 (0-30)
    # @returns: Value << Shift 的结果
    # 
    # 原理：左移n位 = 乘以 2^n
    # 应用：快速乘法、构造掩码
    # 示例：LeftShift(5, 2) = 20
    #       0101 << 2 = 10100
    LeftShift<public>(Value:int, Shift:int)<computes>:int =
        if (Shift <= 0):
            Value
        else if (Shift >= 31):
            0  # 移位超过30位，结果为0（避免溢出）
        else:
            Value * PowerOf2(Shift)
    
    # 右移 (Right Shift) - 逻辑右移
    # @param Value: 要移位的值
    # @param Shift: 移位位数 (0-30)
    # @returns: Value >> Shift 的结果
    # 
    # 原理：右移n位 = 除以 2^n（向下取整）
    # 应用：快速除法、提取高位
    # 示例：RightShift(20, 2) = 5
    #       10100 >> 2 = 00101
    RightShift<public>(Value:int, Shift:int)<transacts><decides>:int =
        if (Shift <= 0):
            Value
        else if (Shift >= 31):
            0  # 移位超过30位，结果为0
        else:
            Floor[Value * 1.0 / (PowerOf2(Shift) * 1.0)]
    
    # 计算 2^n (查表实现，避免递归)
    PowerOf2<public>(N:int)<computes>:int =
        if (N <= 0):
            1
        else if (N = 1):
            2
        else if (N = 2):
            4
        else if (N = 3):
            8
        else if (N = 4):
            16
        else if (N = 5):
            32
        else if (N = 6):
            64
        else if (N = 7):
            128
        else if (N = 8):
            256
        else if (N = 9):
            512
        else if (N = 10):
            1024
        else if (N = 11):
            2048
        else if (N = 12):
            4096
        else if (N = 13):
            8192
        else if (N = 14):
            16384
        else if (N = 15):
            32768
        else if (N = 16):
            65536
        else if (N = 17):
            131072
        else if (N = 18):
            262144
        else if (N = 19):
            524288
        else if (N = 20):
            1048576
        else if (N = 21):
            2097152
        else if (N = 22):
            4194304
        else if (N = 23):
            8388608
        else if (N = 24):
            16777216
        else if (N = 25):
            33554432
        else if (N = 26):
            67108864
        else if (N = 27):
            134217728
        else if (N = 28):
            268435456
        else if (N = 29):
            536870912
        else if (N = 30):
            1073741824
        else:
            2147483648  # 2^31 (仅用于计算，实际使用可能溢出)
    
    # ═══════════════════════════════════════════════════════════
    # 高级位操作 (基于移位实现)
    # ═══════════════════════════════════════════════════════════
    
    # 检查指定位是否为1
    # @param Value: 要检查的值
    # @param BitIndex: 位索引 (0-30，0表示最低位)
    # @returns: 如果指定位为1返回true
    # 
    # 原理：(Value >> BitIndex) & 1
    # 应用：标志位检查、权限验证
    # 示例：TestBit(5, 0) = true  (0101的第0位是1)
    #       TestBit(5, 1) = false (0101的第1位是0)
    TestBit<public>(Value:int, BitIndex:int)<transacts><decides>:logic =
        if (BitIndex < 0 or BitIndex >= 31):
            false  # 无效索引
        else:
            Shifted := RightShift[Value, BitIndex]
            Remainder := Floor[Shifted * 1.0 / 2.0]
            LastBit := Shifted - (Remainder * 2)
            if (LastBit = 1) then true else false
    
    # 设置指定位为1
    # @param Value: 原始值
    # @param BitIndex: 位索引 (0-30)
    # @returns: 设置后的值
    # 
    # 原理：Value | (1 << BitIndex)
    # 应用：设置标志位、添加权限
    # 示例：SetBit(4, 0) = 5  (0100 | 0001 = 0101)
    SetBit<public>(Value:int, BitIndex:int)<transacts><decides>:int =
        if (BitIndex < 0 or BitIndex >= 31):
            Value  # 无效索引，返回原值
        else:
            Mask := PowerOf2(BitIndex)
            if (TestBit[Value, BitIndex]?):
                Value  # 已经是1，不需要修改
            else:
                Value + Mask  # 添加这一位
    
    # 清除指定位（设置为0）
    # @param Value: 原始值
    # @param BitIndex: 位索引 (0-30)
    # @returns: 清除后的值
    # 
    # 原理：Value & ~(1 << BitIndex)
    # 应用：清除标志位、移除权限
    # 示例：ClearBit(5, 0) = 4  (0101 & ~0001 = 0100)
    ClearBit<public>(Value:int, BitIndex:int)<transacts><decides>:int =
        if (BitIndex < 0 or BitIndex >= 31):
            Value
        else:
            Mask := PowerOf2(BitIndex)
            if (TestBit[Value, BitIndex]?):
                Value - Mask  # 移除这一位
            else:
                Value  # 已经是0，不需要修改
    
    # 切换指定位（0变1，1变0）
    # @param Value: 原始值
    # @param BitIndex: 位索引 (0-30)
    # @returns: 切换后的值
    # 
    # 应用：切换开关状态
    # 示例：ToggleBit(4, 0) = 5, ToggleBit(5, 0) = 4
    ToggleBit<public>(Value:int, BitIndex:int)<transacts><decides>:int =
        if (BitIndex < 0 or BitIndex >= 31):
            Value
        else:
            Mask := PowerOf2(BitIndex)
            if (TestBit[Value, BitIndex]?):
                Value - Mask  # 从1变为0
            else:
                Value + Mask  # 从0变为1
    
    # ═══════════════════════════════════════════════════════════
    # 掩码工具函数
    # ═══════════════════════════════════════════════════════════
    
    # 创建连续位掩码
    # @param NumBits: 位数 (1-31)
    # @returns: 掩码值
    # 
    # 应用：创建权限掩码
    # 示例：CreateMask(3) = 7 (0b111)
    #       CreateMask(4) = 15 (0b1111)
    CreateMask<public>(NumBits:int)<computes>:int =
        if (NumBits <= 0):
            0
        else if (NumBits >= 31):
            2147483647  # 2^31 - 1，最大正整数
        else:
            PowerOf2(NumBits) - 1
    
    # 创建单个位掩码
    # @param BitIndex: 位索引 (0-30)
    # @returns: 掩码值
    # 
    # 应用：位操作
    # 示例：CreateBitMask(0) = 1, CreateBitMask(2) = 4
    CreateBitMask<public>(BitIndex:int)<computes>:int =
        if (BitIndex < 0 or BitIndex >= 31):
            0
        else:
            PowerOf2(BitIndex)
    
    # ═══════════════════════════════════════════════════════════
    # 实用函数
    # ═══════════════════════════════════════════════════════════
    
    # 判断整数是否是2的幂
    # @param Value: 要检查的值
    # @returns: 如果是2的幂返回true
    # 
    # 原理：2的幂只有一个位为1
    # 应用：对齐检查、容量验证
    # 示例：IsPowerOf2(8) = true, IsPowerOf2(6) = false
    IsPowerOf2<public>(Value:int)<computes>:logic =
        if (Value <= 0):
            false
        else if (Value = 1):
            true
        else if (Value = 2):
            true
        else if (Value = 4):
            true
        else if (Value = 8):
            true
        else if (Value = 16):
            true
        else if (Value = 32):
            true
        else if (Value = 64):
            true
        else if (Value = 128):
            true
        else if (Value = 256):
            true
        else if (Value = 512):
            true
        else if (Value = 1024):
            true
        else if (Value = 2048):
            true
        else if (Value = 4096):
            true
        else if (Value = 8192):
            true
        else if (Value = 16384):
            true
        else if (Value = 32768):
            true
        else if (Value = 65536):
            true
        else if (Value = 131072):
            true
        else if (Value = 262144):
            true
        else if (Value = 524288):
            true
        else if (Value = 1048576):
            true
        else if (Value = 2097152):
            true
        else if (Value = 4194304):
            true
        else if (Value = 8388608):
            true
        else if (Value = 16777216):
            true
        else if (Value = 33554432):
            true
        else if (Value = 67108864):
            true
        else if (Value = 134217728):
            true
        else if (Value = 268435456):
            true
        else if (Value = 536870912):
            true
        else if (Value = 1073741824):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════════
    # 标志位组合工具 (常见使用模式)
    # ═══════════════════════════════════════════════════════════
    
    # 检查是否拥有所有指定的标志位
    # @param Value: 要检查的值
    # @returns: 如果所有标志位都是1返回true
    # 
    # 原理：检查多个位是否都被设置
    # 应用：权限验证（需要同时拥有多个权限）
    HasAllFlags2<public>(Value:int, Bit0:int, Bit1:int)<transacts><decides>:logic =
        if (TestBit[Value, Bit0]?):
            TestBit[Value, Bit1]?
        else:
            false
    
    HasAllFlags3<public>(Value:int, Bit0:int, Bit1:int, Bit2:int)<transacts><decides>:logic =
        if (TestBit[Value, Bit0]?):
            if (TestBit[Value, Bit1]?):
                TestBit[Value, Bit2]?
            else:
                false
        else:
            false
    
    # 检查是否拥有任意指定的标志位
    # @param Value: 要检查的值
    # @returns: 如果任意标志位是1返回true
    # 
    # 应用：权限验证（拥有任一权限即可）
    HasAnyFlags2<public>(Value:int, Bit0:int, Bit1:int)<transacts><decides>:logic =
        if (TestBit[Value, Bit0]?):
            true
        else:
            TestBit[Value, Bit1]?
    
    HasAnyFlags3<public>(Value:int, Bit0:int, Bit1:int, Bit2:int)<transacts><decides>:logic =
        if (TestBit[Value, Bit0]?):
            true
        else if (TestBit[Value, Bit1]?):
            true
        else:
            TestBit[Value, Bit2]?
