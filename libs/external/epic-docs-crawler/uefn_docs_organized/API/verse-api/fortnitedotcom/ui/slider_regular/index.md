# slider_regular class

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular
> **爬取时间**: 2025-12-27T01:06:58.536432

---

Slider with a text value. Displays a slider, its progress bar and value.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/UI }` |

## Inheritance Hierarchy

This class is derived from `widget`.

| Name | Description |
| --- | --- |
| [`widget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget) | Base class for all UI elements drawn on the `player`'s screen. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `DefaultMaxValue` | `float` | The maximum value that the slider can haver. Used only during initialization of the widget and not modified by SetMaxValue. |
| `DefaultMinValue` | `float` | The minimum value that the slider can haver. Used only during initialization of the widget and not modified by SetMinValue. |
| `DefaultStepSize` | `float` | The amount to adjust the value by, when using a controller or keyboard. Used only during initialization of the widget and not modified by SetStepSize. |
| `DefaultValue` | `float` | The value to display to the user. Used only during initialization of the widget and not modified by SetValue. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetMaxValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/getmaxvalue) | Gets the maximum value of the slider. |
| [`GetMinValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/getminvalue) | Gets the minimum value of the slider. |
| [`GetParentWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getparentwidget) | Returns the `widget`'s parent `widget`. Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`. |
| [`GetRootWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getrootwidget) | Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself. Fails if this `widget` is not in the `player_ui`. |
| [`GetStepSize`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/getstepsize) | Gets the amount to adjust the value by. |
| [`GetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/getvalue) | Gets the value of the slider. |
| [`GetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getvisibility) | Returns the current `widget_visibility` state. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/isenabled) | `true` if this `widget` can be modified interactively by the player. |
| [`OnValueChanged`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/onvaluechanged) | Subscribable event that fires when the value of the slider has changed. |
| [`SetEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setenabled) | Enables or disables whether the `player` can interact with this `widget`. |
| [`SetMaxValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/setmaxvalue) | Sets the maximum value of the slider, will enforce that the sliders maximum value is always larger than or equal to the minimum value. |
| [`SetMinValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/setminvalue) | Sets the minimum value of the slider, will enforce that the sliders maximum value is always larger than or equal to the minimum value. |
| [`SetStepSize`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/setstepsize) | Sets the amount to adjust the value by, when using a controller or keyboard. |
| [`SetValue`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/slider_regular/setvalue) | Sets the value of the slider, will clamp the value to be within the sliders minimum and maximum value. |
| [`SetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setvisibility) | Shows or hides the `widget` without removing itself from the containing `player_ui`. See `widget_visibility` for details. |
