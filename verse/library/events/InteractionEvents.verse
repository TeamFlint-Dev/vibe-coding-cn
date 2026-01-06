# InteractionEvents - 交互事件系统
# 版本: 1.1
# 添加时间: 2025-12-27
# 来源: REQ-004 (循环迭代模式)
# 更新: 修复 Verse 语法错误 - scene_event 属性应为常量

using { /Verse.org/SceneGraph }

# ==========================================
# 交互开始事件
# ==========================================

# 交互开始时触发
interaction_started_event<public> := class<concrete>(scene_event):
    # 发起交互的实体（通常是玩家）
    Interactor<public>:?entity = false
    # 被交互的目标实体
    Target<public>:?entity = false
    # 交互类型标识
    InteractionType<public>:string = "default"

# ==========================================
# 交互完成事件
# ==========================================

# 交互成功完成时触发
interaction_completed_event<public> := class<concrete>(scene_event):
    Interactor<public>:?entity = false
    Target<public>:?entity = false
    InteractionType<public>:string = "default"
    # 是否成功
    Success<public>:logic = true
    # 交互结果数据（可选）
    ResultData<public>:string = ""

# ==========================================
# 交互取消事件
# ==========================================

# 交互被中断/取消时触发
interaction_cancelled_event<public> := class<concrete>(scene_event):
    Interactor<public>:?entity = false
    Target<public>:?entity = false
    InteractionType<public>:string = "default"
    # 取消原因
    CancelReason<public>:string = "unknown"

# ==========================================
# 交互提示事件
# ==========================================

# 显示/隐藏交互提示
interaction_prompt_event<public> := class<concrete>(scene_event):
    # 是否显示提示
    Show<public>:logic = false
    # 提示文本
    PromptText<public>:string = ""
    # 交互按键提示
    KeyHint<public>:string = "E"
    # 目标实体
    Target<public>:?entity = false

# ==========================================
# 交互进度事件
# ==========================================

# 需要持续按住的交互进度更新
interaction_progress_event<public> := class<concrete>(scene_event):
    Interactor<public>:?entity = false
    Target<public>:?entity = false
    # 当前进度 (0.0 ~ 1.0)
    Progress<public>:float = 0.0
    # 总所需时间
    TotalDuration<public>:float = 1.0

# ==========================================
# 交互类型常量
# ==========================================

InteractionTypes<public> := module:
    # 拾取物品
    Pickup<public>:string = "pickup"
    # 打开容器/门
    Open<public>:string = "open"
    # 使用/激活
    Use<public>:string = "use"
    # 对话/交谈
    Talk<public>:string = "talk"
    # 购买
    Buy<public>:string = "buy"
    # 修复/建造
    Build<public>:string = "build"
    # 检查/查看
    Examine<public>:string = "examine"
