# 耐久度系统模块
# 功能：耐久度损耗公式、修理费用计算

using { /Verse.org/Simulation }

InvDurability<public> := module:
    
    # ========== 数据结构 ==========
    
    # 耐久度信息
    durability_info<public> := struct<computes>:
        Current<public>:float = 100.0
        Maximum<public>:float = 100.0
        RepairCost<public>:int = 0
    
    # ========== 常量定义 ==========
    
    # 耐久度损耗率
    COMBAT_DURABILITY_LOSS<public>:float = 0.1      # 战斗每次损耗
    DEATH_DURABILITY_LOSS<public>:float = 10.0      # 死亡损耗
    
    # 修理费用系数
    REPAIR_COST_PER_POINT<public>:float = 1.0
    REPAIR_COST_MULTIPLIER<public>:float = 0.5      # 按物品价值的50%
    
    # ========== 耐久度损耗 ==========
    
    # 计算战斗损耗
    CalculateCombatDurabilityLoss<public>(Current:float)<computes>:float =
        Max(Current - COMBAT_DURABILITY_LOSS, 0.0)
    
    # 计算死亡损耗
    CalculateDeathDurabilityLoss<public>(Current:float)<computes>:float =
        Max(Current - DEATH_DURABILITY_LOSS, 0.0)
    
    # 计算耐久度百分比
    GetDurabilityPercent<public>(Info:durability_info)<computes>:float =
        if (Info.Maximum > 0.0):
            Clamp(Info.Current / Info.Maximum, 0.0, 1.0)
        else:
            0.0
    
    # 检查是否损坏
    CheckBroken<public>(Info:durability_info)<decides><transacts>:void =
        Info.Current <= 0.0
    
    # 检查是否需要修理
    CheckNeedsRepair<public>(Info:durability_info, Threshold:float)<decides><transacts>:void =
        Percent := GetDurabilityPercent(Info)
        Percent < Threshold
    
    # ========== 修理费用计算 ==========
    
    # 计算修理费用
    CalculateRepairCost<public>(Current:float, Maximum:float, ItemValue:int)<computes>:int =
        if (Maximum <= 0.0):
            0
        else:
            DurabilityLost := Maximum - Current
            CostPerPoint := Floor(ItemValue) * REPAIR_COST_MULTIPLIER / Maximum
            TotalCost := DurabilityLost * CostPerPoint
            Max(Floor(TotalCost), 1)
    
    # 计算完全修理费用
    CalculateFullRepairCost<public>(Info:durability_info, ItemValue:int)<computes>:int =
        CalculateRepairCost(Info.Current, Info.Maximum, ItemValue)
    
    # ========== 修理操作 ==========
    
    # 修理装备
    RepairDurability<public>(Info:durability_info, RepairAmount:float)<transacts>:durability_info =
        NewCurrent := Min(Info.Current + RepairAmount, Info.Maximum)
        durability_info{
            Current := NewCurrent
            Maximum := Info.Maximum
            RepairCost := Info.RepairCost
        }
    
    # 完全修理
    FullRepair<public>(Info:durability_info)<transacts>:durability_info =
        durability_info{
            Current := Info.Maximum
            Maximum := Info.Maximum
            RepairCost := 0
        }
    
    # ========== 工具函数 ==========
    
    # 创建耐久度信息
    MakeDurabilityInfo<public>(Max:float, ItemValue:int)<transacts>:durability_info =
        durability_info{
            Current := Max
            Maximum := Max
            RepairCost := 0
        }
