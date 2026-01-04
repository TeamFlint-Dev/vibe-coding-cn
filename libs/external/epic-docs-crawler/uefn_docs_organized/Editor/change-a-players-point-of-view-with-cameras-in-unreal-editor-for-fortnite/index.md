# Transitioning Player Point of View with Cameras

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/change-a-players-point-of-view-with-cameras-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:18:48.370788

---

Cameras play a key role in the look and feel of a game. Third-person cameras can give players a greater sense of space, while first-person cameras give players a closer look at their game world. Switching cameras during gameplay can evoke different feelings, and transitioning between multiple cameras can add significant variety to your experience. For example, you could create a fun platforming challenge using a fixed camera to create a side-scrolling section.

In UEFN, you can use Verse to handle camera changes. By using devices to listen for events, you can add a camera to a player to change their view when the event triggers. In this example, you'll add an [Orbit Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-orbit-camera-devices-in-fortnite-creative) device to a player at the end of a cinematic. You can modify the settings on an orbit camera to simulate a first-person view, and by adding the camera at the end of a cinematic you can create a smooth transition from third to first-person. For added gameplay, this example has the player grab a weapon and swing it at the door to trigger the cinematic. You can tailor this example to fit the needs of your experience, such as a player swinging a wrench to fix a faulty ship door, or swinging a hammer to smash a boulder and reveal a secret area. You can also more broadly apply these concepts to create cool gameplay moments, like a wide shot when entering a new zone, switching to a top-down view when the player needs to solve a puzzle, or a first-person view in a spooky horror experience.

Follow this tutorial to learn how to create a Verse device that transitions a player from third to first-person using a cinematic sequence when they open a door.

This example uses the following language features:

- [Class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse): This example creates a Verse class that activates a cinematic when a player opens a door.
- [Option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse): You can store subscribable events in option variables, and cancel subscriptions to those events later.

This example uses the following APIs:

- [Subscribable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/subscribable): You'll subscribe to events to know when a player enters a volume next to the door, and grant players an item when they interact with a button.

## Setting Up the Level

This example uses the following devices:

