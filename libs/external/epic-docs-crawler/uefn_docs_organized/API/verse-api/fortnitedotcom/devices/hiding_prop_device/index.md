# hiding_prop_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device
> **爬取时间**: 2025-12-27T01:57:41.617784

---

The hiding prop device can be used to give players a place to hide, or to allow players a special way to commence a Hidden Travel to another Hiding prop.

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
| `AttemptNoRepeatDestinations` | `?logic` | This value maps to the 'Attempt No Repeat Destinations' user option. If this is set to On, the prop will avoid sending a player to the previous hiding prop twice in a row, unless there is no other hiding prop available. Modifying this value will take effect the next time a player attempts a hidden travel. Leaving this value unset means that this hiding\_prop\_device will not be able to initiate hidden travel. |
| `BeginPlayerHideEvent` | `listenable(payload)` | Signaled when a player hides in this Hiding prop. |
| `BlockHideTime` | `?float` | This value maps to the 'Block Hide Time' user option. When a player leaves the prop, this determines the amount of time another player must wait before they can hide in the prop. Modifying this value will not affect any player who is currently blocked from hiding, but will affect all players who eject from the hiding prop after it has been modified. |
| `EnableHiddenTravel` | `?logic` | This value controls whether or not Hidden Travel is enabled or disabled Modifying this value will take effect the next time a player attempts a hidden travel. |
| `EndPlayerHideEvent` | `listenable(payload)` | Signaled when a player stops hiding in this hiding prop. |
| `HiddenTravelGroup` | `??int` | This value maps to the 'Hidden Travel Group' user option. To make use of the hidden travel feature, you must assign this hiding prop to a Hidden Travel Group. Modifying this value will take effect the next time a player attempts a hidden travel. Leaving this value unset will make it so other hiding\_prop\_device are ineligible to travel to this one. |
| `HiddenTravelTargetGroup` | `??int` | This value maps to the 'Hidden Travel Target Group' user option. Determines which group of hiding props can be targeted as a hidden travel destination. You can set this to the same value as the Hidden Travel Group option, or if you have multiple groups of hiding props you can target a different group. Modifying this value will take effect the next time a player attempts a hidden travel. Leaving this value unset means that this hiding\_prop\_device will not be able to cause a Hidden Travel when players hide inside of it. |
| `MaxHideTime` | `??float` | This value maps to the 'Max Hiding Time' user option. Sets a maximum amount of time a player can hide in the prop before being ejected. Setting this value to False will disable any limit to how long a player can hide. Modifying this value will instantly take effect, if any players hiding are now exceeding the Max Hiding time, they will be immediately ejected. |
| `MaxNumberOfOccupants` | `?int` | This value maps to the 'Max Number Of Occupants' user option. Determines how many players can hide in this prop at one time. Modifying this value will not eject any players who are currently hiding, but will otherwise take effect immediately. |
| `PlayerHiddenTravelEvent` | `listenable(payload)` | Signaled when a hidden travel completes to another hiding prop. |
| `ShouldWobbleWhileHiding` | `?logic` | This value maps to the 'Should Wobble While Hiding' user option. Modifying this value will take effect the next time a player hides inside of this device. By default, the prop alerts other players with sound and animation that a player is hiding in the prop. Set this to Off to disable these effects. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device/disable) | Disable this device. When this device is disabled, it cannot be interacted with. |
| [`EjectAllHiddenPlayers`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device/ejectallhiddenplayers) | Eject all players hiding in this hiding prop. Returns an array of all players that were ejected. |
| [`EjectHiddenPlayer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device/ejecthiddenplayer) | Eject a specific player from this hiding prop. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device/enable) | Enable this device. When this device is enabled, it can be interacted with. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HideNearbyPlayers`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device/hidenearbyplayers) | Hides all players within the provided meters of a hiding prop. Returns an array of all players that were hidden. This event will not allow more players than is specified in 'MaxNumberOfOccupants' to be hidden in this device. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device/isenabled) | Succeeds if the object is enabled, fails if it's disabled. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
