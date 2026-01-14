# 鱼竿升级模块
# 功能：升级材料、成功率、属性提升

using { /Verse.org/Simulation }
using { library.logicModules.fishingCommonUtils }

RodUpgrade<public> := module:
    
    # ========== 模块特定功能 ==========
    # 本模块使用 MathHelpers 提供的通用数学函数
    # 可在此添加本模块特有的业务逻辑函数
    
    # 示例：获取模块名称
    GetModuleName<public>()<computes>:string =
        return "RodUpgrade"
    
    # 示例：模块初始化检查
    IsModuleReady<public>()<computes>:logic =
        return true
