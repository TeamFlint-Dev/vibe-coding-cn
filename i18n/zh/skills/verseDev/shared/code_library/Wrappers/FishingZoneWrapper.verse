# FishingZoneWrapper - UEFN fishing_zone_device API 封装
# 版本: 1.0
# 创建时间: 2025-12-31
#
# 设计目的:
# 1. 统一封装 UEFN fishing_zone_device API 调用
# 2. 处理所有边界条件和错误情况
# 3. 提供类型安全的接口
# 4. 让 Component 层无需直接依赖 UEFN API
#
# API 参考:
# - fishing_zone_device 位于 shared/api-digests/Fortnite.digest.verse.md L6394
# - 参考现有 Wrapper 模式: CharacterWrapper.verse
#
# 封装的方法:
# - Enable() / Disable() - 启用/禁用设备
# - Reset() - 重置可用次数
# - Restock() - 补充库存
#
# 可用的事件:
# - CaughtEvent - 当玩家钓到鱼时触发
# - EmptyEvent - 当所有物品都被钓走时触发

using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

# ═══════════════════════════════════════════════════════════
# 操作结果
# ═══════════════════════════════════════════════════════════

# API 调用结果
fishing_zone_op_result<public> := struct<concrete>:
    Success<public>:logic = false       # 是否成功
    ErrorReason<public>:string = ""     # 失败原因（成功时为空）

# ═══════════════════════════════════════════════════════════
# FishingZoneWrapper 模块 - UEFN API 封装层
# ═══════════════════════════════════════════════════════════

FishingZoneWrapper<public> := module:
    
    # ═══════════════════════════════════════════════════════
    # 设备启用/禁用操作
    # API: fishing_zone_device.Enable():void
    # API: fishing_zone_device.Disable():void
    # ═══════════════════════════════════════════════════════
    
    # 启用钓鱼区域设备
    Enable<public>(Device:fishing_zone_device):fishing_zone_op_result =
        # 调用设备的 Enable 方法
        Device.Enable()
        
        fishing_zone_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # 禁用钓鱼区域设备
    Disable<public>(Device:fishing_zone_device):fishing_zone_op_result =
        # 调用设备的 Disable 方法
        Device.Disable()
        
        fishing_zone_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # ═══════════════════════════════════════════════════════
    # 重置操作
    # API: fishing_zone_device.Reset():void
    # 重置可用次数回到"允许使用次数"设定值
    # ═══════════════════════════════════════════════════════
    
    # 重置钓鱼区域可用次数
    Reset<public>(Device:fishing_zone_device):fishing_zone_op_result =
        # 调用设备的 Reset 方法
        Device.Reset()
        
        fishing_zone_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # ═══════════════════════════════════════════════════════
    # 补充库存操作
    # API: fishing_zone_device.Restock():void
    # 将所有已钓走的物品归还到库存
    # 注意: 仅在"池类型"设置为"设备库存"时有效
    # ═══════════════════════════════════════════════════════
    
    # 补充钓鱼区域库存
    Restock<public>(Device:fishing_zone_device):fishing_zone_op_result =
        # 调用设备的 Restock 方法
        Device.Restock()
        
        fishing_zone_op_result{
            Success := true,
            ErrorReason := ""
        }
    
    # ═══════════════════════════════════════════════════════
    # 事件订阅辅助
    # 注意: 事件订阅请直接使用 fishing_zone_device 的事件:
    #       - Device.CaughtEvent.Subscribe(OnCaught)
    #       - Device.EmptyEvent.Subscribe(OnEmpty)
    # ═══════════════════════════════════════════════════════
