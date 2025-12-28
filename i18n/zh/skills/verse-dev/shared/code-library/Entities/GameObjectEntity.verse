# game_object_entity - 基础游戏对象Entity模板
# 版本: 1.0
# 来源: 模板预置

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }

# 基础游戏对象Entity
# 提供ID管理和基本生命周期
game_object_entity<public> := class(entity):
    var ObjectID<private>:string = ""
    var IsInitialized<private>:logic = false
    
    # 初始化对象
    Initialize<public>(ID:string):void =
        if not IsInitialized:
            set ObjectID = ID
            set IsInitialized = true
    
    # 获取对象ID
    GetID<public>():string = ObjectID
    
    # 是否已初始化
    IsObjectInitialized<public>():logic = IsInitialized
