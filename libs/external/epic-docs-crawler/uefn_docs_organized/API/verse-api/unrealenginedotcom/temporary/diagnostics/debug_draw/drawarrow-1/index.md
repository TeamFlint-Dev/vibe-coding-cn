# DrawArrow function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/diagnostics/debug_draw/drawarrow-1
> **爬取时间**: 2025-12-27T07:17:40.935733

---

Draws an arrow pointing from Start to End locations, and using the provided draw parameters.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/Diagnostics }` |

`DrawArrow<public>(Start:vector3, End:vector3, ArrowSize:float, Color:color, Thickness:float, DrawDurationPolicy:debug_draw_duration_policy, Duration:float)<transacts>:void`

## Parameters

`DrawArrow` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Start` | `vector3` |  |
| `End` | `vector3` |  |
| `ArrowSize` | `float` |  |
| `Color` | `color` |  |
| `Thickness` | `float` |  |
| `DrawDurationPolicy` | `debug_draw_duration_policy` |  |
| `Duration` | `float` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `DrawArrow` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `DrawArrow` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `transacts` | This effect indicates that any actions performed by the function can be rolled back. The transacts effect is required any time a mutable variable (`var`) is written. You'll be notified when you compile your code if the `transacts` effect was added to a function that can't be rolled back. Note that this check is not done for functions with the `native` specifier. |
