# RandomUtils - 随机选择工具模块
# 版本: 1.0
# 添加时间: 2025-12-27
# 来源: REQ-003 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/SpatialMath }

RandomUtils<public> := module:
    # ==========================================
    # 随机选择
    # ==========================================
    
    # 从数组中随机选择一个元素
    SelectRandom<public>(Items:[]t where t:type):?t =
        if Items.Length = 0:
            return false
        Index := GetRandomInt(0, Items.Length - 1)
        return option{Items[Index]}
    
    # 按权重随机选择
    SelectWeighted<public>(Items:[]t, Weights:[]float where t:type):?t =
        if Items.Length = 0 or Weights.Length = 0:
            return false
        if Items.Length <> Weights.Length:
            return false
        
        TotalWeight := 0.0
        for (W in Weights):
            set TotalWeight += W
        
        if TotalWeight <= 0.0:
            return false
        
        Roll := GetRandomFloat(0.0, TotalWeight)
        CumulativeWeight := 0.0
        
        for (Index -> Item in Items):
            set CumulativeWeight += Weights[Index]
            if Roll <= CumulativeWeight:
                return option{Item}
        
        return option{Items[Items.Length - 1]}
    
    # 从数组随机选择多个（不重复）
    SelectMultiple<public>(Items:[]t, Count:int where t:type):[]t =
        if Items.Length = 0 or Count <= 0:
            return array{}
        
        ActualCount := Min(Count, Items.Length)
        Shuffled := Shuffle(Items)
        
        Result:[]t = array{}
        for (I := 0..ActualCount - 1):
            set Result += array{Shuffled[I]}
        return Result
    
    # ==========================================
    # 随机数值
    # ==========================================
    
    # 随机整数 [Min, Max] 包含两端
    RandomInt<public>(MinVal:int, MaxVal:int):int =
        return GetRandomInt(MinVal, MaxVal)
    
    # 随机浮点数 [Min, Max]
    RandomFloat<public>(MinVal:float, MaxVal:float):float =
        return GetRandomFloat(MinVal, MaxVal)
    
    # 随机概率判定
    RandomChance<public>(Probability:float):logic =
        if Probability <= 0.0:
            return false
        if Probability >= 1.0:
            return true
        return GetRandomFloat(0.0, 1.0) <= Probability
    
    # 随机布尔（50%概率）
    RandomBool<public>():logic =
        return RandomChance(0.5)
    
    # 随机符号 (-1 或 1)
    RandomSign<public>():int =
        return if RandomBool() then 1 else -1
    
    # ==========================================
    # 随机向量
    # ==========================================
    
    # 随机方向（单位向量）
    RandomDirection<public>():vector3 =
        Theta := GetRandomFloat(0.0, 6.28318530718)
        Z := GetRandomFloat(-1.0, 1.0)
        R := Sqrt(1.0 - Z * Z)
        return vector3{
            X := R * Cos(Theta),
            Y := R * Sin(Theta),
            Z := Z
        }
    
    # 随机点在圆内（水平面）
    RandomPointInCircle<public>(Radius:float):vector3 =
        Angle := GetRandomFloat(0.0, 6.28318530718)
        R := Sqrt(GetRandomFloat(0.0, 1.0)) * Radius
        return vector3{
            X := R * Cos(Angle),
            Y := R * Sin(Angle),
            Z := 0.0
        }
    
    # 随机点在球内
    RandomPointInSphere<public>(Radius:float):vector3 =
        Direction := RandomDirection()
        R := Pow(GetRandomFloat(0.0, 1.0), 0.333333) * Radius
        return vector3{
            X := Direction.X * R,
            Y := Direction.Y * R,
            Z := Direction.Z * R
        }
    
    # 随机点在盒子内
    RandomPointInBox<public>(HalfExtent:vector3):vector3 =
        return vector3{
            X := GetRandomFloat(-HalfExtent.X, HalfExtent.X),
            Y := GetRandomFloat(-HalfExtent.Y, HalfExtent.Y),
            Z := GetRandomFloat(-HalfExtent.Z, HalfExtent.Z)
        }
    
    # ==========================================
    # 数组操作
    # ==========================================
    
    # 打乱数组顺序 (Fisher-Yates)
    Shuffle<public>(Items:[]t where t:type):[]t =
        if Items.Length <= 1:
            return Items
        
        Result := Items
        N := Result.Length
        
        for (I := N - 1; I > 0; I -= 1):
            J := GetRandomInt(0, I)
            Temp := Result[I]
            set Result[I] = Result[J]
            set Result[J] = Temp
        
        return Result
    
    # 随机排列（返回索引数组）
    RandomPermutation<public>(N:int):[]int =
        Indices:[]int = array{}
        for (I := 0..N - 1):
            set Indices += array{I}
        return Shuffle(Indices)
    
    # ==========================================
    # 游戏常用
    # ==========================================
    
    # 掷骰子
    RollDice<public>(Sides:int):int =
        return GetRandomInt(1, Sides)
    
    # 掷多个骰子
    RollMultipleDice<public>(Sides:int, Count:int):int =
        Total := 0
        for (I := 0..Count - 1):
            set Total += RollDice(Sides)
        return Total
    
    # 战利品掉落判定
    ShouldDrop<public>(DropRate:float):logic =
        return RandomChance(DropRate)

    # 私有工具
    Min<private>(A:int, B:int):int = if A < B then A else B
    Sqrt<private>(X:float):float = Pow(X, 0.5)
    Cos<private>(X:float):float = external {}
    Sin<private>(X:float):float = external {}
    Pow<private>(Base:float, Exp:float):float = external {}
