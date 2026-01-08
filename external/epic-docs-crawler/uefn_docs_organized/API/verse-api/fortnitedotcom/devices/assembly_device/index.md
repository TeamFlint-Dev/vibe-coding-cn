# assembly_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device>
> **爬取时间**: 2025-12-27T01:37:07.429889

---

Used to dynamically assemble or disassemble one or more building actors. Only available in LEGO islands.

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
| `AssemblyFinishedEvent` | `listenable(payload)` | Signaled when the device finishes assembling, at the same time as other 'finished' effects are started. |
| `DisassemblyFinishedEvent` | `listenable(payload)` | Signaled when the device finishes disassembling. |
| `Progress` | `?float` | The amount of progress the device has made towards fully assembling (1.0) or fully disassembling (0.0). |

### Functions

| Function Name | Description |
| --- | --- |
| [`Assemble`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/assemble) | Initiates the assembly process. |
| [`Assemble`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/assemble-1) | Initiates the assembly process. |
| [`Disable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/disable) | Disable this object. |
| [`Disassemble`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/disassemble) | Initiates the disassembly process. |
| [`Disassemble`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/disassemble-1) | Initiates the disassembly process. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/enable) | Enable this object. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`HideHologram`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/hidehologram) | Hide the hologram used to preview the fully assembled device |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/isenabled) | Succeeds if the object is enabled, fails if it’s disabled. |
| [`IsPaused`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/ispaused) | Succeeds if the device is paused, fails if it is not. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`Pause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/pause) | Pause the assembly or disassembly process. |
| [`Pause`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/pause-1) | Pause the assembly or disassembly process. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/reset) | Resets affected building actors to the state they were in at the start of the round. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/reset-1) | Resets affected building actors to the state they were in at the start of the round. |
| [`ShowHologram`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/showhologram) | Show the hologram used to preview the fully assembled device |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
| [`UpdateAssembly`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/assembly_device/updateassembly) | Scans for newly created objects and adds them to the assembly where possible |
