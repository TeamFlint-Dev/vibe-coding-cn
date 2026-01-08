# Deception Through Disguises

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-deception-through-disguises-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:12:48.402974

---

Blend into the crowd with the **Disguise** device and kit. The [Social Deduction](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-social-deduction-template-in-unreal-editor-for-fortnite) template highlights the use of this feature to create moments of uncertainty and suspicion.

[![Squid Game Disguise Device Minigame in UEFN](https://dev.epicgames.com/community/api/documentation/image/3b376bef-6618-4b1f-bf87-d6620ebd6fac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b376bef-6618-4b1f-bf87-d6620ebd6fac?resizing_type=fit)

Disguise Device Minigame

## Disguise Device and Kit

With the Disguise device and kit, you can let players transform their appearance into Squid Game guards or contestants. The disguise can last for the duration of a round or through the whole game.

You can set up these features for players to pretend they are someone else by concealing their identity while furthering their own goal.

When using this device, consider when the disguise should be removed. What happens when a player takes or deals damage? Should the disguise be removed then?

You can use the **Disguise Breaks on Attack** and **Disguise Breaks on Damage** options in the **Details** panel to configure when to remove the disguise. Disguises can override other disguises.

The Disguise device is available for all Fortnite islands in Creative and UEFN, but is especially useful for Squid Game islands. In the template, you can find the device in the **Content Drawer**, under **All > Fortnite > Devices > Logic**.

To learn more about the device and settings, see [Using Disguise Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-disguise-devices-in-fortnite).

The Squid Game feature set also includes the Disguise Kit. Place this kit into your islands for players to add to their inventory and decide when to change their appearance. You can place the kit with any device based on the asset inventory, such as the [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) device.

The Disguise Kit is located in the **Squid Game > Items** folder.

[![Squid Game Disguise Kit Item in UEFN](https://dev.epicgames.com/community/api/documentation/image/d347408c-dacb-4a99-ade3-6bcc91f78397?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d347408c-dacb-4a99-ade3-6bcc91f78397?resizing_type=fit)

Disguise Kit Item

## Gameplay Setup

Choose to be the hunter or the imposter. As the imposter, blend into the NPC crowd to avoid being spotted by the sniper. As the sniper, choose wisely: your ammo count is low, so every shot counts -but don't take too long before the timer runs out.

[![Squid Game Disguise Minigame in UEFN](https://dev.epicgames.com/community/api/documentation/image/3851bde8-daa8-4568-8fc6-923ed73051b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3851bde8-daa8-4568-8fc6-923ed73051b1?resizing_type=fit)

Disguise Minigame

Devices Used

- [Disguise](https://dev.epicgames.com/documentation/en-us/fortnite/using-disguise-devices-in-fortnite) x 2
- [Class Selector](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative) x 2
- [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)  x 6
- [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) x  2
- [Elimination Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-elimination-manager-devices-in-fortnite-creative) X 1
- [Player Marker](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-marker-devices-in-fortnite-creative) x 1
- [AI Navigation Modification](https://dev.epicgames.com/documentation/en-us/fortnite/using-ai-navigation-modification-devices-in-fortnite-creative) x 4
- [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) x 4
- [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) x 1
- [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) x 6
- [Mutator Zone](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative) x 2
- [NPC Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) x 8
- [Player Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-counter-devices-in-fortnite-creative) x 1
- [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)  x 4
- [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative)  x 1
- [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) x 1
- [Player Checkpoint Pad](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative) x 1

To start the game, there are two **Class Selector** devices that you can use to choose between being a hider or the sniper. Only one player can be the sniper. Walk into either **Class Selector** device to begin the game.

Walking into the Class Selector sets the following in motion:

- The **Class Selector** activates one of the **Disguise** devices, and applies the appropriate character to the player.
- The sniper is placed on the observatory level through the **Teleporter** device with a weapon and limited ammo provided from the Item Granter devices. A guard disguise is applied to the sniper.
- Hiders are placed on the dorm room floor through a **Teleporter** device, and are disguised as a Squid Game contestant amongst NPCs.
- A **Timer** begins to count down the round.

As the sniper you have a select amount of ammo to find the disguised player. Use the display of the Player Counter device to observe how many players are hiding among the NPCs. For every successful elimination of a disguised player, you are granted more ammo. This is tracked through the **Elimination Manager**.

[![Squid Game Devices Setup for Guard in UEFN](https://dev.epicgames.com/community/api/documentation/image/fe739e18-8228-4e9d-8d74-f6de7177e7d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe739e18-8228-4e9d-8d74-f6de7177e7d7?resizing_type=fit)

Devices Setup for Guard

As a disguised player, blend in until time is up or the sniper runs out of bullets. To contain the NPCs in the room, AI Navigation Modification devices are set up at each door. Lock devices are also applied to the doors to avoid players escaping.

The NPCs are spawned from the NPC Spawner device. You can see a full list of Squid Game characters to choose from in the **Squid Game > Characters** folder. You can also use the [Guard Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-guard-spawner-devices-in-fortnite-creative) and [Character Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-character-devices-in-fortnite-creative) to spawn the character cosmetics.

[![Squid Game Characters in UEFN](https://dev.epicgames.com/community/api/documentation/image/c5eb0958-31db-4837-898b-a720e0a52bfa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5eb0958-31db-4837-898b-a720e0a52bfa?resizing_type=fit)

At the end of the round, players are spawned back into the tutorial room.

## Design Tips

Below are additional design considerations:

- Further define differentiated gameplay roles with devices like [Team Settings and Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative) and [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-designer-devices-in-fortnite-creative). You can use these to set different health levels and weapon loadouts, and prohibit interaction with certain devices. For example, allowing only players with a guard disguise to use keycards.
- Use the minimap to hide disguised players or have other disguised players see one another. You can make adjustments with the [Player Marker](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-marker-devices-in-fortnite-creative) device.

## Next

Learn to add voting to your island.

[![Create Voting Opportunities](https://dev.epicgames.com/community/api/documentation/image/05e6f703-825d-4914-b90f-09692b57c5e7?resizing_type=fit&width=640&height=640)

Create Voting Opportunities

Learn to use the voting devices for your Squid Game islands.](<https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-create-voting-opportunities-in-unreal-editor-for-fortnite>)
