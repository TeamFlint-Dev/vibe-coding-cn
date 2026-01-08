# Making Widgets Interactable

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/making-widgets-interactable-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:16:39.259602

---

You can make your widgets interactable by:

- Adding the argument `player_ui_slot{InputMode := ui_input_mode.All }` when you add a widget using the function `AddWidget()`.
- Binding an event handler to the widget’s event.

Currently, you can make the following widgets interactable:

- [Button](widget-types-in-unreal-editor-for-fortnite#button)
- [Slider](widget-types-in-unreal-editor-for-fortnite#slider)

The following sections are examples of how to make these widgets interactable.

## Button Interactions

[![Interacting with a button Verse UI](https://dev.epicgames.com/community/api/documentation/image/b45725e4-6cb9-463e-8caa-6754ab80e34b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b45725e4-6cb9-463e-8caa-6754ab80e34b?resizing_type=fit)

Follow these steps to create a UI with a button, and add behavior that prints the selected button text to the screen when the player interacts with the button:

1. Open the Verse file you created in [Removing a Widget](creating-and-removing-widgets-in-unreal-editor-for-fortnite#removingawidget).
2. Create a function named `CreateMyUI()` where you’ll create the UI.
    `CreateMyUI() : canvas =
   MyUIButton : button_loud = button_loud{DefaultText := TextForMyUI}
   MyInteractableButtons : canvas = canvas:
   Slots := array:
   canvas_slot:
   Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
   Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
   Alignment := vector2{X := 0.5, Y := 0.5}
   SizeToContent := true
   Widget := MyUIButton
   return MyInteractableButtons`
3. Change the type for `MaybeMyUIPerPlayer` to `[player]?canvas`:
    `var MaybeMyUIPerPlayer : [player]?canvas = map{}`
4. Change the assignment for `NewUI` to call your new function `CreateMyUI()`.

   ```verse
        # UI are added per Player.
        HandleButtonInteraction(Agent : agent) : void =
            if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                if (MyUI := MaybeMyUIPerPlayer[InPlayer]?):
                    PlayerUI.RemoveWidget(MyUI)
                    if (set MaybeMyUIPerPlayer[InPlayer] = false) {}
                else:
                    NewUI := CreateMyUI()
                    PlayerUI.AddWidget(NewUI)
                    if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}
   ```

5. Add the argument `player_ui_slot{InputMode := ui_input_mode.All}` when you add a new widget so the player can use their cursor on the canvas when it’s created.

   ```verse
        # UI are added per Player.
        HandleButtonInteraction(Agent : agent) : void =
            if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                if (MyUI := MaybeMyUIPerPlayer[InPlayer]?):
                    PlayerUI.RemoveWidget(MyUI)
                    if (set MaybeMyUIPerPlayer[InPlayer] = false) {}
                else:
                    NewUI := CreateMyUI()
                    PlayerUI.AddWidget(NewUI, player_ui_slot{InputMode := ui_input_mode.All})
                    if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}
   ```

6. All UI buttons have an `OnClick()` `listenable` event that you can subscribe to. The event handler is expected to have a `void` return type and one parameter with the type `widget_message`.
    `CreateMyUI() : canvas =
   MyUIButton : button_loud = button_loud{DefaultText := TextForMyUI}
   MyUIButton.OnClick().Subscribe(HandleSelectedUIButton)
   MyInteractableButtons : canvas = canvas:
   Slots := array:
   canvas_slot:
   Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
   Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
   Alignment := vector2{X := 0.5, Y := 0.5}
   SizeToContent := true
   Widget := MyUIButton
   return MyInteractableButtons
   HandleSelectedUIButton(Message : widget_message) : void =

   # Define what happens when the player presses the button`

7. In `HandleSelectedUIButton`, print the button’s text to the screen and remove the widget from the screen. A `widget_message` knows what player and UI element selected it, so you can use that information to get the text of the button and find the widget that’s displayed to the player to remove it from the screen.

   ```verse
        HandleSelectedUIButton(Message : widget_message) : void =
            if (PlayerUI := GetPlayerUI[Message.Player], MyUI := MaybeMyUIPerPlayer[Message.Player]?, SelectedButton := text_button_base[Message.Source]):
                Print("Player selected {SelectedButton.GetText()}")
                PlayerUI.RemoveWidget(MyUI)
                if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
   ```

8. The following is the complete code for this example.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/UI }
        using { /Fortnite.com/UI }
        using { /UnrealEngine.com/Temporary/SpatialMath }

        hello_world_device := class(creative_device):

            # Set the Button device in the Editor to reference the device in the level
            @editable
            MyButton : button_device = button_device{}

            # Localizable message to display as text in the UI
            TextForMyUI<localizes> : message = "Option"

            # A mapping between the Player and the widget that may have been added to their UI
            var MaybeMyUIPerPlayer : [player]?canvas = map{}

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends> : void =
                MyButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

            # A custom UI can only be associated with a specific player, and only that player can see it
            HandleButtonInteraction(Agent : agent) : void =
                if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                    if (MyUI := MaybeMyUIPerPlayer[InPlayer]?):
                        PlayerUI.RemoveWidget(MyUI)
                        if (set MaybeMyUIPerPlayer[InPlayer] = false) {}
                    else:
                        NewUI := CreateMyUI()
                        PlayerUI.AddWidget(NewUI, player_ui_slot{InputMode := ui_input_mode.All})
                        if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}

            CreateMyUI() : canvas =
                MyUIButton : button_loud = button_loud{DefaultText := TextForMyUI}

                MyUIButton.OnClick().Subscribe(HandleSelectedUIButton)

                MyInteractableButtons : canvas = canvas:
                    Slots := array:
                        canvas_slot:
                            Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                            Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                            Alignment := vector2{X := 0.5, Y := 0.5}
                            SizeToContent := true
                            Widget := MyUIButton

                return MyInteractableButtons

            HandleSelectedUIButton(Message : widget_message) : void =
                if (PlayerUI := GetPlayerUI[Message.Player], MyUI := MaybeMyUIPerPlayer[Message.Player]?, SelectedButton := text_button_base[Message.Source]):
                    Print("Player selected {SelectedButton.GetText()}")
                    PlayerUI.RemoveWidget(MyUI)
                    if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
   ```

## Slider Interactions

Follow these steps to create a UI with a slider, and add behavior that prints the set value to the screen when the player interacts with the slider:

1. Open the Verse file you created in [Button Interactions](https://dev.epicgames.com/documentation/en-us/fortnite/making-widgets-interactable-in-unreal-editor-for-fortnite).
2. Update the function named `CreateMyUI()` with the slider.
    `CreateMyUI() : canvas =
   MyUIButton : button_loud = button_loud{DefaultText := TextForMyUI}
   MyUIButton.OnClick().Subscribe(HandleSelectedUIButton)
   MyUISlider : slider_regular = slider_regular:
   DefaultValue := 5.0
   DefaultMinValue := 0.0
   DefaultMaxValue := 10.0
   DefaultStepSize := 0.5
   MyInteractableWidgets : canvas = canvas:
   Slots := array:
   canvas_slot:
   Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
   Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
   Alignment := vector2{X := 0.5, Y := 0.5}
   SizeToContent := true
   Widget := MyUISlider
   canvas_slot:
   Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.6}, Maximum := vector2{X := 0.5, Y := 0.6}}
   Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
   Alignment := vector2{X := 0.5, Y := 0.5}
   SizeToContent := true
   Widget := MyUIButton
   return MyInteractableWidgets`
3. All UI sliders have an `OnValueChanged()` `listenable` event that you can subscribe to. The event handler is expected to have a `void` return type and one parameter with the type `widget_message`.
    `CreateMyUI() : canvas =
   MyUIButton : button_loud = button_loud{DefaultText := TextForMyUI}
   MyUIButton.OnClick().Subscribe(HandleSelectedUIButton)
   MyUISlider : slider_regular = slider_regular:
   DefaultValue := 5.0
   DefaultMinValue := 0.0
   DefaultMaxValue := 10.0
   DefaultStepSize := 0.5
   MyUISlider.OnValueChanged().Subscribe(HandleValueChangedUISlider)
   MyInteractableWidgets : canvas = canvas:
   Slots := array:
   canvas_slot:
   Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
   Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
   Alignment := vector2{X := 0.5, Y := 0.5}
   SizeToContent := true
   Widget := MyUISlider
   canvas_slot:
   Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.6}, Maximum := vector2{X := 0.5, Y := 0.6}}
   Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
   Alignment := vector2{X := 0.5, Y := 0.5}
   SizeToContent := true
   Widget := MyUIButton
   return MyInteractableWidgets
   HandleValueChangedUISlider(Message : widget_message) : void =

   # Define what happens when the player changes the value of the slider`

