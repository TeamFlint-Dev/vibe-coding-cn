# 生命值相关事件
# 版本: 1.1
# 来源: 模板预置
# 更新: 修复 Verse 语法错误 - scene_event 属性应为常量

using { /Verse.org/SceneGraph }

# 生命值变化事件
health_changed_event<public> := class<concrete>(scene_event):
    CurrentHealth<public>:int = 0
    MaxHealth<public>:int = 0
    ChangeAmount<public>:int = 0  # 正数为治疗，负数为伤害

# 实体死亡事件
entity_died_event<public> := class<concrete>(scene_event):
    # 空事件，仅用于通知死亡
