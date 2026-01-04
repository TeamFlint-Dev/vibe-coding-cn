# MakeCanvasSlot function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/makecanvasslot
> **爬取时间**: 2025-12-27T07:07:35.083598

---

Make a canvas slot for fixed position widget.
If Size is set, then the Offsets is calculated and the SizeToContent is set to false.
If Size is not set, then Right and Bottom are set to zero and are not used. The widget size will be automatically calculated. The SizeToContent is set to true.
The widget is not anchored and will not move if the parent is resized.
The Anchors is set to zero.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/UI }` |

`MakeCanvasSlot<public><native>(Widget:widget, Position:vector2, Size:vector2, ZOrder:int, Alignment:vector2)<computes>:`[`canvas_slot`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/canvas_slot)

## Parameters

`MakeCanvasSlot` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `Widget` | `widget` |  |
| `Position` | `vector2` |  |
| `Size` | `vector2` |  |
| `ZOrder` | `int` |  |
| `Alignment` | `vector2` |  |

## Attributes, Specifiers, and Effects

### Specifiers

The following specifiers determine how you can interact with `MakeCanvasSlot` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |
| `native` | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions that a developer can then fill out its implementation. You can use this specifier on classes, interfaces, enums, methods, and data. |

### Effects

The following effects determine how `MakeCanvasSlot` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
