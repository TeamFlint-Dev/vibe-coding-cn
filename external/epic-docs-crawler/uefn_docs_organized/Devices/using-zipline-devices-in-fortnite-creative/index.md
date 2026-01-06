# Zipline Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-zipline-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:40:42.190629

---

With the **Zipline** device, you can create [ziplines](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#zipline) as long as you need, with whatever curves, twists and turns you want! You can create the exact route you want, and give your players a unique and fun way to [traverse](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#traverse) the environment on your island.

Zipline devices are similar to Grind Rail and Grind Vine devices in that when you place a zipline, it has two parts, a cable and two Control Points. The Control Points determine the length of the zipline and its shape. A minimum of two Control Points is required — if you remove all but one Control Point, it will remove the entire zipline.

The zipline and the Control Points have separate [Customization panels](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#customize-panel) and separate options. Make sure you have the Control Point selected, and not the rail. If you accidentally click the rail, it will move the whole thing instead of just moving the Control Point on the rail.

Use the [phone tool](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phone) **Copy** function on one of the original two Control Points to add a new Control Point to the zipline. You can use the **Cut** function to move a Control Point to a different position on the zipline or to change the zipline's length. To safely remove one or more Control Points, use the phone tool **Select** function first, then delete.

Rotating a Control Point adjusts the direction of the zipline as it goes through that point, which is how you create curves and turns. You can adjust the sharpness or roundness of the curve by adjusting the **Tangent Intensity** option (see [Device Options](https://dev.epicgames.com/documentation/en-us/fortnite/using-zipline-devices-in-fortnite-creative) below).

If there are any structures on the zipline, whether placed by you or built by players, they will be destroyed when the player hits them. This is to prevent players from trying to block the zipline to stop their opponents from escaping.

## Finding and Placing the Device

1. From [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode), press the **Tab** key to open the [CREATIVE inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen.
2. Click the **DEVICES** tab. You can scroll to select the device, use the **Search** box to look up the device by name, or the **Categories** in the panel on the left.
3. Click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#place) immediately, or put the device in the [QUICK BAR](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#quick-bar) to place later.
4. Press **Esc** to return to your island in Create mode. Use your [phone](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#phone) to position the device, then click to place it. Press **Esc** to detach the device from your phone.
5. Point at the device with your phone. If the **CUSTOMIZE** popup doesn't open immediately, move closer until it does, then press **E** to open the Customize panel.

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. You can choose names that relate to each device's purpose, so it's easier to remember what each one does.

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This feature will reduce clutter in the Customize panel and make options easier to manage and navigate.

However, it may not be easy to recognize which options or values trigger contextual filtering. To help you identify them, in our device docs we use *italic* for any values that trigger contextual filtering. All options will be listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option’s value, there will be a note about that in the Description field for that option.

## Device Options

You can determine which teams or classes can use a zipline. You can also set a custom color for the zipline, or change the curve intensity of the zipline when it passes through control points.

Configure this device with the following options.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

### Zipline Cable: Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Selected Team** | **Any**, Pick or enter a team | Determines which team is able to use this zipline. |
| **Invert Team Selection** | On, **Off** | If this is set to **On**, all teams can use the zipline **except** the team chosen in the **Selected Team** option. |
| **Selected Class** | No Class, **Any**, Pick or enter a class | Determines which classes are able to use this zipline. If you choose **No Class**, only players without an assigned class can use the zipline. |
| **Invert Class Selection** | On, **Off** | If this is set to **On**, all classes can use the zipline **except** the class chosen in the **Selected Class** option. |
| **Use Custom Color** | *On*, **Off** | Determines whether the zipline uses the default color, or a custom color. If this is set to **On**, the **Color** option displays below this one. |
| **Color** | **White**, Pick a color swatch | This option is only displayed if the **Use Custom Color** option is set to **On**. Determines the color of the zipline. Click the swatch to open the Color Picker. Select a color, then click the checkmark to close the Color Picker. |

### Zipline Cable: All Options (Additional)

There are no additional options for the zipline cable.

### Zipline Control Point: Basic Options

| Option | Value | Description |
| --- | --- | --- |
| **Tangent Intensity** | **1000.0**, Pick or enter a number | Determines how much the forward direction of this Control Point influences the curve of the zipline at this location. |

### Zipline Control Points: All Options (Additional)

There are no additional options for the zipline Control Points.

## Direct Event Binding System

**Direct event binding** allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the functions and events for this device.

### Zipline Cable Functions

There are no functions for the zipline cable.

### Zipline Cable Events

| Option | Select Device | Select Function | Description |
| --- | --- | --- | --- |
| **On Attach Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When a player attaches to the zipline, an event is sent to the selected device, which triggers the selected function. |
| **On Detach Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When a player detaches from the zipline, an event is sent to the selected device, which triggers the selected function. |

### Zipline Control Point Functions/Events

The Control Points have no functions or events.
