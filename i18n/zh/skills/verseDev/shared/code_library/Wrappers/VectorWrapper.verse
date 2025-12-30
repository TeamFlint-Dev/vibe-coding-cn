# VectorWrapper - 向量操作统一封装
# 版本: 1.0
# 更新时间: 2025-12-30
# 来源: REQ - 统一 Verse 与 UnrealEngine 向量类型
#
# 设计目的:
# 1. 统一封装 Verse.vector3 和 UnrealEngine.vector3 两种向量类型
# 2. 处理不同坐标系统之间的转换
# 3. 提供完整的向量运算操作集合
# 4. 让上层代码无需关心底层向量类型差异
#
# 向量类型说明:
# - Verse.vector3: 使用 Forward/Left/Up 字段 (Verse 原生类型)
# - UnrealEngine.vector3: 使用 X/Y/Z 字段 (UE 坐标系统)
#
# 坐标系统说明:
# - UE 坐标系统: X=前方(Forward), Y=右方(Right), Z=上方(Up), 左手坐标系
# - Verse 坐标系统: Forward/Left/Up
# - 编辑器坐标系统: 编辑器中显示的坐标
#
# 业务域范围:
# - 向量类型转换 (Verse ↔ UnrealEngine)
# - 向量基础运算 (加减乘除)
# - 向量高级运算 (点积、叉积、归一化)
# - 向量查询 (长度、距离、方向)
# - 向量插值 (Lerp, Clamp)
# - 坐标系统转换
#
# API 参考:
# - /Verse.org/SpatialMath: Verse 原生向量类型
# - /UnrealEngine.com/Temporary/SpatialMath: UE 向量类型
# - /Verse.org/Verse: 标准数学函数 (Sqrt, Clamp, Min, Max)

using { /Verse.org/Simulation }  # 标准 UEFN 模拟环境（所有 Wrapper 的标准引用）
using { /Verse.org/Verse }  # Sqrt, Clamp 标准数学函数
using { /Verse.org/SpatialMath }
using { /UnrealEngine.com/Temporary/SpatialMath }

# ═══════════════════════════════════════════════════════════
# 操作结果结构
# ═══════════════════════════════════════════════════════════

# 向量操作结果（统一返回格式）
vector_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因（成功时为空）
    ResultVector<public>:(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := 0.0, Y := 0.0, Z := 0.0}  # 结果向量（使用 UE 类型）

# 标量操作结果（用于长度、距离等）
scalar_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因（成功时为空）
    ResultValue<public>:float = 0.0         # 结果数值

# ═══════════════════════════════════════════════════════════
# VectorWrapper 模块 - 向量操作统一封装层
# ═══════════════════════════════════════════════════════════

VectorWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 向量类型转换
    # 在 Verse 和 UnrealEngine 的 vector3 类型之间转换
    # ═══════════════════════════════════════════════════════
    
    # 将 Verse.vector3 转换为 UnrealEngine.vector3
    # Verse 使用 Forward/Left/Up, UE 使用 X/Y/Z
    # 映射关系: Forward->X, -Left->Y, Up->Z (注意 Left 需要取反为 Right)
    VerseToUE<public>(VV:(/Verse.org/SpatialMath:)vector3):(/UnrealEngine.com/Temporary/SpatialMath:)vector3 =
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := VV.Forward,
            Y := -VV.Left,    # Verse 的 Left 对应 UE 的 -Y (因为 UE 用 Right)
            Z := VV.Up
        }
    
    # 将 UnrealEngine.vector3 转换为 Verse.vector3
    # UE 使用 X/Y/Z, Verse 使用 Forward/Left/Up
    # 映射关系: X->Forward, -Y->Left, Z->Up
    UEToVerse<public>(UV:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):(/Verse.org/SpatialMath:)vector3 =
        (/Verse.org/SpatialMath:)vector3{
            Forward := UV.X,
            Left := -UV.Y,    # UE 的 Y (Right) 对应 Verse 的 -Left
            Up := UV.Z
        }
    
    # ═══════════════════════════════════════════════════════
    # 向量常量（使用 UE 类型）
    # ═══════════════════════════════════════════════════════
    
    # 零向量
    Zero<public>():(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = 
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    # 单位向量（所有分量为1）
    One<public>():(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = 
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := 1.0, Y := 1.0, Z := 1.0}
    
    # 前方向量（UE坐标系: X轴正方向）
    Forward<public>():(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = 
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := 1.0, Y := 0.0, Z := 0.0}
    
    # 右方向量（UE坐标系: Y轴正方向）
    Right<public>():(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = 
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := 0.0, Y := 1.0, Z := 0.0}
    
    # 上方向量（UE坐标系: Z轴正方向）
    Up<public>():(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = 
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := 0.0, Y := 0.0, Z := 1.0}
    
    # 后方向量
    Back<public>():(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = 
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := -1.0, Y := 0.0, Z := 0.0}
    
    # 左方向量
    Left<public>():(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = 
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := 0.0, Y := -1.0, Z := 0.0}
    
    # 下方向量
    Down<public>():(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = 
        (/UnrealEngine.com/Temporary/SpatialMath:)vector3{X := 0.0, Y := 0.0, Z := -1.0}
    
    # ═══════════════════════════════════════════════════════
    # 向量基础运算
    # ═══════════════════════════════════════════════════════
    
    # 向量加法
    Add<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):vector_op_result =
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := A.X + B.X,
            Y := A.Y + B.Y,
            Z := A.Z + B.Z
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
    
    # 向量减法
    Subtract<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):vector_op_result =
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := A.X - B.X,
            Y := A.Y - B.Y,
            Z := A.Z - B.Z
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
    
    # 向量标量乘法
    Multiply<public>(
        V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        Scalar:float
    ):vector_op_result =
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := V.X * Scalar,
            Y := V.Y * Scalar,
            Z := V.Z * Scalar
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
    
    # 向量分量乘法（逐分量相乘）
    MultiplyComponents<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):vector_op_result =
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := A.X * B.X,
            Y := A.Y * B.Y,
            Z := A.Z * B.Z
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
    
    # 向量标量除法
    Divide<public>(
        V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        Scalar:float
    ):vector_op_result =
        # 检查除数是否接近零（使用小的容差值避免浮点精度问题）
        if (Scalar > -0.0001 and Scalar < 0.0001):
            vector_op_result{
                Success := false,
                ErrorReason := "Cannot divide by zero",
                ResultVector := Zero()
            }
        else:
            Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
                X := V.X / Scalar,
                Y := V.Y / Scalar,
                Z := V.Z / Scalar
            }
            
            vector_op_result{
                Success := true,
                ErrorReason := "",
                ResultVector := Result
            }
    
    # ═══════════════════════════════════════════════════════
    # 向量高级运算
    # ═══════════════════════════════════════════════════════
    
    # 计算向量长度（模）
    Length<public>(V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):scalar_op_result =
        LenSquared := V.X * V.X + V.Y * V.Y + V.Z * V.Z
        Len := Sqrt(LenSquared)
        
        scalar_op_result{
            Success := true,
            ErrorReason := "",
            ResultValue := Len
        }
    
    # 计算向量长度的平方（避免开方运算，用于比较）
    LengthSquared<public>(V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):scalar_op_result =
        LenSquared := V.X * V.X + V.Y * V.Y + V.Z * V.Z
        
        scalar_op_result{
            Success := true,
            ErrorReason := "",
            ResultValue := LenSquared
        }
    
    # 归一化向量（转换为单位向量）
    Normalize<public>(V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):vector_op_result =
        LenSquared := V.X * V.X + V.Y * V.Y + V.Z * V.Z
        
        # 检查是否为零向量
        if (LenSquared < 0.0001):
            vector_op_result{
                Success := false,
                ErrorReason := "Cannot normalize zero vector",
                ResultVector := Zero()
            }
        else:
            Len := Sqrt(LenSquared)
            Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
                X := V.X / Len,
                Y := V.Y / Len,
                Z := V.Z / Len
            }
            
            vector_op_result{
                Success := true,
                ErrorReason := "",
                ResultVector := Result
            }
    
    # 点积（数量积）
    # 用于计算向量夹角、投影等
    Dot<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):scalar_op_result =
        DotProduct := A.X * B.X + A.Y * B.Y + A.Z * B.Z
        
        scalar_op_result{
            Success := true,
            ErrorReason := "",
            ResultValue := DotProduct
        }
    
    # 叉积（向量积）
    # 结果向量垂直于输入的两个向量，方向遵循右手定则
    Cross<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):vector_op_result =
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := A.Y * B.Z - A.Z * B.Y,
            Y := A.Z * B.X - A.X * B.Z,
            Z := A.X * B.Y - A.Y * B.X
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
    
    # ═══════════════════════════════════════════════════════
    # 向量查询与比较
    # ═══════════════════════════════════════════════════════
    
    # 计算两个向量之间的距离
    Distance<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):scalar_op_result =
        DiffX := B.X - A.X
        DiffY := B.Y - A.Y
        DiffZ := B.Z - A.Z
        DistSquared := DiffX * DiffX + DiffY * DiffY + DiffZ * DiffZ
        Dist := Sqrt(DistSquared)
        
        scalar_op_result{
            Success := true,
            ErrorReason := "",
            ResultValue := Dist
        }
    
    # 计算两个向量之间距离的平方（避免开方，用于比较）
    DistanceSquared<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):scalar_op_result =
        DiffX := B.X - A.X
        DiffY := B.Y - A.Y
        DiffZ := B.Z - A.Z
        DistSquared := DiffX * DiffX + DiffY * DiffY + DiffZ * DiffZ
        
        scalar_op_result{
            Success := true,
            ErrorReason := "",
            ResultValue := DistSquared
        }
    
    # 判断两个点是否在指定范围内
    IsInRange<public>(
        From:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        To:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        Range:float
    ):logic =
        DiffX := To.X - From.X
        DiffY := To.Y - From.Y
        DiffZ := To.Z - From.Z
        DistSquared := DiffX * DiffX + DiffY * DiffY + DiffZ * DiffZ
        RangeSquared := Range * Range
        
        if (DistSquared <= RangeSquared):
            true
        else:
            false
    
    # 获取从 From 指向 To 的方向向量（归一化）
    Direction<public>(
        From:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        To:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):vector_op_result =
        DiffX := To.X - From.X
        DiffY := To.Y - From.Y
        DiffZ := To.Z - From.Z
        
        LenSquared := DiffX * DiffX + DiffY * DiffY + DiffZ * DiffZ
        
        # 检查是否为零向量
        if (LenSquared < 0.0001):
            vector_op_result{
                Success := false,
                ErrorReason := "From and To are the same point",
                ResultVector := Zero()
            }
        else:
            Len := Sqrt(LenSquared)
            Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
                X := DiffX / Len,
                Y := DiffY / Len,
                Z := DiffZ / Len
            }
            
            vector_op_result{
                Success := true,
                ErrorReason := "",
                ResultVector := Result
            }
    
    # 判断向量是否接近零向量
    IsNearlyZero<public>(V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, ?Tolerance:float = 0.0001):logic =
        LenSquared := V.X * V.X + V.Y * V.Y + V.Z * V.Z
        ToleranceSquared := Tolerance * Tolerance
        
        if (LenSquared < ToleranceSquared):
            true
        else:
            false
    
    # 判断两个向量是否近似相等
    IsNearlyEqual<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        ?Tolerance:float = 0.0001
    ):logic =
        DiffX := A.X - B.X
        DiffY := A.Y - B.Y
        DiffZ := A.Z - B.Z
        
        if (DiffX < -Tolerance or DiffX > Tolerance):
            false
        else if (DiffY < -Tolerance or DiffY > Tolerance):
            false
        else if (DiffZ < -Tolerance or DiffZ > Tolerance):
            false
        else:
            true
    
    # ═══════════════════════════════════════════════════════
    # 向量插值与限制
    # ═══════════════════════════════════════════════════════
    
    # 线性插值（Lerp）
    # T=0 返回 A, T=1 返回 B, T=0.5 返回中点
    Lerp<public>(
        A:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        B:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        T:float
    ):vector_op_result =
        # 使用标准库 Clamp 函数限制 T 在 [0, 1] 范围内
        ClampedT := Clamp(T, 0.0, 1.0)
        
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := A.X + (B.X - A.X) * ClampedT,
            Y := A.Y + (B.Y - A.Y) * ClampedT,
            Z := A.Z + (B.Z - A.Z) * ClampedT
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
    
    # 向量分量限制（每个分量限制在指定范围内）
    Clamp<public>(
        V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        Min:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        Max:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
    ):vector_op_result =
        # 使用标准库 Clamp 函数对每个分量进行限制
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := Clamp(V.X, Min.X, Max.X),
            Y := Clamp(V.Y, Min.Y, Max.Y),
            Z := Clamp(V.Z, Min.Z, Max.Z)
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
    
    # 限制向量长度（保持方向，但长度不超过最大值）
    ClampLength<public>(
        V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3, 
        MaxLength:float
    ):vector_op_result =
        if (MaxLength <= 0.0):
            vector_op_result{
                Success := false,
                ErrorReason := "MaxLength must be positive",
                ResultVector := Zero()
            }
        else:
            LenSquared := V.X * V.X + V.Y * V.Y + V.Z * V.Z
            MaxLenSquared := MaxLength * MaxLength
            
            if (LenSquared <= MaxLenSquared):
                # 长度已经在范围内，直接返回
                vector_op_result{
                    Success := true,
                    ErrorReason := "",
                    ResultVector := V
                }
            else:
                # 需要缩短向量
                Len := Sqrt(LenSquared)
                Scale := MaxLength / Len
                Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
                    X := V.X * Scale,
                    Y := V.Y * Scale,
                    Z := V.Z * Scale
                }
                
                vector_op_result{
                    Success := true,
                    ErrorReason := "",
                    ResultVector := Result
                }
    
    # ═══════════════════════════════════════════════════════
    # 坐标系统转换
    # ═══════════════════════════════════════════════════════
    
    # UE 世界空间坐标转换为编辑器显示坐标
    # UE 内部使用厘米，编辑器可能使用不同单位
    WorldToEditor<public>(WorldPos:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):vector_op_result =
        # 目前直接返回，未来可以添加单位转换
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := WorldPos
        }
    
    # 编辑器显示坐标转换为 UE 世界空间坐标
    EditorToWorld<public>(EditorPos:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):vector_op_result =
        # 目前直接返回，未来可以添加单位转换
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := EditorPos
        }
    
    # ═══════════════════════════════════════════════════════
    # 辅助工具函数
    # ═══════════════════════════════════════════════════════
    
    # 获取向量的最大分量值
    MaxComponent<public>(V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):scalar_op_result =
        MaxVal:float = 
            if (V.X >= V.Y and V.X >= V.Z):
                V.X
            else if (V.Y >= V.Z):
                V.Y
            else:
                V.Z
        
        scalar_op_result{
            Success := true,
            ErrorReason := "",
            ResultValue := MaxVal
        }
    
    # 获取向量的最小分量值
    MinComponent<public>(V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):scalar_op_result =
        MinVal:float = 
            if (V.X <= V.Y and V.X <= V.Z):
                V.X
            else if (V.Y <= V.Z):
                V.Y
            else:
                V.Z
        
        scalar_op_result{
            Success := true,
            ErrorReason := "",
            ResultValue := MinVal
        }
    
    # 获取向量各分量的绝对值
    Abs<public>(V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):vector_op_result =
        var AbsX:float = V.X
        if (V.X < 0.0):
            set AbsX = -V.X
        
        var AbsY:float = V.Y
        if (V.Y < 0.0):
            set AbsY = -V.Y
        
        var AbsZ:float = V.Z
        if (V.Z < 0.0):
            set AbsZ = -V.Z
        
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := AbsX,
            Y := AbsY,
            Z := AbsZ
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
    
    # 向量取反（所有分量取负）
    Negate<public>(V:(/UnrealEngine.com/Temporary/SpatialMath:)vector3):vector_op_result =
        Result := (/UnrealEngine.com/Temporary/SpatialMath:)vector3{
            X := -V.X,
            Y := -V.Y,
            Z := -V.Z
        }
        
        vector_op_result{
            Success := true,
            ErrorReason := "",
            ResultVector := Result
        }
