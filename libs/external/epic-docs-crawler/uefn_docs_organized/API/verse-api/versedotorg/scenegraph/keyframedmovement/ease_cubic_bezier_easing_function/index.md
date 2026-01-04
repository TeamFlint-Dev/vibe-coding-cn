# ease_cubic_bezier_easing_function class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/ease_cubic_bezier_easing_function
> **爬取时间**: 2025-12-27T02:45:07.203474

---

`Ease` animations start slowly, speed up, then end slowly. The speed of the animation is slightly slower at the end than the start.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Verse.org/SceneGraph/KeyframedMovement }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `easing_function`:

| Name | Description |
| --- | --- |
| [`easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/easing_function) | Base class for an animation easing function. |
| [`cubic_bezier_easing_function`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/cubic_bezier_easing_function) | Cubic bezier easing function. See CubicBezierEasingFunctions for some basic easing values. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `X0` | `float` |  |
| `X0` | `float` |  |
| `X1` | `float` |  |
| `X1` | `float` |  |
| `Y0` | `float` |  |
| `Y0` | `float` |  |
| `Y1` | `float` |  |
| `Y1` | `float` |  |

### Functions

| Function Name | Description |
| --- | --- |
| [`Evaluate`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/cubic_bezier_easing_function/evaluate) |  |
| [`Evaluate`](/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/keyframedmovement/easing_function/evaluate) |  |
