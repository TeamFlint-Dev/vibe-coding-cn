# 1. Combo System

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-01-combo-system-in-fortnite
> **爬取时间**: 2025-12-27T00:29:11.706258

---

Now that your targets behave as expected, you can spice things up even more using Verse!

## Create a Combo System

In this section, you'll add a combo system to your game that rewards players with a special target worth extra points when they the hit all of the good targets without hitting any bad ones.

1. Select a **Good Target** in the viewport.
2. Press the **Alt** key, then drag a duplicate target to the back of your shooting gallery. This will be the **Combo Target**.
3. In the **Details** panel, under **User Options**:

   1. Set the **TargetType** to **Llama**.
   2. Set the **Score Value** to **0**. This means that only the Verse code will affect the score.
   3. Set the **Start Position** to **Down**.
   4. Set the **Reset Time Type** to **Never**.
   5. Set the **Pop Up Delay Type** to **Never**.
   6. Set the **Hopping Frequency Type** to **Random**. This means the target will move up and down randomly.
   7. Set the **Hop Length Type** to **Random**.
4. Add the following code to `shooting_range_manager_device.verse` to:

   1. Create a `shooting_range_target_track_device` variable that stores a reference to the Combo Target.
   2. Add an integer variable for its score value.
   3. Add three **logic** variables to track the combo state.

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

   <# --- New Code Start --- #>

       @editable
       ComboTarget:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       var ComboTargetScore:int = 500

       # Variables to track the combo state.
       var HitGoodTarget1:logic = false
       var HitGoodTarget2:logic = false
       var HitGoodTarget3:logic = false

   <# --- New Code End --- #>

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

       # A hit callback that scores and pops down the first GoodTarget.
       OnGoodTarget1Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget1.PopDown()
       
       # A hit callback that scores and pops down the second GoodTarget.
       OnGoodTarget2Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget2.PopDown()

       # A hit callback that scores and pops down the third GoodTarget.
       OnGoodTarget3Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget3.PopDown()

       # A hit callback that scores and pops down the first BadTarget.
       OnBadTarget1Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget1.PopDown()

       # A hit callback that scores and pops down the second BadTarget.
       OnBadTarget2Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget2.PopDown()

       # A hit callback that scores and pops down the third BadTarget.
       OnBadTarget3Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget3.PopDown()

       # Adjusts the player's score by the provided value.
       AdjustScore(Value:int):void=
           ScoreManager.SetScoreAward(Value)

         # Gets the first player in the playspace.
           if (Player:player = GetPlayspace().GetPlayers()[0]):
               # Awards the points to the player.
               ScoreManager.Activate(Player)
   ```
5. Select the shooting\_range\_manager\_device in the viewport.
6. In the Details panel, set ComboTarget to the Llama target.
7. Add the following code to:

   1. Disable the Combo Target on game start.
   2. Set up the Combo Target hit event subscription.
   3. Score the Combo Target on hit.

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

   <# --- New Code Start --- #>

           # Subscribing to the ComboTarget HitEvent.
           ComboTarget.HitEvent.Subscribe(OnComboTargetHit)

           # Disabling the ComboTarget on game start.
           ComboTarget.Disable()

   <# --- New Code End --- #>

       # A hit callback that scores and pops down the first GoodTarget.
       OnGoodTarget1Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget1.PopDown()
       
       # A hit callback that scores and pops down the second GoodTarget.
       OnGoodTarget2Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget2.PopDown()

       # A hit callback that scores and pops down the third GoodTarget.
       OnGoodTarget3Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget3.PopDown()

       # A hit callback that scores and pops down the first BadTarget.
       OnBadTarget1Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget1.PopDown()

       # A hit callback that scores and pops down the second BadTarget.
       OnBadTarget2Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget2.PopDown()

       # A hit callback that scores and pops down the third BadTarget.
       OnBadTarget3Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget3.PopDown()

   <# --- New Code Start --- #>

       # A hit callback that scores the ComboTarget.
       OnComboTargetHit():void=
           AdjustScore(ComboTargetScore)

   <# --- New Code End --- #>

       # Adjusts the player's score by the provided value.
       AdjustScore(Value:int):void=
           ScoreManager.SetScoreAward(Value)

         # Gets the first player in the playspace.
           if (Player:player = GetPlayspace().GetPlayers()[0]):
               # Awards the points to the player.
               ScoreManager.Activate(Player)
   ```
