# 套装效果模块
# 功能：套装效果激活判定（2件套/4件套）

using { /Verse.org/Simulation }

ItemSets<public> := module:
    
    # ========== 数据结构 ==========
    
    # 套装定义
    item_set_definition<public> := struct<computes>:
        SetID<public>:int = 0
        SetName<public>:string = "Unknown"
        TotalPieces<public>:int = 6
        TwoSetBonus<public>:int = 0             # 2件套效果ID
        FourSetBonus<public>:int = 0            # 4件套效果ID
        SixSetBonus<public>:int = 0             # 6件套效果ID
    
    # 套装进度
    set_progress<public> := struct<computes>:
        SetID<public>:int = 0
        EquippedCount<public>:int = 0
        ActiveBonuses<public>:[]int = array{}   # 激活的套装效果ID列表
        CompletionPercent<public>:float = 0.0
    
    # ========== 常量定义 ==========
    
    # 套装激活阈值
    TWO_SET_THRESHOLD<public>:int = 2
    FOUR_SET_THRESHOLD<public>:int = 4
    SIX_SET_THRESHOLD<public>:int = 6
    
    # ========== 套装激活判定 ==========
    
    # 检查2件套是否激活
    CheckTwoSetActive<public>(EquippedCount:int)<decides><transacts>:void =
        EquippedCount >= TWO_SET_THRESHOLD
    
    # 检查4件套是否激活
    CheckFourSetActive<public>(EquippedCount:int)<decides><transacts>:void =
        EquippedCount >= FOUR_SET_THRESHOLD
    
    # 检查6件套是否激活
    CheckSixSetActive<public>(EquippedCount:int)<decides><transacts>:void =
        EquippedCount >= SIX_SET_THRESHOLD
    
    # 获取激活的套装效果
    GetActiveBonuses<public>(Definition:item_set_definition, EquippedCount:int)<transacts>:[]int =
        var Bonuses:[]int = array{}
        
        if (CheckTwoSetActive[EquippedCount] and Definition.TwoSetBonus > 0):
            set Bonuses += array{Definition.TwoSetBonus}
        
        if (CheckFourSetActive[EquippedCount] and Definition.FourSetBonus > 0):
            set Bonuses += array{Definition.FourSetBonus}
        
        if (CheckSixSetActive[EquippedCount] and Definition.SixSetBonus > 0):
            set Bonuses += array{Definition.SixSetBonus}
        
        Bonuses
    
    # ========== 套装进度计算 ==========
    
    # 计算套装完成度
    CalculateSetCompletion<public>(EquippedCount:int, TotalPieces:int)<computes>:float =
        if (TotalPieces <= 0):
            0.0
        else:
            Progress := Floor(EquippedCount) / Floor(TotalPieces)
            Clamp(Progress, 0.0, 1.0)
    
    # 创建套装进度
    MakeSetProgress<public>(Definition:item_set_definition, EquippedCount:int)<transacts>:set_progress =
        ActiveBonuses := GetActiveBonuses(Definition, EquippedCount)
        CompletionPercent := CalculateSetCompletion(EquippedCount, Definition.TotalPieces)
        
        set_progress{
            SetID := Definition.SetID
            EquippedCount := EquippedCount
            ActiveBonuses := ActiveBonuses
            CompletionPercent := CompletionPercent
        }
    
    # ========== 套装效果查询 ==========
    
    # 检查特定效果是否激活
    CheckBonusActive<public>(Progress:set_progress, BonusID:int)<decides><transacts>:void =
        var IsActive:logic = false
        for (ActiveBonus : Progress.ActiveBonuses):
            if (ActiveBonus = BonusID):
                set IsActive = true
        IsActive
    
    # 获取激活的套装效果数量
    GetActiveBonusCount<public>(Progress:set_progress)<computes>:int =
        Progress.ActiveBonuses.Length
    
    # ========== 工具函数 ==========
    
    # 创建套装定义
    MakeSetDefinition<public>(SetID:int, Name:string, Total:int, TwoSet:int, FourSet:int, SixSet:int)<transacts>:item_set_definition =
        item_set_definition{
            SetID := SetID
            SetName := Name
            TotalPieces := Total
            TwoSetBonus := TwoSet
            FourSetBonus := FourSet
            SixSetBonus := SixSet
        }
