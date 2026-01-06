# npc_behavior class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/npc_behavior
> **爬取时间**: 2025-12-27T00:57:03.802287

---

Inherit from this to create a custom NPC behavior.
The npc\_behavior can be defined for a character in a CharacterDefinition asset, or in a npc\_spawner\_device.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/AI }` |

## Members

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`OnBegin`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/npc_behavior/onbegin) | This function is called when the NPC is added to the simulation. |
| [`OnEnd`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/npc_behavior/onend) | This function is called when the NPC is removed from the simulation. |
| [`GetAgent`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/npc_behavior/getagent) | Returns the agent associated with this behavior. |
| [`GetEntity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/npc_behavior/getentity) | Returns the entity associated with this behavior. |
