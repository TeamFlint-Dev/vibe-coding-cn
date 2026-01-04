# 1. Coding the Verse Device

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-1-coding-the-verse-device-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:17:20.567076

---

In this section, you'll learn how to create the Verse device to manage timing and transitions for the camera views and UI elements. You can copy-paste the [complete script](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-1-coding-the-verse-device-in-unreal-editor-for-fortnite) at the end of this section.

Follow these steps to create your Title Sequence Verse device:

1. Create a new Verse device named **title\_sequence** and add the device to your level. See [Create Your Own Device Using Verse](create-your-own-device-in-verse) for steps.
2. Add the following fields to your Verse device:

   - An editable Fixed Point Camera device constant named `SplashScreenGameCamera`, which will be the camera to show the [title screens](unreal-editor-for-fortnite-glossary#title-screen) against.
   - An editable Fixed Point Camera device named `TitleGameCamera`, which will be the camera to show the game title against.
   - An editable Popup Dialog device named `StartGameDialog`, which will show the dialog option for the player to choose to start the game.
   - An editable HUD Message device named `TitleScreen`, which will show the game title UI.
   - An editable float named `GameMenuDelay`, which defines how long the title screen should be shown before the game menu appears.
   - An editable array of HUD Message devices named `SplashScreens`, which will show all the splash screens before the title screen.
   - An editable HUD Controller device named `IntroHUDController`, which is the HUD Controller to hide all in-game UI elements during the intro.
   - An editable HUD Controller device named `GameHUDController`, which is the HUD Controller to show all in-game UI elements that appear when the game starts.
   - An editable Trigger device named `GameStart`, which you can use to notify any devices that the game is starting.

     ```verse
                 using { /Fortnite.com/Characters }
                 using { /Fortnite.com/Devices }
                 using { /UnrealEngine.com/Temporary/Diagnostics }
                 using { /Verse.org/Simulation }

                 title_sequence:= class(creative_device):

                     # Game camera to show splash screens on top of.
                     @editable
                     SplashScreenGameCamera:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

                     # Game camera to show game title on top of.
                     @editable
                     TitleGameCamera:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

                     # Dialog option for player to choose to start the game.
                     @editable
                     StartGameDialog:popup_dialog_device = popup_dialog_device{}

                     # Game title screen to display.
                     @editable
                     TitleScreen:hud_message_device = hud_message_device{}

                     # How long the title screen should be shown before the game menu appears.
                     @editable
                     GameMenuDelay:float = 2.5

                     # Splash screens to show before the title screen.
                     @editable
                     SplashScreens:[]hud_message_device = array{}

                     # HUD Controller to hide all in-game UI elements.
                     @editable
                     IntroHUDController:hud_controller_device = hud_controller_device{}

                     # HUD Controller to show all in-game UI elements for when the game starts.
                     @editable
                     GameHUDController:hud_controller_device = hud_controller_device{}

                     # Method to notify any devices that the game should start.
                     @editable
                     GameStart:trigger_device = trigger_device{}

                     # Runs when the device is started in a running game
                     OnBegin<override>()<suspends>:void=
     ```
3. Create a method named `ShowTitleAndGameMenu()` that has the [suspends](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse) specifier. This method will show the camera for the title, display the title screen, wait for GameMenuDelay seconds before showing the game start dialog, and wait for the player to press the Start Game button in the UI.
    `# Shows the title screen and the Start Game option.
   ShowTitleAndGameMenu()<suspends>:void=
   # Add title camera to all players.
   TitleGameCamera.AddToAll()
   # Show the title screen.
   TitleScreen.Show()
   # Wait for GameMenuDelay seconds before showing the Start Game option.
   Sleep(GameMenuDelay)
   # Show the Start Game menu
   StartGameDialog.Show()
   # Wait for the player to press Start Game before doing anything else.
   StartGameDialog.RespondingButtonEvent.Await()`
4. Create a method named `HideTitleAndGameMenu()`. This method will hide the title screen and remove the camera that's used for the title.
   ~~~(verse)
   # Hide the title screen and removes the camera from all players.
   HideTitleAndGameMenu():void=
   TitleScreen.Hide()
   TitleGameCamera.RemoveFromAll()
   ~~~
5. Create a method named `ShowSplashScreens()`. This method will iterate through all the HUD Message devices added to the `SplashScreens` array to show the splash screen, and wait for as long as the splash screen was set to display in its properties. After all the splash screens have been shown, the camera for the splash screens is disabled.
    `# Show the series of splash screens.
   ShowSplashScreens()<suspends>:void=
   # Iterates through all splash screens.
   for (SplashScreen : SplashScreens):
   # Show each splash screen.
   SplashScreen.Show()
   # Wait for as long as the splash screen should be shown.
   Sleep(SplashScreen.GetDisplayTime())
   # Remove game camera that's used to show the splash screens.
   SplashScreenGameCamera.Disable()`
6. Create a method named `ToggleStasisForAllPlayers()`. This method will iterate through all the players and put them in stasis (so they can't move) if the `ShouldFreeze` argument is `true`, and release them from stasis (so they can move again) if the `ShouldFreeze` argument is `false`.
    `# Toggle player stasis.
   # When ShouldFreeze is true, all players will be put in stasis.
   # When ShouldFreeze is false, all players will be released from stasis.
   ToggleStasisForAllPlayers(ShouldFreeze:logic):void=
   for:
   Player : GetPlayspace().GetPlayers()
   Character := Player.GetFortCharacter[]
   do:
   if (ShouldFreeze?):
   # Put player in stasis and not allow them to turn or emote, either.
   Character.PutInStasis(stasis_args{AllowFalling := true, AllowTurning := false, AllowEmotes := false})
   else:
   # Release player from stasis.
   Character.ReleaseFromStasis()`
7. Update `OnBegin()` to:

   - Enable the HUD Controller for the intro to hide all in-game UI elements with `IntroHUDController.Enable()`.
   - Put players in stasis so they can't move during the intro with `ToggleStasisForAllPlayers(true)`.
   - Show the sequence of splash screens with `ShowSplashScreens()`.
   - Hide the title and game menu at the very last second of this `OnBegin()` function by using the [defer](https://dev.epicgames.com/documentation/en-us/fortnite/defer-in-verse) expression and calling `HideTitleAndGameMenu()`.
   - Show the title and game menu with `ShowTitleAndGameMenu()`.
   - Release the players from stasis with `ToggleStasisForAllPlayers(false)`.
   - Swap out the HUD Controllers from the intro HUD to the actual game HUD.
   - Finally, call `GameStart.Trigger()` to notify any devices that are listening that the game is starting.
      `# Runs when the device is started in a running game
     OnBegin<override>()<suspends>:void=
     IntroHUDController.Enable()
     # Wait one simulation update for everything to initialize.
     Sleep(0.0)
     # Put players in stasis so they can't move.
     ToggleStasisForAllPlayers(true)
     # Show the series of splash screens.
     ShowSplashScreens()
     # Hide the title and game menu at the very last second.
     # This defer executes when the current code block exits,
     # which is the end of this OnBegin function, after GameStart.Trigger().
     defer:
     HideTitleAndGameMenu()
     # Show the title and game menu.
     ShowTitleAndGameMenu()
     # Release players from stasis so they can move again.
     ToggleStasisForAllPlayers(false)
     # Change HUD controllers to the actual game HUD.
     IntroHUDController.Disable()
     GameHUDController.Enable()
     # Notify any devices that are listening that the game should now start!
     GameStart.Trigger()`
8. Save your Verse file and compile your code to update your Verse device in the level.

## Complete Script

The following is the complete code for the Title Sequence Verse device.

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Simulation }

title_sequence := class(creative_device):

    # Game camera to show splash screens on top of.
    @editable
    SplashScreenGameCamera:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

    # Game camera to show game title on top of.
    @editable
    TitleGameCamera:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

    # Dialog option for player to choose to start the game.
    @editable
    StartGameDialog:popup_dialog_device = popup_dialog_device{}

    # Game title screen to display.
    @editable
    TitleScreen:hud_message_device = hud_message_device{}

    # How long the title screen should be shown before the game menu appears.
    @editable
    GameMenuDelay:float = 2.5

    # Splash screens to show before the title screen.
    @editable
    SplashScreens:[]hud_message_device = array{}

    # HUD Controller to hide all in-game UI elements.
    @editable
    IntroHUDController:hud_controller_device = hud_controller_device{}

    # HUD Controller to show all in-game UI elements for when the game starts.
    @editable
    GameHUDController:hud_controller_device = hud_controller_device{}

    # Method to notify any devices that the game should start.
    @editable
    GameStart:trigger_device = trigger_device{}

    OnBegin<override>()<suspends>:void=
        IntroHUDController.Enable()

        # Wait one simulation update for everything to initialize.
        Sleep(0.0)

        # Put players in stasis so they can't move.
        ToggleStasisForAllPlayers(true)

        # Show the series of splash screens.
        ShowSplashScreens()

        # Hide the title and game menu at the very last second.
        # This defer executes when the current code block exits,
        # which is the end of this OnBegin function, after GameStart.Trigger().
        defer:
            HideTitleAndGameMenu()

        # Show the title and game menu.
        ShowTitleAndGameMenu()

        # Release players from stasis so they can move again.
        ToggleStasisForAllPlayers(false)

        # Change HUD controllers to the actual game HUD.
        IntroHUDController.Disable()
        GameHUDController.Enable()

        # Notify any devices that are listening that the game should now start!
        GameStart.Trigger()

    # Shows the title screen and the Start Game option.
    ShowTitleAndGameMenu()<suspends>:void=
        # Add title camera to all players.
        TitleGameCamera.AddToAll()

        # Show the title screen.
        TitleScreen.Show()

        # Wait for GameMenuDelay seconds before showing the Start Game option.
        Sleep(GameMenuDelay)

        # Show the Start Game menu
        StartGameDialog.Show()

        # Wait for the player to press Start Game before doing anything else.
        StartGameDialog.RespondingButtonEvent.Await()

    # Hide the title screen and removes the camera from all players.
    HideTitleAndGameMenu():void=
        TitleScreen.Hide()
        TitleGameCamera.RemoveFromAll()

    # Show the series of splash screens.
    ShowSplashScreens()<suspends>:void=
        # Iterates through all splash screens.
        for (SplashScreen : SplashScreens):
            # Show each splash screen.
            SplashScreen.Show()
            # Wait for as long as the splash screen should be shown.
            Sleep(SplashScreen.GetDisplayTime())

        # Remove game camera that's used to show the splash screens.
        SplashScreenGameCamera.Disable()

    # Toggle player stasis.
    # When ShouldFreeze is true, all players will be put in stasis.
    # When ShouldFreeze is false, all players will be released from stasis.
    ToggleStasisForAllPlayers(ShouldFreeze:logic):void=
        for:
            Player : GetPlayspace().GetPlayers()
            Character := Player.GetFortCharacter[]
        do:
            if (ShouldFreeze?):
                # Put player in stasis and not allow them to turn or emote, either.
                Character.PutInStasis(stasis_args{AllowFalling := true, AllowTurning := false, AllowEmotes := false})
            else:
                # Release player from stasis.
                Character.ReleaseFromStasis()
```

## Next Section

[![2. Customizing the Splash Screens](https://dev.epicgames.com/community/api/documentation/image/44a027b3-aefa-44d3-b10b-e1f1fe8dc807?resizing_type=fit&width=640&height=640)

2. Customizing the Splash Screens

Create custom images to show on the HUD Message devices for the splash screens.](https://dev.epicgames.com/documentation/en-us/fortnite/title-sequence-2-customizing-the-splash-screens-in-unreal-editor-for-fortnite)
