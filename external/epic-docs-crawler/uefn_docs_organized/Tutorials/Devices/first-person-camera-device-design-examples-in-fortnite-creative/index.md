# First Person Camera Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/first-person-camera-device-design-examples-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:06:44.888794

---

The **First Person Camera** device can transform your Fortnite island into exciting gameplay with a traditional first-person way of looking at things!

Ready to take a look at what this device can do?

## Example 1: Basic Setup

The **First Person Camera** device provides a perspective for the player as though they were looking through their avatar's eyes. In this camera mode, the player usually can't see their avatar's body, but can see their hands or weapons.

### Devices Used

- 1 x [First Person Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-first-person-camera-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device

### Add the First Person Camera Device

1. Place the camera on your island.
2. Customize it with the following settings.

   [![](https://dev.epicgames.com/community/api/documentation/image/56e88580-2afd-4813-b079-2987fd90e512?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/56e88580-2afd-4813-b079-2987fd90e512?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Preview Device Color** | Gold | Select this or another color you like. |
   | **Interaction Distance** | Standard | Sets how close the player needs to be to interact with the camera. |

### Add a Player Spawner Device

1. Place a **Player Spawner** device.
2. Rename it so you can tell which spawner is being used for first-person gameplay. In this example, it was named **Player Spawner FPS\_1**.

### Add an Item Granter Device

One quirk of the First Person Camera device is that an avatar must already be holding an item that works with this camera before the player can switch to a first-person view.

Most available guns work with the device and show a player's hands holding the weapon, so you'll need to make sure that players start with a compatible weapon. The **[First Person Camera](https://dev.epicgames.com/documentation/en-us/fortnite/using-first-person-camera-devices-in-fortnite-creative)** page lists compatible weapons.

[![](https://dev.epicgames.com/community/api/documentation/image/a3277f17-5e6d-4eb5-b673-e2f013a2a66a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3277f17-5e6d-4eb5-b673-e2f013a2a66a?resizing_type=fit)

*This example shows an assault rifle registered with the Item Granter device, but you can use any weapon that's compatible with the first-person camera view.*

1. Place an **Item Granter** device.
2. Rename the item granter **Starting Gun\_1**.
3. Set the **Equip Granted Item** option to **Yes**.

   [![](https://dev.epicgames.com/community/api/documentation/image/8965015b-e636-44e4-803b-1d43acb82366?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8965015b-e636-44e4-803b-1d43acb82366?resizing_type=fit)
4. **Direct event binding** is how you set devices to communicate directly with other devices. This involves setting **functions** and **events** for the devices involved.

Bind the Item Granter **function** to the **Player Spawner FPS\_1** device, and set the **event** to **On Player Spawned**.

[![](https://dev.epicgames.com/community/api/documentation/image/97a2ab07-64de-44a6-9a11-53235990d329?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97a2ab07-64de-44a6-9a11-53235990d329?resizing_type=fit)

When you bind a device function to an event on another device, the binding will also show on the bound device under the event tab.

[![](https://dev.epicgames.com/community/api/documentation/image/ade9975c-8283-487a-ae3b-2b0861b34e6d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ade9975c-8283-487a-ae3b-2b0861b34e6d?resizing_type=fit)

This also applies binding events to other devices — the binding will show on the bound device on the function tab.

## Example 2: Customizing the First Person Camera Device

There are a number of interesting settings that can be adjusted in the First Person Camera device.

One that will have an immediate effect on the gameplay on your islands relates to interacting with items from a first-person view.

Follow the steps below to build on the example you just completed in **Example 1**.

### Additional Devices Used

- 1 x [Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative) device
- 1 x **[Fang Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-fang-spawner-devices-in-fortnite-creative)** device

### Add Item Spawner Devices

1. Add a few item spawners to your island.

   [![](https://dev.epicgames.com/community/api/documentation/image/0c49b5a0-134a-446b-9d40-19cc8ccec56b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c49b5a0-134a-446b-9d40-19cc8ccec56b?resizing_type=fit)
2. To register a weapon to a spawner, stand next to the spawner, then go to the [Creative Menu](https://dev.epicgames.com/documentation/en-us/fortnite/hotkey-and-keybinding-shortcuts-in-fortnite-creative) then to the **Weapons** category.
3. From here, select a weapon, then click **Drop**.
4. Customize each item spawner by changing the **Time Before First Spawn** to **1.0 Second**.

   [![](https://dev.epicgames.com/community/api/documentation/image/353e46a1-3195-471b-91a9-3282ccbafee9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/353e46a1-3195-471b-91a9-3282ccbafee9?resizing_type=fit)

   One way to tell which options have been changed from the default values is to note which options have an **asterisk (\*)** at the beginning of the line.

   [![](https://dev.epicgames.com/community/api/documentation/image/0153e23e-a372-473b-a157-295c96d96a74?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0153e23e-a372-473b-a157-295c96d96a74?resizing_type=fit)

   Another way is to click the **Modified Options** tab.

### Add a Fang Vehicle Spawner

From the **Devices** tab in the **Creative Menu**, add a **Fang Spawner** device.

[![](https://dev.epicgames.com/community/api/documentation/image/0d2e8dab-ce41-452d-8ab8-fbc59a5cf6aa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d2e8dab-ce41-452d-8ab8-fbc59a5cf6aa?resizing_type=fit)

Use the default settings for this device.

### Customize the First Person Camera

1. Open the Customize panel for the First Person Camera device.
2. Scroll down the options until you find a setting called **Interaction Distance**.

[![](https://dev.epicgames.com/community/api/documentation/image/7cce3c6d-60a2-44a8-b2f1-be33c9ba1355?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7cce3c6d-60a2-44a8-b2f1-be33c9ba1355?resizing_type=fit)

This setting can be adjusted to change how close a player needs to be in first-person view to successfully interact with objects, weapons, and vehicles.

The option selected changes the player's view.

| option | how it appears |
| --- | --- |
| **Close** |  |
| **Standard** |  |
| **Far** |  |

Changing this setting changes the interaction distance quite a bit!

Experiment with this setting until you find what works for you.

### Design Tips

You've barely scratched the surface of what is possible with this exciting new device. Try using it in your own islands to create exciting new experiences for your players!

## Example 3: Build A Co-op Haunted House!

In this example, you will use the First Person Camera device to build a spooky haunted house for two players to explore in co-op gameplay.

Let's get started!

### Devices Used

- 1 x **First Person Camera** device
- 2 x **Player Spawner** devices
- Several [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) devices
- Several [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) devices
- Several [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative) devices
- 1 x [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative) device
- 1 x [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) device
- 1 x [End Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-end-game-devices-in-fortnite-creative) device
- 3 x **[Audio Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-fortnite-creative)** devices
- Several [Creature Placer](https://dev.epicgames.com/documentation/en-us/fortnite/using-creature-placer-devices-in-fortnite-creative) devices
- Several Chests
- Several [Customizable Light](https://dev.epicgames.com/documentation/en-us/fortnite/using-customizable-light-devices-in-fortnite-creative) devices

### Overview

1. Set up first-person gameplay.
2. Build the haunted house.
3. Add devices to create locked rooms.
4. Add spooky sound effects.
5. Add monsters.
6. Place chests in the treasure rooms.
7. Make everything look spooky!

### Set Up First-Person Gameplay

1. Place the **First Person Camera** device, then customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/41d3964b-622e-4bc4-b81c-005568422878?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41d3964b-622e-4bc4-b81c-005568422878?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Preview Device Color** | Yellow | Select this or another color you like. |

   A player can only use the first-person view when equipped with a weapon.
2. You can use a class designer to equip players with the correct assets for when they explore the haunted house. Place a **Class Designer** device and rename it **Class Treasure Hunter**.
3. Customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/ffc0fb5f-7d8b-431c-af1e-e0aa4ef89be7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ffc0fb5f-7d8b-431c-af1e-e0aa4ef89be7?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Class Identifier** | 1 | A unique identifier for this class. |
   | **Class Name** | Treasure Hunter | The name used throughout, including the modified name of the device itself. |
   | **Grant Items on Respawn** | Yes | If a player is eliminated, they will respawn with the same item granted. |
   | **Equip Granted Item** | First Item | Player is equipped with the first item registered to the device. |
4. Register the starting items for the class by dropping them onto the Class Designer device. This example uses the **Flashlight** found on the **Items** category under the **Content browser**, and the rare (blue) **Lever Action Shotgun**, found under **Weapons**.

   Drop these assets in the order above (Flashlight, then Lever Action Shotgun). If they aren't in that sequence, you can change the **Equip Granted Item** setting on the class identifier to select the Flashlight instead.
5. Add two **Player Spawner** devices to the island and set **Visible in Game** to **Off**.
6. Set the following events:

   [![](https://dev.epicgames.com/community/api/documentation/image/dc1a1f14-3cad-4dc2-a9a1-60f105124133?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc1a1f14-3cad-4dc2-a9a1-60f105124133?resizing_type=fit)

   When a player is spawned, an audio threat will play. As soon as the player is equipped with a weapon, the player will switch to first-person camera view.
7. Repeat these settings for the second player spawner.
8. Place a **Tracker** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/00600c80-3142-4789-9725-b10a2f800319?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00600c80-3142-4789-9725-b10a2f800319?resizing_type=fit)
9. Go to **Island Settings** and select **Mode**.
10. Under **Structure**, set **Max Players** to **2** and **Teams** to **Cooperative**.

    [![](https://dev.epicgames.com/community/api/documentation/image/e8d31271-9a3d-4aa1-8053-979d007ad8d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8d31271-9a3d-4aa1-8053-979d007ad8d3?resizing_type=fit)

### Build the Haunted House

Building the haunted house is easy, thanks to **[Prefabs and Galleries](https://dev.epicgames.com/documentation/en-us/fortnite/using-prefabs-and-galleries-in-fortnite-creative)**.

[![](https://dev.epicgames.com/community/api/documentation/image/b834db5b-3943-4391-b2dc-87cbafaaa218?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b834db5b-3943-4391-b2dc-87cbafaaa218?resizing_type=fit)

1. Go to **Creative Menu > Prefabs**. Type **haunted** in the search bar.
2. Pick a structure, then place it on your island. To follow this design example, use the **Haunted Overlook Castle** prefab.
3. You'll need to add some doors inside the castle so that you can lock them to create gameplay. Go to **Creative Menu > Galleries**, then search for **haunted** again.
4. Add the following galleries to your **quick bar**:

   - **Haunted Wall Gallery**
   - **Haunted Castle Interior Wall**
   - **Haunted Castle Broken Floor**

   [![](https://dev.epicgames.com/community/api/documentation/image/69706405-e0e1-4359-ba96-1a3cc61ff3f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69706405-e0e1-4359-ba96-1a3cc61ff3f2?resizing_type=fit)
5. Place these galleries on your island, but out of the way, so you can grab the pieces when you need them.
6. Pick a room inside the castle to use as an **objective** (a **treasure room**) for the players. (You'll eventually have several treasure rooms spread throughout the castle.)

   [![](https://dev.epicgames.com/community/api/documentation/image/8be3dbb9-9049-4542-b207-82b4c6213696?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8be3dbb9-9049-4542-b207-82b4c6213696?resizing_type=fit)

   *The little room in the tower off the balcony is a good place to start for setting up a player objective.*
7. To seal the room, select a wall piece with a door from the gallery pieces you equipped to your quick bar earlier.

   [![](https://dev.epicgames.com/community/api/documentation/image/dac7f1fb-4ae7-469b-8bd9-4b3c671b0369?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dac7f1fb-4ae7-469b-8bd9-4b3c671b0369?resizing_type=fit)
8. Copy the wall segment and drag it to where you need it.

   [![](https://dev.epicgames.com/community/api/documentation/image/527f6b82-9300-4635-bba5-ca5481764bcd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/527f6b82-9300-4635-bba5-ca5481764bcd?resizing_type=fit)

   It should snap directly into place in the prefab building, replacing the current doorframe with the closeable door.

   If you have any issues with placing the door piece where you want, see [Hotkeys and Keybinding Shortcuts](https://dev.epicgames.com/documentation/en-us/fortnite/hotkey-and-keybinding-shortcuts-in-fortnite-creative).

   [![](https://dev.epicgames.com/community/api/documentation/image/25899d22-214a-4beb-a421-03935c87830d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/25899d22-214a-4beb-a421-03935c87830d?resizing_type=fit)
9. Repeat this process to close off a few more castle rooms.
10. Take a few broken floor pieces from the galleries.

    [![](https://dev.epicgames.com/community/api/documentation/image/4c7d4576-9b81-4b26-868d-a2c7546f52b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c7d4576-9b81-4b26-868d-a2c7546f52b4?resizing_type=fit)
11. Add the boards to the attic floor so players can climb up into the attic from below.

    [![](https://dev.epicgames.com/community/api/documentation/image/f032b3b6-fb85-475a-9f9b-552c8a07fa0c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f032b3b6-fb85-475a-9f9b-552c8a07fa0c?resizing_type=fit)

### Add Locks and Conditional Buttons to the Treasure Room Doors

1. Place a **Lock** device on each door to your treasure rooms and give each one a descriptive name.

   Save steps by customizing one device, then copying and renaming the device to all the other locations where you will use it.

   [![](https://dev.epicgames.com/community/api/documentation/image/d862961f-ef86-4e25-87fa-56f25dd58987?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d862961f-ef86-4e25-87fa-56f25dd58987?resizing_type=fit)

   Make sure that the Lock device touches the door when you place it. The device will turn blue if it is registered correctly.
2. Set **Visible During Game** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/1d74ad61-7292-48e1-9d04-d67a98157813?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d74ad61-7292-48e1-9d04-d67a98157813?resizing_type=fit)
3. Add a **Conditional Button** device to each door and give it a descriptive name.
4. Customize it as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/5532ce2b-5767-4af8-9c5f-3384a6ac7aa7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5532ce2b-5767-4af8-9c5f-3384a6ac7aa7?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Display Main Icon** | Locked | This displays the icon that looks like a closed lock when the button is locked. |
   | **Use Alt Display Icon** | on | Makes it possible to use the Alt Display Icon when conditions change. |
   | **Alt Display Icon** | Unlocked | This switches the icon to an open lock when the button is unlocked. |
   | **Toggle Icon on Use** | On | Allows the device to toggle between main and alt icons based on user interaction. |
   | **Disable After Use** | On | Once activated, the device disables until triggered. |
   | **Show Key Item** | Key and Icon | This displays both the icon and the item that is registered as the key. |
5. Register a **Jewel** object by dropping it on the Conditional Button device. (You can find this llama-shaped Jewel under the **Items** category on the **Contents** tab.)

   [![](https://dev.epicgames.com/community/api/documentation/image/1058dc1e-750a-4ec4-9994-305759b8ecaa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1058dc1e-750a-4ec4-9994-305759b8ecaa?resizing_type=fit)
6. Copy the first Conditional Button device and place copies next to each locked treasure room in the haunted house.
7. Link the Conditional Button devices to the Lock devices on each of your treasure room doors by binding the conditional buttons with the locks:

   [![](https://dev.epicgames.com/community/api/documentation/image/a8aba538-31cd-466d-827b-7a4a33cc3aea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8aba538-31cd-466d-827b-7a4a33cc3aea?resizing_type=fit)
8. Hide a few Jewel objects in interesting places around the haunted house. At least one Jewel must be located outside of your locked treasure rooms.

### Add Spooky Sound Effects and Monsters

You can also use **Audio Player** devices and **Trigger** devices to add a spooky atmosphere to your haunted house.

1. Place three **Audio Player** devices on your island.
2. Name the first one **Audio Threat**, then customize it as shown.

   [![](https://dev.epicgames.com/community/api/documentation/image/1b9dbe4c-2236-4b11-9c3f-e869359f658d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b9dbe4c-2236-4b11-9c3f-e869359f658d?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Audio** | Threat | This is an ominous sound. |
   | **Volume** | 2.0 | Loud enough to impinge without overwhelming. |
   | **Play Location** | Registered Players | This plays the sound near the players. |
3. Name the second audio player **Audio Halloween Secret** then customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/0884d17c-e6e2-4b0e-a894-9bc80a5e20f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0884d17c-e6e2-4b0e-a894-9bc80a5e20f4?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Audio** | Halloween Secret | A different sound. |
   | **Volume** | 3.0 | This is slightly louder than the previous sound. |
   | **Can Be Heard By** | Instigator Only | Only the triggering player (the instigator) will hear the sound. |
   | **Play Location** | Instigating Player | Plays near the instigator. |
4. Name the third audio device **Halloween Ghosts** and customize it.

   [![](https://dev.epicgames.com/community/api/documentation/image/eb69082d-1818-453a-be80-852171065957?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb69082d-1818-453a-be80-852171065957?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Audio** | Halloween Ghosts | A different sound. |
   | **Can Be Heard By** | Instigator Only | Only the triggering player (the instigator) will hear the sound. |
   | **Play Location** | Instigating Player | Plays near the instigator. |
5. Add some **Trigger** devices in strategic places throughout the haunted house to play scary sound effects when the players walk over them.

   [![](https://dev.epicgames.com/community/api/documentation/image/2dc0a3b9-6ed6-47b8-b4a0-cd832cfd9895?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2dc0a3b9-6ed6-47b8-b4a0-cd832cfd9895?resizing_type=fit)

   *Place triggers in locations where you’d like to give the players a scare when they walk past.*
6. Give each trigger a descriptive name, and customize.

   [![](https://dev.epicgames.com/community/api/documentation/image/135df695-4fea-41fa-ad4e-74dcb995309d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/135df695-4fea-41fa-ad4e-74dcb995309d?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Visible in Game** | Off | The player won't see the device. |
   | **Triggered by Vehicles** | Off | Only players can trigger the device. |
   | **Triggered by Sequencers** | Off | Only players can trigger the device. |
   | **Triggered by Water** | Off | Only players can trigger the device. |
   | **Trigger VFX** | Off | Visual effects won't be triggered. |
   | **Trigger SFX** | Off | Sound effects won't be triggered. |
7. Bind the trigger to play Audio Halloween Ghosts when the trigger is activated.

   [![](https://dev.epicgames.com/community/api/documentation/image/0ef1fe72-4b6c-45d1-aa39-188b0c167112?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0ef1fe72-4b6c-45d1-aa39-188b0c167112?resizing_type=fit)
8. Set up the conditional buttons to give the players a scare when they open the door to a treasure room by binding events as shown below:

   [![](https://dev.epicgames.com/community/api/documentation/image/1a6db988-a753-454d-9095-4159d46564eb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1a6db988-a753-454d-9095-4159d46564eb?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Activated Send Event To** | Audio Halloween Secret | Play |
   | **On Activated Send Event To** | Audio Lock A2 | Toggle Opened |

### Add Monsters

You will also use the **Conditional Button** devices to add monsters in your treasure rooms.

1. Add a **Creature Placer** device in each sealed room. This example uses the **Major Ice Fiend** but you can choose any creatures that you want.
2. Customize the device.

   [![](https://dev.epicgames.com/community/api/documentation/image/8ffc4c09-b4b2-48cc-aca2-055b400e4a3e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ffc4c09-b4b2-48cc-aca2-055b400e4a3e?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Creature Type** | Major Ice Fiend | The creature used. |
   | **Activation Range** | 3.0 Tiles | How close the player needs to be to activate the spawner |
   | **Enable on Game Phase** | Never | The device should only activate when the player is near. |
   | **Despawn Type** | Distance to Spawner | The spawning is based on the player's proximity. |
   | **Despawn Range** | 4.0 Tiles | How great of a distance triggers the despawn. |
   | **Restore Player Shield on Elimination** | Off | The player's shield does not restore if the creature eliminates the player. |
3. Configure the creature placer to activate when the conditional button opens the treasure room door.

   [![](https://dev.epicgames.com/community/api/documentation/image/87b055e0-8fd5-4d32-916d-11379e295eab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87b055e0-8fd5-4d32-916d-11379e295eab?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Enable When Receiving From** | Conditional Button F | On Activated |
4. Repeat the binding for all Creature Placer devices with the associated Conditional Button devices for each room.

### Add Chests

Place a chest inside of each locked treasure room.

[![](https://dev.epicgames.com/community/api/documentation/image/d102dda5-526b-43f6-a6c4-990b4e5e9351?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d102dda5-526b-43f6-a6c4-990b4e5e9351?resizing_type=fit)

You might also want to add chests in other hidden places in the haunted house.

You can add items to a chest then place the chest from the Creative Menu.

### Make Things Look Spooky!

With a few final tweaks, you can transform the look of your island into a setting right out of your favorite scary movie!

Do this by adjusting some of the settings in the Island Settings menu.

1. Go to Island **Settings > World > Ambience** and make the following changes:

   [![](https://dev.epicgames.com/community/api/documentation/image/0454e2fe-2059-4d0c-9263-ee7fd1f30e33?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0454e2fe-2059-4d0c-9263-ee7fd1f30e33?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Time of Day** | 1:00 AM | This makes the island very dark. |
   | **Camera Filter** | Horror Movie | A filter that spooks things up. |
   | **Light Brightness** | 70 percent | Brings down the illumination on any added lights. |
   | **Light Color** | Blue | Blue adds a coldness to the scene. |
   | **Character Rimlight Intensity** | 0 | Rimlights (backlighting that creates a halo around an illuminated object) have no intensity. |
   | **Fog Thickness** | 50 percent | Covers the island in a fog. |
   | **Fog Color** | Black | Makes the fog even more ominous. |
2. To add even more spooky ambiance, place a **Customizable Light** device inside each treasure room, then customize.

   [![](https://dev.epicgames.com/community/api/documentation/image/d57dd0fc-b952-41eb-8b52-d1b8ab99ac91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d57dd0fc-b952-41eb-8b52-d1b8ab99ac91?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Light Intensity** | 30 percent | Brings down the intensity of the lights. |
   | **Light Reflection Intensity** | 80 percent | Brings down the intensity of the reflected light. |
   | **Light Size** | 40 percent | This restricts how far the light will cast. |
   | **Rhythm Preset** | Flicker | Provides a random flickering effect. |
   | **Cast Shadows** | Yes | The light will cast eerie shadows. Wooooohhhhh! |

These lights give your treasure rooms more visibility, and help lead players through the dark!

[![](https://dev.epicgames.com/community/api/documentation/image/5744117b-d670-4853-99fd-068631c02eb5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5744117b-d670-4853-99fd-068631c02eb5?resizing_type=fit)

### Design Tips

It took some work, but you've created a fun, spooky two-player cooperative adventure that anyone would be proud to share.

Try adding different creatures in the spawners in your treasure rooms, or even adding more buildings for players to explore in the dark with their flashlights!
