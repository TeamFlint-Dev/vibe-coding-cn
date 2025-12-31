# 通用状态事件
# 版本: 1.1
# 来源: 模板预置
# 更新: 修复 Verse 语法错误 - scene_event 属性应为常量

using { /Verse.org/SceneGraph }

# 状态变化事件
state_changed_event<public> := class<concrete>(scene_event):
    OldState<public>:string = ""
    NewState<public>:string = ""

# 启用/禁用事件
enabled_changed_event<public> := class<concrete>(scene_event):
    IsEnabled<public>:logic = false
