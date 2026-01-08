# Campfire Device Design Example

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/campfire-device-design-example-in-fortnite-creative>
> **爬取时间**: 2025-12-26T23:06:33.533594

---

The **Campfire** device makes an interesting addition to any island. You can use it to heal players, and you can even set it up to require additional wood to keep it burning.

In this example, you'll use the Campfire device to create a puzzle mini-game that players can use to open a secret room they can then explore.

Initially, the room will be underwater, but when a player lights the campfire, the water will drain out and they can access the hidden room!

## Devices Used

- 1 x [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative) device
- 1 x [**Campfire**](using-campfire-devices-in-fortnite-creative) device
- 1 x [Water](https://dev.epicgames.com/documentation/en-us/fortnite/using-water-devices-in-fortnite-creative) device

## Build Your Own

Start by constructing the secret area for players to discover, then add water and a campfire to complete the puzzle.

In this design example, the geometry is kept very simple to demonstrate the game mechanics, but feel free to add more environmental elements to make it visually exciting!

### Construct the Play Area

1. Make the secret area that you want your players to discover.

   [![](https://dev.epicgames.com/community/api/documentation/image/fb5c31c7-5fa2-430a-9fe7-6720130a1cc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb5c31c7-5fa2-430a-9fe7-6720130a1cc0?resizing_type=fit)

   Environmental puzzles like this work best if a player can see where they need to go, but have to figure out how to get there.
2. Place a water device in the center of the puzzle play space, and adjust the settings so the passage to the secret area is submerged.

   [![](https://dev.epicgames.com/community/api/documentation/image/f9543744-4c89-45cb-bae2-ab6f7106212d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f9543744-4c89-45cb-bae2-ab6f7106212d?resizing_type=fit)
3. Customize the water settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/ad481f83-1be9-4c55-9ab6-5ceef32b5f9f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad481f83-1be9-4c55-9ab6-5ceef32b5f9f?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Zone Width** | 4.0 | You're setting the basic dimensions based on grid counts. This and the depth provides enough of an area to build a fun course. |
   | **Zone Depth** | 6.5 | See Zone Width. |
   | **Zone Height** | 2.5 | This is how deep the water volume is. |
   | **Vertical Filling Speed (T PM)** | 30.0 | The speed, based on tiles per minute (T PM) the water volume will fill up when triggered. |
   | **Vertical Emptying Speed (T PM)** | 30.0 | How quickly the water will drain when triggered. |

### Add a Campfire Device and Bind to Water

1. Place a **Campfire** device near your water puzzle.

   [![](https://dev.epicgames.com/community/api/documentation/image/84b5ad62-8ce1-417d-9f0b-331efc414753?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84b5ad62-8ce1-417d-9f0b-331efc414753?resizing_type=fit)
2. Direct event binding is how you can set triggers between devices. Bind the Campfire device to the water volume with these events:

   [![](https://dev.epicgames.com/community/api/documentation/image/bb923557-1e5d-4ba9-ace5-aad61c1f6ff2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb923557-1e5d-4ba9-ace5-aad61c1f6ff2?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Lit Send Event To** | Water | Start Vertical Emptying |
   | **On Extinguished Send Event To** | Water | Start Vertical Filling |

   The events you bind here will show up automatically as functions on the Water device.

   [![](https://dev.epicgames.com/community/api/documentation/image/b9064447-2f43-4f8d-b0b6-76a7b6c34bf8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9064447-2f43-4f8d-b0b6-76a7b6c34bf8?resizing_type=fit)

And just like that, you have a secret room underwater that players can see but can’t reach until they solve the puzzle by lighting the Campfire device.

## Design Tip

To make the puzzle more interesting visually, use rocks and trees to build your island geometry instead of primitive shapes.

Adjust the settings on the Campfire device so that it uses fuel to stay lit, then place wood collectibles nearby to make the puzzle even more challenging to solve!
