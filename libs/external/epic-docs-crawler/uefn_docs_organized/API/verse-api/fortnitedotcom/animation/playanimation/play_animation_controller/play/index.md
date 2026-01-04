# Play function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/animation/playanimation/play_animation_controller/play
> **爬取时间**: 2025-12-27T07:13:05.578248

---

Start an animation sequence and obtain an instance to query and manipulate.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/Animation/PlayAnimation }` |

`Play<public>(AnimationSequence:animation_sequence, PlayRate:float, PlayCount:float, StartPositionSeconds:float, BlendInTime:float, BlendOutTime:float)<transacts><no_rollback>:`[`play_animation_instance`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/animation/playanimation/play_animation_instance)

## Parameters

`Play` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `AnimationSequence` | `animation_sequence` |  |
| `PlayRate` | `float` |  |
| `PlayCount` | `float` |  |
| `StartPositionSeconds` | `float` |  |
| `BlendInTime` | `float` |  |
| `BlendOutTime` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `Play` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `Play` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
| `no_rollback` | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone and so the function cannot be used in a failure context. This effect cannot be manually specified. |
