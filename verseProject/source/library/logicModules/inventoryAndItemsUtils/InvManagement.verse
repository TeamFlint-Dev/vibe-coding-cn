# 库存管理模块
# 功能：背包已满判定、自动堆叠逻辑

using { /Verse.org/Simulation }

InvManagement<public> := module:
    
    # ========== 数据结构 ==========
    
    # 物品槽
    item_slot<public> := struct<computes>:
        ItemID<public>:int = 0                  # 0表示空槽位
        Quantity<public>:int = 0
        MaxStack<public>:int = 1
    
    # 背包信息
    inventory_info<public> := struct<computes>:
        TotalSlots<public>:int = 20
        UsedSlots<public>:int = 0
        EmptySlots<public>:int = 20
    
    # ========== 常量定义 ==========
    
    DEFAULT_MAX_STACK<public>:int = 99
    
    # ========== 背包查询 ==========
    
    # 检查背包是否已满
    CheckInventoryFull<public>(Info:inventory_info)<decides><transacts>:void =
        Info.EmptySlots <= 0
    
    # 检查是否有足够空位
    CheckHasSpace<public>(Info:inventory_info, RequiredSlots:int)<decides><transacts>:void =
        Info.EmptySlots >= RequiredSlots
    
    # 计算背包使用率
    GetInventoryUsage<public>(Info:inventory_info)<computes>:float =
        if (Info.TotalSlots <= 0):
            1.0
        else:
            Floor(Info.UsedSlots) / Floor(Info.TotalSlots)
    
    # ========== 堆叠逻辑 ==========
    
    # 检查物品是否可堆叠
    CheckCanStack<public>(Slot:item_slot)<decides><transacts>:void =
        Slot.MaxStack > 1
    
    # 检查槽位是否已满
    CheckSlotFull<public>(Slot:item_slot)<decides><transacts>:void =
        Slot.Quantity >= Slot.MaxStack
    
    # 计算可添加数量
    CalculateAddableAmount<public>(Slot:item_slot, AmountToAdd:int)<computes>:int =
        RemainingSpace := Slot.MaxStack - Slot.Quantity
        Min(AmountToAdd, RemainingSpace)
    
    # 添加物品到槽位（返回剩余数量）
    AddToSlot<public>(Slot:item_slot, Amount:int)<transacts>:tuple(item_slot, int) =
        CanAdd := CalculateAddableAmount(Slot, Amount)
        NewQuantity := Slot.Quantity + CanAdd
        Remaining := Amount - CanAdd
        
        NewSlot := item_slot{
            ItemID := Slot.ItemID
            Quantity := NewQuantity
            MaxStack := Slot.MaxStack
        }
        
        (NewSlot, Remaining)
    
    # 从槽位移除物品
    RemoveFromSlot<public>(Slot:item_slot, Amount:int)<transacts>:item_slot =
        NewQuantity := Max(Slot.Quantity - Amount, 0)
        item_slot{
            ItemID := if (NewQuantity = 0) then 0 else Slot.ItemID
            Quantity := NewQuantity
            MaxStack := Slot.MaxStack
        }
    
    # ========== 工具函数 ==========
    
    # 创建物品槽
    MakeItemSlot<public>(ItemID:int, Qty:int, MaxStack:int)<transacts>:item_slot =
        item_slot{
            ItemID := ItemID
            Quantity := Qty
            MaxStack := MaxStack
        }
    
    # 创建空槽位
    MakeEmptySlot<public>()<transacts>:item_slot =
        item_slot{
            ItemID := 0
            Quantity := 0
            MaxStack := 1
        }
    
    # 创建背包信息
    MakeInventoryInfo<public>(TotalSlots:int)<transacts>:inventory_info =
        inventory_info{
            TotalSlots := TotalSlots
            UsedSlots := 0
            EmptySlots := TotalSlots
        }
