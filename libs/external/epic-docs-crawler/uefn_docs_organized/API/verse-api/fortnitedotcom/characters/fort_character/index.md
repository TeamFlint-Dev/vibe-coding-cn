# fort_character interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character
> **爬取时间**: 2025-12-27T01:17:39.038603

---

Main API implemented by Fortnite characters.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Characters }` |

## Exposed Interfaces

This interface exposes the following interfaces:

| Name | Description |
| --- | --- |
| [`positional`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/positional) | Implemented by objects to allow reading position information. |
| [`healable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healable) | Implemented by Fortnite objects that can be healed. |
| [`healthful`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/healthful) | Implemented by Fortnite objects that have health state and can be eliminated. |
| [`damageable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/damageable) | Implemented by Fortnite objects that can be damaged. |
| [`shieldable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/shieldable) | Implemented by Fortnite objects that have shields. A shield is a method of protection that can take incoming damage while leaving the health state unchanged. |
| [`game_action_instigator`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/game_action_instigator) | Implemented by Fortnite objects that initiate game actions, such as damage and heal. For example, player or agents. Event listeners often use `game_action_instigators` to calculate player damage scores. |
| [`game_action_causer`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/game/game_action_causer) | Implemented by Fortnite objects that can be passed through game action events, such as damage and heal. For example: player, vehicle, or weapon.  Event Listeners often use `game_action_causer` to pass along additional information about what weapon caused the damage. Systems will then use that information for completing quests or processing game specific event logic. |

## Members

This interface has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`GetAgent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/getagent) | Returns the agent associated with this `fort_character`. Use this when interacting with APIs that require an `agent` reference. |
| [`EliminatedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/eliminatedevent) | Signaled when this `fort_character` is eliminated from the match. |
| [`GetViewRotation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/getviewrotation) | Returns the rotation where this `fort_character` is looking or aiming at. |
| [`GetViewLocation`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/getviewlocation) | Returns the location where this `fort_character` is looking or aiming from. |
| [`JumpedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/jumpedevent) | Signaled when this `fort_character` jumps. Returns a listenable with a payload of this `fort_character`. |
| [`CrouchedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/crouchedevent) | Signaled when this `fort_character` changes crouch state. Sends `tuple` payload:   - 0: the `fort_character` that changed crouch states. - 1: `true` if the character is crouching. `false` if the character is not crouching. |
| [`SprintedEvent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/sprintedevent) | Signaled when this `fort_character` changes sprint state. Sends `tuple` payload:   - 0: the `fort_character` that changed sprint state. - 1: `true` if the character is sprinting. `false` if the character stopped sprinting. |
| [`IsActive`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isactive) | Succeeds if this `fort_character` is in the world and has not been eliminated. Most fort\_character actions will silently fail if this fails. Please test IsActive if you want to handle these failure cases rather than allow them to silently fail. |
| [`IsDownButNotOut`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isdownbutnotout) | Succeeds if this `fort_character` is in the 'Down But Not Out' state. In this state the character is down but can still be revived by teammates for a period of time. |
| [`IsCrouching`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/iscrouching) | Succeeds if this `fort_character` is crouching. |
| [`IsOnGround`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isonground) | Succeeds if this `fort_character` is standing on the ground. |
| [`IsInAir`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isinair) | Succeeds if this `fort_character` is standing in the air. |
| [`IsInWater`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isinwater) | Succeeds if this `fort_character` is inside water volume. |
| [`IsFalling`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isfalling) | Succeeds if this `fort_character` is in falling locomotion state. |
| [`IsGliding`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isgliding) | Succeeds if this `fort_character` is in gliding locomotion state. |
| [`IsFlying`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isflying) | Succeeds if this `fort_character` is in flying locomotion state. |
| [`PutInStasis`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/putinstasis) | Puts this `fort_character` into stasis, preventing certain types of movement specified by `Args`. |
| [`ReleaseFromStasis`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/releasefromstasis) | Release this `fort_character` from stasis. |
| [`Show`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/show) | Sets this `fort_character` visibility to visible. |
| [`Hide`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/hide) | Sets this `fort_character` visibility to invisible. |
| [`SetVulnerability`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/setvulnerability) | Control if this `fort_character` can be damaged. |
| [`IsVulnerable`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/isvulnerable) | Succeeds if this `fort_character` can be damaged. Fails if this `fort_character` cannot be damaged. |
| [`TeleportTo`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/teleportto) | Teleports this `fort_character` to the provided `Position` and applies the yaw and pitch of `Rotation`. Will fail if the `Position` specified is e.g. outside of the playspace or specifies a place where the character cannot fit. |
| [`GetEntity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/getentity) | Returns the entity associated with this `fort_character`. Use this when interacting with APIs that require an `entity` reference. |
| [`GetLinearVelocity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/getlinearvelocity) | Returns a ‘fort\_character’s linear velocity in meters/second. |
| [`SetLinearVelocity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/setlinearvelocity) | Set a ‘fort\_character’s linear velocity in meters/second. Will not do anything if physics is disabled. |
| [`ApplyLinearImpulse`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/applylinearimpulse) | Apply a linear impulse to a ‘fort\_character’ with units in Newton\*seconds. Will not do anything if physics is disabled. |
| [`GetMass`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/getmass) | Returns a ‘fort\_character’s mass in kilograms. |
| [`ApplyForce`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/characters/fort_character/applyforce) | Apply a force to a ‘fort\_character’ with units in Newtons. Will not do anything if physics is disabled. |
