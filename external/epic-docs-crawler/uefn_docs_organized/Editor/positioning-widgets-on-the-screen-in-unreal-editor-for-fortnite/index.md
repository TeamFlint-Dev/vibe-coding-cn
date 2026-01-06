# Positioning Widgets on the Screen

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/positioning-widgets-on-the-screen-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:16:45.705402

---

You position widgets on the screen with the [canvas widget](https://dev.epicgames.com/documentation/en-us/fortnite/widget-types-in-unreal-editor-for-fortnite) by adding widgets to its canvas slots.

[![Button with text Center displayed in middle of the screen](https://dev.epicgames.com/community/api/documentation/image/8509e7db-ca4b-4f19-821b-cd03e12b5917?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8509e7db-ca4b-4f19-821b-cd03e12b5917?resizing_type=fit)

The following code is an example of a canvas widget that will display the text "Center" on a button in the middle of the screen.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}

hello_world_device := class(creative_device):

    # Set the Button device in the Editor to reference the device in the level
    @editable
    MyButton : button_device = button_device{}

    # A localizable message to display as text in the UI
    TextForMyUI<localizes> : message = "Center"

    # A mapping between the Player and the widget that may have been added to their UI
    var MaybeMyUIPerPlayer : [player]?canvas = map{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =
        MyButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

    # A custom UI can only be associated with a specific player, and only that player can see it
    HandleButtonInteraction(Agent : agent) : void =
        # Agents can be a player or AI, but you can only get the UI of a player
        # so you must cast the Agent, who interacted with the Button device, to the player type
        if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
            if (MyUI := MaybeMyUIPerPlayer[InPlayer]?):
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[InPlayer] = false) {}
            else:
                NewUI := CreateMyUI()
                PlayerUI.AddWidget(NewUI)
                if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}

    # A canvas widget that displays a button with the text "Center" in the middle of the screen
    CreateMyUI() : canvas =
        MyCanvas : canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI}

        return MyCanvas
