# 3. Bonus Time Target

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-03-bonus-time-target-in-fortnite
> **爬取时间**: 2025-12-27T00:29:32.261531

---

In this step, you will create a special target that awards extra time when a player hits it. The target pops up randomly when hitting positive scoring targets, and the odds that it will pop up increase until it appears.

## Modify Your Island

1. Select the **Combo Target** in the viewport.
2. Press the **Alt** key, then left-click the axis widget, and drag a duplicate target to the front of your shooting gallery. This is the **bonus time target**.
3. In the **Details** panel, set the **TargetType** to **Dancing**.

## Write Verse Code

This page guides you step by step through the code changes, but if you want to check your work, review the [Complete Code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-03-bonus-time-target-in-fortnite#complete-code) section for the final result.

1. Open the `shooting_range_manager_device.verse` file.
2. Add the following library to support random number generation.

   ```verse
   using { /Verse.org/Random }
   ```
3. Add the following variables to store the target device reference and related properties. The time duration and reward variables are in seconds.

   ```verse
       @editable
       InitialTimerDuration:float = 30.0

       @editable
       MaxTimerDuration:float = 60.0

       @editable
       BonusTimeTarget:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       BonusTimeTargetBaseChance:float = 0.05

       @editable
       BonusTimeReward:float = 10.0

       var GoodHitsSinceLastBonus:int = 0
   ```
4. Add the `OnBonusTimeTargetHit` callback method that increases the timer.

   ```verse
       # A hit callback that adds bonus time and disables the BonusTimeTarget.
       OnBonusTimeTargetHit():void=        
           CurrentDuration:float = Timer.GetActiveDuration()
           Timer.SetActiveDuration(CurrentDuration + BonusTimeReward)

           BonusTimeTarget.PopDown()
           BonusTimeTarget.Disable()
   ```
5. Modify the `OnBegin` method to set up the bonus time target event subscription and disable it.

   ```verse
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

   <# --- New Code Start --- #>

           # Subscribing to the BonusTimeTarget HitEvent.
           BonusTimeTarget.HitEvent.Subscribe(OnBonusTimeTargetHit)

           # Disabling the BonusTimeTarget on game start.
           BonusTimeTarget.Disable()

   <# --- New Code End --- #>
   ```
6. Modify the `StartTimer` method to set the timer's maximum and active durations.

   ```verse
       # Setup and start the timer.
       StartTimer():void=
           # Set the event subscription to call OnTimerSuccess when the timer finishes.
           Timer.SuccessEvent.Subscribe(OnTimerSuccess)

   <# --- New Code Start --- #>

           # Set the max and active duration based on the set property values.
           Timer.SetMaxDuration(MaxTimerDuration)
           Timer.SetActiveDuration(InitialTimerDuration)

   <# --- New Code End --- #>

           # Start the timer.
           Timer.Start()

           # Track that the timer has started.
           set IsTimerStarted = true
   ```
7. Modify the `AdjustScore` method to randomly make the bonus time target appear based on how many Good Targets you hit.

   ```verse
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

   <# --- New Code Start --- #>

           # If a positive scoring target (Good or Combo) was hit, then...
           if (Value > 0):
               # Increment the good hit chain counter.
               set GoodHitsSinceLastBonus += 1
              
               # Generate a random floating point number between 0 and 1.
               RandomValue := GetRandomFloat(0.0, 1.0)

               # Determine the percent chance for the bonus target to activate.
               TargetNumber := (BonusTimeTargetBaseChance * GoodHitsSinceLastBonus)
              
               # If the random value generated is less than our percent chance, then...
               if (RandomValue <= TargetNumber):
                   # Reset the good hit chain counter.
                   set GoodHitsSinceLastBonus = 0

                   # Enable the BonusTimeTarget.
                   BonusTimeTarget.Enable()

   <# --- New Code End --- #>
   ```
8. Save and build your Verse code.

## Complete Code

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Random }
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
    InitialTimerDuration:float = 30.0

    @editable
    MaxTimerDuration:float = 60.0

    @editable
    EndGame:end_game_device = end_game_device{}

    var IsTimerStarted:logic = false

    @editable
    BonusTimeTarget:shooting_range_target_track_device = shooting_range_target_track_device{}

    @editable
    BonusTimeTargetBaseChance:float = 0.05

    @editable
    BonusTimeReward:float = 10.0

    var GoodHitsSinceLastBonus:int = 0
    
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

        # Subscribing to the BonusTimeTarget HitEvent.
        BonusTimeTarget.HitEvent.Subscribe(OnBonusTimeTargetHit)

        # Disabling the BonusTimeTarget on game start.
        BonusTimeTarget.Disable()

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

    # A hit callback that adds bonus time and disables the BonusTimeTarget.
    OnBonusTimeTargetHit():void=        
        CurrentDuration:float = Timer.GetActiveDuration()
        Timer.SetActiveDuration(CurrentDuration + BonusTimeReward)

        BonusTimeTarget.PopDown()
        BonusTimeTarget.Disable()
        
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

        # If a positive scoring target (Good or Combo) was hit, then...
        if (Value > 0):
            # Increment the good hit chain counter.
            set GoodHitsSinceLastBonus += 1
           
            # Generate a random floating point number between 0 and 1.
            RandomValue := GetRandomFloat(0.0, 1.0)

            # Determine the percent chance for the bonus target to activate.
            TargetNumber := (BonusTimeTargetBaseChance * GoodHitsSinceLastBonus)
           
            # If the random value generated is less than our percent chance, then...
            if (RandomValue <= TargetNumber):
                # Reset the good hit chain counter.
                set GoodHitsSinceLastBonus = 0

                # Enable the BonusTimeTarget.
                BonusTimeTarget.Enable()

    # Setup and start the timer.
    StartTimer():void=
        # Set the event subscription to call OnTimerSuccess when the timer finishes.
        Timer.SuccessEvent.Subscribe(OnTimerSuccess)

        # Set the max and active duration based on the set property values.
        Timer.SetMaxDuration(MaxTimerDuration)
        Timer.SetActiveDuration(InitialTimerDuration)

        # Start the timer.
        Timer.Start()

        # Track that the timer has started.
        set IsTimerStarted = true
```

## Bring It Together

1. Select the **shooting\_range\_manager\_device** in the viewport or **Outliner** panel.
2. In the **Details** panel, set **BonusTimeTarget** to the bonus time target.
3. Push your changes and playtest your island.

   1. Verify that the bonus time target appears occasionally after shooting positive scoring targets.

## Ready for More?

[![4. Weapon Leveling System](https://dev.epicgames.com/community/api/documentation/image/45eb2231-80c0-4ac9-a490-51ff1d17225c?resizing_type=fit&width=640&height=640)

4. Weapon Leveling System

Switch weapons while stringing combos.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-04-weapon-leveling-system-in-fortnite)
