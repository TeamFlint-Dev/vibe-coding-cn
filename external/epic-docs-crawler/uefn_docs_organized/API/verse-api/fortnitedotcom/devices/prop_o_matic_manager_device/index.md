# prop_o_matic_manager_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_o_matic_manager_device
> **爬取时间**: 2025-12-27T01:56:11.346434

---

Allows customization of the Prop-o-Matic weapon functions and how the game reacts to players using it.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `creative_object`:

| Name | Description |
| --- | --- |
| [`creative_object`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object) | Base class for creative devices and props. |
| [`creative_device_base`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_device_base) | Base class for creative\_device. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `BeginEnteringDisguiseEvent` | `listenable(payload)` | Signaled when an `agent` begins entering a disguise. Sends the `agent` that began entering the disguise. |
| `ExitingDisguiseEvent` | `listenable(payload)` | Signaled when an `agent` exits a disguise. Sends the `agent` that exited the disguise. |
| `FinishEnteringDisguiseEvent` | `listenable(payload)` | Signaled when an `agent` finishes entering a disguise. Sends the `agent` that finished entering the disguise. |
| `PingAllPlayerPropsEvent` | `listenable(payload)` | Signaled when all player props have been pinged. |
| `PingPlayerPropEvent` | `listenable(payload)` | Signaled when a player prop has been pinged. Sends the `agent` that was pinged. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsPlayerProp`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_o_matic_manager_device/isplayerprop) | Returns whether a player is currently hiding or not. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`PingPlayerProp`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_o_matic_manager_device/pingplayerprop) | Manually ping a specific player if they are currently a prop. |
| [`PingPlayerProps`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_o_matic_manager_device/pingplayerprops) | Manually ping all players that are currently hiding as props. |
| [`SetPingFrequency`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_o_matic_manager_device/setpingfrequency) | Adjust the ping time. |
| [`SetPingProps`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_o_matic_manager_device/setpingprops) | Toggle Pinging props on/off. |
| [`SetShowPropPingCooldown`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_o_matic_manager_device/setshowproppingcooldown) | Toggle showing the prop ping cooldown. |
| [`SetShowPropsRemaining`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_o_matic_manager_device/setshowpropsremaining) | Toggle showing the props remaining on the UI. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
