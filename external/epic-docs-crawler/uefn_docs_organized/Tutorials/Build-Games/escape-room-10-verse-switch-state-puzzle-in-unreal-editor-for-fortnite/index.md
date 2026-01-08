# 10. Verse Switch State Puzzle

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-10-verse-switch-state-puzzle-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:18:01.957414

---

There are two puzzles created using Verse, the first is the [Tagged Lights Puzzle](https://dev.epicgames.com/documentation/en-us/fortnite/tagged-lights-puzzle-in-verse). The Tagged Lights puzzle is used in the hidden room behind the stairs in the sub basement.

[![The Tagged Lights Puzzle set up in the secret room.](https://dev.epicgames.com/community/api/documentation/image/1e8c65aa-1e9f-4241-aefe-ae108d13a4ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e8c65aa-1e9f-4241-aefe-ae108d13a4ca?resizing_type=fit)

You can copy and paste the code from the last section of the tutorial, but it’s strongly recommended that you build the puzzle piece-by-piece to get an understanding for how the Verse language works.

The second puzzle uses a hard-coded logic key to check each switch device to ensure the right switch has been triggered in the proper sequence.

When the proper switch is triggered, a success sound accompanies the switch. Likewise, a failure sound and message are triggered when the wrong switch is turned on during the sequence. A final success sound and message are played, and four item spawners are activated when the puzzle is solved.

You can use an array to check valid and invalid states, as well as trigger any device connected to a state. For this example, the answer key was hard-coded to help those new to coding understand what the code is doing.

## Set Up the Puzzle Devices

For this puzzle you’ll need the following devices:

- 4 x [**Switch Device**](https://dev.epicgames.com/documentation/fortnite-creative/using-switch-devices-in-fortnite-creative)
- 3 x [Audio Player Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-unreal-editor-for-fortnite)
- 4 x [**Item Switch Device**](https://dev.epicgames.com/documentation/fortnite-creative/using-item-spawner-devices-in-fortnite-creative)
- 2 x [**HUD Message Device**](https://dev.epicgames.com/documentation/fortnite-creative/using-hud-message-devices-in-fortnite-creative)
- 1 x [**Trigger Device**](https://dev.epicgames.com/documentation/fortnite-creative/using-trigger-devices-in-fortnite-creative)
- 1 x [Verse Device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite)

[![The set up of the second puzzle.](https://dev.epicgames.com/community/api/documentation/image/6aa95919-bacd-4464-9e7c-605ed0b21dc6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6aa95919-bacd-4464-9e7c-605ed0b21dc6?resizing_type=fit)

Rename your Item Spawners with the item they spawn.

### Switch Device

Place a Switch device on the wall next to the door and set the following options

| Option | Value | Explanation |
| --- | --- | --- |
| **Device Model** | Circuit Breaker | For this puzzle we want players to flip the circuit breaker. |
| **Sound** | False | Audio devices will play different sound cues for valid, invalid, and successful puzzle states. |
| **Interaction Time** | 0.1 | The interaction time should be immediate. |
| **Interaction Radius** | 1.0 | The player must be standing within one tile space in front of the switch to interact with it. |
| **Check State at Game Start** | False | The Verse device is going to run this check instead. |

Copy three more Switch devices on the wall and place them in a row.

### Audio Device

In the center of the square place an Audio device. Set the Audio options to the following.

| Option | Value | Explanation |
| --- | --- | --- |
| **Restart Audio when Activated** | True | You want the audio to be able to play more than once and start from the beginning each time. |
| **Play on Hit** | False | The Verse device is going to trigger the Audio device. |

Copy two more Audio devices. Rename the devices and add a sound cue to each:

- **Valid -** For the Valid Audio device play, **Match\_Round\_Change\_01\_Cue**.
- **Invalid -** For the Invalid Audio device play, **Player\_Checkpoint\_Trigger\_Cue**.
- **Completed -** For the Completed Audio device play, **CTF\_Return\_Team\_Cue**

### Trigger Device

To the right of the switches, place the Trigger device and set the following options.

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible In Game** | False | This device does not need to be visible in the game. |
| **Enabled on Game Start** | False | The Verse device is going to control the Trigger device. |
| **Triggered By Player** | False | The Verse device is going to control the Trigger device. |
| **Triggered by Vehicles** | False | The Verse device is going to control the Trigger device. |
| **Triggered by Sequencers** | False | The Verse device is going to control the Trigger device. |
| **Triggered by Water** | False | The Verse device is going to control the Trigger device. |
| **Times Can Trigger** | True, 10 | You want the trigger to be able to be used more than once in the puzzle |
| **Trigger VFX** | False | There isn’t a need for the visual effects. |
| **Trigger SFX** | False | The Audio devices will control the sound. |

Rename the device Invalid Trigger.

### HUD Message Device

Set up the first HUD Message device using the following options.

| Option | Value | Explanation |
| --- | --- | --- |
| **Message** | Invalid HUD Message:   - That’s not quite right.   FindItems HUD Message:   - I heard something metal fall in the basement. Maybe it's those items I need for the door? | These messages for the puzzle cover the failure and success states. |
| **Display Time** | Invalid HUD Message - 3.0  Completed HUD Message - 5.0 | The amount of time messages display for. |

Afterward, translate the HUD Message device outside of the basement wall so it’s not visible in the room and copy it.

Rename each of the HUD MEssage devices:

- Find Items HUD Message
- Invalid HUD Message

### Verse Device

Now you’re ready to create the Verse program that controls the puzzle. Create a new Verse device named **switch\_state\_puzzle** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and drag the device into the level. (For steps on how to create a new Verse device, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).)

## Puzzle Design

Turning on switches in the correct sequence allows players to move past this point of the escape room.

When the player turns on a switch in the correct sequence a bell sounds. If the wrong switch is turned on, a buzzer sounds and resets the switches. Invalid states cause a message to pop up, and successfully completing the puzzle plays a success sound, displays a helpful message and spawns items.

You can visualize the logic of the puzzle using the flowchart below.

[![The flow chart shows the logic behind the puzzle.](https://dev.epicgames.com/community/api/documentation/image/91eda1c1-0bae-4205-9ea6-5eca3f362e16?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91eda1c1-0bae-4205-9ea6-5eca3f362e16?resizing_type=fit)

*Click image to enlarge.*

The correct solution to the puzzle is shown in the table below.

| Puzzle Solution Matrix |  |  |  |  |
| --- | --- | --- | --- | --- |
| **Switches** | **2** | **3** | **1** | **4** |
| **1** |  |  | X |  |
| **2** | X |  | X |  |
| **3** | X | X | X |  |
| **4** | X | X | X | X |

## Verse Language Features Used

- `if`, `then`, `else`: With the `if`, `then`, and `else` expressions you can find valid and invalid states for each switch device and other devices dependent upon states.
- `failure`: Failure contexts are used to decide the current state of the puzzle and its solution.
- `for`: The `for` expression is used to iterate over each switch in the puzzle and perform operations on them.

## APIs Used

- [Editable Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse): Multiple Verse-authored device properties are exposed to UEFN so you can customize them in the editor. You’ll be able to create new puzzle configurations by changing these properties.
- [Device Events](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse): The buttons’ `InteractedWithEvent` are used to control the game state.

## Switch Interaction

Think about the steps required to execute the puzzle. First you’ll want to check if the Verse device registers an event when a player checks the box. To accomplish this, write [pseudocode](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#pseudocode) first to prove the interaction concept.

1. Underneath the switch\_state\_puzzle class definition, add the following editable fields.

   1. An editable array of type `switch_device` named `Switches`. This will refer to all your switches in the puzzle.
   2. A variable array of type `cancelable` named `SwitchSubscriptions`. This holds a reference to each switch\_device subscription that you can use to reset the switches.

      ```verse
        
           switch_state_puzzle := class(creative_device):
            
           @editable
           Switches : []switch_device = array{} #References the switches players can interact with
        
           var SwitchSubscriptions : []cancelable = array{}
        
      ```

2. In the same file, create a new class called `switch_event_handler`.In this class you’ll identify the Verse device and the switches.
3. Add a new method `OnSwitchPressed()` to the `switch_event_handler` class. This method checks the Verse device against player interaction by calling `CheckSequence()` in the `item_switch_puzzle` class. It also prints **Clicked** everytime a switch is interacted with.

   ```verse
     
        ## An event handler class to handle switch interactions
        ## This event handler is attached to events in the loop above
        switch_event_handler := class():
            PuzzleDevice : item_switch_puzzle
            Switch : switch_device
     
            OnSwitchPressed(InPlayer : agent) : void =
                Print("Clicked")
                PuzzleDevice.CheckSequence(InPlayer)
     
   ```

## Add a Print Logger

One way to check whether your code is successful or not is to print to a log. This allows you to see visually which parts of your code work as planned by printing messages. Add the print logger above the creative device class.

```verse
    Print<native><public>(Message:[]char, Level:log_level):void
```

## Referencing Switches

Now you need a way to reference your switch devices in the puzzle. Referencing the switch devices provides a way for you to loop through all switches and add event handlers to each switch when the game is running.

1. In `OnBegin()` in the `switch_state_puzzle` class, add a `for` expression to iterate through each `Switch` in the `Switches` array. Retrieve the index of each `Switch` and store it in a variable `SwitchIndex`.
2. Add a Print function under the for expression that identifies the switch being interacted with during running time by typing **Switch {SwitchIndex} added** in the Print command.
3. Because the puzzle solution is based on a certain order of switch states, you need to check if the puzzle is solved whenever any switch changes state. To do this, you’ll use the `switch_event_handler` class you defined earlier to listen for two different events per switch. For each switch, create two subscriptions, one for the switches `TurnedOnEvent`, and one for the switches `TurnedOffEvent`. Subscribe both events to the `OnSwitchPressed()` function of your `switch_event_handler` class. Pass a reference to both the `switch_state_puzzle` and the current `Switch`.

   ```verse
            ## Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                Print("Loading Switch Puzzle")

                # Looping through each switch and adding event handlers for each switch
                for (SwitchIndex -> Switch : Switches):
                    Print("Switch {SwitchIndex} added")
                    Switch.TurnedOnEvent.Subscribe(switch_event_handler{PuzzleDevice := Self, Switch := Switch}.OnSwitchPressed)
                    Switch.TurnedOffEvent.Subscribe(switch_event_handler{PuzzleDevice := Self, Switch := Switch}.OnSwitchPressed)
   ```

4. Save the script in Visual Studio Code, and in UEFN, click **Verse -> Build Verse Code**.

When testing your level, everytime you turn a switch on or off, you should see printed both the index of the switch you interacted with and word **Clicked**.

## Puzzle States

Each switch in the puzzle can have two states, valid and invalid.

To solve the puzzle, the player needs to toggle the switches on in a certain order. To implement this order in code, you need to define a sequence of valid states for each switch and check this sequence whenever a player updates the switch state..

1. Add a new method `ValidState()` to the `switch_state_puzzle` class. This method takes a string and plays an audio clip whenever a player flips a switch to a valid state, giving them audio feedback to know they’re on the right track.
2. In `ValidState()`, print out the `State` string that was passed and call `Play()` on the `ValidAudioPlayer` you set up ealier.

   ```verse
     
            # Actions to perform when the state is valid
            ValidState(State : string) : void =
                # Play a validation sound
                Print("Valid {State}")
                ValidAudioPlayer.Play()
     
   ```

3. Add a new method `InvalidState()` to the `switch_state_puzzle` class. This method resets all the switches after playing a sound when the player triggers an invalid state.

```verse
    # Actions to perform when the state is invalid
    InvalidState(InPlayer : agent) : void =
        # Play a buzz sound 
        # Clear all switches
        Print("Invalid")
```

1. In `InvalidState()`, let the player know they triggered an invalid state by printing **Invalid** and playing and audio clip by calling `Play()` on the `InvalidAudioPlayer` you set up earlier. You also need to call `Trigger()` on your `InvalidTrigger`, and `Show()` your `InvalidHUDMessage`.

```verse
 # Actions to perform when the state is invalid
    InvalidState(InPlayer : agent) : void =
        # Play a buzz sound 
        # Clear all switches
        Print("Invalid")
        InvalidAudioPlayer.Play()
        InvalidTrigger.Trigger()
        InvalidHUDMessage.Show()
```

Create a for loop that subscribes to events on the switch devices. The print statement identifies which switches a player flips and the sequence the switches are flipped.

```verse
        # Looping through each switch and adding event handlers for each switch
        for (SwitchIndex -> Switch : Switches):
            Print("Switch {SwitchIndex} added")
            Switch.TurnedOnEvent.Subscribe(switch_event_handler{PuzzleDevice := Self, Switch := Switch}.OnSwitchPressed)
            Switch.TurnedOffEvent.Subscribe(switch_event_handler{PuzzleDevice := Self, Switch := Switch}.OnSwitchPressed)
```

In a for loop, loop through all switches and turn each one off. Because the Switch’s `TurnOff()` method requires a player instigator, pass in the player who triggered the invalid state.

```verse
        ## Looping through the switches and turning each one off 
        for (SwitchIndex -> Switch : Switches):
            Switch.TurnOff(InPlayer)
```

1. **Save** your code and go back to UEFN and select **Verse** > **Build Verse Code**.

Next you need to create the logic in the `item_switch_puzzle` class that loops through each switch and validates its state against the puzzle matrix to determine which state (valid or invalid) the switch flip falls under.

### Sorting Switch States

Checking the validity of a switch flip is accomplished by creating a **CheckSequence** method that uses a for expression to check the current state of the switch. To define whether a switch’s state change is valid or not you can use an `if` statement to define which switch flip is valid in the sequence and which switch flips are not.

1. Add a new method `CheckSequence()`. This method takes the player as instigating the switch state changes and an array of logic values corresponding to switch states. In `CheckSequence()`, create a `for` loop to iterate through each switch in the `Switches` array. Get the index of each switch in the array and save it in a variable `SwitchIndex`. In the for loop, check each switch state by calling `GetCurrentState[]`. Then print the state of the switch to the log.

   ```verse
     
            # Function to validate the sequence of the switches
            CheckSequence(InPlayer : agent) : void =
                for (SwitchIndex -&gt; Switch : Switches):
                    if(Switch.GetCurrentState[]) then Print("{SwitchIndex} On") else Print("{SwitchIndex} Off")
     
   ```

Now you need to create a sequence of states to check against using `CheckSequence()`. To do this, you’re going to add new functionality to the `switch_event_handler`’s `OnSwitchPressed()` method.

### Sequence States

Create the sequence for the switch states using arrays. Each array checks the validity of the sequence the switches are flipped. Log the sequence of the player’s actions on the switches using the print logger to log whether the switches have been **Clicked** and whether the sequence is valid by printing the number of the sequence to the logger (“One”, “Two”, “Three”, and “Four”).

1. In `OnSwitchPressed()`, inside an `if` statement, call `CheckSequence()` passing both the player and a new array of logic values. This new array should correspond to your series of switches, with `false` values representing off switches, and `true` values representing on switches. Set the switch you want players to press first to `true`, and all other values to false. If the call to `CheckSequence[]` succeeds, call `ValidState()` passing in "One" to represent the first switch pressed.

   ```verse
     
            OnSwitchPressed(InPlayer : agent) : void =
                Print("Clicked")
                PuzzleDevice.CheckSequence(InPlayer)
     
   ```

2. Hardcode the answer key for the switch flips for each of the switches in your puzzle, in the order you want them to be pressed.

   ```verse
     
            if:
                    # check for valid states and hardcodes the validation of the states
                    # [off],[off],[on],[off] State One
                    not Switches[0].GetCurrentState[]
                    not Switches[1].GetCurrentState[]
                    Switches[2].GetCurrentState[]
                    not Switches[3].GetCurrentState[]
                then:
                    ValidState("One")
     
                else if:
                    # check for valid states
                    #[On], [Off], [On], [Off] State Two
                    Switches[0].GetCurrentState[]
                    not Switches[1].GetCurrentState[]
                    Switches[2].GetCurrentState[]
                    not Switches[3].GetCurrentState[]
                then:
                    ValidState("Two")
     
                else if:
                    # check for valid states
                    #[On], [On], [On], [Off] State Three
                    Switches[0].GetCurrentState[]
                    Switches[1].GetCurrentState[]
                    Switches[2].GetCurrentState[]
                    not Switches[3].GetCurrentState[]
                then:
                    ValidState("Three")
                 
                else if:
                    # check for valid states
                    #[On], [On], [On], [On] State Four, puzzle is completed
                    Switches[0].GetCurrentState[]
                    Switches[1].GetCurrentState[]
                    Switches[2].GetCurrentState[]
                    Switches[3].GetCurrentState[]
                then:
                    CompletedState()
     
   ```

3. Finally, add an `else` expression at the end that calls `InvalidState()`. This will happen if any of the calls to `CheckSequence[]` fail.

   ```verse
         
            else:
                    # It isn't a valid state, so it's invalid
                    InvalidState(InPlayer)
     
   ```

4. Your `switch_event_handler` code should now look like the following.

   ```verse
     
            # Function to validate the sequence of the switches
            CheckSequence(InPlayer : agent) : void =
                for (SwitchIndex -> Switch : Switches):
                    if(Switch.GetCurrentState[]) then Print("{SwitchIndex} On") else Print("{SwitchIndex} Off")
             
                if:
                    # check for valid states and hardcodes the validation of the states
                    # [off],[off],[on],[off] State One
                    not Switches[0].GetCurrentState[]
                    not Switches[1].GetCurrentState[]
                    Switches[2].GetCurrentState[]
                    not Switches[3].GetCurrentState[]
                then:
                    ValidState("One")
     
                else if:
                    # check for valid states
                    #[On], [Off], [On], [Off] State Two
                    Switches[0].GetCurrentState[]
                    not Switches[1].GetCurrentState[]
                    Switches[2].GetCurrentState[]
                    not Switches[3].GetCurrentState[]
                then:
                    ValidState("Two")
     
                else if:
                    # check for valid states
                    #[On], [On], [On], [Off] State Three
                    Switches[0].GetCurrentState[]
                    Switches[1].GetCurrentState[]
                    Switches[2].GetCurrentState[]
                    not Switches[3].GetCurrentState[]
                then:
                    ValidState("Three")
                 
                else if:
                    # check for valid states
                    #[On], [On], [On], [On] State Four, puzzle is completed
                    Switches[0].GetCurrentState[]
                    Switches[1].GetCurrentState[]
                    Switches[2].GetCurrentState[]
                    Switches[3].GetCurrentState[]
                then:
                    CompletedState()
     
                else:
                    # It isn't a valid state, so it's invalid
                    InvalidState(InPlayer)
     
   ```

5. **Save** your code and go back to UEFN and select **Verse** > **Build Verse Code**.

Now as you turn on switches in the game, the log will print:

- **Loading Switch Puzzle** - when the game starts
- **Switch {SwitchIndex} added** - when a switch is added to the loop
- **Clicked** - when a player turns on a switch
- **Valid {State}** - if the player turns on the right switch in the sequence order
- **Invalid** - if the player turns on the wrong switch

If the log is reporting correctly to your switch flips, you’re ready to add more editable devices to the item\_switch\_puzzle class and make each of these states do something.

## Adding Devices

Once the puzzle has been successfully completed by the player and the puzzle has looped through the switches’ ValidStates all the way to the CompletedState, the success result should do something, like grant items.

The same is true for the InvalidStates. If a player gets the puzzle wrong, the script should account for that and let players know they need to try again. To accomplish this, you need to add additional devices to the item\_switch\_puzzle class.

By adding editable devices to your script, the devices show up in the Verse Device’s User Options where you can connect the devices to the Verse Device so they function in the game as it’s written in the Verse script.

1. Add the following @editable devices under the item\_switch\_puzzle:

   ```verse
     
            @editable 
            InvalidTrigger : trigger_device = trigger_device{}
     
            @editable 
            InvalidHUDMessage : hud_message_device = hud_message_device{}
     
            @editable 
            InvalidAudioPlayer : audio_player_device = audio_player_device{}
     
            @editable 
            ValidAudioPlayer : audio_player_device = audio_player_device{}
     
            @editable 
            FindItemsHUDMessage : hud_message_device = hud_message_device{}
     
            @editable 
            CompletedAudioPlayer : audio_player_device = audio_player_device{}
     
            @editable 
            ItemSpawners : item_spawner_device = item_spawner_device{} #This grabs all the item spawners associated with this puzzle
     
   ```

2. Add a new method `CompletedState()` to the `item_switch_puzzle` class. This method handles the actions performed when the puzzle is completed.

   ```verse
     
            ## Actions to perform when the puzzle is completed
            CompletedState() : void =
                # Play a success sound
                # Set all switches to disabled
                # Spawn items on the attached item spawners
                Print("Completed")
     
   ```

   1. Add a for expression to the `CompletedState()` method that iterates through each item spawner in `ItemSpawners`. Enable each item spawner with `Enable()`, then call `SpawnItem()` to grant the player the reward for solving the puzzle.

      ```verse
        
           ## Looping through the Item Spawners allowing you to call each Item Spawner to enable and spawn its item
               for (ItemSpawnerIndex -&gt; ItemSpawner : ItemSpawners):
                   ItemSpawner.Enable()
                   ItemSpawner.SpawnItem()
        
      ```

3. Once the puzzle has been completed successfully, you need to call `Play()` on `CompletedAudioPlayer` you set up earlier, spawn the metal pieces on the Item Spawners using the `ItemSpawnerIndex` and the call `Enable1` and `SpawnItem`. Inform the player they need to search for the newly spawned items by calling `Show()` on the `FindItemsHUDMessage`. Additionally, you don’t want the player to continue interacting with your switches. Add a second for expression to loop through each switch in `Switches` and disable them by calling `Disable()`.

   ```verse
     
            # Actions to perform when the puzzle is completed
            CompletedState() : void =
                # Play a success sound
                # Set all switches to disabled
                # Spawn items on the attached item spawners
                Print("Completed")
             
                # Looping through the Item Spawners allowing you to call each Item Spawner to enable and spawn its item
                for (ItemSpawnerIndex -> ItemSpawner : ItemSpawners):
                    ItemSpawner.Enable()
                    ItemSpawner.SpawnItem()
     
                # Plays the special audio cue for completing the puzzle sequence
                CompletedAudioPlayer.Play()
     
                # Plays a HUD message to tell players to search for newly spawned items
                FindItemsHUDMessage.Show()
     
                # Disable all switches upon puzzle completed sucessfully
                for (SwitchIndex -> Switch : Switches):
                    Switch.Disable()
     
   ```

4. **Save** your code and go back to UEFN and select **Verse** > **Build Verse Code**.

Now these devices have been added to the Item Switch Puzzle device in UEFN.

### Select Devices

All the @editable devices are added to the Verse device. Now you need to attach the devices you pulled out to create the puzzle to the Verse device. To do this select item\_switch\_puzzle in the **Outliner** and all the device slots are visible in the **Details** panel. You just have to match the device to the slot.

1. Add the puzzle **Switch** devices to the **Switches** 4 array elements under **Item Switch Puzzle**.

   [![Add all the switches to the Switches array.](https://dev.epicgames.com/community/api/documentation/image/b00b5be5-d7d3-4d5b-9849-c4ceab2ce359?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b00b5be5-d7d3-4d5b-9849-c4ceab2ce359?resizing_type=fit)
2. Add the **Invalid Trigger** to the **InvalidTrigger** slot
3. Add the **Invalid HUD Message** to the **InvalidHUDMessage** slot.
4. Add the **Invalid Audio Player** to the **InvalidAudioPlayer** slot.

   [![Add all the invalid devices to their individual slots.](https://dev.epicgames.com/community/api/documentation/image/e44a1a0f-e08b-4ed8-9230-5b33ed061084?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e44a1a0f-e08b-4ed8-9230-5b33ed061084?resizing_type=fit)
5. Add the **Valid Audio Player** to the **ValidAudioPlayer** slot.
6. Add the **Find HUD Message** device to the **FindHUDMessage** slot.
7. Add the **Completed Audio Player** to the **CompletedAudioPlayer** slot.

   [![Add the valid devices ot their individual slots.](https://dev.epicgames.com/community/api/documentation/image/2185080c-356a-4ea4-977b-d806830594f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2185080c-356a-4ea4-977b-d806830594f1?resizing_type=fit)
8. Add the **Item Spawners** to the **ItemSpawners** 4 array elements.

   [![Add the Item Spawners ot the array](https://dev.epicgames.com/community/api/documentation/image/e1859d6a-080b-44b1-bd3c-cae08ee643e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e1859d6a-080b-44b1-bd3c-cae08ee643e5?resizing_type=fit)
9. Uncheck the **Visible in Game** option to hide the Verse Device during the game.

   [![Make the Verse Device invisible during the game so players won’t see it.](https://dev.epicgames.com/community/api/documentation/image/e2b98436-1594-4b7d-8832-e7225982d7d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e2b98436-1594-4b7d-8832-e7225982d7d4?resizing_type=fit)

Now you’re ready to playtest your level and see how the puzzles enhance the escape room experience.

## Next Section

With the Switch State Puzzle working, you're ready to create the automatic teleporting Verse script that takes players from staring in the opening cinematic to the holding room in the cabin's sub-basement once the cinematic finishes playing.

[![11. Teleporting Players After a Cutscene](https://dev.epicgames.com/community/api/documentation/image/dcb4d422-8c7b-4a6e-8497-e468bb134efc?resizing_type=fit&width=640&height=640)

1. Teleporting Players After a Cutscene

Use a simple Verse script to teleport players instantly between places.](<https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-11-teleporting-players-after-a-cutscene-in-unreal-editor-for-fortnite>)
