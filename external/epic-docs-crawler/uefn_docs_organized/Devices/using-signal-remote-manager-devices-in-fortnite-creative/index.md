# Signal Remote Manager Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-signal-remote-manager-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:48:39.223723

---

A **Signal Remote** is a device players can carry and use to send signals to other devices. You can use the **Signal Remote Manager** to manage how and where these signals are sent. This gives players the ability to send signals from held items [in-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).

For example, a player can activate their Signal Remote to send a signal that teleports them back to their base area.

## Finding and Placing the Signal Remote Manager

[![Finding the Signal Remote Manager Device](https://dev.epicgames.com/community/api/documentation/image/36aed0c9-0790-402e-9043-1410e39c1627?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36aed0c9-0790-402e-9043-1410e39c1627?resizing_type=fit)

Finding the Signal Remote Manager Device

*Click image to enlarge.*

1. From [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary), press the **Tab** key to open the [CREATIVE inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) screen.
2. Click the **DEVICES** tab. You can scroll to select the device, use the **Search** box to look up the device by name, or the **Categories** in the panel on the left.
3. Click **PLACE NOW** to [place](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) immediately, or put the device in the [QUICK BAR](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to place later.
4. Press **Esc** to return to your island in Create mode. Use your [phone](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to position the device, then click to place it. Press **Esc** to detach the device from your phone.
5. Point at the device with your phone. If the **CUSTOMIZE** popup doesn't open immediately, move closer until it does, then press **E** to open the Customize panel.

## Finding and Placing a Signal Remote

You need to use a Signal Remote with the Signal Remote Manager. Although it doesn't look like a weapon, the Signal Remote is found on the **Weapons** tab in the Creative inventory.

You need to grant your players a Signal Remote using a [Class Designer](using-class-designer-devices-in-fortnite-creative), an [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device, or a [chest](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary). This Signal Remote can "fire" signals on two channels: a primary and a secondary.

[![Finding the Signal Remote](https://dev.epicgames.com/community/api/documentation/image/b8515020-582f-4341-ab83-954a8886397c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b8515020-582f-4341-ab83-954a8886397c?resizing_type=fit)

Finding the Signal Remote

*Click image to enlarge.*

1. From **Create mode**, press the **Tab** key to open the **Creative inventory** screen.
2. Click the **WEAPONS** tab. You can scroll to find the Signal Remote, or use the **Search** box to look it up.
3. Click **EQUIP** to place the Signal Remote in your Player Equipment bar.
4. Press **Esc** or **Tab** to return to your island in Create mode.
5. Walk up to the Signal Remote Manager device. Press the **Tab** key to open Creative inventory, but this time, click **Play** in the [top navigation bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to display the [Play inventory](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary).
6. Drag the Signal Remote off the [Equipment bar](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to drop it on the Signal Remote Manager. This registers the Signal Remote with the device. It should look like the image below.

   [![Signal Remote Registered with Signal Remote Manager](https://dev.epicgames.com/community/api/documentation/image/876addab-0b4a-43db-8855-7f79f717773f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/876addab-0b4a-43db-8855-7f79f717773f?resizing_type=fit)

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) them. You can choose names that relate to each device's purpose so it's easier to remember what each one does.

## Device Options

When you customize the options on the Signal Remote Manager, the values will affect how the Signal Remote works.

You can configure the Signal Remote Manager with the following options.

Default values are **bold**.

### Device Options

| Option | Value | Description |
| --- | --- | --- |
| **Enabled at Game Start** | **On**, Off | Determines whether the device is [enabled](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) at the start of the game. |
| Cooldown Time | 3 seconds, Pick or enter an amount of time | Determines the length of time the [cooldown](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) lasts after you activate the Signal Remote. |
| **Signal Remote Tier** | Common, **Uncommon**, Rare, Epic, Legendary | Determines the rarity tier of the signal remote this device is paired with. |
| **Activate Events Immediately** | On, **Off** | Determines whether the event activates as soon as the player presses the input control. |
| **Remote Sound Enabled** | **On**, Off | Determines whether the device should play default SFX or not. |

## Direct Event Binding

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the [functions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) and [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) for this device.

### Functions

Direct event binding uses functions as receivers. A function listens for one device's event to tell another device to perform a function.

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **Enable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function enables the device when an event occurs. If more than one device or event can enable this device, click **Add** to add a new line. |
| **Disable When Receiving From** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available events. | This function disables the device when an event occurs. If more than one device or event can disable this device, click **Add** to add a new line. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

| Option | Select Device | Select Event | Description |
| --- | --- | --- | --- |
| **On Primary Activation Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When the player activates the Signal Remote's primary function, the device sends an event to the selected device, which triggers the selected function. |
| **On Secondary Fire Send Event To** | Click the arrow to display a list of available devices. | Click the arrow to display a list of available functions. | When the player activates the Signal Remote's secondary function, the device sends an event to the selected device, which triggers the selected function. |

## Design Examples

Here are some examples of how you can use the Signal Remote Manager.

- [Door Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-signal-remote-manager-devices-in-fortnite-creative)
- [Restock Remote](https://dev.epicgames.com/documentation/en-us/fortnite/using-signal-remote-manager-devices-in-fortnite-creative)
- [Remote Hacking](https://dev.epicgames.com/documentation/en-us/fortnite/using-signal-remote-manager-devices-in-fortnite-creative)

The Signal Remote Manager device requires one of the Signal Remote A through D weapons to be registered to it in order to transmit signals correctly. This means you can have four different Signal Remote Manager devices within the same map, one per Signal Remote weapon. Then, through either a Class Manager, Item Spawner or Item Granter, you need to give this to the player to use.

For these examples, all three use the Class Designer device. Place a Class Designer anywhere on the map and customize it with the following settings.

[![Class Designer Settings](https://dev.epicgames.com/community/api/documentation/image/9974f58f-4eee-4e38-8dd6-d5e653c5ca13?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9974f58f-4eee-4e38-8dd6-d5e653c5ca13?resizing_type=fit)

| Option | Value | Description |
| --- | --- | --- |
| **Class Identifier** | 1 | This will be used as the default class for all examples. |
| **Equip Granted Item** | First Item | The Signal Remote will be automatically equipped upon spawning. |

Next, go to the Game tab in your My Island settings and make sure to set the Default Class Identifier as follows. This will ensure that you spawn with the Signal Remote weapon at the beginning of each design example.

[![My Island Game Tab, Default Class Identifier](https://dev.epicgames.com/community/api/documentation/image/db4ba5c4-e457-488e-b6fb-64ceb4e09188?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/db4ba5c4-e457-488e-b6fb-64ceb4e09188?resizing_type=fit)

My Island Game Tab, Default Class Identifier

*Click image to expand.*

| Which Tab in My Island | Option | Value | Description |
| --- | --- | --- | --- |
| Game | **Default Class Identifier** | 1 | This will be used as the default class for all examples. |

### Door Lock

The most basic functionality of the Signal Remote Manager device is in sending two signals — such as one to open or unlock a door, and the other to close it. This is demonstrated in the following example and video.

You will need the following devices.

- 1 x **Signal Remote Manager** and **Signal Remote** weapon
- 1 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative)

1. Create a wall with a door, and add the Lock device adjacent to the door. Customize the lock to the following settings.

   [![Lock Settings](https://dev.epicgames.com/community/api/documentation/image/26aa3793-bd7f-4e12-b95b-3aa0cd64cbf5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26aa3793-bd7f-4e12-b95b-3aa0cd64cbf5?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Visible During Game** | Off | The Lock device is not visible during gameplay. |
   | **Unlock When Receiving From** | Channel 1 | The primary fire of the Signal Remote will unlock the door. |
   | **Lock When Receiving From** | Channel 2 | The secondary fire of the Signal Remote will lock the door. |
   | **Open When Receiving From** | Channel 1 | The primary fire of the Signal Remote will open the door. |
   | **Close When Receiving From** | Channel 2 | The secondary fire of the Signal Remote will close the door. |
2. Place a set-up Signal Remote Manager device anywhere on your island. Customize it with the following settings.

   [![Remote Manager Settings](https://dev.epicgames.com/community/api/documentation/image/7b369ab6-7845-4bff-9983-83986f9c0b79?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b369ab6-7845-4bff-9983-83986f9c0b79?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Cooldown Time** | 1 Second | Time between transmitting signals on the Signal Remote. |
   | **On Primary Activation Transmit On** | Channel 1 | Transmits the signal to unlock and open the door on primary fire of the Signal Remote. |
   | **On Secondary Fire Transmit On** | Channel 2 | Transmits the signal to lock and close the door on secondary fire of the Signal Remote. |

You now have a lockable door operated by a Signal Remote weapon.

You can also use this game mechanic for enabling and disabling other devices. Lock a car remotely so nobody else can use it. Make walls vanish and reappear with a toggle for an advanced line of defense. These openings can be used as shortcuts on the team, and restricted to certain classes or globally used.

### Restock Remote

You can use Signal Manager devices to set primary and secondary fire to trigger Teleporter devices. This gives players a way to restock immediately during a firefight without being eliminated, and provides a way to teleport to a central location..

You will need the following devices.

- 1 x **Signal Remote Manager** and **Signal Remote**
- 2 x [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)
- Multiple [Vending Machines](https://dev.epicgames.com/documentation/en-us/fortnite/using-vending-machine-devices-in-fortnite-creative)

1. Create a resupply depot and a secure place to teleport near the front lines of your arena. Place a Teleporter device inside the resupply depot. Customize it to the following settings.

   [![Teleporter Settings](https://dev.epicgames.com/community/api/documentation/image/0534af11-927f-4565-a857-c5b677f3d846?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0534af11-927f-4565-a857-c5b677f3d846?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Teleporter Group** | None | There is no manually activated teleporter network for this device when you walk into it. |
   | **Teleporter Target Group** | None | There is no manually activated targeted teleporter network for this device when you walk into it. |
   | **Teleporter Rift Visible** | No | The teleporter rift is not visible during gameplay. |
   | **Play Sound Effects** | No | The teleporter sound effects are not played when used. |
   | **Face Player In Teleporter Direction** | Yes | The player is faced in a specific direction to make sure they are properly oriented when using the teleporter. |
   | **Teleport To When Receiving From** | Channel 2 | Teleports the player when using the alternate fire of the Signal Remote. |
2. Copy the teleporter, and place a second one down in the secure front lines section of your arena. Adjust only the following setting.

   [![Teleporter Settings](https://dev.epicgames.com/community/api/documentation/image/22040f29-ffa3-4124-9d09-efad1166af30?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/22040f29-ffa3-4124-9d09-efad1166af30?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Teleport To When Receiving From** | Channel 1 | Teleports the player when using the primary fire of the Signal Remote. |
3. Populate the resupply depot with the vending machines and equipment you want, using the default device settings.

You now have a Signal Remote weapon able to teleport the player between two different locations.

Game modes with longer respawns or limited lives can benefit from this method of re-engagement, where running in and being eliminated might not be the best way to get back in the fight. There can also be two assault points that a player can choose between after respawning.

### Remote Hacking

You can use more complex interactions with a signal manager. They can be used offensively in game modes like Capture the Flag, Search and Destroy or Domination to give a unique identity to certain classes.

You will use the following devices.

- 1 x **Signal Remote Manager** and **Signal Remote**
- Multiple [**Customizable Lights**](using-customizable-light-devices-in-fortnite-creative)
- 1 x [Timed Objective Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-timed-objective-devices-in-fortnite-creative)

1. Build a structure to house an objective, such as a flag or Capture Area device. Set the time of day and optionally use additional lighting such as a Skydome device to darken the map.
2. Place a Customizable Light device within the building. Customize the following settings.

   [![Light Settings](https://dev.epicgames.com/community/api/documentation/image/8e31444c-fe30-403a-8656-677d6d70dcb9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8e31444c-fe30-403a-8656-677d6d70dcb9?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Light Intensity** | 10% | Make sure to set a desired light intensity. This setting was used for demonstration purposes. |
   | **Turn On When Receiving From** | Channel 2 | Automatically turns the lights back on with a Timed Objective device a short duration after being shut off. |
   | **Turn Off When Receiving From** | Channel 1 | The Signal Remote primary fire will turn off the lights and set the automatic reboot from the Timed Objective device. |
3. Duplicate the customizable light and populate the interior with copies until it is well lit.
4. Place a Timed Objective device anywhere on the island. Customize it to the following settings.

   [![Timed Objective Settings](https://dev.epicgames.com/community/api/documentation/image/b30505ea-0eac-4474-b07a-b4f8e5f2f297?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b30505ea-0eac-4474-b07a-b4f8e5f2f297?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Time** | 15 Seconds | The duration of the Timed Objective timer. |
   | **Timer Label Text** | Rebooting Power... | The HUD display for the timer being counted down. |
   | **Urgency Mode Start Time** | 3 | The remaining duration before the timer countdown begins to play urgent sound effects. |
   | **Start When Receiving From** | Channel 1 | The timer is begun when the primary button of the Signal Remote is hit that deactivates the lights. |
   | **When Completed Transmit On** | Channel 2 | After completing, transmits a signal to turn all the Customizeable Lights back on. |
5. Finally, place a set-up Signal Remote Manager device anywhere on your island. Customize it with the following settings.

   [![Remote Signal Settings](https://dev.epicgames.com/community/api/documentation/image/2ff3e5b8-f265-4965-82eb-7ca838408bcf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ff3e5b8-f265-4965-82eb-7ca838408bcf?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Cooldown Time** | 1 Second | Time between transmitting signals on the Signal Remote. |
   | **On Primary Activation Transmit On** | Channel 1 | Transmits the signal to turn off the lights and activate the Timed Objective device automatically rebooting it. |

You have now set up a Signal Remote weapon that operates as a remote hacking device.

Set the cooldown time longer than 1 second. This was used for demonstration, but the actual class should have a longer cooldown. You could also combine the above elements, to open shortcuts that are normally locked and might be poorly defended. Alternatively, you can set classes to temporarily activate Sentry devices on a cooldown, which help defend the base when it is attacked.
