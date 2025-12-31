# InventoryComponent - 库存管理组件
# 版本: 1.2
# 添加时间: 2025-12-27
# 更新: 修复 Verse 语法错误
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
    OwnerEntity<public>:?entity = false
    ItemId<public>:string = ""
    Quantity<public>:int = 0
    NewTotal<public>:int = 0

# 物品移除事件
item_removed_event<public> := class<concrete>(scene_event):
    OwnerEntity<public>:?entity = false
    ItemId<public>:string = ""
    Quantity<public>:int = 0
    Remaining<public>:int = 0

# 物品使用事件
item_used_event<public> := class<concrete>(scene_event):
    OwnerEntity<public>:?entity = false
    ItemId<public>:string = ""
    Remaining<public>:int = 0

# 库存满事件
inventory_full_event<public> := class<concrete>(scene_event):
    OwnerEntity<public>:?entity = false
    AttemptedItemId<public>:string = ""

# 库存槽位
inventory_slot<public> := struct:
    SlotIndex<public>:int
    ItemId<public>:string
    Quantity<public>:int
    IsLocked<public>:logic

# 库存组件
inventory_component<public> := class<final_super>(component):
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
        if (set ItemRegistry[Info.ItemId] = Info) {}
    
    # ==========================================
    # 物品操作
    # ==========================================
    
    # 添加物品
    AddItem<public>(ItemId:string, Amount:int):int =
        if (Amount <= 0):
            0
        else:
            var RemainingAmount:int = Amount
            
            # 首先尝试堆叠到现有槽位
            for (I -> Slot : Slots):
                if (Slot.ItemId = ItemId, not Slot.IsLocked?):
                    MaxCanAdd := GetMaxStackForItem(ItemId) - Slot.Quantity
                    ToAdd := if (RemainingAmount < MaxCanAdd) then RemainingAmount else MaxCanAdd
                    
                    if (ToAdd > 0):
                        UpdateSlotQuantity(I, Slot.Quantity + ToAdd)
                        set RemainingAmount -= ToAdd
            
            # 然后使用空槽位（如果允许重复或还没有该物品）
            AlreadyHasItem := HasItemDirect(ItemId)
            CanUseEmpty := if (AllowDuplicates?):
                true
            else if (AlreadyHasItem?):
                false
            else:
                true
            
            if (RemainingAmount > 0, CanUseEmpty):
                for (I -> Slot : Slots):
                    if (Slot.ItemId = "", not Slot.IsLocked?):
                        MaxForItem := GetMaxStackForItem(ItemId)
                        ToAdd := if (RemainingAmount < MaxForItem) then RemainingAmount else MaxForItem
                        SetSlot(I, ItemId, ToAdd)
                        set RemainingAmount -= ToAdd
            
            Added := Amount - RemainingAmount
            
            if (Added > 0):
                OwnerEntity := Self.Entity
                OwnerEntity.SendUp(item_added_event{
                    OwnerEntity := option{OwnerEntity},
                    ItemId := ItemId,
                    Quantity := Added,
                    NewTotal := GetItemCount(ItemId)
                })
            
            if (RemainingAmount > 0):
                OwnerEntity := Self.Entity
                OwnerEntity.SendUp(inventory_full_event{
                    OwnerEntity := option{OwnerEntity},
                    AttemptedItemId := ItemId
                })
            
            Added
    
    # 移除物品
    RemoveItem<public>(ItemId:string, Amount:int):int =
        if (Amount <= 0):
            0
        else:
            var RemainingToRemove:int = Amount
            
            # 从后往前移除（保护前面的槽位）
            for (I := Slots.Length - 1..0):
                if (Slot := Slots[I]):
                    if (Slot.ItemId = ItemId, not Slot.IsLocked?):
                        ToRemove := if (RemainingToRemove < Slot.Quantity) then RemainingToRemove else Slot.Quantity
                        NewQuantity := Slot.Quantity - ToRemove
                        
                        if (NewQuantity <= 0):
                            ClearSlot(I)
                        else:
                            UpdateSlotQuantity(I, NewQuantity)
                        
                        set RemainingToRemove -= ToRemove
            
            Removed := Amount - RemainingToRemove
            
            if (Removed > 0):
                OwnerEntity := Self.Entity
                OwnerEntity.SendUp(item_removed_event{
                    OwnerEntity := option{OwnerEntity},
                    ItemId := ItemId,
                    Quantity := Removed,
                    Remaining := GetItemCount(ItemId)
                })
            
            Removed
    
    # 使用物品（移除1个并发送使用事件）
    UseItem<public>(ItemId:string):logic =
        Count := GetItemCount(ItemId)
        if (Count <= 0):
            false
        else:
            RemoveItem(ItemId, 1)
            
            OwnerEntity := Self.Entity
            OwnerEntity.SendUp(item_used_event{
                OwnerEntity := option{OwnerEntity},
                ItemId := ItemId,
                Remaining := GetItemCount(ItemId)
            })
            
            true
    
    # 转移物品到另一个库存
    TransferItem<public>(ItemId:string, Amount:int, TargetInv:inventory_component):int =
        Available := Min(Amount, GetItemCount(ItemId))
        Transferred := TargetInv.AddItem(ItemId, Available)
        RemoveItem(ItemId, Transferred)
        Transferred
    
    # ==========================================
    # 槽位操作
    # ==========================================
    
    # 设置槽位内容
    SetSlot<private>(Index:int, ItemId:string, Quantity:int):void =
        if (Index >= 0, Index < Slots.Length):
            if (OldSlot := Slots[Index]):
                var NewSlots:[]inventory_slot = array{}
                for (I -> S : Slots):
                    if (I = Index):
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
        if (Index >= 0, Index < Slots.Length):
            if (Slot := Slots[Index]):
                var NewSlots:[]inventory_slot = array{}
                for (I -> S : Slots):
                    if (I = Index):
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
        if (Index >= 0, Index < Slots.Length):
            if (Slot := Slots[Index]):
                var NewSlots:[]inventory_slot = array{}
                for (I -> S : Slots):
                    if (I = Index):
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
        if (IndexA >= 0, IndexA < Slots.Length, IndexB >= 0, IndexB < Slots.Length):
            if (SlotA := Slots[IndexA]):
                if (SlotB := Slots[IndexB]):
                    if (not SlotA.IsLocked?, not SlotB.IsLocked?):
                        SetSlot(IndexA, SlotB.ItemId, SlotB.Quantity)
                        SetSlot(IndexB, SlotA.ItemId, SlotA.Quantity)
    
    # ==========================================
    # 查询方法
    # ==========================================
    
    # 获取物品总数量
    GetItemCount<public>(ItemId:string):int =
        var Total:int = 0
        for (Slot : Slots):
            if (Slot.ItemId = ItemId):
                set Total += Slot.Quantity
        Total
    
    # 检查是否拥有物品
    HasItem<public>(ItemId:string):logic =
        Count := GetItemCount(ItemId)
        if (Count > 0):
            true
        else:
            false
    
    # 内部直接计算版本（用于条件检查）
    HasItemDirect<private>(ItemId:string):logic =
        var Found:logic = false
        for (Slot : Slots):
            if (Slot.ItemId = ItemId, Slot.Quantity > 0):
                set Found = true
        Found
    
    # 检查是否拥有足够数量
    HasItemAmount<public>(ItemId:string, Amount:int):logic =
        Count := GetItemCount(ItemId)
        if (Count >= Amount):
            true
        else:
            false
    
    # 获取空槽位数量
    GetEmptySlotCount<public>():int =
        var Count:int = 0
        for (Slot : Slots):
            if (Slot.ItemId = "", not Slot.IsLocked?):
                set Count += 1
        Count
    
    # 检查库存是否已满
    IsFull<public>():logic =
        EmptyCount := GetEmptySlotCount()
        if (EmptyCount = 0):
            true
        else:
            false
    
    # 获取槽位信息
    GetSlot<public>(Index:int):?inventory_slot =
        if (Index >= 0, Index < Slots.Length):
            if (SlotData := Slots[Index]):
                option{SlotData}
            else:
                false
        else:
            false
    
    # 获取所有非空槽位
    GetOccupiedSlots<public>():[]inventory_slot =
        var Result:[]inventory_slot = array{}
        for (Slot : Slots):
            if (Slot.ItemId <> ""):
                set Result += array{Slot}
        Result
    
    # 获取物品最大堆叠数
    GetMaxStackForItem<private>(ItemId:string):int =
        if (Info := ItemRegistry[ItemId]):
            if (Info.MaxStack > 0):
                Info.MaxStack
            else:
                MaxStackSize
        else:
            MaxStackSize
    
    # ==========================================
    # 批量操作
    # ==========================================
    
    # 清空所有物品
    Clear<public>():void =
        for (I := 0..Slots.Length - 1):
            if (Slot := Slots[I]):
                if (not Slot.IsLocked?):
                    ClearSlot(I)
    
    # 整理库存（合并相同物品）
    Organize<public>():void =
        # 收集所有物品
        var Items:[string]int = map{}
        for (Slot : Slots):
            if (Slot.ItemId <> "", not Slot.IsLocked?):
                var Current:int = 0
                if (C := Items[Slot.ItemId]):
                    set Current = C
                if (set Items[Slot.ItemId] = Current + Slot.Quantity) {}
        
        # 清空非锁定槽位
        for (I := 0..Slots.Length - 1):
            if (Slot := Slots[I]):
                if (not Slot.IsLocked?):
                    ClearSlot(I)
        
        # 重新填充
        for (ItemId -> Quantity : Items):
            AddItem(ItemId, Quantity)

