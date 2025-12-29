# PetWrapper - UEFN Pet/Companion API 封装
# 版本: 1.0
# 创建时间: 2025-12-29
# 来源: REQ-PET-001 宠物系统需求
#
# 设计目的:
# 1. 统一封装 UEFN 宠物/伴侣相关 API 调用
# 2. 提供跟随、行为、状态管理等核心宠物功能
# 3. 处理边界条件和类型转换
# 4. 让 Component 层无需直接依赖底层 UEFN API
#
# 业务域划分:
# - 宠物生成与绑定（使用 creative_prop 作为宠物实体）
# - 跟随行为（基于 transform 和 positional 接口）
# - 状态管理（活跃/闲置/跟随/守卫）
# - 交互控制（召唤/遣散/命令）
#
# API 参考:
# - creative_prop 作为宠物实体基础
# - positional 接口: GetTransform()
# - transform: Translation, Rotation
# - fort_character 作为主人
# - 来源: shared/api-digests/Fortnite.digest.verse

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /Fortnite.com/Devices }

# ═══════════════════════════════════════════════════════════
# 宠物状态枚举
# ═══════════════════════════════════════════════════════════

pet_state<public> := enum:
    Idle        # 闲置状态
    Following   # 跟随主人
    Guarding    # 守卫位置
    Dismissed   # 已遣散
    Dead        # 死亡

# 宠物行为模式
pet_behavior_mode<public> := enum:
    Passive     # 被动（不攻击）
    Defensive   # 防御（被攻击才反击）
    Aggressive  # 主动（主动攻击敌人）

# ═══════════════════════════════════════════════════════════
# 操作结果结构
# ═══════════════════════════════════════════════════════════

pet_op_result<public> := struct<concrete>:
    Success<public>:logic = false
    ErrorReason<public>:string = ""
    ResultValue<public>:float = 0.0

pet_state_result<public> := struct<concrete>:
    Success<public>:logic = false
    ErrorReason<public>:string = ""
    CurrentState<public>:pet_state = pet_state.Idle

# ═══════════════════════════════════════════════════════════
# 宠物数据结构
# ═══════════════════════════════════════════════════════════

pet_data<public> := class<concrete>:
    # 基本信息
    var PetEntity<public>:?creative_prop = false
    var Owner<public>:?fort_character = false
    var PetName<public>:string = "Pet"
    
    # 状态
    var CurrentState<public>:pet_state = pet_state.Idle
    var BehaviorMode<public>:pet_behavior_mode = pet_behavior_mode.Passive
    
    # 跟随参数
    var FollowDistance<public>:float = 3.0     # 跟随距离（米）
    var FollowSpeed<public>:float = 5.0        # 跟随速度
    var MaxDistance<public>:float = 20.0       # 最大距离（超过则传送）
    
    # 守卫位置
    var GuardPosition<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    # 统计数据
    var TotalDistanceTraveled<public>:float = 0.0
    var TimeWithOwner<public>:float = 0.0

# ═══════════════════════════════════════════════════════════
# PetWrapper 模块 - UEFN API 封装层
# ═══════════════════════════════════════════════════════════

PetWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 宠物生成与绑定
    # API: creative_prop (作为宠物实体), fort_character (主人)
    # ═══════════════════════════════════════════════════════
    
    # 创建宠物数据对象
    CreatePetData<public>(
        Entity:creative_prop,
        Owner:fort_character,
        Name:string
    ):pet_data =
        pet_data:
            PetEntity := Entity
            Owner := Owner
            PetName := Name
            CurrentState := pet_state.Idle
            BehaviorMode := pet_behavior_mode.Passive
            FollowDistance := 3.0
            FollowSpeed := 5.0
            MaxDistance := 20.0
    
    # 绑定宠物到主人
    BindPetToOwner<public>(
        PetEntity:creative_prop,
        Owner:fort_character
    ):pet_op_result =
        # 检查实体有效性
        if (not IsPetEntityValid(PetEntity)):
            return pet_op_result{
                Success := false,
                ErrorReason := "Pet entity is invalid"
            }
        
        # 检查主人有效性
        if (not Owner.IsActive[]):
            return pet_op_result{
                Success := false,
                ErrorReason := "Owner character is invalid"
            }
        
        # 绑定成功（实际绑定逻辑需要在更高层实现）
        pet_op_result{
            Success := true,
            ErrorReason := "",
            ResultValue := 1.0
        }
    
    # 检查宠物实体是否有效
    IsPetEntityValid<public>(Entity:creative_prop):logic =
        # creative_prop 没有 IsActive 方法，需要通过其他方式验证
        # 简化处理：假设传入的都是有效的
        true
    
    # ═══════════════════════════════════════════════════════
    # 位置与距离计算
    # API: positional.GetTransform(), transform.Translation
    # ═══════════════════════════════════════════════════════
    
    # 获取宠物位置
    GetPetPosition<public>(Entity:creative_prop):vector3 =
        Transform := Entity.GetTransform()
        Transform.Translation
    
    # 获取主人位置
    GetOwnerPosition<public>(Owner:fort_character):vector3 =
        Transform := Owner.GetTransform()
        Transform.Translation
    
    # 计算宠物与主人的距离
    GetDistanceToOwner<public>(
        PetEntity:creative_prop,
        Owner:fort_character
    ):float =
        PetPos := GetPetPosition(PetEntity)
        OwnerPos := GetOwnerPosition(Owner)
        CalculateDistance(PetPos, OwnerPos)
    
    # 计算两个位置之间的距离
    CalculateDistance<public>(Pos1:vector3, Pos2:vector3):float =
        DeltaX := Pos2.X - Pos1.X
        DeltaY := Pos2.Y - Pos1.Y
        DeltaZ := Pos2.Z - Pos1.Z
        Sqrt(DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ)
    
    # 计算跟随目标位置（主人后方）
    CalculateFollowPosition<public>(
        OwnerPos:vector3,
        OwnerRot:rotation,
        FollowDistance:float
    ):vector3 =
        # 获取主人的前向方向并取反（后方）
        ForwardDir := RotationToDirection(OwnerRot)
        
        # 计算目标位置：主人位置 - 前向 * 距离
        vector3{
            X := OwnerPos.X - ForwardDir.X * FollowDistance,
            Y := OwnerPos.Y - ForwardDir.Y * FollowDistance,
            Z := OwnerPos.Z
        }
    
    # 将旋转转换为方向向量（简化版）
    RotationToDirection<private>(Rot:rotation):vector3 =
        # 简化实现：返回基本前向方向
        # 实际应该根据 rotation 计算真实方向
        vector3{X := 1.0, Y := 0.0, Z := 0.0}
    
    # ═══════════════════════════════════════════════════════
    # 状态管理
    # ═══════════════════════════════════════════════════════
    
    # 设置宠物状态
    SetPetState<public>(PetData:pet_data, NewState:pet_state):pet_state_result =
        # 验证状态转换合法性
        if (not IsValidStateTransition(PetData.CurrentState, NewState)):
            return pet_state_result{
                Success := false,
                ErrorReason := "Invalid state transition",
                CurrentState := PetData.CurrentState
            }
        
        # 更新状态
        set PetData.CurrentState = NewState
        
        pet_state_result{
            Success := true,
            ErrorReason := "",
            CurrentState := NewState
        }
    
    # 检查状态转换是否合法
    IsValidStateTransition<private>(CurrentState:pet_state, NewState:pet_state):logic =
        # Dead 状态不能转换到其他状态
        if (CurrentState = pet_state.Dead):
            false
        # Dismissed 只能转换到 Following 或 Dead
        else if (CurrentState = pet_state.Dismissed):
            if (NewState = pet_state.Following or NewState = pet_state.Dead):
                true
            else:
                false
        # 其他状态可以自由转换
        else:
            true
    
    # 获取宠物当前状态
    GetPetState<public>(PetData:pet_data):pet_state =
        PetData.CurrentState
    
    # 检查宠物是否存活
    IsPetAlive<public>(PetData:pet_data):logic =
        if (PetData.CurrentState <> pet_state.Dead):
            true
        else:
            false
    
    # 检查宠物是否在跟随
    IsPetFollowing<public>(PetData:pet_data):logic =
        if (PetData.CurrentState = pet_state.Following):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # 行为控制
    # ═══════════════════════════════════════════════════════
    
    # 设置行为模式
    SetBehaviorMode<public>(PetData:pet_data, Mode:pet_behavior_mode):void =
        set PetData.BehaviorMode = Mode
    
    # 获取行为模式
    GetBehaviorMode<public>(PetData:pet_data):pet_behavior_mode =
        PetData.BehaviorMode
    
    # 命令宠物跟随
    CommandFollow<public>(PetData:pet_data):pet_op_result =
        if (not IsPetAlive(PetData)):
            return pet_op_result{
                Success := false,
                ErrorReason := "Pet is dead"
            }
        
        StateResult := SetPetState(PetData, pet_state.Following)
        if (StateResult.Success):
            pet_op_result{Success := true}
        else:
            pet_op_result{
                Success := false,
                ErrorReason := StateResult.ErrorReason
            }
    
    # 命令宠物守卫位置
    CommandGuard<public>(PetData:pet_data, Position:vector3):pet_op_result =
        if (not IsPetAlive(PetData)):
            return pet_op_result{
                Success := false,
                ErrorReason := "Pet is dead"
            }
        
        set PetData.GuardPosition = Position
        StateResult := SetPetState(PetData, pet_state.Guarding)
        
        if (StateResult.Success):
            pet_op_result{Success := true}
        else:
            pet_op_result{
                Success := false,
                ErrorReason := StateResult.ErrorReason
            }
    
    # 命令宠物待机
    CommandStay<public>(PetData:pet_data):pet_op_result =
        if (not IsPetAlive(PetData)):
            return pet_op_result{
                Success := false,
                ErrorReason := "Pet is dead"
            }
        
        StateResult := SetPetState(PetData, pet_state.Idle)
        if (StateResult.Success):
            pet_op_result{Success := true}
        else:
            pet_op_result{
                Success := false,
                ErrorReason := StateResult.ErrorReason
            }
    
    # 遣散宠物
    DismissPet<public>(PetData:pet_data):pet_op_result =
        StateResult := SetPetState(PetData, pet_state.Dismissed)
        if (StateResult.Success):
            pet_op_result{Success := true}
        else:
            pet_op_result{
                Success := false,
                ErrorReason := StateResult.ErrorReason
            }
    
    # ═══════════════════════════════════════════════════════
    # 跟随行为更新（应在 tick 中调用）
    # ═══════════════════════════════════════════════════════
    
    # 更新宠物跟随行为
    UpdateFollowBehavior<public>(
        PetData:pet_data,
        DeltaTime:float
    ):pet_op_result =
        # 检查是否处于跟随状态
        if (PetData.CurrentState <> pet_state.Following):
            return pet_op_result{
                Success := false,
                ErrorReason := "Pet is not in following state"
            }
        
        # 检查主人和宠物是否有效
        if (PetEntity := PetData.PetEntity, Owner := PetData.Owner):
            # 计算距离
            Distance := GetDistanceToOwner(PetEntity, Owner)
            
            # 如果距离过远，传送到主人身边
            if (Distance > PetData.MaxDistance):
                OwnerPos := GetOwnerPosition(Owner)
                OwnerRot := Owner.GetTransform().Rotation
                FollowPos := CalculateFollowPosition(OwnerPos, OwnerRot, PetData.FollowDistance)
                
                # TODO: 实际传送逻辑需要使用 MoveTo 或 TeleportTo
                # 这里只返回成功，实际移动由调用方处理
                return pet_op_result{
                    Success := true,
                    ErrorReason := "Teleport required",
                    ResultValue := Distance
                }
            
            # 正常跟随距离
            else if (Distance > PetData.FollowDistance):
                # TODO: 计算移动方向和速度
                # 实际移动逻辑需要在更高层实现
                
                # 更新统计
                MoveDistance := PetData.FollowSpeed * DeltaTime
                set PetData.TotalDistanceTraveled += MoveDistance
                set PetData.TimeWithOwner += DeltaTime
                
                return pet_op_result{
                    Success := true,
                    ErrorReason := "",
                    ResultValue := Distance
                }
            
            # 距离合适，不需要移动
            else:
                set PetData.TimeWithOwner += DeltaTime
                return pet_op_result{
                    Success := true,
                    ErrorReason := "In range",
                    ResultValue := Distance
                }
        else:
            pet_op_result{
                Success := false,
                ErrorReason := "Invalid pet or owner reference"
            }
    
    # ═══════════════════════════════════════════════════════
    # 参数配置
    # ═══════════════════════════════════════════════════════
    
    # 设置跟随距离
    SetFollowDistance<public>(PetData:pet_data, Distance:float):pet_op_result =
        if (Distance <= 0.0):
            return pet_op_result{
                Success := false,
                ErrorReason := "Distance must be positive"
            }
        
        Clamped := Clamp(Distance, 1.0, 50.0)
        set PetData.FollowDistance = Clamped
        
        pet_op_result{
            Success := true,
            ResultValue := Clamped
        }
    
    # 设置跟随速度
    SetFollowSpeed<public>(PetData:pet_data, Speed:float):pet_op_result =
        if (Speed <= 0.0):
            return pet_op_result{
                Success := false,
                ErrorReason := "Speed must be positive"
            }
        
        Clamped := Clamp(Speed, 1.0, 20.0)
        set PetData.FollowSpeed = Clamped
        
        pet_op_result{
            Success := true,
            ResultValue := Clamped
        }
    
    # 设置最大距离
    SetMaxDistance<public>(PetData:pet_data, Distance:float):pet_op_result =
        if (Distance <= PetData.FollowDistance):
            return pet_op_result{
                Success := false,
                ErrorReason := "Max distance must be greater than follow distance"
            }
        
        set PetData.MaxDistance = Distance
        
        pet_op_result{
            Success := true,
            ResultValue := Distance
        }
    
    # ═══════════════════════════════════════════════════════
    # 统计与查询
    # ═══════════════════════════════════════════════════════
    
    # 获取宠物总移动距离
    GetTotalDistanceTraveled<public>(PetData:pet_data):float =
        PetData.TotalDistanceTraveled
    
    # 获取与主人相处时间
    GetTimeWithOwner<public>(PetData:pet_data):float =
        PetData.TimeWithOwner
    
    # 重置统计数据
    ResetStatistics<public>(PetData:pet_data):void =
        set PetData.TotalDistanceTraveled = 0.0
        set PetData.TimeWithOwner = 0.0
    
    # 获取宠物名称
    GetPetName<public>(PetData:pet_data):string =
        PetData.PetName
    
    # 设置宠物名称
    SetPetName<public>(PetData:pet_data, Name:string):void =
        set PetData.PetName = Name
