# Ddakji and Flying Stone Target Practice

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-ddakji-and-flying-stone-target-practice-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:13:36.136789

---

In the [Minigame Mastery](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-minigame-mastery-template-in-unreal-editor-for-fortnite) template for Squid Game, learn how to use throwables with triggers and targets to set up some classic mini-game functionality. The addition of the **Ddakji** and **Flying Stone** items bring elements of the show into your island. Use these to create theme-skilled-based mini-games.

[![Squid Game Throwables Minigame](https://dev.epicgames.com/community/api/documentation/image/2206f193-32fb-4195-b63f-32a4e9bc0c75?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2206f193-32fb-4195-b63f-32a4e9bc0c75?resizing_type=fit)

Throwables Mini-game

## Ddakji and Flying Stone Items

The Ddakji and Flying Stones items are similar to the [Lump of Coal](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#lump-of-coal) item.

[![Squid Game Throwable Items in UEFN](https://dev.epicgames.com/community/api/documentation/image/a0d6d9d5-2108-4972-b627-fbf4540d419a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a0d6d9d5-2108-4972-b627-fbf4540d419a?resizing_type=fit)

Throwable Items

Throwables deal a small amount of damage, which can enable triggers and other devices that listen for damage dealt to trigger them. This functionality is foundational for setting up mini-games; players throw something at a trigger, which has an effect in the game.

Use the Ddakji or Flying Stone items with targets and triggers to give players consequences for hitting or missing their target. These devices must be triggered by damage.

These items are available only in Squid Game islands in Creative and Unreal Editor for Fortnite (UEFN). In the template, you can find the device in the **Content Drawer**, from the **All > Squid Game > Items folder**.

[![](https://dev.epicgames.com/community/api/documentation/image/e6b5fe32-986b-4bee-a52c-d708dc798007?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6b5fe32-986b-4bee-a52c-d708dc798007?resizing_type=fit)

Try placing these items into your islands for players to add to their inventory. You can place the kit with any item inventory based device, such as the **Item Granter** and **Item Spawner** devices.

## Gameplay Setup

The example gameplay focuses on players throwing items at moving targets to score points. The first player in this 1v1 multiplayer mini-game to reach the target score wins.

Devices Used

- Llama Bank x 2
- [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) x 2
- [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/using-barrier-devices-in-fortnite-creative) x 6
- [Billboard](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative) x 3
- [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) x 2
- [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative) x 1
- [Health Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-health-powerup-devices-in-fortnite-creative) x 1
- [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)  x 3
- [Item Remover](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-remover-devices-in-fortnite-creative) x 1
- [Mutator Zone](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative) x 3
- [Player Checkpoint Pad](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative) x 1
- [Player Reference](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-reference-devices-in-fortnite-creative) x 1
- [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative) x 2
- [Stat Counter](https://dev.epicgames.com/documentation/en-us/fortnite/using-stat-counter-devices-in-fortnite-creative) x 2
- [Target Dummy Track](https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-devices-in-fortnite-creative) x 6
- [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) x 2
- [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) x 2
- [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) x 2
- [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative) x 1

Both players press the Button devices to begin. Pressing the device sets the following in motion:

- The **Ddakji** and **Flying Stone** items are spawned in player inventories via the **Item Granter** devices.
- The **Time** device begins to count down to signal the end of the match.
- Targets begin to move back and forth via the **Target Dummy Tracker** device.
- The **Llama Bank** device begins to fill to indicate the player's progress in the game.

[![Squid Game Minigame Mastery Template in UEFN](https://dev.epicgames.com/community/api/documentation/image/61590539-fdd7-4557-8118-44c3464b56a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/61590539-fdd7-4557-8118-44c3464b56a2?resizing_type=fit)

Gameplay Arena

Players can try to take out opponents by dealing damage. However, they could focus on the targets, advancing in points and healing. For every successful hit on the target dummy, the **Health Powerup** device heals the player. The **Stat Counter** device keeps track of the score to update the progress in the **Llama Bank** device.

You can use the **Player Reference** device to relay player statistics to other devices, or even to other players. Players register to the device via the Button device.

## Design Tips

Below are additional design considerations:

- Create interesting ways to track scores. The Llama Bank shows players their progress. Can they focus to catch up, or will they let the pressure get to them?
- Consider other game structures that you can set up for throwable object-based mini-game scenarios.
- Use **Volumes**, like in the gameplay example, to contain throwable items to certain areas.

## Next

Learn to create items that players can carry.

[![Carry Items Through Obstacles](https://dev.epicgames.com/community/api/documentation/image/cd07d3c2-e228-4b32-9d9f-cb0b2a510eaa?resizing_type=fit&width=640&height=640)

Carry Items Through Obstacles

Learn to create Squid Game minigames with the Carryable Spawner device.](<https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-carry-items-through-obstacles-in-unreal-editor-for-fortnite>)
