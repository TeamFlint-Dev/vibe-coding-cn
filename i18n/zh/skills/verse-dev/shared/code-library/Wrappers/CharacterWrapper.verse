# CharacterWrapper - UEFN 角色 API 封装
# 版本: 2.0
# 更新时间: 2025-12-28
# 来源: API 一致性修复 (基于 Fortnite.digest.verse)
#
# 设计目的:
# 1. 统一封装 UEFN fort_character API 调用
# 2. 处理所有边界条件和错误情况
# 3. 提供类型安全的接口（使用正确的 float 类型）
# 4. 让 Component 层无需直接依赖 UEFN API
#
# API 参考:
# - fort_character 实现接口: positional, healable, healthful, damageable, shieldable
# - 来源: shared/api-digests/Fortnite.digest.verse L11777

using { /Verse.org/Simulation }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /UnrealEngine.com/Temporary/SpatialMath }

# ═══════════════════════════════════════════════════════════
# 操作结果
# ═══════════════════════════════════════════════════════════

# API 调用结果（使用 float 类型与真实 API 匹配）
character_op_result<public> := struct<concrete>:
    Success<public>:logic           # 是否成功
    ErrorReason<public>:string      # 失败原因（成功时为空）
    ActualValue<public>:float       # 实际生效的数值

# ═══════════════════════════════════════════════════════════
# CharacterWrapper 模块 - UEFN API 封装层
# ═══════════════════════════════════════════════════════════

CharacterWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 伤害操作
    # API: damageable.Damage(Amount:float):void
    # 注意: fort_character 直接实现 damageable 接口，无需 getter
    # ═══════════════════════════════════════════════════════
    
    # 对角色造成伤害
    ApplyDamage<public>(Character:fort_character, Amount:float):character_op_result =
        # 边界检查：无效输入
        if Amount <= 0.0:
            return character_op_result{
                Success := false,
                ErrorReason := "Damage amount must be positive",
                ActualValue := 0.0
            }
        
        # 检查角色是否有效/存活
        if not IsCharacterValid(Character):
            return character_op_result{
                Success := false,
                ErrorReason := "Character is invalid or dead",
                ActualValue := 0.0
            }
        
        # 直接调用 damageable 接口方法
        # fort_character 实现 damageable，可直接调用 Damage()
        Character.Damage(Amount)
        
        return character_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := Amount
        }
    
    # 带来源信息的伤害
    ApplyDamageWithArgs<public>(
        Character:fort_character, 
        Amount:float, 
        Instigator:?game_action_instigator,
        Source:?game_action_causer
    ):character_op_result =
        if Amount <= 0.0:
            return character_op_result{
                Success := false,
                ErrorReason := "Damage amount must be positive",
                ActualValue := 0.0
            }
        
        if not IsCharacterValid(Character):
            return character_op_result{
                Success := false,
                ErrorReason := "Character is invalid or dead",
                ActualValue := 0.0
            }
        
        # 使用 damage_args 结构体提供来源信息
        Character.Damage(damage_args{
            Amount := Amount,
            Instigator := Instigator,
            Source := Source
        })
        
        return character_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := Amount
        }
    
    # ═══════════════════════════════════════════════════════
    # 治疗操作
    # API: healable.Heal(Amount:float):void
    # 注意: fort_character 直接实现 healable 接口，无需 getter
    # ═══════════════════════════════════════════════════════
    
    # 治疗角色
    ApplyHeal<public>(Character:fort_character, Amount:float):character_op_result =
        if Amount <= 0.0:
            return character_op_result{
                Success := false,
                ErrorReason := "Heal amount must be positive",
                ActualValue := 0.0
            }
        
        if not IsCharacterValid(Character):
            return character_op_result{
                Success := false,
                ErrorReason := "Character is invalid or dead",
                ActualValue := 0.0
            }
        
        # 获取当前和最大生命值以计算实际治疗量
        CurrentHP := Character.GetHealth()
        MaxHP := Character.GetMaxHealth()
        ActualHeal := Min(Amount, MaxHP - CurrentHP)
        
        if ActualHeal > 0.0:
            # 直接调用 healable 接口方法
            Character.Heal(ActualHeal)
            return character_op_result{
                Success := true,
                ErrorReason := "",
                ActualValue := ActualHeal
            }
        else:
            return character_op_result{
                Success := false,
                ErrorReason := "Character is at full health",
                ActualValue := 0.0
            }
    
    # ═══════════════════════════════════════════════════════
    # 生命值操作
    # API: healthful.GetHealth/SetHealth/GetMaxHealth/SetMaxHealth
    # 注意: fort_character 直接实现 healthful 接口
    # ═══════════════════════════════════════════════════════
    
    # 设置角色生命值
    SetHealth<public>(Character:fort_character, Amount:float):character_op_result =
        if not IsCharacterValid(Character):
            return character_op_result{
                Success := false,
                ErrorReason := "Character is invalid",
                ActualValue := 0.0
            }
        
        MaxHP := Character.GetMaxHealth()
        # 注意: SetHealth 会自动 clamp 到 [1.0, MaxHealth]
        # 不能直接设置为 0，需要使用 Damage 来击杀
        ClampedAmount := Clamp(Amount, 1.0, MaxHP)
        Character.SetHealth(ClampedAmount)
        
        return character_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := ClampedAmount
        }
    
    # ═══════════════════════════════════════════════════════
    # 生命值查询
    # ═══════════════════════════════════════════════════════
    
    # 获取当前生命值
    GetHealth<public>(Character:fort_character):float =
        return Character.GetHealth()
    
    # 获取最大生命值
    GetMaxHealth<public>(Character:fort_character):float =
        return Character.GetMaxHealth()
    
    # 获取生命值百分比
    GetHealthPercent<public>(Character:fort_character):float =
        MaxHP := Character.GetMaxHealth()
        if MaxHP > 0.0:
            return Character.GetHealth() / MaxHP
        return 0.0
    
    # ═══════════════════════════════════════════════════════
    # 护盾操作
    # API: shieldable.GetShield/SetShield/GetMaxShield/SetMaxShield
    # ═══════════════════════════════════════════════════════
    
    # 获取护盾值
    GetShield<public>(Character:fort_character):float =
        return Character.GetShield()
    
    # 获取最大护盾值
    GetMaxShield<public>(Character:fort_character):float =
        return Character.GetMaxShield()
    
    # 设置护盾值
    SetShield<public>(Character:fort_character, Amount:float):character_op_result =
        MaxShield := Character.GetMaxShield()
        ClampedAmount := Clamp(Amount, 0.0, MaxShield)
        Character.SetShield(ClampedAmount)
        
        return character_op_result{
            Success := true,
            ErrorReason := "",
            ActualValue := ClampedAmount
        }
    
    # ═══════════════════════════════════════════════════════
    # 状态判定
    # ═══════════════════════════════════════════════════════
    
    # 检查角色是否有效（使用官方 IsActive 方法）
    IsCharacterValid<public>(Character:fort_character):logic =
        # 使用 fort_character.IsActive 判断角色是否在世界中且未被淘汰
        if (Character.IsActive[]):
            return true
        return false
    
    # 检查角色是否存活
    IsAlive<public>(Character:fort_character):logic =
        return Character.GetHealth() > 0.0
    
    # 检查角色是否满血
    IsFullHealth<public>(Character:fort_character):logic =
        return Character.GetHealth() >= Character.GetMaxHealth()
    
    # 检查角色是否有护盾
    HasShield<public>(Character:fort_character):logic =
        return Character.GetShield() > 0.0
    
    # 检查是否处于倒地状态（DBNO）
    IsDownButNotOut<public>(Character:fort_character):logic =
        if (Character.IsDownButNotOut[]):
            return true
        return false
    
    # ═══════════════════════════════════════════════════════
    # 位置与移动
    # API: positional.GetTransform, fort_character.TeleportTo
    # ═══════════════════════════════════════════════════════
    
    # 获取角色位置
    GetPosition<public>(Character:fort_character):vector3 =
        # 使用 positional 接口的 GetTransform 方法
        Transform := Character.GetTransform()
        return Transform.Translation
    
    # 获取角色旋转
    GetRotation<public>(Character:fort_character):rotation =
        Transform := Character.GetTransform()
        return Transform.Rotation
    
    # 传送角色
    TeleportTo<public>(Character:fort_character, Position:vector3, Rotation:rotation):logic =
        # 使用 fort_character.TeleportTo 方法
        if (Character.TeleportTo[Position, Rotation]):
            return true
        return false
    
    # 获取视角方向
    GetViewRotation<public>(Character:fort_character):rotation =
        return Character.GetViewRotation()
    
    # 获取视角位置
    GetViewLocation<public>(Character:fort_character):vector3 =
        return Character.GetViewLocation()
    
    # ═══════════════════════════════════════════════════════
    # 物理操作
    # ═══════════════════════════════════════════════════════
    
    # 获取线速度
    GetLinearVelocity<public>(Character:fort_character):(/Verse.org/SpatialMath:)vector3 =
        return Character.GetLinearVelocity()
    
    # 设置线速度
    SetLinearVelocity<public>(Character:fort_character, Velocity:(/Verse.org/SpatialMath:)vector3):void =
        Character.SetLinearVelocity(Velocity)
    
    # 施加冲量
    ApplyLinearImpulse<public>(Character:fort_character, Impulse:(/Verse.org/SpatialMath:)vector3):void =
        Character.ApplyLinearImpulse(Impulse)
    
    # 获取质量
    GetMass<public>(Character:fort_character):float =
        return Character.GetMass()
    
    # ═══════════════════════════════════════════════════════
    # 控制状态
    # ═══════════════════════════════════════════════════════
    
    # 设置无敌状态
    SetVulnerability<public>(Character:fort_character, Vulnerable:logic):void =
        Character.SetVulnerability(Vulnerable)
    
    # 检查是否可被伤害
    IsVulnerable<public>(Character:fort_character):logic =
        if (Character.IsVulnerable[]):
            return true
        return false
    
    # 显示角色
    Show<public>(Character:fort_character):void =
        Character.Show()
    
    # 隐藏角色
    Hide<public>(Character:fort_character):void =
        Character.Hide()
    
    # 进入静止状态
    PutInStasis<public>(Character:fort_character, Args:stasis_args):void =
        Character.PutInStasis(Args)
    
    # 解除静止状态
    ReleaseFromStasis<public>(Character:fort_character):void =
        Character.ReleaseFromStasis()
    
    # ═══════════════════════════════════════════════════════
    # 私有工具
    # ═══════════════════════════════════════════════════════
    
    Min<private>(A:float, B:float):float = if A < B then A else B
    Max<private>(A:float, B:float):float = if A > B then A else B
    
    Clamp<private>(Value:float, MinVal:float, MaxVal:float):float =
        if Value < MinVal then MinVal
        else if Value > MaxVal then MaxVal
        else Value
