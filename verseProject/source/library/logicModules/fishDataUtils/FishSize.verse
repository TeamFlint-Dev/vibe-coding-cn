# 尺寸计算模块
# 功能：尺寸范围、尺寸修正、记录判定

using { /Verse.org/Simulation }
using { library.logicModules.fishingCommonUtils }

FishSize<public> := module:
    
    # ========== 模块特定功能 ==========
    # 本模块使用 MathHelpers 提供的通用数学函数
    # 可在此添加本模块特有的业务逻辑函数
    
    # 示例：获取模块名称
    GetModuleName<public>()<computes>:string =
        return "FishSize"
    
    # 示例：模块初始化检查
    IsModuleReady<public>()<computes>:logic =
        return true
