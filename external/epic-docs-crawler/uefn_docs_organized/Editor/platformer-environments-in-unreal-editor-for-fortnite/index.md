# Platformer Environments

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/platformer-environments-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:39:06.898552

---

Platformers usually have different zones that feature different environments. Zones represent different levels in the platformer and have different dangers that require the player to use a new set of skills to get through the new level — sometimes combining new skills with old.

More devices are used to help the players navigate the island, find health and shields, and add more weapons to the landscape.

## Custom Landscapes

The environment design of this example is meant to look otherworldly but still  familiar. The **Reality** and **Invasion Nature Galleries** have great assets to achieve this. The custom landscape was made in [Landscape Mode](landscape-mode-in-unreal-editor-for-fortnite) using the **15X15** landscape size and **Chapter 4 landscape material**.

Only one functional platformer zone was created for this example.

In Landscape Mode, pathways were painted into the landscape to show players which way to go. A cave was then sculpted into the landscape for players to explore, while also providing the chance to find danger and more coins to increase their score.

[![](https://dev.epicgames.com/community/api/documentation/image/5796abe4-a0be-44aa-96fe-b5578594f55a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5796abe4-a0be-44aa-96fe-b5578594f55a?resizing_type=fit)

Bodies of water were added using the [River tool](https://dev.epicgames.com/documentation/en-us/uefn/water-tools-in-unreal-editor-for-fortnite) found in the **Fortnite** > **Environment** > **Water** folders. All water tools automatically sculpt the terrain around the body of water. On this island, the water is used as an environmental trap and the player's health reduces when they enter the water.

You can create additional 15 X 15 zones and blend them into one another by painting the edges of the zones. Or you could use Barrier devices to keep them separated and use Teleporter devices to teleport players between zones.

[![](https://dev.epicgames.com/community/api/documentation/image/439efc9a-b982-461b-8d0e-bd733b5f860b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/439efc9a-b982-461b-8d0e-bd733b5f860b?resizing_type=fit)

### Optimized Lighting

Optimized lighting is achieved by using the [Lumen Exposure Manager](https://dev.epicgames.com/documentation/en-us/uefn/using-the-lumen-exposure-manager-in-unreal-editor-for-fortnite) and the [Lighting Scalability Manager](https://dev.epicgames.com/documentation/en-us/uefn/lighting-scalability-manager-in-unreal-editor-for-fortnite). Placing these devices into your project is enough for them to work. There's no need to change their settings.

[![](https://dev.epicgames.com/community/api/documentation/image/eab8e7a0-9f91-4a82-b16b-73d45a275ad6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eab8e7a0-9f91-4a82-b16b-73d45a275ad6?resizing_type=fit)

These devices are found in the **Fortnite** > **Lighting** > **Tools** folders. These managers take the lighting you created with the Day Sequence devices and optimize the output according to the platform the player uses.

## Barrier Device

Barriers are used to keep players on the right path and to prevent them from entering zones where the danger is greater than their class level.

The barrier for your island will require unique measurements for the Barrier **Depth**, **Barrier Width**, and **Barrier Height.**

[![](https://dev.epicgames.com/community/api/documentation/image/31bef5dd-281d-43e7-a40b-15b665ec6e5e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/31bef5dd-281d-43e7-a40b-15b665ec6e5e?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| Barrier Material | None | Makes the barrier invisible in game. |
| Barrier Depth | 10.0 | Makes the barrier long enough to cover a large area at the beginning of the game. |
| Barrier Width | 0.1 | Makes the barrier thin without it disappearing form the viewport. |
| Barrier Height | 3.0 | Makes the barrier tall enough to stop players from jumping off the large Reality mushroom and into an area where the final boss is. |

## Slurp Plant

Slurp plants are scattered throughout the game to provide players with the opportunity to replenish their health and shields after fighting off creatures. They also blend into the scenery.

The default settings of the Slurp Plant were used.

[![](https://dev.epicgames.com/community/api/documentation/image/53c4e716-de28-4357-adf0-94f706d1655f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53c4e716-de28-4357-adf0-94f706d1655f?resizing_type=fit)

## Bomb Flowers

Bomb Flowers are added to the landscape in later stages of the game and strategically placed to help players eliminate larger creature hordes.

The default settings of the Bomb Flower were used.

[![](https://dev.epicgames.com/community/api/documentation/image/496976ca-73fd-4147-ac1e-f9fa26629df4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/496976ca-73fd-4147-ac1e-f9fa26629df4?resizing_type=fit)

## Mushroom Bouncer

The Mushroom Bouncer device is placed next to a Large Reality Mushroom to thrust the player into the air so they can land on top of the large mushroom, while also providing a period of health to the player.

The default settings of the Bomb Flower were used.

[![](https://dev.epicgames.com/community/api/documentation/image/498221b2-063b-4078-bdc2-85c57867fe95?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/498221b2-063b-4078-bdc2-85c57867fe95?resizing_type=fit)
