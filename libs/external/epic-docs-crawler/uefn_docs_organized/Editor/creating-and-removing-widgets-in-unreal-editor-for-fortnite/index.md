# Creating and Removing Widgets

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-and-removing-widgets-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:16:32.245877

---

The following sections show how to add a widget to a player’s UI and remove a widget.

These examples use a text block widget, but you can use any kind of widget. See [Widget Types](https://dev.epicgames.com/documentation/en-us/fortnite/widget-types-in-unreal-editor-for-fortnite) for all the types of widgets you can use.

## Adding a Widget

This example shows how to add a widget when a player interacts with a [Button device](https://www.fortnite.com/creative/docs/using-button-devices-in-fortnite-creative) in the level:

1. Create a new Verse device and add it to the level. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).
2. Open your Verse file in Visual Studio Code with [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite).
3. Add an editable Button device property to your Verse device and set up the reference to the Button device in your level. To learn how to create editable properties, see [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse).
    `# Set the Button device in the Editor to reference the device in the level
   @editable
   MyButton : button_device = button_device{}`
4. At the top of your Verse file, add the following lines to use the Verse UI API:
    `using { /UnrealEngine.com/Temporary/UI }
   using { /Fortnite.com/UI }
   using { /UnrealEngine.com/Temporary/SpatialMath}`
5. This UI is only per player, so you'll need a reference to a player to access their UI. This example shows how to display a custom UI when the player interacts with a button, since events for devices include a reference to the player that interacted with the device. To learn how to set up event subscriptions, see [Coding Device Interactions](coding-device-interactions-in-verse).
    `# Runs when the device is started in a running game
   OnBegin<override>()<suspends> : void =
   MyButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)
   # A custom UI can only be associated with a specific player, and only that player can see it
   HandleButtonInteraction(Agent : agent) : void =
   # Display UI`
6. Now, you can call the [failable function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression) `GetPlayerUI[]` in an [if](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#if-expression) expression to get a reference to the player’s UI.

   ```verse
        # A custom UI can only be associated with a specific player, and only that player can see it
        HandleButtonInteraction(Agent : agent) : void =
            # Agents can be a player or AI, but you can only get the UI of a player
            # so you must cast the Agent, who interacted with the Button device, to the player type
            if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                # Display UI
   ```
7. With the reference to the player's UI, you can call `AddWidget()` to add your widget.

   1. Create a message named TextForMyUI that has the `localizes` specifer and initialize it with the string `"Hello, world!"`.
       `hello_world_device := class(creative_device):
      # Set the Button device in the Editor to reference the device in the level
      @editable
      MyButton : button_device = button_device{}
      # A localizable message to display as text in the UI
      TextForMyUI<localizes> : message = "Hello, world!"`

   The `message` type means the text can be localized, and the string you use to initialize a `message` variable is the default text and language for the message. To learn more about the `message` type, see the [Verse Language Quick Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference).

   1. Then, create a text widget with `TextForMyUI` as the default text and add it to the player's UI.

      ```verse
       # A custom UI can only be associated with a specific player, and only that player can see it
       HandleButtonInteraction(Agent : agent) : void =
           # Agents can be a player or AI, but you can only get the UI of a player
           # so you must cast the Agent, who interacted with the Button device, to the player type
           if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
               MyUI : text_block = text_block{DefaultText := TextFOrMyUI}
               PlayerUI.AddWidget(MyUI)
      ```
8. The following is the complete code:

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
            TextForMyUI<localizes> : message = "Hello, world!"

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends> : void =
                MyButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

            # A custom UI can only be associated with a specific player, and only that player can see it
            HandleButtonInteraction(Agent : agent) : void =
                # Agents can be a player or AI, but you can only get the UI of a player
                # so you must cast the Agent, who interacted with the Button device, to the player type
                if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                    MyUI : text_block = text_block{DefaultText := TextForMyUI}
                    PlayerUI.AddWidget(MyUI)
   ```
9. Save your Verse file and choose **Verse > Build Verse Code** in the UEFN main menu to update your Verse device.

When you playtest your level with this Verse device, the text "Hello, world!" appears in the upper left corner of the screen when the player interacts with the Button device.

## Removing a Widget

This example shows how to remove the UI from the player's screen when they interact with the Button device again:

1. Open the Verse file you created in [Adding a Widget](https://dev.epicgames.com/documentation/en-us/fortnite/creating-and-removing-widgets-in-unreal-editor-for-fortnite).
2. To be able to remove the widget later when the player interacts with the Button again, you'll need to store the widget in a [variable](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse) so you can reference it later. Since widgets only show per player, you'll need to store the widget and associate it with the player it's displaying to, so you can grab the right widget for the right player.
3. Create a [map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse) variable named `MaybeMyUIPerPlayer` that uses `player` as the key and an [optional](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse) text block as the widget [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) in the [map](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). (Note, this example uses a text block widget, but you can use any kind of widget.)
    `var MaybeMyUIPerPlayer : [player]?text_block = map{}`
4. When you add the widget to the player's UI, store your widget in the `MaybeMyUIPerPlayer` variable, so you can remove it later from the screen. Since accessing an element in a map is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse), setting the value of the widget in relation to the player must be called in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context), like an `if` expression.

   ```verse
        # A custom UI can only be associated with a specific player, and only that player can see it
        HandleButtonInteraction(Agent : agent) : void =
            # Agents can be a player or AI, but you can only get the UI of a player
            # so you must cast the Agent, who interacted with the Button device, to the player type
            if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                NewUI := text_block{DefaultText := TextForMyUI}
                PlayerUI.AddWidget(NewUI)
                if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}
   ```
5. Now update the function to check if the player already has a widget showing for them in `MaybeMyUIPerPlayer`. If they do, then remove the widget. If they don't, then create a new widget for them to see.

   ```verse
        # A custom UI can only be associated with a specific player, and only that player can see it
        HandleButtonInteraction(Agent : agent) : void =
            # Agents can be a player or AI, but you can only get the UI of a player
            # so you must cast the Agent, who interacted with the Button device, to the player type
            if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):
                if (MyUI := MaybeMyUIPerPlayer[InPlayer]?):
                    PlayerUI.RemoveWidget(MyUI)
                    if (set MaybeMyUIPerPlayer[InPlayer] = false) {}
                else:
                    NewUI := text_block{DefaultText := TextForMyUI}
                    PlayerUI.AddWidget(NewUI)
                    if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}
   ```
6. The following is the complete code:

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
            TextForMyUI<localizes> : message = "Hello, world!"

            # A mapping between the Player and the widget that may have been added to their UI
            var MaybeMyUIPerPlayer : [player]?text_block = map{}

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
                        NewUI := text_block{DefaultText := TextForMyUI}
                        PlayerUI.AddWidget(NewUI)
                        if (set MaybeMyUIPerPlayer[InPlayer] = option{NewUI}) {}
   ```
7. Save your Verse file and choose **Verse > Build Verse Code** in the UEFN main menu to update your Verse device.

When you playtest your level with this Verse device, the text "Hello, world!" appears in the upper left corner of the screen when the player first interacts with the Button device. The text disappears when the player interacts with the Button device again.
