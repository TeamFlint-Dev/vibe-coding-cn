# Shove Item for Pushing Players

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-shove-item-for-pushing-players-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:13:22.256740

---

Watch your back as you hop into the **Shove** room in the [Minigame Mastery template](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-minigame-mastery-template-in-unreal-editor-for-fortnite). This [mini-game](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mini-game) focuses on equipping the Shove item to push players off a platform as you make your attempt at pressing the button for the win.

[![Shove Item for Squid Game Islands in UEFN and Creative](https://dev.epicgames.com/community/api/documentation/image/eb899305-5774-4478-bb73-69549b164786?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eb899305-5774-4478-bb73-69549b164786?resizing_type=fit)

Shove Item

Shove is an inventory item that players can equip to push other players and launch them a short distance. In the template, you can learn the fundamentals of the item, and then test your skills in the arena.

## Shove Item

Squid Game features some pivotal moments where contestants take calculated action to remove other players out of their way, often through shoving them. The action highlights moments of tension and betrayal, like pushing someone off a glass bridge or narrow ledge to save yourself or to give yourself more chance of succeeding. The **Shove** item brings this functionality to your island.

The Shove item is available for all Fortnite islands in Creative and Unreal Editor for Fortnite (UEFN), but is especially useful for Squid Game islands. In the template, you can find the item in the **Content Drawer**, under **All > Fortnite > Items**.

Shove is stamina based, and players must keep that in mind when using the item. Players can use the item against other players and nonplayer characters (NPCs).

To assign the item or provide the choice for players to equip it, you can use the following:

- [Item Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)
- [Item Granter Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative)
- [Item Remover Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-remover-devices-in-fortnite-creative)
- [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-get-started-in-unreal-editor-for-fortnite)
- Granting it on particular conditions

To learn more about the item, see [Shove Gameplay Item](https://dev.epicgames.com/documentation/en-us/fortnite/shove-gameplay-item-in-fortnite).

## Gameplay Setup

The arena focuses on a mini-game with Shove as the only inventory item. In order to win this survival game, players must be the last one standing, and be the first to press the button. The environment includes a shrinking platform.

[![Squid Game Shove Arena in UEFN](https://dev.epicgames.com/community/api/documentation/image/8d491d4f-3646-44a1-b5ab-247760984926?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d491d4f-3646-44a1-b5ab-247760984926?resizing_type=fit)

Shove Arena

The **Logic** folder under the **Shove Arena** folder in the **Outliner** contains the device setup for the experience.

Devices Used:

- [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) x 1
- [Player Checkpoint Pad](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative) x 2
- [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative) x 1
- [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) x 1
- [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) x 2
- [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)  x 1
- [Item Remover](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-remover-devices-in-fortnite-creative) x 1
- [Mutator Zone](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative) x 1
- [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) x 2
- [Switch](https://dev.epicgames.com/documentation/en-us/fortnite/using-switch-devices-in-fortnite-creative) x 1
- [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative) x 7
- [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) x 1

The majority of the gameplay setup is around spawning players onto the platform and setting a bounds to indicate when they are falling off. Once on the platform, the Shove item is the key factor between players.

The game starts when players enter the rift from the lower level. The portal entrance sets the following in motion:

- Players are dropped onto the platform from the connected **Teleporter** device.
- The Shove item is added to players inventory via the **Item Granter** device.
- The arena teleporter turns on the **Switch** device which activates the **Cinematic Sequence** device.
- The platform begins to shrink over time via the **Cinematic Sequenc**e device.

If a player falls off, they can enter back into the portal for a chance to still win. A **Damage Volume** device is placed at the end to cause elimination. The **Shove** item is removed from your inventory through the **Item Remover** device. Although players can hop back into the game, valuable time is lost for each fall.

The platform continues to shrink until it reaches its minimum size. The game is over once a player presses the button.

This single item creates a wide range of possible gameplay and ways to capture the essence of Squid Game experience. You can explore the devices in the **Outliner** to view all their settings and connected events.

[![](https://dev.epicgames.com/community/api/documentation/image/c365e19d-6114-4ac1-a5cf-88a7242361d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c365e19d-6114-4ac1-a5cf-88a7242361d7?resizing_type=fit)

Arena Setup

## Design Tips

Below are additional design considerations:

- Think of mini-games where players can use the item to get an advantage in a high stakes mini-game.
- The room design is lit to increase the suspense and capture moments of intensity similar to the show. To learn more, see [Lighting](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-in-unreal-editor-for-fortnite).

You can use the Verse [item\_remover\_device](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/item_remover_device) class to further define removing the item from players.

## Next

Hop into the next room to learn about Squid Game-themed throwable items.

[![Ddakji and Flying Stone Target Practice](https://dev.epicgames.com/community/api/documentation/image/42324281-e95c-40ce-be56-df4817ae2ee8?resizing_type=fit&width=640&height=640)

Ddakji and Flying Stone Target Practice

Learn to use Squid Game throwable items to create versatile gameplay.](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-ddakji-and-flying-stone-target-practice-in-unreal-editor-for-fortnite)
