# InventoryComponent - 库存管理组件
# 版本: 1.0
# 添加时间: 2025-12-27
# 来源: REQ-011 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 物品信息
item_info<public> := struct:
    ItemId<public>:string
    DisplayName<public>:string
    Quantity<public>:int
    MaxStack<public>:int
    Metadata<public>:string  # JSON格式附加数据

# 物品添加事件
item_added_event<public> := class<concrete>(scene_event):
    var Owner<public>:?entity = false
    var ItemId<public>:string = ""
    var Quantity<public>:int = 0
    var NewTotal<public>:int = 0

# 物品移除事件
item_removed_event<public> := class<concrete>(scene_event):
    var Owner<public>:?entity = false
    var ItemId<public>:string = ""
    var Quantity<public>:int = 0
    var Remaining<public>:int = 0

# 物品使用事件
item_used_event<public> := class<concrete>(scene_event):
    var Owner<public>:?entity = false
    var ItemId<public>:string = ""
    var Remaining<public>:int = 0

# 库存满事件
inventory_full_event<public> := class<concrete>(scene_event):
    var Owner<public>:?entity = false
    var AttemptedItemId<public>:string = ""

# 库存槽位
inventory_slot<public> := struct:
    SlotIndex<public>:int
    ItemId<public>:string
    Quantity<public>:int
    IsLocked<public>:logic

