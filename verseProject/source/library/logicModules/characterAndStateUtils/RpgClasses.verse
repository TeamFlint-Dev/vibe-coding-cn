# RPG 职业系统模块
# 功能：职业相克系数、职业基础数值模板

using { /Verse.org/Simulation }

RpgClasses<public> := module:
    
    # ========== 枚举定义 ==========
    
    # 职业ID枚举（使用整数代替真正的枚举）
    CLASS_WARRIOR<public>:int = 0
    CLASS_MAGE<public>:int = 1
    CLASS_ROGUE<public>:int = 2
    CLASS_CLERIC<public>:int = 3
    CLASS_RANGER<public>:int = 4
    
    # ========== 数据结构 ==========
    
    # 职业基础数值模板
    class_template<public> := struct<computes>:
        ClassID<public>:int = 0
        ClassName<public>:string = "Unknown"
        BaseStrength<public>:float = 10.0
        BaseAgility<public>:float = 10.0
        BaseIntelligence<public>:float = 10.0
        BaseVitality<public>:float = 10.0
        BaseSpirit<public>:float = 10.0
        HealthMultiplier<public>:float = 1.0      # 生命值倍率
        ManaMultiplier<public>:float = 1.0        # 法力值倍率
        DamageMultiplier<public>:float = 1.0      # 伤害倍率
    
    # 职业相克关系
    class_counter_modifier<public> := struct<computes>:
        AttackerClass<public>:int = 0
        DefenderClass<public>:int = 0
        DamageModifier<public>:float = 1.0  # 1.0=无加成, 1.2=+20%, 0.8=-20%
    
    # ========== 职业模板定义 ==========
    
    # 战士模板：高力量、高体力
    GetWarriorTemplate<public>()<transacts>:class_template =
        class_template{
            ClassID := CLASS_WARRIOR
            ClassName := "Warrior"
            BaseStrength := 18.0
            BaseAgility := 8.0
            BaseIntelligence := 6.0
            BaseVitality := 16.0
            BaseSpirit := 7.0
            HealthMultiplier := 1.3
            ManaMultiplier := 0.7
            DamageMultiplier := 1.1
        }
    
    # 法师模板：高智力、高精神
    GetMageTemplate<public>()<transacts>:class_template =
        class_template{
            ClassID := CLASS_MAGE
            ClassName := "Mage"
            BaseStrength := 6.0
            BaseAgility := 7.0
            BaseIntelligence := 18.0
            BaseVitality := 8.0
            BaseSpirit := 16.0
            HealthMultiplier := 0.8
            ManaMultiplier := 1.5
            DamageMultiplier := 1.2
        }
    
    # 刺客模板：高敏捷
    GetRogueTemplate<public>()<transacts>:class_template =
        class_template{
            ClassID := CLASS_ROGUE
            ClassName := "Rogue"
            BaseStrength := 10.0
            BaseAgility := 18.0
            BaseIntelligence := 8.0
            BaseVitality := 10.0
            BaseSpirit := 9.0
            HealthMultiplier := 1.0
            ManaMultiplier := 0.9
            DamageMultiplier := 1.15
        }
    
    # 牧师模板：高精神、平衡属性
    GetClericTemplate<public>()<transacts>:class_template =
        class_template{
            ClassID := CLASS_CLERIC
            ClassName := "Cleric"
            BaseStrength := 8.0
            BaseAgility := 8.0
            BaseIntelligence := 14.0
            BaseVitality := 12.0
            BaseSpirit := 18.0
            HealthMultiplier := 1.1
            ManaMultiplier := 1.3
            DamageMultiplier := 0.9
        }
    
    # 游侠模板：平衡型
    GetRangerTemplate<public>()<transacts>:class_template =
        class_template{
            ClassID := CLASS_RANGER
            ClassName := "Ranger"
            BaseStrength := 12.0
            BaseAgility := 16.0
            BaseIntelligence := 10.0
            BaseVitality := 12.0
            BaseSpirit := 10.0
            HealthMultiplier := 1.1
            ManaMultiplier := 1.0
            DamageMultiplier := 1.05
        }
    
    # 根据职业ID获取模板
    GetClassTemplate<public>(ClassID:int)<transacts>:class_template =
        if (ClassID = CLASS_WARRIOR):
            GetWarriorTemplate()
        else if (ClassID = CLASS_MAGE):
            GetMageTemplate()
        else if (ClassID = CLASS_ROGUE):
            GetRogueTemplate()
        else if (ClassID = CLASS_CLERIC):
            GetClericTemplate()
        else if (ClassID = CLASS_RANGER):
            GetRangerTemplate()
        else:
            # 默认模板
            class_template{}
    
    # ========== 职业相克系数 ==========
    
    # 计算职业相克伤害系数
    # 战士 > 刺客 > 法师 > 战士（石头剪刀布）
    # 牧师和游侠无明显相克
    CalculateClassCounterModifier<public>(AttackerClass:int, DefenderClass:int)<computes>:float =
        # 战士克制刺客
        if (AttackerClass = CLASS_WARRIOR and DefenderClass = CLASS_ROGUE):
            1.2
        # 刺客克制法师
        else if (AttackerClass = CLASS_ROGUE and DefenderClass = CLASS_MAGE):
            1.2
        # 法师克制战士
        else if (AttackerClass = CLASS_MAGE and DefenderClass = CLASS_WARRIOR):
            1.2
        # 被克制的情况（减伤）
        else if (AttackerClass = CLASS_ROGUE and DefenderClass = CLASS_WARRIOR):
            0.85
        else if (AttackerClass = CLASS_MAGE and DefenderClass = CLASS_ROGUE):
            0.85
        else if (AttackerClass = CLASS_WARRIOR and DefenderClass = CLASS_MAGE):
            0.85
        # 牧师对所有职业治疗效果+10%（在治疗计算中使用）
        else if (AttackerClass = CLASS_CLERIC):
            1.0  # 治疗不受相克影响
        # 游侠对远程单位+5%伤害
        else if (AttackerClass = CLASS_RANGER and (DefenderClass = CLASS_MAGE or DefenderClass = CLASS_RANGER)):
            1.05
        else:
            1.0  # 无相克关系
    
    # 创建职业相克关系数据
    MakeClassCounter<public>(AttackerClass:int, DefenderClass:int)<transacts>:class_counter_modifier =
        class_counter_modifier{
            AttackerClass := AttackerClass
            DefenderClass := DefenderClass
            DamageModifier := CalculateClassCounterModifier(AttackerClass, DefenderClass)
        }
    
    # ========== 职业特性检查 ==========
    
    # 检查是否为物理职业（战士、刺客、游侠）
    IsPhysicalClass<public>(ClassID:int)<computes>:logic =
        if (ClassID = CLASS_WARRIOR or ClassID = CLASS_ROGUE or ClassID = CLASS_RANGER):
            true
        else:
            false
    
    # 检查是否为魔法职业（法师、牧师）
    IsMagicClass<public>(ClassID:int)<computes>:logic =
        if (ClassID = CLASS_MAGE or ClassID = CLASS_CLERIC):
            true
        else:
            false
    
    # 检查是否为治疗职业
    IsHealerClass<public>(ClassID:int)<computes>:logic =
        if (ClassID = CLASS_CLERIC):
            true
        else:
            false
    
    # 检查是否为远程职业
    IsRangedClass<public>(ClassID:int)<computes>:logic =
        if (ClassID = CLASS_MAGE or ClassID = CLASS_RANGER):
            true
        else:
            false
    
    # ========== 职业伤害计算 ==========
    
    # 应用职业伤害倍率
    ApplyClassDamageMultiplier<public>(BaseDamage:float, ClassID:int)<computes>:float =
        Template := GetClassTemplate(ClassID)
        BaseDamage * Template.DamageMultiplier
    
    # 计算带相克的最终伤害
    CalculateFinalDamageWithClass<public>(BaseDamage:float, AttackerClass:int, DefenderClass:int)<computes>:float =
        DamageWithMultiplier := ApplyClassDamageMultiplier(BaseDamage, AttackerClass)
        CounterModifier := CalculateClassCounterModifier(AttackerClass, DefenderClass)
        DamageWithMultiplier * CounterModifier
