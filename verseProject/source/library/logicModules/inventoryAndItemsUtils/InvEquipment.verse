# 装备系统模块
# 功能：装备槽位互斥检查（如双手武器不能拿盾）

using { /Verse.org/Simulation }

InvEquipment<public> := module:
    
    # ========== 槽位枚举 ==========
    
    SLOT_HEAD<public>:int = 0
    SLOT_CHEST<public>:int = 1
    SLOT_LEGS<public>:int = 2
    SLOT_FEET<public>:int = 3
    SLOT_MAIN_HAND<public>:int = 4
    SLOT_OFF_HAND<public>:int = 5
    SLOT_ACCESSORY_1<public>:int = 6
    SLOT_ACCESSORY_2<public>:int = 7
    
    # 装备类型
    EQUIPMENT_TYPE_ONE_HAND<public>:int = 0
    EQUIPMENT_TYPE_TWO_HAND<public>:int = 1
    EQUIPMENT_TYPE_SHIELD<public>:int = 2
    EQUIPMENT_TYPE_DUAL_WIELD<public>:int = 3
    
    # ========== 数据结构 ==========
    
    # 装备信息
    equipment_info<public> := struct<computes>:
        ItemID<public>:int = 0
        SlotType<public>:int = 0
        EquipmentType<public>:int = 0
        RequiredLevel<public>:int = 1
        RequiredClass<public>:int = -1          # -1表示无职业限制
    
    # 套装信息
    item_set_info<public> := struct<computes>:
        SetID<public>:int = 0
        EquippedPieces<public>:int = 0
        TotalPieces<public>:int = 0
        ActiveBonuses<public>:[]int = array{}
    
    # ========== 装备验证 ==========
    
    # 检查槽位兼容性
    CheckSlotCompatible<public>(Equipment:equipment_info, TargetSlot:int)<decides><transacts>:void =
        Equipment.SlotType = TargetSlot
    
    # 检查双手武器冲突
    CheckTwoHandConflict<public>(MainHandType:int, OffHandEquipped:logic)<decides><transacts>:void =
        if (MainHandType = EQUIPMENT_TYPE_TWO_HAND):
            not OffHandEquipped
        else:
            true
    
    # 检查等级需求
    CheckLevelRequirement<public>(Equipment:equipment_info, PlayerLevel:int)<decides><transacts>:void =
        PlayerLevel >= Equipment.RequiredLevel
    
    # 检查职业需求
    CheckClassRequirement<public>(Equipment:equipment_info, PlayerClass:int)<decides><transacts>:void =
        if (Equipment.RequiredClass < 0):
            true  # 无职业限制
        else:
            Equipment.RequiredClass = PlayerClass
    
    # 综合检查能否装备
    CheckCanEquip<public>(Equipment:equipment_info, PlayerLevel:int, PlayerClass:int, OffHandEquipped:logic)<decides><transacts>:void =
        LevelOK := if (CheckLevelRequirement[Equipment, PlayerLevel]) then true else false
        ClassOK := if (CheckClassRequirement[Equipment, PlayerClass]) then true else false
        TwoHandOK := if (CheckTwoHandConflict[Equipment.EquipmentType, OffHandEquipped]) then true else false
        if (LevelOK and ClassOK and TwoHandOK) then true else false
    
    # ========== 套装效果 ==========
    
    # 检查套装件数激活的奖励
    GetActiveSetBonuses<public>(EquippedCount:int)<transacts>:[]int =
        var Bonuses:[]int = array{}
        if (EquippedCount >= 2):
            set Bonuses += array{1}  # 2件套效果
        if (EquippedCount >= 4):
            set Bonuses += array{2}  # 4件套效果
        if (EquippedCount >= 6):
            set Bonuses += array{3}  # 6件套效果
        Bonuses
    
    # 计算套装装备件数
    CalculateSetPiecesEquipped<public>(EquippedItems:[]int, SetID:int, SetItemIDs:[]int)<computes>:int =
        var Count:int = 0
        for (ItemID : EquippedItems):
            for (SetItemID : SetItemIDs):
                if (ItemID = SetItemID):
                    set Count += 1
                    break
        Count
    
    # ========== 工具函数 ==========
    
    # 创建装备信息
    MakeEquipmentInfo<public>(ItemID:int, Slot:int, Type:int, ReqLevel:int)<transacts>:equipment_info =
        equipment_info{
            ItemID := ItemID
            SlotType := Slot
            EquipmentType := Type
            RequiredLevel := ReqLevel
            RequiredClass := -1
        }
    
    # 创建套装信息
    MakeItemSetInfo<public>(SetID:int, Total:int)<transacts>:item_set_info =
        item_set_info{
            SetID := SetID
            EquippedPieces := 0
            TotalPieces := Total
            ActiveBonuses := array{}
        }
