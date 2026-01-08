# 8. Visualizing Players Holding Objectives

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-08-visualizing-players-holding-objectives-in-verse>
> **爬取时间**: 2025-12-27T00:21:46.006829

---

The Infiltrator's invisibility creates an interesting problem when it comes to grabbing the Defender's objective. How are the Defenders going to find an invisible player who might be sprinting back to base with their objective? To solve this issue, you can use a visual aid, in this case a prop, to show the Defenders where the Infiltrator is.

Follow the steps below to learn how to create an object that floats above a player's head when they're holding an objective.

## Creating the Item Capture Manager

1. Create a new Verse device named **item\_capture\_manager** using [Verse Explorer](/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and drag the device into the level.
2. At the top of the `item_capture_manager` file:
   1. Add `using { /UnrealEngine.com/Temporary/SpatialMath }` to access the `vector3` struct. You'll use this to know where to teleport the indicators that floats above a player's head. Also add `using { /Fortnite.com/Characters }` to access a player's `fort_character`.

      ```verse
      |  |  |
      | --- | --- |
      |  | using { /Fortnite.com/Devices } |
      |  | using { /Verse.org/Simulation } |
      |  | using { /Fortnite.com/Characters } |
      |  | using { /UnrealEngine.com/Temporary/Diagnostics } |
      |  | using { /UnrealEngine.com/Temporary/SpatialMath } |

      Copy full snippet
      ```

3. In the `item_capture_manager` class definition, add the following fields:
   1. An editable array of Capture Item Spawner devices named `CaptureItemSpawners`. This array holds the Capture Item Spawner device for the Infiltrators.

      ```verse
      |  |  |
      | --- | --- |
      |  | item_capture_manager := class(creative_device): |
      |  |  |
      |  | Logger:log = log{Channel := triad_item_capture_log_channel} |
      |  |  |
      |  | # Capture item spawner that spawns the item to capture. |
      |  | @editable |
      |  | CaptureItemSpawner:capture_item_spawner_device = capture_item_spawner_device{} |

      Copy full snippet
      ```

   2. An editable creative prop named `CaptureItemIndicator`. This is the prop that will float above an Infiltrator's head when they grab the objective.

      ```verse
                               # Capture item spawner that spawns the item to capture.
                               @editable
                               CaptureItemSpawner:capture_item_spawner_device = capture_item_spawner_device{}
                  
                               # Prop that floats above a players head when they're holding the item from 
                               # the CaptureItemSpawner.
                               @editable
                               CaptureItemIndicator:creative_prop = creative_prop{}
      Copy full snippet
      ```

   3. An editable map indicator device named `MapIndicator`. This will sit under the CaptureItemSpawner in the level, and display on the map where the objectives for each team are.

      ```verse
                               # Prop that floats above a players head when they're holding the item from 
                               # the CaptureItemSpawner.
                               @editable
                               CaptureItemIndicator:creative_prop = creative_prop{}
              
                               # Indicator that displays on the map where the objectives for each team are
                               @editable
                               MapIndicator:map_indicator_device = map_indicator_device{}
      Copy full snippet
      ```

   4. Two editable floats `UpdateRateSeconds` and `VerticalOffset`. The first controls how quickly the position of the `CaptureItemIndicator` changes, and the second controls how far above a player's head the `CaptureItemIndicator` floats.

      ```verse
                               # Indicator that displays on the map where the objectives for each team are
                               @editable
                               MapIndicator:map_indicator_device = map_indicator_device{}
              
                               # How often the CaptureItemIndicator updates its position.
                               @editable
                               UpdateRateSeconds:float = 0.15
              
                               # How high above a player's head the CaptureItemIndicator floats.
                               @editable
                               VerticalOffset:float = 180.0
      Copy full snippet
      ```

   5. An editable hud message device named `ItemGrabbedMessageDevice`. This sends a message to each player when an objective is picked up.

      ```verse
                               # How high above a player's head the CaptureItemIndicator floats.
                               @editable
                               VerticalOffset:float = 180.0
              
                               # Displays a message when a player grabs the Capture Item.
                               @editable
                               ItemGrabbedMessageDevice:hud_message_device = hud_message_device{}
      Copy full snippet
      ```

   6. An editable score manager device named `ScoreManagerDevice`. This awards score to a team whenever a player captures the obje

      ```verse
                               # Displays a message when a player grabs the Capture Item.
                               @editable
                               ItemGrabbedMessageDevice:hud_message_device = hud_message_device{}
                  
                               # Awards score when a player captures the capture Item.
                               @editable
                               ScoreManagerDevice:score_manager_device = score_manager_device{}
      Copy full snippet
      ```

   7. An editable float named `ReturnTime`. If the capture item has a return time before returning to the CaptureItemSpawner, you need to track how long the length of that return time to know when to return the indicators back to the CaptureItemSpawner.
4. Add a new method `FollowCharacter()` to the `item_capture_manager` class definition. This method takes a `fort_character` and tracks them using the indicators above their head. Add the `<suspends>` specifier to this function, since you want to spawn one of these for a player whenever they're holding an objective.

   ```verse
        # Causes the CaptureItemIndicator to continuously follow a player above their head.
        # Races between the update loop for the CaptureItemIndictator, and whether the player
        # captures the item, drops the item, or is eliminated.
        FollowCharacter(FortCharacter:fort_character)<suspends>:void=
            Logger.Print("Spawned FollowCharacter function")
   Copy full snippet
   ```

## Running a Race While Holding the Objective

It's important to think about what happens when a player grabs the objective. The player can:

- Move around, in which case you need your CaptureItem and Map indicators to continuously update to the player's position. This can be done in a loop.
- Capture the objective, in which case you need your indicators to return to the CaptureItemSpawner somewhere out of sight since they shouldn't be visible unless a player is holding the capture item.
- Drop the objective or be eliminated, in which case the indicators need to stay where the item was dropped, and return to the CaptureItemSpawner when the capture item returns.

To achieve this, you're going to set up a [race expression](/documentation/en-us/fortnite/race-in-verse). By using a `race` between the three conditions above, you can continue to update the position of the indicators while waiting for the player to either drop or capture the objective.

1. Add a `race` expression to `FollowCharacter()`. Set up the race to run between a `loop`, an `Await()` for the `CaptureItemSpawner`'s `ItemCapturedEvent`, an `Await()` for the `CaptureItemSpawner`'s `ItemCapturedDroppedEvent`, and an `Await()` for the `FortCharacter`'s `EliminatedEvent()`.

   ```verse
        FollowCharacter(FortCharacter:fort_character)<suspends>:void=
            Logger.Print("Spawned FollowCharacter function")
            race:
                loop:
                CaptureItemSpawner.ItemCapturedEvent.Await()
                CaptureItemSpawner.ItemDroppedEvent.Await()
                FortCharacter.EliminatedEvent().Await()
   Copy full snippet
   ```

2. In the `loop`, get the position of `FortCharacter` and save it in a variable `Transform`.

   ```verse
        loop:
            Transform := FortCharacter.GetTransform()
   Copy full snippet
   ```

3. Now spawn a `MoveTo()` to move both `CaptureItemIndicator` and `MapIndicator` to the `Transform`'s translation and rotation plus the `VerticalOffset` you set up earlier over an `UpdateRateSeconds` amount of time. You want to `Spawn{}` both `MoveTo()` functions because both the `CaptureItemIndicator` and `MapIndicator` need to move at the exact same time, rather than waiting for each other's expression to complete. Because the translation is a `vector3` consisting of `X`, `Y`, and `Z` coordinates, you'll have to put the `VerticalOffset` inside a new `vector3`. Since the `VerticalOffset` is the vertical distance above a player's head, set it as the `Z` value of the `vector3`.

   ```verse
        loop:
             Transform := FortCharacter.GetTransform()
             spawn{CaptureItemIndicator.MoveTo(Transform.Translation + vector3{Z := VerticalOffset}, Transform.Rotation, UpdateRateSeconds)}
             spawn{MapIndicator.MoveTo(Transform.Translation + vector3{Z := VerticalOffset}, Transform.Rotation, UpdateRateSeconds)}
   Copy full snippet
   ```

4. Finally, sleep for `0.0` seconds. This ensures the loop runs only once per [simulation update](/documentation/en-us/fortnite/verse-glossary#verse-glossary), and does not go out of control spawning `MoveTo()` functions. Your `FollowCharacter()` code should now look like:

   ```verse
        # Causes the CaptureItemIndicator to continuously follow a player above their head.
        # Races between the update loop for the CaptureItemIndictator, and whether the player
        # captures the item, drops the item, or is eliminated.
        FollowCharacter(FortCharacter:fort_character)<suspends>:void=
            Logger.Print("Spawned FollowCharacter function")
            race:
                loop:
                    Transform := FortCharacter.GetTransform()
                    spawn{CaptureItemIndicator.MoveTo(Transform.Translation + vector3{Z := VerticalOffset}, Transform.Rotation, UpdateRateSeconds)}
                    spawn{MapIndicator.MoveTo(Transform.Translation + vector3{Z := VerticalOffset}, Transform.Rotation, UpdateRateSeconds)}
                    # We want to make sure this loop runs only once per simulation update, so we sleep for one game tick.
                    Sleep(0.0)
                CaptureItemSpawner.ItemCapturedEvent.Await()
                CaptureItemSpawner.ItemDroppedEvent.Await()
                FortCharacter.EliminatedEvent().Await()
            Logger.Print("Objective dropped or captured")
   Copy full snippet
   ```

   ## Resetting the Indicators

5. When the capture item is captured or returned, you need to return the indicators to the `CaptureItemSpawner` somewhere out of sight. In this case, you'll teleport them high above the `CaptureItemSpawner`. To do this, add a function named `ReturnIndicators()` to the `item_capture_manager` class definition.

   ```verse
        # Returns the map and capture item indicators back to their initial positions above the spawners.
        ReturnIndicators(InAgent:agent):void=
   Copy full snippet
   ```

6. Get the transform of the `CaptureItemSpawner` and save it in a variable `SpawnerTransform`. Then spawn a `MoveTo()` for the `CaptureItemIndicator` and `MapIndicator` to the `CaptureItemSpawner`'s transform and rotation, adding the `VerticalOffset` in the same way as you did in the `loop` to put them above the `CaptuerItemSpawnwer`. If you want your prop to stay far away out of sight, you can multiply the `VerticalOffset` by a large number, in this case 10. Your completed `ReturnIndicators()` method should look like:

   ```verse
        # Returns the map and capture item indicators back to their initial positions above the spawners.
        ReturnIndicators():void=
            SpawnerTransform := CaptureItemSpawner.GetTransform()
            # Teleport back to spawner, hiding the CaptureItemIndicator and MapIndicator above the map out of site.
            spawn{CaptureItemIndicator.MoveTo(SpawnerTransform.Translation + vector3{Z := VerticalOffset * 10.0}, SpawnerTransform.Rotation, UpdateRateSeconds)}
            spawn{MapIndicator.MoveTo(SpawnerTransform.Translation + vector3{Z := VerticalOffset * 10.0}, SpawnerTransform.Rotation, UpdateRateSeconds)}
            Logger.Print("Returned Indicators to capture spawner")
   Copy full snippet
   ```

## Handling Players Grabbing, Dropping, and Capturing the Objective

1. Add a new method, `OnItemPickedUp()` to the `item_capture_manager` class definition. This method takes an `agent` and spawns an instance of `FollowCharacter()` for that character.

   ```verse
        # Signal each player when a player grabs the objective
        OnItemPickedUp(InAgent:agent):void=
            Logger.Print("Objective Grabbed")
   Copy full snippet
   ```

2. Get the `FortCharacter` for `InAgent`, and spawn a `FollowCharacter()` function using that `FortCharacter`. Your completed `OnItemPickedUp()` method should look like:

   ```verse
        # Signal each player when a player grabs the objective
        OnItemPickedUp(InAgent:agent):void=
            Logger.Print("Objective Grabbed")
            if(FortCharacter := InAgent.GetFortCharacter[]):
                ItemGrabbedMessageDevice.Show()
                spawn{FollowCharacter(FortCharacter)}
   Copy full snippet
   ```

3. Add a new method `OnItemCaptured()` to the `item_capture_manager` class definition. This method takes the `agent` who captured the objective.

   ```verse
        # When the item is captured, award score to the capturing team, and return the indicators.
        OnItemCaptured(CapturingAgent:agent):void=
            Logger.Print("Objective Captured")
   Copy full snippet
   ```

4. In `OnItemCaptured()`, activate the `ScoreManagerDevice` to award the capturing player's team score, and call `ReturnIndicators()` to return the indicators.

   ```verse
        # When the item is captured, award score to the capturing team, and return the indicators.
        OnItemCaptured(CapturingAgent:agent):void=
            Logger.Print("Objective Captured")
            ScoreManagerDevice.Activate()
            ReturnIndicators()
   Copy full snippet
   ```

5. Add a new method `OnItemDropped()` to the `item_capture_manager` class definition. This method takes the `agent` who dropped the item.

   ```verse
        # When a player drops an item, spawn a WaitForReturn() function
        # if the ReturnTime is greater than 0.
        OnItemDropped(InAgent:agent):void=
            Logger.Print("Objective Dropped")
   Copy full snippet
   ```

6. When the objective is dropped, the indicators should remain near the objective until the objective is either picked up or returns to the `CaptureItemSpawner`. To know when to return the indicators, you'll use the `ReturnTime` variable you set up earlier. If `ReturnTime` is greater than or equal to `0.0`, you want to wait that amount of time, then return the indicators. If `ReturnTime` is negative, the objective doesn't have a retun time, so you don't need to move in the indicators. To move the indicatrs back, spawn a new helper function named `WaitForReturn()`, which you'll define in the next step.

   ```verse
        # When a player drops an item, spawn a WaitForReturn() function
        # if the ReturnTime is greater than 0.
        OnItemDropped(InAgent:agent):void=
            Logger.Print("Objective Dropped")
            if(ReturnTime >= 0.0):
                spawn{WaitForReturn()}
            else:
                Logger.Print("The dropped objective does not return")
   Copy full snippet
   ```

7. Add a new method `WaitForReturn()` to the `item_capture_manager` class definitin. This function waits a `ReturnTime` amount of time, then returns the if the objective was not picked up before the wait completed. Add the `<suspends>` modifier to this method to allow it to `Sleep()`.

   ```verse
        # Wait a ReturnTime amount of Time, then return the indicators.
        WaitForReturn()<suspends>:void=
            Logger.Print("Waiting to return the indicators...")
   Copy full snippet
   ```

8. Whether you need to return the indicators or not depends on whether the objective was picked up before `ReturnTime` ends. If it was, you don't want to return the indicators since they would immediately jump back to the player, could cause some strange visuals. To solve this you'll use a logic variable where the value is equal to the result of a race.

   ```verse
        # Wait a ReturnTime amount of Time, then return the indicators.
        WaitForReturn()<suspends>:void=
            Logger.Print("Waiting to return the indicators...")
            # Return the CaptureItem and Map indicators if the capture item
            # is not picked up before time expires.
            ShouldReturn:logic := race:
   Copy full snippet
   ```

9. Your `WaitForReturn()` function needs to race between two conditions. The `ReturnTime` runs out and the objective returns to the `CaptureItemSpawner`, in which case you need to return the indicators and `ShouldReturn` should be `true`. Or the objective is picked up before `ReturnTime` expires, in which case `ShouldReturn` should be `false`. Since each of these conditions returns a value, you'll run the race using two seperate [`blocks`](/documentation/en-us/fortnite/block-in-verse).

   ```verse
        ShouldReturn:logic := race:
            block:
            block:
   Copy full snippet
   ```

10. In the first block, call `Sleep()` for a `ReturnTime` amount of time, then return `true`. In the second block, `Await()` the `CaptureItemSpawner.ItemPickedUpEvent`, and return false. The `ShouldReturn` variable will now be initialized to whichever one of these completes first.

    ```verse
         ShouldReturn:logic := race:
             block:
                 Sleep(ReturnTime)
                 true
             block:
                 CaptureItemSpawner.ItemPickedUpEvent.Await()
                 false
    Copy full snippet
    ```

11. If `ShouldReturn` is true you need to return the indicators. Call `ReturnIndicators()` if `ShouldReturn` evaluates to `true`. Your completed `WaitForReturn()` code should now look like:

    ```verse
         # Wait a ReturnTime amount of Time, then return the indicators.
         WaitForReturn()<suspends>:void=
             Logger.Print("Waiting to return the indicators...")
             # Return the CaptureItem and Map indicators if the capture item
             # is not picked up before time expires.
             ShouldReturn:logic := race:
                 block:
                     Sleep(ReturnTime)
                     true
                 block:
                     CaptureItemSpawner.ItemPickedUpEvent.Await()
                     false
              
             if(ShouldReturn?):
                 ReturnIndicators()
    Copy full snippet
    ```

12. Now in `OnBegin()`, subscribe the `CaptureItemSpawner`'s `ItemPickedUpEvent` to `OnItemPickedUp()`, the `ItemCapturedEvent` to `OnItemCaptured()`, and the `ItemDroppedEvent` to `OnItemDropped()`.

    ```verse
         OnBegin<override>()<suspends>:void=
             CaptureItemSpawner.ItemPickedUpEvent.Subscribe(OnItemPickedUp)
             CaptureItemSpawner.ItemCapturedEvent.Subscribe(OnItemCaptured)
             CaptureItemSpawner.ItemDroppedEvent.Subscribe(OnItemDropped)
             SpawnerTransform := CaptureItemSpawner.GetTransform()
    Copy full snippet
    ```

13. Finally in `OnBegin()`, put the indicators in their starting positions when the script runs by calling `MoveTo()` on the `CaptureItemIndicator` and `MapIndicator`. Your `OnBegin()` code should now look like:

    ```verse
         OnBegin<override>()<suspends>:void=
             CaptureItemSpawner.ItemPickedUpEvent.Subscribe(OnItemPickedUp)
             CaptureItemSpawner.ItemCapturedEvent.Subscribe(OnItemCaptured)
             CaptureItemSpawner.ItemDroppedEvent.Subscribe(OnItemDropped)
             SpawnerTransform := CaptureItemSpawner.GetTransform()
              
             # Teleport back to spawner, hiding the CaptureItemIndicator beneath the map out of site.
             CaptureItemIndicator.MoveTo(SpawnerTransform.Translation + vector3{Z := VerticalOffset * 10.0}, SpawnerTransform.Rotation, UpdateRateSeconds)
             MapIndicator.MoveTo(SpawnerTransform.Translation + vector3{Z := VerticalOffset * 10.0}, SpawnerTransform.Rotation, UpdateRateSeconds)
    Copy full snippet
    ```

14. Back in the editor, save the script, build it, and drag the device into the level. Choose an appropriate prop you want to serve as the `CaptureItemIndicator` into your level. This could be anything as long as it's visible enough. In this example, you'll use a Diamond. In the Details panel, assign **CaptureItemSpawner** to the **InfiltratorCaptureSpawner**, and **CaptureItemIndicator** to the prop you chose. Also assign **MapIndicator** to the Infiltrator's map indicator, **ItemGrabbedMessageDevice** to the Infiltrator's HUD message device, and **ScoreManagerDevice** to the Infiltrator's score manager. Set **ReturnTime** to a negative number, sinc the Infiltrator's capture item doesn't return.

    You should also set up an instance of `item_capture_manager` for the Attackers. Remember to change the **CaptureItemIndicator** to a prop that's different from the the Infiltrator props to avoid visual confusion for the teams, and make sure to assign all other devices. Set **ReturnTime** to a positive number, since the Attacker's capture item returns after a set time.
15. Click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, a player should have a prop above their head when they grab an objective. The prop should move around with the player, and when they drop or capture the objective, the prop should teleport back to the capture item spawner.

![Visualize Objective](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/6d0677be-6d6f-4452-b586-3dccb819d381/visualize-objective.gif)

## Next Step

In the [next step](/documentation/en-us/fortnite/triad-infiltration-9-creating-visual-aids-in-verse) of this tutorial, you'll learn how to quickly tell players what they should be doing in a game, and what to focus on when improving player experience.
