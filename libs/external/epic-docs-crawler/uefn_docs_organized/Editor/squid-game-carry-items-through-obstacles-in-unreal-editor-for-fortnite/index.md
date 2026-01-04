# Carry Items Through Obstacles

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-carry-items-through-obstacles-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:13:15.596176

---

In the [Minigame Mastery template](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-minigame-mastery-template-in-unreal-editor-for-fortnite), learn to spawn items players can pick up to throw or drop onto triggers. [Mini-games](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#mini-game) often include the mechanics of triggering other games and relays.

[![Squid Game Obstacle Minigame in UEFN](https://dev.epicgames.com/community/api/documentation/image/ba4f839f-9497-43fb-a18b-3e9e7bff2075?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba4f839f-9497-43fb-a18b-3e9e7bff2075?resizing_type=fit)

Obstacle Mini-game

## Carryable Spawner Device

You can spawn items from the **Carryable Spawner**, which can be picked up, put down, or thrown. Players always carry objects over their heads.

The device comes with a wide range of user options. You can swap the static mesh, sound and visual effects to create a custom held object.

[![Carryable Spawner Device Options  for Squid Game Islands in UEFN](https://dev.epicgames.com/community/api/documentation/image/0eb3d19b-a85d-4e5c-9e8e-8d37465b4d55?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0eb3d19b-a85d-4e5c-9e8e-8d37465b4d55?resizing_type=fit)

Carryable Spawner Device Options

In the **Damage** **and** **Explosion** category in the **Details** panel, you can set how the item interacts with the environment. For example, character damage and explosion on impact.

[![Squid Game in UEFN](https://dev.epicgames.com/community/api/documentation/image/071af498-3658-44c4-8fdf-33794b6fc8ec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/071af498-3658-44c4-8fdf-33794b6fc8ec?resizing_type=fit)

Item Explosion on Impact

With the device you can create games like chess, use heavy stones to weigh down pressure plates, recreate basketball, and other sports games.

The Carryable Spawner device is available for all Fortnite islands in Creative and UEFN, but is especially useful in the Squid Game feature set. In the template, you can find the device in the **Content Drawer**, under **All > Fortnite > Devices > !Beta**.

To learn more about the device and settings, see [Using Carryable Spawner Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-carryable-spawner-devices-in-fortnite).

The Squid Game feature set also includes the brand-specific version of this device. These devices represent the Gonggi item in different colors. This means the settings are the same, but the prop is designed to fit the aesthetic of the Squid Game brand and connect fans to iconic props seen in the show.

In the template, you can find the Gonggi version in the **Content Drawer**, from  the **All > Squid Game > Devices** folder.

[![Squid Game Gonggi Carryable Device in UEFN](https://dev.epicgames.com/community/api/documentation/image/a0fc1f2c-a4a0-467d-9767-b12ed60ce5f9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a0fc1f2c-a4a0-467d-9767-b12ed60ce5f9?resizing_type=fit)

Gonggi Carryable Device

## Gameplay Setup

In the mini-game, one player must carry a stone across a narrow bridge while avoiding obstacles and trying not to fall into the lava. However, the other team, wearing VIP masks, try to make the player's life harder by throwing things at them from the sidelines.

[![Squid Game Carryable Arena in UEFN](https://dev.epicgames.com/community/api/documentation/image/41d15b0f-83e8-4c3b-b784-b6f861ecd645?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41d15b0f-83e8-4c3b-b784-b6f861ecd645?resizing_type=fit)

Carryable Arena

This setup may not feel fair, but neither is Squid Game. Asymmetric play like this is core to the theme of the show. While all contestants generally have a fair time against one another, setting up discrepancies, advantages, and demonstrating that power hierarchy is an interesting way to put a certain twist on things.

Devices Used

- [Carryable Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-carryable-spawner-devices-in-fortnite) x 8
- [Audio Player](https://dev.epicgames.com/documentation/en-us/fortnite/using-audio-player-devices-in-fortnite-creative) x 1
- [Billboard](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative) x 5
- [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) x 3
- [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)  x 5
- [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) x 1
- [Class Selector](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative) x 2
- [Team Settings and Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative) x 2
- [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative) x 3
- [Mutator Zone](https://dev.epicgames.com/documentation/en-us/fortnite/using-mutator-zone-devices-in-fortnite-creative) x 6
- [Player Checkpoint Pad](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-checkpoint-devices-in-fortnite-creative) x 3
- [Random Number Generator](https://dev.epicgames.com/documentation/en-us/fortnite/using-random-number-generator-devices-in-fortnite-creative) x 1
- [Score Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-score-manager-devices-in-fortnite-creative) x 2
- [Target Dummy Track](https://dev.epicgames.com/documentation/en-us/fortnite/using-target-dummy-track-devices-in-fortnite-creative) x 2
- [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)  x 4
- [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) x 2
- [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) x 3
- [Visual Effect Powerup](https://dev.epicgames.com/documentation/en-us/fortnite/using-visual-effect-powerup-devices-in-fortnite-creative) x 1
- [Pinball Flipper](https://dev.epicgames.com/documentation/en-us/fortnite/using-pinball-flipper-devices-in-fortnite-creative) x 4
- [Pinball Bumper](https://dev.epicgames.com/documentation/en-us/fortnite/using-pinball-bumper-devices-in-fortnite-creative) x 3

The game starts by choosing a team, Carrier or Thrower, from the Class Selector device. Entrance into either device triggers the following:

- The carrier is spawned into the obstacle room.
- Obstacles connected to the **Pinball Flipper** and **Pinball Bumper** devices begin moving.
- A **Timer** device begins the countdown for the carrier to make it across.
- Carryable items spawn in the scene via the **Carryable Spawner** device.
- A UI for the score becomes visible.

If a player is knocked into the lava, whether due to the thrower or obstacles, they’re eliminated. A **Damage Volume** device is placed around the lava to create the elimination. Players keep spawning in the game until time runs out.

[![Squid Game VIP Masks in UEFN](https://dev.epicgames.com/community/api/documentation/image/4e993561-c26c-439a-a5d1-92aa4635457a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e993561-c26c-439a-a5d1-92aa4635457a?resizing_type=fit)

VIP Masks

For the thrower, a VIP mask is attached via the **Visual Effect Powerup** device. This device connects to a **Niagara system** containing the mask through the **Custom Effect** option.

To learn more about creating a Niagara system, see [Visual Effects](https://dev.epicgames.com/documentation/en-us/fortnite/visual-effects-in-unreal-editor-for-fortnite).

## Design Tips

Below are additional design considerations:

- Use Squid Game props to create more branded carryable items, like the **Llama Bank**.
- Design custom meshes with in-engine modeling tools.
- Use VIP masks as items players can unlock or ways to distinguish teams.
- Think of vulnerable moments you can create for players while they carry an item.

## Next

Learn to add multiplayer skill checks to your Squid Game island.

[![Multiplayer Skill Checks](https://dev.epicgames.com/community/api/documentation/image/203b9519-deb1-4bda-a3c2-96869d676083?resizing_type=fit&width=640&height=640)

Multiplayer Skill Checks

Learn to add multiplayer skill checks to your Squid Game islands.](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-multiplayer-skill-checks-in-unreal-editor-for-fortnite)
