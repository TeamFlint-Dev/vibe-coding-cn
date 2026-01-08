# Making a Custom Countdown Timer

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-countdown-timer-using-verse>
> **爬取时间**: 2025-12-27T00:06:32.368003

---

You could use the [Timer device](https://www.fortnite.com/en-US/creative/docs/using-timer-devices-in-fortnite-creative) that runs a countdown timer, but making your own countdown timer in Verse is a way that you can customize its behavior to fit exactly what you need.

This tutorial will show you how to create your own timer with Verse, and to use a callout when time is added to the countdown. Start simple, and you'll find ways to improve it, project by project.

## Verse Language Features Used

- [if](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse): The `if` expression tests conditions and accesses values that might [fail](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary).
- [block](https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse): This example uses the `block` expression to [initialize](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) the UI when the countdown timer is created.
- [loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse): The `loop` expression updates the UI and ends when the countdown reaches zero.
- [spawn](https://dev.epicgames.com/documentation/en-us/fortnite/spawn-in-verse): A `spawn` expression starts an [asynchronous expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#async) in any [context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#context).
- [message](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference): The message type means the text can be localized, and the string you use to initialize a message variable is the default text and language for the message.
- [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse): This example creates a Verse class that manages and displays the countdown.
- [constructor](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse): A constructor is a special function that creates an instance of the class that it’s associated with.
- [Access specifiers](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse): You can use access specifiers to set the access level of your code.

## Verse APIs Used

- [Sleep](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/simulation/sleep): With the `Sleep()` API, you can choose the period between UI updates.
- [Events](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/event): You can create your own events in Verse and add custom functionality when they occur.
- [Verse UI](creating-in-game-ui-in-verse): Create a custom in-game UI to display information about the player and game.

## Instructions

Follow these steps to learn how to create your own custom timer. The [complete script](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-countdown-timer-using-verse) is included at the end of this guide for reference.

### Setting Up the Level

This example uses the following props and devices.

- 1 x [Button device](https://www.fortnite.com/en-US/creative/docs/using-button-devices-in-fortnite-creative): When the player interacts with the device, more time is added to the countdown.
- 1 x [End Game device](https://www.fortnite.com/en-US/creative/docs/using-end-game-devices-in-fortnite-creative): When the countdown ends, this device causes the game to end.

Follow these steps to set up your level:

1. Add a **Button** device and **End Game** device to your level.
2. Create a new Verse device and name it `countdown_timer_example` using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite). See [Create Your Own Device Using Verse](create-your-own-device-in-verse) for steps.
3. Add an [editable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#editable) reference to the Button device in `countdown_timer_example` and name it `AddMoreTimeButton`. See [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse) for steps.

   ```verse
        countdown_timer_example := class(creative_device):
     
            @editable
            AddMoreTimeButton : button_device = button_device{}
   ```

4. Add an editable reference to the End Game device in `countdown_timer_example` and name it `EndGame`.

   ```verse
        countdown_timer_example := class(creative_device):
     
            @editable
            AddMoreTimeButton : button_device = button_device{}
             
            @editable
            EndGame : end_game_device = end_game_device{}
   ```

5. Save your Verse file, and in the UEFN main menu choose **Verse > Build Verse Code** to update your device in the level to see your changes in the device's **Details** panel.

[![Settings of countdown_timer_example device](https://dev.epicgames.com/community/api/documentation/image/859cecfb-b80b-4c25-8b67-6e547d8c924a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/859cecfb-b80b-4c25-8b67-6e547d8c924a?resizing_type=fit)

### Starting the Countdown

In this example, you'll create a Verse class that draws its own UI and manages its own countdown.

Follow these steps to make your custom countdown timer:

1. Create an empty Verse file and name it **countdown\_timer.verse**.
2. Add the following Verse modules at the top of the file:

   ```verse
        using { /UnrealEngine.com/Temporary/UI }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { /Fortnite.com/UI }
        using { /Verse.org/Colors }
        using { /Verse.org/Simulation }
   ```

3. Create a class and name it `countdown_timer`, then add the following variables:

   - A float variable named `RemainingTime` and initialized to `0.0`.

     ```verse
                               var RemainingTime : float = 0.0
     ```

   - A canvas widget variable named `Canvas`.

     ```verse
       var Canvas : canvas = canvas{}
     ```

   - A text widget named `RemainingTimeWidget` with a white default text color.

     ```verse
       RemainingTimeWidget : text_block = text_block{DefaultTextColor := NamedColors.White}
     ```

   - A function returning a message named `RemainingTimeText` that takes an integer [parameter](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parameter) to display the value represented by `RemainingTime`.

     ```verse
       RemainingTimeText<localizes>(CurrentRemainingTime : int) : message = "{CurrentRemainingTime}"
     ```

   - An optional player UI named `MaybePlayerUI` and initialized to `false`.

     ```verse
       MaybePlayerUI : ?player_ui = false
       
     ```

4. Your class should look like:

   ```verse
        countdown_timer := class:
            MaybePlayerUI : ?player_ui = false
            var RemainingTime : float = 0.0
               var Canvas : canvas = canvas{}
               RemainingTimeWidget : text_block = text_block{DefaultTextColor := NamedColors.White}
               RemainingTimeText<localizes>(CurrentRemainingTime : int) : message = "{CurrentRemainingTime}"
   ```

5. Add a `block` expression to create the UI where the time appears in the upper middle of the screen. A [block](https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse) expression in a class definition runs only when the class is instantiated, so we can create the UI once in this `block` expression.

   ```verse
        countdown_timer := class:
            block:
                set Canvas = canvas:
                    Slots := array:
                        canvas_slot:
                            Anchors := anchors:
                                Minimum := vector2{X := 0.5, Y := 0.05}
                                Maximum := vector2{X := 0.5, Y := 0.05}
                            Alignment := vector2{X := 0.5, Y := 0.0}
                            Offsets := margin{Top := 0.0, Left := 0.0, Bottom := 0.0, Right := 0.0}
                            SizeToContent := true
                            Widget := RemainingTimeWidget

            MaybePlayerUI : ?player_ui = false
         var RemainingTime : float = 0.0
            var Canvas : canvas = canvas{}
            RemainingTimeWidget : text_block = text_block{DefaultTextColor := NamedColors.White}
            RemainingTimeText<localizes>(CurrentRemainingTime : int) : message = "{CurrentRemainingTime}"
   ```

6. Add the function `StartCountdown()` to display the UI.

   ```verse
        StartCountdown() : void =
            Print("Starting countdown")
     
            if (PlayerUI := MaybePlayerUI?):
                PlayerUI.AddWidget(Canvas)
   ```

7. In **countdown\_timer\_example.verse**, create a `countdown_timer` instance with a reference to the player UI and the initial countdown time. Call `StartCountdown()` in `OnBegin()` so the countdown appears as soon as the game starts.

   ```verse
        using { /Verse.org/Simulation }
        using { /Fortnite.com/Devices }

        countdown_timer_example := class(creative_device):

            @editable
            AddMoreTimeButton : button_device = button_device{}

            @editable
            EndGame : end_game_device = end_game_device{}

            var CountdownTimer : countdown_timer = countdown_timer{}
            InitialCountdownTime : float = 30.0

            OnBegin<override>()<suspends> : void =
                if:
                    FirstPlayer := Self.GetPlayspace().GetPlayers()[0]
                    PlayerUI := GetPlayerUI[player[FirstPlayer]]
                then:
                    set CountdownTimer = countdown_timer{MaybePlayerUI := option{PlayerUI}, RemainingTime := InitialCountdownTime}
                    CountdownTimer.StartCountdown()
                else:
                    Print("Can't find player")
   ```

8. If you playtest now, the UI doesn’t display the remaining time when the countdown starts, so in **countdown\_timer.verse**, create a function and name it `UpdateUI()` that updates the current countdown value in the UI. Call `UpdateUI()` in `StartCountdown()`.

   ```verse
        StartCountdown() : void =
            Print("Starting countdown")
     
            if (PlayerUI := MaybePlayerUI?):
                PlayerUI.AddWidget(Canvas)
                 
                # Update the UI when we start the timer to see the initial RemainingTime on screen
                UpdateUI()
     
        UpdateUI() : void =
            if (IntTime := Int[RemainingTime]):
                RemainingTimeWidget.SetText(RemainingTimeText(IntTime))
   ```

9. Now, the initial countdown appears in the UI but the value doesn’t update every second. To do this:

   - Add the float variable `TimerTickPeriod` to represent how often in seconds to update the UI. This example uses one second.

     ```verse
                               TimerTickPeriod : float = 1.0 # The timer "precision": how often, in seconds, it ticks.
     ```

   - Create a function and name it `RunCountdown()` that has the [suspends specifier](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse), and call it from `StartCountdown()`. Have `RunCountdown()` wait for the `TimerTickPeriod` before updating the UI and repeat this on [loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse). Set the loop to end, and have the countdown disappear from the UI, when the countdown reaches `0.0`.

     ```verse
       StartCountdown() : void =
           Print("Starting countdown")

           if (PlayerUI := MaybePlayerUI?):
               PlayerUI.AddWidget(Canvas)

               # Update the UI when we start the timer to see the initial RemainingTime on screen
               UpdateUI()

               spawn:
                   RunCountdown()

       RunCountdown()<suspends> : void =
           loop:
               Sleep(TimerTickPeriod) # Wait TimerTickPeriod seconds before updating the UI again.
               set RemainingTime -= TimerTickPeriod # Update how much time is left in the countdown after waiting

               UpdateUI()

               # Timer End
               if (RemainingTime <= 0.0):
                   if (PlayerUI := MaybePlayerUI?):
                       PlayerUI.RemoveWidget(Canvas)
                   break
     ```

10. When you playtest, you should see the countdown start at 30 and update every second until the timer reaches 0 and the countdown disappears from the UI.

[![Countdown timer starts at 30 when the game starts](https://dev.epicgames.com/community/api/documentation/image/cd5448d1-5a12-421b-a894-8ff0b98daa96?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd5448d1-5a12-421b-a894-8ff0b98daa96?resizing_type=fit)

### Adding More Time

With this countdown timer, you'll want to add a custom way to add more time and call out the added time. This example shows how to add more time to the countdown, and display the added time when the player interacts with the **Button** device.

Follow these steps to add more time to the countdown timer when the player interacts with the Button device:

1. In countdown\_timer.verse, create a new function named `AddRemainingTime()` that updates the `RemainingTime` variable with the value passed to the function in the float parameter named `Time`, then updates the UI to show the new remaining time.

   ```verse
        AddRemainingTime(Time : float) : void =
            set RemainingTime += Time
     
            # Immediately update the UI for better player feedback when time is added.
            UpdateUI()
   ```

2. In countdown\_timer\_example.verse, subscribe to the `InteractedWithEvent` of the Button device and call `AddRemainingTime()` when the player interacts with the Button device.

   ```verse
        using { /Verse.org/Simulation }
        using { /Fortnite.com/Devices }

        countdown_timer_example := class(creative_device):

            @editable
            AddMoreTimeButton : button_device = button_device{}

            @editable
            EndGame : end_game_device = end_game_device{}

            var CountdownTimer : countdown_timer = countdown_timer{}
            InitialCountdownTime : float = 30.0

            OnBegin<override>()<suspends> : void =
                AddMoreTimeButton.InteractedWithEvent.Subscribe(OnButtonInteractedWith)

                if:
                    FirstPlayer := Self.GetPlayspace().GetPlayers()[0]
                    PlayerUI := GetPlayerUI[player[FirstPlayer]]
                then:
                    set CountdownTimer = countdown_timer{MaybePlayerUI := option{PlayerUI}, RemainingTime := InitialCountdownTime}
                    CountdownTimer.StartCountdown()
                else:
                    Print("Can't find player")

            OnButtonInteractedWith(Agent : agent) : void =
                TimeToAdd : float = 20.0
                CountdownTimer.AddRemainingTime(TimeToAdd)
   ```

3. Add a widget to the `countdown_timer` class to call out how much time is added to the countdown when the player interacts with the button.

   ```verse
        AddedTimeWidget : text_block = text_block{DefaultTextColor := NamedColors.White} 
        AddedTimeText<localizes>(AddedTime : int) : message = " +{AddedTime}!"
   ```

4. Use the same positioning values as the RemainingTime widget for the new AddedTimeWidget, but change the following values so the callout time displays to the upper right of the countdown timer:

   - For the AddedTimeWidget, set the Left margin in Offsets to `50.0`.
   - For the RemainingTimeWidget, set the Top margin in Offsets to `25.0`.

     ```verse
                               countdown_timer := class:
                                   <# This block runs for each instance of the countdown_timer class.
                                   We can setup the canvas once here. #>
                                   block:
                                       set Canvas = canvas:
                                           Slots := array:
                                               canvas_slot:
                                                   Anchors := anchors:
                                                       Minimum := vector2{X := 0.5, Y := 0.05}
                                                       Maximum := vector2{X := 0.5, Y := 0.05}
                                                   Alignment := vector2{X := 0.5, Y := 0.0}
                                                   Offsets := margin{Top := 0.0, Left := 50.0, Bottom := 0.0, Right := 0.0}
                                                   SizeToContent := true
                                                   Widget := AddedTimeWidget
                                               canvas_slot:
                                                   Anchors := anchors:
                                                       Minimum := vector2{X := 0.5, Y := 0.05}
                                                       Maximum := vector2{X := 0.5, Y := 0.05}
                                                   Alignment := vector2{X := 0.5, Y := 0.0}
                                                   Offsets := margin{Top := 25.0, Left := 0.0, Bottom := 0.0, Right := 0.0}
                                                   SizeToContent := true
                                                   Widget := RemainingTimeWidget
     ```

5. Create a new function named `AddedTimeCallout()` that updates the value in the AddedTimeWidget and displays the callout for two seconds before hiding the widget again. Call `AddedTimeCallout()` in `AddRemainingTime()`.

   ```verse
        AddRemainingTime(Time : float) : void =
            set RemainingTime += Time
     
            # Immediately update the UI for better player feedback when time is added.
            UpdateUI()
     
            # Fire a simple callout to show the time being added.
            spawn:
                AddedTimeCallout(Time)
     
        AddedTimeCallout(Time : float)<suspends> : void =
            if:
                PlayerUI := MaybePlayerUI?
                IntTime := Int[Time]
            then:
                AddedTimeWidget.SetVisibility(widget_visibility.Visible)
                AddedTimeWidget.SetText(AddedTimeText(IntTime))
                Sleep(2.0)
                AddedTimeWidget.SetVisibility(widget_visibility.Hidden)
   ```

6. When you playtest, you should see the countdown start at 30 and update every second until the timer reaches 0 and the countdown then disappears from the UI. When the player interacts with the button, twenty seconds are added to the countdown and a callout appears for two seconds showing the additional time added.

### Signaling Countdown Timer Ending

Previously in this tutorial, you used a Button device `InteractedWithEvent` to know when the player pressed the button and added more time to the countdown timer. But you can also create your own custom events that others can use to know when something happens in your code.

This example shows how to use the following behavior of custom events:

- `Signal()`: This function lets anyone waiting on the event know the event has happened.
- `Await()`: This asynchronous function blocks execution of its enclosing context until the event is signaled.

In this example, you’ll add an event to the countdown timer to signal when the countdown ends so you can activate the End Game device.

Follow these steps to add an event for the countdown ending.

1. Add an event field named `CountdownEndedEvent` to the `countdown_timer` class:

   ```verse
        CountdownEndedEvent : event() = event(){}
   ```

   The `event()` is a [parametric type](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse), meaning it returns a class or interface rather than a value or object instance. This is why the type is `event()`, and why you need to initialize your constant `CountdownEndedEvent` with `event(){}` to mimic how you instantiate a class.
2. Update `RunCountdown()` to signal the `CountdownEndedEvent` to let other code know the countdown has ended before breaking out of the loop.

   ```verse
        RunCountdown()<suspends> : void =
            # We loop with the TimerTickPeriod.
            # The UI is also updated each time.
            loop:
                Sleep(TimerTickPeriod)
                set RemainingTime -= TimerTickPeriod
                UpdateUI()

                # Timer End
                if (RemainingTime <= 0.0):
                    if (UI := MaybePlayerUI?):
                        UI.RemoveWidget(Canvas)
                    CountdownEndedEvent.Signal()
                    break
   ```

3. In **countdown\_timer\_example.verse**, await on the `CountdownEndedEvent` associated with the `CountdownTimer`, then activate the End Game device because we know the countdown ended when the event happens.

   ```verse
        OnBegin<override()<suspends> : void =
            AddMoreTimeButton.InteractedWithEvent.Subscribe(OnButtonInteractedWith)
            if:
                FirstPlayer := Self.GetPlayspace().GetPlayers()[0]
                PlayerUI := GetPlayerUI[player[FirstPlayer]]
            then:
                set CountdownTimer = countdown_timer{MaybePlayerUI := option{PlayerUI}, RemainingTime := InitialCountdownTime}
             
                CountdownTimer.StartCountdown()
                CountdownTimer.CountdownEndedEvent.Await()
                 
                EndGame.Activate(FirstPlayer)
            else:
                Print("Can't find player")
   ```

4. When you playtest, you should see the countdown start at 30 and update every second until the timer reaches 0. As soon as the countdown ends, the countdown disappears from the UI and the game ends. When the player interacts with the button, twenty seconds are added to the countdown and a callout appears for two seconds showing the time added.

### Preparing Your Class to Be Used by Other Code

You’ve now created your own custom countdown timer class and used a Verse-authored device to instantiate and control the timer.

When you create your own custom classes (and really, any code), it’s important to specify who can access what you create. For example, only the countdown timer should be able to create and change its UI. In Verse, you can use [access specifiers](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse) to set the access level of your code.

Add the `public` specifier to any identifiers you want others to access, because **public** means that the identifier is universally accessible. In this example, the following are all used in the `countdown_timer_example` device and so should have public access:

- `CountdownEndedEvent<public> : event() = event(){}`
- `StartCountdown<public>() : void =`
- `AddRemainingTime<public>(Time : float) : void =`

Add the `private` specifier to any identifiers you don’t want others to access because **private** means that the identifier can only be accessed in the current, immediately enclosing, scope (which in this case is the `countdown_timer` class).

In this example, the following should have private access:

- `RemainingTimeWidget<private> : text_block = text_block{DefaultTextColor := NamedColors.White}`
- `AddedTimeWidget<private> : text_block = text_block{DefaultTextColor := NamedColors.White}`
- `AddedTimeText<localizes><private>(AddedTime : int) : message = " +{AddedTime}!"`
- `RemainingTimeText<localizes><private>(CurrentRemainingTime : int) : message = "{CurrentRemainingTime}"`
- `var Canvas<private> : canvas = canvas{}`
- `TimerTickPeriod<private> : float = 1.0`
- `RunCountdown<private>()<suspends> : void =`
- `AddedTimeCallout<private>(Time : float)<suspends> : void =`
- `UpdateUI<private>() : void =`

It’s a good idea to group your code by access. We recommend ordering your code from greatest to least amount of access:

- public
- internal
- protected
- private

You can use a [constructor](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse) to set initial values for a new class instance without [exposing](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expose) a class’s variables. A constructor is a special function that creates an instance of the class that it’s associated with.

Create a constructor for the `countdown_timer` class that updates the `RemainingTime` and `MaybePlayerUI` variables.

```verse
MakeCountdownTimer<constructor><public>(MaxTime : float, InPlayer : agent) := countdown_timer:
    RemainingTime := MaxTime
    MaybePlayerUI := option{GetPlayerUI[player[InPlayer]]}
```

The variables `RemainingTime` and `MaybePlayerUI` that are set in the constructor shouldn’t have public access, but they can’t have private access if they’re set in a constructor. You can use the `internal` specifier for these variables, which means the identifier can only be accessed in the current, immediately enclosing module.

- `MaybePlayerUI<internal> : ?player_ui = false`
- `var RemainingTime<internal> : float = 0.0`

## Complete Code

The following code is the complete code for creating a custom countdown timer.

There are two Verse files created in this example.

### countdown\_timer.verse

```verse
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Simulation }
using { /Fortnite.com/UI }

MakeCountdownTimer<constructor><public>(MaxTime : float, InPlayer : agent) := countdown_timer:
    RemainingTime := MaxTime
    MaybePlayerUI := option{GetPlayerUI[player[InPlayer]]}

countdown_timer := class:
    <# This block runs for each instance of the countdown_timer class.
    We can setup the canvas once here. #>
    block:
        set Canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors:
                        Minimum := vector2{X := 0.4, Y := 0.3}
                        Maximum := vector2{X := 0.6, Y := 0.3}
                    Alignment := vector2{X := 0.5, Y := 0.5 }
                    Offsets := margin{Top := 0.0, Left := 0.0, Bottom := 0.0, Right := 0.0}
                    SizeToContent := true
                    Widget := RemainingTimeTextBlock
                canvas_slot:
                    Anchors := anchors:
                        Minimum := vector2{X := 0.4, Y := 0.3}
                        Maximum := vector2{X := 0.6, Y := 0.3}
                    Alignment := vector2{X := 0.0, Y := 1.0}
                    Offsets := margin{Top := 0.0, Right := 0.0}
                    SizeToContent := true
                    Widget := AddedTimeTextBlock

    CountdownEndedEvent<public> : event(float) = event(float){}

    StartCountdown<public>() : void =
        if (PlayerUI := MaybePlayerUI?):
            PlayerUI.AddWidget(Canvas)

            # Update the UI when we start the timer to see the initial RemainingTime on screen
            UpdateUI()
            spawn:
                RunCountdown()

    AddRemainingTime<public>(Time : float) : void =
        set RemainingTime += Time
        # Immediately update UI for better player feedback when time is added.
        UpdateUI()

        # Fire a simple callout to show the time being added.
        spawn:
            AddedTimeCallout(Time)

    MaybePlayerUI<internal> : ?player_ui = false
    var RemainingTime<internal> : float = 0.0
    RemainingTimeTextBlock<private> : text_block = text_block{}
    AddedTimeTextBlock<private> : text_block = text_block{}
    RemainingTimeText<localizes><private>(CurrentRemainingTime : int) : message = "{CurrentRemainingTime}"
    AddedTimeText<localizes><private>(AddedTime : int) : message = " +{AddedTime}!"
    var Canvas<private> : canvas = canvas{}
    var TotalTime<private> : float = 0.0
    # The timer "precision": how often, in seconds, it ticks.
    TimerTickPeriod<private> : float = 1.0

    RunCountdown<private>()<suspends> : void =
        # We loop with the TimerTickPeriod.
        # The UI is also updated each time.
        loop:
            Sleep(TimerTickPeriod)
            set TotalTime += TimerTickPeriod
            set RemainingTime -= TimerTickPeriod
            UpdateUI()

            # Timer End
            if (RemainingTime <= 0.0):

                Canvas.RemoveWidget(RemainingTimeTextBlock)

                 if (UI := MaybePlayerUI?):
                     UI.RemoveWidget(Canvas)

                CountdownEndedEvent.Signal(TotalTime)
                break

    AddedTimeCallout<private>(Time : float)<suspends> : void =
        if:
            PlayerUI := MaybePlayerUI?
            IntTime := Int[Time]
        then:
            AddedTimeTextBlock.SetVisibility(widget_visibility.Visible)
            AddedTimeTextBlock.SetText(AddedTimeText(IntTime))
            Sleep(2.0)
            AddedTimeTextBlock.SetVisibility(widget_visibility.Hidden)

    UpdateUI<private>() : void =
        if (IntTime := Int[RemainingTime]):
            RemainingTimeTextBlock.SetText(RemainingTimeText(IntTime))
```

### countdown\_timer\_example.verse

```verse
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/UI }

countdown_timer_example := class(creative_device):

    @editable
    AddMoreTimeButton : button_device = button_device{}

    @editable
    EndGame : end_game_device = end_game_device{}

    var CountdownTimer : countdown_timer = countdown_timer{}
    InitialCountdownTime : float = 30.0

    OnBegin<override>()<suspends> : void =
        AddMoreTimeButton.InteractedWithEvent.Subscribe(OnButtonInteractedWith)

        if:
            FirstPlayer := Self.GetPlayspace().GetPlayers()[0]
            PlayerUI := GetPlayerUI[player[FirstPlayer]]
        then:
            set CountdownTimer = countdown_timer{MaybePlayerUI := option{PlayerUI}, RemainingTime := InitialCountdownTime}

            CountdownTimer.StartCountdown()

            CountdownTimer.CountdownEndedEvent.Await()

            EndGame.Activate(FirstPlayer)
        else:
            Print("Can't find player")

    OnButtonInteractedWith(Agent : agent) : void =
        TimeToAdd : float = 20.0
        CountdownTimer.AddRemainingTime(TimeToAdd)
```

## On Your Own

By completing this guide, you’ve learned how to create a custom countdown timer.

Using what you’ve learned, try to do the following:

- Change the timer tick rate and add an event for each tick.
- Add pause, resume, and restart functionality to the timer.
