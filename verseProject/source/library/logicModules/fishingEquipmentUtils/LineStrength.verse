# 鱼线强度模块
# 功能：强度等级、断裂阈值、耐久消耗

using { /Verse.org/Simulation }
using { library.logicModules.fishingCommonUtils }

LineStrength<public> := module:
    
    # ========== 模块特定功能 ==========
    # 本模块使用 MathHelpers 提供的通用数学函数
    # 可在此添加本模块特有的业务逻辑函数
    
    # 示例：获取模块名称
    GetModuleName<public>()<computes>:string =
        return "LineStrength"
    
    # 示例：模块初始化检查
    IsModuleReady<public>()<computes>:logic =
        return true
