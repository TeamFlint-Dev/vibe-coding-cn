# 2. Timer System

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-02-timer-system-in-fortnite
> **爬取时间**: 2025-12-27T00:29:18.362385

---

In this step, you will create a timer system in Verse that uses the [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) and [End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative) devices. The timer will start when the player hits any target, and the game will end and display the scoreboard when it runs out.

While you can end your game on a timer with Island Settings or with devices alone, using Verse increases your control over the game mechanics you use.

## Modify Your Island

1. Select the **Island Settings** device in the viewport or **Outliner** panel.
2. In the **Details** panel, set the following parameters:

   1. Uncheck **Stat to End**. This removes the original scoring end condition, which you will replace with the timer.
   2. Set **Game Score Display** Time to **10** seconds.
   3. Enable **First Scoreboard Column**, then set to **Score**.
3. Use the **Content Browser** to find the **Timer Device**, then drag it into the viewport.
4. In the **Details** panel, set **Visible During Game** to **Hidden**. This hides the timer object during the game, but the time still displays on the player's HUD while it is active.
5. Use the **Content Browser** to find the **End Game Device**, then drag it into the viewport.

## Write Verse Code

This page guides you step by step through the code changes, but if you want to check your work, review the [Complete Code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-02-timer-system-in-fortnite#complete-code) section for the final result.

1. Open the `shooting_range_manager_device.verse` file.
2. Add the following variables to store the new device references and a logic flag to track the timer's state.

   A **flag variable** refers to a variable in your code that exists to track if a certain condition has been met. `IsTimerStarted` is the flag here where **false** represents ‘no’, and **true** represents yes.

   ```verse
       @editable
       Timer:timer_device = timer_device{}

       @editable
       EndGame:end_game_device = end_game_device{}

       var IsTimerStarted:logic = false
   ```
3. Add the `OnTimerSuccess` callback method, which will be called when the timer runs out to end the game.

   The **OnTimerSuccess** method receives an optional agent parameter, which is the agent that activated the timer, if any. The End Game device requires a non-option agent parameter to activate, so the optional agent is converted to non-optional in the `if` statement. See [option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse) for more information on option types.

   ```verse
       # When time runs out, end the game.
       OnTimerSuccess(Agent:?agent):void=
           if (TriggerAgent := Agent?):
               EndGame.Activate(TriggerAgent)
   ```
4. Add the **StartTimer** method that sets up the timer's subscription to the **OnTimerSuccess** callback and starts the timer.

   ```verse
       # Setup and start the timer.
       StartTimer():void=
           # Set the event subscription to call OnTimerSuccess when the timer finishes.
           Timer.SuccessEvent.Subscribe(OnTimerSuccess)

           # Start the timer.
           Timer.Start()

           # Track that the timer has started.
           set IsTimerStarted = true
   ```
5. Modify the **AdjustScore** method to start the timer. This gives the player a moment to ready their first shot to begin the game.

   ```verse
       # Adjusts the player's score by the provided value.
       AdjustScore(Value:int):void=

   <# --- New Code Start --- #>

           # Start the timer if it hasn't started yet.
           if (not IsTimerStarted?):
               StartTimer()

   <# --- New Code End --- #>
          
           # Sets the score award to the base value of the target.
           ScoreManager.SetScoreAward(Value)

           # Gets the first player in the playspace.
           if (Player:player = GetPlayspace().GetPlayers()[0]):
               # Awards the points to the player.
               ScoreManager.Activate(Player)
   ```
6. Save and build your Verse code.

## Complete Code

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# A device that manages shooting range gameplay.
shooting_range_manager_device := class(creative_device):

    @editable
    ScoreManager:score_manager_device = score_manager_device{}

    @editable
    GoodTarget1:shooting_range_target_track_device = shooting_range_target_track_device{}

    @editable
    GoodTarget2:shooting_range_target_track_device = shooting_range_target_track_device{}

    @editable
    GoodTarget3:shooting_range_target_track_device = shooting_range_target_track_device{}

    @editable
    var GoodTargetScore:int = 100

    @editable
    BadTarget1:shooting_range_target_device = shooting_range_target_device{}

    @editable
    BadTarget2:shooting_range_target_device = shooting_range_target_device{}

    @editable
    BadTarget3:shooting_range_target_device = shooting_range_target_device{}

    @editable
    var BadTargetScore:int = -100

    @editable
    ComboTarget:shooting_range_target_track_device = shooting_range_target_track_device{}

    @editable
    var ComboTargetScore:int = 500

    # Variables to track the combo state.
    var HitGoodTarget1:logic = false
    var HitGoodTarget2:logic = false
    var HitGoodTarget3:logic = false

    @editable
    Timer:timer_device = timer_device{}

    @editable
    EndGame:end_game_device = end_game_device{}

    var IsTimerStarted:logic = false

    # Runs when the device is started in a running game.
    OnBegin<override>()<suspends>:void=
        # Subscribing to the GoodTarget HitEvents.
        GoodTarget1.HitEvent.Subscribe(OnGoodTarget1Hit)
        GoodTarget2.HitEvent.Subscribe(OnGoodTarget2Hit)
        GoodTarget3.HitEvent.Subscribe(OnGoodTarget3Hit)

        # Subscribing to the BadTarget HitEvents.
        BadTarget1.HitEvent.Subscribe(OnBadTarget1Hit)
        BadTarget2.HitEvent.Subscribe(OnBadTarget2Hit)
        BadTarget3.HitEvent.Subscribe(OnBadTarget3Hit)

        # Subscribing to the ComboTarget HitEvent.
        ComboTarget.HitEvent.Subscribe(OnComboTargetHit)

        # Disabling the ComboTarget on game start.
        ComboTarget.Disable()

    # When time runs out, end the game.
    OnTimerSuccess(Agent:?agent):void=
        if (TriggerAgent := Agent?):
            EndGame.Activate(TriggerAgent)

    # A hit callback that scores, disables the first GoodTarget, and checks for combo.
    OnGoodTarget1Hit():void=
        set HitGoodTarget1 = true
        AdjustScore(GoodTargetScore)
        GoodTarget1.Disable()
        CheckCombo()

    # A hit callback that scores, disables the second GoodTarget, and checks for combo.
    OnGoodTarget2Hit():void=
        set HitGoodTarget2 = true
        AdjustScore(GoodTargetScore)
        GoodTarget2.Disable()
        CheckCombo()

    # A hit callback that scores, disables the third GoodTarget, and checks for combo.
    OnGoodTarget3Hit():void=
        set HitGoodTarget3 = true
        AdjustScore(GoodTargetScore)
        GoodTarget3.Disable()
        CheckCombo()

    # A hit callback that scores, pops down the first BadTarget, and resets the combo.
    OnBadTarget1Hit():void=
        AdjustScore(BadTargetScore)
        BadTarget1.PopDown()
        ResetCombo()

    # A hit callback that scores, pops down the second BadTarget, and resets the combo.
    OnBadTarget2Hit():void=
        AdjustScore(BadTargetScore)
        BadTarget2.PopDown()
        ResetCombo()

    # A hit callback that scores, pops down the third BadTarget, and resets the combo.
    OnBadTarget3Hit():void=
        AdjustScore(BadTargetScore)
        BadTarget3.PopDown()
        ResetCombo()

    # A hit callback that scores the ComboTarget and resets the combo.
    OnComboTargetHit():void=
        AdjustScore(ComboTargetScore)
        ResetCombo()

    # If the combo is complete, enable the ComboTarget.
    CheckCombo():void=
        if:
            # If all logics are set to true...
            HitGoodTarget1?
            HitGoodTarget2?
            HitGoodTarget3?
        then:
            # ...then enable the ComboTarget.
            ComboTarget.Enable()

    # Resets the combo tracking variables, re-enables all GoodTargets, and disables the ComboTarget.
    ResetCombo():void=
        set HitGoodTarget1 = false
        set HitGoodTarget2 = false
        set HitGoodTarget3 = false

        GoodTarget1.Enable()
        GoodTarget2.Enable()
        GoodTarget3.Enable()

        ComboTarget.PopDown()
        ComboTarget.Disable()

    # Adjusts the player's score by the provided value.
    AdjustScore(Value:int):void=
        # Start the timer if it hasn't started yet.
        if (not IsTimerStarted?):
            StartTimer()
       
        # Sets the score award to the base value of the target.
        ScoreManager.SetScoreAward(Value)

        # Gets the first player in the playspace.
        if (Player:player = GetPlayspace().GetPlayers()[0]):
            # Awards the points to the player.
            ScoreManager.Activate(Player)

    # Setup and start the timer.
    StartTimer():void=
        # Set the event subscription to call OnTimerSuccess when the timer finishes.
        Timer.SuccessEvent.Subscribe(OnTimerSuccess)

        # Start the timer.
        Timer.Start()

        # Track that the timer has started.
        set IsTimerStarted = true
```

## Bring It Together

1. Select the **shooting\_range\_manager\_devic****e** in the viewport or **Outliner** panel.
2. In the **Details panel**, set the following parameters:

   1. Set **Timer** to the Timer device.
   2. Set **EndGame** to the End Game device.
3. Push your changes and playtest your island.

   1. Verify the timer starts when shooting any target.
   2. Verify that once the timer runs out, the game ends and displays the scoreboard.

## Ready for More?

[![3. Bonus Time Target](https://dev.epicgames.com/community/api/documentation/image/f40e269b-bba5-46d3-a309-67a4dbc1295a?resizing_type=fit&width=640&height=640)

3. Bonus Time Target

Reward players with a surprise extra target that can add precious seconds to the game!](https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-03-bonus-time-target-in-fortnite)
