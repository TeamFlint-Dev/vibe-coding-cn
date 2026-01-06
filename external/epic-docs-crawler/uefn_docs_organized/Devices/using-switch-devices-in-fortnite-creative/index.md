# Switch Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-switch-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:41:06.418875

---

There are two ways you can use a **Switch**.

- As a physical switch that players can interact with, used with other devices so that players can open and close doors or turn lights off and on. If the Switch is made invisible, you can also use it to add interactivity to a prop!
- As a method for filtering interactions with other devices. For example, if the state of the Switch is **On**, it send an event, and if the Switch is **Off**, it will send a different event.

To find the Switch device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, any values that trigger contextual filtering are in *italic*. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about that in the Description field for that option.

## Device Options

This device has some basic functionality, like setting switch visibility, and choosing what text the player sees when they interact with the switch. Additionally, there are some advanced options that you can use if the switch is able to save its state.

You can configure this device with the following options.

Default values are **bold**. Values that use contextual filtering are in *italics*.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled at Game Start** | **Yes**, No | Determines whether the device is [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when the game starts. Disabled devices ignore all events except Enable. |
| **Initial State** | **Off**, On | This is the default starting state of the switch when there is no player-sourced state to override it. |
| **Visible During Game** | **Yes**, No | Determines whether the device is visible to players during the game. |
| **Turn On Text** | Enter text into field | Sets the text that displays when turning the Switch to the On position. The text field has a 150 character limit. |
| **Turn Off Text** | Enter text into field | Sets the text that displays when turning the Switch to the Off position. The text field has a 150 character limit. |
| **Device Model** | **Default**, Antique Lever, Toggle Switch, Default (Unlit), Antique Lever (Unlit), Red Button, Circuit Breaker, Ancient Lever, Checkbox | This is the visual model used for the switch. |
| **Sound** | **Enabled**, Disabled | Determines whether the switch makes a sound when it changes state (from Off to On, from On to Off). |
| **Allow Interaction** | **Yes**, No | Determines whether players can interact with the device. |
| **Interaction Time** | **Instant**, Pick or enter an amount of seconds | Determines how long the player interaction must be to activate the device. |
| **Limit Times Can Change** | **No**, *Yes* | Determines there is a limit to how many times the device can change. If this is set to **Yes**, an additional option displays below this one. |
| **Times Can Change** | **1**, Pick or enter a number | Determines the number of times the device can be toggled before it is disabled. |
| **Infinite Cooldown** | ***No***, Yes | Determines the cooldown time between interactions with the device. If you set this to **Yes**, the **Cooldown Time** option does not display below this one. |
| **Cooldown Time** | **Instant**, Pick an amount of seconds | This option only displays when the **Infinite Cooldown** option is set to **No**. Determines the cooldown time between interactions. |
| **Allowed Class** | No Class, **Any**, Pick or enter a class | Determines which class can activate the device. |
| **Allowed Team** | **Any**, Pick or enter a team | Determines which team can activate the device. |
| **Interaction Radius** | **0**, Pick or enter a radius distance | Allows players to interact by looking at any point within a radius of the specified size, rather than having to look directly at the button. Use in conjunction with the **Visibility** setting to make it appear as though players are interacting with other props. |
| **State Reset Time** | **No Reset**, Pick or enter an amount of time | Determines the amount of time before the device resets to its default state. |
| **Mutually Exclusive** | **No Exclusivity**, Pick a number | Turning this switch to **On** will turn off any other switches that have the same Mutually Exclusive index number. |
| **Store State Per Player** | Yes, **No** | If this is set to **Yes**, each player will have their own switch state. If this is set to **No**, all players have the same switch state. If this is set to **No** and the **Use Persistence** option is set to **Use**, the switch will use the **Resolve Conflicts** option when the state attempts to load. |
| **Use Persistence** | **Do Not Use**, *Use* | Whether or not this device should load any data from the backend. If you choose **Use**, additional options are displayed in the All Options tab. |
| **Auto-Save** | Yes, **No** | This option only displays if the **Use Persistence** option is set to **Use**. Determines whether the switch state is automatically saved when it changes. |
| **Auto-Load** | On, **Off** | This option only displays if the **Use Persistence** option is set to **Use**. Determines whether the switch state is automatically loaded at Game Start, or if it must be loaded using event binding. |
| **Resolve Conflicts** | First Player, **Majority**, Prioritize On, Prioritize Off | This option only displays if the **Use Persistence** option is set to **Use**. Determines what happens when the state is loaded and the **Store State Per Player** option is set to **No**.  Values for this option:   - **First Player**: The switch loads the state of the oldest active player. - **Majority**: The switch loads the state that is the most prevalent, with ties using the **Initial State** option's value. - **Prioritize On**: The switch loads the **On** state if at least one player has that state. - **Prioritize Off**: The switch loades the **Off** state if at least one player has that state. |
| **Check State at Game Start** | **Enabled**, Disabled | Determines if the switch will check its state at Game Start, triggering the **On Check Result On** or **On Check Result Off** events. |
| **Check Switch State When Disabled** | Yes, **No** | Determines whether the device will check its state even when it is disabled. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Turn On When Receiving From** | This function turns the switch on when an event occurs. |
| **Turn Off When Receiving From** | This function turns the switch off when an event occurs. |
| **Toggle State When Receiving From** | This function toggles the switch when an event occurs. |
| **Load State When Receiving From** | This function loads the switch's state when an event occurs. |
| **Save State When Receiving From** | This function saves the switch's state when an event occurs. |
| **Check State When Receiving From** | This function checks the state of the switch when an event occurs. |
| **Clear Player Persistence When Receiving From** | This function clear's the instigating players persistence data when an event occurs. |
| **Clear All Persistence Data For Current Players When Receiving From** | This function clears all persistence data for all current players when an event occurs. |
| **Save State For All When Receiving From** | This function saves the switch state for all players when an event occurs. |
| **Load State For All When Receiving From** | This function loads the switch state for all players when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Turned On Send Event To** | When the switch is turned on, an event is sent to the selected device, which triggers the selected function. |
| **On Turned Off Send Event To** | When the switch is turned off, an event is sent to the selected device, which triggers the selected function. |
| **On Check Result On Send Event To** | If the switch is on when the state is checked, an event is sent to the selected device, which triggers the selected function. |
| **On Check Result Off Send Event To** | If the switch is off when the state is checked, an event is sent to the selected device, which triggers the selected function. |
| **On State Save Send Event To** | When the switch state is saved, an event is sent to the selected device, which triggers the selected function. |
| **On State Changes Send Event To** | When the switch's state changes, an event is sent to the selected device, which triggers the selected function. |
| **On State Load Send Event To** | When the switch's state is loaded, an event is sent to the selected device, which triggers the selected function. |
| **On Cleared Send Event To** | When the switch's persistence data is cleared, an event is sent to the selected device, which triggers the selected function. |

## Using Switch in Verse

You can use the code below to control a Switch device in [Verse](https://dev.epicgames.com/documentation/en-us/uefn/learn-programming-with-verse-in-unreal-editor-for-fortnite). This code shows how to use events and functions in the Switch device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level
switch_device_verse_example := class(creative_device):

    # Reference to the Switch Device in the level.
    # In the Details panel for this Verse device,
    # set this property to your Switch Device.
    @editable
    MySwitchDevice:switch_device = switch_device{}

    # Localizable messages that you can use to set player-facing text
    TurnOnInteractionText<localizes>:message = "Custom switch turned on text!"

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # Example for subscribing to an event on the Creative device.
        # Signaled when the switch state changes.
        MySwitchDevice.StateChangesEvent.Subscribe(OnStateChanged)

        # Sets the *Turn On Text* to be displayed to a user when the switch is currently off, and offers an interaction to switch it on. Clamped to 150 characters.
        MySwitchDevice.SetTurnOnInteractionText(TurnOnInteractionText)

    # This function runs when the player turns the switch on/off in-game because it's an event handler for StateChangesEvent.
    OnStateChanged():void=
        Print("Switch Device state changed.")

        # Query whether this device has a single global on/off state, or has a personalized on/off state for each individual agent.
        if (MySwitchDevice.IsStatePerAgent[]):
            Print("Switch Device state is set to per agent.")

            # This example iterates through all players in the experience to show how to do operations per player on the device.
            for (Player : GetPlayspace().GetPlayers()):
                # Returns the current state of this switch: true (on) or false (off). Use this overload  of `GetCurrentState` when this device has *Store State Per Player* set to *Yes*.
                if (MySwitchDevice.GetCurrentState[Player]):
                    Print("Current state is on.")
                else:
                    Print("Current state is off.")
        else:
            Print("Switch Device state is not set to per agent.")

            # Returns the current state of this switch: true (on) or false (off). Use this overload  of `GetCurrentState` when this device has *Store State Per Player* set to *No*.
            if (MySwitchDevice.GetCurrentState[]):
                Print("Current state is on.")
            else:
                Print("Current state is off.")
```

To use this code in your UEFN experience, follow these steps.

1. Drag a Switch device onto your island.
2. Create a new Verse device named **switch\_device\_verse\_example**. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#creatinganewdevicewithverse) for steps.
3. In Visual Studio Code, open **switch\_device\_verse\_example.verse** in Visual Studio Code and paste the code above.
4. Compile your code and drag your Verse-authored device onto your island. See [Adding Your Verse Device to Your Level](https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse#addingyourversedevicetoyourlevel) for steps.
5. Add a reference for the Switch device on your island to your Verse device. See [Adding a Verse Reference to a Creative Device in Your Level](https://dev.epicgames.com/documentation/en-us/uefn/customize-device-properties-in-verse#addingaversereferencetoacreativedeviceinyourlevel) for steps.
6. Save your project and click **Launch Session** to playtest.

### Switch Device Verse API

See the [`switch_device` API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/switch_device) for more information on using the Switch device in Verse.
