# guard_awareness_component class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/guard_awareness_component>
> **爬取时间**: 2025-12-27T00:57:34.865416

---

Fortnite Guard perception management

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/AI }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `component`:

| Name | Description |
| --- | --- |
| [`component`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component) | Base class for authoring logic and data in the SceneGraph. Using components you can author re-usable building blocks of logic and data which can then be added to entities in the scene.  Components are a very low level building block which can be used in many ways. For example:   - Exposing engine level concepts like mesh or sound - Adding gameplay capabilities like damage or interaction - Storing an inventory for a character in the game   As components are generic there is no specific way that they must be used. It is up to the needs of your experience if you use one big game component or if you break up logic into many small components.  Classes deriving from component must also specify `<final_super>` to be added to entities. This ensures the class will always derive directly from `component`. Further subclassing of the initial derived component is allowed and does not require specifying `<final_super>` on the derived classes.  Only one instance of a component from each subclass group can be added to an entity at a time. For example, given this group of components, only one light\_component can exist on a single entity. To create multiple lights you should use multiple entities.  light\_component := class(component){} capsule\_light\_component := class(light\_component){} directional\_light\_component := class(light\_component){} spot\_light\_component := class(light\_component){} sphere\_light\_component := class(light\_component){} rect\_light\_component := class(light\_component){}  ============================================================================== Component Lifetime  Components move through a series of lifetime functions as they are added to entities, added to the scene, and begin running in the simulation. Components should override these methods to perform setup and run their simulation.  As a component shuts down it will then move through shutdown version of these functions, giving users the opportunity to clean up any retained state on the component before it is disposed . Lifetime Methods: OnAddedToScene OnBeginSimulation -> OnSimulate OnEndSimulation OnRemovingFromScene ============================================================================== |
| [`npc_awareness_component`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/npc_awareness_component) | Fortnite NPC perception management |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `AlertLevel` | `?guard_alert_level` | Current alert level. |
| `AlertLevelChangeEvent` | `listenable(payload)` | Event when the alert level has changed. |
| `DetectedObstacle` | `??entity` | Potentially detected obstacle. |
| `DetectedTargets` | `?[]npc_target_info` | Information about all detected targets. |
| `DetectObstacleEvent` | `listenable(payload)` | Event when a new obstacle is detected. |
| `DetectTargetEvent` | `listenable(payload)` | Event when a target was detected. |
| `Entity` | `entity` | The parent entity of this component.   - Components must have a parent entity pointer provided when being constructed. - Components cannot be moved between parents. |
| `ForgetObstacleEvent` | `listenable(payload)` | Event when the current obstacle was forgotten. |
| `ForgetTargetEvent` | `listenable(payload)` | Event when a target was forgotten. |
| `HearTargetEvent` | `listenable(payload)` | Event when a target is heard. Hearing sense must be active. |
| `PrimaryThreat` | `??npc_target_info` | Information about the primary threat. |
| `PrimaryThreatChangeEvent` | `listenable(payload)` | Event when the primary threat has changed. |
| `SeeTargetEvent` | `listenable(payload)` | Event when a target is seen. Sight sense must be active. |
| `TickEvents` | `?tick_events` | Set callbacks to `TickEvents.PrePhysics` and `TickEvents.PostPhysics` to receive per-frame updates before and after physics is updated on your object. |
| `TouchTargetEvent` | `listenable(payload)` | Event when a target is touched. Touch sense must be active. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetAlertLevel`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ai/guard_awareness_component/getalertlevel) | Get the current alert level for a specific target. |
| [`IsInScene`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/isinscene) | Succeeds if the component is currently in the scene.   - After `OnAddedToScene` is called this call succeeds. - After `OnRemovingFromScene` is called this call fails. |
| [`IsSimulating`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/issimulating) | Succeeds if the component is currently simulating.   - After `OnBeginSimulation` is called this call succeeds. - After `OnEndSimulation` is called this call fails. |
| [`OnAddedToScene`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onaddedtoscene) | Called when the component is added to the scene by parenting it under the simulation entity or another entity already in the scene.   - Querying for components in the scene is valid after this phase completes. |
| [`OnBeginSimulation`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onbeginsimulation) | Called when the component begins simulating within the scene.   - Use this to set up TickEvent callbacks or other setup that must be guaranteed to complete immediately. - `OnAddedToScene` is guaranteed to run before `OnBeginSimulation`. |
| [`OnEndSimulation`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onendsimulation) | Called when the component ends simulation within the scene.   - Simulation ends on a component when the experience resets, the parent entity is removed from the scene. - Cached TickEvents cancelables should be canceled in `OnEndSimulation`. - `OnSimulate` task will be canceled before `OnEndSimulation` is called. - `OnEndSimulation` is only called on components that have already had `OnBeginSimulation` called. |
| [`OnRemovingFromScene`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onremovingfromscene) | Called when the component is about to be removed from the scene.   - Components are removed from a scene when the parent entity is removed from the scene. - `OnRemovingFromScene` is only called on components that have already had `OnAddedToScene` called. |
| [`OnSimulate`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onsimulate) | Called when the component begins simulating within the scene.   - Use this to add asynchronous/suspends update logic for a component. - `OnBeginSimulation` is guaranteed to run before `OnSimulate`. - `OnSimulate` will be cancelled before `OnEndSimulation` |
| [`RemoveFromEntity`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/removefromentity) | Removes the component from the entity.   - Removed components are removed from the scene and can only be added back to the same entity. - Flows through `OnEndSimulation`-> `OnRemovingFromScene`. |
| [`SendDown`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/senddown) | Send a scene event to this component. Return true to consume the event and halt propogation. |