8. Add the following code to:

   1. Set GoodTarget logic variables to true on hit.
   2. Disable the GoodTragets on hit so they don't pop back up.
   3. Add a `CheckCombo()` call to each GoodTarget to track its combo state when it is hit.
   4. Pop up the ComboTarget when all GoodTargets are hit.

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

   <# --- New Code End --- #>

       # A hit callback that scores and pops down the first BadTarget.
       OnBadTarget1Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget1.PopDown()

       # A hit callback that scores and pops down the second BadTarget.
       OnBadTarget2Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget2.PopDown()

       # A hit callback that scores and pops down the third BadTarget.
       OnBadTarget3Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget3.PopDown()

       # A hit callback that scores the ComboTarget.
       OnComboTargetHit():void=
           AdjustScore(ComboTargetScore)

   <# --- New Code Start --- #>

       # If the combo is complete, enables the ComboTarget.
       CheckCombo():void=
           if:
               # If all logics are set to true...
               HitGoodTarget1?
               HitGoodTarget2?
               HitGoodTarget3?
           then:
               # ...then enable the ComboTarget.
               ComboTarget.Enable()

   <# --- New Code End --- #>

       # Adjusts the player's score by the provided value.
       AdjustScore(Value:int):void=
           ScoreManager.SetScoreAward(Value)

         # Gets the first player in the playspace.
           if (Player:player = GetPlayspace().GetPlayers()[0]):
               # Awards the points to the player.
               ScoreManager.Activate(Player)
   ```

   When using an `if` statement, you can put conditions on multiple lines, but they all must succeed to execute the `then` block.

   For example, in `CheckCombo()`, there are three statements using the query operator (`?`) to check whether a logic value is true. If a single one is false, the Combo Target will not be enabled.

   For more information, see [If in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse) and [Operators in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse).
9. Add the following code to reset the combo when hitting a Bad Target.

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

   <# --- New Code Start --- #>

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

   <# --- New Code End --- #>

       # If the combo is complete, enables the ComboTarget.
       CheckCombo():void=
           if:
               # If all logics are set to true...
               HitGoodTarget1?
               HitGoodTarget2?
               HitGoodTarget3?
           then:
               # ...then enable the ComboTarget.
               ComboTarget.Enable()

   <# --- New Code Start --- #>

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

   <# --- New Code End --- #>

       # Adjusts the player's score by the provided value.
       AdjustScore(Value:int):void=
           ScoreManager.SetScoreAward(Value)

         # Gets the first player in the playspace.
           if (Player:player = GetPlayspace().GetPlayers()[0]):
               # Awards the points to the player.
               ScoreManager.Activate(Player)
   ```
10. Select **Verse** > **Build Verse Code** from the **Menu Bar**.
11. Playtest your changes in an Edit Session.

    1. Verify GoodTragets stay down when you hit them and only pop back up when hitting a Bad or Combo Target.
    2. Verify the ComboTarget starts down, pops up when you complete the combo, and stays down when you hit it.
    3. Verify the ComboTarget drops when you hit a BadTarget during a full combo.
    4. Verify your score increases when hitting the ComboTarget.

## Ready for More?

[![2. Timer System](https://dev.epicgames.com/community/api/documentation/image/60517b39-a9a8-42ab-bb1c-b696bf1226a3?resizing_type=fit&width=640&height=640)

2. Timer System

Build suspense by adding a countdown to the end of the game!](https://dev.epicgames.com/documentation/en-us/fortnite/verse-start-02-timer-system-in-fortnite)
