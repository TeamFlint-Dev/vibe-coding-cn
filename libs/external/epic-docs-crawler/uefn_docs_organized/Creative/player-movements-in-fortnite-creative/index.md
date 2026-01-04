# Player Movements

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:13:07.862369

---

In **Fortnite Creative**, there are several ways players can move that could affect your island design. Understanding how players can [traverse](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#traverse) your island is important when planning and designing your overall experience.

These unique movement types include:

- [Mantling](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#mantling)
- [Hurdling](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#hurdling)
- [Sprinting](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#sprinting)
- [Sliding](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#sliding)
- [Slide Kick](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#slide-kick)
- [Shoulder Bashing](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#shoulder-bashing)
- [Boosted Jump](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#boosted-jump)
- [Roll Landing](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#roll-landing)
- [Wall Kick](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#wall-nbsp-kick)
- [Wall Scramble](https://dev.epicgames.com/documentation/en-us/fortnite/player-movements-in-fortnite-creative#wall-scramble)

## Enabling Player Movements

To enable or disable any of these movement settings, press the M key and click Island Settings. Click the Player category, then click to expand the Locomotion subcategory. Scroll down until you locate the following settings:

- Allow Mantling
- Allow Hurdling
- Allow Sprinting
- Allow Sliding
- Allow Slide Kick
- Allow Shoulder Bashing
- Allow Boosted Jump
- Allow Roll Landing
- Allow Wall Kick
- Allow Wall Scramble

[![Locate player movement options in Island Settings](https://dev.epicgames.com/community/api/documentation/image/c5cb0490-4ec2-4b69-b05a-56b97bb08921?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5cb0490-4ec2-4b69-b05a-56b97bb08921?resizing_type=fit)

All of these settings can be set to **On** or **Off**. Some of these movement features, such as Mantling and Sprinting, also have additional options you can customize for your players.

You can also turn these movement features on or off using the Team Settings & Inventory device, or the [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite/class-designer) device. Using these devices to control when and how a player can use these special movement types, giving you more flexibility in designing your island.

## Mantling

[Mantling](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mantle) provides a fun and exciting way to move between different points on your island. By [enabling](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#enable) mantling for your island, you can add a design dimension that creates new space for player interactions and [traversals](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#traverse).

With mantling, you need to consider how [fall damage](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#fall-damage) works, and whether it's better for your overall island experience to use this feature.

### Fall Damage

When mantling is on, players can take fall damage if they fall while climbing, or if they try to mantle over a surface that is too high. This damage is calculated based on a percentage:

- If a player mantles past the 50% maximum damage cutoff, their mantle attempt will fail. The player will fall, and take damage based on how far they fall.
- If a player mantles mid-fall before taking more than 50% of maximum damage, the player will stop falling, mantle against a surface, and take zero damage.

### Using Mantling on Your Island

Mantling is an engaging way for players to experience your island, providing different ways to move through your island and helping you create unique challenges and objectives for players to complete. Even if the terrain of your island is not perfectly tailored for mantling, players may still find fun ways to use it while traversing your island.

Mantling can be used with a variety of games, both PvP and non-PvP. Some examples are Boxfights, Zone Wars, battle games, and games with puzzle, adventure, stealth, and exploration elements. It also offers an opportunity to create new game types or expand on existing ones. For example, you can use mantling in parkour-style exploration, mountain climbing, and more involved adventure games. These can have movement-related puzzles and other exciting methods of progressing between points of the island, giving players multiple ways of completing objectives.

However, mantling can break game types where you want restricted player movement. In these cases, you can avoid use of mantling by making sure it is set to Off. Some game types where this may apply include Deathrun, Escape Room, as well as sports, strategy, and racing or vehicle-oriented games.

Try experimenting with mantling to add new twists and challenges for your players!

Older islands may not function as intended with mantling enabled. Many features or props that were not interactive for players prior to mantling can now be climbed, which might allow players to access areas outside the boundaries of your island experience.

Although [Barrier](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#barrier) devices can help block trouble spots, it might not be a viable solution to entirely wall off all problem areas due to the barrier's minimum width. It's recommended that older experiences keep mantling turned off if updating your island is not realistic or worth the time investment.

## Hurdling

When players are running towards a wall or other obstacle, they can press the jump control to automatically hurdle over the obstacle if the **Allow Hurdling** option is set to **On**.

## Sprinting

Players can hold the **left Shift** key to sprint. In addition to the increased movement speed, anything the player is holding (such as a pickaxe or weapon) is holstered or put away, and returned when the player stops sprinting. Additionally, players who jump while sprinting can jump higher and farther.

While players are sprinting, the **Energy bar** displays above their shield bar indicating how much sprint time the player has left. Once the player is out of Energy, they stop sprinting.

[![The Energy bar over the shield bar in the HUD](https://dev.epicgames.com/community/api/documentation/image/e59b3bc2-1cc3-4c71-8fb4-45b1885c527e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e59b3bc2-1cc3-4c71-8fb4-45b1885c527e?resizing_type=fit)

The Energy bar automatically refills over time. It also disappears from the [HUD](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hud) when the player is not sprinting.

## Sliding

**Sliding** is a way for players to move quickly through a space in style.

To slide while running, the player can press and hold the **Left Ctrl key** to activate sliding. The slide will last for several seconds, then stop. If the player presses and holds **Left Ctrl** while while sprinting, they will automatically enter a slide. You can end a slide early by starting a sprint while sliding, or by jumping.

When sliding downhill, the player will slide faster if the slope is steeper. While players can slide on flat terrain, the slide speed is the same as running at normal speed (not sprinting).

## Slide Kick

The **Slide Kick** is a special attack that players can use while sliding. If this movement type is turned on, a sliding player that impacts an opposing player or a destructible object performs a slide kick that does damage and knocks away opposing players.

## Shoulder Bashing

With shoulder bashing a player can break through doors seamlessly while sprinting, sliding, or during roll landing. For this to work, the **Allow Sprinting** or **Allow Sliding** options must be set to **On**, along with the **Allow Shoulder Bashing** option. When a player bashes through a door, players standing on the other side are knocked back, but don't take damage.

As of now, players cannot bash through two doors within the same sprint, even if there is still time left in the Energy bar. The player must stop sprinting then start again between each door.

## Boosted Jump

A boosted jump is a parkour style jump. It provides a faster, extra lift when pushing off a ledge. This provides a way for you to travel more quickly and efficiently than players who don't use a boosted jump.

To perform a boosted jump, you must first sprint, then slide down an incline. As you approach the ledge press the **spacebar** to jump off the ledge and into the air.

## Roll Landing

Perform a roll landing before hitting the ground to regain stamina, or avoid taking damage when jumping from higher than one story. Just before landing press or hold the spacebar, and the character tucks and rolls on the ground and avoids any lethal damage.

## Wall Kick

You can perform a wall kick to avoid enemies or to scale upwards between two walls. While sprinting, approach a wall and press the **spacebar** to jump onto the wall and press the **spacebar** again to kick off the wall. To scale upwards between two walls alternate which wall you kick toward and press the **spacebar** when you land to kick off the wall again.

## Wall Scramble

Scramble up a wall to reach an open window or a ledge that is two stories high or more. On approach, jump onto the wall by pressing the **spacebar**, then continue to press the **spacebar** to scramble up the wall until you catch the ledge or the open window.
