# Configuring Walkers

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/twdu-configuring-walker-npcs-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:00:46.179938

---

## Overview

When creating a project using one of **The Walking Dead Universe** islands, you can create and add [NPC Spawner Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) to your project that can spawn **Walker NPC**s to populate your islands with Walker enemy types.

Walkers are unique NPC enemy types that can patrol areas of your island, and provide challenges and obstacles for your players to navigate and defeat. These NPCs are slow-moving enemies that pursue a player once they've been alerted to the player's position.

You can also add obstacles that block the Walker NPC’s path. However the Walkers can break through obstacles if they detect a player is behind them.

For a complete demonstration of how to set up Walker NPCs, and to observe the Walker NPCs used in different scenarios, see the [Walker NPC Template](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-walker-npc-template-in-unreal-editor-for-fortnite) documentation.

### Horde

When creating projects with the Walker NPCs, an NPC Spawner can spawn a large number of enemies for your player to overcome.

As the player triggers alerts to multiple NPCs, they all begin to pursue the player, creating a horde! These enemy hordes can raise the stakes challenging gameplay situations.

[![walker hordes](https://dev.epicgames.com/community/api/documentation/image/9297ceaa-bf55-4b37-9ee2-16e0369e9877?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9297ceaa-bf55-4b37-9ee2-16e0369e9877?resizing_type=fit)

Walker Hordes

For optimal island performance when using Walker NPCs, the recommended limit of Walker NPCs is 50.

### Attacks

There are a couple of ways you can set the Walkers to attack:

| Attack | Animation | Description |
| --- | --- | --- |
| **Swipe** | walker npc swipe attack animation  Swipe Attack | A basic attack that will damage the player. You can define the amount of damage that is applied using the Character Definition asset. |
| **Bite** | walker npc bite attack animation  Bite Attack | An attack that applies a small amount of initial damage but will increase at a set rate  over time that eventually eliminates the player. After a player is bitten they will experience a dark vignette over their screen that slowly consumes their field of vision.  You can adjust the rate of damage over time this attack will inflict to determine how long a  player can survive after getting bitten, or disable this feature entirely using the Character Definition asset. |

For more information on adjusting the Walker NPC gameplay mechanics, see the **Walker Gameplay Modifier Settings** section below.

### Walker Appearance

Walker NPCs are spawned using [NPC Spawner Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) the new **Walker Character** asset **Type** option in the **Character Definition** asset. When using the Walker Character Type, the NPC Spawner device will spawn a generated set of Walker enemy types using a random selection of different mesh components and color options to increase variety in a Walker horde.

For an alternative appearance to suit the prison environment, you can also select the **Walker (Prison Uniform)** option from the Character Definition asset **Type** dropdown. The Walker (Prison Uniform) type is only an appearance change. Prisoner-variant Walkers behave like other Walkers. For more information, see the [Walker Appearance Customization](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-configuring-walker-npcs-in-unreal-editor-for-fortnite#walker-appearance-customization) section.

### Customizing Walker NPCs

You can define properties and behaviors of the [NPC Character Definitions](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite) asset using [Modifiers](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite#npc-character-modifiers) to further customize how Walker NPCs can interact with your player and island environment. The [Walker Gameplay Modifier](https://dev.epicgames.com/documentation/en-us/fortnite/twdu-configuring-walker-npcs-in-unreal-editor-for-fortnite#walker-gameplay-modifier) is a specialized set of options that you can use to edit unique properties to the Walker NPC attacks, and attributes to further finetune your project.

## Device Access

You can create Walker NPCs in **Unreal Editor for Fortnite** (**UEFN**) for use in your islands. Walker NPCs are only accessible in UEFN using **The Walking Dead Universe** project templates. To learn more about working with the Walking Dead Universe content in UEFN, see the [Working With TWDU Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-twdu-islands-in-unreal-editor-for-fortnite) documentation.

### Unreal Editor for Fortnite Setup

To add Walker NPCs to your island:

1. Navigate in the **Content Browser** to **All** > **Fortnite** > **Devices** > **!Beta** and drag the NPC Spawner device into your island.

   [![npc spawner device](https://dev.epicgames.com/community/api/documentation/image/72d84dc7-2540-4146-95b4-46d810483fba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/72d84dc7-2540-4146-95b4-46d810483fba?resizing_type=fit)

   NPC Spawner Device
2. Select the NPC Spawner device and navigate in the **Details** panel to the **NPC Character Definition** option.

   [![npc character definition option](https://dev.epicgames.com/community/api/documentation/image/46146dfb-7d28-4d82-b0cf-925f2b81ec71?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/46146dfb-7d28-4d82-b0cf-925f2b81ec71?resizing_type=fit)

   NPC Character Definition Option
3. Using the option asset selection dropdown, create a new **NPC Character Definition** asset. Name it, then select a location in your project to save the new asset.

   [![create new npc character definition asset](https://dev.epicgames.com/community/api/documentation/image/233ac7f1-236b-4b13-a4d6-ef55259c9d2c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/233ac7f1-236b-4b13-a4d6-ef55259c9d2c?resizing_type=fit)

   Create New NPC Character Definition Asset
4. Double-click the new NPC Character Definition asset to open its options, then in the **Type** option, select **Walker** using the dropdown menu.

   [![npc character definition type option](https://dev.epicgames.com/community/api/documentation/image/2cd30f93-feb3-4355-91f9-e5871cfad654?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2cd30f93-feb3-4355-91f9-e5871cfad654?resizing_type=fit)

   NPC Character Definition Type Option

You can also automatically create an NPC Spawner device that will spawn Walker NPCs by dragging your NPC Character Definition asset directly into your island.

You can then select the device in the **viewport** to open the device’s **Details** panel, and make adjustments to the device properties.

Walker NPCs can experience an issue when navigating larger environment assets in your island, such as stairs.

To correct this navigation issue:

1. Click the environment asset in the viewport.
2. In the **Details** panel, select the **StaticMeshComponent**.
3. Scroll to the **Can Ever Affect Navigation** option, and uncheck to turn it off.

[![can ever affect navigation option](https://dev.epicgames.com/community/api/documentation/image/489d7954-aa7b-402d-8e0e-16e1daacc672?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/489d7954-aa7b-402d-8e0e-16e1daacc672?resizing_type=fit)

Can Ever Affect Navigation Option

## Additional Walker NPC Customization

After creating an NPC Spawner device, you can define the NPC Spawner properties common across all NPC Spawner devices, such as **Spawn Count**, **Enabled at Start** and more in the **Details** panel. For more information about NPC Spawner devices and their customization properties, see the [NPC Spawner Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) documentation.

### Walker Gameplay Modifier

Modifiers are additional settings and overrides that you can apply to NPC Characters generated from NPC Spawners. Modifiers can add effects like adjustments to movement speed and an NPC’s patrol path.

Most modifiers are the same across all NPC Spawner devices, including the NPC Spawner devices that can spawn Walker NPCs. To learn more about these universal modifiers see the [Modifiers](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite#npc-character-modifiers) documentation.

To make friendly Walker NPCs, use the **Team Modifier** in the **Character Definition** asset to either make Walker NPCs not be hostile towards players, or to be aligned on the same team as a player, meaning the NPCs can then assist the player, either against other NPCs enemies or other players.

When using NPC Spawner devices to spawn Walker NPCs, you can also define unique properties to control the specialized attributes of the Walker NPCs using the **Walker Gameplay Modifier**.

If you use the **Walker Character Type** for your NPC Spawners, the **Walker Gameplay Modifier** should be automatically defined in the spawner's **NPC Character Modifiers** option. Select the device in the **viewport**, then expand the **NPC Character Modifiers** option to see the Walker Gameplay Modifier settings.

The Walker Gameplay Modifier can be applied to all Walker NPC Spawners in your project, or controlled on the individual NPC Spawner device level. Reference the following chart depending on how you want to apply the Walker Gameplay Modifier to the NPC Spawners in your project:

| Apply Modifiers to all NPC Spawner Devices | Apply Modifiers to an individual NPC Spawner Device |
| --- | --- |
| Follow these steps:   1. Open the Character Definition asset. 2. (**+**) **Add** an array element to the **Modifiers** option 3. Select the type of modifier. 4. Expand the Modifier’s settings, and adjust their values. | Follow these steps:   1. Select the specific NPC Spawner Device you want to edit. 2. (**+**) **Add** an array element to the **Additional NPC Character Modifiers** option. 3. Select the type of modifier. 4. Expand the Modifier’s settings, and adjust their values. |

By applying modifiers, you can alter the behavior of the Walker NPCs you include in your project, such as disabling the Bite attack damage-over-time effect for easier enemies, or increasing health for harder enemies. To create variety among your Walker NPCs, you can duplicate a Character Definition asset and assign different modifiers to different NPC Spawners in your project.

#### Walker Gameplay Modifier Settings

Here you can reference a list of the Walker Gameplay Modifier’s settings and a description of their functionality:

[![walker npc character modifier](https://dev.epicgames.com/community/api/documentation/image/05fd287a-ce7b-43a1-bedc-823bc855725f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/05fd287a-ce7b-43a1-bedc-823bc855725f?resizing_type=fit)

Walker NPC Character Modifier

| Options | Options Description |
| --- | --- |
| **Headshot Damage Model** | When **enabled**, walkers spawned will take limited damage when a player shoots their body, but will take critical damage from headshots. When **disabled**, the Walker NPCs will take damage like all other NPCs and Players. |
| **Attack Damage** | This option’s value will set the amount of damage applied to a player after a successful attack. A value of `12` is used as default. Increasing this value will apply more damage to the player, while decreasing this value will apply less damage to the player. |
| **Bitten Damage Over Time** | This value sets the amount of damage over time the Walker will infect a player with after a successful bite attack. A default value of `2` is used, which means 2 damage will be applied every second after the Walker has bitten a player. You can increase this value to increase the rate the player will be eliminated after a bite, or decrease this value to slow the rate the player will be eliminated after a bite.  To turn off the bite damage over time gameplay mechanic, set this option value to 0. |
| **Remove Infection On DBNO** | When **enabled**, the player's bitten status will be removed after they are downed, meaning the player can be downed from a bite attack from a walker, but not be eliminated if they are revived by another player. When **disabled**, reviving a downed player will not remove the bitten status, meaning the player will still be eliminated by the bite’s damage-over-time effect.  To remove a player’s bitten status after being downed, **enable** this option. |
| **Skip Spawning Animation** | When **enabled**, the walker NPCs will spawn without playing their stand-up spawn animation. When **disabled**, the animation will play when the NPC is spawned. |
| **Wait Time Between Wandering Minimum** | Here you can set the minimum amount of time Walker NPCs will wait and stand idle between wandering moves. Walker NPCs will randomly select a time between this value and the value set for the **Wait Time Between Wandering Maximum** option to determine how long to wait before moving again. A default value of `3.0` seconds is used. |
| **Wait Time Between Wandering Maximum** | Here you can set the maximum amount of time Walker NPCs will wait and stand idle between wandering moves. Walker NPCs will randomly select a time between this value and the value set for the **Wait Time Between Wandering Minimum** option to determine how long to wait before moving again. A default value of `15.0` seconds is used. |

### Walker Appearance Customization

By default, the Walker NPC device will spawn walkers by randomly selecting Skeletal Mesh Components from the default set of walker meshes. You can optionally change the set of walker appearances to the Prisoner Uniforms seen in The Walking Dead Universe Gameplay template project. To change the appearance of your Walkers to the Prisoner Uniform meshes:

1. Open your Character Definition Asset by double-clicking the asset in the **Content Browser** or in the **NPC Character Definition** option in your NPC Spawner **Details** panel.
2. In the asset editor, open the **Type** option dropdown and select the **Walker (Prison Uniform)** option.

   [![walker prisoner uniform type option](https://dev.epicgames.com/community/api/documentation/image/0e3d35b9-38c4-458a-9312-e66eacfffe2d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0e3d35b9-38c4-458a-9312-e66eacfffe2d?resizing_type=fit)

   Walker Prisoner Uniform Type Option
