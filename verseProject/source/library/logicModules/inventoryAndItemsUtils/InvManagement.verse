# 背包管理模块
# 功能：背包容量判定、物品堆叠规则

using { /Verse.org/Simulation }

InvManagement<public> := module:
    
    DEFAULT_CAPACITY<public>:int = 20
    MAX_STACK_SIZE<public>:int = 99
    
    CanAddItem<public>(CurrentCount:int, Capacity:int)<decides><transacts>:void =
        CurrentCount < Capacity
    
    GetRemainingCapacity<public>(CurrentCount:int, MaxCapacity:int)<computes>:int =
        Max(MaxCapacity - CurrentCount, 0)
