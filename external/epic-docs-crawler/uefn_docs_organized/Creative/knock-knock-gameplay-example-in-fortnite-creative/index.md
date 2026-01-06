# Knock Knock

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/knock-knock-gameplay-example-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:27:55.314861

---

In this [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gameplay) example, you will plant an explosive and a controlling button to blow up a target location in the environment — along with any nearby players.

After creating this example, you will know how to use a [Button device](using-button-devices-in-fortnite-creative) to remotely detonate an [Explosive Barrel device](using-explosive-devices-in-fortnite-creative), and alter the explosive barrel’s **Blast Radius**, **Player Damage,** and **Structure Damage**.

[![A player standing between a Button device and an Explosive device.](https://dev.epicgames.com/community/api/documentation/image/b7853c08-3369-4f4e-bf25-7b1ad03e7d75?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7853c08-3369-4f4e-bf25-7b1ad03e7d75?resizing_type=fit)

### Devices Used

To learn more about placing devices and props, and using the grid, watch the [Video Tutorials](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-video-tutorials).

- 1 x [Button device](using-button-devices-in-fortnite-creative)
- 1 x [Explosive Barrel device](using-explosive-devices-in-fortnite-creative)
- 1 x [Player Spawn Pad device](https://dev.epicgames.com/documentation/en-us/fortnite/using-player-spawn-pad-devices-in-fortnite-creative)

### Setting up the Explosion

1. Identify a target environment where you can place your Explosive Barrel device.

   [![A Fortnite player surveying an Explosive Barrel device in the target environment.](https://dev.epicgames.com/community/api/documentation/image/6587aa3c-1dcf-4c43-8eb1-0e1e46f61ae1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6587aa3c-1dcf-4c43-8eb1-0e1e46f61ae1?resizing_type=fit)

   Be sneaky and strategic about placing your Explosive Barrel devices. Effective Explosive Barrel devices are hidden to take other players by surprise! Find buildings with walls, doors, bushes, or other objects that obstruct the player’s [line of sight](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#line-of-sight).
2. Place your Button device.

   [![A Fortnite player standing next to a Button device.](https://dev.epicgames.com/community/api/documentation/image/7fcb186a-1404-4c12-ba64-6fcb07de7543?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7fcb186a-1404-4c12-ba64-6fcb07de7543?resizing_type=fit)

   Make sure you place the button where your player can see their opponent in the explosive barrel’s vicinity, and make sure the player is far enough away to avoid being caught in the explosion. The explosion is triggered remotely, so your player should be ready to activate the Button device when their opponent approaches the Explosive Barrel device.
3. Customize the device options for the Button device.

   [![Customize the options for the Button device.](https://dev.epicgames.com/community/api/documentation/image/5a0d8941-c408-46df-8de3-6b7f4e6b0203?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a0d8941-c408-46df-8de3-6b7f4e6b0203?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Interaction Text** | **Detonate Barrel!** | Tells the player what the button does. |
   | **When Interacted With Transmit on** | **Channel 1** | When you interact with the Button device, it sends a signal that detonates the Explosive Barrel device. |
4. Customize the device options for the Explosive Barrel device.

   [![Customize the options for the Explosive Barrel device.](https://dev.epicgames.com/community/api/documentation/image/229c96a9-02e4-4197-8de9-6d25b2b05726?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/229c96a9-02e4-4197-8de9-6d25b2b05726?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | **Blast Radius** | **2.5** | Establishes the explosion’s perimeter in tiles. |
   | **Player Damage** | **Elimination** | Ensures any player caught in the explosion is eliminated. |
   | **Structure Damage** | **5,000** | Completely destroys the target environment. |
   | **Damage Indestructible Buildings** | **Yes** | The Explosive Barrel device will damage the environment even when environmental damage is otherwise turned off. |
   | **Explode When Receiving From** | **Channel 1** | Explodes when receiving a signal sent on this channel by the Button device. |

   If you are setting up more than one Explosive Barrel device and Button device pair, use a different channel for each pair, unless you want one Button device to detonate multiple Explosive Barrels.
5. Place a Player Spawn Pad device near the button, so you don’t need to sky-dive into the level to play it. You don’t need to configure the Player Spawn Pad, the default options are fine.

## Customize My Island Settings

Before your island is ready, you need to configure the [My Island settings](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) so your game will play properly.

Open your inventory and select the [My Island menu](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) to begin, then make the following changes to the **SETTINGS** tab. You can change other options as well if you want, but these are required for this gameplay example to function correctly.

| Option | Value | Description |
| --- | --- | --- |
| **Environment Damage** | **Off** | Only the explosives you set up can damage the environment. |

### Conclusion

Once you’ve mastered one, try Knock Knock with as many buttons and explosive barrels as you’d like!
