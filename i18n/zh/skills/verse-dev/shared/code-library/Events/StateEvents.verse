# 通用状态事件
# 版本: 1.0
# 来源: 模板预置

using { /Verse.org/SceneGraph }

# 状态变化事件
state_changed_event<public> := class<concrete>(scene_event):
    var OldState<public>:string = ""
    var NewState<public>:string = ""

# 启用/禁用事件
enabled_changed_event<public> := class<concrete>(scene_event):
    var IsEnabled<public>:logic = false
