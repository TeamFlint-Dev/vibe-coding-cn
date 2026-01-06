# (Entity:entity).FindSweepHits extension

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/findsweephits
> **爬取时间**: 2025-12-27T00:49:53.056865

---

Find objects in the scene that would intersect this entity if it were swept from its location along the Displacement vector. Returns the first object interacting as collision\_interaction.Block, and all objects interacting as collision\_interaction.Overlap encountered before the first block. Hits are sorted by hit distance, so the blocking hit will be last.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph }` |

`(Entity:entity).FindSweepHits<public>(Displacement:vector3)<transacts>:generator(sweep_hit)`

## Parameters

`FindSweepHits` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Entity` | `entity` |  |
| `Displacement` | `vector3` |  |

## Attributes, Specifiers, and Effects

The following attributes, specifiers, and effects determine how you can interact with `FindSweepHits` in your programs, as well as how it behaves in your programs and UEFN. For the complete list of attributes, specifiers, and effects; see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

### Attributes

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 2930` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |

### Specifiers

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
