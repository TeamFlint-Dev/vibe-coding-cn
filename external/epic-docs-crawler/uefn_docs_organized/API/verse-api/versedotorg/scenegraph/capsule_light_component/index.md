# capsule_light_component class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/capsule_light_component
> **爬取时间**: 2025-12-27T00:54:05.909254

---

A `capsule_light_component` emits light in all directions into the scene from a capsule shaped source with a specified radius and length. A radius and length of 0 makes it a point light. You can use these
to simulate any kind of light sources that emit in all directions and need an elongated source shape, such as a long light bulb.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `component`:

| Name | Description |
| --- | --- |
| [`component`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component) | Base class for authoring logic and data in the SceneGraph. Using components you can author re-usable building blocks of logic and data which can then be added to entities in the scene.  Components are a very low level building block which can be used in many ways. For example:   - Exposing engine level concepts like mesh or sound - Adding gameplay capabilities like damage or interaction - Storing an inventory for a character in the game   As components are generic there is no specific way that they must be used. It is up to the needs of your experience if you use one big game component or if you break up logic into many small components.  Classes deriving from component must also specify `<final_super>` to be added to entities. This ensures the class will always derive directly from `component`. Further subclassing of the initial derived component is allowed and does not require specifying `<final_super>` on the derived classes.  Only one instance of a component from each subclass group can be added to an entity at a time. For example, given this group of components, only one light\_component can exist on a single entity. To create multiple lights you should use multiple entities.  light\_component := class(component){} capsule\_light\_component := class(light\_component){} directional\_light\_component := class(light\_component){} spot\_light\_component := class(light\_component){} sphere\_light\_component := class(light\_component){} rect\_light\_component := class(light\_component){}  ============================================================================== Component Lifetime  Components move through a series of lifetime functions as they are added to entities, added to the scene, and begin running in the simulation. Components should override these methods to perform setup and run their simulation.  As a component shuts down it will then move through shutdown version of these functions, giving users the opportunity to clean up any retained state on the component before it is disposed . Lifetime Methods: OnAddedToScene OnBeginSimulation -> OnSimulate OnEndSimulation OnRemovingFromScene ============================================================================== |
| [`light_component`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/light_component) | Base class for light components in the SceneGraph.  Dependencies:   - `transform_component` on the entity positions the light.   Examples of components implementing `light_component`:   - `directional_light_component` - `capsule_light_component` - `sphere_light_component` - `rect_light_component` - `spot_light_component` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `AttenuationRadius` | `??float` | The bounds of the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more. The light falloff is based on Inverse Square law. Towards the tail end of the AttenuationRadius, there is an additional smoothing factor to fade out the light contribution to 0 to avoid a hard cutoff. |
| `CastShadows` | `?logic` | Whether the light should cast any shadows. |
| `ColorFilter` | `?color` | Set the filter color of the light. This acts as a colored filter in front of the light source. Note that this can change the light's effective intensity. In normalized range 0-1. |
| `DiffuseScale` | `?float` | Multiplier on diffuse lighting. Any value besides 1.0 is not physical. 0.0 means no diffuse contribution from this light. |
| `Entity` | `entity` | The parent entity of this component.   - Components must have a parent entity pointer provided when being constructed. - Components cannot be moved between parents. |
| `Intensity` | `?float` | Set the visible light intensity emitted in SI unit Candela. Specified before ColorFilter (which multiplies each color component after the intensity calculation and can change the effective intensity of the light). |
| `SourceLength` | `?float` | Length of the source capsule shape in centimeters along the local Z axis. Note that light shapes which intersect shadow casting geometry can cause shadowing artifacts. |
| `SourceRadius` | `?float` | Radius of the source capsule shape in centimeters around the local Z axis. Note that light shapes which intersect shadow casting geometry can cause shadowing artifacts. |
| `SpecularScale` | `?float` | Multiplier on specular highlights. Can be used to artistically remove highlights mimicking polarizing filters or photo touch up. Any value besides 1.0 is not physical. 0.0 means no specular contribution from this light. |
| `TickEvents` | `?tick_events` | Set callbacks to `TickEvents.PrePhysics` and `TickEvents.PostPhysics` to receive per-frame updates before and after physics is updated on your object. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Disable`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/light_component/disable) | Disables rendering of this light. |
| [`Enable`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/light_component/enable) | Enables rendering of this light. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/light_component/isenabled) | Succeeds if the component is enabled, fails if it's disabled. |
| [`IsInScene`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/isinscene) | Succeeds if the component is currently in the scene.   - After `OnAddedToScene` is called this call succeeds. - After `OnRemovingFromScene` is called this call fails. |
| [`IsSimulating`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/issimulating) | Succeeds if the component is currently simulating.   - After `OnBeginSimulation` is called this call succeeds. - After `OnEndSimulation` is called this call fails. |
| [`OnAddedToScene`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onaddedtoscene) | Called when the component is added to the scene by parenting it under the simulation entity or another entity already in the scene.   - Querying for components in the scene is valid after this phase completes. |
| [`OnBeginSimulation`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onbeginsimulation) | Called when the component begins simulating within the scene.   - Use this to set up TickEvent callbacks or other setup that must be guaranteed to complete immediately. - `OnAddedToScene` is guaranteed to run before `OnBeginSimulation`. |
| [`OnEndSimulation`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onendsimulation) | Called when the component ends simulation within the scene.   - Simulation ends on a component when the experience resets, the parent entity is removed from the scene. - Cached TickEvents cancelables should be canceled in `OnEndSimulation`. - `OnSimulate` task will be canceled before `OnEndSimulation` is called. - `OnEndSimulation` is only called on components that have already had `OnBeginSimulation` called. |
| [`OnRemovingFromScene`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onremovingfromscene) | Called when the component is about to be removed from the scene.   - Components are removed from a scene when the parent entity is removed from the scene. - `OnRemovingFromScene` is only called on components that have already had `OnAddedToScene` called. |
| [`OnSimulate`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/onsimulate) | Called when the component begins simulating within the scene.   - Use this to add asynchronous/suspends update logic for a component. - `OnBeginSimulation` is guaranteed to run before `OnSimulate`. - `OnSimulate` will be cancelled before `OnEndSimulation` |
| [`RemoveFromEntity`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/removefromentity) | Removes the component from the entity.   - Removed components are removed from the scene and can only be added back to the same entity. - Flows through `OnEndSimulation`-> `OnRemovingFromScene`. |
| [`SendDown`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/component/senddown) | Send a scene event to this component. Return true to consume the event and halt propogation. |
