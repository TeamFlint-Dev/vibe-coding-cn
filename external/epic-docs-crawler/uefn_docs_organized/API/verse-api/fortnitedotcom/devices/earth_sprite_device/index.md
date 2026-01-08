# earth_sprite_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device>
> **爬取时间**: 2025-12-27T01:39:52.063415

---

Use to create a sprite that players can trade in a weapon for a random legendary weapon or a custom item list.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |

## Exposed Interfaces

This class exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`enableable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/enableable) | Implemented by classes whose instances can be enabled and disabled. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `GrantTimerCompletedEvent` | `listenable(payload)` | Triggers when the grant timer has completed. Sends the triggering `agent`. |
| `WeaponConsumedEvent` | `listenable(payload)` | Triggers when a player gives the Earth Sprite a weapon. Sends the triggering `agent`. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/disable) | Disable the device. |
| [`DisableItemGranting`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/disableitemgranting) | Disable the device’s ability to grant items. Can still interact and consume weapons. |
| [`DisableTradingForPlayer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/disabletradingforplayer) | Prevents the `agent` from trading. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/enable) | Enable the device, and resets all trade counts the Sprite is tracking. |
| [`EnableItemGranting`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/enableitemgranting) | Enable the device’s ability to grant items. |
| [`EnableTradingForPlayer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/enabletradingforplayer) | Allows a `agent` to trade, and will reset the `agent`'s trade count for this Sprite. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/hide) | Makes the Earth Sprite invisible. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/isenabled) | Succeeds if the device is enabled, fails if it's disabled. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/earth_sprite_device/show) | Makes the Earth Sprite visible. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