```

## Canvas Slot Settings

You can change the following fields of a canvas slot to position widgets in the canvas:

| Field | Description | Values |
| --- | --- | --- |
| **Anchors** | The location in the canvas where the widget is anchored, specified as a percentage of the canvas. When the canvas resizes, the widget stays attached to its anchors in the new canvas size. You can specify the maximum and minimum anchors of the widget, which can change the size of the widget when **SizeToContent** is enabled. | The range for the X and Y fields of an anchor is 0 to 1, where `vector2{X := 0.0, Y := 0.0}` is the upper left of the canvas and `vector2{X := 1.0, Y := 1.0}` is the bottom right of the canvas. |
| **Alignment** | The part of the widget that is at the anchor location. For example, if the Alignment field is `vector2{X := 0.5, 1.0}`, then the bottom center of the widget is positioned at the anchor location. | The range for the X and Y fields for Alignment is 0 to 1, where `vector2{X := 0.0, Y := 0.0}` is the upper left of the widget and `vector2{X := 1.0, Y := 1.0}` is the bottom right of the widget. |
| **Offsets** | This field can affect the size and position of the widget in two ways:   - When the fields **Anchors** and **Alignment** are both set, this field can specify the offset from the anchor to position the widget. - When the widget is anchored in a way that the size does not make sense, this field can represent the size space allocated for the widget. However, if **SizeToContent** is enabled, the widget will take its needed size. | The margin must be in the range 0 to 1080. This resolution will be scaled to fit the resolution of the player’s screen. |
| **SizeToContent** | When enabled, sizes the widget as desired. | `true` / `false` to represent whether this option is enabled or not. |

The location and layout of your UI elements is platform-dependent. The resolution of the UI will be determined by the platform the player is using, and the UI will be scaled to fit.

Generally, your workflow for positioning a widget will be setting the fields in the following Order:

1. **Anchors** to specify where the widget should appear on the canvas, even when the canvas is resized.
2. **Alignment** to specify what part of the widget is positioned at the anchor location.
3. **Offsets** to apply an offset from the anchor point.
4. **SizeToContent** to size the widget as needed.

The following shows how changing the Offsets Margin changes where the widget appears relative to the anchor location.

![Offsets Top Margin is 0.0](https://dev.epicgames.com/community/api/documentation/image/a83d1bd6-8273-42d2-ae24-88af08517f12?resizing_type=fit&width=1920&height=1080)

![Offsets Top Margin is 50.0](https://dev.epicgames.com/community/api/documentation/image/c1dc4d71-5e15-43d8-95b2-86e6e920331f?resizing_type=fit&width=1920&height=1080)

Offsets Top Margin is 0.0

Offsets Top Margin is 50.0

The following shows how changing the Alignment field affects which part of the widget is at the anchor location.

![Alignment set to middle of widget, vector2{X := 0.5, Y := 0.5}](https://dev.epicgames.com/community/api/documentation/image/3aea6a86-2fcd-46f1-b4f6-9f0edea0e3d6?resizing_type=fit&width=1920&height=1080)

![Alignment set to top left of widget, vector2{X := 0.0, Y := 0.0}](https://dev.epicgames.com/community/api/documentation/image/1a0ca86e-6f52-4ac9-8164-7064f841a70f?resizing_type=fit&width=1920&height=1080)

Alignment set to middle of widget, vector2{X := 0.5, Y := 0.5}

Alignment set to top left of widget, vector2{X := 0.0, Y := 0.0}

The following shows how changing the Minimum and Maximum Anchors can affect the size of a widget.

![Minimum and Maximum Anchors are same: vector2{X := 0.5, Y := 0.5}](https://dev.epicgames.com/community/api/documentation/image/cffa1eed-5a5b-4c83-b042-2826318d226e?resizing_type=fit&width=1920&height=1080)

![Minimum and Maximum Anchors are different: Minimum := vector2{X := 0.4, Y := 0.4}, Maximum := vector2{X := 0.6, Y := 0.6}](https://dev.epicgames.com/community/api/documentation/image/5614025b-393c-4c66-b9cb-db7e6905298a?resizing_type=fit&width=1920&height=1080)

Minimum and Maximum Anchors are same: vector2{X := 0.5, Y := 0.5}

Minimum and Maximum Anchors are different: Minimum := vector2{X := 0.4, Y := 0.4}, Maximum := vector2{X := 0.6, Y := 0.6}

## Example of Positioning Widgets on the Screen

The following code is an example of positioning widgets at various points around the screen.

[![Widgets positioned around the canvas](https://dev.epicgames.com/community/api/documentation/image/38199b15-2488-423c-9eef-df466615b15b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38199b15-2488-423c-9eef-df466615b15b?resizing_type=fit)

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}

hello_world_device := class(creative_device):

    # Set the Button device in the Editor to reference the device in the level
    @editable
    MyButton : button_device = button_device{}

    # Localizable messages to display as text in the UI
    TextForMyUI<localizes>(InText : string) : message = "{InText}"

    # A mapping between the Player and the widget that may have been added to their UI
    var MaybeMyUIPerPlayer : [player]?canvas = map{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =
        MyButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

    # A custom UI can only be associated with a specific player, and only that player can see it
    HandleButtonInteraction(Agent : agent) : void =
        # Agents can be a player or AI, but you can only get the UI of a player
        # so you must cast the Agent, who interacted with the Button device, to the player type
        if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
            if (MyUI := MaybeMyUIPerPlayer[InPlayer]?):
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[InPlayer] = false) {}
            else:
                NewUI := CreateMyUI()
                PlayerUI.AddWidget(NewUI)
                if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}

    # A canvas widget that displays a button with text at various positions around the screen
    CreateMyUI() : canvas =
        MyCanvas : canvas = canvas:
            Slots := array:
                canvas_slot: # Upper Left of Screen
                    Anchors := anchors{Minimum := vector2{X := 0.0, Y := 0.0}, Maximum := vector2{X := 0.0, Y := 0.0}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.0, Y := 0.0}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI("Upper Left")}
                canvas_slot: # Upper Middle of Screen
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.0}, Maximum := vector2{X := 0.5, Y := 0.0} }
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.0}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI("Upper Middle")}
                canvas_slot: # Upper Right of Screen
                    Anchors := anchors{Minimum := vector2{X := 1.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 0.0}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 1.0, Y := 0.0}
                    SizeToContent := true
                    Widget := button_loud{ DefaultText := TextForMyUI("Upper Right")}
                canvas_slot: # Middle Left of Screen
                    Anchors := anchors{ Minimum := vector2{X := 0.0, Y := 0.5}, Maximum := vector2{X := 0.0, Y := 0.5}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.0, Y := 0.5}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI("Middle Left")}
                canvas_slot: # Center of Screen
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI("Center")}
                canvas_slot: # Middle Right of Screen
                    Anchors := anchors{Minimum := vector2{X := 1.0, Y := 0.5}, Maximum := vector2{X := 1.0, Y := 0.5}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 1.0, Y := 0.5}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI("Middle Right")}
                canvas_slot: # Lower Left of Screen
                    Anchors := anchors{Minimum := vector2{X := 0.0, Y := 1.0}, Maximum := vector2{X := 0.0, Y := 1.0}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.0, Y := 1.0}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI("Lower Left")}
                canvas_slot: # Lower Middle of Screen
                    Anchors := anchors{ Minimum := vector2{X := 0.5, Y := 1.0}, Maximum := vector2{X := 0.5, Y := 1.0}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 1.0}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI("Lower Middle")}
                canvas_slot: # Lower Right of Screen
                    Anchors := anchors{Minimum := vector2{X := 1.0, Y := 1.0}, Maximum := vector2{X := 1.0, Y := 1.0}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 1.0, Y := 1.0}
                    SizeToContent := true
                    Widget := button_loud{DefaultText := TextForMyUI("Lower Right")}

        return MyCanvas
```
