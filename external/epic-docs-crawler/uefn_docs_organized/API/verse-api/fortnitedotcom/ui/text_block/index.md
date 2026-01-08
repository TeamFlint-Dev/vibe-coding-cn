# text_block class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/text_block>
> **爬取时间**: 2025-12-27T01:08:09.553576

---

Text block widget. Displays text to the user.

|  |  |
| --- | --- |
| Verse `using` statement | `using { /Fortnite.com/UI }` |

## Inheritance Hierarchy

This class is derived from the following hierarchy, starting with `widget`:

| Name | Description |
| --- | --- |
| [`widget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget) | Base class for all UI elements drawn on the `player`'s screen. |
| [`text_base`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base) | Base widget for text widget. |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `DefaultJustification` | `text_justification` | The justification to display to the user. Used only during initialization of the widget and not modified by SetJustification. |
| `DefaultOverflowPolicy` | `text_overflow_policy` | The policy that determine what happens when the text is longer than its allowed length. Used only during initialization of the widget and not modified by SetOverflowPolicy. |
| `DefaultShadowColor` | `color` | The color of the shadow. Used only during initialization of the widget and not modified by SetShadowColor. |
| `DefaultShadowOffset` | `?vector2` | The direction the shadow is cast. Used only during initialization of the widget and not modified by SetShadowOffset. |
| `DefaultShadowOpacity` | `float` | The opacity of the shadow. Used only during initialization of the widget and not modified by SetShadowOpacity. |
| `DefaultText` | `message` | The text to display to the user. Used only during initialization of the widget and not modified by SetText. |
| `DefaultTextColor` | `color` | The color of the displayed text. Used only during initialization of the widget and not modified by SetTextColor. |
| `DefaultTextOpacity` | `float` | The opacity of the displayed text. Used only during initialization of the widget and not modified by SetTextOpacity. |
| `DefaultTextSize` | `float` | The size of the displayed text. Used only during initialization of the widget and not modified by SetTextSize. |

### Functions

| Function Name | Description |
| --- | --- |
| [`GetJustification`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/getjustification) | Gets the text justification in the widget. |
| [`GetOverflowPolicy`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/getoverflowpolicy) | Gets the policy that determine what happens when the text is longer than its allowed length. |
| [`GetParentWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getparentwidget) | Returns the `widget`'s parent `widget`. Fails if no parent exists, such as if this `widget` is not in the `player_ui` or is itself the root `widget`. |
| [`GetRootWidget`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getrootwidget) | Returns the `widget` that added this `widget` to the `player_ui`. The root `widget` will return itself. Fails if this `widget` is not in the `player_ui`. |
| [`GetShadowColor`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/text_block/getshadowcolor) | Gets the color of the shadow. |
| [`GetShadowOffset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/text_block/getshadowoffset) | Gets the direction the shadow is cast. |
| [`GetShadowOpacity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/text_block/getshadowopacity) | Gets the opacity of the shadow. |
| [`GetText`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/gettext) | Gets the text currently in the widget. |
| [`GetTextColor`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/gettextcolor) | Gets the color of the displayed text. |
| [`GetTextOpacity`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/gettextopacity) | Gets the opacity of the displayed text. |
| [`GetTextSize`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/gettextsize) | Gets the size of the displayed text. |
| [`GetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/getvisibility) | Returns the current `widget_visibility` state. |
| [`IsEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/isenabled) | `true` if this `widget` can be modified interactively by the player. |
| [`SetEnabled`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setenabled) | Enables or disables whether the `player` can interact with this `widget`. |
| [`SetJustification`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/setjustification) | Sets the text justification in the widget. |
| [`SetOverflowPolicy`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/setoverflowpolicy) | Sets the policy that determine what happens when the text is longer than its allowed length. |
| [`SetShadowColor`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/text_block/setshadowcolor) | Sets the color of the shadow. |
| [`SetShadowOffset`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/text_block/setshadowoffset) | Sets the direction the shadow is cast. |
| [`SetShadowOpacity`](/documentation/en-us/fortnite/verse-api/fortnitedotcom/ui/text_block/setshadowopacity) | Sets the opacity of the shadow. |
| [`SetText`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/settext) | Sets the text displayed in the widget. |
| [`SetTextColor`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/settextcolor) | Sets the color of the displayed text. |
| [`SetTextOpacity`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/settextopacity) | Sets the opacity of the displayed text. |
| [`SetTextSize`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/text_base/settextsize) | Sets the size of the displayed text. |
| [`SetVisibility`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/ui/widget/setvisibility) | Shows or hides the `widget` without removing itself from the containing `player_ui`. See `widget_visibility` for details. |
