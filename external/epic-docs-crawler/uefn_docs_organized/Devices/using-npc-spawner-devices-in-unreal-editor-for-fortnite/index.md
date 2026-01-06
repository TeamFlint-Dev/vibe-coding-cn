# NPC Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:15:34.355843

---

This feature is in Beta. You can publish an island with this feature, but be aware that changes may break your island and may require your active intervention.

With the **NPC Spawner** device, you can create unique creatures, enemies, and more with engaging roles that bring your gameplay to life. These non-playable characters (NPCs) can have health, [patrol set paths](https://dev.epicgames.com/documentation/en-us/fortnite/using-ai-patrol-path-node-devices-in-fortnite-creative), and even aid players in solving puzzles. Use this device to assign scripts and [NPC Character Definitions](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite) 
that you can reuse across multiple NPC Spawner devices.

Include NPCs, characters with artificial intelligence (AI), in your gameplay to add an extra layer of immersion. You can customize NPCs to perform various actions, from reviving teammates to following players.

[![NPC Spawner in UEFN](https://dev.epicgames.com/community/api/documentation/image/61ea479c-9ed3-4600-bdfc-f7b4aec2be6d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61ea479c-9ed3-4600-bdfc-f7b4aec2be6d?resizing_type=fit)

The NPC Spawner is different from the [Character device](https://dev.epicgames.com/documentation/en-us/fortnite/using-character-devices-in-fortnite-creative),  in that you can make custom configurations that alter how a character looks, moves, and behaves with the NPC Spawner.

The Character device, like the [Guard Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative), is useful for a singular instance of a basic character. However, both are limited to Fortnite [outfits](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#outfit). The NPC Spawner device can create instances of characters with either Fortnite uniform guards, wildlife, or custom NPCs with user-imported meshes'.

The device is only available in **Unreal Editor for Fortnite** (UEFN) located in **All > Fortnite > Devices > !Beta > NPC Spawner**.

## Using Brand Specific NPCs

Custom-branded NPCs are available in the NPC Spawner through a [character definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite).

Depending on the IP, you can find the unique NPCs in one or both of the following:

- The **NPC Character Type** which can include unique modifiers.
- Through the **Cosmetic Modifier** when selecting a **Custom** or **Guard** character type.

Branded assets have specific rules and guidelines for use. Check the brand rules for the IP assets you intend to use. To learn more about the various brand partners and content, see [Game Collections](https://dev.epicgames.com/documentation/en-us/fortnite/game-collections-in-unreal-editor-for-fortnite).

You can only use brand assets in a project specific to the relevant IP property.

## Contextual Filtering

Some devices are affected by a feature called contextual filtering. This feature highlights or shades options depending on the values selected for certain related options. This feature reduces clutter in the Details panel and makes options easier to manage and navigate.

## User Options

[![User Options](https://dev.epicgames.com/community/api/documentation/image/49f09ba0-4e4a-4358-9ec9-d34f32f082e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49f09ba0-4e4a-4358-9ec9-d34f32f082e6?resizing_type=fit)

With the User Options settings, you can set the spawn conditions, reference character definitions, and designate functions and events.

The default values are bold. Values that trigger contextual filtering are in italics.

| Option | Value | Description |
| --- | --- | --- |
| **Spawn Count** | **1**, Type an amount | Sets the number of NPCs this spawner can have active at any time. When the spawner activates, it produces one NPC at a time. |
| **Spawn Through Walls** | **True**, False | Determines whether NPC must spawn within line-of-sight of the spawner or if they can spawn behind obstructing walls. |
| **Spawn Character at Game Start** | **True**, False | Determines whether the spawner is already enabled when the game starts to spawn NPC characters. Set this to False to have an animated character. |
| [NPC Behavior Script Override](https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite) | **None**, Select a script | Overrides the default or assigned behavior of the NPC Character Definition assigned to this device. |
| **NPC Character Definition** | **None**, Select a Character Definition | Sets the character definition for spawning NPCs of a specific character type. Select from an existing character definition or create a new one from the dropdown.  If you drag an NPC Character Definition into the viewport, this field is automatically populated. |
| **Additional NPC Character Modifiers** | *Add an Array element* | Adds an extra list of modifiers to apply to the NPC. The character type you select in the character definition affects the available list of modifiers.  To add a modifier, click the plus icon, and then select from the Index dropdown. Additional options for the modifier become available. Modifiers you assign to the device overrides modifiers you assigned in the Character Definition. Visit the NPC Character Definitions documentation to learn more  about [modifiers](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite#npc-character-modifiers). |
| **Allow Infinite Spawn** | **True**, False | Determines whether the spawner has a total spawn limit or not. |
| **Total Spawn Limit** | **1**, Type an amount | sets the maximum number of AIs this spawner can produce during its lifetime. |
| **Spawn On Timer** | **True**, False | Determines whether the AI is spawned on the Spawn Timer countdown or spawned on events. |
| **Spawn Timer** | **3.0s**, Type an amount | Sets the minimum time between spawning AIs. |
| **Show Spawn Radius** | **True**, False | Determines if the spawn radius will be shown or not. |
| **Spawn Radius** | **1.0m**, Type an amount | Sets the maximum distance from the device that AI can spawn. |
| **Despawn AIs When Disabled** | True, **False** | When the device is disabled, this determines whether AIs remain spawn or despawn. |

## Direct Event Binding

The following are the **[direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding)** options for this device.

### Functions

A **[function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary)** listens for an event on a device and then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the Device dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable** | Enables this device when an event occurs. |
| **Disable** | Disables this device when an event occurs. |
| **Spawn** | Spawns AI on this device when an event occurs. |
| **Despawn** | Despawns AI on this device when an event occurs. |
| **Reset Total Spawn Count** | Resets the count for the **Total Spawn Limit** when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Spawned** | Sends an event to a linked device when a player interacts with the button. |
| **On Eliminated** | Sends an event to a linked device when a player interacts with the button. |

## Using The NPC Spawner in Verse

You can use the code below to control an NPC Spawner device in Verse. This code uses all features of the NPC Spawner device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/AI }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# Visit [here](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse) to create a verse device.

# A Verse-authored creative device that can be placed in a level
npc_spawner_device_example := class(creative_device):

    # Reference to the NPC Spawner Device in the level.
    # In the Details panel for this Verse device,
    # set this property to your NPC Spawner Device.
    @editable
    MyNPCSpawnerDevice:npc_spawner_device = npc_spawner_device{}

    # Runs when the device is started in a running game.
    OnBegin<override>()<suspends>:void=

        # Example for subscribing to an event on the Creative device.
        # Signaled when a character is spawned from the NPC Spawner Device.
        # Sends the `agent` character who was spawned.
        MyNPCSpawnerDevice.SpawnedEvent.Subscribe(OnCharacterSpawned)

        # Signaled when a character Spawned from the NPC Spawner Device is
        # eliminated. Sends a device_ai_interaction_result of the agent who eliminated
        # the character, and
        MyNPCSpawnerDevice.EliminatedEvent.Subscribe(OnCharacterEliminated)

        # Spawn a character from the NPC Spawner Device.
        MyNPCSpawnerDevice.Spawn()

        Sleep(15.0)

        # Eliminates all creatures spawned by this device.
        MyNPCSpawnerDevice.DespawnAll(false)

    # This function runs when a character is spawned from the NPC Spawner
    # because it's an event handler for SpawnedEvent.
    OnCharacterSpawned(SpawnedAgent:agent):void=

        Print("A character just spawned from this device.")

        # When a character spawns, have them focus on the first player in the playspace
        if:
            FortCharacter := SpawnedAgent.GetFortCharacter[]
            FocusInterface := FortCharacter.GetFocusInterface[]
            PlayerToFocus := GetPlayspace().GetPlayers()[0]
        then:
            spawn{FocusInterface.MaintainFocus(PlayerToFocus)}

    # This function runs when the character spawned from the NPC Spawner
    # is eliminated, because it's an event handler for EliminatedEvent.
    OnCharacterEliminated(AIInteractionResult:device_ai_interaction_result):void=

        # `Source` is the `agent` that has eliminated the creature.
        # If the creature was eliminated by a non-agent then `Source` is 'false'.
        # `Target` is the creature that was eliminated.
        if(AIInteractionResult.Source?):
            Print("The character was eliminated by another agent.")
        else:
            Print("The character was not eliminated by another agent.")
```

To use this code in your UEFN experience, follow these steps.

1. Drag an NPC Spawner device onto your island.
2. Create a new Verse device named **npc\_spawner\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
3. In Visual Studio Code, open **npc\_spawner\_device\_verse\_example.verse** in Visual Studio Code and paste the code above.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
5. Select your Verse device in the **Outliner**.
6. In the device’s **Details** panel, assign the object reference for the NPC Spawner to the NPC Spawner device on your island. You can use the eyedropper to pick the device in the **Viewport** or use the dropdown to search for the device.
7. Save your project and click **Launch Session**.

### NPC Spawner Device API

See the [`npc_spawner_device`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/npc_spawner_device) API Reference for more information on using the NPC Spawner device in Verse.
