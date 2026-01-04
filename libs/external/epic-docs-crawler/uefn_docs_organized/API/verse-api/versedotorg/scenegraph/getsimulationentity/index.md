# (InEntity:entity).GetSimulationEntity extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/getsimulationentity
> **爬取时间**: 2025-12-27T00:54:00.576258

---

Returns the simulation entity parent for this entity.

- The simulation entity is the rootmost entity in an experience.
- Fails if this entity is not currently in the scene.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

`(InEntity:entity).GetSimulationEntity<public><native>()<transacts><decides>:`[`entity`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/entity)

## Parameters

`GetSimulationEntity` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `InEntity` | `entity` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `GetSimulationEntity` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `decides` | Indicates that the function can fail, and that calling this function is a [failable expression](/documentation/en-us/fortnite/failure-in-verse#failableexpression). Function definitions with the `decides` effect must also have the `transacts` effect, which means the actions performed by this function can be rolled back (as if the actions were never performed), if there's a failure anywhere in the function. |