4. In `HandleValueChangedUISlider`, print the slider’s value to the screen. A `widget_message` knows which player interacted and what UI element they selected, so you can use that information to get the value of the slider and find the widget that’s displayed to the player.

   ```verse
        HandleValueChangedUISlider(Message : widget_message) : void =
            if:
                PlayerUI := GetPlayerUI[Message.Player]
                MyUI := MaybeMyUIPerPlayer[Message.Player]?
                ChangedSlider := slider_regular[Message.Source]
            then:
                Print("Player changed slider value to {ChangedSlider.GetValue()}")
   ```

5. The following is the complete code for this example.

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/UI }
        using { /Fortnite.com/UI }
        using { /UnrealEngine.com/Temporary/SpatialMath }

        interactable_slider := class(creative_device):

            # Set the Button device in the Editor to reference the device in the level
            @editable
            MyButton : button_device = button_device{}

            # Localizable message to display as text in the UI
            TextForMyUI<localizes> : message = "Close"

            # A mapping between the Player and the widget that may have been added to their UI
            var MaybeMyUIPerPlayer : [player]?canvas = map{}

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends> : void =
                MyButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

            # A custom UI can only be associated with a specific player, and only that player can see it
            HandleButtonInteraction(Agent : agent) : void =
                if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                    if (MyUI := MaybeMyUIPerPlayer[InPlayer]?):
                        PlayerUI.RemoveWidget(MyUI)
                        if (set MaybeMyUIPerPlayer[InPlayer] = false) {}
                    else:
                        NewUI := CreateMyUI()
                        PlayerUI.AddWidget(NewUI, player_ui_slot{InputMode := ui_input_mode.All})
                        if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}

            # Create a UI with an interactable slider, and a button that removes the UI from the screen
            CreateMyUI() : canvas =
                MyUIButton : button_loud = button_loud{DefaultText := TextForMyUI}

                MyUIButton.OnClick().Subscribe(HandleSelectedUIButton)

                MyUISlider : slider_regular = slider_regular:
                    DefaultValue := 5.0
                    DefaultMinValue := 0.0
                    DefaultMaxValue := 10.0
                    DefaultStepSize := 0.5

                MyUISlider.OnValueChanged().Subscribe(HandleValueChangedUISlider)

                MyInteractableWidgets : canvas = canvas:
                    Slots := array:
                        canvas_slot:
                            Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                            Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                            Alignment := vector2{X := 0.5, Y := 0.5}
                            SizeToContent := true
                            Widget := MyUISlider
                        canvas_slot:
                            Anchors := anchors{Minimum := vector2{X := 0.25, Y := 0.6}, Maximum := vector2{X := 0.5, Y := 0.6}}
                            Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                            Alignment := vector2{X := 0.5, Y := 0.5}
                            SizeToContent := true
                            Widget := MyUIButton

                return MyInteractableWidgets

            # When the player interacts with the slider, the new value is printed to the screen
            HandleValueChangedUISlider(Message : widget_message) : void =
                if:
                    PlayerUI := GetPlayerUI[Message.Player]
                    MyUI := MaybeMyUIPerPlayer[Message.Player]?
                    ChangedSlider := slider_regular[Message.Source]
               then:
                    Print("Player changed slider value to {ChangedSlider.GetValue()}")

            # The custom UI is removed when the player selects the Close button option
            HandleSelectedUIButton(Message : widget_message) : void =
                if (PlayerUI := GetPlayerUI[Message.Player], MyUI := MaybeMyUIPerPlayer[Message.Player]?, SelectedButton := text_button_base[Message.Source]):
                    Print("Player selected {SelectedButton.GetText()}")
                    PlayerUI.RemoveWidget(MyUI)
                    if (set MaybeMyUIPerPlayer[Message.Player] = false) {}
   ```
