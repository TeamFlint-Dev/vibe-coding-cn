# The Walking Dead Universe Weapons

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-weapons-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:15:14.330509

---

Ding-dang dong, eliminated! Enter the first room of the [Walker NPC template](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-walker-npc-template-in-unreal-editor-for-fortnite) to get acquainted with hero weapons of **The Walking Dead Universe** (TWDU), the **Lucille** bat and **Shiva Shotgun**. Use the room to spawn Walkers and test out the weapons in the environment.

[![The Walking Dead Universe Weapon Gameplay](https://dev.epicgames.com/community/api/documentation/image/a0877d03-a44a-4d5a-a4e5-7cfb2fa48aa6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a0877d03-a44a-4d5a-a4e5-7cfb2fa48aa6?resizing_type=fit)

## Weapon Access

You can access the weapons from the following locations:

- **UEFN: Content Browser > The Walking Dead Universe > Weapons**
- **Creative: Creative Menu > Content > The Walking Dead Universe > Weapons**

There are various ways to add weapons to your islands like the [Item Spawner device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative). To automictically add the hero weapons to a player's inventory use the [Item Granter device](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative).

## Lucille

Lucille is Negan’s number one girl. Perfect for bashing in Walkers and Survivors. This iconic baseball bat comes with unique melee attacks and a comic style aura effect. Hold the secondary attack button with Lucille for a powerful swing, and attack from the air for an area-of-effect (AoE) knockback.

|  |  |  |
| --- | --- | --- |
| TWDU Lucille Bat | TWDU Lucille Bat | TWDU Lucille Bat |
| **Swing** | **Slam Attack** | **Heavy Swing** |

To preserve the look and feel of Lucille, third-person view is active when wielding the melee weapon. This set viewpoint is by design to highlight the presentation and feel of the weapon.

## Shiva Shotgun

Mow ‘em down with roaring fury. The Shiva Shotgun is a powerful one-of-a-kind ranged weapon. Aesthetically, it is designed to celebrate The Walking Dead Universe, while featuring mechanics that complement the gameplay offered in the feature toolset.

The weapon is an exotic, modded pump shotgun with a flashlight, which holds 5 rounds that show a toon fire look when trigged. Hold the trigger to charge and release an explosive shell, which roars like a tiger when the shell explodes! Aim (target) with the shotgun to activate the flashlight to help navigate dark areas.

|  |  |
| --- | --- |
| TWDU Shiva Shotgun | TWDU Shiva Shotgun |
| **Fire** | **(Charge) Explosive Shot** |

The weapon is not mod-able via work benches.

## Using Weapons in your Level Design

Spawn more Walkers to try out the weapons, and start thinking about how they help with your game design elements. Specifically, where each weapon will fit in your level design. Make design choices that compliment the available weapons for engaging gameplay.

Think of areas that players can attack from in combination with the weapons. For example, in the weapon room there are ledges you can climb to practice your slam attack with Lucille to knock back a group of Walkers. Or charge up the Shiva Shotgun to practice eliminating the group. You’ll get the same opportunity  in the **Action** area of the template.

[![](https://dev.epicgames.com/community/api/documentation/image/3e6109ae-f8dc-404e-a724-bbd470603a9c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e6109ae-f8dc-404e-a724-bbd470603a9c?resizing_type=fit)

Create opportunities for players to get the most out of the weapons.

Where you place Walkers in your level design makes weapon mechanics important. Use this to make players think about their combat strategy.

- Watch for close quarters when using the Shiva Shotgun, as the charge explosive causes residual damage. If players aren't careful, they can take damage when firing in close quarters. This can also force players to use Lucille if available.
- Limited ammo can add to moments of tension due to the increased need to pay attention to managing resources.
- Switching to Lucille in close quarters or when low on ammo can be a lifesaver.
- Walkers are overwhelming in numbers. Players can take advantage of Lucille's powerful knockback to control the space.
- By default, Walkers are resistant to body shots and take increased damage with headshots. Consider the Walker modifiers like **Headshot Damage Model** when you add weapons to your level design.

The table below lists the Walker modifiers available in a [character definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite) after you select **Walker** or **Walker (Prisoner Uniform)** as the type.

| Walker Gameplay Modifier | Default Value | Description |
| --- | --- | --- |
| **Headshot Damage Model** | On | If on, NPCs take minimal damage from body shots and critical damage from headshots. |
| **Attack Damage** | 12 | Determines how much damage Walkers do with a swipe attack. With a minimum and maximum range of 1 - 10000. |
| **Bitten DOT Damage** | 2 | Determines the initial bite damage and damage-over-time (DOT) value that slowly lowers a player's health until eliminated or downed. With a minimum and maximum range of 0 - 100, where 0 turns off the bite DOT gameplay mechanic. |
| **Remove Infection On DBNO** | On | Determines if the bitten DOT is removed after a downed player is revived by a teammate. |
| **Skip Spawning Animation** | Off | Disables or enables the spawning animation of the Walkers standing up from the ground. |
| **Wait Time Between Wandering Minimum** | 3 seconds | Sets the minimum wait time before Walkers start to wander. |
| **Wait Time Between Wandering Maximum** | 16 seconds | Sets the maximum wait time before Walkers start to wander. |

To learn more about adjusting the modifiers, see [Configuring Walkers](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-configuring-walker-npcs-in-unreal-editor-for-fortnite).

## Up Next

Continue to learn about Walkers and making weapon choices for your game based on the level design.

[![The Walking Dead Universe Level Design](https://dev.epicgames.com/community/api/documentation/image/01e15228-92e3-4426-ba8d-7d71836ad313?resizing_type=fit&width=640&height=640)

The Walking Dead Universe Level Design

Explore the attributes of Walkers, and learn best practices for placing the NPCs in your islands through level design scenarios.](https://dev.epicgames.com/documentation/en-us/fortnite/the-walking-dead-universe-level-design-in-unreal-editor-for-fortnite)
