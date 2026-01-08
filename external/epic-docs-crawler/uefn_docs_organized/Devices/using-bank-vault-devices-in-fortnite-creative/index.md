# Bank Vault Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-bank-vault-devices-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:42:38.936306

---

This device is a **Bank Vault** you can place in buildings on your island, if you want to create a heist mechanic in your game.

For help on how to find the **Vault** device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

### Device Options

Default values are **bold**.

You can configure this device with the following options.

| Option | Values | Description |
| --- | --- | --- |
| **Enabled at Game Start** | **On**, Off | Determines if the device is enabled when the game starts. |
| **Require Thermit****e** | On, Off | Determines if the player needs thermite when interacting with the door to start the vault opening process. |
| **Activating Team** | **Any**, Pick a team | Determines which team can interact with the device. |
| **Invert Team Selection** | On, **Off** | If this is set to **On**, all teams except the team selected in the **Activating Team** option can interact with the device. |
| **Activating Class** | No Class, All, **Any**, Pick a class | Determines which class can interact with the device. **No Class** means only players with no assigned class can interact. **All** means all players can interact regardless of class. **Any** means any player with an assigned class can interact. |
| **Invert Class Selection** | On, Off | If this is set to **On**, all classes except the class selected in the **Activating Class** option can interact with the device. |
| **Weakpoints Take External Damage** | **On**, Off | Determines if the vault's weakpoints take damage from weapons or items. |
| **Weakpoint Passive Damage Per Second** | **Don't Override**, 0, Pick an amount | Determines how much damage the vault's weakpoints take each second. If set to the default **Don't Override**, the damage per second will start low and increase over time. |
| **Weakpoint Health** | **750**, Pick an amount | Determines how much damage a weakpoint can take before being destroyed and activating the next weakpoint. |
| **Number of Weakpoints** | **5**, Pick an amount | Determines how many weakpoints need to be destroyed before the vault opens. |
| **Initial Weakpoint Delay** | **6.0 Seconds**, Pick or enter an amount | Determines how many seconds it takes until the weakpoint is vulnerable after it is activated. |
| **Zone Width** | **20**, Pick a size | The vault has a zone the player must be in to see the progress of the vault opening. This option determines the width of that zone. |
| **Zone Depth** | **20**, Pick a size | The vault has a zone the player must be in to see the progress of the vault opening. This option determines the depth of that zone. |
| **Zone Height** | **20**, Pick a size | The vault has a zone the player must be in to see the progress of the vault opening. This option determines the height of that zone. |
| **Show Progress Zone** | **On**, Off | Determines if the progress zone is visible during Create mode (Creative) and Edit Mode (UEFN). |
| **Show Map Icon** | On, Off | Determines if this Bank Vault displays as an icon on the map. |

### Direct Event Binding

Following are the direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/function) listens for an event on a device, and then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving** **From** | Enables the device when an event occurs. |
| **Disable****When Receiving From** | Disables the device when an event occurs. |
| **Reset****When Receiving From** | Resets the vault when an event occurs. |
| **Activate Vault Door****When Receiving From** | Begins the vault opening sequence without thermite when an event occurs. |
| **Deactivate Vault Door****When Receiving From** | Disables the weakpoint vulnerability and freezes the progress on all of them when an event occurs. |
| **Force Open****When Receiving From** | Destroys the remaining weakpoints and opens the vault door when an event occurs. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/event) tells another device when to perform a function.

1. For any function, click the option, then Select Device to access and select from the Device dropdown menu.
2. Once you've selected a device, click Select Function to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the Add button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Opened Send Event To** | When the vault is opened, an event is sent to the selected device. |
| **On Sequence Started Send Event To** | When the vault sequence is started by a player or event, an event is sent to the selected device. |
| **On Weakpoint Activated Send Event To** | When a weakpoint becomes active, an event is sent to the selected device. |
| **On Weakpoint Destroyed Send Event To** | When a weakpoint is destroyed, an event is sent to the selected device. |
| **On Weakpoint Vulnerable Send Event To** | When a weakpoint becomes vulnerable (such as after being frozen), an event is sent to the selected device. |
