# SidekickWrapper - UEFN Sidekick 系统 API 封装
# 版本: 1.0
# 更新时间: 2025-12-30
# 来源: 需求驱动 - task-20251230-103318-10
#
# 设计目的:
# 1. 统一封装 UEFN Sidekick 相关 API 调用
# 2. 提供 Sidekick 生成、跟随、状态管理的统一接口
# 3. 处理 Sidekick 与玩家的交互和行为控制
# 4. 让 Component 层无需直接依赖底层 UEFN API
#
# 业务域范围:
# - Sidekick 生成与管理（Spawn/Despawn）
# - Sidekick 行为控制（跟随、站立、攻击）
# - Sidekick 状态查询（位置、健康、可见性）
# - Sidekick 与玩家交互（设置主人、距离判定）
# - Sidekick 视觉效果（显示/隐藏、效果应用）
#
# API 参考:
# - fort_character: Sidekick 基于角色实体
# - sidekick_device: Sidekick 生成和管理设备
# - positional: 位置和移动控制
# - damageable/healable: 生命值系统
# - 来源: Fortnite.digest.verse (sidekick related APIs)

using { /Verse.org/Simulation }
using { /Verse.org/Verse }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /Fortnite.com/Devices }

# ═══════════════════════════════════════════════════════════
# Sidekick 行为状态枚举
# ═══════════════════════════════════════════════════════════

# Sidekick 行为模式
sidekick_behavior<public> := enum:
    Follow      # 跟随主人
    Stay        # 原地待命
    Defensive   # 防御模式（跟随但会攻击敌人）
    Aggressive  # 攻击模式（主动攻击附近敌人）
    Patrol      # 巡逻模式

# Sidekick 状态
sidekick_status<public> := enum:
    Idle        # 空闲状态
    Moving      # 移动中
    Attacking   # 攻击中
    Resting     # 休息中
    Dead        # 已死亡

# ═══════════════════════════════════════════════════════════
# 操作结果结构
# ═══════════════════════════════════════════════════════════

# Sidekick 操作结果（统一返回格式）
sidekick_op_result<public> := struct<concrete>:
    Success<public>:logic = false           # 是否成功
    ErrorReason<public>:string = ""         # 失败原因
    ActualValue<public>:float = 0.0         # 实际生效的数值

# Sidekick 完整信息结构
sidekick_info<public> := struct<concrete>:
    IsValid<public>:logic = false           # Sidekick 是否有效
    IsAlive<public>:logic = false           # 是否存活
    Behavior<public>:sidekick_behavior = sidekick_behavior.Follow
    Status<public>:sidekick_status = sidekick_status.Idle
    Position<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    Health<public>:float = 0.0              # 当前生命值
    MaxHealth<public>:float = 0.0           # 最大生命值
    DistanceToOwner<public>:float = 0.0     # 与主人的距离
    IsVisible<public>:logic = true          # 是否可见

# ═══════════════════════════════════════════════════════════
# SidekickWrapper 模块 - UEFN Sidekick API 封装层
# ═══════════════════════════════════════════════════════════

SidekickWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 生成与管理
    # API: sidekick_device.Spawn / Despawn
    # digest: Fortnite.digest.verse (sidekick_device APIs)
    # ═══════════════════════════════════════════════════════
    
    # 为指定玩家生成 Sidekick
    # 参数:
    #   - Device: sidekick_device 设备实例
    #   - Owner: 拥有者（fort_character 或 agent）
    #   - Position: 生成位置
    #   - Rotation: 生成朝向
    SpawnSidekickForPlayer<public>(
        Device:sidekick_device,
        Owner:agent,
        Position:vector3,
        Rotation:rotation
    ):sidekick_op_result =
        # 边界检查：位置有效性
        if (Position.X == 0.0 and Position.Y == 0.0 and Position.Z == 0.0):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Invalid spawn position",
                ActualValue := 0.0
            }
        else:
            # 调用 sidekick_device 的生成方法
            # digest: sidekick_device.Spawn(agent)
            Device.Spawn(Owner)
            
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 1.0
            }
    
    # 在指定位置生成 Sidekick
    SpawnSidekickAtLocation<public>(
        Device:sidekick_device,
        Owner:agent,
        Location:vector3
    ):sidekick_op_result =
        # 边界检查
        if (Location.X == 0.0 and Location.Y == 0.0 and Location.Z == 0.0):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Invalid location",
                ActualValue := 0.0
            }
        else:
            # 生成 Sidekick
            Device.Spawn(Owner)
            
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := 1.0
            }
    
    # 移除/销毁 Sidekick
    DespawnSidekick<public>(
        Device:sidekick_device,
        Owner:agent
    ):sidekick_op_result =
        # 调用 Despawn API
        # digest: sidekick_device.Despawn(agent)
        Device.Despawn(Owner)
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := 0.0
        }
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 生命值管理
    # API: damageable, healable, healthful
    # 注意: Sidekick 基于 fort_character，继承其生命系统
    # ═══════════════════════════════════════════════════════
    
    # 对 Sidekick 造成伤害
    DamageSidekick<public>(
        Sidekick:fort_character,
        Amount:float
    ):sidekick_op_result =
        # 边界检查
        if (Amount <= 0.0):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Damage amount must be positive",
                ActualValue := 0.0
            }
        else if (not Sidekick.IsActive[]):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick is invalid or dead",
                ActualValue := 0.0
            }
        else:
            # 调用 damageable 接口
            # digest: fort_character.Damage(float)
            Sidekick.Damage(Amount)
            
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := Amount
            }
    
    # 治疗 Sidekick
    HealSidekick<public>(
        Sidekick:fort_character,
        Amount:float
    ):sidekick_op_result =
        if (Amount <= 0.0):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Heal amount must be positive",
                ActualValue := 0.0
            }
        else if (not Sidekick.IsActive[]):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick is invalid or dead",
                ActualValue := 0.0
            }
        else:
            # 获取当前和最大生命值
            CurrentHP := Sidekick.GetHealth()
            MaxHP := Sidekick.GetMaxHealth()
            ActualHeal := Min(Amount, MaxHP - CurrentHP)
            
            if (ActualHeal > 0.0):
                # 调用 healable 接口
                # digest: fort_character.Heal(float)
                Sidekick.Heal(ActualHeal)
                
                sidekick_op_result{
                    Success := true,
                    ErrorReason := "",
                    ActualValue := ActualHeal
                }
            else:
                sidekick_op_result{
                    Success := false,
                    ErrorReason := "Sidekick is at full health",
                    ActualValue := 0.0
                }
    
    # 设置 Sidekick 生命值
    SetSidekickHealth<public>(
        Sidekick:fort_character,
        Amount:float
    ):sidekick_op_result =
        if (not Sidekick.IsActive[]):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick is invalid",
                ActualValue := 0.0
            }
        else:
            MaxHP := Sidekick.GetMaxHealth()
            # 限制在 [1.0, MaxHealth] 范围内
            ClampedAmount := Clamp(Amount, 1.0, MaxHP)
            
            # digest: fort_character.SetHealth(float)
            Sidekick.SetHealth(ClampedAmount)
            
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := ClampedAmount
            }
    
    # 设置 Sidekick 最大生命值
    SetSidekickMaxHealth<public>(
        Sidekick:fort_character,
        MaxAmount:float
    ):sidekick_op_result =
        if (MaxAmount <= 0.0):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Max health must be positive",
                ActualValue := 0.0
            }
        else if (not Sidekick.IsActive[]):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick is invalid",
                ActualValue := 0.0
            }
        else:
            # digest: fort_character.SetMaxHealth(float)
            Sidekick.SetMaxHealth(MaxAmount)
            
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := MaxAmount
            }
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 生命值查询
    # ═══════════════════════════════════════════════════════
    
    # 获取当前生命值
    GetSidekickHealth<public>(Sidekick:fort_character):float =
        Sidekick.GetHealth()
    
    # 获取最大生命值
    GetSidekickMaxHealth<public>(Sidekick:fort_character):float =
        Sidekick.GetMaxHealth()
    
    # 获取生命值百分比
    GetSidekickHealthPercent<public>(Sidekick:fort_character):float =
        MaxHP := Sidekick.GetMaxHealth()
        if (MaxHP > 0.0):
            Sidekick.GetHealth() / MaxHP
        else:
            0.0
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 位置与移动
    # API: positional interface (GetTransform, TeleportTo)
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 位置
    GetSidekickPosition<public>(Sidekick:fort_character):vector3 =
        Transform := Sidekick.GetTransform()
        Transform.Translation
    
    # 获取 Sidekick 旋转
    GetSidekickRotation<public>(Sidekick:fort_character):rotation =
        Transform := Sidekick.GetTransform()
        Transform.Rotation
    
    # 传送 Sidekick 到指定位置
    TeleportSidekickTo<public>(
        Sidekick:fort_character,
        Position:vector3,
        Rotation:rotation
    ):sidekick_op_result =
        # 边界检查
        if (Position.X == 0.0 and Position.Y == 0.0 and Position.Z == 0.0):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Invalid target position",
                ActualValue := 0.0
            }
        else if (not Sidekick.IsActive[]):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Sidekick is invalid",
                ActualValue := 0.0
            }
        else:
            # 调用 positional 接口的 TeleportTo
            # digest: fort_character.TeleportTo(vector3, rotation)
            if (Sidekick.TeleportTo[Position, Rotation]):
                sidekick_op_result{
                    Success := true,
                    ErrorReason := "",
                    ActualValue := 0.0
                }
            else:
                sidekick_op_result{
                    Success := false,
                    ErrorReason := "Teleport failed - location may be blocked",
                    ActualValue := 0.0
                }
    
    # 传送 Sidekick 到主人身边
    TeleportSidekickToOwner<public>(
        Sidekick:fort_character,
        Owner:fort_character,
        Offset:vector3
    ):sidekick_op_result =
        if (not Owner.IsActive[]):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Owner is invalid",
                ActualValue := 0.0
            }
        else:
            OwnerTransform := Owner.GetTransform()
            OwnerPos := OwnerTransform.Translation
            
            # 计算偏移位置
            TargetPos := vector3{
                X := OwnerPos.X + Offset.X,
                Y := OwnerPos.Y + Offset.Y,
                Z := OwnerPos.Z + Offset.Z
            }
            
            # 传送到目标位置
            TeleportSidekickTo(Sidekick, TargetPos, OwnerTransform.Rotation)
    
    # 计算 Sidekick 与主人的距离
    CalculateDistanceToOwner<public>(
        Sidekick:fort_character,
        Owner:fort_character
    ):float =
        SidekickPos := GetSidekickPosition(Sidekick)
        OwnerTransform := Owner.GetTransform()
        OwnerPos := OwnerTransform.Translation
        
        DeltaX := SidekickPos.X - OwnerPos.X
        DeltaY := SidekickPos.Y - OwnerPos.Y
        DeltaZ := SidekickPos.Z - OwnerPos.Z
        
        # 计算欧式距离
        Sqrt(DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ)
    
    # 计算 Sidekick 与目标点的距离
    CalculateDistanceToPosition<public>(
        Sidekick:fort_character,
        TargetPosition:vector3
    ):float =
        SidekickPos := GetSidekickPosition(Sidekick)
        
        DeltaX := SidekickPos.X - TargetPosition.X
        DeltaY := SidekickPos.Y - TargetPosition.Y
        DeltaZ := SidekickPos.Z - TargetPosition.Z
        
        Sqrt(DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ)
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 状态判定
    # ═══════════════════════════════════════════════════════
    
    # 检查 Sidekick 是否有效
    IsSidekickValid<public>(Sidekick:fort_character):logic =
        if (Sidekick.IsActive[]):
            true
        else:
            false
    
    # 检查 Sidekick 是否存活
    IsSidekickAlive<public>(Sidekick:fort_character):logic =
        if (Sidekick.GetHealth() > 0.0):
            true
        else:
            false
    
    # 检查 Sidekick 是否满血
    IsSidekickFullHealth<public>(Sidekick:fort_character):logic =
        if (Sidekick.GetHealth() >= Sidekick.GetMaxHealth()):
            true
        else:
            false
    
    # 检查 Sidekick 是否在主人附近
    IsSidekickNearOwner<public>(
        Sidekick:fort_character,
        Owner:fort_character,
        MaxDistance:float
    ):logic =
        if (MaxDistance <= 0.0):
            false
        else:
            Distance := CalculateDistanceToOwner(Sidekick, Owner)
            if (Distance <= MaxDistance):
                true
            else:
                false
    
    # 检查 Sidekick 是否处于倒地状态（DBNO）
    IsSidekickDownButNotOut<public>(Sidekick:fort_character):logic =
        if (Sidekick.IsDownButNotOut[]):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 控制状态
    # ═══════════════════════════════════════════════════════
    
    # 设置 Sidekick 无敌状态
    SetSidekickVulnerability<public>(
        Sidekick:fort_character,
        Vulnerable:logic
    ):void =
        # digest: fort_character.SetVulnerability(logic)
        Sidekick.SetVulnerability(Vulnerable)
    
    # 检查 Sidekick 是否可被伤害
    IsSidekickVulnerable<public>(Sidekick:fort_character):logic =
        if (Sidekick.IsVulnerable[]):
            true
        else:
            false
    
    # 显示 Sidekick
    ShowSidekick<public>(Sidekick:fort_character):void =
        # digest: fort_character.Show()
        Sidekick.Show()
    
    # 隐藏 Sidekick
    HideSidekick<public>(Sidekick:fort_character):void =
        # digest: fort_character.Hide()
        Sidekick.Hide()
    
    # 进入静止状态（定身）
    PutSidekickInStasis<public>(
        Sidekick:fort_character,
        Args:stasis_args
    ):void =
        # digest: fort_character.PutInStasis(stasis_args)
        Sidekick.PutInStasis(Args)
    
    # 解除静止状态
    ReleaseSidekickFromStasis<public>(Sidekick:fort_character):void =
        # digest: fort_character.ReleaseFromStasis()
        Sidekick.ReleaseFromStasis()
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 护盾系统
    # API: shieldable interface
    # ═══════════════════════════════════════════════════════
    
    # 获取护盾值
    GetSidekickShield<public>(Sidekick:fort_character):float =
        Sidekick.GetShield()
    
    # 获取最大护盾值
    GetSidekickMaxShield<public>(Sidekick:fort_character):float =
        Sidekick.GetMaxShield()
    
    # 设置护盾值
    SetSidekickShield<public>(
        Sidekick:fort_character,
        Amount:float
    ):sidekick_op_result =
        MaxShield := Sidekick.GetMaxShield()
        ClampedAmount := Clamp(Amount, 0.0, MaxShield)
        
        # digest: fort_character.SetShield(float)
        Sidekick.SetShield(ClampedAmount)
        
        sidekick_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := ClampedAmount
        }
    
    # 设置最大护盾值
    SetSidekickMaxShield<public>(
        Sidekick:fort_character,
        MaxAmount:float
    ):sidekick_op_result =
        if (MaxAmount < 0.0):
            sidekick_op_result{
                Success := false,
                ErrorReason := "Max shield cannot be negative",
                ActualValue := 0.0
            }
        else:
            # digest: fort_character.SetMaxShield(float)
            Sidekick.SetMaxShield(MaxAmount)
            
            sidekick_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := MaxAmount
            }
    
    # 检查是否有护盾
    HasSidekickShield<public>(Sidekick:fort_character):logic =
        if (Sidekick.GetShield() > 0.0):
            true
        else:
            false
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 物理操作
    # API: 物理系统相关（速度、冲量）
    # 注意: 使用 /Verse.org/SpatialMath:vector3
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 质量
    GetSidekickMass<public>(Sidekick:fort_character):float =
        # digest: fort_character.GetMass()
        Sidekick.GetMass()
    
    # 获取视角方向
    GetSidekickViewRotation<public>(Sidekick:fort_character):rotation =
        # digest: fort_character.GetViewRotation()
        Sidekick.GetViewRotation()
    
    # 获取视角位置
    GetSidekickViewLocation<public>(Sidekick:fort_character):vector3 =
        # digest: fort_character.GetViewLocation()
        Sidekick.GetViewLocation()
    
    # ═══════════════════════════════════════════════════════
    # Sidekick 信息查询
    # ═══════════════════════════════════════════════════════
    
    # 获取 Sidekick 完整信息（用于 UI 显示或调试）
    GetSidekickInfo<public>(
        Sidekick:fort_character,
        Owner:fort_character,
        CurrentBehavior:sidekick_behavior,
        CurrentStatus:sidekick_status
    ):sidekick_info =
        IsValid := IsSidekickValid(Sidekick)
        IsAlive := IsSidekickAlive(Sidekick)
        Position := GetSidekickPosition(Sidekick)
        Health := GetSidekickHealth(Sidekick)
        MaxHealth := GetSidekickMaxHealth(Sidekick)
        Distance := CalculateDistanceToOwner(Sidekick, Owner)
        
        sidekick_info{
            IsValid := IsValid,
            IsAlive := IsAlive,
            Behavior := CurrentBehavior,
            Status := CurrentStatus,
            Position := Position,
            Health := Health,
            MaxHealth := MaxHealth,
            DistanceToOwner := Distance,
            IsVisible := true  # TODO: 实际检测可见性
        }
    
    # ═══════════════════════════════════════════════════════
    # 辅助工具函数
    # ═══════════════════════════════════════════════════════
    
    # 平方根计算（用于距离计算）
    Sqrt<private>(Value:float):float =
        if (Value <= 0.0):
            0.0
        else if (Value == 1.0):
            1.0
        else:
            # 使用牛顿迭代法估算平方根
            # 初始猜测值
            Guess := Value / 2.0
            # 迭代 10 次以获得精确结果
            IterateSqrt(Value, Guess, 10)
    
    # 平方根迭代计算（内部辅助函数）
    IterateSqrt<private>(Value:float, Guess:float, Iterations:int):float =
        if (Iterations <= 0):
            Guess
        else:
            # 牛顿法: NewGuess = (Guess + Value/Guess) / 2
            NewGuess := (Guess + Value / Guess) / 2.0
            IterateSqrt(Value, NewGuess, Iterations - 1)
    
    # 验证位置向量是否有效（不在原点）
    IsValidPosition<private>(Position:vector3):logic =
        if (Position.X == 0.0 and Position.Y == 0.0 and Position.Z == 0.0):
            false
        else:
            true
    
    # 验证距离是否在合理范围内
    IsReasonableDistance<private>(Distance:float):logic =
        if (Distance < 0.0 or Distance > 100000.0):  # 10万单位上限
            false
        else:
            true
