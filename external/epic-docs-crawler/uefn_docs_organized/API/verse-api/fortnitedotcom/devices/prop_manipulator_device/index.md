# prop_manipulator_device class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device
> **爬取时间**: 2025-12-27T01:50:02.546873

---

Used to manipulate the properties of one or more props in a specified area (e.g. Visibility/Destructibility).

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
| `DamagedEvent` | `listenable(payload)` | Signaled when props affected by this device are damaged. Sends the `agent` that damaged the prop. |
| `DestroyedEvent` | `listenable(payload)` | Signaled when props affected by this device are destroyed. Sends the `agent` that destroyed the prop. |
| `HarvestingEvent` | `listenable(payload)` | Signaled when prop resource nodes affected by this device are harvested. Sends the `agent` that harvested resources from the prop. |
| `ResourceDepletionEvent` | `listenable(payload)` | Signaled when prop resource nodes affected by this device are completely depleted of energy. Sends the `agent` that depleted the prop's energy. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/disable) | Disables this device. |
| [`DisableResourceNodeOverrides`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/disableresourcenodeoverrides) | Sets the *Override Resource* option to *No*. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/enable) | Enables this device. |
| [`ExhaustResources`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/exhaustresources) | Empties the resources of all props affected by this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HideProps`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/hideprops) | Hides all props affected by this device. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`RestockResources`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/restockresources) | Restocks the resources of all props affected by this device. |
| [`RestoreHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/restorehealth) | Restores health of all props affected by this device. |
| [`SetResourceOverridesActive`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/setresourceoverridesactive) | Sets the *Override Resource* option to *Yes*. |
| [`ShowProps`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/prop_manipulator_device/showprops) | Shows all props affected by this device. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
