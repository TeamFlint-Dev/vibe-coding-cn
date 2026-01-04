# NPC Types

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/npc-types-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:03:52.815197

---

NPCs in UEFN fall into several groups, each with their own rules and behaviors that are native to their character type. All fortnite characters implement the `fort_character` interface which grants them bespoke base behaviors, such as the ability to be damaged and healed.

When creating your own NPCs using the [NPC Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite), selecting an NPC Type will grant the NPCs the base behaviors from that character type. As a base, all NPC Types inherit the `fort_character` and `AI` behaviors. Guard-type NPCs will inherit behaviors from the guard class, and Wildlife-type NPCs will inherit from the wildlife class. Custom-type NPCs do not inherit any extra behaviors.

## NPC Types

This section covers the various types of NPCs, and the behaviors native to each type.

### Guard

Guard-type NPCs are humanoid NPCs that all share common rules. Guards may be assigned to teams, and patrol an area or a patrol path. Guards coordinate to attack enemies and spread info about enemy locations to other guards. Guards may be hired and will leash and protect players who hire them. Guards use the perception system, which allows you to control how well guards can perceive targets in the world around them using sight, sound, and touch.

When a guard spawns, it either begins idle or starts patrolling if the patrol option is enabled. When the guard detects a target, it begins to fill the suspicion meter. If the meter is filled, the guard enters the alert phase, otherwise, it returns to patrolling. While alert, the guard will continuously navigate to their target, attacking them if they’re in range. If the target is eliminated or escapes the guard, the guard will return to patrolling.

| State | Description | Gif |
| --- | --- | --- |
| Idle | Guard will stand idle. Guards are only idle when the patrol option is disabled. |  |
| Patrolling | Guard patrols randomly in a set area. If patrol paths are enabled, the guard will patrol along an assigned patrol path. |  |
| Hired | The guard will leash to the player who hired them and attempt to stay within a certain distance from them. While hired and within the leash radius, the guard will continue to detect and attack enemy targets. |  |
| Suspicious | When a target is in range, the guard begins to fill the suspicion meter, represented by the question mark (?) symbol above their head. The guard moves to the Alert stage when the suspicion meter is filled. |  |
| Alert | The guard has detected a target, indicated by the exclamation mark (!) symbol above their head. The guard will attempt to chase the target and attack when the target is in range. |  |
| Attacking | The guard actively attacks a target and will attempt to maneuver to avoid being hit. |  |

Guards are a highly flexible NPC type that lend themselves to a ton of different gameplay situations. For example:

- Guarding a capture point in a control point gamemode.
- Escorting a VIP NPC or player.
- Spawning waves of guards as part of a tower defense game.
- Companions or quest-givers that can defend themselves as part of an RPG.

If you want NPCs that can fight, patrol, and work with the player, guards are a solid choice for your experiences.

### Wildlife

Wildlife-type NPCs are non-humanoid NPCs that default to the Wildlife & Creatures team. Wildlife NPCs have significant differences between their types. For example, Wolves, Boars, and Raptors can be tamed and mounted, while Chickens cannot. Frogs and Chickens run away from enemies, while Raptors attack them.

When wildlife spawn, they begin to patrol an area around their spawn point. When wildlife detect a target, the action they take depends on their wildlife type. Different wildlife have both actions unique to each type and have general actions depending on whether the wildlife is predator or prey. Predators, such as the Raptor and Wolf, will charge their target and begin attacking them. Prey animals ,such as the Frog and Chicken, will generally run away from the target. Certain wildlife (the Raptor, Wolf, and Boar) can be tamed either by interacting with them while they are eating or by jumping onto their backs. When tamed, wildlife will join the team of the player who tamed them and follow them around. A maximum of three wildlife may be tamed by a player at any time.

The Raptor, Wolf, and Boar can also be mounted. When mounted, these NPCs act as vehicles for the player and will not take independent action. They will use the player's inputs for movement and only act independently when dismounted.

| State | Description | Gif |
| --- | --- | --- |
| Idle | The wildlife will patrol randomly in a set area. |  |
| Tamed | The wildlife will follow the player who tamed them and attempt to stay within a certain distance from them. While hired and within the follow radius, the wildlife will continue to detect and attack enemy targets. |  |
| Mounted | The wildlife will not take independent action and will use the player’s input for movement until dismounted. |  |
| Out of Energy | The wildlife is out of energy and cannot move or attack. After regenerating energy through waiting or being fed, the wildlife can move again. |  |
| Attacking | The wildlife is actively attacking a target and will attempt to find the quickest path to them. |  |

Wildlife-type NPCs are useful when you want to populate your world with creatures, create animal companions for your players, or make open-world exploration more exciting through mounted riding and combat.

### Custom

Custom-type NPCs do not implement base behavior and instead are reliant on NPC behavior scripts to drive their actions. This gives them a large amount of flexibility, and you can customize these NPCs to suit your game’s needs. For more information on NPC Behavior scripts and to learn how to create your own, check out [Create Custom NPC Behavior](https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite).
