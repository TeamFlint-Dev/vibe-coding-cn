# 5. Refactor and Refine

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-05-refactor-and-refine-in-fortnite
> **爬取时间**: 2025-12-27T00:29:04.981091

---

This final tutorial step shows you how to improve your code while teaching some important Verse concepts as you go.

## Improve Your Verse Code

This page guides you step by step through the code changes, but if you want to check your work, review the [Complete Code](https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-05-refactor-and-refine-in-fortnite#complete-code) section for the final result.

**Refactoring** is a process in which you restructure existing code to improve the design or implementation without changing its behavior. The following are the most common goals when refactoring your code:

- Improving readability with better variable naming, better spacing or overall code structure.
- Improving performance with simpler or more efficient implementation of behavior.
- Reducing repetition and code bloat (large, unnecessary or overly complex code) by condensing similar functions into one or gathering multiple variables of similar type and purpose into containers like arrays.

Refactoring by following these goals should help you write code that is maintainable, easy to read and revisit, and extensible, easy to extend the capabilities of for future enhancements to the behavior. Making your games really level up!

### GetFirstPlayer()

Writing readable code is a great programming practice. For example, `GetFirstPlayer()` is clearer than `GetPlayspace().GetPlayers()[0]`. Additionally, this approach is a best practice for programming common operations as it clearly states the operation's intent.

1. Open the `shooting_range_manager_device.verse` file.
2. Add the `GetFirstPlayer` method.

   Notice the `GetFirstPlayer` method has the <[decides](https://dev.epicgames.com/documentation/en-us/fortnite/decides)><[transacts](https://dev.epicgames.com/documentation/en-us/fortnite/transacts)> effect specifiers because it can fail and rollback. Read [Failure in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse) for more details about failable expressions and failure contexts.

   ```verse
       # Returns the first player in the playspace.
       GetFirstPlayer()<decides><transacts>:player=
           return GetPlayspace().GetPlayers()[0]
   ```
3. Modify the `AdjustScore` method to use the new `GetFirstPlayer` method.

   Notice that the `GetFirstPlayer` method is called with brackets instead of parentheses because it is failable.

   ```verse
       # Adjusts the player's score by the provided value.
       AdjustScore(Value:int):void=
           # Start the timer if it hasn't started yet.
           if (not IsTimerStarted?):
               StartTimer()
          
           # Sets the score award to the base value of the target multiplied by the current weapon level.
           ScoreManager.SetScoreAward(Value * CurrentWeaponLevel)

   <# --- New Code Start --- #>

           # Gets the first player in the playspace.
           if (Player:player = GetFirstPlayer[]):

   <# --- New Code End --- #>

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
4. Modify the `IncreaseWeaponLevel` method to use the new `GetFirstPlayer` method.

   ```verse
       # Increases the player's weapon level by one (up to the maximum value).
       IncreaseWeaponLevel():void=
           if:
               # If able to retrieve the first player and current weapon level isn't maxed, then...

   <# --- New Code Start --- #>

               Player:player = GetFirstPlayer[]

   <# --- New Code End --- #>

               CurrentWeaponLevel < MaxWeaponLevel
           then:
               # Increase weapon level and cycle to the next item.
               set CurrentWeaponLevel += 1
               ItemGranter.CycleToNextItem(Player)
   ```

### Target Class Wrappers and Arrays

Another key goal when cleaning up code is minimizing duplication. In the current implementation, each Good and Bad Target defines its own callback and hit flag, making the code repetitive.

A better approach is to create a wrapper [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) that contains everything an individual target needs. The shooting range manager can then manage these target wrappers in an array, rather than defining each component individually.

This not only reduces duplication but also improves scalability. You can add as many targets as you like without writing additional code.

1. Define the `good_target_wrapper` class. You can put this above your `shooting_range_manager_device` class definition.

   ```verse
   # A wrapper class for the good targets to support array storage with a self-contained event callback.
   good_target_wrapper := class:

       @editable
       Target:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       Score:int = 100

       # A circular reference to the shooting range manager device.
       var RangeManager:shooting_range_manager_device= shooting_range_manager_device{}

       # Tracks if this target is hit to support combo functionality.
       var IsHit:logic = false

       # Initializes the target's manager reference and event subscription.
       Init(Manager:shooting_range_manager_device):void=
           set RangeManager = Manager
           Target.HitEvent.Subscribe(OnHit)

       # A hit callback that updates the hit state, scores the target, and checks the combo.
       OnHit():void=
           if (not IsHit?):
               set IsHit = true
               Target.Disable()
               RangeManager.AdjustScore(Score)
               RangeManager.CheckCombo()

       # Resets the target's hit state.
       Reset():void=
           set IsHit = false
           Target.Enable()
   ```
2. Define the `bad_target_wrapper` class. You can put this above your `shooting_range_manager_device` class definition.

   ```verse
   # A wrapper class for the bad targets to support array storage with a self-contained event callback.
   bad_target_wrapper := class:

       @editable
       Target:shooting_range_target_device = shooting_range_target_device{}

       @editable
       Score:int = -100

       # A circular reference to the shooting range manager device.
       var RangeManager:shooting_range_manager_device= shooting_range_manager_device{}

       # Initializes the target's manager reference and event subscription.
       Init(Manager:shooting_range_manager_device):void=
           set RangeManager = Manager
           Target.HitEvent.Subscribe(OnHit)

       # A hit callback that pops the target down, scores the target, and resets the combo.
       OnHit():void=
           Target.PopDown()
           RangeManager.AdjustScore(Score)
           RangeManager.ResetCombo()
   ```
3. Add the following array properties to your shooting range manager device.

   ```verse
       @editable:
       GoodTargets:[]good_target_wrapper = array{}

       @editable
       BadTargets:[]bad_target_wrapper = array{}
   ```
4. Remove the following from your shooting range manager device. These are handled by the wrapper classes now.

   - GoodTarget1-3
   - GoodTargetScore
   - BadTarget1-3
   - BadTargetScore
   - HitGoodTarget1-3
   - OnGoodTarget1-3Hit()
   - OnBadTarget1-3Hit()
5. Modify the `OnBegin` method to initialize the Good and Bad Targets by looping through the array.

   ```verse
       # Runs when the device is started in a running game.
       OnBegin<override>()<suspends>:void=

   <# --- New Code Start --- #>

           # Initialize GoodTargets.
           for (GoodTarget : GoodTargets):
               GoodTarget.Init(Self)

           # Initialize BadTargets.
           for (BadTarget : BadTargets):
               BadTarget.Init(Self)

   <# --- New Code End --- #>

           # Subscribing to the ComboTarget HitEvent.
           ComboTarget.HitEvent.Subscribe(OnComboTargetHit)

           # Disabling the ComboTarget on game start.
           ComboTarget.Disable()

           # Subscribing to the BonusTimeTarget HitEvent.
           BonusTimeTarget.HitEvent.Subscribe(OnBonusTimeTargetHit)

           # Disabling the BonusTimeTarget on game start.
           BonusTimeTarget.Disable()
   ```
6. Modify the `CheckCombo` method to check for combo completion by looping through the Good Target array.

   ```verse
       # If the combo is complete, enable the ComboTarget.
       CheckCombo():void=

   <# --- New Code Start --- #>

           # If any of the good targets are not hit, exit the function.
           for (GoodTarget : GoodTargets):
               if (not GoodTarget.IsHit?):
                   return

   <# --- New Code End --- #>
          
           # If all of the good targets are hit, enable the combo target.
           ComboTarget.Enable()
   ```
7. Update the `ResetCombo` method to loop through the Good Target array.

   ```verse
       # Resets the combo tracking variables, re-enables all GoodTargets, and disables the ComboTarget.
       ResetCombo():void=

   <# --- New Code Start --- #>

           for (GoodTarget : GoodTargets):
               GoodTarget.Reset()

   <# --- New Code End --- #>

           ComboTarget.PopDown()
           ComboTarget.Disable()
   ```
8. Save and build your Verse code.

## Complete Code

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Random }
using { /Verse.org/Simulation }

<#>
    Utility Classes
<#>

# A wrapper class for the good targets to support array storage with a self-contained event callback.
good_target_wrapper := class:

    @editable
    Target:shooting_range_target_track_device = shooting_range_target_track_device{}

    @editable
    Score:int = 100

    # A circular reference to the shooting range manager device.
    var RangeManager:shooting_range_manager_device= shooting_range_manager_device{}

    # Tracks if this target is hit to support combo functionality.
    var IsHit:logic = false

    # Initializes the target's manager reference and event subscription.
    Init(Manager:shooting_range_manager_device):void=
        set RangeManager = Manager
        Target.HitEvent.Subscribe(OnHit)

    # A hit callback that updates the hit state, scores the target, and checks the combo.
    OnHit():void=
        if (not IsHit?):
            set IsHit = true
            Target.Disable()
            RangeManager.AdjustScore(Score)
            RangeManager.CheckCombo()

    # Resets the target's hit state.
    Reset():void=
        set IsHit = false
        Target.Enable()

# A wrapper class for the bad targets to support array storage with a self-contained event callback.
bad_target_wrapper := class:

    @editable
    Target:shooting_range_target_device = shooting_range_target_device{}

    @editable
    Score:int = -100

    # A circular reference to the shooting range manager device.
    var RangeManager:shooting_range_manager_device= shooting_range_manager_device{}

    # Initializes the target's manager reference and event subscription.
    Init(Manager:shooting_range_manager_device):void=
        set RangeManager = Manager
        Target.HitEvent.Subscribe(OnHit)

    # A hit callback that pops the target down, scores the target, and resets the combo.
    OnHit():void=
        Target.PopDown()
        RangeManager.AdjustScore(Score)
        RangeManager.ResetCombo()

<#>
    Main Device
<#>

# A device that manages shooting range gameplay.
shooting_range_manager_device := class(creative_device):

    <#>
        Score Manager Property
    <#>

    @editable
    ScoreManager:score_manager_device = score_manager_device{}

    <#>
        Target Properties
    <#>

    @editable:
    GoodTargets:[]good_target_wrapper = array{}

    @editable
    BadTargets:[]bad_target_wrapper = array{}

    @editable
    ComboTarget:shooting_range_target_track_device = shooting_range_target_track_device{}

    @editable
    var ComboTargetScore:int = 500

    @editable
    BonusTimeTarget:shooting_range_target_track_device = shooting_range_target_track_device{}

    @editable
    BonusTimeTargetBaseChance:float = 0.05

    @editable
    BonusTimeReward:float = 10.0

    var GoodHitsSinceLastBonus:int = 0

    <#>
        Weapon Level Properties
    <#>

    @editable
    ItemGranter:item_granter_device = item_granter_device{}

    @editable
    MaxWeaponLevel:int = 5

    var CurrentWeaponLevel:int = 1

    <#>
        Time Properties
    <#>

    @editable
    Timer:timer_device = timer_device{}

    @editable
    InitialTimerDuration:float = 30.0

    @editable
    MaxTimerDuration:float = 60.0

    @editable
    EndGame:end_game_device = end_game_device{}

    var IsTimerStarted:logic = false

    <#>
        Entry and Exit Points
    <#>

    # Runs when the device is started in a running game.
    OnBegin<override>()<suspends>:void=
        # Initialize GoodTargets.
        for (GoodTarget : GoodTargets):
            GoodTarget.Init(Self)

        # Initialize BadTargets.
        for (BadTarget : BadTargets):
            BadTarget.Init(Self)

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

    <#>
        Target Callbacks
    <#>

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

    <#>
        Scoring
    <#>

    # Adjusts the player's score by the provided value.
    AdjustScore(Value:int):void=
        # Start the timer if it hasn't started yet.
        if (not IsTimerStarted?):
            StartTimer()
       
        # Sets the score award to the base value of the target multiplied by the current weapon level.
        ScoreManager.SetScoreAward(Value * CurrentWeaponLevel)

        # Gets the first player in the playspace.
        if (Player:player = GetFirstPlayer[]):
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

    # If the combo is complete, enable the ComboTarget.
    CheckCombo():void=
        # If any of the good targets are not hit, exit the function.
        for (GoodTarget : GoodTargets):
            if (not GoodTarget.IsHit?):
                return
       
        # If all of the good targets are hit, enable the combo target.
        ComboTarget.Enable()

    # Resets the combo tracking variables, re-enables all GoodTargets, and disables the ComboTarget.
    ResetCombo():void=
        for (GoodTarget : GoodTargets):
            GoodTarget.Reset()

        ComboTarget.PopDown()
        ComboTarget.Disable()

    # Increases the player's weapon level by one (up to the maximum value).
    IncreaseWeaponLevel():void=
        if:
            # If able to retrieve the first player and current weapon level isn't maxed, then...
            Player:player = GetFirstPlayer[]
            CurrentWeaponLevel < MaxWeaponLevel
        then:
            # Increase weapon level and cycle to the next item.
            set CurrentWeaponLevel += 1
            ItemGranter.CycleToNextItem(Player)

    <#>
        Utility
    <#>

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

    # Returns the first player in the playspace.
    GetFirstPlayer()<decides><transacts>:player=
        return GetPlayspace().GetPlayers()[0]
```

## Bring It Together

You must set new values for the changed editable properties on your Verse device.

1. Select the **shooting\_range\_manager\_device** in the viewport or **Outliner** panel.
2. In the **Details** panel, set the following parameters:

   1. Add three elements to the **GoodTargets** array and set each to their respective targets. Optionally, you can also change the score value of an individual target now.
   2. Add three elements to the **BadTargets** array and set each to their respective targets. You can also optionally change the score value of an individual target now.
   3. Verify all other properties are set as expected.

## On Your Own

This section is over, but you don't have to be. For more Verse functionality and gameplay, see the documentation in [Learn Game Mechanics](https://dev.epicgames.com/documentation/en-us/fortnite/learn-game-mechanics-in-unreal-editor-for-fortnite).
