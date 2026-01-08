# team_settings_and_inventory_device class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/team_settings_and_inventory_device>
> **爬取时间**: 2025-12-27T01:39:20.480603

---

Provides team and inventory configurations that go beyond the choices the My Island settings provide.
Can also be used to customize individual devices and create variations in team setup.

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
| `AllowTemporaryTeamMemberInvitations` | `??logic` | This variable maps to the 'Dynamic Team Emotes' user option. Modifying this value does not affect the state of any existing Temporary Team member. If a player is currently on a Temporary Team, they will maintain access to the leave team emote regardless of this value. Available values:   - If this option is unset, use the global setting configured in Island Settings - If this is set to TRUE, it allows members of this team to Emote and invite other players to their team. - If this is set to FALSE, it prevents members of this team from using an Emote to invite other players to this team. |
| `EnemyEliminatedEvent` | `listenable(payload)` | Signaled when an enemy of *Team* is eliminated by a team member. Sends the `agent` team member who eliminated the enemy. |
| `TeamMemberEliminatedEvent` | `listenable(payload)` | Signaled when a member of *Team* is eliminated. Sends the `agent` that was eliminated. |
| `TeamMemberSpawnedEvent` | `listenable(payload)` | Signaled when a member of *Team* is spawned.Sends the `agent` that has spawned. |
| `TeamOutOfRespawnsEvent` | `listenable(payload)` | Signaled when *Team* runs out of respawns. |

### Functions

| Function Name | Description |
| --- | --- |
| [`EndRound`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/team_settings_and_inventory_device/endround) | Ends the round and *Team* wins the round. |
| [`GetTeamMembers`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/team_settings_and_inventory_device/getteammembers) | Returns an array of agents that are currently of the team defined by this device. |
| [`GetTransform`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/gettransform) | Returns the transform of the `creative_object` with units in cm. You must check `creative_object.IsValid` before calling this if there is a possibility the object has been disposed or destroyed by gameplay. Otherwise a runtime error will result. |
| [`IsOnTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/team_settings_and_inventory_device/isonteam) | Is true if `Agent` is on *Team*. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto) | Moves the `creative_object` to the specified `Position` and `Rotation` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`MoveTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/moveto-1) | Moves the `creative_object` to the specified `Transform` over the specified time, in seconds. If an animation is currently playing on the `creative_object` it will be stopped and put into the `AnimationNotSet` state. |
| [`RemoveTemporaryMemberFromTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/team_settings_and_inventory_device/removetemporarymemberfromteam) | Removes the `agent` from its Temporary Team. Decides based on whether the `agent` was on a Temporary Team. This will return them to the team they were on before they joined a Temporary Team |
| [`RemoveTemporaryMembersFromTeam`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/team_settings_and_inventory_device/removetemporarymembersfromteam) | Returns all temporary team members for this Device’s Team Setting Value back to their original Teams. If the device is configured to All, then this function will remove all Temporary Team members from any Temporary Team they are on, returning them to their original team. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto) | Teleports the `creative_object` to the specified `Position` and `Rotation`. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/creative_object/teleportto-1) | Teleports the `creative_object` to the specified location defined by `Transform`, also applies rotation and scale accordingly. |
