# Button Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:32:07.694627

---

You can use a [Button](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) device to activate other [devices](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). In its [default](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) state, the button does nothing, but when configured to work with another device, the button can activate another [device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) when a player interacts with it.

For help on how to find the Button device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

**Looking for more inspiration?** See [**Button Device Design Examples**](button-device-design-examples-in-fortnite-creative) to kick off your imagination!

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Device Options

To pair a button with another device, you need to specify the [event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for the player interaction with the button. See [Direct Event Binding](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) for the settings.

You can configure this device with the following options.

Default values are in **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Interact Time** | **Instant**, Pick an amount of time | Determines the length of interaction required to activate the device. |
| **Activating Team** | **Any**, Pick a team number | This indicates which team can interact with the button. Use the arrows to choose a team, or click in the field to type in a team number. |
| **Invert Team Selection** | On, **Off** | If set, the device can by used by all but the selected team. |
| **Allowed Class** | **Any**, No Class, Pick a class | Determines what class can interact with the device. Use the arrows to choose a class, or click in the field to type in a class number. |
| **Invert Class Selection** | On, **Off** | If set, the device can by used by all but the selected class. |
| **Times Can Trigger** | **Infinite**, Pick a number | The number of times the button can be [triggered](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) before it's [disabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). Use the arrows to choose, or click in the field to type in a number. |
| **Delay** | **Instant**, Pick an amount of seconds | How long the button waits to transmit its signal after it's triggered. Use the arrows to choose, or click in the field to choose an amount. |
| **Reset Delay** | **Instant**, Pick an amount of seconds | This is the amount of time where the button can't be triggered after it transmits its signal. Use the arrows to choose, or click in the field to choose an amount. |
| **Trigger Sound** | **Enabled**, Disabled | The sound that plays when the button is triggered. |
| **Enabled at Game Start** | **Enabled**, Disabled | Whether the button is automatically enabled when the game starts. |
| **Interaction Text** | Enter text | This text displays when the player is close to the button and looks at it. The text field is limited to 64 characters. |
| **Visible During Game** | **Yes**, No | If you want the button to be generally visible during the game, choose Yes. You can also choose to make the button invisible and attach it to a [prop](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), so it looks like the prop activates another device. In that case, choose No. |
| **Interaction Radius** | **Button**, Pick a size | If you choose to make the button visible in the game, choose **Button**. If you choose not to make the button visible, you need to indicate how close the player must be to interact with the prop your button is attached to. Use the arrows to choose a distance, or click in the field to type in a number. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Event to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, press the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | Enable the button. |
| **Disable When Receveing From** | Disable the button. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the timer to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Interact Send Event To** | Sends an event to a linked device when a player interacts with the button. |

## Gameplay Examples Using Buttons

- [Dungeon Crawler](https://dev.epicgames.com/documentation/en-us/fortnite/dungeon-crawler-gameplay-example-in-fortnite-creative)
- [Shooting Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/shooting-gallery-in-fortnite-creative)
- [Spawner123](https://dev.epicgames.com/documentation/en-us/fortnite/spawner-123-in-fortnite-creative)
