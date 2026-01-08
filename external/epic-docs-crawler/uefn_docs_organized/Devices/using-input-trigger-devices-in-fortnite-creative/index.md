# Input Trigger Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-input-trigger-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:45:23.655539

---

The **Input Trigger** device is a way to trigger events when players press or release a particular control input. You can use the device to capture when an input is pressed, and which player pressed it.

Response time for input defined in the input trigger device is dependent on the round-trip time between the player's client and the server. Because of this, input can take up to a second depending on the player's internet connection, so keep this in mind when using the input trigger device for your game.

You can use [event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) in the Creative toolset, connections in the **Details** panel in UEFN, or Verse code, to trigger other device functions such as blowing up a barrel, changing cameras, or other gameplay that is triggerable.

For help finding the Input Trigger device, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative)**.

## How the Creative Input Option Works

When you customize the Input Trigger device options, you'll see the **Creative Input** option listed first. This option's values correspond to a number of new input actions that can be configured by players. The way this works is a little complicated, so this section provides a more detailed explanation than the Device Options table has room for.

Players can find and rebind these inputs in the **Creative Input Action** section of the **Keyboard Controls** and **Controller Mapping** tabs in the Settings Menu.

Open the **sidebar**, click the **gear** icon to open the **Setting Menu**, then click either the **Keyboard Controls** or the **Controller Mapping** icons. You can find the **Creative Input Action** section of the settings by scrolling down the list in the left navigation area. This is where players can change which actions map to which controls. These settings apply across all of your Fortnite experiences.

For people on mobile platforms, these inputs always appear as new buttons displayed on the screen. The Input Trigger device has options you can use to customize the icon and color of this button, and whether you want it to display text.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Input Type** | **Creative Input Action**, *Standard Action* | Determines if this device tracks a standard input or a custom input. Standard inputs are used for common game actions. If **Standard Actions** is set as the Input Type, this device will listen for whether inputs bound to those actions are pressed or released. **Creative Input Actions** are custom actions only used by the Input Trigger. |
| **Creative Input** | Custom 1 (Fire), Custom 2 (Target), Custom 3 (Crouch), Custom 4 (Jump), Custom 5 (Sprint), **Custom 6 (Interact)**, *Custom 7 (Forward/Back)*, *Custom 8 (Left/Right)*, Custom 9 (Previous Item), Custom 10 (Next Item), Custom 11 (Swap Quickbar), Custom 12 (Harvesting Tool) | If the **Input Type** option is set to **Creative Input Actions**, this defines the input control this device is listening for. For more information about how this works, see the **How the Creative Input Option Works** section above. If you select **Custom 7** or **Custom 8**, an additional option is displayed below. |
| **Axis Direction** | Negative, **Any**, Positive | This option only displays if the Creative Input option is set to **Custom 7** or **Custom 8**. If the input control selected in the **Creative Input** option is a directional axis, this determines which direction the device is listening for. **Negative** is left or backwards, **Positive** is right or forwards. |
| **Standard Input** | **Fire**, Target, Crouch, Sprint, Jump | This option only displays if the **Input Type** is set to **Standard Action**. These are inputs are the same ones bound to normal player actions. This device only listens for whether these inputs are pressed or released. In cases where a mobile device doesn't have these inputs, a custom button is created. |
| **Consume Input** | On, **Off** | If set to **On**, this stops the input being read by other actions bound to that input. |
| **Show on HUD** | **On**, Off | Determines if the input is shown on the HUD. |
| **HUD Description** | **{input}**, Enter text | If **Show on HUD** is set to **On**, this is the text that will show on the HUD. The text field has a character limit of 24. The default text **{input}** will show the current input. |
| **Enabled At Game Start** | **On**, Off | Determines if the device is enabled when the game starts. |
| **Selected Team** | **Any**, Pick a team | Determines which team can activate the input. |
| **Selected Class** | No Class, **Any**, Pick a class | Determines which classes can activate the input. |
| **Invert Team Selection** | On, **Off** | If this is set to **On**, the input can be activated by all teams except the one chosen in the **Selected Team** option. |
| **Invert Class Selection** | On, **Off** | If this is set to **On**, the input can be activated by all classes except the one chosen in the **Selected Class** option. |
| **Registered Player Behavior** | **Add Registered**, Require Registered, Ignore Registered | Determines how registered players are counted by the device.   - **Add Registered**: Players can either be registered or counted by the device. - **Require Registered**: Players must be both registered and counted by the device. - **Ignore Registered**: Players must be counted, but not registered by the device. |

### Mobile Options

If you're looking to build an experience that runs smoothly on mobile, the following options allow you to customize button layouts, scaling and to add mobile icons.

