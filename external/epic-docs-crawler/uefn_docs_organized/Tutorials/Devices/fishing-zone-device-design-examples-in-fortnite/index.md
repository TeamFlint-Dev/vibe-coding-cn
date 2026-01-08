# Fishing Zone Device Design Examples

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/fishing-zone-device-design-examples-in-fortnite>
> **爬取时间**: 2025-12-26T23:05:16.690722

---

You can use the **Fishing Zone** device to build games and mini-games within larger games.

## Basic Fishing Mechanic

The basic Fishing Zone mechanic is simple. All you need is a body of water, a Fishing Zone in the water, and some fishing rods!

### Devices Used

- 1 x [Fishing Zone](https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-zone-devices-in-fortnite-creative) device
- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [Fishing Rod Barrel](https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-rod-barrel-devices-in-fortnite-creative) device

### Set Up the Devices

1. Choose a starting island with natural lakes or other bodies of water.
2. Place a **Player Spawner** device near a body of water.
3. Place a **Fishing Rod Barrel** device.
4. Place a **Fishing Zone** device connected to an area in the water.
5. Customize the **Fishing Zone** as follows:

   [![](https://dev.epicgames.com/community/api/documentation/image/30a2e343-20c3-4897-90e2-5d6d969920ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30a2e343-20c3-4897-90e2-5d6d969920ea?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Pool Type | Fish Only |

You now have the basic functionality for a fishing mechanic!

### Design Tip

The Fishing Zone can be used to give the player anything, not just fish. The **Pool Type** setting allows you to change what the player can fish out. The default setting, Battle Royale, uses the default loot pool, which can be a great place to start.

## Special Item Fishing

Using the Fishing Zone device, you can give players an engaging way to discover a new item or weapon. Using this device with the **Water** device, you’ll set up a unique weapon discovery encounter!

### Devices Used

- 1 x Fishing Zone device
- 1 x [Water](https://dev.epicgames.com/documentation/en-us/fortnite/using-water-devices-in-fortnite-creative) device
- 1 x [Fishing Rod Barrel](https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-rod-barrel-devices-in-fortnite-creative) device
- 1 x Player Spawner device

### Set Up the Devices

1. Create a small above-ground pool using rocks from the **Tropical Rock Gallery**.
2. Place a **Water** device in the middle of the pool. Adjust the bounds of the Water device and the position of the rocks to make it look like the water is contained within the rock formation.
3. Customize the Water device:

   [![](https://dev.epicgames.com/community/api/documentation/image/86e383b5-ebc5-460d-a066-b45116476570?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86e383b5-ebc5-460d-a066-b45116476570?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Zone Width | 2.75 |
   | Zone Depth | 2.0 |
   | Zone Height | 0.5 |
   | Vertical Emptying Speed (T PM) | 10.0 |
   | Water Type | Red River Styx |

4. Place a **Fishing Zone** device above the Water device, ensuring that the devices overlap. Register a **Legendary Primal Pistol** to the device.
5. Customize the Fishing Zone:

   [![](https://dev.epicgames.com/community/api/documentation/image/479f0629-5e1e-4410-a4fe-b04b0d1ee468?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/479f0629-5e1e-4410-a4fe-b04b0d1ee468?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Usage Type | Limited | The device can only be used once. |
   | Pool Type | Device Inventory |  |
   | Disable when Empty | On |  |

6. Place a Fishing Rod Barrel device near the pool.
7. Place a Player Spawner device away from the pool.

### Bind Functions / Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#directeventbinding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) and [events](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) for the devices involved.

Configure the following event on the Fishing Zone so that when the device is caught, the Water empties from the pool.

[![](https://dev.epicgames.com/community/api/documentation/image/8a902e64-abd2-44ba-9c9a-5927e2cb568b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a902e64-abd2-44ba-9c9a-5927e2cb568b?resizing_type=fit)

| Event | Select Device | Select Function |
| --- | --- | --- |
| On Caught | Water | Start Vertical Emptying |

You now have the basic functionality for a unique way to discover items!

### Design Tip

The Fishing Zone can send events when a fish is caught, allowing you to connect all sorts of devices to a successful catch! You could give players upgrades, reward them with new resources, spawn vehicles, trigger VFX, and much more when a player catches a fish!

## Build a Fishing Game

Using the Fishing Zone device, you’ll now create a fully functioning fishing game, complete with five types of fish. You'll also set up a way to sell catches and buy an upgrade!

### Devices Used

- 1 x Fishing Zone device
- 1 x Player Spawner device
- 6 x Item Granter devices
- 1 x [Beacon](https://dev.epicgames.com/documentation/en-us/fortnite/using-beacon-devices-in-fortnite-creative) device
- 5 x [Conditional Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-conditional-button-devices-in-fortnite-creative) devices
- 5 x [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative) devices
- 1 x [Vending Machine](https://dev.epicgames.com/documentation/en-us/fortnite/using-vending-machine-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Begin with the Mountain Ridge Island starter island.
2. On the small island in the large lake, place a Player Spawner device.
3. Customize the Player Spawner so it is not visible in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/29c72341-834e-4fc9-b317-e19a39304792?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/29c72341-834e-4fc9-b317-e19a39304792?resizing_type=fit)
4. Place an **Item Granter** device and register a **Creative Fishing Rod** to the device.
5. Customize the Item Granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/64348cec-3be0-4c8e-ba6a-a2c59836264e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/64348cec-3be0-4c8e-ba6a-a2c59836264e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Receiving Players | All |
   | Grant on Game Start | On |

6. Place a **Fishing Zone** device in the lake. Register a **Small Fry**, **Flopper**, **Stink Fish**, **Cuddle Fish**, and **Thermal Fish**.
7. Customize the Fishing Zone **Pool Type** for **Device Inventory**:

   [![](https://dev.epicgames.com/community/api/documentation/image/f2a4b7a6-7143-43cd-8351-2e1bb86fbf5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2a4b7a6-7143-43cd-8351-2e1bb86fbf5b?resizing_type=fit)

   Using the **Device Inventory** setting and manually selecting the fish that you want the player to fish for gives more control over the game. You could also use the **Fish Only** setting, but it wouldn't have the same variety of fish.
8. Place a Beacon device on the water’s surface in the middle of the Fishing Zone to make sure the player always knows where to fish.
9. Customize the Beacon:

   [![](https://dev.epicgames.com/community/api/documentation/image/2b58cf25-da0b-4123-9f5d-cb52b0fe505c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b58cf25-da0b-4123-9f5d-cb52b0fe505c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Beacon To Show | Badge |
   | Custom Beacon Color | #3500FF |
   | Badge Uses Beacon Color | On |
   | Icon Identifier | Fish |
   | Hide HUD Icon At | 300M |

### Set Up the Market

1. Place a few walls from the **Pirate Cove Gallery** on the small island.
2. Place a **Conditional Button** device a wall and register a **Small Fry** to the device.
3. Place an **Item Granter** device and register a **Gold** to the device.
4. Customize the Item Granter for **On Grant Action** to **Keep All**:

   [![](https://dev.epicgames.com/community/api/documentation/image/95200275-f1d9-48a1-ba24-7e3323ed5880?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95200275-f1d9-48a1-ba24-7e3323ed5880?resizing_type=fit)
5. You’ll now spruce up the effect of selling a fish! Place a **VFX Spawner** in front of the Conditional Button.
6. Customize the VFX Spawner:

   [![](https://dev.epicgames.com/community/api/documentation/image/06356868-26f4-45d5-9014-22152f71c960?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06356868-26f4-45d5-9014-22152f71c960?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Effect Type | Burst |
   | Burst Visual Effect | Splash Small |

7. Configure the following events on the Conditional Button to trigger the VFX and give the player Gold when they sell a fish.

   [![](https://dev.epicgames.com/community/api/documentation/image/21a71d0d-e243-4445-b9e6-29dc662132bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21a71d0d-e243-4445-b9e6-29dc662132bb?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Activated | VFX Spawner 1 | Restart |
   | On Activated | Small Fry Item Granter | Grant Item |

8. **Duplicate** this trio of devices **four times**. Configure them to sell **Floppers** for **3 Gold**, **Stink Fish** for **8 Gold**, **Cuddle Fish** for **15 Gold**, and **Thermal Fish** for **50 Gold** by changing the registered fish in the Conditional Buttons and the number of Gold registered in the Item Granters.
9. Next to the tree, place a **Vending Machine** device and register a **Creative Pro Fishing Rod**.
10. Customize the Vending Machine:

    [![](https://dev.epicgames.com/community/api/documentation/image/0938143d-3905-4ff2-bb08-d8a7068d02c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0938143d-3905-4ff2-bb08-d8a7068d02c4?resizing_type=fit)

    | Option | Value |
    | --- | --- |
    | First Item Resource Type | Gold |
    | Cost of First Item | 50 |
    | Model | Screen Only |

Use Billboard devices to label the different buttons so that the player knows how much they can sell their fish for!

### Modify Island Settings

Make the following modifications to the island settings.

1. Go to **Island Settings > Player**.
2. Under **Inventory**, change **Infinite Building Materials** to **Off**.

   [![](https://dev.epicgames.com/community/api/documentation/image/369ba79a-924a-4934-9dc5-04d5ff83bdba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/369ba79a-924a-4934-9dc5-04d5ff83bdba?resizing_type=fit)
3. Go to **Island Settings > User Interface**.
4. Under HUD, change Show Gold Resource Count to Yes.

   [![](https://dev.epicgames.com/community/api/documentation/image/267d3a84-dab4-4cb0-a191-3834a9ad33d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/267d3a84-dab4-4cb0-a191-3834a9ad33d9?resizing_type=fit)

You now have a working fishing game using the Fishing Zone device!

### Design Tip

One way to add more complexity to a fishing game is by combining the Fishing Zone with the Skilled Interaction device. Use them together to create a more engaging mini-game. Make sure the Fishing Zone is set to only trigger another device, then connect Item Granters to the different events on the Skilled Interaction Device to give the player fish when they succeed! See this in action in the [Skilled Interaction Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/skilled-interaction-device-design-examples)!Place a **Fishing Zone** device above the Water device, ensuring that the devices overlap. Register a **Legendary Primal Pistol** to the device.Customize the Beacon:
