# 3. Playing Effects on Idle Players

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-03-playing-effects-on-idle-players-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:22:50.914420

---

## Determining If A Player Is Idle

In this section, you will learn how to check if a player has moved a certain distance since the last simulation update. If they have, the player’s current position is saved and checked again. If they haven’t, the loop breaks and the method completes. This method uses [`GetFortCharacter[]`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/characters/getfortcharacter), [`GetTransform()`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/game/positional/gettransform), and [`Translation`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/unrealenginedotcom/temporary/spatialmath/transform) to get the location of the player. You can learn more about these on their API Reference pages.

This page includes Verse snippets that show how to execute gameplay mechanics needed in this gameplay. Follow the steps below and copy the full script on [step 6](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-06-adding-the-full-script-in-unreal-editor-for-fortnite) of this tutorial.

Follow these steps to determine if a player is idle.

1. Create an extension method for the agent class named `AwaitStopMoving()`. This means you’re adding a custom method to an already defined class.

   ```verse
        (PropAgent:agent).AwaitStopMoving(MinimumDistance:float)<suspends>:void=
             Logger.Print("Checking if the agent has moved less than the minimum distance.")
   ```
2. Get the initial position of the player.

   ```verse
   (PropAgent:agent).AwaitStopMoving(MinimumDistance:float)<suspends>:void=
            Logger.Print("Checking if the agent has moved less than the minimum distance.")
            # Get the initial position of the agent from the agent's character in the scene.
            if (Tracked := PropAgent.GetFortCharacter[]):
                var StartPosition:vector3 = Tracked.GetTransform().Translation
   ```
3. Get the next position of the player in the next simulation update.

   ```verse
        (PropAgent:agent).AwaitStopMoving(MinimumDistance:float)<suspends>:void=
            Logger.Print("Checking if the agent has moved less than the minimum distance.")
            # Get the initial position of the agent from the agent's character in the scene.
            if (Tracked := PropAgent.GetFortCharacter[]):
                var StartPosition:vector3 = Tracked.GetTransform().Translation
                Sleep(0.0) # Get the position of the agent in the next game tick.
                NewPosition := Tracked.GetTransform().Translation
   ```
4. Check if the distance between the initial position and the latest position is within an acceptable threshold, passed to the function as the `MinimumDistance` parameter.
    `(PropAgent:agent).AwaitStopMoving(MinimumDistance:float)<suspends>:void=
   Logger.Print("Checking if the agent has moved less than the minimum distance.")
   # Get the initial position of the agent from the agent's character in the scene.
   if (Tracked := PropAgent.GetFortCharacter[]):
   var StartPosition:vector3 = Tracked.GetTransform().Translation
   Sleep(0.0) # Get the position of the agent in the next game tick.
   NewPosition := Tracked.GetTransform().Translation
   # If the distance of the new position from the starting position is less than MinimumDistance, the agent has not moved and we break the loop.
   if (Distance(StartPosition, NewPosition) < MinimumDistance):
   Logger.Print("Agent has moved less than the minimum distance.")
   # Otherwise, we reset StartPosition to make sure the player moves from the new position.
   else:
   set StartPosition = NewPosition`
5. Now we want to loop the check between the initial and latest positions and break out of the loop when the distance between the positions is above the `MinimumDistance` threshold.

   ```verse
        # Loops until the agent moves less than the MinimumDistance.
        (PropAgent:agent).AwaitStopMoving(MinimumDistance:float)<suspends>:void=
            Logger.Print("Checking if the agent has moved less than the minimum distance.")
            # Get the initial position of the agent from the agent's character in the scene.
            if (Tracked := PropAgent.GetFortCharacter[]):
                var StartPosition:vector3 = Tracked.GetTransform().Translation
                loop:
                    Sleep(0.0) # Get the position of the agent in the next game tick.
                    NewPosition := Tracked.GetTransform().Translation
                    # If the distance of the new position from the starting position is less than MinimumDistance, the agent has not moved and we break the loop.
                    if (Distance(StartPosition, NewPosition) < MinimumDistance):
                        Logger.Print("Agent has moved less than the minimum distance.")
                        break
                    # Otherwise, we reset StartPosition to make sure the player moves from the new position.
                    else:
                        set StartPosition = NewPosition
   ```

## Countdown Before Heartbeat

Follow these steps to wait for an amount of time equal to `HeartBeat.MoveTime - HeartBeat.WarningTime` before displaying a warning and countdown timer until the countdown time runs out, and then clears the warning and countdown text.

1. Create a function named CountdownTimer().

   ~~~(verse)
   # Delays until HeartBeatWarningTime should start. Then counts down by HeartBeatWarningTime and sets the countdown text. Clears the text when deferred.
   CountdownTimer(PropAgent:agent):void =
   Logger.Print("Starting heartbeat countdown.")
   ~~~
2. You first need to try to get the `heartbeat_warning_ui` for the associated player from the map you set up in **heartbeat.verse**. If that succeeds, you then need to start the delay between the player stopping and the countdown timer displaying.

   ~~~(verse)
   # Delays until HeartBeatWarningTime should start. Then counts down by HeartBeatWarningTime and sets the countdown text. Clears the text when deferred.
   CountdownTimer(PropAgent:agent)<suspends>:void=
   Logger.Print("Starting heart beat countdown.")
   if (UIData := HeartBeat.WarningUI[PropAgent]):
   Sleep(HeartBeat.MoveTime - HeartBeat.WarningTime) # Sleep for the amount of time before the warning appears.
   Logger.Print("Starting heartbeat warning.")
   else:
   Logger.Print("UIData not found.")
   ~~~
3. Now create the variable that will appear on the screen and will be decreased by one every second. Name it `WarningTimeRemaining`. Set it to `WarningTime` from **heartbeat.verse**. Since `WarningTimeRemaining` is an `int` and `WarningTime` is a `float`, you’ll need to use the [`Ceil[]`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/verse/ceil-1) function to create an `int`.

   ```verse
        # Delays until HeartBeatWarningTime should start. Then counts down by HeartBeatWarningTime and sets the countdown text. Clears the text when deferred.
        CountdownTimer(PropAgent:agent)<suspends>:void=
            Logger.Print("Starting heart beat countdown.")
            if (UIData := HeartBeat.WarningUI[PropAgent]):
                Sleep(HeartBeat.MoveTime - HeartBeat.WarningTime) # Sleep for the amount of time before the warning appears.
                Logger.Print("Starting heartbeat warning.")
                var WarningTimeRemaining:int = 0
                if (set WarningTimeRemaining = Ceil[HeartBeat.WarningTime]) {}
            else:
                Logger.Print("UIData not found.")
   ```
4. Before starting the countdown loop, use the `defer` expression to clear the countdown timer from the player’s UI whenever the `CountdownTimer()` function completes. It will only complete when the timer runs out or when the player starts moving again. See [Defer](https://dev.epicgames.com/documentation/en-us/uefn/defer-in-verse) to learn more.

   ```verse
        # Delays until HeartBeatWarningTime should start. Then counts down by HeartBeatWarningTime and sets the countdown text. Clears the text when deferred.
        CountdownTimer(PropAgent:agent)<suspends>:void=
            Logger.Print("Starting heart beat countdown.")
            if (UIData := HeartBeat.WarningUI[PropAgent]):
                Sleep(HeartBeat.MoveTime - HeartBeat.WarningTime) # Sleep for the amount of time before the warning appears.
                Logger.Print("Starting heart beat warning.")
                var WarningTimeRemaining:int = 0
                if (set WarningTimeRemaining = Ceil[HeartBeat.WarningTime]) {}
                    # A defer happens when the function completes or if it is canceled, such as if it loses a race.
                    # So in this case, the warning text is cleared when the countdown finishes or if the prop agent moves before the countdown finishes.
                    defer:
                        UIData.Text.SetText(HeartBeatWarningClear)
                    # Set the warning text to the time remaining, wait a second, and then decrement the time remaining. If the countdown completes, break the loop.
                  UIData.Text.SetText(HeartBeatWarningMessage(WarningTimeRemaining))
            else:
                Logger.Print("UIData not found.")
   ```
5. Finally, create the loop that decreases the countdown timer. Use the `SetText()` function to display `HeartBeatWarningMessage` with the `WarningTimeRemaining`. Then wait one second with `Sleep()`, before decrementing the time remaining. If `WarningTimeRemaining` is 0 or less, then the countdown is complete and you can break the loop.

   ```verse
        # Delays until HeartBeatWarningTime should start. Then counts down by HeartBeatWarningTime and sets the countdown text. Clears the text when deferred.
        CountdownTimer(PropAgent:agent)<suspends>:void=
            Logger.Print("Starting heart beat countdown.")
            if (UIData := HeartBeat.WarningUI[PropAgent]):
                Sleep(HeartBeat.MoveTime - HeartBeat.WarningTime) # Sleep for the amount of time before the warning appears.
                Logger.Print("Starting heart beat warning.")
                var WarningTimeRemaining:int = 0
                if (set WarningTimeRemaining = Ceil[HeartBeat.WarningTime]) {}
                    # A defer happens when the function completes or if it is canceled, such as if it loses a race.
                    # So in this case, the warning text is cleared when the countdown finishes or if the prop agent moves before the countdown finishes.
                    defer:
                        UIData.Text.SetText(HeartBeatWarningClear)
                    # Set the warning text to the time remaining, wait a second, and then decrement the time remaining. If the countdown completes, break the loop.
                    loop:
                        Logger.Print("Heart beat in {WarningTimeRemaining} seconds.")
                        UIData.Text.SetText(HeartBeatWarningMessage(WarningTimeRemaining))
                        Sleep(1.0)
                        set WarningTimeRemaining -= 1
                        if (WarningTimeRemaining <= 0):
                            break
            else:
                Logger.Print("UIData not found.")
   ```

## Playing Effects On Idle Players

When `AwaitStopMoving()` completes, you know it’s time to start the player’s countdown timer, and **then** their heartbeat effects. But as soon as they start moving again, you want to cancel the timer or the heartbeat, whichever is currently running. To do this, you need a `race` expression, where the two racing expressions are:

- `PropAgent.AwaitStartMoving(MinimumMoveDistance)`.
- `block` where there’s a countdown before heartbeat effects play.

`AwaitStartMoving()` is needed to win the race and stop the countdown timer or heartbeat effects.

The block expression is used to ensure that the two functions within it, `CountdownTimer()` and `StartHeartbeart()`, run sequentially and do not race against each other. The countdown timer is meant to let the Prop player know that their heartbeat effects will start **after** the timer completes, so it wouldn’t make sense to start both the timer and heartbeat at the same time.

Follow these steps to play effects when the player hasn’t moved for too long.

1. Create an extension method named `AwaitStartMoving()` where the implementation is the same except for the following:

- It checks if the player has moved `MinimumDistance` or more since the last simulation update. Instead of less than the `MinimumDistance` like in `AwaitStopMoving()`.
- It doesn’t reset the `StartPosition` after each loop. If `StartPosition` was reset at the end of every loop, the player would have to move the entire `MinimumDistance` or more in the time it takes to do the simulation update, which might be impossible.

  ```verse
        # Loops until the agent moves more than the MinimumDistance.
        (PropAgent:agent).AwaitStartMoving(MinimumDistance:float)<suspends>:void=
            Logger.Print("Checking if the agent moves further than the minimum distance.")
            # Get the initial position of the agent from the agent's character in the scene.
            if (Tracked := PropAgent.GetFortCharacter[]):
                StartPosition:vector3 = Tracked.GetTransform().Translation
                loop:
                    Sleep(0.0) # Get the position of the agent in the next game tick.
                    NewPosition := Tracked.GetTransform().Translation
                    # If the distance of the new position from the starting position is greater than or equal to MinimumDistance, the agent has moved and we break the loop.
                    if (Distance(StartPosition, NewPosition) >= MinimumDistance):
                        Logger.Print("Agent has moved more than or equal to the minimum distance.")
                        break
  ```

1. Create a function named `RunPropGameLoop()` that manages to play the heartbeat effect when the player is idle for too long.

   ```verse
        # If the prop agent stops moving then race to see if the prop agent moves beyond the MinimumMoveDistance, the heartbeat timer completes, or the prop agent is eliminated.
        RunPropGameLoop(PropAgent:agent)<suspends>:void =
            Logger.Print("Starting prop agent game loop.")
   ```
2. Wait until the prop agent moves less than the minimum distance, then advance.

   ```verse
            # If the prop agent stops moving then race to see if the prop agent moves beyond the MinimumMoveDistance, the heartbeat timer completes, or the prop agent is eliminated.
            RunPropGameLoop(PropAgent:agent)<suspends>:void =
                Logger.Print("Starting prop agent game loop.")
                # Loop forever through the prop behavior until the prop agent is eliminated or the player leaves the session.
                loop:
                    # Wait until the prop agent moves less than the minimum distance, then advance.
                    PropAgent.AwaitStopMoving(MinimumMoveDistance)
                    Sleep(0.0)
   ```
3. Add the `race` expression to race between `AwaitStartMoving()` completing, meaning the player has started moving, and a `block` expression with `CountdownTimer()` and then `StartHeartbeat()` running.

   ```verse
            # If the prop agent stops moving then race to see if the prop agent moves beyond the MinimumMoveDistance, the heartbeat timer completes, or the prop agent is eliminated.
            RunPropGameLoop(PropAgent:agent)<suspends>:void =
                Logger.Print("Starting prop agent game loop.")
                # Loop forever through the prop behavior until the prop agent is eliminated or the player leaves the session.
                loop:
                    # Wait until the prop agent moves less than the minimum distance, then advance.
                    PropAgent.AwaitStopMoving(MinimumMoveDistance)
                    # Until the prop agent moves beyond the minimum distance, countdown to the heartbeat and then play the heartbeat indefinitely.
                    race:
                        PropAgent.AwaitStartMoving(MinimumMoveDistance)
                        block:
                            CountdownTimer(PropAgent)
                            PropAgent.StartHeartbeat()
                    Sleep(0.0) # Once the race completes (the prop agent moves), start the loop again.
   ```

## Next Section

[![4. Setting up Teams and Classes](https://dev.epicgames.com/community/api/documentation/image/32759977-2ded-4ccf-a776-8dc86355d7df?resizing_type=fit&width=640&height=640)

4. Setting up Teams and Classes

Use a combination of devices to designate teams and classes for players.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-04-setting-up-teams-and-classes-in-unreal-editor-for-fortnite)
