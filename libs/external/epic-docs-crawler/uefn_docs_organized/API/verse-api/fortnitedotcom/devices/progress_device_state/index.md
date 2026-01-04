# progress_device_state enumeration

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/progress_device_state
> **爬取时间**: 2025-12-27T01:42:50.654750

---

The state of a progress\_based\_mesh\_device.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Enumerators

The `progress_device_state` enumeration includes the following enumerators:

| Name | Description |
| --- | --- |
| `Progress` | This device is currently progressing, and will increase its 'CurrentProgress' by its 'ProgressRate'. |
| `Regress` | This device is currently regressing, and will decrease its 'CurrentProgress' by its 'RegressRate'. |
| `Pause` | This device is currently paused. It will not progress or regress automatically. |
