# 1. Setting Up the Team Elimination Level

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-1-setting-up-the-level-in-verse
> **爬取时间**: 2025-12-27T00:18:46.199028

---

This example uses the following devices.

- 4 x [Player Spawn Pad devices](https://www.epicgames.com/fortnite/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative): This device defines where the player spawns at the start of the game.
- 10 x [Item Granter devices](https://www.fortnite.com/en-US/creative/docs/using-item-granter-devices-in-fortnite-creative): These automatically grant players items when spawning and upon scoring eliminations.
- 2 x [Sentry devices](https://www.fortnite.com/en-US/creative/docs/using-sentry-devices-in-fortnite-creative): This tutorial shows how to use the Sentry device to test out multiplayer code.
- 1 x [End Game device](https://www.fortnite.com/en-US/creative/docs/using-end-game-devices-in-fortnite-creative): This ends the game when a player scores the final elimination.
- Props to create an area for your players to compete in.

To learn more about placing props and devices in UEFN, see the [User Interface Reference](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite).

Follow these steps to set up your level:

1. Add one **Player Spawn Pad** device on one end of the level. This will be the area where Team 1 will spawn. Hide the spawn pad behind a wall or other obstacle to prevent players from attacking each other from their spawn.
2. Select the spawn pad in the **Outliner** to open its **Details** panel.
3. In the **Details** panel, under **User Options**:

   - Set **Player Team** to **Team Index** with a value of **1**.
   - Disable **Visible in Game**.

     [![Modify Player Spawners](https://dev.epicgames.com/community/api/documentation/image/06598cc8-705e-446c-948e-8dc480d6ed73?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06598cc8-705e-446c-948e-8dc480d6ed73?resizing_type=fit)

     *Click image to expand.*
4. Duplicate the spawn pad and place it somewhere else in the Team 1 spawn area.
5. Duplicate both spawn pads and drag them over to the Team 2 spawn area.
6. Select the spawn pads in the Team 2 spawn area, and in the **Outliner** under **User Options**, change the value of **Team Index** to **2** for both.
7. Add one **Item Granter** device outside of the arena, hidden from any players.
8. Select the item granter in the **Outliner** to open its **Details** panel.
9. In the **Details** panel, under **User Options**:

   - Click **Add Element** to **Item List**.
   - Set the **Item Definition** to **Combat Pistol L1**.

     [![Modify Item Granter](https://dev.epicgames.com/community/api/documentation/image/76f296c4-efe7-4ef4-9ff6-20cc7c4c87e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76f296c4-efe7-4ef4-9ff6-20cc7c4c87e5?resizing_type=fit)

     *Click image to expand.*
10. Duplicate the item granter device nine more times, changing the **Item Definition** to the next weapon in the sequence you want your players to use. A fun sequence might have easy-to-use, weaker weapons like pistols early, stronger weapons like Rifles and SMGs in the middle, and difficult to use powerful weapons like sniper rifles and explosives near the end. Set the final weapon to something very difficult, such as the **Basic Sword L1**, or the **Flint-Knock Pistol L1**. An example weapon sequence might look like:

    - **Combat Pistol L1**
    - **Assault Rifle L1**
    - **Auto Shotgun L1**
    - **Sideways Scythe L1**
    - **Stinger SMG L1**
    - **Makeshift Bow L2**
    - **Rocket Launcher L1**
    - **Bolt-Action Sniper Rifle L1**
    - **Grenade Launcher L3**
    - **Basic Sword L1**
11. Add two **Sentry** devices to the level, close together but without their ranges overlapping. Select each sentry device, and in the **Details** panel under **User Options**:

    - Set **Weapon Type** to **Shotgun**.
    - Set **Accuracy** to **Deadshot**.
    - Enable **Respawn on a Timer**.
    - Set **Friendly Team** to **Team Index** with a value of **1** for the first sentry, and **2** for the second sentry. This ensures each team has a sentry to test eliminations on.

      [![Modify Sentries](https://dev.epicgames.com/community/api/documentation/image/a521012b-bcd8-4dc9-b08a-e55c755c0b7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a521012b-bcd8-4dc9-b08a-e55c755c0b7a?resizing_type=fit)

      *Click image to expand.*
12. Add one **End Game** device to the level, and in the **Details** panel under **User Options**, set **Winning Team** to **Activating Team.**

    [![Modify End Game Device](https://dev.epicgames.com/community/api/documentation/image/6e6d10b5-54e9-4161-8441-ad9b4a490872?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e6d10b5-54e9-4161-8441-ad9b4a490872?resizing_type=fit)

    *Click image to expand.*
13. In the **Outliner** select the **Island Settings** device. In the **Details** panel under **User Options - Game Rules**:

    - Set **Teams** to **Team Index** with a value of **2**. You’ll use two teams in this example, but there is no restriction on how many teams you want to use.
    - Set **Team Size** to **Split Evenly**. This will balance players evenly between the two teams.
    - Set **Join in Progress** to **Spawn** so new players can join the game while it’s running.

      [![Modify Island Settings](https://dev.epicgames.com/community/api/documentation/image/57d4db12-706c-492c-ae5d-e05c0e45a9c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57d4db12-706c-492c-ae5d-e05c0e45a9c1?resizing_type=fit)

      *Click image to expand.*
14. Create a new Verse device named **team\_elimination\_game** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and drag the device into the level. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-2-finding-devices-at-runtime-in-verse) of this tutorial, you’ll create a new device using Verse to track the devices you populated your level with.
