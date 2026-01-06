# Boat Spawner Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/boat-spawner-device-design-examples
> **爬取时间**: 2025-12-26T23:07:27.525414

---

Water is a fun addition to any Fortnite island, and in this design example, you’ll learn how to build a unique fishing mini-game mode featuring the Boat Spawner.

Let’s dive right in!

## Fishing Competition

## Devices Used

- 2 x [Player Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 8 x [Fishing Zone devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-zone-devices-in-fortnite-creative)
- 1 x [Water device](https://dev.epicgames.com/documentation/en-us/fortnite/using-water-devices-in-fortnite-creative)
- 2 x [Boat Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-boat-spawner-devices-in-fortnite-creative)
- 2 x [Fishing Rod Barrel devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-rod-barrel-devices-in-fortnite-creative)
- 10 x [Capture Area devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-capture-area-devices-in-fortnite-creative)

### Construct the Play Area

1. Add two docks, one on either side of the play area, for players to start on.
2. In a 30 x 30 grid space, place a few large obstacles.

[![A simple play area for your fishing minigame complete with a dock on either side to be used by each team.](https://dev.epicgames.com/community/api/documentation/image/4ecd6140-893c-4a6e-b155-2a077cf16f91?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ecd6140-893c-4a6e-b155-2a077cf16f91?resizing_type=fit)

A simple play area for your fishing minigame complete with a dock on either side to be used by each team.

### Add Player Spawner Devices to Your Docks

1. Add a Player Spawner device to the first pier, and configure it for Team 1:

   [![](https://dev.epicgames.com/community/api/documentation/image/92010456-1aa6-4669-8d8b-a288604c05e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92010456-1aa6-4669-8d8b-a288604c05e6?resizing_type=fit)
2. Copy and place the spawner on the second dock, then configure it for Team 2.

You can confirm you’ve assigned the team you want to the spawner by checking the device model.

It’ll proudly display the team number, what a pose!

[![](https://dev.epicgames.com/community/api/documentation/image/7aac111c-e07c-4443-891a-81732a2928cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7aac111c-e07c-4443-891a-81732a2928cb?resizing_type=fit)

### Add Fishing Zones

In this example, you are using the **Small Fry fish**, the **Shield Fish**, the **Slurpfish**, the **Cuddle Fish**, and the **Stink Fish**.

1. Start by adding a single Fishing Zone device to your island.
2. Customize the Inventory of the device by manually registering five types of fish to the zone. To register custom items to a device:

   1. Add the item to your inventory.
   2. Move to be in close proximity to the device you want to register custom loot to.
   3. Drop the desired item close to the device.

   When successful, you'll see a small hologram of the custom loot projected above the device.
3. For more information about how to add custom loot to a device, see [[Item Granter Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)].
4. Customize your Fishing Zone device with the following settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/e6404f62-4069-46c9-a985-6ac446185c73?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6404f62-4069-46c9-a985-6ac446185c73?resizing_type=fit)

Once the Fishing Zone device has been customized, copy and paste it around the play area in interesting spots to fish.

Make sure that the Drops options is set to On when you place your Fishing zone devices, and that they aren't sticking in the ground.

[![](https://dev.epicgames.com/community/api/documentation/image/667c9c2e-0aa3-4f8c-b200-27b057d26ae6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/667c9c2e-0aa3-4f8c-b200-27b057d26ae6?resizing_type=fit)

### Add Water to Your Play Area

You can find the Water devices in the devices tab.

Grab the Water device and place it in the center of the play area.

Make sure that the Drops option is set to On when you place your Water device, and make sure that it isn’t sticking in the ground of your island. Make sure that the Drops options is set to On when you place your Water device, and that it isn't sticking in the ground.

Next, customize the size settings of the Water device so that the width and depth cover the entire play area and the tops of your Fishing Zone devices are above the waterline.

### Add Boats and Fishing Poles to Your Play Area

1. Add a Boat Spawner device by each dock.
2. Add your Fishing Pole Barrel devices to the island.
3. Configure your Boat Spawner device with the following settings:

   [![](https://dev.epicgames.com/community/api/documentation/image/7441ec42-b2b5-4932-8814-2711ad95c16d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7441ec42-b2b5-4932-8814-2711ad95c16d?resizing_type=fit)

You could place them on landmarks dotted around your play area or on the starting docks, it’s up to you!

### Add Capture Area Devices for Scoring

This fishing mini-game will award points when players return the fish they have caught back to the capture areas on the dock.

To do this, you'll need to place the capture areas, register the different types of fish, and set how many points they award.

1. Start by placing a new Capture Area device on one of your docks.
2. Register it with the Small Fry consumable fish by manually registering the consumable. To register custom items to a device:

   1. Add the item to your inventory.
   2. Move close to the device you want to register custom loot to.
   3. Drop the desired item close to the device.

   When successful, you’ll see a small hologram of the custom loot projected above the device.
3. For more information about how to add custom loot to a device, see [[Item Granter Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)].
4. Configure the Capture Area:

   [![](https://dev.epicgames.com/community/api/documentation/image/4a348d02-5034-4926-92dc-eb88ccd37f0c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4a348d02-5034-4926-92dc-eb88ccd37f0c?resizing_type=fit)

Once you’ve completed the steps above, your Capture Area will look like this:

[![](https://dev.epicgames.com/community/api/documentation/image/e61af301-8234-4971-9628-f0234b120f8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e61af301-8234-4971-9628-f0234b120f8c?resizing_type=fit)

From there, repeat those steps for each of the other types of consumable fish in your Fishing Zones.

For this example, you’ll set the scores like so:

- Small Fry - 1 point.
- Stink Fish - 2 points.
- Shield Fish - 3 points.
- Cuddle Fish - 4 points.
- Slurp Fish - 5 points!

Now you’ve set up a basic point curve where the rarer the fish, the greater the point value. Simple as that. You’ve got to make sure to reward patient little loot goblins who hold out for the rarer catch!

The final layout of the Capture Zones on the dock should look something like this:

[![](https://dev.epicgames.com/community/api/documentation/image/9460609b-2d3f-4cfa-bbc8-c464bd2805b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9460609b-2d3f-4cfa-bbc8-c464bd2805b4?resizing_type=fit)

Once you have your Capture Areas set up, you can select them all at once and simply copy them to the dock on the other side of the play area.

To help keep the sides of the play space distinct, you can change the color of the Capture Area devices, but functionally there's no difference to the players.

They can turn their fish in anywhere they want!

### Configure the Island Settings

Your fishing mini-game mode will be based on total score with a short time limit. The player who catches and delivers the highest scoring loads of fish before time runs out wins.

Use the following Island Settings:

1. Mode Settings:

   Set the Max Players to 2.

   [![](https://dev.epicgames.com/community/api/documentation/image/8ef9686f-9c6e-431c-ba61-f9935a38e56c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ef9686f-9c6e-431c-ba61-f9935a38e56c?resizing_type=fit)
2. Round End Condition Settings:

   Increase the Time Limit to 10 minutes.

   [![](https://dev.epicgames.com/community/api/documentation/image/9e2d378b-9633-428a-a206-4ba8fca9d8b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e2d378b-9633-428a-a206-4ba8fca9d8b2?resizing_type=fit)
3. Round Victory Condition Settings:

   Set the Round Win Condition to Score.

   [![](https://dev.epicgames.com/community/api/documentation/image/cf39bea3-e233-47a2-a601-37aebef590d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf39bea3-e233-47a2-a601-37aebef590d2?resizing_type=fit)
4. User Interface Settings:

   Set the HUD Info Type to SCORE.

   [![](https://dev.epicgames.com/community/api/documentation/image/17d6f1ef-3de6-4310-a796-b6cb2b3a9d22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17d6f1ef-3de6-4310-a796-b6cb2b3a9d22?resizing_type=fit)

## Next Steps

Now you’ve created your own fishing mini game mode featuring the Boat Spawner device, learned how to configure devices that grant items to players, and also collect them from players. To expand on this mini game, try setting the same game up on a map with multiple islands, add more vehicles — make an entire fishing wars island for yourself complete with teams, the sky's the limit!