# 库存组件
inventory_component<public> := class(component):
    # 可编辑属性
    @editable 
    var MaxSlots<public>:int = 20
    @editable 
    var MaxStackSize<public>:int = 99
    @editable 
    var AllowDuplicates<public>:logic = true  # 是否允许相同物品占用多个槽位
    
    # 运行时状态
    var Slots<private>:[]inventory_slot = array{}
    var ItemRegistry<private>:[string]item_info = map{}
    
    # ==========================================
    # 初始化
    # ==========================================
    
    # 初始化库存
    Initialize<public>():void =
        set Slots = array{}
        for (I := 0..MaxSlots - 1):
            set Slots += array{inventory_slot{
                SlotIndex := I,
                ItemId := "",
                Quantity := 0,
                IsLocked := false
            }}
    
    # 注册物品定义
    RegisterItem<public>(Info:item_info):void =
        if set ItemRegistry[Info.ItemId] = Info: {}
    
    # ==========================================
    # 物品操作
    # ==========================================
    
    # 添加物品
    AddItem<public>(ItemId:string, Amount:int):int =
        if Amount <= 0:
            return 0
        
        RemainingAmount := Amount
        
        # 首先尝试堆叠到现有槽位
        for (I -> Slot in Slots):
            if Slot.ItemId = ItemId and not Slot.IsLocked:
                MaxCanAdd := GetMaxStackForItem(ItemId) - Slot.Quantity
                ToAdd := Min(RemainingAmount, MaxCanAdd)
                
                if ToAdd > 0:
                    UpdateSlotQuantity(I, Slot.Quantity + ToAdd)
                    set RemainingAmount -= ToAdd
                
                if RemainingAmount <= 0:
                    break
        
        # 然后使用空槽位
        if RemainingAmount > 0 and (AllowDuplicates or not HasItem(ItemId)):
            for (I -> Slot in Slots):
                if Slot.ItemId = "" and not Slot.IsLocked:
                    ToAdd := Min(RemainingAmount, GetMaxStackForItem(ItemId))
                    SetSlot(I, ItemId, ToAdd)
                    set RemainingAmount -= ToAdd
                    
                    if RemainingAmount <= 0:
                        break
        
        Added := Amount - RemainingAmount
        
        if Added > 0:
            if (Owner := GetOwner()):
                Owner.SendUp(item_added_event{
                    Owner := option{Owner},
                    ItemId := ItemId,
                    Quantity := Added,
                    NewTotal := GetItemCount(ItemId)
                })
        
        if RemainingAmount > 0:
            if (Owner := GetOwner()):
                Owner.SendUp(inventory_full_event{
                    Owner := option{Owner},
                    AttemptedItemId := ItemId
                })
        
        return Added
    
    # 移除物品
    RemoveItem<public>(ItemId:string, Amount:int):int =
        if Amount <= 0:
            return 0
        
        RemainingToRemove := Amount
        
        # 从后往前移除（保护前面的槽位）
        for (I := Slots.Length - 1..0, -1):
            if (Slot := Slots[I]):
                if Slot.ItemId = ItemId and not Slot.IsLocked:
                    ToRemove := Min(RemainingToRemove, Slot.Quantity)
                    NewQuantity := Slot.Quantity - ToRemove
                    
                    if NewQuantity <= 0:
                        ClearSlot(I)
                    else:
                        UpdateSlotQuantity(I, NewQuantity)
                    
                    set RemainingToRemove -= ToRemove
                    
                    if RemainingToRemove <= 0:
                        break
        
        Removed := Amount - RemainingToRemove
        
        if Removed > 0:
            if (Owner := GetOwner()):
                Owner.SendUp(item_removed_event{
                    Owner := option{Owner},
                    ItemId := ItemId,
                    Quantity := Removed,
                    Remaining := GetItemCount(ItemId)
                })
        
        return Removed
    
    # 使用物品（移除1个并发送使用事件）
    UseItem<public>(ItemId:string):logic =
        if GetItemCount(ItemId) <= 0:
            return false
        
        RemoveItem(ItemId, 1)
        
        if (Owner := GetOwner()):
            Owner.SendUp(item_used_event{
                Owner := option{Owner},
                ItemId := ItemId,
                Remaining := GetItemCount(ItemId)
            })
        
        return true
    
    # 转移物品到另一个库存
    TransferItem<public>(ItemId:string, Amount:int, Target:inventory_component):int =
        Available := Min(Amount, GetItemCount(ItemId))
        Transferred := Target.AddItem(ItemId, Available)
        RemoveItem(ItemId, Transferred)
        return Transferred
    
    # ==========================================
    # 槽位操作
    # ==========================================
    
    # 设置槽位内容
    SetSlot<private>(Index:int, ItemId:string, Quantity:int):void =
        if Index >= 0 and Index < Slots.Length:
            if (OldSlot := Slots[Index]):
                NewSlots:[]inventory_slot = array{}
                for (I -> S in Slots):
                    if I = Index:
                        set NewSlots += array{inventory_slot{
                            SlotIndex := Index,
                            ItemId := ItemId,
                            Quantity := Quantity,
                            IsLocked := OldSlot.IsLocked
                        }}
                    else:
                        set NewSlots += array{S}
                set Slots = NewSlots
    
    # 更新槽位数量
    UpdateSlotQuantity<private>(Index:int, NewQuantity:int):void =
        if (Slot := Slots[Index]):
            SetSlot(Index, Slot.ItemId, NewQuantity)
    
    # 清空槽位
    ClearSlot<public>(Index:int):void =
        SetSlot(Index, "", 0)
    
    # 锁定槽位
    LockSlot<public>(Index:int):void =
        if Index >= 0 and Index < Slots.Length:
            if (Slot := Slots[Index]):
                NewSlots:[]inventory_slot = array{}
                for (I -> S in Slots):
                    if I = Index:
                        set NewSlots += array{inventory_slot{
                            SlotIndex := Index,
                            ItemId := Slot.ItemId,
                            Quantity := Slot.Quantity,
                            IsLocked := true
                        }}
                    else:
                        set NewSlots += array{S}
                set Slots = NewSlots
    
    # 解锁槽位
    UnlockSlot<public>(Index:int):void =
        if Index >= 0 and Index < Slots.Length:
            if (Slot := Slots[Index]):
                NewSlots:[]inventory_slot = array{}
                for (I -> S in Slots):
                    if I = Index:
                        set NewSlots += array{inventory_slot{
                            SlotIndex := Index,
                            ItemId := Slot.ItemId,
                            Quantity := Slot.Quantity,
                            IsLocked := false
                        }}
                    else:
                        set NewSlots += array{S}
                set Slots = NewSlots
    
    # 交换两个槽位
    SwapSlots<public>(IndexA:int, IndexB:int):void =
        if IndexA < 0 or IndexA >= Slots.Length:
            return
        if IndexB < 0 or IndexB >= Slots.Length:
            return
        
        if (SlotA := Slots[IndexA]):
            if (SlotB := Slots[IndexB]):
                if SlotA.IsLocked or SlotB.IsLocked:
                    return
                
                SetSlot(IndexA, SlotB.ItemId, SlotB.Quantity)
                SetSlot(IndexB, SlotA.ItemId, SlotA.Quantity)
    
    # ==========================================
    # 查询方法
    # ==========================================
    
    # 获取物品总数量
    GetItemCount<public>(ItemId:string):int =
        Total := 0
        for (Slot in Slots):
            if Slot.ItemId = ItemId:
                set Total += Slot.Quantity
        return Total
    
    # 检查是否拥有物品
    HasItem<public>(ItemId:string):logic =
        return GetItemCount(ItemId) > 0
    
    # 检查是否拥有足够数量
    HasItemAmount<public>(ItemId:string, Amount:int):logic =
        return GetItemCount(ItemId) >= Amount
    
    # 获取空槽位数量
    GetEmptySlotCount<public>():int =
        Count := 0
        for (Slot in Slots):
            if Slot.ItemId = "" and not Slot.IsLocked:
                set Count += 1
        return Count
    
    # 检查库存是否已满
    IsFull<public>():logic =
        return GetEmptySlotCount() = 0
    
    # 获取槽位信息
    GetSlot<public>(Index:int):?inventory_slot =
        if Index >= 0 and Index < Slots.Length:
            return option{Slots[Index]}
        return false
    
    # 获取所有非空槽位
    GetOccupiedSlots<public>():[]inventory_slot =
        Result:[]inventory_slot = array{}
        for (Slot in Slots):
            if Slot.ItemId <> "":
                set Result += array{Slot}
        return Result
    
    # 获取物品最大堆叠数
    GetMaxStackForItem<private>(ItemId:string):int =
        if (Info := ItemRegistry[ItemId]):
            if Info.MaxStack > 0:
                return Info.MaxStack
        return MaxStackSize
    
    # ==========================================
    # 批量操作
    # ==========================================
    
    # 清空所有物品
    Clear<public>():void =
        for (I := 0..Slots.Length - 1):
            if (Slot := Slots[I]):
                if not Slot.IsLocked:
                    ClearSlot(I)
    
    # 整理库存（合并相同物品）
    Organize<public>():void =
        # 收集所有物品
        Items:[string]int = map{}
        for (Slot in Slots):
            if Slot.ItemId <> "" and not Slot.IsLocked:
                Current := 0
                if (C := Items[Slot.ItemId]):
                    set Current = C
                if set Items[Slot.ItemId] = Current + Slot.Quantity: {}
        
        # 清空非锁定槽位
        for (I := 0..Slots.Length - 1):
            if (Slot := Slots[I]):
                if not Slot.IsLocked:
                    ClearSlot(I)
        
        # 重新填充
        for (ItemId -> Quantity in Items):
            AddItem(ItemId, Quantity)
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    Min<private>(A:int, B:int):int = if A < B then A else B
