# 4. Weapon Leveling System

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-04-weapon-leveling-system-in-fortnite
> **爬取时间**: 2025-12-27T00:29:25.617953

---

In this step, you will create a gun game-style weapon-leveling system in Verse that uses an [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device to give players a new weapon when they complete a combo.

## Modify Your Island

1. Select the **Island Settings** device in the viewport or **Outliner** panel.
2. In the **Details** panel, set the following parameters:

   1. Set **Infinite Reserve Ammo** to **True**.
   2. Set **Infinite Magazine Ammo** to **False**. This change requires the player to reload, an essential aspect of many Fortnite weapons.
3. Select the **Item Granter** device in the viewport or **Outliner** panel.
4. In the **Details** panel, set the following parameters:

   1. Set **On Grant Action** to **Clear Inventory**.
   2. Set **Grant** to **Current Item**.
   3. Remove all elements from the **Index List**, then add the following five elements:

      1. Assault Rifle L1
      2. Lever Action Rifle L2
      3. Heavy Shotgun L3
      4. Six Shooter L4
      5. Hand Cannon L5
   4. Set **Receiving Players** to **All**.
   5. Set **Grant on Cycle** to **True**.
   6. Set **Grant on Game Start** to **True**.
   7. Remove the **Enable and Grant Item** function bindings.
5. Select the **Score Manager** device in the viewport or **Outliner** panel.
6. In the **Details** panel, set **Display Score Update** **on HUD** to **True**.

## Write Verse Code

This page guides you step by step through the code changes, but if you want to check your work, review the [Complete Code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-04-weapon-leveling-system-in-fortnite#complete-code) section for the final result.

1. Open the `shooting_range_manager_device.verse` file.
2. Add the following variables to store a reference to the item granter device and track item level properties.

   ```verse
       @editable
       ItemGranter:item_granter_device = item_granter_device{}

       @editable
       MaxWeaponLevel:int = 5

       var CurrentWeaponLevel:int = 1
   ```
3. Add the `IncreaseWeaponLevel` method to increase the weapon level variable and cycle to the next item.

   ```verse
       # Increases the player's weapon level by one (up to the maximum value).
       IncreaseWeaponLevel():void=
           if:
               # If able to retrieve the first player and current weapon level isn't maxed, then...
               Player:player = GetPlayspace().GetPlayers()[0]
               CurrentWeaponLevel < MaxWeaponLevel
           then:
               # Increase weapon level and cycle to the next item.
               set CurrentWeaponLevel += 1
               ItemGranter.CycleToNextItem(Player)
   ```
4. Modify the `OnComboTargetHit` method to call `IncreaseWeaponLevel`.

   ```verse
       # A hit callback that scores the ComboTarget and resets the combo.
       OnComboTargetHit():void=
           AdjustScore(ComboTargetScore)

   <# --- New Code Start --- #>

           IncreaseWeaponLevel()

   <# --- New Code End --- #>

           ResetCombo()
   ```
5. Modify the `AdjustScore` method to multiply the score awarded by the weapon level.

   ```verse
       # Adjusts the player's score by the provided value.
       AdjustScore(Value:int):void=
           # Start the timer if it hasn't started yet.
           if (not IsTimerStarted?):
               StartTimer()
          
   <# --- New Code Start --- #>

           # Sets the score award to the base value of the target multiplied by the current weapon level.
           ScoreManager.SetScoreAward(Value * CurrentWeaponLevel)

   <# --- New Code End --- #>

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
   ```
6. Save and build your Verse code.

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
    
    @editable
    ItemGranter:item_granter_device = item_granter_device{}

    @editable
    MaxWeaponLevel:int = 5

    var CurrentWeaponLevel:int = 1
    
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
        IncreaseWeaponLevel()
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

    # Increases the player's weapon level by one (up to the maximum value).
    IncreaseWeaponLevel():void=
        if:
            # If able to retrieve the first player and current weapon level isn't maxed, then...
            Player:player = GetPlayspace().GetPlayers()[0]
            CurrentWeaponLevel < MaxWeaponLevel
        then:
            # Increase weapon level and cycle to the next item.
            set CurrentWeaponLevel += 1
            ItemGranter.CycleToNextItem(Player)

    # Adjusts the player's score by the provided value.
    AdjustScore(Value:int):void=
        # Start the timer if it hasn't started yet.
        if (not IsTimerStarted?):
            StartTimer()
       
        # Sets the score award to the base value of the target multiplied by the current weapon level.
        ScoreManager.SetScoreAward(Value * CurrentWeaponLevel)

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
2. In the **Details** panel, set ItemGranter to the Item Granter device.
3. Push your changes and playtest your island.

   1. Verify the weapon swaps after hitting a combo target, up to 5 times. At the 5th level, it stays the same.
   2. Verify the incoming score multiplies by the weapon level.

## Ready for More?

[![5. Refactor and Refine](https://dev.epicgames.com/community/api/documentation/image/d73cd87f-7a6e-438b-a44b-8cc5e4c1d2a3?resizing_type=fit&width=640&height=640)

5. Refactor and Refine

Learn some key Verse concepts as you tweak your code!](https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-05-refactor-and-refine-in-fortnite)