| Option | Value | Description |
| --- | --- | --- |
| **Mobile Has Text** | On, Off | This option only displays if the Input Type is set to Creative Input Action. For players on mobile, this determines if the interaction icon shows the description text. |
| **Mobile Icon** | Hand, Pick an icon | This option only displays if the Input Type is set to Creative Input Action. For players on mobile, this determines what icon is used for the interaction icon. If you select None, the Hand icon will be used. Click the arrow to open the Icon Picker. Click in the search field and type text to find an icon, or use the scroll bar to browse through the collection. Click to select an icon, then click the checkmark to close the Icon Picker. |
| **Mobile Color** | White, Pick a color | This option only displays if the Input Type is set to Creative Input Action. Determines the color of the icon selected in the Mobile Icon option. Click the arrow to open the Color Picker. Click in the search field and type text to find a color, or use the scroll bar to browse through the collection. Click a color swatch, then click the checkmark to close the Color Picker. |
| **Mobile Pressed Icon** | **None**, Pick an icon | This determines what icon is used for the interaction icon when the button is pressed. If you select **None**, the Mobile Icon will be used. |
| **Mobile Use Direct Placement** | On, **Off** | When set to **On**, allows you to change the mobile button placement by changing the **Mobile Offset X** and **Mobile Offset Y** coordinates. |
| **Mobile Scale** | **1.0** - 10.0 |  |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enables the device when an event occurs. |
| **Disable When Receiving From** | Disables the device when an event occurs. |
| **Register Player When Receiving From** | Registers the instigating player when an event occurs. Registered players can be added or removed from the list of counted players depending on the **Registered Player Behavior** option's value. |
| **Unregister Player When Receiving From** | Removes the instigating player from the list of registered players when an event occurs. |
| **Unregister All Players When Receiving From** | Clears all players from the registered players list when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Input Pressed Send Event To** | When the input control is pressed, an event is sent to the selected device, which triggers the selected function. |
| **On Input Released Send Event To** | When the input control is released, an event is sent to the selected device, which triggers the selected function. |

## Using the Input Trigger Device in Verse

You can use the code below to control an Input Trigger device in **[Verse](https://dev.epicgames.com/documentation/en-us/fortnite/onboarding-guide-to-programming-with-verse-in-unreal-editor-for-fortnite)**. This code shows how to use events and functions in the Input Trigger device API. Modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }

using { /UnrealEngine.com/Temporary/Diagnostics }

using { /Verse.org/Simulation }

# A Verse-authored creative device that can be placed in a level

input_trigger_device_verse_example := class(creative_device):

    # Reference to the Input Trigger device in the level.

    # In the Details panel for this Verse device,

    # set this property to your Input Trigger device.

    @editable

    MyInputTriggerDevice:input_trigger_device = input_trigger_device{}

    # Reference to a VFX Spawner device in the level.

    # In the Details panel for this Verse device,

    # set this property to your VFX Spawner device.

    @editable

    VFXSpawnerDevice:vfx_spawner_device = vfx_spawner_device{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        # Example for subscribing to an event on the Creative device.

        # Signaled when a player presses the specified input on the device.

        MyInputTriggerDevice.PressedEvent.Subscribe(OnInputPressed)

        # Example for subscribing to an event on the Creative device.

        # Signaled when a player releases the specified input on the device.

        MyInputTriggerDevice.ReleasedEvent.Subscribe(OnInputReleased)

        # This example iterates through all players in the experience to show how to do operations per player on the device.

        for (Player : GetPlayspace().GetPlayers()):

            # Adds `Agent` to the registered player list.

            MyInputTriggerDevice.Register(Player)

    # This function runs when a player presses the input specified in the Input Trigger device because it's an event handler for PressedEvent.

    OnInputPressed(Agent:agent):void=

        VFXSpawnerDevice.Enable()

    # This function runs when a player releases the input specified in the Input Trigger device because it's an event handler for ReleasedEvent.

    OnInputReleased(Agent:agent, InputHeldDuration:float):void=

        VFXSpawnerDevice.Disable()

        Print("Input held for {InputHeldDuration} seconds.")
```

To use this code in your UEFN experience, follow these steps.

1. Drag an **Input Trigger** device onto your island.
2. Create a new Verse device named **input\_trigger\_device\_verse\_example**. See **[Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite)** for steps.
3. In Visual Studio Code, open **input\_trigger\_device\_verse\_example.verse** in Visual Studio Code and paste the code above.
4. Compile your code and drag your Verse-authored device onto your island. See **Adding Your Verse Device to Your Level** for steps.
5. Add a reference for the Input Trigger device on your island to your Verse device. See the **Adding a Verse Reference to a Creative Device in Your Level** section in [Editable Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse) for steps.
6. Save your project and click **Launch Session** to playtest.

### Input Trigger Device Verse API

See the [`input_trigger_device` API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/fortnitedotcom/devices/input_trigger_device) for more information on using the Input Trigger device in Verse.
