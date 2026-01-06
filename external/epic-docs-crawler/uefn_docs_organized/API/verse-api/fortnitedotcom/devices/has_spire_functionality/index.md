# has_spire_functionality interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/has_spire_functionality
> **爬取时间**: 2025-12-27T01:41:36.966780

---

An interface for shared functionality between different spire devices

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
| `ActivationDistance` | `?float` | Determines the distance where approaching players activate the Spire. |
| `ActivateEvent` | `listenable(payload)` | Triggers when the Spire becomes activated from players entering the `Activation Distance` |
| `DeactivateEvent` | `listenable(payload)` | Triggers when the Spire becomes deactivated, either from players leaving the `Activation Distance` |
| `DestroyEvent` | `listenable(payload)` | Triggers when the Spire is destroyed from damage or events |
| `MaxHealth` | `?float` | The maximum health of this Spire. |
| `Health` | `?float` | The Spire's current health. Clamped between 0 and `MaxHealth`.   - Setting this value does nothing if the Spire is destroyed. |
| `ShowMapIcon` | `?logic` | Determines if a Spire-specific icon should be displayed on the map while the Spire is spawned |

### Functions

| Function Name | Description |
| --- | --- |
| [`IsActivated`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/has_spire_functionality/isactivated) | If this Spire is currently activated.   - Succeeds if activated. Fails if deactivated - An activated will react to enemies and take damage - Becomes activated from being enabled and players entering the `Activation Distance` |
| [`Spawn`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/has_spire_functionality/spawn) | Spawns the Spire, causing it to become visible and enabling collision   - Does nothing if the Spire is already spawned or destroyed |
| [`IsSpawned`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/has_spire_functionality/isspawned) | Succeeds if this Spire is in a spawned state. Fails if the Spire is destroyed or has not spawned. |
| [`Destroy`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/has_spire_functionality/destroy) | Sets the Spire’s health to zero, destroying it. |
| [`IsDestroyed`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/has_spire_functionality/isdestroyed) | Succeeds if this Spire’s health has reached 0. Fails otherwise |
| [`Reset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/has_spire_functionality/reset) | Resets the Spire to its initial state. |
