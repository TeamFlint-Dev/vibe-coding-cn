# Analytics Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-analytics-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:33:45.683246

---

With the **Analytics** device, you can gather information on your island to evaluate player behavior, such as the number of times [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) elements are interacted with and various events are [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) on your island. By registering [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) in the Analytics device, you generate event data that can be processed and gathered in the [Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), then retrieved based on the [Island Code](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

The Analytics device is designed to work with other [devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) by registering when player behavior triggers other devices such as stepping on a trigger, entering a [volume](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), [eliminating an enemy](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), or pressing a button. Although players will be unaware of the devices you place on your island or what they trigger, player behavior causes an interaction with the Analytics devices and any device attached to it during gameplay.

Data is recorded daily, and can be viewed in the [Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/using-creator-portal-in-fortnite-creative).

The Analytics device takes up very little memory. The first device you place uses **39** memory, and each placed after that uses **9** memory.

The amount of times a device can be placed on an island is completely separate from how much memory the device uses. The Analytics device can be placed **100** times on an island.

If you edit your island, you will not need to re-deploy any devices that have already been placed unless the edit included removing them.

For a list of the Analytics device best practices, see the [Analytics Device Dashboard](https://dev.epicgames.com/documentation/en-us/fortnite/analytics-device-dashboard-in-fortnite-creative) document.

To find the Analytics device, go to the Creative **Content browser** and select the **Devices** category. From there, you can search or browse for the device. For more information on finding devices see [Finding and Placing Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

[![Placing an Analytics device.](https://dev.epicgames.com/community/api/documentation/image/1d93378e-dad9-48fa-a5aa-eb9b7836f01e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d93378e-dad9-48fa-a5aa-eb9b7836f01e?resizing_type=fit)

When using the Analytics device, it is best to rename the Analytics device and all the associated devices tied to a specific Analytics device when editing device options in **Create mode**. Choose names that relate to each device’s purpose, so it’s easier to remember what each one does.

For repeat events such as player checkpoints, copy and paste the necessary devices, then rename each **Event Name** in the copied Analytics devices so the different events will gather analytics and generate data in the Creator Portal under the names you chose.

## Device Options

This device has some basic functionality, like auto saving, and gathering analytical data on events connected to the device.

[![Device icon](https://dev.epicgames.com/community/api/documentation/image/c620fd24-3e1a-4c9a-ab62-d8a979aca803?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c620fd24-3e1a-4c9a-ab62-d8a979aca803?resizing_type=fit)

Default values are **bold**.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Event Name** | **Text string** | The name that is passed along with the analytics event. |
| **Enabled During Phase** | **All**, None, Pre-Game Only, Gameplay Only | Enable the device during a specific phase. The pre-game phase includes all phases before the game starts. |
| **Show Feedback** | **Yes**, No | Whether triggering the event displays a message during an edit session. The device will never display a message in a published game. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device. |
| **Disable When Receiving From** | Disables the device. |
| **Submit When Receiving From** | Submits the event information on receiving a signal from the selected device. Events are typically sent at the end of the match. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

This device has no events.

## Analyzing Gameplay

The following are suggested ways to use the Analytics device in popular game types.

### Deathrun Example

To capture data on the number of levels completed in a deathrun, set the Analytics device to listen for player behavior that activates the [Player Checkpoint](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative) device.

Configure the user options for the Player Checkpoint device on your island, then add **[Mutator Zones](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative)** to all the level entrances.

Next, add the Analytics devices to receive information when the checkpoints are activated and to submit the checkpoint data when players enter the Mutator Zone on the next level.

#### Direct Event Binding

| Device A | Function | Device B | Event |
| --- | --- | --- | --- |
| **Analytics Device** | Submit | **Mutator Zone** | On Player Entering Zone |

Name the events clearly so you know what the device is monitoring, and number the events according to the number of levels in your deathrun. Notice in the example below that the name of the event is tied to the placement of the first checkpoint.

[![](https://dev.epicgames.com/community/api/documentation/image/681548ef-a78e-4868-9c2e-8ce5554cdd8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/681548ef-a78e-4868-9c2e-8ce5554cdd8c?resizing_type=fit)

You can place up to 100 Analytics devices on an island at once.

### Prop Hunt Example

Use the Analytics devices to determine whether hunters in a prop hunt game are evenly matched to the hidden players. Set up the necessary devices for the prop hunt gameplay. In this instance you’ll use two Analytics devices to track the number of players in the game versus the number eliminations.

Set one Analytics device to track the number of players that join a game, then set another Analytics device to track the number of eliminations in a game.

#### Direct Event Binding

| Device A | Function | Device B | Event |
| --- | --- | --- | --- |
| **Analytics Device** - Players\_Spawn | Submit | **Player Spawner** | On Player Spawned |
| **Analytics Device** - Players\_Eliminated | Submit | **Elimination Manager** | On Eliminated |

### Capture the Flag Example

Determine the number of times a flag is captured by monitoring how many times the flag is taken to the capture area. Once you’ve set the flag and capture areas, add an analytics device for each team. Set each device to monitor the capture event for one of the teams.

#### Direct Event Binding

| Device A | Function | Device B | Event |
| --- | --- | --- | --- |
| **Analytics Device** - Team 1 | Submit | **Capture Area** - Team 1 | On Control Change |
| **Analytics Device** - Team 2 | Submit | **Capture Area** - Team 2 | On Control Change |

## Analyzing Events Using Verse

Ensure the devices you intend to monitor with the Analytics device have a **Player Agent function**. Without a player-led action, the Analytics device will not record any data. Use the [**Verse API**](https://dev.epicgames.com/documentation/en-us/uefn/verse-api) to search for Player Agent functions on the device.

Set up the basic options for the devices to ensure they behave the way you want them to.

Create a Verse script following the directions in [Create Your Own Verse Device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

## Using Analytics in Verse

You can use the code below to control an Analytics device in [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/onboarding-guide-to-programming-with-verse-in-unreal-editor-for-fortnite). This code shows how to use events and functions in the Analytics device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level
analytics_device_verse_example := class(creative_device):

    # Reference to the Analytics device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Analytics device.
    @editable
    MyAnalyticsDevice:analytics_device = analytics_device{}

    # Reference to the Damage Volume device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Damage Volume device.
    @editable
    DamageVolume:damage_volume_device = damage_volume_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # Example for subscribing to an event on the Creative device.
        # Signaled when an agent enters the damage volume.
        DamageVolume.AgentEntersEvent.Subscribe(OnAgentEntered)

    # This function runs when an agent enters the damage volume because it's an event handler for the Damage Volume device's AgentEntersEvent.
    OnAgentEntered(Agent:agent):void=
        # Submits an event for `Agent` to generate analytics.
        MyAnalyticsDevice.Submit(Agent)
```

To use this code in your UEFN experience, follow these steps.

1. Drag an Analytics device onto your island.
2. Create a new Verse device named **analytics\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
3. In Visual Studio Code, open **analytics\_device\_verse\_example.verse** and paste the code above.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite#adding-your-verse-device-to-your-level) for steps.
5. Add a reference for the Analytics device on your island to your Verse device.
6. Save your project and click **Launch Session** to playtest.

### Analytics Device Verse API

See the `[analytics_device](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/analytics_device)` API Reference for more information on using the Analytics device in Verse.