- 1 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) device: When the player interacts with the button, they'll receive a sword from an item granter device.
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/item-granter) device: The item granter grants the player the sword they need to progress through the door.
- 1 x [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/conditional-button) device: The required weapon is set as the **Key Item** of the conditional button so that the player can't progress through the door unless they have the required sword.
- 1 x [Input Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-input-trigger-devices-in-fortnite-creative) device: This opens the door when the player attacks by listening for the fire input action. This only happens when the player is inside the volume device, if the player has the sword, and the door isn't already open.
- 1 x [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) device: Since you don't want just any attack trigger with the sword to open the door, the volume device makes sure the player needs to be right next to the door to open it.
- 1 x [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) devices: To create a smooth transition from third- to first-person, you'll play a cinematic that shows the door opening and reposition the camera to line up with the player's viewpoint in first-person.
- 1 x [Orbit Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-orbit-camera-devices-in-fortnite-creative) device: To create a first-person view for the player, you'll use an orbit camera positioned inside the character's chest to mimic a first-person viewpoint. This view change only happens after the cinematic players when the player opens the door.
- 1 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) device: This keeps the door locked to prevent the player from opening it before they have the required weapon.
- 1 x [Map Indicator](https://dev.epicgames.com/documentation/en-us/fortnite/map-indicator) device: This displays the location of the door on the minimap when the player picks up the weapon.

To set up your level, follow these steps:

### Item Granter and Button

To grant the player the weapon they need to open the door, you'll use an item granter and a button device. When the player interacts with the button, the item granter grants them the weapon. To add these elements, follow these steps:

1. Add one **Item Granter** device to your level.
2. Select the item granter in the **Outliner**. In the **Details** panel, under **User Options**, set the values to the following:

   [![Item Granter Options](https://dev.epicgames.com/community/api/documentation/image/bbb7a2ef-c014-4e90-82a8-ac4771fa9129?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbb7a2ef-c014-4e90-82a8-ac4771fa9129?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Item Definition** | Sword | This is the weapon the player opens the door with. |
   | **Equip Granted Item** | True | In this example, the player picks up and immediately equips the weapon. |
3. Add one **Button** device to your level.
4. Select the button in the **Outliner**. In the **Details** panel, under **User Options**, set the values to the following:

   [![Button Options](https://dev.epicgames.com/community/api/documentation/image/36b5e474-5eb7-4d89-aea3-316225d3dba5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36b5e474-5eb7-4d89-aea3-316225d3dba5?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Interaction Text** | "Pick Up" | This is the text that prompts the player to interact with the button. |
   | **Times Can Trigger** | 1 | In this example, the player can only pick up the weapon once. |

### Input Trigger

To know when a player swings a weapon, you can use an input trigger that listens for a particular action. When a player swings the weapon, the input trigger activates. To add an input trigger, follow these steps:

1. Add one **Input Trigger** device to your level.
2. Select the input trigger in the **Outliner**. In the **Details** panel, under **User Options**, set the values to the following:

   [![Input Trigger Options](https://dev.epicgames.com/community/api/documentation/image/65137cff-0e40-4d64-b82d-d2c5122944c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65137cff-0e40-4d64-b82d-d2c5122944c6?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Input Type** | Standard Action | **Fire** is a Standard Action, which is what the input trigger needs to listen for to know when a player swings the weapon. |
   | **Standard Input** | Fire | Fire is the action the input trigger needs to listen for to know when a player swings a weapon. |
   | **Show on HUD** | False | You don't need to show this action on the HUD. |

### Volume

To make sure a player has to be next to the door to open it, you can use a volume device near the door to check if a player is inside it. To add a volume device, follow these steps.

1. Add a door somewhere on your level. This is the door that the player opens using the weapon.
2. Add one **Volume** device to your level. This volume device has to overlap a small area in front of the door, or the area you want your player to attack.
3. Change the size of the volume device by modifying its [transform gizmo](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#transform-gizmo) to fit the area you want the player to be in when attacking. The input trigger will only listen for the fire event while the player is inside of this volume, so make sure it matches the needs of your experience.

   [![Volume Options](https://dev.epicgames.com/community/api/documentation/image/6107bd4d-7903-454d-8e48-34f0d45d61c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6107bd4d-7903-454d-8e48-34f0d45d61c3?resizing_type=fit)

### Lock

To make sure a player can't open the door before they get the weapon, you can lock the door using a lock device. To add a lock device, follow these steps:

1. Add a **Lock** device attached to your door.
2. Select the lock in the **Outliner**. In the **Details** panel, under **User Options**, set **Visible in Game** to **false**.

   [![Lock Options](https://dev.epicgames.com/community/api/documentation/image/48061d71-104c-451e-bd28-695364c20650?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48061d71-104c-451e-bd28-695364c20650?resizing_type=fit)

### Map Indicator

When the place a player needs to reach is far away from where they get the weapon, it's helpful to show players where to go using a map indicator. This displays an image on their map and minimap and can activate an objective pulse that points players directly to the door. To add a map indicator, follow these steps:

1. Add a **Map Indicator** device to your level, hidden underneath the door.
2. Select the map indicator in the **Outliner**. In the **Details** panel, under **User Options**:

   [![Map Indicator Options](https://dev.epicgames.com/community/api/documentation/image/06787138-c473-490e-b314-58b12fda120f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06787138-c473-490e-b314-58b12fda120f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Enabled on Game Start** | false | The map indicator is only enabled after the player picks up the weapon. |
   | **Small Icon** | Choose an Icon | Choose an icon you want to show on the minimap. |
   | **Large Icon** | Choose an Icon | Choose an icon you want to show on the map. |

### Conditional Item Button

To know that a player is swinging the correct weapon they need to open the door, you can use a conditional item button to check the weapon they're holding when they swing it. To add a conditional item button, follow these steps:

1. Add one **Conditional Item Button** device to your level.
2. Select the conditional item button in the **Outliner**. In the **Details** panel, under **User Options**, set the values to the following:

   [![Conditional Item Button Options](https://dev.epicgames.com/community/api/documentation/image/462fefcb-4a56-4467-ba44-2681f6de47bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/462fefcb-4a56-4467-ba44-2681f6de47bd?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Consume Key Items** | False | You don't want to consume the player's weapon when they open the door. |
   | **Key Item 1 Item Definition** | Weapon | This is the weapon the player needs to open the door. |

### Orbit Camera

To simulate a first-person view, you can use an orbit camera to change the player's perspective. To add an orbit camera, follow these steps:

1. Add one **Camera: Orbit** device to your level.
2. Select the orbit camera button in the **Outliner**. In the **Details** panel, under **Camera**, set the values to the following:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Distance** | 0.0 cm | Parameters needed for the first-person view |
   | **Offset X** | 27.0 cm | Parameters needed for the first-person view |
   | **Offset Y** | 0.0 cm | Parameters needed for the first-person view |
   | **Offset Z** | 76.0 cm | Parameters needed for the first-person view |
   | **Horizontal Speed** | 0.0 cm/s | Parameters needed for the first-person view |
3. In the **Details** panel, under **Transition**, set the values to the following:

   [![Orbit Camera Options](https://dev.epicgames.com/community/api/documentation/image/839208f1-577e-4b0d-8fbd-66ec6d947039?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/839208f1-577e-4b0d-8fbd-66ec6d947039?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Transition In Time** | 0.0 s | Parameters needed for the first-person view |
   | **Transition Out Time** | 0.1 s | Parameters needed for the first-person view |
   | **Transition Out Type** | Ease-Out | Parameters needed for the first-person view |

### Cinematic Sequence

To trigger a cinematic when opening the door, you need a cinematic sequence device to play it. To add a cinematic sequence, follow these steps:

1. Add a **Cinematic Sequence** device to your level.
2. In the **Content Browser**, create a cinematic sequence you want to use in your level. The cinematic sequence use the orbit camera you set up earlier and should show the door opening while transitioning the camera from an initial angle to a first-person view. For more info on creating your own cinematic sequences, check out [Making Cinematics and Cutscenes](https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-and-cutscenes-in-unreal-editor-for-fortnite).
3. In the **Outliner**, select the cinematic sequence. Then, in the **Details** panel, under **User Options**, assign the **Sequence** to your cinematic sequence.

   [![Cinematic Sequence Options](https://dev.epicgames.com/community/api/documentation/image/b253f4cb-b674-4dec-ae4c-4f79671f11e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b253f4cb-b674-4dec-ae4c-4f79671f11e9?resizing_type=fit)

   *Click image to expand.*

## Door Opening Cinematic using Verse

To handle the logic for playing a cinematic and opening the door, you'll use a [Verse device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite). The device listens for a player swinging their weapon inside the volume device, then plays a cinematic sequence, opens the door, and transitions the player into first-person.

### Setting Up Fields

To create your Verse device:

1. Create a new Verse device using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and name it `door_open_cinematic_manager`.
2. Above the `door_open_cinematic_manager` class definition, add a log channel to print messages specific to this device. Then add a logger to the class definition to use with the log channel.

   ```verse
   door_open_channel := class(log_channel){}
   		
        # A Verse-authored creative device that can be placed in a level
        door_open_cinematic_manager := class(creative_device):
            Logger:log = log{Channel := door_open_channel}
   ```
3. Add the following fields to the `door_open_cinematic_manager` class definition:

   - An editable Volume device named `DoorVolume`. This is the volume the player needs to be inside to open the door.

     ```verse
     # The volume the player needs to be inside of to open the door.
       @editable
       DoorVolume:volume_device = volume_device{}
     ```
   - An editable Input Trigger device named `FireTrigger`. This listens for the player using their weapon while inside the `DoorVolume`.

     ```verse
     # The input trigger that listens for the player swinging their weapon
       # when inside the DoorVolume.
       @editable
       FireTrigger:input_trigger_device = input_trigger_device{}
     ```
   - An editable Conditional Button device named `ConditionalButton`. This checks that the player has the correct weapon equipped when inside the volume device.

     ```verse
     # The Conditional Item Button that checks that the player has the correct weapon.
       @editable
       ConditionalButton:conditional_button_device = conditional_button_device{}
     ```
   - An editable Lock Device named `DoorLock`. This keeps the door locked if the player doesn't have the correct weapon.

     ```verse
     # The lock device that prevents the door from being opened.
       @editable
       Door:lock_device = lock_device{}
     ```
   - An editable Cinematic Sequence device named `CinematicSequence`. This plays the cinematic leading into the camera transition when opening the door.

     ```verse
     # The cinematic sequence device that plays the cinematic when opening the door.
       @editable
       CinematicSequence:cinematic_sequence_device = cinematic_sequence_device{}
     ```
   - An editable Map Indicator device named `ObjectiveMarker`. This shows the location of the door on the minimap after picking up the weapon.

     ```verse
     # The map indicator device that shows the location of the door.
       @editable
       ObjectiveMarker:map_indicator_device = map_indicator_device{}
     ```
   - An editable Item Granter device named `ItemGranter`. This grants the player the weapon they need to progress.

     ```verse
     # The item granter device that grants the player the weapon they need.
       @editable
       ItemGranter:item_granter_device = item_granter_device{}
     ```
   - An editable Button device named `ItemGrantButton`. This activates the `ItemGranter` to grant the player the weapon they need.

     ```verse
     # The button that activates the ItemGranter granter.
       @editable
       ItemGrantButton:button_device = button_device{}
     ```
   - An editable Orbit Camera device named `FPSCamera`. This simulates a first-person view and is added to the player after the cinematic ends.

     ```verse
     # The orbit camera that simulates a first-person view.
       @editable
       FPSCamera:gameplay_camera_orbit_device = gameplay_camera_orbit_device{}
     ```
   - A [`logic`](logic-in-verse) variable named `IsDoorOpen`. This field tracks whether the door is already open, so the sequence doesn't play if it is.

     ```verse
     # A variable that tracks whether the door is already open.
       var IsDoorOpen:logic = false
     ```
   - An [`option`](option-in-verse) `cancelable` variable named `FireSubscription`. This stores the subscription to the `FireTrigger` `PressedEvent`. The cinematic sequence should only trigger when the player is right next to the door. This cancelable subscription makes sure to `Unregister` the player from the `FireTrigger`, if they get too far away.

     ```verse
     # A cancelable subscription to the FireTrigger device.
       var FireSubscription:?cancelable = false
     ```

### Playing the Cinematic

When the door opens, a cinematic occurs that shows the door opening and transitions the players' view from third to first person. Follow the steps below to activate your cinematic when a player opens the door.

1. Add a new method `PlayCinematic()` to the `door_open_cinematic_manager` class definition. Add a new method `PlayCinematic()` to the `door_open_cinematic_manager` class definition. This function takes the player who is opening the door. It then plays the cinematic and opens the door using the Lock device.

   ```verse
   # Plays a cinematic and unlocks the door.
        PlayCinematic(Agent:agent):void=
   ```
2. In `PlayCinematic()`, first play the cinematic sequence from the `CinematicSequence`, then unlock the door and open it using `Unlock()` and `Open()` respectively.

   ```verse
   # Plays a cinematic and unlocks the door.
        PlayCinematic(Agent:agent)<suspends>:void=
   		
            Logger.Print("Player is holding item, playing cinematic...")  
            CinematicSequence.Play()
   		
   		
            # Unlock the door, then open it.
            Door.Unlock(Agent)
            Door.Open(Agent)
            set IsDoorOpen = true
   ```
3. Finally, change the player’s view from third to first-person by adding the orbit camera to them using `AddTo()`, then disable the Objective Marker. Your complete `PlayCinematic()` function should look like this:

   ```verse
   # Plays a cinematic and unlocks the door.
        PlayCinematic(Agent:agent)<suspends>:void=
   		
            Logger.Print("Player is holding item, playing cinematic...")  
            CinematicSequence.Play()
   		
            # Unlock the door, then open it.
            Door.Unlock(Agent)
            Door.Open(Agent)
            set IsDoorOpen = true
   		
            # Add the first person camera to the agent. When the cinematic ends, the 
            # agent will be in first-person view.
            FPSCamera.AddTo(Agent)
            Logger.Print("Camera changed")
   		
            # Disable the Objective Marker
            ObjectiveMarker.Disable()
   ```
4. The cinematic should only play when the player is holding the required item, and it shouldn’t play again after the door is already open. To handle this logic, add a new method `CheckCinematic()` to the `door_open_cinematic_manager` class definition. This function takes the player inside the `DoorVolume` and checks if they have the required items.

   ```verse
   # Check if the player has the required item and the door isn't already open.
        CheckCinematic(Agent:agent):void=
   ```
5. In `CheckCinematic()`, check if the player is holding the item registered on the `ConditionalButton` using `IsHoldingItem[]`, and check if `IsDoorOpen` is false to make sure the door isn’t already unlocked. If so, `spawn{}` the `PlayCinematic()` function passing the player opening the door. Your complete `CheckCinematic()` function should look like this:

   ```verse
   # Check if the player has the required item and the door isn't already open.
        CheckCinematic(Agent:agent):void=
            if:
                ConditionalButton.IsHoldingItem[Agent] and not IsDoorOpen?
            then:
                spawn{PlayCinematic(Agent)}
   ```

### Tracking the Player and Granting Items

Since the player needs to swing their weapon while inside the `DoorVolume` to open the door, the input trigger device needs to be listening for that event. Follow the steps below to get your input trigger to listen for when your player swings a weapon.

1. Add a new method `OnPlayerEntersVolume()` to the `door_open_cinematic_manager` class definition. This function takes an Agent and registers them with the `FireTrigger` when they enter the `DoorVolume`.

   ```verse
   # Registers the Agent with the FireTrigger when they enter the DoorVolume.
        OnPlayerEntersVolume(Agent:agent):void=
            Logger.Print("Agent entered DoorVolume")
   ```
2. In `OnPlayerEntersVolume()`, register the agent with the `FireTrigger` by calling `Register()`. Then set the `FireSubscription` to the result of subscribing the `FireTrigger.PressedEvent` to `PlayCinematic()`. Your complete `OnPlayerEntersVolume()` function should look like the following:

   ```verse
   # Registers the Agent with the FireTrigger when they enter the DoorVolume.
        OnPlayerEntersVolume(Agent:agent):void=
   		
            Logger.Print("Agent entered DoorVolume")
   		
            FireTrigger.Register(Agent)
   		
            # Subscribe the PressedEvent to PlayCinematic, and store that subscription in FireSubscrition.
            set FireSubscription = option{(FireTrigger.PressedEvent.Subscribe(PlayCinematic))}
   ```
3. When a player exits the `DoorVolume`, you need to stop tracking the subscription for the `FireTrigger.PressedEvent` since the player should only be able to activate the cinematic if they're not inside the volume. To handle this, add a new method `OnPlayerExitsVolume()` to the `door_open_cinematic_manager` class definition.

   ```verse
   # Unregister the Agent with the FireTrigger when they leave the DoorVolume.
        OnPlayerExitsVolume(Agent:agent):void=
   ```
4. In `OnPlayerExitsVolume()`, first `Unregister()` the agent with the `FireTrigger`. Then retrieve the subscription inside `FireSubscription`, and cancel it. Your complete `OnPlayerExitsVolume()` method should look like this:

   ```verse
   # Unregister the Agent with the FireTrigger when they leave the DoorVolume.
        OnPlayerExitsVolume(Agent:agent):void=
   		
            Logger.Print("Agent exited DoorVolume")
   		
            FireTrigger.Unregister(Agent)
   		
            # Cancel the subscription to the FireSubscription.
            if (SubscriptionToCancel := FireSubscription?):
                SubscriptionToCancel.Cancel()
   ```
5. When the player interacts with the `ItemButton`, they are granted the weapon they need to progress. An objective marker also appears on their minimap, which shows them the way to the door in case they haven't found it yet. To handle this, add a new method `GrantItem()` which takes an `agent` to the `door_open_cinematic_manager`class definition. Inside `GrantItem()`, call `GrantItem` on the agent that was passed, and enable the objective marker. Your complete `GrantItem()` method should look like the following:

   ```verse
   # Grants the Agent an item when they interact with the ItemGrantButton
        # and enables the ObjectiveMarker.
        GrantItem(Agent:agent):void=
            ItemGranter.GrantItem(Agent)
            ObjectiveMarker.Enable()
   ```

### Linking it All Together

You can now subscribe each event to its associated function and test out your code in-game.

1. In `OnBegin()`, subscribe the `ItemGrantButton.InteractedWithEvent` to the `GrantItem()` function. Then subscribe both `DoorVolume.AgentEntersEvent` and `DoorVolume.AgentExitsEvent` to their associated functions. Your `OnBegin()` function should look like this:

   ```verse
   # Runs when the device is started in a running game
        OnBegin<override>()<suspends>:void=
   		
            # Subscribe each event to its associated function.
            ItemGrantButton.InteractedWithEvent.Subscribe(GrantItem)
            DoorVolume.AgentEntersEvent.Subscribe(OnPlayerEntersVolume)
            DoorVolume.AgentExitsEvent.Subscribe(OnPlayerExitsVolume)
   ```
2. Save your code and compile it.
3. In UEFN, select the **DoorOpenCinematicManager** device in your level. In the **O**utliner, assign each editable reference to the device in the level.

   [![Verse Device Options](https://dev.epicgames.com/community/api/documentation/image/2a24ed3b-171d-48c6-885e-8bf391fefc8f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a24ed3b-171d-48c6-885e-8bf391fefc8f?resizing_type=fit)

   *Click image to expand.*
4. Click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest the level, interacting with the item button should grant the player the weapon they need, and add an objective marker to the player's minimap. When the player uses the weapon inside the door volume, a cinematic should play, the door should open, and the player should transition into first-person view.

## Complete Code

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.
door_open_log := class(log_channel){}

door_open_cinematic_manager := class(creative_device):

    Logger:log = log{Channel := door_open_log}

    # The input trigger that listens for the player swinging their weapon 
    # when inside the DoorVolume.
    @editable
    FireTrigger:input_trigger_device = input_trigger_device{}
        
    # The cinematic sequence device that plays the cinematic when opening the door.
    @editable
    CinematicSequence:cinematic_sequence_device = cinematic_sequence_device{}

    # The Conditional Item Button that checks that the player has the correct weapon.
    @editable
    ConditionalButton:conditional_button_device = conditional_button_device{}

    # The lock device that prevents the door from being opened.
    @editable
    Door:lock_device = lock_device{}

    # The volume the player needs to be in to open the door.
    @editable
    DoorVolume:volume_device = volume_device{}

    # The orbit camera that simulates a first-person view.
    @editable
    FPSCamera:gameplay_camera_orbit_device = gameplay_camera_orbit_device{}

    # The item granter device that grants the player the weapon they need.
    @editable
    ItemGranter:item_granter_device = item_granter_device{}

    # The button that activates the ItemGranter.
    @editable
    ItemGrantButton:button_device = button_device{}

    # The map indicator device that shows the location of the door.
    @editable
    ObjectiveMarker:map_indicator_device = map_indicator_device{}

    # A variable that tracks whether the door is already open.
    var IsDoorOpen:logic = false

    # A cancelable subscription to the FireTrigger device.
    var FireSubscription:?cancelable = false

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=

        # Subscribe each event to its associated function.
        ItemGrantButton.InteractedWithEvent.Subscribe(GrantItem)
        DoorVolume.AgentEntersEvent.Subscribe(OnPlayerEntersVolume)
        DoorVolume.AgentExitsEvent.Subscribe(OnPlayerExitsVolume)

    # Registers the Agent with the FireTrigger when they enter the DoorVolume.
    OnPlayerEntersVolume(Agent:agent):void=
        Logger.Print("Agent entered DoorVolume")
        
        FireTrigger.Register(Agent)
        
        # Subscribe the PressedEvent to PlayCinematic, and store that subscription in FireSubscrition.
        set FireSubscription = option{(FireTrigger.PressedEvent.Subscribe(CheckCinematic))}

    # Unregister the Agent with the FireTrigger when they leave the DoorVolume.
    OnPlayerExitsVolume(Agent:agent):void= 
        Logger.Print("Agent exited DoorVolume")

        FireTrigger.Unregister(Agent)

        # Cancel the subscription to the FireSubscription.
        if (SubscriptionToCancel := FireSubscription?):
            SubscriptionToCancel.Cancel()

    # Grants the Agent an item when they interact with the ItemGrantButton
    # and enables the ObjectiveMarker.
    GrantItem(Agent:agent):void=
        ItemGranter.GrantItem(Agent)
        ObjectiveMarker.Enable()

    # Check if the player has the required item and the door isn't already open.
    CheckCinematic(Agent:agent):void=
        if:
            ConditionalButton.IsHoldingItem[Agent] and not IsDoorOpen?
        then:
            spawn{PlayCinematic(Agent)}

    # Plays a cinematic and unlocks the door.
    PlayCinematic(Agent:agent)<suspends>:void=

        Logger.Print("Player is holding item, playing cinematic...")  
        CinematicSequence.Play()

        # Unlock the door, then open it.
        Door.Unlock(Agent)
        Door.Open(Agent)
        set IsDoorOpen = true

        # Add the first person camera to the agent. When the cinematic ends, the 
        # agent will be in first-person view.
        FPSCamera.AddTo(Agent)
        
        Logger.Print("Camera changed")
    
        # Disable the Objective Marker
        ObjectiveMarker.Disable()
```

## On Your Own

By completing this guide, you've learned how to use Verse to play a cinematic when a player opens a door, and how to transition from third to first-person camera.

Using what you've learned, try the following:

- Can you do other types of camera transitions, such as a transition to a side-scroller view?
- How about a dedicated button to change the camera angle, or designing a level that requires multiple camera angles to progress?
- Can you use input triggers for negative penalties, such as challenging players to get through a section without jumping, and play a cinematic if they fail?
