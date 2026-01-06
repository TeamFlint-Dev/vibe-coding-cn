# guard_spawner_visibility_range_restriction enumeration

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/guard_spawner_visibility_range_restriction
> **爬取时间**: 2025-12-27T01:36:01.657551

---

Used with `guard_spawner_device.VisibilityRangeRestriction` to define how the guard uses `guard_spawner_device.VisibilityRange`

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Enumerators

The `guard_spawner_visibility_range_restriction` enumeration includes the following enumerators:

| Name | Description |
| --- | --- |
| `OnlyWhenUnaware` | The NPC only uses its `VisibilityRange` when it does not have a target. Otherwise, the guard has an infinite range. |
| `Always` | The NPC uses its `VisibilityRange` both when it is unaware and when it has a target. |
