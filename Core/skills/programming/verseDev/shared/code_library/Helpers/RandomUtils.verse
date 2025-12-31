# RandomUtils - 随机选择工具模块
# 版本: 1.5
# 添加时间: 2025-12-27
# 更新: 简化代码，移除与标准库冲突的函数
# 来源: REQ-003 (循环迭代模式)
#
# 使用说明:
# - 对于 Shuffle 功能，请直接使用 /Verse.org/Random:Shuffle
# - 对于 Min/Max 功能，请直接使用 /Verse.org/Verse:Min/Max

using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/SpatialMath }

RandomUtils<public> := module:
    # ==========================================
    # 随机选择
    # ==========================================
    
    # 从数组中随机选择一个元素
    SelectRandom<public>(Items:[]t where t:type)<decides><transacts>:t =
        Items.Length > 0
        Index := GetRandomInt(0, Items.Length - 1)
        Items[Index]
    
    # 按权重随机选择
    SelectWeighted<public>(Items:[]t, Weights:[]float where t:type)<decides><transacts>:t =
        Items.Length > 0
        Weights.Length > 0
        Items.Length = Weights.Length
        
        var TotalWeight:float = 0.0
        for (W : Weights):
            set TotalWeight += W
        
        TotalWeight > 0.0
        
        Roll := GetRandomFloat(0.0, TotalWeight)
        var CumulativeWeight:float = 0.0
        
        for (Index -> Item : Items):
            set CumulativeWeight += Weights[Index]
            if (Roll <= CumulativeWeight):
                Item
        
        Items[Items.Length - 1]
    
    # 从数组随机选择多个（不重复）
    # 注意: 使用 /Verse.org/Random:Shuffle 和 /Verse.org/Verse:Min
    SelectMultiple<public>(Items:[]t, Count:int where t:type)<transacts>:[]t =
        if (Items.Length = 0, Count <= 0):
            array{}
        else:
            ActualCount := if (Count < Items.Length) then Count else Items.Length
            Shuffled := Shuffle(Items)  # 这里会使用 /Verse.org/Random:Shuffle
            
            var Result:[]t = array{}
            for (I := 0..ActualCount - 1):
                if (ShuffledItem := Shuffled[I]):
                    set Result += array{ShuffledItem}
            Result
    
    # ==========================================
    # 随机数值
    # ==========================================
    
    # 随机整数 [Min, Max] 包含两端
    RandomInt<public>(MinVal:int, MaxVal:int)<transacts>:int =
        GetRandomInt(MinVal, MaxVal)
    
    # 随机浮点数 [Min, Max]
    RandomFloat<public>(MinVal:float, MaxVal:float)<transacts>:float =
        GetRandomFloat(MinVal, MaxVal)
    
    # 随机概率判定
    RandomChance<public>(Probability:float)<transacts>:logic =
        if (Probability <= 0.0):
            false
        else if (Probability >= 1.0):
            true
        else if (GetRandomFloat(0.0, 1.0) <= Probability):
            true
        else:
            false
    
    # 随机布尔（50%概率）
    RandomBool<public>()<transacts>:logic =
        RandomChance(0.5)
    
    # 随机符号 (-1 或 1)
    RandomSign<public>()<transacts>:int =
        if (RandomBool()?) then 1 else -1
    
    # ==========================================
    # 随机向量
    # ==========================================
    
    # 随机方向（单位向量）
    RandomDirection<public>()<transacts>:vector3 =
        Theta := GetRandomFloat(0.0, 6.28318530718)
        ZVal := GetRandomFloat(-1.0, 1.0)
        R := Sqrt(1.0 - ZVal * ZVal)
        vector3{
            X := R * Cos(Theta),
            Y := R * Sin(Theta),
            Z := ZVal
        }
    
    # 随机点在圆内（水平面）
    RandomPointInCircle<public>(Radius:float)<transacts>:vector3 =
        Angle := GetRandomFloat(0.0, 6.28318530718)
        R := Sqrt(GetRandomFloat(0.0, 1.0)) * Radius
        vector3{
            X := R * Cos(Angle),
            Y := R * Sin(Angle),
            Z := 0.0
        }
    
    # 随机点在球内
    RandomPointInSphere<public>(Radius:float)<transacts>:vector3 =
        Direction := RandomDirection()
        R := Pow(GetRandomFloat(0.0, 1.0), 0.333333) * Radius
        vector3{
            X := Direction.X * R,
            Y := Direction.Y * R,
            Z := Direction.Z * R
        }
    
    # 随机点在盒子内
    RandomPointInBox<public>(HalfExtent:vector3)<transacts>:vector3 =
        vector3{
            X := GetRandomFloat(-HalfExtent.X, HalfExtent.X),
            Y := GetRandomFloat(-HalfExtent.Y, HalfExtent.Y),
            Z := GetRandomFloat(-HalfExtent.Z, HalfExtent.Z)
        }
    
    # ==========================================
    # 数组操作
    # ==========================================
    
    # 打乱数组顺序
    # 注意: 包装标准库的 Shuffle
    ShuffleItems<public>(Items:[]t where t:type)<transacts>:[]t =
        Shuffle(Items)  # 使用 /Verse.org/Random:Shuffle
    
    # 随机排列（返回索引数组）
    RandomPermutation<public>(N:int)<transacts>:[]int =
        var Indices:[]int = array{}
        for (I := 0..N - 1):
            set Indices += array{I}
        Shuffle(Indices)  # 使用 /Verse.org/Random:Shuffle
    
    # ==========================================
    # 游戏常用
    # ==========================================
    
    # 掷骰子
    RollDice<public>(Sides:int)<transacts>:int =
        GetRandomInt(1, Sides)
    
    # 掷多个骰子
    RollMultipleDice<public>(Sides:int, Count:int)<transacts>:int =
        var Total:int = 0
        for (I := 0..Count - 1):
            set Total += RollDice(Sides)
        Total
    
    # 战利品掉落判定
    ShouldDrop<public>(DropRate:float)<transacts>:logic =
        RandomChance(DropRate)
