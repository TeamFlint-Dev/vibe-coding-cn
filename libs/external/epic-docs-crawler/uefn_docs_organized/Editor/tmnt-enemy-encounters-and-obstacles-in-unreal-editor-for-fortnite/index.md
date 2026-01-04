# TMNT Enemy Encounters and Obstacles

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-enemy-encounters-and-obstacles-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:08:42.632877

---

Enemy encounters are the cornerstone of arcade beat-em-ups, letting players fine-tune their fighting skills, rack up high scores and try not to get hit as they complete levels. This page will explain the set up used in the TMNT Arcade template for all three enemy encounters, and give you tips on setting up your own!

You will also learn more about setting up environmental hazards – elements that add challenge to a level.

## First Encounter

**Devices used:**

- **1 x [Trigger device](https://dev.epicgames.com/documentation/fortnite-creative/using-trigger-devices-in-fortnite-creative)**
- **1 x [Checkpoint device](https://dev.epicgames.com/documentation/fortnite-creative/using-player-checkpoint-pad-devices-in-fortnite-creative)**
- **1 x [Fixed Point Camera device](https://dev.epicgames.com/documentation/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative)**
- **2 x [Barrier device](https://dev.epicgames.com/documentation/fortnite-creative/using-barrier-devices-in-fortnite-creative)**
- **3 x [TMNT Character Spawner device](https://dev.epicgames.com/documentation/fortnite-creative/using-character-devices-in-fortnite-creative)**
- **1 x [Tracker device](https://dev.epicgames.com/documentation/fortnite-creative/using-tracker-devices-in-fortnite-creative)**
- **1 x [Prop Manipulator device](https://dev.epicgames.com/documentation/fortnite-creative/using-prop-manipulator-devices-in-fortnite-creative)**

When a player steps on the **Trigger** device, many things are set in motion:

1. The player is assigned to the **Fixed Point Camera**.
2. The **Barrier** devices prevent the player from exiting the specified arena.
3. The **Checkpoint** device activates, ensuring that the player respawns inside the arena if they are eliminated.
4. The three Foot Elite are spawned using the **TMNT Character Spawner**.

The player now has to face off against the foes using their weapon of choice.

During this encounter, the Tracker device monitors eliminations from all three TMNT Character Spawners. Once all three Foot Elite are eliminated, the Tracker sends the following events:

[![Tracked eliminations](https://dev.epicgames.com/community/api/documentation/image/f98f8e38-c080-4c1d-b42e-1eddbb226191?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f98f8e38-c080-4c1d-b42e-1eddbb226191?resizing_type=fit)

1. Drop the right **Barrier.**
2. Assign the player to the next **Fixed Angle Camera.**
3. Activate a Pizza supply drop.
4. Tell the **Prop Manipulator** to show the arrow that tells them to advance!

   [![Tracker Events](https://dev.epicgames.com/community/api/documentation/image/9cebd6e4-1208-4493-9fa0-7daa3ad77275?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9cebd6e4-1208-4493-9fa0-7daa3ad77275?resizing_type=fit)

## Environment Hazards

**Devices used:**

- **multiple x [Damage Volume device](https://dev.epicgames.com/documentation/fortnite-creative/using-damage-volume-devices-in-fortnite-creative)**
- **multiple x [VFX Spawner device](https://dev.epicgames.com/documentation/fortnite-creative/using-vfx-spawner-devices-in-fortnite-creative)**

Once the player deals with the Foot Elite, they are rewarded with a Pizza supply drop that can replenish their health and shields. They will need it, as they’re about to come up against the first environment hazard in the level.

Once the player arrives in the sewers, their first obstacle is a broken pipe that shoots out hot steam.

[![Pipe Damage Volume](https://dev.epicgames.com/community/api/documentation/image/fecb20f8-c5b5-4661-9a28-5f65deb93866?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fecb20f8-c5b5-4661-9a28-5f65deb93866?resizing_type=fit)

The steam uses a VFX Spawner device with custom particle VFX, and a Damage Volume that does 25 damage at a tick rate of 2 seconds. This means every 2 seconds the player stands in the Damage Volume, they will take 25 damage.

All VFX used in this template are available to you in the template’s VFX folder!

[![VFX folder](https://dev.epicgames.com/community/api/documentation/image/8408b1ee-0082-42fb-9845-6a8fe5eeae64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8408b1ee-0082-42fb-9845-6a8fe5eeae64?resizing_type=fit)

Further in the level, a broken walkway requires the player to double-jump across the sewage water, or fall to their death if they touch the water. This is achieved by creating a gap in the floor, and placing a Damage Volume at the level of the water.

[![Broken Walkway](https://dev.epicgames.com/community/api/documentation/image/174a5c3b-1e4a-4291-b645-79725499e5c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/174a5c3b-1e4a-4291-b645-79725499e5c5?resizing_type=fit)

In this case, the Damage Volume is set to immediately eliminate any player that makes contact with the water instead of just damaging them.

## Sewer Encounter

**Devices used:**

- **1 x [Trigger device](https://dev.epicgames.com/documentation/fortnite-creative/using-trigger-devices-in-fortnite-creative)**
- **1 x [Player Checkpoint device](https://dev.epicgames.com/documentation/fortnite-creative/using-player-checkpoint-pad-devices-in-fortnite-creative)**
- **1 x [Fixed Point Camera device](https://dev.epicgames.com/documentation/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative)**
- **2 x [Barrier device](https://dev.epicgames.com/documentation/fortnite-creative/using-barrier-devices-in-fortnite-creative)**
- **3 x [NPC Spawner](https://dev.epicgames.com/documentation/uefn/using-npc-spawner-devices-in-unreal-editor-for-fortnite)**
- **1 x [Tracker device](https://dev.epicgames.com/documentation/fortnite-creative/using-tracker-devices-in-fortnite-creative)**
- **1 x [Prop Manipulator device](https://dev.epicgames.com/documentation/fortnite-creative/using-prop-manipulator-devices-in-fortnite-creative)**

In the Sewers, the player comes up against the Mousers.

The device setup here is essentially the same as for the first encounter, with one crucial difference: **waves**.

Mousers are a custom NPC. Learn more about setting up custom NPCs by checking out the [AI and NPCs section](https://dev.epicgames.com/documentation/en-us/fortnite/ai-and-npcs-in-unreal-editor-for-fortnite) of the documentation.

The NPC Spawner devices are set to have Infinite spawns at one-second intervals. This means that once the spawned Mouser is eliminated, it will spawn a new Mouser after 1 second.

This will go on until the Tracker device registers 9 NPC eliminations. With three NPC Spawners, the player needs to eliminate three waves of Mousers to move ahead.

## Final Encounter

**Devices used:**

- **1 x [Trigger device](https://dev.epicgames.com/documentation/fortnite-creative/using-trigger-devices-in-fortnite-creative)**
- **1 x [Checkpoint device](https://dev.epicgames.com/documentation/fortnite-creative/using-checkpoint-devices-in-fortnite-creative)**
- **1 x [Fixed Point Camera device](https://dev.epicgames.com/documentation/fortnite-creative/using-fixed-point-camera-devices-in-fortnite-creative)**
- **3 x [Barrier device](https://dev.epicgames.com/documentation/fortnite-creative/using-barrier-devices-in-fortnite-creative)**
- **3 x [TMNT Character Spawner device](https://dev.epicgames.com/documentation/fortnite-creative/using-character-devices-in-fortnite-creative)**
- **1 x [End Game device](https://dev.epicgames.com/documentation/fortnite-creative/using-end-game-devices-in-fortnite-creative)**

After getting one last supply drop, the player finally gets to the end of the level and they must face off against the toughest enemy yet: Shredder.

Everything is set up like the first encounter, but with a few slight differences:

1. The trigger starts a short cinematic sequence that shows Shredder breaking through a brick wall.
2. During the cinematic sequence, the player can still move around, so an extra Barrier device is added to prevent them from going into the combat arena.
3. The TMNT Character Spawners are set up to spawn two Foot Elites and a Shredder.
4. The End Game device displays a win screen when it registers that Shredder has been defeated.

## Next Up

Next, you will learn about how to move players to and from different areas of your map, successfully utilizing the space and making the transitions seamless.

[![TMNT Travel Between Areas](https://dev.epicgames.com/community/api/documentation/image/557d58a8-b135-4dc3-a3b4-7e9b4b933a2c?resizing_type=fit&width=640&height=640)

TMNT Travel Between Areas

Set up travel between different areas in the TMNT Arcade template.](https://dev.epicgames.com/documentation/en-us/fortnite/tmnt-setting-up-travel-between-areas-in-unreal-editor-for-fortnite)
