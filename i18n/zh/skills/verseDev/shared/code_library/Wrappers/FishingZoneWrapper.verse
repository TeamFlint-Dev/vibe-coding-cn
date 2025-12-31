# FishingZoneWrapper - UEFN fishing_zone_device API 封装
# 版本: 1.0
# 创建时间: 2025-12-31
#
# TODO: @copilot 请实现这个 Wrapper
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
# 需要封装的方法:
# - Enable() / Disable() - 启用/禁用设备
# - Reset() - 重置可用次数
# - Restock() - 补充库存
#
# 需要封装的事件:
# - CaughtEvent - 当玩家钓到鱼时触发
# - EmptyEvent - 当所有物品都被钓走时触发

using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }

# TODO: 实现 FishingZoneWrapper 模块
# 参考 CharacterWrapper.verse 的模式实现
