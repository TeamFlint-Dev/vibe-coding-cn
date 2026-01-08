# item_two_shot_shotgun_mythic class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/itemization/vibinitems/item_two_shot_shotgun_mythic>
> **爬取时间**: 2025-12-27T03:35:43.029325

---

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Itemization/VibinItems }` |

## Inheritance Hierarchy

This class is derived from `entity`.

| Name | Description |
| --- | --- |
| [`entity`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity) | Entities are the base object in the SceneGraph.   - Objects in experiences are constructed of one or more entities. - Entities are hierarchical. You can query your parent using `GetParent` and add child entities using `AddEntities`. - Behavior is added to entities through `component`s. You can add new components using `AddComponents`. - The structure and content of entities is dynamic and be changed at any time through your experience. Deriving from entity   In the SceneGraph system a class that derives from `entity` is also known as a prefab. Prefabs are useful when you want to spawn/re-use a collection of entities and components many times within your game. Primarily prefabs are authored through the editor, with their Verse classes generated as part of the build into the projects Assets.digest.verse file.  While you can create base prefabs for common game object types like a vehicle or character, we highly recommended that you do not add code directly to the entity class, and instead keep logic in components. Keeping logic and data in components allows you to restructure your prefabs throughout production of your experience, without needing to massively refactor your class structure. |

## Members

This class has functions, but no data members.

### Functions

| Function Name | Description |
| --- | --- |
| [`AddComponents`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/addcomponents) | Adds the provided components to the entity.   - If a component is not allowed to be added to this entity it is skipped.   Note: When called during the AddedToScene or BeginSimulation phase, it will make sure the added component has achieved the corresponding phase. - Components are added following these rules:   1. All components are added to the entity child list.   2. All components have `OnAddedToScene` called (if this entity is in the scene).   3. All components have `OnBeginSimulation` called (if this entity is simulating). |
| [`AddEntities`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/addentities) | Adds the provided entities as children of this entity.   - If child entity already has a parent, removes the entity from its current parent and adds it to the new one. - Added child entities will move through their lifetime methods until they match the state of the new parent. |
| [`GetComponent`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/getcomponent) | Succeeds and returns the child component of type `component_type` if it exists and is accessible from the calling context. Note: When called during the AddedToScene or BeginSimulation phase, it will make sure the returned component has achieved the corresponding phase. Fails if no component of `component_type` exists or can be accessed. |
| [`GetComponents`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/getcomponents) | Returns the child components belonging to this entity which are accessible from the calling context. |
| [`GetEntities`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/getentities) | Returns the child entities belonging to this entity which are accessible from the calling context.   - This method only gets the direct entity children. To query multiple levels down the entity structure use   the Find\* query methods instead. |
| [`GetParent`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/getparent) | Returns the parent entity of this entity.   - The parent entity controls the lifetime of its child entities and components. When an entity   is removed from the scene, all its child entities and components will be removed as well. - Method fails if there is currently no parent entity. |
| [`RemoveFromParent`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/removefromparent) | Removes this entity from its parent. This is used to remove entities from the scene.   - Components on this entity and its children will run through `OnEndSimulation` -> `OnRemovingFromScene`. - Entity can be added back later by using `NewParent.AddEntities`. |
| [`SendDown`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/senddown) | Send a scene event to this entity and then down the hierarchy. First, SendDown will be invoked on each component on this entity. Next, SendDown will be invoked on each child entity. Consuming the event at any point will halt propogation. Returns true if any participant consumed the event. |
| [`SendUp`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity/sendup) | Send a scene event to this entity and then up the hierarchy. First, SendDown will be invoked on each component on this entity. Next, SendUp will be invoked on this entity's parent. Consuming the event at any point will halt propogation. Returns true if any participant consumed the event. |
