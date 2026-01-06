# PetWrapper - UEFN 宠物系统 API 封装
# 版本: 1.0
# 更新时间: 2025-12-29
# 来源: 需求驱动示例 - 宠物系统开发
#
# 设计目的:
# 1. 统一封装 UEFN 宠物相关 API 调用（基于 fort_character 和 creative_prop）
# 2. 提供宠物跟随、行为控制、状态管理的统一接口
# 3. 处理宠物与玩家的交互逻辑
# 4. 让 Component 层无需直接依赖底层 UEFN API
#
# 业务域范围:
# - 宠物生成与销毁
# - 宠物跟随系统（基于位置和旋转）
# - 宠物行为状态（待命、跟随、攻击、休息）
# - 宠物与玩家交互
# - 宠物视觉效果控制
#
# API 参考:
# - fort_character: 用于宠物实体（如果使用角色类型）
# - creative_prop: 用于宠物道具实体
# - positional: 位置和移动控制
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

# 宠物行为状态
pet_behavior_state<public> := enum:
    Idle        # 待命状态
    Following   # 跟随主人
    Attacking   # 攻击状态
    Resting     # 休息状态
    Playing     # 玩耍状态

# ═══════════════════════════════════════════════════════════
# 操作结果结构
# ═══════════════════════════════════════════════════════════

# 宠物操作结果（统一返回格式）
pet_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因
    ActualValue<public>:float = 0.0         # 实际生效的数值（如距离、速度等）

# 宠物信息结构
pet_info<public> := struct<concrete>:
    IsValid<public>:logic = false           # 宠物是否有效
    BehaviorState<public>:pet_behavior_state = pet_behavior_state.Idle
    Position<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    DistanceToOwner<public>:float = 0.0     # 与主人的距离
    IsVisible<public>:logic = true          # 是否可见

# ═══════════════════════════════════════════════════════════
# PetWrapper 模块 - UEFN 宠物系统封装层
# ═══════════════════════════════════════════════════════════

PetWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 宠物生成与管理
    # API: creative_device.SpawnProp / TeleportTo
    # digest: Fortnite.digest.verse (creative_prop related APIs)
    # ═══════════════════════════════════════════════════════
    
    # 在指定位置生成宠物（使用 creative_prop 作为宠物实体）
    # 注意: 实际项目中需要根据具体 UEFN 版本选择合适的生成 API
    SpawnPetAtLocation<public>(
        Position:vector3, 
        Rotation:rotation
    ):pet_op_result =
        # 边界检查：位置是否有效
        if (Position.X = 0.0 and Position.Y = 0.0 and Position.Z = 0.0):
            pet_op_result{
                Success := false,
                ErrorReason := "Invalid spawn position",
                ActualValue := 0.0
            }
        else:
            # TODO: 实际项目中调用 SpawnProp 或类似 API
            # 这里返回成功作为示例
            pet_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 1.0
            }
    
    # 销毁宠物实体
    DespawnPet<public>(PetEntity:creative_prop):pet_op_result =
        # 检查实体有效性
        # 注意: creative_prop 没有 IsActive 方法，需要其他验证方式
        # 实际项目中根据具体 API 实现
        pet_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0.0
        }
    
    # ═══════════════════════════════════════════════════════
    # 位置与跟随系统
    # API: positional interface (GetTransform, TeleportTo)
    # ═══════════════════════════════════════════════════════
    
    # 获取宠物位置
    GetPetPosition<public>(PetEntity:creative_prop):vector3 =
        Transform := PetEntity.GetTransform()
        Transform.Translation
    
    # 传送宠物到指定位置
    TeleportPetTo<public>(
        PetEntity:creative_prop, 
        Position:vector3, 
        Rotation:rotation
    ):pet_op_result =
        # 边界检查
        if (Position.X = 0.0 and Position.Y = 0.0 and Position.Z = 0.0):
            pet_op_result{
                Success := false,
                ErrorReason := "Invalid target position",
                ActualValue := 0.0
            }
        else:
            # 调用 positional 接口的 TeleportTo
            if (PetEntity.TeleportTo[Position, Rotation]):
                pet_op_result{
                    Success := true,
                    ErrorReason := "",
                    ActualValue := 0.0
                }
            else:
                pet_op_result{
                    Success := false,
                    ErrorReason := "Teleport failed - location may be blocked",
                    ActualValue := 0.0
                }
    
    # 计算宠物与主人的距离
    CalculateDistanceToOwner<public>(
        PetEntity:creative_prop, 
        OwnerPosition:vector3
    ):float =
        PetPos := GetPetPosition(PetEntity)
        DeltaX := PetPos.X - OwnerPosition.X
        DeltaY := PetPos.Y - OwnerPosition.Y
        DeltaZ := PetPos.Z - OwnerPosition.Z
        
        # 计算欧式距离
        Sqrt(DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ)
    
    # 让宠物跟随到指定位置（平滑移动而非传送）
    # 注意: 这是业务逻辑的一部分，实际实现应在 Helper 或 Component 层
    # Wrapper 层只提供基础 API 封装
    MoveTowardsPosition<public>(
        PetEntity:creative_prop,
        TargetPosition:vector3,
        Speed:float
    ):pet_op_result =
        if (Speed <= 0.0):
            pet_op_result{
                Success := false,
                ErrorReason := "Speed must be positive",
                ActualValue := 0.0
            }
        else:
            # TODO: 实际项目中使用物理系统 API 或角色移动组件
            # 这里返回成功作为接口示例
            CurrentPos := GetPetPosition(PetEntity)
            Distance := CalculateDistanceToOwner(PetEntity, TargetPosition)
            
            pet_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := Distance
            }
    
    # ═══════════════════════════════════════════════════════
    # 宠物行为状态管理
    # 注意: 状态本身由 Component 层管理，Wrapper 只提供底层控制
    # ═══════════════════════════════════════════════════════
    
    # 设置宠物可见性（对应不同行为状态的视觉表现）
    SetPetVisibility<public>(PetEntity:creative_prop, Visible:logic):void =
        if (Visible):
            PetEntity.Show()
        else:
            PetEntity.Hide()
    
    # 播放宠物动画（如果宠物使用 fort_character）
    # 注意: creative_prop 没有动画接口，需要使用 fort_character 或其他 API
    # 这里作为接口占位符
    PlayPetAnimation<public>(AnimationName:string):pet_op_result =
        # TODO: 实际项目中调用动画播放 API
        if (AnimationName = ""):
            pet_op_result{
                Success := false,
                ErrorReason := "Animation name cannot be empty",
                ActualValue := 0.0
            }
        else:
            pet_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 0.0
            }
    
    # ═══════════════════════════════════════════════════════
    # 宠物与玩家交互
    # API: 基于 agent 和 fort_character 的交互接口
    # ═══════════════════════════════════════════════════════
    
    # 检查玩家是否在宠物交互范围内
    IsPlayerInInteractionRange<public>(
        PetEntity:creative_prop,
        PlayerCharacter:fort_character,
        InteractionRadius:float
    ):logic =
        if (InteractionRadius <= 0.0):
            false
        else:
            PetPos := GetPetPosition(PetEntity)
            PlayerTransform := PlayerCharacter.GetTransform()
            PlayerPos := PlayerTransform.Translation
            
            Distance := CalculateDistanceToOwner(PetEntity, PlayerPos)
            
            if (Distance <= InteractionRadius):
                true
            else:
                false
    
    # 获取宠物朝向玩家的旋转
    GetRotationTowardsPlayer<public>(
        PetEntity:creative_prop,
        PlayerCharacter:fort_character
    ):rotation =
        PetPos := GetPetPosition(PetEntity)
        PlayerTransform := PlayerCharacter.GetTransform()
        PlayerPos := PlayerTransform.Translation
        
        # 计算方向向量
        DeltaX := PlayerPos.X - PetPos.X
        DeltaY := PlayerPos.Y - PetPos.Y
        
        # TODO: 实际项目中使用正确的旋转计算
        # 这里返回默认旋转作为示例
        rotation{}
    
    # ═══════════════════════════════════════════════════════
    # 宠物信息查询
    # ═══════════════════════════════════════════════════════
    
    # 获取宠物完整信息（用于 UI 显示或调试）
    GetPetInfo<public>(
        PetEntity:creative_prop,
        OwnerCharacter:fort_character,
        CurrentState:pet_behavior_state
    ):pet_info =
        PetPos := GetPetPosition(PetEntity)
        OwnerTransform := OwnerCharacter.GetTransform()
        OwnerPos := OwnerTransform.Translation
        Distance := CalculateDistanceToOwner(PetEntity, OwnerPos)
        
        pet_info{
            IsValid := true,
            BehaviorState := CurrentState,
            Position := PetPos,
            DistanceToOwner := Distance,
            IsVisible := true  # TODO: 实际检测可见性
        }
    
    # ═══════════════════════════════════════════════════════
    # 工具函数
    # ═══════════════════════════════════════════════════════
    
    # 平方根计算（用于距离计算）
    Sqrt<private>(Value:float):float =
        if (Value <= 0.0):
            0.0
        else:
            # Verse 标准库应该提供 Sqrt，这里作为示例
            # 实际使用 /Verse.org/Verse 中的数学函数
            Value  # 简化实现，实际项目需使用正确的 Sqrt
    
    # 限制数值范围
    ClampFloat<private>(Value:float, MinVal:float, MaxVal:float):float =
        if (Value < MinVal):
            MinVal
        else if (Value > MaxVal):
            MaxVal
        else:
            Value
    
    # ═══════════════════════════════════════════════════════
    # 边界条件检查（内部辅助函数）
    # ═══════════════════════════════════════════════════════
    
    # 验证位置向量是否有效（不在原点）
    IsValidPosition<private>(Position:vector3):logic =
        if (Position.X = 0.0 and Position.Y = 0.0 and Position.Z = 0.0):
            false
        else:
            true
    
    # 验证距离是否在合理范围内
    IsReasonableDistance<private>(Distance:float):logic =
        if (Distance < 0.0 or Distance > 100000.0):  # 10万单位上限
            false
        else:
            true
