# Third Person Controls Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-third-person-controls-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:34:15.690506

---

The **Control: Third Person** (Third Person Controls) device is designed for use alongside the [Fixed Angle Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-fixed-angle-camera-devices-in-fortnite-creative), [Fixed Point Camera](using-fixed-point-camera-devices-in-fortnite-creative), and [Orbit Camera](using-orbit-camera-devices-in-fortnite-creative) devices. The Third Person Controls device has two main functions:

- Configuring movement and facing settings for players affected by camera devices
- Configuring targeting behavior for players affected by camera devices

Because the camera devices change what the player sees, the usual controls for movement and other player actions will be different. This device is where you determine the direction the player faces, how they target enemies or objects for interaction, how fast they move, and so on.

To learn more about how to use the camera and controls devices together, see [Designing with Cameras and Controls](https://dev.epicgames.com/documentation/en-us/fortnite/designing-with-cameras-and-controls-in-fortnite-creative).
To learn about using cameras in UEFN, see:

- [Gameplay Camera and Control Devices](https://dev.epicgames.com/documentation/en-us/uefn/gameplay-camera-and-control-devices-in-unreal-editor-for-fortnite)
- [Making a Title Sequence](https://dev.epicgames.com/documentation/en-us/uefn/making-a-title-sequence-in-unreal-editor-for-fortnite) gameplay example

For help on how to find the **Third Person Controls** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

Configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

| Option | Value | Description |
| --- | --- | --- |
| **Creative Preview** | N/A | Click **Start** to preview what the camera is seeing. Click **Stop** to leave the preview and go back to editing your island. |
| **Priority** | **0.0**, Pick or enter a number | Multiple cameras can be present at any time, but only the one with the highest priority is considered active. |
| **Add to Players on Start** | **On**, Off | Determines whether this device is automatically added to all players when the game starts. |
| **Remove on Elimination** | On, **Off** | Determines whether this camera is removed from a player when they are eliminated. |
| **Enabled During Phase** | None, **Always**, Gameplay Only | Determines which phases the camera is active in. If you choose **None**, the camera can only be enabled manually using events. |
| **Facing Direction** | **Movement**, *Twin Stick*, *Fixed* | Determines which direction the player is facing during gameplay. If you choose **Fixed**, another option displays below this one. Values for this option are:   - **Movement**: Players face in the direction they are moving. - **Twin Stick**: Players can change their facing direction based on an input, such as the mouse cursor position or the direction a joystick is pushed on a controller. - **Fixed**: Players always face a specific direction, inferred from the value of the **Fixed Facing Angle** option. |
| **Twin Stick Mouse Aim Mode** | **Target Cursor**, Dial Aiming | This option only displays if you set the **Facing Direction** option to **Twin Stick**. This determines where the player will aim when they are using a mouse. Values for this option are:   - **Target Cursor**: The player will aim towards the mouse cursor's location. - **Dial Aiming**: The mouse will act as analog joystick, and the player will aim in the direction the mouse is moved. |
| **Auto Fire On Controller** | On, **Off** | Determines whether the player's weapon automatically fires when the player is using the right stick on a controller. |
| **Fixed Facing Angle** | **0 degrees**, pick or enter a number | This option only displays if the **Facing Direction** option is set to **Fixed**. Determines the direction that players face during gameplay. |
| **Movement Speed Multiplier** | **1.0x**, Pick an amount | Determines how fast the player moves, as a multiple of the default speed. |
| **Movement Speed Multiplier When Shooting** | **1.0x**, Pick an amount | Determines how fast the player moves while shooting, as a multiple of the default speed. |
| **Movement Speed Multiplier When Aiming** | **1.0x**, Pick an amount | Determines how fast the player moves while aiming, as a multiple of the default speed. |
| **Turn Speed Multiplier** | **1.0**, Pick an amount | Determines the player's speed while turning, as a multiplier of the default speed. |
| **Turn Speed Multiplier When Shooting** | **1.0x**, Pick an amount | Determines the player's turning speed while shooting, as a multiplier of the default speed. |
| **Turn Speed Multiplier When Aiming** | **1.0x**, Pick an amount | Determines the player's turning speed while aiming, as a multiplier of the default speed. |
| **Turn Speed Multiplier When Sprinting** | **1.0x**, Pick an amount | Determines the player's turning speed while sprinting, as a multiplier of the default speed. |
| **Targeting Assistance** | **On**, Off | When this is set to **On**, players will auto-select a target based on distance, angle and targeting priorities.  If you have **Facing Direction** set to **Twin Stick**, and you have **Targeting Assistance** set to **On**, players can break out of auto-targeting by moving the right joystick or their mouse after the target is locked on. |
| **Targeting Lock On** | Never, Always, Shooting, Aiming, **Shooting or Aiming** | This option only displays if the **Targeting Assistance** option is set to **On**. Determines when players turn towards their target, when a target is selected. |
| **Target Retention Duration** | **1.5 sec**, Pick a number of seconds | This option only displays if the **Targeting Assistance** option is set to **On**. The amount of seconds a player will attempt to face their target after each ranged action. |
| **Targeting Distance** | **1000 cm**, Pick an amount | This option only displays if the **Targeting Assistance** option is set to **On**. Determines the maximum distance targets can be from the player to be considered valid targets. |
| **Targeting Distance When Aiming** | **1000 cm**, Pick an amount | This option only displays if the **Targeting Assistance** option is set to **On**. Determines the maximum distance targets can be from the player to be considered valid targets. |
| **Targeting Angle** | **85°**, Pick a number of degrees | This option only displays if the **Targeting Assistance** option is set to **On**. From the player's facing direction, this is the angle within which targets must be to be considered valid targets. |
| **Targeting Angle When Aiming** | **85°**, Pick a number of degrees | This option only displays if the **Targeting Assistance** option is set to **On**. From the player's facing direction, this is the angle within which targets must be to be considered valid targets. |
| **Require Target Line of Sight** | **On**, Off | This option only displays if the **Targeting Assistance** option is set to **On**. Determines whether a clear line of sight is required for a target to be considered valid. |
| **Base Weight Players** | **1.0**, Pick a number | This option only displays if the **Targeting Assistance** option is set to **On**. Determines the targeting prioritization assigned to players. If you select **0**, players cannot be targeted. |
| **Base Weight Creatures** | **0.5**, Pick a number | This option only displays if the **Targeting Assistance** option is set to **On**. Determines the targeting prioritization assigned to creatures. If you select **0**, creatures cannot be targeted. |
| **Base Weight Vehicles** | **0.3**, Pick a number | This option only displays if the **Targeting Assistance** option is set to **On**. Determines the targeting prioritization assigned to vehicles. If you select **0**, vehicles cannot be targeted. |
| **Scale Weight by Distance** | **0.5**, Pick a number | This option only displays if the **Targeting Assistance** option is set to **On**. Scales the target's calculated priority weight, reducing the final value by the target's distance from the player. |
| **Scale Weight by Angle** | **1**, Pick a number | This option only displays if the **Targeting Assistance** option is set to **On**. Scales the target's calculated priority weight, reducing the final value by the target's angle to the player. |
| **Affects Team** | **Any**, Pick or enter a team | Determines which team is affected by this device. |
| **Affects Class** | No Class, **Any**, Pick or enter a class | Determines which classes are affected by this device. **No Class** means only players with no assigned class are affected. **Any** means all players, including those with no assigned class, are affected. |
| **Invert Team** | On, **Off** | If this is set to **On**, all teams are affected by this device except the team selected in the **Affects Team** option. |
| **Invert Class** | On, **Off** | If this is set to **On**, all classes are affected by this device except the class selected in the **Affects Class** option. |
| **Targetable Device in Edit Mode** | On, **Off** | Determines whether the device itself is targetable. If set to **On**, the device is only targetable when you are editing your island. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If a function can be triggered by more than one event, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Add to When Receiving From** | Adds this device to the instigating player when an event occurs. |
| **Add to All When Receiving From** | Adds this device to all players when an event occurs. |
| **Remove from When Receiving From** | Removes this device from the instigating player when an event occurs. |
| **Remove from All When Receiving From** | Removes this device from all players when an event occurs. |

### Events

This device has no events.

## Use Third Person Controls In Verse

You can use the code below to control a Third Person Controls device in Verse. This code shows how to use events and functions in the Third Person Controls device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
# A Verse-authored creative device that can be placed in a level
gameplay_controls_third_person_device_verse_example := class(creative_device):
    # Reference to the Gameplay Control: Third Person Device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Gameplay Control: Third Person Device.
    @editable
    MyThirdPersonControlsDevice:gameplay_controls_third_person_device = gameplay_controls_third_person_device{}
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Print("Adding third person controls to players.")
        # This example iterates through all players in the experience to show how to do operations per player on the device.
        for (Player : GetPlayspace().GetPlayers()):
            # Adds the camera to the `Agent`'s camera stack and pushes it to be the active camera.
            MyThirdPersonControlsDevice.AddTo(Player)
        # Wait 5 seconds
        Sleep(5.0)
        Print("Removing third person controls from players.")
        # Removes the camera from all `Agent`'s camera stacks and pops from being the active camera replacing it with the next one in the stack.
        MyThirdPersonControlsDevice.RemoveFromAll()
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Third Person Controls device onto your island.
2. Create a new Verse device named **gameplay\_controls\_third\_person\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#creatinganewdevicewithverse) for steps.
3. In Visual Studio Code, open **gameplay\_controls\_third\_person\_device\_verse\_example.verse** in Visual Studio Code and paste the code above.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#addingyourversedevicetoyourlevel) for steps.
5. Add a reference for the device on your island to your Verse device. See [Adding a Verse Reference to a Creative Device in Your Level](https://dev.epicgames.com/documentation/en-us/uefn/customize-verse-device-properties-in-verse#addingaversereferencetoacreativedeviceinyourlevel) for steps.

   Disable the **Add to Players on Start** property of the Third Person Controls device so that only Verse will add the controls to the player.
6. Save your project and click **Launch Session** to playtest.

### Third Person Controls API

See the [`Gameplay Controls Third Person` API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/gameplay_controls_third_person_device) for more information on using the device in Verse.
