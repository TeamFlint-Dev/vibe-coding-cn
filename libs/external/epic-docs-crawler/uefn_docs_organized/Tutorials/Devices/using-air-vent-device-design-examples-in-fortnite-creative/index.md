# Air Vent Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-air-vent-device-design-examples-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:05:22.632704

---

The **Air Vent** device tosses players or vehicles into the air, adding a whole new dimension to to gameplay. Keep going for a couple of examples of how you can use this device:

- [Bounce for Points Mini-Game](https://dev.epicgames.com/documentation/en-us/fortnite/using-air-vent-device-design-examples-in-fortnite-creative)
- [Vehicle Big Air Competition](https://dev.epicgames.com/documentation/en-us/fortnite/using-air-vent-device-design-examples-in-fortnite-creative)

## Bounce for Points Mini-Game

The goal in this mini-game is for players to earn as many points as possible before time runs out by grabbing the collectible objects that appear in the play space.
Varying settings on the air vents, along with unexpected placements, will pack the game with entertaining surprises.

### Devices Used

You will need the following devices:

- 8 x [Player Spawner devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)
- 13 x **Air Vent** devices
- 3 x [**Collectible Object** devices](using-collectible-object-devices-in-fortnite-creative)
- 3 x [Timer devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative)\*

### Build It Yourself

Start by building a simple arena that includes:

- A ground area where you can place Air Vent devices.
- An elevated area surrounding the ground area where players can spawn in. This encourages them to literally jump into the game.
- Angled areas under the spawning points where you can place additional air vents. This makes their start a little more fun!

[![Start with a simple arena.](https://dev.epicgames.com/community/api/documentation/image/6bffedb7-c939-43ec-8789-02b763e6cff9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6bffedb7-c939-43ec-8789-02b763e6cff9?resizing_type=fit)

### Add Air Vents

1. Place one set of **Air Vent devices** on the ground.
2. Place more air vents at angles under the player spawners, and at angles relative to the base of the arena, and under where the spawners will go.

You can use the default values for the air vents, or you can adjust movement settings, such as **Knockup Force Multiplier**, to add more variety or make the higher value coins more challenging to reach.

[![Vary settings from air vent to air vent.](https://dev.epicgames.com/community/api/documentation/image/d2a3a39e-8464-4022-af41-fa7019292858?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d2a3a39e-8464-4022-af41-fa7019292858?resizing_type=fit)

### Add Player Spawners

Place **Player Spawner** devices above the arena. There are eight player spawners in this example. Use enough spawners to accommodate the number of players you want to support.

### Add Collectible Objects

This example uses three **Collectible Object** devices — a Bronze Coin, a Silver Coin, and a Gold Coin — with higher points awarded for each coin type. The objects are suspended above the air vents so that players have to use the vent boosts to reach them.

Play with the points awarded from each device to get the results you like!

You will also use three **Timer** devices later, and bind each collectible to a separate timer.

1. Place the first collectible coin above the vent arena and select the coin in the **Collectible Object** option in the Customize panel.
2. Set the **Score** value for that coin.

   [![Set the Score option to the value you want for the coin.](https://dev.epicgames.com/community/api/documentation/image/a3d02730-8db8-4c9d-90d4-2065f424169b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3d02730-8db8-4c9d-90d4-2065f424169b?resizing_type=fit)

   Rename the collectible object in the Customize panel for easier binding later. For example, you could name one "Bronze Coin", one "Silver Coin", and the third "Gold Coin."
3. Repeat for the Bronze and Gold coins, and set the Score value for each.

### Add Timers

1. Add a **Timer** device, and give it a name the same way you named the collective object (coins) devices. In this example, the silver coin's timer is named "Timer Silver Coin." This will make it easier to bind the timers to the collectible objects.
2. Set the **Duration** option for the Silver Coin to **5 seconds**.

   [![Set the Duration option to 5 seconds.](https://dev.epicgames.com/community/api/documentation/image/7e1e1342-83b6-4b42-9ad6-07a4f2ceba28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e1e1342-83b6-4b42-9ad6-07a4f2ceba28?resizing_type=fit)
3. Add two more timers to go with the Bronze and Gold coins. Rename them as you did with the first timer, and set the **Duration** option for both to **5 seconds**.

   [![You will end up with three timers to go with the three coins.](https://dev.epicgames.com/community/api/documentation/image/273bd6b1-4a32-4ef8-8c0c-00daeb78b6fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/273bd6b1-4a32-4ef8-8c0c-00daeb78b6fd?resizing_type=fit)

### Bind Timers and Coins

Each collectible object is linked to its own timer, which is set to start a countdown when the object is collected. When the timer completes the countdown, it sends an event back to the Collectible Object device telling it to respawn the coin.

To make the play more challenging, you can vary the respawn time for different coins, with longer respawns on the higher-value coins. This encourages players to go for lower-value objectives while they wait for the bigger prizes to respawn!

You will need to [bind](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-direct-event-binding-in-fortnite-creative) each coin device to a timer, then bind the timers to the coins.

1. For the silver coin collectible object, set up the following **Function** binding.

   [![Respawn for All When Receiving From function](https://dev.epicgames.com/community/api/documentation/image/b23dac2e-2b06-4f6c-971f-73499ec52d5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b23dac2e-2b06-4f6c-971f-73499ec52d5b?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | Respawn for All When Receiving From | Timer Silver Coin | On Success |
2. Then set up the following **Event** binding on the silver coin collectible object.

   [![On Collected Send Event To event](https://dev.epicgames.com/community/api/documentation/image/c7c5ea5b-a9f1-4c44-aa61-0df5b3a059bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7c5ea5b-a9f1-4c44-aa61-0df5b3a059bb?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Collected Send Event To | Timer Silver Coin | Start When Receiving From |
3. For the silver coin's timer, set the following **Function** binding.

   [![Start When Receiving From function](https://dev.epicgames.com/community/api/documentation/image/e25f6b39-52f8-4f89-96a0-652693745a85?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e25f6b39-52f8-4f89-96a0-652693745a85?resizing_type=fit)

   | Function | Select Device | Select Event |
   | --- | --- | --- |
   | **Start When Receiving From** | Collectible Silver Coin | On Collected |
4. Then set the silver coin's timer for the following **Event** binding.

   [![On Success Send Event To](https://dev.epicgames.com/community/api/documentation/image/48c1a666-2297-4557-87dd-5eb73105490d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48c1a666-2297-4557-87dd-5eb73105490d?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | **On Success Send Event To** | Collectible Silver Coin | Respawn |
5. Repeat these steps for the Bronze and Gold coins.

### Modify Island Settings

The last step is to modify the [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/understanding-island-settings-in-fortnite-creative).

1. Go to the **Islands Settings** tab.
2. Select the **Round** category, then the **End Condition** subcategory.
3. Set the **Time Limit** setting to **2 minutes**.

   [![Location of the Time Limit setting](https://dev.epicgames.com/community/api/documentation/image/11fe5894-9b3c-42b0-abd1-dcee2e182999?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/11fe5894-9b3c-42b0-abd1-dcee2e182999?resizing_type=fit)
4. Select the **Mode** category, then the **Victory Condition** subcategory.
5. Set the **Game Win Condition** setting to **Most Score Wins**. The player with the highest score wins the game.

   [![Location of the Game Win Condition setting](https://dev.epicgames.com/community/api/documentation/image/cc1320f3-fb8f-4f03-aed3-7d4530391534?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cc1320f3-fb8f-4f03-aed3-7d4530391534?resizing_type=fit)
6. Select the **User Interface** category, then the **Scoreboard** subcategory.
7. Set the **First Scoreboard Column** setting to **Score**. This shows players their scores in the first column of the Scoreboard.

   [![](https://dev.epicgames.com/community/api/documentation/image/35d1ba0d-e692-483d-b865-0e278df0fde3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35d1ba0d-e692-483d-b865-0e278df0fde3?resizing_type=fit)

You've created the basic functionality for a mini-game based on the Air Vent device!

Try changing the Island Settings to customize how your mini-game plays, or experiment with adding weapons for even more fun!

## Vehicle Big Air Competition

An Air Vent device can also be used to **catapult vehicles** high into the air!

This mini-game example shows how you can use an air vent in combination with a few simple island settings to create a vehicle-jumping mini-game of your own. Create a dedicated vehicle-jumping game, or include these mechanics in your other island designs.

### Construct a Vehicle Jump

In this example, an Air Vent device is embedded into the ground so that vehicles can easily drive over it.

[![Set the air vent into the ground or road.](https://dev.epicgames.com/community/api/documentation/image/f3bc2303-ace4-4f55-a277-6a6dde2df38b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3bc2303-ace4-4f55-a277-6a6dde2df38b?resizing_type=fit)

### Modify Island Settings

1. Go to **Island Settings > Mode > Victory Condition** and change **Game Win Condition** to **Most Score Wins**.
2. Go to **Round > End Condition**, and set **Time Limit** to whatever you choose.

With this simple setup, you can pull off aerial tricks with a surprising number of vehicles. Try using different vehicle types to see what kinds of tricks your players can potentially do!
