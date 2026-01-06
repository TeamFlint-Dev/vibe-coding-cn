# bank_vault_interface interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface
> **爬取时间**: 2025-12-27T01:36:19.687290

---

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Devices }` |

## Exposed Interfaces

This interface exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`enableable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/enableable) | Implemented by classes whose instances can be enabled and disabled. |

## Members

This interface has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `StartSequenceEvent` | `listenable(payload)` | Triggers when the vault sequence is started by a player or event.   - Sends the `agent` that triggered this event, if applicable. |
| `OpenEvent` | `listenable(payload)` | Triggers when the vault is opened either by the destruction of its weakpoints or by an event.   - Sends the last `agent` that damaged a weakpoint or the `agent` that started the sequence if no external damage was done or none if the sequence was triggered by a function. |
| `ActivateWeakpointEvent` | `listenable(payload)` | Triggers when a weakpoint is activated. The weakpoint will begin to glow, but does not become vulnerable until a subsequent `WeakpointVulnerableEvent`.   - Sends the `agent` that activated the vault or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation. |
| `WeakpointVulnerableEvent` | `listenable(payload)` | Triggers when a weakpoint becomes vulnerable.   - Sends the `agent` that activated the vault or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation. |
| `DestroyWeakpointEvent` | `listenable(payload)` | Triggers when a weakpoint is destroyed.   - Sends the last `agent` that damaged the weakpoint or the `agent` that started the sequence if no external damage was done or none if the sequence was triggered by a function, and the `int` index of the weakpoint from 0-4, in order of activation. |
| `RequireThermite` | `?logic` | Whether the player needs thermite when interacting with the door to start the vault opening sequence. |
| `WeakpointDamagePerSecond` | `?float` | Damage dealt to the active weakpoint each second. Negative numbers heal the weakpoint. Weakpoints can only be damaged while the vault sequence is active. |
| `WeakpointTakesExternalDamage` | `?logic` | Whether the weakpoint takes damage from weapons and items while vault sequence is active. |
| `MaxWeakpointHealth` | `?float` | The max health of this device's weakpoints. |

### Functions

| Function Name | Description |
| --- | --- |
| [`ForceOpen`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/forceopen) | Destroys the remaining weakpoints and opens the vault door. Requires the device to be enabled. |
| [`StartSequence`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/startsequence) | Begin the sequence of events to open the vault door without thermite, or unpauses the sequence if it was paused. Requires the device to be enabled. Weakpoints can only be damaged while the vault sequence is active. |
| [`PauseSequence`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/pausesequence) | Disable the weakpoint vulnerability and freeze the progress of each one. Weakpoints can only be damaged while the vault sequence is active. |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/reset) | Restores vault to default state, deactivates the device, and heals all weakpoints to max health. Requires the device to be enabled. |
| [`IsSequenceActive`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/issequenceactive) | Whether the vault sequence is currently active and not paused. |
| [`DestroyActiveWeakpoint`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/destroyactiveweakpoint) | Destroy the active weakpoint. Requires the device to be enabled. Must have active weakpoint. |
| [`RestoreActiveWeakpoint`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/restoreactiveweakpoint) | Restores the active weakpoint to full health. Requires the device to be enabled. Must have active weakpoint. |
| [`GetActiveWeakpointIndex`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/getactiveweakpointindex) | Gets the active weakpoint's index starting at `0`, regardless of device's enabled state. Returns false if there is no active weakpoint, such as when the sequence is not active or directly after a weakpoint is destroyed. |
| [`GetWeakpointCount`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/getweakpointcount) | Gets the total number of weakpoints. |
| [`GetActiveWeakpointHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/getactiveweakpointhealth) | Get active weakpoint's health. If there is no active weakpoint, returns false. |
| [`SetActiveWeakpointHealth`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/bank_vault_interface/setactiveweakpointhealth) | Set active weakpoint's health. Setting it to `0.0` or false will destroy the weakpoint. Clamps to maximum of WeakpointMaxHealth. |
